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
    
    ut_trace.trace(isbmessage => '[ Creacion de tabla LDC_TIPCAUS_IMPAPAR', inulevel => 1); 
    
    OPEN cuTabla('LDC_TIPCAUS_IMPAPAR');
    FETCH cuTabla
        INTO nuControl;
    CLOSE cuTabla;

    IF nuControl != 0
    THEN
       RETURN;
    END IF;

    EXECUTE IMMEDIATE 'CREATE TABLE LDC_TIPCAUS_IMPAPAR 
                                                       (
                                                        CODIGO      NUMBER(15) NOT NULL,
                                                        DESCRIPCION VARCHAR2(300) NOT NULL,
                                                        ACTIVO      VARCHAR2(1) DEFAULT ''Y'' NOT NULL 
                                                       )';

    EXECUTE IMMEDIATE 'COMMENT ON TABLE LDC_TIPCAUS_IMPAPAR IS ''Configuracion tipos de causales para impresion de pagos parciales''';
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN LDC_TIPCAUS_IMPAPAR.CODIGO IS ''Codigo del tipo de causal''';
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN LDC_TIPCAUS_IMPAPAR.DESCRIPCION IS ''Descripcion del tipo de causal''';
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN LDC_TIPCAUS_IMPAPAR.ACTIVO IS ''Registro activo?''';

    EXECUTE IMMEDIATE 'ALTER TABLE LDC_TIPCAUS_IMPAPAR ADD CONSTRAINT PK_LDC_TIPCAUS_IMPAPAR PRIMARY KEY (CODIGO)';
	EXECUTE IMMEDIATE 'ALTER TABLE LDC_TIPCAUS_IMPAPAR ADD CONSTRAINT CK_LDC_TIPCAUS_IMPAPAR CHECK(ACTIVO IN(''Y'',''N''))';
    EXECUTE IMMEDIATE 'GRANT SELECT,UPDATE,DELETE,INSERT ON LDC_TIPCAUS_IMPAPAR TO SYSTEM_OBJ_PRIVS_ROLE';
    EXECUTE IMMEDIATE 'GRANT SELECT ON LDC_TIPCAUS_IMPAPAR TO REPORTES';
    EXECUTE IMMEDIATE 'GRANT SELECT ON LDC_TIPCAUS_IMPAPAR TO RSELOPEN';
    
    ut_trace.trace(isbmessage => 'Tabla [LDC_TIPCAUS_IMPAPAR] creada ok!', inulevel => 2); 
    
    ut_trace.trace(isbmessage => '] Creacion de tabla LDC_TIPCAUS_IMPAPAR', inulevel => 1); 
EXCEPTION
    WHEN OTHERS THEN
        Errors.setError;
        errors.geterror(onuerror, osbError);
        dbms_output.put_line('Error: ' || onuerror || ' - ' || osbError);
END;
/
