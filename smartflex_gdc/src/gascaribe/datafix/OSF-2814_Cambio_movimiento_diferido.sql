column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX OSF-2814');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin
    dbms_output.put_line('Inicia Actualización Datafix OSF-2814 !');
    UPDATE movidife
       SET modicuap = 1 
    WHERE modidife = 12366779 
      AND modisusc = 17212908
      AND modicuap = 0 
      AND modisign = 'CR';
    commit;
    dbms_output.put_line('Fin Actualización Datafix OSF-2814 !');
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/