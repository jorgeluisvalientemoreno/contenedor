DECLARE
   nuConta NUMBER;
BEGIN

    SELECT COUNT(*) INTO nuConta
    FROM dba_tables
    WHERE table_name = 'CONT_EXCL_FACT_ELECT' 
      AND owner = 'PERSONALIZACIONES';

    IF nuConta = 0 THEN

        EXECUTE IMMEDIATE 'CREATE TABLE personalizaciones.CONT_EXCL_FACT_ELECT 
                           ( 
                               contrato_id      NUMBER(15,0) NOT NULL,
                               fecha_inicial    DATE NOT NULL,
                               fecha_final      DATE NOT NULL
                           )';
                                                                                  
        EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.CONT_EXCL_FACT_ELECT.contrato_id IS 'CODIGO DEL CONTRATO'#';
        EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.CONT_EXCL_FACT_ELECT.fecha_inicial IS 'FECHA EN QUE SE INICIA LA EXCLUSION O BLOQUEO DEL CONTRATO'#';
        EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.CONT_EXCL_FACT_ELECT.fecha_final IS 'FECHA EN QUE SE TERMINA LA EXCLUSION O BLOQUEO DEL CONTRATO'#';
        EXECUTE IMMEDIATE q'#COMMENT ON TABLE  personalizaciones.CONT_EXCL_FACT_ELECT IS 'CONTRATOS EXCLUIDOS O BLOQUEADOS DE LA FACTURACION ELECTRONICA DIAN'#';
        
        EXECUTE IMMEDIATE 'CREATE INDEX idx_CONT_EXCL_FACT_ELECT01 ON personalizaciones.CONT_EXCL_FACT_ELECT(contrato_id)';
          
        BEGIN
           pkg_utilidades.prAplicarPermisos('CONT_EXCL_FACT_ELECT', 'PERSONALIZACIONES');
        END;
    
    END IF;
END;
/