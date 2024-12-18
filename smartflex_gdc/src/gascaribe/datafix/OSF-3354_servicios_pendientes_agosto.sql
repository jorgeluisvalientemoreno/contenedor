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
      -- Agosto
      vsbsolici := 189357220;
      vsbclasif := '';   
      update open.ldc_osf_serv_pendiente l
        set l.Ingreso_Report = -4200000
      where l.nuano = 2024
        and l.numes in (8)
        and l.solicitud = 189357220
        and l.concepto = 19;
      commit;
      --
      vsbsolici := 197415684;
      vsbclasif := '';   
      update open.ldc_osf_serv_pendiente l
        set l.Ingreso_Report = -68950000
      where l.nuano = 2024
        and l.numes in (8)
        and l.solicitud = 197415684
        and l.concepto = 19;
      commit;
      --
      vsbsolici := 198359752;
      vsbclasif := '';   
      update open.ldc_osf_serv_pendiente l
        set l.Ingreso_Report = -3930440
      where l.nuano = 2024
        and l.numes in (8)
        and l.solicitud = 198359752
        and l.concepto = 400;
      --
      update open.ldc_osf_serv_pendiente l
        set l.Ingreso_Report = -54400000
      where l.nuano = 2024
        and l.numes in (8)
        and l.solicitud = 198359752
        and l.concepto = 19;       
      commit;
      --
      vsbsolici := 198375667;
      vsbclasif := '';   
      update open.ldc_osf_serv_pendiente l
        set l.Ingreso_Report = -98261
      where l.nuano = 2024
        and l.numes in (8)
        and l.solicitud = 198375667
        and l.concepto = 400;
      commit;
      --
      vsbsolici := 207496750;
      vsbclasif := '';   
      update open.ldc_osf_serv_pendiente l
        set l.Ingreso_Report = -10612188
      where l.nuano = 2024
        and l.numes in (8)
        and l.solicitud = 207496750
        and l.concepto = 400;
      commit;
      --
      vsbsolici := 208298826;
      vsbclasif := '';   
      update open.ldc_osf_serv_pendiente l
        set l.Ingreso_Report = -52800000
      where l.nuano = 2024
        and l.numes in (8)
        and l.solicitud = 208298826
        and l.concepto = 19;
      commit;
      --
      vsbsolici := 208298826;
      vsbclasif := '';   
      update open.ldc_osf_serv_pendiente l
        set l.Ingreso_Report = -52800000
      where l.nuano = 2024
        and l.numes in (8)
        and l.solicitud = 208298826
        and l.concepto = 19;
      commit;
      --
      vsbsolici := 211751081;
      vsbclasif := '';   
      update open.ldc_osf_serv_pendiente l
        set l.Ingreso_Report = -67619728
      where l.nuano = 2024
        and l.numes in (8)
        and l.solicitud = 211751081
        and l.concepto = 4;
      commit;
      --
      vsbsolici := 212355558;
      vsbclasif := '';   
      update open.ldc_osf_serv_pendiente l
        set l.Ingreso_Report = -38616000
      where l.nuano = 2024
        and l.numes in (8)
        and l.solicitud = 212355558
        and l.concepto = 19;
      commit;
      --
      vsbsolici := 214152778;
      vsbclasif := '';   
      update open.ldc_osf_serv_pendiente l
        set l.Ingreso_Report = -1721536
      where l.nuano = 2024
        and l.numes in (8)
        and l.solicitud = 214152778
        and l.concepto = 400;
      --
      update open.ldc_osf_serv_pendiente l
        set l.Ingreso_Report = -12294496
      where l.nuano = 2024
        and l.numes in (8)
        and l.solicitud = 214152778
        and l.concepto = 4;       
      commit;
      --
      vsbsolici := 214984611;
      vsbclasif := '';   
      update open.ldc_osf_serv_pendiente l
        set l.Ingreso_Report = -1075960
      where l.nuano = 2024
        and l.numes in (8)
        and l.solicitud = 214984611
        and l.concepto = 400;
      --
      update open.ldc_osf_serv_pendiente l
        set l.Ingreso_Report = -7684060
      where l.nuano = 2024
        and l.numes in (8)
        and l.solicitud = 214984611
        and l.concepto = 4;       
      commit;
      --
      vsbsolici := 215016265;
      vsbclasif := '';   
      update open.ldc_osf_serv_pendiente l
        set l.Ingreso_Report = -79914224
      where l.nuano = 2024
        and l.numes in (8)
        and l.solicitud = 215016265
        and l.concepto = 4;       
      commit;
      --
      vsbsolici := 216382336;
      vsbclasif := '';   
      update open.ldc_osf_serv_pendiente l
        set l.Ingreso_Report = -76840600
      where l.nuano = 2024
        and l.numes in (8)
        and l.solicitud = 216382336
        and l.concepto = 4;       
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