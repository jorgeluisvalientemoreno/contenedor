DECLARE
  nuConta NUMBER;
BEGIN

 SELECT COUNT(*) INTO nuConta
 FROM dba_tables
 WHERE table_name = 'PERIODO_FACTELECT' 
    AND OWNER = 'PERSONALIZACIONES';
  
  IF nuConta = 0 THEN

    EXECUTE IMMEDIATE 'CREATE TABLE personalizaciones.periodo_factelect ( periodo  NUMBER(15),
                                                                    estado   VARCHAR2(1),
                                                                    observacion VARCHAR2(4000),
                                                                    fecha_registro DATE)';
    EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.periodo_factelect.periodo IS 'PERIODO DE FACTURACION'#';
    EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.periodo_factelect.estado IS 'ESTADO P - PENDIENTE, T - TERMINADO, E - ERROR'#';
    EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.periodo_factelect.observacion IS 'OBSERVACION'#';
    EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.periodo_factelect.fecha_registro   IS 'FECHA DE REGISTRO'#';
    EXECUTE IMMEDIATE q'#COMMENT ON TABLE  personalizaciones.periodo_factelect IS 'PERIODO DE FACTURACION ELECTRONICA ENERGIA SOLAR - PROCESADOS'#';   
    
    
    EXECUTE IMMEDIATE 'CREATE INDEX idx_periodo_factelect01 ON personalizaciones.periodo_factelect(periodo)';
      
    BEGIN
      pkg_utilidades.prAplicarPermisos('PERIODO_FACTELECT', 'PERSONALIZACIONES');
    END;
    
  END IF;
END;
/