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
    -- Ajustamos proyectos
    -- CEBE 4123
    vsbsolici := 214152730;
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -10757684
     where l.nuano = 2025
       and l.numes = 6
       and l.solicitud = 214152730
       and l.concepto = 4
       and l.carg_x_conex = 10757684;
    commit;
    --
    vsbsolici := 220794547;    
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -1721536
     where l.nuano = 2025
       and l.numes = 6
       and l.solicitud = 220794547
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