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
    --
    vsbsolici := 198985577;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -13115000
     where l.nuano = 2025
       and l.numes = 3
       and l.solicitud = 198985577
       and l.concepto = 19
       and l.interna = 13115000;
    commit;
    --
    vsbsolici := 207555227; 
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -21600000
     where l.nuano = 2025
       and l.numes = 3
       and l.solicitud = 207555227
       and l.concepto = 19
       and l.interna = 21600000;
    commit;
    --
    vsbsolici := 208714466; -- ok
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -64690076
     where l.nuano = 2025
       and l.numes = 3
       and l.solicitud = 208714466
       and l.concepto = 4
       and l.carg_x_conex = 129380152;
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -15120000
     where l.nuano = 2025
       and l.numes = 3
       and l.solicitud = 208714466
       and l.concepto = 19
       and l.interna = 69120000;
    commit;
    --
    vsbsolici := 217377671;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -14850000
     where l.nuano = 2025
       and l.numes = 3
       and l.solicitud = 217377671
       and l.concepto = 19;
    commit;
    --
    vsbsolici := 218624818; -- ok
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -9220872
     where l.nuano = 2025
       and l.numes = 3
       and l.solicitud = 218624818
       and l.concepto = 4
       and l.carg_x_conex = 45335954;
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -14828248
     where l.nuano = 2025
       and l.numes = 3
       and l.solicitud = 218624818
       and l.concepto = 400
       and l.cert_previa = 10006428;
    commit;
    --
    vsbsolici := 221977374;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -38420300
     where l.nuano = 2025
       and l.numes = 3
       and l.solicitud = 221977374
       and l.concepto = 4;
    commit;
    --
    vsbsolici := 218120406;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -11160000
     where l.nuano = 2025
       and l.numes = 3
       and l.solicitud = 218120406
       and l.concepto = 19
       and l.ingreso_report = 0;
    commit;
    --
    vsbsolici := 221513003;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -5600000
     where l.nuano = 2025
       and l.numes = 3
       and l.solicitud = 221513003
       and l.concepto = 19;
    commit;
    --
    vsbsolici := 224036703;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -3860000
     where l.nuano = 2025
       and l.numes = 3
       and l.solicitud = 224036703
       and l.concepto = 19;
    commit;
    --
    vsbsolici := 210115502;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -6147248
     where l.nuano = 2025
       and l.numes = 3
       and l.solicitud = 210115502
       and l.concepto = 4
       and l.carg_x_conex = 6147248;
    commit;
    --
    vsbsolici := 213985981;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -200553966
     where l.nuano = 2025
       and l.numes = 3
       and l.solicitud = 213985981
       and l.concepto = 4;
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -29050920
     where l.nuano = 2025
       and l.numes = 3
       and l.solicitud = 213985981
       and l.concepto = 400
       and l.cert_previa != 0;
    commit;
    --
    vsbsolici := 197330102;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -109980000
     where l.nuano = 2025
       and l.numes = 3
       and l.solicitud = 197330102
       and l.concepto = 19;
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -11496537
     where l.nuano = 2025
       and l.numes = 3
       and l.solicitud = 197330102
       and l.concepto = 400;
    commit;
    --
    vsbsolici := 201638674;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -101000000
     where l.nuano = 2025
       and l.numes = 3
       and l.solicitud = 201638674
       and l.concepto = 19;
    commit;
    --
    vsbsolici := 202851020;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -34686133
     where l.nuano = 2025
       and l.numes = 3
       and l.solicitud = 202851020
       and l.concepto = 400
       and l.ingreso_report != 0;
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -188445004
     where l.nuano = 2025
       and l.numes = 3
       and l.solicitud = 202851020
       and l.concepto = 4;
    commit;
    --
    vsbsolici := 205678021;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -5600877
     where l.nuano = 2025
       and l.numes = 3
       and l.solicitud = 205678021
       and l.concepto = 400;
    commit;
    --
    vsbsolici := 208794282;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -29580000
     where l.nuano = 2025
       and l.numes = 3
       and l.solicitud = 208794282
       and l.concepto = 19
       and l.interna = 29580000;
    commit;
    --
    vsbsolici := 216014885;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -5378842
     where l.nuano = 2025
       and l.numes = 3
       and l.solicitud = 216014885
       and l.concepto = 4
       and l.carg_x_conex = 5378842;
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -13341904
     where l.nuano = 2025
       and l.numes = 3
       and l.solicitud = 216014885
       and l.concepto = 400
       and l.cert_previa != 0;
    commit;
    --    
    -- CUCO = -1
    --
    vsbsolici := 198985577;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -123754928
     where l.nuano = 2025
       and l.numes = 3
       and l.solicitud = 198985577
       and l.concepto = 4;
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -21617420
     where l.nuano = 2025
       and l.numes = 3
       and l.solicitud = 198985577
       and l.concepto = 400
       and l.cert_previa = 17293936;
    commit;
    --    
/*    vsbsolici := 202851020;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -188445004
     where l.nuano = 2025
       and l.numes = 3
       and l.solicitud = 202851020
       and l.concepto = 4;    
    commit;*/
    -- 
    vsbsolici := 215666061;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -1536812
     where l.nuano = 2025
       and l.numes = 3
       and l.solicitud = 215666061
       and l.concepto = 4
       and l.carg_x_conex = 1536812;
    commit;
    --
    vsbsolici := 215992166;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -144460328
     where l.nuano = 2025
       and l.numes = 3
       and l.solicitud = 215992166
       and l.concepto = 4;
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -21196412
     where l.nuano = 2025
       and l.numes = 3
       and l.solicitud = 215992166
       and l.concepto = 400;
    commit;
    --
    vsbsolici := 220625715;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -79914224
     where l.nuano = 2025
       and l.numes = 3
       and l.solicitud = 220625715
       and l.concepto = 4
       and l.carg_x_conex = 46872766;
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -6563356
     where l.nuano = 2025
       and l.numes = 3
       and l.solicitud = 220625715
       and l.concepto = 400
       and l.cert_previa = 6563356;
    commit;
    --
    vsbsolici := 222936736;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -37993061
     where l.nuano = 2025
       and l.numes = 3
       and l.solicitud = 222936736
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