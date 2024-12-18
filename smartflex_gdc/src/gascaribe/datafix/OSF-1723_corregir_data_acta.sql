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
       and t.nro_acta = 207710
       and t.zona_ofertados = 4;
    COMMIT;
    dbms_output.put_line('Se eliminaron registro del periodo 2023-9 con acta 207710 de la zona ofertados 4');
  exception
    when others then
      rollback;
      dbms_output.put_line('No se eliminaron registro del periodo 2023-9 con acta 207710 de la zona ofertados 4 - ' ||
                           sqlerrm);
  end;

  begin
    delete from OPEN.LDC_CANT_ASIG_OFER_CART t
     where t.unidad_operatva_cart = 3654
       and t.nuano = 2023
       and t.numes = 9
       and t.nro_acta = 207710
       and t.zona_ofertados = 8;
    COMMIT;
    dbms_output.put_line('Se eliminaron registro del periodo 2023-9 con acta 207710 de la zona ofertados 8');
  exception
    when others then
      rollback;
      dbms_output.put_line('No se eliminaron registro del periodo 2023-9 con acta 207710 de la zona ofertados 8 - ' ||
                           sqlerrm);
  end;

  begin
    update OPEN.LDC_CANT_ASIG_OFER_CART t
       set t.zona_ofertados    = -1,
           t.cantidad_asignada = 12,
           t.reg_activo        = 'Y'
     where t.unidad_operatva_cart = 3654
       and t.nuano = 2023
       and t.numes = 9
       and t.zona_ofertados = 1
       and t.actividad = 100008222
       and t.nro_acta = 207710;
    commit;
    dbms_output.put_line('Actualizacion de zona de ofertados en -1 de la actividad 100008222 al registro de Ordenes del acta 207710');
  exception
    when others then
      rollback;
      dbms_output.put_line('No se actualizacion de zona de ofertados en -1 de la actividad 100008222 al registro de Ordenes del acta 207710 - ' ||
                           sqlerrm);
  end;

  begin
    update OPEN.LDC_CANT_ASIG_OFER_CART t
       set t.zona_ofertados    = -1,
           t.reg_activo        = 'Y'
     where t.unidad_operatva_cart = 3654
       and t.nuano = 2023
       and t.numes = 9
       and t.zona_ofertados = 1
       and t.actividad = 100008310
       and t.nro_acta = 207710;
    commit;
    dbms_output.put_line('Actualizacion de zona de ofertados en -1 de la actividad 100008310 al registro de Ordenes del acta 207710');
  exception
    when others then
      rollback;
      dbms_output.put_line('No se actualizacion de zona de ofertados en -1 de la actividad 100008310 al registro de Ordenes del acta 207710 - ' ||
                           sqlerrm);
  end;

end;
/


select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/