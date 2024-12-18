CREATE OR REPLACE PACKAGE LDC_BO_GESTIONSUSPSEG
/*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : LDC_BO_GESTIONSUSPSEG
    Descripcion    : Paquete donde se implementa la lógica para suspensión de seguridad
    Autor          : Horbath
    Fecha          : 01/06/2020
    
    Metodos

    Nombre         :
    Parametros         Descripcion
    ============  ===================


    Historia de Modificaciones
    Fecha               Autor               Modificacion
    =========           =========           ====================
    17/07/2023          jcatuchemvm         OSF-1258: Ajuste por encapsulamiento de
                                            procedimientos open
                                              [Ldc_job_suspensecleg]
                                              [pLegalizaOrdSuspProdSusp]
                                              [prGeneRecoSeguridad]
                                              [prGeneSuspSeguridad]
                                              [pCreaOrdSuspProdSusp]
                                            Se actualizan llamados a métodos errors por los
                                            correspondientes en pkg_error
    01/06/2020          Horbath             Creación
  ******************************************************************/
IS
    PROCEDURE prGeneRecoSeguridad (
        inuProducto     IN     pr_product.product_id%TYPE,
        inuCliente      IN     or_order_activity.subscriber_id%TYPE,
        inuTipoSusp     IN     NUMBER,
        IsbComment      IN     MO_PACKAGES.COMMENT_%TYPE,
        OnuPackage_id      OUT MO_PACKAGES.PACKAGE_ID%TYPE,
        onuMotiveId        OUT MO_MOTIVE.MOTIVE_ID%TYPE,
        onuerror           OUT NUMBER,
        OsbError           OUT VARCHAR2);

    /**************************************************************************
      Autor       :  Horbath
      Fecha       : 2020-06-01
      Proceso     : prGeneRecoSeguridad
      Ticket      : 76
      Descripcion : proceso que genere solicitud de reconexion de seguridad

      Parametros Entrada
       inuProducto   codigo de producto
       inuCliente    codigo del cliente
       IsbComment    comentario de la solicitud

      Valor de salida
       OnuPackage_id  codigo de la solicitud
       onuMotiveId    codigo del motivo creado
       onuerror      codigo de error
       OsbError      mensaje de error

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/

    PROCEDURE prGeneSuspSeguridad (
        inuProducto     IN     pr_product.product_id%TYPE,
        inuCliente      IN     or_order_activity.subscriber_id%TYPE,
        inuTipoSusp     IN     NUMBER,
        InutipoCausal   IN     NUMBER,
        inuCausal       IN     NUMBER,
        IsbComment      IN     MO_PACKAGES.COMMENT_%TYPE,
        OnuPackage_id      OUT MO_PACKAGES.PACKAGE_ID%TYPE,
        onuMotiveId        OUT MO_MOTIVE.MOTIVE_ID%TYPE,
        onuerror           OUT NUMBER,
        OsbError           OUT VARCHAR2);

    /**************************************************************************
      Autor       :  Horbath
      Fecha       : 2020-06-01
      Proceso     : prGeneSuspSeguridad
      Ticket      : 76
      Descripcion : proceso que genere solicitud de suspension de seguridad

      Parametros Entrada
       inuProducto   codigo de producto
       inuCliente    codigo del cliente
       InutipoCausal tipo de causal
       inuCausal     causal de suspension
       IsbComment    comentario de la solicitud

      Valor de salida
       OnuPackage_id  codigo de la solicitud
       onuMotiveId    codigo del motivo creado
       onuerror      codigo de error
       OsbError      mensaje de error

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/

    PROCEDURE ldc_plugsuspensec;

    /**************************************************************************
        Autor       :  Horbath
        Proceso     : ldc_plugsuspensec
        Fecha       : 2021-01-05
        Ticket      : 76
        Descripcion : plugin que genera orden de suspension por seguridad

        Parametros Entrada

        Valor de salida

        HISTORIA DE MODIFICACIONES
        FECHA        AUTOR       DESCRIPCION
      ***************************************************************************/
    PROCEDURE ldc_plugreconexseg;

    /**************************************************************************
         Autor       :  Horbath
         Proceso     : ldc_plugreconexseg
         Fecha       : 2021-01-05
         Ticket      : 76
         Descripcion : plugin que genera orden de reconexion por seguridad

         Parametros Entrada

         Valor de salida

         HISTORIA DE MODIFICACIONES
         FECHA        AUTOR       DESCRIPCION
       ***************************************************************************/
    PROCEDURE Ldc_job_suspensecleg;

    /**************************************************************************
        Autor       :  Horbath
        Proceso     : Ldc_job_suspensecleg
        Fecha       : 2021-01-05
        Ticket      : 76
        Descripcion : Job que legaliza suspension de seguridad

        Parametros Entrada

        Valor de salida

        HISTORIA DE MODIFICACIONES
        FECHA        AUTOR       DESCRIPCION
     05/07/2022   cgonzalez   OSF-414: Se ajusta para obtener el producto de la orden padre
      ***************************************************************************/

    FUNCTION ldc_fsbvalidasuspcemoacomprod (
        nupaproducto   pr_product.product_id%TYPE)
        RETURN VARCHAR2;

    FUNCTION LDC_FNUVALCAUSOLSUS (nuSolicitud NUMBER)
        RETURN NUMBER;

    PROCEDURE ldc_plugsuspensecaco;

    PROCEDURE pCreaOrdSuspProdSusp (
        inuActividad         or_order_activity.activity_id%TYPE,
        inuIdDireccion       or_order_activity.address_id%TYPE,
        inuProducto          or_order_activity.product_id%TYPE,
        inuContrato          or_order_activity.subscription_id%TYPE,
        inuCliente           or_order_activity.subscriber_id%TYPE,
        inuSectorOperativo   or_order_activity.operating_sector_id%TYPE,
        inuUnidadOperativa   or_order_activity.operating_unit_id%TYPE,
        inuSolicitud         or_order_activity.package_id%TYPE,
        inuMotivo            or_order_activity.motive_id%TYPE); 

    PROCEDURE Ldc_job_LegOrdProdYaSusp;
    
END LDC_BO_GESTIONSUSPSEG;
/

