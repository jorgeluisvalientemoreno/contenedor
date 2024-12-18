CREATE OR REPLACE PACKAGE adm_person.LDC_VALIDA_ORDER_REDES
IS

/**************************************************************************
    Autor       :
    Fecha       : 12/07/2020
    Ticket      : 443
    Descripción: Paquete para validacion de forma LDCDEORREOF

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
***************************************************************************/

    /**************************************************************************
        Fecha       : 12/07/2020
        Ticket      : 443
        Descripción: Retorna la version actual del objeto
    ***************************************************************************/
    FUNCTION fsbVersion
    RETURN VARCHAR2;

    /**************************************************************************
        Fecha       : 12/07/2020
        Ticket      : 443
        Descripción: Valida si la orden ya está registrada como padre, hija o nieta
    ***************************************************************************/
    PROCEDURE VALIDA_ORDENES
    (
        inuOtPadre      in  ldc_ordenes_ofertados_redes.orden_padre%TYPE,
        inuOtHija       in  ldc_ordenes_ofertados_redes.orden_hija%TYPE,
        inuOtNieta      in  ldc_ordenes_ofertados_redes.orden_nieta%TYPE
    );


END LDC_VALIDA_ORDER_REDES;
/
CREATE OR REPLACE PACKAGE BODY adm_person.LDC_VALIDA_ORDER_REDES
IS
/**************************************************************************
    Autor       :
    Fecha       : 12/07/2020
    Ticket      : 443
    Descripción: Paquete para validacion de forma LDCDEORREOF

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
***************************************************************************/

    csbVERSION  CONSTANT    VARCHAR2(20) := 'OSF-2884';

    /**************************************************************************
        Autor       : OLsoftware
        Fecha       : 12/07/2020
        Ticket      : 443
        Descripción: Retorna la version actual del objeto

        Parámetros Entrada

        Valor de salida

        HISTORIA DE MODIFICACIONES
        FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
    FUNCTION fsbVersion
    RETURN VARCHAR2
    IS
    BEGIN
       RETURN csbVERSION;
    END fsbVersion;

    /**************************************************************************
        Autor       : OLsoftware
        Fecha       : 12/07/2020
        Ticket      : 443
        Descripción: Valida si la orden ya está registrada como padre, hija o nieta

        Parámetros Entrada

        HISTORIA DE MODIFICACIONES
        FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
    PROCEDURE VALIDA_ORDENES
    (
        inuOtPadre      in  ldc_ordenes_ofertados_redes.orden_padre%TYPE,
        inuOtHija       in  ldc_ordenes_ofertados_redes.orden_hija%TYPE,
        inuOtNieta      in  ldc_ordenes_ofertados_redes.orden_nieta%TYPE
    )
    IS
        dtFechaIinicio      DATE;
        sbErrMsg            VARCHAR2(2000);
        nuExiste            NUMBER := 0;

        CURSOR cuHijaNieta
        (
            inuOrder  in  ldc_ordenes_ofertados_redes.orden_padre%TYPE
        )
        IS
            SELECT  count(1)
            FROM    ldc_ordenes_ofertados_redes
            WHERE   (ldc_ordenes_ofertados_redes.orden_hija = inuOrder OR
                     ldc_ordenes_ofertados_redes.orden_nieta = inuOrder);

        CURSOR cuPadreNieta
        (
            inuOrder  in  ldc_ordenes_ofertados_redes.orden_hija%TYPE
        )
        IS
            SELECT  count(1)
            FROM    ldc_ordenes_ofertados_redes
            WHERE   (ldc_ordenes_ofertados_redes.orden_padre = inuOrder OR
                     ldc_ordenes_ofertados_redes.orden_nieta = inuOrder);

        CURSOR cuPadreHija
        (
            inuOrder  in  ldc_ordenes_ofertados_redes.orden_nieta%TYPE
        )
        IS
            SELECT  count(1)
            FROM    ldc_ordenes_ofertados_redes
            WHERE   (ldc_ordenes_ofertados_redes.orden_padre = inuOrder OR
                     ldc_ordenes_ofertados_redes.orden_hija = inuOrder);


    BEGIN
        ut_trace.trace('Inicia LDC_VALIDA_ORDER_REDES.VALIDA_ORDENES - inuOtPadre: '||inuOtPadre||
                        ' inuOtHija: '||inuOtHija||' inuOtNieta: '||inuOtNieta,10);

        -- Se valida la orden padre
        IF inuOtPadre IS NOT NULL THEN

            OPEN cuHijaNieta(inuOtPadre);
            FETCH cuHijaNieta INTO nuExiste;
            CLOSE cuHijaNieta;

            IF nuExiste > 0 THEN
                sbErrMsg := 'La orden ['||inuOtPadre||'] que está almacenando como padre, ya existe como orden hija o nieta. Favor validar.';
                Errors.seterror(2741,sbErrMsg);
                RAISE ex.CONTROLLED_ERROR;
            END IF;

        END IF;

        nuExiste := 0;
        -- Se valida la orden hija
        IF inuOtHija IS NOT NULL THEN

            OPEN cuPadreNieta(inuOtHija);
            FETCH cuPadreNieta INTO nuExiste;
            CLOSE cuPadreNieta;

            IF nuExiste > 0 THEN
                sbErrMsg := 'La orden ['||inuOtHija||'] que está almacenando como hija, ya existe como orden padre o nieta. Favor validar.';
                Errors.seterror(2741,sbErrMsg);
                RAISE ex.CONTROLLED_ERROR;
            END IF;

        END IF;

        nuExiste := 0;
        -- Se valida la orden hija
        IF inuOtNieta IS NOT NULL THEN

            OPEN cuPadreHija(inuOtNieta);
            FETCH cuPadreHija INTO nuExiste;
            CLOSE cuPadreHija;

            IF nuExiste > 0 THEN
                sbErrMsg := 'La orden ['||inuOtNieta||'] que está almacenando como nieta, ya existe como orden padre o hija. Favor validar.';
                Errors.seterror(2741,sbErrMsg);
                RAISE ex.CONTROLLED_ERROR;
            END IF;

        END IF;


        ut_trace.trace('Fin LDC_VALIDA_ORDER_REDES.VALIDA_ORDENES',10);
    EXCEPTION
        WHEN ex.CONTROLLED_ERROR THEN
            RAISE ex.CONTROLLED_ERROR;

        WHEN OTHERS THEN
            Errors.setError;
            RAISE ex.CONTROLLED_ERROR;
    END VALIDA_ORDENES;


END LDC_VALIDA_ORDER_REDES;
/
Prompt Otorgando permisos sobre ADM_PERSON.LDC_VALIDA_ORDER_REDES
BEGIN
    pkg_Utilidades.prAplicarPermisos(upper('LDC_VALIDA_ORDER_REDES'), 'ADM_PERSON');
END;
/