CREATE OR REPLACE FUNCTION adm_person.ldc_retornaflagasounidper (
    inuperson IN NUMBER,
    inuunidad IN NUMBER
) RETURN NUMBER IS
/**************************************************************************
  Autor       : John Jairo Jimenez Marimon
  Fecha       : 2014-02-14
  Descripcion : Verificamos asociación persona con unidad operativa, retorna 1 si existe de lo contrario 0

  Parametros Entrada
    inuperson persona
    inuunidad unidad operativa

  Valor de salida
    Existencia o on

 HISTORIA DE MODIFICACIONES
    FECHA           AUTOR               DESCRIPCION
    07/03/2024      Paola Acosta        OSF-2104: Se retiran referencias .open a objetos
    06/03/2024      Paola Acosta        OSF-2104: Se agregan permisos para REXEREPORTES por solicitud de CGonzalez
    27/02/2024      Paola Acosta        OSF-2104: Migracion del esquema OPEN al esquema ADM_PERSON 
***************************************************************************/
    nuconta NUMBER DEFAULT 0;
BEGIN
    nuconta := 0;
    SELECT
        COUNT(1)
    INTO nuconta
    FROM
        or_oper_unit_persons up
    WHERE
            up.operating_unit_id = inuunidad
        AND up.person_id = inuperson;

    IF nuconta > 0 THEN
        RETURN 1;
    ELSE
        RETURN 0;
    END IF;
END ldc_retornaflagasounidper;
/

BEGIN
    pkg_utilidades.praplicarpermisos('LDC_RETORNAFLAGASOUNIDPER', 'ADM_PERSON');
END;
/

GRANT EXECUTE ON adm_person.ldc_retornaflagasounidper TO REXEREPORTES;
/