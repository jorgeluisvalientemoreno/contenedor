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
    -- ENERO
    vsbsolici := 192844118;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = -21472000
     where l.nuano = 2024
       and l.numes = 1
       and l.solicitud = 192844118
       and l.concepto = 19;
    commit;
    -- 
    vsbsolici := 201669771;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = -61250000
     where l.nuano = 2024
       and l.numes = 1
       and l.solicitud = 201669771
       and l.concepto = 19;
    commit;
    -- 
    vsbsolici := 205324480;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = -66799535
     where l.nuano = 2024
       and l.numes = 1
       and l.solicitud = 205324480
       and l.concepto = 4;
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = -9334795
     where l.nuano = 2024
       and l.numes = 1
       and l.solicitud = 205324480
       and l.concepto = 400;       
    commit;    
    -- 
    vsbsolici := 205887839;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = -25313508
     where l.nuano = 2024
       and l.numes = 1
       and l.solicitud = 205887839
       and l.concepto = 4;
    commit;    
    -- 
    vsbsolici := 204172968;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = -11250448
     where l.nuano = 2024
       and l.numes = 1
       and l.solicitud = 204172968
       and l.concepto = 4;
    commit;    
    --     
    vsbsolici := 207282357;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = -14063060
     where l.nuano = 2024
       and l.numes = 1
       and l.solicitud = 207282357
       and l.concepto = 4;
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = -1965220
     where l.nuano = 2024
       and l.numes = 1
       and l.solicitud = 207282357
       and l.concepto = 400;       
    commit;    
    --
    vsbsolici := 198627603;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = -54435000
     where l.nuano = 2024
       and l.numes = 1
       and l.solicitud = 198627603
       and l.concepto = 19;
    commit;    
    --
    vsbsolici := 203879724;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = -1913601
     where l.nuano = 2024
       and l.numes = 1
       and l.solicitud = 203879724
       and l.concepto = 4;
    commit;    
    --
    vsbsolici := 206790707;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = -24610355
     where l.nuano = 2024
       and l.numes = 1
       and l.solicitud = 206790707
       and l.concepto = 4;
    commit;    
    --
    vsbsolici := 198837749;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = -1473915
     where l.nuano = 2024
       and l.numes = 1
       and l.solicitud = 198837749
       and l.concepto = 400;
    commit;    
    --
    vsbsolici := 202158854;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = -46550000
     where l.nuano = 2024
       and l.numes = 1
       and l.solicitud = 202158854
       and l.concepto = 19;
    commit;    
    --
    vsbsolici := 203098446;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = -13690000
     where l.nuano = 2024
       and l.numes = 1
       and l.solicitud = 203098446
       and l.concepto = 19;
    commit;    
    --
    vsbsolici := 204150734;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = -12656754
     where l.nuano = 2024
       and l.numes = 1
       and l.solicitud = 204150734
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