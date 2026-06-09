/*DEF FRAME f-relatorio WITH TITLE "RELATORIO" CENTERED
    SIDE-LABELS.

FOR EACH cargo BREAK BY idCargo:
    IF FIRST-OF(idCargo)
    THEN DISPLAY idCargo WITH FRAME f-relatorio.
    DISPLAY nome WITH FRAME f-relatorio.
END.*/