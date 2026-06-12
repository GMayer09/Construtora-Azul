DEF VAR vRetCidade  AS INT NO-UNDO.
DEF VAR v-idCidade AS INT NO-UNDO.

DEF FRAME cidade-frame 
    v-idCidade LABEL "Cod.Cidade" SKIP
    WITH TITLE "DELETAR CIDADE" CENTERED
    1 COLUMN 1 DOWN ROW 3.

DEF VAR del-answer AS LOGICAL LABEL "Delete?".

REPEAT:
    ON 'F5' OF v-idCidade IN FRAME cidade-frame DO:
        RUN browseCidade.p (OUTPUT vRetCidade).
        
        IF FOCUS:NAME = "v-idCidade" AND vRetCidade <> 0 THEN DO:
            v-idCidade = vRetCidade.
            FOCUS:SCREEN-VALUE = STRING(vRetCidade).
        END.
        RETURN.
    END.
    
    ASSIGN v-idCidade = 0.
    
    UPDATE v-idCidade WITH FRAME cidade-frame.
    FIND cidade WHERE cidade.idCidade = v-idCidade EXCLUSIVE-LOCK NO-ERROR NO-WAIT.
    
    IF AVAILABLE cidade THEN DO:
        DISP v-idCidade cidade.nome cidade.estado WITH FRAME cidade-frame.
        
        del-answer = NO.
        UPDATE del-answer WITH FRAME cidade-frame.
        
        IF del-answer THEN DO:
            MESSAGE "Cidade" cidade.idCidade " - " cidade.nome "deletada com sucesso!" VIEW-AS ALERT-BOX.
            DELETE cidade.
        END.
        HIDE FRAME cidade-frame.
    END.
    
    ELSE DO:
        MESSAGE "Erro: cidade nao encontrada!" VIEW-AS ALERT-BOX.
    END.
END.