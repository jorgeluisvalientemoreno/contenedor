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
    vsbsolici := 10667110;
    vsbclasif := 19;  
    delete OPEN.LDC_OSF_SERV_PENDIENTE p  
    where p.nuano = 2023
      and p.numes = 02 
      and p.solicitud = 10667110
      and p.tipo = 'Ing_Osf';
    commit;
    --  
    vsbsolici := 10667110;
    vsbclasif := 30;  
    update OPEN.LDC_OSF_SERV_PENDIENTE p  
      set p.ingreso_report = -13374671
    where p.nuano = 2023
      and p.numes = 02 
      and p.solicitud = 10667110
      and p.interna > 0;
    commit;
    --  
    vsbsolici := 179342664;
    vsbclasif := 19;  
    update OPEN.LDC_OSF_SERV_PENDIENTE p  
      set p.interna = 26495408
    where p.nuano = 2023
      and p.numes = 02 
      and p.solicitud = 179342664
      and p.interna > 0;
    commit;  
    --
    vsbsolici := 189051233;
    vsbclasif := 19;  
    update OPEN.LDC_OSF_SERV_PENDIENTE p  
      set p.ingreso_report = -81250000
    where p.nuano = 2023
      and p.numes = 02 
      and p.solicitud = 189051233 -- 189051233
      and p.interna > 0;
    commit;   
    --
    vsbsolici := 189051233;
    vsbclasif := 4;  
    update OPEN.LDC_OSF_SERV_PENDIENTE p  
      set p.ingreso_report = -248639600
    where p.nuano = 2023
      and p.numes = 02 
      and p.solicitud = 189051233 -- 189051233
      and p.carg_x_conex > 0;
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