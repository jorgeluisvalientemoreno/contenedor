column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare
  nuDepaNuevo     number:= 8962;
  nuDepaAnterior  number:= 3;
  sbTabla         varchar2(200);
begin
  begin
    update ge_geogra_location lo 
      set lo.geo_loca_father_id=nuDepaNuevo,
          lo.display_description = replace(replace(display_description,'ATLANTICO','BOLIVAR'),'MAGDALENA','BOLIVAR') 
    where lo.geograp_location_id in (123,53,88,8429,8663,69,134,60,139,82,89,50,122,130,107,54,94)
      and lo.geo_loca_father_id  != nuDepaNuevo;
    dbms_output.put_line('Localidad padre actualizada correctamente actualizados : '||sql%rowcount ||' registros');
    commit;
  exception
     when others then
      rollback;
      dbms_output.put_line('Error al actualizar ge_geogra_location '||sqlerrm);
  end;

  begin
    insert into ldc_unit_rp_plamin 
    select p1.anio, 
           p1.mes, 
           nuDepaNuevo as departamento, 
           p1.operating_unit_id
      from  ldc_unit_rp_plamin p1
     where departamento=nuDepaAnterior
       and not exists(select null from ldc_unit_rp_plamin p2 where p1.anio=p2.anio and p1.mes=p2.mes and p2.departamento=nuDepaNuevo);
    dbms_output.put_line('insert a ldc_unit_rp_plamin terminó correctamente. Registros insertados '|| sql%rowcount );
    commit;
  exception
    when others then
      rollback;
      dbms_output.put_line('Error al insertar ldc_unit_rp_plamin '||sqlerrm);
  end;  

  begin
    insert into ldc_notif_packtype 
    select p1.package_type_id,  
           nuDepaNuevo as departamento, 
           p1.person_id 
      from open.ldc_notif_packtype p1 
     where p1.departamento = nuDepaAnterior
      and not exists(select null 
                       from open.ldc_notif_packtype p2 
                      where p1.package_type_id = p2.package_type_id 
                        and p2.departamento = nuDepaNuevo 
                        and p1.person_id = p2.person_id);
    dbms_output.put_line('insert a ldc_notif_packtype terminó correctamente. Registros insertados '||sql%rowcount);
    commit;
  exception
     when others then
      rollback;
      dbms_output.put_line('Error al insertar ldc_notif_packtype '||sqlerrm); 
  end; 

  begin
    insert into ldc_detalle1_tt_proceso 
    select d1.ot_proceso_id, 
           d1.email, 
           nuDepaNuevo as departamento 
      from ldc_detalle1_tt_proceso d1 
     where departamento = nuDepaAnterior 
       and not exists(select null 
                        from ldc_detalle1_tt_proceso d2 
                       where d2.ot_proceso_id = d1.ot_proceso_id 
                         and d2.email = d1.email 
                         and d2.departamento = nuDepaNuevo);
    dbms_output.put_line('insert a ldc_notif_packtype terminó correctamente. Registros insertados '||sql%rowcount);
    commit;
  exception
     when others then
      rollback;
      dbms_output.put_line('Error al insertar ldc_notif_packtype '||sqlerrm); 
  end;   

  begin
    sbTabla := 'insertar ldc_tipo_list_depart .';
    insert into ldc_tipo_list_depart
    select consecutivo+9 consecutivo, substr(descripcion, 1, instr(descripcion, '-'))||' BOLIVAR' descripcion, nuDepaNuevo departamento
      from open.ldc_tipo_list_depart d
     where departamento = nuDepaAnterior
       and not exists(select null from open.ldc_tipo_list_depart d2 where d2.consecutivo=d.consecutivo+9);
    dbms_output.put_line('insert a ldc_tipo_list_depart terminó correctamente.Registros insertados '||sql%rowcount);
    
    sbTabla := 'actualizar ldc_loc_tipo_list_dep .';
    update ldc_loc_tipo_list_dep
       set departamento=nuDepaNuevo,
           tipo_lista=decode(tipo_lista,1,10,2,11,3,12, null)
     where localidad in (123,53,88,8429,8663,69,134,60,139,82,89,50,122,130,107,54,94)
       and departamento != nuDepaNuevo;
     dbms_output.put_line('update a ldc_loc_tipo_list_dep terminó correctamente.Registros actualizados '||sql%rowcount);
    commit;

  exception
     when others then
      rollback;
      dbms_output.put_line('Error al '||sbTabla  || sqlerrm); 
  end;   


  begin
    update crsucopa c 
       set c.cscpdepa=nuDepaNuevo  
     where cscploca in (123,53,88,8429,8663,69,134,60,139,82,89,50,122,130,107,54,94)
       and cscpdepa  != nuDepaNuevo;
    dbms_output.put_line('update a crsucopa terminó correctamente. Registros actualizados '||sql%rowcount);
    commit;
  exception
     when others then
      rollback;
      dbms_output.put_line('Error al actualizar crsucopa '||sqlerrm); 
  end;   


  begin
    update ldc_crsucopa c 
       set c.cscpdepa=nuDepaNuevo   
     where cscploca in  (123,53,88,8429,8663,69,134,60,139,82,89,50,122,130,107,54,94)
       and cscpdepa  != nuDepaNuevo;
    dbms_output.put_line('update a ldc_crsucopa terminó correctamente. Registros actualizados '||sql%rowcount);
    commit;
  exception
     when others then
      rollback;
      dbms_output.put_line('Error al actualizar ldc_crsucopa '||sqlerrm); 
  end;   

  begin
    update ldci_actiubgttra ac 
       set ac.acbgdpto = nuDepaNuevo 
     where ac.acbgloca in  (123,53,88,8429,8663,69,134,60,139,82,89,50,122,130,107,54,94)
       and ac.acbgdpto  != nuDepaNuevo;
    dbms_output.put_line('update a ldci_actiubgttra terminó correctamente. Registros actualizados '||sql%rowcount);
    commit;
  exception
     when others then
      rollback;
      dbms_output.put_line('Error al actualizar ldci_actiubgttra '||sqlerrm); 
  end;   
  
  begin
    update ldci_cecoubigetra ce 
       set ce.ccbgdpto = nuDepaNuevo 
     where ce.ccbgloca in (123,53,88,8429,8663,69,134,60,139,82,89,50,122,130,107,54,94)
       and ce.ccbgdpto  != nuDepaNuevo;
    dbms_output.put_line('update a ldci_cecoubigetra terminó correctamente. Registros actualizados '||sql%rowcount);
    commit;
  exception
     when others then
      rollback;
      dbms_output.put_line('Error al actualizar ldci_cecoubigetra '||sqlerrm); 
  end; 


  begin
    update ldci_centbenelocal ceb2 
       set ceb2.celodpto = nuDepaNuevo 
     where ceb2.celoloca in (123,53,88,8429,8663,69,134,60,139,82,89,50,122,130,107,54,94)
       and ceb2.celodpto  != nuDepaNuevo;
    dbms_output.put_line('update a ldci_centbenelocal terminó correctamente. Registros actualizados '||sql%rowcount);
    commit;
  exception
     when others then
      rollback;
      dbms_output.put_line('Error al actualizar ldci_centbenelocal '||sqlerrm); 
  end; 

  begin
    update ldc_altura_loc loc 
       set loc.departamento = nuDepaNuevo 
     where  loc.localidad  in (123,53,88,8429,8663,69,134,60,139,82,89,50,122,130,107,54,94)
       and loc.departamento  != nuDepaNuevo;
    dbms_output.put_line('update a ldc_altura_loc terminó correctamente. Registros actualizados '||sql%rowcount);
    commit;
  exception
     when others then
      rollback;
      dbms_output.put_line('Error al actualizar ldc_altura_loc '||sqlerrm); 
  end; 



  begin
  --- ciclo
    update ldc_cicldepa cicdep 
       set cicdep.cicldepa = nuDepaNuevo 
    where cicdep.ciclcodi in (339,1539,766,746,781,1181,1481,958,189,789,1489,1499,899,199,745,745,1343,1341,248,1648,1342,1749,1750,182)
      and cicdep.cicldepa  != nuDepaNuevo;
    dbms_output.put_line('update a ldc_cicldepa terminó correctamente. Registros actualizados '||sql%rowcount);
    commit;
  exception
     when others then
      rollback;
      dbms_output.put_line('Error al actualizar ldc_cicldepa '||sqlerrm); 
  end; 

  begin
    update  ldc_config_gest_cobr 
      set departamento = nuDepaNuevo 
    where localidad in (123,53,88,8429,8663,69,134,60,139,82,89,50,122,130,107,54,94)
      and departamento  != nuDepaNuevo;
    dbms_output.put_line('update a ldc_config_gest_cobr terminó correctamente. Registros actualizados '||sql%rowcount);
    commit;
    --ciclo
    update  ldc_config_gest_cobr 
       set departamento = nuDepaNuevo 
     where ciclo in (339,1539,766,746,781,1181,1481,958,189,789,1489,1499,899,199,745,745,1343,1341,248,1648,1342,1749,1750,182)
       and departamento  != nuDepaNuevo;
    dbms_output.put_line('update a ldc_config_gest_cobr terminó correctamente. Registros actualizados '||sql%rowcount);
    commit;
  exception
     when others then
      rollback;
      dbms_output.put_line('Error al actualizar ldc_cicldepa '||sqlerrm); 
  end; 

  begin
    update ldc_clientedepart  
       set depa_id = nuDepaNuevo 
     where loca_id in (123,53,88,8429,8663,69,134,60,139,82,89,50,122,130,107,54,94)
       and depa_id  != nuDepaNuevo;
    dbms_output.put_line('update a ldc_clientedepart terminó correctamente. Registros actualizados '||sql%rowcount);
    commit;
  exception
     when others then
      rollback;
      dbms_output.put_line('Error al actualizar ldc_clientedepart '||sqlerrm); 
  end; 
  


  begin
    --ciclo
    update ldc_depacatesub_ciclo  
       set departamento_id = nuDepaNuevo 
     where ciclo_id in (339,1539,766,746,781,1181,1481,958,189,789,1489,1499,899,199,745,745,1343,1341,248,1648,1342,1749,1750,182)
       and departamento_id  != nuDepaNuevo;
    dbms_output.put_line('update a ldc_depacatesub_ciclo terminó correctamente. Registros actualizados '||sql%rowcount);
    commit;
  exception
     when others then
      rollback;
      dbms_output.put_line('Error al actualizar ldc_cicldepa '||sqlerrm); 
  end; 
  


  begin
    
    update manzanas 
       set manzdepa=nuDepaNuevo 
     where manzloca in (123,53,88,8429,8663,69,134,60,139,82,89,50,122,130,107,54,94)
       and manzdepa  != nuDepaNuevo;
    dbms_output.put_line('update a manzanas terminó correctamente. Registros actualizados '||sql%rowcount);
    commit;
    update open.histreti 
       set HSREMZDE = nuDepaNuevo 
     where hsremzlo in (123,53,88,8429,8663,69,134,60,139,82,89,50,122,130,107,54,94)
       and HSREMZDE  != nuDepaNuevo;
    dbms_output.put_line('update a histreti terminó correctamente. Registros actualizados '||sql%rowcount);
    commit;
  exception
     when others then
      rollback;
      dbms_output.put_line('Error al actualizar histreti '||sqlerrm); 
  end; 

  
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/