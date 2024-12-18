BEGIN
    MERGE INTO LDCI_CARASEWE A
    USING 
    (
        SELECT 'TIPO_CONTRATOS_FNB'                        as CASECODI,
               'TIPOS DE CONTRATOS DE FNB'                 as CASEDESC,
               '9,22,870,1450,1570,2150,2190,2370'         as CASEVALO,
               'WS_COSTOS'                                 as CASEDESE
        FROM DUAL
    ) B
    ON (A.CASECODI = B.CASECODI)
    WHEN NOT MATCHED THEN
        INSERT
            (CASECODI,   CASEDESC,   CASEVALO,   CASEDESE)
        VALUES
            (B.CASECODI, B.CASEDESC, B.CASEVALO, B.CASEDESE)
    WHEN MATCHED THEN
        UPDATE set CASEVALO = B.CASEVALO;

    COMMIT;
END;
/