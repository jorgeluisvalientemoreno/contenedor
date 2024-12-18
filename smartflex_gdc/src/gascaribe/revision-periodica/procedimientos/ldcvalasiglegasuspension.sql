CREATE OR REPLACE PROCEDURE LDCVALASIGLEGASUSPENSION (
    inuProduct_id   IN PR_PRODUCT.PRODUCT_ID%TYPE)
AS
    /*****************************************************************************************************************
    Propiedad Intelectual de HORBATH TECHNOLOGIES

    Funcion     :  LDCVALASIGLEGASUSPENSION
    Descripcion :  Validaciones:
                  *si existen ordes de suspension en estados parametrisados LDC_PAR_STATUSORDEN_SUSP
                  *asignar y legalizar las ordenes
                  *enviar correos a unidades operativas y al responsable de revision

    Autor       : Josh Brito
    Fecha       : 3-04-2018

    Historia de Modificaciones
      Fecha               Autor                Modificacion
    =========           =========          ====================
    03-04-2018          Josh Brito         Creacion Caso 200-1871
    05/04/2018          Josh Brito         Asignacion y legalizacion de ordenes de reparacion
    19/09/2018          JJJM               Se cambia parametro LDC_PAR_STATUSORDEN_SUSP por LDC_PAR_STATUSORDEN_SUSP_NEW
                                           en el cursor cuOrden
    10/02/2019          Horbath Tech       Se modifica cursor cuOrdenReparacion para que tenga en cuenta
                                               las peticiones (mo_motive) con estado 13 y no tenga en cuenta
                                               los or_order_activity que tengan la actividad que este en el
                                               parametro ACTIVIDAD_NO_CIERRE_REPARA. caso 200-2264
    13/08/2019      ESANTIAGO (horbath)    Caso: 200-2628 se modifica la forma en  que se obtiene el usuario(INUPERSONID),
                                           para legalización para obtener el valor del parámetro PERID_GEN_CIOR.
    28/07/2023          jpinedc             OSF-1357:
                                            * Se reemplaza os_legalizeorders por
                                            api_legalizeorders
                                            * Se reemplaza OS_ASSIGN_ORDER por 
                                            API_ASSIGN_ORDER                                            
                                            * ge_boerrors.seterrorcodeargument por
                                            pkg_error.setErrorMessage                                         
                                            * Se reemplaza Errors.setError; por
                                            pkg_error.setError;
                                            * Se reemplaza ERRORS.geterror por
                                            pkg_error.getError
                                            * Se cambia when ex.CONTROLLED_ERROR 
                                            por WHEN pkg_error.Controlled_Error
                                            * Se cambia raise ex.Controlled_Error
                                            por pkg_error.Controlled_Error                                        
                                            * Se quita RAISE pkg_Error.controlled_error
                                            después de pkg_error.setErrorMessage
                                            * Se quitan variables que no se usan
                                            * Se quita codigo que está en comentarios
                                            * Se agrega pkg_utilidades.prAplicarPermisos
                                            * Se agrega pkg_utilidades.prCrearSinonimos
                                            * osbMensError
    02/08/2023          jpinedc             OSF-1357:                                            
                                            * Se reemplaza gw_boerrors.checkerror por
                                            pkg_error.setErrorMessage          
    **********************************************************************************************************************/

    nuTipoTrab             ld_parameter.numeric_value%TYPE;
    ISBDATAORDER           VARCHAR2 (2000);
    nuCausalId             or_order.causal_id%TYPE;

    nuTipoComment          OR_ORDER_COMMENT.COMMENT_TYPE_ID%TYPE;
    nuTipoCo               OR_ORDER_COMMENT.COMMENT_TYPE_ID%TYPE := 3;
    onuErrorCode           NUMBER;
    osbErrorMessage        VARCHAR2 (2000);
    nuClaseCausal          ge_causal.CLASS_CAUSAL_ID%TYPE;
    nuCantActividad        or_order_activity.VALUE_REFERENCE%TYPE;
    INUPERSONID            ge_person.person_id%TYPE;
    nuoperatingunit        or_order.OPERATING_UNIT_ID%TYPE;

    isbObserva             or_order_comment.order_comment%TYPE
        := 'Se cierra por generación de tramite desde LDCVALASIGLEGASUSPENSION';

    sbInstance             VARCHAR2 (32767);
    nuPackageId            mo_packages.package_id%TYPE;
    nuPackage_type_id      mo_packages.package_type_id%TYPE;

    sbEnviarCorreo         BOOLEAN DEFAULT FALSE;
    sbToUnidOper           VARCHAR2 (2000) := '';
    sbCorreo               VARCHAR2 (2000) := NULL;
    sbTipoSoliSuspe        open.ld_parameter.value_chain%TYPE
        := DALD_PARAMETER.fsbGetValue_Chain ('TIPO_SOL_CERRAR_SUSPENSION',
                                             NULL);
    nuorden                or_order.order_id%TYPE;

    --Cursor para buscar la orden asociada a la solicitud de revision periodica
    -- Team 3473 sengun los TT configurados en los parametros.
    CURSOR cuOrden (nuProductId PR_PRODUCT.PRODUCT_ID%TYPE)
    IS
        SELECT b.order_id,
               b.task_type_id,
               b.order_status_id,
               a.order_activity_id,
               a.package_id,
               b.operating_unit_id
          FROM or_order_activity a, or_order b, open.mo_packages p
         WHERE     a.order_id = b.order_id
               AND (   b.task_type_id IN
                           (SELECT TO_NUMBER (COLUMN_VALUE)
                              FROM TABLE (
                                       LDC_BOUTILITIES.SPLITSTRINGS (
                                           DALD_PARAMETER.fsbGetValue_Chain (
                                               'LDC_TT_SUSP_CM',
                                               NULL),
                                           ',')))
                    OR b.task_type_id IN
                           (SELECT TO_NUMBER (COLUMN_VALUE)
                              FROM TABLE (
                                       LDC_BOUTILITIES.SPLITSTRINGS (
                                           DALD_PARAMETER.fsbGetValue_Chain (
                                               'LDC_TT_SUSP_ACOMETIDA',
                                               NULL),
                                           ','))))
               AND b.order_status_id IN
                       (SELECT TO_NUMBER (COLUMN_VALUE)
                          FROM TABLE (
                                   LDC_BOUTILITIES.SPLITSTRINGS (
                                       DALD_PARAMETER.fsbGetValue_Chain (
                                           'LDC_PAR_STATUSORDEN_SUSP_NEW',
                                           NULL),
                                       ',')))
               AND a.PRODUCT_ID = nuProductId
               AND a.package_id = p.package_id
               AND INSTR (sbTipoSoliSuspe, package_type_id) > 0;

    CURSOR cuOrdenReparacion (nuProductId PR_PRODUCT.PRODUCT_ID%TYPE)
    IS
        SELECT b.order_id,
               b.task_type_id,
               b.order_status_id,
               a.order_activity_id,
               a.package_id,
               b.operating_unit_id
          FROM or_order_activity  a,
               or_order           b,
               mo_packages        p,
               mo_motive          m
         WHERE     a.order_id = b.order_id
               AND a.package_id = p.package_id
               AND p.package_id = m.package_id
               AND P.MOTIVE_STATUS_ID = 13                         -- 200-2264
               AND A.ACTIVITY_ID NOT IN
                       (SELECT TO_NUMBER (COLUMN_VALUE)
                          FROM TABLE (
                                   LDC_BOUTILITIES.SPLITSTRINGS (
                                       DALD_PARAMETER.fsbGetValue_Chain (
                                           'ACTIVIDAD_NO_CIERRE_REPARA',
                                           NULL),
                                       ',')))                      -- 200-2264
               AND m.product_id = nuProductId
               AND p.package_type_id =
                   DALD_PARAMETER.fnuGetNumeric_Value (
                       'TRAMITE_REPARACION_PRP',
                       NULL)
               AND b.order_status_id IN
                       (SELECT TO_NUMBER (COLUMN_VALUE)
                          FROM TABLE (
                                   LDC_BOUTILITIES.SPLITSTRINGS (
                                       DALD_PARAMETER.fsbGetValue_Chain (
                                           'LDC_PAR_STATUSORDEN_SUSP',
                                           NULL),
                                       ',')))
               AND a.PRODUCT_ID = nuProductId;

    CURSOR cuCorreosResponsableRVS IS
        SELECT p.E_MAIL
          FROM ge_person p
         WHERE p.PERSON_ID IN
                   (SELECT TO_NUMBER (COLUMN_VALUE)
                      FROM TABLE (
                               LDC_BOUTILITIES.SPLITSTRINGS (
                                   DALD_PARAMETER.fsbGetValue_Chain (
                                       'LDC_PARRESPONSABLE_REVSION',
                                       NULL),
                                   ',')));

    PROCEDURE REPROGRAMA (INUORDEN OPEN.OR_ORDER.ORDER_ID%TYPE)
    IS
        --SBORDERID             GE_BOINSTANCECONTROL.STYSBVALUE;
        SBARRANGEDHOUR        GE_BOINSTANCECONTROL.STYSBVALUE;
        SBOPERATINGUNITID     GE_BOINSTANCECONTROL.STYSBVALUE;
        NUOPERATINGUNITID     OR_OPERATING_UNIT.OPERATING_UNIT_ID%TYPE;
        SBASSIGNEDDATE        GE_BOINSTANCECONTROL.STYSBVALUE;
        DTNEWASSIGNDATE       DATE;
        DTTRUNCSYSDATE        DATE;
        --SBMAXPOSTPORDERDAYS   GE_PARAMETER.VALUE%TYPE;
        NUMAXPOSTPORDERDAYS   NUMBER;
        RCORDER               DAOR_ORDER.STYOR_ORDER;
    BEGIN
        UT_TRACE.TRACE ('INICIA - LDCVALASIGLEGASUSPENSION.REPROGRAMA', 15);
        RCORDER := DAOR_ORDER.FRCGETRECORD (INUORDEN);
        SBARRANGEDHOUR := RCORDER.ASSIGNED_DATE;

        IF (RCORDER.OPERATING_UNIT_ID IS NOT NULL)
        THEN
            SBOPERATINGUNITID := RCORDER.OPERATING_UNIT_ID;
        END IF;

        SBASSIGNEDDATE := SYSDATE;

        DTNEWASSIGNDATE :=
            TRUNC (TO_DATE (SBASSIGNEDDATE, UT_DATE.FSBDATE_FORMAT));
        DTTRUNCSYSDATE := TRUNC (UT_DATE.FDTSYSDATE);

        BEGIN
            NUMAXPOSTPORDERDAYS :=
                NVL (
                    GE_BOPARAMETER.FNUVALORNUMERICO (
                        OR_BOCONSTANTS.CSBMAXPOSTPORDERDAYS),
                    OR_BOCONSTANTS.CNUDEFAULTMAXPOSTPORDERDAYS);

            IF (   NUMAXPOSTPORDERDAYS < 1
                OR NUMAXPOSTPORDERDAYS >
                   OR_BOCONSTANTS.CNUDEFAULTMAXPOSTPORDERDAYS)
            THEN
                NUMAXPOSTPORDERDAYS :=
                    OR_BOCONSTANTS.CNUDEFAULTMAXPOSTPORDERDAYS;
            END IF;
        EXCEPTION
            WHEN OTHERS
            THEN
                NUMAXPOSTPORDERDAYS :=
                    OR_BOCONSTANTS.CNUDEFAULTMAXPOSTPORDERDAYS;
        END;

        IF (NOT DTNEWASSIGNDATE BETWEEN TRUNC (UT_DATE.FDTSYSDATE)
                                    AND TRUNC (
                                              UT_DATE.FDTSYSDATE
                                            + NUMAXPOSTPORDERDAYS))
        THEN
            pkg_error.setErrorMessage (
                900891,
                   'Fecha de programacion|'
                || TO_CHAR (TRUNC (UT_DATE.FDTSYSDATE),
                            UT_DATE.FSBDATE_FORMAT)
                || '|'
                || TO_CHAR (TRUNC (UT_DATE.FDTSYSDATE + NUMAXPOSTPORDERDAYS),
                            UT_DATE.FSBDATE_FORMAT));
        END IF;

        IF (RCORDER.OPERATING_UNIT_ID IS NULL)
        THEN
            IF (DTNEWASSIGNDATE = DTTRUNCSYSDATE)
            THEN
                OR_BOORDERTRANSITION.CHANGESTATUS (
                    RCORDER,
                    OR_BOCONSTANTS.CNUORDER_ACTION_ASSIGN,
                    OR_BOCONSTANTS.CNUORDER_STAT_REGISTERED,
                    FALSE);
                RCORDER.ASSIGNED_DATE := NULL;
                OR_BOPROCESSORDER.UPDBASICDATA (RCORDER, NULL, NULL);
            ELSE
                RCORDER.ASSIGNED_DATE := DTNEWASSIGNDATE;
            END IF;

            DAOR_ORDER.UPDRECORD (RCORDER);
        ELSE
            NUOPERATINGUNITID :=
                SUBSTR (SBOPERATINGUNITID,
                        0,
                        INSTR (SBOPERATINGUNITID, '-') - 1);

            IF (DTNEWASSIGNDATE = DTTRUNCSYSDATE)
            THEN
                OR_BOORDERTRANSITION.CHANGESTATUS (
                    RCORDER,
                    OR_BOCONSTANTS.CNUORDER_ACTION_ASSIGN,
                    OR_BOCONSTANTS.CNUORDER_STAT_REGISTERED,
                    FALSE);
                DAOR_ORDER.UPDRECORD (RCORDER);
                OR_BOPROCESSORDER.PROCESSORDER (RCORDER.ORDER_ID,
                                                NULL,
                                                NUOPERATINGUNITID,
                                                UT_DATE.FDTSYSDATE,
                                                TRUE);

                IF (DAOR_ORDER.FNUGETORDER_STATUS_ID (RCORDER.ORDER_ID) =
                    OR_BOCONSTANTS.CNUORDER_STAT_REGISTERED)
                THEN
                    RCORDER.ASSIGNED_DATE := NULL;
                    RCORDER.OPERATING_UNIT_ID := NULL;
                    DAOR_ORDER.UPDRECORD (RCORDER);
                END IF;
            ELSE
                RCORDER.ASSIGNED_DATE := DTNEWASSIGNDATE;
                DAOR_ORDER.UPDRECORD (RCORDER);
            END IF;
        END IF;

        UT_TRACE.TRACE ('FIN - LDCVALASIGLEGASUSPENSION.REPROGRAMA', 15);
    END;
