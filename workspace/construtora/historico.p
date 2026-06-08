DEF FRAME historico-frame WITH TITLE "HISTORICO" CENTERED
    1 COLUMN 1 DOWN ROW 3.

DEF BUFFER b-displayFunc FOR funcionario.
DEF BUFFER b-displayCargo FOR cargo.

REPEAT:
    PROMPT-FOR historico.idHist WITH FRAME historico-frame.
    FIND historico WHERE historico.idHist = INPUT historico.idHist NO-LOCK NO-ERROR NO-WAIT.
    
    IF AVAIL historico THEN DO:
        FIND FIRST b-displayFunc 
            WHERE b-displayFunc.idFunc = historico.idFunc NO-LOCK NO-ERROR NO-WAIT.
        FIND FIRST b-displayCargo
            WHERE b-displayCargo.idCargo = historico.idCargo NO-LOCK NO-ERROR NO-WAIT.
        
        DISPLAY b-displayFunc.nome WITH FRAME historico-frame.
        DISPLAY b-displayCargo.nome WITH FRAME historico-frame.
        DISPLAY historico WITH FRAME historico-frame.
        
        HIDE FRAME historico-frame.
    END.
    
    ELSE DO:
        MESSAGE "Erro: historico nao foi encontrado!" VIEW-AS ALERT-BOX.
    END.
END.