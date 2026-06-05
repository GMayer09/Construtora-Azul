DEF FRAME historico-frame WITH TITLE "HISTORICO" CENTERED
    1 COLUMN 1 DOWN ROW 3.

DEF BUFFER b-displayFunc FOR funcionario.
DEF BUFFER b-displayCargo FOR cargo.

FOR EACH historico:
    FIND FIRST b-displayFunc 
        WHERE b-displayFunc.idFunc = historico.idFunc NO-LOCK NO-ERROR.
    FIND FIRST b-displayCargo
        WHERE b-displayCargo.idCargo = historico.idCargo NO-LOCK NO-ERROR.
    
    DISPLAY b-displayFunc.nome WITH FRAME historico-frame.
    DISPLAY b-displayCargo.nome WITH FRAME historico-frame.
    DISPLAY historico WITH FRAME historico-frame.
    HIDE FRAME historico-frame.
END.