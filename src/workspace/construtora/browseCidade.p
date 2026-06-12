DEF OUTPUT PARAM pCidadeId AS INT NO-UNDO.

DEF FRAME f-cidade.

DEF TEMP-TABLE tCidade NO-UNDO
    FIELD idCidade AS INT
    FIELD nome   AS CHAR.

PROCEDURE carregaqueryCidade:
    EMPTY TEMP-TABLE tCidade.
    FOR EACH cidade NO-LOCK:
        CREATE tCidade.
        ASSIGN tCidade.idCidade = cidade.idCidade
               tCidade.nome    = cidade.nome.
    END.
END PROCEDURE.

PROCEDURE f-menu-cidade:
    DEF QUERY q-cidade FOR tCidade.
    
    DEF BROWSE b-cidade QUERY q-cidade
        DISP   idCidade COLUMN-LABEL "ID"
               nome   COLUMN-LABEL "Nome" FORMAT "x(30)"
        WITH 6 DOWN NO-BOX.
    
    DEF FRAME f-cidade
        b-cidade WITH COLUMN 14 ROW 10 SIDE-LABELS OVERLAY KEEP-TAB-ORDER TITLE " [ Filtro ] ".
    
    RUN carregaqueryCidade.
    
    OPEN QUERY q-cidade FOR EACH tCidade NO-LOCK BY tCidade.idCidade.
    
    ON "RETURN" OF b-cidade IN FRAME f-cidade DO:
        IF AVAIL tCidade THEN DO:
            ASSIGN pCidadeId = tCidade.idCidade.
            APPLY "END-ERROR" TO FRAME f-Cidade.
        END.
    END.
    
    ON "END-ERROR" OF b-cidade IN FRAME f-cidade DO:
        HIDE FRAME f-cidade NO-PAUSE.
        HIDE MESSAGE NO-PAUSE.
    END.
    
    ENABLE b-cidade WITH FRAME f-cidade.
    WAIT-FOR "END-ERROR" OF FRAME f-cidade FOCUS b-cidade.
    HIDE FRAME f-cidade NO-PAUSE.
END PROCEDURE.

RUN f-menu-cidade.