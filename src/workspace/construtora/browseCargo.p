DEF OUTPUT PARAM pCargoId AS INT NO-UNDO.

DEF FRAME f-cargo.

DEF TEMP-TABLE tCargo NO-UNDO
    FIELD idCargo AS INT
    FIELD nome    AS CHAR.

PROCEDURE carregaqueryCargo:
    EMPTY TEMP-TABLE tCargo.
    FOR EACH cargo NO-LOCK:
        CREATE tCargo.
        ASSIGN tCargo.idCargo = cargo.idCargo
               tCargo.nome    = cargo.nome.
    END.
END PROCEDURE.

PROCEDURE f-menu-cargo:
    DEF QUERY q-cargo FOR tCargo.
    
    DEF BROWSE b-cargo QUERY q-cargo
        DISP   idCargo COLUMN-LABEL "ID"
               nome   COLUMN-LABEL "Nome" FORMAT "x(30)"
        WITH 6 DOWN NO-BOX.
    
    DEF FRAME f-cargo
        b-cargo WITH COLUMN 14 ROW 10 SIDE-LABELS OVERLAY KEEP-TAB-ORDER TITLE " [ Filtro ] ".
    
    RUN carregaqueryCargo.
    
    OPEN QUERY q-cargo FOR EACH tCargo NO-LOCK BY tCargo.idCargo.
    
    ON "RETURN" OF b-cargo IN FRAME f-cargo DO:
        IF AVAIL tCargo THEN DO:
            ASSIGN pCargoId = tCargo.idCargo.
            APPLY "END-ERROR" TO FRAME f-Cargo.
        END.
    END.
    
    ON "END-ERROR" OF b-cargo IN FRAME f-cargo DO:
        HIDE FRAME f-cargo NO-PAUSE.
        HIDE MESSAGE NO-PAUSE.
    END.
    
    ENABLE b-cargo WITH FRAME f-cargo.
    WAIT-FOR "END-ERROR" OF FRAME f-cargo FOCUS b-cargo.
    HIDE FRAME f-cargo NO-PAUSE.
END PROCEDURE.

RUN f-menu-cargo.