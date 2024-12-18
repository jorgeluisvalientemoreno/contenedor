CREATE OR REPLACE FUNCTION adm_person.ldc_retornadiferosiniestro (
    inusolicitud IN NUMBER
) RETURN VARCHAR2 IS
  /**************************************************************************
  Autor       : John Jairo Jimenez Marimon
  Fecha       : 2014-11-14
  Descripcion : Retorna diferidos concatenados de solicitudes de siniestro.
  Parametros Entrada
    nuano Año
    numes Mes

  HISTORIA DE MODIFICACIONES
  
  FECHA           AUTOR               DESCRIPCION
  06/03/2024      Paola Acosta        OSF-2104: Se retiran referencias .open y se crean sinonimos adm_person para objetos
  06/03/2024      Paola Acosta        OSF-2104: Se agregan permisos para REXEREPORTES por solicitud de CGonzalez
  28/02/2024      Paola Acosta        OSF-2104: Migracion del esquema OPEN al esquema ADM_PERSON
  ***************************************************************************/

    sbdiferido VARCHAR2(5000);
BEGIN
    sbdiferido := NULL;
    FOR i IN (
        SELECT
            u.financing_code_id cod_dife
        FROM
            ld_detail_liquidation u
        WHERE
            u.package_id = inusolicitud
        ORDER BY
            u.financing_code_id
    ) LOOP
        IF sbdiferido IS NULL THEN
            sbdiferido := to_char(i.cod_dife);
        ELSE
            sbdiferido := sbdiferido
                          || ','
                          || to_char(i.cod_dife);
        END IF;
    END LOOP;

    RETURN sbdiferido;
EXCEPTION
    WHEN OTHERS THEN
        RETURN NULL;
END ldc_retornadiferosiniestro;
/

BEGIN
    pkg_utilidades.praplicarpermisos('LDC_RETORNADIFEROSINIESTRO', 'ADM_PERSON');
END;
/
GRANT EXECUTE ON adm_person.ldc_retornadiferosiniestro TO REXEREPORTES;
/