CREATE OR REPLACE TRIGGER ADM_PERSON.TRGBIULDCRANGOCOMISION
    AFTER INSERT OR UPDATE of RANGO_INI,RANGO_FIN
ON open.LDCRANGOCOMISION
    REFERENCING OLD AS OLD NEW AS NEW
    FOR EACH ROW

DECLARE
    PRAGMA AUTONOMOUS_TRANSACTION;
    CURSOR curang IS
        SELECT ZONA,
               RANGO_INI,
               RANGO_FIN,
               VALOR_COMISION,
               VALOR_COMICUMP,
               FLAGPOREFE
        FROM open.LDCRANGOCOMISION
        WHERE ZONA = :new.ZONA
        /*AND RANGO_INI=:new.RANGO_INI*/
        ;

    rgrangos open.LDCRANGOCOMISION%ROWTYPE;
BEGIN

    OPEN curang;
    LOOP
        FETCH curang
            INTO rgrangos;
        EXIT WHEN curang%NOTFOUND;

        IF updating THEN

            IF ((:new.RANGO_INI > rgrangos.RANGO_INI AND :new.RANGO_INI<
               rgrangos.RANGO_FIN) OR
               (:new.RANGO_FIN > rgrangos.RANGO_INI AND :new.RANGO_FIN<
               rgrangos.RANGO_FIN)) THEN

                errors.seterror(2741, 'Solapamiento de rangos');
                RAISE ex.controlled_error;
            END IF;
        ELSE

            IF (:new.RANGO_INI BETWEEN rgrangos.RANGO_INI AND
               rgrangos.RANGO_FIN)
               OR (:new.RANGO_FIN BETWEEN rgrangos.RANGO_INI AND
               rgrangos.RANGO_FIN) THEN

                errors.seterror(2741, 'Solapamiento de rangos');
                RAISE ex.controlled_error;
            END IF;

        END IF;
    END LOOP;
    CLOSE curang;

END;
/
