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
      set l.Ingreso_Report = -222420000
    where l.nuano = 2024
      and l.numes in (7)
      and l.solicitud = 198775030
      and l.concepto = 19
      and l.ingreso_report is not null;    
    commit;
    -- Ingreso Real
    vsbsolici := 207219572;
    update open.ldc_osf_serv_pendiente l
      set l.Ingreso_Report = (l.interna + l.carg_x_conex + l.cert_previa) * -1
    where l.nuano = 2024
      and l.numes in (7)
      and l.solicitud = 207219572;
    commit;
    --
    vsbsolici := 207283202;
    update open.ldc_osf_serv_pendiente l
      set l.Ingreso_Report = (l.interna + l.carg_x_conex + l.cert_previa) * -1
    where l.nuano = 2024
      and l.numes in (7)
      and l.solicitud = 207283202
      and l.concepto = 4;
    commit;
    --
    vsbsolici := 207283284;
    update open.ldc_osf_serv_pendiente l
      set l.Ingreso_Report = -71721606
    where l.nuano = 2024
      and l.numes in (7)
      and l.solicitud = 207283284
      and l.concepto = 4;
    commit;
    --  
    vsbsolici := 207495574;
    update open.ldc_osf_serv_pendiente l
      set l.Ingreso_Report = -29160000
    where l.nuano = 2024
      and l.numes in (7)
      and l.solicitud = 207495574
      and l.concepto = 19;
    commit;
    --  
    vsbsolici := 212488827;
    update open.ldc_osf_serv_pendiente l
      set l.Ingreso_Report = -l.carg_x_conex
    where l.nuano = 2024
      and l.numes in (7)
      and l.solicitud = 212488827;
    commit;
    --
    vsbsolici := 214147328;
    update open.ldc_osf_serv_pendiente l
      set l.Ingreso_Report = -l.carg_x_conex
    where l.nuano = 2024
      and l.numes in (7)
      and l.solicitud = 214147328;
    commit;
    --
    vsbsolici := 215011499;
    update open.ldc_osf_serv_pendiente l
      set l.Ingreso_Report = (l.interna + l.carg_x_conex + l.cert_previa) * -1
    where l.nuano = 2024
      and l.numes in (7)
      and l.solicitud = 215011499;
    commit;
    --
    -- Ajustes Contables
    --
    vsbsolici := 198134848;
    update open.ldc_osf_serv_pendiente l
      set l.Ingreso_Report = -12053373
    where l.nuano = 2024
      and l.numes in (7)
      and l.solicitud = 198134848
      and l.concepto = 19;
    commit;  
    --
    vsbsolici := 198627603;
    delete open.ldc_osf_serv_pendiente l
    where l.nuano = 2024
      and l.numes in (7)
      and l.solicitud = 198627603
      and l.notas != 0;
    commit;
    --
    vsbsolici := 198837749;
    delete open.ldc_osf_serv_pendiente l
    where l.nuano = 2024
      and l.numes in (7)
      and l.solicitud = 198837749
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