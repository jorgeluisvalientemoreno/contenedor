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
    vsbsolici := 206458609;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = -35157650
     where l.nuano = 2023
       and l.numes = 12
       and l.solicitud = 206458609
       and l.concepto = 4;
    commit;
    --
    vsbsolici := 204684760;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = -3300000
     where l.nuano = 2023
       and l.numes = 12
       and l.solicitud = 204684760
       and l.concepto = 4;
    commit;
    --
    vsbsolici := 197444261;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = 0
     where l.nuano = 2023
       and l.numes = 12
       and l.solicitud = 197444261
       and l.concepto = 19
       and l.tipo = 'PROD_CONSTRUC';
    commit;
    --    
    vsbsolici := 203098446;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = -25313508
     where l.nuano = 2023
       and l.numes = 12
       and l.solicitud = 203098446
       and l.concepto = 4;
    commit;
    --    
    vsbsolici := 198134848;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = -22500896
     where l.nuano = 2023
       and l.numes = 12
       and l.solicitud = 198134848
       and l.concepto = 4;
    commit;    
    --
    vsbsolici := 194065261;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = 0
     where l.nuano = 2023
       and l.numes = 12
       and l.solicitud = 194065261
       and l.concepto = 19
       and l.tipo = '';
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