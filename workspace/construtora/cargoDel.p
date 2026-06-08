DEF FRAME cargo-frame WITH TITLE "DELETE CARGO" CENTERED
    1 COLUMN 1 DOWN ROW 3.
DEF VAR del-answer AS LOGICAL LABEL "Delete?".
REPEAT:
    PROMPT-FOR cargo.idCargo WITH FRAME cargo-frame.
    FIND cargo WHERE cargo.idCargo = INPUT cargo.idCargo EXCLUSIVE-LOCK NO-ERROR NO-WAIT.
    
    IF AVAILABLE cargo THEN DO:
        DISPLAY cargo WITH FRAME cargo-frame.
        del-answer = NO.
        UPDATE del-answer WITH FRAME cargo-frame.
        
        IF del-answer THEN DO:
            DELETE cargo.
            MESSAGE "Cargo deletado com sucesso!" VIEW-AS ALERT-BOX.
        END.
        HIDE FRAME cargo-frame.
    END.
    
    ELSE DO:
        MESSAGE "Erro: cargo nao foi encontrado!" VIEW-AS ALERT-BOX.
    END.
END.