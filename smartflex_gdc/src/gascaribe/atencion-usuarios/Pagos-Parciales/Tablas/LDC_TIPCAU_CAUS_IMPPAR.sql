DECLARE
    onuerror NUMBER;
    osbError VARCHAR2(200);

    CURSOR cuTabla(sbTable VARCHAR2) IS
        SELECT COUNT(1)
          FROM all_tables
         WHERE upper(TABLE_NAME) = upper(sbTable);

    nuControl NUMBER;
BEGIN
    ut_trace.Init;
    ut_trace.SetOutPut(ut_trace.cnuTRACE_DBMS_OUTPUT);
    ut_trace.SetLevel(2);
    
    ut_trace.trace(isbmessage => '[ Creacion de tabla LDC_TIPCAU_CAUS_IMPPAR', inulevel => 1); 
    
    OPEN cuTabla('LDC_TIPCAU_CAUS_IMPPAR');
    FETCH cuTabla
        INTO nuControl;
    CLOSE cuTabla;

    IF nuControl != 0 THEN
     RETURN;
    END IF;

    EXECUTE IMMEDIATE 'CREATE TABLE LDC_TIPCAU_CAUS_IMPPAR 
                                                          (
                                                           CODIGO          NUMBER(15) NOT NULL,
                                                           COD_TIPO_CAUSAL NUMBER(15) NOT NULL,
                                                           CAUSAL          NUMBER(4)  NOT NULL,
                                                           ACTIVO          VARCHAR2(1) DEFAULT ''Y'' NOT NULL														   
                                                          )';

    EXECUTE IMMEDIATE 'COMMENT ON TABLE LDC_TIPCAU_CAUS_IMPPAR IS ''Configuracion tipos de causales por causal para impresion de pagos parciales''';
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN LDC_TIPCAU_CAUS_IMPPAR.CODIGO IS ''Codigo asociacion tipo causal por causal''';
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN LDC_TIPCAU_CAUS_IMPPAR.COD_TIPO_CAUSAL IS ''Codigo tipo de causal''';
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN LDC_TIPCAU_CAUS_IMPPAR.CAUSAL IS ''Codigo causal''';
	EXECUTE IMMEDIATE 'COMMENT ON COLUMN LDC_TIPCAU_CAUS_IMPPAR.ACTIVO IS ''Registro activo?''';

    EXECUTE IMMEDIATE 'ALTER TABLE LDC_TIPCAU_CAUS_IMPPAR ADD CONSTRAINT PK_LDC_TIPCAU_CAUS_IMPPAR PRIMARY KEY (CODIGO)';
	EXECUTE IMMEDIATE 'ALTER TABLE LDC_TIPCAU_CAUS_IMPPAR ADD CONSTRAINT FK_LDC_TIPCAU_CAUS_IMPPAR FOREIGN KEY (COD_TIPO_CAUSAL) REFERENCES LDC_TIPCAUS_IMPAPAR(CODIGO)';
	EXECUTE IMMEDIATE 'ALTER TABLE LDC_TIPCAU_CAUS_IMPPAR ADD CONSTRAINT FK2_LDC_TIPCAU_CAUS_IMPPAR FOREIGN KEY (CAUSAL) REFERENCES LDC_CAUSALABONOFNB(CODIGO)';
	EXECUTE IMMEDIATE 'ALTER TABLE LDC_TIPCAU_CAUS_IMPPAR ADD CONSTRAINT UK_LDC_TIPCAU_CAUS_IMPPAR UNIQUE (COD_TIPO_CAUSAL,CAUSAL)';
	EXECUTE IMMEDIATE 'ALTER TABLE LDC_TIPCAU_CAUS_IMPPAR ADD CONSTRAINT CK_LDC_TIPCAU_CAUS_IMPPAR CHECK(ACTIVO IN(''Y'',''N''))';
    EXECUTE IMMEDIATE 'GRANT SELECT,UPDATE,DELETE,INSERT ON LDC_TIPCAU_CAUS_IMPPAR TO SYSTEM_OBJ_PRIVS_ROLE';
    EXECUTE IMMEDIATE 'GRANT SELECT ON CK_LDC_TIPCAU_CAUS_IMPPAR TO REPORTES';
    EXECUTE IMMEDIATE 'GRANT SELECT ON CK_LDC_TIPCAU_CAUS_IMPPAR TO RSELOPEN';
    
    ut_trace.trace(isbmessage => 'Tabla [LDC_TIPCAU_CAUS_IMPPAR] creada ok!', inulevel => 2); 
    
    ut_trace.trace(isbmessage => '] Creacion de tabla LDC_TIPCAU_CAUS_IMPPAR', inulevel => 1); 
EXCEPTION
    WHEN OTHERS THEN
        Errors.setError;
        errors.geterror(onuerror, osbError);
        dbms_output.put_line('Error: ' || onuerror || ' - ' || osbError);
END;
/
