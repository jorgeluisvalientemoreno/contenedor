column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin

  dbms_output.put_line('Inicia OSF-3622');

  UPDATE cargos SET cargdoso = 'PP-CB-202411'
  WHERE cargcuco = 3072301537 AND cargconc = 17;

  UPDATE cargos SET cargdoso = 'PP-'
  WHERE cargcuco = 3072301537 AND cargconc = 156;

  UPDATE cargos SET cargdoso = 'PP-CB-202411'
  WHERE cargcuco = 3072301550 AND cargconc = 17;

  UPDATE cargos SET cargdoso = 'PP-CB-202411'
  WHERE cargcuco = 3072301549 AND cargconc = 17;
 
  update factura set factfege = sysdate 
  where factcodi in (2141859178,2141859177,2141859165);

  commit;
   dbms_output.put_line('Termina OSF-3622');

EXCEPTION
    WHEN OTHERS THEN
      rollback;
      DBMS_OUTPUT.PUT_LINE('Error no controlado --> ' || sqlerrm);
  END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/