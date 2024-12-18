CREATE OR REPLACE PROCEDURE adm_person.ldc_proccontdocuvent ( inuasig_subsidy_id IN VARCHAR2,
                                                   onuErrorCode       OUT NUMBER,
                                                   osbErrorMessage    OUT VARCHAR2) IS
  /**************************************************************************
        Autor       : Luis Javier Lopez Barrios / Horbath
        Fecha       : 2018-05-11
        Ticket      : 200-1901
        Descripcion : proceso para legalizar las ordenes de control de datos y documentacion de venta

        Parametros Entrada
        inuasig_subsidy_id   id del subsidio asigando

        Valor de salida
        onuErrorCode    codigo de error
        osbErrorMessage mensaje de error

        HISTORIA DE MODIFICACIONES
        FECHA               AUTOR              DESCRIPCION
        =========           =========          ====================
        08/05/2024          Adrianavg          OSF-2668: Se migra del esquema OPEN al esquema ADM_PERSON 
        06/11/2024          felipe.valencia    OSF-3546: Se agrega bloqueo a la tabla LD_ubication
   ***************************************************************************/
    Pragma AUTONOMOUS_TRANSACTION;

    ---parametros para valores quemados
    CURSOR cuAsigSubsidy IS
    SELECT *
    FROM   ld_asig_subsidy
    WHERE  asig_subsidy_id =
    to_number(LD_BOSUBSIDY.FsbGetString(1, inuasig_subsidy_id, '-'));

    ---parametros para valores quemados
    CURSOR cuSalesWithoutsubsidy IS
    SELECT *
    FROM   Ld_sales_withoutsubsidy
    WHERE  Sales_Withoutsubsidy_Id =
    to_number(LD_BOSUBSIDY.FsbGetString(1, inuasig_subsidy_id, '-'));

    CURSOR cuOrder(nuorder_id or_order.order_id%TYPE) IS
    SELECT * FROM or_order WHERE order_id = nuorder_id;

    CURSOR cuOrderActivity(nuorder_id   or_order.order_id%TYPE,
    nuactivityid or_order_activity.activity_id%TYPE) IS
    SELECT DISTINCT order_activity_id,
    comment_
    FROM   or_order_activity
    WHERE  order_id = nuorder_id
    AND    activity_id = nuactivityid;

    CURSOR lengthorder_activity IS
    SELECT a.DATA_LENGTH
    FROM   all_tab_columns a
    WHERE  a.TABLE_NAME = 'OR_ORDER_ACTIVITY'
    AND    a.COLUMN_NAME = 'COMMENT_';

    nuCAUSAL_ID ge_boInstanceControl.stysbValue;
    sbComment   ge_boInstanceControl.stysbValue;
    nuOrdenTrab         or_order.order_id%type;
    AsigSubsidy         cuAsigSubsidy%ROWTYPE;
    SalesWithoutsubsidy cuSalesWithoutsubsidy%ROWTYPE;
    OrderAsig           cuOrder%ROWTYPE;
    OrderActivity       cuOrderActivity%ROWTYPE;
    nuParameter         ld_parameter.numeric_value%TYPE;
    --sbParameter         ld_parameter.value_chain%type;

    nuError NUMBER;
    sbError VARCHAR2(4000);

    rcRelatedOrder daor_related_order.styOR_related_order;

    nuItems              ge_items.items_id%TYPE;
    nuMotive             mo_motive.motive_id%TYPE;
    nuAddress            mo_packages.address_id%TYPE;
    nuSubscriberId       mo_packages.Subscriber_Id%TYPE;
    nuSubscriptionPendId mo_packages.Subscription_Pend_Id%TYPE;
    rcMotive             damo_motive.styMO_motive;
    nuOrderId            or_order.order_id%TYPE;
    nuOrderActivityId    or_order_activity.order_activity_id%TYPE;

    nuOperatingUnitId or_order.operating_unit_id%TYPE;
    nuContractorID    or_operating_unit.contractor_id%TYPE;
    nuOrderId_Out     or_order.order_id%TYPE;
    sbtypesale        ld_asig_subsidy.type_subsidy%TYPE;
    nulengthcomment   NUMBER;
    --
    sbSuccessCausal ld_parameter.value_chain%TYPE;
    sbFailedCausal  ld_parameter.value_chain%TYPE;
    --
    nuasigsub   ld_asig_subsidy.asig_subsidy_id%TYPE;
    rcubication dald_ubication.styld_ubication;

    erProceso EXCEPTION;

    csbProcedimiento CONSTANT VARCHAR2(100) := $$PLSQL_UNIT;

    PROCEDURE proinserLogError (nuOrden   or_order.order_id%type,
                                sbError   VARCHAR2) IS
    /**************************************************************************
        Autor       : Luis Javier Lopez Barrios / Horbath
        Fecha       : 2018-05-11
        Ticket      : 200-1901
        Descripcion : proceso para legalizar las ordenes de control de datos y documentacion de venta

        Parametros Entrada
        nuOrden   numero de orden

        Valor de salida
         sbError mensaje de error

        HISTORIA DE MODIFICACIONES
        FECHA        AUTOR       DESCRIPCION
   ***************************************************************************/
    Pragma AUTONOMOUS_TRANSACTION;
        csbMetodo CONSTANT VARCHAR2(100) := csbProcedimiento ||'.proinserLogError';
    BEGIN
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

       INSERT INTO LDC_LOGERCODAVE ( ORDER_ID,    OBSEERROR,    FECHERROR,    USUARIO,    TERMINAL)
             VALUES ( nuOrden,    sbError,    SYSDATE,   USER,   pkg_session.fsbgetterminal );
       COMMIT;
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    EXCEPTION
      WHEN OTHERS THEN
         ROLLBACK;
    END proinserLogError;

    PROCEDURE LegAllactivities(inuOrderId        IN NUMBER,
                               inuCausalId       IN NUMBER,
                               inuPersonId       IN NUMBER,
                               idtExeInitialDate IN DATE,
                               idtExeFinalDate   IN DATE,
                               isbComment        IN VARCHAR2,
                               idtChangeDate     IN OR_order_stat_change.stat_chg_date%TYPE,
                               onuErrorCode      OUT ge_error_log.error_log_id%TYPE,
                               osbErrorMessage   OUT ge_error_log.description%TYPE) IS

        nuOrderCommentId OR_order_comment.order_comment_id%TYPE;
		nuOperUnitId  or_order.operating_unit_id%TYPE;

        csbMetodo CONSTANT VARCHAR2(100) := csbProcedimiento ||'.LegAllactivities';

    BEGIN
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        onuErrorCode := 0;
		osbErrorMessage := NULL;
        IF (isbComment IS NOT NULL) THEN
            OR_BOOrderComment.InsertOrUpdateComment(inuOrderId,
                                                    1,
                                                    isbComment,
                                                    'Y',
                                                    nuOrderCommentId);

        END IF;
		nuOperUnitId := pkg_bcordenes.fnuobtieneunidadoperativa(inuOrderId);
		ldc_closeOrder (
							inuOrderId ,                     --> orden a legalizar
							inuCausalId,                   --> Causal de la orden padre
							inuPersonId ,             --> tecnico de la orden padre
							nuOperUnitId   --> Unidad de trabajo de la orden padre
						);
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
		   onuErrorCode := -1;
            raise pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            pkg_error.setError;
			 onuErrorCode := -1;
			 osbErrorMessage := 'termina con error controlado '||SQLERRM;
            raise pkg_error.CONTROLLED_ERROR;
    END LegAllactivities;



    BEGIN
         pkg_traza.trace(csbProcedimiento, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

        nuCAUSAL_ID := pkg_bcld_parameter.fnuobtienevalornumerico('LDC_CAUSLEGSUB');
        sbComment   := pkg_bcld_parameter.fsbobtienevalorcadena('LDC_OBSELEGSUB');
        /*Validar que se haya ingresado la causal*/
        IF nuCAUSAL_ID IS NULL THEN
            onuErrorCode := ld_boconstans.cnuGeneric_Error;
            osbErrorMessage := 'La causal de legalizacion no puede ser nula';
            RAISE erProceso;

        END IF;

        /*Validar que el parametro de causales de exito este configurado*/
        IF ld_boconstans.csbCAU_COM_DOC_SUB IS NULL THEN
            onuErrorCode := ld_boconstans.cnuGeneric_Error;
            osbErrorMessage := 'El parametro CAU_COM_DOC_SUB no esta diligenciado';
            RAISE erProceso;
        END IF;

        /*Validar que el parametro de causales de exito este configurado*/
        IF ld_boconstans.csbCAU_NON_COM_DOC_SUB IS NULL THEN

            onuErrorCode := ld_boconstans.cnuGeneric_Error;
            osbErrorMessage := 'El parametro CAU_NON_COM_DOC_SUB no esta diligenciado';

            RAISE erProceso;
        END IF;

        /*Obtener la longitud del campo comentario de la tabla or_order_activity*/
        BEGIN
            FOR rglengthorder_activity IN lengthorder_activity LOOP
                nulengthcomment := rglengthorder_activity.data_length;
            END LOOP;
        EXCEPTION
            WHEN OTHERS THEN
                nulengthcomment := 2000;
        END;

        IF (length(sbComment) + length('Legalizada por la aplicacion LDCDE []')) >
           nulengthcomment THEN
            onuErrorCode := ld_boconstans.cnuGeneric_Error;
            osbErrorMessage := 'La longitud del comentario de las ordenes a generar es muy extenso';
             RAISE erProceso;
        END IF;

        IF ld_boconstans.csbapackagedocok IS NULL OR  nvl(ld_boconstans.csbapackagedocok, 'X') <> 'S' THEN

            onuErrorCode := ld_boconstans.cnuGeneric_Error;
            osbErrorMessage :=  'La constante csbapackagedocok del paquete Ld_Boconstans no se encuentra debidamente diligenciada';
            RAISE erProceso;
        END IF;

        IF Ld_boconstans.cnupenalize_activity IS NULL THEN

            onuErrorCode := ld_boconstans.cnuGeneric_Error;
            osbErrorMessage :=  'El parametro PENALIZE_ACTIVITY no se ha diligenciado';

           RAISE erProceso;
        END IF;
        IF ld_boconstans.cnuTransitionSub IS NULL THEN
            onuErrorCode := ld_boconstans.cnuGeneric_Error;
            osbErrorMessage :=  'El parametro TRANSITION_SUBSIDY no se ha diligenciado';

            RAISE erProceso;
        END IF;
        IF Ld_boconstans.cnudocactivity IS NULL THEN

            onuErrorCode := ld_boconstans.cnuGeneric_Error;
            osbErrorMessage :=  'El parametro NORMAL_SALE_DOC_ACTIVITY no se ha diligenciado';

             RAISE erProceso;
        END IF;

        /*Obtener el valor de los parametros de causales de exito y fallo*/
        sbSuccessCausal := ld_boconstans.csbCAU_COM_DOC_SUB;
        sbFailedCausal  := ld_boconstans.csbCAU_NON_COM_DOC_SUB;

        /*Validar que la causal que se ingreso es de exito o de fallo*/
        IF REGEXP_INSTR(sbSuccessCausal, '(\W|^)' || nuCAUSAL_ID || '(\W|$)') =
           ld_boconstans.cnuCero_Value AND
           REGEXP_INSTR(sbFailedCausal, '(\W|^)' || nuCAUSAL_ID || '(\W|$)') =
           ld_boconstans.cnuCero_Value THEN
            onuErrorCode := ld_boconstans.cnuGeneric_Error;
            osbErrorMessage := 'La causal de legalizacion ' ||
                                             nuCAUSAL_ID ||
                                             ' no se encuentra configurada ni como causal de exito ni de fallo';

             RAISE erProceso;
        END IF;

        IF nuCAUSAL_ID IS NOT NULL THEN
            ---Causal de Cumplimiento de Documentacion
            IF REGEXP_INSTR(sbSuccessCausal,
                            '(\W|^)' || nuCAUSAL_ID || '(\W|$)') >
               ld_boconstans.cnuCero_Value THEN
                pkg_traza.trace('CAUSAL DE EXITO: ' || nuCAUSAL_ID, pkg_traza.cnuNivelTrzDef);
                ---Cursor para subsidio asignados
                OPEN cuAsigSubsidy;
                FETCH cuAsigSubsidy INTO AsigSubsidy;
                ---parametros para valores quemados
                IF cuAsigSubsidy%FOUND AND   LD_BOSUBSIDY.FsbGetString(2, inuasig_subsidy_id, '-') = 'S' THEN
                   pkg_traza.trace('IF cuAsigSubsidy%FOUND AND', pkg_traza.cnuNivelTrzDef);
                    nuParameter := pkg_bcld_parameter.fnuobtienevalornumerico(ld_boconstans.csbCodOrderStatus);
                    nuOrdenTrab := AsigSubsidy.Order_Id;

                    IF nuParameter IS NOT NULL THEN
                      	pkg_traza.trace('IF nuParameter IS NOT NULL THEN', pkg_traza.cnuNivelTrzDef);
                        OPEN cuOrder(AsigSubsidy.Order_Id);
                      	pkg_traza.trace('OPEN cuOrder('||AsigSubsidy.Order_Id||');', pkg_traza.cnuNivelTrzDef);
                        FETCH cuOrder   INTO OrderAsig;
                        IF cuOrder%FOUND THEN
                        		pkg_traza.trace(' IF cuOrder%FOUND THEN', pkg_traza.cnuNivelTrzDef);
                            IF OrderAsig.Order_Status_Id = nuParameter THEN

                               pkg_traza.trace(' IF '||OrderAsig.Order_Status_Id||' = '||nuParameter ||' THEN ', pkg_traza.cnuNivelTrzDef);

                                IF OrderAsig.Causal_Id <> nuCAUSAL_ID THEN
                                    onuErrorCode    := Ld_Boconstans.cnuGeneric_Error;
                                    osbErrorMessage := 'La orden [' ||  OrderAsig.Order_Id ||'] fue legalizada con Causal Diferente';

                                ELSE
                                    /*Obtener el tipo de asignacion de subsidio*/

                                  	pkg_traza.trace(' sbtypesale := dald_asig_subsidy.fsbGetType_Subsidy(LD_BOSUBSIDY.FsbGetString(1,' , pkg_traza.cnuNivelTrzDef);

                                    sbtypesale := dald_asig_subsidy.fsbGetType_Subsidy(LD_BOSUBSIDY.FsbGetString(1, inuasig_subsidy_id,'-'), NULL);

                                    IF sbtypesale = ld_boconstans.csbretroactivesale THEN

                                       pkg_traza.trace('LD_BOSUBSIDY.ApplyRetrosubsidy(LD_BOSUBSIDY.FsbGetString(1, '||inuasig_subsidy_id||',  -), onuErrorCode,
                                                          osbErrorMessage);', pkg_traza.cnuNivelTrzDef);

                                       LD_BOSUBSIDY.ApplyRetrosubsidy( LD_BOSUBSIDY.FsbGetString(1,inuasig_subsidy_id,'-'),
                                                                       onuErrorCode,
                                                                       osbErrorMessage);
                                    END IF;

                                    IF onuErrorCode IS NOT NULL AND  osbErrorMessage IS NOT NULL THEN


                                       RAISE erProceso;
                                    END IF;

                                      pkg_traza.trace('dald_asig_subsidy.updDelivery_Doc('||AsigSubsidy.Asig_Subsidy_Id||',
                                                                      '||ld_boconstans.csbapackagedocok||');', pkg_traza.cnuNivelTrzDef);

                                      dald_asig_subsidy.updDelivery_Doc(AsigSubsidy.Asig_Subsidy_Id,
                                                                           ld_boconstans.csbapackagedocok);

                                END IF;
                            ELSE
                              pkg_traza.trace('antes de IF OrderAsig.Order_Status_Id <> nuParameter THEN', pkg_traza.cnuNivelTrzDef) 	;
                            	pkg_traza.trace('OrderAsig.Order_Status_Id '||OrderAsig.Order_Status_Id ||' - '||' nuParameter ' ||nuParameter, pkg_traza.cnuNivelTrzDef) 	;

                                IF OrderAsig.Order_Status_Id <> nuParameter THEN
                                    pkg_traza.trace ( ' LegAllactivities('||OrderAsig.Order_Id||',
                                                     '||nuCAUSAL_ID||',
                                                     '||ld_boutilflow.fnuGetPersonToLegal(pkg_bcordenes.fnuobtieneunidadoperativa(OrderAsig.Order_Id))||',
                                                     '||SYSDATE||',
                                                     '||SYSDATE||',
                                                     Legalizacion por proceso Automatico,
                                                     NULL, --new parameter add for open
                                                     nuError,
                                                     sbError);', pkg_traza.cnuNivelTrzDef);

                                    LegAllactivities(OrderAsig.Order_Id,
                                                     nuCAUSAL_ID,
                                                     ld_boutilflow.fnuGetPersonToLegal(pkg_bcordenes.fnuobtieneunidadoperativa(OrderAsig.Order_Id)),
                                                     SYSDATE,
                                                     SYSDATE,
                                                     'Legalizacion por proceso Automatico',
                                                     NULL, --new parameter add for open
                                                     nuError,
                                                     sbError);

                                    IF nuError = ld_boconstans.cnuCero_Value THEN
                                        /*Obtener el tipo de asignacion de subsidio*/
                                        sbtypesale := dald_asig_subsidy.fsbGetType_Subsidy(LD_BOSUBSIDY.FsbGetString(1,
                                                                                                        inuasig_subsidy_id,
                                                                                                        '-'),
                                                                                           NULL);

                                        /*Generar movimientos: bajar deuda diferida, generar nota y
                                        cargo credito para un subsidio retroactivo*/
                                        IF sbtypesale = ld_boconstans.csbretroactivesale THEN
                                            LD_BOSUBSIDY.ApplyRetrosubsidy(LD_BOSUBSIDY.FsbGetString(1,
                                                                           inuasig_subsidy_id,
                                                                           '-'),
                                                                          onuErrorCode,
                                                                           osbErrorMessage);
                                        END IF;

                                        IF onuErrorCode IS NOT NULL AND
                                           osbErrorMessage IS NOT NULL THEN
                                            pkg_Error.setErrorMessage(onuErrorCode,
                                                                             osbErrorMessage);


                                        END IF;

                                        dald_asig_subsidy.updDelivery_Doc(AsigSubsidy.Asig_Subsidy_Id,
                                                                          ld_boconstans.csbapackagedocok);

                                    ELSE
                                        onuErrorCode    := nuError;
                                        osbErrorMessage := sbError;


                                    END IF;
                                END IF;
                            END IF;
                        ELSE
                            onuErrorCode    := Ld_Boconstans.cnuGeneric_Error;
                            osbErrorMessage := 'Inconvenientes con la orden [' ||
                                               AsigSubsidy.Order_Id || ']';

                        END IF;
                        CLOSE cuOrder;
                    ELSE
                        onuErrorCode    := Ld_Boconstans.cnuGeneric_Error;
                        osbErrorMessage := 'Error. El parametro de estado de legalizacion de la orden no esta diligenciado [COD_ORDER_STATUS]';

                    END IF;
                ELSE
                    -----/*
                    OPEN cuSalesWithoutsubsidy;
                    FETCH cuSalesWithoutsubsidy INTO SalesWithoutsubsidy;
                    ---parametros para valores quemados
                    IF cuSalesWithoutsubsidy%FOUND AND
                       LD_BOSUBSIDY.FsbGetString(2, inuasig_subsidy_id, '-') = 'V' THEN
                        nuParameter := pkg_bcld_parameter.fnuobtienevalornumerico(ld_boconstans.csbCodOrderStatus);
                        nuOrdenTrab := SalesWithoutsubsidy.Order_Id;
                        IF nuParameter IS NOT NULL THEN
                            OPEN cuOrder(SalesWithoutsubsidy.Order_Id);
                            FETCH cuOrder  INTO OrderAsig;
                            IF cuOrder%FOUND THEN
                                IF OrderAsig.Order_Status_Id = nuParameter THEN
                                    IF OrderAsig.Causal_Id <> nuCAUSAL_ID THEN
                                        onuErrorCode    := Ld_Boconstans.cnuGeneric_Error;
                                        osbErrorMessage := 'La orden [' ||
                                                           OrderAsig.Order_Id ||
                                                           '] fue legalizada con Causal Diferente';

                                    ELSE
                                        dald_sales_withoutsubsidy.updDelivery_Doc(SalesWithoutsubsidy.Sales_Withoutsubsidy_Id,
                                                                                  ld_boconstans.csbapackagedocok);

                                    END IF;
                                ELSE
                                    IF OrderAsig.Order_Status_Id <> nuParameter THEN
                                        LegAllactivities(OrderAsig.Order_Id,
                                                         nuCAUSAL_ID,
                                                         ld_boutilflow.fnuGetPersonToLegal(pkg_bcordenes.fnuobtieneunidadoperativa(OrderAsig.Order_Id)),
                                                         SYSDATE,
                                                         SYSDATE,
                                                         'Legalizacion por proceso Automatico',
                                                         NULL, --new parameter add for open
                                                         nuError,
                                                         sbError);
                                        IF nuError =
                                           ld_boconstans.cnuCero_Value THEN
                                            dald_sales_withoutsubsidy.updDelivery_Doc(SalesWithoutsubsidy.Sales_Withoutsubsidy_Id,
                                                                                      ld_boconstans.csbapackagedocok);

                                        ELSE
                                            onuErrorCode    := nuError;
                                            osbErrorMessage := sbError;


                                        END IF;
                                    END IF;
                                END IF;
                            ELSE
                                onuErrorCode    := Ld_Boconstans.cnuGeneric_Error;
                                osbErrorMessage := 'Inconvenientes con la orden [' ||
                                                   AsigSubsidy.Order_Id || ']';

                                --close cuOrder;
                            END IF;
                            CLOSE cuOrder;
                        ELSE
                            onuErrorCode    := Ld_Boconstans.cnuGeneric_Error;
                            osbErrorMessage := 'Error. El parametro de estado de legalizacion de la orden no esta diligenciado [COD_ORDER_STATUS]';

                        END IF;
                    ELSE
                        onuErrorCode    := Ld_Boconstans.cnuGeneric_Error;
                        osbErrorMessage := 'Error al procesar la validacion de documentos para el subsidio asignado [' ||
                                           inuasig_subsidy_id || ']';

                        --close cuSalesWithoutsubsidy;
                    END IF;

                   	pkg_traza.trace ('antes de CLOSE cuSalesWithoutsubsidy;');

                    CLOSE cuSalesWithoutsubsidy;

                     pkg_traza.trace ('despues de CLOSE cuSalesWithoutsubsidy;');
                    ------*/
                END IF;

                pkg_traza.trace ('antes de CLOSE cuAsigSubsidy',0);

                CLOSE cuAsigSubsidy;

            ELSE

                ---Causal de incumplimiento de entrega de documentacion
                IF REGEXP_INSTR(sbFailedCausal,
                                '(\W|^)' || nuCAUSAL_ID || '(\W|$)') >
                   ld_boconstans.cnuCero_Value THEN
                    pkg_traza.trace('CAUSAL DE FALLO: ' || nuCAUSAL_ID, pkg_traza.cnuNivelTrzDef);
                    ---Ventas Subsidiadas
                    OPEN cuAsigSubsidy;
                    FETCH cuAsigSubsidy  INTO AsigSubsidy;
                    ---parametros para valores quemados
                    IF cuAsigSubsidy%FOUND AND LD_BOSUBSIDY.FsbGetString(2, inuasig_subsidy_id, '-') = 'S' THEN
                        --asignacion retroactiva
                        IF AsigSubsidy.Type_Subsidy = 'R' THEN
                            nuParameter := pkg_bcld_parameter.fnuobtienevalornumerico(ld_boconstans.csbCodOrderStatus);
                            nuOrdenTrab := AsigSubsidy.Order_Id;

                            IF nuParameter IS NOT NULL THEN
                                OPEN cuOrder(AsigSubsidy.Order_Id);
                                FETCH cuOrder  INTO OrderAsig;
                                pkg_traza.trace('La orden: ' ||
                                               AsigSubsidy.Order_Id ||
                                               '  Se encuentra en estado: ' ||
                                               OrderAsig.Order_Status_Id ||
                                               ' | nuParameter:' ||
                                               nuParameter,
                                               pkg_traza.cnuNivelTrzDef);
                                IF cuOrder%FOUND THEN
                                    IF OrderAsig.Order_Status_Id = nuParameter THEN
                                        IF OrderAsig.Causal_Id <> nuCAUSAL_ID THEN
                                            onuErrorCode    := Ld_Boconstans.cnuGeneric_Error;
                                            osbErrorMessage := 'La orden [' ||
                                                               OrderAsig.Order_Id ||
                                                               '] fue legalizada con Causal Diferente a Causal de Fallo';

                                        ELSE
                                            IF OrderAsig.Causal_Id =
                                               nuCAUSAL_ID THEN
                                                onuErrorCode    := Ld_Boconstans.cnuGeneric_Error;
                                                osbErrorMessage := 'La orden [' ||
                                                                   OrderAsig.Order_Id ||
                                                                   '] ya fue legalizada con Causal Fallo';

                                            END IF;
                                        END IF;
                                    ELSE
                                        IF OrderAsig.Order_Status_Id <>    nuParameter THEN
                                            LegAllactivities(OrderAsig.Order_Id,
                                                             nuCAUSAL_ID,
                                                             ld_boutilflow.fnuGetPersonToLegal(pkg_bcordenes.fnuobtieneunidadoperativa(OrderAsig.Order_Id)),
                                                             SYSDATE,
                                                             SYSDATE,
                                                             'Legalizacion por proceso Automatico',
                                                             NULL, --new parameter add for open
                                                             nuError,
                                                             sbError);
                                            IF nuError <>   ld_boconstans.cnuCero_Value THEN
                                                onuErrorCode    := nuError;
                                                osbErrorMessage := sbError;


                                            ELSE

                                                /*Obtener el codigo de asignacion del subsidio*/
                                                nuasigsub := LD_BOSUBSIDY.FsbGetString(1,
                                                                          inuasig_subsidy_id,
                                                                          '-');

                                                /*Validad que el codigo exista*/
                                                IF NOT   dald_asig_subsidy.fblExist(nuasigsub) THEN
                                                    onuErrorCode    := ld_boconstans.cnuGeneric_Error;
                                                    osbErrorMessage := 'El codigo de asignacion de subsidio ' ||
                                                                       nuasigsub ||
                                                                       ' no existe';


                                                END IF;
                                                pkg_traza.trace('ACTUALIZA EL ESTADO A: ' ||
                                                               ld_boconstans.cnuSubreverstate,
                                                               pkg_traza.cnuNivelTrzDef);
                                                /*Se actualiza el estado del subsidio a reversado*/
                                                dald_asig_subsidy.updState_Subsidy(nuasigsub,
                                                                                   ld_boconstans.cnuSubreverstate);

                                                /*Obtener datos de la poblacion*/
                                                DALD_ubication.LockByPkForUpdate(dald_asig_subsidy.fnuGetUbication_Id(nuasigsub,
                                                                                                              NULL),
                                                                         rcubication);

                                                /*Reversar el valor del subsidio de la poblacion y del subsidio*/
                                                LD_BOSUBSIDY.Procbalancesub(dald_asig_subsidy.fnuGetSubsidy_Id(nuasigsub,
                                                                                                  NULL),
                                                               rcubication,
                                                               dald_asig_subsidy.fnuGetSubsidy_Value(nuasigsub,
                                                                                                     NULL),
                                                               ld_boconstans.cnutwonumber);



                                            END IF;
                                        END IF;
                                    END IF;
                                ELSE
                                    onuErrorCode    := Ld_Boconstans.cnuGeneric_Error;
                                    osbErrorMessage := 'Inconvenientes con la orden [' ||
                                                       AsigSubsidy.Order_Id || ']';

                                    --close cuOrder;
                                END IF;
                                CLOSE cuOrder;
                            ELSE
                                onuErrorCode    := Ld_Boconstans.cnuGeneric_Error;
                                osbErrorMessage := 'Error. El parametro de estado de legalizacion de la orden no esta diligenciado [COD_ORDER_STATUS]';

                            END IF;
                        ELSE
                            --Legalizacion como incumplida de una venta subsidida realizada por el formulario de venta
                            IF AsigSubsidy.Type_Subsidy = 'V' THEN

                                nuParameter := pkg_bcld_parameter.fnuobtienevalornumerico(ld_boconstans.csbCodOrderStatus);
                                IF nuParameter IS NOT NULL THEN
                                    OPEN cuOrder(AsigSubsidy.Order_Id);
                                    FETCH cuOrder  INTO OrderAsig;
                                    IF cuOrder%FOUND THEN
                                        IF OrderAsig.Order_Status_Id =    nuParameter THEN
                                            IF OrderAsig.Causal_Id <>  nuCAUSAL_ID THEN
                                                onuErrorCode    := Ld_Boconstans.cnuGeneric_Error;
                                                osbErrorMessage := 'La orden [' ||
                                                                   OrderAsig.Order_Id ||
                                                                   '] fue legalizada con Causal Diferente a Causal de Fallo';
                                            ELSE
                                                onuErrorCode    := Ld_Boconstans.cnuGeneric_Error;
                                                osbErrorMessage := 'La orden [' ||
                                                                   OrderAsig.Order_Id ||
                                                                   '] ya fue legalizada con Causal No Exitoso';
                                            END IF;
                                        ELSE

                                            IF OrderAsig.Order_Status_Id <>  nuParameter THEN
                                                LegAllactivities(OrderAsig.Order_Id,
                                                                 nuCAUSAL_ID,
                                                                 ld_boutilflow.fnuGetPersonToLegal(pkg_bcordenes.fnuobtieneunidadoperativa(OrderAsig.Order_Id)),
                                                                 SYSDATE,
                                                                 SYSDATE,
                                                                 'Legalizacion por proceso Automatico',
                                                                 NULL, --new parameter add for open
                                                                 nuError,
                                                                 sbError);
                                                IF nuError <>
                                                   ld_boconstans.cnuCero_Value THEN
                                                    onuErrorCode    := nuError;
                                                    osbErrorMessage := sbError;


                                                ELSE

                                                    OPEN cuOrderActivity(OrderAsig.Order_Id,
                                                                         Ld_boconstans.cnudocactivity);
                                                    FETCH cuOrderActivity
                                                        INTO OrderActivity;
                                                    IF cuOrderActivity%FOUND THEN
                                                        daor_order_activity.updComment_(orderactivity.order_activity_id,
                                                                                        orderactivity.comment_ ||
                                                                                        chr(10) ||
                                                                                        'Legalizada por la aplicacion LDCDE [' ||
                                                                                        sbComment || ']');

                                                        ---/* Generar una orden para venta subsidiada
                                                        nuItems              := Ld_boconstans.cnudocactivity;
                                                        nuMotive             := mo_bopackages.fnuGetInitialMotive(AsigSubsidy.Package_Id);
                                                        nuAddress            := mo_bopackages.fnuFindAddressId(AsigSubsidy.Package_Id);
                                                        nuSubscriberId       := mo_bopackages.fnuGetSubscriberId(AsigSubsidy.Package_Id);
                                                        nuSubscriptionPendId := mo_bopackages.fnuGetSuscriptionByPack(AsigSubsidy.Package_Id);
                                                        damo_motive.getRecord(nuMotive,
                                                                              rcMotive);

                                                        /*Creacion de orden de la nueva orden de control de documentacion*/
                                                        api_createorder(nuItems,
                                                                        AsigSubsidy.Package_Id,
                                                                        nuMotive,
                                                                        NULL,
                                                                        NULL,
                                                                        nuAddress,
                                                                        NULL,
                                                                        nuSubscriberId,
                                                                        nuSubscriptionPendId,
                                                                        rcMotive.product_id,
                                                                        NULL,
                                                                        NULL,
                                                                        NULL,
                                                                        'Orden de venta no subsidiada por medio de LDCDE',
                                                                        NULL,
                                                                        NULL,
                                                                        NULL,
                                                                        NULL,
                                                                        NULL,
                                                                        NULL,
                                                                        NULL,
                                                                        NULL,
                                                                        NULL,
                                                                        NULL,
                                                                        NULL,
                                                                        NULL,
                                                                        nuOrderId,
                                                                        nuorderactivityid,
                                                                        nuError,
                                                                        sbError
                                                                        );

                                                        ---Fin Generar una orden para venta subsidiada*/

                                                        --/*Asignacion de unidad operativa a la orden de venta subsidiada
                                                        IF nuOrderId =
                                                           ld_boconstans.cnuCero_Value THEN
                                                            onuErrorCode    := Ld_Boconstans.cnuGeneric_Error;
                                                            osbErrorMessage := 'No se genero orden';


                                                        ELSE


                                                            --Fin Asignacion de unidad operativa a la orden de venta subsidiada*/
                                                            IF nuerror <>   ld_boconstans.cnuCero_Value THEN
                                                                onuErrorCode    := nuError;
                                                                osbErrorMessage := sbError;


                                                            ELSE
                                                                ---/* Relaciona orden legalizada con orden generada
                                                                rcRelatedOrder.order_id           := OrderAsig.Order_Id;
                                                                rcRelatedOrder.related_order_id   := nuOrderId;
                                                                rcRelatedOrder.rela_order_type_id := or_bofworderrelated.FNUGETRELATEDORDERTYPE;
                                                                daor_related_order.insRecord(rcRelatedOrder);
                                                                     --/*Obtener el codigo de asignacion del subsidio*
                                                                nuasigsub := LD_BOSUBSIDY.FsbGetString(1,
                                                                                          inuasig_subsidy_id,
                                                                                          '-');

                                                                --/*Validad que el codigo exista*
                                                                IF NOT
                                                                    dald_asig_subsidy.fblExist(nuasigsub) THEN
                                                                    onuErrorCode    := ld_boconstans.cnuGeneric_Error;
                                                                    osbErrorMessage := 'El codigo de asignacion de subsidio ' ||
                                                                                       nuasigsub ||
                                                                                       ' no existe';


                                                                END IF;

                                                                /*Actualizacion de la orden en el registro de asignacion de subsidios*/
                                                                dald_asig_subsidy.updOrder_Id(nuasigsub,
                                                                                              nuOrderId);


                                                                --FIN NC1112*/

                                                            END IF;
                                                        END IF;
                                                    ELSE
                                                        onuErrorCode    := Ld_Boconstans.cnuGeneric_Error;
                                                        osbErrorMessage := 'La Actividad [' ||
                                                                           Ld_boconstans.cnudocactivity ||
                                                                           '] no esta asociada a la orden [' ||
                                                                           OrderAsig.Order_Id ||
                                                                           '] no esta asociada a la orden ';


                                                    END IF;
                                                    CLOSE cuOrderActivity;
                                                END IF; ---
                                            END IF;
                                        END IF;
                                    ELSE
                                        onuErrorCode    := Ld_Boconstans.cnuGeneric_Error;
                                        osbErrorMessage := 'Inconvenientes con la orden [' ||
                                                           AsigSubsidy.Order_Id || ']';
                                        --close cuOrder;

                                    END IF;
                                    CLOSE cuOrder;
                                ELSE
                                    onuErrorCode    := Ld_Boconstans.cnuGeneric_Error;
                                    osbErrorMessage := 'Error. El parametro de estado de legalizacion de la orden no esta diligenciado [COD_ORDER_STATUS]';

                                END IF;
                            END IF;
                        END IF;
                    ELSE
                        -----/*
                        OPEN cuSalesWithoutsubsidy;
                        FETCH cuSalesWithoutsubsidy INTO SalesWithoutsubsidy;
                        IF cuSalesWithoutsubsidy%FOUND AND
                           LD_BOSUBSIDY.FsbGetString(2, inuasig_subsidy_id, '-') = 'V' THEN
                            nuParameter := pkg_bcld_parameter.fnuobtienevalornumerico(ld_boconstans.csbCodOrderStatus);
                             nuOrdenTrab := SalesWithoutsubsidy.Order_Id;
                            IF nuParameter IS NOT NULL THEN
                                OPEN cuOrder(SalesWithoutsubsidy.Order_Id);
                                FETCH cuOrder     INTO OrderAsig;
                                IF cuOrder%FOUND THEN
                                    IF OrderAsig.Order_Status_Id = nuParameter THEN
                                        IF OrderAsig.Causal_Id <> nuCAUSAL_ID THEN
                                            onuErrorCode    := Ld_Boconstans.cnuGeneric_Error;
                                            osbErrorMessage := 'La orden [' ||
                                                               OrderAsig.Order_Id ||
                                                               '] fue legalizada con Causal Diferente';

                                        ELSE
                                            onuErrorCode    := Ld_Boconstans.cnuGeneric_Error;
                                            osbErrorMessage := 'La orden [' ||
                                                               OrderAsig.Order_Id ||
                                                               '] ya fue legalizada con Causal No Exitoso';

                                        END IF;
                                    ELSE
                                        IF OrderAsig.Order_Status_Id <>  nuParameter THEN
                                            LegAllactivities(OrderAsig.Order_Id,
                                                             nuCAUSAL_ID,
                                                             ld_boutilflow.fnuGetPersonToLegal(pkg_bcordenes.fnuobtieneunidadoperativa(OrderAsig.Order_Id)),
                                                             SYSDATE,
                                                             SYSDATE,
                                                             'Legalizacion por proceso Automatico',
                                                             NULL, --new parameter add for open
                                                             nuError,
                                                             sbError);
                                            IF nuError <>
                                               ld_boconstans.cnuCero_Value THEN
                                                onuErrorCode    := nuError;
                                                osbErrorMessage := sbError;


                                            ELSE
                                                OPEN cuOrderActivity(OrderAsig.Order_Id,
                                                                     Ld_boconstans.cnudocactivity);
                                                FETCH cuOrderActivity  INTO OrderActivity;
                                                IF cuOrderActivity%FOUND THEN
                                                    daor_order_activity.updComment_(orderactivity.order_activity_id,
                                                                                    orderactivity.comment_ ||
                                                                                    chr(10) ||
                                                                                    'Legalizada por la aplicacion LDCDE [' ||
                                                                                    sbComment || ']');

                                                    pkg_traza.trace('despues de cuOrderActivity',
                                                                   pkg_traza.cnuNivelTrzDef);

                                                    ---/* Generar una orden para venta NO subsidiada
                                                    nuItems              := Ld_boconstans.cnudocactivity;
                                                    nuMotive             := mo_bopackages.fnuGetInitialMotive(SalesWithoutsubsidy.Package_Id);
                                                    nuAddress            := mo_bopackages.fnuFindAddressId(SalesWithoutsubsidy.Package_Id);
                                                    nuSubscriberId       := mo_bopackages.fnuGetSubscriberId(SalesWithoutsubsidy.Package_Id);
                                                    nuSubscriptionPendId := mo_bopackages.fnuGetSuscriptionByPack(SalesWithoutsubsidy.Package_Id);
                                                    damo_motive.getRecord(nuMotive,
                                                                          rcMotive);

                                                    /*Creacion de orden de venta NO subsidiada*/
                                                    api_createorder(nuItems,
                                                                    SalesWithoutsubsidy.Package_Id,
                                                                    nuMotive,
                                                                    NULL,
                                                                    NULL,
                                                                    nuAddress,
                                                                    NULL,
                                                                    nuSubscriberId,
                                                                    nuSubscriptionPendId,
                                                                    rcMotive.product_id,
                                                                    NULL,
                                                                    NULL,
                                                                    NULL,
                                                                    'Orden de venta no subsidiada por medio de LDCDE',
                                                                    NULL,
                                                                    NULL,
                                                                    NULL,
                                                                    NULL,
                                                                    NULL,
                                                                    NULL,
                                                                    NULL,
                                                                    NULL,
                                                                    NULL,
                                                                    NULL,
                                                                    NULL,
                                                                    NULL,
                                                                    nuOrderId,
                                                                    nuorderactivityid,
                                                                    nuerror,
                                                                    sbError
                                                                    );

                                                    ---Fin Generar una orden para venta subsidiada*/

                                                    --/*Asignacion de unidad operativa a la orden de venta subsidiada
                                                    IF nuOrderId =  ld_boconstans.cnuCero_Value THEN
                                                        onuErrorCode    := Ld_Boconstans.cnuGeneric_Error;
                                                        osbErrorMessage := 'No se genero orden';


                                                    ELSE

                                                        --Fin Asignacion de unidad operativa a la orden de venta subsidiada*/
                                                        IF nuerror <> ld_boconstans.cnuCero_Value THEN
                                                            onuErrorCode    := nuError;
                                                            osbErrorMessage := sbError;


                                                        ELSE
                                                            ---/* Relaciona orden legalizada con orden generada
                                                            rcRelatedOrder.order_id           := SalesWithoutsubsidy.Order_Id;
                                                            rcRelatedOrder.related_order_id   := nuOrderId;
                                                            rcRelatedOrder.rela_order_type_id := or_bofworderrelated.FNUGETRELATEDORDERTYPE;
                                                            daor_related_order.insRecord(rcRelatedOrder);
                                                            ---Fin Relaciona orden legalizada con orden generada*/

                                                            --INICIO NC112
                                                            --Este codigo estaba ubicado al final de la generacion de la multa
                                                            --se ubico despues de relacionar la orden generada con la orden lelgalizada
                                                            --para mantener el orden en el registro de asignacion de subsidio

                                                            --/*Obtener el codigo de asignacion del subsidio*
                                                            nuasigsub := LD_BOSUBSIDY.FsbGetString(1,
                                                                                      inuasig_subsidy_id,
                                                                                      '-');

                                                            --/*Validad que el codigo exista*
                                                            IF NOT   daLd_sales_withoutsubsidy.fblExist(nuasigsub) THEN
                                                                onuErrorCode    := ld_boconstans.cnuGeneric_Error;
                                                                osbErrorMessage := 'El codigo ' ||
                                                                                   nuasigsub ||
                                                                                   ' no existe en la tabla Ld_sales_withoutsubsidy';


                                                            END IF;

                                                            --/*Actualizacion de la orden en el registro de venta no subsidiada*
                                                            daLd_sales_withoutsubsidy.updOrder_Id(inuasig_subsidy_id,
                                                                                                  nuOrderId);


                                                        END IF;
                                                    END IF;
                                                ELSE
                                                    onuErrorCode    := Ld_Boconstans.cnuGeneric_Error;
                                                    osbErrorMessage := 'La Actividad [' ||
                                                                       Ld_boconstans.cnudocactivity ||
                                                                       '] no esta asociada a la orden [' ||
                                                                       OrderAsig.Order_Id ||
                                                                       '] no esta asociada a la orden ';


                                                END IF;
                                                CLOSE cuOrderActivity;
                                            END IF; ---
                                        END IF;
                                    END IF;
                                ELSE
                                    onuErrorCode    := Ld_Boconstans.cnuGeneric_Error;
                                    osbErrorMessage := 'Inconvenientes con la orden [' ||
                                                       SalesWithoutsubsidy.Order_Id || ']';
                                    --close cuOrder;

                                END IF;
                                CLOSE cuOrder;
                            ELSE
                                onuErrorCode    := Ld_Boconstans.cnuGeneric_Error;
                                osbErrorMessage := 'Error. El parametro de estado de legalizacion de la orden no esta diligenciado [COD_ORDER_STATUS]';

                            END IF;
                        ELSE
                            onuErrorCode    := Ld_Boconstans.cnuGeneric_Error;
                            osbErrorMessage := 'Error al procesar la validacion de documentos para el subsidio asignado [' ||
                                               inuasig_subsidy_id || ']';

                        END IF;
                        CLOSE cuSalesWithoutsubsidy;
                        ------*/
                    END IF;
                    CLOSE cuAsigSubsidy;
                    -------*/
                ELSE
                    onuErrorCode    := Ld_Boconstans.cnuGeneric_Error;
                    osbErrorMessage := 'Causal de legalizacion invalida';

                END IF;
            END IF;
        ELSE
            onuErrorCode    := Ld_Boconstans.cnuGeneric_Error;
            osbErrorMessage := 'Causal de legalizacion invalida';

        END IF;

        IF onuErrorCode IS NULL AND osbErrorMessage IS NULL THEN
          COMMIT;
        ELSE
          RAISE erProceso;
        END IF;

        pkg_traza.trace(csbProcedimiento, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

EXCEPTION

  WHEN erProceso THEN
     proinserLogError( nuOrdenTrab,onuErrorCode||'-'||osbErrorMessage );
      ROLLBACK;
  WHEN pkg_error.CONTROLLED_ERROR  THEN
      ROLLBACK;
      onuErrorCode := -1;
      osbErrorMessage := 'termina con error controlado '||SQLERRM;
      pkg_traza.trace(osbErrorMessage, pkg_traza.cnuNivelTrzDef);
      proinserLogError( nuOrdenTrab,onuErrorCode||'-'||osbErrorMessage );
  WHEN OTHERS THEN
      pkg_traza.trace('termina con error no controlado '||SQLERRM, pkg_traza.cnuNivelTrzDef);
      ROLLBACK;
      onuErrorCode := -1;
      osbErrorMessage := 'termina con error controlado '||SQLERRM;
      proinserLogError( nuOrdenTrab,onuErrorCode||'-'||osbErrorMessage );
END LDC_PROCCONTDOCUVENT;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre procedimiento LDC_PROCCONTDOCUVENT
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_PROCCONTDOCUVENT', 'ADM_PERSON'); 
END;
/
