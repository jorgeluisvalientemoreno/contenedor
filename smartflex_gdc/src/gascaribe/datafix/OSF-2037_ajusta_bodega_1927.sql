column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare
  nuBalance number;
  nuQuota number;
begin

   execute immediate 'alter trigger TRG_OR_UNI_ITEM_BALA_MOV disable';

    select a.balance, a.quota
    into nuBalance, nuQuota
    from  or_ope_uni_item_bala a
    where a.operating_unit_id=1927
      and a.items_id=4294784;


    update or_ope_uni_item_bala a
      set a.balance=3
    where a.operating_unit_id=1927
      and a.items_id=4294784;

    commit;


    execute immediate 'alter trigger TRG_OR_UNI_ITEM_BALA_MOV enable';
    dbms_output.put_line('Se actualizo balance a 3 de la bodega 1927 - SM MTTO CUARTO DE EMERGENCIAS');


exception 
when others then
rollback;
execute immediate 'alter trigger TRG_OR_UNI_ITEM_BALA_MOV enable';
dbms_output.put_line('No se actualizo balance de la bodega 1927 - SM MTTO CUARTO DE EMERGENCIAS - ' || sqlerrm);
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/