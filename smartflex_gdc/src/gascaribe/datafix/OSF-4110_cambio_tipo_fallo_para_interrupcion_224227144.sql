column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE
  nuError number;
BEGIN

  BEGIN

    update open.tt_damage d
       set d.reg_damage_type_id = 100105, d.final_damage_type_id = 100105
     where d.package_id = 224227144;
  
    commit;
    dbms_output.put_line('Se actualiza en la interrupcion 224227144 el tipo de fallo 100005 - AUSENCIA DE GAS  IMPUTABLE A LA EMPRESA al nuevo 100105 - AUSENCIA DE GAS NO IMPUTABLE');
  
  EXCEPTION
  
    when OTHERS then
      Rollback;
      dbms_output.put_line('No actualizo en la interrupcion 224227144 el tipo de fallo 100005 - AUSENCIA DE GAS  IMPUTABLE A LA EMPRESA al nuevo 100105 - AUSENCIA DE GAS NO IMPUTABLE - ' ||
                           sqlerrm);
  
  END;
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/