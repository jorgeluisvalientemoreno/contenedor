CREATE OR REPLACE PACKAGE adm_person.ldc_bcRevokeOts
IS
    /*****************************************************************
        Propiedad intelectual de PETI (c).

        Unidad         : ldc_bcRevokeOts
        Descripcion    : Paquete donde se implementa la lógica para la anulación de ots.
        Autor          : Sayra Ocoro
        Fecha          : 20/08/2013

        Metodos

        Nombre         :
        Parametros         Descripcion
        ============  ===================


        Historia de Modificaciones
        Fecha               Autor               Modificacion
        =========           =========           ====================
        16/10/2024          pacosta             OSF-3439: Implementar Gestión de Archivos
                                                 Actualizacion metodos:
                                                 FnGetOrders
                                                 prRevokeOTs
                                                 prSendNotification
        14/08/2024          jpinedc             OSF-3126: Se modifica prRevokeOTs
        20/06/2024          PAcosta             OSF-2845: Cambio de esquema ADM_PERSON 
        28/05/2024          jpinedc             OSF-2603: Se reemplazan LDC_ManagementEmailFNB.PROENVIARCHIVO
                                                y ldc_email.mail por
                                                pkg_Correo.prcEnviaCorreo
        17/07/2023          jcatuchemvm         OSF-1258: Ajuste por encapsulamiento de
                                                procedimiento para legalización de órdenes
                                                  [prRevokeOTs]
                                                Se actualizan llamados a métodos errors por los
                                                correspondientes en pkg_error
        10/05/2023          jcatuchemvm         OSF-1074: Se ajusta el procedimiento
                                                    [prSendNotification]
        20/08/2013          Sayra Ocoro         Creación
      ******************************************************************/

    /*****************************************************************
      Propiedad intelectual de PETI (c).

      Unidad         : FnGetOrders
      Descripcion    : Función para consultar las órdenes de un tipo de trabajo parametrizado,
                       ciclo de facturación, fecha de registro, fecha de asignación o id especófico
      Autor          : Sayra Ocoro
      Fecha          : 20/08/2013

      Parametros              Descripcion
      ============         ===================

      Fecha             Autor             Modificacion
      =========       =========           ====================
      ******************************************************************/
    FUNCTION FnGetOrders
        RETURN constants_per.tyrefcursor;

    /*****************************************************************
      Propiedad intelectual de PETI (c).

      Unidad         : prRevokeOTs
      Descripcion    : Procedimiento para anular ots de trabajo de manera masiva utilizando API.
      Autor          : Sayra Ocoro
      Fecha          : 20/08/2013

      Parametros              Descripcion
      ============         ===================

      Fecha             Autor             Modificacion
      =========       =========           ====================
      ******************************************************************/
    PROCEDURE prRevokeOTs (inuIdOrder        IN     or_order.order_id%TYPE,
                           inuCurrent        IN     NUMBER,
                           inuTotal          IN     NUMBER,
                           onuErrorCode         OUT NUMBER,
                           osbErrorMessage      OUT VARCHAR);

    /*****************************************************************
      Propiedad intelectual de PETI (c).

      Unidad         : prSendNotification
      Descripcion    : Procedimiento enviar notificación del proceso PAMOT.
      Autor          : Sayra Ocoro
      Fecha          : 23/08/2013

      Parametros              Descripcion
      ============         ===================

      Fecha             Autor             Modificacion
      =========       =========           ====================
      ******************************************************************/
    PROCEDURE prSendNotification (                     /*isbOrders varchar2,*/
                                  isbOption VARCHAR2, isbRecipients VARCHAR2);

    /*Función que devuelve la versión del pkg*/
    FUNCTION fsbVersion
        RETURN VARCHAR2;

    /*****************************************************************
      Propiedad intelectual de PETI (c).

      Unidad         : prValidatePAMOT
      Descripcion    : Procedimiento para validar los datos ingresados en la forma PAMOT.
      Autor          : Sayra Ocoro
      Fecha          : 09/05/2014

      Parametros              Descripcion
      ============         ===================

      Fecha             Autor             Modificacion
      =========       =========           ====================
      ******************************************************************/
    PROCEDURE prValidatePAMOT;
END ldc_bcRevokeOts;
/

