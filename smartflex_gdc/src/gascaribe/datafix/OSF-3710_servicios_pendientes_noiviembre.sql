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
    -- Descontar servicio cumplido
    vsbsolici := 198985577;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -8646968
     where l.nuano =  2024
       and l.numes = 11
       and l.solicitud = 198985577
       and l.concepto = 400;
    commit;
    --
    vsbsolici := 207590238;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -30235579
     where l.nuano =  2024
       and l.numes = 11
       and l.solicitud = 207590238
       and l.concepto = 4;
    commit;
    --
    vsbsolici := 207690603;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -84378360
     where l.nuano =  2024
       and l.numes = 11
       and l.solicitud = 207690603
       and l.concepto = 4;
    commit;
    --
    vsbsolici := 217377867;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -79145818
     where l.nuano =  2024
       and l.numes = 11
       and l.solicitud = 217377867
       and l.concepto = 4;
    commit;
    --
    vsbsolici := 181882394;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -133594948
     where l.nuano =  2024
       and l.numes = 11
       and l.solicitud = 181882394
       and l.concepto = 4;
    commit;
    --
    vsbsolici := 219132325;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -66851322
     where l.nuano =  2024
       and l.numes = 11
       and l.solicitud = 219132325
       and l.concepto = 4;
    commit;
    --
    vsbsolici := 219799327;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -63009292
     where l.nuano =  2024
       and l.numes = 11
       and l.solicitud = 219799327
       and l.concepto = 4;
    commit;
    --
    vsbsolici := 205141895;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -98325000
     where l.nuano =  2024
       and l.numes = 11
       and l.solicitud = 205141895
       and l.concepto = 19;
    commit;
    --
    vsbsolici := 208841157;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -88500000
     where l.nuano =  2024
       and l.numes = 11
       and l.solicitud = 208841157
       and l.concepto = 19
       and l.interna = 47250000;
    commit;
    --
    vsbsolici := 208841157;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -88500000
     where l.nuano =  2024
       and l.numes = 11
       and l.solicitud = 208841157
       and l.concepto = 19
       and l.interna = 47250000;
    commit;
    --
    vsbsolici := 205471270;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -58361699
     where l.nuano =  2024
       and l.numes = 11
       and l.solicitud = 205471270
       and l.concepto = 4;
    commit;
    --
    vsbsolici := 213708982;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -24840000
     where l.nuano =  2024
       and l.numes = 11
       and l.solicitud = 213708982
       and l.concepto = 19;
    commit;
    --
    -- Sumar el Ingreso Real
    --
    vsbsolici := 197415684;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -49220710
     where l.nuano =  2024
       and l.numes = 11
       and l.solicitud = 197415684
       and l.concepto = 4;
    commit;
    --
    vsbsolici := 202851020;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -266250000
     where l.nuano =  2024
       and l.numes = 11
       and l.solicitud = 202851020
       and l.concepto = 19;
    commit;
    --
    vsbsolici := 205471270;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -2947830
     where l.nuano =  2024
       and l.numes = 11
       and l.solicitud = 205471270
       and l.concepto = 400;
    commit;
    --
    vsbsolici := 207590238;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -13560018
     where l.nuano =  2024
       and l.numes = 11
       and l.solicitud = 207590238
       and l.concepto = 400;
    commit;
    --
    vsbsolici := 207690603;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -12086103
     where l.nuano =  2024
       and l.numes = 11
       and l.solicitud = 207690603
       and l.concepto = 400;
    commit;
    --
    vsbsolici := 214147328;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -860768
     where l.nuano =  2024
       and l.numes = 11
       and l.solicitud = 214147328
       and l.concepto = 400;
    commit;
    --
    vsbsolici := 217275582;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -15368120
     where l.nuano =  2024
       and l.numes = 11
       and l.solicitud = 217275582
       and l.concepto = 4;
    commit;
    --
    vsbsolici := 217763132;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -1075960
     where l.nuano =  2024
       and l.numes = 11
       and l.solicitud = 217763132
       and l.concepto = 400;
    commit;
    --
    vsbsolici := 219132325;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -10329216
     where l.nuano =  2024
       and l.numes = 11
       and l.solicitud = 217763132
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