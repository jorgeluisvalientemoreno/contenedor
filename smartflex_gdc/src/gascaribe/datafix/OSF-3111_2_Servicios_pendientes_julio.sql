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
    -- CEBE 4106
    -- Correcciones Servicios Cumplidos
    vsbsolici := 198775030;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
      set l.Ingreso_Report = 0
    where l.nuano = 2024
      and l.numes in (7)
      and l.solicitud = 198775030
      and l.concepto = 19
      and rownum = 1;
    update open.ldc_osf_serv_pendiente l
      set l.Ingreso_Report = -222750000
    where l.nuano = 2024
      and l.numes in (7)
      and l.solicitud = 198775030
      and l.concepto = 19
      and l.ingreso_report = -222420000;
    commit;     
    --
    vsbsolici := 214147328;
    update open.ldc_osf_serv_pendiente l
      set l.Ingreso_Report = -2160000
    where l.nuano = 2024
      and l.numes in (7)
      and l.solicitud = 214147328;
    commit;  
    --
    vsbsolici := 195390433;
    vsbclasif := '';
    update open.ldc_osf_serv_pendiente l
      set l.Ingreso_Report = -2670000
    where l.nuano = 2024
      and l.numes in (7)
      and l.solicitud = 195390433
      and l.concepto = 19;
    commit;
    --
    vsbsolici := 198837749;
    update open.ldc_osf_serv_pendiente l
      set l.notas = 0
    where l.nuano = 2024
      and l.numes in (7)
      and l.product_id = 52616663
      and l.notas != 0;
    commit;  
    --
    vsbsolici := 198627603;
    update open.ldc_osf_serv_pendiente l
      set l.notas = 0
    where l.nuano = 2024
      and l.numes in (7)
      and l.product_id = 52613455
      and l.notas != 0;
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