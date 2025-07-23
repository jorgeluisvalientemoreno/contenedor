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
    -- Sta Marta 4127
    --
    -- Inserta registros facturados por memorando solicitud 210790060
    --
    vsbsolici := 188201650;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.cert_previa = l.cert_previa + 10329216
     where l.nuano = 2025
       and l.numes = 1
       and l.solicitud = 188201650
       and l.concepto = 400;
    update open.ldc_osf_serv_pendiente l
       set l.carg_x_conex = l.carg_x_conex + 16783174
     where l.nuano = 2025
       and l.numes = 1
       and l.solicitud = 188201650
       and l.concepto = 4;
    update open.ldc_osf_serv_pendiente l
       set l.interna = l.interna + 20520000
     where l.nuano = 2025
       and l.numes = 1
       and l.solicitud = 188201650
       and l.concepto = 19;      
    commit;
    --
    vsbsolici := 176393303;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.cert_previa = l.cert_previa + 11092284
     where l.nuano = 2025
       and l.numes = 1
       and l.solicitud = 176393303
       and l.concepto = 400;
    update open.ldc_osf_serv_pendiente l
       set l.carg_x_conex = l.carg_x_conex + 74154024
     where l.nuano = 2025
       and l.numes = 1
       and l.solicitud = 176393303
       and l.concepto = 4;
    update open.ldc_osf_serv_pendiente l
       set l.interna = l.interna + 87570000
     where l.nuano = 2025
       and l.numes = 1
       and l.solicitud = 176393303
       and l.concepto = 19;      
    commit;
    --
    vsbsolici := 176393179;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.cert_previa = l.cert_previa + 8011094
     where l.nuano = 2025
       and l.numes = 1
       and l.solicitud = 176393179
       and l.concepto = 400;
    update open.ldc_osf_serv_pendiente l
       set l.carg_x_conex = l.carg_x_conex + 53555684
     where l.nuano = 2025
       and l.numes = 1
       and l.solicitud = 176393179
       and l.concepto = 4;
    update open.ldc_osf_serv_pendiente l
       set l.interna = l.interna + 65520000
     where l.nuano = 2025
       and l.numes = 1
       and l.solicitud = 176393179
       and l.concepto = 19;      
    commit;
    --
    -- Descontamos Ingreso Real
    -- CEBE 4101
    --
    vsbsolici := 198985577;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = l.ingreso_report + -6328377
     where l.nuano = 2025
       and l.numes = 1
       and l.solicitud = 198985577
       and l.concepto = 4
       and l.carg_x_conex = 6328377;
    commit;
    --
    vsbsolici := 200721769;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = l.ingreso_report + -750000
     where l.nuano = 2025
       and l.numes = 1
       and l.solicitud = 200721769
       and l.concepto = 19
       and l.interna = 750000;
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = l.ingreso_report + -703153
     where l.nuano = 2025
       and l.numes = 1
       and l.solicitud = 200721769
       and l.concepto = 4
       and l.carg_x_conex = 703153;
    commit;
    --
    vsbsolici := 201480636;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -6920000
     where l.nuano = 2025
       and l.numes = 1
       and l.solicitud = 201480636
       and l.concepto = 19
       and l.interna = 6920000;
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -85081513
     where l.nuano = 2025
       and l.numes = 1
       and l.solicitud = 201480636
       and l.concepto = 4
       and l.carg_x_conex = 85081513;
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -589566
     where l.nuano = 2025
       and l.numes = 1
       and l.solicitud = 201480636
       and l.concepto = 400
       and l.cert_previa = 589566;
    commit;
    --
    vsbsolici := 207555227;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -21600000
     where l.nuano = 2025
       and l.numes = 1
       and l.solicitud = 207555227
       and l.concepto = 19
       and l.interna = 21600000;
    commit;
    --
    vsbsolici := 207590238;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -24610355
     where l.nuano = 2025
       and l.numes = 1
       and l.solicitud = 207590238
       and l.concepto = 4  
       and l.carg_x_conex = 24610355;
    commit;
    --
    vsbsolici := 207590250;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -46080000
     where l.nuano = 2025
       and l.numes = 1
       and l.solicitud = 207590250
       and l.concepto = 19 
       and l.interna = 46080000;
    commit;
    --
    vsbsolici := 212417294;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -56400000
     where l.nuano = 2025
       and l.numes = 1
       and l.solicitud = 212417294
       and l.concepto = 19;
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -46104360
     where l.nuano = 2025
       and l.numes = 1
       and l.solicitud = 212417294
       and l.concepto = 4
       and l.carg_x_conex = 46104360;
    commit;
    --
    vsbsolici := 218624818;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -9200000
     where l.nuano = 2025
       and l.numes = 1
       and l.solicitud = 218624818
       and l.concepto = 19 
       and l.interna = 9200000;
    commit;
    --
    vsbsolici := 218770941;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -3073624
     where l.nuano = 2025
       and l.numes = 1
       and l.solicitud = 218770941
       and l.concepto = 4 
       and l.carg_x_conex = 3073624;
    commit;
    --
    vsbsolici := 219110723;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -37313000
     where l.nuano = 2025
       and l.numes = 1
       and l.solicitud = 219110723
       and l.concepto = 19;
    commit;
    --
    vsbsolici := 220625715;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -860768
     where l.nuano = 2025
       and l.numes = 1
       and l.solicitud = 220625715
       and l.concepto = 400
       and l.cert_previa = 860768;
    commit;
    --
    -- CEBE 4102
    --
    vsbsolici := 207490553;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -9334795
     where l.nuano = 2025
       and l.numes = 1
       and l.solicitud = 207490553
       and l.concepto = 400;
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -66799535
     where l.nuano = 2025
       and l.numes = 1
       and l.solicitud = 207490553
       and l.concepto = 4;
    commit;
    --
    vsbsolici := 219770792;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -73766976
     where l.nuano = 2025
       and l.numes = 1
       and l.solicitud = 219770792
       and l.concepto = 4;
    commit;
    --
    -- CEBE 4106
    --
    vsbsolici := 181882394;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -176068
     where l.nuano = 2025
       and l.numes = 1
       and l.solicitud = 181882394
       and l.concepto = 400
       and l.cert_previa = 176068;
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -7062288
     where l.nuano = 2025
       and l.numes = 1
       and l.solicitud = 181882394
       and l.concepto = 4
       and l.carg_x_conex = 7062288;
    commit;
    --
    vsbsolici := 208024262;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -25970000
     where l.nuano = 2025
       and l.numes = 1
       and l.solicitud = 208024262
       and l.concepto = 19
       and l.interna = 25970000;
    commit;
    --
    vsbsolici := 210115502;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -296000
     where l.nuano = 2025
       and l.numes = 1
       and l.solicitud = 210115502
       and l.concepto = 19
       and l.interna = 296000;
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -2305218
     where l.nuano = 2025
       and l.numes = 1
       and l.solicitud = 210115502
       and l.concepto = 4
       and l.carg_x_conex = 2305218;
    commit;
    --
    vsbsolici := 215845759;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -41280000
     where l.nuano = 2025
       and l.numes = 1
       and l.solicitud = 215845759
       and l.concepto = 19
       and l.interna = 41280000;
    commit;
    --
    vsbsolici := 215992166;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -430384
     where l.nuano = 2025
       and l.numes = 1
       and l.solicitud = 215992166
       and l.concepto = 400
       and l.cert_previa = 430384;
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -73766976
     where l.nuano = 2025
       and l.numes = 1
       and l.solicitud = 215992166
       and l.concepto = 4
       and l.carg_x_conex = 73766976;
    commit;
    --
    -- CEBE 4106
    --
    vsbsolici := 215666061;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -46104360
     where l.nuano = 2025
       and l.numes = 1
       and l.solicitud = 215666061
       and l.concepto = 4;
    commit;
    --
    vsbsolici := 216014885;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -8069700
     where l.nuano = 2025
       and l.numes = 1
       and l.solicitud = 216014885
       and l.concepto = 400
       and l.cert_previa = 8069700;
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -54556826
     where l.nuano = 2025
       and l.numes = 1
       and l.solicitud = 216014885
       and l.concepto = 4
       and l.carg_x_conex = 54556826;
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -67620000
     where l.nuano = 2025
       and l.numes = 1
       and l.solicitud = 216014885
       and l.concepto = 19
       and l.interna = 67620000;
    commit;
    --
    vsbsolici := 217343127;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -4610436
     where l.nuano = 2025
       and l.numes = 1
       and l.solicitud = 217343127
       and l.concepto = 4
       and l.carg_x_conex = 4610436;
    commit;
    --
    -- CEBE 4158
    --
    vsbsolici := 202275265;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -23004000
     where l.nuano = 2025
       and l.numes = 1
       and l.solicitud = 202275265
       and l.concepto = 19
       and l.interna = 23004000;
    commit;
    --
    vsbsolici := 212635675;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -6650000
     where l.nuano = 2025
       and l.numes = 1
       and l.solicitud = 212635675
       and l.concepto = 19
       and l.interna = 6650000;
    commit;
    --
    vsbsolici := 214002754;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -33480000
     where l.nuano = 2025
       and l.numes = 1
       and l.solicitud = 214002754
       and l.concepto = 19
       and l.interna = 33480000;
    commit;
    --
    vsbsolici := 217974751;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -367000
     where l.nuano = 2025
       and l.numes = 1
       and l.solicitud = 217974751
       and l.concepto = 19
       and l.interna = 367000;
    commit;
    --
    vsbsolici := 221144561;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -18620000
     where l.nuano = 2025
       and l.numes = 1
       and l.solicitud = 221144561
       and l.concepto = 19
       and l.interna = 18620000;
    commit;
    --
    -- Descontamos los valores -1
    -- CEBE 4101
    --
    vsbsolici := 207690603;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -12086103
     where l.nuano = 2025
       and l.numes = 1
       and l.solicitud = 207690603
       and l.concepto = 400;
    commit;
    --
    -- CEBE 4106
    --
    vsbsolici := 210115502;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -10329216
     where l.nuano = 2025
       and l.numes = 1
       and l.solicitud = 210115502
       and l.concepto = 400;
    commit;
    --
    -- CEBE 4127
    --
    vsbsolici := 202851020;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -32426130
     where l.nuano = 2025
       and l.numes = 1
       and l.solicitud = 202851020
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