CREATE OR REPLACE FUNCTION adm_person.ldc_retornacuponconcidecaje (
    inucajero IN NUMBER,
    idtfecha  IN DATE
) RETURN NUMBER IS
 /**************************************************************
  Propiedad intelectual PETI.

  procedimiento  :  ldc_retornacuponconcidecaje

  Descripción  : Muestra los cupones de las conciliaciones por cajero en una fecha

  Autor  : John Jairo Jimenez Marimon
  Fecha  : 25-10-2013

  Historia de Modificaciones
  
  FECHA           AUTOR               DESCRIPCION
  06/03/2024      Paola Acosta        OSF-2104: Se agregan permisos para REXEREPORTES por solicitud de CGonzalez
  28/02/2024      Paola Acosta        OSF-2104: Migracion del esquema OPEN al esquema ADM_PERSON
  **************************************************************/
  
    dtfein DATE;
    dtfefi DATE;
    CURSOR cuconci (
        nuccaj   NUMBER,
        fechain  DATE,
        fechafin DATE
    ) IS
    SELECT
        h.dedosopo conccons
    FROM
        ca_document f,
        ca_detadocu h
    WHERE
            f.docutran = 1
        AND f.docucaje = nuccaj
        AND f.docufech BETWEEN fechain AND fechafin
        AND f.docucodi = h.dedodocu;

    nusuma NUMBER(13, 2) DEFAULT 0;
    nucup  concilia.concprre%TYPE;
BEGIN
    dtfein := to_date(to_char(trunc(idtfecha), 'DD/MM/YYYY')
                      || ' 00:00:00', 'DD/MM/YYYY HH24:MI:SS');

    dtfefi := to_date(to_char(trunc(idtfecha), 'DD/MM/YYYY')
                      || ' 23:59:59', 'DD/MM/YYYY HH24:MI:SS');

    nusuma := 0;
    FOR i IN cuconci(inucajero, dtfein, dtfefi) LOOP
        BEGIN
            SELECT
                c.concprre
            INTO nucup
            FROM
                concilia c
            WHERE
                c.conccons = to_number(i.conccons);

        EXCEPTION
            WHEN no_data_found THEN
                nucup := 0;
        END;
    END LOOP;

    nusuma := nusuma + nvl(nucup, 0);
    RETURN nusuma;
EXCEPTION
    WHEN OTHERS THEN
        nusuma := 0;
        RETURN nusuma;
END ldc_retornacuponconcidecaje;
/

BEGIN
    pkg_utilidades.praplicarpermisos('LDC_RETORNACUPONCONCIDECAJE', 'ADM_PERSON');
END;
/
GRANT EXECUTE ON ADM_PERSON.LDC_RETORNACUPONCONCIDECAJE TO REXEREPORTES;
/