DEF VAR cargo-ant AS INT NO-UNDO.
DEF VAR salario-ant AS DEC NO-UNDO.
DEF VAR data-ini AS DATE NO-UNDO.
DEF VAR wfuncid AS INT NO-UNDO.

DEF VAR vRetFunc    AS INT NO-UNDO.
DEF VAR vRetCargo   AS INT NO-UNDO.
DEF VAR vRetCidade  AS INT NO-UNDO.

DEF VAR v-idCargo AS INT NO-UNDO.
DEF VAR v-idCidade AS INT NO-UNDO.
DEF VAR v-acao AS INT INITIAL 1 FORM "9" NO-UNDO.

DEF FRAME func-frame
    v-acao LABEL "1.Cadas/2.Altera" SKIP
    wfuncid LABEL "Cod.Func" SKIP
    funcionario.nome       funcionario.cpf   funcionario.rg      funcionario.endereco
    funcionario.nascimento funcionario.sexo  funcionario.salario funcionario.dataAdm
    funcionario.dataDemi
    v-idCargo LABEL "Cod.Cargo" SKIP
    v-idCidade LABEL "Cod.Cidade" SKIP
    WITH TITLE "FUNCIONARIO" CENTERED 1 COLUMN 1 DOWN ROW 3.

FUNCTION getLastIdFunc RETURN INT ():
    DEF BUFFER funcionario FOR funcionario.
    
    FIND LAST funcionario NO-LOCK NO-ERROR.
    
    RETURN IF AVAIL funcionario THEN funcionario.idFunc ELSE 0.
END FUNCTION.

FUNCTION getLastIdHist RETURN INT ():
    DEF BUFFER historico FOR historico.
    
    FIND LAST historico NO-LOCK NO-ERROR.
    
    RETURN IF AVAIL historico THEN historico.idHist ELSE 0.
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

FUNCTION ocupouCargoAnterior RETURN LOGICAL (INPUT p-idFunc AS INT, INPUT p-idCargo AS INT):
    DEF BUFFER b-historico FOR historico.
    
    FIND FIRST b-historico NO-LOCK 
         WHERE b-historico.idFunc  = p-idFunc 
           AND b-historico.idCargo = p-idCargo NO-ERROR.
           
    RETURN IF AVAIL b-historico THEN TRUE ELSE FALSE.
END FUNCTION.

