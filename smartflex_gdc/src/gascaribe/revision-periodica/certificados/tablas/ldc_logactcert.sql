DECLARE
	nuConta number;
BEGIN
	SELECT 	COUNT(1) 
	INTO 	nuConta
	FROM 	dba_tables
	WHERE 	table_name = 'LDC_LOGACTCERT';
  
	IF (nuConta = 0) THEN
		EXECUTE IMMEDIATE 'CREATE TABLE LDC_LOGACTCERT( 
														LOGACTCERT_ID 		NUMBER(15) PRIMARY KEY,
														NOMBRE_ARCHIVO  	VARCHAR2(100),
														LINEA  				VARCHAR2(100),
														CERTIFICADOS_OIA_ID NUMBER(15),
														ID_CONTRATO  		NUMBER(15),
														CERTIFICADO_ACTUAL  VARCHAR2(100),
														CERTIFICADO_NUEVO  	VARCHAR2(100),
														OBSERVACION  		VARCHAR2(200),
														FECHA  				DATE,
														ESTADO  			VARCHAR2(100)
														)';

		EXECUTE IMMEDIATE 'CREATE INDEX IDX_LDC_LOGACTCERT_01 ON LDC_LOGACTCERT(CERTIFICADOS_OIA_ID)';
		EXECUTE IMMEDIATE 'CREATE INDEX IDX_LDC_LOGACTCERT_02 ON LDC_LOGACTCERT(ID_CONTRATO)';
		EXECUTE IMMEDIATE 'CREATE INDEX IDX_LDC_LOGACTCERT_03 ON LDC_LOGACTCERT(FECHA)';

		EXECUTE IMMEDIATE 'COMMENT ON COLUMN LDC_LOGACTCERT.LOGACTCERT_ID 		IS ''IDENTIFICADOR''';
		EXECUTE IMMEDIATE 'COMMENT ON COLUMN LDC_LOGACTCERT.NOMBRE_ARCHIVO  	IS ''NOMBRE DEL ARCHIVO PROCESADO''';
		EXECUTE IMMEDIATE 'COMMENT ON COLUMN LDC_LOGACTCERT.LINEA  				IS ''LINEA PROCESADA''';
		EXECUTE IMMEDIATE 'COMMENT ON COLUMN LDC_LOGACTCERT.CERTIFICADOS_OIA_ID IS ''IDENTIFICADOR DEL CERTIFICADO OIA''';
		EXECUTE IMMEDIATE 'COMMENT ON COLUMN LDC_LOGACTCERT.ID_CONTRATO  		IS ''CONTRATO''';
		EXECUTE IMMEDIATE 'COMMENT ON COLUMN LDC_LOGACTCERT.CERTIFICADO_ACTUAL  IS ''CERTIFICADO ACTUAL''';
		EXECUTE IMMEDIATE 'COMMENT ON COLUMN LDC_LOGACTCERT.CERTIFICADO_NUEVO   IS ''CERTIFICADO NUEVO''';
		EXECUTE IMMEDIATE 'COMMENT ON COLUMN LDC_LOGACTCERT.OBSERVACION  		IS ''OBSERVACION INGRESADA''';
		EXECUTE IMMEDIATE 'COMMENT ON COLUMN LDC_LOGACTCERT.FECHA  				IS ''FECHA EN QUE SE PROCESO EL CERTIFICADO''';
		EXECUTE IMMEDIATE 'COMMENT ON COLUMN LDC_LOGACTCERT.ESTADO  			IS ''ESTADO DE LA LINEA PROCESADA''';
		EXECUTE IMMEDIATE 'COMMENT ON TABLE LDC_LOGACTCERT 						IS ''LOG DE LOS REGISTROS DEL PROCESO LDCACTCERT''';
	
	END IF;
	
	SELECT 	COUNT(1) 
	INTO 	nuConta
	FROM 	ALL_TAB_COLUMNS
	WHERE 	table_name = 'LDC_LOGACTCERT'
	AND 	column_name = 'USUARIO';
	
	IF (nuConta = 0) THEN
		EXECUTE IMMEDIATE 'ALTER TABLE LDC_LOGACTCERT ADD USUARIO VARCHAR2(100)';
	END IF;
	
	SELECT 	COUNT(1) 
	INTO 	nuConta
	FROM 	ALL_TAB_COLUMNS
	WHERE 	table_name = 'LDC_LOGACTCERT'
	AND 	column_name = 'TERMINAL';
	
	IF (nuConta = 0) THEN
		EXECUTE IMMEDIATE 'ALTER TABLE LDC_LOGACTCERT ADD TERMINAL VARCHAR2(100)';
	END IF;
  
	EXECUTE IMMEDIATE 'grant select, insert, delete, update on LDC_LOGACTCERT to SYSTEM_OBJ_PRIVS_ROLE';
	EXECUTE IMMEDIATE 'grant select on LDC_LOGACTCERT to RSELOPEN';
	EXECUTE IMMEDIATE 'grant select on LDC_LOGACTCERT to reportes';
END;
/