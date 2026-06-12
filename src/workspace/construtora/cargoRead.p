DEF VAR vRetCargo   AS INT NO-UNDO.
DEF VAR v-idCargo AS INT NO-UNDO.

DEF FRAME cargo-frame 
    v-idCargo LABEL "Cod.Cargo" SKIP
    WITH TITLE "CONSULTA CARGO" CENTERED
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
    
    ASSIGN v-idCargo = 0.
    
    UPDATE v-idCargo WITH FRAME cargo-frame.
    FIND cargo WHERE cargo.idCargo = v-idCargo NO-LOCK NO-ERROR.
    
    IF AVAIL cargo THEN DO:
        DISP v-idCargo cargo.nome WITH FRAME cargo-frame.
        HIDE FRAME cargo-frame.
    END.
    
    ELSE DO:
        MESSAGE "Erro: cargo nao foi encontrado!" VIEW-AS ALERT-BOX.
    END.
END.