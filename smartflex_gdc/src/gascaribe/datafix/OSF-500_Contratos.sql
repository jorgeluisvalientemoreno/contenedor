DECLARE
    nuerrorcode      NUMBER;
    sberrormessage   VARCHAR2(4000);
    CURSOR cucontratos IS
    SELECT DISTINCT
        susccodi
    FROM
        suscripc,
        servsusc
    WHERE
        susctisu = 42
        AND sesuesco = 99
        AND sesususc = susccodi;

BEGIN                         
    dbms_output.put_line('Inicio DTF OSF-500');
    FOR rccontrato IN cucontratos LOOP
        UPDATE suscripc
        SET
            susctisu = - 1
        WHERE
            susccodi = rccontrato.susccodi;

        COMMIT;
        dbms_output.put_line('Contrato: ' || rccontrato.susccodi);
    END LOOP;

    dbms_output.put_line('FIN DTF OSF-500');
    dbms_output.put_line('SALIDA onuCode: ' || nuerrorcode);
    dbms_output.put_line('SALIDA osbMess: ' || sberrormessage);
EXCEPTION
    WHEN ex.controlled_error THEN
        errors.geterror(nuerrorcode, sberrormessage);
        dbms_output.put_line('ERROR CONTROLLED ');
        dbms_output.put_line('error onuErrorCode: ' || nuerrorcode);
        dbms_output.put_line('error osbErrorMess: ' || sberrormessage);
    WHEN OTHERS THEN
        errors.seterror;
        errors.geterror(nuerrorcode, sberrormessage);
        dbms_output.put_line('ERROR OTHERS ');
        dbms_output.put_line('error onuErrorCode: ' || nuerrorcode);
        dbms_output.put_line('error osbErrorMess: ' || sberrormessage);
END;
/