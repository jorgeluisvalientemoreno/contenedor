CREATE OR REPLACE FUNCTION adm_person.nutraeutllectfact (
    inuproducto IN NUMBER
) RETURN NUMBER IS
    /*****************************************************************
  PROPIEDAD INTELECTUAL DE GASES DEL CARIBE E.S.P.

  UNIDAD         : nutraeutllectfact
  DESCRIPCION    : Funcion usada para obtener la lectura facturada para el reporte de
                   ordenes de cartera ORM.
  AUTOR          : Caren Berdejo (Ludycom)
  CASO           : 100-27933
  FECHA          : 10/01/2017

  PARAMETROS            DESCRIPCION
  ============      ===================
  isbEntrega        Nombre de la entrega

  FECHA             AUTOR                   MODIFICACION
  ==========        =========               ====================
  06/03/2024        Paola Acosta            OSF-2104: Se agregan permisos para REXEREPORTES por solicitud de CGonzalez
  28/02/2024        Paola Acosta            OSF-2104: Migracion del esquema OPEN al esquema ADM_PERSON   
  10/01/2017        Caren Berdjo(LUDYCOM)   CreaciOn.
  ******************************************************************/
  
    nulectura NUMBER;
BEGIN
    nulectura := 0;
    SELECT
        leemleto
    INTO nulectura
    FROM
        (
            SELECT
                leemleto
            FROM
                lectelme l
            WHERE
                    leemsesu = inuproducto
                AND l.leemclec = 'F'
            ORDER BY
                leemfele DESC
        )
    WHERE
        ROWNUM <= 1;

    RETURN nulectura;
EXCEPTION
    WHEN no_data_found THEN
        RETURN 0;
    WHEN OTHERS THEN
        RETURN 0;
END nutraeutllectfact;
/

BEGIN
    pkg_utilidades.praplicarpermisos('NUTRAEUTLLECTFACT', 'ADM_PERSON');
END;
/
GRANT EXECUTE ON ADM_PERSON.NUTRAEUTLLECTFACT TO REXEREPORTES;
/
