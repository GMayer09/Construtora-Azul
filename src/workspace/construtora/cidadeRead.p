DEF VAR vRetCidade  AS INT NO-UNDO.
DEF VAR v-idCidade AS INT NO-UNDO.

DEF FRAME cidade-frame 
    v-idCidade LABEL "Cod.Cidade"
    WITH TITLE "CONSULTAR CIDADE" CENTERED
    1 COLUMN 1 DOWN ROW 3.

REPEAT:
    ON 'F5' ANYWHERE DO:
        RUN browseCidade.p (OUTPUT vRetCidade).
        
        IF FOCUS:NAME = "v-idCidade" AND vRetCidade <> 0 THEN DO:
            v-idCidade = vRetCidade.
            FOCUS:SCREEN-VALUE = STRING(vRetCidade).
        END.
        RETURN.
    END.
    
    ASSIGN v-idCidade = 0.
    
    UPDATE v-idCidade WITH FRAME cidade-frame.
    FIND cidade WHERE cidade.idCidade = v-idCidade NO-LOCK NO-ERROR NO-WAIT. 
    
    IF AVAIL cidade THEN DO:
        DISP v-idCidade cidade.nome cidade.estado WITH FRAME cidade-frame.
        HIDE FRAME cidade-frame.
    END.
    
    ELSE DO:
        MESSAGE "Erro: cidade não foi encontrada!" VIEW-AS ALERT-BOX.
    END.
END.