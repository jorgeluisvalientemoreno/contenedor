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
  vsbclasif := null;
  delete OPEN.LDC_OSF_SERV_PENDIENTE p
   where p.nuano = 2023
     and p.numes = 01 
     and p.solicitud in (10667110)
     and p.tipo = 'Ing_Mig';
  --
  vsbsolici := 10667110;
  vsbclasif := 4;
  update OPEN.LDC_OSF_SERV_PENDIENTE p
     set p.ingreso_report = p.carg_x_conex * -1
   where p.nuano = 2023
     and p.numes = 01 
     and p.solicitud in (10667110)
     and p.carg_x_conex > 0;
  commit;
  --
  vsbsolici := 190246557;
  vsbclasif := null;
  update OPEN.LDC_OSF_SERV_PENDIENTE p
     set p.ingreso_report = p.interna * -1 
   where p.nuano = 2023
     and p.numes = 01 
     and p.solicitud in (190246557)
     and p.interna > 0;
    commit;
  --
  vsbsolici := 179342664;
  vsbclasif := 4;
  update OPEN.LDC_OSF_SERV_PENDIENTE p
     set p.interna = 27055408,
         p.ingreso_report = -21840000
   where p.nuano = 2023
     and p.numes = 1
     and p.solicitud in (179342664)
     and rownum = 1;
  commit;
  delete OPEN.LDC_OSF_SERV_PENDIENTE p
   where p.nuano = 2023
     and p.numes = 1
     and p.solicitud in (179342664)
     and p.interna = 560000;
  commit;
    -- Correccion cargos para el mes de febrero
  vsbsolici := 188194601;
  vsbclasif := '';
  update open.cargos c
     set c.cargunid = 88
   where cargdoso = 'PP-188194601' 
     and cargconc in(30,674);
  commit;
  --
  vsbsolici := 189554700;
  update open.cargos c
     set c.cargunid = 88
   where cargdoso = 'PP-189554700' 
     and cargconc in(30);
  commit;
  --
  vsbsolici := 195160412;
  update open.cargos c
     set c.cargunid = 106
   where cargdoso = 'PP-195160412' 
     and cargconc in(30);
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
  
  --
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/