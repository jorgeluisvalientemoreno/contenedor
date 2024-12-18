DECLARE
  nuConta NUMBER;
BEGIN

 SELECT COUNT(*) INTO nuConta
 FROM dba_tables
 WHERE table_name = 'LOTE_FACT_ELECTRONICA' 
    AND OWNER = 'PERSONALIZACIONES';
  
  IF nuConta = 0 THEN

	EXECUTE IMMEDIATE 'CREATE TABLE personalizaciones.LOTE_FACT_ELECTRONICA(  	CODIGO_LOTE       	 NUMBER(15) NOT NULL,
																				 tipo_documento    NUMBER(15) ,
																				PERIODO_FACTURACION  NUMBER(15),
																				ANIO				 NUMBER(4),
																				MES   				 NUMBER(2),
																				CICLO  				 NUMBER(5),
																				CANTIDAD_REGISTRO    NUMBER(20),
																				CANTIDAD_HILOS       NUMBER(2),
																				HILOS_PROCESADO		 NUMBER(2),
																				HILOS_FALLIDO		 NUMBER(2),
																				INTENTOS             NUMBER(2) DEFAULT 0,
																				FLAG_TERMINADO       VARCHAR2(1) DEFAULT ''N'',
																				FECHA_INICIO 		 DATE,
																				FECHA_FIN       	 DATE,
																				FECHA_INICIO_PROC 	 DATE,
																				FECHA_FIN_PROC       DATE) TABLESPACE TSD_FCONSUMOS';
	EXECUTE IMMEDIATE q'#ALTER TABLE personalizaciones.lote_fact_electronica ADD CONSTRAINT PK_LOTE_FACT_ELECTRONICA PRIMARY KEY(codigo_lote ) USING INDEX TABLESPACE TSI_FCONSUMOS#';
	EXECUTE IMMEDIATE q'#CREATE INDEX personalizaciones.idx_lote_fact_electronica01 ON personalizaciones.lote_fact_electronica (anio,mes, ciclo ) TABLESPACE TSI_FCONSUMOS#';
	EXECUTE IMMEDIATE q'#CREATE INDEX personalizaciones.idx_lote_fact_electronica02 ON personalizaciones.lote_fact_electronica (periodo_facturacion ) TABLESPACE TSI_FCONSUMOS#';
	EXECUTE IMMEDIATE q'#CREATE INDEX personalizaciones.idx_lote_fact_electronica03 ON personalizaciones.lote_fact_electronica (periodo_facturacion, flag_terminado, tipo_documento, intentos ) TABLESPACE TSI_FCONSUMOS#';
	EXECUTE IMMEDIATE q'#CREATE INDEX personalizaciones.idx_lote_fact_electronica04 ON personalizaciones.lote_fact_electronica (codigo_lote, periodo_facturacion, flag_terminado, intentos ) TABLESPACE TSI_FCONSUMOS#';
	EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.lote_fact_electronica.codigo_lote IS 'CODIGO DE LOTE'#';
	EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.lote_fact_electronica.tipo_documento IS 'TIPO DE DOCUMENTO'#';
	EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.lote_fact_electronica.periodo_facturacion IS 'periodo de facturacion'#';
	EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.lote_fact_electronica.anio IS 'AÑO DEL PERIODO'#';
	EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.lote_fact_electronica.mes IS 'MES DEL PERIODO'#';
	EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.lote_fact_electronica.ciclo IS 'CICLO DEL PERIODO'#';
	EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.lote_fact_electronica.cantidad_registro IS 'CANTIDAD DE REGISTRO'#';
	EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.lote_fact_electronica.cantidad_hilos IS 'CANTIDAD DE HILOS'#';
	EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.lote_fact_electronica.hilos_procesado IS 'HILOS PROCESADOS'#';
	EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.lote_fact_electronica.hilos_fallido IS 'HILOS FALLIDOS'#';
	EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.lote_fact_electronica.INTENTOS IS 'INTENTOS'#';
	EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.lote_fact_electronica.FLAG_TERMINADO IS 'FLAG QUE INDICA QUE PROCESO TERMINO CON EXITO'#';
	EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.lote_fact_electronica.fecha_inicio IS 'fecha inicio de registro'#';
	EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.lote_fact_electronica.fecha_fin IS 'FECHA FINAL DE REGISTRO'#';
	EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.lote_fact_electronica.fecha_inicio_proc IS 'FECHA INICIO DE PROCESADO'#';
	EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.lote_fact_electronica.fecha_fin_proc IS 'FECHA FINAL DE PROCESADO'#';
  EXECUTE IMMEDIATE q'#COMMENT ON TABLE  personalizaciones.lote_fact_electronica IS 'lote de facturacion electronica general'#';
	
	BEGIN
	  pkg_utilidades.prAplicarPermisos('LOTE_FACT_ELECTRONICA','PERSONALIZACIONES');
	END;
	

  END IF;
END;
/