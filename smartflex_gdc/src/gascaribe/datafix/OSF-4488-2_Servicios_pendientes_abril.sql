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
    vsbsolici := 223274744;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -82453026
     where l.nuano = 2025
       and l.numes = 4
       and l.solicitud = 223274744
       and l.concepto = 4;
    commit;
    --
    vsbsolici := 220794547;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -12294496
     where l.nuano = 2025
       and l.numes = 4
       and l.solicitud = 220794547
       and l.concepto = 4;
    commit;
    --
    vsbsolici := 210115502;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -93552000
     where l.nuano = 2025
       and l.numes = 4
       and l.solicitud = 210115502
       and l.concepto = 19
       and l.interna = 65136000;
    commit;
    --
    vsbsolici := 223274744;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -82453026
     where l.nuano = 2025
       and l.numes = 4
       and l.solicitud = 223274744
       and l.concepto = 4;
    commit;
    --
    vsbsolici := 216014885;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -13557096
     where l.nuano = 2025
       and l.numes = 4
       and l.solicitud = 216014885
       and l.concepto = 400
       and l.cert_previa = 13341904;
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