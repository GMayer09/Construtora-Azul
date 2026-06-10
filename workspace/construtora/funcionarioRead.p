DEF FRAME func-frame WITH TITLE "CONSULTA FUNCIONARIO" CENTERED
    1 COLUMN 1 DOWN ROW 3.

DEF BUFFER b-displayCargo FOR cargo.
DEF BUFFER b-displayCidade FOR cidade.

REPEAT:
    PROMPT-FOR funcionario.idFunc WITH FRAME func-frame.
    FIND funcionario WHERE funcionario.idFunc = INPUT funcionario.idFunc NO-LOCK NO-ERROR NO-WAIT.
    
    IF AVAIL funcionario THEN DO:
        FIND FIRST b-displayCargo
            WHERE b-displayCargo.idCargo = funcionario.idCargo NO-LOCK NO-ERROR NO-WAIT.
        FIND FIRST b-displayCidade 
            WHERE b-displayCidade.idCidade = funcionario.idCidade NO-LOCK NO-ERROR NO-WAIT.
        
        DISPLAY funcionario WITH FRAME func-frame.
        DISPLAY b-displayCargo.nome b-displayCidade.nome b-displayCidade.estado WITH FRAME func-frame.
        
        HIDE FRAME func-frame.
    END.
    
    ELSE DO:
        MESSAGE "Erro: funcionario nao foi encontrado!" VIEW-AS ALERT-BOX.
    END.
END.