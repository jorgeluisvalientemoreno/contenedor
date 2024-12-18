column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare
  
    nuCantidad NUMBER;
   
begin

    --select * from open.mo_packages_asso a where a.package_id = 194845907  
    update open.mo_packages_asso a set a.annul_dependent = 'N' where a.package_id = 194845907;
    commit;

    WF_BOEIFINSTANCE.RecoverInstance(-1911950393);
    
    update open.mo_packages_asso a set a.annul_dependent = 'Y' where a.package_id = 194845907;    
    commit;

  dbms_output.put_line('Se actualiza campo annul_dependent a estado N de la solicitud 194845907');

exception
  when no_data_found then
    rollback;
    dbms_output.put_line('Error actualizando campo annul_dependent a estado N');
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/