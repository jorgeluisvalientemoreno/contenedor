DECLARE
  nuconta number;
BEGIN
  SELECT COUNT(1) INTO nuconta
  FROM DBA_TABLES
  WHERE TABLE_NAME = 'LDC_APPROVED_REQUESTS';
  
  IF nuconta = 0 THEN  
	EXECUTE IMMEDIATE 'CREATE TABLE personalizaciones.LDC_APPROVED_REQUESTS(  
                                                     PACKAGE_ID 			NUMBER(15),
                                                     DATE_APPROVED       DATE,
                                                     OBSERVATION        VARCHAR2(4000),
                                                     USER_PROCESS       VARCHAR2(1000),
                                                     TERMINAL           VARCHAR2(100)
                                                   )';
                                                   
	EXECUTE IMMEDIATE 'CREATE INDEX IDXLDC_APPROVED_REQUESTS01 ON personalizaciones.LDC_APPROVED_REQUESTS(PACKAGE_ID)';
	EXECUTE IMMEDIATE 'CREATE INDEX IDXLDC_APPROVED_REQUESTS02 ON personalizaciones.LDC_APPROVED_REQUESTS(DATE_APPROVED)';
	
	EXECUTE IMMEDIATE 'COMMENT ON COLUMN personalizaciones.LDC_APPROVED_REQUESTS.PACKAGE_ID           IS ''Número de Solicitud''';
	EXECUTE IMMEDIATE 'COMMENT ON COLUMN personalizaciones.LDC_APPROVED_REQUESTS.DATE_APPROVED        IS ''Fecha de aprobación''';
	EXECUTE IMMEDIATE 'COMMENT ON COLUMN personalizaciones.LDC_APPROVED_REQUESTS.OBSERVATION          IS ''Observación''';
	EXECUTE IMMEDIATE 'COMMENT ON COLUMN personalizaciones.LDC_APPROVED_REQUESTS.USER_PROCESS         IS ''Usuario que proceso''';
  EXECUTE IMMEDIATE 'COMMENT ON COLUMN personalizaciones.LDC_APPROVED_REQUESTS.TERMINAL             IS ''Terminal''';
	EXECUTE IMMEDIATE 'COMMENT ON TABLE personalizaciones.LDC_APPROVED_REQUESTS IS ''Proceso de Aprobación de Solicitudes''';
	
  END IF;

	EXECUTE immediate 'grant select, insert, delete, update on personalizaciones.LDC_APPROVED_REQUESTS to SYSTEM_OBJ_PRIVS_ROLE';
	execute immediate 'grant select on personalizaciones.LDC_APPROVED_REQUESTS to RSELOPEN';
	execute immediate 'grant select on personalizaciones.LDC_APPROVED_REQUESTS to reportes';

END;
/