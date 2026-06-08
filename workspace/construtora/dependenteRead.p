DEF FRAME depe-frame WITH TITLE "CONSULTA DEPENDENTE" CENTERED
    1 COLUMN 1 DOWN ROW 3.

DEF BUFFER b-displayFunc FOR funcionario.

REPEAT:
    PROMPT-FOR dependente.idDepe WITH FRAME depe-frame.
    FIND dependente WHERE dependente.idDepe = INPUT dependente.idDepe NO-LOCK NO-ERROR NO-WAIT.
    
    IF AVAIL dependente THEN DO:
        FIND FIRST b-displayFunc 
            WHERE b-displayFunc.idFunc = dependente.idFunc NO-LOCK NO-ERROR NO-WAIT.
    
        DISPLAY dependente WITH FRAME depe-frame.
        DISPLAY b-displayFunc.idFunc LABEL "Cod func" b-displayFunc.nome 
            LABEL "Nome do func" WITH FRAME depe-frame.
            
        HIDE FRAME depe-frame.
    END.
    
    ELSE DO:
        MESSAGE "Erro: dependente não foi encontrado!" VIEW-AS ALERT-BOX.
    END.
END.