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
      and l.Ingreso_Report > 0;
    commit;
    --
    vsbsolici := 198775030;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
      set l.Ingreso_Report = -178200000
    where l.nuano = 2024
      and l.numes in (6)
      and l.solicitud = 198775030
      and l.concepto = 19;
    commit;  
    --
    vsbsolici := 190929760;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
      set l.Ingreso_Report = -85797373
    where l.nuano = 2024
      and l.numes in (6)
      and l.solicitud = 190929760
      and l.concepto = 19;
    commit;
    --    
    -- Ingreso Real
    vsbsolici := 195876526;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
      set l.Ingreso_Report = -49728000
    where l.nuano = 2024
      and l.numes in (6)
      and l.solicitud = 195876526
      and l.concepto = 19
      and l.interna = 49728000;
    commit;
    --
    vsbsolici := 196412783;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
      set l.Ingreso_Report = -7734683
    where l.nuano = 2024
      and l.numes in (6)
      and l.solicitud = 196412783
      and l.concepto = 4;
    commit;
    --  
    vsbsolici := 202090943;
    update open.ldc_osf_serv_pendiente l
      set l.Ingreso_Report = -703153
    where l.nuano = 2024
      and l.numes in (6)
      and l.solicitud = 202090943
      and l.concepto = 4;
    commit;
    --   
    vsbsolici := 204251153;
    update open.ldc_osf_serv_pendiente l
      set l.Ingreso_Report = -59040000
    where l.nuano = 2024
      and l.numes in (6)
      and l.solicitud = 204251153
      and l.concepto = 19;
    commit;
    --
    vsbsolici := 209408856;
    update open.ldc_osf_serv_pendiente l
      set l.Ingreso_Report = -1866959
    where l.nuano = 2024
      and l.numes in (6)
      and l.solicitud = 209408856
      and l.concepto = 400;
    --
    update open.ldc_osf_serv_pendiente l
      set l.Ingreso_Report = -8820000
    where l.nuano = 2024
      and l.numes in (6)
      and l.solicitud = 209408856
      and l.concepto = 19;     
    commit;
    --
    vsbsolici := 209476599;
    update open.ldc_osf_serv_pendiente l
      set l.Ingreso_Report = -3658264
    where l.nuano = 2024
      and l.numes in (6)
      and l.solicitud = 209476599
      and l.concepto = 400;
    --
    update open.ldc_osf_serv_pendiente l
      set l.Ingreso_Report = -12780000
    where l.nuano = 2024
      and l.numes in (6)
      and l.solicitud = 209476599
      and l.concepto = 19;     
    commit;
    --
    vsbsolici := 212153997;
    update open.ldc_osf_serv_pendiente l
      set l.Ingreso_Report = -1506344
    where l.nuano = 2024
      and l.numes in (6)
      and l.solicitud = 212153997
      and l.concepto = 400;
    commit;
    --
    vsbsolici := 212446982;
    update open.ldc_osf_serv_pendiente l
      set l.Ingreso_Report = -15368120
    where l.nuano = 2024
      and l.numes in (6)
      and l.solicitud = 212446982
      and l.concepto = 4;
    --
    update open.ldc_osf_serv_pendiente l
      set l.Ingreso_Report = -7100000
    where l.nuano = 2024
      and l.numes in (6)
      and l.solicitud = 212446982
      and l.concepto = 19;     
    commit;
    --
    vsbsolici := 213437964;
    update open.ldc_osf_serv_pendiente l
      set l.Ingreso_Report = -1075960
    where l.nuano = 2024
      and l.numes in (6)
      and l.solicitud = 213437964
      and l.concepto = 400;
    commit;
    --
    vsbsolici := 213723628;
    update open.ldc_osf_serv_pendiente l
      set l.Ingreso_Report = -10240000
    where l.nuano = 2024
      and l.numes in (6)
      and l.solicitud = 213723628
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