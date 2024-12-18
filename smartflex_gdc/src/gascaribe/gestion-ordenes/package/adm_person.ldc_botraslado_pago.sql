CREATE OR REPLACE PACKAGE adm_person.LDC_BOTRASLADO_PAGO IS
    
    /*****************************************************************
    Propiedad intelectual de GAS CARIBE (c).

    Unidad         : LDC_BOTRASLADO_PAGO
    Descripcion    : Objeto con servicios para el tramite de traslado de pago a otro contrato
    Autor          : Horbath
    Fecha          : 25-03-2022

    Historia de Modificaciones
    Fecha       Autor       Modificacion
    ==========  =========   ====================
    25-03-2022  cgonzalez   OSF-192 Creacion
    17-09-2024  jpinedc     OSF-3316 Se migra a ADM_PERSON
    02-10-2024  fvalencia   OSF-3395 Se modifica la función fsbAsignarOrden
    ******************************************************************/

    /*****************************************************************
    Propiedad intelectual de GAS CARIBE (c).
    Unidad         : fsbAsignarOrden
    Descripcion    : Asigna las ordenes de la solicitud a la unidad operativa
                     seleccionada en el campo "Unidad Operativa que Gestiona"
    ******************************************************************/
    FUNCTION fsbAsignarOrden(isbIN IN VARCHAR2) RETURN VARCHAR2;

