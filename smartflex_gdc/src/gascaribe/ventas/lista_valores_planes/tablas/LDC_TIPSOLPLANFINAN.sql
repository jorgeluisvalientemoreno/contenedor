DECLARE
  CURSOR cuTabla(sbTable VARCHAR2) IS
    SELECT * FROM all_tables WHERE upper(TABLE_NAME) = upper(sbTable);

  rccuTabla cuTabla%ROWTYPE;

BEGIN
  Dbms_Output.Put_Line('Inicia Creacion tabla LDC_TIPSOLPLANFINAN');
  OPEN cuTabla('LDC_TIPSOLPLANFINAN');
  FETCH cuTabla
    INTO rccuTabla;

  IF (cuTabla%NOTFOUND) THEN
  
    Dbms_Output.Put_Line('Inicia Crea LDC_TIPSOLPLANFINAN');
  
    EXECUTE IMMEDIATE 'create table LDC_TIPSOLPLANFINAN
                      (
                        PACKAGE_TYPE_ID NUMBER(15),
                        PLDICODI NUMBER(4),
                        CREATED_TSPF DATE,
                        USUARIO_CREATED VARCHAR2(50),
                        UPDATED_TSPF DATE,
                        USUARIO_UPDATED VARCHAR2(50)                        
                      )';
    --- Comentarios de la tabla.
    dbms_output.put_line('SCRIPT: Comentarios de la tabla...');
    EXECUTE IMMEDIATE 'comment on table LDC_TIPSOLPLANFINAN is ''TIPO SOLICITUD POR PLAN DE FINANCIACION''';
    EXECUTE IMMEDIATE 'comment on column LDC_TIPSOLPLANFINAN.PACKAGE_TYPE_ID is ''CONSECUTIVO DE TIPO DE PAQUETE''';
    EXECUTE IMMEDIATE 'comment on column LDC_TIPSOLPLANFINAN.PLDICODI is ''CONSECUTIVO PLAN DE FINANCIACION''';
    EXECUTE IMMEDIATE 'comment on column LDC_TIPSOLPLANFINAN.CREATED_TSPF is ''FECHA CREACION''';
    EXECUTE IMMEDIATE 'comment on column LDC_TIPSOLPLANFINAN.USUARIO_CREATED is ''USUARIO QUE REALIZO LA CREACION''';
    EXECUTE IMMEDIATE 'comment on column LDC_TIPSOLPLANFINAN.UPDATED_TSPF is ''FECHA ACTUALIZACION''';
    EXECUTE IMMEDIATE 'comment on column LDC_TIPSOLPLANFINAN.USUARIO_UPDATED is ''USUARIO QUE REALIZO LA ACTUALIZACION''';
  
    --- Indices
    dbms_output.put_line('SCRIPT: Indices...');
    EXECUTE IMMEDIATE 'create index IDX_LDC_TIPSOLPLANFINAN_0 on LDC_TIPSOLPLANFINAN (PACKAGE_TYPE_ID)';
    EXECUTE IMMEDIATE 'create index IDX_LDC_TIPSOLPLANFINAN_1 on LDC_TIPSOLPLANFINAN (PLDICODI)';
  
    --- llave primaria
    BEGIN
      dbms_output.put_line('SCRIPT: llave primaria...');
      EXECUTE IMMEDIATE 'alter table LDC_TIPSOLPLANFINAN add constraint PK_LDC_TIPSOLPLANFINAN primary key (PACKAGE_TYPE_ID,PLDICODI)';
    EXCEPTION
      WHEN OTHERS THEN
        dbms_output.put_line('SCRIPT: ERROR CREANDO LLAVE PRIMARI[PK_LDC_TIPSOLPLANFINAN]');
    END;
  
    --- llave foranea
    BEGIN
      dbms_output.put_line('SCRIPT: llave foranea...');
      EXECUTE IMMEDIATE 'alter table LDC_TIPSOLPLANFINAN add constraint FK_LDC_TIPSOLPLANFINAN_0 foreign key (PACKAGE_TYPE_ID) references PS_PACKAGE_TYPE (PACKAGE_TYPE_ID)';
    EXCEPTION
      WHEN OTHERS THEN
        dbms_output.put_line('SCRIPT: ERROR CREANDO LLAVE FORANEA[FK_LDC_TIPSOLPLANFINAN_0]');
    END;
    BEGIN
      dbms_output.put_line('SCRIPT: llave foranea...');
      EXECUTE IMMEDIATE 'alter table LDC_TIPSOLPLANFINAN add constraint FK_LDC_TIPSOLPLANFINAN_1 foreign key (PLDICODI) references plandife (PLDICODI)';
    EXCEPTION
      WHEN OTHERS THEN
        dbms_output.put_line('SCRIPT: ERROR CREANDO LLAVE FORANEA[FK_LDC_TIPSOLPLANFINAN_1]');
    END;
  
    dbms_output.put_line('SCRIPT: APLICANDO PERMISOS...');
    --- Aplica Permisos.
    EXECUTE IMMEDIATE 'GRANT SELECT,UPDATE,DELETE,INSERT ON LDC_TIPSOLPLANFINAN TO SYSTEM_OBJ_PRIVS_ROLE';
    EXECUTE IMMEDIATE 'GRANT SELECT ON LDC_TIPSOLPLANFINAN TO REPORTES';
    EXECUTE IMMEDIATE 'GRANT SELECT ON LDC_TIPSOLPLANFINAN TO RSELOPEN';
    --- Fin.
  
    Dbms_Output.Put_Line('Fin Creacion tabla LDC_TIPSOLPLANFINAN');
  ELSE
    Dbms_Output.Put_Line('***************tabla LDC_TIPSOLPLANFINAN ya existe');
  END IF;
  CLOSE cuTabla;

END;
/
