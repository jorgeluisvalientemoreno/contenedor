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
    vsbsolici := 213985981;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = 0
     where l.nuano = 2025
       and l.numes = 3
       and l.solicitud = 213985981
       and l.concepto = 400
       and l.cert_previa = 12803924;
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