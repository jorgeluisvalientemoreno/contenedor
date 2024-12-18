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
    vsbsolici := 189441237;
    vsbclasif := 19;  
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.ingreso_report = -3640000
    where p.nuano = 2023
      and p.numes in (5) 
      and p.solicitud = 189441237;
    commit;
    --
    vsbsolici := 195980358;
    vsbclasif := 19;  
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.ingreso_report = -23765000
    where p.nuano = 2023
      and p.numes in (5) 
      and p.solicitud = 195980358;
    commit;
    --  
    vsbsolici := 187578605;
    vsbclasif := 4;  
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.interna = 0
    where p.nuano = 2023
      and p.numes in (5) 
      and p.solicitud = 187578605
      and p.concepto = 4;
    commit;
    --  
    vsbsolici := 187578605;
    vsbclasif := 4;  
    delete OPEN.LDC_OSF_SERV_PENDIENTE p
    where p.nuano = 2023
      and p.numes in (5) 
      and p.solicitud IS NULL
      and p.tipo = 'NOTA_MES'
      and p.ingreso_report = -26488000;
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