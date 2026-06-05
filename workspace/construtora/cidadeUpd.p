DEF FRAME cidade-frame WITH TITLE "ALTERAR CIDADE" CENTERED
    1 COLUMN 1 DOWN ROW 3.
REPEAT:
    PROMPT-FOR cidade.idCidade WITH FRAME cidade-frame.
    FIND cidade WHERE cidade.idCidade = INPUT cidade.idCidade EXCLUSIVE-LOCK NO-ERROR.
    IF AVAILABLE cidade THEN DO:
        DISPLAY cidade WITH FRAME cidade-frame.
        UPDATE cidade.nome cidade.estado WITH FRAME cidade-frame.
        HIDE FRAME cidade-frame.
        MESSAGE "Cidade alterada com sucesso!" VIEW-AS ALERT-BOX.
    END.
    ELSE DO:
        MESSAGE "Erro: cidade nao encontrada!" VIEW-AS ALERT-BOX.
    END.
END.