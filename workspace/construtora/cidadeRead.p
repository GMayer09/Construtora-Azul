DEF FRAME cidade-frame WITH TITLE "CONSULTAR CIDADE" CENTERED
    1 COLUMN 1 DOWN ROW 3.

REPEAT:
    PROMPT cidade.idCidade WITH FRAME cidade-frame.
    FIND cidade WHERE cidade.idCidade = INPUT cidade.idCidade NO-LOCK NO-ERROR NO-WAIT. 
    
    IF AVAIL cidade THEN DO:
        DISP cidade WITH FRAME cidade-frame.
        HIDE FRAME cidade-frame.
    END.
    
    ELSE DO:
        MESSAGE "Erro: cidade não foi encontrada!" VIEW-AS ALERT-BOX.
    END.
END.