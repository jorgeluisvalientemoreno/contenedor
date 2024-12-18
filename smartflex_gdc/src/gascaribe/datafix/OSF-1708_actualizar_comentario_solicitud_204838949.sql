column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE
BEGIN
  UPDATE open.mo_data_change
     SET entity_attr_new_val = 'VIDAL D ACUNTI'
   WHERE mo_data_change.motive_id =
         (select mm.motive_id
            from open.mo_motive mm
           where mm.package_id = 204838949)
     AND mo_data_change.entity_name = 'GE_SUBSCRIBER'
     AND mo_data_change.entity_pk = 388005
     AND mo_data_change.attribute_name = 'SUBS_LAST_NAME';

  COMMIT;
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/