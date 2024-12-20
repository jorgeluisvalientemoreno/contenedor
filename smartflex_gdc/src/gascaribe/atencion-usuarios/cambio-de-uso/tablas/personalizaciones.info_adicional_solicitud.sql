DECLARE
  nuconta number;
BEGIN
  SELECT COUNT(1)
    INTO nuconta
    FROM DBA_TABLES
   WHERE TABLE_NAME = 'INFO_ADICIONAL_SOLICITUD';

  --/*
  IF nuconta = 1 THEN
    EXECUTE IMMEDIATE 'drop table PERSONALIZACIONES.INFO_ADICIONAL_SOLICITUD';
    dbms_output.put_line('Reaplicar tabla PERSONALIZACIONES.INFO_ADICIONAL_SOLICITUD Ok.');
    nuconta := 0;
  end if;
  --*/

  IF nuconta = 0 THEN
  
    EXECUTE IMMEDIATE 'CREATE TABLE PERSONALIZACIONES.INFO_ADICIONAL_SOLICITUD
                                    (PACKAGE_ID NUMBER(15),
                                     DATO_ADICIONAL VARCHAR2(100),
                                     VALOR VARCHAR2(2000)) TABLESPACE TSD_DEFAULT';
    dbms_output.put_line('Creacion de entidad INFO_ADICIONAL_SOLICITUD Ok.');
  
    -- Add comments to the table 
    EXECUTE IMMEDIATE 'COMMENT ON TABLE PERSONALIZACIONES.INFO_ADICIONAL_SOLICITUD IS ''DATO ADICIONAL PARA UNA SOLICITUD''';
    dbms_output.put_line('Comentario de la nueva entidad INFO_ADICIONAL_SOLICITUD Ok.');
  
    -- Add comments to the columns 
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN PERSONALIZACIONES.INFO_ADICIONAL_SOLICITUD.PACKAGE_ID IS ''CODIGO SOLICITUD''';
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN PERSONALIZACIONES.INFO_ADICIONAL_SOLICITUD.DATO_ADICIONAL IS ''NOMBRE DATO ADICIONAL''';
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN PERSONALIZACIONES.INFO_ADICIONAL_SOLICITUD.VALOR IS ''VALOR DEL DATO ADICIONAL''';
    dbms_output.put_line('Comentario de los atributos en al entidad INFO_ADICIONAL_SOLICITUD Ok.');
  
    -- Create/Recreate indexes 
    EXECUTE IMMEDIATE 'CREATE INDEX PERSONALIZACIONES.IDX_INFO_SOLICITUD_00 ON PERSONALIZACIONES.INFO_ADICIONAL_SOLICITUD(PACKAGE_ID) TABLESPACE TSI_DEFAULT';
    EXECUTE IMMEDIATE 'CREATE INDEX PERSONALIZACIONES.IDX_INFO_SOLICITUD_01 ON PERSONALIZACIONES.INFO_ADICIONAL_SOLICITUD(DATO_ADICIONAL) TABLESPACE TSI_DEFAULT';
    dbms_output.put_line('Creacion de indices en al entidad INFO_ADICIONAL_SOLICITUD Ok.');
  
    -- Create/Recreate primary
    EXECUTE IMMEDIATE 'ALTER TABLE PERSONALIZACIONES.INFO_ADICIONAL_SOLICITUD ADD CONSTRAINT PK_INFO_ADICIONAL_SOLICITUD PRIMARY KEY (PACKAGE_ID,DATO_ADICIONAL) USING INDEX TABLESPACE TSI_DEFAULT';
    dbms_output.put_line('Creacion de llave Primaria en la entidad INFO_ADICIONAL_SOLICITUD Ok.');
  
    pkg_utilidades.praplicarpermisos('INFO_ADICIONAL_SOLICITUD',
                                     'PERSONALIZACIONES');
    pkg_utilidades.prCrearSinonimos('INFO_ADICIONAL_SOLICITUD',
                                    'PERSONALIZACIONES');
    DBMS_OUTPUT.PUT_LINE('Aplicar permisos y sinonimos a la entidad INFO_ADICIONAL_SOLICITUD.');
  
  ELSE
    DBMS_OUTPUT.PUT_LINE('La entidad INFO_ADICIONAL_SOLICITUD ya existe.');
    pkg_utilidades.praplicarpermisos('INFO_ADICIONAL_SOLICITUD',
                                     'PERSONALIZACIONES');
    pkg_utilidades.prCrearSinonimos('INFO_ADICIONAL_SOLICITUD',
                                    'PERSONALIZACIONES');
  END IF;

exception
  when others then
    DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;
/
