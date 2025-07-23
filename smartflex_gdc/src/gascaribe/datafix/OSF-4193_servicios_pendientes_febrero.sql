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
    -- Inserta registros facturados por memorando 
    --
    vsbsolici := 219511290;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.carg_x_conex = l.carg_x_conex + 338098640
     where l.nuano = 2025
       and l.numes = 2
       and l.solicitud = 219511290
       and l.concepto = 4;
    commit;
    --
    vsbsolici := 205141895;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.interna = l.interna + 173650000
     where l.nuano = 2025
       and l.numes = 2
       and l.solicitud = 205141895
       and l.concepto = 19;      
    commit;
    --
    vsbsolici := 208841157;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.interna = l.interna + 172500000
     where l.nuano = 2025
       and l.numes = 2
       and l.solicitud = 208841157
       and l.concepto = 19;      
    commit;
    --
    vsbsolici := 202851020;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.interna = l.interna + 266250000
     where l.nuano = 2025
       and l.numes = 2
       and l.solicitud = 202851020
       and l.concepto = 19;      
    commit;
    --
    -- Descontamos Ingreso Real
    --
    vsbsolici := 181882394;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = l.ingreso_report + -1177048
     where l.nuano = 2025
       and l.numes = 2
       and l.solicitud = 181882394
       and l.concepto = 4
       and l.carg_x_conex = 141834284;
    commit;
    --
    vsbsolici := 201480636;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = l.ingreso_report + -98261
     where l.nuano = 2025
       and l.numes = 2
       and l.solicitud = 201480636
       and l.concepto = 400
       and l.cert_previa = 98261;
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = l.ingreso_report + -703153
     where l.nuano = 2025
       and l.numes = 2
       and l.solicitud = 201480636
       and l.concepto = 4
       and l.carg_x_conex = 703153;
    commit;
     --
    vsbsolici := 202851020;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = l.ingreso_report + -1473915
     where l.nuano = 2025
       and l.numes = 2
       and l.solicitud = 202851020
       and l.concepto = 400
       and l.cert_previa = 1473915;
    commit;
    --
    vsbsolici := 207490553;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = l.ingreso_report + -98261
     where l.nuano = 2025
       and l.numes = 2
       and l.solicitud = 207490553
       and l.concepto = 400
       and l.cert_previa = 98261;
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = l.ingreso_report + -703153
     where l.nuano = 2025
       and l.numes = 2
       and l.solicitud = 207490553
       and l.concepto = 4
       and l.carg_x_conex = 703153;
    commit;
    --
    vsbsolici := 207690603;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = l.ingreso_report + -98261
     where l.nuano = 2025
       and l.numes = 2
       and l.solicitud = 207690603
       and l.concepto = 400
       and l.cert_previa = 98261;
     commit;
     --
    vsbsolici := 208714466;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = l.ingreso_report + -98261
     where l.nuano = 2025
       and l.numes = 2
       and l.solicitud = 208714466
       and l.concepto = 400;
     commit;
     --
    vsbsolici := 210115502;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = l.ingreso_report + -968364
     where l.nuano = 2025
       and l.numes = 2
       and l.cert_previa = 10329216;
     commit;
    --
    vsbsolici := 215625374;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = l.ingreso_report + -56550000
     where l.nuano = 2025
       and l.numes = 2
       and l.solicitud = 215625374
       and l.concepto = 19;      
    commit;
    --
    vsbsolici := 215845759;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = l.ingreso_report + -40850000
     where l.nuano = 2025
       and l.numes = 2
       and l.solicitud = 215845759
       and l.concepto = 19
       and l.interna = 40850000;      
    commit;
    --
    vsbsolici := 215992166;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = l.ingreso_report + -18441744
     where l.nuano = 2025
       and l.numes = 2
       and l.solicitud = 215992166
       and l.concepto = 4
       and l.carg_x_conex = 73766976;
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = l.ingreso_report + -9898832
     where l.nuano = 2025
       and l.numes = 2
       and l.solicitud = 215992166
       and l.concepto = 400
       and l.cert_previa = 9898832;
    commit;
    --
    vsbsolici := 216014885;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = l.ingreso_report + -1536812
     where l.nuano = 2025
       and l.numes = 2
       and l.solicitud = 216014885
       and l.concepto = 4
       and l.carg_x_conex = 83756254;
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = l.ingreso_report + -322788
     where l.nuano = 2025
       and l.numes = 2
       and l.solicitud = 216014885
       and l.concepto = 400
       and l.cert_previa = 860768;
    commit;
    --
    vsbsolici := 217457665;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -56400000
     where l.nuano = 2025
       and l.numes = 2
       and l.solicitud = 217457665
       and l.concepto = 19;
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -92208720
     where l.nuano = 2025
       and l.numes = 2
       and l.solicitud = 217457665
       and l.concepto = 4;
    commit;
    --
    vsbsolici := 218624818;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = l.ingreso_report + -40725518
     where l.nuano = 2025
       and l.numes = 2
       and l.solicitud = 218624818
       and l.concepto = 4;
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = l.ingreso_report + -5810184
     where l.nuano = 2025
       and l.numes = 2
       and l.solicitud = 218624818
       and l.concepto = 400;
    commit;
    --
    vsbsolici := 220625532;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = l.ingreso_report + -72998570
     where l.nuano = 2025
       and l.numes = 2
       and l.solicitud = 220625532
       and l.concepto = 4;
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = l.ingreso_report + -10329216
     where l.nuano = 2025
       and l.numes = 2
       and l.solicitud = 220625532
       and l.concepto = 400;
    commit;
    --
    vsbsolici := 220691938;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = l.ingreso_report + -7684060
     where l.nuano = 2025
       and l.numes = 2
       and l.solicitud = 220691938
       and l.concepto = 4;
    commit;
    --
    vsbsolici := 220794738;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = l.ingreso_report + -18000000
     where l.nuano = 2025
       and l.numes = 2
       and l.solicitud = 220794738
       and l.concepto = 19;
    commit;
    --
    vsbsolici := 221626804;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = l.ingreso_report + -11526090
     where l.nuano = 2025
       and l.numes = 2
       and l.solicitud = 221626804
       and l.concepto = 4;
    commit;
    --
    --
    -- Descontamos los valores -1
    --
    vsbsolici := 198985577;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = l.ingreso_report + 13115000
     where l.nuano = 2025
       and l.numes = 2
       and l.solicitud = 198985577
       and l.concepto = 19;
    commit;
    --
    vsbsolici := 202851020;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = l.ingreso_report + 98261
     where l.nuano = 2025
       and l.numes = 2
       and l.solicitud = 202851020
       and l.concepto = 400
       and l.cert_previa = 32426130;
    commit;
    --    
    vsbsolici := 207555227;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = l.ingreso_report + 21600000
     where l.nuano = 2025
       and l.numes = 2
       and l.solicitud = 207555227
       and l.concepto = 19;
    commit;
    --
    vsbsolici := 208714466;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = l.ingreso_report + 68205841
     where l.nuano = 2025
       and l.numes = 2
       and l.solicitud = 208714466
       and l.concepto = 4;
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = l.ingreso_report + 15120000
     where l.nuano = 2025
       and l.numes = 2
       and l.solicitud = 208714466
       and l.concepto = 19;
    commit;
    --
    vsbsolici := 208794282;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = l.ingreso_report + 29580000
     where l.nuano = 2025
       and l.numes = 2
       and l.solicitud = 208794282
       and l.concepto = 19;
    commit;
    --
    vsbsolici := 210115502;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = l.ingreso_report + 6147248
     where l.nuano = 2025
       and l.numes = 2
       and l.solicitud = 210115502
       and l.concepto = 4
       and l.carg_x_conex = 65314510;
    commit;
    --
    vsbsolici := 213985981;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = l.ingreso_report + 11835560
     where l.nuano = 2025
       and l.numes = 2
       and l.solicitud = 213985981
       and l.concepto = 400;
    commit;
    --
    vsbsolici := 218120406;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = l.ingreso_report + 11160000
     where l.nuano = 2025
       and l.numes = 2
       and l.solicitud = 218120406
       and l.concepto = 19;
    commit;
    --
    vsbsolici := 218624818;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = l.ingreso_report + 10757684
     where l.nuano = 2025
       and l.numes = 2
       and l.solicitud = 218624818
       and l.concepto = 4;
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