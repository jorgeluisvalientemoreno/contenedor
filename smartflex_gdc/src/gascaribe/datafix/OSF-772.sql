column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare
  -- Poblacion a la que aplica el Datafix
  CURSOR cuPoblacion IS
  SELECT  OA.*
  FROM    OPEN.OR_ORDER_ACTIVITY OA
  WHERE   OA.ORDER_ID IN (
                              --------------- CONTRATO: 67344637  ----------------
                              266261588, --causal: 9944 - INSTALACION CERTIFICADA
                              266020349, --casual: 3672 - DOCUMENTACION NO CUMPLE
                              265591494, --causal: 3673 - IMPOSIBILIDAD DE EJECUCION
                              265039849, --causal: 3673 - IMPOSIBILIDAD DE EJECUCION
                              264622236, --causal: 3675 - PREDIO CUENTA CON ACOMETIDA
                              --------------- CONTRATO: 67294453  ----------------
                              257196474, --  9944 - INSTALACION CERTIFICADA
                              257789914, --  9944 - INSTALACION CERTIFICADA
                              258320777, --  9944 - INSTALACION CERTIFICADA
                              256689781, --  9944 - INSTALACION CERTIFICADA
                              256689780, --  9944 - INSTALACION CERTIFICADA
                              --------------- CONTRATO: 67294686  ----------------
                              262240893, --  9944 - INSTALACION CERTIFICADA
                              264311065, --  9944 - INSTALACION CERTIFICADA
                              264343330, --  9944 - INSTALACION CERTIFICADA
                              256689783, --  9944 - INSTALACION CERTIFICADA
                              258321898, --  9944 - INSTALACION CERTIFICADA
                              256689782  --  9944 - INSTALACION CERTIFICADA
  );

begin
  dbms_output.put_line('---- Inicio OSF-772 ----');

  FOR reg in cuPoblacion
  LOOP
    UPDATE  OPEN.OR_ORDER_ACTIVITY
    SET     OR_ORDER_ACTIVITY.PACKAGE_ID = NULL,
            OR_ORDER_ACTIVITY.MOTIVE_ID = NULL
    WHERE   ORDER_ID = reg.ORDER_ID;
    dbms_output.put_line('Se actualiza la orden ['||reg.ORDER_ID||'] PACKAGE_ID actual ['||reg.PACKAGE_ID||'] - MOTIVE_ID Actual [' ||reg.MOTIVE_ID||']');
  END LOOP;

  COMMIT;

  dbms_output.put_line('---- Fin OSF-772 ----');
EXCEPTION
  WHEN OTHERS THEN
    rollback;
    dbms_output.put_line('---- Error OSF-772 ----');
    DBMS_OUTPUT.PUT_LINE('Error no controlado --> '||sqlerrm);
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/