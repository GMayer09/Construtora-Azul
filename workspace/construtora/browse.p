DEF FRAME f-func.

DEF TEMP-TABLE tFunc
    FIELD idFunc AS INT
    FIELD nome AS CHAR.

PROCEDURE carregaqueryFunc:
    EMPTY TEMP-TABLE tFunc.
    
    FOR EACH funcionario:
        CREATE tFunc.
        ASSIGN tFunc.idFunc = funcionario.idFunc
               tFunc.nome = funcionario.nome.
    END.
END PROCEDURE.

PROCEDURE fmenu-lista:
    DEF OUTPUT PARAM opFuncId AS INT NO-UNDO.
    
    DEF QUERY q-func FOR tFunc.
    
    DEF BROWSE b-func QUERY q-func
    DISP idFunc COLUMN-LABEL "ID"
         nome   COLUMN-LABEL "Nome" FORMAT "x(30)"
            WITH 6 DOWN NO-BOX.
    
    DEF FRAME f-func 
              b-func WITH COLUMN 14 ROW 10 SIDE-LABELS OVERLAY KEEP-TAB-ORDER TITLE " [ Filtro ] ".
    RUN carregaqueryFunc.
    
    OPEN QUERY q-func FOR EACH tFunc WHERE NO-LOCK BY tFunc.idFunc.
    
    ON "RETURN" OF b-func IN FRAME f-func DO:
        IF AVAIL tFunc THEN DO:
            ASSIGN opFuncId = tFunc.idFunc.
            APPLY "END-ERROR" TO FRAME f-func.
        END.
    END.
    
    ON "END-ERROR" OF b-func IN FRAME f-func DO:
        HIDE FRAME f-func NO-PAUSE.
        HIDE MESSAGE NO-PAUSE.
    END.
    
    ENABLE ALL WITH FRAME f-func.
    WAIT-FOR "END-ERROR" OF FRAME f-func FOCUS b-func.
    HIDE FRAME f-func NO-PAUSE.
END PROCEDURE.