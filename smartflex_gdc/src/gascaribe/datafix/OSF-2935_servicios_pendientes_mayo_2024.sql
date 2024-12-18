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
    vsbsolici := 205892473;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = 0
     where l.nuano = 2024
       and l.numes in (5)
       and l.solicitud = 205892473
       and l.concepto = 19;
    commit;
    --
    vsbsolici := 135038591;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = 0
     where l.nuano = 2024
       and l.numes in (5)
       and l.solicitud = 135038591
       and l.concepto = 19;
    commit;
    --
    vsbsolici := 110526032;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = 0
     where l.nuano = 2024
       and l.numes in (5)
       and l.solicitud = 110526032
       and l.concepto = 19;
    commit;    
    --    
    -- INgreso Real
    vsbsolici := 192844118;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = -54079113
     where l.nuano = 2024
       and l.numes in (5)
       and l.solicitud = 192844118
       and l.concepto = 4;
    commit;
    --
    vsbsolici := 198645312;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = -55549087
     where l.nuano = 2024
       and l.numes in (5)
       and l.solicitud = 198645312
       and l.concepto = 4;
    --
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = -7762619
     where l.nuano = 2024
       and l.numes in (5)
       and l.solicitud = 198645312
       and l.concepto = 400;           
    commit;
    --
    vsbsolici := 201341105;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = -50880000
     where l.nuano = 2024
       and l.numes in (5)
       and l.solicitud = 201341105
       and l.concepto = 19;
    commit;
    --
    vsbsolici := 212552189;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = -15493824
     where l.nuano = 2024
       and l.numes in (5)
       and l.solicitud = 212552189
       and l.concepto = 400;
    commit;
    --
    vsbsolici := 190016167;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = -25200000
     where l.nuano = 2024
       and l.numes in (5)
       and l.solicitud = 190016167
       and l.concepto = 19;
    commit;
    --
    vsbsolici := 197721438;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = -14063060
     where l.nuano = 2024
       and l.numes in (5)
       and l.solicitud = 197721438
       and l.concepto = 4;
    --
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = -1965220
     where l.nuano = 2024
       and l.numes in (5)
       and l.solicitud = 197721438
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