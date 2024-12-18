column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare
  nuMovimiento number;
begin

   execute immediate 'alter trigger TRG_OR_UNI_ITEM_BALA_MOV disable';

    update or_ope_uni_item_bala a
       set balance=51
    where a.operating_unit_id=799 
      and a.items_id=4295313;

    commit;

    execute immediate 'alter trigger TRG_OR_UNI_ITEM_BALA_MOV enable';
    dbms_output.put_line('Se actualizo balance a 51  del item 4295313 en la bodega 799 - Laboratorio');


exception 
when others then
rollback;
execute immediate 'alter trigger TRG_OR_UNI_ITEM_BALA_MOV enable';
dbms_output.put_line('No se actualizo balance a 51  del item 4295313 en la bodega 799 - Laboratorio - ' || sqlerrm);
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/