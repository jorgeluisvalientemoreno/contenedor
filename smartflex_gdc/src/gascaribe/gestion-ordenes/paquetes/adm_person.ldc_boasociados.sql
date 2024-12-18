CREATE OR REPLACE PACKAGE ADM_PERSON.LDC_BOASOCIADOS
AS
    /*******************************************************************************
  Propiedad intelectual de PROYECTO PETI

  Autor                : Luis Arturo Diuza Cuero / OLSoftware
  Fecha                : 22/12/2014

  Fecha                IDEntrega           Modificacion
  ============    ================         ============================================
  22-Dic-2012     LDiuza/OLSoftware        Creación
  *******************************************************************************/
  /*****************************************
  Metodo: fsbVersion
  Descripcion: Obtiene la version del paquete.
  ******************************************/
  FUNCTION fsbVersion  return varchar2;

  /*****************************************
  Metodo: provalidatadiccertnuevas
  Descripcion: Realiza validaciones sobre las ordenes de trabajo asociadas.
                Las vañidaciones estan relacionadas con causales de legalizacion
                y actividades solicitadas
  ******************************************/
  PROCEDURE validateAssociateOrd;

END LDC_BOASOCIADOS;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.LDC_BOASOCIADOS
AS

    -- Version del paquete
    csbVERSION   constant varchar2(20) := 'TEAM2004_3';

    -- Estado de orden cerrado (Legalizada)
    cnuOrderStatusClosed CONSTANT or_order_status.order_status_id%type := 8;

    FUNCTION fsbVersion  return varchar2 IS
    BEGIN
        return csbVersion;
    END;

    /***************************************************************
    Unidad       : validateAssociateOrd
    Descripcion	 : Realiza validaciones sobre las ordenes de trabajo asociadas.
                    Las vañidaciones estan relacionadas con causales de legalizacion
                    y actividades solicitadas

    Parametros          Descripcion
    ============        ===================

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    20-01-2014      LDiuza              Se modifica para que no eleve error cuando
                                            no se legalice con una de las causales
                                            parametrizadas en ASSO_ORDERS_COD_CAUS.
    14-01-2015      LDiuza              Se realizan modificaciones para validar
                                            el tipo de solicitud de la orden.
    22-12-2014      LDiuza              Creación
    ******************************************************************/
    PROCEDURE validateAssociateOrd IS

        nuCurrentOrderId or_order.order_id%type;
        nuProductId pr_product.product_id%type;
        nuPackageId mo_packages.package_id%type;
        sbCertValidation VARCHAR2(1) := null;
        nuCertificationOderId or_order.order_id%type := null;
        nuCommercialVisitOrder or_order.order_id%type := null;
        nuCausalId or_order.causal_id%type;
        nuSupportActivityOrder or_order.order_id%type := null;
        nuValidation NUMBER;

        CURSOR cuGetOrderGeneralInfo(inuOrderId or_order.order_id%type) IS
            SELECT  oa.product_id,
                    oa.package_id
            FROM    or_order ord, or_order_activity oa
            WHERE   ord.order_id = inuOrderId
            AND     ord.order_id = oa.order_id
            AND     rownum = 1;

        CURSOR cuValidateCertificableOrder(inuTaskTypeid or_order.task_type_id%type, inuPackageTypeId mo_packages.package_type_id%type) IS
            SELECT  'X'
            FROM    ldc_tipotrab_certifica
            WHERE   task_type_id = inuTaskTypeid
            AND     package_type_id = inuPackageTypeId
            AND     certifica = 'S';

        CURSOR cuFindOrder(
                            inuProductId pr_product.product_id%type,
                            inuPackageId mo_packages.package_id%type,
                            isbTaskTypes ld_parameter.value_chain%type
                          ) IS
            SELECT  max(ord.order_id) order_id
            FROM    or_order ord, or_order_activity oa
            WHERE   ord.order_id = oa.order_id
            AND     ord.task_type_id IN (SELECT column_value
                                            FROM TABLE(ldc_boutilities.SPLITstrings(isbTaskTypes,','))
                                        )
            AND     oa.product_id = inuProductId
            AND     oa.package_id = inuPackageId;

        /*
         *Se valida si existe la actividad de apoyo en otra orden certificabe ya cerrada
         para la misma solicitud.

         Nota: Primero se busca en otras ordenes, porque la actividad de apoyo se solicita solo en una
                orden certificable dentro de la solicitud, puede que ya este presente en otra orden, en dado
                caso no se muestra error.
        */
        CURSOR cuFindSupportActiv(
                                    inuExcludedOrder or_order.order_id%type,
                                    inuProductId pr_product.product_id%type,
                                    inuPackageId mo_packages.package_id%type
                                 ) IS
            SELECT  ord.order_id
            FROM    or_order ord, or_order_activity oa
            WHERE   ord.order_id = oa.order_id
            AND     ord.order_id <> inuExcludedOrder
            AND     oa.product_id = inuProductId
            AND     oa.package_id = inuPackageId
            AND     ord.order_status_id = cnuOrderStatusClosed
            AND     oa.activity_id IN (
                                        SELECT column_value
                                        FROM TABLE(ldc_boutilities.SPLITstrings(dald_parameter.fsbgetValue_Chain('SUPPORT_ACTIVITY_ASSO_ORDERS'),','))
                                      )
            AND     ord.task_type_id IN (
                                            SELECT  task_type_id
                                            FROM    ldc_tipotrab_certifica
                                            WHERE   package_type_id = damo_packages.fnugetpackage_type_id(inuPackageId)
                                            AND     certifica = 'S'
                                        )
            AND rownum = 1;

        CURSOR cuFindSuppActivityInOrder(inuOrderId or_order.order_id%type) IS
            SELECT  ord.order_id
            FROM    or_order ord, or_order_activity oa
            WHERE   ord.order_id = oa.order_id
            AND     ord.order_id = inuOrderId
            AND     oa.activity_id IN (
                                        SELECT column_value
                                        FROM TABLE(ldc_boutilities.SPLITstrings(dald_parameter.fsbgetValue_Chain('SUPPORT_ACTIVITY_ASSO_ORDERS'),','))
                                      )
            AND rownum = 1;

        -- Cursor utilitario para validar si un valor (sbValue) se encuentra en un conjunto de datos (sbDataSet)
        CURSOR cuValidateData
        (
            sbValue VARCHAR2,
            sbDataSet VARCHAR2
        )
        IS
            SELECT count(1)
            FROM dual
            WHERE sbValue IN (SELECT column_value
                              FROM TABLE(ldc_boutilities.SPLITstrings(sbDataSet,','))
                             );

    BEGIN
        ut_trace.trace('Inicia LDC_BOASOCIADOS.validateAssociateOrd', 10);

        -- Se obtiene orden de trabajo actual de instancia
        nuCurrentOrderId := or_bolegalizeorder.fnugetcurrentorder;
        ut_trace.trace('Orden de trabajo actualmente procesada: '||nuCurrentOrderId, 10);

        -- Se obtiene el id del PRODUCTO y el id de la SOLICITUD
        IF(cuGetOrderGeneralInfo%ISOPEN) THEN
            close cuGetOrderGeneralInfo;
        END IF;

        OPEN cuGetOrderGeneralInfo(nuCurrentOrderId);
        FETCH cuGetOrderGeneralInfo INTO nuProductId, nuPackageId;
        CLOSE cuGetOrderGeneralInfo;

        ut_trace.trace('Id Producto: ['||nuProductId||'], Id Solicitud: ['||nuPackageId||']', 10);

        -- Se valida si el tipo de trabajo de la orden procesada es certificable
        IF(cuValidateCertificableOrder%ISOPEN) THEN
            close cuValidateCertificableOrder;
        END IF;

        OPEN cuValidateCertificableOrder(daor_order.fnugettask_type_id(nuCurrentOrderId), damo_packages.fnugetpackage_type_id(nuPackageId));
        FETCH cuValidateCertificableOrder INTO sbCertValidation;
        CLOSE cuValidateCertificableOrder;

        IF(sbCertValidation IS NULL) THEN
            -- Si no es certificable no se hace nada, el proceso no aplica.
            ut_trace.trace('Tipo de trabajo de la orden no es certificable, plugin finaliza sin error', 10);
            ut_trace.trace('Fin LDC_BOASOCIADOS.validateAssociateOrd', 10);
            return;
        END IF;

        -- Se valida si la orden pertenece a alguno de los tipos de solicitudes parametrizados para validar trabajos asociados.
        nuValidation := 0;
        IF(cuValidateData%ISOPEN) THEN
            CLOSE cuValidateData;
        END IF;

        OPEN cuValidateData(damo_packages.fnugetpackage_type_id(nuPackageId), dald_parameter.fsbgetValue_Chain('PACK_TYPES_ASSO_ORDES'));
        FETCH cuValidateData INTO nuValidation;
        CLOSE cuValidateData;

        IF(nuValidation = 0) THEN
            ut_trace.trace('La solicitud de la orden no es de tipo de solicitud parametrizado para validar trabajos asociados -> PACK_TYPES_ASSO_ORDES, plugin finaliza sin error', 10);
            ut_trace.trace('Fin LDC_BOASOCIADOS.validateAssociateOrd', 10);
            return;
        END IF;

        -- Se busca si existe una orden de certificacion para el mismo producto creada en la misma solicitud
        IF(cuFindOrder%ISOPEN) THEN
            CLOSE cuFindOrder;
        END IF;

        OPEN cuFindOrder(nuProductId, nuPackageId , dald_parameter.fsbgetValue_Chain('TASKTYPE_CERT_ASSO_ORDERS'));
        FETCH cuFindOrder INTO nuCertificationOderId;
        CLOSE cuFindOrder;

        -- Si no se encuentra orden de certificacion
        IF(nuCertificationOderId IS NULL) THEN
            ut_trace.trace('No se encontro orden de certificacion, plugin finaliza sin error', 10);
            ut_trace.trace('Fin LDC_BOASOCIADOS.validateAssociateOrd', 10);
            return;
        END IF;

        ut_trace.trace('Id Orden de certificacion: '||nuCertificationOderId, 10);

        -- Validar si la orden de certificacion esta legalizada (order_status_id = 8 - Cerrada)
        IF(daor_order.fnugetorder_status_id(nuCertificationOderId) <> cnuOrderStatusClosed) THEN
            ut_trace.trace('Error: Orden de certificación aun no esta legalizada', 10);
            errors.seterror(
                            Ld_Boconstans.cnuGeneric_Error,
                            'La orden de Certificacion con Id '||nuCertificationOderId||' debe encontrarse legalizada'
                            );
            raise ex.CONTROLLED_ERROR;
        END IF;

        -- Obtiene la causal de la orden de certificacion
        nuCausalId := daor_order.fnugetcausal_id(nuCertificationOderId);

        -- Validar que se haya legalizado la orden de certificacion con las causales parametrizadas
        nuValidation := 0;
        IF(cuValidateData%ISOPEN) THEN
            CLOSE cuValidateData;
        END IF;
        OPEN cuValidateData(nuCausalId, dald_parameter.fsbGetValue_Chain('ASSO_ORDERS_COD_CAUS',NULL));
        FETCH cuValidateData INTO nuValidation;
        CLOSE cuValidateData;

        IF(nuValidation = 0) THEN
            ut_trace.trace('Orden no legalizada con causales ASSO_ORDERS_COD_CAUS, plugin finaliza sin error');
            ut_trace.trace('Fin LDC_BOASOCIADOS.validateAssociateOrd', 10);
            return;
        END IF;

        -- Validar si las causales de la orden de certificacion y la causal de la orden actual son iguales
        IF (daor_order.fnugetcausal_id(nuCurrentOrderId) <> nuCausalId) THEN
            ut_trace.trace('Error: Orden no esta siendo legalizada con la misma causal de la orden de certificacion');
            errors.seterror(
                            Ld_Boconstans.cnuGeneric_Error,
                            'Se debe legalizar la orden con la causal: '||nuCausalId||', ya que debe corresponder a la causal de legalizacion de la orden de certificación'
                            );
            raise ex.CONTROLLED_ERROR;
        END IF;

        -- Se verifica si la causal de legalizacion corresponde a la parametrizada para solicitar actividad de apoyo
        nuValidation := 0;
        IF(cuValidateData%ISOPEN) THEN
            CLOSE cuValidateData;
        END IF;
        OPEN cuValidateData(nuCausalId, dald_parameter.fsbGetValue_Chain('ASSO_ORD_ASK_FOR_SUPPORT_ACT'));
        FETCH cuValidateData INTO nuValidation;
        CLOSE cuValidateData;

        IF(nuValidation > 0) THEN
            ut_trace.trace('La causal corresponde a una de las causales parametrizadas para solicitar actividad de apoyo, validando exstencia de actividad');

            -- busca actividad de apoyo en otras ordenes certificables de la solicitud.
            IF(cuFindSupportActiv%ISOPEN) THEN
                CLOSE cuFindSupportActiv;
            END IF;

            OPEN cuFindSupportActiv(nuCurrentOrderId, nuProductId, nuPackageId);
            FETCH cuFindSupportActiv INTO nuSupportActivityOrder;
            CLOSE cuFindSupportActiv;

            IF(nuSupportActivityOrder IS NULL) THEN
                ut_trace.trace('Orden de apoyo no encontrada en otras ordenes certificables de la solicitud');

                -- Si no se encuentra la actividad en otra orden de la solicitud, debe estar en la orden
                -- que se esta procesando
                IF(cuFindSuppActivityInOrder%ISOPEN) THEN
                    CLOSE cuFindSuppActivityInOrder;
                END IF;

                OPEN cuFindSuppActivityInOrder(nuCurrentOrderId);
                FETCH cuFindSuppActivityInOrder INTO nuSupportActivityOrder;
                CLOSE cuFindSuppActivityInOrder;

                IF(nuSupportActivityOrder IS NULL) THEN
                    ut_trace.trace('Error: se legaliza la orden con una causal parametrizada en -> ASSO_ORD_ASK_FOR_SUPPORT_ACT, pero no tiene actividad de apoyo requerida');
                    errors.seterror(
                            Ld_Boconstans.cnuGeneric_Error,
                            'No se encontró actividad de apoyo requerida cuando se legaliza con las causales: '||dald_parameter.fsbGetValue_Chain('ASSO_ORD_ASK_FOR_SUPPORT_ACT')
                            );
                    raise ex.CONTROLLED_ERROR;
                END IF;
            ELSE
                ut_trace.trace('Actividad de apoyo se encuentra la orden -> '||nuSupportActivityOrder, 10);
            END IF;
        END IF;
        ut_trace.trace('Fin LDC_BOASOCIADOS.validateAssociateOrd', 10);
    EXCEPTION
    	WHEN ex.CONTROLLED_ERROR then
                ut_trace.trace('ex.CONTROLLED_ERROR -> Fin LDC_BOASOCIADOS.validateAssociateOrd', 10);
                raise ex.CONTROLLED_ERROR;
            when others then
                ut_trace.trace('OTHERS ERROR -> Fin LDC_BOASOCIADOS.validateAssociateOrd', 10);
                Errors.setError;
                raise ex.CONTROLLED_ERROR;
    END validateAssociateOrd;

END LDC_BOASOCIADOS;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_BOASOCIADOS', 'ADM_PERSON');
END;
/