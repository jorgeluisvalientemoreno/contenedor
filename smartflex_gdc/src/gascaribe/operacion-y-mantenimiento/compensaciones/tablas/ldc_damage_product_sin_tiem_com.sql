DECLARE
  CURSOR cuTabla(sbTable VARCHAR2) IS
    SELECT * FROM all_tables WHERE upper(TABLE_NAME) = upper(sbTable);

  rccuTabla cuTabla%ROWTYPE;

BEGIN
  Dbms_Output.Put_Line('Inicia Creacion tabla LDC_DAMPRO_SIN_TIEMCOM');
  OPEN cuTabla('LDC_DAMPRO_SIN_TIEMCOM');
  FETCH cuTabla
    INTO rccuTabla;

  IF (cuTabla%NOTFOUND) THEN
  
    Dbms_Output.Put_Line('Inicia Crea LDC_DAMPRO_SIN_TIEMCOM');
  
    EXECUTE IMMEDIATE 'create table LDC_DAMPRO_SIN_TIEMCOM
                      (
                        DAMAGES_PRODUCT_ID NUMBER(15),
                        PRODUCT_ID NUMBER(15),
                        PACKAGE_ID NUMBER(15)
                      )';
    --- Comentarios de la tabla.
    dbms_output.put_line('SCRIPT: Comentarios de la tabla...');
    EXECUTE IMMEDIATE 'comment on table LDC_DAMPRO_SIN_TIEMCOM is ''PRODUCTOS AFECTADOS SIN TIEMPO COMPENSADOS''';
    EXECUTE IMMEDIATE 'comment on column LDC_DAMPRO_SIN_TIEMCOM.DAMAGES_PRODUCT_ID is ''IDENTIFICADOR DEL REGISTRO''';
    EXECUTE IMMEDIATE 'comment on column LDC_DAMPRO_SIN_TIEMCOM.PRODUCT_ID is ''IDENTIFICADOR DEL PRODUCTO''';
    EXECUTE IMMEDIATE 'comment on column LDC_DAMPRO_SIN_TIEMCOM.PACKAGE_ID is ''IDENTIFICADOR DE LA FALLA - PAQUETE''';
  
    --- Indices
    dbms_output.put_line('SCRIPT: Indices...');
    EXECUTE IMMEDIATE 'create index IDX_LDC_DAMPRO_SIN_TIEMCOM_01 on LDC_DAMPRO_SIN_TIEMCOM (PRODUCT_ID)';
    EXECUTE IMMEDIATE 'create index IDX_LDC_DAMPRO_SIN_TIEMCOM_02 on LDC_DAMPRO_SIN_TIEMCOM (PACKAGE_ID, PRODUCT_ID)';
    EXECUTE IMMEDIATE 'create index IDX_LDC_DAMPRO_SIN_TIEMCOM_03 on LDC_DAMPRO_SIN_TIEMCOM (PACKAGE_ID)';
  
    --- llave primaria
    BEGIN
      dbms_output.put_line('SCRIPT: llave primaria...');
      EXECUTE IMMEDIATE 'alter table LDC_DAMPRO_SIN_TIEMCOM add constraint PK_LDC_DAMPRO_SIN_TIEMCOM primary key (DAMAGES_PRODUCT_ID)';
    EXCEPTION
      WHEN OTHERS THEN
        dbms_output.put_line('SCRIPT: ERROR CREANDO LLAVE PRIMARI[PK_LDC_DAMPRO_SIN_TIEMCOM]');
    END;
  
    dbms_output.put_line('SCRIPT: APLICANDO PERMISOS...');
    --- Aplica Permisos.
    EXECUTE IMMEDIATE 'GRANT SELECT,UPDATE,DELETE,INSERT ON LDC_DAMPRO_SIN_TIEMCOM TO SYSTEM_OBJ_PRIVS_ROLE';
    EXECUTE IMMEDIATE 'GRANT SELECT ON LDC_DAMPRO_SIN_TIEMCOM TO REPORTES';
    EXECUTE IMMEDIATE 'GRANT SELECT ON LDC_DAMPRO_SIN_TIEMCOM TO RSELOPEN';
    --- Fin.
  
    Dbms_Output.Put_Line('Fin Creacion tabla LDC_DAMPRO_SIN_TIEMCOM');
  ELSE
    Dbms_Output.Put_Line('***************tabla LDC_DAMPRO_SIN_TIEMCOM ya existe');
  END IF;
  CLOSE cuTabla;

END;
/
