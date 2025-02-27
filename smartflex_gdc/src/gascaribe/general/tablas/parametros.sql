DECLARE
  nuConta NUMBER;
BEGIN

 SELECT COUNT(*) INTO nuConta
 FROM dba_tables
 WHERE table_name = 'PARAMETROS' 
    AND OWNER = 'OPEN';
  
  IF nuConta = 0 THEN 
 
	 EXECUTE IMMEDIATE 'CREATE TABLE PARAMETROS 
					   (	CODIGO VARCHAR2(100 BYTE) NOT NULL, 
						DESCRIPCION VARCHAR2(500 BYTE) NOT NULL, 
						VALOR_NUMERICO NUMBER(20,5), 
						VALOR_CADENA VARCHAR2(4000 BYTE), 
						VALOR_FECHA DATE, 
						PROCESO NUMBER(15,0) NOT NULL, 
						ESTADO VARCHAR2(1) DEFAULT ''A'',
						OBLIGATORIO VARCHAR2(1) DEFAULT ''S'',
						FECHA_CREACION DATE, 	
						FECHA_ACTUALIZACION DATE, 
						USUARIO VARCHAR2(400 BYTE), 
						TERMINAL VARCHAR2(400 BYTE), 
						
						CONSTRAINT PK_PARAMETROS PRIMARY KEY (CODIGO), 
						CONSTRAINT FK_PARAME_PROCESOS FOREIGN KEY (PROCESO) REFERENCES PROCESO_NEGOCIO (CODIGO) ) tablespace TSD_LOGS';

   EXECUTE IMMEDIATE q'#COMMENT ON COLUMN PARAMETROS.CODIGO IS 'CODIGO DEL PARAMETRO'#';
   EXECUTE IMMEDIATE q'#COMMENT ON COLUMN PARAMETROS.DESCRIPCION IS 'DESCRIPCION DEL PARAMETRO'#';
   EXECUTE IMMEDIATE q'#COMMENT ON COLUMN PARAMETROS.VALOR_NUMERICO IS 'VALOR NUMERICO'#';
   EXECUTE IMMEDIATE q'#COMMENT ON COLUMN PARAMETROS.VALOR_CADENA IS 'VALOR CADENA'#';
   EXECUTE IMMEDIATE q'#COMMENT ON COLUMN PARAMETROS.VALOR_FECHA IS 'VALOR FECHA'#';
   EXECUTE IMMEDIATE q'#COMMENT ON COLUMN PARAMETROS.PROCESO IS 'PROCESO'#';
   EXECUTE IMMEDIATE q'#COMMENT ON COLUMN PARAMETROS.ESTADO IS 'ESTADO DEL REGISTRO A - ACTIVO, I - INACTIVO '#';
   EXECUTE IMMEDIATE q'#COMMENT ON COLUMN PARAMETROS.OBLIGATORIO IS 'OBLIGATORIO TENER VALOR S - SI N - NO '#';
   EXECUTE IMMEDIATE q'#COMMENT ON COLUMN PARAMETROS.FECHA_CREACION IS 'FECHA DE CREACION'#';
   EXECUTE IMMEDIATE q'#COMMENT ON COLUMN PARAMETROS.FECHA_ACTUALIZACION IS 'FECHA DE ULTIMA ACTUALIZACION'#';
   EXECUTE IMMEDIATE q'#COMMENT ON COLUMN PARAMETROS.USUARIO IS 'USUARIO'#';
   EXECUTE IMMEDIATE q'#COMMENT ON COLUMN PARAMETROS.TERMINAL IS 'TERMINAL'#';
   EXECUTE IMMEDIATE q'#COMMENT ON TABLE PARAMETROS  IS 'PARAMETROS PERSONALIZADOS DEL SISTEMA'#';

	BEGIN
	  pkg_utilidades.prAplicarPermisos('PARAMETROS','OPEN');
	END;
  END IF;

END;
/