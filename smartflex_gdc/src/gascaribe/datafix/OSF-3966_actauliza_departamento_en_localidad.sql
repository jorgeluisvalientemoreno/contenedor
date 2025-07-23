column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare
  nuDepaNuevo    number := 4;
  nuDepaAnterior number := 3;
  sbTabla        varchar2(200);
begin
  begin
    update ge_geogra_location lo
       set lo.geo_loca_father_id  = nuDepaNuevo,
           lo.display_description = replace(display_description,
                                            'ATLANTICO',
                                            'MAGDALENA')
     where lo.geograp_location_id in (101)
       and lo.geo_loca_father_id != nuDepaNuevo;
    commit;
    dbms_output.put_line('Acualiza en ge_geogra_location el Departamento del MAGDALENA para la localidad PALERMO - Se actualiza ' ||
                         sql%rowcount || ' registro(s)');
  exception
    when others then
      rollback;
      dbms_output.put_line('Error al actualizar en ge_geogra_location el Departamento del MAGDALENA para la localidad PALERMO - Error: ' ||
                           sqlerrm);
  end;

  begin
    update crsucopa c
       set c.cscpdepa = nuDepaNuevo
     where cscploca in (101)
       and cscpdepa != nuDepaNuevo;
    commit;
    dbms_output.put_line('Acualiza en crsucopa el Departamento del MAGDALENA para la localidad PALERMO - Se actualiza ' ||
                         sql%rowcount || ' registro(s)');
  exception
    when others then
      rollback;
      dbms_output.put_line('Error al actualizar en crsucopa el Departamento del MAGDALENA para la localidad PALERMO - Error: ' ||
                           sqlerrm);
  end;

  begin
    update ldc_crsucopa c
       set c.cscpdepa = nuDepaNuevo
     where cscploca in (101)
       and cscpdepa != nuDepaNuevo;
    commit;
    dbms_output.put_line('Acualiza en ldc_crsucopa el Departamento del MAGDALENA para la localidad PALERMO - Se actualiza ' ||
                         sql%rowcount || ' registro(s)');
  exception
    when others then
      rollback;
      dbms_output.put_line('Error al actualizar en ldc_crsucopa el Departamento del MAGDALENA para la localidad PALERMO - Error: ' ||
                           sqlerrm);
  end;

  begin
    update ldci_actiubgttra ac
       set ac.acbgdpto = nuDepaNuevo
     where ac.acbgloca in (101)
       and ac.acbgdpto != nuDepaNuevo;
    commit;
    dbms_output.put_line('Acualiza en ldci_actiubgttra el Departamento del MAGDALENA para la localidad PALERMO - Se actualiza ' ||
                         sql%rowcount || ' registro(s)');
  exception
    when others then
      rollback;
      dbms_output.put_line('Error al actualizar en ldci_actiubgttra el Departamento del MAGDALENA para la localidad PALERMO - Error: ' ||
                           sqlerrm);
  end;

  begin
    update ldci_cecoubigetra ce
       set ce.ccbgdpto = nuDepaNuevo
     where ce.ccbgloca in (101)
       and ce.ccbgdpto != nuDepaNuevo;
    commit;
    dbms_output.put_line('Acualiza en ldci_cecoubigetra el Departamento del MAGDALENA para la localidad PALERMO - Se actualiza ' ||
                         sql%rowcount || ' registro(s)');
  exception
    when others then
      rollback;
      dbms_output.put_line('Error al actualizar en ldci_cecoubigetra el Departamento del MAGDALENA para la localidad PALERMO - Error: ' ||
                           sqlerrm);
  end;

  begin
    update ldci_centbenelocal ceb2
       set ceb2.celodpto = nuDepaNuevo
     where ceb2.celoloca in (101)
       and ceb2.celodpto != nuDepaNuevo;
    commit;
    dbms_output.put_line('Acualiza en ldci_centbenelocal el Departamento del MAGDALENA para la localidad PALERMO - Se actualiza ' ||
                         sql%rowcount || ' registro(s)');
  exception
    when others then
      rollback;
      dbms_output.put_line('Error al actualizar en ldci_centbenelocal el Departamento del MAGDALENA para la localidad PALERMO - Error: ' ||
                           sqlerrm);
  end;

  begin
    update ldc_altura_loc loc
       set loc.departamento = nuDepaNuevo
     where loc.localidad in (101)
       and loc.departamento != nuDepaNuevo;
    commit;
    dbms_output.put_line('Acualiza en ldc_altura_loc el Departamento del MAGDALENA para la localidad PALERMO - Se actualiza ' ||
                         sql%rowcount || ' registro(s)');
  exception
    when others then
      rollback;
      dbms_output.put_line('Error al actualizar en ldc_altura_loc el Departamento del MAGDALENA para la localidad PALERMO - Error: ' ||
                           sqlerrm);
  end;

  begin
    --- ciclo
    update ldc_cicldepa cicdep
       set cicdep.cicldepa = nuDepaNuevo
     where cicdep.ciclcodi in (151, 751, 1251)
       and cicdep.cicldepa != nuDepaNuevo;
    commit;
    dbms_output.put_line('Acualiza en ldc_cicldepa el Departamento del MAGDALENA para los ciclos 151, 751, 1251 - Se actualiza ' ||
                         sql%rowcount || ' registro(s)');
  exception
    when others then
      rollback;
      dbms_output.put_line('Error al actualizar en ldc_cicldepa el Departamento del MAGDALENA para los ciclos 151, 751, 1251 - Error: ' ||
                           sqlerrm);
  end;

  begin
    update ldc_config_gest_cobr
       set departamento = nuDepaNuevo
     where localidad in (101)
       and departamento != nuDepaNuevo;
    commit;
    dbms_output.put_line('Acualiza en ldc_config_gest_cobr el Departamento del MAGDALENA para la localidad PALERMO - Se actualiza ' ||
                         sql%rowcount || ' registro(s)');
  exception
    when others then
      rollback;
      dbms_output.put_line('Error al actualizar en ldc_config_gest_cobr el Departamento del MAGDALENA para la localidad PALERMO - Error: ' ||
                           sqlerrm);
  end;

  begin
    --ciclo
    update ldc_config_gest_cobr
       set departamento = nuDepaNuevo
     where ciclo in (151, 751, 1251)
       and departamento != nuDepaNuevo;
    commit;
    dbms_output.put_line('Acualiza en ldc_config_gest_cobr el Departamento del MAGDALENA para los ciclos 151, 751, 1251 - Se actualiza ' ||
                         sql%rowcount || ' registro(s)');
  exception
    when others then
      rollback;
      dbms_output.put_line('Error al actualizar en ldc_config_gest_cobr el Departamento del MAGDALENA para los ciclos 151, 751, 1251 - Error: ' ||
                           sqlerrm);
  end;

  begin
    update ldc_clientedepart
       set depa_id = nuDepaNuevo
     where loca_id in (101)
       and depa_id != nuDepaNuevo;
    commit;
    dbms_output.put_line('Acualiza en ldc_clientedepart el Departamento del MAGDALENA para la localidad PALERMO - Se actualiza ' ||
                         sql%rowcount || ' registro(s)');
  exception
    when others then
      rollback;
      dbms_output.put_line('Error al actualizar en ldc_clientedepart el Departamento del MAGDALENA para la localidad PALERMO - Error: ' ||
                           sqlerrm);
  end;

  begin
    --ciclo
    update ldc_depacatesub_ciclo
       set departamento_id = nuDepaNuevo
     where ciclo_id in (151, 751, 1251)
       and departamento_id != nuDepaNuevo;
    commit;
    dbms_output.put_line('Acualiza en ldc_depacatesub_ciclo el Departamento del MAGDALENA para los ciclos 151, 751, 1251 - Se actualiza ' ||
                         sql%rowcount || ' registro(s)');
  exception
    when others then
      rollback;
      dbms_output.put_line('Error al actualizar en ldc_depacatesub_ciclo el Departamento del MAGDALENA para los ciclos 151, 751, 1251 - Error: ' ||
                           sqlerrm);
  end;

  begin
  
    update manzanas
       set manzdepa = nuDepaNuevo
     where manzloca in (101)
       and manzdepa != nuDepaNuevo;
  
    commit;
    dbms_output.put_line('Acualiza en manzanas el Departamento del MAGDALENA para la localidad PALERMO - Se actualiza ' ||
                         sql%rowcount || ' registro(s)');
  exception
    when others then
      rollback;
      dbms_output.put_line('Error al actualizar en manzanas el Departamento del MAGDALENA para la localidad PALERMO - Error: ' ||
                           sqlerrm);
  end;

  begin
    update histreti
       set HSREMZDE = nuDepaNuevo
     where hsremzlo in (101)
       and HSREMZDE != nuDepaNuevo;
    commit;
    dbms_output.put_line('Acualiza en histreti el Departamento del MAGDALENA para la localidad PALERMO - Se actualiza ' ||
                         sql%rowcount || ' registro(s)');
  exception
    when others then
      rollback;
      dbms_output.put_line('Error al actualizar en histreti el Departamento del MAGDALENA para la localidad PALERMO - Error: ' ||
                           sqlerrm);
  end;

end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/