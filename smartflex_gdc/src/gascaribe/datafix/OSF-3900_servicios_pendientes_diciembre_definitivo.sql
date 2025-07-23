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
    -- Corrige CARGDOSO memos Sta Marta 4127
    --
    vsbsolici := 188201650;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.interna = (l.interna * 3) 
     where l.nuano =  2024
       and l.numes = 12
       and l.solicitud = 188201650
       and l.interna = 20520000;
    update open.ldc_osf_serv_pendiente l
       set l.carg_x_conex = (l.carg_x_conex * 3) 
     where l.nuano =  2024
       and l.numes = 12
       and l.solicitud = 188201650
       and l.carg_x_conex = 16783173;
    update open.ldc_osf_serv_pendiente l
       set l.cert_previa = (l.cert_previa * 3) 
     where l.nuano =  2024
       and l.numes = 12
       and l.solicitud = 188201650
       and l.cert_previa = 2502873;
    commit;
    --
    -- CEBE 4106
    --
    -- Inserta registros facturados por memorando solicitud 210790060
    --
    vsbsolici := 210790060;
    vsbclasif := '';
    insert into LDC_OSF_SERV_PENDIENTE (NUANO, NUMES, PRODUCT_ID, ESTADO_TEC, CATEGORIA, SOLICITUD, TIPO_SOLICITUD, TIPO, CEBE, DEPARTAMENTO, LOCALIDAD, TIPO_IDENT, IDENTIFICACION, FEC_VENTA, CONCEPTO, INTERNA, CARG_X_CONEX, CERT_PREVIA, NOTAS, INGRESO_REPORT, VALOR_ANULADO, ORDEN)
    values (2024, 12, 52803639, null, 1, 210790060, 323, 'PROD_CONSTRUC', '4106', 3, 115, 110, '9011162502', NULL, 19, 19815506.00, 0.00, 0.00, 0.00, 0.00, 0.00, NULL);

    insert into LDC_OSF_SERV_PENDIENTE (NUANO, NUMES, PRODUCT_ID, ESTADO_TEC, CATEGORIA, SOLICITUD, TIPO_SOLICITUD, TIPO, CEBE, DEPARTAMENTO, LOCALIDAD, TIPO_IDENT, IDENTIFICACION, FEC_VENTA, CONCEPTO, INTERNA, CARG_X_CONEX, CERT_PREVIA, NOTAS, INGRESO_REPORT, VALOR_ANULADO, ORDEN)
    values (2024, 12, 52803639, null, 1, 210790060, 323, 'PROD_CONSTRUC', '4106', 3, 115, 110, '9011162502', NULL, 400, 0.00, 0.00, 190375.00, 0.00, 0.00, 0.00, NULL);
    commit;
    --
    vsbsolici := 210115502;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -10329216
     where l.nuano =  2024
       and l.numes = 12
       and l.solicitud = 210115502
       and l.cert_previa = 10329216;
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = 0
     where l.nuano =  2024
       and l.numes = 12
       and l.solicitud = 210115502
       and l.interna = 36720000;
    commit;
    --
    vsbsolici := 198985577;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -17293936
     where l.nuano =  2024
       and l.numes = 12
       and l.solicitud = 198985577
       and l.ingreso_report = -17296936;
    commit;
    --
    -- CEBE 4101
    --
    vsbsolici := 207555227;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -64800000
     where l.nuano =  2024
       and l.numes = 12
       and l.solicitud = 207555227;
    commit;
    --
    vsbsolici := 207724578;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -106260000
     where l.nuano =  2024
       and l.numes = 12
       and l.solicitud = 207724578
       and l.interna = 106260000;
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