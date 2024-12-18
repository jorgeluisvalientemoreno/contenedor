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
    -- Septiembre - Eliminar notas ajustadas en contabilidad
    vsbsolici := 52575595;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.notas = 0
     where l.nuano = 2024
       and l.numes in (8)
       and l.product_id = 52575595
       and l.notas != 0;
    commit;
    --
    vsbsolici := 52380076;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.notas = 0
     where l.nuano = 2024
       and l.numes in (8)
       and l.product_id = 52380076
       and l.notas != 0;
    commit;
    --
    vsbsolici := 52497439;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.notas = 0
     where l.nuano = 2024
       and l.numes in (8)
       and l.product_id = 52497439
       and l.notas != 0;
    commit;
    --
    vsbsolici := 52497461;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.notas = 0
     where l.nuano = 2024
       and l.numes in (8)
       and l.product_id = 52497461
       and l.notas != 0;
    commit;
    --
    vsbsolici := 52517915;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.notas = 0
     where l.nuano = 2024
       and l.numes in (8)
       and l.product_id = 52517915
       and l.notas != 0;
    commit;
    --
    vsbsolici := 52519509;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.notas = 0
     where l.nuano = 2024
       and l.numes in (8)
       and l.product_id = 52519509
       and l.notas = -355342;
    commit;
    --
    vsbsolici := 52631145;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.notas = 0
     where l.nuano = 2024
       and l.numes in (8)
       and l.product_id = 52631145
       and l.notas != 0;
    commit;
    --
    vsbsolici := 52649473;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.notas = 0
     where l.nuano = 2024
       and l.numes in (8)
       and l.product_id = 52649473
       and l.notas != 0;
    commit;
    --
    vsbsolici := 52664380;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.notas = 0
     where l.nuano = 2024
       and l.numes in (8)
       and l.product_id = 52664380
       and l.notas != 0;
    commit;
    --
    vsbsolici := 52673673;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.notas = 0
     where l.nuano = 2024
       and l.numes in (8)
       and l.product_id = 52673673
       and l.notas != 0;
    commit;
    --
    vsbsolici := 52808647;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.notas = 0
     where l.nuano = 2024
       and l.numes in (8)
       and l.product_id = 52808647
       and l.notas != 0;
    commit;    
    --    
    DBMS_OUTPUT.PUT_LINE('Proceso termina Ok.');
    --
  Exception
    when others then
        ROLLBACK;
          DBMS_OUTPUT.PUT_LINE('Error solicitud : ' || vsbsolici || '  clasificador : ' || vsbclasif ||'   ' || SQLERRM);

  end;
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/