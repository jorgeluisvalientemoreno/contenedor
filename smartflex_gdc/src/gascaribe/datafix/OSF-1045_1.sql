column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare
  cnuCommentType     CONSTANT NUMBER := 83;
  isbOrderComme      varchar2(4000) := 'Se cambia estado a anulado por caso OSF-1045';
  nuCommentType      number := 1277;
  nuErrorCode        number;
  sbErrorMesse       varchar2(4000);

  CURSOR cuPoblacion IS
  WITH BASE AS(
  select o.ORDER_ID,
        o.OPERATING_UNIT_ID,
        a.ORDER_ACTIVITY_ID,
        o.order_status_id,
        o.TASK_TYPE_ID,
        o.EXEC_INITIAL_DATE,
        o.EXECUTION_FINAL_DATE,
        o.ASSIGNED_DATE,
        a.PRODUCT_ID,
        o.CAUSAL_ID
      FROM OPEN.OR_ORDER o
    INNER JOIN OPEN.OR_ORDER_ACTIVITY a ON o.ORDER_ID = a.ORDER_ID
    WHERE o.ORDER_STATUS_ID = 7
      and a.TASK_TYPE_ID in (10444, 10795, 12162, 11198, 11200, 11165)
  ), tbl_ordenes as (
  SELECT B.*,
        OTINT.MESSAGECODE,
        OTINT.MESSAGETEXT
  FROM BASE B
  LEFT JOIN OPEN.LDCI_ORDENESALEGALIZAR OTINT ON OTINT.ORDER_ID=B.ORDER_ID
  )
  -- poblacion
  select  oo.order_id
  from    open.or_order oo
          join open.or_order_activity oa on oo.order_id = oa.order_id
          join open.mo_packages mp on oa.package_id = mp.package_id
          join tbl_ordenes on oo.order_id = tbl_ordenes.order_id
  where   oo.task_type_id IN (10444, 10795, 12162, 11198, 11200, 11165 )
  and     oo.order_status_id = 7
  and     oa.STATUS <> 'F'
  and     mp.MOTIVE_STATUS_ID = 32
  and     oo.order_id = 274271240;

begin
  dbms_output.put_line('---- Inicio OSF-1045 ----');

  FOR reg IN cuPoblacion
  LOOP
      BEGIN
          dbms_output.put_line('orden: '||reg.order_id);

          or_boanullorder.anullorderwithoutval(reg.order_id, SYSDATE);

          OS_ADDORDERCOMMENT(reg.order_id,
                            nuCommentType,
                            isbOrderComme,
                            nuErrorCode,
                            sbErrorMesse);

          dbms_output.put_line('nuErrorCode: '||nuErrorCode );
          dbms_output.put_line('sbErrorMesse: '||sbErrorMesse );

          if nuErrorCode = 0 then
            commit;
            dbms_output.put_line('Se anulo OK orden: ' || reg.order_id);
          else
            rollback;
            dbms_output.put_line('Error anulando orden: ' || reg.order_id ||
                                ' : ' || sbErrorMesse);
          end IF;
      EXCEPTION
        WHEN OTHERS THEN
          rollback;
          DBMS_OUTPUT.PUT_LINE('Error al anular la orden --> '||sqlerrm);
      END;
  END LOOP;
  COMMIT;

  dbms_output.put_line('---- Fin OSF-1045 ----');
EXCEPTION
  WHEN OTHERS THEN
    rollback;
    dbms_output.put_line('---- Error OSF-1045 ----');
    DBMS_OUTPUT.PUT_LINE('Error no controlado --> '||sqlerrm);
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/