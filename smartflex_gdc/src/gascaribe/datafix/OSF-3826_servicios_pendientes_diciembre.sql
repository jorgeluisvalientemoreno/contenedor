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
    -- Ingreso Real 202412
    --
    vsbsolici := 210115502;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -28120000
     where l.nuano =  2024
       and l.numes = 12
       and l.solicitud = 210115502
       and l.interna = 28120000;
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -71461758
     where l.nuano =  2024
       and l.numes = 12
       and l.solicitud = 210115502
       and l.carg_x_conex = 71461758;
    commit;
    --
    vsbsolici := 198985577;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -55549087
     where l.nuano =  2024
       and l.numes = 12
       and l.solicitud = 198985577
       and l.carg_x_conex = 55549087;
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -17296936
     where l.nuano =  2024
       and l.numes = 12
       and l.solicitud = 198985577
       and l.ingreso_report = -13461757;
    commit;
    --
    vsbsolici := 181882394;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -134183472
     where l.nuano =  2024
       and l.numes = 12
       and l.solicitud = 181882394
       and l.carg_x_conex = 134183472;
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -588524
     where l.nuano =  2024
       and l.numes = 12
       and l.solicitud = 181882394
       and l.carg_x_conex = 588524;
    commit;
    --
    vsbsolici := 200721769;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -12086103
     where l.nuano =  2024
       and l.numes = 12
       and l.solicitud = 200721769
       and l.concepto = 400;
    -- corrige serv cumplido mes descontamos los -1
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -98080500
     where l.nuano =  2024
       and l.numes = 12
       and l.solicitud = 200721769
       and l.concepto = 19;
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -85784666
     where l.nuano =  2024
       and l.numes = 12
       and l.solicitud = 200721769
       and l.concepto = 4;
    commit;
    --
    vsbsolici := 202851020;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -32426130
     where l.nuano =  2024
       and l.numes = 12
       and l.solicitud = 202851020
       and l.concepto = 400;
    commit;
    --
    vsbsolici := 115279213;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -7800000
     where l.nuano =  2024
       and l.numes = 12
       and l.solicitud = 115279213;
    commit;
    --
    vsbsolici := 205141895;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -75325000
     where l.nuano =  2024
       and l.numes = 12
       and l.solicitud = 205141895
       and l.concepto = 19
       and l.interna = 75325000;
    commit;
    --
    vsbsolici := 205471270;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -3515765
     where l.nuano =  2024
       and l.numes = 12
       and l.solicitud = 205471270
       and l.carg_x_conex = 3515765;
    commit;
    --
    vsbsolici := 207590238;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -30235579
     where l.nuano =  2024
       and l.numes = 12
       and l.solicitud = 207590238
       and l.carg_x_conex = 30235579;
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -79456289
     where l.nuano =  2024
       and l.numes = 12
       and l.solicitud = 207590238
       and l.carg_x_conex = 79456289;
    commit;
    --
    vsbsolici := 207689413;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -135160000
     where l.nuano =  2024
       and l.numes = 12
       and l.solicitud = 207689413
       and l.concepto = 19
       and l.interna = 135160000;
    commit;
    --    
    vsbsolici := 207690603;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -2109459
     where l.nuano =  2024
       and l.numes = 12
       and l.solicitud = 207690603
       and l.carg_x_conex = 2109459;
    commit;
    --
    vsbsolici := 207724741;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -6485226
     where l.nuano =  2024
       and l.numes = 12
       and l.solicitud = 207724741
       and l.concepto = 400;
    commit;
    --
    vsbsolici := 208794282;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -28275000
     where l.nuano =  2024
       and l.numes = 12
       and l.solicitud = 208794282
       and l.concepto = 19;
    commit;
    --
    vsbsolici := 208841157;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -28500000
     where l.nuano =  2024
       and l.numes = 12
       and l.solicitud = 208841157
       and l.concepto = 19
       and l.interna = 28500000;
    commit;
    --
    vsbsolici := 212417294;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -12911520
     where l.nuano =  2024
       and l.numes = 12
       and l.solicitud = 212417294
       and l.concepto = 400;
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -46104360
     where l.nuano =  2024
       and l.numes = 12
       and l.solicitud = 212417294
       and l.concepto = 4;
    commit;
    --
    vsbsolici := 212447834;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -76800000
     where l.nuano =  2024
       and l.numes = 12
       and l.solicitud = 212447834
       and l.concepto = 19
       and l.interna = 76800000;
    delete open.ldc_osf_serv_pendiente l
     where l.nuano =  2024
       and l.numes = 12
       and l.solicitud = 212447834
       and l.concepto = 19
       and l.interna =  741000;
    commit;
    --
    vsbsolici := 213708982;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -360000
     where l.nuano =  2024
       and l.numes = 12
       and l.solicitud = 213708982
       and l.concepto = 19
       and l.interna = 360000;
    commit;
    -- Quitar nota de 95 millos Parque Alegra
    vsbsolici := 52128425;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.notas = 0
     where l.nuano = 2024
       and l.numes = 12
       and l.product_id = 52128425;
    commit;
    --
    vsbsolici := 216014885;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = (l.interna + l.carg_x_conex + l.cert_previa) * -1
     where l.nuano =  2024
       and l.numes = 12
       and l.solicitud = 216014885;
    commit;
    --
    vsbsolici := 217843285;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -37001000
     where l.nuano =  2024
       and l.numes = 12
       and l.solicitud = 217843285;
    commit;
    --
    vsbsolici := 219132325;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -6915654
     where l.nuano =  2024
       and l.numes = 12
       and l.solicitud = 219132325
       and l.carg_x_conex = 6915654;
    commit;
    --
    vsbsolici := 219511290;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -30736240
     where l.nuano =  2024
       and l.numes = 12
       and l.solicitud = 219511290;
    commit;
    --
    vsbsolici := 219770623;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -57630450
     where l.nuano =  2024
       and l.numes = 12
       and l.solicitud = 219770623;
    commit;
    --
    vsbsolici := 219799327;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -16904932
     where l.nuano =  2024
       and l.numes = 12
       and l.solicitud = 219799327
       and l.carg_x_conex = 16904932;
    commit;
    --
    vsbsolici := 220807381;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = (l.interna + l.carg_x_conex + l.cert_previa) * -1
     where l.nuano =  2024
       and l.numes = 12
       and l.solicitud = 220807381;
    commit;
    --
    -- Corrige serv cumplido mes descontamos los -1
    -- 
    vsbsolici := 201480636;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = (l.interna + l.carg_x_conex + l.cert_previa) * -1
     where l.nuano =  2024
       and l.numes = 12
       and l.solicitud = 201480636;
    commit;
    --    
    vsbsolici := 202275265;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = (l.interna + l.carg_x_conex + l.cert_previa) * -1
     where l.nuano =  2024
       and l.numes = 12
       and l.solicitud = 202275265;
    commit;
    --
    vsbsolici := 202275265;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = (l.interna + l.carg_x_conex + l.cert_previa) * -1
     where l.nuano =  2024
       and l.numes = 12
       and l.solicitud = 202275265;
    commit;
    --
    vsbsolici := 207590250;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = (l.interna + l.carg_x_conex + l.cert_previa) * -1
     where l.nuano =  2024
       and l.numes = 12
       and l.solicitud = 207590250;
    commit;
    --
    vsbsolici := 208024262;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = (l.interna + l.carg_x_conex + l.cert_previa) * -1
     where l.nuano =  2024
       and l.numes = 12
       and l.solicitud = 208024262;
    commit;
    --
    vsbsolici := 215992166;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = (l.interna + l.carg_x_conex + l.cert_previa) * -1
     where l.nuano =  2024
       and l.numes = 12
       and l.solicitud = 215992166
       and l.concepto = 400;
    commit;
    --
    vsbsolici := 217343127;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = (l.interna + l.carg_x_conex + l.cert_previa) * -1
     where l.nuano =  2024
       and l.numes = 12
       and l.solicitud = 217343127;
    commit;
    --
    vsbsolici := 218624818;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = (l.interna + l.carg_x_conex + l.cert_previa) * -1
     where l.nuano =  2024
       and l.numes = 12
       and l.solicitud = 218624818;
    commit;
    --
    vsbsolici := 218770941;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = (l.interna + l.carg_x_conex + l.cert_previa) * -1
     where l.nuano =  2024
       and l.numes = 12
       and l.solicitud = 218770941;
    commit;
    --
    vsbsolici := 220625715;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = (l.interna + l.carg_x_conex + l.cert_previa) * -1
     where l.nuano =  2024
       and l.numes = 12
       and l.solicitud = 220625715;
    commit;
    --
    -- Corrige CARGDOSO memos Quilla
    --
    vsbsolici := 198775030;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.interna = 222750000
     where l.nuano =  2024
       and l.numes = 12
       and l.solicitud = 198775030;
    commit;
    --
    vsbsolici := 195160412;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.cert_previa = 11772773
     where l.nuano =  2024
       and l.numes = 12
       and l.solicitud = 195160412
       and l.concepto = 400;
    commit;
    --
    vsbsolici := 194066594;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.cert_previa = 60450389
     where l.nuano =  2024
       and l.numes = 12
       and l.solicitud = 194066594
       and l.concepto = 400;
    commit;
    --
    vsbsolici := 193875743;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.cert_previa = 15573432
     where l.nuano =  2024
       and l.numes = 12
       and l.solicitud = 193875743
       and l.concepto = 400;
    update open.ldc_osf_serv_pendiente l
       set l.interna = 34776000
     where l.nuano =  2024
       and l.numes = 12
       and l.solicitud = 193875743
       and l.concepto = 19;
    update open.ldc_osf_serv_pendiente l
       set l.carg_x_conex = 104428632
     where l.nuano =  2024
       and l.numes = 12
       and l.solicitud = 193875743
       and l.concepto = 4;
    commit;
    --
    vsbsolici := 193125608;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.cert_previa = 21135372
     where l.nuano =  2024
       and l.numes = 12
       and l.solicitud = 193125608
       and l.concepto = 400;
    update open.ldc_osf_serv_pendiente l
       set l.carg_x_conex = 153534953
     where l.nuano =  2024
       and l.numes = 12
       and l.solicitud = 193125608
       and l.concepto = 4;
    commit;
    --
    -- Corrige CARGDOSO memos Sta Marta
    --
    vsbsolici := 176393179;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.interna = (l.interna * 3) 
     where l.nuano =  2024
       and l.numes = 12
       and l.solicitud = 176393179
       and l.interna = 65520000;
    update open.ldc_osf_serv_pendiente l
       set l.carg_x_conex = (l.carg_x_conex * 3) 
     where l.nuano =  2024
       and l.numes = 12
       and l.solicitud = 176393179
       and l.carg_x_conex = 53555684;
    update open.ldc_osf_serv_pendiente l
       set l.cert_previa = (l.cert_previa * 3) 
     where l.nuano =  2024
       and l.numes = 12
       and l.solicitud = 176393179
       and l.cert_previa = 8011094;
    commit;
    --
    vsbsolici := 176393303;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.interna = (l.interna * 3) 
     where l.nuano =  2024
       and l.numes = 12
       and l.solicitud = 176393303
       and l.interna = 87570000;
    update open.ldc_osf_serv_pendiente l
       set l.carg_x_conex = (l.carg_x_conex * 3) 
     where l.nuano =  2024
       and l.numes = 12
       and l.solicitud = 176393303
       and l.carg_x_conex = 74154024;
    update open.ldc_osf_serv_pendiente l
       set l.cert_previa = (l.cert_previa * 3) 
     where l.nuano =  2024
       and l.numes = 12
       and l.solicitud = 176393303
       and l.cert_previa = 11092284;
    commit;
    --
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