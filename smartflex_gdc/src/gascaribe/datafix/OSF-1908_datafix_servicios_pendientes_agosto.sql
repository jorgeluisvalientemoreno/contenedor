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
    --
    vsbsolici := 194825000;  
    vsbclasif := '';   
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.ingreso_report = -95104647
    where p.nuano = 2023 
      and p.numes in (7)
      and p.solicitud = 194825000
      and p.concepto = 4;
    --
    vsbsolici := 194825000;  
    vsbclasif := '';   
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.ingreso_report = -108158226
    where p.nuano = 2023 
      and p.numes in (8)
      and p.solicitud = 194825000
      and p.concepto = 4;       
    commit;  
    --
    vsbsolici := 193206355;  
    vsbclasif := '';   
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.ingreso_report = -76985000
    where p.nuano = 2023 
      and p.numes in (8)
      and p.solicitud = 193206355
      and p.concepto = 19;       
    commit;  
    --  
    vsbsolici := 195213587;  
    vsbclasif := '';   
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.ingreso_report = -8000000
    where p.nuano = 2023 
      and p.numes in (8)
      and p.solicitud = 195213587
      and p.concepto = 19;       
    commit;  
    --  
    vsbsolici := 195213699;  
    vsbclasif := '';   
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.ingreso_report = -8000000
    where p.nuano = 2023 
      and p.numes in (8)
      and p.solicitud = 195213699
      and p.concepto = 19;       
    commit;  
    --
    vsbsolici := 195377220;  
    vsbclasif := '';   
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.ingreso_report = -12328967
    where p.nuano = 2023 
      and p.numes in (8)
      and p.solicitud = 195377220
      and p.concepto = 400;       
    commit;  
    --  
    vsbsolici := 195390433;  
    vsbclasif := '';   
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.ingreso_report = -30458351
    where p.nuano = 2023 
      and p.numes in (8)
      and p.solicitud = 195390433
      and p.concepto = 4;       
    commit;  
    -- 
    vsbsolici := 195390433;  
    vsbclasif := '';   
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.ingreso_report = -4542251
    where p.nuano = 2023 
      and p.numes in (8)
      and p.solicitud = 195390433
      and p.concepto = 400;       
    commit;  
    --
    vsbsolici := 195582335;  
    vsbclasif := '';   
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.ingreso_report = -14000000
    where p.nuano = 2023 
      and p.numes in (8)
      and p.solicitud = 195582335
      and p.concepto = 19;       
    commit;  
    --
    vsbsolici := 197399572;  
    vsbclasif := '';   
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.ingreso_report = -12600000
    where p.nuano = 2023 
      and p.numes in (8)
      and p.solicitud = 197399572
      and p.concepto = 19;
    --
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.ingreso_report = -25313508
    where p.nuano = 2023 
      and p.numes in (8)
      and p.solicitud = 197399572
      and p.concepto = 4;
    --
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.ingreso_report = -3537396
    where p.nuano = 2023 
      and p.numes in (8)
      and p.solicitud = 197399572
      and p.concepto = 400;
    commit;  
    --  
    vsbsolici := 199630784;  
    vsbclasif := '';   
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.ingreso_report = -7410000
    where p.nuano = 2023 
      and p.numes in (8)
      and p.solicitud = 199630784
      and p.concepto = 19;
    --
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.ingreso_report = -13359907
    where p.nuano = 2023 
      and p.numes in (8)
      and p.solicitud = 199630784
      and p.concepto = 4;
    --
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.ingreso_report = -1866959
    where p.nuano = 2023 
      and p.numes in (8)
      and p.solicitud = 199630784
      and p.concepto = 400;
    commit;  
    --     
    vsbsolici := 201178015;  
    vsbclasif := '';   
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.ingreso_report = -5610000
    where p.nuano = 2023 
      and p.numes in (8)
      and p.solicitud = 201178015
      and p.concepto = 19;
    commit;
    --
    vsbsolici := 179342664;  
    vsbclasif := '';   
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.ingreso_report = -22952436
    where p.nuano = 2023 
      and p.numes in (8)
      and p.solicitud = 179342664
      and p.concepto = 4;
    --
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.ingreso_report = -3433326
    where p.nuano = 2023 
      and p.numes in (8)
      and p.solicitud = 179342664
      and p.concepto = 400;
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