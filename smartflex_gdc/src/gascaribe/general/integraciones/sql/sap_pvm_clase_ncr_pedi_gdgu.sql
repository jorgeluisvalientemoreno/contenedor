BEGIN
    -- OSF-4290
    MERGE INTO OPEN.LDCI_CARASEWE A USING
     (SELECT
      'SAP_PVM_CLASE_NCR_PEDI_GDGU' as CASECODI,
      'CLASE PEDIDO NOTA CREDITO GDGU' as CASEDESC,
      'ZRCB' as CASEVALO,
      'WS_FACELEC_EMI_COMIBRILLA' as CASEDESE
      FROM DUAL) B
    ON (A.CASECODI = B.CASECODI and A.CASEDESE = B.CASEDESE)
    WHEN NOT MATCHED THEN 
    INSERT (
      CASECODI, CASEDESC, CASEVALO, CASEDESE)
    VALUES (
      B.CASECODI, B.CASEDESC, B.CASEVALO, B.CASEDESE)
    WHEN MATCHED THEN
    UPDATE SET 
      A.CASEDESC = B.CASEDESC,
      A.CASEVALO = B.CASEVALO;

    COMMIT;
END;
/