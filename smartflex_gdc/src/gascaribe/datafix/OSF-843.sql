column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

BEGIN
  dbms_output.put_line('Inicia Elimina SALDOS POR ITEMS MATERIALES INVENTARIOS POR UNIDAD OPERATIVA');
  DELETE FROM LDC_INV_OUIB where ITEMS_ID = 10004070 AND OPERATING_UNIT_ID = 3503;

  -- Se elimina activo
  DELETE FROM ldc_act_ouib o2
  WHERE o2.items_id = 10004070
  AND   o2.operating_unit_id = 3503;

  COMMIT;
  dbms_output.put_line('Finaliza Elimina SALDOS POR ITEMS MATERIALES INVENTARIOS POR UNIDAD OPERATIVA');
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/