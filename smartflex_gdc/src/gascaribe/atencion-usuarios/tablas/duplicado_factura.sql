DECLARE
  nuconta number;
BEGIN
  SELECT COUNT(1)
    INTO nuconta
    FROM DBA_TABLES
   WHERE TABLE_NAME = 'DUPLICADO_FACTURA';

  IF nuconta = 1 THEN
    EXECUTE IMMEDIATE 'drop table PERSONALIZACIONES.DUPLICADO_FACTURA';
    dbms_output.put_line('Reaplicar tabla PERSONALIZACIONES.DUPLICADO_FACTURA Ok.');
    nuconta := 0;
  end if;

  IF nuconta = 0 THEN
  
    EXECUTE IMMEDIATE 'create table PERSONALIZACIONES.DUPLICADO_FACTURA
                                    ( CUPONUME   NUMBER(10) not null,
                                      SUSCCODI   NUMBER(8) not null,
                                      PACKAGE_ID NUMBER(15) not null,
                                      FECHA_REGISTRO DATE DEFAULT SYSDATE,
                                      OBSERVACION VARCHAR2(4000)
                                    ) tablespace TSD_DEFAULT';
    dbms_output.put_line('Creacion de entidad DUPLICADO_FACTURA Ok.');
  
    -- Add comments to the table 
    EXECUTE IMMEDIATE 'COMMENT ON TABLE PERSONALIZACIONES.DUPLICADO_FACTURA IS ''CUPONES CON COBRO POR DUPLICADO FACTURA''';
    dbms_output.put_line('Comentario de la nueva entidad DUPLICADO_FACTURA Ok.');
  
    -- Add comments to the columns 
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN PERSONALIZACIONES.DUPLICADO_FACTURA.CUPONUME IS ''CUPON''';
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN PERSONALIZACIONES.DUPLICADO_FACTURA.SUSCCODI IS ''CONTRATO''';
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN PERSONALIZACIONES.DUPLICADO_FACTURA.PACKAGE_ID IS ''SOLICITUD''';
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN PERSONALIZACIONES.DUPLICADO_FACTURA.FECHA_REGISTRO IS ''FECHA REGISTRO''';
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN PERSONALIZACIONES.DUPLICADO_FACTURA.OBSERVACION IS ''OBSERVACION SOBRE FINANCION''';
    dbms_output.put_line('Comentario de los atributos en al entidad DUPLICADO_FACTURA Ok.');
  
    -- Create/Recreate indexes 
    EXECUTE IMMEDIATE 'CREATE INDEX PERSONALIZACIONES.IDX_DUPLICADO_FACTURA_00 ON PERSONALIZACIONES.DUPLICADO_FACTURA(CUPONUME) tablespace TSI_DEFAULT';
    EXECUTE IMMEDIATE 'CREATE INDEX PERSONALIZACIONES.IDX_DUPLICADO_FACTURA_01 ON PERSONALIZACIONES.DUPLICADO_FACTURA(SUSCCODI) tablespace TSI_DEFAULT';
    EXECUTE IMMEDIATE 'CREATE INDEX PERSONALIZACIONES.IDX_DUPLICADO_FACTURA_02 ON PERSONALIZACIONES.DUPLICADO_FACTURA(PACKAGE_ID) tablespace TSI_DEFAULT';
    EXECUTE IMMEDIATE 'CREATE INDEX PERSONALIZACIONES.IDX_DUPLICADO_FACTURA_03 ON PERSONALIZACIONES.DUPLICADO_FACTURA(FECHA_REGISTRO) tablespace TSI_DEFAULT';
    EXECUTE IMMEDIATE 'CREATE INDEX PERSONALIZACIONES.IDX_DUPLICADO_FACTURA_04 ON PERSONALIZACIONES.DUPLICADO_FACTURA(CUPONUME, PACKAGE_ID) tablespace TSI_DEFAULT';
    EXECUTE IMMEDIATE 'CREATE INDEX PERSONALIZACIONES.IDX_DUPLICADO_FACTURA_05 ON PERSONALIZACIONES.DUPLICADO_FACTURA(CUPONUME, FECHA_REGISTRO) tablespace TSI_DEFAULT';
    EXECUTE IMMEDIATE 'CREATE INDEX PERSONALIZACIONES.IDX_DUPLICADO_FACTURA_06 ON PERSONALIZACIONES.DUPLICADO_FACTURA(PACKAGE_ID, FECHA_REGISTRO) tablespace TSI_DEFAULT';
    EXECUTE IMMEDIATE 'CREATE INDEX PERSONALIZACIONES.IDX_DUPLICADO_FACTURA_07 ON PERSONALIZACIONES.DUPLICADO_FACTURA(OBSERVACION) tablespace TSI_DEFAULT';
    EXECUTE IMMEDIATE 'CREATE INDEX PERSONALIZACIONES.IDX_DUPLICADO_FACTURA_08 ON PERSONALIZACIONES.DUPLICADO_FACTURA(SUSCCODI, FECHA_REGISTRO) tablespace TSI_DEFAULT';
    dbms_output.put_line('Creacion de indices en al entidad DUPLICADO_FACTURA Ok.');
  
    pkg_utilidades.praplicarpermisos('DUPLICADO_FACTURA',
                                     'PERSONALIZACIONES');
    pkg_utilidades.prCrearSinonimos('DUPLICADO_FACTURA',
                                    'PERSONALIZACIONES');
    dbms_output.put_line('Creacion de permisos para la entidad DUPLICADO_FACTURA Ok.');
  
    -- Create/Recreate primary, unique and foreign key constraints
    EXECUTE IMMEDIATE 'alter table PERSONALIZACIONES.DUPLICADO_FACTURA add constraint PK_DUPLICADO_FACTURA primary key (CUPONUME)';
    dbms_output.put_line('Creacion de llave Primaria en la entidad DUPLICADO_FACTURA Ok.');
  
  ELSE
    DBMS_OUTPUT.PUT_LINE('La entidad DUPLICADO_FACTURA ya existe.');
    pkg_utilidades.praplicarpermisos('DUPLICADO_FACTURA',
                                     'PERSONALIZACIONES');
    pkg_utilidades.prCrearSinonimos('DUPLICADO_FACTURA',
                                    'PERSONALIZACIONES');
  END IF;

exception
  when others then
    DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;
/