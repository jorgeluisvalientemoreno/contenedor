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
    vsbsolici := 198134848;  
    vsbclasif := '';   
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.ingreso_report = -11360000
    where p.nuano = 2023 
      and p.numes in (8)
      and p.solicitud = 198134848
      and p.concepto = 19;
    commit;
    --
    vsbsolici := 179080527;  
    vsbclasif := '';   
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.carg_x_conex = 235998124
    where p.nuano = 2023 
      and p.numes in (7,8)
      and p.solicitud = 179080527
      and p.concepto = 4;       
    -- 
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.cert_previa = 31780274
    where p.nuano = 2023 
      and p.numes in (7,8)
      and p.solicitud = 179080527
      and p.concepto = 400;       
    commit;    
    --
    vsbsolici := 192970403;  
    vsbclasif := '';   
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.ingreso_report = -27350356
    where p.nuano = 2023 
      and p.numes in (8)
      and p.solicitud = 192970403
      and p.concepto = 4;       
    -- 
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.ingreso_report = -29480000
    where p.nuano = 2023 
      and p.numes in (8)
      and p.solicitud = 192970403
      and p.concepto = 19;       
    --     
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.interna = 0,
          p.ingreso_report = -4078756
    where p.nuano = 2023 
      and p.numes in (8)
      and p.solicitud = 192970403
      and p.concepto = 400;       
    commit;
    --
    vsbsolici := 194831746;  
    vsbclasif := '';   
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.interna = 0,
          p.carg_x_conex = 144210968
    where p.nuano = 2023 
      and p.numes in (8)
      and p.solicitud = 194831746
      and p.concepto = 4;
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