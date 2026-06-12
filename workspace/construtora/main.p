DEF VAR v-choose AS INT NO-UNDO.
DEF VAR v-subchoose AS INT NO-UNDO.

DEF VAR menu AS CHAR EXTENT 6 FORM "x(29)"
    INITIAL ["1.Gerenciamento Funcionario", "2.Gerenciamento Dependente",
    "3.Gerencimento Cargo", "4.Gerencimento Cidade", "5.Historico", "6.Relatorio"].

DEF VAR submenu1 AS CHAR EXTENT 3 FORM "x(31)"
    INITIAL ["1.Cadastrar/Alterar Funcionario", "2.Consultar Funcionario",
    "3.Deletar Funcionario"].
DEF VAR submenu2 AS CHAR EXTENT 4 FORM "x(23)"
    INITIAL ["1.Cadastrar Dependente", "2.Consultar Dependente",
    "3.Alterar Dependente", "4.Deletar Dependente"].
DEF VAR submenu3 AS CHAR EXTENT 4 FORM "x(17)"
    INITIAL ["1.Cadastrar Cargo", "2.Consultar Cargo",
    "3.Alterar Cargo", "4.Deletar Cargo"].
DEF VAR submenu4 AS CHAR EXTENT 4 FORM "x(18)"
    INITIAL ["1.Cadastrar Cidade", "2.Consultar Cidade",
    "3.Alterar Cidade", "4.Deletar Cidade"].
DEF VAR submenu5 AS CHAR EXTENT 2 FORM "x(22)"
    INITIAL ["1.Consultar Historico", "2.Deletar Historico"].

DEF FRAME f-menu WITH TITLE "MENU PRINCIPAL" CENTERED
    1 COLUMN 1 DOWN NO-LABELS ROW 3.
    
DEF FRAME f-submenu1 WITH TITLE "MENU FUNCIONARIO" CENTERED
    1 COLUMN 1 DOWN NO-LABELS ROW 3.
DEF FRAME f-submenu2 WITH TITLE "MENU DEPENDENTE" CENTERED
    1 COLUMN 1 DOWN NO-LABELS ROW 3.
DEF FRAME f-submenu3 WITH TITLE "MENU CARGO" CENTERED
    1 COLUMN 1 DOWN NO-LABELS ROW 3.
DEF FRAME f-submenu4 WITH TITLE "MENU CIDADE" CENTERED
    1 COLUMN 1 DOWN NO-LABELS ROW 3.
DEF FRAME f-submenu5 WITH TITLE "HISTORICO" CENTERED
    1 COLUMN 1 DOWN NO-LABELS ROW 3.
    
main-block:
DO TRANSACTION:
    REPEAT:
        DISP menu WITH FRAME f-menu.
        CHOOSE FIELD menu AUTO-RETURN WITH FRAME f-menu.
        v-choose = FRAME-INDEX.
        HIDE FRAME f-menu.
        
        IF v-choose > 0 AND v-choose <= 6 THEN DO:
            IF v-choose = 1 THEN DISP submenu1 WITH FRAME f-submenu1.
            IF v-choose = 2 THEN DISP submenu2 WITH FRAME f-submenu2.
            IF v-choose = 3 THEN DISP submenu3 WITH FRAME f-submenu3.
            IF v-choose = 4 THEN DISP submenu4 WITH FRAME f-submenu4.
            IF v-choose = 5 THEN DISP submenu5 WITH FRAME f-submenu5.
            IF v-choose = 6 THEN RUN relatorio.p.
            
            IF v-choose = 1 THEN DO:
                CHOOSE FIELD submenu1 AUTO-RETURN WITH FRAME f-submenu1.
                v-subchoose = FRAME-INDEX.
                HIDE FRAME f-submenu1.
                
                IF LASTKEY <> KEYCODE("ESC") THEN DO:
                    IF v-subchoose = 1 THEN RUN funcionarioUpd.p.
                    ELSE IF v-subchoose = 2 THEN RUN funcionarioRead.p.
                    ELSE IF v-subchoose = 3 THEN RUN funcionarioDel.p.
                END.
            END.
            
            ELSE IF v-choose = 2 THEN DO:
                CHOOSE FIELD submenu2 AUTO-RETURN WITH FRAME f-submenu2.
                v-subchoose = FRAME-INDEX.
                HIDE FRAME f-submenu2.
                
                IF LASTKEY <> KEYCODE("ESC") THEN DO:
                    IF v-subchoose = 1 THEN RUN dependenteAdd.p.
                    ELSE IF v-subchoose = 2 THEN RUN dependenteRead.p.
                    ELSE IF v-subchoose = 3 THEN RUN dependenteUpd.p.
                    ELSE IF v-subchoose = 4 THEN RUN dependenteDel.p.
                END.
            END.
            
            ELSE IF v-choose = 3 THEN DO:
                CHOOSE FIELD submenu3 AUTO-RETURN WITH FRAME f-submenu3.
                v-subchoose = FRAME-INDEX.
                HIDE FRAME f-submenu3.
                
                IF LASTKEY <> KEYCODE("ESC") THEN DO:
                    IF v-subchoose = 1 THEN RUN cargoAdd.p.
                    ELSE IF v-subchoose = 2 THEN RUN cargoRead.p.
                    ELSE IF v-subchoose = 3 THEN RUN cargoUpd.p.
                    ELSE IF v-subchoose = 4 THEN RUN cargoDel.p.
                END.
            END.
            
            ELSE IF v-choose = 4 THEN DO:
                CHOOSE FIELD submenu4 AUTO-RETURN WITH FRAME f-submenu4.
                v-subchoose = FRAME-INDEX.
                HIDE FRAME f-submenu4.
                
                IF LASTKEY <> KEYCODE("ESC") THEN DO:
                    IF v-subchoose = 1 THEN RUN cidadeAdd.p.
                    ELSE IF v-subchoose = 2 THEN RUN cidadeRead.p.
                    ELSE IF v-subchoose = 3 THEN RUN cidadeUpd.p.
                    ELSE IF v-subchoose = 4 THEN RUN cidadeDel.p.
                END.
            END.
            
            ELSE IF v-choose = 5 THEN DO:
                CHOOSE FIELD submenu5 AUTO-RETURN WITH FRAME f-submenu5.
                v-subchoose = FRAME-INDEX.
                HIDE FRAME f-submenu4.
                
                IF LASTKEY <> KEYCODE("ESC") THEN DO:
                    IF v-subchoose = 1 THEN RUN historico.p.
                    ELSE IF v-subchoose = 2 THEN RUN historicoDel.p.
                END.
            END.    
        END.
    END.
END.