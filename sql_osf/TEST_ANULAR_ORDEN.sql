DECLARE

  CURSOR cuDatos IS
    SELECT o.*
      FROM or_order o
     WHERE o.order_id = o.order_id
       and trunc(o.created_date) >= trunc(sysdate)
       and o.task_type_id in (10553)
       and o.order_status_id = 8;

  sbOrderCommen VARCHAR2(4000) := 'Se cambia estado a anulado para pruebas';
  nuCommentType NUMBER := 1277;
  nuErrorCode   NUMBER;
  sbErrorMesse  VARCHAR2(4000);
  nuacta        NUMBER;

BEGIN

  FOR reg IN cudatos LOOP
  
    BEGIN
      dbms_output.put_line('Orden: ' || reg.order_id);
    
      api_anullorder(reg.order_id,
                     nuCommentType,
                     sbOrderCommen,
                     nuErrorCode,
                     sbErrorMesse);
    
      IF (nuErrorCode = 0) THEN
        COMMIT;
        dbms_output.put_line('Se anulo OK orden: ' || reg.order_id);
      ELSE
        ROLLBACK;
        dbms_output.put_line('Error anulando orden: ' || reg.order_id ||
                             ' : ' || sbErrorMesse);
      END IF;
    
    EXCEPTION
      WHEN OTHERS THEN
        dbms_output.put_line('Error OTHERS anulando orden: ' ||
                             reg.order_id || ' : ' || sqlerrm);
        ROLLBACK;
    END;
  END LOOP;
END;
/
