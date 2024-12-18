column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE
  -- Poblacion 1 DataFix
	CURSOR cuPoblacionEstadoUno IS
	SELECT * FROM GE_ITEMS_SERIADO where OPERATING_UNIT_ID=1 and ID_ITEMS_ESTADO_INV = 1;
	
  -- Poblacion 2 DataFix	
	CURSOR cuPoblacionEstadoCinco IS
	SELECT * FROM GE_ITEMS_SERIADO where OPERATING_UNIT_ID=1 and ID_ITEMS_ESTADO_INV = 5 AND SERIE IN ('I-13045610V','F-5617721-2011','F-5714621-2011');
		
 
BEGIN
  dbms_output.put_line('-------------------  Inicio OSF-1057 ------------------- ');

  FOR regPoblacionEstadoUno IN cuPoblacionEstadoUno
  LOOP
      
      BEGIN
          UPDATE  open.ge_items_seriado
          SET     OPERATING_UNIT_ID = null, ID_ITEMS_ESTADO_INV = 8
          WHERE   ID_ITEMS_SERIADO = regPoblacionEstadoUno.ID_ITEMS_SERIADO;

          COMMIT ;

          DBMS_OUTPUT.PUT_LINE('-> OK ID_ITEMS_SERIADO ['||regPoblacionEstadoUno.ID_ITEMS_SERIADO ||'] - OPERATING_UNIT_ID: NULL - ID_ITEMS_ESTADO_INV: 8');
      EXCEPTION
          WHEN OTHERS THEN
            rollback;
            DBMS_OUTPUT.PUT_LINE('FALLO ID_ITEMS_SERIADO ['||regPoblacionEstadoUno.ID_ITEMS_SERIADO ||'] - OPERATING_UNIT_ID: NULL - ID_ITEMS_ESTADO_INV: 8');
            DBMS_OUTPUT.PUT_LINE('fallo: --> '||sqlerrm);
      END;

  END LOOP;
  

  
  FOR regPoblacionEstadoCinco IN cuPoblacionEstadoCinco
  LOOP
      
      BEGIN
          UPDATE  open.ge_items_seriado
          SET     OPERATING_UNIT_ID = null
          WHERE   ID_ITEMS_SERIADO = regPoblacionEstadoCinco.ID_ITEMS_SERIADO;

          COMMIT;

          DBMS_OUTPUT.PUT_LINE('-> OK ID_ITEMS_SERIADO ['||regPoblacionEstadoCinco.ID_ITEMS_SERIADO ||'] - OPERATING_UNIT_ID: NULL');
      EXCEPTION
          WHEN OTHERS THEN
            rollback;
            DBMS_OUTPUT.PUT_LINE('FALLO ID_ITEMS_SERIADO ['||regPoblacionEstadoCinco.ID_ITEMS_SERIADO ||'] - OPERATING_UNIT_ID: NULL');
            DBMS_OUTPUT.PUT_LINE('fallo: --> '||sqlerrm);
      END;

  END LOOP;

  COMMIT;
  dbms_output.put_line('------------------- Fin OSF-1057 ------------------- ');
EXCEPTION
  WHEN OTHERS THEN
    rollback;
    dbms_output.put_line('---- Error OSF-1057 ----');
    DBMS_OUTPUT.PUT_LINE('OSF-1057-Error General: --> '||sqlerrm);
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/