DECLARE
  nuconta number;
BEGIN
  SELECT COUNT(1)
    INTO nuconta
    FROM DBA_TABLES
   WHERE TABLE_NAME = 'LOG_INFO_ADICIONAL_SOLICITUD';

  --/*
  IF nuconta = 1 THEN
    EXECUTE IMMEDIATE 'drop table PERSONALIZACIONES.LOG_INFO_ADICIONAL_SOLICITUD';
    dbms_output.put_line('Reaplicar tabla PERSONALIZACIONES.LOG_INFO_ADICIONAL_SOLICITUD Ok.');
    nuconta := 0;
  end if;
  --*/

  IF nuconta = 0 THEN
  
    EXECUTE IMMEDIATE 'CREATE TABLE PERSONALIZACIONES.LOG_INFO_ADICIONAL_SOLICITUD
                                    (PACKAGE_ID NUMBER(15),
                                     DATO_ADICIONAL VARCHAR2(100),
                                     VALOR_ANTERIOR VARCHAR2(2000),
                                     VALOR_NUEVO VARCHAR2(2000),
                                     FECHA_CAMBIO DATE,
                                     USUARIO VARCHAR2(50),
                                     TERMINAL VARCHAR2(200),
                                     OPERACION VARCHAR2(1)) TABLESPACE TSD_DEFAULT';
    dbms_output.put_line('Creacion de entidad LOG_INFO_ADICIONAL_SOLICITUD Ok.');
  
    -- Add comments to the table 
    EXECUTE IMMEDIATE 'COMMENT ON TABLE PERSONALIZACIONES.LOG_INFO_ADICIONAL_SOLICITUD IS ''DATO ADICIONAL PARA UNA SOLICITUD''';
    dbms_output.put_line('Comentario de la nueva entidad LOG_INFO_ADICIONAL_SOLICITUD Ok.');
  
    -- Add comments to the columns 
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN PERSONALIZACIONES.LOG_INFO_ADICIONAL_SOLICITUD.PACKAGE_ID IS ''CODIGO SOLICITUD''';
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN PERSONALIZACIONES.LOG_INFO_ADICIONAL_SOLICITUD.DATO_ADICIONAL IS ''NOMBRE DATO ADICIONAL''';
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN PERSONALIZACIONES.LOG_INFO_ADICIONAL_SOLICITUD.VALOR_ANTERIOR IS ''VALOR ANTES DESPUES DEL CAMBIO''';
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN PERSONALIZACIONES.LOG_INFO_ADICIONAL_SOLICITUD.VALOR_NUEVO IS ''VALOR NUEVO DESPUES DEL CAMBIO''';
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN PERSONALIZACIONES.LOG_INFO_ADICIONAL_SOLICITUD.FECHA_CAMBIO IS ''FECHA CAMBIO DEL DATO ADICIONAL''';
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN PERSONALIZACIONES.LOG_INFO_ADICIONAL_SOLICITUD.USUARIO IS ''USUARIO EJECUTA CAMBIO''';
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN PERSONALIZACIONES.LOG_INFO_ADICIONAL_SOLICITUD.TERMINAL IS ''TERMINAL EJECUTA CAMBIO''';
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN PERSONALIZACIONES.LOG_INFO_ADICIONAL_SOLICITUD.OPERACION IS ''OPERACION DEL CAMBIO I(INSERT) U(UPDATE) D(DELETE)''';
    dbms_output.put_line('Comentario de los atributos en al entidad LOG_INFO_ADICIONAL_SOLICITUD Ok.');
  
    -- Create/Recreate indexes 
    EXECUTE IMMEDIATE 'CREATE INDEX PERSONALIZACIONES.IDX_LOG_INFO_SOLICITUD_00 ON PERSONALIZACIONES.LOG_INFO_ADICIONAL_SOLICITUD(PACKAGE_ID) TABLESPACE TSI_DEFAULT';
    EXECUTE IMMEDIATE 'CREATE INDEX PERSONALIZACIONES.IDX_LOG_INFO_SOLICITUD_01 ON PERSONALIZACIONES.LOG_INFO_ADICIONAL_SOLICITUD(DATO_ADICIONAL) TABLESPACE TSI_DEFAULT';
    EXECUTE IMMEDIATE 'CREATE INDEX PERSONALIZACIONES.IDX_LOG_INFO_SOLICITUD_02 ON PERSONALIZACIONES.LOG_INFO_ADICIONAL_SOLICITUD(PACKAGE_ID,DATO_ADICIONAL) TABLESPACE TSI_DEFAULT';
    EXECUTE IMMEDIATE 'CREATE INDEX PERSONALIZACIONES.IDX_LOG_INFO_SOLICITUD_03 ON PERSONALIZACIONES.LOG_INFO_ADICIONAL_SOLICITUD(VALOR_ANTERIOR) TABLESPACE TSI_DEFAULT';
    EXECUTE IMMEDIATE 'CREATE INDEX PERSONALIZACIONES.IDX_LOG_INFO_SOLICITUD_04 ON PERSONALIZACIONES.LOG_INFO_ADICIONAL_SOLICITUD(VALOR_NUEVO) TABLESPACE TSI_DEFAULT';
    EXECUTE IMMEDIATE 'CREATE INDEX PERSONALIZACIONES.IDX_LOG_INFO_SOLICITUD_05 ON PERSONALIZACIONES.LOG_INFO_ADICIONAL_SOLICITUD(FECHA_CAMBIO) TABLESPACE TSI_DEFAULT';
    EXECUTE IMMEDIATE 'CREATE INDEX PERSONALIZACIONES.IDX_LOG_INFO_SOLICITUD_06 ON PERSONALIZACIONES.LOG_INFO_ADICIONAL_SOLICITUD(USUARIO) TABLESPACE TSI_DEFAULT';
    EXECUTE IMMEDIATE 'CREATE INDEX PERSONALIZACIONES.IDX_LOG_INFO_SOLICITUD_07 ON PERSONALIZACIONES.LOG_INFO_ADICIONAL_SOLICITUD(TERMINAL) TABLESPACE TSI_DEFAULT';
    EXECUTE IMMEDIATE 'CREATE INDEX PERSONALIZACIONES.IDX_LOG_INFO_SOLICITUD_08 ON PERSONALIZACIONES.LOG_INFO_ADICIONAL_SOLICITUD(OPERACION) TABLESPACE TSI_DEFAULT';
    EXECUTE IMMEDIATE 'CREATE INDEX PERSONALIZACIONES.IDX_LOG_INFO_SOLICITUD_09 ON PERSONALIZACIONES.LOG_INFO_ADICIONAL_SOLICITUD(FECHA_CAMBIO,OPERACION) TABLESPACE TSI_DEFAULT';
    EXECUTE IMMEDIATE 'CREATE INDEX PERSONALIZACIONES.IDX_LOG_INFO_SOLICITUD_10 ON PERSONALIZACIONES.LOG_INFO_ADICIONAL_SOLICITUD(FECHA_CAMBIO,DATO_ADICIONAL) TABLESPACE TSI_DEFAULT';
    EXECUTE IMMEDIATE 'CREATE INDEX PERSONALIZACIONES.IDX_LOG_INFO_SOLICITUD_11 ON PERSONALIZACIONES.LOG_INFO_ADICIONAL_SOLICITUD(FECHA_CAMBIO,USUARIO) TABLESPACE TSI_DEFAULT';
    dbms_output.put_line('Creacion de indices en al entidad LOG_INFO_ADICIONAL_SOLICITUD Ok.');
  
    pkg_utilidades.praplicarpermisos('LOG_INFO_ADICIONAL_SOLICITUD',
                                     'PERSONALIZACIONES');
    pkg_utilidades.prCrearSinonimos('LOG_INFO_ADICIONAL_SOLICITUD',
                                    'PERSONALIZACIONES');
    DBMS_OUTPUT.PUT_LINE('Aplicar permisos y sinonimos a la entidad LOG_INFO_ADICIONAL_SOLICITUD.');
  
  ELSE
    DBMS_OUTPUT.PUT_LINE('La entidad LOG_INFO_ADICIONAL_SOLICITUD ya existe.');
    pkg_utilidades.praplicarpermisos('LOG_INFO_ADICIONAL_SOLICITUD',
                                     'PERSONALIZACIONES');
    pkg_utilidades.prCrearSinonimos('LOG_INFO_ADICIONAL_SOLICITUD',
                                    'PERSONALIZACIONES');
  END IF;

exception
  when others then
    DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;
/