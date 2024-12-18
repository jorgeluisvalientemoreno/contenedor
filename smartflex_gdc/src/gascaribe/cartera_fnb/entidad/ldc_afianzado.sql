DECLARE
  CURSOR cuTabla(sbTable VARCHAR2) IS
    SELECT * FROM all_tables WHERE upper(TABLE_NAME) = upper(sbTable);

  rccuTabla cuTabla%ROWTYPE;

BEGIN
  Dbms_Output.Put_Line('Inicia Creacion tabla ldc_afianzado');
  OPEN cuTabla('ldc_afianzado');
  FETCH cuTabla
    INTO rccuTabla;

  IF (cuTabla%NOTFOUND) THEN
  
    Dbms_Output.Put_Line('Inicia Crea ldc_afianzado');
  
    EXECUTE IMMEDIATE 'create table ldc_afianzado
               (
                   product_id NUMBER(15) NOT null,
                   block VARCHAR2(1) default ''Y'' not null,
                   created_at DATE,
                   updated_at DATE
                )';
    --- Comentarios de la tabla y campos.
    EXECUTE IMMEDIATE 'comment on table ldc_afianzado is ''Configuracion de items que se les aplicara Sobretasa RETEICA''';
    EXECUTE IMMEDIATE 'comment on column ldc_afianzado.product_id is ''Producto Brilla''';
    EXECUTE IMMEDIATE 'comment on column ldc_afianzado.block is ''Flag si indica que esta bloqueado por fianza Y o N''';
    EXECUTE IMMEDIATE 'comment on column ldc_afianzado.created_at is ''Fecha Creacion''';
    EXECUTE IMMEDIATE 'comment on column ldc_afianzado.updated_at is ''Fecha Actualiza''';
  
    --Llaves  
    dbms_output.put_line('SCRIPT: APLICANDO LLAVE PRIMARIA...');
    EXECUTE IMMEDIATE 'alter table ldc_afianzado add constraint pk_afianzado primary key (product_id)';
  
    dbms_output.put_line('SCRIPT: APLICANDO INDICE...');
    EXECUTE IMMEDIATE 'create index IDX_afianzado_01 on ldc_afianzado (block)';
    EXECUTE IMMEDIATE 'create index IDX_afianzado_02 on ldc_afianzado (created_at)';
    EXECUTE IMMEDIATE 'create index IDX_afianzado_03 on ldc_afianzado (updated_at)';
  
    dbms_output.put_line('SCRIPT: APLICANDO PERMISOS...');
    --- Aplica Permisos.
    EXECUTE IMMEDIATE 'GRANT SELECT,UPDATE,DELETE,INSERT ON ldc_afianzado TO SYSTEM_OBJ_PRIVS_ROLE';
    EXECUTE IMMEDIATE 'GRANT SELECT ON ldc_afianzado TO REPORTES';
    EXECUTE IMMEDIATE 'GRANT SELECT ON ldc_afianzado TO RSELOPEN';
    --- Fin.
  
    Dbms_Output.Put_Line('Fin Creacion tabla ldc_afianzado');
  ELSE
    Dbms_Output.Put_Line('***************tabla ldc_afianzado ya existe');
  END IF;
  CLOSE cuTabla;

END;
/
