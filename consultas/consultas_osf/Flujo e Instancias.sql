Declare

  cursor cuExternal_idPrincipal is
    select b.plan_id,
           b.package_id,
           a.instance_id,
           a.attribute_id,
           a.value,
           b.unit_id,
           b.unit_type_id,
           a.instance_attrib_id,
           b.description
      from open.WF_INSTANCE_ATTRIB a,
           (select d.plan_id,
                   d.package_id,
                   s.instance_id,
                   s.description,
                   s.unit_id,
                   s.unit_type_id
              from (select /*+ index (d IDX_WF_DATA_EXTERNAL_01) index (s IX_WF_INSTANCE23, IX_WF_INSTANCE24)*/
                     d.plan_id, d.package_id, d.unit_type_id
                      from open.wf_data_external d
                     where D.package_id in (119478328)
                    /*(select mp.package_id
                     from open.mo_packages mp
                    where mp.package_type_id = 271
                         --and mp.package_id in (71246745)
                      and mp.motive_status_id = 13)*/
                    ) d,
                   open.wf_instance s
             where D.PLAN_ID = S.PLAN_ID
                  --and s.unit_id = 154
                  --and s.unit_type_id = 75
               and (uppER(s.description) like
                   upper('Espera Respuesta del Cliente') or
                   uppER(s.description) like
                   upper('Orden Cliente Da Respuesta') or
                   uppER(s.description) like upper('Segundo Aviso') or
                   uppER(s.description) like upper('Orden Segundo Aviso')or
                   uppER(s.description) like upper('Publicar Edicto') 
                   )) b
     where a.instance_id = b.INSTANCE_ID
    --and ATTRIBUTE_ID = 400
    --and a.value is null
    --and b.unit_id = 102775
    --and b.unit_type_id = 163
     order by b.description;

  cursor cuExternal_idIncompleta(InuUnit_id      number,
                                 InuUnit_type_id number,
                                 InuATTRIBUTE_ID number) is
    select b.plan_id,
           b.package_id,
           a.instance_id,
           a.attribute_id,
           a.value,
           b.unit_id,
           b.unit_type_id,
           a.instance_attrib_id,
           b.description
      from open.WF_INSTANCE_ATTRIB a,
           (select d.plan_id,
                   d.package_id,
                   s.instance_id,
                   s.description,
                   s.unit_id,
                   s.unit_type_id
              from (select /*+ index (d IDX_WF_DATA_EXTERNAL_01) index (s IX_WF_INSTANCE23, IX_WF_INSTANCE24)*/
                     d.plan_id, d.package_id, d.unit_type_id
                      from open.wf_data_external d
                     where D.package_id in (100091434)
                    /*(select mp.package_id
                     from open.mo_packages mp
                    where mp.package_type_id = 271
                         --and mp.package_id in (71246745)
                      and mp.motive_status_id = 13)*/
                    ) d,
                   open.wf_instance s
             where D.PLAN_ID = S.PLAN_ID
               and s.unit_id = InuUnit_id
               and s.unit_type_id = InuUnit_type_id
               and (uppER(s.description) like
                   upper('Espera Respuesta del Cliente') or
                   uppER(s.description) like
                   upper('Orden Cliente Da Respuesta') or
                   uppER(s.description) like upper('Publicar Edicto') 
                   )) b
     where a.instance_id = b.INSTANCE_ID
       and ATTRIBUTE_ID = InuATTRIBUTE_ID
       and a.value is null
    --and b.unit_id = 102775
    --and b.unit_type_id = 163
     order by b.description;

  rfcuExternal_idPrincipal  cuExternal_idPrincipal%rowtype;
  rfcuExternal_idIncompleta cuExternal_idIncompleta%rowtype;

  nuRegistro numbeR;

  VnuInstancia number;
