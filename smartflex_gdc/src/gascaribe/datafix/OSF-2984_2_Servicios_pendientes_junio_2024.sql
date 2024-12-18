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
    -- Servicios Cumplidos
    vsbsolici := 198608517;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
      set l.Ingreso_Report = -60480000
    where l.nuano = 2024
      and l.numes in (6)
      and l.solicitud = 198608517
      and l.concepto = 19
      and l.Ingreso_Report <> 0;
    commit;
    --
    vsbsolici := 200715350;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
      set l.Ingreso_Report = -36000000
    where l.nuano = 2024
      and l.numes in (6)
      and l.solicitud = 200715350
      and l.concepto = 19
      and l.Ingreso_Report <> 0;
    commit;
    --
    vsbsolici := 200271871;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
      set l.Ingreso_Report = -38160000
    where l.nuano = 2024
      and l.numes in (6)
      and l.solicitud = 200271871
      and l.concepto = 19
      and l.Ingreso_Report <> 0;
    commit;
    --
    vsbsolici := 200747716;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
      set l.Ingreso_Report = -17460000
    where l.nuano = 2024
      and l.numes in (6)
      and l.solicitud = 200747716
      and l.concepto = 19
      and l.Ingreso_Report <> 0;
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