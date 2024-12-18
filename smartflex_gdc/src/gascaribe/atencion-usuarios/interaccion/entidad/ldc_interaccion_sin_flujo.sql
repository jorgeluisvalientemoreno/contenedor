DECLARE
  CURSOR cuTabla(sbTable VARCHAR2) IS
    SELECT * FROM all_tables WHERE upper(TABLE_NAME) = upper(sbTable);

  rccuTabla cuTabla%ROWTYPE;

BEGIN

  --Validacion de existencia de entidad
  OPEN cuTabla('ldc_interaccion_sin_flujo');
  FETCH cuTabla
    INTO rccuTabla;

  IF (cuTabla%NOTFOUND) THEN
  
    Dbms_Output.Put_Line('Creacion entidad ldc_interaccion_sin_flujo');
  
    EXECUTE IMMEDIATE 'create table ldc_interaccion_sin_flujo
               (
                   package_id NUMBER(15) not null,
                   parcial VARCHAR2(1) default ''N'' not null,
                   procesado VARCHAR2(1) default ''N'' not null,
                   mensaje varchar2(4000),
                   created_at date default sysdate not null,
                   update_at date
                )';
    --- Comentarios de la tabla y campos.
    EXECUTE IMMEDIATE 'comment on table ldc_interaccion_sin_flujo is ''Control de Interaccion asociadas a las solciitudes''';
    EXECUTE IMMEDIATE 'comment on column ldc_interaccion_sin_flujo.package_id is ''Codigo Interaccion''';
    EXECUTE IMMEDIATE 'comment on column ldc_interaccion_sin_flujo.parcial is ''Flag S(Si) o N(No) Indicando que se atendio una solicitud asociada a la interaccion''';
    EXECUTE IMMEDIATE 'comment on column ldc_interaccion_sin_flujo.procesado is ''Flag S(Si) o N(No) Indicando que se atendieron todas las solicitudes asociadas a la interaccion''';
    EXECUTE IMMEDIATE 'comment on column ldc_interaccion_sin_flujo.mensaje is ''Mensaje de error generado al procesar la interaccion sin flujo''';    
    EXECUTE IMMEDIATE 'comment on column ldc_interaccion_sin_flujo.created_at is ''Fecha creacion''';    
    EXECUTE IMMEDIATE 'comment on column ldc_interaccion_sin_flujo.update_at is ''Fecha actualizacion''';    
  
    --Llaves  
    dbms_output.put_line('APLICANDO LLAVE PRIMARIA...');
    EXECUTE IMMEDIATE 'alter table ldc_interaccion_sin_flujo add constraint pk_interaccion_sin_flujo primary key (package_id)';
  
    dbms_output.put_line('APLICANDO INDICE...');
    EXECUTE IMMEDIATE 'create index IDX_interaccion_sin_flujo_01 on ldc_interaccion_sin_flujo (parcial)';
    EXECUTE IMMEDIATE 'create index IDX_interaccion_sin_flujo_02 on ldc_interaccion_sin_flujo (procesado)';
    EXECUTE IMMEDIATE 'create index IDX_interaccion_sin_flujo_03 on ldc_interaccion_sin_flujo (parcial,procesado)';
    EXECUTE IMMEDIATE 'create index IDX_interaccion_sin_flujo_04 on ldc_interaccion_sin_flujo (package_id,parcial,procesado)';
    EXECUTE IMMEDIATE 'create index IDX_interaccion_sin_flujo_05 on ldc_interaccion_sin_flujo (created_at)';
    EXECUTE IMMEDIATE 'create index IDX_interaccion_sin_flujo_06 on ldc_interaccion_sin_flujo (update_at)';
    EXECUTE IMMEDIATE 'create index IDX_interaccion_sin_flujo_07 on ldc_interaccion_sin_flujo (created_at,update_at)';
    EXECUTE IMMEDIATE 'create index IDX_interaccion_sin_flujo_08 on ldc_interaccion_sin_flujo (package_id,created_at,update_at)';
  
    dbms_output.put_line('APLICANDO PERMISOS...');
    --- Aplica Permisos.
    EXECUTE IMMEDIATE 'GRANT SELECT,UPDATE,DELETE,INSERT ON ldc_interaccion_sin_flujo TO SYSTEM_OBJ_PRIVS_ROLE';
    EXECUTE IMMEDIATE 'GRANT SELECT ON ldc_interaccion_sin_flujo TO REPORTES';
    EXECUTE IMMEDIATE 'GRANT SELECT ON ldc_interaccion_sin_flujo TO RSELOPEN';
    --- Fin.
  
    Dbms_Output.Put_Line('Fin Creacion tabla ldc_interaccion_sin_flujo');
  ELSE
    Dbms_Output.Put_Line('***************tabla ldc_interaccion_sin_flujo ya existe');
  END IF;
  CLOSE cuTabla;

END;
/
