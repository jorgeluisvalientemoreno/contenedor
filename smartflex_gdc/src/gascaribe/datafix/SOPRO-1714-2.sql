BEGIN

    UPDATE "OPEN".LDC_OTLEGALIZAR SET
        EXEC_INITIAL_DATE = TO_DATE('2022-07-18 08:10:31', 'YYYY-MM-DD HH24:MI:SS'),
        EXEC_FINAL_DATE = TO_DATE('2022-07-18 08:20:31', 'YYYY-MM-DD HH24:MI:SS')
        WHERE ORDER_ID = 252938472;
    UPDATE "OPEN".OR_ORDER SET
        EXEC_INITIAL_DATE=TIMESTAMP '2022-07-18 08:10:31.000000',
        EXECUTION_FINAL_DATE=TIMESTAMP '2022-07-18 08:20:31.000000'
        WHERE ORDER_ID=252938472;


    UPDATE "OPEN".LDC_OTLEGALIZAR SET
        EXEC_INITIAL_DATE = TO_DATE('2021-06-22 16:58:47', 'YYYY-MM-DD HH24:MI:SS'),
        EXEC_FINAL_DATE = TO_DATE('2021-06-22 17:00:47', 'YYYY-MM-DD HH24:MI:SS')
        WHERE ORDER_ID = 213657360;
    UPDATE "OPEN".OR_ORDER SET
        EXEC_INITIAL_DATE=TIMESTAMP '2021-06-22 16:58:47.000000',
        EXECUTION_FINAL_DATE=TIMESTAMP '2021-06-22 17:00:47.000000'
        WHERE ORDER_ID=213657360;


    UPDATE "OPEN".LDC_OTLEGALIZAR SET
        EXEC_INITIAL_DATE = TO_DATE('2022-07-13 16:59:58', 'YYYY-MM-DD HH24:MI:SS'),
        EXEC_FINAL_DATE = TO_DATE('2022-07-13 17:10:58', 'YYYY-MM-DD HH24:MI:SS')
        WHERE ORDER_ID = 252614478;
    UPDATE "OPEN".OR_ORDER SET
        EXEC_INITIAL_DATE=TIMESTAMP '2022-07-13 16:59:58.000000',
        EXECUTION_FINAL_DATE=TIMESTAMP '2022-07-13 17:10:58.000000'
        WHERE ORDER_ID=252614478;


    UPDATE "OPEN".LDC_OTLEGALIZAR SET
        EXEC_INITIAL_DATE = TO_DATE('2022-08-12 17:25:39', 'YYYY-MM-DD HH24:MI:SS'),
        EXEC_FINAL_DATE = TO_DATE('2022-08-12 17:35:39', 'YYYY-MM-DD HH24:MI:SS')
        WHERE ORDER_ID = 255846759;
    UPDATE "OPEN".OR_ORDER SET
        EXEC_INITIAL_DATE=TIMESTAMP '2022-08-12 17:25:39.000000',
        EXECUTION_FINAL_DATE=TIMESTAMP '2022-08-12 17:35:39.000000'
        WHERE ORDER_ID=255846759;

    COMMIT;
END;
/
