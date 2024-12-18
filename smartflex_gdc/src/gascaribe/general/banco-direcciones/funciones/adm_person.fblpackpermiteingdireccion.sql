CREATE OR REPLACE FUNCTION ADM_PERSON.fblPackPermiteIngDireccion(nuPackageType IN ps_package_type.package_type_id%type)
RETURN BOOLEAN IS
/*******************************************************************************
Propiedad intelectual de Gases del Caribe

Programa:    fblPackPermiteIngDireccion
Autor:       jpadilla
Fecha:       26-08-2024
Descripcion: Valida si un tipo de solicitud tiene permitido modificar los predios.
            Para esto se usa el parámetro PACK_PERMITE_ING_DIRECCION, el cual
            guarda un listado de tipos de solicitudes que tienen permitido modificar
            la base de direcciones directamente en OSF.

Fecha           Autor               Modificacion
============    ================    ============================================
23-08-2024      JPADILLA            Se crea la función.
*******************************************************************************/

    nuExiste            number;

    CURSOR cuExistePaquete(nuPackageTypeId ps_package_type.package_type_id%type) IS
        SELECT COUNT(1)
        FROM PS_PACKAGE_TYPE pt
        WHERE pt.PACKAGE_TYPE_ID IN (
            SELECT TO_NUMBER(REGEXP_SUBSTR(pkg_bcld_parameter.fsbObtieneValorCadena('PACK_PERMITE_ING_DIRECCION'), '[^,]+', 1, LEVEL))
            FROM dual
            CONNECT BY REGEXP_SUBSTR(pkg_bcld_parameter.fsbObtieneValorCadena('PACK_PERMITE_ING_DIRECCION'), '[^,]+', 1, LEVEL) IS NOT NULL
        )
        AND pt.PACKAGE_TYPE_ID = nuPackageTypeId;

BEGIN
    IF (cuExistePaquete%ISOPEN) THEN
        CLOSE cuExistePaquete;
    END IF;

    OPEN cuExistePaquete(nuPackageType);
    FETCH cuExistePaquete INTO nuExiste;
    CLOSE cuExistePaquete;

    RETURN nuExiste <> 0;
END fblPackPermiteIngDireccion;
/
PROMPT "Función fblPackPermiteIngDireccion creada"

BEGIN
    pkg_utilidades.prAplicarPermisos('fblPackPermiteIngDireccion', 'ADM_PERSON');
END;
/
PROMPT "Permisos aplicados a la función fblPackPermiteIngDireccion"
