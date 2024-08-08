DECLARE

  CURSOR cuTabla(sbTable VARCHAR2) IS
    SELECT * FROM all_tables WHERE upper(TABLE_NAME) = upper(sbTable);

  rccuTabla cuTabla%ROWTYPE;

BEGIN

  ---Inicio Borrado de entidades
  OPEN cuTabla('JLV_HISTORIC');
  FETCH cuTabla
    INTO rccuTabla;
  IF (cuTabla%FOUND) THEN
    EXECUTE IMMEDIATE 'DROP table JLV_HISTORIC cascade constraints';
    Dbms_Output.Put_Line('***************tabla JLV_HISTORIC Eliminada Ok.');
  end iF;
  close cuTabla;
  
  OPEN cuTabla('JLV_AVAILABILITY');
  FETCH cuTabla
    INTO rccuTabla;
  IF (cuTabla%FOUND) THEN
    EXECUTE IMMEDIATE 'DROP table JLV_AVAILABILITY cascade constraints';
    Dbms_Output.Put_Line('***************tabla JLV_AVAILABILITY Eliminada Ok.');
  end iF;
  close cuTabla;

  OPEN cuTabla('JLV_EVENT');
  FETCH cuTabla
    INTO rccuTabla;
  IF (cuTabla%FOUND) THEN
    EXECUTE IMMEDIATE 'DROP table JLV_EVENT cascade constraints';
    Dbms_Output.Put_Line('***************tabla JLV_EVENT Eliminada Ok.');
  end iF;
  close cuTabla;

  OPEN cuTabla('JLV_TYPE');
  FETCH cuTabla
    INTO rccuTabla;
  IF (cuTabla%FOUND) THEN
    EXECUTE IMMEDIATE 'DROP table JLV_TYPE cascade constraints';
    Dbms_Output.Put_Line('***************tabla JLV_TYPE Eliminada Ok.');
  end iF;
  close cuTabla;
  ---Fin Borrado de entidades

  ----Inicio Creacion de entidad JLV_TYPE
  Dbms_Output.Put_Line('Inicia Creacion tabla JLV_TYPE');

  OPEN cuTabla('JLV_TYPE');
  FETCH cuTabla
    INTO rccuTabla;

  IF (cuTabla%NOTFOUND) THEN
  
    Dbms_Output.Put_Line('Inicia Crea JLV_TYPE');
  
    EXECUTE IMMEDIATE 'create table JLV_TYPE
                      (
                        TYPE_ID NUMBER(15),
                        TYPE_DESC VARCHAR2(4000)
                      )';
    --- Comentarios de la tabla.
    dbms_output.put_line('SCRIPT: Comentarios de la tabla...');
    EXECUTE IMMEDIATE 'comment on table JLV_TYPE is ''TIPO EVENTO''';
    EXECUTE IMMEDIATE 'comment on column JLV_TYPE.TYPE_ID is ''CODIGO TIPO EVENTO''';
    EXECUTE IMMEDIATE 'comment on column JLV_TYPE.TYPE_DESC is ''DESCRIPCION TIPO EVENTO''';
  
    --- Indices
    dbms_output.put_line('SCRIPT: Indices...');
    EXECUTE IMMEDIATE 'create index IDX_JLV_TYPE_01 on JLV_TYPE (TYPE_ID)';
    EXECUTE IMMEDIATE 'create index IDX_JLV_TYPE_02 on JLV_TYPE (TYPE_DESC)';
  
    --- llave primaria
    BEGIN
      dbms_output.put_line('SCRIPT: llave primaria...');
      EXECUTE IMMEDIATE 'alter table JLV_TYPE add constraint PK_JLV_TYPE primary key (TYPE_ID)';
    EXCEPTION
      WHEN OTHERS THEN
        dbms_output.put_line('SCRIPT: ERROR CREANDO LLAVE PRIMARI[PK_JLV_TYPE]');
    END;
  
    dbms_output.put_line('SCRIPT: APLICANDO PERMISOS...');
    --- Aplica Permisos.
    EXECUTE IMMEDIATE 'GRANT SELECT,UPDATE,DELETE,INSERT ON JLV_TYPE TO SYSTEM_OBJ_PRIVS_ROLE';
    --- Fin.
  
    Dbms_Output.Put_Line('Fin Creacion tabla JLV_TYPE');
  END IF;
  CLOSE cuTabla;
  ----Fin Creacion de entidad JLV_TYPE

  ----Inicio Creacion de entidad JLV_EVENT
  Dbms_Output.Put_Line('Inicia Creacion tabla JLV_EVENT');

  OPEN cuTabla('JLV_EVENT');
  FETCH cuTabla
    INTO rccuTabla;

  IF (cuTabla%NOTFOUND) THEN
  
    Dbms_Output.Put_Line('Inicia Crea JLV_EVENT');
  
    EXECUTE IMMEDIATE 'create table JLV_EVENT
                      (
                        EVENT_ID NUMBER(15),
                        EVENT_DESC VARCHAR2(4000),
                        TYPE_ID NUMBER(15),
                        EVENT_FLAG VARCHAR2(1)
                      )';
    --- Comentarios de la tabla.
    dbms_output.put_line('SCRIPT: Comentarios de la tabla...');
    EXECUTE IMMEDIATE 'comment on table JLV_EVENT is ''EVENTOS''';
    EXECUTE IMMEDIATE 'comment on column JLV_EVENT.EVENT_ID is ''CODIGO EVENTO''';
    EXECUTE IMMEDIATE 'comment on column JLV_EVENT.EVENT_DESC is ''DESCRIPCION EVENTO''';
    EXECUTE IMMEDIATE 'comment on column JLV_EVENT.TYPE_ID is ''CODIGO TIPO EVENTO''';
    EXECUTE IMMEDIATE 'comment on column JLV_EVENT.EVENT_FLAG is ''EVENTO ACTIVO''';
  
    --- Indices
    dbms_output.put_line('SCRIPT: Indices...');
    EXECUTE IMMEDIATE 'create index IDX_JLV_EVENT_01 on JLV_EVENT (EVENT_ID)';
    EXECUTE IMMEDIATE 'create index IDX_JLV_EVENT_02 on JLV_EVENT (EVENT_DESC)';
    EXECUTE IMMEDIATE 'create index IDX_JLV_EVENT_03 on JLV_EVENT (TYPE_ID)';
    EXECUTE IMMEDIATE 'create index IDX_JLV_EVENT_04 on JLV_EVENT (EVENT_FLAG)';
    EXECUTE IMMEDIATE 'create index IDX_JLV_EVENT_05 on JLV_EVENT (EVENT_ID,TYPE_ID)';
    EXECUTE IMMEDIATE 'create index IDX_JLV_EVENT_06 on JLV_EVENT (EVENT_ID,TYPE_ID,EVENT_FLAG)';
    EXECUTE IMMEDIATE 'create index IDX_JLV_EVENT_07 on JLV_EVENT (EVENT_ID,EVENT_FLAG)';
    EXECUTE IMMEDIATE 'create index IDX_JLV_EVENT_08 on JLV_EVENT (TYPE_ID,EVENT_FLAG)';
  
    --- llave primaria
    BEGIN
      dbms_output.put_line('SCRIPT: llave primaria...');
      EXECUTE IMMEDIATE 'alter table JLV_EVENT add constraint PK_JLV_EVENT primary key (EVENT_ID)';
    EXCEPTION
      WHEN OTHERS THEN
        dbms_output.put_line('SCRIPT: ERROR CREANDO LLAVE PRIMARI[PK_JLV_EVENT]');
    END;

    -- Create/foreign key constraints 
    EXECUTE IMMEDIATE 'alter table JLV_EVENT add constraint FK_JLV_TYPE_TYPE_ID foreign key (TYPE_ID) references JLV_TYPE (TYPE_ID)';
    
    -- Create/Recreate check constraints 
    dbms_output.put_line('SCRIPT: Chequeo...');    
    EXECUTE IMMEDIATE 'alter table JLV_EVENT add constraint CH_EVENT_FLAG_0 check(EVENT_FLAG in(''S'',''N''))';
  
    dbms_output.put_line('SCRIPT: APLICANDO PERMISOS...');
    --- Aplica Permisos.
    EXECUTE IMMEDIATE 'GRANT SELECT,UPDATE,DELETE,INSERT ON JLV_EVENT TO SYSTEM_OBJ_PRIVS_ROLE';
    --- Fin.
  
    Dbms_Output.Put_Line('Fin Creacion tabla JLV_EVENT');
  END IF;
  CLOSE cuTabla;
  ----Fin Creacion de entidad JLV_EVENT

  ----Inicio Creacion de entidad JLV_AVAILABILITY
  Dbms_Output.Put_Line('Inicia Creacion tabla JLV_AVAILABILITY');

  OPEN cuTabla('JLV_AVAILABILITY');
  FETCH cuTabla
    INTO rccuTabla;

  IF (cuTabla%NOTFOUND) THEN
  
    Dbms_Output.Put_Line('Inicia Crea JLV_AVAILABILITY');
  
    EXECUTE IMMEDIATE 'create table JLV_AVAILABILITY
                      (
                        AVAILABILITY_ID NUMBER(15),
                        EVENT_ID NUMBER(15),
                        AVAILABILITY_FEC_INI DATE,
                        AVAILABILITY_FEC_FIN DATE
                      )';
    --- Comentarios de la tabla.
    dbms_output.put_line('SCRIPT: Comentarios de la tabla...');
    EXECUTE IMMEDIATE 'comment on table JLV_AVAILABILITY is ''DISPONIBILIDAD DE EVENTOS''';
    EXECUTE IMMEDIATE 'comment on column JLV_AVAILABILITY.AVAILABILITY_ID is ''CODIGO DISPONIBILIDAD''';
    EXECUTE IMMEDIATE 'comment on column JLV_AVAILABILITY.EVENT_ID is ''CODIGO EVENTO''';
    EXECUTE IMMEDIATE 'comment on column JLV_AVAILABILITY.AVAILABILITY_FEC_INI is ''FECHA INICIO''';
    EXECUTE IMMEDIATE 'comment on column JLV_AVAILABILITY.AVAILABILITY_FEC_FIN is ''FECHA FIN''';
  
    --- Indices
    dbms_output.put_line('SCRIPT: Indices...');
    EXECUTE IMMEDIATE 'create index IDX_JLV_AVAILABILITY_01 on JLV_AVAILABILITY (AVAILABILITY_ID)';
    EXECUTE IMMEDIATE 'create index IDX_JLV_AVAILABILITY_02 on JLV_AVAILABILITY (EVENT_ID)';
    EXECUTE IMMEDIATE 'create index IDX_JLV_AVAILABILITY_03 on JLV_AVAILABILITY (AVAILABILITY_FEC_INI)';
    EXECUTE IMMEDIATE 'create index IDX_JLV_AVAILABILITY_04 on JLV_AVAILABILITY (AVAILABILITY_FEC_FIN)';
    EXECUTE IMMEDIATE 'create index IDX_JLV_AVAILABILITY_05 on JLV_AVAILABILITY (AVAILABILITY_ID,EVENT_ID)';
    EXECUTE IMMEDIATE 'create index IDX_JLV_AVAILABILITY_06 on JLV_AVAILABILITY (EVENT_ID,AVAILABILITY_FEC_INI,AVAILABILITY_FEC_FIN)';
    EXECUTE IMMEDIATE 'create index IDX_JLV_AVAILABILITY_07 on JLV_AVAILABILITY (AVAILABILITY_FEC_INI,AVAILABILITY_FEC_FIN)';
  
    --- llave primaria
    BEGIN
      dbms_output.put_line('SCRIPT: llave primaria...');
      EXECUTE IMMEDIATE 'alter table JLV_AVAILABILITY add constraint PK_JLV_AVAILABILITY primary key (AVAILABILITY_ID)';
    EXCEPTION
      WHEN OTHERS THEN
        dbms_output.put_line('SCRIPT: ERROR CREANDO LLAVE PRIMARI[PK_JLV_AVAILABILITY]');
    END;

    -- Create/foreign key constraints 
    EXECUTE IMMEDIATE 'alter table JLV_AVAILABILITY add constraint FK_JLV_AVAILABILITY_EVENT_ID foreign key (EVENT_ID) references JLV_EVENT (EVENT_ID)';
    

    dbms_output.put_line('SCRIPT: APLICANDO PERMISOS...');
    --- Aplica Permisos.
    EXECUTE IMMEDIATE 'GRANT SELECT,UPDATE,DELETE,INSERT ON JLV_AVAILABILITY TO SYSTEM_OBJ_PRIVS_ROLE';
    --- Fin.
  
    Dbms_Output.Put_Line('Fin Creacion tabla JLV_AVAILABILITY');
  END IF;
  CLOSE cuTabla;
  ----Fin Creacion de entidad JLV_AVAILABILITY

  ----Inicio Creacion de entidad JLV_HISTORIC
  Dbms_Output.Put_Line('Inicia Creacion tabla JLV_HISTORIC');

  OPEN cuTabla('JLV_HISTORIC');
  FETCH cuTabla
    INTO rccuTabla;

  IF (cuTabla%NOTFOUND) THEN
  
    Dbms_Output.Put_Line('Inicia Crea JLV_HISTORIC');
  
    EXECUTE IMMEDIATE 'create table JLV_HISTORIC
                      (
                        HISTORIC_ID NUMBER(15),
                        USUARIO_ID VARCHAR2(30),
                        EVENT_ID NUMBER(15),
                        AVAILABILITY_FEC_INI DATE,
                        AVAILABILITY_FEC_FIN DATE,
                        EVENT_FLAG VARCHAR2(1)
                      )';
    --- Comentarios de la tabla.
    dbms_output.put_line('SCRIPT: Comentarios de la tabla...');
    EXECUTE IMMEDIATE 'comment on table JLV_HISTORIC is ''HISTORICOS''';
    EXECUTE IMMEDIATE 'comment on column JLV_HISTORIC.HISTORIC_ID is ''CODIGO HISTORICO''';
    EXECUTE IMMEDIATE 'comment on column JLV_HISTORIC.USUARIO_ID is ''USUARIO REAIZA CAMBIO''';
    EXECUTE IMMEDIATE 'comment on column JLV_HISTORIC.EVENT_ID is ''CODIGO EVENTO''';
    EXECUTE IMMEDIATE 'comment on column JLV_HISTORIC.AVAILABILITY_FEC_INI is ''HISTORICO ACTIVO''';
    EXECUTE IMMEDIATE 'comment on column JLV_HISTORIC.AVAILABILITY_FEC_FIN is ''HISTORICO ACTIVO''';
    EXECUTE IMMEDIATE 'comment on column JLV_HISTORIC.EVENT_FLAG is ''HISTORICO ACTIVO''';
  
    --- Indices
    dbms_output.put_line('SCRIPT: Indices...');
    EXECUTE IMMEDIATE 'create index IDX_JLV_HISTORIC_01 on JLV_HISTORIC (HISTORIC_ID)';
    EXECUTE IMMEDIATE 'create index IDX_JLV_HISTORIC_02 on JLV_HISTORIC (HISTORIC_DESC)';
    EXECUTE IMMEDIATE 'create index IDX_JLV_HISTORIC_03 on JLV_HISTORIC (TYPE_ID)';
    EXECUTE IMMEDIATE 'create index IDX_JLV_HISTORIC_04 on JLV_HISTORIC (HISTORIC_FLAG)';
    EXECUTE IMMEDIATE 'create index IDX_JLV_HISTORIC_05 on JLV_HISTORIC (HISTORIC_ID,TYPE_ID)';
    EXECUTE IMMEDIATE 'create index IDX_JLV_HISTORIC_06 on JLV_HISTORIC (HISTORIC_ID,TYPE_ID,HISTORIC_FLAG)';
    EXECUTE IMMEDIATE 'create index IDX_JLV_HISTORIC_07 on JLV_HISTORIC (HISTORIC_ID,HISTORIC_FLAG)';
    EXECUTE IMMEDIATE 'create index IDX_JLV_HISTORIC_08 on JLV_HISTORIC (TYPE_ID,HISTORIC_FLAG)';
  
    --- llave primaria
    BEGIN
      dbms_output.put_line('SCRIPT: llave primaria...');
      EXECUTE IMMEDIATE 'alter table JLV_HISTORIC add constraint PK_JLV_HISTORIC primary key (HISTORIC_ID)';
    EXCEPTION
      WHEN OTHERS THEN
        dbms_output.put_line('SCRIPT: ERROR CREANDO LLAVE PRIMARI[PK_JLV_HISTORIC]');
    END;

    -- Create/foreign key constraints 
    EXECUTE IMMEDIATE 'alter table JLV_HISTORIC add constraint FK_JLV_TYPE_TYPE_ID foreign key (TYPE_ID) references JLV_TYPE (TYPE_ID)';
    
    -- Create/Recreate check constraints 
    dbms_output.put_line('SCRIPT: Chequeo...');    
    EXECUTE IMMEDIATE 'alter table JLV_HISTORIC add constraint CH_EVENT_FLAG_0 check(EVENT_FLAG in(''S'',''N''))';
  
    dbms_output.put_line('SCRIPT: APLICANDO PERMISOS...');
    --- Aplica Permisos.
    EXECUTE IMMEDIATE 'GRANT SELECT,UPDATE,DELETE,INSERT ON JLV_HISTORIC TO SYSTEM_OBJ_PRIVS_ROLE';
    --- Fin.
  
    Dbms_Output.Put_Line('Fin Creacion tabla JLV_HISTORIC');
  END IF;
  CLOSE cuTabla;
  ----Fin Creacion de entidad JLV_HISTORIC

END;
/
