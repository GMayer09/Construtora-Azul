DEF FRAME depe-frame WITH TITLE "DELETAR DEPENDENTE" CENTERED
    1 COLUMN 1 DOWN ROW 3.
DEF VAR del-answer AS LOGICAL LABEL "Delete?".

REPEAT:
    PROMPT-FOR dependente.idDepe WITH FRAME depe-frame.
    FIND dependente WHERE dependente.idDepe = INPUT dependente.idDepe EXCLUSIVE-LOCK NO-ERROR NO-WAIT.
    
    IF AVAILABLE dependente THEN DO:
        DISPLAY dependente WITH FRAME depe-frame.
        
        del-answer = NO.
        UPDATE del-answer WITH FRAME depe-frame.
        
        IF del-answer THEN DO:
            DELETE dependente.
            MESSAGE "Dependente deletado com sucesso!" VIEW-AS ALERT-BOX.
        END.
        HIDE FRAME depe-frame.
    END.
    
    ELSE DO:
        MESSAGE "Erro: dependente nao encontrado!" VIEW-AS ALERT-BOX.
    END.
END.