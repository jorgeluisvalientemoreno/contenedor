column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare
    nuNuevoEstado number := 5; -- [5 En Uso]
    
    -- Poblacion a la que aplica el Datafix
    cursor cuPoblacion
    is
    select  id_items_seriado, serie, id_items_estado_inv
    from    ge_items_seriado
    where   serie = 'S-1026731-Q';    
begin
  dbms_output.put_line('---- Inicio SOSF-902 ----');
  for reg in cuPoblacion
  loop
    update  ge_items_seriado
    set     id_items_estado_inv = nuNuevoEstado
    where   id_items_seriado = reg.id_items_seriado;
    dbms_output.put_line('Se cambia el item Seriado ['||reg.id_items_seriado||'] con serie ['||reg.serie||'] del estado inventario actual ['||reg.id_items_estado_inv||'] al estado de inventario ['||nuNuevoEstado||']');
  end loop;
  commit;
  dbms_output.put_line('---- Fin SOSF-902 ----');
EXCEPTION
  WHEN OTHERS THEN
    rollback;
    dbms_output.put_line('---- Error SOSF-902 ----');
    DBMS_OUTPUT.PUT_LINE('Error no controlado --> '||sqlerrm);
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/