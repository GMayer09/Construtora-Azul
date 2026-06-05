DEF FRAME depe-frame WITH TITLE "CONSULTA DEPENDENTE" CENTERED
    1 COLUMN 1 DOWN ROW 3.

DEF BUFFER b-displayFunc FOR funcionario.

FOR EACH dependente:
    FIND FIRST b-displayFunc 
        WHERE b-displayFunc.idFunc = dependente.idFunc NO-LOCK NO-ERROR.

    DISPLAY dependente WITH FRAME depe-frame.
    DISPLAY b-displayFunc WITH FRAME depe-frame.
    HIDE FRAME depe-frame.
END.