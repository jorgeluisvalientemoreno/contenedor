CREATE OR REPLACE PACKAGE LDC_PKGVALGA
IS
    /**************************************************************************
          Proceso     : LDC_PKGVALGA
          Autor       :  Horbath
          Fecha       : 03-06-2020
          Ticket      : 146
          Descripcion :

          HISTORIA DE MODIFICACIONES
          FECHA         AUTOR       DESCRIPCION
          27/05/2024    jpinedc     OSF-2603: PRCVAORGA - Se reemplaza LDC_ENVIAMAIL por
                                              pkg_Correo.prcEnviaCorreo
        ***************************************************************************/


    PROCEDURE PRCRORVAL (nuOrden       IN     or_order.order_id%TYPE,
                         sbComment     IN     or_order_Activity.comment_%TYPE,
                         sberrormess      OUT VARCHAR2,
                         nuOtGaran        OUT or_order.order_id%TYPE);


    PROCEDURE PRCVAORGA;
END LDC_PKGVALGA;
/

CREATE OR REPLACE PACKAGE BODY LDC_PKGVALGA
IS
    csbSP_NAME		CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT||'.';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;

    sbRemitente     ld_parameter.value_chain%TYPE:= pkg_BCLD_Parameter.fsbObtieneValorCadena('LDC_SMTP_SENDER');
        
    PROCEDURE PRCRORVAL (nuOrden       IN     or_order.order_id%TYPE,
                         sbComment     IN     or_order_Activity.comment_%TYPE,
                         sberrormess      OUT VARCHAR2,
                         nuOtGaran        OUT or_order.order_id%TYPE)
    IS
        /**************************************************************************
            Proceso     : PRCRORVAL
            Autor       :  Horbath
            Fecha       : 03-06-2020
            Ticket      : 146
            Descripcion : Proceso generar y asociar orden de validacion de garantia.

            HISTORIA DE MODIFICACIONES
            FECHA        AUTOR       DESCRIPCION
          ***************************************************************************/
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'PRCRORVAL';
        nuError         NUMBER;
        sbError         VARCHAR2(4000); 
          
        PROC_ERROR             EXCEPTION;
        nuactividadgenenar     ge_items.items_id%TYPE;
        sbcomentario           VARCHAR2 (4000);
        nuOrderval             NUMBER := NULL;
        osbErrorMessage        VARCHAR2 (4000);
        onuErrorCode           NUMBER;
        nuUnitop               or_operating_unit.OPERATING_UNIT_ID%TYPE;
        nuPackage              or_order_activity.package_id%TYPE;
        nuMotive               or_order_activity.motive_id%TYPE;
        nuCompon               or_order_activity.component_id%TYPE;
        nuProduct              or_order_activity.product_id%TYPE;
        nuContrato             or_order_activity.subscription_id%TYPE;
        nuAddress_Id           or_order_activity.address_id%TYPE;
        nuCliente              or_order_activity.subscriber_id%TYPE;
        nuNewOrderActivityId   or_order_activity.order_activity_id%TYPE;

        -- Cursor para obtner lo datos de la orden pricipal
        CURSOR CUDAOR (ORDEN NUMBER)
        IS
            SELECT a.package_id,
                   a.MOTIVE_ID,
                   a.component_id,
                   a.PRODUCT_ID,
                   a.SUBSCRIPTION_ID,
                   a.ADDRESS_ID,
                   a.subscriber_id
              FROM or_order_activity a
             WHERE order_id = ORDEN;
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  

        nuactividadgenenar :=
            pkg_BCLD_Parameter.fnuObtieneValorNumerico ('ACTIV_TITR_VALIDA_GARANTIA');


        IF nuactividadgenenar IS NULL
        THEN
            osbErrorMessage :=
                'El parametro ACTIV_TITR_VALIDA_GARANTIA no esta configurado ';
            RAISE PROC_ERROR;
        ELSE
            OPEN CUDAOR (nuOrden);

            FETCH CUDAOR
                INTO nuPackage,
                     nuMotive,
                     nuCompon,
                     nuproduct,
                     nucontrato,
                     nuAddress_Id,
                     nuCliente;

            CLOSE CUDAOR;

            sbcomentario := 'Validacion de garantia :' || sbComment;
            onuErrorCode := NULL;
            osbErrorMessage := NULL;
            -- se genera la orden y actividad de validacion de garantia.
            or_boorderactivities.createactivity (
                inuitemsid            => nuactividadgenenar,
                inupackageid          => nuPackage,
                inumotiveid           => nuMotive,
                INUCOMPONENTID        => nuCompon,
                INUINSTANCEID         => NULL,
                INUADDRESSID          => nuAddress_Id,
                INUELEMENTID          => NULL,
                INUSUBSCRIBERID       => nuCliente,
                INUSUBSCRIPTIONID     => nucontrato,
                INUPRODUCTID          => nuProduct,
                INUOPERSECTORID       => NULL,
                INUOPERUNITID         => NULL,
                IDTEXECESTIMDATE      => NULL,
                INUPROCESSID          => NULL,
                ISBCOMMENT            => sbcomentario,
                IBLPROCESSORDER       => NULL,
                INUPRIORITYID         => NULL,
                IONUORDERID           => nuOrderval,
                IONUORDERACTIVITYID   => nuNewOrderActivityId,
                ISBCOMPENSATE         => NULL,
                INUCONSECUTIVE        => NULL,
                INUROUTEID            => NULL,
                INUROUTECONSECUTIVE   => NULL,
                INULEGALIZETRYTIMES   => 0,                   ---null,200-2686
                ISBTAGNAME            => NULL,
                IBLISACTTOGROUP       => NULL,
                INUREFVALUE           => NULL,
                INUACTIONID           => NULL);

            IF nuOrderval IS NULL
            THEN
                osbErrorMessage := 'Error a generar la orden de validacion';
                RAISE PROC_ERROR;
            ELSE
                -- se relaciona la orden de validacion de garantia con la orden pricipal.
                OS_RELATED_ORDER (nuOrden,
                                  nuOrderval,
                                  onuErrorCode,
                                  osbErrorMessage);

                IF NVL (onuErrorCode, 0) != 0
                THEN
                    RAISE PROC_ERROR;
                ELSE
                    -- se asigna la orden de validacion de garantia a la unidad operativa del parametro UNIDAD_VALIDA_GARANTIA
                    nuUnitop :=
                        pkg_BCLD_Parameter.fnuObtieneValorNumerico ('UNIDAD_VALIDA_GARANTIA');
                        
                    os_assign_order (nuOrderval,
                                     nuUnitop,
                                     SYSDATE,
                                     SYSDATE,
                                     onuerrorcode,
                                     osberrormessage);

                    IF NVL (onuErrorCode, 0) != 0
                    THEN
                        RAISE PROC_ERROR;
                    END IF;
                END IF;
            END IF;
        END IF;

        nuOtGaran := nuOrderval;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);  
    --
    EXCEPTION
        WHEN PROC_ERROR
        THEN
            sberrormess := osbErrorMessage;
        WHEN pkg_Error.CONTROLLED_ERROR
        THEN
            pkg_Error.getError (onuErrorCode, osbErrorMessage);
            sberrormess := osbErrorMessage;
        WHEN OTHERS
        THEN
            sberrormess := osbErrorMessage || SQLERRM;
    END PRCRORVAL;

    --------------------------------------------------------------------------------------------------------------------------
    PROCEDURE PRCVAORGA
    IS
        /**************************************************************************
            Proceso     : PRCVAORGA
            Autor       :  Horbath
            Fecha       : 03-06-2020
            Ticket      : 146
            Descripcion : plugin para enviar correos a la unidad operativa y funcionario,
           cuando se legalize la orden de validacion de garantia.

            HISTORIA DE MODIFICACIONES
            FECHA        AUTOR       DESCRIPCION
          ***************************************************************************/
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'PRCVAORGA';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);           
          
        sbmessageemail   VARCHAR2 (4000);
        sbDescCausal     VARCHAR2 (4000);
        sbEmailUo        or_operating_unit.e_mail%TYPE;
        nuOrden          or_order.order_id%TYPE;
        nuOtPadre        or_order.order_id%TYPE;
        nuUnidPad        or_operating_unit.operating_unit_id%TYPE;
        nuCausal         or_order.causal_id%TYPE;
        sbEmailfun       ld_parameter.value_chain%TYPE
            := pkg_BCLD_Parameter.fsbObtieneValorCadena ('CORREO_FUNCIONARIO_GDC');

        CURSOR CUEMAIL (ORDEN NUMBER)
        IS
            SELECT u.e_mail, ore.order_id, u.operating_unit_id
              FROM or_operating_unit  u,
                   or_order_activity  a,
                   or_related_order   ore
             WHERE     ore.order_id = a.order_id
                   AND u.OPERATING_UNIT_ID = a.OPERATING_UNIT_ID
                   AND ore.related_order_id = ORDEN;

        CURSOR CUR_CAUDESC (cusal NUMBER)
        IS
            SELECT description
              FROM ge_causal
             WHERE CAUSAL_ID = cusal;

    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  

        nuOrden := or_bolegalizeorder.fnuGetCurrentOrder;
        nuCausal := daor_order.fnugetcausal_id (nuOrden);

        OPEN CUR_CAUDESC (nuCausal);

        FETCH CUR_CAUDESC INTO sbDescCausal;

        CLOSE CUR_CAUDESC;

        IF sbDescCausal IS NOT NULL
        THEN
            OPEN CUEMAIL (nuOrden);

            FETCH CUEMAIL INTO sbEmailUo, nuOtPadre, nuUnidPad;

            CLOSE CUEMAIL;

            IF sbEmailUo IS NULL
            THEN
                pkg_error.setErrorMessage( isbMsgErrr =>
                       'La unidad operativa '
                    || nuUnidPad
                    || ' no tiene correo configurado, favor validar');
            END IF;

            IF sbEmailfun IS NULL
            THEN
                pkg_error.setErrorMessage( isbMsgErrr => 'El parametro CORREO_FUNCIONARIO_GDC no ha sido configurado, favor validar');
            END IF;


            sbmessageemail :=
                   'La orden: '
                || nuOrden
                || ' se legalizo con causal: '
                || sbDescCausal
                || ' y comentario de legalizacion: '
                || LDC_REPORTESCONSULTA.FSBOBSERVACIONOT (nuOrden);
                      
            pkg_Correo.prcEnviaCorreo
            (
                isbRemitente        => sbRemitente,
                isbDestinatarios    => sbEmailUo,
                isbAsunto           => 'Orden de validacion de garantia',
                isbMensaje          => sbmessageemail
            );

            pkg_Correo.prcEnviaCorreo
            (
                isbRemitente        => sbRemitente,
                isbDestinatarios    => sbEmailfun,
                isbAsunto           => 'Orden de validacion de garantia',
                isbMensaje          => sbmessageemail
            );

            UPDATE ldc_otlegalizar l
               SET l.mensaje_legalizado =
                          'Termino Validacion Garantias Resultado: '
                       || sbmessageemail
             WHERE l.order_id = nuOtPadre;
        END IF;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        
    EXCEPTION
        WHEN pkg_Error.CONTROLLED_ERROR
        THEN
            RAISE pkg_Error.CONTROLLED_ERROR;
        WHEN OTHERS
        THEN
            pkg_Error.setError;
            RAISE pkg_Error.CONTROLLED_ERROR;
    END PRCVAORGA;
END LDC_PKGVALGA;
/

