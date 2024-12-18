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
    -- Septiembre
    vsbsolici := 202275265;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -21708000
     where l.nuano =  2024
       and l.numes = (9)
       and l.solicitud = 202275265;
    commit;
    --
    vsbsolici := 205678021;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = l.ingreso_report - 62100000
     where l.nuano =  2024
       and l.numes = (9)
       and l.solicitud = 205678021;
    commit;
    --
    vsbsolici := 207555227;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -64800000
     where l.nuano =  2024
       and l.numes = (9)
       and l.solicitud = 207555227;
    commit;
    --
    vsbsolici := 208298826;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -59064852
     where l.nuano =  2024
       and l.numes = (9)
       and l.solicitud = 208298826
       and l.concepto = 4;
    --
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -8646968
     where l.nuano =  2024
       and l.numes = (9)
       and l.solicitud = 208298826
       and l.concepto = 400;    
    commit;
    --
    vsbsolici := 209993886;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -4626628
     where l.nuano =  2024
       and l.numes = (9)
       and l.solicitud = 209993886
       and l.concepto = 400;    
    commit;
    --
    vsbsolici := 212355558;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -10221620
     where l.nuano =  2024
       and l.numes = (9)
       and l.solicitud = 212355558
       and l.concepto = 400;    
    commit;
    --
    vsbsolici := 212943862;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -8200000
     where l.nuano =  2024
       and l.numes = (9)
       and l.solicitud = 212943862
       and l.concepto = 19;    
    commit;
    --
    vsbsolici := 213916153;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -46872766
     where l.nuano =  2024
       and l.numes = (9)
       and l.solicitud = 213916153
       and l.concepto = 4;    
    commit;
    --
    vsbsolici := 214867931;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -17875000
     where l.nuano =  2024
       and l.numes = (9)
       and l.solicitud = 214867931
       and l.concepto = 19;    
    commit;
    --
    vsbsolici := 215289370;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -3960000
     where l.nuano =  2024
       and l.numes = (9)
       and l.solicitud = 215289370
       and l.concepto = 19;    
    commit;
    --
    vsbsolici := 216519420;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -30987648
     where l.nuano =  2024
       and l.numes = (9)
       and l.solicitud = 216519420
       and l.concepto = 400;
    --
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -220532522
     where l.nuano =  2024
       and l.numes = (9)
       and l.solicitud = 216519420
       and l.concepto = 4;    
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