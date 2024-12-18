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
    vsbsolici := 212153997;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.carg_x_conex = 3842030,
           l.ingreso_report = -3842030
     where l.nuano =  2024
       and l.numes = (9)
       and l.carg_x_conex = -3842030
       and l.solicitud = 212153997;
    commit;
    --
    vsbsolici := 198359752;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.carg_x_conex = 0,
           l.ingreso_report = -50400000
     where l.nuano =  2024
       and l.numes = (9)
       and l.solicitud = 198359752
       and l.concepto = 19;
    commit;
    --
    vsbsolici := 199110672;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.carg_x_conex = 28829273,
           l.ingreso_report = -27422967
     where l.nuano =  2024
       and l.numes = (9)
       and l.solicitud = 199110672
       and l.concepto = 4;
    commit;
    -- 
    vsbsolici := 213514006;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.carg_x_conex = 91440314,
           l.ingreso_report = -91440314
     where l.nuano =  2024
       and l.numes = (9)
       and l.solicitud = 213514006
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