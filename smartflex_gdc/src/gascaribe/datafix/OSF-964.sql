column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

BEGIN
  dbms_output.put_line('Inicia Elimina SALDOS POR ITEMS MATERIALES INVENTARIOS POR UNIDAD OPERATIVA');

  -- Se elimina inventario
  DELETE FROM LDC_INV_OUIB 
  where ITEMS_ID in (select items_id from ge_items where item_classif_id  not in (3))
  AND OPERATING_UNIT_ID = 3349
  and total_costs = 0;

  -- Se elimina activo
  DELETE FROM ldc_act_ouib o2
  WHERE o2.items_id in (select items_id from ge_items where item_classif_id  not in (3))
  AND   o2.operating_unit_id = 3349
  and   o2.total_costs = 0;

  COMMIT;
  dbms_output.put_line('Finaliza Elimina SALDOS POR ITEMS MATERIALES INVENTARIOS POR UNIDAD OPERATIVA');
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/