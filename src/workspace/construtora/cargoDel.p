DEF VAR vRetCargo   AS INT NO-UNDO.
DEF VAR v-idCargo AS INT NO-UNDO.

DEF FRAME cargo-frame 
    v-idCargo LABEL "Cod.Cargo" SKIP
    WITH TITLE "DELETE CARGO" CENTERED
    1 COLUMN 1 DOWN ROW 3.

DEF VAR del-answer AS LOGICAL LABEL "Delete?".

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
    FIND cargo WHERE cargo.idCargo = v-idCargo EXCLUSIVE-LOCK NO-ERROR NO-WAIT.
    
    IF AVAILABLE cargo THEN DO:
        DISP cargo.nome cargo.nome WITH FRAME cargo-frame.
        del-answer = NO.
        UPDATE del-answer WITH FRAME cargo-frame.
        
        IF del-answer THEN DO:
            MESSAGE "Cargo" cargo.idCargo " - " cargo.nome "deletado com sucesso!" VIEW-AS ALERT-BOX.
            DELETE cargo.
        END.
        HIDE FRAME cargo-frame.
    END.
    
    ELSE DO:
        MESSAGE "Erro: cargo nao foi encontrado!" VIEW-AS ALERT-BOX.
    END.
END.