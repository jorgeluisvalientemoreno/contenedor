DECLARE
  nuConta NUMBER;
BEGIN

 SELECT COUNT(*) INTO nuConta
 FROM dba_tables
 WHERE table_name = 'CONTRATOS_OMITIR_NIT_GENERICO' 
    AND OWNER = 'OPEN';
  
  IF nuConta = 0 THEN
		EXECUTE IMMEDIATE 'CREATE TABLE contratos_omitir_nit_generico( CONTRATO NUMBER(10) NOT NULL ) TABLESPACE TSD_DEFAULT';
		EXECUTE IMMEDIATE 'ALTER TABLE contratos_omitir_nit_generico ADD CONSTRAINT pk_contratos_omitir_nit_gene PRIMARY KEY (contrato) USING INDEX TABLESPACE TSI_DEFAULT';
	  EXECUTE IMMEDIATE 'ALTER TABLE contratos_omitir_nit_generico ADD CONSTRAINT fk_contrato_mnitgene_suscripc  FOREIGN KEY (contrato) REFERENCES suscripc(susccodi)';
		EXECUTE IMMEDIATE q'#COMMENT ON COLUMN contratos_omitir_nit_generico.contrato IS 'Numero de contrato'#';
		EXECUTE IMMEDIATE q'#COMMENT ON TABLE contratos_omitir_nit_generico IS 'Contratos para Omitir Cedula Genérica'#';
		
			
		BEGIN
			pkg_utilidades.prAplicarPermisos('CONTRATOS_OMITIR_NIT_GENERICO','OPEN');
		END;
  END IF;

END;
/