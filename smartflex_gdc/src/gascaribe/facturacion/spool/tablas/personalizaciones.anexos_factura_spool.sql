DECLARE
  nuConta NUMBER;
BEGIN

 SELECT COUNT(*) INTO nuConta
 FROM dba_tables
 WHERE table_name = 'ANEXOS_FACTURA_HELIO' 
    AND OWNER = 'PERSONALIZACIONES';
  
  IF nuConta = 1 THEN
		 EXECUTE IMMEDIATE 'alter table personalizaciones.anexos_factura_helio rename to anexos_factura_spool';
		 
     EXECUTE IMMEDIATE 'GRANT SELECT, INSERT, UPDATE, DELETE ON personalizaciones.ANEXOS_FACTURA_SPOOL TO ROLE_APPFACTURACION_ELECTRONIK';

		BEGIN
			pkg_utilidades.prAplicarPermisos('ANEXOS_FACTURA_SPOOL','PERSONALIZACIONES');
		END;

    
  END IF;

END;
/