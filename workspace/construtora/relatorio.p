DEF VAR v-idDepe AS INT.

DEF BUFFER b-cargo FOR cargo.
DEF BUFFER b-Depe FOR dependente.

DEF FRAME f-relatorio 
    funcionario.idCargo   COLUMN-LABEL "COD.CARGO"  FORMAT ">>>>9"
    b-cargo.nome          COLUMN-LABEL "CARGO"      FORMAT "x(30)"
    funcionario.nome      COLUMN-LABEL "NOME"       FORMAT "x(15)"
    funcionario.salario   COLUMN-LABEL "SALARIO"    FORMAT "->>,>>9.99"
    v-idDepe              COLUMN-LABEL "DEPENDENTES" FORMAT ">>>>9" 
    WITH TITLE "RELATORIO" CENTERED STREAM-IO DOWN WIDTH 81.

FOR EACH funcionario WHERE funcionario.dataDemi = ? BREAK BY funcionario.idCargo:
    FIND FIRST b-cargo WHERE b-cargo.idCargo = funcionario.idCargo NO-LOCK NO-ERROR NO-WAIT.
    
    v-idDepe = 0.
    FOR EACH b-Depe NO-LOCK WHERE b-Depe.idFunc = funcionario.idFunc:
        v-idDepe = v-idDepe + 1.
    END.
    
    DISPLAY funcionario.idCargo WHEN FIRST-OF(funcionario.idCargo) b-cargo.nome WHEN FIRST-OF(funcionario.idCargo)
            funcionario.nome salario v-idDepe WITH FRAME f-relatorio.
    
    ACCUMULATE funcionario.salario(TOTAL BY funcionario.idCargo).
    ACCUMULATE v-idDepe (TOTAL BY funcionario.idCargo).
    
    IF LAST-OF (funcionario.idCargo) THEN DO:
        UNDERLINE funcionario.salario v-idDepe WITH FRAME f-relatorio.
        
        DISPLAY "TOTAL CARGO:" @ funcionario.nome
                ACCUM TOTAL BY funcionario.idCargo funcionario.salario @ funcionario.salario
                ACCUM TOTAL BY funcionario.idCargo v-idDepe @ v-idDepe
                WITH FRAME f-relatorio.
    END.
END.