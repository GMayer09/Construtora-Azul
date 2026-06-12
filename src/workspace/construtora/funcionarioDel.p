DEF VAR wfuncid AS INT NO-UNDO.

DEF VAR vRetFunc    AS INT NO-UNDO.

DEF FRAME func-frame 
    wfuncid LABEL "Cod.Func" SKIP
    WITH TITLE "DELETAR FUNCIONARIO" CENTERED
    1 COLUMN 1 DOWN ROW 3.
    
DEF VAR del-answer AS LOGICAL LABEL "Delete?".

REPEAT:
    ON 'F5' OF wfuncid IN FRAME func-frame DO:
        RUN browseFunc.p (OUTPUT vRetFunc).
        IF vRetFunc <> 0 THEN wfuncid = vRetFunc.
        DISP wfuncid WITH FRAME func-frame.
    END.
    
    ASSIGN wfuncid = 0.
    
    UPDATE wfuncid WITH FRAME func-frame.
    FIND funcionario WHERE funcionario.idFunc = wfuncid EXCLUSIVE-LOCK NO-ERROR NO-WAIT.
    
    IF AVAILABLE funcionario THEN DO:
        DISP funcionario.nome       funcionario.cpf     funcionario.rg      funcionario.endereco 
                funcionario.nascimento funcionario.sexo    funcionario.salario funcionario.dataAdm
                funcionario.dataDemi   funcionario.idCargo funcionario.idCidade
                WITH FRAME func-frame.
        
        del-answer = NO.
        UPDATE del-answer WITH FRAME func-frame.
        
        IF del-answer THEN DO:
            MESSAGE "Funcionario" funcionario.idFunc " - " funcionario.nome "deletado com sucesso!" VIEW-AS ALERT-BOX.
            DELETE funcionario.
        END.
        HIDE FRAME func-frame.
    END.
    
    ELSE DO:
        MESSAGE "Erro: funcionario nao encontrado!" VIEW-AS ALERT-BOX.
    END.
END.