DECLARE
  nuConta number;
BEGIN
  SELECT COUNT(1)
    INTO nuConta
    FROM dba_tables
   WHERE table_name = 'LDC_GRUPO';

  IF (nuConta = 0) THEN
    EXECUTE IMMEDIATE ' create table OPEN.LDC_GRUPO
                        (
                          grupcodi            NUMBER(15) not null,
                          grupdesc            VARCHAR2(255) not null,
                          gruptamu            NUMBER(15) not null,
                          vigencia_init_date  DATE,
                          vigencia_final_date DATE
                        )
                        tablespace TSD_DEFAULT';
    DBMS_OUTPUT.put_line('Creacion de entidad LDC_GRUPO');
  
    -- Add comments to the table 
    EXECUTE IMMEDIATE 'comment on table OPEN.LDC_GRUPO is ''Tabla informacion de los grupos con su tamano de muestra''';
    DBMS_OUTPUT.put_line('Definicion de comentario de entidad LDC_GRUPO');
  
    -- Add comments to the columns 
    EXECUTE IMMEDIATE 'comment on column OPEN.LDC_GRUPO.grupcodi is ''ID DE LA TABLA''';
    EXECUTE IMMEDIATE 'comment on column OPEN.LDC_GRUPO.grupdesc is ''DESCRIPCION DEL GRUPO''';
    EXECUTE IMMEDIATE 'comment on column OPEN.LDC_GRUPO.gruptamu is ''TAMANO DE LA MUESTRA''';
    EXECUTE IMMEDIATE 'comment on column OPEN.LDC_GRUPO.vigencia_init_date is ''Fecha inicial de Vigencia''';
    EXECUTE IMMEDIATE 'comment on column OPEN.LDC_GRUPO.vigencia_final_date is ''Fecha final de Vigencia''';
    DBMS_OUTPUT.put_line('Definicion de la descripcion de columnas de entidad LDC_GRUPO');
  
    -- Create/Recreate primary, unique and foreign key constraints         
    EXECUTE IMMEDIATE 'alter table OPEN.LDC_GRUPO add constraint PK_LDC_GRUPO primary key (GRUPCODI) using index tablespace TSI_DEFAULT';
    DBMS_OUTPUT.put_line('Creacion de llave primaria');
  
    -- Grant/Revoke object privileges 
    EXECUTE IMMEDIATE 'grant select on OPEN.LDC_GRUPO to REPORTES';
    EXECUTE IMMEDIATE 'grant select on OPEN.LDC_GRUPO to ROLESELOPEN';
    EXECUTE IMMEDIATE 'grant select on OPEN.LDC_GRUPO to RSELOPEN';
    EXECUTE IMMEDIATE 'grant select on OPEN.LDC_GRUPO to RSELUSELOPEN';
    EXECUTE IMMEDIATE 'grant select, insert, update, delete on OPEN.LDC_GRUPO to SYSTEM_OBJ_PRIVS_ROLE;';
    DBMS_OUTPUT.put_line('Creacion de permisos');
  
  END IF;

  SELECT COUNT(1)
    INTO nuConta
    FROM ALL_TAB_COLUMNS
   WHERE table_name = 'LDC_GRUPO'
     AND column_name = 'GRUPMURE';

  IF (nuConta = 0) THEN
    EXECUTE IMMEDIATE 'ALTER TABLE LDC_GRUPO ADD GRUPMURE NUMBER(15)';
    EXECUTE IMMEDIATE 'comment on column OPEN.LDC_GRUPO.GRUPMURE is ''MUESTRAS REQUERIDAS''';
    DBMS_OUTPUT.put_line('Adicion de nueva columna llamada GRUPMURE en la entidad LDC_GRUPO');
  ELSE
    DBMS_OUTPUT.put_line('Ya existe la columna llamada GRUPMURE en la entidad LDC_GRUPO');
  END IF;

END;
/