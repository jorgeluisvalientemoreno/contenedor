column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare

  cursor cuMovimiento is
    select ouibm.*
      from or_uni_item_bala_mov ouibm
     where ouibm.operating_unit_id = 3020
       and ouibm.items_id = 10000593
       and ouibm.item_moveme_caus_id = -1
       and ouibm.movement_type = 'D'
       and trunc(ouibm.move_date) = trunc(sysdate);     

  rfMovimiento cuMovimiento%rowtype;

begin

  execute immediate 'alter trigger TRG_OR_UNI_ITEM_BALA_MOV disable';

  update or_ope_uni_item_bala a
     set balance = balance - 1
   where a.operating_unit_id = 3020
     and a.items_id = 10000593;

  commit;  

  open cuMovimiento;
  fetch cuMovimiento
    into rfMovimiento;
  if cuMovimiento%found then
    update or_uni_item_bala_mov ouibm
       set ouibm.comments = 'CASO OSF-3476'
     where ouibm.uni_item_bala_mov_id = rfMovimiento.uni_item_bala_mov_id;       
  end if;
  close cuMovimiento;

  commit;

  execute immediate 'alter trigger TRG_OR_UNI_ITEM_BALA_MOV enable';
  dbms_output.put_line('Se actualizo balance a 0 del item [10000593 - MEDIDOR 37 M3H DIAF 30 LT IZQ] en la bodega [3020 - CUARTO DE EMERGENCIA GASCARIBE BQ]');

exception
  when others then
    rollback;
    execute immediate 'alter trigger TRG_OR_UNI_ITEM_BALA_MOV enable';
    dbms_output.put_line('No se actualizo balance a 0 del item [10000593 - MEDIDOR 37 M3H DIAF 30 LT IZQ] en la bodega [3020 - CUARTO DE EMERGENCIA GASCARIBE BQ] - Error: ' ||
                         sqlerrm);
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/