DEF OUTPUT PARAM pFuncId AS INT NO-UNDO.
DEF OUTPUT PARAM pCargoId AS INT NO-UNDO.
DEF OUTPUT PARAM pCidadeId AS INT NO-UNDO.

DEF FRAME f-func.
DEF FRAME f-cargo.
DEF FRAME f-cidade.

DEF TEMP-TABLE tFunc NO-UNDO
    FIELD idFunc AS INT
    FIELD nome   AS CHAR.
DEF TEMP-TABLE tCargo NO-UNDO
    FIELD idCargo AS INT
    FIELD nome    AS CHAR.
DEF TEMP-TABLE tCidade NO-UNDO
    FIELD idCidade AS INT
    FIELD nome   AS CHAR.

PROCEDURE carregaqueryFunc:
    EMPTY TEMP-TABLE tFunc.
    FOR EACH funcionario NO-LOCK:
        CREATE tFunc.
        ASSIGN tFunc.idFunc = funcionario.idFunc
               tFunc.nome   = funcionario.nome.
    END.
END PROCEDURE.

PROCEDURE carregaqueryCargo:
    EMPTY TEMP-TABLE tCargo.
    FOR EACH cargo NO-LOCK:
        CREATE tCargo.
        ASSIGN tCargo.idCargo = cargo.idCargo
               tCargo.nome    = cargo.nome.
    END.
END PROCEDURE.

PROCEDURE carregaqueryCidade:
    EMPTY TEMP-TABLE tCidade.
    FOR EACH cidade NO-LOCK:
        CREATE tCidade.
        ASSIGN tCidade.idCidade = cidade.idCidade
               tCidade.nome    = cidade.nome.
    END.
END PROCEDURE.

PROCEDURE fmenu-func:
    DEF QUERY q-func FOR tFunc.
    
    DEF BROWSE b-func QUERY q-func
        DISP   idFunc COLUMN-LABEL "ID"
               nome   COLUMN-LABEL "Nome" FORMAT "x(30)"
        WITH 6 DOWN NO-BOX.
    
    DEF FRAME f-func 
        b-func WITH COLUMN 14 ROW 10 SIDE-LABELS OVERLAY KEEP-TAB-ORDER TITLE " [ Filtro ] ".
        
    RUN carregaqueryFunc.
    
    OPEN QUERY q-func FOR EACH tFunc NO-LOCK BY tFunc.idFunc.
    
    ON "RETURN" OF b-func IN FRAME f-func DO:
        IF AVAIL tFunc THEN DO:
            ASSIGN pFuncId = tFunc.idFunc.
            APPLY "END-ERROR" TO FRAME f-func.
        END.
    END.
    
    ON "END-ERROR" OF b-func IN FRAME f-func DO:
        HIDE FRAME f-func NO-PAUSE.
        HIDE MESSAGE NO-PAUSE.
    END.
    
    ENABLE b-func WITH FRAME f-func.
    WAIT-FOR "END-ERROR" OF FRAME f-func FOCUS b-func.
    HIDE FRAME f-func NO-PAUSE.
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

PROCEDURE p-escolha:
    DEF VAR v-opcao AS INT LABEL "Escolha uma opcao" NO-UNDO.
    
    DEF FRAME f-escolha
        "1 - Consultar Funcionarios" SKIP
        "2 - Consultar Cargos"       SKIP
        "3 - Consultar Cidades"      SKIP(1)
        v-opcao BLANK
        WITH CENTERED SIDE-LABELS TITLE " Menu de Consulta ".

    REPEAT:
        UPDATE v-opcao WITH FRAME f-escolha.
        
        IF v-opcao = 1 THEN DO:
            HIDE FRAME f-escolha.
            RUN fmenu-func.
            LEAVE.
        END.
        
        ELSE IF v-opcao = 2 THEN DO:
            HIDE FRAME f-escolha.
            RUN f-menu-cargo. 
            LEAVE.
        END.
        
        ELSE IF v-opcao = 3 THEN DO:
            HIDE FRAME f-escolha.
            RUN f-menu-cidade.
            LEAVE.
        END.
        
        ELSE DO:
            MESSAGE "Opcao Invalida!" VIEW-AS ALERT-BOX WARNING.
        END.
    END.
    
    HIDE FRAME f-escolha NO-PAUSE.
END PROCEDURE.

RUN p-escolha.