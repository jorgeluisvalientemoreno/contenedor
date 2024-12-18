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
    vsbsolici := 195160412;  
    vsbclasif := '';   
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.ingreso_report = -54700712
    where p.nuano = 2023 
      and p.numes in (7) 
      and p.solicitud = 195160412
      and p.concepto = 4
      and p.tipo = 'SIN_PRODUCTOS';
    --
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.ingreso_report = -8157512
    where p.nuano = 2023 
      and p.numes in (7) 
      and p.solicitud = 195160412
      and p.concepto = 400
      and p.tipo = 'SIN_PRODUCTOS'; 
    commit;
    --
    vsbsolici := 199110672;  
    vsbclasif := '';   
    delete OPEN.LDC_OSF_SERV_PENDIENTE p
    where p.nuano = 2023 
      and p.numes in (7) 
      and p.solicitud = 199110672
      and p.carg_x_conex < 27422967;
    --
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.carg_x_conex = 28829273,
          p.ingreso_report = -54845934
    where p.nuano = 2023 
      and p.numes in (7) 
      and p.solicitud = 199110672
      and p.concepto = 4;
    commit;
    --
    vsbsolici := 198888652;  
    vsbclasif := '';
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.ingreso_report = -133599070
    where p.nuano = 2023 
      and p.numes in (7) 
      and p.solicitud = 198888652
      and p.concepto = 4;
    --    
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.ingreso_report = -18866112
    where p.nuano = 2023 
      and p.numes in (7) 
      and p.solicitud = 198888652
      and p.concepto = 400;
    commit;  
    --
    vsbsolici := 199237665;  
    vsbclasif := '';   
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.ingreso_report = -1250000
    where p.nuano = 2023 
      and p.numes in (7) 
      and p.solicitud = 199237665
      and p.concepto = 19;
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