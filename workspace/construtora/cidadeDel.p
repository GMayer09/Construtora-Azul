DEF FRAME cidade-frame WITH TITLE "DELETAR CIDADE" CENTERED
    1 COLUMN 1 DOWN ROW 3.

DEF VAR del-answer AS LOGICAL LABEL "Delete?".

REPEAT:
    PROMPT-FOR cidade.idCidade WITH FRAME cidade-frame.
    FIND cidade WHERE cidade.idCidade = INPUT cidade.idCidade EXCLUSIVE-LOCK NO-ERROR NO-WAIT.
    
    IF AVAILABLE cidade THEN DO:
        DISP cidade WITH FRAME cidade-frame.
        
        del-answer = NO.
        UPDATE del-answer WITH FRAME cidade-frame.
        
        IF del-answer THEN DO:
            DELETE cidade.
            MESSAGE "Cidade deletada com sucesso!" VIEW-AS ALERT-BOX.
        END.
        HIDE FRAME cidade-frame.
    END.
    
    ELSE DO:
        MESSAGE "Erro: cidade nao encontrada!" VIEW-AS ALERT-BOX.
    END.
END.