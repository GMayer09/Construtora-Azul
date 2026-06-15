DEF VAR vRetDepe    AS INT NO-UNDO.

DEF VAR v-idDepe   AS INT NO-UNDO.

DEF FRAME depe-frame 
    v-idDepe   LABEL "Cod.Depe"   SKIP
    WITH TITLE "CONSULTA DEPENDENTE" CENTERED
    1 COLUMN 1 DOWN ROW 3.

DEF BUFFER b-displayFunc FOR funcionario.

REPEAT:
    ON 'F5' OF v-idDepe IN FRAME depe-frame DO:
        RUN browseDepe.p (OUTPUT vRetDepe).
        
        IF FOCUS:NAME = "v-idDepe" AND vRetDepe <> 0 THEN DO:
            v-idDepe = vRetDepe.
            FOCUS:SCREEN-VALUE = STRING(vRetDepe). 
        END.
        RETURN.
    END.
    
    ASSIGN v-idDepe = 0.
    
    UPDATE v-idDepe WITH FRAME depe-frame.
    FIND dependente WHERE dependente.idDepe = v-idDepe NO-LOCK NO-ERROR NO-WAIT.
    
    IF AVAIL dependente THEN DO:
        FIND FIRST b-displayFunc 
            WHERE b-displayFunc.idFunc = dependente.idFunc NO-LOCK NO-ERROR NO-WAIT.
    
        DISP dependente.nome       dependente.cpf  dependente.rg       dependente.endereco
             dependente.nascimento dependente.sexo dependente.grauPare 
             WITH FRAME depe-frame.
        DISP b-displayFunc.idFunc b-displayFunc.nome 
            LABEL "Nome do Func" WITH FRAME depe-frame.
            
        HIDE FRAME depe-frame.
    END.
    
    ELSE DO:
        MESSAGE "Erro: dependente nao foi encontrado!" VIEW-AS ALERT-BOX.
    END.
END.