CREATE OR REPLACE PACKAGE BODY LDC_BO_GESTIONSUSPSEG
IS
    csbEntrega76    CONSTANT VARCHAR2 (10) := '0000076';
    inuSUSPENSION_TYPE_ID    NUMBER
        := open.dald_parameter.fnuGetNumeric_Value ('LDC_TIPOSUSPRECSEG',
                                                    NULL); --se almacena el tipo de suspension
    nutipoCausal             NUMBER
        := open.dald_parameter.fnuGetNumeric_Value ('LDC_TIPOCAURECSEG',
                                                    NULL); --se almacena el tipo de causal
    nuCausalSol              NUMBER
        := open.dald_parameter.fnuGetNumeric_Value ('LDC_CAUSSUSPRECSEG',
                                                    NULL); --se almacena la causal de suspension
    nuCausalSolAco           NUMBER
        := open.dald_parameter.fnuGetNumeric_Value ('LDC_CAUSSUSPRECSEGACO',
                                                    NULL); --se almacena la causal de suspension x acometida


    cnuSUSPENDIDO       CONSTANT pr_product.product_status_id%TYPE  := 2;
    cnuACTI_YA_SUSP_CM  CONSTANT or_order_activity.activity_id%TYPE := DALD_PARAMETER.FNUGETNUMERIC_VALUE('ACTI_YA_SUSP_CM');
    cnuACTI_YA_SUSP_AC  CONSTANT or_order_activity.activity_id%TYPE := DALD_PARAMETER.FNUGETNUMERIC_VALUE('ACTI_YA_SUSP_AC');
    
    cnuPERID_GEN_CIOR   CONSTANT or_order_activity.activity_id%TYPE := DALD_PARAMETER.FNUGETNUMERIC_VALUE('PERID_GEN_CIOR');
    
    PROCEDURE prGeneRecoSeguridad (
        inuProducto     IN     pr_product.product_id%TYPE,
        inuCliente      IN     or_order_activity.subscriber_id%TYPE,
        inuTipoSusp     IN     NUMBER,
        IsbComment      IN     MO_PACKAGES.COMMENT_%TYPE,
        OnuPackage_id      OUT MO_PACKAGES.PACKAGE_ID%TYPE,
        onuMotiveId        OUT MO_MOTIVE.MOTIVE_ID%TYPE,
        onuerror           OUT NUMBER,
        OsbError           OUT VARCHAR2)
    IS
        /**************************************************************************
          Autor       :  Horbath
          Fecha       : 2020-06-01
          Proceso     : prGeneRecoSeguridad
          Ticket      : 76
          Descripcion : proceso que genere solicitud de reconexion de seguridad

          Parametros Entrada
           inuProducto   codigo de producto
           inuCliente    codigo del cliente
           IsbComment    comentario de la solicitud

          Valor de salida
           OnuPackage_id  codigo de la solicitud
           onuMotiveId    codigo del motivo creado
           onuerror      codigo de error
           OsbError      mensaje de error

          HISTORIA DE MODIFICACIONES
          FECHA        AUTOR        DESCRIPCION
          17/07/2023   jcatuchemvm  OSF-1258: Actualización llamado os_registerrequestwithxml por api_registerRequestByXml
        ***************************************************************************/
        sbRequestXML   VARCHAR2 (4000);                      --se almacena xml
    BEGIN
        sbRequestXML :=
               '<?xml version="1.0" encoding="ISO-8859-1"?>
                    <P_RECONEXION_POR_SEGURIDAD_100343 ID_TIPOPAQUETE="100343">
                    <RECEPTION_TYPE_ID>10</RECEPTION_TYPE_ID>
                    <CONTACT_ID>'
            || inuCliente
            || '</CONTACT_ID>
                    <ADDRESS_ID></ADDRESS_ID>
                    <COMMENT_>'
            || IsbComment
            || '</COMMENT_>
                    <PRODUCT>'
            || inuProducto
            || '</PRODUCT>
                    <TIPO_DE_SUSPENSION>'
            || inuTipoSusp
            || '</TIPO_DE_SUSPENSION>
                  </P_RECONEXION_POR_SEGURIDAD_100343>';

        api_registerRequestByXml(sbRequestXML,
                                   OnuPackage_id,
                                   onuMotiveId,
                                   onuerror,
                                   OsbError);
    EXCEPTION
        WHEN Pkg_Error.CONTROLLED_ERROR
        THEN
            Pkg_Error.getError (onuerror, OsbError);
            RAISE Pkg_Error.CONTROLLED_ERROR;
        WHEN OTHERS
        THEN
            Pkg_Error.setError;
            Pkg_Error.getError (onuerror, OsbError);
            RAISE Pkg_Error.CONTROLLED_ERROR;
    END prGeneRecoSeguridad;

    PROCEDURE prGeneSuspSeguridad (
        inuProducto     IN     pr_product.product_id%TYPE,
        inuCliente      IN     or_order_activity.subscriber_id%TYPE,
        inuTipoSusp     IN     NUMBER,
        InutipoCausal   IN     NUMBER,
        inuCausal       IN     NUMBER,
        IsbComment      IN     MO_PACKAGES.COMMENT_%TYPE,
        OnuPackage_id      OUT MO_PACKAGES.PACKAGE_ID%TYPE,
        onuMotiveId        OUT MO_MOTIVE.MOTIVE_ID%TYPE,
        onuerror           OUT NUMBER,
        OsbError           OUT VARCHAR2)
    IS
        /**************************************************************************
          Autor       :  Horbath
          Fecha       : 2020-06-01
          Proceso     : prGeneSuspSeguridad
          Ticket      : 76
          Descripcion : proceso que genere solicitud de suspension de seguridad

          Parametros Entrada
           inuProducto   codigo de producto
           inuCliente    codigo del cliente
           InutipoCausal tipo de causal
           inuCausal     causal de suspension
           IsbComment    comentario de la solicitud

          Valor de salida
           OnuPackage_id  codigo de la solicitud
           onuMotiveId    codigo del motivo creado
           onuerror      codigo de error
           OsbError      mensaje de error

          HISTORIA DE MODIFICACIONES
          FECHA        AUTOR        DESCRIPCION
          17/07/2023   jcatuchemvm  OSF-1258: Actualización llamado os_registerrequestwithxml por api_registerRequestByXml
        ***************************************************************************/
        sbRequestXML     VARCHAR2 (4000);                    --se almacena xml
        dtFecha_inicio   DATE;                           --fecha de suspension
    BEGIN
        dtFecha_inicio := SYSDATE + 1 / 24 / 60;

        sbRequestXML :=
               '<?xml version="1.0" encoding="ISO-8859-1"?>
                <P_SUSPENSION_POR_SEGURIDAD_XML_100334  ID_TIPOPAQUETE="100334">
                <RECEPTION_TYPE_ID>10</RECEPTION_TYPE_ID>
                <CONTACT_ID>'
            || inuCliente
            || '</CONTACT_ID>
                <ADDRESS_ID></ADDRESS_ID>
                <COMMENT_>'
            || IsbComment
            || '</COMMENT_>
                <PRODUCT>'
            || inuProducto
            || '</PRODUCT>
                <FECHA_DE_SUSPENSION>'
            || dtFecha_inicio
            || '</FECHA_DE_SUSPENSION>
                <TIPO_DE_SUSPENSION>'
            || inuTipoSusp
            || '</TIPO_DE_SUSPENSION>
                <TIPO_DE_CAUSAL>'
            || InutipoCausal
            || '</TIPO_DE_CAUSAL>
                <CAUSAL_ID>'
            || inuCausal
            || '</CAUSAL_ID>
                </P_SUSPENSION_POR_SEGURIDAD_XML_100334>';

        api_registerRequestByXml(sbRequestXML,
                                   OnuPackage_id,
                                   onuMotiveId,
                                   onuerror,
                                   OsbError);
    EXCEPTION
        WHEN Pkg_Error.CONTROLLED_ERROR
        THEN
            Pkg_Error.getError (onuerror, OsbError);
            RAISE Pkg_Error.CONTROLLED_ERROR;
        WHEN OTHERS
        THEN
            Pkg_Error.setError;
            Pkg_Error.getError (onuerror, OsbError);
            RAISE Pkg_Error.CONTROLLED_ERROR;
    END prGeneSuspSeguridad;

    /**************************************************************************
    Autor       :  Lubin Pineda - MVM
    Proceso     : pCreaOrdSuspProdSusp
    Fecha       : 2022-11-22
    Ticket      : OSF-706
    Descripcion : Crea una orden de Suspension en Centro de Medicion para
                  producto ya suspendico con tipo de trabajo 10966
                  y con una actividad del tipo 100006650

    Parametros Entrada

    Valor de salida

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
    17/07/2023  jcatuchemvm  OSF-1258: Actualización llamado or_boorderactivities.createactivity por api_createorder
    18/01/2023  jpinedc-MVM  OSF-814: Se quitan tildes en este encabezado.
                                      Se valida al inicio que la unidad no sea nula.
                                      Se quita rollback
                                      Se quita actualizacio a null del sector operativo
                                      
    12/01/2023  jpinedc-MVM  OSF-814: Se agrega el parametro de entrada
                                      inuMotivo y Se cambia el programa de 
                                      asignacion
    05/01/2023  jpinedc-MVM  OSF-814: Se agregan los parametros de entrada
                                      inuUnidadOperativa e inuSolicitud,
									  Se ajusta para asignar y legalizar
									  la orden generada.
    15/12/2022  jpinedc-MVM  OSF-706: Se cambia el nombre del metodo 
                                      pCreaOrdSuspProdSusp
                                      a pCreaOrdSuspProdSusp.
                                      Se agrega parametro de entrada
                                      inuActividad
                                      Se cambia OS_CreateOrderActivities por
                                      OR_BOORDERACTIVITIES.createActivity
    21/11/2022  jpinedc-MVM  OSF-706: Creacion
    ***************************************************************************/
    PROCEDURE pCreaOrdSuspProdSusp (
        inuActividad         or_order_activity.activity_id%TYPE,
        inuIdDireccion       or_order_activity.address_id%TYPE,
        inuProducto          or_order_activity.product_id%TYPE,
        inuContrato          or_order_activity.subscription_id%TYPE,
        inuCliente           or_order_activity.subscriber_id%TYPE,
        inuSectorOperativo   or_order_activity.operating_sector_id%TYPE,
        inuUnidadOperativa   or_order_activity.operating_unit_id%TYPE,
        inuSolicitud         or_order_activity.package_id%TYPE,
        inuMotivo            or_order_activity.motive_id%TYPE)
    IS
        dtFecha             DATE := SYSDATE;
        sbComentario        or_order_comment.order_comment%TYPE;
        nuOrden             or_order_activity.order_id%TYPE;
        nuIdActividadOrden  or_order_activity.order_activity_id%TYPE;        
        rcOrder             Daor_Order.styOr_Order;
        onuErrorCode        NUMBER;
        osbErrorMessage     VARCHAR2 (4000);

                       
    BEGIN
        ut_trace.trace ('Inicia pCreaOrdSuspProdSusp', 5);

        sbComentario := 'PRODUCTO YA ESTA SUSPENDIDO[' || inuProducto || ']';

        api_createorder  
        (
            inuitemsid => inuActividad,
            inupackageid => inuSolicitud,
            inumotiveid => inuMotivo,
            inucomponentid => NULL,
            inuinstanceid => NULL,
            inuaddressid => inuIdDireccion,
            inuelementid => NULL,
            inusubscriberid => inuCliente,
            inusubscriptionid => inuContrato,
            inuproductid => inuProducto,
            inuoperunitid => NULL,
            idtexecestimdate => dtFecha,
            inuprocessid => NULL,
            isbcomment => sbComentario,
            iblprocessorder => FALSE,
            inupriorityid => NULL,
            inuordertemplateid => NULL,
            isbcompensate => NULL,
            inuconsecutive => NULL,
            inurouteid => NULL,
            inurouteconsecutive => NULL,
            inulegalizetrytimes => 0,
            isbtagname => NULL,
            iblisacttogroup => false,
            inurefvalue => null,
            ionuorderid => nuOrden,
            ionuorderactivityid => nuIdActividadOrden,
            onuErrorCode => onuErrorCode,
            osbErrorMessage => osbErrorMessage                              
        );

        ut_trace.trace ('nuOrden|' || nuOrden, 5);
        
        IF nuOrden is null THEN
          raise Pkg_Error.CONTROLLED_ERROR;
        END IF;
        
        rcOrder := Daor_Order.Frcgetrecord(nuOrden);
                                             
        ut_trace.trace ('Termina pCreaOrdSuspProdSusp', 5);
        
    END pCreaOrdSuspProdSusp;

    PROCEDURE ldc_plugsuspensec
    IS
        /**************************************************************************
          Autor       :  Horbath
          Proceso     : ldc_plugsuspensec
          Fecha       : 2021-01-05
          Ticket      : 76
          Descripcion : plugin que genera orden de suspension por seguridad

          Parametros Entrada

          Valor de salida

          HISTORIA DE MODIFICACIONES
          FECHA        AUTOR       DESCRIPCION
          21/11/2022  jpinedc-MVM  OSF-706: Se modifica para crear orden con tipo de
                                            trabajo 10966 si el producto esta
                                            suspendido
        ***************************************************************************/
        nuOrderId           NUMBER;
        nuTipoCausalId      NUMBER;
        nucausal            NUMBER;
        nuExiste            NUMBER;
        nuProducto          NUMBER;
        nuEstadoProducto    pr_product.product_status_id%TYPE;
        nuIdDireccion       or_order_activity.address_id%TYPE;
        nuContrato          or_order_activity.subscription_id%TYPE;
        nuSectorOperativo   or_order_activity.operating_sector_id%TYPE;
        nuCliente           NUMBER;
        sbcausalesPerm      VARCHAR2 (4000)
            := open.dald_parameter.fsbgetvalue_chain ('PAR_CAUSUSPENSEG',
                                                      NULL);
        nuCausalLeg         NUMBER
            := open.dald_parameter.fnuGetNumeric_Value ('LDC_CAUSLEGSUSPSEG',
                                                        NULL);
        sbComment           VARCHAR2 (4000);
        ERROR               NUMBER;
        nuPackage_id        NUMBER;
        nuMotiveId          NUMBER;
        sbmensa             VARCHAR2 (4000);
        nuUnidadOpera       NUMBER;
        nuPersona           NUMBER;

        sbNombreoAtrib      VARCHAR2 (100)
            := DALD_PARAMETER.FSBGETVALUE_CHAIN ('PARAM_NOMDATO_LECTURA',
                                                 NULL);
        nuCodigoAtrib       NUMBER
            := Dald_parameter.fnuGetNumeric_Value ('PARAM_DATO_LECTURA',
                                                   NULL);
        nuLectura           NUMBER;

        nuSolicitud         or_order_activity.package_id%TYPE;

        nuMotivo           or_order_activity.motive_id%TYPE;
                
        --se obtiene producto y cliente de la orden
        CURSOR cugetProducto IS
            SELECT oa.product_id,
                   oa.subscriber_id,
                   pr.product_status_id,
                   pr.address_id,
                   oa.subscription_id,
                   oa.operating_sector_id,
                   oa.package_id,
                   oa.motive_id
              FROM or_order_activity oa, pr_product pr, ab_address ad
             WHERE     oa.order_id = nuOrderId
                   AND pr.product_id = oa.product_id
                   AND ad.address_id = pr.address_id;
    BEGIN
        IF FBLAPLICAENTREGAXCASO (csbEntrega76)
        THEN
            /*Obtiene el id de la orden en la instancia*/
            nuOrderId := or_bolegalizeorder.fnuGetCurrentOrder ();
            nucausal := daor_order.fnugetcausal_id (nuOrderId, NULL);
            
            nuUnidadOpera := open.daor_order.fnugetoperating_unit_id (nuOrderId,NULL);
                                                                 
            SELECT COUNT (1)
              INTO nuExiste
              FROM (    SELECT TO_NUMBER (REGEXP_SUBSTR (sbcausalesPerm,
                                                         '[^,]+',
                                                         1,
                                                         LEVEL))    AS causal
                          FROM DUAL
                    CONNECT BY REGEXP_SUBSTR (sbcausalesPerm,
                                              '[^,]+',
                                              1,
                                              LEVEL)
                                   IS NOT NULL)
             WHERE causal = nucausal;

            IF nuExiste >= 1
            THEN
                --se carga producto y cliente
                OPEN cugetProducto;

                FETCH cugetProducto
                    INTO nuProducto,
                         nuCliente,
                         nuEstadoProducto,
                         nuIdDireccion,
                         nuContrato,
                         nuSectorOperativo,
                         nuSolicitud,
                         nuMotivo;

                CLOSE cugetProducto;

                IF nuEstadoProducto = cnuSUSPENDIDO
                THEN
                    pCreaOrdSuspProdSusp (  cnuACTI_YA_SUSP_CM,
                                            nuIdDireccion,
                                            nuProducto,
                                            nuContrato,
                                            nuCliente,
                                            nuSectorOperativo,
                                            nuUnidadOpera,
                                            nuSolicitud,
                                            nuMotivo);
                ELSE
                    BEGIN
                        SELECT p.person_id
                          INTO nuPersona
                          FROM open.or_order_person p
                         WHERE p.order_id = nuOrderId;
                    EXCEPTION
                        WHEN OTHERS
                        THEN
                            nuPersona := NULL;
                    END;

                    sbComment :=
                           'SUSPENSION POR SEGURIDAD OT LEGALIZADA['
                        || nuOrderId
                        || ']';

                    nuLectura :=
                        ldc_boordenes.fsbDatoAdicTmpOrden (
                            nuOrderId,
                            nuCodigoAtrib,
                            TRIM (sbNombreoAtrib));

                    IF nuLectura IS NULL
                    THEN
                        sbmensa :=
                               'Proceso termino con errores : '
                            || 'No se ha digitado Lectura';
                        Pkg_Error.setErrorMessage( isbMsgErrr => sbmensa);
                        RAISE Pkg_Error.CONTROLLED_ERROR;
                    END IF;

                    prGeneSuspSeguridad (nuProducto,
                                         nuCliente,
                                         inuSUSPENSION_TYPE_ID,
                                         nutipoCausal,
                                         nuCausalSol,
                                         sbComment,
                                         nuPackage_id,
                                         nuMotiveId,
                                         error,
                                         sbmensa);

                    IF error <> 0
                    THEN
                        Pkg_Error.setErrorMessage( isbMsgErrr => sbmensa);
                        RAISE Pkg_Error.CONTROLLED_ERROR;
                    ELSE
                        INSERT INTO LDC_BLOQ_LEGA_SOLICITUD (PACKAGE_ID_ORIG,
                                                             PACKAGE_ID_GENE)
                             VALUES (NULL, nuPackage_id);

                        INSERT INTO LDC_ORDEASIGPROC (ORAPORPA,
                                                      ORAPSOGE,
                                                      ORAOPELE,
                                                      ORAOUNID,
                                                      ORAOCALE,
                                                      ORAOITEM,
                                                      ORAOPROC)
                             VALUES (nuOrderId,
                                     nuPackage_id,
                                     nuPersona,
                                     nuUnidadOpera,
                                     nuCausalLeg,
                                     NULL,
                                     'SUSPSEGU');
                    END IF;
                END IF;
            END IF;
        END IF;
    EXCEPTION
        WHEN Pkg_Error.CONTROLLED_ERROR
        THEN
            RAISE Pkg_Error.CONTROLLED_ERROR;
        WHEN OTHERS
        THEN
            Pkg_Error.setError;
            RAISE Pkg_Error.CONTROLLED_ERROR;
    END ldc_plugsuspensec;

    PROCEDURE ldc_plugreconexseg
    IS
        /**************************************************************************
             Autor       :  Horbath
             Proceso     : ldc_plugreconexseg
             Fecha       : 2021-01-05
             Ticket      : 76
             Descripcion : plugin que genera orden de reconexion por seguridad

             Parametros Entrada

             Valor de salida

             HISTORIA DE MODIFICACIONES
             FECHA        AUTOR       DESCRIPCION
           ***************************************************************************/
        nuOrderId        NUMBER;
        nuTipoCausalId   NUMBER;
        nucausal         NUMBER;

        nuProducto       NUMBER;
        nuCliente        NUMBER;

        sbComment        VARCHAR2 (4000);
        ERROR            NUMBER;
        nuPackage_id     NUMBER;
        nuMotiveId       NUMBER;
        sbmensa          VARCHAR2 (4000);
        nuExisteSusp     NUMBER := 0;
        nuUnidadOpera    NUMBER;
        nuPersona        NUMBER;
        nuCausalLeg      NUMBER
            := open.dald_parameter.fnuGetNumeric_Value (
                   'LDC_CAUSLEGERECOSEG',
                   NULL);
        sbNombreoAtrib   VARCHAR2 (100)
            := DALD_PARAMETER.FSBGETVALUE_CHAIN ('PARAM_NOMDATO_LECTURA',
                                                 NULL);
        nuCodigoAtrib    NUMBER
            := Dald_parameter.fnuGetNumeric_Value ('PARAM_DATO_LECTURA',
                                                   NULL);
        nuLectura        NUMBER;

        --se obtiene producto y cliente de la orden
        CURSOR cugetProducto IS
            SELECT oa.product_id, oa.subscriber_id
              FROM or_order_activity oa
             WHERE oa.order_id = nuOrderId;

        CURSOR cuValidaSuspension IS
            SELECT 1
              FROM open.pr_product p, open.pr_prod_suspension s
             WHERE     p.product_id = s.product_id
                   AND s.active = 'Y'
                   AND p.product_status_id = 2
                   AND p.product_id = nuProducto
                   AND s.suspension_type_id = inuSUSPENSION_TYPE_ID;
    BEGIN
        IF FBLAPLICAENTREGAXCASO (csbEntrega76)
        THEN
            /*Obtiene el id de la orden en la instancia*/
            nuOrderId := or_bolegalizeorder.fnuGetCurrentOrder ();
            nuTipoCausalId :=
                dage_causal.fnugetclass_causal_id (
                    daor_order.fnugetcausal_id (nuOrderId, NULL),
                    NULL);

            IF nuTipoCausalId = 1
            THEN
                --se carga producto y cliente
                OPEN cugetProducto;

                FETCH cugetProducto INTO nuProducto, nuCliente;

                CLOSE cugetProducto;

                OPEN cuValidaSuspension;

                FETCH cuValidaSuspension INTO nuExisteSusp;

                CLOSE cuValidaSuspension;

                IF nuExisteSusp != 0
                THEN
                    sbComment :=
                           'RECONEXION POR SEGURIDAD OT LEGALIZADA['
                        || nuOrderId
                        || ']';

                    BEGIN
                        SELECT p.person_id
                          INTO nuPersona
                          FROM open.or_order_person p
                         WHERE p.order_id = nuOrderId;
                    EXCEPTION
                        WHEN OTHERS
                        THEN
                            nuPersona := NULL;
                    END;

                    nuUnidadOpera :=
                        open.daor_order.fnugetoperating_unit_id (nuOrderId,
                                                                 NULL);

                    nuLectura :=
                        ldc_boordenes.fsbDatoAdicTmpOrden (
                            nuOrderId,
                            nuCodigoAtrib,
                            TRIM (sbNombreoAtrib));

                    IF nuLectura IS NULL
                    THEN
                        sbmensa :=
                               'Proceso termino con errores : '
                            || 'No se ha digitado Lectura';
                        Pkg_Error.setErrorMessage( isbMsgErrr => sbmensa);
                        RAISE Pkg_Error.CONTROLLED_ERROR;
                    END IF;

                    prGeneRecoSeguridad (nuProducto,
                                         nuCliente,
                                         inuSUSPENSION_TYPE_ID,
                                         sbComment,
                                         nuPackage_id,
                                         nuMotiveId,
                                         error,
                                         sbmensa);

                    IF error <> 0
                    THEN
                        Pkg_Error.setErrorMessage( isbMsgErrr => sbmensa);
                        RAISE Pkg_Error.CONTROLLED_ERROR;
                    ELSE
                        INSERT INTO LDC_BLOQ_LEGA_SOLICITUD (PACKAGE_ID_ORIG,
                                                             PACKAGE_ID_GENE)
                             VALUES (NULL, nuPackage_id);

                        INSERT INTO LDC_ORDEASIGPROC (ORAPORPA,
                                                      ORAPSOGE,
                                                      ORAOPELE,
                                                      ORAOUNID,
                                                      ORAOCALE,
                                                      ORAOITEM,
                                                      ORAOPROC)
                             VALUES (nuOrderId,
                                     nuPackage_id,
                                     nuPersona,
                                     nuUnidadOpera,
                                     nuCausalLeg,
                                     NULL,
                                     'RECOSEGU');
                    END IF;
                END IF;
            END IF;
        END IF;
    EXCEPTION
        WHEN Pkg_Error.CONTROLLED_ERROR
        THEN
            RAISE Pkg_Error.CONTROLLED_ERROR;
        WHEN OTHERS
        THEN
            Pkg_Error.setError;
            RAISE Pkg_Error.CONTROLLED_ERROR;
    END ldc_plugreconexseg;

    PROCEDURE Ldc_job_suspensecleg
    IS
        /**************************************************************************
            Autor       :  Horbath
            Proceso     : Ldc_job_suspensecleg
            Fecha       : 2021-01-05
            Ticket      : 76
            Descripcion : Job que legaliza suspension de seguridad

            Parametros Entrada

            Valor de salida

            HISTORIA DE MODIFICACIONES
            FECHA        AUTOR        DESCRIPCION
          17/07/2023   jcatuchemvm    OSF-1258: Actualización llamados OS_LEGALIZEORDERS por API_LEGALIZEORDERS y
                                      OS_ASSIGN_ORDER por api_assign_order
          05/07/2022   cgonzalez      OSF-414: Se ajusta para obtener el producto de la orden padre
          ***************************************************************************/
        dtFechaAsig      DATE;               --se almacena fecha de asigancion
        dtFechaEjecIni   DATE;         --se almacena fecha inicio de ejecucion
        dtFechaEjecfIN   DATE;            --se almacena fecha fin de ejecucion
        nuClaseCausal    NUMBER;                 --se almacena clase de causal
        nuTipoSuspLega   NUMBER; -- se almacena tipo de suspension a legalizar
        sbmedidor        VARCHAR2 (100);    --se almacena medidor del producto
        nuLectura        NUMBER;          --se alamacena lectura de suspension
        nuOk             NUMBER;
        sbCadenalega     VARCHAR2 (4000); --se almacena cadena de legalizacion
        nuEstadoRegOt    NUMBER
            := dald_parameter.fnuGetNumeric_Value ('COD_STATUS_REG', NULL); --se almacena estado de regsitrado de la orden
        nuParaLectura    NUMBER
            := Dald_parameter.fnuGetNumeric_Value ('PARAM_DATO_LECTURA',
                                                   NULL);

        --variables para el log
        nuparano         NUMBER;
        nuparmes         NUMBER;
        nutsess          NUMBER;
        sbparuser        VARCHAR2 (4000);
        sberrormessage   VARCHAR2 (4000);
        nuerrorcode      NUMBER;
        nuOrden          NUMBER;

        --obtiene ordedes de suspension a legalizar
        CURSOR cuOrdenSuspension IS
            SELECT ot.order_id,
                   NVL (oa.product_id,
                        (SELECT a.product_id
                           FROM or_order_activity a
                          WHERE a.order_id = S.ORAPORPA AND ROWNUM = 1))
                       product_id,
                   oa.ORDER_ACTIVITY_ID,
                   S.ORAOUNID,
                   S.ORAOPELE,
                   S.ORAOCALE,
                   S.ORAOITEM,
                   S.ORAPORPA,
                   s.ORAPSOGE
              FROM or_order_activity oa, or_order ot, LDC_ORDEASIGPROC s
             WHERE     s.ORAPSOGE = oa.package_id
                   AND oa.order_id = ot.order_id
                   AND ot.order_status_id = nuEstadoRegOt
                   AND s.ORAOPROC IN ('SUSPSEGU', 'RECOSEGU')
                   AND s.ORAOUNID IS NOT NULL;

        --se obtiene datos de la orden padre
        CURSOR cugetdatoOrdePadre (inuOrden NUMBER)
        IS
            SELECT ot.ASSIGNED_DATE,
                   ot.EXEC_INITIAL_DATE,
                   ot.EXECUTION_FINAL_DATE
              FROM or_order ot
             WHERE ot.order_id = inuOrden;

        --se consulta medidor ylectura de instalacion
        CURSOR cugetLectMedi (nuProducto pr_product.product_id%TYPE)
        IS
            SELECT leemleto
              FROM (  SELECT leemfele, leemleto
                        FROM open.lectelme
                       WHERE leemsesu = nuProducto AND leemleto IS NOT NULL
                    -- and LEEMCLEC = 'F'
                    ORDER BY leemfele DESC)
             WHERE ROWNUM = 1;

        --se consulta medidor ylectura de instalacion
        CURSOR cugetMedidor (nuProducto pr_product.product_id%TYPE)
        IS
            SELECT em.emsscoem
              FROM elmesesu em
             WHERE em.emsssesu = nuProducto AND em.emssfere > SYSDATE;

        -- se valida la clasificacion de la causal
        CURSOR cuTipoCausal (nuCausal ge_causal.CAUSAL_ID%TYPE)
        IS
            SELECT DECODE (CLASS_CAUSAL_ID,  1, 1,  2, 0)     tipo
              FROM ge_causal
             WHERE CAUSAL_ID = nuCausal;


        CURSOR cuLecturaOrdePadre (nuParametro NUMBER, nuOt NUMBER)
        IS
            SELECT DECODE (s.capture_order,
                           1, value_1,
                           2, value_2,
                           3, value_3,
                           4, value_4,
                           5, value_5,
                           6, value_6,
                           7, value_7,
                           8, value_8,
                           9, value_9,
                           10, value_10,
                           11, value_11,
                           12, value_12,
                           13, value_13,
                           14, value_14,
                           15, value_15,
                           16, value_16,
                           17, value_17,
                           18, value_18,
                           19, value_19,
                           20, value_20,
                           'NA')    lectura
              FROM OPEN.or_tasktype_add_data  d,
                   OPEN.ge_attrib_set_attrib  s,
                   OPEN.ge_attributes         A,
                   OPEN.or_requ_data_value    r,
                   OPEN.or_order              o
             WHERE     d.task_type_id = o.task_type_id
                   AND d.attribute_set_id = s.attribute_set_id
                   AND s.attribute_id = a.attribute_id
                   AND r.attribute_set_id = d.attribute_set_id
                   AND r.order_id = o.order_id
                   AND o.order_id = nuOt
                   AND d.active = 'Y'
                   AND A.attribute_id = nuParametro;
    BEGIN
        IF FBLAPLICAENTREGAXCASO (csbEntrega76)
        THEN
            -- Consultamos datos para inicializar el proceso
            SELECT TO_NUMBER (TO_CHAR (SYSDATE, 'YYYY')),
                   TO_NUMBER (TO_CHAR (SYSDATE, 'MM')),
                   USERENV ('SESSIONID'),
                   USER
              INTO nuparano,
                   nuparmes,
                   nutsess,
                   sbparuser
              FROM DUAL;

            -- Inicializamos el proceso
            ldc_proinsertaestaprog (nuparano,
                                    nuparmes,
                                    'LDC_JOB_SUSPENSECLEG',
                                    'En ejecucion',
                                    nutsess,
                                    sbparuser);

            FOR reg IN cuOrdenSuspension
            LOOP
                --se setean valores iniciales
                nuerrorcode := NULL;
                sberrormessage := NULL;
                nuOrden := NULL;
                nuOrden := reg.order_id;
                nuClaseCausal := NULL;
                nuOk := 0;

                IF nuOrden IS NOT NULL
                THEN
                    OPEN cugetdatoOrdePadre (reg.ORAPORPA);

                    FETCH cugetdatoOrdePadre
                        INTO dtFechaAsig, dtFechaEjecIni, dtFechaEjecfIN;

                    IF cugetdatoOrdePadre%NOTFOUND
                    THEN
                        sberrormessage :=
                               'No existen datos de orden Padre: ['
                            || nuOrden
                            || ']';
                        --   proRegistraLogLegOrdRecoSusp('JOB_LEGAORDENRECOYSUSPADMI', SYSDATE,NULL, nuOrden, sbmensa,USER );
                        LDC_PKGREPEGELERECOYSUSP.proRegistraLogLegOrdRecoSusp (
                            'LDC_JOB_SUSPENSECLEG-INFORD',
                            SYSDATE,
                            nuOrden,
                            reg.ORAPORPA,
                            sberrormessage,
                            USER);
                        nuOk := -1;
                    END IF;

                    CLOSE cugetdatoOrdePadre;

                    OPEN cuLecturaOrdePadre (nuParaLectura, reg.ORAPORPA);

                    FETCH cuLecturaOrdePadre INTO nuLectura;

                    IF cuLecturaOrdePadre%NOTFOUND
                    THEN
                        --se obtiene lectura y medidor
                        OPEN cugetLectMedi (reg.product_id);

                        FETCH cugetLectMedi INTO nuLectura;

                        CLOSE cugetLectMedi;
                    END IF;

                    CLOSE cuLecturaOrdePadre;


                    IF nuok <> -1
                    THEN
                        DELETE LDC_BLOQ_LEGA_SOLICITUD
                         WHERE PACKAGE_ID_GENE = reg.ORAPSOGE;

                        --Actualizar producto en la actividad de la orden
                        daor_order_activity.updProduct_Id (
                            reg.ORDER_ACTIVITY_ID,
                            reg.product_id);

                        -- se procede asignar la orden generada
                        api_assign_order (nuOrden,
                                         reg.ORAOUNID,
                                         nuerrorcode,
                                         sberrormessage);

                        IF nuerrorcode = 0
                        THEN
                            UPDATE or_order
                               SET ASSIGNED_DATE = dtFechaAsig
                             WHERE ORDER_ID = nuOrden;

                            UPDATE OR_ORDER_STAT_CHANGE
                               SET STAT_CHG_DATE = dtFechaAsig,
                                   EXECUTION_DATE = dtFechaAsig
                             WHERE     INITIAL_STATUS_ID = 0
                                   AND FINAL_STATUS_ID = 5
                                   AND order_id = nuOrden;

                            -- commit;
                            DBMS_LOCK.sleep (1);
                            nuerrorcode := NULL;
                            sberrormessage := NULL;

                            --se obtiene clase de causal
                            OPEN cuTipoCausal (reg.ORAOCALE);

                            FETCH cuTipoCausal INTO nuClaseCausal;

                            CLOSE cuTipoCausal;

                            IF nuClaseCausal = 1
                            THEN
                                OPEN cugetMedidor (reg.product_id);

                                FETCH cugetMedidor INTO sbmedidor;

                                CLOSE cugetMedidor;


                                --ut_trace.trace ('lectura '||nuLectura||' sbmedidor '||sbmedidor);
                                sbCadenalega :=
                                       nuOrden
                                    || '|'
                                    || reg.ORAOCALE
                                    || '|'
                                    || REG.ORAOPELE
                                    || '||'
                                    || reg.ORDER_ACTIVITY_ID
                                    || '>'
                                    || nuClaseCausal
                                    || ';READING>'
                                    || NVL (nuLectura, '')
                                    || '>9>;COMMENT1>>>;COMMENT2>>>;COMMENT3>>>||'
                                    || sbmedidor
                                    || ';1='
                                    || NVL (nuLectura, '')
                                    || '=T===|'
                                    || '1277;Orden Legalizada por proceso PRJOBASIGLEGORSN';
                            ELSE
                                sbCadenalega :=
                                       nuOrden
                                    || '|'
                                    || reg.ORAOCALE
                                    || '|'
                                    || REG.ORAOPELE
                                    || '||'
                                    || reg.ORDER_ACTIVITY_ID
                                    || '>'
                                    || nuClaseCausal
                                    || ';;READING>>>;COMMENT1>>>;COMMENT2>>>;COMMENT3>>>|||1277;Orden Legalizada por proceso PRJOBASIGLEGORSN';
                            END IF;

                            -- se procede a legalizar la orden de trabajo
                            api_legalizeorders (sbCadenalega,
                                               dtFechaEjecIni,
                                               SYSDATE,
                                               NULL,
                                               nuerrorcode,
                                               sberrormessage);
                            DBMS_LOCK.sleep (2);

                            -- se valida que todo alla terminado bien
                            IF nuerrorcode = 0
                            THEN
                                COMMIT;
                            ELSE
                                --se llena log
                                LDC_PKGREPEGELERECOYSUSP.proRegistraLogLegOrdRecoSusp (
                                    'LDC_JOB_SUSPENSECLEG-LEGA',
                                    SYSDATE,
                                    nuOrden,
                                    reg.ORAPORPA,
                                    sberrormessage,
                                    USER);
                                ROLLBACK;
                            END IF;
                        ELSE
                            --se llena log
                            LDC_PKGREPEGELERECOYSUSP.proRegistraLogLegOrdRecoSusp (
                                'LDC_JOB_SUSPENSECLEG-ASIG',
                                SYSDATE,
                                nuOrden,
                                reg.ORAPORPA,
                                sberrormessage,
                                USER);
                            ROLLBACK;
                        END IF;
                    END IF;
                END IF;
            END LOOP;

            ldc_proactualizaestaprog (nutsess,
                                      sberrormessage,
                                      'LDC_JOB_SUSPENSECLEG',
                                      'Ok');
        END IF;
    EXCEPTION
        WHEN Pkg_Error.CONTROLLED_ERROR
        THEN
            Pkg_Error.getError (nuerrorcode, sberrormessage);
            LDC_PKGREPEGELERECOYSUSP.proRegistraLogLegOrdRecoSusp (
                'LDC_JOB_SUSPENSECLEG',
                SYSDATE,
                nuOrden,
                NULL,
                sberrormessage,
                USER);
            ROLLBACK;
        WHEN OTHERS
        THEN
            Pkg_Error.setError;
            Pkg_Error.getError (nuerrorcode, sberrormessage);
            ldc_proactualizaestaprog (nutsess,
                                      sberrormessage,
                                      'LDC_JOB_SUSPENSECLEG',
                                      'Ok');
            LDC_PKGREPEGELERECOYSUSP.proRegistraLogLegOrdRecoSusp (
                'LDC_JOB_SUSPENSECLEG',
                SYSDATE,
                nuOrden,
                NULL,
                sberrormessage,
                USER);
            ROLLBACK;
    END Ldc_job_suspensecleg;

    FUNCTION ldc_fsbvalidasuspcemoacomprod (
        nupaproducto   pr_product.product_id%TYPE)
        RETURN VARCHAR2
    IS
        /**************************************************************************************
        Propiedad Intelectual de Gases del caribe S.A E.S.P

        Funcion     : ldc_fsbvalidasuspcemoacomprod
        Descripcion : funcion retorna si el producto es suspendido desde centro de medicion o acometida
                      esto para las actividades de suspension por seguridad


        Historia de Modificaciones
          Fecha               Autor                Modificacion
        =========           =========          ====================
        ***************************************************************************************/
        CURSOR cudatosulactsusp (nucuproducto NUMBER)
        IS
            SELECT fecha_registro_actividad, actividad
              FROM (  SELECT x.register_date     fecha_registro_actividad,
                             x.activity_id       actividad
                        FROM open.or_order_activity x
                       WHERE x.order_id IN
                                 (SELECT d.order_id
                                    FROM open.or_order_activity d
                                   WHERE d.order_activity_id IN
                                             (SELECT p.suspen_ord_act_id
                                                FROM pr_product p
                                               WHERE p.product_id =
                                                     nucuproducto))
                    ORDER BY x.register_date DESC)
             WHERE ROWNUM = 1;

        nuactsuscmacom   or_order_activity.activity_id%TYPE;
        sbresultado      VARCHAR2 (2);
    BEGIN
        -- Ultima actividad de suspension
        FOR i IN cudatosulactsusp (nupaproducto)
        LOOP
            nuactsuscmacom := i.actividad;

            -- Suspension por centro de medicion.
            FOR j
                IN (SELECT TO_NUMBER (COLUMN_VALUE)     actividad_cm
                      FROM TABLE (
                               ldc_boutilities.splitstrings (
                                   dald_parameter.fsbGetValue_Chain (
                                       'LDC_ACTIVIDAD_SUSPSEGU_CM',
                                       NULL),
                                   ',')))
            LOOP
                IF nuactsuscmacom = j.actividad_cm
                THEN
                    sbresultado := 'CM';
                    EXIT;
                END IF;
            END LOOP;

            -- Suspension por acometida.
            FOR j
                IN (SELECT TO_NUMBER (COLUMN_VALUE)     actividad_am
                      FROM TABLE (
                               ldc_boutilities.splitstrings (
                                   dald_parameter.fsbGetValue_Chain (
                                       'LDC_ACTIVIDAD_SUSPSEGU_ACO',
                                       NULL),
                                   ',')))
            LOOP
                IF nuactsuscmacom = j.actividad_am
                THEN
                    sbresultado := 'AC';
                    EXIT;
                END IF;
            END LOOP;
        END LOOP;

        IF sbresultado NOT IN ('CM', 'AC')
        THEN
            sbresultado := '--';
        END IF;

        RETURN sbresultado;
    EXCEPTION
        WHEN OTHERS
        THEN
            sbresultado := '--';
            RETURN sbresultado;
    END;

    FUNCTION LDC_FNUVALCAUSOLSUS (nuSolicitud NUMBER)
        RETURN NUMBER
    IS
        /**********************************************************************
        Propiedad intelectual de Arquitecsoft
        Nombre   LDC_FNUVALCAUSOLSUS
        Autor    GDC

        Descripcion: SERIVICIO PARA VALIDAR SI EL CAUSAL DE LA SOLICITUD ESTA RELACIONADA
                     AL PARAMETRO LDC_CAUSSUSPRECSEG

        Historia de Modificaciones
        Fecha             Autor             Modificacion
        ***********************************************************************/

        nuCausalExsite      NUMBER;

        CURSOR cuCausalSolicitud IS
            SELECT mm.causal_id
              FROM open.mo_motive mm
             WHERE mm.package_id = nuSolicitud;

        nuCausalSolicitud   NUMBER;
        nuCausalParametro   NUMBER;
        nuCausalParamAcom   NUMBER;
    BEGIN
        OPEN cuCausalSolicitud;

        FETCH cuCausalSolicitud INTO nuCausalSolicitud;

        CLOSE cuCausalSolicitud;

        nuCausalParametro :=
            dald_parameter.fnuGetNumeric_Value ('LDC_CAUSSUSPRECSEG', 0);
        nuCausalParamAcom :=
            dald_parameter.fnuGetNumeric_Value ('LDC_CAUSSUSPRECSEGACO', 0);



        nuCausalExsite := 0;

        IF nuCausalSolicitud = nuCausalParametro
        THEN
            nuCausalExsite := 1;
        ELSE
            IF nuCausalSolicitud = nuCausalParamAcom
            THEN
                nuCausalExsite := 2;
            END IF;
        END IF;

        RETURN nuCausalExsite;
    EXCEPTION
        WHEN OTHERS
        THEN
            RETURN 0;
    END;

    PROCEDURE ldc_plugsuspensecaco
    IS
        /**************************************************************************
          Autor       :  Horbath
          Proceso     : ldc_plugsuspensecaco
          Fecha       : 2021-01-05
          Ticket      : 76
          Descripcion : plugin que genera orden de suspension por seguridad x aco

          Parametros Entrada

          Valor de salida

          HISTORIA DE MODIFICACIONES
          FECHA        AUTOR       DESCRIPCION
          21/11/2022  jpinedc-MVM  OSF-706: Se modifica para crear orden con tipo de
                                            trabajo 10966 si el producto esta
                                            suspendido
        ***************************************************************************/
        nuOrderId           NUMBER;
        nuTipoCausalId      NUMBER;
        nucausal            NUMBER;
        nuExiste            NUMBER;
        nuProducto          NUMBER;
        nuEstadoProducto    pr_product.product_status_id%TYPE;
        nuIdDireccion       or_order_activity.address_id%TYPE;
        nuContrato          or_order_activity.subscription_id%TYPE;
        nuSectorOperativo   or_order_activity.operating_sector_id%TYPE;
        nuCliente           NUMBER;
        sbcausalesPerm      VARCHAR2 (4000)
            := open.dald_parameter.fsbgetvalue_chain ('PAR_CAUSUSPENSEGACO',
                                                      NULL);
        nuCausalLeg         NUMBER
            := open.dald_parameter.fnuGetNumeric_Value (
                   'LDC_CAUSLEGSUSPSEGACO',
                   NULL);
        sbComment           VARCHAR2 (4000);
        ERROR               NUMBER;
        nuPackage_id        NUMBER;
        nuMotiveId          NUMBER;
        sbmensa             VARCHAR2 (4000);
        nuUnidadOpera       NUMBER;
        nuPersona           NUMBER;
        nuTitr              open.or_Task_type.task_Type_id%TYPE;
        nuActividad         open.ge_items.items_id%TYPE;
        sbActivPermi        open.ld_parameter.value_chain%TYPE
            := open.dald_parameter.fsbGetValue_Chain (
                   'ACTIVIDAD_GEN_SUSPXSEGURXACO',
                   NULL);
    
        nuSolicitud         or_order_activity.package_id%TYPE;
        
        nuMotivo            or_order_activity.motive_id%TYPE;

        --se obtiene producto y cliente de la orden
        CURSOR cugetProducto IS
            SELECT oa.product_id,
                   oa.subscriber_id,
                   oa.activity_id,
                   pr.product_status_id,
                   pr.address_id,
                   oa.subscription_id,
                   oa.operating_sector_id,
                   oa.package_id,
                   oa.motive_id
              FROM or_order_activity oa, pr_product pr
             WHERE     oa.order_id = nuOrderId
                   AND oa.task_type_id = nuTitr
                   AND oa.final_date IS NULL
                   AND pr.product_id = oa.product_id;
    BEGIN
        IF FBLAPLICAENTREGAXCASO (csbEntrega76)
        THEN
            /*Obtiene el id de la orden en la instancia*/
            nuOrderId := or_bolegalizeorder.fnuGetCurrentOrder ();
            nucausal := daor_order.fnugetcausal_id (nuOrderId, NULL);
            nuTitr := daor_order.fnugettask_type_id (nuOrderId, NULL);
            nuUnidadOpera := open.daor_order.fnugetoperating_unit_id ( nuOrderId, NULL);

            SELECT COUNT (1)
              INTO nuExiste
              FROM (    SELECT TO_NUMBER (REGEXP_SUBSTR (sbcausalesPerm,
                                                         '[^,]+',
                                                         1,
                                                         LEVEL))    AS causal
                          FROM DUAL
                    CONNECT BY REGEXP_SUBSTR (sbcausalesPerm,
                                              '[^,]+',
                                              1,
                                              LEVEL)
                                   IS NOT NULL)
             WHERE causal = nucausal;

            IF nuExiste >= 1
            THEN
                --se carga producto y cliente
                OPEN cugetProducto;

                FETCH cugetProducto
                    INTO nuProducto,
                         nuCliente,
                         nuActividad,
                         nuEstadoProducto,
                         nuIdDireccion,
                         nuContrato,
                         nuSectorOperativo,
                         nuSolicitud,
                         nuMotivo;

                CLOSE cugetProducto;

                nuExiste := 0;

                SELECT COUNT (1)
                  INTO nuExiste
                  FROM (    SELECT TO_NUMBER (REGEXP_SUBSTR (sbActivPermi,
                                                             '[^,]+',
                                                             1,
                                                             LEVEL))    AS actividad
                              FROM DUAL
                        CONNECT BY REGEXP_SUBSTR (sbActivPermi,
                                                  '[^,]+',
                                                  1,
                                                  LEVEL)
                                       IS NOT NULL)
                 WHERE actividad = nuActividad;

                IF nuExiste >= 1
                THEN
                    IF nuEstadoProducto = cnuSUSPENDIDO
                    THEN
                        pCreaOrdSuspProdSusp (  cnuACTI_YA_SUSP_AC,
                                                nuIdDireccion,
                                                nuProducto,
                                                nuContrato,
                                                nuCliente,
                                                nuSectorOperativo,
                                                nuUnidadOpera,
                                                nuSolicitud,
                                                nuMotivo);
                    ELSE
                        BEGIN
                            SELECT p.person_id
                              INTO nuPersona
                              FROM open.or_order_person p
                             WHERE p.order_id = nuOrderId;
                        EXCEPTION
                            WHEN OTHERS
                            THEN
                                nuPersona := NULL;
                        END;

                        sbComment :=
                               'SUSPENSION POR SEGURIDAD ACOMETIDA OT LEGALIZADA['
                            || nuOrderId
                            || ']';

                        prGeneSuspSeguridad (nuProducto,
                                             nuCliente,
                                             inuSUSPENSION_TYPE_ID,
                                             nutipoCausal,
                                             nuCausalSolAco,
                                             sbComment,
                                             nuPackage_id,
                                             nuMotiveId,
                                             error,
                                             sbmensa);

                        IF error <> 0
                        THEN
                            Pkg_Error.setErrorMessage( isbMsgErrr => sbmensa);
                            RAISE Pkg_Error.CONTROLLED_ERROR;
                        ELSE
                            INSERT INTO LDC_BLOQ_LEGA_SOLICITUD (
                                            PACKAGE_ID_ORIG,
                                            PACKAGE_ID_GENE)
                                 VALUES (NULL, nuPackage_id);

                            INSERT INTO LDC_ORDEASIGPROC (ORAPORPA,
                                                          ORAPSOGE,
                                                          ORAOPELE,
                                                          ORAOUNID,
                                                          ORAOCALE,
                                                          ORAOITEM,
                                                          ORAOPROC)
                                 VALUES (nuOrderId,
                                         nuPackage_id,
                                         nuPersona,
                                         nuUnidadOpera,
                                         nuCausalLeg,
                                         NULL,
                                         'SUSPSEGU');
                        END IF;
                    END IF;
                END IF;
            END IF;
        END IF;
    EXCEPTION
        WHEN Pkg_Error.CONTROLLED_ERROR
        THEN
            RAISE Pkg_Error.CONTROLLED_ERROR;
        WHEN OTHERS
        THEN
            Pkg_Error.setError;
            RAISE Pkg_Error.CONTROLLED_ERROR;
    END ldc_plugsuspensecaco;
    
    PROCEDURE Ldc_job_LegOrdProdYaSusp
    IS
        /**************************************************************************
            Autor       :  Lubin Pineda
            Proceso     :  Ldc_job_LegOrdProdYaSusp
            Fecha       : 2023-01-20
            Ticket      : OSF-714
            Descripcion : Job que legaliza ordenes de producto ya suspendido

            Parametros Entrada

            Valor de salida

            HISTORIA DE MODIFICACIONES
            FECHA        AUTOR        DESCRIPCION
            17/07/2023   jcatuchemvm  OSF-1258: Actualización llamado OS_ASSIGN_ORDER por api_assign_order
                                      en procedimiento privado pLegalizaOrdSuspProdSusp          
          ***************************************************************************/

        --variables para el log
        nuparano         NUMBER;
        nuparmes         NUMBER;
        nutsess          NUMBER;
        sbparuser        VARCHAR2 (4000);
        sberrormessage   VARCHAR2 (4000);
        nuerrorcode      NUMBER;
        nuOrden          NUMBER;
        
        nuUltOrden       or_order.order_id%TYPE := -1;
        
        sbProceso        ldc_osf_estaproc.proceso%TYPE; 
        
        CURSOR cuOrdXLeg ( inuUltOrden or_order.order_id%TYPE) IS
        SELECT
        oa.comment_,
        oa.order_activity_id, 
        oa.order_id,
        oa.task_type_id,
        ( SELECT description FROM or_task_type tt WHERE tt.task_type_id = oa.task_type_id ) desc_task_type,
        oa.activity_id,
        ( SELECT description FROM ge_items it WHERE it.items_id = oa.activity_id ) desc_actividad,
        oa.product_id,
        od.created_date,
        od.legalization_date,
        oa.package_id
        from or_order_activity oa,
        or_order od
        where
            oa.task_type_id = 10966
        AND oa.order_id > inuUltOrden
        AND oa.comment_ like 'PRODUCTO YA ESTA SUSPENDIDO[%'
        AND od.order_id = oa.order_id
        AND od.order_status_id = 0
        AND oD.legalization_date IS NULL
        AND oa.activity_id in
        (
            select numeric_value from LD_PARAMETER
            where parameter_id in ( 'ACTI_YA_SUSP_CM','ACTI_YA_SUSP_AC')
        )
        order by oa.order_id asc;
        
        TYPE tytbOrdXLeg IS TABLE OF cuOrdXLeg%ROWTYPE
        INDEX BY BINARY_INTEGER;
        
        tbOrdXLeg tytbOrdXLeg;
            
        CURSOR cuOrdenTT_12155( inProducto NUMBER, idtFechCrea DATE, inuSolicitud NUMBER ) IS
        SELECT oa.*
        FROM or_order_activity oa,
        or_order od
        WHERE oa.product_id = inProducto
        AND oa.task_type_id+0 = 12155
        AND od.order_id = oa.order_id
        AND od.order_status_id+0 = 8
        AND oa.package_id = inuSolicitud;
        
        TYPE tytbOrdenTT_12155 IS TABLE OF cuOrdenTT_12155%ROWTYPE INDEX BY BINARY_INTEGER;
        
        tbOrdenTT_12155 tytbOrdenTT_12155;
        
        PROCEDURE pLegalizaOrdSuspProdSusp (
            inuOrden             or_order_activity.order_id%TYPE,
            inuUnidadOperativa   or_order_activity.operating_unit_id%TYPE)
        IS
        
            dtFecha             DATE := SYSDATE;

            nuError             NUMBER;
            sbMessage           VARCHAR2(4000);
            
            rcOrder             Daor_Order.styOr_Order;
            
            nuCausal_Usr_Susp   ge_causal.causal_id%TYPE := 3311;
            
            onuCodError         NUMBER;
            osbMensError        VARCHAR2(4000);
                   
        BEGIN
            ut_trace.trace  ('Inicia pLegalizaOrdSuspProdSusp', 5);

            ut_trace.trace  ('inuOrden|' || inuOrden, 5);
            
            if inuUnidadOperativa is null then
                LDC_PKGREPEGELERECOYSUSP.proRegistraLogLegOrdRecoSusp (
                    sbProceso,
                    SYSDATE,
                    inuOrden,
                    NULL,
                    'La unidad operativa no puede ser nula',
                    USER);
            ELSE

                rcOrder := Daor_Order.Frcgetrecord(inuOrden);

                ut_trace.trace  ('Order_Status_id1|' || rcOrder.Order_Status_Id, 5 );
                                                       
                api_assign_order
                (
                    inuOrden,
                    inuUnidadOperativa,
                    nuError,
                    sbMessage
                );

                IF nuError <> pkConstante.Exito THEN
                
                    ROLLBACK;
                    
                    sberrormessage := 'Error asignando['|| sbMessage || ']Unidad['  ||
                                                     inuUnidadOperativa || ']Orden[' ||
                                                     inuOrden || ']';
                                                     
                    LDC_PKGREPEGELERECOYSUSP.proRegistraLogLegOrdRecoSusp (
                        sbProceso,
                        SYSDATE,
                        inuOrden,
                        NULL,
                        sberrormessage,
                        USER);
                        
                ELSE      
                
                    rcOrder := Daor_Order.Frcgetrecord(inuOrden);
                    
                    ut_trace.trace  ('Order_Status_id2|' || rcOrder.Order_Status_Id, 5);

                    os_legalizeorderallactivities(inuOrden,
                                                nuCausal_Usr_Susp,
                                                cnuPERID_GEN_CIOR,
                                                dtFecha,
                                                dtFecha,
                                                'Legalizado por ' || sbProceso,
                                                null,
                                                nuError,
                                                sbMessage);

                    if (nuError = pkConstante.Exito) then
                        COMMIT;
                        ut_trace.trace  ('Ok legalizacion', 5 );
                    else
                        ROLLBACK;
                        
                        sberrormessage := sbMessage;
                        
                        LDC_PKGREPEGELERECOYSUSP.proRegistraLogLegOrdRecoSusp (
                            sbProceso,
                            SYSDATE,
                            inuOrden,
                            NULL,
                            sberrormessage,
                            USER);                        
                                            
                    end if;
                    
                END IF;
            
            END IF;
            
            ut_trace.trace  ('Termina pLegalizaOrdSuspProdSusp' , 5);
                
        EXCEPTION
            WHEN Pkg_Error.CONTROLLED_ERROR
            THEN
                Pkg_Error.getError (nuerrorcode, sberrormessage);
                LDC_PKGREPEGELERECOYSUSP.proRegistraLogLegOrdRecoSusp (
                    sbProceso,
                    SYSDATE,
                    inuOrden,
                    NULL,
                    sberrormessage,
                    USER);
                ROLLBACK;
            WHEN OTHERS
            THEN
                Pkg_Error.setError;
                Pkg_Error.getError (nuerrorcode, sberrormessage);
                LDC_PKGREPEGELERECOYSUSP.proRegistraLogLegOrdRecoSusp (
                    sbProceso,
                    SYSDATE,
                    inuOrden,
                    NULL,
                    sberrormessage,
                    USER);
                ROLLBACK;
        END pLegalizaOrdSuspProdSusp;  

    BEGIN

        ut_trace.trace  ('Inicia Ldc_job_LegOrdProdYaSusp', 5 );
            
        -- Consultamos datos para inicializar el proceso
        SELECT TO_NUMBER (TO_CHAR (SYSDATE, 'YYYY')),
               TO_NUMBER (TO_CHAR (SYSDATE, 'MM')),
               USERENV ('SESSIONID'),
               USER
          INTO nuparano,
               nuparmes,
               nutsess,
               sbparuser
          FROM DUAL;
        
        sbProceso := 'LdcJobLegOrdProdYaSusp'|| nutsess;

        -- Inicializamos el proceso
        ldc_proinsertaestaprog (nuparano,
                                nuparmes,
                                sbProceso,
                                'En ejecucion',
                                nutsess,
                                sbparuser);

 
        
        
        LOOP
            tbOrdXLeg.DELETE;
            
            OPEN cuOrdXLeg( nuUltOrden );
            FETCH cuOrdXLeg BULK COLLECT INTO tbOrdXLeg LIMIT 1000;
            CLOSE cuOrdXLeg;
            
            EXIT WHEN tbOrdXLeg.COUNT = 0;
                    
            IF tbOrdXLeg.COUNT > 0 THEN
            
                FOR indtb1 IN 1..tbOrdXLeg.COUNT LOOP

                    ut_trace.trace ( 'Inicia Legalizacion Orden|' || tbOrdXLeg(indtb1).order_id || '|Producto|' || tbOrdXLeg(indtb1).product_id || '|FechaCreac|' || tbOrdXLeg(indtb1).created_date, 5);
                
                    tbOrdenTT_12155.DELETE;
                    
                    OPEN cuOrdenTT_12155( tbOrdXLeg(indtb1).product_id , tbOrdXLeg(indtb1).created_date, tbOrdXLeg(indtb1).package_id);
                    FETCH cuOrdenTT_12155 BULK COLLECT INTO tbOrdenTT_12155 LIMIT 1;
                    CLOSE cuOrdenTT_12155;
                                
                    ut_trace.trace ( 'tbOrdenTT_12155.count|' || tbOrdenTT_12155.count, 5);

                    IF tbOrdenTT_12155.COUNT > 0 THEN
                                            
                        pLegalizaOrdSuspProdSusp( tbOrdXLeg(indtb1).order_id, tbOrdenTT_12155(1).operating_unit_id );

                    ELSE
 
                        sberrormessage := 'No hay orden con Tipo de Trabajo 12155';

                        ut_trace.trace ( sberrormessage,  5);
                                                
                        LDC_PKGREPEGELERECOYSUSP.proRegistraLogLegOrdRecoSusp (
                            sbProceso,
                            SYSDATE,
                            tbOrdXLeg(indtb1).order_id,
                            NULL,
                            sberrormessage,
                            USER);                     
                                   
                    END IF;

                END LOOP;
            
            END IF;
            
            nuUltOrden := tbOrdXLeg( tbOrdXLeg.COUNT ).order_id;

        END LOOP;
                 
        sberrormessage := null;

        ldc_proactualizaestaprog (nutsess,
                                  sberrormessage,
                                  sbProceso,
                                  'Ok');
                                  
        ut_trace.trace  ('Termina Ldc_job_LegOrdProdYaSusp', 5 );                                  

    EXCEPTION
        WHEN Pkg_Error.CONTROLLED_ERROR
        THEN
            Pkg_Error.getError (nuerrorcode, sberrormessage);
            ldc_proactualizaestaprog (nutsess,
                                      sberrormessage,
                                      sbProceso,
                                      'NOk');            
            LDC_PKGREPEGELERECOYSUSP.proRegistraLogLegOrdRecoSusp (
                sbProceso,
                SYSDATE,
                nuOrden,
                NULL,
                sberrormessage,
                USER);
            ROLLBACK;
        WHEN OTHERS
        THEN
            Pkg_Error.setError;
            Pkg_Error.getError (nuerrorcode, sberrormessage);
            ldc_proactualizaestaprog (nutsess,
                                      sberrormessage,
                                      sbProceso,
                                      'NOk');
            LDC_PKGREPEGELERECOYSUSP.proRegistraLogLegOrdRecoSusp (
                sbProceso,
                SYSDATE,
                nuOrden,
                NULL,
                sberrormessage,
                USER);
            ROLLBACK;
    END Ldc_job_LegOrdProdYaSusp;
        
END ldc_bo_gestionsuspseg;
/

