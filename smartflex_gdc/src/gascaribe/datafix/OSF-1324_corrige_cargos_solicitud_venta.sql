column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin
  Declare
    vnuconc varchar2(4);
  Begin
  -- Interna
    vnuconc := 30;  
    update open.cargos c
      set cargvalo = 33856000
    where cargdoso = 'PP-181882394'
      and cargconc = 30;
    -- IVA Interna
    vnuconc := 287;    
    update open.cargos c
      set cargvalo = 643264
    where cargdoso = 'PP-181882394'
      and cargconc = 287;
    -- CxC
    vnuconc := 19;  
    update open.cargos c
      set cargvalo = 54144208
    where cargdoso = 'PP-181882394'
      and cargconc = 19;
    -- C.P.
    vnuconc := 674;    
    update open.cargos c
      set cargvalo = 8099128
    where cargdoso = 'PP-181882394'
      and cargconc = 674;
    -- IVA C.P.
    vnuconc := 137;    
    update open.cargos c
      set cargvalo = 1538834
    where cargdoso = 'PP-181882394'
      and cargconc = 137; 
    --
    commit;
    --
    DBMS_OUTPUT.PUT_LINE('Proceso termina Ok.');
    --
    --
  Exception
    when others then
        ROLLBACK;
          DBMS_OUTPUT.PUT_LINE('Error solicitud : 181882394' || '  concepto : ' || vnuconc ||'   ' || SQLERRM);
  end;
  commit;
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/