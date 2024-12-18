CREATE OR REPLACE FUNCTION adm_person.ldc_retornaconcidecaje (
    inucajero IN NUMBER,
    idtfecha  IN DATE
) RETURN VARCHAR2 IS
/**************************************************************
  Propiedad intelectual PETI.

  procedimiento  :  ldc_retornaconcidecaje

  Descripción  : Muestra las conciliaciones por cajero en una fecha

  Autor  : John Jairo Jimenez Marimon
  Fecha  : 26-09-2013

  Historia de Modificaciones
  
  FECHA           AUTOR               DESCRIPCION
  06/03/2024      Paola Acosta        OSF-2104: Se agregan permisos para REXEREPORTES por solicitud de CGonzalez
  27/02/2024      Paola Acosta        OSF-2104: Migracion del esquema OPEN al esquema ADM_PERSON  
  **************************************************************/
  
    dtfein   DATE;
    dtfefi   DATE;
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

    sbobserv VARCHAR2(1000) DEFAULT NULL;
BEGIN
    dtfein := to_date(to_char(trunc(idtfecha), 'DD/MM/YYYY')
                      || ' 00:00:00', 'DD/MM/YYYY HH24:MI:SS');

    dtfefi := to_date(to_char(trunc(idtfecha), 'DD/MM/YYYY')
                      || ' 23:59:59', 'DD/MM/YYYY HH24:MI:SS');

    FOR i IN cuconci(inucajero, dtfein, dtfefi) LOOP
        IF sbobserv IS NULL THEN
            sbobserv := to_char(i.conccons);
        ELSE
            sbobserv := trim(sbobserv)
                        || ','
                        || to_char(i.conccons);
        END IF;
    END LOOP;

    RETURN trim(sbobserv);
EXCEPTION
    WHEN OTHERS THEN
        sbobserv := NULL;
        RETURN sbobserv;
END ldc_retornaconcidecaje;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_RETORNACONCIDECAJE', 'ADM_PERSON');
END;
/
GRANT EXECUTE ON ADM_PERSON.LDC_RETORNACONCIDECAJE TO REXEREPORTES;
/