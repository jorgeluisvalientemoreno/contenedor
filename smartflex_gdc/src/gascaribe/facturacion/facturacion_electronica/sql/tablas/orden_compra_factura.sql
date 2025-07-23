DECLARE
  nuConta NUMBER;
BEGIN

 SELECT COUNT(*) INTO nuConta
 FROM dba_tables
 WHERE table_name = 'ORDEN_COMPRA_FACTURA' 
    AND OWNER = 'OPEN';
  
  IF nuConta = 0 THEN
		EXECUTE IMMEDIATE 'CREATE TABLE orden_compra_factura ( orden_compra VARCHAR2(100) NOT NULL,
                                    factura NUMBER(15) NOT NULL,  
                                    fecha_registro DATE) TABLESPACE TSD_DEFAULT';
		EXECUTE IMMEDIATE 'ALTER TABLE orden_compra_factura ADD CONSTRAINT PK_ORDEN_COMPRA_FACTURA PRIMARY KEY (factura) USING INDEX TABLESPACE TSI_DEFAULT';
		EXECUTE IMMEDIATE q'#COMMENT ON COLUMN orden_compra_factura.orden_compra IS 'Orden de Compra'#';
		EXECUTE IMMEDIATE q'#COMMENT ON COLUMN orden_compra_factura.factura IS 'Factura'#';
		EXECUTE IMMEDIATE q'#COMMENT ON COLUMN orden_compra_factura.fecha_registro IS 'Fecha Registro'#';
		EXECUTE IMMEDIATE q'#COMMENT ON TABLE orden_compra_factura  IS 'Orden de Compra por Factura'#';
	
			
		BEGIN
			pkg_utilidades.prAplicarPermisos('ORDEN_COMPRA_FACTURA','OPEN');
		END;
  END IF;

END;
/