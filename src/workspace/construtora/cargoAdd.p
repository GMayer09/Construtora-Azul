DEF FRAME cargo-frame WITH TITLE "CADASTRAR CARGO" CENTERED
    1 COLUMN 1 DOWN ROW 3.

DEF VAR vRetCargo   AS INT NO-UNDO.
DEF VAR v-idCargo AS INT NO-UNDO.

FUNCTION getLastIdCargo RETURN INT ():
    DEF BUFFER cargo FOR cargo.

    FIND LAST cargo NO-LOCK NO-ERROR.

    RETURN IF AVAIL cargo THEN cargo.idCargo ELSE 0.
END FUNCTION.

REPEAT:
    ON 'F5' ANYWHERE DO:
        RUN browseCargo.p (OUTPUT vRetCargo).
        
        IF FOCUS:NAME = "v-idCargo" AND vRetCargo <> 0 THEN DO:
            v-idCargo = vRetCargo.
            FOCUS:SCREEN-VALUE = STRING(vRetCargo). 
        END.
        RETURN.
    END.
    
    ASSIGN v-idCargo = 0.
    
    CREATE cargo.
    ASSIGN cargo.idCargo = getLastIdCargo() + 1
           v-idCargo     = cargo.idCargo.
    UPDATE cargo.nome WITH FRAME cargo-frame.
    
    HIDE FRAME cargo-frame.
    MESSAGE "Cargo cadastrado com sucesso!" VIEW-AS ALERT-BOX.
END.