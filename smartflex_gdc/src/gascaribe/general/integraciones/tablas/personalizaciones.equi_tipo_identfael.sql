DECLARE
  nuConta NUMBER;
BEGIN

 SELECT COUNT(*) INTO nuConta
 FROM dba_tables
 WHERE table_name = 'EQUI_TIPO_IDENTFAEL' 
    AND OWNER = 'PERSONALIZACIONES';
  
  IF nuConta = 0 THEN

    EXECUTE IMMEDIATE 'CREATE TABLE personalizaciones.equi_tipo_identfael ( tipo_idenosf     NUMBER(5),
                                                     tipo_idendian    NUMBER(5))';
    EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.equi_tipo_identfael.tipo_idenosf IS 'TIPO DE IDENTIFACION OSF'#';
    EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.equi_tipo_identfael.tipo_idendian IS 'TIPO DE IDENTIFICACION DIAN'#';
    EXECUTE IMMEDIATE q'#COMMENT ON TABLE  personalizaciones.equi_tipo_identfael IS 'EQUIVALENCIA DE TIPO DE IDENTIFICACION FACTURACION ELECTRONICA'#';
    
    
    EXECUTE IMMEDIATE 'CREATE INDEX idx_equi_tipo_identfael01 ON personalizaciones.equi_tipo_identfael(tipo_idenosf)';
      
    BEGIN
      pkg_utilidades.prAplicarPermisos('EQUI_TIPO_IDENTFAEL', 'PERSONALIZACIONES');
    END;
    
  END IF;
END;
/