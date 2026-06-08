FUNCTION getLastIdFunc RETURN INT ():
    DEF BUFFER funcionario FOR funcionario.
    
    FIND LAST funcionario NO-LOCK NO-ERROR.
    
    RETURN IF AVAIL funcionario THEN funcionario.idFunc ELSE 0.
END FUNCTION.

FUNCTION validIdCargo RETURN LOGICAL (INPUT v-idCargo AS INT):
    DEF BUFFER b-idCargo FOR cargo.
    
    FIND FIRST b-idCargo NO-LOCK
        WHERE b-idCargo.idCargo = v-idCargo NO-ERROR.
        
    RETURN IF AVAIL b-idCargo THEN TRUE ELSE FALSE.
END FUNCTION.

FUNCTION validIdCidade RETURN LOGICAL (INPUT v-idCidade AS INT):
    DEF BUFFER b-idCidade FOR cidade.
    
    FIND FIRST b-idCidade NO-LOCK
        WHERE b-idCidade.idCidade = v-idCidade NO-ERROR.
        
    RETURN IF AVAIL b-idCidade THEN TRUE ELSE FALSE.
END FUNCTION.

DEF VAR v-idCargo AS INT NO-UNDO.
DEF VAR v-idCidade AS INT NO-UNDO.

DEF FRAME func-frame WITH TITLE "CADASTRAR FUNCIONARIO" CENTERED
    1 COLUMN 1 DOWN ROW 3.

REPEAT:
    CREATE funcionario.
    ASSIGN funcionario.idFunc = getLastIdFunc() + 1.
   
    UPDATE funcionario.nome       funcionario.cpf   funcionario.rg      funcionario.endereco
           funcionario.nascimento funcionario.sexo  funcionario.salario funcionario.dataAdm
           funcionario.dataDemi   v-idCargo LABEL "Cod. Cargo" v-idCidade LABEL "Cod. Cidade" WITH FRAME func-frame.
    
    IF NOT validIdCargo(v-idCargo) THEN DO:
        MESSAGE "Erro: Codigo de cargo invalido!" VIEW-AS ALERT-BOX ERROR.
        UNDO, RETRY.
    END.
    
    IF NOT validIdCidade(v-idCidade) THEN DO:
        MESSAGE "Erro: Codigo de cidade invalido!" VIEW-AS ALERT-BOX ERROR.
        UNDO, RETRY.
    END.
    
    ASSIGN 
        funcionario.idCargo  = v-idCargo.
        funcionario.idCidade = v-idCidade.
        
    HIDE FRAME func-frame.
    MESSAGE "Funcionario cadastrado com sucesso!" VIEW-AS ALERT-BOX.
END.