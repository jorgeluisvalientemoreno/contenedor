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
    -- CEBE 4106 -- Correccion dato correspondiente a causal 84
    vsbsolici := 210115502;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.interna = l.interna + 36720000
     where l.nuano = 2025
       and l.numes = 6
       and l.solicitud = 210115502
       and l.concepto = 19
       and l.interna = 93552000;
    commit;
    --
    -- Ajustamos proyectos
    -- CEBE 4101
    vsbsolici := 201480636;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -4218918
     where l.nuano = 2025
       and l.numes = 6
       and l.solicitud = 201480636
       and l.concepto = 4
       and l.carg_x_conex = 4218918;
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -294783
     where l.nuano = 2025
       and l.numes = 6
       and l.solicitud = 201480636
       and l.concepto = 400
       and l.cert_previa = 294783;
    commit;
    --
    vsbsolici := 207261363;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -11250000
     where l.nuano = 2025
       and l.numes = 6
       and l.solicitud = 207261363
       and l.concepto = 19
       and l.interna = 11250000;
    commit;
    --
    vsbsolici := 208714466;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -1406306
     where l.nuano = 2025
       and l.numes = 6
       and l.solicitud = 208714466
       and l.concepto = 4
       and l.carg_x_conex = 1406306;
    --
    vsbsolici := 216704650;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -103480000
     where l.nuano = 2025
       and l.numes = 6
       and l.solicitud = 216704650
       and l.concepto = 19
       and l.interna = 103480000;
    commit;
    --
    vsbsolici := 217377671;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -27662616
     where l.nuano = 2025
       and l.numes = 6
       and l.solicitud = 217377671
       and l.concepto = 4
       and l.carg_x_conex = 27662616;
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -3873456
     where l.nuano = 2025
       and l.numes = 6
       and l.solicitud = 217377671
       and l.concepto = 400
       and l.cert_previa = 3873456;
    commit;
    --
    vsbsolici := 218112225;
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -3842030
     where l.nuano = 2025
       and l.numes = 6
       and l.solicitud = 218112225
       and l.concepto = 4
       and l.carg_x_conex = 3842030;
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -107596
     where l.nuano = 2025
       and l.numes = 6
       and l.solicitud = 218112225
       and l.concepto = 400
       and l.cert_previa = 107596;
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -36740000
     where l.nuano = 2025
       and l.numes = 6
       and l.solicitud = 218112225
       and l.concepto = 19
       and l.interna = 36740000;
    commit;
    --       
    vsbsolici := 220625715;
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -14740652
     where l.nuano = 2025
       and l.numes = 6
       and l.solicitud = 220625715
       and l.concepto = 400
       and l.cert_previa = 14740652;
    commit;
    --
    vsbsolici := 222936736;
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -10427994
     where l.nuano = 2025
       and l.numes = 6
       and l.solicitud = 222936736
       and l.concepto = 400
       and l.cert_previa = 10427994;
    commit;
    --   
    vsbsolici := 223312174;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -32775000
     where l.nuano = 2025
       and l.numes = 6
       and l.solicitud = 223312174
       and l.concepto = 19
       and l.interna = 32775000;
    commit;
    --
    vsbsolici := 226392444;
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -75986122
     where l.nuano = 2025
       and l.numes = 6
       and l.solicitud = 226392444
       and l.concepto = 4;
    commit;
    --
    vsbsolici := 226430924;
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -23442527
     where l.nuano = 2025
       and l.numes = 6
       and l.solicitud = 226430924
       and l.concepto = 4;
    commit;
    --
    -- Ajustamos proyectos
    -- CEBE 4102
    vsbsolici := 218137146;
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -11526090
     where l.nuano = 2025
       and l.numes = 6
       and l.solicitud = 218137146
       and l.concepto = 4;
    commit;
    --
    vsbsolici := 220360281;
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -768406
     where l.nuano = 2025
       and l.numes = 6
       and l.solicitud = 220360281
       and l.concepto = 4
       and l.carg_x_conex = 768406;
    commit;
    --
    vsbsolici := 226430567;
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -25867616
     where l.nuano = 2025
       and l.numes = 6
       and l.solicitud = 226430567
       and l.concepto = 4;
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -3835584
     where l.nuano = 2025
       and l.numes = 6
       and l.solicitud = 226430567
       and l.concepto = 400;
    commit;
    --
    -- Ajustamos proyectos
    -- CEBE 4106
    vsbsolici := 181882394;
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -1177048
     where l.nuano = 2025
       and l.numes = 6
       and l.solicitud = 181882394
       and l.concepto = 4
       and l.carg_x_conex = 1177048;
    commit;
    --
    vsbsolici := 208025444;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -25440000
     where l.nuano = 2025
       and l.numes = 6
       and l.solicitud = 208025444
       and l.concepto = 19
       and l.ingreso_report = 0;
    commit;
    --
    vsbsolici := 210115502;
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -1536812
     where l.nuano = 2025
       and l.numes = 6
       and l.solicitud = 210115502
       and l.concepto = 4
       and l.carg_x_conex = 2305218;
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -107596
     where l.nuano = 2025
       and l.numes = 6
       and l.solicitud = 210115502
       and l.concepto = 400
       and l.cert_previa = 107596;
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -28416000
     where l.nuano = 2025
       and l.numes = 6
       and l.solicitud = 210115502
       and l.concepto = 19
       and l.interna = 28416000;
    commit;
    --
    vsbsolici := 210790060;    
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -19815506
     where l.nuano = 2025
       and l.numes = 6
       and l.solicitud = 210790060
       and l.concepto = 19
       and l.interna = 19815506;
    commit;
    --
    vsbsolici := 213985981;    
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -147825000
     where l.nuano = 2025
       and l.numes = 6
       and l.solicitud = 213985981
       and l.concepto = 19
       and l.interna = 147825000;
    commit;
    --
    vsbsolici := 215845759;    
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -41710000
     where l.nuano = 2025
       and l.numes = 6
       and l.solicitud = 215845759
       and l.concepto = 19
       and l.interna = 41710000;
    commit;
    --
    -- Ajustamos proyectos
    -- CEBE 4123
    vsbsolici := 214152730;
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -10757684
     where l.nuano = 2025
       and l.numes = 6
       and l.solicitud = 210115502
       and l.concepto = 4
       and l.carg_x_conex = 10757684;
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -1506344
     where l.nuano = 2025
       and l.numes = 6
       and l.solicitud = 214152730
       and l.concepto = 400
       and l.cert_previa = 1506344;
    commit;
    --
    vsbsolici := 220794547;    
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -4800000
     where l.nuano = 2025
       and l.numes = 6
       and l.solicitud = 220794547
       and l.concepto = 19;
    commit;
    --
    vsbsolici := 220794547;    
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -1613940
     where l.nuano = 2025
       and l.numes = 6
       and l.solicitud = 220794547
       and l.concepto = 400;
    commit;
    --
    -- Ajustamos proyectos
    -- CEBE 4127
    vsbsolici := 192908941;
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -116239013
     where l.nuano = 2025
       and l.numes = 6
       and l.solicitud = 192908941
       and l.concepto = 4
       and l.carg_x_conex = 116239013;
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -370796
     where l.nuano = 2025
       and l.numes = 6
       and l.solicitud = 192908941
       and l.concepto = 400
       and l.cert_previa = 370796;
    commit;
    --
    vsbsolici := 195263154;
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -621599
     where l.nuano = 2025
       and l.numes = 6
       and l.solicitud = 195263154
       and l.concepto = 4
       and l.carg_x_conex = 621599;
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -280704
     where l.nuano = 2025
       and l.numes = 6
       and l.solicitud = 195263154
       and l.concepto = 400
       and l.cert_previa = 280704;
    commit;
    --
    vsbsolici := 196901330;
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -60471158
     where l.nuano = 2025
       and l.numes = 6
       and l.solicitud = 196901330
       and l.concepto = 4
       and l.carg_x_conex = 60471158;
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -8941751
     where l.nuano = 2025
       and l.numes = 6
       and l.solicitud = 196901330
       and l.concepto = 400
       and l.cert_previa = 11594798;
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -158080000
     where l.nuano = 2025
       and l.numes = 6
       and l.solicitud = 196901330
       and l.concepto = 19;
    commit;
    --
    vsbsolici := 204251153;
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -32345038
     where l.nuano = 2025
       and l.numes = 6
       and l.solicitud = 204251153
       and l.concepto = 4;
    commit;
    --
    vsbsolici := 205678021;
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -46408098
     where l.nuano = 2025
       and l.numes = 6
       and l.solicitud = 205678021
       and l.concepto = 4
       and l.carg_x_conex = 46408098;
    commit;
    --
    vsbsolici := 219646382;
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -31680000
     where l.nuano = 2025
       and l.numes = 6
       and l.solicitud = 219646382
       and l.concepto = 19;
    commit;
    --
    vsbsolici := 222738223;
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -473986
     where l.nuano = 2025
       and l.numes = 6
       and l.solicitud = 222738223
       and l.concepto = 4
       and l.carg_x_conex = 473986;
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -195140
     where l.nuano = 2025
       and l.numes = 6
       and l.solicitud = 222738223
       and l.concepto = 400
       and l.cert_previa = 195140
       and l.ingreso_report = 0;
    commit;
    --
    -- Ajustamos proyectos
    -- CEBE 4158
    vsbsolici := 214002754;
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -34862400
     where l.nuano = 2025
       and l.numes = 6
       and l.solicitud = 214002754
       and l.concepto = 19;
    commit;
    --
    vsbsolici := 217843285;
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -430384
     where l.nuano = 2025
       and l.numes = 6
       and l.solicitud = 217843285
       and l.concepto = 400
       and l.cert_previa = 860768;
    commit;
    --
    vsbsolici := 219875970;
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -26125804
     where l.nuano = 2025
       and l.numes = 6
       and l.solicitud = 219875970
       and l.concepto = 4
       and l.carg_x_conex = 26125804;
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -4411436
     where l.nuano = 2025
       and l.numes = 6
       and l.solicitud = 219875970
       and l.concepto = 400
       and l.cert_previa = 4411436;
    commit;
    --
    vsbsolici := 223475149;
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -390000
     where l.nuano = 2025
       and l.numes = 6
       and l.solicitud = 223475149
       and l.concepto = 19
       and l.interna = 390000;
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