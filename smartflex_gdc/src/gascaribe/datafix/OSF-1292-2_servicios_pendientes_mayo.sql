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
    vsbsolici := 175333049;
    vsbclasif := 19;  
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.ingreso_report = -26488000,
          p.concepto = 19
    where p.nuano = 2023
      and p.numes in (5) 
      and p.solicitud = 175333049;
    commit;
    --
    vsbsolici := 190656698;
    vsbclasif := 19;  
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.ingreso_report = -49280000
    where p.nuano = 2023
      and p.numes in (5) 
      and p.solicitud = 190656698
      and p.concepto = 19;
    commit;
    --  
    vsbsolici := 191226013;
    vsbclasif := 19;  
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.ingreso_report = -66926000 
    where p.nuano = 2023
      and p.numes in (5) 
      and p.solicitud = 191226013
      and p.concepto = 19;
    commit;
    --
    vsbsolici := 194066594;
    vsbclasif := 19;
    delete OPEN.LDC_OSF_SERV_PENDIENTE p
    where p.nuano = 2023 
      and p.numes in (5) 
      and p.solicitud = 194066594
      and rownum < 5;
    --  
    vsbsolici := 194066594;
    vsbclasif := 19;  
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.interna = 88320000
    where p.nuano = 2023
      and p.numes in (5) 
      and p.solicitud = 194066594
      and p.concepto = 19;
    commit;
    --
    vsbsolici := 198134848;
    vsbclasif := 19;  
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.interna = 1888000
    where p.nuano = 2023
      and p.numes in (5) 
      and p.solicitud = 198134848
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