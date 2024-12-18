column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin
-- Actualizo saldo de items en bodega 799
 Update OPEN.OR_OPE_UNI_ITEM_BALA a
   set a.balance = 2
 where a.items_id = 10007062
   and a.operating_unit_id = 799;

Update OPEN.OR_OPE_UNI_ITEM_BALA a
   set a.balance = 2
 where a.items_id = 10004070
   and a.operating_unit_id = 799;

Update OPEN.OR_OPE_UNI_ITEM_BALA a
   set a.balance = 1
 where a.items_id = 10000593
   and a.operating_unit_id = 799;

Update OPEN.OR_OPE_UNI_ITEM_BALA a
   set a.balance = 1
 where a.items_id = 10003861
   and a.operating_unit_id = 799;

Update OPEN.OR_OPE_UNI_ITEM_BALA a
   set a.balance = 0
 where a.items_id = 10002106
   and a.operating_unit_id = 799;

commit;
-- Actualizo el ítem del item seriado
update open.ge_items_seriado s
   set s.items_id = 10002106
 where s.serie = 'S-1100720-T';
commit;
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/