MAIN-LOOP:
REPEAT:
    ON 'F5' OF wfuncid IN FRAME func-frame DO:
        RUN browseFunc.p (OUTPUT vRetFunc).
        
        IF FOCUS:NAME = "wfuncid" AND vRetFunc <> 0 THEN DO:
            wfuncid = vRetFunc.
            DISP wfuncid WITH FRAME func-frame.
        END.
    END.
    
    ON 'F5' OF v-idCargo IN FRAME func-frame DO:
        RUN browseCargo.p (OUTPUT vRetCargo).
        
        IF FOCUS:NAME = "v-idCargo" AND vRetCargo <> 0 THEN DO:
            v-idCargo = vRetCargo.
            FOCUS:SCREEN-VALUE = STRING(vRetCargo). 
        END.
        RETURN.
    END.
    
    ON 'F5' OF v-idCidade IN FRAME func-frame DO:
        RUN browseCidade.p (OUTPUT vRetCidade).
        
        IF FOCUS:NAME = "v-idCidade" AND vRetCidade <> 0 THEN DO:
            v-idCidade = vRetCidade.
            FOCUS:SCREEN-VALUE = STRING(vRetCidade).
        END.
        RETURN.
    END.
    
    ASSIGN wfuncid = 0.
    
    DISP v-acao wfuncid WITH FRAME func-frame.
    UPDATE v-acao WITH FRAME func-frame.
    
    IF v-acao <> 1 AND v-acao <> 2 THEN DO:
        MESSAGE "Erro: opcao invalida!" VIEW-AS ALERT-BOX ERROR.
        NEXT MAIN-LOOP.
    END.
    
    IF LASTKEY = KEYCODE("ESC") THEN LEAVE MAIN-LOOP.
    
    ASSIGN v-idCargo  = 0
           v-idCidade = 0.
    
    IF v-acao = 1 THEN DO:
        CREATE funcionario.
        ASSIGN funcionario.idFunc = getLastIdFunc() + 1
               wfuncid            = funcionario.idFunc.
        
        DISP wfuncid WITH FRAME func-frame.
        
        UPDATE funcionario.nome       funcionario.cpf   funcionario.rg      funcionario.endereco
               funcionario.nascimento funcionario.sexo  funcionario.salario funcionario.dataAdm
               funcionario.dataDemi   v-idCargo LABEL "Cod. Cargo" v-idCidade LABEL "Cod. Cidade" WITH FRAME func-frame.
        
        IF funcionario.dataDemi < funcionario.dataAdm THEN DO:
            MESSAGE "Erro: A data de demissao tem que ser maior que a data de admissao" VIEW-AS ALERT-BOX ERROR.
            UNDO, RETRY.
        END.
        
        IF NOT validIdCargo(v-idCargo) THEN DO:
            MESSAGE "Erro: Codigo de cargo invalido!" VIEW-AS ALERT-BOX ERROR.
            UNDO, RETRY.
        END.
        
        IF NOT validIdCidade(v-idCidade) THEN DO:
            MESSAGE "Erro: Codigo de cidade invalido!" VIEW-AS ALERT-BOX ERROR.
            UNDO, RETRY.
        END.
        
        ASSIGN 
            funcionario.idCargo  = v-idCargo
            funcionario.idCidade = v-idCidade.
            
        HIDE FRAME func-frame.
        MESSAGE "Funcionario cadastrado com sucesso!" VIEW-AS ALERT-BOX.      
    END.
    
     ELSE DO:
        UPDATE wfuncid WITH FRAME func-frame.
        FIND funcionario WHERE funcionario.idFunc = wfuncid EXCLUSIVE-LOCK NO-ERROR. 
        
        IF NOT AVAIL funcionario THEN DO:
            MESSAGE "Erro: Funcionario nao encontrado para alteracao!" VIEW-AS ALERT-BOX ERROR.
            NEXT MAIN-LOOP.
        END.
        
        ASSIGN cargo-ant   = funcionario.idCargo
               salario-ant = funcionario.salario
               data-ini    = funcionario.dataAdm
               v-idCargo   = funcionario.idCargo
               v-idCidade  = funcionario.idCidade.

        UPDATE funcionario.nome       funcionario.cpf   funcionario.rg      funcionario.endereco
               funcionario.nascimento funcionario.sexo  funcionario.salario funcionario.dataAdm
               funcionario.dataDemi   v-idCargo LABEL "Cod. Cargo" v-idCidade LABEL "Cod. Cidade" WITH FRAME func-frame.
        
        IF NOT validIdCargo(v-idCargo) THEN DO:
            MESSAGE "Erro: Codigo de cargo invalido!" VIEW-AS ALERT-BOX ERROR.
            UNDO MAIN-LOOP, RETRY MAIN-LOOP.
        END.
        
        IF NOT validIdCidade(v-idCidade) THEN DO:
            MESSAGE "Erro: Codigo de cidade invalido!" VIEW-AS ALERT-BOX ERROR.
            UNDO MAIN-LOOP, RETRY MAIN-LOOP.
        END.
        
        IF v-idCargo <> cargo-ant THEN DO:
            IF ocupouCargoAnterior(funcionario.idFunc, v-idCargo) THEN DO:
                MESSAGE "Erro: O funcionario nao pode voltar a ocupar um cargo anterior!" VIEW-AS ALERT-BOX ERROR.
                UNDO MAIN-LOOP, RETRY MAIN-LOOP.
            END.
        END.
        
        ASSIGN funcionario.idCargo  = v-idCargo
               funcionario.idCidade = v-idCidade.

        IF funcionario.idCargo <> cargo-ant OR funcionario.salario <> salario-ant THEN DO:
            CREATE historico.
            ASSIGN historico.idHist  = getLastIdHist() + 1
                   historico.idFunc  = funcionario.idFunc
                   historico.salario = salario-ant
                   historico.idCargo = cargo-ant
                   historico.dataIni = data-ini
                   historico.dataFim = TODAY.
            ASSIGN funcionario.dataAdm = TODAY.
        END.
        
        HIDE FRAME func-frame.
        MESSAGE "Funcionario alterado com sucesso!" VIEW-AS ALERT-BOX.
    END.
END.