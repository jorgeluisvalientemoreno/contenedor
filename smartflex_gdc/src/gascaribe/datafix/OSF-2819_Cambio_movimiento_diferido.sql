column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX OSF-2819');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare
    nuCont   NUMBER;
begin
    dbms_output.put_line('Inicia Actualización Datafix OSF-2819 !');
    nuCont := 0;
    UPDATE movidife
       SET modicuap = 1 
    WHERE modidife = 11295310 
      AND modisusc = 17157352
      AND modicuap = 0 
      AND modisign = 'CR'
    RETURNING COUNT(1) INTO nuCont;
    commit;
    dbms_output.put_line('Registros actualizados en MOVIDIFE del contrato 17157352: '||nuCont);
    dbms_output.put_line('Fin Actualización Datafix OSF-2819 !');
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/