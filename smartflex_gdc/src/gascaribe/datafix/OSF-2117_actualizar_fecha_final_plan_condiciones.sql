column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE

  --CT_CONPLA_CON_TYPE (Plan de Condiciones por Contrato) 
  CURSOR cuPlanCondicionesContrato IS
    select *
      from open.CT_CONPLA_CON_TYPE ccct
     where ccct.contract_id in (1157,
                                1160,
                                1166,
                                1167,
                                1168,
                                1169,
                                1170,
                                1171,
                                1172,
                                1173,
                                1174,
                                1175,
                                3941,
                                4061,
                                4861,
                                8581,
                                8661,
                                8841,
                                9001,
                                9161,
                                9382)
       and ccct.flag_type = 'C';

  rfcuPlanCondicionesContrato cuPlanCondicionesContrato%rowtype;

BEGIN
  FOR rfcuPlanCondicionesContrato IN cuPlanCondicionesContrato LOOP
  
    begin
      dbms_output.put_line('-------------------------------------------------');
      dbms_output.put_line('Contrato: ' ||
                           rfcuPlanCondicionesContrato.contract_id ||
                           ' con plan de condiciones: ' ||
                           rfcuPlanCondicionesContrato.conditions_plan_id);
    
      update CT_CONPLA_CON_TYPE ccct
         set ccct.end_date = to_date('31/12/4732 23:59:59',
                                     'DD/MM/YYYY HH24:MI:SS')
       where ccct.contract_id = rfcuPlanCondicionesContrato.contract_id
         and ccct.conditions_plan_id =
             rfcuPlanCondicionesContrato.conditions_plan_id
         and ccct.flag_type = 'C';
      commit;
    
      dbms_output.put_line('Fecha final anterior del plan de condiciones: ' ||
                           rfcuPlanCondicionesContrato.end_date);
      dbms_output.put_line('Fecha final actualizada del plan de condiciones: ' ||
                           to_date('31/12/4732 23:59:59',
                                   'DD/MM/YYYY HH24:MI:SS'));
    exception
      when others then
        rollback;
        dbms_output.put_line('Error: ' || sqlerrm);
    end;
  END LOOP;
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/

        