column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin

  begin
    delete from OPEN.LDC_CANT_ASIG_OFER_CART t
     where t.unidad_operatva_cart = 3654
       and t.nuano = 2023
       and t.numes = 9
       and t.nro_acta = -1;
    COMMIT;
    dbms_output.put_line('Se eliminaron los registros del periodo 2023-9 con acta -1');
  exception
    when others then
      rollback;
      dbms_output.put_line('No se eliminaron los registros del periodo 2023-9 con acta -1');
  end;

  begin
    update OPEN.LDC_CANT_ASIG_OFER_CART t
       set t.zona_ofertados = -1
     where t.unidad_operatva_cart = 3654
       and t.nuano = 2023
       and t.numes = 9
       and t.nro_acta = 207710;
    commit;
    dbms_output.put_line('Actualizacion de zona de ofertadoss en -1 al registro de Ordenes del acta 207710');
  exception
    when others then
      rollback;
      dbms_output.put_line('No se actualizacion de zona de ofertadoss en -1 al registro de Ordenes del acta 207710');
  end;

end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/