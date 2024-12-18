DECLARE
   nuConta NUMBER;
BEGIN

    SELECT COUNT(*) INTO nuConta
    FROM dba_tables
    WHERE table_name = 'CONC_UNID_MEDIDA_DIAN' 
      AND owner = 'PERSONALIZACIONES';

    IF nuConta = 0 THEN

        EXECUTE IMMEDIATE 'CREATE TABLE personalizaciones.CONC_UNID_MEDIDA_DIAN 
                           ( 
                               concepto_id      NUMBER(4,0) NOT NULL,
                               unidad_medida    VARCHAR2(10) NOT NULL,
                               descripcion      VARCHAR2(100),
                               requiere_tarifa  VARCHAR2(1)
                           )';
                                                                                  
        EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.CONC_UNID_MEDIDA_DIAN.concepto_id IS 'CODIGO DEL CONCEPTO DE FACTURACION RELACIONADO A LA TABLA CONCEPTO'#';
        EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.CONC_UNID_MEDIDA_DIAN.unidad_medida IS 'UNIDAD DE MEDIDA DIAN A REPORTAR EN LA FACTURACION ELECTRONICA'#';
        EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.CONC_UNID_MEDIDA_DIAN.descripcion IS 'DESCRIPCION DIAN DE LA UNIDAD DE MEDIDA'#';
        EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.CONC_UNID_MEDIDA_DIAN.REQUIERE_TARIFA IS 'REQUIERE VALOR UNITARIO COMO TARIFA (S - SI, N - NO)'#';
        EXECUTE IMMEDIATE q'#COMMENT ON TABLE  personalizaciones.CONC_UNID_MEDIDA_DIAN IS 'CODIGO DE CONCEPTO Y SU UNIDAD DE MEDIDA USADA EN LA FACTURACION ELECTRONICA DIAN'#';
        
        EXECUTE IMMEDIATE 'CREATE UNIQUE INDEX idx_CONC_UNID_MEDIDA_DIAN01 ON personalizaciones.CONC_UNID_MEDIDA_DIAN(concepto_id)';
          
        BEGIN
           pkg_utilidades.prAplicarPermisos('CONC_UNID_MEDIDA_DIAN', 'PERSONALIZACIONES');
        END;
    
    END IF;

    SELECT COUNT(*) INTO nuConta
    FROM dba_tab_columns
    WHERE table_name = 'CONC_UNID_MEDIDA_DIAN'
     AND OWNER = 'PERSONALIZACIONES'
     AND column_name = 'REQUIERE_TARIFA';
    
    IF nuConta = 0  THEN
        EXECUTE IMMEDIATE q'#ALTER TABLE PERSONALIZACIONES.CONC_UNID_MEDIDA_DIAN ADD REQUIERE_TARIFA VARCHAR2(1 BYTE)#';
        EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.CONC_UNID_MEDIDA_DIAN.REQUIERE_TARIFA IS 'REQUIERE VALOR UNITARIO COMO TARIFA (S - SI, N - NO)'#';
    END IF;

END;
/