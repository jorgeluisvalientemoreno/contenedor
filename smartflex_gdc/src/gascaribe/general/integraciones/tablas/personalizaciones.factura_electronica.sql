DECLARE
  nuConta NUMBER;
BEGIN

 SELECT COUNT(*) INTO nuConta
 FROM dba_tables
 WHERE table_name = 'FACTURA_ELECTRONICA' 
    AND OWNER = 'PERSONALIZACIONES';
  
  IF nuConta = 0 THEN

    EXECUTE IMMEDIATE 'CREATE TABLE personalizaciones.factura_electronica ( contrato          NUMBER(15),
                                      consfael          NUMBER(15),
                                      factura            NUMBER(15),
                                      estado            NUMBER(1),
                                      numero_intento    NUMBER(4),
                                      fecha_registro    DATE,
                                      fecha_envio       DATE,
                                      fecha_respuesta   DATE,
                                      XML_factelect     CLOB,
                                      xml_respuesta     CLOB,
                                      mensaje_respuesta CLOB)';
    EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.factura_electronica.contrato IS 'CONTRATO'#';
    EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.factura_electronica.consfael IS 'CONSECUTIVO DE FACTURACION ELECTRONICA (NUMERACION DE LA DIAN)'#';
    EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.factura_electronica.factura IS 'CODIGO DE FACTURA RECURRENTE'#';
    EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.factura_electronica.estado   IS 'ESTADO (1- REGISTRADO, 2- error EN ENVIO, 3- RECHAZADO PT, 4 - RECHAZADO DIAN, 5 - DATOS CORREGIDOS, 6- EXITOSO)'#';
    EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.factura_electronica.fecha_registro IS 'FECHA DE REGISTRO'#';
    EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.factura_electronica.numero_intento   IS 'NUMERO DE INTENTOS'#';
    EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.factura_electronica.fecha_envio   IS 'FECHA DE ENVIO'#';
    EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.factura_electronica.fecha_respuesta   IS 'FECHA DE RESPUESTA'#';
    EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.factura_electronica.XML_factelect   IS 'XML FACTURA ELECTRONICA'#';
    EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.factura_electronica.xml_respuesta   IS 'XML RESPUESTA'#';
    EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.factura_electronica.mensaje_respuesta IS 'MENSAJE DE RESPUESTA'#';
    EXECUTE IMMEDIATE q'#COMMENT ON TABLE  personalizaciones.factura_electronica IS 'FACTURACION ELECTRONICA ENERGIA SOLAR'#';
    
    
    EXECUTE IMMEDIATE 'CREATE INDEX idx_factura_electronica01 ON personalizaciones.factura_electronica(contrato, estado)';
    EXECUTE IMMEDIATE 'CREATE INDEX idx_factura_electronica02 ON personalizaciones.factura_electronica(consfael, estado)';
    EXECUTE IMMEDIATE 'CREATE INDEX idx_factura_electronica03 ON personalizaciones.factura_electronica(contrato, factura,estado)';
    EXECUTE IMMEDIATE 'CREATE INDEX idx_factura_electronica04 ON personalizaciones.factura_electronica(fecha_registro, estado)';
    EXECUTE IMMEDIATE 'CREATE INDEX idx_factura_electronica05 ON personalizaciones.factura_electronica(contrato,factura, fecha_registro,estado)';
    EXECUTE IMMEDIATE 'CREATE INDEX idx_factura_electronica06 ON personalizaciones.factura_electronica(estado)';
    EXECUTE IMMEDIATE 'CREATE INDEX idx_factura_electronica07 ON personalizaciones.factura_electronica(factura, estado)';
    
    BEGIN
      pkg_utilidades.prAplicarPermisos('FACTURA_ELECTRONICA', 'PERSONALIZACIONES');
    END;
    
  END IF;
END;
/