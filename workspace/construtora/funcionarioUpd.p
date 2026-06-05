FUNCTION getLastIdHist RETURN INT ():
    DEF BUFFER historico FOR historico.
    FIND LAST historico NO-LOCK NO-ERROR.
    RETURN IF AVAIL historico THEN historico.idHist ELSE 0.
END FUNCTION.

DEF FRAME func-frame WITH TITLE "ALTERAR FUNCIONARIO" CENTERED
    1 COLUMN 1 DOWN ROW 3.

DEF VAR cargo-ant AS INT.
DEF VAR salario-ant AS DEC.
REPEAT:
    PROMPT-FOR funcionario.idFunc WITH FRAME func-frame.
    FIND funcionario WHERE funcionario.idFunc = INPUT funcionario.idFunc EXCLUSIVE-LOCK NO-ERROR.
    IF AVAILABLE funcionario THEN DO:
        ASSIGN cargo-ant = funcionario.idCargo.
        ASSIGN salario-ant = funcionario.salario.
        DISPLAY funcionario WITH FRAME func-frame.

        UPDATE funcionario WITH FRAME func-frame.
        IF funcionario.idCargo <> cargo-ant OR funcionario.salario <> salario-ant THEN DO:
            CREATE historico.
            ASSIGN historico.idHist = getLastIdHist() + 1.
            ASSIGN historico.idFunc = funcionario.idFunc
                   historico.salario = salario-ant
                   historico.idCargo = cargo-ant.
            MESSAGE "Para o antigo cargo ou salario do funcionario, diga qual data de inicio e fim desses dados."
                VIEW-AS ALERT-BOX.
            MESSAGE "Para o antigo cargo ou salario do funcionario, diga qual data de inicio e fim desses dados.".
            UPDATE historico.dataIni LABEL "Data de inicio" historico.dataFim LABEL "Data fim".
        END.
        MESSAGE "Funcionario alterado com sucesso!" VIEW-AS ALERT-BOX.
        HIDE FRAME func-frame.
    END.
    ELSE DO:
        MESSAGE "Erro: funcionario nao encontrado!" VIEW-AS ALERT-BOX.
    END.
END.