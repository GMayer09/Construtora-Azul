DEF VAR vRetDepe    AS INT NO-UNDO.

DEF VAR v-idDepe   AS INT NO-UNDO.

DEF FRAME depe-frame 
    v-idDepe LABEL "Cod.Depe" SKIP
    WITH TITLE "DELETAR DEPENDENTE" CENTERED
    1 COLUMN 1 DOWN ROW 3.
DEF VAR del-answer AS LOGICAL LABEL "Delete?".

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
    FIND dependente WHERE dependente.idDepe = v-idDepe EXCLUSIVE-LOCK NO-ERROR NO-WAIT.
    
    IF AVAILABLE dependente THEN DO:
        DISP dependente.nome       dependente.cpf  dependente.rg         dependente.endereco
               dependente.nascimento dependente.sexo dependente.grauPare dependente.idFunc  WITH FRAME depe-frame.
        
        del-answer = NO.
        UPDATE del-answer WITH FRAME depe-frame.
        
        IF del-answer THEN DO:
            MESSAGE "Dependente" dependente.idDepe " - " dependente.nome "deletado com sucesso!" VIEW-AS ALERT-BOX.
            DELETE dependente.
        END.
        HIDE FRAME depe-frame.
    END.
    
    ELSE DO:
        MESSAGE "Erro: dependente nao encontrado!" VIEW-AS ALERT-BOX.
    END.
END.