column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE
    CURSOR cuCuentas IS
    SELECT *
    FROM  cuencobr
    WHERE cucosacu <0
    AND   cucocodi in (3020530664,3020530665) ;
BEGIN
    pkerrors.setapplication('FTDU');
    
    
  FOR rc in cuCuentas LOOP
      dbms_output.put_Line('Inicia Balance de cuenta :'||rc.cucocodi);

      pkAccountMgr.GenPositiveBal( rc.cucocodi, null );

      dbms_output.put_Line('Finaliza Balance de cuenta :'||rc.cucocodi);

  END LOOP;
  commit;
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/