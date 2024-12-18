column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE
  -- Poblacion 1 DataFix
	CURSOR cuSolicitudes IS
		SELECT * FROM MO_PACKAGES where PACKAGE_ID IN (198905213, 198905155,198905318);		
 
BEGIN
  dbms_output.put_line('-------------------  Inicio OSF-1095 ------------------- ');

  FOR rcSolicitudes IN cuSolicitudes
  LOOP
      
      BEGIN
          CF_BOACTIONS.ATTENDREQUEST(rcSolicitudes.package_id);

          COMMIT ;

          DBMS_OUTPUT.PUT_LINE('-> OK PACKAGE_ID ['||rcSolicitudes.package_id ||']');
      EXCEPTION
          WHEN OTHERS THEN
            rollback;
            DBMS_OUTPUT.PUT_LINE('FALLO OK PACKAGE_ID ['||rcSolicitudes.package_id ||']');
            DBMS_OUTPUT.PUT_LINE('Fallo: --> '||sqlerrm);
      END;

  END LOOP;
  

  COMMIT;
  dbms_output.put_line('------------------- Fin OSF-1095 ------------------- ');
EXCEPTION
  WHEN OTHERS THEN
    rollback;
    dbms_output.put_line('---- Error OSF-1095 ----');
    DBMS_OUTPUT.PUT_LINE('OSF-1095-Error General: --> '||sqlerrm);
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/