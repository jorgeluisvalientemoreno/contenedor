DECLARE
  nuConta NUMBER;
BEGIN

 SELECT COUNT(*) INTO nuConta
 FROM dba_tables
 WHERE table_name = 'LOG_PARAMETROS' 
    AND OWNER = 'PERSONALIZACIONES';
  
  IF nuConta = 0 THEN 
 
	 EXECUTE IMMEDIATE 'CREATE TABLE personalizaciones.LOG_PARAMETROS 
						   (	CODIGO VARCHAR2(100 BYTE), 
							VALOR_NUMERICO_ACTUAL NUMBER(20,5), 
							VALOR_NUMERICO_ANTE NUMBER(20,5), 
							VALOR_CADENA_ACTUAL VARCHAR2(4000 BYTE), 
							VALOR_CADENA_ANTE VARCHAR2(4000 BYTE), 
							VALOR_FECHA_ACTUAL DATE, 
							VALOR_FECHA_ANTE DATE,
							PROCESO_ACTUAL NUMBER(15,0), 
							PROCESO_ANTE NUMBER(15,0), 
							ESTADO_ACTUAL VARCHAR2(1) DEFAULT ''A'',
							ESTADO_ANTE VARCHAR2(1) DEFAULT ''A'',
							OBLIGATORIO_ACTUAL VARCHAR2(1) DEFAULT ''S'',
							OBLIGATORIO_ANTE VARCHAR2(1) DEFAULT ''S'',
							OPERACION  VARCHAR2(1),
							FECHA_REGISTRO DATE, 
							USUARIO VARCHAR2(400 BYTE), 
							TERMINAL VARCHAR2(400 BYTE)) TABLESPACE TSD_LOGS';

   EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.LOG_PARAMETROS.CODIGO IS 'CODIGO DEL PARAMETRO'#';
   EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.LOG_PARAMETROS.VALOR_NUMERICO_ACTUAL IS 'VALOR NUMERICO ACTUAL'#';
   EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.LOG_PARAMETROS.VALOR_NUMERICO_ANTE IS 'VALOR NUMERICO ANTERIOR'#';
   EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.LOG_PARAMETROS.VALOR_CADENA_ACTUAL IS 'VALOR CADENA ACTUAL'#';
   EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.LOG_PARAMETROS.VALOR_CADENA_ANTE IS 'VALOR CADENA ANTERIOR'#';
   EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.LOG_PARAMETROS.VALOR_FECHA_ACTUAL IS 'VALOR FECHA ACTUAL'#';
   EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.LOG_PARAMETROS.VALOR_FECHA_ANTE  IS 'VALOR FECHA ANTERIOR'#';
   EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.LOG_PARAMETROS.PROCESO_ACTUAL IS 'PROCESO ACTUAL'#';
   EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.LOG_PARAMETROS.PROCESO_ANTE IS 'PROCESO ANTERIOR'#';
   EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.LOG_PARAMETROS.ESTADO_ACTUAL IS 'ESTADO DEL REGISTRO ACTUAL'#';
   EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.LOG_PARAMETROS.ESTADO_ANTE IS 'ESTADO DEL REGISTRO ANTERIOR'#';
   EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.LOG_PARAMETROS.OBLIGATORIO_ACTUAL IS 'OBLIGATORIO ACTUAL'#';
   EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.LOG_PARAMETROS.OBLIGATORIO_ANTE IS 'OBLIGATORIO ANTERIOR'#';
   EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.LOG_PARAMETROS.OPERACION IS 'OPERACION I - INSERTAR, U - ACTUALIZAR, D - ELIMINAR'#';
   EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.LOG_PARAMETROS.FECHA_REGISTRO IS 'FECHA DE REGISTRO'#';
   EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.LOG_PARAMETROS.USUARIO IS 'USUARIO'#';
   EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.LOG_PARAMETROS.TERMINAL IS 'TERMINAL'#';
   EXECUTE IMMEDIATE q'#COMMENT ON TABLE personalizaciones.LOG_PARAMETROS  IS 'LOG DE PARAMETROS PERSONALIZADOS DEL SISTEMA'#';
   
   BEGIN
	  pkg_utilidades.prAplicarPermisos('LOG_PARAMETROS','PERSONALIZACIONES');
   END;

  END IF;

END;
/