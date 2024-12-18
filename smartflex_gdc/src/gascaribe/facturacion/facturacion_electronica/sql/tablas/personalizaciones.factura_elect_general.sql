DECLARE
  nuConta NUMBER;
BEGIN

 SELECT COUNT(*) INTO nuConta
 FROM dba_tables
 WHERE table_name = 'FACTURA_ELECT_GENERAL' 
    AND OWNER = 'PERSONALIZACIONES';
  
  IF nuConta = 0 THEN

	EXECUTE IMMEDIATE 'CREATE TABLE personalizaciones.FACTURA_ELECT_GENERAL (codigo_lote       NUMBER(15) NOT NULL,
																			 tipo_documento    NUMBER(15) NOT NULL,
																			 consfael          VARCHAR2(50) NOT NULL,
																			 contrato          NUMBER(15),                                                                             
                                       documento         NUMBER(15) NOT NULL,																			 
                                       estado            NUMBER(1),
                                       fecha_registro    DATE,														
                                       texto_enviado      CLOB,
																			 texto_contigencia  CLOB,
																			 factura_electronica VARCHAR2(100),
																			 texto_spool				 CLOB,
																			 emitir_factura      VARCHAR2(1),
																			 ruta_reparto      VARCHAR2(50) ) TABLESPACE TSD_FCONSUMOS';
  EXECUTE IMMEDIATE q'#ALTER TABLE personalizaciones.FACTURA_ELECT_GENERAL ADD CONSTRAINT pk_factura_elect_general PRIMARY KEY(codigo_lote, tipo_documento, consfael ) USING INDEX TABLESPACE TSI_FCONSUMOS#';
  EXECUTE IMMEDIATE q'#ALTER TABLE personalizaciones.factura_elect_general ADD CONSTRAINT fk_factura_elect_gen_lote  FOREIGN KEY (codigo_lote ) REFERENCES lote_fact_electronica(codigo_lote)#';

	EXECUTE IMMEDIATE q'#CREATE INDEX personalizaciones.idx_factura_elect_general01 ON personalizaciones.FACTURA_ELECT_GENERAL (codigo_lote, estado, ruta_reparto) tablespace TSI_FCONSUMOS#';
	EXECUTE IMMEDIATE q'#CREATE INDEX personalizaciones.idx_factura_elect_general02 ON personalizaciones.FACTURA_ELECT_GENERAL (consfael) tablespace TSI_FCONSUMOS#';
	EXECUTE IMMEDIATE q'#CREATE UNIQUE INDEX personalizaciones.ux_factura_elect_general ON personalizaciones.FACTURA_ELECT_GENERAL (tipo_documento, documento) tablespace TSI_FCONSUMOS#';
	EXECUTE IMMEDIATE q'#CREATE INDEX personalizaciones.idx_factura_elect_general03 ON personalizaciones.FACTURA_ELECT_GENERAL (codigo_lote, tipo_documento, documento) tablespace TSI_FCONSUMOS#';
	EXECUTE IMMEDIATE q'#CREATE INDEX personalizaciones.idx_factura_elect_general04 ON personalizaciones.FACTURA_ELECT_GENERAL (factura_electronica) tablespace TSI_FCONSUMOS#';
	EXECUTE IMMEDIATE q'#CREATE INDEX personalizaciones.idx_factura_elect_general05 ON personalizaciones.FACTURA_ELECT_GENERAL (codigo_lote) tablespace TSI_FCONSUMOS#';
	EXECUTE IMMEDIATE q'#CREATE INDEX personalizaciones.idx_factura_elect_general06 ON personalizaciones.factura_elect_general(codigo_lote, tipo_documento, documento,emitir_factura ) tablespace TSI_FCONSUMOS#';

	EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.FACTURA_ELECT_GENERAL.codigo_lote IS 'CODIGO DE LOTE'#';
	EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.FACTURA_ELECT_GENERAL.tipo_documento IS 'TIPO DE DOCUMENTO'#';
	EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.FACTURA_ELECT_GENERAL.contrato IS 'CONTRATO'#';
	EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.FACTURA_ELECT_GENERAL.consfael IS 'CONSECUTIVO DE FACTURACION ELECTRONICA (SECUENCIA SEQ_CONSECUTIVOFAEL)'#';
	EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.FACTURA_ELECT_GENERAL.documento IS 'CODIGO DEL DOCUMENTO'#';
	EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.FACTURA_ELECT_GENERAL.estado   IS 'ESTADO (1- REGISTRADO, 2 -ENVIADO , 3-ENVIADO CON ERROR, 4 - PROCESADO, 5 - PROCESADO CON ERROR)'#';
	EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.FACTURA_ELECT_GENERAL.fecha_registro IS 'FECHA DE REGISTRO'#';
	EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.FACTURA_ELECT_GENERAL.texto_enviado IS 'TEXTO ENVIADO OSF'#';
  EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.FACTURA_ELECT_GENERAL.texto_contigencia IS 'TEXTO CONTIGENICA OSF'#';
  EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.FACTURA_ELECT_GENERAL.ruta_reparto IS 'RUTA DE REPARTO'#';
	EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.factura_elect_general.factura_electronica IS 'Factura electronica'#';
	EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.factura_elect_general.texto_spool IS 'Texto del spool'#';
	EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.factura_elect_general.emitir_factura IS 'Indica si factura se debe o no emitir a la Dian S/N'#';
	EXECUTE IMMEDIATE q'#COMMENT ON TABLE  personalizaciones.FACTURA_ELECT_GENERAL IS 'FACTURACION ELECTRONICA GENERAL'#';
		
	BEGIN
	  pkg_utilidades.prAplicarPermisos('FACTURA_ELECT_GENERAL','PERSONALIZACIONES');
	END;
  END IF;

	SELECT COUNT(*) INTO nuConta
  FROM DBA_INDEXES
  WHERE INDEX_NAME = 'IDX_FACTURA_ELECT_GENERAL06'
    AND owner = 'PERSONALIZACIONES';

	IF nuConta =  0 THEN
     	EXECUTE IMMEDIATE q'#CREATE INDEX personalizaciones.idx_factura_elect_general06 ON personalizaciones.factura_elect_general(codigo_lote, tipo_documento, documento,emitir_factura ) tablespace TSI_FCONSUMOS#';
	END IF;	
END;
/