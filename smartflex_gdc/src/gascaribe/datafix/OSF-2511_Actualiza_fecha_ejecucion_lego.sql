DECLARE

    CURSOR cuOrdenes
    IS
    SELECT a.order_id, b.exec_initial_date, b.execution_final_date
    FROM ldc_otlegalizar a, or_order b 
    WHERE b.order_id = a.order_id  
    AND a.exec_initial_date IS NULL;

BEGIN
    
    FOR rcOrdenes IN cuOrdenes LOOP
    
        UPDATE ldc_otlegalizar
        SET  exec_initial_date = rcOrdenes.exec_initial_date,
        exec_final_date   = rcOrdenes.execution_final_date
        WHERE order_id = rcOrdenes.order_id;

        COMMIT;

    END LOOP;
END;
/