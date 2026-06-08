DEF FRAME cargo-frame WITH TITLE "ALTERAR CARGO" CENTERED
    1 COLUMN 1 DOWN ROW 3.
REPEAT:
    PROMPT-FOR cargo.idCargo WITH FRAME cargo-frame.
    FIND cargo WHERE cargo.idCargo = INPUT cargo.idCargo EXCLUSIVE-LOCK NO-ERROR NO-WAIT.
    
    IF AVAILABLE cargo THEN DO:
        UPDATE cargo.nome WITH FRAME cargo-frame.
        MESSAGE "Cargo alterado com sucesso!" VIEW-AS ALERT-BOX.
        
        HIDE FRAME cargo-frame.
    END.
    
    ELSE DO:
        MESSAGE "Erro: cargo nao encontrado!" VIEW-AS ALERT-BOX.
    END.
END.