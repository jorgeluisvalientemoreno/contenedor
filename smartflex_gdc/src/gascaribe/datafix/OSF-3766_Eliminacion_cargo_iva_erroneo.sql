column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE
 nuValor number;
 
  CURSOR cuVato IS
  SELECT  SUM(decode(cargos.cargsign, 'DB', cargos.cargvalo, 'CR', -cargos.cargvalo)) VATO
  FROM cuencobr, cargos
  WHERE cargos.cargcuco = cuencobr.cucocodi
     AND cuencobr.cucofact = 2142214559
     AND cargos.cargsign IN ('DB', 'CR')
     AND cargos.cargprog <> 6;

BEGIN
    DELETE FROM cargos WHERE ROWID ='AACIYwAD8AAKYB3AAI';
    OPEN cuVato;
    FETCH cuVato INTO nuValor;
    CLOSE cuVato;
    
    UPDATE cuencobr SET cucovato = nuValor
    WHERE cucocodi = 2142214559;
    commit;
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/