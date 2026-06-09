FUNCTION getLastIdDepe RETURN INT ():
    DEF BUFFER dependente FOR dependente.
    
    FIND LAST dependente NO-LOCK NO-ERROR.
    
    RETURN IF AVAIL dependente THEN dependente.idDepe ELSE 0.
END FUNCTION.

FUNCTION validIdFunc RETURN LOGICAL (INPUT v-idFunc AS INT):
    DEF BUFFER b-idFunc FOR funcionario.
    
    FIND FIRST b-idFunc 
        WHERE b-idFunc.idFunc = v-idFunc NO-LOCK NO-ERROR.
        
    RETURN IF AVAIL b-idFunc THEN TRUE ELSE FALSE.
END FUNCTION.

DEF VAR v-idFunc AS INT NO-UNDO.

DEF FRAME depe-frame WITH TITLE "CADASTRAR DEPENDENTE" CENTERED
    1 COLUMN 1 DOWN ROW 3.

REPEAT:
    CREATE dependente.
    ASSIGN dependente.idDepe = getLastIdDepe() + 1.
   
    UPDATE dependente.nome       dependente.cpf   dependente.rg       dependente.endereco
           dependente.nascimento dependente.sexo  dependente.grauPare
           v-idFunc LABEL "Cod. Func" WITH FRAME depe-frame.
    
    IF NOT validIdFunc(v-idFunc) THEN DO:
        MESSAGE "Erro: Codigo de funcionario invalido!" VIEW-AS ALERT-BOX ERROR.
        UNDO, RETRY.
    END.
    

    ASSIGN dependente.idFunc  = v-idFunc.
                
    HIDE FRAME depe-frame.
    MESSAGE "Dependente cadastrado com sucesso!" VIEW-AS ALERT-BOX.
END.