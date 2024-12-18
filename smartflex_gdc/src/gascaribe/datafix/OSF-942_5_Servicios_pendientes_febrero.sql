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
    vsbsolici := 190033313;
    vsbclasif := 4;  
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.ingreso_report = (p.interna + p.carg_x_conex + p.cert_previa) * -1
    where p.nuano = 2023
      and p.numes = 02 
      and p.solicitud = 190033313;
    commit;
    --
    vsbsolici := 190200929;
    vsbclasif := 4;  
    delete OPEN.LDC_OSF_SERV_PENDIENTE p
    where p.nuano = 2023
      and p.numes = 02 
      and p.solicitud = 190200929
      and p.tipo = 'Ing_Osf';
    commit;
    --
    vsbsolici := 191645343;
    vsbclasif := 4;  
    delete OPEN.LDC_OSF_SERV_PENDIENTE p
    where p.nuano = 2023
      and p.numes = 02 
      and p.solicitud = 191645343
      and p.tipo = 'Ing_Osf';
    commit;  
    --
    vsbsolici := 195160412;
    update open.cargos c
      set c.cargunid = decode(cargunid, 79,2,47)
    where cargdoso = 'PP-186601129' 
      and cargconc in(30);
    commit;
    --
    vsbsolici := 189051233;
    vsbclasif := 4;  
    update OPEN.LDC_OSF_SERV_PENDIENTE p  
      set p.ingreso_report = -248639000
    where p.nuano = 2023
      and p.numes = 02 
      and p.solicitud = 189051233
      and p.concepto = 4;
    commit;
    --  
    vsbsolici := 189051233;
    vsbclasif := 400;  
    update OPEN.LDC_OSF_SERV_PENDIENTE p  
      set p.ingreso_report = -37079600 
    where p.nuano = 2023
      and p.numes = 02 
      and p.solicitud = 189051233
      and p.concepto = 400;
    commit; 
    --
    vsbsolici := 189051233;
    vsbclasif := 400;  
    update OPEN.LDC_OSF_SERV_PENDIENTE p  
      set p.ingreso_report = -65000000 
    where p.nuano = 2023
      and p.numes = 02 
      and p.solicitud = 189051233
      and p.concepto = 19;
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
  commit;
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/