BEGIN
    ut_trace.trace ('Inicio LDCVALASIGLEGASUSPENSION', 10);
    DBMS_OUTPUT.put_line ('Inicio proceso');

    GE_BOINSTANCECONTROL.GETCURRENTINSTANCE (sbInstance);
    GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE (sbInstance,
                                               NULL,
                                               'MO_PACKAGES',
                                               'PACKAGE_ID',
                                               nuPackageId);
    ut_trace.trace ('Obtine nuPackageId -->' || nuPackageId, 10);

    GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE (sbInstance,
                                               NULL,
                                               'MO_PACKAGES',
                                               'PACKAGE_TYPE_ID',
                                               nuPackage_type_id);
    ut_trace.trace ('Obtine nuPackage_type_id -->' || nuPackage_type_id, 10);


    BEGIN
        nuorden := or_bolegalizeorder.fnuGetCurrentOrder;
    EXCEPTION
        WHEN OTHERS
        THEN
            nuorden := NULL;
    END;

    IF INSTR (DALD_PARAMETER.fsbGetValue_Chain ('LDC_PAR_INSTANCIA', NULL),
              ut_session.getmodule) =
       0
    THEN
        RETURN;
    END IF;


    nuTipoTrab :=
        Dald_parameter.fnuGetNumeric_Value ('ID_TASKTYPE_SUSP_REVI_RP', NULL);

    IF nuTipoTrab IS NULL
    THEN
        pkg_error.setErrorMessage ( isbMsgErrr =>
            'No existe datos para el parametro "ID_TASKTYPE_SUSP_REVI_RP", definalos por el comando LDPAR separados por coma');
    END IF;

    nuTipoTrab :=
        Dald_parameter.fnuGetNumeric_Value ('ID_TASKTYPE_ACOM_REVI_RP', NULL);

    IF nuTipoTrab IS NULL
    THEN
        pkg_error.setErrorMessage (
            isbMsgErrr =>
            'No existe datos para el parametro "ID_TASKTYPE_ACOM_REVI_RP", definalos por el comando LDPAR separados por coma');
    END IF;

    nuCausalId :=
        Dald_parameter.fnuGetNumeric_Value ('ID_CAUSAL_SUSP_REVI_RP', NULL);

    IF nuCausalId IS NULL
    THEN
        pkg_error.setErrorMessage (
            isbMsgErrr =>
            'No existe datos para el parametro "ID_CAUSAL_SUSP_REVI_RP", definalos por el comando LDPAR separados por coma');
    END IF;

    nuTipoComment :=
        Dald_parameter.fnuGetNumeric_Value ('ID_TYPE_COMMENT_RP', NULL);

    IF nuTipoComment IS NULL
    THEN
        pkg_error.setErrorMessage (
            isbMsgErrr =>
            'No existe datos para el parametro "ID_TYPE_COMMENT_RP", definalos por el comando LDPAR separados por coma');
    END IF;

    nuoperatingunit :=
        Dald_parameter.fnuGetNumeric_Value ('ID_OPER_UNIT_LEG_OT_RP', NULL);

    IF nuoperatingunit IS NULL
    THEN
        pkg_error.setErrorMessage (
            isbMsgErrr =>
            'No existe datos para el parametro "ID_OPER_UNIT_LEG_OT_RP", definalos por el comando LDPAR separados por coma');
    END IF;

    INUPERSONID := dald_parameter.fnuGetNumeric_Value ('PERID_GEN_CIOR'); --caso:200-2628

    --ASIGNA Y LEGALIZA ORDENES DE SUSPENSION EN PROCESO
    FOR O IN cuOrden (inuProduct_id)
    LOOP
        sbEnviarCorreo := FALSE;
        sbCorreo := NULL;
        sbToUnidOper := '';
        ut_trace.trace ('ASIGNO A LA ORDEN DE SUSPENSION==>' || O.order_id,
                        10);
        -- proceso que estas ordenes queden asignado a la unidad de trabajo
        -- configurado en el parametro  'ID_OPER_UNIT_LEG_OT_RP'
        onuErrorCode := 0;

        IF O.ORDER_STATUS_ID = 20
        THEN
            REPROGRAMA (O.ORDER_ID);
        END IF;

        IF O.ORDER_STATUS_ID != 5
        THEN
            API_ASSIGN_ORDER (O.order_id,
                             nuoperatingunit,
                             onuErrorCode,
                             osbErrorMessage);
            ut_trace.trace (
                   'BUSCO LA CAUSAL PARA LEGALIZAR LA OT DE SUSPENSION==>'
                || O.order_id,
                10);

            IF onuErrorCode != 0
            THEN
                pkg_error.setErrorMessage ( isbMsgErrr => osbErrorMessage);
            END IF;
        ELSE
            INUPERSONID :=
                dald_parameter.fnuGetNumeric_Value ('PERID_GEN_CIOR'); --caso:200-2628
        END IF;

        nuTipoTrab :=
            Dald_parameter.fnuGetNumeric_Value ('ID_TASKTYPE_SUSP_REVI_RP');

        IF O.task_type_id = nuTipoTrab
        THEN
            nuCausalId :=
                Dald_parameter.fnuGetNumeric_Value ('ID_CAUSAL_SUSP_REVI_RP');
        ELSE
            nuTipoTrab :=
                Dald_parameter.fnuGetNumeric_Value (
                    'ID_TASKTYPE_ACOM_REVI_RP');

            IF O.task_type_id = nuTipoTrab
            THEN
                nuCausalId :=
                    Dald_parameter.fnuGetNumeric_Value (
                        'ID_CAUSAL_SUSP_REVI_RP');
            END IF;
        END IF;

        nuClaseCausal := dage_causal.fnugetclass_causal_id (nuCausalId);

        IF nuClaseCausal = 1
        THEN
            nuCantActividad := 1;
        ELSE
            nuCantActividad := 0;
        END IF;


        ISBDATAORDER :=
               O.order_id
            || '|'
            || nuCausalId
            || '|'
            || inuPersonId
            || '||'
            || O.order_activity_id
            || '>'
            || nuCantActividad
            || ';READING>>>;COMMENT1>>>;COMMENT2>>>;COMMENT3>>>|||'
            || nuTipoCo
            || ';'
            || isbObserva;
        api_legalizeorders (ISBDATAORDER,
                           SYSDATE,
                           SYSDATE,
                           SYSDATE,
                           onuErrorCode,
                           osbErrorMessage);

        IF (onuErrorCode <> 0)
        THEN
            pkg_error.setErrorMessage (isbMsgErrr => osbErrorMessage);
        END IF;

    END LOOP;

    -- VALIDA SI ES GESTIONADO POR EL TRAMITE DE 100295 - CERTFICACION PRP
    --ASIGNA Y LEGALIZA ORDENES DE REPARACION EN PROCESO
    INUPERSONID := dald_parameter.fnuGetNumeric_Value ('PERID_GEN_CIOR'); --caso:200-2628

    IF nuPackage_type_id =
       DALD_PARAMETER.fnuGetNumeric_Value ('TRAMITE_CERTIFICACION_PRP', NULL)
    THEN
        FOR R IN cuOrdenReparacion (inuProduct_id)
        LOOP
            sbEnviarCorreo := FALSE;
            sbCorreo := NULL;
            sbToUnidOper := '';
            ut_trace.trace (
                'ASIGNO A LA ORDEN DE REPARACION==>' || R.order_id,
                10);
            -- proceso que estas ordenes queden asignado a la unidad de trabajo
            -- configurado en el parametro  'ID_OPER_UNIT_LEG_OT_RP'
            onuErrorCode := 0;

            IF R.ORDER_STATUS_ID = 20
            THEN
                REPROGRAMA (R.ORDER_ID);
            END IF;

            IF R.ORDER_STATUS_ID != 5
            THEN
                API_ASSIGN_ORDER (R.order_id,
                                 nuoperatingunit,
                                 onuErrorCode,
                                 osbErrorMessage);
                ut_trace.trace (
                       'BUSCO LA CAUSAL PARA LEGALIZAR LA OT DE REPARACION==>'
                    || R.order_id,
                    10);

                IF onuErrorCode != 0
                THEN
                    pkg_error.setErrorMessage ( isbMsgErrr => osbErrorMessage);
                END IF;
            ELSE
                INUPERSONID :=
                    dald_parameter.fnuGetNumeric_Value ('PERID_GEN_CIOR'); --caso:200-2628
            END IF;


            nuCausalId :=
                Dald_parameter.fnuGetNumeric_Value ('ID_CAUSAL_LEGALIZA_RPR');

            IF nuCausalId IS NULL
            THEN
                pkg_error.setErrorMessage (
                    isbMsgErrr =>
                    'No existe datos para el parametro "ID_CAUSAL_LEGALIZA_RPR", definalos por el comando LDPAR separados por coma');
            END IF;

            nuClaseCausal := dage_causal.fnugetclass_causal_id (nuCausalId);

            IF nuClaseCausal = 1
            THEN
                nuCantActividad := 1;
            ELSE
                nuCantActividad := 0;
            END IF;

            ISBDATAORDER :=
                   R.order_id
                || '|'
                || nuCausalId
                || '|'
                || inuPersonId
                || '||'
                || R.order_activity_id
                || '>'
                || nuCantActividad
                || ';READING>>>;COMMENT1>>>;COMMENT2>>>;COMMENT3>>>|||'
                || nuTipoCo
                || ';'
                || isbObserva;
            api_legalizeorders (ISBDATAORDER,
                               SYSDATE,
                               SYSDATE,
                               SYSDATE,
                               onuErrorCode,
                               osbErrorMessage);

            IF (onuErrorCode <> 0)
            THEN
                pkg_error.setErrorMessage ( isbMsgErrr =>  osbErrorMessage);
            END IF;

            LDC_NOTIFICA_CIERRE_OT (R.ORDER_ID, 'L');

        END LOOP;
    END IF;
EXCEPTION
    WHEN pkg_Error.CONTROLLED_ERROR
    THEN
        RAISE;
    WHEN OTHERS
    THEN
        pkg_error.setError;
        RAISE pkg_Error.CONTROLLED_ERROR;
END LDCVALASIGLEGASUSPENSION;
/

PROMPT Otorgando permisos de ejecución sobre LDCVALASIGLEGASUSPENSION
BEGIN
    pkg_utilidades.prAplicarPermisos('LDCVALASIGLEGASUSPENSION','OPEN');
END;
/

