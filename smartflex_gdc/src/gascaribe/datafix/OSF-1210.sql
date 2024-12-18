column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare

  nuNewcausal_id	  or_order.causal_id%type := 9512;
  nuOrder_id        or_order.order_id%type := 283674182;
  blCambioOrder     boolean := false;

begin
  dbms_output.put_line('---- Inicio OSF-1210 ----');

  BEGIN
    UPDATE OPEN.OR_ORDER
    SET    CAUSAL_ID = nuNewcausal_id
    WHERE  ORDER_ID = nuOrder_id;

    blCambioOrder := true;
    COMMIT;
    dbms_output.put_line('- Cambio de causal OK OR_ORDER.CAUSAL_ID = 9512 -');
  EXCEPTION
    WHEN OTHERS THEN
      rollback;
      blCambioOrder := false;
      DBMS_OUTPUT.PUT_LINE('Error OR_ORDER.CAUSAL_ID = 9512 -> '||sqlerrm);
  END;
  
  IF (blCambioOrder) THEN
      BEGIN
        UPDATE OPEN.OR_ORDER_STAT_CHANGE
        SET CAUSAL_ID = nuNewcausal_id
        WHERE ORDER_ID = nuOrder_id
        AND ORDER_STAT_CHANGE_ID = 818839885;
        COMMIT;
        dbms_output.put_line('- Cambio de causal OK OR_ORDER_STAT_CHANGE.CAUSAL_ID = 9512 -');
      EXCEPTION
        WHEN OTHERS THEN
          rollback;
          DBMS_OUTPUT.PUT_LINE('Error OR_ORDER_STAT_CHANGE.CAUSAL_ID = 9512 -> '||sqlerrm);
      END;
  END IF;

  dbms_output.put_line('---- Fin OSF-1210 ----');
EXCEPTION
  WHEN OTHERS THEN
    rollback;
    dbms_output.put_line('---- Error OSF-1210 ----');
    DBMS_OUTPUT.PUT_LINE('Error no controlado --> '||sqlerrm);
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/