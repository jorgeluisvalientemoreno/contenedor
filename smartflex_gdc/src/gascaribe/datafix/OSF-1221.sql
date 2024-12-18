column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare

  -- Poblacion DataFix
  cursor cuPoblacionOs is
      SELECT 284153874 AS ORDEN, 1999613 AS PRODUCTO, 1999613 AS CONTRATO, 1392348 AS CLIENTE FROM DUAL;

begin
  dbms_output.put_line('---- Inicio OSF-1221 ----');

  FOR regPoblacion IN cuPoblacionOs
  LOOP
    BEGIN
      UPDATE  OPEN.OR_ORDER_ACTIVITY oa
      SET     oa.PRODUCT_ID = regPoblacion.producto,
              oa.SUBSCRIPTION_ID = regPoblacion.contrato,
              oa.SUBSCRIBER_ID = regPoblacion.cliente
      WHERE   oa.ORDER_ID = regPoblacion.orden;
      COMMIT;
      DBMS_OUTPUT.PUT_LINE('OK (OR_ORDER_ACTIVITY) Orden ['||regPoblacion.orden||'] - PRODUCT_ID ['||regPoblacion.producto||'] - SUBSCRIPTION_ID ['||regPoblacion.contrato||'] - SUBSCRIBER_ID ['||regPoblacion.cliente||']');
    EXCEPTION
      WHEN OTHERS THEN
        rollback;
        DBMS_OUTPUT.PUT_LINE('Fallo (OR_ORDER_ACTIVITY) Orden ['||regPoblacion.orden||'] - PRODUCT_ID ['||regPoblacion.producto||'] - SUBSCRIPTION_ID ['||regPoblacion.contrato||'] - SUBSCRIBER_ID ['||regPoblacion.cliente||']');
    END;

    BEGIN
      UPDATE  OPEN.OR_EXTERN_SYSTEMS_ID
      SET     SERVICE_NUMBER = regPoblacion.producto,
              PRODUCT_ID = regPoblacion.producto,
              SUBSCRIPTION_ID = regPoblacion.contrato,
              SUBSCRIBER_ID = regPoblacion.cliente
      WHERE   ORDER_ID = regPoblacion.orden;
      COMMIT;
      DBMS_OUTPUT.PUT_LINE('OK (OR_EXTERN_SYSTEMS_ID) - Orden ['||regPoblacion.orden||'] - PRODUCT_ID ['||regPoblacion.producto||'] - SUBSCRIPTION_ID ['||regPoblacion.contrato||'] - SUBSCRIBER_ID ['||regPoblacion.cliente||']');
    EXCEPTION
      WHEN OTHERS THEN
        rollback;
        DBMS_OUTPUT.PUT_LINE('Fallo (OR_EXTERN_SYSTEMS_ID) Orden ['||regPoblacion.orden||'] - PRODUCT_ID ['||regPoblacion.producto||'] - SUBSCRIPTION_ID ['||regPoblacion.contrato||'] - SUBSCRIBER_ID ['||regPoblacion.cliente||']');
    END;
  END LOOP;
  
  COMMIT;

  dbms_output.put_line('---- Fin OSF-1221 ----');
EXCEPTION
  WHEN OTHERS THEN
    rollback;
    dbms_output.put_line('---- Error OSF-1221 ----');
    DBMS_OUTPUT.PUT_LINE('OSF-1221-Error General: --> '||sqlerrm);
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/