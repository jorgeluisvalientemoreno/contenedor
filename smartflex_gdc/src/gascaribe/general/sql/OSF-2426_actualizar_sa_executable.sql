DECLARE
    sbdescripcion VARCHAR2(2000);
BEGIN
    SELECT
        description
    INTO sbdescripcion
    FROM
        sa_executable
    WHERE
        name = 'LDCRVEEM';

    IF sbdescripcion LIKE '%NO USAR%' THEN
        NULL;
    ELSE
        UPDATE sa_executable
        SET
            description = 'NO USAR - ' || description
        WHERE
            name = 'LDCRVEEM';

        COMMIT;
    END IF;

END;
/