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
    -- MARZO
    vsbsolici := 210316380;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = -3242613
     where l.nuano = 2024
       and l.numes in (3)
       and l.solicitud = 210316380
       and l.concepto = 400;
    commit;
    --
    -- ABRIL
    vsbsolici := 210316380;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = l.cert_previa * -1
     where l.nuano = 2024
       and l.numes in (4)
       and l.solicitud = 210316380
       and l.concepto = 400;
    commit;
    --
    -- Servicios Cumplidos
    vsbsolici := 190929760;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = -83250000
     where l.nuano = 2024
       and l.numes in (4)
       and l.solicitud = 190929760
       and l.concepto = 19;
    commit;
    --
    vsbsolici := 186601129;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = -28192000
     where l.nuano = 2024
       and l.numes in (4)
       and l.solicitud = 186601129
       and l.concepto = 19
       and l.interna = 28192000;
    commit;
    --
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = -49106321 -- 8080787 + 41025534
     where l.nuano = 2024
       and l.numes in (4)
       and l.solicitud = 186601129
       and l.concepto = 4;
    commit;
    --
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = -278097
     where l.nuano = 2024
       and l.numes in (4)
       and l.solicitud = 186601129
       and l.concepto = 400
       and l.cert_previa = 6118134;
    commit;
    --
    vsbsolici := 190016167;
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = -29215153
     where l.nuano = 2024
       and l.numes in (4)
       and l.solicitud = 190016167
       and l.concepto = 4;
    -- 
    vsbsolici := 195980358;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = -2670500
     where l.nuano = 2024
       and l.numes in (4)
       and l.solicitud = 195980358
       and l.concepto = 19;    
    commit;
    --
    -- Ingreso Real
    vsbsolici := 202090916;
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = -156099966
     where l.nuano = 2024
       and l.numes in (4)
       and l.solicitud = 202090916
       and l.concepto = 4;    
    commit;
    --
    vsbsolici := 210094451;
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = l.interna * -1
     where l.nuano = 2024
       and l.numes in (4)
       and l.solicitud = 210094451;
    commit;
    --
    vsbsolici := 198608517;
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = -18767851
     where l.nuano = 2024
       and l.numes in (4)
       and l.solicitud = 198608517
       and l.concepto = 400;    
    commit;
    --
    vsbsolici := 190016167;
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = -5191144
     where l.nuano = 2024
       and l.numes in (4)
       and l.solicitud = 190016167
       and l.concepto = 400;    
    commit;
    --
    vsbsolici := 200747716;
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = -23907202
     where l.nuano = 2024
       and l.numes in (4)
       and l.solicitud = 200747716
       and l.concepto = 4;
    --
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = -3439135
     where l.nuano = 2024
       and l.numes in (4)
       and l.solicitud = 200747716
       and l.concepto = 400;    
    commit;
    --
    vsbsolici := 205076666;
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = -19688284
     where l.nuano = 2024
       and l.numes in (4)
       and l.solicitud = 205076666
       and l.concepto = 4;
    --
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = -11200000
     where l.nuano = 2024
       and l.numes in (4)
       and l.solicitud = 205076666
       and l.concepto = 19;    
    commit;
    -- 
    vsbsolici := 207283284;
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = -30450000
     where l.nuano = 2024
       and l.numes in (4)
       and l.solicitud = 207283284
       and l.concepto = 19;
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