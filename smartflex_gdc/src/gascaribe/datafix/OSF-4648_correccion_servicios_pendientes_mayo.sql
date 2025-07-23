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
    -- Descontamos Ingreso Real
    -- CEBE 4101
    vsbsolici := 201480636;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -59768005
     where l.nuano = 2025
       and l.numes = 5
       and l.solicitud = 201480636
       and l.concepto = 4
       and l.carg_x_conex = 91409890;
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -7860880
     where l.nuano = 2025
       and l.numes = 5
       and l.solicitud = 201480636
       and l.concepto = 400
       and l.cert_previa = 7860880;
    commit;
    --
    vsbsolici := 207261363;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -10350000
     where l.nuano = 2025
       and l.numes = 5
       and l.solicitud = 207261363
       and l.concepto = 19
       and l.interna = 10350000;
    commit;
    --
    vsbsolici := 208714466;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -133599070
     where l.nuano = 2025
       and l.numes = 5
       and l.solicitud = 208714466
       and l.concepto = 4
       and l.carg_x_conex = 138521141;
    commit;
    --
    vsbsolici := 216704650;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -127360000
     where l.nuano = 2025
       and l.numes = 5
       and l.solicitud = 216704650
       and l.concepto = 19;
    commit;
    --
    vsbsolici := 217377671;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -39957112
     where l.nuano = 2025
       and l.numes = 5
       and l.solicitud = 217377671
       and l.concepto = 4;
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -5594992
     where l.nuano = 2025
       and l.numes = 5
       and l.solicitud = 217377671
       and l.concepto = 400;
    commit;
    --
    vsbsolici := 218112225;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -29967834
     where l.nuano = 2025
       and l.numes = 5
       and l.solicitud = 218112225
       and l.concepto = 4;
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -4626628
     where l.nuano = 2025
       and l.numes = 5
       and l.solicitud = 218112225
       and l.concepto = 400;
    commit;
    --
    vsbsolici := 223312174;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -20425000
     where l.nuano = 2025
       and l.numes = 5
       and l.solicitud = 223312174
       and l.concepto = 19;
    commit;
    --
    vsbsolici := 220625715;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -768406
     where l.nuano = 2025
       and l.numes = 5
       and l.solicitud = 220625715
       and l.concepto = 4
       and l.carg_x_conex = 768406;
    commit;
    --
    --CEBE-4102
    vsbsolici := 220360281;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -134471050
     where l.nuano = 2025
       and l.numes = 5
       and l.solicitud = 220360281
       and l.concepto = 4
       and l.carg_x_conex = 67619728;
    commit;
    --
    vsbsolici := 220794738;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -30736240
     where l.nuano = 2025
       and l.numes = 5
       and l.solicitud = 220794738
       and l.concepto = 4
       and l.carg_x_conex =  17673338;
    commit;
    -- 
    vsbsolici := 222119540;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -8800000
     where l.nuano = 2025
       and l.numes = 5
       and l.solicitud = 222119540
       and l.concepto = 19
       and l.interna = 8800000;
    commit;
    --  
    -- CEBE 4106
    vsbsolici := 208025444;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -25440000
     where l.nuano = 2025
       and l.numes = 5
       and l.solicitud = 208025444
       and l.concepto = 19
       and l.interna = 25440000;
    commit;
    --
    vsbsolici := 210115502;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -218995710
     where l.nuano = 2025
       and l.numes = 5
       and l.solicitud = 210115502
       and l.concepto = 4
       and l.carg_x_conex = 206701214;
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -30880052
     where l.nuano = 2025
       and l.numes = 5
       and l.solicitud = 210115502
       and l.concepto = 400
       and l.cert_previa = 30234476;
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -93552000
     where l.nuano = 2025
       and l.numes = 5
       and l.solicitud = 210115502
       and l.concepto = 19;
    commit;
    --
    vsbsolici := 213985981;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -518674050
     where l.nuano = 2025
       and l.numes = 5
       and l.solicitud = 213985981
       and l.concepto = 4
       and l.carg_x_conex = 301215152;
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -72627300
     where l.nuano = 2025
       and l.numes = 5
       and l.solicitud = 213985981
       and l.concepto = 400
       and l.cert_previa = 55734728;
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -98550000
     where l.nuano = 2025
       and l.numes = 5
       and l.solicitud = 213985981
       and l.concepto = 19;
    commit;
    --
    vsbsolici := 215845759;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -82130000
     where l.nuano = 2025
       and l.numes = 5
       and l.solicitud = 215845759
       and l.concepto = 19;
    commit;
    --    
    vsbsolici := 215992166;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -184417440
     where l.nuano = 2025
       and l.numes = 5
       and l.solicitud = 215992166
       and l.concepto = 4
       and l.carg_x_conex = 145997140;
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -25823040
     where l.nuano = 2025
       and l.numes = 5
       and l.solicitud = 215992166
       and l.concepto = 400
       and l.cert_previa = 20658432;
    commit;
    --
    vsbsolici := 223274744;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -119862
     where l.nuano = 2025
       and l.numes = 5
       and l.solicitud = 223274744
       and l.concepto = 400
       and l.cert_previa = 119862;
    commit;
    -- Corrige serv cumplido, el saldo es un adicional.
    vsbsolici := 215106296;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -266900000
     where l.nuano = 2025
       and l.numes = 5
       and l.solicitud = 215106296
       and l.concepto = 19
       and l.interna = 266900000;
    commit;
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = 0
     where l.nuano = 2025
       and l.numes = 5
       and l.solicitud = 215106296
       and l.concepto = 19
       and l.interna = 50554000;
    commit;    
    --    
    
    --
    -- CEBE 4127
    vsbsolici := 192908941;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -17427412
     where l.nuano = 2025
       and l.numes = 5
       and l.solicitud = 192908941
       and l.concepto = 400
       and l.cert_previa = 17334713;
    commit;
    --    
    vsbsolici := 195263154;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -561408
     where l.nuano = 2025
       and l.numes = 5
       and l.solicitud = 195263154
       and l.concepto = 400;
    commit;
    -- 
    vsbsolici := 196901330;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -6485226
     where l.nuano = 2025
       and l.numes = 5
       and l.solicitud = 196901330
       and l.concepto = 400;
    commit;
    --
    vsbsolici := 205678021;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -88597278
     where l.nuano = 2025
       and l.numes = 5
       and l.solicitud = 205678021
       and l.concepto = 4;
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -1179132
     where l.nuano = 2025
       and l.numes = 5
       and l.solicitud = 205678021
       and l.concepto = 400
       and l.cert_previa = 1179132;
    commit;
    --
    vsbsolici := 216014885;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -1536812
     where l.nuano = 2025
       and l.numes = 5
       and l.solicitud = 216014885
       and l.concepto = 4
       and l.carg_x_conex = 1536812;    
    commit;
    --
    vsbsolici := 222669870;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -3202344
     where l.nuano = 2025
       and l.numes = 5
       and l.solicitud = 222669870
       and l.concepto = 4;
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -1565399
     where l.nuano = 2025
       and l.numes = 5
       and l.solicitud = 222669870
       and l.interna = 1179132;
    commit;
    --
    vsbsolici := 222738223;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -195140
     where l.nuano = 2025
       and l.numes = 5
       and l.solicitud = 222738223
       and l.concepto = 400;
    commit;
    --
    -- CEBE 4158
    vsbsolici := 217843285;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -33041458
     where l.nuano = 2025
       and l.numes = 5
       and l.solicitud = 217843285
       and l.concepto = 4;
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -4841820
     where l.nuano = 2025
       and l.numes = 5
       and l.solicitud = 217843285
       and l.concepto = 400;
    commit;
    --    
    vsbsolici := 219621861;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -24120000
     where l.nuano = 2025
       and l.numes = 5
       and l.solicitud = 219621861
       and l.concepto = 19;
    commit;
    --
    vsbsolici := 220954004;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -18576000
     where l.nuano = 2025
       and l.numes = 5
       and l.solicitud = 220954004
       and l.concepto = 19;
    commit;
    --
    vsbsolici := 223475149;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -1950000
     where l.nuano = 2025
       and l.numes = 5
       and l.solicitud = 223475149
       and l.concepto = 19;
    commit;
    --
    vsbsolici := 223475629;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -2340000
     where l.nuano = 2025
       and l.numes = 5
       and l.solicitud = 223475629
       and l.concepto = 19;
    commit;
    --
    vsbsolici := 223475917;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -2340000
     where l.nuano = 2025
       and l.numes = 5
       and l.solicitud = 223475917
       and l.concepto = 19;
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