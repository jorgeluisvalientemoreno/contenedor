begin

INSERT INTO LDCI_DEFISEWE (DESECODI, DESEDESC, DESEJOB) VALUES ('WS_GIS_ACTUALIZA_CATEG_SUBCA', 'WS QUE ACTUALIZA CATEGORIA Y SUBCATEGORIA DE CONTRATO EN GIS', '');
COMMIT;

INSERT INTO LDCI_CARASEWE (CASECODI, CASEDESC, CASEVALO, CASEDESE) VALUES ('CONTENT_TYPE', 'CONTENT-TYPE DEL SERVICIO', 'application/json', 'WS_GIS_ACTUALIZA_CATEG_SUBCA');
INSERT INTO LDCI_CARASEWE (CASECODI, CASEDESC, CASEVALO, CASEDESE) VALUES ('DATA', 'EXPRESION REGULAR DE DATA EN JSON', '"data":\{(.+?)}', 'WS_GIS_ACTUALIZA_CATEG_SUBCA');
INSERT INTO LDCI_CARASEWE (CASECODI, CASEDESC, CASEVALO, CASEDESE) VALUES ('HOST', 'SERVIDOR', '10148252148', 'WS_GIS_ACTUALIZA_CATEG_SUBCA');
INSERT INTO LDCI_CARASEWE (CASECODI, CASEDESC, CASEVALO, CASEDESE) VALUES ('METODO', 'METODO DEL SERVICIO', 'POST', 'WS_GIS_ACTUALIZA_CATEG_SUBCA');
INSERT INTO LDCI_CARASEWE (CASECODI, CASEDESC, CASEVALO, CASEDESE) VALUES ('PROTOCOLO', 'PROTOCOLO', 'HTTP', 'WS_GIS_ACTUALIZA_CATEG_SUBCA');
INSERT INTO LDCI_CARASEWE (CASECODI, CASEDESC, CASEVALO, CASEDESE) VALUES ('PUERTO', 'PUERTO', '80', 'WS_GIS_ACTUALIZA_CATEG_SUBCA');
INSERT INTO LDCI_CARASEWE (CASECODI, CASEDESC, CASEVALO, CASEDESE) VALUES ('STATUS', 'EXPRESION REGULAR DE STATUS EN JSON', '"status":"(.+?)"', 'WS_GIS_ACTUALIZA_CATEG_SUBCA');
INSERT INTO LDCI_CARASEWE (CASECODI, CASEDESC, CASEVALO, CASEDESE) VALUES ('STATUS_ERROR', 'ESTADO DE ERROR EN JSON', 'ERROR', 'WS_GIS_ACTUALIZA_CATEG_SUBCA');
INSERT INTO LDCI_CARASEWE (CASECODI, CASEDESC, CASEVALO, CASEDESE) VALUES ('WSURL', 'URL DEL SERVICIO', 'integratorqa/gis/categoryAndSubcategoryChange/v1', 'WS_GIS_ACTUALIZA_CATEG_SUBCA');

COMMIT;
end;
/