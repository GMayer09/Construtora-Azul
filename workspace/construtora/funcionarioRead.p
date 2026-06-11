DEF VAR wfuncid AS INT NO-UNDO.

DEF VAR vRetFunc    AS INT NO-UNDO.
DEF VAR vRetCargo   AS INT NO-UNDO.
DEF VAR vRetCidade  AS INT NO-UNDO.

DEF FRAME func-frame
    wfuncid LABEL "Cod.Func" SKIP
    WITH TITLE "CONSULTA FUNCIONARIO" CENTERED
    1 COLUMN 1 DOWN ROW 3.

DEF BUFFER b-displayCargo FOR cargo.
DEF BUFFER b-displayCidade FOR cidade.

MAIN-LOOP:
REPEAT ON ENDKEY UNDO, LEAVE:
    ON 'F5' OF wfuncid IN FRAME func-frame DO:
        RUN browse.p (OUTPUT vRetFunc, OUTPUT vRetCargo, OUTPUT vRetCidade).
        IF vRetFunc <> 0 THEN wfuncid = vRetFunc.
        DISP wfuncid WITH FRAME func-frame.
    END.
    
    UPDATE wfuncid WITH FRAME func-frame.
    
    FIND funcionario WHERE funcionario.idFunc = wfuncid NO-LOCK NO-ERROR NO-WAIT.
    
    IF AVAIL funcionario THEN DO:
        FIND FIRST b-displayCargo
            WHERE b-displayCargo.idCargo = funcionario.idCargo NO-LOCK NO-ERROR NO-WAIT.
        FIND FIRST b-displayCidade 
            WHERE b-displayCidade.idCidade = funcionario.idCidade NO-LOCK NO-ERROR NO-WAIT.
        
        DISPLAY funcionario.nome       funcionario.cpf     funcionario.rg      funcionario.endereco 
                funcionario.nascimento funcionario.sexo    funcionario.salario funcionario.dataAdm
                funcionario.dataDemi   funcionario.idCargo b-displayCargo.nome funcionario.idCidade
                b-displayCidade.nome   b-displayCidade.estado
                WITH FRAME func-frame.
        HIDE FRAME func-frame.
    END.
    
    ELSE DO:
        MESSAGE "Erro: funcionario nao foi encontrado!" VIEW-AS ALERT-BOX.
    END.
END.