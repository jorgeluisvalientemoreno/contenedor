prompt "Creando la tabla multiempresa.auditoria_contrato"
declare

    -- OSF-3956
    sbSentencia     VARCHAR2(32767);

    sbTabla         VARCHAR2(30)    := 'AUDITORIA_CONTRATO'; 
    sbEsquema       VARCHAR2(30)    := 'MULTIEMPRESA';    

    CURSOR CU_DBA_TABLES
    (
        isbTabla    VARCHAR2,
        isbEsquema  VARCHAR2
    ) IS
    SELECT TABLE_NAME 
    FROM DBA_TABLES 
    WHERE TABLE_NAME = isbTabla 
    AND OWNER = isbEsquema;
    
    rcDBA_TABLES CU_DBA_TABLES%ROWTYPE;
    
    PROCEDURE pExecImm( isbSent VARCHAR2) IS
    BEGIN
    
        EXECUTE IMMEDIATE isbSent;

        DBMS_OUTPUT.PUT_LINE( 'INFO:Ok[' || sbSentencia || ']');
            
        EXCEPTION WHEN OTHERS THEN        
            DBMS_OUTPUT.PUT_LINE( 'ERROR[' || isbSent || '][' || sqlerrm || ']' );
            RAISE;
        
    END pExecImm;
        
    PROCEDURE pCreaComenColumna
    (
        isbColumna      VARCHAR2,
        isbComentario   VARCHAR2
    )
    IS
    BEGIN
    
        sbSentencia :=  'COMMENT ON COLUMN ' || sbEsquema || '.' ||sbTabla || '.' || isbColumna || ' IS ' || '''' || isbComentario || '''';
        pExecImm( sbSentencia  );    
        
    END pCreaComenColumna;

begin

    OPEN    CU_DBA_TABLES( sbTabla, sbEsquema);
    FETCH   CU_DBA_TABLES INTO rcDBA_TABLES;
    CLOSE   CU_DBA_TABLES;
    
    IF rcDBA_TABLES.TABLE_NAME IS NULL THEN
        
        sbSentencia := NULL;
    
        sbSentencia := sbSentencia || 'CREATE TABLE ' || sbEsquema || '.' || sbTabla || CHR(10);
        sbSentencia := sbSentencia || '(' || CHR(10);
        sbSentencia := sbSentencia || 'CONTRATO                 NUMBER(15),' || CHR(10);
        sbSentencia := sbSentencia || 'EVENTO                   VARCHAR2(15),' || CHR(10);        
        sbSentencia := sbSentencia || 'EMPRESA_ANTERIOR         VARCHAR2(10),' || CHR(10);
        sbSentencia := sbSentencia || 'EMPRESA_NUEVA            VARCHAR2(10),' || CHR(10);
        sbSentencia := sbSentencia || 'USUARIO                  VARCHAR2(30),' || CHR(10);  
        sbSentencia := sbSentencia || 'TERMINAL                 VARCHAR2(30),' || CHR(10);
        sbSentencia := sbSentencia || 'FECHA_EVENTO             DATE DEFAULT SYSDATE)' || CHR(10);
        sbSentencia := sbSentencia || 'TABLESPACE TSD_MULTI_M' || CHR(10);        
		
        pExecImm( sbSentencia  );

        sbSentencia :=  'COMMENT ON TABLE ' || sbEsquema || '.' ||sbTabla || ' IS ' || '''' || 'Auditoría de Contratos por empresa' || '''';
        pExecImm( sbSentencia  );

        pCreaComenColumna('CONTRATO','Código del contrato');
        pCreaComenColumna('EVENTO','INSERT,UPDATE,DELETE');
        pCreaComenColumna('EMPRESA_ANTERIOR','Código de la empresa antes del evento: GDCA o GDGU');
        pCreaComenColumna('EMPRESA_NUEVA','Código de la empresa después del evento: GDCA o GDGU');
        pCreaComenColumna('USUARIO','Usuario que ejecuta el evento');
        pCreaComenColumna('TERMINAL','Terminal desde el cual se ejecuta el evento');
        pCreaComenColumna('FECHA_EVENTO','Fecha y hora en la cual se ejecuta el evento');
		       
    ELSE
        
        DBMS_OUTPUT.PUT_LINE( 'Ya existe la tabla '|| sbEsquema || '.' || sbTabla );
        
    END IF;
     
END;
/