begin

  /*
  begin
    INSERT INTO LDC_TRAZA_LOG
      (TRALOG_ID, FECHA_REGISTRO, DATA1, DATA2)
    VALUES
      (0, SYSDATE, 'Solicitud 115972105', 'Inicio Porceso');
    COMMIT;
  exception
    when others then
      rollback;
  end;
  --*/

  --nuRegistro := 0;

  /*
  begin
  
    update open.Or_Order_Activity ooa
       set ooa.instance_id = 1497544734
     where ooa.order_id = 229933493
       and ooa.instance_id is null;
  
    commit;
  
    dbms_output.put_line('Actualiza Instancia de orden 229933493 Ok.');
  
    begin
      INSERT INTO LDC_TRAZA_LOG
        (TRALOG_ID, FECHA_REGISTRO, DATA1, DATA2)
      VALUES
        (1,
         SYSDATE,
         'Solicitud 115972105',
         'Actualizar Instancia 1497544734 en la orden 229933493 Ok.');
      COMMIT;
    exception
      when others then
        rollback;
        dbms_output.put_line('No registro en el LOG...');
      
    end;
  
  exception
    when others then
      Rollback;
      dbms_output.put_line('No actualizo Instancia de orden 229933493...');
    
  end;
  --*/

  -----ACtualizacion de valores de atriubots en Instancias
  --Inicio Solicitudes
  for rfcuExternal_idPrincipal in cuExternal_idPrincipal loop
  
    --/*
    dbms_output.put_line('Principal Solicitud[' ||
                         rfcuExternal_idPrincipal.Package_Id ||
                         ']-Unidad[' || rfcuExternal_idPrincipal.Unit_Id ||
                         ']-Plan[' || rfcuExternal_idPrincipal.Plan_Id ||
                         ']-Tipo Unidad[' ||
                         rfcuExternal_idPrincipal.Unit_Type_Id ||
                         ']-Instancia Atributo[' ||
                         rfcuExternal_idPrincipal.instance_attrib_id ||
                         ']-Instancia[' ||
                         rfcuExternal_idPrincipal.Instance_Id ||
                         ']-Atributo[' ||
                         rfcuExternal_idPrincipal.attribute_id ||
                         ']-Valor[' || rfcuExternal_idPrincipal.Value || ']' ||
                         ']-Descripcion Instancia[' ||
                         rfcuExternal_idPrincipal.description || ']');
    --*/
  
    open cuExternal_idIncompleta(rfcuExternal_idPrincipal.Unit_Id,
                                 rfcuExternal_idPrincipal.Unit_Type_Id,
                                 rfcuExternal_idPrincipal.attribute_id);
    fetch cuExternal_idIncompleta
      into rfcuExternal_idIncompleta;
    if cuExternal_idIncompleta%found then
      --/*
      dbms_output.put_line('Incompleto Solicitud[' ||
                           rfcuExternal_idIncompleta.Package_Id ||
                           ']-Unidad[' ||
                           rfcuExternal_idIncompleta.Unit_Id || ']-Plan[' ||
                           rfcuExternal_idIncompleta.Plan_Id ||
                           ']-Tipo Unidad[' ||
                           rfcuExternal_idIncompleta.Unit_Type_Id ||
                           ']-Instancia Atributo[' ||
                           rfcuExternal_idIncompleta.instance_attrib_id ||
                           ']-Instancia[' ||
                           rfcuExternal_idIncompleta.Instance_Id ||
                           ']-Atributo[' ||
                           rfcuExternal_idIncompleta.attribute_id ||
                           ']-Valor[' || rfcuExternal_idIncompleta.Value || ']' ||
                           ']-Descripcion Instancia[' ||
                           rfcuExternal_idIncompleta.description || ']');
      --*/
    
      /*
      begin
        update open.WF_INSTANCE_ATTRIB
           set VALUE = rfcuExternal_idPrincipal.Value
         where INSTANCE_ATTRIB_ID =
               rfcuExternal_idIncompleta.instance_attrib_id
           and INSTANCE_ID = rfcuExternal_idIncompleta.Instance_Id
           and ATTRIBUTE_ID = rfcuExternal_idIncompleta.attribute_id;
      
        commit;
      
        begin
          INSERT INTO LDC_TRAZA_LOG
            (TRALOG_ID, FECHA_REGISTRO, DATA1, DATA2)
          VALUES
            (1,
             SYSDATE,
             'Solicitud 115972105',
             'Actualizo Instancia[' ||
             rfcuExternal_idIncompleta.Instance_Id || ']-Atributo[' ||
             rfcuExternal_idIncompleta.attribute_id || ']-Valor[' ||
             rfcuExternal_idPrincipal.Value || ']');
          COMMIT;
        exception
          when others then
            rollback;
            dbms_output.put_line('No registro en el LOG...');
          
        end;
      
      exception
        when others then
          Rollback;
          dbms_output.put_line('No Actualizo Instancia[' ||
                               rfcuExternal_idIncompleta.Instance_Id ||
                               ']-Atributo[' ||
                               rfcuExternal_idIncompleta.attribute_id ||
                               ']-Valor[' ||
                               rfcuExternal_idPrincipal.Value || ']');
        
      end;     
      --*/
    end if;
    close cuExternal_idIncompleta;
  
    dbms_output.put_line('------------------------------------------------------------');
  
  end loop;
  --------------------------------------------------------------  

  /*
  begin
    INSERT INTO LDC_TRAZA_LOG
      (TRALOG_ID, FECHA_REGISTRO, DATA1, DATA2)
    VALUES
      (2, SYSDATE, 'Solicitud 115972105', 'Fin Porceso');
    COMMIT;
  exception
    when others then
      rollback;
  end;
  --*/

end;

/
