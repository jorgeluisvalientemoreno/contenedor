DECLARE
  nuConta NUMBER;
BEGIN

 SELECT COUNT(*) INTO nuConta
 FROM dba_tables
 WHERE table_name = 'FACTURAS_EMITIDAS' 
    AND OWNER = 'PERSONALIZACIONES';
  
  IF nuConta = 0 THEN

	EXECUTE IMMEDIATE 'CREATE TABLE personalizaciones.facturas_emitidas ( codigo_lote           number(15) not null,    
                                                   tipo_documento        number(15) not null,
                                                   documento             number(15) not null,
                                                   factura_electronica   varchar2(100) not null,
												   												 fecha_emision         date) TABLESPACE TSD_FCONSUMOS';
  EXECUTE IMMEDIATE q'#ALTER TABLE personalizaciones.facturas_emitidas ADD CONSTRAINT PK_facturas_emitidas PRIMARY KEY (codigo_lote, tipo_documento, documento) USING INDEX TABLESPACE TSI_FCONSUMOS#';
  
	EXECUTE IMMEDIATE q'#COMMENT ON COLUMN  personalizaciones.facturas_emitidas.codigo_lote IS  'CODIGO DE LOTE'#';
	EXECUTE IMMEDIATE q'#COMMENT ON COLUMN  personalizaciones.facturas_emitidas.tipo_documento IS  'TIPO DE DOCUMENTO'#';
	EXECUTE IMMEDIATE q'#COMMENT ON COLUMN  personalizaciones.facturas_emitidas.documento IS  'CODIGO DEL DOCUMENTO'#';
	EXECUTE IMMEDIATE q'#COMMENT ON COLUMN  personalizaciones.facturas_emitidas.factura_electronica IS  'Factura electronica'#';
	EXECUTE IMMEDIATE q'#COMMENT ON COLUMN  personalizaciones.facturas_emitidas.fecha_emision IS  'Fecha de registro factura'#';
	EXECUTE IMMEDIATE q'#COMMENT ON TABLE   facturas_emitidas IS  'Documentos emitidos a la Dian'#';
			
	BEGIN
	  pkg_utilidades.prAplicarPermisos('FACTURAS_EMITIDAS','PERSONALIZACIONES');
	END;
  END IF;
END;
/