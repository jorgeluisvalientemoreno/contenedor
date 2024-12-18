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
    vsbsolici := 191226013;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
      set l.ingreso_report = -68154000,
          l.interna = 70111200
    where l.nuano = 2023
      and l.numes = 7
      and l.solicitud = 191226013
      and l.concepto = 19
      and l.interna = 68461000;
    --
    update open.ldc_osf_serv_pendiente l
      set l.carg_x_conex = 141102973,
          l.interna = 0,
          l.ingreso_report = -137358181,
          l.concepto = 4
    where l.nuano = 2023
      and l.numes = 7
      and l.solicitud = 191226013
      and l.concepto = 19
      and l.interna = 1650200;
    commit;
    --
    vsbsolici := 199110672;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
      set l.ingreso_report = -28865332
    where l.nuano = 2023
      and l.numes = 7
      and l.solicitud = 199110672;
    commit;
    --
    vsbsolici := 194831746;
    vsbclasif := '';
    delete open.LDC_OSF_SERV_PENDIENTE l
    where l.nuano = 2023 
      and l.numes in (7)
      and l.solicitud = 194831746
      and l.ingreso_report = -109401424;
    --
    update open.LDC_OSF_SERV_PENDIENTE l
      set l.interna = 154156552
    where l.nuano = 2023 
      and l.numes in (7)
      and l.solicitud = 194831746;
    commit;
    --
    vsbsolici := 194825000;
    vsbclasif := '';  
    update open.LDC_OSF_SERV_PENDIENTE l
      set l.ingreso_report = -53457514
    where l.nuano = 2023 
      and l.numes in (7)
      and l.solicitud = 194825000;
    commit;
  /*
    --
    vsbsolici := 194066594;
    vsbclasif := '';  
    update open.LDC_OSF_SERV_PENDIENTE l
      set l.ingreso_report = -65889494
    where l.nuano = 2023 
      and l.numes in (7)
      and l.solicitud = 194066594 
      and l.concepto = 4;
    --
    update open.LDC_OSF_SERV_PENDIENTE l
      set l.ingreso_report = -9084502
    where l.nuano = 2023 
      and l.numes in (7)
      and l.solicitud = 194066594 
      and l.concepto = 400; 
    commit;      
  */
    --
    vsbsolici := 186692900;
    vsbclasif := '';   
    update open.LDC_OSF_SERV_PENDIENTE l
      set l.ingreso_report = -92699
    where l.nuano = 2023 
      and l.numes in (7)
      and l.solicitud = 186692900
      and l.concepto = 400
      and l.ingreso_report = -278097;
    commit;
    --
    vsbsolici := 184224811;
    vsbclasif := '';   
    update open.LDC_OSF_SERV_PENDIENTE l
      set l.ingreso_report = -92699
    where l.nuano = 2023 
      and l.numes in (7)
      and l.solicitud = 184224811
      and l.concepto = 400
      and l.ingreso_report = -648893;
    commit;
    --
    vsbsolici := 10650181;
    vsbclasif := '';  
    update open.LDC_OSF_SERV_PENDIENTE l
      set l.ingreso_report = -66800
    where l.nuano = 2023 
      and l.numes in (7)
      and l.solicitud = 10650181
      and l.ingreso_report = 66800;
    commit;
    --
    vsbsolici := 188723076;
    vsbclasif := '';  
    update open.LDC_OSF_SERV_PENDIENTE l
      set l.ingreso_report = -88034
    where l.nuano = 2023 
      and l.numes in (7)
      and l.solicitud = 188723076
      and l.ingreso_report = -176068;
    commit;
    --
    vsbsolici := 197563954;
    vsbclasif := '';  
    update open.LDC_OSF_SERV_PENDIENTE l
      set l.ingreso_report = -34320000
    where l.nuano = 2023 
      and l.numes in (7)
      and l.solicitud = 197563954;
    commit;
    --  
    vsbsolici := 197563954;
    vsbclasif := '';  
    update open.LDC_OSF_SERV_PENDIENTE l
      set l.ingreso_report = -621599
    where l.nuano = 2023 
      and l.numes in (7)
      and l.solicitud = 186411354
      and l.ingreso_report = -1243198;
    commit;
    -- 
    vsbsolici := 185280342;
    vsbclasif := '';  
    update open.LDC_OSF_SERV_PENDIENTE l
      set l.interna = 9430000
    where l.nuano = 2023 
      and l.numes in (7)
      and l.solicitud = 185280342
      and l.concepto = 19;
    commit;
    --   
    vsbsolici := 188198596;
    vsbclasif := '';  
    update open.LDC_OSF_SERV_PENDIENTE l
      set l.ingreso_report = -72360000
    where l.nuano = 2023 
      and l.numes in (7)
      and l.solicitud = 188198596
      and l.concepto = 19
      and l.interna = 48240000;
    commit;
    --   
    vsbsolici := 188757464;
    vsbclasif := '';  
    update open.LDC_OSF_SERV_PENDIENTE l
      set l.ingreso_report = -621599
    where l.nuano = 2023 
      and l.numes in (7)
      and l.solicitud = 188757464
      and l.concepto = 4
      and l.ingreso_report = -1243198;
    commit;
    --
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