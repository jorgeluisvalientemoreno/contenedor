DECLARE
  nuconta number;
BEGIN
  SELECT COUNT(1)
    INTO nuconta
    FROM DBA_TABLES
   WHERE TABLE_NAME = 'EXENCION_COBRO_FACTURA';

  IF nuconta = 1 THEN
    EXECUTE IMMEDIATE 'drop table PERSONALIZACIONES.EXENCION_COBRO_FACTURA';
    dbms_output.put_line('Reaplicar tabla PERSONALIZACIONES.EXENCION_COBRO_FACTURA Ok.');
    nuconta := 0;
  end if;

  IF nuconta = 0 THEN
  
    EXECUTE IMMEDIATE 'CREATE TABLE PERSONALIZACIONES.EXENCION_COBRO_FACTURA
                                    ( SOLICITUD   NUMBER(15),
                                      PRODUCTO    NUMBER(10) NOT NULL,
                                      FECHA_INI_VIGENCIA DATE NOT NULL,
                                      FECHA_FIN_VIGENCIA DATE NOT NULL
                                    ) tablespace TSD_DEFAULT';
    dbms_output.put_line('Creacion de entidad EXENCION_COBRO_FACTURA Ok.');
  
    -- Add comments to the table 
    EXECUTE IMMEDIATE 'COMMENT ON TABLE PERSONALIZACIONES.EXENCION_COBRO_FACTURA IS ''Exención de cobro en factura''';
    dbms_output.put_line('Comentario de la nueva entidad EXENCION_COBRO_FACTURA Ok.');
  
    -- Add comments to the columns 
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN PERSONALIZACIONES.EXENCION_COBRO_FACTURA.SOLICITUD IS ''Solicitud''';
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN PERSONALIZACIONES.EXENCION_COBRO_FACTURA.PRODUCTO IS ''Producto''';
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN PERSONALIZACIONES.EXENCION_COBRO_FACTURA.FECHA_INI_VIGENCIA IS ''Fecha Inicio de vigencia''';
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN PERSONALIZACIONES.EXENCION_COBRO_FACTURA.FECHA_FIN_VIGENCIA IS ''Fecha Fin de Vigencia''';
    dbms_output.put_line('Comentario de los atributos en al entidad EXENCION_COBRO_FACTURA Ok.');
  
    -- Create/Recreate indexes 
    EXECUTE IMMEDIATE 'CREATE INDEX PERSONALIZACIONES.IDX_EXENCION_COBRO_FACTURA_01 ON PERSONALIZACIONES.EXENCION_COBRO_FACTURA(SOLICITUD) tablespace TSI_DEFAULT';
    EXECUTE IMMEDIATE 'CREATE INDEX PERSONALIZACIONES.IDX_EXENCION_COBRO_FACTURA_02 ON PERSONALIZACIONES.EXENCION_COBRO_FACTURA(PRODUCTO) tablespace TSI_DEFAULT';
    EXECUTE IMMEDIATE 'CREATE INDEX PERSONALIZACIONES.IDX_EXENCION_COBRO_FACTURA_03 ON PERSONALIZACIONES.EXENCION_COBRO_FACTURA(PRODUCTO,FECHA_INI_VIGENCIA,FECHA_FIN_VIGENCIA) tablespace TSI_DEFAULT';

    dbms_output.put_line('Creacion de indices en al entidad EXENCION_COBRO_FACTURA Ok.');
  
    pkg_utilidades.praplicarpermisos('EXENCION_COBRO_FACTURA',
                                     'PERSONALIZACIONES');

    dbms_output.put_line('Creacion de permisos para la entidad EXENCION_COBRO_FACTURA Ok.');
  
  
  ELSE
    DBMS_OUTPUT.PUT_LINE('La entidad EXENCION_COBRO_FACTURA ya existe.');
    pkg_utilidades.praplicarpermisos('EXENCION_COBRO_FACTURA',
                                     'PERSONALIZACIONES');
  END IF;

exception
  when others then
    DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;
/
