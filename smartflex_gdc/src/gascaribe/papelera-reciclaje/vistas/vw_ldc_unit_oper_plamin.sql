/**********************************
Caso: OSF-4191
Descripcion: Borrado vista
Fecha: 07/04/2025
***********************************/
DECLARE
    csbobjeto      CONSTANT VARCHAR2(70) := 'VW_LDC_UNIT_OPER_PLAMIN';
    csbesquema     CONSTANT VARCHAR2(30) := 'OPEN';
    csbtipoobjeto  CONSTANT VARCHAR2(30) := 'VIEW';
    nuerror        NUMBER;
    sberror        VARCHAR2(4000);
    
    CURSOR cudba_synonyms IS
    SELECT
        *
    FROM
        dba_synonyms
    WHERE
            owner <> upper(csbesquema)
        AND table_owner = upper(csbesquema)
        AND table_name = upper(csbobjeto);

    TYPE tydba_synonyms IS
        TABLE OF cudba_synonyms%rowtype INDEX BY BINARY_INTEGER;
    tbdba_synonyms tydba_synonyms;
    
    CURSOR cudba_objects IS
    SELECT
        *
    FROM
        dba_objects
    WHERE
            owner = upper(csbesquema)
        AND object_name = upper(csbobjeto)
        AND object_type = upper(csbtipoobjeto);

    TYPE tydba_objects IS
        TABLE OF cudba_objects%rowtype INDEX BY BINARY_INTEGER;
    tbdba_objects  tydba_objects;

    PROCEDURE prcexeimm (
        isbsent VARCHAR2
    ) IS
    BEGIN
        EXECUTE IMMEDIATE isbsent;
        dbms_output.put_line('Ok Sentencia['
                             || isbsent
                             || ']');
    EXCEPTION
        WHEN OTHERS THEN
            dbms_output.put_line('Error Sentencia['
                                 || isbsent
                                 || ']['
                                 || sqlerrm
                                 || ']');
    END prcexeimm;

BEGIN
    OPEN cudba_synonyms;
    FETCH cudba_synonyms
    BULK COLLECT INTO tbdba_synonyms;
    CLOSE cudba_synonyms;
    IF tbdba_synonyms.count > 0 THEN
        FOR indtb IN 1..tbdba_synonyms.count LOOP
            prcexeimm('DROP SYNONYM '
                      || tbdba_synonyms(indtb).owner
                      || '.'
                      || tbdba_synonyms(indtb).synonym_name);
        END LOOP;
    ELSE
        dbms_output.put_line('No hay sinonimos para ['
                             || csbesquema
                             || '.'
                             || csbobjeto
                             || ']');
    END IF;

    OPEN cudba_objects;
    FETCH cudba_objects
    BULK COLLECT INTO tbdba_objects;
    CLOSE cudba_objects;
    IF tbdba_objects.count > 0 THEN
        FOR indtb IN 1..tbdba_objects.count LOOP
            prcexeimm('DROP '
                      || tbdba_objects(indtb).object_type
                      || ' '
                      || tbdba_objects(indtb).owner
                      || '.'
                      || tbdba_objects(indtb).object_name);
        END LOOP;
    ELSE
        dbms_output.put_line('No existe ['
                             || csbesquema
                             || '.'
                             || csbobjeto
                             || ']');
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        pkg_error.seterror;
        pkg_error.geterror(nuerror, sberror);
        dbms_output.put_line('sbError => ' || sberror);
        RAISE pkg_error.controlled_error;
END;
/