CREATE OR REPLACE PACKAGE BODY adm_person.ldc_bcRevokeOts
IS

    csbSP_NAME		CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT||'.';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
    
    CSBVERSION   CONSTANT VARCHAR2 (40) := 'OSF-3126';

    cnuNULL_ATTRIBUTE   CONSTANT NUMBER := 2126;
    

    sbRemitente     ld_parameter.value_chain%TYPE:= pkg_BCLD_Parameter.fsbObtieneValorCadena('LDC_SMTP_SENDER');
 
    /*****************************************************************
        Propiedad intelectual de PETI (c).

        Unidad         : ldc_bcRevokeOts
        Descripcion    : Paquete donde se implementa la lógica para la anulación de ots.
        Autor          : Sayra Ocoro
        Fecha          : 20/08/2013

        Metodos

        Nombre         :
        Parametros         Descripcion
        ============  ===================


        Historia de Modificaciones
        Fecha             Autor             Modificacion
        =========         =========         ====================
        16/10/2024          pacosta         OSF-3439: Implementar Gestión de Archivos
                                             Actualizacion metodos:
                                             FnGetOrders
                                             prRevokeOTs
                                             prSendNotification
        10-12-2013        Sayra Ocoró       Se modifican los métodos prRevokeOTs y prSendNotification
                                            para solucionar la NC 2116
      ******************************************************************/

    /*****************************************************************
      Propiedad intelectual de PETI (c).

      Unidad         : FnGetOrders
      Descripcion    : Función para consultar las órdenes de un tipo de trabajo parametrizado,
                       ciclo de facturación, fecha de registro, fecha de asignación o id específico
      Autor          : Sayra Ocoro
      Fecha          : 20/08/2013

      Parametros              Descripcion
      ============         ===================

      Fecha             Autor             Modificacion
      =========       =========           ====================
      16/10/2024      pacosta             OSF-3439: Implementar Gestión de Archivos
                                           Se reemplaza PKCONSTANTE.TYREFCURSOR por CONSTANTS_PER.TYREFCURSOR
                                           Se reemplaza LDC_BOUTILITIES.SPLITSTRINGS por REGEXP_SUBSTR
                                           Se reemplaza UT_DATE.FSBDATE_FORMAT por LDC_BOCONSGENERALES.FSBGETFORMATOFECHA
      
      ******************************************************************/
    FUNCTION FnGetOrders
        RETURN constants_per.tyrefcursor
    IS

        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'FnGetOrders';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    
        sbMESSAGE                    ge_boInstanceControl.stysbValue;
        sbTASK_TYPE_ID               ge_boInstanceControl.stysbValue;
        sbCICLCODI                   ge_boInstanceControl.stysbValue;
        sbCREATED_DATE               ge_boInstanceControl.stysbValue;
        sbASSIGNED_DATE              ge_boInstanceControl.stysbValue;
        sbORDER_ID                   ge_boInstanceControl.stysbValue;
        sbCAUSAL_ID                  ge_boInstanceControl.stysbValue;
        sbOPERATING_UNIT_ID          ge_boInstanceControl.stysbValue;
        sbPERSON_ID                  ge_boInstanceControl.stysbValue;
        sbE_MAIL                     ge_boInstanceControl.stysbValue;

        rfCursor                     constants_per.tyrefcursor;
        sbStatus                     VARCHAR2 (3);
        sbQuery                      VARCHAR2 (32767);

        sbSeparador                  ld_parameter.value_chain%TYPE
            := pkg_BCLD_Parameter.fsbObtieneValorCadena ('LDC_SEPARADOR_PAMOT');
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
        
        sbMESSAGE :=
            ge_boInstanceControl.fsbGetFieldValue ('GE_TMP_MESSAGE_PROC',
                                                   'MESSAGE');
        sbTASK_TYPE_ID :=
            ge_boInstanceControl.fsbGetFieldValue ('OR_TASK_TYPE',
                                                   'TASK_TYPE_ID');
        sbCICLCODI :=
            ge_boInstanceControl.fsbGetFieldValue ('CICLO', 'CICLCODI');
        sbCREATED_DATE :=
            ge_boInstanceControl.fsbGetFieldValue ('OR_ORDER',
                                                   'CREATED_DATE');
        sbASSIGNED_DATE :=
            ge_boInstanceControl.fsbGetFieldValue ('OR_ORDER',
                                                   'ASSIGNED_DATE');
        sbORDER_ID :=
            ge_boInstanceControl.fsbGetFieldValue ('OR_ORDER_COMMENT',
                                                   'ORDER_COMMENT');
        sbCAUSAL_ID :=
            ge_boInstanceControl.fsbGetFieldValue ('GE_CAUSAL', 'CAUSAL_ID');
        sbOPERATING_UNIT_ID :=
            ge_boInstanceControl.fsbGetFieldValue ('OR_OPERATING_UNIT',
                                                   'OPERATING_UNIT_ID');
        sbPERSON_ID :=
            ge_boInstanceControl.fsbGetFieldValue ('OR_OPER_UNIT_PERSONS',
                                                   'PERSON_ID');
        sbE_MAIL :=
            ge_boInstanceControl.fsbGetFieldValue ('GE_PERSON', 'E_MAIL');


        pkg_Traza.Trace ('sbORDER_ID 2: ' || sbORDER_ID, 15);

        ------------------------------------------------
        -- Required Attributes
        ------------------------------------------------

        IF (sbMESSAGE IS NULL)
        THEN
            Pkg_Error.setErrorMessage (cnuNULL_ATTRIBUTE, 'Opción');
        END IF;

        IF (sbTASK_TYPE_ID IS NULL)
        THEN
            Pkg_Error.setErrorMessage (cnuNULL_ATTRIBUTE, 'Tipo de Trabajo');
        END IF;

        IF (sbCAUSAL_ID IS NULL)
        THEN
            Pkg_Error.setErrorMessage (cnuNULL_ATTRIBUTE, 'Causal');
        END IF;

        --Validar dirección de correo
        IF (sbE_MAIL IS NOT NULL)
        THEN
            IF NOT (ut_mail.fblValidateMail (sbE_MAIL))
            THEN
                Pkg_Error.setErrorMessage (
                    isbMsgErrr   =>
                        'La Dirección Electrónica ingresada no es valida');
            END IF;
        END IF;



        ------------------------------------------------
        -- User code
        ------------------------------------------------
        IF sbMESSAGE = 'ANULAR'
        THEN
            sbStatus := '0,5';
        ELSE
            pkg_Traza.Trace ('sbMESSAGE => ' || sbMESSAGE, 11);
            pkg_Traza.Trace ('sbOPERATING_UNIT_ID => ' || sbOPERATING_UNIT_ID,
                            11);

            --Validar que la Unidad Operativa no sea nula
            IF (sbOPERATING_UNIT_ID IS NULL)
            THEN
                Pkg_Error.setErrorMessage (cnuNULL_ATTRIBUTE,
                                           'Unidad de Trabajo');
            END IF;

            --Validar que la Persona de laUnidad Operativa no sea nula
            IF (sbPERSON_ID IS NULL)
            THEN
                Pkg_Error.setErrorMessage (cnuNULL_ATTRIBUTE,
                                           'Personal de la U. Trabajo');
            END IF;

            sbStatus := '5';
        END IF;

        sbQuery :=
               'select distinct or_order.order_id ID_ORDEN,
                order_status_id||'' - ''||daor_order_status.fsbgetdescription(order_status_id) ESTADO,
                or_order.task_type_id||'' - ''||daor_task_type.fsbgetdescription(or_order.task_type_id) TIPO_DE_TRABAJO,
                CREATED_DATE FECHA_REGISTRO, ASSIGNED_DATE FECHA_ASIGNACION
                from or_order, or_order_activity, suscripc where or_order_activity.subscription_id = suscripc.SUSCCODI and order_status_id in  (SELECT TO_NUMBER(COLUMN_VALUE) FROM TABLE(REGEXP_SUBSTR('''
            || sbStatus
            || ''','',''))) and or_order_activity.order_id = or_order.order_id and or_order.task_type_id = to_number('''
            || sbTASK_TYPE_ID
            || ''')';
        pkg_Traza.Trace (
               'Ejecución ldc_bcRevokeOts.FnGetOrders sbQuery Inicial => '
            || sbQuery,
            11);

        IF (sbCICLCODI IS NOT NULL)
        THEN
            sbQuery :=
                   sbQuery
                || ' and suscripc.SUSCCICL = to_number('''
                || sbCICLCODI
                || ''')';
        END IF;

        IF (sbCREATED_DATE IS NOT NULL)
        THEN
            sbQuery :=
                   sbQuery
                || ' and or_order.created_date <= to_date('''
                || sbCREATED_DATE
                || ''', LDC_BOCONSGENERALES.FSBGETFORMATOFECHA)';
        END IF;

        IF (sbASSIGNED_DATE IS NOT NULL)
        THEN
            sbQuery :=
                   sbQuery
                || ' and nvl(or_order.ASSIGNED_DATE,sysdate) <= to_date('''
                || sbASSIGNED_DATE
                || ''', LDC_BOCONSGENERALES.FSBGETFORMATOFECHA)';
        END IF;

        IF (sbORDER_ID IS NOT NULL)
        THEN
            sbQuery :=
                   sbQuery
                || ' and or_order.order_id IN (SELECT TO_NUMBER(COLUMN_VALUE) FROM TABLE(REGEXP_SUBSTR('''
                || sbORDER_ID
                || ''','''
                || sbSeparador
                || ''')))';
        END IF;

        pkg_Traza.Trace (
               'Ejecución ldc_bcRevokeOts.FnGetOrders sbQuery Final => '
            || sbQuery,
            11);


        OPEN rfCursor FOR sbQuery;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 
        
        RETURN rfCursor;
    EXCEPTION
        WHEN NO_DATA_FOUND
        THEN
            IF rfCursor%ISOPEN
            THEN
                CLOSE rfCursor;
            END IF;

            RAISE Pkg_Error.CONTROLLED_ERROR;
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
    END FnGetOrders;

    /*****************************************************************
      Propiedad intelectual de PETI (c).

      Unidad         : prRevokeOTs
      Descripcion    : Procedimiento para anular ots de trabajo de manera masiva utilizando API.
      Autor          : Sayra Ocoro
      Fecha          : 20/08/2013

      Parametros              Descripcion
      ============         ===================

      Fecha             Autor             Modificacion
      =========       =========           ====================
      09-12-2013      Sayra Ocoró         * Se modifica el método como  se almacenan los identificadores de las ordenes para enviar
                                            posteriormente las notificaciones.
                                          * LDC_LOG_PAMOT
      22-02-2014      Sayra Ocoro         * Aranda 2842: 1. Se debe modificar la logica del procedimiento LDC_BCREVOKEOTS prRevokeOTs
                                            para que en el caso de seleccionar la anulacion de los tipos de trabajo listados en la
                                            tabla, surta el mismo efecto que la legalizacion con causal de fallo.
      07-04-2014      Sayra Ocoro         * Aranda 3330: Se modifica para cubrir los casos en los que las ordenes de cartera que se
                                            crean a partir de una regeneracion.
      17/07/2023      jcatuchemvm         * OSF-1258: Actualización llamado OS_LEGALIZEORDERS por API_LEGALIZEORDERS,
                                            or_boanullorder.anullorderwithoutval por api_anullorder,
      14/0/2024       jpinedc             * OSF-3126: Se reemplaza truncate por 
                                            pkg_truncate_tablas_open.prcldc_log_pamot
      16/10/2024      pacosta             * OSF-3439: Implementar Gestión de Archivos   
                                            Cambio dage_causal.fnugetclass_causal_id por pkg_bcordenes.fnuobtieneclasecausal    
                                            Cambio daor_order.fnugettask_type_id por pkg_bcordenes.fnuobtienetipotrabajo
                                            cambio daor_order.updcausal_id por pkg_or_order.prc_actualizacausalorden
      ******************************************************************/
    PROCEDURE prRevokeOTs (inuIdOrder        IN     or_order.order_id%TYPE,
                           inuCurrent        IN     NUMBER,
                           inuTotal          IN     NUMBER,
                           onuErrorCode         OUT NUMBER,
                           osbErrorMessage      OUT VARCHAR)
    IS

        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prRevokeOTs';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        
        sbMESSAGE                    ge_boInstanceControl.stysbValue;
        sbCAUSAL_ID                  ge_boInstanceControl.stysbValue;
        sbDESCRIPTION                ge_boInstanceControl.stysbValue;
        sbOPERATING_UNIT_ID          ge_boInstanceControl.stysbValue;
        sbPERSON_ID                  ge_boInstanceControl.stysbValue;
        sbE_MAIL                     ge_boInstanceControl.stysbValue;

        idtExeInitialDate            DATE := SYSDATE;
        idtExeFinalDate              DATE := SYSDATE;
        idtChangeDate                DATE := SYSDATE;
        nuOrderActivityId            or_order_activity.order_activity_id%TYPE;
        ISBDATAORDER                 VARCHAR2 (2000);
        nuCant                       NUMBER;
        sbQuery                      VARCHAR2 (2000);
        isbTaskTypeIds               VARCHAR2 (2000);

        nuBeforeState                servsusc.sesuesco%TYPE;
        nuProductId                  servsusc.sesunuse%TYPE;

        ---Cursor para obtener el estado de corte anterior asociado al producto
        CURSOR cuBeforeStatus (inuProductId servsusc.sesunuse%TYPE)
        IS
            SELECT HCECECAN
              FROM hicaesco
             WHERE     hcecnuse = inuProductId
                   AND hcecfech = (SELECT MAX (hcecfech)
                                     FROM hicaesco
                                    WHERE hcecnuse = inuProductId);
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO); 
            
        pkg_Traza.Trace ('inuIdOrder => ' || inuIdOrder, csbNivelTraza);
        
        sbMESSAGE :=
            ge_boInstanceControl.fsbGetFieldValue ('GE_TMP_MESSAGE_PROC',
                                                   'MESSAGE');
        sbCAUSAL_ID :=
            ge_boInstanceControl.fsbGetFieldValue ('GE_CAUSAL', 'CAUSAL_ID');
        sbDESCRIPTION :=
            ge_boInstanceControl.fsbGetFieldValue ('GE_MESSAGE',
                                                   'DESCRIPTION');
        sbOPERATING_UNIT_ID :=
            ge_boInstanceControl.fsbGetFieldValue ('OR_OPERATING_UNIT',
                                                   'OPERATING_UNIT_ID');
        sbPERSON_ID :=
            ge_boInstanceControl.fsbGetFieldValue ('OR_OPER_UNIT_PERSONS',
                                                   'PERSON_ID');
        sbE_MAIL :=
            ge_boInstanceControl.fsbGetFieldValue ('GE_PERSON', 'E_MAIL');

        ------------------------------------------------
        -- Required Attributes
        ------------------------------------------------

        IF (sbMESSAGE IS NULL)
        THEN
            Pkg_Error.setErrorMessage (cnuNULL_ATTRIBUTE, 'Opción');
        END IF;

        IF (sbCAUSAL_ID IS NULL)
        THEN
            Pkg_Error.setErrorMessage (cnuNULL_ATTRIBUTE, 'Causal');
        END IF;

        --Validar dirección de correo
        IF (sbE_MAIL IS NOT NULL)
        THEN
            IF NOT (ut_mail.fblValidateMail (sbE_MAIL))
            THEN
                Pkg_Error.setErrorMessage (
                    isbMsgErrr   =>
                        'La Dirección Electrónica ingresada no es valida');
            END IF;
        END IF;

        IF sbMESSAGE = 'LEGALIZAR'
        THEN
            --Validar que la Unidad Operativa no sea nula
            IF (sbOPERATING_UNIT_ID IS NULL)
            THEN
                Pkg_Error.setErrorMessage (cnuNULL_ATTRIBUTE,
                                           'Unidad de Trabajo');
            END IF;

            --Validar que la Persona de laUnidad Operativa no sea nula
            IF (sbPERSON_ID IS NULL)
            THEN
                Pkg_Error.setErrorMessage (cnuNULL_ATTRIBUTE,
                                           'Personal de la U. Trabajo');
            END IF;
        END IF;

        IF sbMESSAGE = 'ANULAR'
        THEN
            --Anular OT
            api_anullorder (inuIdOrder,
                            NULL,
                            NULL,
                            onuErrorCode,
                            osbErrorMessage);

            IF onuErrorCode != 0
            THEN
                RAISE Pkg_Error.CONTROLLED_ERROR;
            END IF;

            -- Actualiza la causal escogida
            PKG_OR_ORDER.PRC_ACTUALIZACAUSALORDEN (inuIdOrder, TO_NUMBER (sbCAUSAL_ID),onuErrorCode, osbErrorMessage);
            --Aranda 2842: validar si los tipos de trabajo corresponden a Suspension o Reconexion
            --1. Validar tipo de trabajo

            isbTaskTypeIds :=
                pkg_BCLD_Parameter.fsbObtieneValorCadena ('IDS_TT_SUSP_RECX');

            IF INSTR (isbTaskTypeIds,
                      TO_CHAR (PKG_BCORDENES.FNUOBTIENETIPOTRABAJO (inuIdOrder))) >
               0
            THEN
                Pkg_Error.setapplication ('PAMOT');
                --Aranda 3330:
                --1. Obtener identificador del producto
                nuProductId :=
                    TO_NUMBER (LDC_BOUTILITIES.fsbGetValorCampoTabla (
                                   'or_order_activity',
                                   'order_id',
                                   'product_id',
                                   inuIdOrder));
                pkg_Traza.Trace (
                       'Ejecucion ldc_bcRevokeOts.prRevokeOTs nuProductId => '
                    || nuProductId,
                    10);

                --2. Actualizar suspcone.sucofeat y suspcone.SUCOTIPO
                UPDATE suspcone
                   SET sucofeat = SYSDATE, SUCOTIPO = 'A'
                 WHERE SUCONUSE = nuProductId AND sucofeat IS NULL;

                --3. Actualizar el estado de corte del producto servsusc.sesuesco
                IF nuProductId <> -1
                THEN
                    nuBeforeState := NULL;

                    OPEN cuBeforeStatus (nuProductId);

                    FETCH cuBeforeStatus INTO nuBeforeState;

                    CLOSE cuBeforeStatus;

                    pkg_Traza.Trace (
                           'Ejecucion ldc_bcRevokeOts.prRevokeOTs nuBeforeState => '
                        || nuBeforeState,
                        10);

                    IF nuBeforeState IS NOT NULL
                    THEN
                        UPDATE servsusc
                           SET sesuesco = nuBeforeState
                         WHERE sesunuse = nuProductId;

                        pkg_Traza.Trace ('Update Finalizado', 10);
                        NULL;
                    END IF;
                END IF;
            END IF;

            INSERT INTO ldc_log_pamot (order_id)
                 VALUES (inuIdOrder);

            COMMIT;
        ELSE
            --Legalizar Ots
            nuOrderActivityId :=
                TO_NUMBER (LDC_BOUTILITIES.fsbGetValorCampoTabla (
                               'or_order_activity',
                               'order_id',
                               'order_activity_id',
                               inuIdOrder));

            IF nuOrderActivityId IS NULL OR nuOrderActivityId = -1
            THEN
                Pkg_Error.setErrorMessage (
                    isbMsgErrr   =>
                           'No se generó un registro de órden por actividad para la orden: '
                        || inuIdOrder);
            END IF;

            --Definir cantidad
            IF PKG_BCORDENES.FNUOBTIENECLASECAUSAL (TO_NUMBER (sbCAUSAL_ID)) = 2 THEN
                IF PKG_BCORDENES.FNUOBTIENECLASECAUSAL (TO_NUMBER (sbCAUSAL_ID)) = 1 THEN
                    nuCant := 1;
                ELSE
                    nuCant := 0;
                END IF;
            END IF;

            pkg_Traza.Trace (
                   'Ejecución ldc_bcRevokeOts.prRevokeOTs ISBDATAORDER => '
                || ISBDATAORDER,
                11);
            ISBDATAORDER :=
                   inuIdOrder
                || '|'
                || TO_NUMBER (sbCAUSAL_ID)
                || '|'
                || TO_NUMBER (sbPERSON_ID)
                || '||'
                || nuOrderActivityId
                || '>'
                || nuCant
                || ';READING>>>;COMMENT1>>>;COMMENT2>>>;COMMENT3>>>|||1277;'
                || sbDESCRIPTION;
            pkg_Traza.Trace (
                   'Ejecución ldc_bcRevokeOts.prRevokeOTs ISBDATAORDER => '
                || ISBDATAORDER,
                11);
            api_legalizeorders (ISBDATAORDER,
                                idtExeInitialDate,
                                idtExeFinalDate,
                                idtChangeDate,
                                onuErrorCode,
                                osbErrorMessage);

            IF (onuErrorCode <> 0)
            THEN
                ROLLBACK;
                RAISE Pkg_Error.CONTROLLED_ERROR;
            ELSE
                INSERT INTO ldc_log_pamot (order_id)
                     VALUES (inuIdOrder);

                COMMIT;
            END IF;
        END IF;

        --Validar si se procesaron todos los registros para enviar notificación
        IF inuCurrent = inuTotal
        THEN
            IF sbE_MAIL IS NOT NULL
            THEN
                prSendNotification (                           /*sbOrdersId,*/
                                    sbMESSAGE, sbE_MAIL);
            ELSE
                pkg_truncate_tablas_open.prcldc_log_pamot;
            END IF;
        END IF;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 
        
    EXCEPTION
        WHEN Pkg_Error.CONTROLLED_ERROR
        THEN
            ROLLBACK;
            RAISE;
        WHEN OTHERS
        THEN
            ROLLBACK;
            onuErrorCode := Ld_Boconstans.cnuGeneric_Error;
            osbErrorMessage :=
                   'No fue posible '
                || sbMESSAGE
                || ' las ordenes de trabajo.'
                || SQLERRM;
            RAISE;
    END prRevokeOTs;

    /*****************************************************************
      Propiedad intelectual de PETI (c).

      Unidad         : prSendNotification
      Descripcion    : Procedimiento enviar notificación del proceso PAMOT.
      Autor          : Sayra Ocoro
      Fecha          : 23/08/2013

      Parametros              Descripcion
      ============         ===================

      Fecha             Autor               Modificacion
      =========       =========             ====================
      10-12-2013    Sayra Ocoró             * Se modifica el método para solucionaar la NC 2116
      10-09-2014    Alexandra Gordillo      Se modifica la notificacion para envio del archivo RQ 1203
                                            Si se presenta error en el envio por el tamaño del archivo,
                                            se envia un mensaje de notificacion para que
                                            se verifique el archivo en el servidor
      10/05/2023    jcatuchemvm             OSF-1074: Se ajusta el nombre del archivo PAMOT, añadiendo la hora de generación para evitar
                                            que en multiples ejecuciones PAMOT para el mismo día se sobrescriba el archivo, en especial
                                            cuando el archivo supera los 30001 registros ya que la notificación indicaría que el archivo
                                            se debe consultar en el servidor y este podría haber sido sobrescrito
                                            Se corrige escritura del archivo html dado que no se consideraba la fecha de legalización y
                                            para el estado de la orden, no se escribía correctamente el codigo del estado
                                            Se añade ademas, información de la unidad operativa asociada a la orden en el html.
                                            Se ajusta asunto del correo para indicar la BD desde donde se genera la notificación.
      16/10/2024    pacosta                 OSF-3439: Implementar Gestión de Archivos                                              
                                             Cambio daor_operating_unit.fsbgetname por pkg_bcunidadoperativa.fsbgetnombre
      ******************************************************************/
    PROCEDURE prSendNotification (                     /*isbOrders varchar2,*/
                                  isbOption VARCHAR2, isbRecipients VARCHAR2)
    IS

        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prSendNotification';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);    
    
        nuTotal                NUMBER := 0;
        sbMessage1             VARCHAR2 (30000);
        sbMessage0             VARCHAR2 (30000);
        sbSubject              VARCHAR2 (2000);

        CURSOR cuOrders IS
            SELECT or_order.order_id
                       ID_ORDEN,
                      order_status_id
                   || ' - '
                   || daor_order_status.fsbgetdescription (order_status_id)
                       ESTADO,
                   or_order.task_type_id
                       TIPO_DE_TRABAJO,
                   CREATED_DATE
                       FECHA_REGISTRO,
                   NVL (or_order.legalization_date, SYSDATE)
                       FECHA_LEGALIZACION,
                   CASE
                       WHEN or_order.operating_unit_id IS NULL
                       THEN
                           '-'
                       ELSE
                              or_order.operating_unit_id
                           || ' - '
                           || pkg_bcunidadoperativa.fsbgetnombre (
                                  or_order.operating_unit_id)
                   END
                       UNIDAD
              FROM or_order, ldc_log_pamot
             WHERE or_order.order_id = ldc_log_pamot.order_id;

        SBRUTA_LOG_ARCH_RECA   VARCHAR2 (2000);
        sbfilename             VARCHAR2 (4000);
        temp_file              pkg_gestionArchivos.styArchivo;

    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO); 
            
        --Modificación 10-12-2013
        SBRUTA_LOG_ARCH_RECA :=
            pkg_BCLD_Parameter.fsbObtieneValorCadena ('RUTA_LOG_ARCH_RECA');
        sbfilename :=
               'PAMOT_'
            || isbOption
            || TO_CHAR (SYSDATE, 'DD-MM-YYYY_HH24MISS')
            || '.html';
        temp_file := pkg_gestionArchivos.ftAbrirArchivo_SMF (SBRUTA_LOG_ARCH_RECA, sbfilename, 'w');


        sbMessage0 :=
               'Senor usuario, durante la ejecucion del proceso PAMOT (LDC - Anulacion | Legalizacion Masiva de ordenes de Trabajo) se procesaron las ordenes de trabajo del archivo adjunto '
            || sbfilename
            || CHR (10)
            || CHR (13);
        sbMessage1 :=
               '<html><body><table BORDER="1"> <tr BGCOLOR="gray"> <th>'
            || RPAD ('ORDEN', 20, ' ')
            || '</th> <th>'
            || RPAD ('ESTADO', 20, ' ')
            || '</th> <th>'
            || RPAD ('TIPO DE TRABAJO', 40, ' ')
            || '</th> <th>'
            || RPAD ('FECHA DE REGISTRO', 30, ' ')
            || '</th> <th>'
            || --rpad('OBSERVACION',80, ' ') || '</th> <th>' ||
               RPAD ('FECHA DE CAMBIO DE ESTADO', 30, ' ')
            || '</th> <th>'
            || RPAD ('UNIDAD OPERATIVA ORDEN', 50, ' ')
            || '</th> </tr>';
        pkg_gestionArchivos.prcEscribirLinea_SMF (temp_file, sbMessage1);

        --Fin Modificación 10-12-2013
        FOR rgOrder IN cuOrders
        LOOP
            sbMessage1 :=
                   '<tr> <td>'
                || RPAD (rgOrder.ID_ORDEN, 20, ' ')
                || '</td> <td>'
                || RPAD (rgOrder.ESTADO, 20, ' ')
                || '</td> <td>'
                || RPAD (rgOrder.TIPO_DE_TRABAJO, 40, ' ')
                || '</td> <td>'
                || RPAD (rgOrder.FECHA_REGISTRO, 30, ' ')
                || '</td> <td>'
                || RPAD (rgOrder.FECHA_LEGALIZACION, 30, ' ')
                || '</td> <td>'
                || RPAD (rgOrder.UNIDAD, 50, ' ')
                || '</td> </tr>';

            pkg_gestionArchivos.prcEscribirLinea_SMF (temp_file, sbMessage1);
            nuTotal := nuTotal + 1;
        END LOOP;

        sbMessage1 :=
               '<tr> <td>'
            || RPAD ('TOTAL ', 20, ' ')
            || '</td> <td>'
            || RPAD (nuTotal, 20, ' ')
            || '</td> <tr>';

        pkg_gestionArchivos.prcEscribirLinea_SMF (temp_file, sbMessage1);
        sbMessage1 := '</table></body></html>';
        pkg_gestionArchivos.prcEscribirLinea_SMF (temp_file, sbMessage1);
        pkg_gestionArchivos.prcCerrarArchivo_SMF (temp_file);

        sbSubject := 'PAMOT - '
            || isbOption
            || ' ORDENES DE TRABAJO DE MANERA MASIVA '
            || SYSDATE;

        -- Si los registros son menores a 30mil se envia archivo, si no se debe de consultar en el servidor
        IF (nuTotal < 30001)
        THEN

            pkg_Correo.prcEnviaCorreo
            (
                isbRemitente        => sbRemitente,
                isbDestinatarios    => isbRecipients,
                isbAsunto           => sbSubject,
                isbMensaje          => sbMessage0,
                isbArchivos         => SBRUTA_LOG_ARCH_RECA || '/' || sbfilename
            ); 

        ELSE
            sbSubject := 'PROCESO DE ANULACION/LEGALIZACION MASIVA DE ORDENES '
                || SYSDATE;
            sbMessage0 :=
                   'No se puede enviar el adjunto por el tamaño del archivo.
                                 La cantidad de registros procesados para la opcion de '
                || isbOption
                || ' fueron '
                || nuTotal
                || '. Por favor contacte al Administrador
                                para verificar en la ruta ['
                || SBRUTA_LOG_ARCH_RECA
                || '] el archivo ['
                || sbfilename
                || '].';

            pkg_Correo.prcEnviaCorreo
            (
                isbRemitente        => sbRemitente,
                isbDestinatarios    => isbRecipients,
                isbAsunto           => sbSubject,
                isbMensaje          => sbMessage0
            );   
            
        END IF;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 
        
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
    END prSendNotification;


    /*Función que devuelve la versión del pkg*/
    FUNCTION fsbVersion
        RETURN VARCHAR2
    IS
    BEGIN
        RETURN CSBVERSION;
    END FSBVERSION;


    /*****************************************************************
      Propiedad intelectual de PETI (c).

      Unidad         : prValidatePAMOT
      Descripcion    : Procedimiento para validar los datos ingresados en la forma PAMOT.
      Autor          : Sayra Ocoro
      Fecha          : 09/05/2014

      Parametros              Descripcion
      ============         ===================

      Fecha             Autor             Modificacion
      =========       =========           ====================
      ******************************************************************/
    PROCEDURE prValidatePAMOT
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prValidatePAMOT';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);  
        
        sbMESSAGE                    ge_boInstanceControl.stysbValue;
        sbTASK_TYPE_ID               ge_boInstanceControl.stysbValue;
        sbCICLCODI                   ge_boInstanceControl.stysbValue;
        sbCREATED_DATE               ge_boInstanceControl.stysbValue;
        sbASSIGNED_DATE              ge_boInstanceControl.stysbValue;
        sbCAUSAL_ID                  ge_boInstanceControl.stysbValue;
        sbDESCRIPTION                ge_boInstanceControl.stysbValue;
        sbOPERATING_UNIT_ID          ge_boInstanceControl.stysbValue;
        sbPERSON_ID                  ge_boInstanceControl.stysbValue;
        sbE_MAIL                     ge_boInstanceControl.stysbValue;
        sbORDER_ID                   ge_boInstanceControl.stysbValue;
        sbALLOW_UPDATE               ge_boInstanceControl.stysbValue;

        sbStatus                     VARCHAR2 (3);

    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO); 
        
        sbMESSAGE :=
            ge_boInstanceControl.fsbGetFieldValue ('GE_TMP_MESSAGE_PROC',
                                                   'MESSAGE');
        sbTASK_TYPE_ID :=
            ge_boInstanceControl.fsbGetFieldValue ('OR_TASK_TYPE',
                                                   'TASK_TYPE_ID');
        sbCICLCODI :=
            ge_boInstanceControl.fsbGetFieldValue ('CICLO', 'CICLCODI');
        sbCREATED_DATE :=
            ge_boInstanceControl.fsbGetFieldValue ('OR_ORDER',
                                                   'CREATED_DATE');
        sbASSIGNED_DATE :=
            ge_boInstanceControl.fsbGetFieldValue ('OR_ORDER',
                                                   'ASSIGNED_DATE');
        sbORDER_ID :=
            ge_boInstanceControl.fsbGetFieldValue ('OR_ORDER_COMMENT',
                                                   'ORDER_COMMENT');
        sbCAUSAL_ID :=
            ge_boInstanceControl.fsbGetFieldValue ('GE_CAUSAL', 'CAUSAL_ID');
        sbDESCRIPTION :=
            ge_boInstanceControl.fsbGetFieldValue ('GE_MESSAGE',
                                                   'DESCRIPTION');
        sbOPERATING_UNIT_ID :=
            ge_boInstanceControl.fsbGetFieldValue ('OR_OPERATING_UNIT',
                                                   'OPERATING_UNIT_ID');
        sbPERSON_ID :=
            ge_boInstanceControl.fsbGetFieldValue ('OR_OPER_UNIT_PERSONS',
                                                   'PERSON_ID');
        sbE_MAIL :=
            ge_boInstanceControl.fsbGetFieldValue ('GE_PERSON', 'E_MAIL');
        sbALLOW_UPDATE :=
            ge_boInstanceControl.fsbGetFieldValue ('GE_CAUSAL',
                                                   'ALLOW_UPDATE');

        pkg_Traza.Trace ('sbORDER_ID 2: ' || sbORDER_ID, 15);

        ------------------------------------------------
        -- Required Attributes
        ------------------------------------------------

        IF (sbMESSAGE IS NULL)
        THEN
            Pkg_Error.setErrorMessage (cnuNULL_ATTRIBUTE, 'Opción');
        END IF;

        IF (sbTASK_TYPE_ID IS NULL)
        THEN
            Pkg_Error.setErrorMessage (cnuNULL_ATTRIBUTE, 'Tipo de Trabajo');

            IF (sbCAUSAL_ID IS NULL)
            THEN
                RAISE Pkg_Error.CONTROLLED_ERROR;
            END IF;

            Pkg_Error.setErrorMessage (cnuNULL_ATTRIBUTE, 'Causal');
        END IF;

        IF (sbALLOW_UPDATE IS NULL)
        THEN
            Pkg_Error.setErrorMessage (cnuNULL_ATTRIBUTE, 'Envia Correo?');
        END IF;

        --Validar dirección de correo
        IF (sbE_MAIL IS NOT NULL)
        THEN
            IF NOT (ut_mail.fblValidateMail (sbE_MAIL))
            THEN
                Pkg_Error.setErrorMessage (
                    isbMsgErrr   =>
                        'La Dirección Electrónica ingresada no es valida');
            END IF;
        END IF;

        IF (sbALLOW_UPDATE = 'Y' AND sbE_MAIL IS NULL)
        THEN
            Pkg_Error.setErrorMessage (cnuNULL_ATTRIBUTE,
                                       'Direccion Electronica');
        END IF;

        IF sbMESSAGE = 'LEGALIZAR'
        THEN
            --Validar que la Unidad Operativa no sea nula
            IF (sbOPERATING_UNIT_ID IS NULL)
            THEN
                Pkg_Error.setErrorMessage (cnuNULL_ATTRIBUTE,
                                           'Unidad de Trabajo');
            END IF;

            --Validar que la Persona de laUnidad Operativa no sea nula
            IF (sbPERSON_ID IS NULL)
            THEN
                Pkg_Error.setErrorMessage (cnuNULL_ATTRIBUTE,
                                           'Personal de la U. Trabajo');
            END IF;
        END IF;

        ------------------------------------------------
        -- User code
        ------------------------------------------------


        IF sbMESSAGE = 'ANULAR'
        THEN
            sbStatus := '0,5';
        ELSE
            pkg_Traza.Trace ('sbMESSAGE => ' || sbMESSAGE, 11);
            pkg_Traza.Trace ('sbOPERATING_UNIT_ID => ' || sbOPERATING_UNIT_ID,
                            11);

            --Validar que la Unidad Operativa no sea nula
            IF (sbOPERATING_UNIT_ID IS NULL)
            THEN
                Pkg_Error.setErrorMessage (cnuNULL_ATTRIBUTE,
                                           'Unidad de Trabajo');
            END IF;

            --Validar que la Persona de laUnidad Operativa no sea nula
            IF (sbPERSON_ID IS NULL)
            THEN
                Pkg_Error.setErrorMessage (cnuNULL_ATTRIBUTE,
                                           'Personal de la U. Trabajo');
            END IF;

            sbStatus := '5';
        END IF;
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 
        
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
    END prValidatePAMOT;
END ldc_bcRevokeOts;
/

PROMPT Otorgando permisos de ejecucion a LDC_BCREVOKEOTS
BEGIN
    pkg_utilidades.praplicarpermisos('LDC_BCREVOKEOTS', 'ADM_PERSON');
END;
/

