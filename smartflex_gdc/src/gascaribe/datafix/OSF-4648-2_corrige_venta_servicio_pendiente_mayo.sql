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
    -- Corregimos facturacion de Sta Marta
    -- CEBE 4127
    vsbsolici := 201480636;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
       set l.carg_x_conex = l.carg_x_conex * 2
     where l.nuano = 2025
       and l.numes = 5
       and l.solicitud = 197330102
       and l.concepto = 4;
    update open.ldc_osf_serv_pendiente l
       set l.cert_previa = l.cert_previa * 2
     where l.nuano = 2025
       and l.numes = 5
       and l.solicitud = 197330102
       and l.concepto = 400;
    update open.ldc_osf_serv_pendiente l
       set l.interna = l.interna * 2
     where l.nuano = 2025
       and l.numes = 5
       and l.solicitud = 197330102
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