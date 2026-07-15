DECLARE
    CURSOR c_orders IS
        SELECT DISTINCT r.order_id
        FROM or_order r
        LEFT JOIN or_order_activity a ON a.order_id = r.order_id
        LEFT JOIN servsusc s ON a.product_id = s.sesunuse
        WHERE s.sesucicl IN (6001)
          AND r.task_type_id IN (12617, 10043)
          AND r.order_status_id IN (0);

    v_count NUMBER := 0;
BEGIN
    FOR rec IN c_orders LOOP
        UPDATE or_order
        SET operating_sector_id = 9266
        WHERE order_id = rec.order_id;

        v_count := v_count + 1;
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('Total órdenes actualizadas: ' || v_count);
END;
