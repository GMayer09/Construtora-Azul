FUNCTION getLastIdCidade RETURN INT ():
    DEF BUFFER cidade FOR cidade.
    
    FIND LAST cidade NO-LOCK NO-ERROR.
    
    RETURN IF AVAIL cidade THEN cidade.idCidade ELSE 0.
END FUNCTION.

DEF FRAME cidade-frame WITH TITLE "CADASTRAR CIDADE" CENTERED
    1 COLUMN 1 DOWN ROW 3.

REPEAT:        
    CREATE cidade.
    ASSIGN cidade.idCidade = getLastIdCidade() + 1.
    UPDATE cidade.nome cidade.estado WITH FRAME cidade-frame.

    HIDE FRAME cidade-frame.
    MESSAGE "Cidade cadastrada com sucesso!" VIEW-AS ALERT-BOX.
END.