create or replace PROCEDURE adm_person.ldc_vainsldsendauthori AS
    /***************************************************************
    Unidad       : validateAssociateOrd
    Descripcion	 : Realiza validaciones sobre las ordenes de para ingresar informacion
                   en la tabla ld_send_authorized

    Parametros          Descripcion
    ============        ===================

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    22-01-2015      SaGomez              Creación
    26-01-2015      SaGomez              Se realiza una modificación
                                         en el cursor para buscar la categoria
                                         por numero de orden
    02-02-2015      SaGomez              Se cambia de donde se obtienen los parametros
                                         ld_general_parameters
    24/04/2024      Adrianavg            OSF-2597: Se migra del esquema OPEN al esquema ADM_PERSON                                         
    ******************************************************************/

        --<<
        -- nuCurrentOrderId guarda el número de la orden
        -->>
        nuCurrentOrderId or_order.order_id%type;
        --<<
        -- nuCurrentCausalId Causal con la cual se legaliza la orden
        -->>
        nuCurrentCausalId or_order.causal_id%type;

        --<<
        -- vaCodCausRiskCntr variable con el codigo de las causales de riesgo en la tabla
        -- ld_general_parameters el codigo es CREDIT_BUREAU_LEG_CAUSAL
        -->>
        vaCodCausRiskCntr ld_general_parameters.parameter_desc%type:='CREDIT_BUREAU_LEG_CAUSAL';

        --<<
        -- vaRiskCenter variable con las causales de riesgo
        -->>
        vaCausRiskCenter ld_general_parameters.text_value%type;

        --<<
        -- vaCodCatRiskCenter variable con el codigo de las categorias comerciales y residenciales
        -- en la tabla ld_parameter el codigo es CREDIT_BUREAU_COD_CATEGORY
        -->>
        vaCodCatRiskCenter ld_general_parameters.parameter_desc%type:='CREDIT_BUREAU_COD_CATEGORY';

        --<<
        -- vaRiskCenter variable con las categorias de riesgo
        -->>
        vaCatRiskCenter ld_general_parameters.text_value%type;

        --<<
        -- vaCategoriProdu variable con la categoria del producto asociado a la orden
        -->>
        vaCategoriProdu pr_product.category_id%type;

        --<<
        -- vaExsLdSendAutrizd variable para validar si ya existe un registro en la tabla ld_send_authorized
        -->>
        vaExsLdSendAutrizd ld_send_authorized.identification%type:=0;

        --<<
        -- vaAuthorized variable que guarda el valor del campo Authorized de la tabla ld_send_authorized
        -->>
        vaAuthorized ld_send_authorized.authorized%type;

        sbErrorMsg  VARCHAR2(200);

        --<<
        -- cuClienteRiesgo cursor que recibe como parametro una orden y devuelve los datos del
        -- cliente que deben de ingresar en la tabla ld_send_authorized.
        -->>
        CURSOR cuClienteRiesgo(vaOrderId or_order.order_id%type) IS
             SELECT  distinct ld_promissory.ident_type_id,
                    ld_promissory.identification,
                    'S' AUTHORIZED,
                    dapr_product.fnugetproduct_type_id(mo_motive.product_id) TYPE_PRODUCT_ID
            FROM    ld_promissory,
                    mo_packages,
                    mo_motive,
                    or_order_activity,
                    or_order
            WHERE   ld_promissory.package_id = mo_packages.package_id
            AND     mo_packages.package_id = mo_motive.package_id
            AND     mo_packages.package_id = or_order_activity.package_id
            AND     or_order_activity.order_id = or_order.order_id
            AND     or_order.order_id =vaOrderId;

        --<<
        -- cuCategorixOrden cursor para obtener la categoria del producto por medio de un numero de orden
        -->>
        CURSOR cuCategorixOrden(vaOrderId or_order.order_id%type)   IS
            SELECT dapr_product.fnugetCategory_id(mo_motive.product_id) categoria
            from or_order, or_order_activity, mo_packages, mo_motive
            where or_order.order_id = or_order_activity.order_id
            and or_order_activity.package_id = mo_packages.package_id
            and mo_packages.package_id = mo_motive.package_id
            and or_order.order_id = vaOrderId
            and rownum = 1;

        --<<
        -- Cursor utilitario para validar si un valor (sbValue) se encuentra en un conjunto de datos (sbDataSet)
        -->>
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


        --<<
        -- vaDatoExiste variable para validar si un valor se encuentra en un conjunto de datos
        -->>
        vaDatoExiste number (2):=0;


  BEGIN