END LDC_BOTRASLADO_PAGO;
/
CREATE OR REPLACE PACKAGE BODY adm_person.LDC_BOTRASLADO_PAGO IS

    csbSP_NAME		CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT||'.';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
    /*****************************************************************
    Propiedad intelectual de GAS CARIBE (c).

    Unidad         : LDC_BOTRASLADO_PAGO
    Descripcion    : Objeto con servicios para el tramite de traslado de pago a otro contrato
    Autor          : Horbath
    Fecha          : 25-03-2022

    Historia de Modificaciones
    Fecha       Autor       Modificacion
    ==========  =========   ====================
    25-03-2022  cgonzalez   OSF-192 Creacion
    17-09-2024  jpinedc     OSF-3316 Se migra a ADM_PERSON
    02-10-2024  fvalencia   OSF-3395 Se modifica la función fsbAsignarOrden
    ******************************************************************/

    /*****************************************************************
    Propiedad intelectual de GAS CARIBE (c).

    Unidad         : fsbAsignarOrden
    Descripcion    : Asigna las ordenes de la solicitud a la unidad operativa
                     seleccionada en el campo "Unidad Operativa que Gestiona"
    Autor          : Horbath
    Fecha          : 25-03-2022

    Historia de Modificaciones
    Fecha       Autor       Modificacion
    ==========  =========   ====================
    25-03-2022  cgonzalez   OSF-192 Creacion
    02-10-2024  fvalencia   OSF-3395 Se modifica el cursor CUDATA
                            para eliminar el to_number
    ******************************************************************/
    FUNCTION fsbAsignarOrden(isbIN IN VARCHAR2)
    RETURN VARCHAR2
    IS

        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fsbAsignarOrden';
        nuError         NUMBER;
        sbError         VARCHAR2(4000); 
    
        sbOrder_id          VARCHAR2(4000) := NULL;
        sbPackage_id        VARCHAR2(4000) := NULL;
        sbActivity_id       VARCHAR2(4000) := NULL;
        sbSubscription_id   VARCHAR2(4000) := NULL;
        nuUnidadOperativa   or_operating_unit.operating_unit_id%type;
        nuErrorId       	NUMBER;
        sbMensajeError  	VARCHAR2(4000);

        CURSOR CUDATA IS            
            SELECT regexp_substr(isbIN,'[^|]+', 1,LEVEL) COLUMN_VALUE
            FROM dual
            CONNECT BY regexp_substr(isbIN, '[^|]+', 1, LEVEL) IS NOT NULL
            ;

    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
        pkg_Traza.Trace('isbIN: '||isbIN, 5);

        FOR rcData IN cuData LOOP

            pkg_Traza.Trace(rcData.COLUMN_VALUE, 10);

            IF (sbOrder_id IS NULL) THEN
                sbOrder_id     := rcData.COLUMN_VALUE;
                sbMensajeError := '[ORDEN - ' || sbOrder_id || ']';
            ELSIF (sbPackage_id IS NULL) THEN
                sbPackage_id   := rcData.COLUMN_VALUE;
                sbMensajeError := sbMensajeError || ' - [SOLICITUD - ' || sbPackage_id || ']';
            ELSIF (sbActivity_id IS NULL) THEN
                sbActivity_id  := rcData.COLUMN_VALUE;
                sbMensajeError := sbMensajeError || ' - [ACTIVIDAD - ' || sbActivity_id || ']';
            ELSIF (sbSubscription_id IS NULL) THEN
                sbSubscription_id   := rcData.COLUMN_VALUE;
                sbMensajeError      := sbMensajeError || ' - [CONTRATO - ' || sbSubscription_id || ']';
            END IF;

        END LOOP;

        --Obtener Unidad Operativa seleccionada en el tramite
        nuUnidadOperativa := daldc_uo_traslado_pago.fnugetoperating_unit_id(sbPackage_id, null);

        IF (nuUnidadOperativa IS NOT NULL) THEN
            --Asigna la Orden a la Unidad Operativa
            API_ASSIGN_ORDER(TO_NUMBER(sbOrder_id),
                                    nuUnidadOperativa,
                                    nuErrorId,
                                    sbMensajeError);

            IF (nuErrorId = 0) THEN

                UPDATE LDC_ORDER
                SET    ASIGNADO = 'S'
                WHERE  NVL(sbPackage_id, 0) = NVL(TO_NUMBER(sbPackage_id), 0)
                AND    ORDER_ID = TO_NUMBER(sbOrder_id);

            ELSE
                LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TO_NUMBER(sbPackage_id),
                                                             TO_NUMBER(sbOrder_id),
                                                             'LA ORDEN NO FUE ASIGNADA A LA UNIDAD OPERATIVA [' ||
                                                             nuUnidadOperativa ||
                                                             '] - MENSAJE DE ERROR PROVENIENTE DE api_assign_order --> ' ||
                                                             sbMensajeError);
            END IF;
        END IF;

        RETURN nuUnidadOperativa;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 

    EXCEPTION
        WHEN pkg_Error.CONTROLLED_ERROR THEN

            nuErrorId    := LD_BOCONSTANS.CNUGENERIC_ERROR;
            sbMensajeError := 'INCONVENIENTES AL ASIGNAR LA UNIDAD OPERATIVA A LA SOLICITUD DE TRASLADO DE PAGO ' ||
                               PKERRORS.FSBGETERRORMESSAGE;
            sbMensajeError := sbMensajeError || ' - [' || DBMS_UTILITY.FORMAT_ERROR_STACK ||
                               ' - [' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE || ']';

            LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TO_NUMBER(sbPackage_id),
                                                 TO_NUMBER(sbOrder_id),
                                                 sbMensajeError);

            COMMIT;

            RETURN NULL;
        WHEN OTHERS THEN
            nuErrorId    := LD_BOCONSTANS.CNUGENERIC_ERROR;
            sbMensajeError := 'INCONVENIENTES AL ASIGNAR LA UNIDAD OPERATIVA A LA SOLICITUD DE TRASLADO DE PAGO ' ||
                               PKERRORS.FSBGETERRORMESSAGE;
            sbMensajeError := sbMensajeError || ' - [' || DBMS_UTILITY.FORMAT_ERROR_STACK ||
                               ' - [' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE || ']';

            LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TO_NUMBER(sbPackage_id),
                                                 TO_NUMBER(sbOrder_id),
                                                 sbMensajeError);

            COMMIT;

            RETURN NULL;
    END fsbAsignarOrden;

End LDC_BOTRASLADO_PAGO;
/
Prompt Otorgando permisos sobre ADM_PERSON.LDC_BOTRASLADO_PAGO
BEGIN
    pkg_Utilidades.prAplicarPermisos(upper('LDC_BOTRASLADO_PAGO'), 'ADM_PERSON');
END;
/
