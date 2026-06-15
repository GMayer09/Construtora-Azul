DEF OUTPUT PARAM pDepeId AS INT NO-UNDO.

DEF FRAME f-Depe.

DEF TEMP-TABLE tDepe NO-UNDO
    FIELD idDepe AS INT
    FIELD nome  AS CHAR.
    
PROCEDURE carregaqueryDepe:
    EMPTY TEMP-TABLE tDepe.
    FOR EACH dependente NO-LOCK:
        CREATE tDepe.
        ASSIGN tDepe.idDep = dependente.idDepe
               tDepe.nome  = dependente.nome.
    END.
END PROCEDURE.

PROCEDURE fmenu-depe:
    DEF QUERY q-depe FOR tDepe.
    
    DEF BROWSE b-depe QUERY q-depe
        DISP idDepe COLUMN-LABEL "ID"
             nome   COLUMN-LABEL "Nome" FORM "x(20)"
        WITH 6 DOWN NO-BOX.
    
    DEF FRAME f-depe
        b-depe WITH COLUMN 14 ROW 10 SIDE-LABELS OVERLAY KEEP-TAB-ORDER TITLE "[ Filtro ]".
    
    RUN carregaqueryDepe.
    
    OPEN QUERY q-depe FOR EACH tDepe NO-LOCK BY tDepe.idDepe.
    
        ON "RETURN" OF b-depe IN FRAME f-depe DO:
        GET CURRENT q-depe NO-LOCK.
        
        IF AVAIL tDepe THEN DO:
            ASSIGN pDepeId = tDepe.idDepe.
            APPLY "END-ERROR" TO FRAME f-depe.
        END.
    END.
    
    ON "END-ERROR" OF b-depe IN FRAME f-depe DO:
        HIDE FRAME f-depe NO-PAUSE.
        HIDE MESSAGE NO-PAUSE.
    END.
    
    ENABLE b-depe WITH FRAME f-depe.
    WAIT-FOR "END-ERROR" OF FRAME f-depe FOCUS b-depe.
    HIDE FRAME f-depe NO-PAUSE.
END PROCEDURE.

RUN fmenu-depe.