DEF VAR v-idCidade AS INT NO-UNDO.

DEF FRAME cidade-frame WITH TITLE "CADASTRAR CIDADE" CENTERED
    1 COLUMN 1 DOWN ROW 3.

FUNCTION getLastIdCidade RETURN INT ():
    DEF BUFFER cidade FOR cidade.
    
    FIND LAST cidade NO-LOCK NO-ERROR.
    
    RETURN IF AVAIL cidade THEN cidade.idCidade ELSE 0.
END FUNCTION.

REPEAT:    
    ASSIGN v-idCidade = 0.
    
    CREATE cidade.
    ASSIGN cidade.idCidade = getLastIdCidade() + 1
           v-idCidade = cidade.idCidade.
    UPDATE cidade.nome cidade.estado WITH FRAME cidade-frame.

    HIDE FRAME cidade-frame.
    MESSAGE "Cidade cadastrada com sucesso!" VIEW-AS ALERT-BOX.
END.