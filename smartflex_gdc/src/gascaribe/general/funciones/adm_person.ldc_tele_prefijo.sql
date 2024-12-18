CREATE OR REPLACE FUNCTION adm_person.ldc_tele_prefijo (
    inunumber       IN NUMBER,
    inusubscriberid IN NUMBER,
    inuaddressid    IN NUMBER
) RETURN VARCHAR2 IS

/**************************************************************
  Propiedad intelectual PETI.
  Trigger  :  LDC_TELE_PREFIJO
  Descripci¿n  :
  Autor  : Alvaro E. Zapata
  Fecha  : 29-01-2014

  Historia de Modificaciones
  FECHA             AUTOR                   MODIFICACION
  ==========        =========               ====================
  07/03/2024        Paola Acosta            OSF-2104: Se crean sinonimos adm_person para objetos
  06/03/2024        Paola Acosta            OSF-2104: Se agregan permisos para REXEREPORTES por solicitud de CGonzalez
  28/02/2024        Paola Acosta            OSF-2104: Migracion del esquema OPEN al esquema ADM_PERSON 
  **************************************************************/

    nutype     NUMBER;
    nupref     VARCHAR2(4);
    nulocal    NUMBER;
    nutelefono VARCHAR2(30);
BEGIN
    SELECT
        daab_address.fnugetgeograp_location_id(inuaddressid)
    INTO nulocal
    FROM
        dual;

    --DBMS_OUTPUT.PUT_LINE('localidad: '||nuLocal);
    SELECT
        ldc_telefonos_subsc(inunumber, inusubscriberid)
    INTO nutelefono
    FROM
        dual;

    --DBMS_OUTPUT.PUT_LINE('telefono: '||nuTelefono);
    SELECT
        sp.phone_type_id,
        CASE nulocal
            WHEN 18 THEN
                    CASE sp.phone_type_id
                        WHEN 1 THEN
                            '03'
                        WHEN 2 THEN
                            '03'
                        WHEN 3 THEN
                            ''
                        WHEN 4 THEN
                            ''
                    END
            ELSE
                CASE sp.phone_type_id
                        WHEN 1 THEN
                            '03'
                        WHEN 2 THEN
                            '03'
                        WHEN 3 THEN
                            '092'
                        WHEN 4 THEN
                            '092'
                END
        END
    INTO
        nutype,
        nupref
    FROM
        ge_subs_phone sp
    WHERE
            sp.phone = nutelefono
        AND sp.subscriber_id = inusubscriberid
        AND ROWNUM = 1;

    --dbms_output.put_line('Tipo Tel y Pref: '||nuType||'-'||nuPref);

    RETURN nupref || nutelefono;
EXCEPTION
    WHEN no_data_found THEN
           ---no existen datos
        RETURN '';
    WHEN OTHERS THEN
        ---se esta generando un error al ejecutar la funcion
        RETURN '';
END ldc_tele_prefijo;
/

BEGIN
    pkg_utilidades.praplicarpermisos('LDC_TELE_PREFIJO', 'ADM_PERSON');
END;
/
GRANT EXECUTE ON ADM_PERSON.LDC_TELE_PREFIJO TO REXEREPORTES;
/
