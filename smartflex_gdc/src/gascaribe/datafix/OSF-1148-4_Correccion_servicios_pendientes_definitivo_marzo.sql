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
    -- CEBE 4158
    --
    vsbsolici := 197113361;
    vsbclasif := '';  
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.departamento = 2,
          p.localidad = 5,
          p.cebe = 4158
    where p.nuano = 2023
      and p.numes = 03 
      and p.solicitud = 197113361;
    commit;
    --
    vsbsolici := 192184974;
    vsbclasif := '';  
    DELETE OPEN.LDC_OSF_SERV_PENDIENTE p
    where p.nuano = 2023
      and p.numes = 03 
      and p.solicitud = 192184974;
    commit;
    --
    -- CEBE 4101
    vsbsolici := 191645343;
    vsbclasif := '';  
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.ingreso_report = -621599
    where p.nuano = 2023
      and p.numes = 03 
      and p.solicitud = 191645343
      and p.product_id = 52496140;
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