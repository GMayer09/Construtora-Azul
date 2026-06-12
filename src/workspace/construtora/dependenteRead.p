DEF FRAME depe-frame WITH TITLE "CONSULTA DEPENDENTE" CENTERED
    1 COLUMN 1 DOWN ROW 3.

DEF BUFFER b-displayFunc FOR funcionario.

REPEAT:
    PROMPT-FOR dependente.idDepe WITH FRAME depe-frame.
    FIND dependente WHERE dependente.idDepe = INPUT dependente.idDepe NO-LOCK NO-ERROR NO-WAIT.
    
    IF AVAIL dependente THEN DO:
        FIND FIRST b-displayFunc 
            WHERE b-displayFunc.idFunc = dependente.idFunc NO-LOCK NO-ERROR NO-WAIT.
    
        DISP dependente WITH FRAME depe-frame.
        DISP b-displayFunc.nome 
            LABEL "Nome do Func" WITH FRAME depe-frame.
            
        HIDE FRAME depe-frame.
    END.
    
    ELSE DO:
        MESSAGE "Erro: dependente nao foi encontrado!" VIEW-AS ALERT-BOX.
    END.
END.