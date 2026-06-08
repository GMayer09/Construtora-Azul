DEF FRAME cargo-frame WITH TITLE "CONSULTA CARGO" CENTERED
    1 COLUMN 1 DOWN ROW 3.

REPEAT:
    PROMPT-FOR cargo.idCargo WITH FRAME cargo-frame.
    FIND cargo WHERE cargo.idCargo = INPUT cargo.idCargo NO-LOCK NO-ERROR NO-WAIT.
    
    IF AVAIL cargo THEN DO:
        DISPLAY cargo WITH FRAME cargo-frame.
        HIDE FRAME cargo-frame.
    END.
    
    ELSE DO:
        MESSAGE "Erro: cargo não foi encontrado!" VIEW-AS ALERT-BOX.
    END.
END.