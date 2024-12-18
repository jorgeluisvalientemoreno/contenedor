DECLARE
  nuConta NUMBER;
BEGIN

 SELECT COUNT(*) INTO nuConta
 FROM dba_tables
 WHERE table_name = 'INFO_PRODUCTO_DESVPOBL' 
    AND OWNER = 'PERSONALIZACIONES';
  
  IF nuConta = 0 THEN
    EXECUTE IMMEDIATE 'CREATE TABLE personalizaciones.info_producto_desvpobl( producto                  NUMBER(15) NOT NULL, 
                                                                               contrato                  NUMBER(15), 
                                                                               periodo_facturacion       NUMBER(15), 
                                                                               periodo_consumo           NUMBER(15),
                                                                               consumo_actual            NUMBER(20,5), 
                                                                               consumo_promedio          NUMBER(20,5),
                                                                               desviacion_poblacional    NUMBER(15,5),
                                                                               tipo_desviacion           VARCHAR2(1),
                                                                               calificacion              NUMBER(15),
                                                                               estado                    VARCHAR2(1) DEFAULT ''A'',
                                                                               fecha_registro            DATE  ) tablespace TSD_FCONSUMOS';
    EXECUTE IMMEDIATE 'CREATE INDEX idx_info_producto_desvpobl01 ON  personalizaciones.info_producto_desvpobl(producto) tablespace TSI_FCONSUMOS';
    EXECUTE IMMEDIATE 'CREATE INDEX idx_info_producto_desvpobl02 ON  personalizaciones.info_producto_desvpobl(periodo_facturacion) tablespace TSI_FCONSUMOS';
    EXECUTE IMMEDIATE 'CREATE INDEX idx_info_producto_desvpobl03 ON  personalizaciones.info_producto_desvpobl(periodo_consumo) tablespace TSI_FCONSUMOS';
    EXECUTE IMMEDIATE 'CREATE INDEX idx_info_producto_desvpobl04 ON  personalizaciones.info_producto_desvpobl(fecha_registro) tablespace TSI_FCONSUMOS';
    EXECUTE IMMEDIATE 'CREATE INDEX idx_info_producto_desvpobl05 ON  personalizaciones.info_producto_desvpobl(contrato, periodo_facturacion,  periodo_consumo) tablespace TSI_FCONSUMOS';
    EXECUTE IMMEDIATE 'CREATE INDEX idx_info_producto_desvpobl06 ON  personalizaciones.info_producto_desvpobl(contrato, periodo_facturacion, estado) tablespace TSI_FCONSUMOS';
    
    EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.info_producto_desvpobl.producto IS 'CODIGO DEL PRODUCTO'#';
    EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.info_producto_desvpobl.contrato IS 'CODIGO DEL CONTRATO'#';
    EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.info_producto_desvpobl.periodo_facturacion IS 'PERIODO DE FACTURACION'#';
    EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.info_producto_desvpobl.periodo_consumo IS 'PERIODO DE CONSUMO'#';
    EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.info_producto_desvpobl.consumo_actual IS 'CONSUMO ACTUAL'#';
    EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.info_producto_desvpobl.consumo_promedio IS 'CONSUMO PROMEDIO'#';
    EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.info_producto_desvpobl.desviacion_poblacional IS 'DESVIACION POBLACIONAL'#';
    EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.info_producto_desvpobl.tipo_desviacion IS 'TIPO DE DESVIACION N-NORMAL, A-AUMENTO, D-DISMINUCION'#';
    EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.info_producto_desvpobl.calificacion IS 'CALIFICACION DE CONSUMO'#';
    EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.info_producto_desvpobl.estado IS 'ESTADO DEL REGISTRO A - ACTIVO, I - INACTIVO '#';
    EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.info_producto_desvpobl.fecha_registro IS 'FECHA DE REGISTRO'#';
    EXECUTE IMMEDIATE q'#COMMENT ON TABLE personalizaciones.info_producto_desvpobl IS 'INFORMACION DE PRODUCTOS QUE INGRESARON AL PROCESO DE DESVIACION POBLACIONAL'#';
    
    BEGIN
	    pkg_utilidades.prAplicarPermisos('INFO_PRODUCTO_DESVPOBL','PERSONALIZACIONES');
	  END;
  
  END IF;
 
  END;
  /