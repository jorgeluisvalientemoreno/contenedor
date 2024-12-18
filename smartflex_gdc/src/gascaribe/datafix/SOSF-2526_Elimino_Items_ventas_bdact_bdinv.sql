column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin
 -- Elimino ítem de la bodega de inventarios
delete open.ldc_inv_ouib
   where items_id between 4000000 and 4999999;
       
-- Elimino ítems de la bodega de activos
delete open.ldc_act_ouib
   where items_id between 4000000 and 4999999;
    
  commit;
end;
/