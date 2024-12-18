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
    vsbsolici := 193125608;  
    vsbclasif := '';
    delete open.ldc_osf_serv_pendiente l
    where l.nuano = 2023
      and l.numes = 7
      and l.solicitud = 193125608
      and l.concepto = 400
      and rownum = 1;
    commit;
    --
    vsbsolici := 181882394;  
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
      set l.ingreso_report = -7042720
    where l.nuano = 2023
      and l.numes = 7
      and l.solicitud = 181882394
      and l.concepto = 400;
    commit;
    --  
    vsbsolici := 188198596;  
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
      set l.ingreso_report = -24120000
    where l.nuano = 2023
      and l.numes = 7
      and l.solicitud = 188198596
      and l.concepto = 19
      and l.ingreso_report = -48240000;
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