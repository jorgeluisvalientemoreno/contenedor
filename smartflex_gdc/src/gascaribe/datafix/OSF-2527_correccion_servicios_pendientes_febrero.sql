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
    -- FEBRERO
    vsbsolici := 190820647;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = -24863960
     where l.nuano = 2024
       and l.numes = 2
       and l.solicitud = 190820647
       and l.concepto = 4;
    --
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = -16000000
     where l.nuano = 2024
       and l.numes = 2
       and l.solicitud = 190820647
       and l.concepto = 19;
    --
    commit;
    -- 
    vsbsolici := 193874472;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = -22800000
     where l.nuano = 2024
       and l.numes = 2
       and l.solicitud = 193874472
       and l.concepto = 19;
    commit;
    -- 
    vsbsolici := 194855829;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = -47241524
     where l.nuano = 2024
       and l.numes = 2
       and l.solicitud = 194855829
       and l.concepto = 4;
    --
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = -19000000
     where l.nuano = 2024
       and l.numes = 2
       and l.solicitud = 194855829
       and l.concepto = 19;
    --
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = -7045124
     where l.nuano = 2024
       and l.numes = 2
       and l.solicitud = 194855829
       and l.concepto = 400;
    commit;    
    -- 
    vsbsolici := 198837749;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = -10547295
     where l.nuano = 2024
       and l.numes = 2
       and l.solicitud = 198837749
       and l.concepto = 4;
    commit;    
    -- 
    vsbsolici := 202157779;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = -1674000
     where l.nuano = 2024
       and l.numes = 2
       and l.solicitud = 202157779
       and l.concepto = 19;
    commit;    
    --     
    vsbsolici := 202678050;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = -703153
     where l.nuano = 2024
       and l.numes = 2
       and l.solicitud = 202678050
       and l.concepto = 4;
    --
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = -990000
     where l.nuano = 2024
       and l.numes = 2
       and l.solicitud = 202678050
       and l.concepto = 19;       
    --
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = -98261
     where l.nuano = 2024
       and l.numes = 2
       and l.solicitud = 202678050
       and l.concepto = 400;       
    commit;    
    --
    vsbsolici := 205324480;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = -42750000
     where l.nuano = 2024
       and l.numes = 2
       and l.solicitud = 205324480
       and l.concepto = 19;
    commit;    
    --
    vsbsolici := 207385461;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = -53439628
     where l.nuano = 2024
       and l.numes = 2
       and l.solicitud = 207385461
       and l.concepto = 4;
    commit;
    --
    vsbsolici := 198608517;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = 0
     where l.nuano = 2024
       and l.numes = 2
       and l.solicitud = 198608517
       and l.concepto = 19;
    commit;   
    --
    vsbsolici := 124434822;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = 0
     where l.nuano = 2024
       and l.numes = 2
       and l.solicitud = 124434822
       and l.concepto = 19;
    commit;   
    --
    --
    vsbsolici := 205324480;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = 0
     where l.nuano = 2024
       and l.numes = 2
       and l.solicitud = 205324480
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