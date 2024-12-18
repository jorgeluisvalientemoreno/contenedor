column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare
    --<< Datos del nuevo estado  
    nuNewStatus   NUMBER := 2;
    -->>

    cursor cuPoblacion
    IS
    SELECT A.* FROM OPEN.SERVSUSC A WHERE A.SESUNUSE = 52129816;
    
begin
  dbms_output.put_line('---- Inicio OSF-756 ----');

  dbms_output.put_line(' ---------------------------->> FALLA # 1 - INICIO'); 
  for reg in cuPoblacion
  loop
    update  OPEN.SERVSUSC
    set     SESUESCO = nuNewStatus
    WHERE   SESUNUSE = reg.SESUNUSE;
    dbms_output.put_line('Actualizando SERVSUSC producto ['||reg.SESUNUSE||'] - SESUESCO Actual ['||reg.SESUESCO||'] Nuevo ['||nuNewStatus||']');
  end loop;

  COMMIT;
  dbms_output.put_line('---- Fin OSF-756 ----');
EXCEPTION
  WHEN OTHERS THEN
    rollback;
    dbms_output.put_line('---- Error OSF-756 ----');
    DBMS_OUTPUT.PUT_LINE('Error no controlado --> '||sqlerrm);
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/