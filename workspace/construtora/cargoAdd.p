DEF FRAME cargo-frame WITH TITLE "CADASTRAR CARGO" CENTERED
    1 COLUMN 1 DOWN ROW 3.

FUNCTION getLastIdCargo RETURN INT ():
    DEF BUFFER cargo FOR cargo.

    FIND LAST cargo NO-LOCK NO-ERROR.

    RETURN IF AVAIL cargo THEN cargo.idCargo ELSE 0.
END FUNCTION.

REPEAT:        
    CREATE cargo.
    ASSIGN cargo.idCargo = getLastIdCargo() + 1.
    UPDATE cargo.nome WITH FRAME cargo-frame.
    
    HIDE FRAME cargo-frame.
    MESSAGE "Cargo cadastrado com sucesso!" VIEW-AS ALERT-BOX.
END.