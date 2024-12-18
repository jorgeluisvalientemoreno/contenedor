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
    -- Septiembre
    vsbsolici := 205141895;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -98325000
     where l.nuano =  2024
       and l.numes = (9)
       and l.solicitud = 205141895;
    commit;
    --
    vsbsolici := 205678021;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -48640000
     where l.nuano =  2024
       and l.numes = (9)
       and l.solicitud = 205678021;
    commit;
    --
    vsbsolici := 212153997;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -2305218
     where l.nuano =  2024
       and l.numes = (9)
       and l.solicitud = 212153997
       and l.concepto = 4
       and l.carg_x_conex = 2305218;
    commit;
    --
    vsbsolici := 213329720;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -10440000
     where l.nuano =  2024
       and l.numes = (9)
       and l.solicitud = 213329720
       and l.concepto = 19;
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