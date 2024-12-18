DECLARE
  nuConta NUMBER;
BEGIN

 SELECT COUNT(*) INTO nuConta
 FROM dba_tables
 WHERE table_name = 'CONTRATOS_OMITIR_NIT_GENE_LOG' 
    AND OWNER = 'PERSONALIZACIONES';
  
  IF nuConta = 0 THEN
		 EXECUTE IMMEDIATE 'CREATE TABLE personalizaciones.contratos_omitir_nit_gene_log ( contrato        NUMBER(10),
                                                                                                                                                    accion          VARCHAR2(1),
                                                                                                                                                    usuario         VARCHAR2(50),
                                                                                                                                                    terminal        VARCHAR2(100),
                                                                                                                                                    fecha_registro  DATE)';
     EXECUTE IMMEDIATE q'#COMMENT ON COLUMN  personalizaciones.contratos_omitir_nit_gene_log.contrato IS 'Numero de contrato'#';
		 EXECUTE IMMEDIATE q'#COMMENT ON COLUMN  personalizaciones.contratos_omitir_nit_gene_log.accion IS 'Accion: I - Insertar, U - Actualizar, D - Eliminar'#';
		 EXECUTE IMMEDIATE q'#COMMENT ON COLUMN  personalizaciones.contratos_omitir_nit_gene_log.usuario IS 'Usuario'#';
		 EXECUTE IMMEDIATE q'#COMMENT ON COLUMN  personalizaciones.contratos_omitir_nit_gene_log.terminal IS 'Terminal'#';
		 EXECUTE IMMEDIATE q'#COMMENT ON COLUMN  personalizaciones.contratos_omitir_nit_gene_log.fecha_registro IS 'Fecha de Registro'#';
		
		 EXECUTE IMMEDIATE q'#COMMENT ON TABLE  personalizaciones.contratos_omitir_nit_gene_log IS 'Log de Excepcion de Contratos para Cedula Generica'#';
			
		BEGIN
			pkg_utilidades.prAplicarPermisos('CONTRATOS_OMITIR_NIT_GENE_LOG','PERSONALIZACIONES');
		END;
  END IF;

END;
/