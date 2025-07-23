DECLARE
  nuConta NUMBER;
  nuExiste 	NUMBER;
  
	cursor cuDatos(sbCampo VARCHAR2) is
	select count(1)
	  from dba_tab_columns
	 where table_name='RECOFAEL_LOG'
	   and column_name= sbCampo;
	   
BEGIN

 SELECT COUNT(*) INTO nuConta
 FROM dba_tables
 WHERE table_name = 'RECOFAEL_LOG' 
    AND OWNER = 'PERSONALIZACIONES';
  
  IF nuConta = 0 THEN

	   EXECUTE IMMEDIATE 'CREATE TABLE personalizaciones.recofael_log( codigo              		NUMBER(15),
                          tipo_documento_actual	NUMBER(15),
                          tipo_documento_anterior  NUMBER(15),
                          prefijo_actual           VARCHAR2(30),
                          prefijo_anterior         VARCHAR2(30),
                          resolucion_actual        VARCHAR2(40),
                          resolucion_anterior      VARCHAR2(40),
                          cons_inicial_actual      NUMBER(20),
                          cons_inicial_anterior    NUMBER(20),
                          cons_final_actual        NUMBER(20),
                          cons_final_anterior      NUMBER(20),
                          ultimo_cons_actual       NUMBER(20),
                          ultimo_cons_anterior     NUMBER(20),
                          estado_actual            VARCHAR2(1),
                          estado_anterior          VARCHAR2(1),
                          fecha_resolucion_act     DATE ,
                          fecha_resolucion_ant		 DATE ,
                          fecha_ini_vigencia_act   DATE,
                          fecha_ini_vigencia_ant   DATE,
                          fecha_fin_vigencia_act 	 DATE,
                          fecha_fin_vigencia_ant 	 DATE,
                          operacion                VARCHAR2(1),
                          fecha_registro  			DATE,
                          usuario         			VARCHAR2(50),
                          terminal       			 VARCHAR2(50))';
    EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.recofael_log.codigo IS 'Codigo'#';
    EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.recofael_log.tipo_documento_actual IS 'Tipo de documento actual'#';
    EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.recofael_log.tipo_documento_anterior IS 'Tipo de documento anterior'#';
    EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.recofael_log.prefijo_actual IS 'Prefijo actual'#';
    EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.recofael_log.prefijo_anterior IS 'Prefijo anterior'#';
    EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.recofael_log.resolucion_actual IS 'Resolucion actual'#';
    EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.recofael_log.resolucion_anterior IS 'Resolucion anterior'#';
    EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.recofael_log.cons_inicial_actual IS 'Consecutivo Inicial actual'#';
    EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.recofael_log.cons_inicial_anterior IS 'Consecutivo Inicial anterior'#';
    EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.recofael_log.cons_final_actual IS 'Consecutivo Final actual'#';
    EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.recofael_log.cons_final_anterior IS 'Consecutivo Final anterior'#';
    EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.recofael_log.ultimo_cons_actual IS 'Ultimo Consecutivo actual'#';
    EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.recofael_log.ultimo_cons_anterior IS 'Ultimo Consecutivo anterior'#';
    EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.recofael_log.estado_actual IS 'Estado actual A -Activo I - Inactivo'#';
    EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.recofael_log.estado_anterior IS 'Estado anterior A -Activo I - Inactivo'#';
    EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.recofael_log.fecha_resolucion_act IS 'Fecha de resolucion actual'#';
    EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.recofael_log.fecha_resolucion_ant IS 'Fecha de resolucion anterior'#'; 
    EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.recofael_log.fecha_ini_vigencia_act IS 'Fecha de inicio vigencia actual'#';
    EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.recofael_log.fecha_ini_vigencia_ant IS 'Fecha de inicio vigencia anterior'#'; 
    EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.recofael_log.fecha_fin_vigencia_act IS 'Fecha de fin vigencia actual'#';
    EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.recofael_log.fecha_fin_vigencia_ant IS 'Fecha de fin vigencia anterior'#'; 
    EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.recofael_log.fecha_registro IS 'Fecha de registro'#';
    EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.recofael_log.operacion IS 'Operacion I - Insertar U - Actualizar'#';
    EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.recofael_log.usuario IS 'Usuario'#';
    EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.recofael_log.terminal IS 'Terminal'#';
    EXECUTE IMMEDIATE q'#COMMENT ON TABLE personalizaciones.recofael_log IS 'Log de Resolucion de Consecutivo Facturacion Electronica'#';
	BEGIN
	  pkg_utilidades.prAplicarPermisos('RECOFAEL_LOG','PERSONALIZACIONES');
	END;
  END IF;
  
     -- Agregar Columna Empresa

  	OPEN cuDatos('EMPRESA');
	FETCH cuDatos INTO nuExiste;
	CLOSE cuDatos;

	IF nuExiste = 0 THEN
	
		EXECUTE IMMEDIATE 
		'alter table PERSONALIZACIONES.RECOFAEL_LOG
		add(
			"EMPRESA" VARCHAR2(10)
			)';


		   EXECUTE IMMEDIATE 'COMMENT ON COLUMN PERSONALIZACIONES.RECOFAEL_LOG.EMPRESA IS ' || '''' || 'Empresa'|| '''';

  
	END IF;
	
  
END;
/