DECLARE
    sbcadenalegalizacionot VARCHAR2(4000);
    nuerror NUMBER;
    sberror VARCHAR2(4000);
    dtfecha_exe_ini DATE;
    dtult_fecha_lect DATE;
BEGIN
    dtfecha_exe_ini := '14-01-2026 08:27:01';
    dtult_fecha_lect :='14-01-2026 10:32:01';

    sbcadenalegalizacionot :=
    '391451568|9688|48106||384887602>1;COMMENT1>79>>;;;|||1277;PRUEBA MASIVA GDGU';

    api_legalizeOrders(
        sbcadenalegalizacionot,
        dtfecha_exe_ini,
        dtult_fecha_lect,
        NULL,
        nuerror,
        sberror
    );

    IF nuerror = 0 THEN
        dbms_output.put_line('OK');
    ELSE
        dbms_output.put_line('ERROR: ' || sberror);
    END IF;
END;
