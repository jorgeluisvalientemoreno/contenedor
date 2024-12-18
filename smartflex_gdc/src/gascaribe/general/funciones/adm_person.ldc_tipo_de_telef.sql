CREATE OR REPLACE FUNCTION adm_person.ldc_tipo_de_telef (
    inunumbertel IN VARCHAR2
) RETURN NUMBER IS

/**************************************************************
  Propiedad intelectual PETI.
  Trigger  :  LDC_TIPO_DE_TELEF
  Descripci¿n  :
  Autor  : Alvaro E. Zapata
  Fecha  : 29-01-2014

  Historia de Modificaciones
  FECHA             AUTOR                   MODIFICACION
  ==========        =========               ====================
  28/02/2024        Paola Acosta            OSF-2104: Migracion del esquema OPEN al esquema ADM_PERSON 
  06/03/2024        Paola Acosta            OSF-2104: Se agregan permisos para REXEREPORTES por solicitud de CGonzalez
  **************************************************************/

    CURSOR cutypenum IS
    SELECT
        sp.phone_type_id
    FROM
        ge_subs_phone sp
    WHERE
            sp.phone = inunumbertel
        AND ROWNUM = 1;

    nutype NUMBER;
BEGIN
    OPEN cutypenum;
    FETCH cutypenum INTO nutype;
    IF cutypenum%notfound THEN
        nutype := NULL;
    END IF;
    CLOSE cutypenum;
    RETURN nutype;
EXCEPTION
    WHEN no_data_found THEN
           ---no existen datos
        RETURN '-1';
    WHEN OTHERS THEN
           ---se esta generando un error al ejecutar la funcion
        RETURN '-2';
END ldc_tipo_de_telef;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_TIPO_DE_TELEF', 'ADM_PERSON');
END;
/
GRANT EXECUTE ON ADM_PERSON.LDC_TIPO_DE_TELEF TO REXEREPORTES;
/