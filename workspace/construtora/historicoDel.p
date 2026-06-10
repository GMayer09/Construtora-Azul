DEF FRAME hist-frame WITH TITLE "DELETAR HISTORICO" CENTERED
    1 COLUMN 1 DOWN ROW 3.
DEF VAR del-answer AS LOGICAL LABEL "Delete?".

REPEAT:
    PROMPT-FOR historico.idHist WITH FRAME hist-frame.
    FIND historico WHERE historico.idHist = INPUT historico.idHist EXCLUSIVE-LOCK NO-ERROR NO-WAIT.
    
    IF AVAILABLE historico THEN DO:
        DISPLAY historico WITH FRAME hist-frame.
        
        del-answer = NO.
        UPDATE del-answer WITH FRAME hist-frame.
        
        IF del-answer THEN DO:
            DELETE historico.
            MESSAGE "Historico deletado com sucesso!" VIEW-AS ALERT-BOX.
        END.
        HIDE FRAME hist-frame.
    END.
    
    ELSE DO:
        MESSAGE "Erro: historico nao encontrado!" VIEW-AS ALERT-BOX.
    END.
END.