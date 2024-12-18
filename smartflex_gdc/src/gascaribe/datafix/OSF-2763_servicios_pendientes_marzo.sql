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
    -- FEBRERO - 2
    vsbsolici := 205324480;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = 0
     where l.nuano = 2024
       and l.numes in (2)
       and l.solicitud = 205324480
       and l.concepto = 19
       and l.interna = 14326000;
    commit;    
    -- 
    vsbsolici := 205324480;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = -42750000
     where l.nuano = 2024
       and l.numes in (3)
       and l.solicitud = 205324480
       and l.concepto = 19;
    commit;    
    --     
    vsbsolici := 198608517;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = -20160000
     where l.nuano = 2024
       and l.numes in (3)
       and l.solicitud = 198608517
       and l.concepto = 19
       and l.interna = 20160000;
    commit;
    -- Ingreso Real
    --     
    vsbsolici := 202090916;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = -21813942
     where l.nuano = 2024
       and l.numes in (3)
       and l.solicitud = 202090916
       and l.concepto = 400;
    commit;
    --     
    vsbsolici := 202366205;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = -30938732
     where l.nuano = 2024
       and l.numes in (3)
       and l.solicitud = 202366205;
    commit;
    --     
    vsbsolici := 210316380;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = -3242613
     where l.nuano = 2024
       and l.numes in (3)
       and l.solicitud = 210316380
       and l.concepto = 19;
    commit;
    --     
    vsbsolici := 198608517;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = -20160000
     where l.nuano = 2024
       and l.numes in (3)
       and l.solicitud = 198608517
       and l.concepto = 19
       and l.interna = 44640000;
    commit;
    --     
    vsbsolici := 198775030;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = -89100000
     where l.nuano = 2024
       and l.numes in (3)
       and l.solicitud = 198775030
       and l.concepto = 19;
    commit;
    --     
    vsbsolici := 205959291;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = -7031530
     where l.nuano = 2024
       and l.numes in (3)
       and l.solicitud = 205959291
       and l.concepto = 4;
    commit; 
    --     
    vsbsolici := 209565158;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = -49177984
     where l.nuano = 2024
       and l.numes in (3)
       and l.solicitud = 209565158
       and l.concepto = 4;
    commit;
    --     
    vsbsolici := 200595950;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = -4037000
     where l.nuano = 2024
       and l.numes in (3)
       and l.solicitud = 200595950
       and l.concepto = 19;
    commit;
    --     
    vsbsolici := 207283202;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = -14210000
     where l.nuano = 2024
       and l.numes in (3)
       and l.solicitud = 207283202
       and l.concepto = 19;
    commit;    
    --
    vsbsolici := 201643344;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = -14063060
     where l.nuano = 2024
       and l.numes in (3)
       and l.solicitud = 201643344
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