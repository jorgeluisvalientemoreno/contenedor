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
    -- Octubre
    vsbsolici := 205471270;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = l.ingreso_report + -49720000
     where l.nuano =  2024
       and l.numes = 10
       and l.solicitud = 205471270;
    commit;
    --
    vsbsolici := 207261363;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = l.ingreso_report + -86400000
     where l.nuano =  2024
       and l.numes = 10
       and l.solicitud = 207261363;
    commit;
    --
    vsbsolici := 208841157;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = l.ingreso_report + -47250000
     where l.nuano =  2024
       and l.numes = 10
       and l.solicitud = 208841157;
    commit;
    --
    vsbsolici := 213708982;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = l.ingreso_report + -24840000
     where l.nuano =  2024
       and l.numes = 10
       and l.solicitud = 213708982;
    commit;
    --
    vsbsolici := 216037735;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = l.ingreso_report + -11520000
     where l.nuano =  2024
       and l.numes = 10
       and l.solicitud = 216037735
       and l.concepto = 19;
    commit;
    --
    vsbsolici := 217275352;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = l.ingreso_report + -3600000
     where l.nuano =  2024
       and l.numes = 10
       and l.solicitud = 217275352
       and l.concepto = 19;
    --
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = l.ingreso_report + -8452466
     where l.nuano =  2024
       and l.numes = 10
       and l.solicitud = 217275352
       and l.concepto = 4;
    --
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = l.ingreso_report + -1291152
     where l.nuano =  2024
       and l.numes = 10
       and l.solicitud = 217275352
       and l.concepto = 400;
    commit;
    --
    vsbsolici := 217275439;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = l.ingreso_report + -4800000
     where l.nuano =  2024
       and l.numes = 10
       and l.solicitud = 217275439
       and l.concepto = 19;
    --
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = l.ingreso_report + -10757684
     where l.nuano =  2024
       and l.numes = 10
       and l.solicitud = 217275352
       and l.concepto = 4;
    --
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = l.ingreso_report + -1506344
     where l.nuano =  2024
       and l.numes = 10
       and l.solicitud = 217275439
       and l.concepto = 400;
    commit;
    --
    vsbsolici := 217343127;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = l.ingreso_report + -50714796
     where l.nuano =  2024
       and l.numes = 10
       and l.solicitud = 217343127
       and l.concepto = 4;
    commit;
    --
    vsbsolici := 217627531;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = l.ingreso_report + -18441744
     where l.nuano =  2024
       and l.numes = 10
       and l.solicitud = 217627531
       and l.concepto = 4;
    commit;
    --
    vsbsolici := 217839144;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = l.ingreso_report + -36883488
     where l.nuano =  2024
       and l.numes = 10
       and l.solicitud = 217839144
       and l.concepto = 4;
    --
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = l.ingreso_report + -5164608
     where l.nuano =  2024
       and l.numes = 10
       and l.solicitud = 217839144
       and l.concepto = 400;
    commit;
    --
    vsbsolici := 218120281;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = l.ingreso_report + -6147248
     where l.nuano =  2024
       and l.numes = 10
       and l.solicitud = 218120281
       and l.concepto = 4;
    commit;
    --
    vsbsolici := 218343225;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = l.ingreso_report + -72230164
     where l.nuano =  2024
       and l.numes = 10
       and l.solicitud = 218343225
       and l.concepto = 4;
    commit;
    --
    vsbsolici := 218478344;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = l.ingreso_report + -5100000
     where l.nuano =  2024
       and l.numes = 10
       and l.solicitud = 218478344
       and l.concepto = 19;
    commit;
    --
    vsbsolici := 218478381;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = l.ingreso_report + -340000
     where l.nuano =  2024
       and l.numes = 10
       and l.solicitud = 218478381
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