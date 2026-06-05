DEF FRAME func-frame WITH TITLE "DELETAR FUNCIONARIO" CENTERED
    1 COLUMN 1 DOWN ROW 3.
DEF VAR del-answer AS LOGICAL LABEL "Delete?".
REPEAT:
    PROMPT-FOR funcionario.idFunc WITH FRAME func-frame.
    FIND funcionario WHERE funcionario.idFunc = INPUT funcionario.idFunc EXCLUSIVE-LOCK NO-ERROR.
    IF AVAILABLE funcionario THEN DO:
        DISPLAY funcionario WITH FRAME func-frame.
        del-answer = NO.
        UPDATE del-answer WITH FRAME func-frame.
        IF del-answer THEN DO:
            DELETE funcionario.
            MESSAGE "Funcionario deletado com sucesso!" VIEW-AS ALERT-BOX.
        END.
        HIDE FRAME func-frame.
    END.
    ELSE DO:
        MESSAGE "Erro: funcionario nao encontrado!" VIEW-AS ALERT-BOX.
    END.
END.