/*  */
        ut_trace.trace('LDC_VAINSLDSENDAUTHORI: Inicia LDC_VAINSLDSENDAUTHORI', 10);


        -- Se obtiene orden de trabajo actual de instancia
        nuCurrentOrderId := or_bolegalizeorder.fnugetcurrentorder;

        ut_trace.trace('LDC_VAINSLDSENDAUTHORI: Orden de trabajo actualmente procesada: '||nuCurrentOrderId, 10);

        -- Se obtiene la causal de la orden de trabajo
        nuCurrentCausalId := daor_order.fnugetcausal_id(nuCurrentOrderId);
        --nuCurrentCausalId :=1;
        ut_trace.trace('LDC_VAINSLDSENDAUTHORI :Causal de la Orden de trabajo actualmente procesada: '
        ||nuCurrentCausalId, 10);

        -- Se obtiene la causal parmetrizada con la que se debe legalizar para que se pueda insertar los datos
        BEGIN
            -- variable con los valores de las causales de riesgo
            SELECT text_value INTO vaCausRiskCenter
            FROM ld_general_parameters
            WHERE parameter_desc = vaCodCausRiskCntr;

            ut_trace.trace('LDC_VAINSLDSENDAUTHORI : Se carga de ld_general_parameters los codigos de las
            causales de riegos CREDIT_BUREAU_LEG_CAUSAL '||vaCausRiskCenter, 10);

       EXCEPTION WHEN NO_DATA_FOUND THEN
            sbErrorMsg := 'No existe valores para el parametro CREDIT_BUREAU_LEG_CAUSAL
                                                    en los parametros de centrales de riesgo';
            ut_trace.trace(sbErrorMsg, 10);
            errors.seterror(Ld_Boconstans.cnuGeneric_Error, sbErrorMsg);
            raise ex.CONTROLLED_ERROR;
       END;

       --se hace la consulta para saber si la causal de legalizacion existe en las causales de riesgo
       OPEN cuValidateData(nuCurrentCausalId,vaCausRiskCenter);
       FETCH cuValidateData INTO vaDatoExiste;
       CLOSE cuValidateData;

        -- Si vaDatoExiste=0 la causal de legalizacion no es una causal de riesgo
       IF(vaDatoExiste = 0)then
          ut_trace.trace('LDC_VAINSLDSENDAUTHORI : la orden no se legalizo con una causal de riesgo numero de causal:
          '||nuCurrentCausalId, 10);
          RETURN;
       END IF;

       BEGIN
            -- variable con los valores de las categorias comercial y residencial
            SELECT text_value into vaCatRiskCenter
            FROM ld_general_parameters
            WHERE parameter_desc = vaCodCatRiskCenter;

        ut_trace.trace('LDC_VAINSLDSENDAUTHORI : Se carga de ld_general_parameters los codigos de las
        ccategorias comercial y residencial '||vaCatRiskCenter, 10);

       EXCEPTION WHEN NO_DATA_FOUND THEN

            sbErrorMsg := 'No existe vcalores para el parametro CREDIT_BUREAU_COD_CATEGORY
                            en los parametros de centrales de riesgo';
            ut_trace.trace(sbErrorMsg, 10);
            errors.seterror(Ld_Boconstans.cnuGeneric_Error, sbErrorMsg);
            raise ex.CONTROLLED_ERROR;
       END;

       --se hace la consulta para saber si la categoria del producto segun el número de orden
        OPEN cuCategorixOrden(nuCurrentOrderId);
        FETCH cuCategorixOrden INTO vaCategoriProdu;
        CLOSE cuCategorixOrden;


       --se hace la consulta para saber si la categoria del producto es residencial o comercial
        OPEN cuValidateData(vaCategoriProdu,vaCatRiskCenter);
        FETCH cuValidateData INTO vaDatoExiste;
        CLOSE cuValidateData;
        ut_trace.trace('LDC_VAINSLDSENDAUTHORI : Se consulta si la categoria del producto es
                        residencial o comercial' , 10);

        -- Si vaDatoExiste=0 la categoria del producto no es comercial o residencial
        if(vaDatoExiste=0)then
          ut_trace.trace('LDC_VAINSLDSENDAUTHORI : la categoria del producto no es comercial o residencial
          numero de la categoria: '||vaCategoriProdu, 10);
          RETURN;
        end if;

         -- se recorre el cursor que trae los datos para insertar en la
         -- tabla ld_send_authorized
         FOR clienteRiesgo in cuClienteRiesgo(nuCurrentOrderId) LOOP

             BEGIN
                 ut_trace.trace('LDC_VAINSLDSENDAUTHORI : ', 10);
                 --se consulta si en la tabla ld_send_authorized ya existe un registro
                 --con esa identificacion y con ese tipo de identificacion

                 SELECT identification, authorized INTO vaExsLdSendAutrizd, vaAuthorized
                 FROM ld_send_authorized
                 WHERE ld_send_authorized.identification = clienteRiesgo.identification
                 AND ld_send_authorized.ident_type_id = clienteRiesgo.ident_type_id
                 AND ld_send_authorized.type_product_id = clienteRiesgo.type_product_id;

                 IF (vaAuthorized='N') then
                  --Actualizar en LD_SEND_AUTHORIZED

                   UPDATE LD_SEND_AUTHORIZED
                   SET AUTHORIZED='S',MODIF_DATE = sysdate
                   WHERE ld_send_authorized.identification = clienteRiesgo.identification
                   and ld_send_authorized.ident_type_id = clienteRiesgo.ident_type_id
                   and ld_send_authorized.type_product_id = clienteRiesgo.type_product_id;

                    ut_trace.trace('LDC_VAINSLDSENDAUTHORI : se actualiza la tabla LD_SEND_AUTHORIZED en el campo
                        authorized=S', 10);
                 END IF;
             EXCEPTION WHEN NO_DATA_FOUND THEN
                 vaExsLdSendAutrizd:=0;
             END;

             ut_trace.trace('LDC_VAINSLDSENDAUTHORI : si la categoria del producto
                es igual a una categoria residencial o comercial se valida que esa persona
                no este en la tabla ld_send_authorized se valida con la variable
                vaExsLdSendAutrizd si es cero se debe de insertar de lo contraio no se
                inserta. vaExsLdSendAutrizd= '||vaExsLdSendAutrizd, 10);

             IF (vaExsLdSendAutrizd=0) THEN
              --insertar en LD_SEND_AUTHORIZED
               INSERT INTO LD_SEND_AUTHORIZED (IDENT_TYPE_ID, IDENTIFICATION, AUTHORIZED, TYPE_PRODUCT_ID,MODIF_DATE)
               VALUES (clienteRiesgo.IDENT_TYPE_ID, clienteRiesgo.IDENTIFICATION, 'S',clienteRiesgo.TYPE_PRODUCT_ID, sysdate);

                ut_trace.trace('LDC_VAINSLDSENDAUTHORI : Realizo el insert en
                LD_SEND_AUTHORIZED', 10);
             END IF;
        END LOOP;
        ut_trace.trace('LDC_VAINSLDSENDAUTHORI: Fin LDC_VAINSLDSENDAUTHORI', 10);

  EXCEPTION
    WHEN ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
    WHEN others then
        Errors.setError;
        raise ex.CONTROLLED_ERROR;
  END LDC_VAINSLDSENDAUTHORI;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre procedimiento LDC_VAINSLDSENDAUTHORI
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_VAINSLDSENDAUTHORI', 'ADM_PERSON'); 
END;
/