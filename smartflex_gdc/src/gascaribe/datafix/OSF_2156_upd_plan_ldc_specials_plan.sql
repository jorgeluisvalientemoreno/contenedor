column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE
  gsbMensaje VARCHAR2(200) := 'DATAFIX OSF-2156 ';

  cursor culdc_specials_plan is
    select * from 
    open.ldc_specials_plan 
    where plan_id = 144;
   
  rfculdc_specials_plan culdc_specials_plan%rowtype;

BEGIN

  dbms_output.put_line('Inico ' || gsbMensaje);

  for rfculdc_specials_plan in culdc_specials_plan loop
  
    
      UPDATE open.ldc_specials_plan 
         SET plan_id = 143
       WHERE specials_plan_id = rfculdc_specials_plan.specials_plan_id;
      COMMIT;

      dbms_output.put_line('Actualizar plan[' ||
                           rfculdc_specials_plan.PLAN_ID ||
                           '] del producto: ' ||
                           rfculdc_specials_plan.product_id ||', contrato:'
                           ||rfculdc_specials_plan.subscription_id||', plan especial:'
                           ||rfculdc_specials_plan.specials_plan_id|| ' por plan [143]');
    
  
  end loop;

  dbms_output.put_line('Fin ' || gsbMensaje);

exception
  when others then
    dbms_output.put_line('Error al actualizar' ||
                         sqlerrm);
    rollback;
  
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/