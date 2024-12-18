column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin
  Declare
    vsbsolici varchar2(15);
    vsbclasif varchar2(4);
  Begin
    --
    vsbsolici := 193125608;  
    vsbclasif := '';   
    insert into open.ldc_osf_serv_pendiente
    select * from open.ldc_osf_serv_pendiente l
    where l.nuano = 2023
      and l.numes = 06
      and l.solicitud = 193125608
      and l.concepto = 400;
    --
    update open.ldc_osf_serv_pendiente l
      set l.numes = 7,
          l.ingreso_report = -14831840
    where l.nuano = 2023
      and l.numes = 06
      and l.solicitud = 193125608
      and l.concepto = 400
      and rownum = 1;
    commit;
    --
    vsbsolici := 196014667;  
    vsbclasif := '';    
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.ingreso_report = -17686980
    where p.nuano = 2023 
      and p.numes in (7)
      and p.solicitud = 196014667
      and p.concepto = 400;
    --
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.ingreso_report = -126567540
    where p.nuano = 2023 
      and p.numes in (7)
      and p.solicitud = 196014667
      and p.concepto = 4;
    commit;  
    --
    vsbsolici := 189051233;  
    vsbclasif := '';    
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.ingreso_report = -130000000
    where p.nuano = 2023 
      and p.numes in (7)
      and p.solicitud = 189051233
      and p.concepto = 19;
    commit;
    --
    vsbsolici := 191226013;  
    vsbclasif := '';   
    delete OPEN.LDC_OSF_SERV_PENDIENTE p
    where p.nuano = 2023 
      and p.numes in (7)
      and p.solicitud = 191226013
      and p.concepto = 4
      and p.tipo = 'CON_PRODUCTOS';
    -- 
    delete OPEN.LDC_OSF_SERV_PENDIENTE p
    where p.nuano = 2023 
      and p.numes in (7)
      and p.solicitud = 191226013
      and p.concepto = 4
      and p.tipo = 'SIN_PRODUCTOS'
      and rownum = 1;
    --     
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.carg_x_conex = 138616577,
          p.ingreso_report = -136130181
    where p.nuano = 2023 
      and p.numes in (7)
      and p.solicitud = 191226013
      and p.concepto = 4;
    --
    update open.LDC_OSF_SERV_PENDIENTE l
      set l.ingreso_report = l.cert_previa * -1
    where l.nuano = 2023 
      and l.numes in (7)
      and l.solicitud = 191226013
      and l.concepto = 400;
    commit;
    --
    vsbsolici := 194825000;  
    vsbclasif := '';   
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.ingreso_report = -95104647
    where p.nuano = 2023 
      and p.numes in (7)
      and p.solicitud = 194825000
      and p.concepto = 4;
    commit;
    --
    vsbsolici := 194066594;  
    vsbclasif := '';   
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.ingreso_report = -88320000
    where p.nuano = 2023 
      and p.numes in (7)
      and p.solicitud = 194066594
      and p.concepto = 19;
    --
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.ingreso_report = -89510256
    where p.nuano = 2023 
      and p.numes in (7)
      and p.solicitud = 194066594
      and p.concepto = 4;
    --
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.ingreso_report = -17798208
    where p.nuano = 2023 
      and p.numes in (7)
      and p.solicitud = 194066594
      and p.concepto = 400;     
    commit;
    --
    vsbsolici := 199923950;  
    vsbclasif := '';
    update open.LDC_OSF_SERV_PENDIENTE l
      set l.ingreso_report = -703153
    where l.nuano = 2023 
      and l.numes in (7)
      and l.solicitud = 199923950
      and l.concepto = 4
      and rownum < 155;
    commit;
    --
    vsbsolici := 194826516;  
    vsbclasif := '';
    update open.LDC_OSF_SERV_PENDIENTE l
      set l.ingreso_report = -92618251
    where l.nuano = 2023 
      and l.numes in (7)
      and l.solicitud = 194826516;
    commit;
    --
    vsbsolici := 199947301;  
    vsbclasif := '';  
    update open.LDC_OSF_SERV_PENDIENTE l
      set l.ingreso_report = l.carg_x_conex * -1
    where l.nuano = 2023 
      and l.numes in (7)
      and l.solicitud = 199947301
      and l.concepto = 4
      and rownum < 41;
    --
    update open.LDC_OSF_SERV_PENDIENTE l
      set l.ingreso_report = l.cert_previa * -1
    where l.nuano = 2023 
      and l.numes in (7)
      and l.solicitud = 199947301
      and l.concepto = 400
      and rownum < 41;
    commit;
    --
    vsbsolici := 196636703;  
    vsbclasif := '';   
    delete open.LDC_OSF_SERV_PENDIENTE l
    where l.nuano = 2023 
      and l.numes in (7)
      and l.solicitud = 196636703
      and l.tipo = 'Ing_Osf';
    --
    update open.LDC_OSF_SERV_PENDIENTE l
      set l.ingreso_report = -49923863
    where l.nuano = 2023 
      and l.numes in (7)
      and l.solicitud = 196636703
      and l.tipo = 'SIN_PRODUCTOS';
    commit;
    --
    vsbsolici := 181882394;  
    vsbclasif := '';  
    update open.LDC_OSF_SERV_PENDIENTE l
      set l.ingreso_report = -33856000
    where l.nuano = 2023 
      and l.numes in (7)
      and l.solicitud = 181882394
      and l.concepto = 19;
    --
    delete open.LDC_OSF_SERV_PENDIENTE l
    where l.nuano = 2023 
      and l.numes in (7)
      and l.solicitud = 181882394
      and l.concepto = 400
      and l.tipo = 'Ing_Osf';
    --
    update open.LDC_OSF_SERV_PENDIENTE l
      set l.ingreso_report = -6426482
    where l.nuano = 2023 
      and l.numes in (7)
      and l.solicitud = 181882394
      and l.concepto = 400;     
    commit;
    --
    vsbsolici := 198046028;  
    vsbclasif := '';  
    update open.LDC_OSF_SERV_PENDIENTE l
      set l.ingreso_report = l.cert_previa * -1
    where l.nuano = 2023 
      and l.numes in (7)
      and l.solicitud = 198046028
      and l.concepto = 400;
    commit;
    --
    DBMS_OUTPUT.PUT_LINE('Proceso termina Ok.');
    --
  Exception
    when others then
        ROLLBACK;
          DBMS_OUTPUT.PUT_LINE('Error solicitud : ' || vsbsolici || '  clasificador : ' || vsbclasif ||'   ' || SQLERRM);
  End;
  
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/