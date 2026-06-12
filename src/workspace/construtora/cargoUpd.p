DEF VAR vRetCargo   AS INT NO-UNDO.
DEF VAR v-idCargo AS INT NO-UNDO.

DEF FRAME cargo-frame 
    v-idCargo LABEL "Cod.Cargo" SKIP
    WITH TITLE "ALTERAR CARGO" CENTERED
    1 COLUMN 1 DOWN ROW 3.
    
REPEAT:
    ON 'F5' OF v-idCargo IN FRAME cargo-frame DO:
        RUN browseCargo.p (OUTPUT vRetCargo).
        
        IF FOCUS:NAME = "v-idCargo" AND vRetCargo <> 0 THEN DO:
            v-idCargo = vRetCargo.
            FOCUS:SCREEN-VALUE = STRING(vRetCargo). 
        END.
        RETURN.
    END.
    
    UPDATE v-idCargo WITH FRAME cargo-frame.
    FIND cargo WHERE cargo.idCargo = v-idCargo EXCLUSIVE-LOCK NO-ERROR NO-WAIT.
    
    IF AVAILABLE cargo THEN DO:
        UPDATE cargo.nome WITH FRAME cargo-frame.
        MESSAGE "Cargo alterado com sucesso!" VIEW-AS ALERT-BOX.
        
        HIDE FRAME cargo-frame.
    END.
    
    ELSE DO:
        MESSAGE "Erro: cargo nao encontrado!" VIEW-AS ALERT-BOX.
    END.
END.