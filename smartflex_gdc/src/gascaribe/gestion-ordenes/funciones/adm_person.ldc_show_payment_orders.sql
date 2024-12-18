CREATE OR REPLACE FUNCTION adm_person.ldc_show_payment_orders (
    inuorderid IN or_order.order_id%TYPE
) RETURN NUMBER IS
    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : LDC_SHOW_PAYMENT_ORDERS
    Descripcion    : Valida si debe mostrar la orden de pago/cobro a proveedor/contratista
                     dependiendo de la unidad operativa del usuario conectado.

    Autor          : KCienfuegos.RNP2923
    Fecha          : 06/01/2015

    Parametros                   Descripcion
    ============             ===================
    inuOrderId:              Id de la Orden

    Historia de Modificaciones
    Fecha            Autor                  Modificacion
    =========        =========              ====================
    06/03/2024       Paola Acosta           OSF-2104: Se agregan permisos para REXEREPORTES por solicitud de CGonzalez
    29/02/2024       Paola Acosta           OSF-2104: Migracion del esquema OPEN al esquema ADM_PERSON
    06/01/2015       KCienfuegos.RNP2923    Creacion.
    ******************************************************************/
    
    nuoperatingunit or_operating_unit.operating_unit_id%TYPE;
    nuoperunitconn  or_operating_unit.operating_unit_id%TYPE;
    nucontractconn  or_operating_unit.contractor_id%TYPE;
    nucontractsale  or_operating_unit.contractor_id%TYPE;
    nuresult        NUMBER := 1;

    --Obtiene la unidad operativa del usuario conectado
    CURSOR cugetunitbyseller IS
    SELECT
        organizat_area_id
    FROM
        cc_orga_area_seller
    WHERE
            person_id = ge_bopersonal.fnugetpersonid
        AND is_current = 'Y'
        AND ROWNUM = 1;

    CURSOR cugetoperunit IS
    SELECT
        o.operating_unit_id
    FROM
        or_order o
    WHERE
        o.order_id = inuorderid;

    CURSOR cuorder IS
    SELECT
        o.order_id
    FROM
        or_order o
    WHERE
            o.order_id = inuorderid
        AND ( instr(dald_parameter.fsbgetvalue_chain('EXCL_TIP_TRABAJO_CONT'), o.task_type_id) > 0
              OR instr(dald_parameter.fsbgetvalue_chain('EXCL_TIP_TRABAJO_PROV'), o.task_type_id) > 0 );

BEGIN

    --Obtiene la unidad operativa del usario conectado
    OPEN cugetunitbyseller;
    FETCH cugetunitbyseller INTO nuoperunitconn;
    CLOSE cugetunitbyseller;
    IF nuoperunitconn IS NOT NULL THEN
        nucontractconn := daor_operating_unit.fnugetcontractor_id(nuoperunitconn, 0);
    END IF;

    FOR i IN cuorder LOOP
        --Obtiene la unidad operativa de la orden
        OPEN cugetoperunit;
        FETCH cugetoperunit INTO nuoperatingunit;
        CLOSE cugetoperunit;
        IF nuoperatingunit IS NOT NULL THEN
            nucontractsale := daor_operating_unit.fnugetcontractor_id(nuoperatingunit, 0);
        END IF;

        --Valida si el contratista de la ut de la orden es igual al contratista de la ut del usuario conectado
        IF nvl(nucontractsale, -1) <> nucontractconn THEN
            nuresult := 0;
        ELSE
            nuresult := 1;
        END IF;

    END LOOP;

    RETURN nuresult;
END ldc_show_payment_orders;
/

BEGIN
    pkg_utilidades.praplicarpermisos('LDC_SHOW_PAYMENT_ORDERS', 'ADM_PERSON');
END;
/
GRANT EXECUTE ON ADM_PERSON.LDC_SHOW_PAYMENT_ORDERS TO REXEREPORTES;
/