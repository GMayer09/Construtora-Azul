DEF FRAME depe-frame WITH TITLE "ALTERAR DEPENDENTE" CENTERED
    1 COLUMN 1 DOWN ROW 3.
    
REPEAT:
    PROMPT-FOR dependente.idDepe WITH FRAME depe-frame.
    FIND dependente WHERE dependente.idDepe = INPUT dependente.idDepe EXCLUSIVE-LOCK NO-ERROR NO-WAIT.
    
    IF AVAILABLE dependente THEN DO:
        UPDATE dependente WITH FRAME depe-frame.
        MESSAGE "Dependente alterado com sucesso!" VIEW-AS ALERT-BOX.
        
        HIDE FRAME depe-frame.
    END.
    
    ELSE DO:
        MESSAGE "Erro: dependente nao encontrado!" VIEW-AS ALERT-BOX.
    END.
END.