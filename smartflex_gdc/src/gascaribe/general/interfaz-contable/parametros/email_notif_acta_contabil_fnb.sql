BEGIN
    MERGE INTO LDCI_CARASEWE A
    USING 
    (
        SELECT 'EMAIL_NOTIF_ACTA_CONTABIL_FNB'                          as CASECODI,
           'CORREOS PARA NOTIFICAR CONTABILIZACION AUTOM. ACTAS BRILLA' as CASEDESC,
           'ldominguez@gascaribe.com;finsignares@gascaribe.com'         as CASEVALO,
           'WS_INTER_CONTABLE'                                          as CASEDESE
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
