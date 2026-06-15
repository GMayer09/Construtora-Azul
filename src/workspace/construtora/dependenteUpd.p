DEF VAR wfuncid AS INT NO-UNDO.

DEF VAR vRetDepe    AS INT NO-UNDO.
DEF VAR vRetFunc    AS INT NO-UNDO.

DEF VAR v-idDepe   AS INT NO-UNDO.

DEF BUFFER b-displayFunc FOR funcionario.

DEF FRAME depe-frame 
    v-idDepe   LABEL "Cod.Depe"   SKIP
    dependente.nome       dependente.cpf  dependente.rg       dependente.endereco
    dependente.nascimento dependente.sexo dependente.grauPare 
    wfuncid    LABEL "Cod.Func"   SKIP
    WITH TITLE "ALTERAR DEPENDENTE" CENTERED
    1 COLUMN 1 DOWN ROW 3.
    
REPEAT:
    ON 'F5' OF v-idDepe IN FRAME depe-frame DO:
        RUN browseDepe.p (OUTPUT vRetDepe).
        
        IF FOCUS:NAME = "v-idDepe" AND vRetDepe <> 0 THEN DO:
            v-idDepe = vRetDepe.
            FOCUS:SCREEN-VALUE = STRING(vRetDepe). 
        END.
        RETURN.
    END.
    
    ON 'F5' OF wfuncid IN FRAME depe-frame DO:
        RUN browseFunc.p (OUTPUT vRetFunc).
        
        IF FOCUS:NAME = "wfuncid" AND vRetFunc <> 0 THEN DO:
            wfuncid = vRetFunc.
            DISP wfuncid WITH FRAME depe-frame.
        END.
    END.
    
    ASSIGN v-idDepe = 0.
    
    UPDATE v-idDepe WITH FRAME depe-frame.
    FIND dependente WHERE dependente.idDepe = v-idDepe EXCLUSIVE-LOCK NO-ERROR NO-WAIT.
    
    IF AVAILABLE dependente THEN DO:
        FIND FIRST b-displayFunc
            WHERE b-displayFunc.idFunc = dependente.idFunc NO-LOCK NO-ERROR NO-WAIT.
        ASSIGN wfuncid = b-displayFunc.idFunc.
        
        UPDATE dependente.nome       dependente.cpf  dependente.rg       dependente.endereco
               dependente.nascimento dependente.sexo dependente.grauPare wfuncid
        WITH FRAME depe-frame.
        MESSAGE "Dependente alterado com sucesso!" VIEW-AS ALERT-BOX.
        
        HIDE FRAME depe-frame.
    END.
    
    ELSE DO:
        MESSAGE "Erro: dependente nao encontrado!" VIEW-AS ALERT-BOX.
    END.
END.