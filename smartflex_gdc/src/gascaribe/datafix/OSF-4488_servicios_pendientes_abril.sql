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
       set l.ingreso_report = -184929239
     where l.nuano = 2025
       and l.numes = 4
       and l.solicitud = 198985577
       and l.concepto = 4
       and l.carg_x_conex = 123754928;
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -3832179
     where l.nuano = 2025
       and l.numes = 4
       and l.solicitud = 198985577
       and l.concepto = 400
       and l.cert_previa = 4225223;
    commit;
    --
    vsbsolici := 208714466;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -3515765
     where l.nuano = 2025
       and l.numes = 4
       and l.solicitud = 208714466
       and l.concepto = 4
       and l.carg_x_conex = 3515765;
    commit;
    --
    vsbsolici := 218624818;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -1536812
     where l.nuano = 2025
       and l.numes = 4
       and l.solicitud = 218624818
       and l.concepto = 4
       and l.carg_x_conex = 1536812;
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -215192
     where l.nuano = 2025
       and l.numes = 4
       and l.solicitud = 218624818
       and l.concepto = 400
       and l.cert_previa = 215192;
    commit;
    --    
    vsbsolici := 220625715;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -15368120
     where l.nuano = 2025
       and l.numes = 4
       and l.solicitud = 220625715
       and l.concepto = 4
       and l.carg_x_conex = 24588992;
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -1183556
     where l.nuano = 2025
       and l.numes = 4
       and l.solicitud = 220625715
       and l.concepto = 400
       and l.cert_previa = 1291152;
    commit;
    --
    vsbsolici := 222936736;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -32334520
     where l.nuano = 2025
       and l.numes = 4
       and l.solicitud = 222936736
       and l.concepto = 4
       and l.carg_x_conex = 32334520;
    commit;
    --
    vsbsolici := 219770865;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -129092208
     where l.nuano = 2025
       and l.numes = 4
       and l.solicitud = 219770865
       and l.concepto = 4;
    commit;
    --
    vsbsolici := 220794738;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -2797496
     where l.nuano = 2025
       and l.numes = 4
       and l.solicitud = 220794738
       and l.concepto = 400;
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -17673338 -- Descontamos 1.536.812 por servcio cumplido con cuco = -1
     where l.nuano = 2025
       and l.numes = 4
       and l.solicitud = 220794738
       and l.concepto = 4;
    commit;
    --
    vsbsolici := 223062657;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -77602848
     where l.nuano = 2025
       and l.numes = 4
       and l.solicitud = 223062657
       and l.concepto = 4;
    commit;
    --
    vsbsolici := 218258163;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -1398748
     where l.nuano = 2025
       and l.numes = 4
       and l.solicitud = 218258163
       and l.concepto = 400;
    commit;
    --
    vsbsolici := 210115502;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -206701214
     where l.nuano = 2025
       and l.numes = 4
       and l.solicitud = 210115502
       and l.concepto = 4
       and l.carg_x_conex = 145228734;
    commit;
    --
    vsbsolici := 213985981;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -301215152
     where l.nuano = 2025
       and l.numes = 4
       and l.solicitud = 213985981
       and l.concepto = 4
       and l.carg_x_conex = 200553966;
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -55734728
     where l.nuano = 2025
       and l.numes = 4
       and l.solicitud = 213985981
       and l.concepto = 400
       and l.cert_previa = 29050920;
    commit;
    --
    vsbsolici := 215992166;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -20658432
     where l.nuano = 2025
       and l.numes = 4
       and l.solicitud = 215992166
       and l.concepto = 400
       and l.cert_previa = 20228048;
    commit;
    --
    vsbsolici := 223274744;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -12345786
     where l.nuano = 2025
       and l.numes = 4
       and l.solicitud = 223274744
       and l.concepto = 400;
    commit;
    --
    vsbsolici := 223274744;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -12294496
     where l.nuano = 2025
       and l.numes = 4
       and l.solicitud = 223274744
       and l.concepto = 4;
    commit;
    --
    vsbsolici := 192908941;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -17334713
     where l.nuano = 2025
       and l.numes = 4
       and l.solicitud = 192908941
       and l.concepto = 400;
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -141504000
     where l.nuano = 2025
       and l.numes = 4
       and l.solicitud = 192908941
       and l.concepto = 19;
    commit;
    --
    vsbsolici := 197330102;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -91409890
     where l.nuano = 2025
       and l.numes = 4
       and l.solicitud = 197330102
       and l.concepto = 4;
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -1277393
     where l.nuano = 2025
       and l.numes = 4
       and l.solicitud = 197330102
       and l.concepto = 400
       and l.cert_previa = 1277393;
    commit;
    --
    vsbsolici := 201638674;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -70315300
     where l.nuano = 2025
       and l.numes = 4
       and l.solicitud = 201638674
       and l.concepto = 4;
   commit;   
   --
    vsbsolici := 202851020;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -249619315
     where l.nuano = 2025
       and l.numes = 4
       and l.solicitud = 202851020
       and l.concepto = 4
       and l.carg_x_conex = 188445004;
   commit;   
   --
    vsbsolici := 215666061;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -768406
     where l.nuano = 2025
       and l.numes = 4
       and l.solicitud = 215666061
       and l.concepto = 4
       and l.carg_x_conex = 768406;
   commit;   
   --
    vsbsolici := 219066458;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -9400000
     where l.nuano = 2025
       and l.numes = 4
       and l.solicitud = 219066458
       and l.concepto = 19;
   commit;   
   --
    vsbsolici := 219875970;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -36980000
     where l.nuano = 2025
       and l.numes = 4
       and l.solicitud = 219875970
       and l.concepto = 19;
   commit;   
   --

    --    
    -- CUCO = -1
    --
    vsbsolici := 201480636;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -95628808
     where l.nuano = 2025
       and l.numes = 4
       and l.solicitud = 201480636
       and l.concepto = 4;
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -18571329
     where l.nuano = 2025
       and l.numes = 4
       and l.solicitud = 201480636
       and l.concepto = 400
       and l.cert_previa = 13363496;
    commit;
    --
    vsbsolici := 222119540;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -23200000
     where l.nuano = 2025
       and l.numes = 4
       and l.solicitud = 222119540
       and l.concepto = 19;
    commit;
    --
    vsbsolici := 205678021;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -17686980
     where l.nuano = 2025
       and l.numes = 4
       and l.solicitud = 205678021
       and l.concepto = 400
       and l.cert_previa = 5600877;
    commit;
    --
    vsbsolici := 216014885;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -95282344
     where l.nuano = 2025
       and l.numes = 4
       and l.solicitud = 216014885
       and l.concepto = 4;
    commit;
    --
    -- Corrige facturacion manual
    --
    vsbsolici := 208794282;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.interna = 87435000
     where l.nuano = 2025
       and l.numes = 4
       and l.solicitud = 208794282
       and l.concepto = 19;
    commit;
    --
    vsbsolici := 217228851;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.cert_previa = 417000
     where l.nuano = 2025
       and l.numes = 4
       and l.solicitud = 217228851
       and l.concepto = 400;
    update open.ldc_osf_serv_pendiente l
       set l.carg_x_conex = 616814
     where l.nuano = 2025
       and l.numes = 4
       and l.solicitud = 217228851
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