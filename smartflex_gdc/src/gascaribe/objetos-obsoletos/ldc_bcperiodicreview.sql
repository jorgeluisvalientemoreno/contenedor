CREATE OR REPLACE PACKAGE LDC_BCPERIODICREVIEW IS

  /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : LDC_BCPeriodicReview
    Descripcion    : Paquete donde se implementa la logica para la la validacion de cruce
                     entre Revisiones Periodicas e Instalaciones Antitecnicas.
    Autor          : Sayra Ocoro
    Fecha          : 21/02/2013

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============  ===================


    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
    31/07/2015        LDiuza            Aranda 5695: Se modifica el metodo <<prGenerateCertbyCategory>>
    23/06/2015        Mmejia            Aranda.7434 Modificacion  <<prFillOTREV>>
    24/01/2024        jpinedc           OSF-2016: Se modifican prRegisterRequest100248 y 
                                        prGenerateRequest100248
  ******************************************************************/

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : PrGenerateOT
  Descripcion    : Procedimiento para crear, asignar y legalizar ordenes de trabajo utilizando API.
  Autor          :
  Fecha          : 21/02/2013

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  procedure PrGenerateOT;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : PrAlert18
  Descripcion    : Procedimiento donde se implementa la logica para enviar notificaciones para atencion
          a ordenes de revision periodica
  Autor          :
  Fecha          : 26/05/2013

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  procedure PrAlert18;
  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : fsbGetDefectsRP
  Descripcion    : Funcion para obtener los defectos de una orden de revision periodica
  Autor          :
  Fecha          : 17/07/2013

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  function fsbGetDefectsRP(inuOrderId or_order.order_id%type) return varchar2;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : fsbGetCommentRP
  Descripcion    : Funcion para obtener la observacion del tramite de servicios de
                   ingenieria o el comentario de la orden de revision periodica
                   que dio origen a la ot de servicios de ingenieria.
  Autor          :
  Fecha          : 24/10/2013

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  function fsbGetCommentRP(inuOrderId or_order.order_id%type) return varchar2;

  /*Funcion que devuelve la version del pkg*/
  FUNCTION fsbVersion RETURN VARCHAR2;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : fnuGetLastOtRPR
  Descripcion    : Funcion que retorna 1 si la ultima orden ejecutada en la ultima solicitud de revision periodica
                   de un producto asociado a una solicitud dada es de suspension a nivel de acometida
                   debido a que el cliente no permitio reparar, certificar o revisar
  Autor          :
  Fecha          : 14/08/2013

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  function fnuGetLastOtRPR(inuPackagesId in mo_packages.package_id%type)
    return number;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : prValidateRP
  Descripcion    : Procedimiento que valida Causales vs Resultados vs Formulario RP durante la legalizacion
  Autor          :
  Fecha          : 28/10/2013

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  procedure prValidateRP;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : prLegalizeRVRP
  Descripcion    : Procedimiento que legaliza la orden de Reprogramar Visita RP
                   durante la legalizacion de una de la orden de revision periodica.
  Autor          :
  Fecha          : 14/11/2013

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  procedure prLegalizeRVRP;
  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : fnuGetSoliReviPerio
  Descripcion    : Funcion que retorna el numero de solicitud de la revision periodica
                   pasando el producto.
  Autor          : Emiro Leyva Hernandez
  Fecha          : 18/01/2014

  Parametros              Descripcion
  ============         ===================

  Fecha                  Autor             Modificacion
  =========            =========           ====================
  27-Febrero-2014    Jorge Valiente        Aranada 2962: Modificacion del servicio y Se valida
                                           con el Ing. Diego Soto (OPEN) y se sugiere modificar
                                           el servicio LDC_BCPERIODICREVIEW.FNUGETSOLIREVIPERIO
                                           para que se excluya las solicitudes cuya orden de
                                           revision fueron legalizadas con la causal 3243 cierra
                                           tramite RP.
  ******************************************************************/
  function fnuGetSoliReviPerio(inuProductId in mo_motive.product_id%type)
    return number;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : prFillOTREV
  Descripcion    : Procedimiento para llenar la tabla usada en el reporte prceso OTREV
  Autor          :
  Fecha          : 16/05/2014

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/

  procedure prFillOTREV;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : prValidate10438
  Descripcion    : Procedimiento para validar la respuesta del usuario a la orden con tt = 12161
  Autor          :
  Fecha          : 16/05/2014

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/

  procedure prValidate10438;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : prGenerateCertificate
  Descripcion    : Procedimiento para generar la ot de certificacion
  Autor          :
  Fecha          : 19/05/2014

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  28/07/2014    socoro@horbath.com     Se adiciona validaci?n: si para el producto se encuentra registrado un
                                     tr?mite 100101 con una orden de  tipo de trabajo 12137 - Reparaci?n
                                     Inmediata y actividad 4000038 -  Reparaci?n Inmediata en estado
                                     registrado o asignado, para este caso debe levantar un mensaje de
                                     error que indique que la causal que seber?a seleccionar para la legalizaci?n es la  8967 - PENDIENTE POR CERTIFICAR ACEPTA TRABAJOS
  ******************************************************************/

  procedure prGenerateCertificate(nuOrderId       IN or_order.order_id%TYPE,
                                  inuCurrent      IN NUMBER,
                                  inuTotal        IN NUMBER,
                                  onuErrorCode    OUT NUMBER,
                                  osbErrorMessage OUT VARCHAR);

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : prRegisterRequest100248
  Descripcion    : Procedimiento para registrar solicitud 100248 por xml
  Autor          : Sayra Ocoro - HT
  Fecha          : 23/05/2014

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/

  procedure prRegisterRequest100248(inuProduct_id pr_product.product_id%type);

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : FCRGETREPAIRORDERS
  Descripcion    : Procedimiento para obtener las ordenes de reparacion asociadas a una solicitud
                   de revision periodica dada.
  Autor          : Sayra Ocoro - HT
  Fecha          : 29/05/2014

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  function FCRGETREPAIRORDERS return pkConstante.tyRefCursor;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : prValidateCertificate
  Descripcion    : Procedimiento para validar la existencia de ordenes de certificacion
                   para la legalizacion de trabajos certificables.

  Autor          : Sayra Ocoro - HT
  Fecha          : 10/06/2014

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/

  procedure prValidateCertificate;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : prGenerateRequest100248
  Descripcion    : Procedimiento para validar la existencia de defectos reportados por OIA
                    y registrar solicitudes del tipo 100248.

  Autor          : Sayra Ocoro - HT
  Fecha          : 11/06/2014

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/

  procedure prGenerateRequest100248;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : fnuGetFromPeriodicReview
  Descripcion    : Funcion que retorna el identificador de la orden cuando NO esta asociada a una
                   solicitud de Revision Periodica.

  Autor          : Sayra Ocoro - HT
  Fecha          : 12/06/2014

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/

  function fnuGetFromPeriodicReview(inuOrderId or_order.order_id%type)
    return number;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : fnuGetExist100101
  Descripcion    : Funcion que retorna el identificador del producto cuando NO tiene una solicitud de
                   Servicios de Ingenieria con trabajos certificables en proceso

  Autor          : Sayra Ocoro - HT
  Fecha          : 13/06/2014

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/

  function fnuGetExist100101(inuProductId pr_product.product_id%type)
    return number;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : prValidate10445
  Descripcion    : Procedimiento para validar el tipo de solicitud asociado a la
                    orden y la respuesta del usuario a la orden con tt = 10445
  Autor          :
  Fecha          : 16/06/2014

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/

  procedure prValidate10445;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : prValidateCertificateSales
  Descripcion    : Procedimiento para validar la existencia de ordenes de certificacion
                   para la legalizacion de trabajos certificables generadas en una Solicitud de Venta.

  Autor          : Sayra Ocoro - HT
  Fecha          : 24/06/2014

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/

  procedure prValidateCertificateSales;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : fnuGetRequestIdbyOrderId
  Descripcion    : Funcion para obtener el identificador de la solicitud de la
                   orden de la instancia. Para usar en regla de inicializacion en la forma ERARP.

  Autor          : Sayra Ocoro - HT
  Fecha          : 26/06/2014

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/

  function fnuGetRequestIdbyOrderId return number;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : prGenerateCertbyCategory
  Descripcion    : Procedimiento para generar orden de certificacion de acuerdo a la categoria
                   a partir de la legalizacion de una orden con tipo 10446 - Visita de Validacion de
                   Certificacion Trabajos

  Autor          : Sayra Ocoro - HT
  Fecha          : 28/06/2014

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/

  procedure prGenerateCertbyCategory;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : fnuViewCertificate
  Descripcion    : Funci?n que retorna el identificador del producto dado si encuentra que
                    aplica como candidato para visualizar el tr?mite 100270 - LDC - Certificaci?n de Trabajos,
                    en caso contrario retorna -1.

  Autor          : Sayra Ocoro - HT
  Fecha          : 26/07/2014

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/

  function fnuViewCertificate(inuProductId in pr_product.product_id%type)
    return number;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : fnuViewPeriodicReview
  Descripcion    : Funci?n que retorna el identificador del producto dado si encuentra que NO
                    aplica como candidato para visualizar el tr?mite 100270 - LDC - Certificaci?n de Trabajos,
                    en caso contrario retorna -1.

  Autor          : Sayra Ocoro - HT
  Fecha          : 26/07/2014

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/

  function fnuViewPeriodicReview(inuProductId in pr_product.product_id%type)
    return number;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : fnuGetPackageTypeSup
  Descripcion    : Obtiene el identificador  del tipo de solicitud de la orden que insert? la
                   marca en ldc_marca_producto para que el producto salga a suspensi?n.


  Autor          : Sayra Ocoro - HT
  Fecha          : 31/07/2014

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/

  function fnuGetPackageTypeSup(inuPackageId in mo_packages.package_id%type)
    return number;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : prCertificateCharge
  Descripcion    : Procedimiento que durante la legalizaci?n de una orden de certificaci?n
                   valida si se debe o no generar cargo.


  Autor          : Sayra Ocoro - HT
  Fecha          : 04/08/2014

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/

  procedure prCertificateCharge;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : prInspectionCharge
  Descripcion    : Procedimiento que durante la legalizaci?n de una orden de inspecci?n valida
                   con qu? concepto se debe generar el cargo dependiendo de la fecha de registro de  la
                   solicitud de revisi?n.


  Autor          : Sayra Ocoro - HT
  Fecha          : 04/08/2014

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/

  procedure prInspectionCharge;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : prRegisterCertificate
  Descripcion    : Procedimiento que ejecuta el objeto OR_BOOBJACTUTILITIES.REGISTERCERTIFICATE
                   s?lo cuando la causal de legalizaci?n est? en el par?metro CAUSAL_TO_CERTIFY.
                   El funcional debe validar en qu? registros configurados en FMIO debe reemplazar
                   el objeto OR_BOOBJACTUTILITIES.REGISTERCERTIFICATE por LDC_BCPeriodicReview.prRegisterCertificate


  Autor          : Sayra Ocoro - HT
  Fecha          : 06/08/2014

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/

  procedure prRegisterCertificate;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : prBrandProdByRepair
  Descripcion    : Procedimiento que marca el producto por no certificar
  Autor          : Sayra Ocoro - HT
  Fecha          : 08/08/2014

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  procedure prBrandProdByRepair;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : prTemporalCharge
  Descripcion    : Procedimiento que durante la legalizaci?n elimina cargos. Soluci?n Operativa Temporal
  Autor          : Sayra Ocoro - HT
  Fecha          : 09/08/2014

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  procedure prTemporalCharge;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : prFinanceCertificate
  Descripcion    : Procedimiento que durante la legalizaci?n valida
                   que la actividad de certificaci?n sea diferente a la
                   de industriales para financiar.
  Autor          : Sayra Ocoro - HT
  Fecha          : 10/08/2014

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  procedure prFinanceCertificate;
  /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : prFillOTREV_Causal
    Descripcion    : Procedimiento para llenar la tabla usada en el reporte prceso OTREV con causal

    Fecha             Autor             Modificacion
    =========       =========           ====================
   14/08/2014         oparra            Aranda 3554: Se adiciona sentencia al reporte OTREV
                                        incluira la causal
  ******************************************************************/

  PROCEDURE prFillOTREV_Causal;

END LDC_BCPeriodicReview;
/

CREATE OR REPLACE PACKAGE BODY LDC_BCPERIODICREVIEW IS

  CSBVERSION CONSTANT varchar2(40) := 'OSF-2016';
  -- INICIO paulaag [12/11/2014] NC 3456
  cnuValorDefecto constant number := -1;
  sbPlanAcuerdoPago varchar2(100);
  sbCuotas          varchar2(100);
  -- FIN paulaag [12/11/2014] NC 3456

  /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : LDC_BCPeriodicReview
    Descripcion    : Paquete donde se implementa la logica para la la validacion de cruce
                     entre Revisiones Periodicas e Instalaciones Antitecnicas.
    Autor          : Sayra Ocoro (socoro@horbath.com)
    Fecha          : 21/02/2013

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============  ===================


    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
   27-09-2013    socoro@horbath.com  Se Modifica fnuGetLastOtRPR
   24-10-2013    socoro@horbath.com  Se modifica fsbGetDefectsRP y se adiciona la funcion fsbGetCommentRP
   28-10-2013    socoro@horbath.com  Se adiciona el procedimiento prValidateRP
   14-11-2013    socoro@horbath.com  Se adiciona el procedimiento prLegalizeRVRP
   27-11-2013     Sayra Ocoro        Se adicionan instrucciones para empujar el flujo
                                    del tramire Reprogramar Visita RP en prLegalizeRVRP
   23-06-2015          Mmejia            Aranda.7434 Modificacion  <<prFillOTREV>>
  ******************************************************************/

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : PrGenerateOT
  Descripcion    : Procedimiento para crear, asignar y legalizar ordenes de trabajo utilizando API.
  Autor          : Sayra Ocoro (socoro@horbath.com)
  Fecha          : 21/02/2013

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  21/10/2013     Sayra Ocoro         Se modifica el filtro para obtener los productos
                                     con RP pendiente por generar
  22/05/2014   Sayra Ocoro - HT     Se modifica filtro del cursor cuWithoutCertificate y procedimiento para
                                    dar cumplimiento a la ley 059.
  ******************************************************************/
  procedure PrGenerateOT is

    dtEndDate       DATE := UT_DATE.FSBSTR_SYSDATE();
    dtInitialDate   DATE;
    sbRecipients    VARCHAR2(200);
    sbSubject       VARCHAR2(200);
    sbMessage0      VARCHAR2(30000);
    sbMessage1      VARCHAR2(30000);
    sbProductIds    VARCHAR2(30000);
    nuproductId     pr_product.product_id%type;
    nuCount         number := 0;
    sbProductIdsIAs VARCHAR2(30000);

    --Validacion de cruce de Ordenes de Revision con Ordenes de Instalacion Anti - tecnica
    cursor cuWithPeriodicReview(idtInitialDate date, idtEndDate date) is
      select nvl(or_order.order_id, 0) inuOrderId,
             or_order_activity.product_id nuProduct
        from or_order_activity, or_order
       where or_order_activity.task_type_id =
             DALD_parameter.fnuGetNumeric_Value('TIPO_TRABAJO_IA') --10068
         and (or_order.order_status_id =
             DALD_parameter.fnuGetNumeric_Value('ESTADO_REGISTRADO') and
             or_order.created_date < idtEndDate)
         and or_order_activity.order_id = or_order.order_id
         and upper(OR_BOREVIEW.FSBREVIEWINPROCESS(or_order_activity.product_id)) = 'Y';

    --Validacion de cruce de Ordenes de Revision Pendientes por Generar con Ordenes de Instalacion Anti - tecnica
    cursor cuWithoutCertificate(idtInitialDate date, idtEndDate date) is
      select nvl(or_order.order_id, 0) inuOrderId,
             nvl(or_order_activity.product_id, 0) inuProductId
        from open.or_order_activity, open.pr_product P, open.or_order
       where or_order_activity.task_type_id =
             open.DALD_parameter.fnuGetNumeric_Value('TIPO_TRABAJO_IA') --10068
         and (or_order.order_status_id =
             open.DALD_parameter.fnuGetNumeric_Value('ESTADO_REGISTRADO') and
             or_order.created_date <= idtEndDate)
         and or_order_activity.order_id = or_order.order_id
         and (or_order_activity.product_id not in
             (select product_id
                 from open.pr_certificate
                where ((estimated_end_date -
                      (open.ge_boparameter.fnuValorNumerico('ADVANCE_PERIOD') * 30) >
                      idtEndDate and pr_certificate.end_date is null))) or
             or_order_activity.product_id in
             (select product_id
                 from pr_product
                where pr_product.product_id not in
                      (select product_id from pr_certificate)))
         and upper(open.OR_BOREVIEW.FSBREVIEWINPROCESS(or_order_activity.product_id)) = 'N'
         and P.product_status_id = 1
         and P.product_id = or_order_activity.product_id

         and not exists
       (select 1
                from mo_packages a, ps_motive_status c, mo_motive x
               WHERE a.PACKAGE_TYPE_ID in (265, 266, 100237)
                 AND c.MOTIVE_STATUS_ID = a.MOTIVE_STATUS_ID
                 AND c.MOTI_STATUS_TYPE_ID = 2
                 AND c.MOTIVE_STATUS_ID not in (14, 32, 51)
                 and x.PACKAGE_ID = a.PACKAGE_ID
                 and x.PRODUCT_ID = P.product_id)
         and not exists
       (select 1
                from ldc_marca_producto
               where ldc_marca_producto.id_producto = P.product_id);

    --Consulta de Ordenes de Revision Generadas
    cursor cuPeriodicReviewOrders(idtEndDate date, listProducts VARCHAR2) is
      SELECT distinct pr_product.product_id SERVICIO_SUSCRITO,
                      ge_subscriber.SUBSCRIBER_NAME || ' ' ||
                      ge_subscriber.subs_last_name SUSCRIPTOR,
                      ge_geogra_location.description MUNICIPIO,
                      ab_address.address_parsed DIRECCION,
                      or_order.order_id ID_ORDEN,
                      or_order.created_date FECHA_CREACION_OT
        FROM ge_geogra_location,
             ab_address,
             pr_product,
             or_order_activity,
             or_order,
             ge_subscriber
       where ge_geogra_location.geograp_location_id =
             ab_address.geograp_location_id
         and ab_address.address_id = pr_product.address_id
         and pr_product.product_id = or_order_activity.product_id
         and or_order_activity.order_id = or_order.order_id
         and or_order_activity.subscriber_id = ge_subscriber.subscriber_id
         and or_order.task_type_id =
             DALD_parameter.fnuGetNumeric_Value('TIPO_TRABAJO_RP') --12161
            --and to_char(trunc(or_order.created_date), 'dd/mm/yyyy') >= to_char(trunc(idtEndDate), 'dd/mm/yyyy')
         and pr_product.product_id in
             (SELECT TO_NUMBER(COLUMN_VALUE)
                FROM TABLE(LDC_BOUTILITIES.SPLITSTRINGS(listProducts, ',')))
       order by 5;

    nuControl      number := 0;
    rgNewParameter ld_parameter%rowtype;
  BEGIN
    ut_trace.trace('Inicio LDC_BCPeriodicReview.PrGenerateOT', 10);
    --Obtener la fecha de la ultima ejecucion del proceso
    if (dald_parameter.fblexist('LDC_FECHA_REVISION_CRUCE_IA_RP') = FALSE) then
      rgNewParameter.PARAMETER_ID  := 'LDC_FECHA_REVISION_CRUCE_IA_RP';
      rgNewParameter.NUMERIC_VALUE := null;
      rgNewParameter.VALUE_CHAIN   := SYSDATE;
      rgNewParameter.DESCRIPTION   := 'ULTIMA FECHA DE EJECUCION DEL PROCESO PARA REVISION DE CRUCE ENTRE IA Y RP';
      insert into ld_parameter
        (PARAMETER_ID, NUMERIC_VALUE, VALUE_CHAIN, DESCRIPTION)
      values
        (rgNewParameter.PARAMETER_ID,
         rgNewParameter.NUMERIC_VALUE,
         rgNewParameter.VALUE_CHAIN,
         rgNewParameter.DESCRIPTION);
      commit;
      dtInitialDate := to_date(dald_parameter.fsbgetvalue_chain('LDC_FECHA_REVISION_CRUCE_IA_RP'),
                               'DD/MM/YYYY');
      dbms_output.put_line(dtInitialDate);
    end if;

    --Almacenar en un parametro para futuras ejecuciones
    dtInitialDate := dald_parameter.fsbgetvalue_chain('LDC_FECHA_REVISION_CRUCE_IA_RP');
    dald_parameter.UPDVALUE_CHAIN('LDC_FECHA_REVISION_CRUCE_IA_RP',
                                  to_char(SYSDATE));
    --Anulacion de Ordenes de Instalacion Anti - tecnica por cruce con Revision Periodica
    for rcOT in cuWithPeriodicReview(dtInitialDate, dtEndDate) loop
      --Anular OT
      Or_BOAnullOrder.AnullOrderWithOutVal(rcOT.inuOrderId /*order_id*/,
                                           sysdate /*change_date*/);
      -- Actualiza la causal escogida
      daor_order.updCausal_Id(rcOT.inuOrderId /*order_id*/,
                              DALD_parameter.fnuGetNumeric_Value('CAUSAL_LEGALIZA_IA_CRUCE_RP') /*inuCausalId*/);
      nuproductId     := rcOT.nuProduct;
      sbProductIdsIAs := sbProductIdsIAs || nuproductId || ',';
      nuControl       := 1;
    end loop;
    --Anulacion de Ordenes de Instalacion Anti - tecnica y Genera Oredenes de Revision Periodica
    for dat in cuWithoutCertificate(dtInitialDate, dtEndDate) loop
      --Anular OT
      Or_BOAnullOrder.AnullOrderWithOutVal(dat.inuOrderId /*order_id*/,
                                           sysdate /*change_date*/);
      -- Actualiza la causal escogida
      daor_order.updCausal_Id(dat.inuOrderId /*order_id*/,
                              DALD_parameter.fnuGetNumeric_Value('CAUSAL_LEGALIZA_IA_GENERA_RP') /*inuCausalId*/);
      --Registrar solicitud de REVISION PERIODICA
      nuControl := 0;
      --22/05/2014 Sayra Ocoro - Modificacion para ley 059
      --OR_BOREVIEW.PERIODICREVIEWREGISTER(dat.inuProductId);
      LDCI_PKREVISIONPERIODICAWEB.LDC_REGISTRVISIIDENCERTIXOTREV(dat.inuProductId);
      --Fin ley 059
      nuproductId  := dat.inuProductId;
      sbProductIds := sbProductIds || nuproductId || ',';
      nuControl    := 1;
      nuCount      := nuCount + 1;
    end loop;

    if nuControl = 1 then
      commit;
      --Esperar hasta que el proceso de creacion de RP registre las ots
      dbms_lock.sleep(200 * nuCount);
      --Configuarcion para envio de correo a usuarios
      sbRecipients := DALD_parameter.fsbGetValue_Chain('FUNC_PERIODIC_REVIEW'); --'socoro@horbath.com';
      sbSubject    := 'Ordenes de Revision Periodicas ' || dtEndDate;
      sbMessage0   := 'Se?or usuario, ';
      --Revisiones periodicas generadas
      if length(sbProductIds) > 0 then
        sbProductIds := substr(sbProductIds, 1, (length(sbProductIds) - 1));
        sbMessage0   := sbMessage0 ||
                        'se generaron Ordenes de Revision Periodica durante el proceso ejecutado de manera automatica en la fecha: ' ||
                        dtEndDate || chr(10) || chr(13);
        sbMessage1   := '<table BORDER="1"> <tr BGCOLOR="gray"> <th>' ||
                        rpad('SERVICIO SUSCRITO', 20, ' ') || '</th> <th>' ||
                        rpad('SUSCRIPTOR', 15, ' ') || '</th> <th>' ||
                        rpad('DIRECCION DE INSTALACION', 35, ' ') ||
                        '</th> <th>' || rpad('CODIGO DE LA ORDEN', 20, ' ') ||
                        '</th> <th>' ||
                        rpad('FECHA DE CREACION DE LA ORDEN', 30, ' ') ||
                        '</th> </tr>';
        for dat in cuPeriodicReviewOrders(trunc(dtEndDate), sbProductIds) loop
          sbMessage1 := sbMessage1 || '<tr> <td>' ||
                        rpad(dat.SERVICIO_SUSCRITO, 20, ' ') ||
                        '</td> <td>' || rpad(dat.SUSCRIPTOR, 15, ' ') ||
                        '</td> <td>' ||
                        rpad(dat.MUNICIPIO || ' - ' || dat.DIRECCION,
                             35,
                             ' ') || '</td> <td>' ||
                        rpad(dat.ID_ORDEN, 20, ' ') || '</td> <td>' ||
                        rpad(dat.FECHA_CREACION_OT, 30, ' ') ||
                        '</td> </tr> ';
        end loop;
        sbMessage0 := sbMessage0 || sbMessage1 || '</table>';
      end if;

      --Revisiones periodicas
      if length(sbProductIdsIAs) > 0 then
        sbProductIdsIAs := substr(sbProductIdsIAs,
                                  1,
                                  (length(sbProductIdsIAs) - 1));
        sbMessage0      := sbMessage0 || chr(10) || chr(13) ||
                           'se anularon ordenes de Instalacion Anti-tecnica que se cruzaban con las siguientes
           ordenes de Revision Periodica: ' ||
                           chr(10) || chr(13);
        sbMessage1      := '<table BORDER="1"> <tr BGCOLOR="gray"> <th>' ||
                           rpad('SERVICIO SUSCRITO', 20, ' ') ||
                           '</th> <th>' || rpad('SUSCRIPTOR', 15, ' ') ||
                           '</th> <th>' ||
                           rpad('DIRECCION DE INSTALACION', 35, ' ') ||
                           '</th> <th>' ||
                           rpad('CODIGO DE LA ORDEN', 20, ' ') ||
                           '</th> <th>' ||
                           rpad('FECHA DE CREACION DE LA ORDEN', 30, ' ') ||
                           '</th> </tr>';
        for dat in cuPeriodicReviewOrders(trunc(dtEndDate), sbProductIdsIAs) loop
          sbMessage1 := sbMessage1 || '<tr> <td>' ||
                        rpad(dat.SERVICIO_SUSCRITO, 20, ' ') ||
                        '</td> <td>' || rpad(dat.SUSCRIPTOR, 15, ' ') ||
                        '</td> <td>' ||
                        rpad(dat.MUNICIPIO || ' - ' || dat.DIRECCION,
                             35,
                             ' ') || '</td> <td>' ||
                        rpad(dat.ID_ORDEN, 20, ' ') || '</td> <td>' ||
                        rpad(dat.FECHA_CREACION_OT, 30, ' ') ||
                        '</td> </tr> ';
        end loop;
        sbMessage0 := sbMessage0 || sbMessage1 || '</table>';
      end if;
      --Enviar correo
      LDC_SENDEMAIL(sbRecipients, sbSubject, sbMessage0);
    end if;

  EXCEPTION
    When others then
      rollback;
      gw_boerrors.checkerror(SQLCODE, SQLERRM);
  END PrGenerateOT;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : PrAlert18
  Descripcion    : Procedimiento donde se implementa la logica para enviar notificaciones para atencion
          a ordenes de revision periodica
  Autor          : Sayra Ocoro (socoro@horbath.com)
  Fecha          : 26/05/2013

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  procedure PrAlert18 is
    sbRecipients VARCHAR2(20000);
    sbSubject    VARCHAR2(200);
    sbMessage0   VARCHAR2(30000);
    sbMessage1   VARCHAR2(30000);
    actualDate   date := UT_DATE.FSBSTR_SYSDATE();
    cursor cuAlert18 is
      SELECT or_order_activity.subscription_id SUSCRIPCION,
             ge_subscriber.subscriber_name || ' ' ||
             ge_subscriber.subs_last_name CLIENTE,
             ps_package_type.package_type_id || ' - ' ||
             ps_package_type.description TIPO_SOLICITUD,
             mo_packages.package_id ID_SOLICITUD,
             OR_ORDER_ACTIVITY.order_iD ID_ORDEN,
             or_order.max_date_to_legalize FECHA_MAXIMA_ATENCION,
             ge_geogra_location.description || ' - ' ||
             ab_address.address_parsed DIRECCION
        FROM OR_ORDER_ACTIVITY,
             mo_packages,
             or_order,
             ps_package_type,
             ab_address,
             ge_subscriber,
             ge_geogra_location,
             pr_product
       WHERE ((mo_packages.package_type_id =
             DALD_parameter.fnuGetNumeric_Value('ID_PKG_TYPE_RP_MASIVA') and
             (or_order.max_date_to_legalize -
             DALD_parameter.fnuGetNumeric_Value('ANS_RP_MASIVA') <=
             sysdate)) or
             (mo_packages.package_type_id =
             DALD_parameter.fnuGetNumeric_Value('ID_PKG_TYPE_RP') and
             (or_order.max_date_to_legalize -
             DALD_parameter.fnuGetNumeric_Value('ANS_RP') <= sysdate)))
         AND OR_ORDER_ACTIVITY.Package_Id = mo_packages.package_id
         and or_order_activity.order_id = or_order.order_id
         and ps_package_type.package_type_id = mo_packages.package_type_id
         and ge_subscriber.subscriber_id = or_order_activity.subscriber_id
         and ge_geogra_location.geograp_location_id =
             ab_address.geograp_location_id
         and ab_address.address_id = pr_product.address_id
         and or_order.order_status_id =
             DALD_parameter.fnuGetNumeric_Value('ESTADO_ASIGNADO') --estado asignado
         and pr_product.product_id = or_order_activity.product_id;
    nuBan number := 0;

  begin

    --Configuarcion para envio de correo a usuarios
    for dat in cuAlert18 loop
      sbMessage1 := sbMessage1 || '<tr> <td>' ||
                    rpad(dat.SUSCRIPCION, 20, ' ') || '</td> <td>' ||
                    rpad(dat.CLIENTE, 15, ' ') || '</td> <td>' ||
                    rpad(dat.TIPO_SOLICITUD, 20, ' ') || '</td> <td>' ||
                    rpad(dat.ID_SOLICITUD, 15, ' ') || '</td> <td>' ||
                    rpad(dat.ID_ORDEN, 15, ' ') || '</td> <td>' ||
                    rpad(dat.FECHA_MAXIMA_ATENCION, 30, ' ') ||
                    '</td> <td>' || rpad(dat.DIRECCION, 30, ' ') ||
                    '</td> </tr> ';
      nuBan      := 1;
    end loop;
    dbms_output.put_line('lalala');
    if nuBan = 1 then
      sbRecipients := DALD_parameter.fsbGetValue_Chain('PERIODIC_REVIEW_ALERT18'); --'socoro@horbath.com';
      sbSubject    := 'ATENCION INMEDIATA de Ordenes de Revision Periodicas ' ||
                      actualDate;
      sbMessage0   := 'Se?or usuario,las Ordenes de Revision Periodica adjuntas a este mensaje, deben ser atendidas
							 con urgencia ya que esta proxima a superar el tiempo de atencion estipulado.' ||
                      chr(10) || chr(13);
      sbMessage0   := sbMessage0 ||
                      '<table BORDER="1"> <tr BGCOLOR="gray"> <th>' ||
                      rpad('SERVICIO SUSCRITO', 20, ' ') || '</th> <th>' ||
                      rpad('SUSCRIPTOR', 15, ' ') || '</th> <th>' ||
                      rpad('TIPO DE SOLICITUD', 20, ' ') || '</th> <th>' ||
                      rpad('SOLICITUD', 15, ' ') || '</th> <th>' ||
                      rpad('CODIGO DE LA ORDEN', 20, ' ') || '</th> <th>' ||
                      rpad('FECHA MAXIMA DE ATENCION', 35, ' ') ||
                      '</th> <th>' ||
                      rpad('DIRECCION DE ATENCION', 40, ' ') ||
                      '</th> </tr>';
      sbMessage0   := sbMessage0 || sbMessage1 || '</table>';

      LDC_SENDEMAIL(sbRecipients, sbSubject, sbMessage0);
    end if;

  EXCEPTION
    When others then
      rollback;
      gw_boerrors.checkerror(SQLCODE, SQLERRM);
  end PrAlert18;
  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : fsbGetDefectsRP
  Descripcion    : Funcion para obtener los defectos de una orden de revision periodica
  Autor          : Sayra Ocoro (socoro@horbath.com)
  Fecha          : 17/07/2013

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  25-10-2013    socoro@horbath.com    Se modifica el cursor cuDefects para que busque a partir de la solicitud de RP
  ******************************************************************/
  function fsbGetDefectsRP(inuOrderId or_order.order_id%type) return varchar2 is

    --Cursor par obtener la ultima orden de revision periodica legalizada
    cursor cuultimaordenrp(inuproduct pr_product.product_id%type) is
      select oa.order_id
        FROM OR_ORDER_ACTIVITY OA
       INNER JOIN OR_ORDER O ON OA.ORDER_ID = O.ORDER_ID
       INNER JOIN MO_PACKAGES MP ON OA.PACKAGE_ID = MP.PACKAGE_ID
       WHERE OA.PRODUCT_ID = inuProduct
         and rownum = 1
            --AND    mp.MOTIVE_STATUS_ID = DALD_parameter.fnuGetNumeric_Value('ID_ESTADO_PKG_ATENDTIDO')-- 14-Solicitud atendida
         and mp.package_type_id in
             (DALD_parameter.fnuGetNumeric_Value('ID_PKG_TYPE_RP_MASIVA'),
              DALD_parameter.fnuGetNumeric_Value('ID_PKG_TYPE_RP'),
              DALD_parameter.fnuGetNumeric_Value('ID_PKG_TYPE_REGENERA_RP')) --Tipo de solicitud
         and o.order_status_id =
             DALD_parameter.fnuGetNumeric_Value('COD_ORDER_STATUS') --8
         and o.task_type_id =
             DALD_parameter.fnuGetNumeric_Value('TIPO_TRABAJO_RP') --12161 --12168
         and dage_causal.fnuGetClass_Causal_Id(o.causal_id) =
             DALD_parameter.fnuGetNumeric_Value('TYPE_CAU_LEG_ORD_DEL') --1
       ORDER BY mp.attention_date DESC;

    --Cursor para obtener los defecto de la Ot de RP
    cursor cuDefects(inuOrderActivityId or_order_activity.order_activity_id%type) is
      select ge_defect.defect_id || ' - ' || ge_defect.description DEFECTOS_RP
        from ge_defect, or_activ_defect
       where or_activ_defect.order_activity_id = inuOrderActivityId
         and or_activ_defect.defect_id = ge_defect.defect_id;

    sbDefectosRP      varchar2(30000);
    nuOrderRP         or_order.order_id%type;
    nuProductId       pr_product.product_id%type;
    nuOrderActivityId or_order_activity.order_activity_id%type;

  begin
    --Obtener el producto asociado a la ot
    nuProductId := to_number(ldc_boutilities.fsbGetValorCampoTabla('or_order_activity',
                                                                   'order_id',
                                                                   'product_id',
                                                                   inuOrderId));

    if nuProductId is not null and nuProductId <> -1 then
      --Obtener la ultima orden de revision periodica legalizada con causal de cumplimiento asociada al producto
      open cuultimaordenrp(nuProductId);
      fetch cuultimaordenrp
        into nuOrderRP;
      if cuultimaordenrp%found then
        close cuultimaordenrp;
        nuOrderActivityId := ldc_bcfinanceot.fnuGetActivityId(nuOrderRP);
        for rgDefects in cuDefects(nuOrderActivityId) loop
          sbDefectosRP := sbDefectosRP || rgDefects.DEFECTOS_RP || ' | ';
        end loop;
        sbDefectosRP := substr(sbDefectosRP, 1, (length(sbDefectosRP) - 2));
        --dbms_output.put_line(sbDefectosRP);
      else
        raise NO_DATA_FOUND;
      end if;

    else
      sbDefectosRP := 'La Orden No. ' || inuOrderId ||
                      ' no esta asociada a un producto';
    end if;

    return sbDefectosRP;
  exception
    WHEN NO_DATA_FOUND THEN
      sbDefectosRP := 'No registra';
      return sbDefectosRP;
    when others then
      sbDefectosRP := sqlcode || ' - ' || sqlerrm;
      return sbDefectosRP;

  end fsbGetDefectsRP;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : fsbGetCommentRP
  Descripcion    : Funcion para obtener la observacion del tramite de servicios de
                   ingenieria o el comentario de la orden de revision periodica
                   que dio origen a la ot de servicios de ingenieria.
  Autor          :
  Fecha          : 24/10/2013

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  function fsbGetCommentRP(inuOrderId or_order.order_id%type) return varchar2

   is
    sbComment   varchar2(30000);
    nuProductId pr_product.product_id%type;
    nuOrderRP   or_order.order_id%type;

    --Cursor par obtener la ultima orden de revision periodica legalizada
    cursor cuultimaordenrp(inuproduct pr_product.product_id%type) is

      select OR_ORDER_ACTIVITY.order_id
        FROM OR_ORDER_ACTIVITY, OR_ORDER, MO_PACKAGES
       WHERE OR_ORDER_ACTIVITY.order_id = OR_ORDER.order_id
         and OR_ORDER_ACTIVITY.Package_Id = MO_PACKAGES.Package_Id
         and OR_ORDER_ACTIVITY.PRODUCT_ID = inuproduct
            --AND    MO_PACKAGES.MOTIVE_STATUS_ID = DALD_parameter.fnuGetNumeric_Value('ID_ESTADO_PKG_ATENDTIDO')-- 14-Solicitud atendida
         and MO_PACKAGES.package_type_id in
             (DALD_parameter.fnuGetNumeric_Value('ID_PKG_TYPE_RP_MASIVA'),
              DALD_parameter.fnuGetNumeric_Value('ID_PKG_TYPE_RP'),
              DALD_parameter.fnuGetNumeric_Value('ID_PKG_TYPE_REGENERA_RP')) --Tipo de solicitud
         and OR_ORDER.order_status_id =
             DALD_parameter.fnuGetNumeric_Value('COD_ORDER_STATUS') --8
         and OR_ORDER.task_type_id =
             DALD_parameter.fnuGetNumeric_Value('TIPO_TRABAJO_RP') --12161 --12168
         and dage_causal.fnuGetClass_Causal_Id(OR_ORDER.causal_id) =
             DALD_parameter.fnuGetNumeric_Value('TYPE_CAU_LEG_ORD_DEL') --1
         and rownum = 1
       ORDER BY MO_PACKAGES.attention_date DESC;

    --Cursor para obtener el comentatio de la ot
    cursor cuComment(inuOrderId or_order.order_id%type) is
      select or_order_comment.order_comment COMENTARIO_RP
        from or_order_comment
       where or_order_comment.order_id = inuOrderId
         and or_order_comment.legalize_comment = 'Y';

    nuOrderActivityId or_order_activity.order_activity_id%type;
    nuPackagesId      mo_packages.package_id%type;

  begin
    --Obtener el producto asociado a la ot
    nuProductId := to_number(ldc_boutilities.fsbGetValorCampoTabla('or_order_activity',
                                                                   'order_id',
                                                                   'product_id',
                                                                   inuOrderId));
    if nuProductId is not null and nuProductId <> -1 then

      --Obtener la ultima orden de revision periodica legalizada con causal de cumplimiento asociada al producto
      open cuultimaordenrp(nuProductId);
      fetch cuultimaordenrp
        into nuOrderRP;
      close cuultimaordenrp;
      if nuOrderRP is null then

        --Obtener el comentario de la solicitud
        nuOrderActivityId := ldc_bcfinanceot.fnuGetActivityId(inuOrderId);
        nuPackagesId      := daor_order_activity.fnugetpackage_id(nuOrderActivityId);
        sbComment         := 'Comentario de ' ||
                             daps_package_type.fsbgetdescription(damo_packages.fnugetpackage_type_id(nuPackagesId)) ||
                             ' No. ' || nuPackagesId || ': ' ||
                             damo_packages.fsbgetcomment_(nuPackagesId);

      else
        for rgComment in cuComment(nuOrderRP) loop
          sbComment := sbComment || rgComment.COMENTARIO_RP || ' / ';
        end loop;
        sbComment := substr(sbComment, 1, (length(sbComment) - 2));
        sbComment := 'Cometario registrado al legalizar la Orden No. ' ||
                     nuOrderRP || ': ' || sbComment;
        --dbms_output.put_line(sbComment);
      end if;

    else
      sbComment := 'La Orden No. ' || inuOrderId ||
                   ' no esta asociada a un producto';
      return sbComment;
    end if;
    return sbComment;
  exception
    WHEN NO_DATA_FOUND THEN
      sbComment := 'No registra';
      return sbComment;
    when others then
      sbComment := sbComment || sqlcode || ' - ' || sqlerrm;
      return sbComment;

  end fsbGetCommentRP;

  /*Funcion que devuelve la version del pkg*/
  FUNCTION fsbVersion RETURN VARCHAR2 IS
  BEGIN
    return CSBVERSION;
  END FSBVERSION;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : fnuGetLastOtRPR
  Descripcion    : Funcion que retorna 1 si la ultima orden ejecutada en la ultima solicitud de revision periodica
                   de un producto asociado a una solicitud dada es de suspension a nivel de acometida
                   debido a que el cliente no permitio reparar, certificar o revisar
  Autor          : Sayra Ocoro (socoro@horbath.com)
  Fecha          : 14/08/2013

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  27-09-2013    socoro@horbath.com   Se modifica el metodo para solucionar la NC 924
                                     y tener en cuenta que los datos de migracion.
  ******************************************************************/
  function fnuGetLastOtRPR(inuPackagesId in mo_packages.package_id%type)
    return number is
    --Obtiene la orden RP asociada al producto
    cursor cuultimaordenrp(inuproduct pr_product.product_id%type) is
      select oa.order_id, oa.package_id
        FROM OR_ORDER_ACTIVITY OA
       INNER JOIN OR_ORDER O ON OA.ORDER_ID = O.ORDER_ID
       INNER JOIN MO_PACKAGES MP ON OA.PACKAGE_ID = MP.PACKAGE_ID
       WHERE OA.PRODUCT_ID = inuProduct
         and rownum = 1
         AND mp.MOTIVE_STATUS_ID =
             DALD_parameter.fnuGetNumeric_Value('ID_ESTADO_PKG_ATENDTIDO') -- 14-Solicitud atendida
         and mp.package_type_id in
             (DALD_parameter.fnuGetNumeric_Value('ID_PKG_TYPE_RP_MASIVA'),
              DALD_parameter.fnuGetNumeric_Value('ID_PKG_TYPE_RP')) --Tipo de solicitud
         and o.order_status_id =
             DALD_parameter.fnuGetNumeric_Value('COD_ORDER_STATUS') --8
         and o.task_type_id =
             DALD_parameter.fnuGetNumeric_Value('ID_TASK_TYPE_SUSP') --12168
         and dage_causal.fnuGetClass_Causal_Id(o.causal_id) =
             DALD_parameter.fnuGetNumeric_Value('TYPE_CAU_LEG_ORD_DEL') --1
       ORDER BY mp.attention_date DESC;

    nuProductId    pr_product.product_id%type;
    nuPackagesRPId mo_packages.package_id%type;
    nuOrderRPId    or_order.order_id%type;

    --CURSOR PARA VALIDAR SOLICITUD DE REVISION PERIODICA
    --CON ACTIVIDAD DE SUSPENSION POR CENTRO DE MEDICION O
    --CON ACTIVIDAD DE SUSPENSION POR ACOMETIDA
    CURSOR CUACTIVITY_ID(INUPACKAGE_ID MO_PACKAGES.PACKAGE_ID%TYPE, inuProductId pr_product.product_id%type, inuOrderId or_order.order_id%type) is
      SELECT COUNT(*)
        FROM OR_ORDER_ACTIVITY E1
       WHERE nvl(E1.PACKAGE_ID, -1) =
             decode(INUPACKAGE_ID, null, -1, INUPACKAGE_ID)
         and E1.Product_Id = inuProductId
         and E1.ORDER_ID =
             decode(inuOrderId, null, E1.ORDER_ID, inuOrderId)
         AND E1.ACTIVITY_ID in
             ((select to_number(column_value)
                from table(ldc_boutilities.splitstrings(DALD_PARAMETER.fsbGetValue_Chain('COD_ACTI_SUSP_REPE_ACOM'),
                                                        ','))))
         and rownum = 1
       order by final_date desc;

    nuCantActSuspAc    number := 0;
    nuProductStatus    pr_product.product_status_id%type;
    nuProdSuspensionId pr_prod_suspension.prod_suspension_id%type;
    nuSuspensionType   pr_prod_suspension.suspension_type_id%type;
  begin
    ut_trace.trace('Inicio LDC_BCPeriodicReview.fnuGetLastOtRPR', 10);
    ----Inicio Nueva Seccion
    --Obtener el producto asociado a la solicitud
    --nuProductId := to_number(ldc_boutilities.fsbgetvalorcampotabla('OR_ORDER_ACTIVITY','package_id','PRODUCT_ID',inuPackagesId));
    nuProductId := to_number(ldc_boutilities.fsbgetvalorcampotabla('mo_motive',
                                                                   'package_id',
                                                                   'PRODUCT_ID',
                                                                   inuPackagesId));
    ut_trace.trace('Ejecucion LDC_BCPeriodicReview.fnuGetLastOtRPR => nuProductId => ' ||
                   nuProductId,
                   10);
    --dbms_output.put_line('Ejecucion LDC_BCPeriodicReview.fnuGetLastOtRPR => nuProductId => '||nuProductId);
    if nuProductId is not null and nuProductId <> -1 then
      --Obtener Estado del Producto
      nuProductStatus := dapr_product.fnugetproduct_status_id(nuProductId);
      ut_trace.trace('Ejecucion LDC_BCPeriodicReview.fnuGetLastOtRPR => nuProductStatus => ' ||
                     nuProductStatus,
                     10);
      --dbms_output.put_line('Ejecucion LDC_BCPeriodicReview.fnuGetLastOtRPR => nuProductStatus => '||nuProductStatus);
      --Validar si el producto esta suspendido
      if nuProductStatus =
         DALD_parameter.fnuGetNumeric_Value('ID_PRODUCT_STATUS_SUSP') then
        --Obtener id del registro de suspension
        nuProdSuspensionId := to_number(ldc_boutilities.fsbgetvalorcampostabla('pr_prod_suspension',
                                                                               'PRODUCT_ID',
                                                                               'prod_suspension_id',
                                                                               nuProductId,
                                                                               'ACTIVE',
                                                                               'Y'));
        ut_trace.trace('Ejecucion LDC_BCPeriodicReview.fnuGetLastOtRPR => nuProdSuspensionId => ' ||
                       nuProdSuspensionId,
                       10);
        --dbms_output.put_line('Ejecucion LDC_BCPeriodicReview.fnuGetLastOtRPR => nuProdSuspensionId => '||nuProdSuspensionId);
        --Validar si existe una suspension activa
        if nuProdSuspensionId is not null and nuProdSuspensionId <> -1 then
          nuSuspensionType := dapr_prod_suspension.fnugetsuspension_type_id(nuProdSuspensionId);
          ut_trace.trace('Ejecucion LDC_BCPeriodicReview.fnuGetLastOtRPR => nuSuspensionType => ' ||
                         nuSuspensionType,
                         10);
          --dbms_output.put_line('Ejecucion LDC_BCPeriodicReview.fnuGetLastOtRPR => nuSuspensionType => '||nuSuspensionType);

          --Validar si la suspension esta relacionada
          if instr(DALD_PARAMETER.fsbGetValue_Chain('ID_RP_SUSPENSION_TYPE'),
                   to_char(nuSuspensionType)) > 0 then
            -- dbms_output.put_line(DALD_PARAMETER.fsbGetValue_Chain('ID_RP_SUSPENSION_TYPE'));
            --Obtiene la ultima RP asociada al producto
            OPEN cuUltimaOrdenRP(nuProductId);
            if cuUltimaOrdenRP%notfound then
              close cuUltimaOrdenRP;
              nuPackagesRPId := null;
              nuOrderRPId    := null;
            else
              fetch cuultimaordenrp
                into nuOrderRPId, nuPackagesRPId;
              close cuUltimaOrdenRP;
            end if;
            ut_trace.trace('Ejecucion LDC_BCPeriodicReview.fnuGetLastOtRPR => nuPackagesRPId => ' ||
                           nuPackagesRPId,
                           10);
            ut_trace.trace('Ejecucion LDC_BCPeriodicReview.fnuGetLastOtRPR => nuOrderRPId => ' ||
                           nuOrderRPId,
                           10);
            --VALIDAR SI LA SOLICTUD DE REVISION PERIODICA DENTRO DE SUS ACTIVIDADES
            --MANEJA SUSPENSION POR POR ACOMETIDA.
            OPEN CUACTIVITY_ID(nuPackagesRPId, nuProductId, nuOrderRPId);
            FETCH CUACTIVITY_ID
              into nuCantActSuspAc;
            close cuactivity_id;
            ut_trace.trace('Ejecucion LDC_BCPeriodicReview.fnuGetLastOtRPR => nuCantActSuspAc => ' ||
                           nuCantActSuspAc,
                           10);
            --Validar si se realizo suspension por acometida
            if nuCantActSuspAc > 0 then
              return 1;
            end if;
          end if;
        end if;
      end if;
    end if;
    return 0;
    ----Fin Nueva Seccion
    ut_trace.trace('Fin LDC_BCPeriodicReview.fnuGetLastOtRPR', 10);
  end fnuGetLastOtRPR;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : prValidateRP
  Descripcion    : Procedimiento que valida Causales vs Resultados vs Formulario RP durante la legalizacion
  Autor          :
  Fecha          : 28/10/2013

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  procedure prValidateRP is
    nuOrderId                ge_boInstanceControl.stysbValue;
    nuTaskTypeIdCurrentOrder or_task_type.task_type_id%type;
    nuCausalId               ge_causal.causal_id%type;
    sbAditionalAttribute     or_temp_data_values.data_value%type;
    nuOrderActivityId        or_order_activity.order_activity_id%type;
    --Cursor para obtener los defecto
    cursor cuDefects(inuOrderActivityId or_order_activity.order_activity_id%type) is
      select ge_defect.defect_id DEFECTO_RP
        from ge_defect, or_activ_defect
       where or_activ_defect.order_activity_id = inuOrderActivityId
         and or_activ_defect.defect_id = ge_defect.defect_id;
    --Cursor para obtener los gasodomesticos

    cursor cuAppliance(inuOrderActivityId or_order_activity.order_activity_id%type) is
      select sum(or_activ_appliance.activ_appliance_id)
        from or_activ_appliance
       where or_activ_appliance.order_activity_id = inuOrderActivityId;
    --Cursor para buscar configuracion
    cursor cuValidateRP(inuCausalId ge_causal.causal_id%type, isbDefect varchar2, isbCriticalDefect varchar2, isbGasAppliance varchar2, isbResultRP varchar2) is
      select LDC_VALIDATE_RP.ITEM_ID
        from LDC_VALIDATE_RP
       where LDC_VALIDATE_RP.CAUSAL_ID = inuCausalId
         and LDC_VALIDATE_RP.DEFECT = isbDefect
         and LDC_VALIDATE_RP.CRITICAL_DEFECT = isbCriticalDefect
         and LDC_VALIDATE_RP.GAS_APPLIANCE = isbGasAppliance
         and LDC_VALIDATE_RP.RESULT_RP = isbResultRP;

    sbDefect          varchar2(1) := 'N';
    sbCritical        varchar2(1) := 'N';
    sbGasAppliance    varchar2(1) := 'N';
    nuGasAppliance    number := 0;
    nuSupportActivity ge_items.items_id%type;

    --Cursor para obtener actividades de apoyo
    cursor cuSupportActivity(inuOrderId or_order.order_id%type, inuItemsId in ge_items.items_id%type) is
      select count(*)
        from or_order_activity
       where order_id = inuOrderId
         and or_order_activity.activity_id = inuItemsId;

    nuCount number := 0;

  begin
    ut_trace.trace('Inicio LDC_BCPeriodicReview.prValidateRP', 10);
    --Obtener orden de la instancia
    nuOrderId := or_bolegalizeorder.fnuGetCurrentOrder;
    ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prValidateRP  => nuOrderId => ' ||
                   nuOrderId,
                   10);
    --Obtener el tipo de trabajo de la ot que esta en la instancia
    nuTaskTypeIdCurrentOrder := daor_order.fnugettask_type_id(nuOrderId);
    ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prValidateRP => nuTaskTypeIdCurrentOrder => ' ||
                   nuTaskTypeIdCurrentOrder,
                   10);
    --Obtener Causal y Resultado
    nuCausalId := daor_order.fnugetcausal_id(nuOrderId);
    ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prValidateRP  => nuCausalId => ' ||
                   nuCausalId,
                   10);
    if nuTaskTypeIdCurrentOrder =
       DALD_parameter.fnuGetNumeric_Value('TIPO_TRABAJO_RP') and
       dage_causal.fnugetclass_causal_id(nuCausalId) = 1 then

      sbAditionalAttribute := to_char(ldc_boordenes.fsbDatoAdicTmpOrden(nuOrderId,
                                                                        to_number(DALD_parameter.fnuGetNumeric_Value('RESULTADO_RP')),
                                                                        'RESULTADO_RP'));
      ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prValidateRP => sbAditionalAttribute => ' ||
                     sbAditionalAttribute,
                     10);
      --Obtener defectos
      nuOrderActivityId := ldc_bcfinanceot.fnuGetActivityId(nuOrderId);
      ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prValidateRP => nuOrderActivityId => ' ||
                     nuOrderActivityId,
                     10);
      for rgDefect in cuDefects(nuOrderActivityId) loop
        sbDefect := 'Y';
        if dage_defect.fsbgetis_critical(rgDefect.DEFECTO_RP) = 'Y' then
          sbCritical := 'Y';
        end if;
      end loop;
      ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prValidateRP => sbDefect => ' ||
                     sbDefect,
                     10);
      ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prValidateRP => sbCritical => ' ||
                     sbCritical,
                     10);
      --Obtener gasodomestico
      open cuAppliance(nuOrderActivityId);
      fetch cuAppliance
        into nuGasAppliance;
      close cuAppliance;
      if nuGasAppliance > 0 then
        sbGasAppliance := 'Y';
      end if;
      ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prValidateRP => sbGasAppliance => ' ||
                     sbGasAppliance,
                     10);
      --Buscar si existe configuracion
      open cuValidateRP(nuCausalId,
                        sbDefect,
                        sbCritical,
                        sbGasAppliance,
                        sbAditionalAttribute);
      fetch cuValidateRP
        into nuSupportActivity;
      close cuValidateRP;
      ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prValidateRP => nuSupportActivity => ' ||
                     nuSupportActivity,
                     10);
      --Validar si la orden tiene asociada una actividad de apoyo
      --como la configurada
      if nuSupportActivity is not null then
        if nuSupportActivity <> -1 then
          open cuSupportActivity(nuOrderId, nuSupportActivity);
          fetch cuSupportActivity
            into nuCount;
          close cuSupportActivity;
          ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prValidateRP => nuCount => ' ||
                         nuCount,
                         10);
          if nuCount = 0 then
            ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                             'La orden [' || nuOrderId ||
                                             '] no tiene asociada ninguna Actividad de Apoyo ' ||
                                             dage_items.fsbgetdescription(nuSupportActivity));
            raise ex.CONTROLLED_ERROR;
          end if;
        end if;
      else
        ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                         'La combinacion CAUSAL + EXISTE DEFETO? + EL DEFECTO ES CRITICO?
                                                           + EXISTE GASODOMESTICO? + RESULTADO DE LA REVISION + ACTIVIDAD DE APOYO de la orden[' ||
                                         nuOrderId ||
                                         '] no esta permitida en PVORP');
        raise ex.CONTROLLED_ERROR;
      end if;
    end if;
    ut_trace.trace('Fin LDC_BCPeriodicReview.prValidateRP', 10);

  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      raise;
    when others then
      ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                       'Error al legalizar la orden' ||
                                       sqlcode || ' - ' || sqlerrm);
      raise;
  end prValidateRP;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : prLegalizeRVRP
  Descripcion    : Procedimiento que legaliza la orden de Reprogramar Visita RP
                   durante la legalizacion de una de la orden de revision periodica.
  Autor          :
  Fecha          : 14/11/2013

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  27-11-2013     Sayra Ocoro        Se adicionan instrucciones para empujar el flujo
                                    del tramire Reprogramar Visita RP
  10-12-2013     Sayra Ocoro        Se modifica la fuente del dato que se le asigna a la variable nuCodPersona
                                    para solucionar la NC 2126
  08-04-2014     Sayra Ocoro        * Aranda 3347: Se modifica la fuente del dato que se le asigna a la variable nuCodPersona.
  09-04-2014     Sayra Ocoro        * Aranda 3347_2: Se modifica la fuente del dato que se le asigna a la variable nuCodPersona.
  ******************************************************************/
  procedure prLegalizeRVRP is
    nuOrderId                or_order.order_id%type;
    nuCausalId               ge_causal.causal_id%type;
    nuTaskTypeIdCurrentOrder or_task_type.task_type_id%type;
    nuCausalClassId          ge_class_causal.class_causal_id%type;
    nuProductId              pr_product.product_id%type;
    nuOrderRVRP              or_order.order_id%type;
    nuPackagesGDS            MO_PACKAGES.Package_Id%type;
    nuCodPersona             ge_person.person_id%type;
    nuOperatinUnitId         or_operating_unit.operating_unit_id%type;
    nuCodUsuario             sa_user.user_id%type;
    nuInstance               number;

    --Cursor para obtener la orden de Reprogramar Visita RP asociada al producto
    cursor cuRVRP(inuProductId pr_product.product_id%type) is
      select OR_ORDER_ACTIVITY.order_id, MO_PACKAGES.Package_Id
        FROM OR_ORDER_ACTIVITY, OR_ORDER, MO_PACKAGES
       WHERE OR_ORDER_ACTIVITY.PRODUCT_ID = inuProductId
         and OR_ORDER_ACTIVITY.order_id = OR_ORDER.order_id
         and OR_ORDER_ACTIVITY.Package_Id = MO_PACKAGES.Package_Id
         and MO_PACKAGES.package_type_id =
             DALD_parameter.fnuGetNumeric_Value('ID_PKG_DOC_SOPORTE')
         and OR_ORDER.task_type_id =
             DALD_parameter.fnuGetNumeric_Value('ID_TT_RVRP') --10259
         and OR_ORDER.order_status_id =
             DALD_parameter.fnuGetNumeric_Value('COD_ESTADO_ASIGNADA_OT'); -- 5;

    nuCausalWF   ge_causal.causal_id%type;
    nuCausalRVRP ge_causal.causal_id%type;
    nuval        number;

  begin
    ut_trace.trace('Inicio LDC_BCPeriodicReview.prLegalizeRVRP', 10);
    --Obtener el identificador de la orden  que se encuentra en la instancia
    nuOrderId := or_bolegalizeorder.fnuGetCurrentOrder;
    ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prLegalizeRVRP => nuOrderId=>' ||
                   nuOrderId,
                   10);
    --Obtener el tipo de trabajo de la ot que esta en la instancia
    nuTaskTypeIdCurrentOrder := daor_order.fnugettask_type_id(nuOrderId);
    ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prLegalizeRVRP => nuTaskTypeIdCurrentOrder => ' ||
                   nuTaskTypeIdCurrentOrder,
                   10);
    --Validar si el tipo de trabajo es 12161
    if nuTaskTypeIdCurrentOrder =
       DALD_parameter.fnuGetNumeric_Value('TIPO_TRABAJO_RP') then
      --Obtener el producto asociado a la ot
      nuProductId := to_number(ldc_boutilities.fsbGetValorCampoTabla('or_order_activity',
                                                                     'order_id',
                                                                     'product_id',
                                                                     nuOrderId));
      ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prLegalizeRVRP => nuProductId => ' ||
                     nuProductId,
                     10);
      if nuProductId is not null and nuProductId <> -1 then
        --Buscar si existe una solicitud de  documentacion no atendida con una orden de Reprogramar visita RP
        --en estado ASIGNADO y legalizarla con la causal de la ot de la instancia
        open cuRVRP(nuProductId);
        fetch cuRVRP
          into nuOrderRVRP, nuPackagesGDS;
        close cuRVRP;
        ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prLegalizeRVRP  => nuOrderRVRP => ' ||
                       nuOrderRVRP,
                       10);
        ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prLegalizeRVRP  => nuPackagesGDS => ' ||
                       nuPackagesGDS,
                       10);
        if nuOrderRVRP is not null then
          --Obtener unidad Operativa
          nuOperatinUnitId := daor_order.fnugetoperating_unit_id(nuOrderRVRP);
          ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prLegalizeRVRP => nuOperatinUnitId => ' ||
                         nuOperatinUnitId,
                         10);
          -- Se obtiene el usuario conectado
          --nuCodUsuario := SA_BOUser.fnuGetUserId;
          --ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prLegalizeRVRP => nuCodUsuario => '||nuCodUsuario, 10);
          --Aranda 3347: Se obtiene la persona a la que se asigno la ot RVRP
          --nuCodPersona := daor_order_person.fnugetperson_id(nuOperatinUnitId,nuOrderRVRP);
          nuCodPersona := to_number(open.ldc_boutilities.fsbGetValorCampoTabla('or_oper_unit_persons',
                                                                               'operating_unit_id',
                                                                               'person_id',
                                                                               nuOperatinUnitId));
          ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prLegalizeRVRP => nuCodPersona => ' ||
                         nuCodPersona,
                         10);
          --nuCodPersona := GE_BCPerson.fnuGetFirstPersonByUserId(nuCodUsuario);
          --Obtener Causal de legalizacion
          nuCausalId := daor_order.fnugetcausal_id(nuOrderId);
          ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prLegalizeRVRP  => nuCausalId => ' ||
                         nuCausalId,
                         10);
          --Obtener clase de causal
          nuCausalClassId := dage_causal.fnugetclass_causal_id(nuCausalId);
          if nuCausalClassId = 1 then
            nuCausalRVRP := 8928;
          else
            nuCausalRVRP := 8929;
          end if;

          --Legalizar la ot
          ldc_closeOrder(nuOrderRVRP,
                         nuCausalRVRP,
                         nuCodPersona,
                         nuOperatinUnitId);
          -- 27-11-2013 Empujar el fujo de la solicitud de gestion de documentos

          -- Obtiene la causal de WF
          SELECT target_value
            INTO nuCausalWF
            FROM (SELECT target_value
                    FROM ge_equivalenc_values
                   WHERE equivalence_set_id = 218
                     AND origin_value = nuCausalRVRP
                     AND rownum = 1
                  UNION ALL
                  SELECT '-1' FLAG_VALIDATE FROM dual)
           WHERE rownum = 1;

          -- Obtiene la instance del Flujo
          begin
            SELECT instance_id
              INTO nuInstance
              FROM or_order_activity
             WHERE ORDER_id = nuOrderRVRP
               AND rownum = 1;
          exception
            when others then
              nuInstance := -1;
          end;

          -- Valida si tiene configurada Regeneracion que detiene el flujo.
          SELECT count(*)
            INTO nuVal
            FROM or_regenera_activida
           WHERE actividad in
                 (SELECT activity_id
                    FROM or_order_activity
                   WHERE order_id in (nuOrderRVRP))
             AND or_regenera_activida.id_causal = nuCausalRVRP
             AND or_regenera_activida.actividad_wf = 'Y';

          -- Envio de Actividad a la Cola de WF
          IF nuCausalWF <> -1 AND nuVal = 0 and nuInstance <> -1 THEN
            wf_boanswer_receptor.answerreceptorbyqueue(nuInstance,
                                                       to_number(nuCausalWF));
          END IF;
        end if;
      end if;

    end if;

    ut_trace.trace('Fin LDC_BCPeriodicReview.prLegalizeRVRP', 10);
  exception
    when ex.CONTROLLED_ERROR then
      raise;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  end prLegalizeRVRP;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : fnuGetSoliReviPerio
  Descripcion    : Funcion que retorna el numero de solicitud de la revision periodica
                   pasando el producto.
  Autor          : Emiro Leyva Hernandez
  Fecha          : 18/01/2014

  Parametros              Descripcion
  ============         ===================

  Fecha                  Autor             Modificacion
  =========            =========           ====================
  27-Febrero-2014    Jorge Valiente        Aranada 2962: Modificacion del servicio y Se valida
                                           con el Ing. Diego Soto (OPEN) y se sugiere modificar
                                           el servicio LDC_BCPERIODICREVIEW.FNUGETSOLIREVIPERIO
                                           para que se excluya las solicitudes cuya orden de
                                           revision fueron legalizadas con la causal 3243 cierra
                                           tramite RP.
   17/06/2015        Jorge Valiente        Cambio 7630: Crear un cursor cuultimaOTrpValida para
                                                        establecer las causales validas como paramatro y
                                                        poder validar mas de una causal.
  ******************************************************************/
  function fnuGetSoliReviPerio(inuProductId in mo_motive.product_id%type)
    return number is
    --Otiene la solicitud RP asociada al producto
    cursor cuultimaordenrp(inuproduct pr_product.product_id%type) is
      SELECT a.PACKAGE_ID
        FROM OR_ORDER_ACTIVITY a
      --Aranada 2962*/
       WHERE REGISTER_DATE =
             (SELECT MAX(Or_Order_Activity.Register_Date)
                FROM Or_Order_Activity, or_order
               WHERE Or_Order_Activity.Product_Id = inuProduct
                 AND Or_Order_Activity.Task_Type_Id = 12161
                 AND Or_Order_Activity.order_id = or_order.order_id
                 AND or_order.causal_id NOT IN (3243))
         AND a.Product_Id = inuProduct
         AND a.Task_Type_Id = 12161
         AND ROWNUM = 1;
    --Solucion aranada 2962*/
    /* --Filtro comentariado por ARANDA 2962 para aplicar
    solucion sujerida por el Ing. Diego Soto
    WHERE REGISTER_DATE = (SELECT MAX(Or_Order_Activity.Register_Date)
                           FROM Or_Order_Activity
                           WHERE Or_Order_Activity.Product_Id =inuProduct -- inuProduct
                           AND Or_Order_Activity.Task_Type_Id = 12161)
    AND a.Product_Id =inuProduct -- inuProduct
    AND a.Task_Type_Id = 12161
    AND ROWNUM=1;
    */

    nuPackagesRPId mo_packages.package_id%type;

    --cambio 7630
    --Otiene la solicitud RP asociada al producto
    cursor cuultimaOTrpValida(inuproduct pr_product.product_id%type) is
      SELECT a.PACKAGE_ID
        FROM OR_ORDER_ACTIVITY a
       WHERE REGISTER_DATE =
             (SELECT MAX(Or_Order_Activity.Register_Date)
                FROM Or_Order_Activity, or_order
               WHERE Or_Order_Activity.Product_Id = inuProduct
                 AND Or_Order_Activity.Task_Type_Id = 12161
                 AND Or_Order_Activity.order_id = or_order.order_id
                 AND or_order.causal_id in (select to_number(column_value)
                                               from table(open.ldc_boutilities.splitstrings(open.DALD_PARAMETER.fsbGetValue_Chain('COD_CAU_VAL_OT_RP',
                                                                                                                                  NULL),
                                                                                            ',')))
                 AND or_order.causal_id NOT IN (3243))
         AND a.Product_Id = inuProduct
         AND a.Task_Type_Id = 12161
         AND ROWNUM = 1;

     SBDESARROLLO VARCHAR2(4000) := 'OSS_JLVM_CAMBIO_7630';
     BLGDO        BOOLEAN := LDC_CONFIGURACIONRQ.aplicaParaGDO(SBDESARROLLO);
     BLEFIGAS     BOOLEAN := LDC_CONFIGURACIONRQ.aplicaParaEfigas(SBDESARROLLO);
     BLSURTIGAS   BOOLEAN := LDC_CONFIGURACIONRQ.aplicaParaSurtigas(SBDESARROLLO);
     BLGDC        BOOLEAN := LDC_CONFIGURACIONRQ.aplicaParaGDC(SBDESARROLLO);

    --fin cambio 7630

  begin
    ut_trace.trace('Inicio LDC_BCPeriodicReview.fnuGetSoliReviPerio', 10);

    --validacion creada por el cambio 7630
    --solo permite el use del nuevo cursor solo si el NIT de la gasera esta configurado
    IF BLGDC OR BLSURTIGAS OR BLEFIGAS OR BLGDO THEN
        ----Inicio Nueva Seccion
        OPEN cuultimaOTrpValida(inuProductId);
        FETCH cuultimaOTrpValida
          into nuPackagesRPId;
        close cuultimaOTrpValida;
    ELSE
        ----Inicio Nueva Seccion
        OPEN cuultimaordenrp(inuProductId);
        FETCH cuultimaordenrp
          into nuPackagesRPId;
        close cuultimaordenrp;
    END IF;
    --fin validacion creada por el cambio 7630

    ut_trace.trace('Ejecucion LDC_BCPeriodicReview.fnuGetSoliReviPerio => nuPackagesRPId => ' ||
                   nuPackagesRPId,
                   10);
    ut_trace.trace('Fin LDC_BCPeriodicReview.fnuGetSoliReviPerio', 10);

    /* codigo original comentariado para adaptarlo a la identificacion del objeto
    ----Inicio Nueva Seccion
    OPEN cuultimaordenrp(inuProductId);
    FETCH cuultimaordenrp
      into nuPackagesRPId;
    close cuultimaordenrp;
    ut_trace.trace('Ejecucion LDC_BCPeriodicReview.fnuGetSoliReviPerio => nuPackagesRPId => ' ||
                   nuPackagesRPId,
                   10);
    ut_trace.trace('Fin LDC_BCPeriodicReview.fnuGetSoliReviPerio', 10);
    */
    return nuPackagesRPId;

  end fnuGetSoliReviPerio;

  /*****************************************************************
   Propiedad intelectual de PETI (c).

   Unidad         : prFillOTREV
   Descripcion    : Procedimiento para llenar la tabla usada en el reporte prceso OTREV
   Autor          :
   Fecha          : 16/05/2014

   Parametros              Descripcion
   ============         ===================

   Fecha             Autor             Modificacion
   =========       =========           ====================
  23/06/2015       Mmejia              Aranda 7434. Se modifca los filtros del cursor  cuOTREV segun
                                       se especifica en el aranda.
  17/06/2015       Spacheco            aranda 7808 se realiza optimizacion de proceso
  28/07/2014   socoro@horbath.com   Aranda 3554: Se modifica cursor cuOTREV para no considerar los
                                    productos con solicitud 100270 - Certificaci?n de Trabajos en estado 13 - Registrado.
  11/09/2014   Jorge Valiente       RNP2180: 1. Modificacion del cursor cuOTTREV para qur al final filtre solamente los
                                             prodcutos que no este identificados como items especiales
                                             2. Crear un cursor para registrar los items especiales para definido en la
                                             legalizacion de calentadores especiales
   ******************************************************************/

  PROCEDURE prFillOTREV IS

    nuMESESRPITEMESPECIAL     number := dald_parameter.fnuGetNumeric_Value('MESES_PROXIMA_RP_ITEM_ESPECIAL',
                                                                           null);
    v_id_items_estado_inv_USO number := DALD_PARAMETER.fnuGetNumeric_Value('ESTADO_ITEM_SERIADO_USO',
                                                                           NULL);
    nuitem                    number := dald_parameter.fnuGetNumeric_Value('COD_ITEM_ESPECIALES',
                                                                           NULL);
    nuCant                    number := 0;

    ---rnp2180
    cursor cuOTREV_items_especiales is
      select /*+ PARALLEL */
       "PRODUCT_ID",
       "CLIENTE",
       "IDENTIFICACION",
       "NOMBRE",
       "APELLIDO",
       "DIRECCION",
       "CODIGO_DEPARTAMENTO",
       "DEPARTAMENTO",
       "CODIGO_LOCALIDAD",
       "LOCALIDAD",
       "CODIGO_BARRIO",
       "BARRIO",
       "CICLO",
       "USO",
       "ESTRATO",
       "MESES"
        from (select PRODUCTO "PRODUCT_ID",
                     SUBSCRIBER_ID "CLIENTE",
                     IDENTIFICATION "IDENTIFICACION",
                     SUBSCRIBER_NAME "NOMBRE",
                     nvl(SUBS_LAST_NAME, '-') "APELLIDO",
                     ADDRESS "DIRECCION",
                     GEO_LOCA_FATHER_ID "CODIGO_DEPARTAMENTO",
                     Departamento "DEPARTAMENTO",
                     GEOGRAP_LOCATION_ID "CODIGO_LOCALIDAD",
                     Localidad "LOCALIDAD",
                     nvl(NEIGHBORTHOOD_ID, -1) "CODIGO_BARRIO",
                     DESC_BARR "BARRIO",
                     Ciclo "CICLO",
                     Cat "USO",
                     Subc "ESTRATO",
                     Meses "MESES",
                     nvl((select or_order.causal_id
                           from Open.or_order_activity, Open.or_order
                          where or_order_activity.product_id = PRODUCTO
                            and or_order_activity.task_type_id in
                                (12161, 12164)
                            and or_order.order_id =
                                or_order_activity.order_id
                            and or_order.order_status_id = 8
                            and or_order.legalization_date =
                                (select MAX(or_order.legalization_date)
                                   from Open.or_order_activity, Open.or_order
                                  where or_order_activity.product_id =
                                        PRODUCTO
                                    and or_order_activity.task_type_id in
                                        (12161, 12164)
                                    and or_order.order_id =
                                        or_order_activity.order_id
                                    and or_order.order_status_id = 8)
                            and rownum = 1),
                         -1) Causal_Revision_periodica
                FROM (select SESUNUSE PRODUCTO,
                             a.SUBSCRIBER_ID,
                             a.IDENTIFICATION,
                             a.SUBSCRIBER_NAME,
                             nvl(a.SUBS_LAST_NAME, '-') SUBS_LAST_NAME,
                             b.ADDRESS,
                             (select /*+ index (c PK_GE_GEOGRA_LOCATION)*/
                               c.GEO_LOCA_FATHER_ID
                                from OPEN.GE_GEOGRA_LOCATION c
                               where c.GEOGRAP_LOCATION_ID =
                                     b.GEOGRAP_LOCATION_ID) GEO_LOCA_FATHER_ID,
                             OPEN.LDC_BOUTILITIES.fsbGetValorCampoTabla('GE_GEOGRA_LOCATION',
                                                                        'GEOGRAP_LOCATION_ID',
                                                                        'DESCRIPTION',
                                                                        (select /*+ index (c PK_GE_GEOGRA_LOCATION)*/
                                                                          c.GEO_LOCA_FATHER_ID
                                                                           from OPEN.GE_GEOGRA_LOCATION c
                                                                          where c.GEOGRAP_LOCATION_ID =
                                                                                b.GEOGRAP_LOCATION_ID)) Departamento,

                             b.GEOGRAP_LOCATION_ID,
                             (select /*+ index (c PK_GE_GEOGRA_LOCATION)*/
                               c.DESCRIPTION
                                from OPEN.GE_GEOGRA_LOCATION c
                               where c.GEOGRAP_LOCATION_ID =
                                     b.GEOGRAP_LOCATION_ID) Localidad,

                             b.NEIGHBORTHOOD_ID,
                             OPEN.LDC_BOUTILITIES.fsbGetValorCampoTabla('GE_GEOGRA_LOCATION',
                                                                        'GEOGRAP_LOCATION_ID',
                                                                        'DESCRIPTION',
                                                                        b.NEIGHBORTHOOD_ID) DESC_BARR,
                             e.sesucicl Ciclo,
                             e.SESUCATE Cat,
                             e.SESUSUCA Subc,
                             (select nuMESESRPITEMESPECIAL -
                                     months_between(trunc(to_date(plazo_maximo),
                                                          'MONTH'),
                                                    trunc(sysdate, 'MONTH'))
                                from OPEN.LDC_PLAZOS_CERT
                               where id_producto = f.product_id) Meses
                        from OPEN.servsusc      e,
                             OPEN.pr_product    f, /*suscripc d,*/
                             OPEN.ge_subscriber a,
                             OPEN.ab_address    b
                       where e.SESUSERV = 7014
                         and e.sesunuse <> -1
                         and e.sesucate in
                             (SELECT TO_NUMBER(COLUMN_VALUE)
                                FROM TABLE(OPEN.LDC_BOUTILITIES.SPLITSTRINGS(OPEN.DALD_PARAMETER.fsbGetValue_Chain('COD_CATEG_VALIDOS_OTREV',
                                                                                                                   NULL),
                                                                             ',')))

                         AND f.product_id = e.sesunuse
                            ----calentador especial
                         and e.sesunuse in
                             (select /*+ index (gis IX_GE_ITEMS_SERIADO05)*/
                               to_number(gis.numero_servicio)
                                from OPEN.ge_items_seriado gis
                               where gis.id_items_estado_inv =
                                     v_id_items_estado_inv_USO
                                 and gis.items_id = nuitem
                                 AND TO_NUMBER(GIS.NUMERO_SERVICIO) =
                                     f.product_id)
                            -----fin calentador
                         and f.product_status_id = 1
                         and e.sesuesfn not in ('C')
                         and exists
                       (select /*+ index (d PK_SUSCRIPC IX_SUSCRIPC017)*/
                               1
                                from OPEN.suscripc d
                               where d.SUSCCODI = f.subscription_id
                                 and d.SUSCCLIE = a.SUBSCRIBER_ID)
                         AND a.ACTIVE = 'Y'
                         and b.ADDRESS_ID = f.ADDRESS_ID
                         and not exists
                       (select /*+ index (c PK_PS_MOTIVE_STATUS)*/
                               1
                                from OPEN.mo_packages      mp,
                                     OPEN.ps_motive_status c,
                                     OPEN.mo_motive        x
                               WHERE mp.PACKAGE_TYPE_ID in
                                     (265, 266, 100237, 100153, 100246, 100156,
                                      100248, 100014, 100153, 100270)

                                 AND c.MOTIVE_STATUS_ID = mp.MOTIVE_STATUS_ID
                                 AND c.MOTI_STATUS_TYPE_ID = 2
                                 AND c.MOTIVE_STATUS_ID not in (14, 32, 51)
                                 and x.PACKAGE_ID = mp.PACKAGE_ID
                                 and x.PRODUCT_ID = f.product_id)
                            --Validar la existencia de solicitudes de servicios
                            --asociados con ordenes certificables
                            --/*
                         and not exists
                       (select /*+ index  (ooa IDX_OR_ORDER_ACTIVITY_010,IDX_OR_ORDER_ACTIVITY_06)*/
                               1
                                from OPEN.or_order_activity ooa,
                                     OPEN.mo_packages       mp
                               where ooa.PRODUCT_ID = f.product_id
                                 and ooa.task_type_id =
                                     (select /*+ index (ltc PK_LDC_TRAB_CERT)*/
                                       ltc.id_trabcert
                                        from OPEN.ldc_trab_cert ltc
                                       where ltc.id_trabcert = ooa.task_type_id)
                                 and (select oo.order_status_id
                                        from OPEN.or_order oo
                                       where oo.order_id = ooa.order_id) in
                                     (0, 5, 7)
                                 and mp.package_id = ooa.package_id
                                 and mp.package_type_id = 100101)
                      /*
                                                                  and not exists  ( select 1
                                                                                   from ldc_marca_producto
                                                                                   where ldc_marca_producto.id_producto = f.product_id )--*/
                      )) l
       where l.Causal_Revision_periodica not in
             (3103, 3104, 3105, 3106, 3107, 3108, 3109, 3112, 9582);
    --fin rnp2180

    cursor cuOTREV is
      select /*+ PARALLEL */
       "PRODUCT_ID",
       "CLIENTE",
       "IDENTIFICACION",
       "NOMBRE",
       "APELLIDO",
       "DIRECCION",
       "CODIGO_DEPARTAMENTO",
       "DEPARTAMENTO",
       "CODIGO_LOCALIDAD",
       "LOCALIDAD",
       "CODIGO_BARRIO",
       "BARRIO",
       "CICLO",
       "USO",
       "ESTRATO",
       "MESES"
        from (select PRODUCTO "PRODUCT_ID",
                     SUBSCRIBER_ID "CLIENTE",
                     IDENTIFICATION "IDENTIFICACION",
                     SUBSCRIBER_NAME "NOMBRE",
                     nvl(SUBS_LAST_NAME, '-') "APELLIDO",
                     ADDRESS "DIRECCION",
                     GEO_LOCA_FATHER_ID "CODIGO_DEPARTAMENTO",
                     Departamento "DEPARTAMENTO",
                     GEOGRAP_LOCATION_ID "CODIGO_LOCALIDAD",
                     Localidad "LOCALIDAD",
                     nvl(NEIGHBORTHOOD_ID, -1) "CODIGO_BARRIO",
                     DESC_BARR "BARRIO",
                     Ciclo "CICLO",
                     Cat "USO",
                     Subc "ESTRATO",
                     Meses "MESES",
                     nvl((select or_order.causal_id
                           from Open.or_order_activity, Open.or_order
                          where or_order_activity.product_id = PRODUCTO
                            and or_order_activity.task_type_id in
                                (12161, 12164)
                            and or_order.order_id =
                                or_order_activity.order_id
                            and or_order.order_status_id = 8
                            and or_order.legalization_date =
                                (select MAX(or_order.legalization_date)
                                   from Open.or_order_activity, Open.or_order
                                  where or_order_activity.product_id =
                                        PRODUCTO
                                    and or_order_activity.task_type_id in
                                        (12161, 12164)
                                    and or_order.order_id =
                                        or_order_activity.order_id
                                    and or_order.order_status_id = 8)
                            and rownum = 1),
                         -1) Causal_Revision_periodica
                FROM (select SESUNUSE PRODUCTO,
                             a.SUBSCRIBER_ID,
                             a.IDENTIFICATION,
                             a.SUBSCRIBER_NAME,
                             nvl(a.SUBS_LAST_NAME, '-') SUBS_LAST_NAME,
                             b.ADDRESS,
                             c.GEO_LOCA_FATHER_ID,
                             LDC_BOUTILITIES.fsbGetValorCampoTabla('GE_GEOGRA_LOCATION',
                                                                   'GEOGRAP_LOCATION_ID',
                                                                   'DESCRIPTION',
                                                                   c.GEO_LOCA_FATHER_ID) Departamento,

                             b.GEOGRAP_LOCATION_ID,
                             c.DESCRIPTION Localidad,

                             b.NEIGHBORTHOOD_ID,
                             LDC_BOUTILITIES.fsbGetValorCampoTabla('GE_GEOGRA_LOCATION',
                                                                   'GEOGRAP_LOCATION_ID',
                                                                   'DESCRIPTION',
                                                                   b.NEIGHBORTHOOD_ID) DESC_BARR,
                             e.sesucicl Ciclo,
                             e.SESUCATE Cat,
                             e.SESUSUCA Subc,
                             ldc_getEdadRP(e.SESUNUSE) Meses
                        from servsusc           e,
                             pr_product         f,
                             suscripc           d,
                             ge_subscriber      a,
                             ab_address         b,
                             GE_GEOGRA_LOCATION c

                       where e.SESUSERV = 7014
                         and e.sesunuse <> -1
                         ------and ldc_getEdadRP(e.SESUNUSE) > 52
                         --Mmejia 23/06/2015
                         --Aranda.7434
                         --2.	Se debe crear un par?metro que controle la condici?n de la cantidad de meses
                         AND ldc_getEdadRP(e.SESUNUSE) > DALD_PARAMETER.fnuGetNUMERIC_VALUE('VALIDAR_MESES_OTREV',NULL)
                         and e.sesucate in
                             (SELECT TO_NUMBER(COLUMN_VALUE)
                                FROM TABLE(LDC_BOUTILITIES.SPLITSTRINGS(DALD_PARAMETER.fsbGetValue_Chain('COD_CATEG_VALIDOS_OTREV',
                                                                                                         NULL),
                                                                        ',')))

                         AND f.product_id = e.sesunuse
                         and f.product_status_id = 1
                         and e.sesuesfn not in ('C')
                         --Mmejia 23/06/2015
                         --Aranda.7434
                         --1.	Se debe crear un par?metro que permita validar el estado de corte
                         and e.sesuesco in
                             (SELECT TO_NUMBER(COLUMN_VALUE)
                                FROM TABLE(LDC_BOUTILITIES.SPLITSTRINGS(DALD_PARAMETER.fsbGetValue_Chain('ESTADO_CORTE_OTREV',
                                                                                                         NULL),
                                                                        ',')))
                         and d.SUSCCODI = f.subscription_id
                         and a.SUBSCRIBER_ID = d.SUSCCLIE
                         AND a.ACTIVE = 'Y'
                         and b.ADDRESS_ID = f.ADDRESS_ID
                         and c.GEOGRAP_LOCATION_ID = b.GEOGRAP_LOCATION_ID
                            --
                         and not exists
                       (select 1
                                from mo_packages      a,
                                     ps_motive_status c,
                                     mo_motive        x
                               WHERE ------a.PACKAGE_TYPE_ID in
                                     ------(265, 266, 100237, 100153, 100246, 100156,
                                     ------ 100248, 100014, 100153, 100270)
                                 --Mmejia 23/06/2015
                                 --Aranda.7434
                                 --3.se debe crear el siguiente par?metro VAL_TIPO_PAQUETE_OTREV
                                 ------AND
                                 a.PACKAGE_TYPE_ID IN
                                    (SELECT TO_NUMBER(COLUMN_VALUE)
                                      FROM TABLE(LDC_BOUTILITIES.SPLITSTRINGS(DALD_PARAMETER.fsbGetValue_Chain('VAL_TIPO_PAQUETE_OTREV',
                                                                                                                NULL),
                                                                              ',')))

                                 AND c.MOTIVE_STATUS_ID = a.MOTIVE_STATUS_ID
                                 AND c.MOTI_STATUS_TYPE_ID = 2
                                 AND c.MOTIVE_STATUS_ID not in (14, 32, 51)
                                 and x.PACKAGE_ID = a.PACKAGE_ID
                                 and x.PRODUCT_ID = f.product_id)
                            --Validar la existencia de solicitudes de servicios
                            --asociados con ordenes certificables
                         and not exists
                       (select 1
                                from ldc_trab_cert,
                                     or_order_activity,
                                     or_order,
                                     mo_packages
                               where or_order_activity.PRODUCT_ID =
                                     f.product_id
                                 and id_trabcert =
                                     or_order_activity.task_type_id
                                 and or_order.order_id =
                                     or_order_activity.order_id
                                 and order_status_id in (0, 5, 7)
                                 and mo_packages.package_id =
                                     or_order_activity.package_id
                                 and mo_packages.package_type_id = 100101)
                         and not exists (select 1
                                from ldc_marca_producto
                               where ldc_marca_producto.id_producto =
                                     f.product_id))) l
       where l.Causal_Revision_periodica not in
             (3103, 3104, 3105, 3106, 3107, 3108, 3109, 3112, 9582)
         and l.PRODUCT_ID not in
             (select /*+ index (gis IX_GE_ITEMS_SERIADO05)*/
               to_number(gis.numero_servicio)
                from OPEN.ge_items_seriado gis
               where gis.id_items_estado_inv = v_id_items_estado_inv_USO
                 and gis.items_id = nuitem
                 AND TO_NUMBER(GIS.NUMERO_SERVICIO) = l.PRODUCT_ID);


   --Mmejia 23/06/2015
   --Aranda.7434
   --4.Se debe adicionar una validacion para los productos que tengan
   --ordenes con  tipos de trabajo 10444 - Visita Identificacion Certificado
   --o 12161 - REVISION PERIODICA
   CURSOR cuValOrdRP(nuproduct_id NUMBER) IS
    select /*+ INDEX(LDC_PLAZOS_CERT idx_plazoscert_prod)  */
            1 valor
  from
        or_order_activity,
        or_order,
        mo_packages,
        LDC_PLAZOS_CERT
  where or_order_activity.PRODUCT_ID = nuproduct_id
    and or_order.order_id =
        or_order_activity.order_id
    and order_status_id in (0,5,8)
    AND or_order.task_type_id IN(10444,12161)
    AND LDC_PLAZOS_CERT.id_producto  =nuproduct_id
    AND or_order.created_date >  LDC_PLAZOS_CERT.plazo_min_revision
    and mo_packages.package_id =
    or_order_activity.package_id
    AND mo_packages.motive_status_id  IN(13,14);

    rccuValOrdRP cuValOrdRP%ROWTYPE;


    sbQuery varchar2(2000);
    --<<
    -- Tipo de dato cuOTREV Spacheco ara 7808 optimizacion
    -->>
    TYPE tycuOTREV IS TABLE OF cuOTREV%ROWTYPE;

    --<<
    -- Variable del tipo de dato tycuOTREV Spacheco ara 7808 optimizacion
    -->>
    vtycuOTREV tycuOTREV := tycuOTREV();

    --<<
    -- Tipo de dato cuOTREV_items_especiales Spacheco ara 7808 optimizacion
    -->>
    TYPE tycuOTREV_items_especiales IS TABLE OF cuOTREV_items_especiales%ROWTYPE;

    --<<
    -- Variable del tipo de dato tycuOTREV_items_especiales Spacheco ara 7808 optimizacion
    -->>
    vtycuOTREV_items_especiales tycuOTREV_items_especiales := tycuOTREV_items_especiales();

  BEGIN

    pkErrors.Push('LDC_BCPeriodicReview.prFillOTREV');
    --/*
    sbQuery := 'truncate table ldc_otrev';
    execute immediate sbQuery;
    dbms_output.put_line('Inicio LDC_BCPeriodicReview.prFillOTREV - ' ||
                         sysdate);

    ---spacheco ara 7808 optimizcion de proceso
    -- <<
    -- Apertura cursor cuOTREV
    -->>
    OPEN cuOTREV;

    LOOP

      --<<
      -- Borrar tabla PL vtycuOTREV
      -->>
      vtycuOTREV.DELETE;

      --<<
      -- Carga controlada de registros
      -->>
      FETCH cuOTREV BULK COLLECT
        INTO vtycuOTREV LIMIT 1000;

      --<<
      -- Recorrido de registros de la tabla pl tbl_datos
      -->>
      FOR nuindice IN 1 .. vtycuOTREV.COUNT LOOP
        --Aranda 7434
        --Validar las ordes de RP
        rccuValOrdRP := NULL;

        --Abre el cursor
        OPEN cuValOrdRP(vtycuOTREV(nuindice).PRODUCT_ID);
        FETCH cuValOrdRP INTO rccuValOrdRP;
        CLOSE cuValOrdRP;
        --Valida la salida del cursor
        IF(rccuValOrdRP.valor IS NULL)THEN
          --<<Valida para insertar

          BEGIN

            --<<
            -- Inserta registros en la tabla ldc_otrev
            -->>
            INSERT INTO /*+ append */
            ldc_otrev
            VALUES
              (vtycuOTREV(nuindice).PRODUCT_ID,
              vtycuOTREV(nuindice).CLIENTE,
              vtycuOTREV(nuindice).IDENTIFICACION,
              vtycuOTREV(nuindice).NOMBRE,
              vtycuOTREV(nuindice).APELLIDO,
              vtycuOTREV(nuindice).DIRECCION,
              vtycuOTREV(nuindice).CODIGO_DEPARTAMENTO,
              vtycuOTREV(nuindice).DEPARTAMENTO,
              vtycuOTREV(nuindice).CODIGO_LOCALIDAD,
              vtycuOTREV(nuindice).LOCALIDAD,
              vtycuOTREV(nuindice).CODIGO_BARRIO,
              vtycuOTREV(nuindice).BARRIO,
              vtycuOTREV(nuindice).CICLO,
              vtycuOTREV(nuindice).USO,
              vtycuOTREV(nuindice).ESTRATO,
              vtycuOTREV(nuindice).MESES);

          EXCEPTION
            WHEN OTHERS THEN
              NULL;
          END;
         END IF; --Validacion de ordenes de RP
        END LOOP;
        COMMIT;--commit cada 1000 registros

      EXIT WHEN cuOTREV%NOTFOUND;

    END LOOP;

    --<<
    -- Cierre del cursor cuOTREV.
    -->>
    IF (cuOTREV%ISOPEN) THEN

      CLOSE cuOTREV;

    END IF;
    COMMIT;

    --fin modificacion spacheco ara 7808 optimizacion

    --*/

    --inicio rnp2180
    sbQuery := 'truncate table ldc_otrev_items_especiales';
    EXECUTE IMMEDIATE sbQuery;

    --Spacheco ara 7808 optimizacion de proceso
    -- <<
    -- Apertura cursor cuOTREV_items_especiales
    -->>
    OPEN cuOTREV_items_especiales;

    LOOP

      --<<
      -- Borrar tabla PL vtycuOTREV_items_especiales
      -->>
      vtycuOTREV_items_especiales.delete;

      --<<
      -- Carga controlada de registros
      -->>
      FETCH cuOTREV_items_especiales BULK COLLECT
        INTO vtycuOTREV_items_especiales LIMIT 1000;

      --<<
      -- Recorrido de registros de la tabla pl tbl_datos
      -->>
      FOR nuindice IN 1 .. vtycuOTREV_items_especiales.COUNT LOOP

        BEGIN

          --<<
          -- Inserta registros en la tabla ldc_otrev_items_especiales
          -->>
          insert /*+ append */
          into ldc_otrev_items_especiales
          values
            (vtycuOTREV_items_especiales(nuindice).PRODUCT_ID,
             vtycuOTREV_items_especiales(nuindice).CLIENTE,
             vtycuOTREV_items_especiales(nuindice).IDENTIFICACION,
             vtycuOTREV_items_especiales(nuindice).NOMBRE,
             vtycuOTREV_items_especiales(nuindice).APELLIDO,
             vtycuOTREV_items_especiales(nuindice).DIRECCION,
             vtycuOTREV_items_especiales(nuindice).CODIGO_DEPARTAMENTO,
             vtycuOTREV_items_especiales(nuindice).DEPARTAMENTO,
             vtycuOTREV_items_especiales(nuindice).CODIGO_LOCALIDAD,
             vtycuOTREV_items_especiales(nuindice).LOCALIDAD,
             vtycuOTREV_items_especiales(nuindice).CODIGO_BARRIO,
             vtycuOTREV_items_especiales(nuindice).BARRIO,
             vtycuOTREV_items_especiales(nuindice).CICLO,
             vtycuOTREV_items_especiales(nuindice).USO,
             vtycuOTREV_items_especiales(nuindice).ESTRATO,
             vtycuOTREV_items_especiales(nuindice).MESES);

        EXCEPTION

          WHEN OTHERS THEN

            null;

        END;

      END LOOP;

      COMMIT;

      EXIT WHEN cuOTREV_items_especiales%NOTFOUND;

    END LOOP;

    --<<
    -- Cierre del cursor cuOTREV_items_especiales.
    -->>
    IF (cuOTREV_items_especiales%ISOPEN) THEN

      CLOSE cuOTREV_items_especiales;

    END IF;
    COMMIT;

    ------fin modificion spacheco ara 7808 optimizacion
    --fin rnp2180

    dbms_output.put_line('Fin LDC_BCPeriodicReview.prFillOTREV - ' ||
                         sysdate);
    pkErrors.Pop;

  EXCEPTION
    when others then
      dbms_output.put_line('Error LDC_BCPeriodicReview.prFillOTREV ' ||
                           sqlcode || ' - ' || sqlerrm);
      raise;
  END prFillOTREV;

  /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : prValidate10438
    Descripcion    : Procedimiento para validar la respuesta del usuario a la orden con tt = 12161
    Autor          :
    Fecha          : 16/05/2014

    Parametros              Descripcion
    ============         ===================

    Fecha             Autor             Modificacion
    =========       =========           ====================
  28/07/2014    socoro@horbath.com     Se adiciona validaci?n: si para el producto se encuentra registrado un
                                       tr?mite 100101 con una orden de  tipo de trabajo 12137 - Reparaci?n
                                       Inmediata y actividad 4000038 -  Reparaci?n Inmediata en estado
                                       registrado o asignado, para este caso debe levantar un mensaje de
                                       error que indique que la causal que seber?a seleccionar para la legalizaci?n es la  8967 - PENDIENTE POR CERTIFICAR ACEPTA TRABAJOS
    ******************************************************************/

  procedure prValidate10438 is

    nuOrderId         or_order.order_id%type;
    nuOrderIdRP       or_order.order_id%type;
    nuTaskTypeId      or_task_type.task_type_id%type;
    nuCausalId        ge_causal.causal_id%type;
    nuASE             number;
    nuGeograpLoca     ge_geogra_location.geograp_location_id%type;
    nuProductId       pr_product.product_id%type;
    nuAdressId        ab_address.address_id%type;
    dtLegalizeRP      date;
    nuOrderActivityId or_order_activity.order_id%type;
    nuPackagesId      mo_packages.package_id%type;
    nuIntentos        number := 0;
    --Obtiene la orden RP asociada al producto
    cursor cuOTRP(inuPackagesId mo_packages.package_id%type) is
      select or_order.order_id, or_order.legalization_date
        from or_order_activity, or_order
       where or_order_activity.package_id = inuPackagesId
         and or_order_activity.task_type_id =
             dald_parameter.fnuGetNumeric_Value('TIPO_TRABAJO_RP')
         and or_order_activity.order_id = or_order.order_id;

    --Cursor para validar si el producto tiene un tr?mite de emergencia en curso
    cursor cuOrderEmergency(inuProductId pr_product.product_id%type) is
      select count(*)
        from or_order, or_order_activity
       where or_order_activity.product_id = inuProductId
         and or_order.task_type_id = 12137
         and activity_id = 4000038
         and or_order.order_id = or_order_activity.order_id
         and or_order.order_status_id in (0, 5);
    nuCountEmergency            number := 0;
    nuCausalPendienteCertificar ge_causal.causal_id%type := 8967;
    nuCausalNoAceptaRep         ge_causal.causal_id%type := 3299;
    nuOt                        or_order.order_id%type;
  begin
    ut_trace.trace('Inicio LDC_BCPeriodicReview.prValidate10438', 10);
    --Obtener orden de la instancia
    nuOrderId := or_bolegalizeorder.fnuGetCurrentOrder;
    ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prValidate10438  => nuOrderId => ' ||
                   nuOrderId,
                   10);
    --Obtener el tipo de trabajo de la ot que esta en la instancia
    nuTaskTypeId := daor_order.fnugettask_type_id(nuOrderId);
    ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prValidate10438 => nuTaskTypeId => ' ||
                   nuTaskTypeId,
                   10);
    --Obtener Causal y Resultado
    nuCausalId := daor_order.fnugetcausal_id(nuOrderId);
    ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prValidate10438  => nuCausalId => ' ||
                   nuCausalId,
                   10);
    --Obtener el producto asociado a la orden
    nuProductId := to_number(ldc_boutilities.fsbgetvalorcampotabla('OR_ORDER_ACTIVITY',
                                                                   'order_id',
                                                                   'PRODUCT_ID',
                                                                   nuOrderId));
    --Obtener direccion
    nuAdressId := dapr_product.fnugetaddress_id(nuProductId);
    --Obtener la localidad de la direccion
    nuGeograpLoca := daab_address.fnugetgeograp_location_id(nuAdressId,
                                                            NULL);
    ut_trace.trace('nuGeograpLoca --> ' || nuGeograpLoca, 10);
    --Validar existencia de tr?mite de emergencia
    open cuOrderEmergency(nuProductId);
    fetch cuOrderEmergency
      into nuCountEmergency;
    close cuOrderEmergency;
    if nuCausalId <> nuCausalPendienteCertificar and nuCountEmergency > 0 then
      ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                       'La orden [' || nuOrderId ||
                                       '] debe legalizarse con la causal 8967 - ' ||
                                       dage_causal.fsbgetdescription(nuCausalPendienteCertificar) ||
                                       ' Ya que tienen un tr?mite 100101 - ' ||
                                       daps_package_type.fsbgetdescription(100101) ||
                                       ' con tipo de trabajo 12137 - ' ||
                                       daor_task_type.fsbgetdescription(12137) ||
                                       ' registrado');
      raise ex.CONTROLLED_ERROR;
    end if;
    --El producto esta activo y pertenece a ASE
    nuASE := ldci_pkrevisionperiodicaweb.fnuGetLocalidadesASE(nuGeograpLoca);
    -- E ASE = 1 ?E ASE = 0
    --Validar causal negativa
    IF nuCausalId = nuCausalNoAceptaRep then
      if nuASE = 1 then
        ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                         'El producto pertenece a una Localidad ASE, debe repararse con GDO');
        raise ex.CONTROLLED_ERROR;
      else

        --Obtener OT de revision del tramite
        nuOrderActivityId := ldc_bcfinanceot.fnuGetActivityId(nuOrderId);
        nuPackagesId      := daor_order_activity.fnugetpackage_id(nuOrderActivityId);
        --   open cuOTRP(nuPackagesId);
        --   fetch cuOTRP into nuOrderIdRP,dtLegalizeRP;
        --   close cuOTRP;
        --Validar la existencia de la marcar del producto

        nuOt := LDCI_PKREVISIONPERIODICAWEB.fnuGetOtUltimaRP(nuProductId);
        if nuOt is null then
          dtLegalizeRP := trunc(sysdate);
        else
          dtLegalizeRP := daor_order.fdtgetlegalization_date(nuOt);
        end if;

        if daldc_marca_producto.fblExist(nuProductId) then
          nuIntentos := daldc_marca_producto.fnuGetINTENTOS(nuProductId);
          nuIntentos := nuIntentos + 1;
          daldc_marca_producto.updFECHA_ULTIMA_ACTU(nuProductId,
                                                    dtLegalizeRP);
          daldc_marca_producto.updINTENTOS(nuProductId, nuIntentos);
          daldc_marca_producto.updORDER_ID(nuProductId, nuOrderId);
          daldc_marca_producto.updREGISTER_POR_DEFECTO(nuProductId, 'Y');
          daldc_marca_producto.updMEDIO_RECEPCION(nuProductId, 'I');
          daldc_marca_producto.updSUSPENSION_TYPE_ID(nuProductId, 102);
        else
          insert into ldc_marca_producto
            (id_producto,
             order_id,
             certificado,
             fecha_ultima_actu,
             intentos,
             medio_recepcion,
             register_por_defecto,
             suspension_type_id)
          values
            (nuProductId, nuOrderId, null, dtLegalizeRP, 1, 'I', 'Y', 102);
        end if;

      end if;

    END IF;

    ut_trace.trace('Fin LDC_BCPeriodicReview.prValidate10438', 10);

  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      raise;
    when others then
      ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                       'Error al legalizar la orden' ||
                                       sqlcode || ' - ' || sqlerrm);
      raise;
  end prValidate10438;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : prGenerateCertificate
  Descripcion    : Procedimiento para generar la ot de certificacion durante la legalizacion de
                   ortenes de reparacion si el producto no se encuentra en una localidad as
  Autor          :
  Fecha          : 19/05/2014

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  09/Oct/2014     Jorge Valiente      RNP1621: MENDIANTE LA VALIDACION DEL TIPO DE TRABAJO DE LA ORDEN
                                               A LEGALIZAR SE DEBE CONFIRMAR QUE ESTE TIPO DE TRABAJO
                                               CON ACTIVIDAD Y TRAMITE ESTA CONFIGURADO PARA GENERAR
                                               ORDEN DE CERTIFICACION.
                                               ESTA VALIDACION SE REALIZARA EN LA ENTIDAD LDC_TIPOTRAB_CERTIFICA
                                               DE LA FORMA LDCTTGC
  12/Feb/2015       Oparra            Aranda 139041. Se corrige error reportado en el usa de la funcion "instr"
                                              de oracle
  09/MAr/2015     Emiro Leyva         Aranda 6500: Se cambia el metodo que obtiene el Tipo de trabajo.
  04/May/2015       Oparra            Aranda 5695: Se valida los tipos de tramite segun parametro
  ******************************************************************/

  procedure prGenerateCertificate(nuOrderId       IN or_order.order_id%TYPE,
                                  inuCurrent      IN NUMBER,
                                  inuTotal        IN NUMBER,
                                  onuErrorCode    OUT NUMBER,
                                  osbErrorMessage OUT VARCHAR) is

    nuOrderIdRP   or_order.order_id%type;
    nuInstanceId  OR_ORDER_ACTIVITY.INSTANCE_ID%type;
    nuCategory    categori.catecodi%type := 0;
    nuActivityId  ge_Items.Items_Id%type;
    isbComment    varchar2(2000) := ' - ';
    nuASE         number;
    nuGeograpLoca ge_geogra_location.geograp_location_id%type;
    nuProductId   pr_product.product_id%type;
    nuAdressId    ab_address.address_id%type;
    dtLegalizeRP  date;

    nuOrderActivityId or_order_activity.order_id%type;
    nuPackagesId      mo_packages.package_id%type;
    nuTaskTypeId      or_task_type.task_type_id%type;
    nuIntentos        number := 0;
    nuCantidad        number := 0;

    cursor cuOTRP(inuPackagesId mo_packages.package_id%type) is
      select or_order.order_id, or_order.legalization_date
        from or_order, or_order_activity
       where or_order_activity.package_id = inuPackagesId
         and or_order_activity.task_type_id =
             dald_parameter.fnuGetNumeric_Value('TIPO_TRABAJO_RP')
         and or_order_activity.order_id = or_order.order_id;

    sbAditionalData varchar2(2000);

    cursor cuActivities(inuPackagesId mo_packages.package_id%type) is
      select count(*)
        from or_order, or_order_activity
       where or_order.order_id = or_order_activity.order_id
         and or_order.order_status_id in (0, 5, 8)
         and package_id = inuPackagesId
         and activity_id in (4295655, 4000065, 4295030, 100002320, 4000064,
              4294588, 100002319);
    nuCountActivities number := 0;

    sbCOMMENT_TYPE_ID ge_boInstanceControl.stysbValue := '3';
    sbORDER_COMMENT   ge_boInstanceControl.stysbValue := 'ERARP';
    rcRequDataValue   daor_requ_data_value.styOR_requ_data_value;
    inuActionId       Ge_Action_Module.Action_Id%type := 104;
    nuPackageTypeId   ps_package_type.package_type_id%type;

    ---RNP1621
    ---CURSOR PARA ESTABLECER QUE EL TIPO DE TRABJO, ACTIVIDAD Y TRAMITE DE LA ORDEN
    --A LEGALIZAR ES VALIDA PARA GENERAR CERTIFICACION.
    CURSOR CULDC_TIPOTRAB_CERTIFICA(NUtask_type_id OR_TASK_TYPE.TASK_TYPE_ID%TYPE, NUitems_id GE_ITEMS.ITEMS_ID%TYPE, NUpackage_type_id PS_PACKAGE_TYPE.PACKAGE_TYPE_ID%TYPE) IS
      SELECT *
        FROM LDC_TIPOTRAB_CERTIFICA LTC
       WHERE LTC.TASK_TYPE_ID = NUtask_type_id
         AND LTC.ITEMS_ID = NUitems_id
         AND LTC.PACKAGE_TYPE_ID = NUpackage_type_id
         AND LTC.CERTIFICA = 'S';

    TEMPCULDC_TIPOTRAB_CERTIFICA CULDC_TIPOTRAB_CERTIFICA%ROWTYPE;
    NUACTIVITY_ID                OR_ORDER_ACTIVITY.ACTIVITY_ID%TYPE;
    -----
    nuOt or_order.order_id%type;

    -- Cursor utilitario para validar si un valor (sbValue) se encuentra en un conjunto de datos (sbDataSet)
    CURSOR cuValidateData(sbValue VARCHAR2, sbDataSet VARCHAR2) IS
      select count(1)
        from dual
       where sbValue IN
             (SELECT column_value
                FROM TABLE(ldc_boutilities.SPLITstrings(sbDataSet, ',')));

  begin

    ut_trace.trace('Inicio LDC_BCPeriodicReview.prGenerateCertificate', 10);
    ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prGenerateCertificate  => nuOrderId => ' ||
                   nuOrderId,
                   10);
    --Obtener el producto asociado a la orden
    nuProductId := to_number(ldc_boutilities.fsbgetvalorcampotabla('OR_ORDER_ACTIVITY',
                                                                   'order_id',
                                                                   'PRODUCT_ID',
                                                                   nuOrderId));
    ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prGenerateCertificate  => nuProductId => ' ||
                   nuProductId,
                   10);
    --Obtener direccion
    nuAdressId := dapr_product.fnugetaddress_id(nuProductId);
    ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prGenerateCertificate  => nuAdressId => ' ||
                   nuAdressId,
                   10);
    --Obtener la localidad de la direccion
    nuGeograpLoca := daab_address.fnugetgeograp_location_id(nuAdressId,
                                                            NULL);
    ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prGenerateCertificate  => nuGeograpLoca => ' ||
                   nuGeograpLoca,
                   10);
    --La localidad del producto esta activo y pertenece a ASE
    nuASE := ldci_pkrevisionperiodicaweb.fnuGetLocalidadesASE(nuGeograpLoca);
    ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prGenerateCertificate  => nuASE => ' ||
                   nuASE,
                   10);
    --Obtener el identificador del registro en or_order activity
    nuOrderActivityId := ldc_bcfinanceot.fnuGetActivityId(nuOrderId);
    ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prGenerateCertificate  => nuOrderActivityId => ' ||
                   nuOrderActivityId,
                   10);
    nuCategory := dapr_product.Fnugetcategory_Id(nuProductId);
    ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prGenerateCertificate  => nuCategory => ' ||
                   nuCategory,
                   10);
    --Obtener respuesta del usuario
    sbAditionalData := ge_boInstanceControl.fsbGetFieldValue('GE_CAUSAL',
                                                             'ALLOW_UPDATE');
    ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prGenerateCertificate  => sbAditionalData => ' ||
                   sbAditionalData,
                   10);
    --Obtener solicitud asociada a la ot en ejecucion
    nuPackagesId := daor_order_activity.fnugetpackage_id(nuOrderActivityId);
    ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prGenerateCertificate  => nuPackagesId => ' ||
                   nuPackagesId,
                   10);

    -- Aranda 6500: Se comenta linea y se cambia el metodo con que seobtiene el Tipo de trabajo
    --nuTaskTypeId := daor_order.fnugetreal_task_type_id(nuOrderId);
    nuTaskTypeId := daor_order.fnugettask_type_id(nuOrderId);
    ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prGenerateCertificate  => nuTaskTypeId => ' ||
                   nuTaskTypeId,
                   10);

    open cuActivities(nuPackagesId);
    fetch cuActivities
      into nuCountActivities;
    close cuActivities;

    --RNP1621
    NUACTIVITY_ID   := DAOR_ORDER_ACTIVITY.FNUGETACTIVITY_ID(nuOrderActivityId);
    nuPackageTypeId := damo_packages.fnugetpackage_type_id(nuPackagesId);
    ut_trace.trace('DATOS DE ENTRADA --> TT[' || nuTaskTypeId ||
                   '] - ACTIVIDAD[' || NUACTIVITY_ID ||
                   '] - TIPO SOLICITUD[' || nuPackageTypeId || ']',
                   10);
    OPEN CULDC_TIPOTRAB_CERTIFICA(nuTaskTypeId,
                                  NUACTIVITY_ID,
                                  nuPackageTypeId);
    FETCH CULDC_TIPOTRAB_CERTIFICA
      INTO TEMPCULDC_TIPOTRAB_CERTIFICA;
    CLOSE CULDC_TIPOTRAB_CERTIFICA;
    ut_trace.trace('CERTIFICA --> ' ||
                   TEMPCULDC_TIPOTRAB_CERTIFICA.CERTIFICA,
                   10);
    ut_trace.trace('EXISTE OT CERITIFICACION --> ' || nuCountActivities,
                   10);
    ---fin RNP1621

    --Validar que no se haya creado antes una ot similar
    if (nuCountActivities = 0) then

      --EL TIPO DE TRANAJO, ACTIVIDAD Y TIPO DE SOLCITUD DEFINDAS EN LA ORDEN
      --GENERAN ORDEN DE CERTIIFACION.
      --Obtener tipo de solicitud
      nuPackageTypeId := damo_packages.fnugetpackage_type_id(nuPackagesId);
      ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prGenerateCertificate  => nuPackageTypeId => ' ||
                     nuPackageTypeId,
                     10);

      --Si el usuario acepta la certificacion o pertenece al mercado relevante ASE
      if nuASE = 1 or sbAditionalData = 'Y' then

        sbAditionalData := 'Y';

        --validacion RNP1621 para confirmar si existen tipo de trabajo
        --inicio validaion existe tipo de trabajo confogurados para generar ot certificacion
        if (TEMPCULDC_TIPOTRAB_CERTIFICA.CERTIFICA = 'S') then
          --inicio validacion certificacion

          --Obtener la categoria del producto
          nuCategory := dapr_product.fnugetcategory_id(nuProductId);
          ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prGenerateCertificate  => nuCategory => ' ||
                         nuCategory,
                         10);

          -- Aranda 5695: Validacion tramites donde se genera ordenes de trabajos para ejecutar
          -- y generar la orden de certificacion
          nuCantidad := 0;
          OPEN cuValidateData(nuPackageTypeId,
                              dald_parameter.fsbGetValue_Chain('SOLIC_MARCAN_CERTIF'));
          FETCH cuValidateData
            INTO nuCantidad;
          CLOSE cuValidateData;

          IF (nuCantidad > 0) THEN
            -- Aranda 5695

            --Validar la categoria para definir la actividad a generar
            --Categoria Residencial
            if nuCategory =
               dald_parameter.fnuGetNumeric_Value('RESIDEN_CATEGORY') then
              nuActivityId := 4000065;
            else
              --Categoria Comercial
              if nuCategory =
                 dald_parameter.fnuGetNumeric_Value('COMMERCIAL_CATEGORY') then
                nuActivityId := 4295030;
                --Categoria Industrial
              else
                -- Ajuste Aranda 139041
                if instr('|' ||
                         dald_parameter.fsbGetValue_Chain('CATEGORIA_INDUSTRIAL') || '|',
                         '|' || to_char(nuCategory) || '|',
                         1) > 0 then
                  nuActivityId := 100002320;
                end if;
              end if;
            end if;
          END IF;
          IF nuPackageTypeId in (100101, 100225) THEN
            --Validar la categoria para definir la actividad a generar
            --Categoria Residencial
            if nuCategory =
               dald_parameter.fnuGetNumeric_Value('RESIDEN_CATEGORY') then
              nuActivityId := 4000064;
            else
              --Categoria Comercial
              if nuCategory =
                 dald_parameter.fnuGetNumeric_Value('COMMERCIAL_CATEGORY') then
                nuActivityId := 4294588;
                --Categoria Industrial
              else
                -- Ajuste Aranda 139041
                if instr('|' ||
                         dald_parameter.fsbGetValue_Chain('CATEGORIA_INDUSTRIAL') || '|',
                         '|' || to_char(nuCategory) || '|',
                         1) > 0 then
                  nuActivityId := 100002319; ---La nueva que creara
                end if;
              end if;
            end if;
          END IF;

          --Crear orden de certificacion asociada al flujo
          ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prGenerateCertificate  => nuActivityId => ' ||
                         nuActivityId,
                         10);
          --Obtener el identificador de la instancia del registro en or_order_activity
          nuInstanceId := daor_order_activity.fnugetinstance_id(nuOrderActivityId);
          ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prGenerateCertificate  => nuInstanceId => ' ||
                         nuInstanceId,
                         10);
          --Crear orden de Certificacion
          Or_BoCreatActivitFromWF.CreateActivityByInstanceId(nuInstanceId,
                                                             nuActivityId,
                                                             isbComment,
                                                             TRUE);
          ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prGenerateCertificate  => SE CREO ORDEN DE CERTIFICACION',
                         10);

          ---fin validacion if 1621
        end if;
        ---fin validacion if 1621

        --RNP1621 se adiciono la validacion del tipo de trabajo certificado
      elsif (TEMPCULDC_TIPOTRAB_CERTIFICA.CERTIFICA = 'S') then

        --Crear orden de VISITA VALIDACION DE CERTIFICACION DE TRABAJOS asociada al flujo
        nuActivityId := 4295655;
        ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prGenerateCertificate  => nuActivityId => ' ||
                       nuActivityId,
                       10);
        --Obtener el identificador de la instancia del registro en or_order_activity
        nuInstanceId := daor_order_activity.fnugetinstance_id(nuOrderActivityId);
        ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prGenerateCertificate  => nuInstanceId => ' ||
                       nuInstanceId,
                       10);
        --Crear orden de Certificacion
        Or_BoCreatActivitFromWF.CreateActivityByInstanceId(nuInstanceId,
                                                           nuActivityId,
                                                           isbComment,
                                                           TRUE);
        ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prGenerateCertificate  => SE CREO ORDEN DE VISITA VALIDACION DE CERTIFICACION DE TRABAJOS ',
                       10);

        --Marcar el producto o actualizar la marca para que el reporte proceso OTREV no lo tenga en cuenta
        nuPackagesId := daor_order_activity.fnugetpackage_id(nuOrderActivityId);
        ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prGenerateCertificate  => nuPackagesId => ' ||
                       nuPackagesId,
                       10);
        --Obtener OT de revision del tramite
        /* open cuOTRP(nuPackagesId);
        fetch cuOTRP into nuOrderIdRP,dtLegalizeRP;
        close cuOTRP;*/
        nuOt := LDCI_PKREVISIONPERIODICAWEB.fnuGetOtUltimaRP(nuProductId);
        if nuOt is null then
          dtLegalizeRP := trunc(sysdate);
        else
          dtLegalizeRP := daor_order.fdtgetlegalization_date(nuOt);
        end if;
        ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prGenerateCertificate  => nuOrderIdRP => ' ||
                       nuOrderIdRP,
                       10);
        ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prGenerateCertificate  => dtLegalizeRP => ' ||
                       dtLegalizeRP,
                       10);
        --Validar la existencia de la marcar del producto
        if daldc_marca_producto.fblExist(nuProductId) then
          ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prGenerateCertificate  => ACTUALIZA MARCA',
                         10);
          nuIntentos := daldc_marca_producto.fnuGetINTENTOS(nuProductId);
          nuIntentos := nuIntentos + 1;
          daldc_marca_producto.updFECHA_ULTIMA_ACTU(nuProductId,
                                                    dtLegalizeRP);
          daldc_marca_producto.updINTENTOS(nuProductId, nuIntentos);
          IF nuPackageTypeId not in (100014, 100153) THEN
            daldc_marca_producto.updORDER_ID(nuProductId, nuOrderId);
          end if;
          daldc_marca_producto.updREGISTER_POR_DEFECTO(nuProductId, 'Y');
          daldc_marca_producto.updMEDIO_RECEPCION(nuProductId, 'I');
          daldc_marca_producto.updSUSPENSION_TYPE_ID(nuProductId, 103);
        else
          ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prGenerateCertificate  => INSERTA MARCA',
                         10);
          insert into ldc_marca_producto
            (id_producto,
             order_id,
             certificado,
             fecha_ultima_actu,
             intentos,
             medio_recepcion,
             register_por_defecto,
             suspension_type_id)
          values
            (nuProductId, nuOrderId, null, dtLegalizeRP, 1, 'I', 'Y', 103);
        end if;

      end if;
    END IF;
    --Actualizar valor del dato adicional en la orden
    --Llenamos los datos de la llave primaria
    rcRequDataValue.NAME_1           := 'CLIENTE_ACEPTA_CERTIFICACION';
    rcRequDataValue.VALUE_1          := sbAditionalData;
    rcRequDataValue.action_id        := inuActionId;
    rcRequDataValue.attribute_set_id := 11731;
    rcRequDataValue.order_id         := nuOrderId;
    rcRequDataValue.task_type_id     := nuTaskTypeId;
    rcRequDataValue.READ_DATE        := sysdate;

    --actualizamos el registro
    daor_requ_data_value.insRecord(rcRequDataValue);

    /* update OR_REQU_DATA_VALUE
    set VALUE_1  = sbAditionalData
       WHERE OR_REQU_DATA_VALUE.ATTRIBUTE_SET_ID = 11731
           AND OR_REQU_DATA_VALUE.ORDER_ID = nuOrderId;*/
    --Cambiar estado de la orden

    OR_BOEjecutarOrden.EjecutarOrden(nuOrderId,
                                     ut_convert.fnuChartoNumber(sbCOMMENT_TYPE_ID), --inuCommentTypeId.
                                     sbORDER_COMMENT);
    ut_trace.trace('Fin LDC_BCPeriodicReview.prGenerateCertificate', 10);
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise;

    when OTHERS then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  end prGenerateCertificate;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : prRegisterRequest100248
  Descripcion    : Procedimiento para registrar solicitud 100248 por xml
  Autor          :
  Fecha          : 23/05/2014

  Parametros              Descripcion
  ============         ===================

    Fecha               Autor               Modificacion
    =========           =========           ====================
    24/01/2024          jpinedc             OSF-2016: Se reemplaza el codigo por NULL  
  ******************************************************************/

    procedure prRegisterRequest100248(inuProduct_id pr_product.product_id%type) is
    BEGIN
        NULL;
    end prRegisterRequest100248;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : FCRGETREPAIRORDERS
  Descripcion    : Procedimiento para obtener las ordenes de reparacion asociadas a una solicitud
                   de revision periodica dada.
  Autor          :
  Fecha          : 29/05/2014

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  function FCRGETREPAIRORDERS return pkConstante.tyRefCursor IS

    cnuNULL_ATTRIBUTE constant number := 2126;

    sbPACKAGE_ID   ge_boInstanceControl.stysbValue;
    sbALLOW_UPDATE ge_boInstanceControl.stysbValue;

    rfCursor    pkConstante.tyRefCursor;
    nuPackageId mo_packages.package_id%type;

  BEGIN
    ut_trace.trace('Inicio LDC_BCPeriodicReview.FCRGETREPAIRORDERS', 10);
    sbPACKAGE_ID   := ge_boInstanceControl.fsbGetFieldValue('GE_TECH_SERVICE_DET',
                                                            'PACKAGE_ID');
    sbALLOW_UPDATE := ge_boInstanceControl.fsbGetFieldValue('GE_CAUSAL',
                                                            'ALLOW_UPDATE');

    ------------------------------------------------
    -- Required Attributes
    ------------------------------------------------

    if (sbPACKAGE_ID is null) then
      Errors.SetError(cnuNULL_ATTRIBUTE, 'Identificador de Solicitud ');
      raise ex.CONTROLLED_ERROR;
    end if;

    if (sbALLOW_UPDATE is null) then
      Errors.SetError(cnuNULL_ATTRIBUTE, 'Actualizable');
      raise ex.CONTROLLED_ERROR;
    end if;

    ------------------------------------------------
    -- User code
    ------------------------------------------------
    nuPackageId := to_number(sbPACKAGE_ID);
    OPEN rfCursor FOR
      select distinct or_order.order_id ID_ORDEN,
                      order_status_id || '' - '' ||
                      daor_order_status.fsbgetdescription(order_status_id) ESTADO,
                      or_order.task_type_id || '' - '' ||
                      daor_task_type.fsbgetdescription(or_order.task_type_id) TIPO_DE_TRABAJO,
                      CREATED_DATE FECHA_REGISTRO,
                      ASSIGNED_DATE FECHA_ASIGNACION
        from or_order, or_order_activity
       where or_order.order_id = or_order_activity.order_id
         and order_status_id =
             dald_parameter.fnuGetNumeric_Value('COD_ESTADO_ASIGNADA_OT')
            --and ','||open.dald_parameter.fsbGetValue_Chain('ACTIVIDADES_REPARACION_RP')||',' like '%,'||to_char(activity_id)||',%'
         and package_id = nuPackageId;

    ut_trace.trace('Fin LDC_BCPeriodicReview.FCRGETREPAIRORDERS', 10);
    return rfCursor;
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise;

    when OTHERS then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END FCRGETREPAIRORDERS;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : prValidateCertificate
  Descripcion    : Procedimiento para validar la existencia de ordenes de certificacion
                   para la legalizacion de trabajos certificables (Objeto de legalizacion para Servicios Asociados).

  Autor          : Sayra Ocor?
  Fecha          : 10/06/2014

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ??/06/2014    Emiro Leiva          Se modifican cursores
  19/10/2014    Jorge Valiente       RNP1621:Crear cursor para validar si el tipo de trabajo de la orden
                                             esta configurar para generar orden de certificacion
  ******************************************************************/

  procedure prValidateCertificate is
    nuOrderId                or_order.order_id%type;
    nuTaskTypeId             or_task_type.task_type_id%type;
    nuOrderActivityId        or_order_activity.order_activity_id%type;
    nuPackagesId             mo_packages.package_id%type;
    nuPackageTypeId          ps_package_type.package_type_id%type;
    nuCountCertificates      number := 0;
    nuCountCertificatesSales number := 0;
    nuCausalId               ge_causal.causal_id%type;
    nuCausalClassId          ge_class_causal.class_causal_id%type;
    --Cursor para validar la existencia de certificaciones
    /*         cursor cuCertificates (
         inuPackagesId         mo_packages.package_id%type
    )is
    select  causal_id --count(*)
       from or_order_activity, or_order
           where package_id = inuPackagesId
          and or_order.task_type_id in (dald_parameter.fnuGetNumeric_Value('COD_TASK_TYPE_INSP_CERT_TRAB_A'),
               dald_parameter.fnuGetNumeric_Value('COD_TASK_TYPE_INSP_CERT_TRA_RP'))
          and order_status_id = 8
          and or_order.order_id = or_order_activity.order_id; */
    cursor cuCertificates(inuPackagesId mo_packages.package_id%type) is

      select a.causal_id
        from or_order a,
             (select distinct order_id
                from or_order_activity
               where package_id = inuPackagesId
                 and task_type_id in
                     (dald_parameter.fnuGetNumeric_Value('COD_TASK_TYPE_INSP_CERT_TRAB_A'),
                      dald_parameter.fnuGetNumeric_Value('COD_TASK_TYPE_INSP_CERT_TRA_RP'))) b
       where a.order_id = b.order_id
         and order_status_id in (0, 5, 8)
       order by a.created_date desc;

    --Cursor para validar la existencia de certificaciones
    /*          cursor cuSalesCertificates (
       inuPackagesId         mo_packages.package_id%type
    )is
    select causal_id
       from or_order_activity, or_order
          where package_id = inuPackagesId
          and or_order.task_type_id = 10446
          and order_status_id = 8
          and or_order.order_id = or_order_activity.order_id; */
    cursor cuSalesCertificates(inuPackagesId mo_packages.package_id%type) is

      select count(*)
        from or_order a,
             (select distinct order_id
                from or_order_activity
               where package_id = inuPackagesId
                 and task_type_id = 10446) b
       where a.order_id = b.order_id
         and order_status_id = 8;

    ---RNP1621
    ---CURSOR PARA ESTABLECER QUE EL TIPO DE TRABJO, ACTIVIDAD Y TRAMITE DE LA ORDEN
    --A LEGALIZAR ES VALIDA PARA GENERAR CERTIFICACION.
    CURSOR CULDC_TIPOTRAB_CERTIFICA(NUtask_type_id OR_TASK_TYPE.TASK_TYPE_ID%TYPE, NUitems_id GE_ITEMS.ITEMS_ID%TYPE, NUpackage_type_id PS_PACKAGE_TYPE.PACKAGE_TYPE_ID%TYPE) IS
      SELECT *
        FROM LDC_TIPOTRAB_CERTIFICA LTC
       WHERE LTC.TASK_TYPE_ID = NUtask_type_id
         AND LTC.ITEMS_ID = NUitems_id
         AND LTC.PACKAGE_TYPE_ID = NUpackage_type_id
         AND LTC.CERTIFICA = 'S';

    TEMPCULDC_TIPOTRAB_CERTIFICA CULDC_TIPOTRAB_CERTIFICA%ROWTYPE;
    NUACTIVITY_ID                OR_ORDER_ACTIVITY.ACTIVITY_ID%TYPE;
    -----FIN 1621

  begin
    ut_trace.trace('Inicio LDC_BCPeriodicReview.prValidateCertificate', 10);
    --Obtener orden de la instancia
    nuOrderId := or_bolegalizeorder.fnuGetCurrentOrder;
    ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prValidateCertificate  => nuOrderId => ' ||
                   nuOrderId,
                   10);
    --Obtener el tipo de trabajo de la ot que esta en la instancia
    nuTaskTypeId := daor_order.fnugettask_type_id(nuOrderId);
    ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prValidateCertificate => nuTaskTypeId => ' ||
                   nuTaskTypeId,
                   10);
    nuOrderActivityId := ldc_bcfinanceot.fnuGetActivityId(nuOrderId);
    ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prValidateCertificate => nuOrderActivityId => ' ||
                   nuOrderActivityId,
                   10);
    nuPackagesId := daor_order_activity.fnugetpackage_id(nuOrderActivityId);
    ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prValidateCertificate => nuPackagesId => ' ||
                   nuPackagesId,
                   10);
    nuPackageTypeId := damo_packages.fnugetpackage_type_id(nuPackagesId);
    ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prValidateCertificate => nuPackageTypeId => ' ||
                   nuPackageTypeId,
                   10);
    --Validar tipo de solicitud

    --RNP1621
    NUACTIVITY_ID := DAOR_ORDER_ACTIVITY.FNUGETACTIVITY_ID(nuOrderActivityId);
    ut_trace.trace('DATOS DE ENTRADA --> TT[' || nuTaskTypeId ||
                   '] - ACTIVIDAD[' || NUACTIVITY_ID ||
                   '] - TIPO SOLICITUD[' || nuPackageTypeId || ']',
                   10);
    OPEN CULDC_TIPOTRAB_CERTIFICA(nuTaskTypeId,
                                  NUACTIVITY_ID,
                                  nuPackageTypeId);
    FETCH CULDC_TIPOTRAB_CERTIFICA
      INTO TEMPCULDC_TIPOTRAB_CERTIFICA;
    CLOSE CULDC_TIPOTRAB_CERTIFICA;
    ut_trace.trace('CERTIFICA --> ' ||
                   TEMPCULDC_TIPOTRAB_CERTIFICA.CERTIFICA,
                   10);
    ---fin RNP1621

    if instr(',' || dald_parameter.fsbGetValue_Chain('PKG_TYPE_ERARP') || ',',
             ',' || to_char(nuPackageTypeId) || ',') > 0 then

      --Validar si tiene ordenes de Validaci?n de Ceritificaci?n
      nuCountCertificates := 1;
      open cuCertificates(nuPackagesId);
      fetch cuCertificates
        into nuCausalId;
      if cuCertificates%notfound then
        nuCountCertificates := 0;
      end if;
      close cuCertificates;
      ut_trace.trace('Inicio LDC_BCPeriodicReview.prValidateCertificate Cantidad de Ordenes de Certificaci?n nuCountCertificates => ' ||
                     nuCountCertificates,
                     10);
      if nuCountCertificates > 0 then
        if nuCausalId is not null then
          nuCausalClassId := dage_causal.fnugetclass_causal_id(nuCausalId);
          if nuCausalClassId = 1 then
            ldc_boordenes.procomparacantcertrepara;
          end if;
        else

          --VALIDACION 1621
          IF NVL(TEMPCULDC_TIPOTRAB_CERTIFICA.CERTIFICA, 'N') = 'S' THEN
            --VALIDACION 1621

            ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                             'La solicitud [' ||
                                             nuPackagesId ||
                                             '] no tiene orden  de certificaci?n en estado 8 - Cerrada');
            raise ex.CONTROLLED_ERROR;

            --FIN VALIDACION 1621
          END If;
          --FIN VALIDACION 1621
        end if;
      else
        open cuSalesCertificates(nuPackagesId);
        fetch cuSalesCertificates
          into nuCountCertificatesSales;
        close cuSalesCertificates;
        ut_trace.trace('Inicio LDC_BCPeriodicReview.prValidateCertificate Cantidad de Ordenes de COMERCIALES Certificaci?n nuCountCertificatesSales => ' ||
                       nuCountCertificatesSales,
                       10);
        if nuCountCertificatesSales = 0 then

          --VALIDACION 1621
          IF NVL(TEMPCULDC_TIPOTRAB_CERTIFICA.CERTIFICA, 'N') = 'S' THEN
            --VALIDACION 1621
            ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                             'La solicitud [' ||
                                             nuPackagesId ||
                                             '] no tiene orden  de ' ||
                                             daor_task_type.fsbgetdescription(10446) ||
                                             ' en estado 8 - Cerrada');
            raise ex.CONTROLLED_ERROR;
            --FIN VALIDACION 1621
          END If;
          --FIN VALIDACION 1621

        end if;
      end if;
    else
      ldc_boordenes.procomparacantcertrepara;
    end if;
    ut_trace.trace('Fin LDC_BCPeriodicReview.prValidateCertificate', 10);
  exception
    when ex.CONTROLLED_ERROR then
      raise;

    when OTHERS then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;

  end prValidateCertificate;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : prGenerateRequest100248
  Descripcion    : Procedimiento para validar la existencia de defectos reportados por OIA
                    y registrar solicitudes del tipo 100248.

  Autor          : Sayra Ocoro - HT
  Fecha          : 11/06/2014

  Parametros              Descripcion
  ============         ===================

    Fecha               Autor             Modificacion
    =========           =========         ====================
    24/01/2024          jpinedc           OSF-2016: Se reemplaza el codigo por NULL   
  ******************************************************************/

    procedure prGenerateRequest100248 is
    begin
        NULL;
    end prGenerateRequest100248;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : fnuGetFromPeriodicReview
  Descripcion    : Funcion que retorna el identificador de la orden cuando NO esta asociada a una
                   solicitud de Revision Periodica.

  Autor          : Sayra Ocoro - HT
  Fecha          : 12/06/2014

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/

  function fnuGetFromPeriodicReview(inuOrderId or_order.order_id%type)
    return number is

    nuOrderActivity or_order_activity.order_activity_id%type;
    nuPackageId     mo_packages.package_id%type;
    nuPackageTypeId ps_package_type.package_type_id%type;

    cursor cuTrabCert is
      select count(*)
        from LDC_TRAB_CERT, or_order
       where order_id = inuOrderId
         and LDC_TRAB_CERT.ID_TRABCERT = or_order.task_type_id;
    nuCount number := 0;
  begin
    ut_trace.trace('Inicio LDC_BCPeriodicReview.fnuGetFromPeriodicReview',
                   10);
    --Obtener identificador de or_order_activity
    nuOrderActivity := ldc_bcfinanceot.fnuGetActivityId(inuOrderId);
    --Obtener Solicitud
    nuPackageId := daor_order_activity.fnugetpackage_id(nuOrderActivity,
                                                        null);
    --Validar si esta asociado a una solicitud
    if nuPackageId is not null then
      --Obtener tipo de solicitud
      nuPackageTypeId := damo_packages.fnugetpackage_type_id(nuPackageId,
                                                             null);
      --Validar tipo de solicitud
      if instr(',' || dald_parameter.fsbGetValue_Chain('PKG_TYPE_ERARP') || ',',
               ',' || to_char(nuPackageTypeId) || ',') > 0 then
        open cuTrabCert;
        fetch cuTrabCert
          into nuCount;
        close cuTrabCert;
        if nuCount > 0 then
          return - 1;
        end if;
      end if;
    end if;
    ut_trace.trace('Fin LDC_BCPeriodicReview.fnuGetFromPeriodicReview', 10);
    return inuOrderId;
  end fnuGetFromPeriodicReview;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : fnuGetExist100101
  Descripcion    : Funcion que retorna el identificador del producto cuando NO tiene una solicitud de
                   Servicios de Ingenieria con trabajos certificables en proceso

  Autor          : Sayra Ocoro - HT
  Fecha          : 13/06/2014

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/

  function fnuGetExist100101(inuProductId pr_product.product_id%type)
    return number is

    cursor cuExist100101 is
      select count(*)
        from ldc_trab_cert, or_order_activity, or_order, mo_packages
       where or_order_activity.PRODUCT_ID = inuProductId
         and id_trabcert = or_order_activity.task_type_id
         and or_order.order_id = or_order_activity.order_id
         and order_status_id in (0, 5, 7)
         and mo_packages.package_id = or_order_activity.package_id
         and mo_packages.package_type_id = 100101;

    nuCount number := 0;

  begin
    open cuExist100101;
    fetch cuExist100101
      into nuCount;
    close cuExist100101;
    if nuCount > 0 then
      return - 1;
    else
      return inuProductId;
    end if;

  end fnuGetExist100101;
  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : prValidate10445
  Descripcion    : Procedimiento para validar el tipo de solicitud asociado a la
                    orden y la respuesta del usuario a la orden con tt = 10445
  Autor          :
  Fecha          : 16/06/2014

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/

  procedure prValidate10445 is
    nuOrderId           or_order.order_id%type;
    nuOrderActivity     or_order_activity.order_activity_id%type;
    nuPackageId         mo_packages.package_id%type;
    nuPackageTypeId     ps_package_type.package_type_id%type;
    nuCausalId          ge_causal.causal_id%type;
    nuCausalAceptaRep   ge_causal.causal_id%type := 3295;
    nuCausalNOAceptaRep ge_causal.causal_id%type := 3296;
    dtLegalizeRP        date;
    nuProductId         pr_product.product_id%type;
    nuIntentos          number;
    nuOt                or_order.order_id%type;
  begin
    ut_trace.trace('Inicio LDC_BCPeriodicReview.prValidate10445', 10);
    nuOrderId := or_bolegalizeorder.fnuGetCurrentOrder;
    ut_trace.trace('Ejecucion  LDC_BCPeriodicReview.prValidate10445 nuOrderId => ' ||
                   nuOrderId,
                   10);
    --Obtener identificador de or_order_activity
    nuOrderActivity := ldc_bcfinanceot.fnuGetActivityId(nuOrderId);
    ut_trace.trace('Ejecucion  LDC_BCPeriodicReview.prValidate10445 nuOrderActivity => ' ||
                   nuOrderActivity,
                   10);
    --Obtener Solicitud
    nuPackageId := daor_order_activity.fnugetpackage_id(nuOrderActivity,
                                                        null);
    ut_trace.trace('Ejecucion  LDC_BCPeriodicReview.prValidate10445 nuPackageId => ' ||
                   nuPackageId,
                   10);
    --Validar si esta asociado a una solicitud
    if nuPackageId is not null then
      --Obtener causal
      nuCausalId := daor_order.fnugetcausal_id(nuOrderId);
      ut_trace.trace('Ejecucion  LDC_BCPeriodicReview.prValidate10445 nuCausalId => ' ||
                     nuCausalId,
                     10);
      --Obtener tipo de solicitud
      nuPackageTypeId := damo_packages.fnugetpackage_type_id(nuPackageId,
                                                             null);
      if nuPackageTypeId = 100248 and nuCausalId = nuCausalAceptaRep then
        --Registrar solicitud de Venta de Servicios de Ingenieria
        ldc_crea_tramite_ser_ing();
      end if;
      --Validar respuesta para marcar
      if nuCausalId = nuCausalNOAceptaRep then
        nuProductId := daor_order_activity.fnugetproduct_id(nuOrderActivity);
        nuOt        := LDCI_PKREVISIONPERIODICAWEB.fnuGetOtUltimaRP(nuProductId);
        if nuOt is null then
          dtLegalizeRP := trunc(sysdate);
        else
          dtLegalizeRP := daor_order.fdtgetlegalization_date(nuOt);
        end if;
        --Validar la existencia de la marcar del producto
        if daldc_marca_producto.fblExist(nuProductId) then
          ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prValidate10445  => ACTUALIZA MARCA',
                         10);
          nuIntentos := daldc_marca_producto.fnuGetINTENTOS(nuProductId);
          nuIntentos := nuIntentos + 1;
          daldc_marca_producto.updFECHA_ULTIMA_ACTU(nuProductId,
                                                    dtLegalizeRP);
          daldc_marca_producto.updINTENTOS(nuProductId, nuIntentos);
          IF nuPackageTypeId not in (100014, 100153) THEN
            daldc_marca_producto.updORDER_ID(nuProductId, nuOrderId);
          end if;
          daldc_marca_producto.updREGISTER_POR_DEFECTO(nuProductId, 'Y');
          daldc_marca_producto.updMEDIO_RECEPCION(nuProductId, 'I');
          daldc_marca_producto.updSUSPENSION_TYPE_ID(nuProductId, 102);
        else
          ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prValidate10445  => INSERTA MARCA',
                         10);
          insert into ldc_marca_producto
            (id_producto,
             order_id,
             certificado,
             fecha_ultima_actu,
             intentos,
             medio_recepcion,
             register_por_defecto,
             suspension_type_id)
          values
            (nuProductId, nuOrderId, null, dtLegalizeRP, 1, 'I', 'Y', 102);
        end if;
      end if;
    end if;
    ut_trace.trace('Fin LDC_BCPeriodicReview.prValidate10445', 10);
  exception
    when ex.CONTROLLED_ERROR then
      raise;

    when OTHERS then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  end prValidate10445;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : prValidateCertificateSales
  Descripcion    : Procedimiento para validar la existencia de ordenes de certificacion
                   para la legalizacion de trabajos certificables generadas en una Solicitud de Venta.

  Autor          : Sayra Ocoro - HT
  Fecha          : 24/06/2014

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  27-06-2014    Sayra Ocoro        Se incluye validacion de existencia de actividad de apoyo
                                   de suspension por no certificacion si el tipo de trabajo de
                                   la orden en legalizacion es Cargo por Conexion
  05-08-2014    Sayra Ocor?        Se modifica cursor cuCertificates para que valide clase de causal de
                                   exito.
  11/08/2015    Ivan Ceron         Se crea validacion para productos que fueron certificados
                                   por independientes. Aranda 8477
	16/08/2016    Sayra Ocor??     CA 200-711: Se parametriza actividad de suspensi?? tipo de suspensi??  ******************************************************************/

  procedure prValidateCertificateSales is
    nuOrderId           or_order.order_id%type;
    nuTaskTypeId        or_task_type.task_type_id%type;
    nuOrderActivityId   or_order_activity.order_activity_id%type;
    nuPackagesId        mo_packages.package_id%type;
    nuPackageTypeId     ps_package_type.package_type_id%type;
    nuCountCertificates number := 0;
    cursor cuCertificates(inuPackagesId mo_packages.package_id%type) is
      select count(*)
        from or_order_activity, or_order, ge_causal
       where package_id = inuPackagesId
         and or_order.task_type_id in
             (dald_parameter.fnuGetNumeric_Value('COD_TASK_TYPE_INSP_CERT_TRAB_A'),
              dald_parameter.fnuGetNumeric_Value('COD_TASK_TYPE_INSP_CERT_TRA_RP'),
              dald_parameter.fnuGetNumeric_Value('COD_INSP_CERT_TASK_TYPE'))
         and order_status_id in (0, 5, 8)
         and or_order.order_id = or_order_activity.order_id
         and or_order.causal_id = ge_causal.causal_id
         and ge_causal.class_causal_id = 1;

    --Cursor para obtener actividades de apoyo
    cursor cuSupportActivity(inuOrderId or_order.order_id%type, inuItemsId in ge_items.items_id%type) is
      select count(*)
        from or_order_activity
       where order_id = inuOrderId
         and or_order_activity.activity_id = inuItemsId;

    nuCount              number := 0;
		--CA 200-711
    inuActivityId        ge_items.items_id%type;-- := 4000070;
		nuSuspensionType     number;
		--CA 200-711

    --obtiene la cantidad de OT CxC y/o Instalacion legalizadas
    cursor cucantotcerradas(nusolicitud mo_packages.package_id%type, nuttinstala or_order.task_type_id%type, nuttcarcon or_order.task_type_id%type, nudireccion or_order_activity.address_id%type) is
      select count(a.order_id)
        from or_order_activity a, or_order b
       where a.order_id = b.order_id
         and a.task_type_id in (nuttinstala, nuttcarcon)
         and b.order_status_id = 8
         and ldc_boutilities.fsbbuscatoken(dald_parameter.fsbgetvalue_chain('CAUSA_CERT_INSTALACION'),
                                           to_char(b.causal_id),
                                           ',') = 'S'
         and a.package_id = nusolicitud
         and a.address_id = nudireccion;

    SBCREAR_ITEM_AUTO ld_parameter.value_chain%type;

    --Obtiene la orden de INTERNA asociada a la solicitud de venta
    cursor cuOrdenInst(inuPackageid mo_packages.package_id%type, inuAddressId or_order_activity.address_id%type) is
      select a.order_id, a.task_type_id, a.address_id
        from or_order_activity a, or_order b
       where a.order_id = b.order_id
         and a.task_type_id in (12149, 12151)
         and b.order_status_id <> 12
         and a.package_id = inuPackageid
         and a.address_id = inuAddressId;

    --Obtiene la orden de CARGO POR CONEXION asociada a la solicitud de venta
    cursor cuOrdenCargo(inuPackageid mo_packages.package_id%type, inuAddressId or_order_activity.address_id%type) is
      select a.order_id, a.task_type_id, a.address_id
        from or_order_activity a, or_order b
       where a.order_id = b.order_id
         and a.task_type_id in (12152, 12150)
         and b.order_status_id <> 12
         and a.package_id = inuPackageid
         and a.address_id = inuAddressId;
    --obtiene la cantidad de OT CxC y/o Instalacion asociadas a la solicitud
    cursor cucantotsol(nusolicitud mo_packages.package_id%type, nudireccion or_order_activity.address_id%type) is
      select count(*)
        from or_order_activity a, or_order b
       where a.order_id = b.order_id
         and a.task_type_id in (12149, 12151, 12152, 12150)
         and b.order_status_id <> 12 --anulada
         and a.package_id = nusolicitud
         and a.address_id = nudireccion;

    nuAddressId     or_order_activity.address_id%type;
    nuTaskTypeOther or_task_type.task_type_id%type;
    nuOrderIdOther  or_order.order_id%type;
    nuotCerradas    number := 0;
    nucantot        number := 0;
    nuProductId     pr_product.product_id%type;
    dtLegalize      date;
    nuIntentos      number := 0;
    nuOt            or_order.order_id%type;

    nuExisteSolictud       number;
  begin
    ut_trace.trace('Inicio LDC_BCPeriodicReview.prValidateCertificateSales',
                   10);
		--Inicio CA 200-711
		inuActivityId := dald_parameter.fnuGetNumeric_Value('ACTSUSPNOCERT',null);
		ut_trace.trace('Ejecuci??DC_BCPeriodicReview.prValidateCertificateSales inuActivityId => '||inuActivityId,10);
		if inuActivityId is null then
			
		          ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                               'ERROR: No se ha definido valor num?co para la actividad de apoyo de suspensi??n el par?tro ACTSUSPNOCERT');
              raise ex.CONTROLLED_ERROR;
		end if;
		nuSuspensionType := dald_parameter.fnuGetNumeric_Value('TIPOSUSPNOCERTREDNUEVA',null);
		if nuSuspensionType is null then
			
		          ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                               'ERROR: No se ha definido valor num?co para el tipo de suspensi??n el par?tro TIPOSUSPNOCERTREDNUEVA');
              raise ex.CONTROLLED_ERROR;
		end if;	
	  --Fin CA 200-711
		
    --Obtener orden de la instancia
    nuOrderId := or_bolegalizeorder.fnuGetCurrentOrder;
    ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prValidateCertificateSales  => nuOrderId => ' ||
                   nuOrderId,
                   10);
    --Obtener el tipo de trabajo de la ot que esta en la instancia
    nuTaskTypeId := daor_order.fnugettask_type_id(nuOrderId);
    ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prValidateCertificateSales => nuTaskTypeId => ' ||
                   nuTaskTypeId,
                   10);
    nuOrderActivityId := ldc_bcfinanceot.fnuGetActivityId(nuOrderId);
    ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prValidateCertificateSales => nuOrderActivityId => ' ||
                   nuOrderActivityId,
                   10);
    nuPackagesId := daor_order_activity.fnugetpackage_id(nuOrderActivityId);
    ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prValidateCertificateSales => nuPackagesId => ' ||
                   nuPackagesId,
                   10);
    nuPackageTypeId := damo_packages.fnugetpackage_type_id(nuPackagesId);
    ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prValidateCertificateSales => nuPackageTypeId => ' ||
                   nuPackageTypeId,
                   10);
    nuAddressId := daor_order_activity.fnugetaddress_id(nuOrderActivityId);

    -- ivandc -> Cambio 8477 -> Se crea cursor para validar si la solicitud
    --                          existe en la tabla LDC_PROD_CERT_INDEP
    begin
        select     count(*)
        into       nuExisteSolictud
        from       open.LDC_PROD_CERT_INDEP
        where      package_id = nuPackagesId;

    exception
       when others then
           nuExisteSolictud := 0;
    end;
    ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prValidateCertificateSales => nuPackageTypeId => ' ||
                   nuExisteSolictud,10);

    --Validar si la solicitud tiene ordenes de certificacion
    open cuCertificates(nuPackagesId);
    fetch cuCertificates
      into nuCountCertificates;
    close cuCertificates;
    if nuCountCertificates = 0 then
      --Validar si es un tipo de trabajo de cargo por conexion
      if instr(',' ||
               dald_parameter.fsbGetValue_Chain('TT_APL_FOR_REP_COT') || ',',
               ',' || to_char(nuTaskTypeId) || ',') > 0 then

        --Validar existencia de actividad de apoyo
        --Consultar actividades de apoyo relacionadas
        OPEN cuSupportActivity(nuOrderId, inuActivityId);
        fetch cuSupportActivity
          into nuCount;
        close cuSupportActivity;
        -- Cambio 8477 -> Se adiciona validacion para verifucar que la solicitud no exista en la tabla de control
        if nuCount = 0 and nuExisteSolictud = 0 then

              ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                               'La solicitud [' || nuPackagesId ||
                                               '] no tiene orden de Certificacion. Debe asociarle a la orden[' ||
                                               nuOrderId ||
                                               '] la Actividad de Apoyo ' ||
                                               dage_items.fsbgetdescription(inuActivityId));
              raise ex.CONTROLLED_ERROR;
        else
          --Marcar el producto
          nuProductId := daor_order_activity.fnugetproduct_id(nuOrderActivityId);

          nuOt := LDCI_PKREVISIONPERIODICAWEB.fnuGetOtUltimaRP(nuProductId);
          if nuOt is null then
            dtLegalize := trunc(sysdate);
          else
            dtLegalize := daor_order.fdtgetlegalization_date(nuOt);
          end if;

          --Validar la existencia de la marcar del producto
          if daldc_marca_producto.fblExist(nuProductId) then
            ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prValidateCertificateSales  => ACTUALIZA MARCA',
                           10);
            nuIntentos := daldc_marca_producto.fnuGetINTENTOS(nuProductId);
            nuIntentos := nuIntentos + 1;
            daldc_marca_producto.updFECHA_ULTIMA_ACTU(nuProductId,
                                                      dtLegalize);
            daldc_marca_producto.updINTENTOS(nuProductId, nuIntentos);
            daldc_marca_producto.updORDER_ID(nuProductId, nuOrderId);
            daldc_marca_producto.updREGISTER_POR_DEFECTO(nuProductId, 'N');
            daldc_marca_producto.updMEDIO_RECEPCION(nuProductId, 'I');
						--Ca 200-711
            daldc_marca_producto.updSUSPENSION_TYPE_ID(nuProductId, nuSuspensionType);
          else
            ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prValidateCertificateSales  => INSERTA MARCA',
                           10);
            insert into ldc_marca_producto
              (id_producto,
               order_id,
               certificado,
               fecha_ultima_actu,
               intentos,
               medio_recepcion,
               register_por_defecto,
               suspension_type_id)
            values
						--Ca 200-711
              (nuProductId, nuOrderId, null, dtLegalize, 1, 'I', 'N', nuSuspensionType);
          end if;

        end if;

        --obtener orden de interna asociada a la solicitud
        open cuOrdenInst(nuPackagesId, nuAddressId);
        fetch cuOrdenInst
          into nuOrderIdOther, nuTaskTypeOther, nuAddressId;
        close cuOrdenInst;
      else
        --Obtener orden de cargo por conexion
        open cuOrdenCargo(nuPackagesId, nuAddressId);
        fetch cuOrdenCargo
          into nuOrderIdOther, nuTaskTypeOther, nuAddressId;
        close cuOrdenCargo;
      end if;

      --Obtener cantidad de ordenes asociadas a la solicitud
      Open cucantotsol(nuPackagesId, nuAddressId);
      fetch cucantotsol
        into nucantot;
      close cucantotsol;

      --Obtener cantidad de ordenes cerradas
      open cucantotcerradas(nuPackagesId,
                            nuTaskTypeOther,
                            nuTaskTypeId,
                            nuAddressId);
      fetch cucantotcerradas
        into nuotCerradas;
      close cucantotcerradas;
      if (nuotcerradas = (nucantot - 1)) then

        SBCREAR_ITEM_AUTO := DALD_PARAMETER.fsbGetValue_Chain('CREAR_ITEM_AUTO',
                                                              NULL);
        IF SBCREAR_ITEM_AUTO IS NULL THEN
          SBCREAR_ITEM_AUTO := 'S';
        END IF;
        if SBCREAR_ITEM_AUTO = 'S' then
          ldc_boordenes.procreaitemspago(nuOrderId);
        end if;
      end if;

    else
       -- Cambio 8477 -> Se adiciona validacion para verifucar que la solicitud no exista en la tabla de control
       if nuExisteSolictud = 0 then
            ldc_boordenes.proComparaCantCertInst;
       else
            ut_trace.trace('LDC_BCPeriodicReview.prValidateCertificateSales => Ingresa a crear items automaticos',10);
            -- Cambio 8477 -> Se crean los items atuomaticos para los productos de la tabla de control
            -- Se valida si el tipo de trabajo es de CXC
            if instr(',' ||
               dald_parameter.fsbGetValue_Chain('TT_APL_FOR_REP_COT') || ',',
               ',' || to_char(nuTaskTypeId) || ',') > 0 then

                --obtener orden de interna asociada a la solicitud
                open cuOrdenInst(nuPackagesId, nuAddressId);
                fetch cuOrdenInst
                into nuOrderIdOther, nuTaskTypeOther, nuAddressId;
                close cuOrdenInst;
            else
                --Obtener orden de cargo por conexion
                open cuOrdenCargo(nuPackagesId, nuAddressId);
                fetch cuOrdenCargo
                  into nuOrderIdOther, nuTaskTypeOther, nuAddressId;
                close cuOrdenCargo;
            end if; -- fin instr

            --Obtener cantidad de ordenes asociadas a la solicitud
            Open cucantotsol(nuPackagesId, nuAddressId);
            fetch cucantotsol
            into nucantot;
            close cucantotsol;

            --Obtener cantidad de ordenes cerradas
            open cucantotcerradas(nuPackagesId,
                                  nuTaskTypeOther,
                                  nuTaskTypeId,
                                  nuAddressId);
            fetch cucantotcerradas
              into nuotCerradas;
            close cucantotcerradas;
            if (nuotcerradas = (nucantot - 1)) then

              SBCREAR_ITEM_AUTO := DALD_PARAMETER.fsbGetValue_Chain('CREAR_ITEM_AUTO',
                                                                      NULL);
              IF SBCREAR_ITEM_AUTO IS NULL THEN
                SBCREAR_ITEM_AUTO := 'S';
              END IF;
              if SBCREAR_ITEM_AUTO = 'S' then
                ldc_boordenes.procreaitemspago(nuOrderId);
              end if;
            end if;
       end if; -- fin if nuExisteSolictud = 0 then
    end if;
    ut_trace.trace('Fin LDC_BCPeriodicReview.prValidateCertificateSales',
                   10);
  exception
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;

    when OTHERS then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;

  end prValidateCertificateSales;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : fnuGetRequestIdbyOrderId
  Descripcion    : Funcion para obtener el identificador de la solicitud de la
                   orden de la instancia. Para usar en regla de inicializacion en la forma ERARP.

  Autor          : Sayra Ocoro - HT
  Fecha          : 26/06/2014

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/

  function fnuGetRequestIdbyOrderId return number is
    nuORDER_ID      or_order.order_id%type;
    nuOrderActivity or_order_activity.order_activity_id%type;
    nuPackageId     mo_packages.package_id%type;
    nuIndex         number;
    sbORDER_ID      varchar2(2000);
    cnuNULL_ATTRIBUTE constant number := 2126;
  begin

    IF (GE_BOInstanceControl.fblAcckeyAttributeStack(ge_boInstanceConstants.csbWORK_INSTANCE,
                                                     Null,
                                                     'OR_ORDER',
                                                     'ORDER_ID',
                                                     nuIndex)) THEN
      GE_BOInstanceControl.getAttributeNewValue(ge_boInstanceConstants.csbWORK_INSTANCE,
                                                Null,
                                                'OR_ORDER',
                                                'ORDER_ID',
                                                sbORDER_ID);
      ut_trace.trace('fnuGetRequestIdbyOrderId - Orden: [' || sbORDER_ID || ']',
                     15);
      nuORDER_ID := ut_convert.fnuChartoNumber(sbORDER_ID);
      --Obtener identificador de or_order_activity
      nuOrderActivity := ldc_bcfinanceot.fnuGetActivityId(nuORDER_ID);
      --Obtener Solicitud
      nuPackageId := daor_order_activity.fnugetpackage_id(nuOrderActivity,
                                                          null);
    ELSE
      Errors.SetError(cnuNULL_ATTRIBUTE, 'Codigo de Orden');
      ut_trace.trace('fnuGetRequestIdbyOrderId - Error en Orden', 15);
      RAISE ex.CONTROLLED_ERROR;
    END IF;
    return nuPackageId;
  exception
    when ex.CONTROLLED_ERROR then
      raise;

  end fnuGetRequestIdbyOrderId;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : prGenerateCertbyCategory
  Descripcion    : Procedimiento para generar orden de certificacion de acuerdo a la categoria
                   a partir de la legalizacion de una orden con tipo 10446 - Visita de Validacion de
                   Certificacion Trabajos con causal 3297

  Autor          : Sayra Ocoro - HT
  Fecha          : 28/06/2014

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  31/07/2015      LDiuza              Aranda 5695: Se parametrizan los tipos de solicitud validados
                                        para la creacion de la orden
  ******************************************************************/

  procedure prGenerateCertbyCategory is
    nuOrderId             or_order.order_id%type;
    nuTaskTypeId          or_task_type.task_type_id%type;
    nuTaskTypeIdReference or_task_type.task_type_id%type := 10446;
    nuOrderActivityId     or_order_activity.order_activity_id%type;
    nuPackagesId          mo_packages.package_id%type;
    nuPackageTypeId       ps_package_type.package_type_id%type;
    nuCausalId            ge_causal.causal_id%type;
    nuCausalIdReference   ge_causal.causal_id%type := 3297;
    nuCategory            categori.catecodi%type;
    nuProductId           pr_product.product_id%type;
    nuInstanceId          or_order_activity.instance_id%Type;
    nuActivityId          ge_items.items_id%type;
    isbComment            varchar2(200) := 'Generada desde el proceso LDC_BCPeriodicReview.prGenerateCertbyCategory';
    dtLegalizeRP          date;
    nuIntentos            number := 0;
    nuOt                  or_order.order_id%type;
    nuCount               NUMBER;

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

  begin
    ut_trace.trace('Inicio LDC_BCPeriodicReview.prGenerateCertbyCategory',
                   10);
    --Obtener orden de la instancia
    nuOrderId := or_bolegalizeorder.fnuGetCurrentOrder;
    ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prGenerateCertbyCategory  => nuOrderId => ' ||
                   nuOrderId,
                   10);
    --Obtener tipo de trabajo
    nuTaskTypeId := daor_order.fnugettask_type_id(nuOrderId);
    ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prGenerateCertbyCategory  => nuTaskTypeId => ' ||
                   nuTaskTypeId,
                   10);
    --Obtener causal
    nuCausalId := daor_order.fnugetcausal_id(nuOrderId);
    ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prGenerateCertbyCategory  => nuCausalId => ' ||
                   nuCausalId,
                   10);
    nuOrderActivityId := ldc_bcfinanceot.fnuGetActivityId(nuOrderId);
    ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prGenerateCertbyCategory  => nuOrderActivityId => ' ||
                   nuOrderActivityId,
                   10);
    --Obtener identificador del producto
    nuProductId := daor_order_activity.fnugetproduct_id(nuOrderActivityId);
    ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prGenerateCertbyCategory  => nuProductId => ' ||
                   nuProductId,
                   10);
    --Validar Causal 3297 y tipo de trabajo 10446
    if nuTaskTypeId = nuTaskTypeIdReference and
       nuCausalId = nuCausalIdReference then
      --Obtener solicitud
      nuPackagesId := daor_order_activity.fnugetpackage_id(nuOrderActivityId);
      ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prGenerateCertbyCategory  => nuPackagesId => ' ||
                     nuPackagesId,
                     10);
      --Obtener tipo de solicitud
      nuPackageTypeId := damo_packages.fnugetpackage_type_id(nuPackagesId);
      ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prGenerateCertbyCategory  => nuPackageTypeId => ' ||
                     nuPackageTypeId,
                     10);
      --Obtener la categoria del producto
      nuCategory := dapr_product.fnugetcategory_id(nuProductId);
      ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prGenerateCertbyCategory  => nuCategory => ' ||
                     nuCategory,
                     10);

      --Validar tipo de solicitud
      -- LDiuza.Aranda5695
      nuCount := 0;
      OPEN cuValidateData(nuPackageTypeId, dald_parameter.fsbGetValue_Chain('COD_SOL_OT_REP', 0));
      FETCH cuValidateData INTO nuCount;
      CLOSE cuValidateData;

      IF (nuCount > 0) THEN
        --Validar la categoria para definir la actividad a generar
        --Categoria Residencial
        if nuCategory =
           dald_parameter.fnuGetNumeric_Value('RESIDEN_CATEGORY') then
          nuActivityId := 4000065;
        else
          --Categoria Comercial
          if nuCategory =
             dald_parameter.fnuGetNumeric_Value('COMMERCIAL_CATEGORY') then
            nuActivityId := 4295030;
            --Categoria Industrial
          else
            if instr('|' ||
                     dald_parameter.fsbGetValue_Chain('CATEGORIA_INDUSTRIAL') || '|',
                     '|' || to_char(nuCategory) || '|',
                     1) > 0 then
              nuActivityId := 100002320;
            end if;
          end if;
        end if;
      END IF;

      nuCount := 0;
      OPEN cuValidateData(nuPackageTypeId, dald_parameter.fsbGetValue_Chain('COD_SOL_SERV_ASSO_REP_TT10446', 0));
      FETCH cuValidateData INTO nuCount;
      CLOSE cuValidateData;

      IF (nuCount > 0) THEN
        --Validar la categoria para definir la actividad a generar
        --Categoria Residencial
        if nuCategory =
           dald_parameter.fnuGetNumeric_Value('RESIDEN_CATEGORY') then
          nuActivityId := 4000064;
        else
          --Categoria Comercial
          if nuCategory =
             dald_parameter.fnuGetNumeric_Value('COMMERCIAL_CATEGORY') then
            nuActivityId := 4294588;
            --Categoria Industrial
          else
            if instr('|' ||
                     dald_parameter.fsbGetValue_Chain('CATEGORIA_INDUSTRIAL') || '|',
                     '|' || to_char(nuCategory) || '|',
                     1) > 0 then
              nuActivityId := 100002319; ---La nueva que creara
            end if;
          end if;
        end if;
      END IF;

      --Crear orden de certificacion asociada al flujo
      ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prGenerateCertbyCategory  => nuActivityId => ' ||
                     nuActivityId,
                     10);
      --Obtener el identificador de la instancia del registro en or_order_activity
      nuInstanceId := daor_order_activity.fnugetinstance_id(nuOrderActivityId);
      ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prGenerateCertbyCategory  => nuInstanceId => ' ||
                     nuInstanceId,
                     10);
      --Crear orden de Certificacion
      Or_BoCreatActivitFromWF.CreateActivityByInstanceId(nuInstanceId,
                                                         nuActivityId,
                                                         isbComment,
                                                         TRUE);
      ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prGenerateCertbyCategory  => SE CREO ORDEN DE CERTIFICACION',
                     10);
    else
      nuOt := LDCI_PKREVISIONPERIODICAWEB.fnuGetOtUltimaRP(nuProductId);
      if nuOt is null then
        dtLegalizeRP := trunc(sysdate);
      else
        dtLegalizeRP := daor_order.fdtgetlegalization_date(nuOt);
      end if;

      --Validar la existencia de la marcar del producto
      if daldc_marca_producto.fblExist(nuProductId) then
        ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prGenerateCertificate  => ACTUALIZA MARCA',
                       10);
        nuIntentos := daldc_marca_producto.fnuGetINTENTOS(nuProductId);
        nuIntentos := nuIntentos + 1;
        daldc_marca_producto.updFECHA_ULTIMA_ACTU(nuProductId,
                                                  dtLegalizeRP);
        daldc_marca_producto.updINTENTOS(nuProductId, nuIntentos);
        IF nuPackageTypeId not in (100014, 100153) THEN
          daldc_marca_producto.updORDER_ID(nuProductId, nuOrderId);
        end if;
        daldc_marca_producto.updREGISTER_POR_DEFECTO(nuProductId, 'Y');
        daldc_marca_producto.updMEDIO_RECEPCION(nuProductId, 'I');
        daldc_marca_producto.updSUSPENSION_TYPE_ID(nuProductId, 103);
      else
        ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prGenerateCertificate  => INSERTA MARCA',
                       10);
        insert into ldc_marca_producto
          (id_producto,
           order_id,
           certificado,
           fecha_ultima_actu,
           intentos,
           medio_recepcion,
           register_por_defecto,
           suspension_type_id)
        values
          (nuProductId, nuOrderId, null, dtLegalizeRP, 1, 'I', 'Y', 103);
      end if;

    end if;
    ut_trace.trace('Fin LDC_BCPeriodicReview.prGenerateCertbyCategory', 10);
  exception
    when others then
      raise;
  end prGenerateCertbyCategory;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : fnuViewCertificate
  Descripcion    : Funci?n que retorna el identificador del producto dado si encuentra que
                    aplica como candidato para visualizar el tr?mite 100270 - LDC - Certificaci?n de Trabajos,
                    en caso contrario retorna -1.

  Autor          : Sayra Ocoro - HT
  Fecha          : 26/07/2014

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  23/11/2014        luzaa             team 4025: validacion por estado de producto y no por estado de corte
  09/02/2015       eromero            Aranda 134559: Se adicionan mas causales en la validacion.
  01/04/2015       oparra             SAO 306850: Se cambian valores quemados en el cursor "cuLastPR" por valores
                                      configurados en parametros (LDPAR). Se consulta la ultima solicutd generada.
  ******************************************************************/

  FUNCTION fnuViewCertificate(inuProductId in pr_product.product_id%type)
    return number IS

    cursor cuLastPR is
      select max(oa.package_id)
        from or_order_activity oa, or_order o, mo_packages mp
       where oa.order_id = o.order_id
         and oa.package_id = mp.package_id
         and oa.product_id = inuProductId
         and o.order_status_id =
             dald_parameter.fnuGetNumeric_Value('COD_ORDER_STATUS') --8
         and mp.motive_status_id =
             dald_parameter.fnuGetNumeric_Value('ID_ESTADO_PKG_ATENDTIDO') -- 14-Solicitud atendida
         and mp.package_type_id in
             (SELECT to_number(column_value)
                FROM TABLE(ldc_boutilities.splitstrings(dald_parameter.fsbGetValue_Chain('LDC_PKG_TYPE_VALIDA_100270',
                                                                                         null),
                                                        ',')))
         and o.task_type_id in
             (SELECT TO_NUMBER(column_value)
                FROM TABLE(ldc_boutilities.splitstrings(dald_parameter.fsbGetValue_Chain('LDC_TT_VALIDA_100270',
                                                                                         null),
                                                        ',')))
         and o.causal_id in
             (SELECT TO_NUMBER(column_value)
                FROM TABLE(ldc_boutilities.splitstrings(dald_parameter.fsbGetValue_Chain('LDC_CAUSAL_VALIDA_100270',
                                                                                         null),
                                                        ',')));

    --<<team 4025
    cursor cuestadoproducto(nuproducto number) is
      select product_status_id
        from pr_product
       where product_id = nuproducto;
    -->>

    nuPackageId  mo_packages.package_id%type;
    dtDateLastPR date;
    nuDays       number;
    nuestacort   servsusc.sesuesco%type;
    nuestaprod   pr_product.product_status_id%type;
    nuIdPKGPR    mo_packages.package_id%type;

  BEGIN

    --Obtener estado de corte del producto
    --<<team 4025
    --nuEstacort := pktblservsusc.fnugetsesuesco(inuProductId);
    --obtiene estado de producto
    open cuestadoproducto(inuProductId);
    fetch cuestadoproducto
      into nuestaprod;
    close cuestadoproducto;
    -->>
    --Obtener Revision Periodica
    nuIdPKGPR := mo_bopackages.fnugetidpackage(inuProductId, 265, 13);
    --Validar que no exista RP en proceso
    if nuIdPKGPR is null then
      nuIdPKGPR := mo_bopackages.fnugetidpackage(inuProductId, 266, 13);
      if nuIdPKGPR is null then
        nuIdPKGPR := mo_bopackages.fnugetidpackage(inuProductId, 100270, 13);
      end if;
    end if;
    --Validar que el estado de corte del producto sea 1 - Conexi?n
    --<<team 4025
    if nuidpkgpr is null and
       nuestaprod =
       dald_parameter.fnugetnumeric_value('ID_PRODUCT_STATUS_ACTIVO', null) then
      -->>
      --Obtener Revisi?n Peri?dica en la que se rechazaron trabajos de reparaci?n
      open cuLastPR;
      fetch cuLastPR
        into nuPackageId;
      close cuLastPR;

      if nuPackageId is not null then
        --Obtener fecha de ultima Revisi?n Peri?dica en la que se rechazaron trabajos de reparaci?n
        dtDateLastPR := damo_packages.fdtgetrequest_date(nuPackageId);
        --Calcular diferencia entre la ultima fecha de RP y la fecha actual
        nuDays := sysdate - dtDateLastPR;
        --Validar vs par?metro de d?as LDC_DAYS_TO_CERTIFICATE
        if nuDays <= dald_parameter.fnuGetNumeric_Value('LDC_DAYS_TO_CERTIFICATE',
                                                        null) then
          return inuProductId;
        end if;
      end if;
    end if;
    return - 1;

  EXCEPTION
    when others then
      raise;

  END fnuViewCertificate;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : fnuViewPeriodicReview
  Descripcion    : Funci?n que retorna el identificador del producto dado si encuentra que NO
                    aplica como candidato para visualizar el tr?mite 100270 - LDC - Certificaci?n de Trabajos,
                    en caso contrario retorna -1.

  Autor          : Sayra Ocoro - HT
  Fecha          : 26/07/2014

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/

  function fnuViewPeriodicReview(inuProductId in pr_product.product_id%type)
    return number is
    cursor cuLastPR is
      select oa.package_id
        FROM OR_ORDER_ACTIVITY OA
       INNER JOIN OR_ORDER O ON OA.ORDER_ID = O.ORDER_ID
       INNER JOIN MO_PACKAGES MP ON OA.PACKAGE_ID = MP.PACKAGE_ID
       WHERE OA.PRODUCT_ID = inuProductId
         and rownum = 1
         AND mp.MOTIVE_STATUS_ID =
             DALD_parameter.fnuGetNumeric_Value('ID_ESTADO_PKG_ATENDTIDO') -- 14-Solicitud atendida
         and mp.package_type_id in
             (DALD_parameter.fnuGetNumeric_Value('ID_PKG_TYPE_RP_MASIVA'),
              DALD_parameter.fnuGetNumeric_Value('ID_PKG_TYPE_RP')) --Tipo de solicitud
         and o.order_status_id =
             DALD_parameter.fnuGetNumeric_Value('COD_ORDER_STATUS') --8
         and o.task_type_id in
             (10445, 12135, 12136, 12138, 12139, 12140, 12142, 12143, 12145,
              12146, 12147, 12148, 12453, 12487, 10011, 10339)
         and o.causal_id in (3357, 3296)
       ORDER BY mp.attention_date DESC;

    nuPackageId  mo_packages.package_id%type;
    dtDateLastPR date;
    nuDays       number;
    nuEstacort   servsusc.sesuesco%type;
    nuIdPKGPR    mo_packages.package_id%type;

  begin
    --Obtener estado de corte del producto
    nuEstacort := pktblservsusc.fnugetsesuesco(inuProductId);
    --Obtener Revision Periodica
    nuIdPKGPR := mo_bopackages.fnugetidpackage(inuProductId, 265, 13);
    --Validar que no exista RP en proceso
    if nuIdPKGPR is null then
      nuIdPKGPR := mo_bopackages.fnugetidpackage(inuProductId, 266, 13);
      if nuIdPKGPR is null then
        nuIdPKGPR := mo_bopackages.fnugetidpackage(inuProductId, 100270, 13);
      end if;
    end if;
    --Validar que el estado de corte del producto sea 1 - Conexi?n
    if nuIdPKGPR is null then
      --Obtener Revisi?n Peri?dica en la que se rechazaron trabajos de reparaci?n
      open cuLastPR;
      fetch cuLastPR
        into nuPackageId;
      close cuLastPR;
      if nuPackageId is not null then
        --Obtener fecha de ultima Revisi?n Peri?dica en la que se rechazaron trabajos de reparaci?n
        dtDateLastPR := damo_packages.fdtgetrequest_date(nuPackageId);
        --Calcular diferencia entre la ultima fecha de RP y la fecha actual
        nuDays := sysdate - dtDateLastPR;
        --Validar vs par?metro de d?as LDC_DAYS_TO_CERTIFICATE
        if nuDays > dald_parameter.fnuGetNumeric_Value('LDC_DAYS_TO_CERTIFICATE',
                                                       null) then
          return inuProductId;
        end if;
      else
        return inuProductId;
      end if;
    end if;
    return - 1;
  exception
    when others then
      raise;
  end fnuViewPeriodicReview;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : fnuGetPackageTypeSup
  Descripcion    : Obtiene el identificador  del tipo de solicitud de la orden que insert? la
                   marca en ldc_marca_producto para que el producto salga a suspensi?n.


  Autor          : Sayra Ocoro - HT
  Fecha          : 31/07/2014

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  31/07/2014       Socoro             1. Creacion
  12/02/2015    oparra.Team 2732      2. Correcion, para que consulte primero el tipo de suspension en
                                         ldc_marca_producto y sino existe busque en pr_prod_suspension.
  ******************************************************************/

  FUNCTION fnuGetPackageTypeSup(inuPackageId in mo_packages.package_id%type)
    return number IS
    nuPackageTypeId    ps_package_type.package_type_id%type;
    nuProductId        pr_product.product_id%type;
    nuProdSuspensionId pr_prod_suspension.prod_suspension_id%type;
    nuSuspensionType   ldc_marca_producto.suspension_type_id%type;
    nuOrderId          or_order.order_id%type;
    nuOrderActivityId  or_order_activity.order_activity_id%type;
    nuPackageIdRef     mo_packages.package_id%type;
    nuPackageTypeRef   ps_package_type.package_type_id%type;

  BEGIN

    ut_trace.trace('Inicio LDC_BCPeriodicReview.fnuGetPackageTypeSup', 10);
    dbms_output.put_line('Inicio LDC_BCPeriodicReview.fnuGetPackageTypeSup');

    nuPackageTypeId := damo_packages.fnugetpackage_type_id(inuPackageId);
    ut_trace.trace('Ejecuci?n LDC_BCPeriodicReview.fnuGetPackageTypeSup nuPackageTypeId => ' ||
                   nuPackageTypeId,
                   10);
    dbms_output.put_line('Ejecuci?n LDC_BCPeriodicReview.fnuGetPackageTypeSup nuPackageTypeId => ' ||
                         nuPackageTypeId);

    --validar tipo de solicitud
    IF nuPackageTypeId in (100014, 100153) THEN

      --Obtener identificador del producto
      nuProductId := to_number(ldc_boutilities.fsbgetvalorcampotabla('mo_motive',
                                                                     'package_id',
                                                                     'PRODUCT_ID',
                                                                     inuPackageId));
      ut_trace.trace('Ejecuci?n LDC_BCPeriodicReview.fnuGetPackageTypeSup nuProductId => ' ||
                     nuProductId,
                     10);
      dbms_output.put_line('Ejecuci?n LDC_BCPeriodicReview.fnuGetPackageTypeSup nuProductId => ' ||
                           nuProductId);

      /* Team 2732: Se cambia la logica para que consulte primero el "Tipo de suspension" en la tabla ldc_marca_producto
      porque puede que no este suspendido el producto, sino NO existe entonces consulta el tipo de suspension
      en pr_prod_suspension */

      --Obtener tipo de suspension en marca producto
      nuSuspensionType := daldc_marca_producto.fnugetsuspension_type_id(nuProductId,
                                                                        null);

      if (nuSuspensionType is null) then
        --Obtener id del registro de suspension
        nuProdSuspensionId := to_number(ldc_boutilities.fsbgetvalorcampostabla('pr_prod_suspension',
                                                                               'PRODUCT_ID',
                                                                               'prod_suspension_id',
                                                                               nuProductId,
                                                                               'ACTIVE',
                                                                               'Y'));
        -- obtener tipo de suspension de pr_prod_suspension
        nuSuspensionType := dapr_prod_suspension.fnugetsuspension_type_id(nuProdSuspensionId);
      end if;
      ut_trace.trace('Ejecuci?n LDC_BCPeriodicReview.fnuGetPackageTypeSup nuSuspensionType => ' ||
                     nuSuspensionType,
                     10);
      dbms_output.put_line('Ejecuci?n LDC_BCPeriodicReview.fnuGetPackageTypeSup nuSuspensionType => ' ||
                           nuSuspensionType);

      --Validar tipo de suspensi?n
      if instr(DALD_PARAMETER.fsbGetValue_Chain('ID_RP_SUSPENSION_TYPE'),
               to_char(nuSuspensionType)) > 0 then

        --Consultar orden de la marca
        nuOrderId := daldc_marca_producto.fnuGetORDER_ID(nuProductId, null);
        ut_trace.trace('Ejecuci?n LDC_BCPeriodicReview.fnuGetPackageTypeSup nuOrderId => ' ||
                       nuOrderId,
                       10);
        dbms_output.put_line('Ejecuci?n LDC_BCPeriodicReview.fnuGetPackageTypeSup nuOrderId => ' ||
                             nuOrderId);

        if nuOrderId is not null then

          --Obtener Solicitud de la orden de suspensi?n
          nuOrderActivityId := ldc_bcfinanceot.fnuGetActivityId(nuOrderId);
          ut_trace.trace('Ejecuci?n LDC_BCPeriodicReview.fnuGetPackageTypeSup nuOrderActivityId => ' ||
                         nuOrderActivityId,
                         10);
          dbms_output.put_line('Ejecuci?n LDC_BCPeriodicReview.fnuGetPackageTypeSup nuOrderActivityId => ' ||
                               nuOrderActivityId);

          nuPackageIdRef := daor_order_activity.fnugetpackage_id(nuOrderActivityId);
          ut_trace.trace('Ejecuci?n LDC_BCPeriodicReview.fnuGetPackageTypeSup nuPackageIdRef => ' ||
                         nuPackageIdRef,
                         10);
          dbms_output.put_line('Ejecuci?n LDC_BCPeriodicReview.fnuGetPackageTypeSup nuPackageIdRef => ' ||
                               nuPackageIdRef);

          nuPackageTypeRef := damo_packages.fnugetpackage_type_id(nuPackageIdRef);
          ut_trace.trace('Ejecuci?n LDC_BCPeriodicReview.fnuGetPackageTypeSup nuPackageTypeRef => ' ||
                         nuPackageTypeRef,
                         10);
          dbms_output.put_line('Ejecuci?n LDC_BCPeriodicReview.fnuGetPackageTypeSup nuPackageTypeRef => ' ||
                               nuPackageTypeRef);

          return nuPackageTypeRef;

        else
          return 265;
        end if;
      end if;

    END IF;

    return - 1;

    ut_trace.trace('Fin LDC_BCPeriodicReview.fnuGetPackageTypeSup', 10);
    dbms_output.put_line('Fin LDC_BCPeriodicReview.fnuGetPackageTypeSup');

  exception
    when others then
      return - 2;

  END fnuGetPackageTypeSup;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : prCertificateCharge
  Descripcion    : Procedimiento que durante la legalizaci?n de una orden de certificaci?n
                   valida si se debe o no generar cargo.


  Autor          : Sayra Ocoro - HT
  Fecha          : 04/08/2014

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/

  procedure prCertificateCharge is
    nuOrderId          or_order.order_id%type;
    nuCausalId         ge_causal.causal_id%type;
    nuClassCausalId    ge_causal.class_causal_id%type;
    nuTaskTypeId       or_task_type.task_type_id%type;
    nuClassCausalRef   ge_causal.class_causal_id%type := 1;
    nuTaskTypeRefSA    or_task_type.task_type_id%type;
    nuTaskTypeRefVR    or_task_type.task_type_id%type;
    nuOrderActivityId  or_order_activity.order_activity_id%type;
    nuOriginActivityId or_order_activity.order_activity_id%type;
    nuPackageId        mo_packages.package_id%type;
    nuGenCharge        number := 0;

    dtLivePR date := trunc(to_date(dald_parameter.fsbGetValue_Chain('LIVE_DEPARTURE_DATE_PR'),
                                   ut_date.fsbDATE_FORMAT));
    --Cursor para validar si la orden se regener? a partir de una orden de
    ---arbitraje o correcci?n.
    cursor cuIsRegen(inuActivityId or_order_activity.order_activity_id%type) is
      select count(*)
        from or_order_activity, or_order
       where or_order_activity.order_activity_id = inuActivityId
         and or_order.order_id = or_order_activity.order_id
         and ((or_order.task_type_id = 12475 and or_order.causal_id = 9537) or
             (or_order.task_type_id = 10213 and or_order.causal_id = 3162));
    nuIsRegen number := 0;

    --Cursor para obtener el valor neto de la orden
    cursor cuOrderValue(inuOrderId or_order.order_id%type) is
      SELECT sum(nvl(or_order_items.total_price, 0)) value
        FROM or_order_items
       WHERE or_order_items.order_id = inuOrderId
         AND or_order_items.out_ = 'Y';

    nuProductId     pr_product.product_id%type;
    nuContractId    pr_product.subscription_id%type;
    nuOrderValue    or_order.order_value%type;
    nuConcepto      or_task_type.concept%type;
    onuErrorCode    number;
    osbErrorMessage varchar2(2000);

  begin
    ut_trace.trace('Inicio LDC_BCPeriodicReview.prCertificateCharge', 10);
    --Obtener orden de la instancia
    nuOrderId := or_bolegalizeorder.fnuGetCurrentOrder;
    ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prCertificateCharge  => nuOrderId => ' ||
                   nuOrderId,
                   10);
    nuCausalId := daor_order.fnugetcausal_id(nuOrderId);
    ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prCertificateCharge  => nuCausalId => ' ||
                   nuCausalId,
                   10);
    nuClassCausalId := dage_causal.fnugetclass_causal_id(nuCausalId);
    ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prCertificateCharge  => nuClassCausalId => ' ||
                   nuClassCausalId,
                   10);
    nuTaskTypeId := daor_order.fnugettask_type_id(nuOrderId);
    ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prCertificateCharge  => nuTaskTypeId => ' ||
                   nuTaskTypeId,
                   10);
    nuOrderActivityId := ldc_bcfinanceot.fnuGetActivityId(nuOrderId);
    ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prCertificateCharge  => nuOrderActivityId => ' ||
                   nuOrderActivityId,
                   10);
    nuPackageId := daor_order_activity.fnugetpackage_id(nuOrderActivityId);
    ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prCertificateCharge  => nuPackageId => ' ||
                   nuPackageId,
                   10);
    ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prCertificateCharge  => trunc(damo_packages.fdtgetrequest_date(nuPackageId)) => ' ||
                   trunc(damo_packages.fdtgetrequest_date(nuPackageId)),
                   10);

    --Validar clase de causal de legalizaci?n
    if nuClassCausalId = nuClassCausalRef and
       (nuTaskTypeId = nuTaskTypeRefSA or
       (nuTaskTypeId = nuTaskTypeRefVR and damo_packages.fnugetpackage_type_id(nuPackageId) in
       (100014, 100153))) then
      --Validar tipo de trabajo
      if trunc(damo_packages.fdtgetrequest_date(nuPackageId)) < dtLivePR then
        --Validar fecha de registro de la solicitud
        nuGenCharge := 1;
      else
        --Obtener actividad de origen
        nuOriginActivityId := daor_order_activity.fnugetorigin_activity_id(nuOrderActivityId);
        ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prCertificateCharge  => nuOriginActivityId => ' ||
                       nuOriginActivityId,
                       10);
        --Validar si la orden es regenerada
        if nuOriginActivityId is not null then
          open cuIsRegen(nuOriginActivityId);
          fetch cuIsRegen
            into nuIsRegen;
          close cuIsRegen;
          if nuIsRegen > 0 then
            nuGenCharge := 1;
          end if;
        end if;
      end if;
      if nuGenCharge > 0 then
        --Obtener contrato
        nuProductId := daor_order_activity.fnugetproduct_id(nuOrderActivityId);
        ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prCertificateCharge  => nuProductId => ' ||
                       nuProductId,
                       10);
        nuContractId := dapr_product.fnugetsubscription_id(nuProductId);
        ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prCertificateCharge  => nuContractId => ' ||
                       nuContractId,
                       10);
        open cuOrderValue(nuOrderId);
        fetch cuOrderValue
          into nuOrderValue;
        close cuOrderValue;
        ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prCertificateCharge nuOrderValue => ' ||
                       nuOrderValue,
                       10);
        ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prCertificateCharge  Inicio de insertar cargo',
                       10);
        nuConcepto := daor_task_type.fnugetconcept(nuTaskTypeId);
        OS_CHARGETOBILL(INUSUBSCRIBERSERVICE => nuProductId,
                        INUCONCEPT           => nuConcepto,
                        INUUNITS             => 1,
                        INUCHARGECAUSE       => 3,
                        INUVALUE             => -1 *
                                                round(abs(nuOrderValue)),
                        ISBSUPPORTDOCUMENT   => 'PP-' || nuPackageId,
                        INUCONSPERIOD        => NULL,
                        ONUERRORCODE         => onuErrorCode,
                        OSBERRORMSG          => osbErrorMessage);
        ut_trace.trace('CODIGO ERROR --> ' || onuErrorCode);
        ut_trace.trace('DESCRIPCION ERROR --> ' || osbErrorMessage);
        ut_trace.trace('Fin de insertar cargo', 10);
        if onuErrorCode <> 0 then
          ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                           osbErrorMessage);
          raise ex.CONTROLLED_ERROR;
        end if;
      end if;
    end if;
    ut_trace.trace('Fin LDC_BCPeriodicReview.prCertificateCharge', 10);
  exception
    when ex.CONTROLLED_ERROR then
      gw_boerrors.checkerror(SQLCODE, SQLERRM);
      raise;
    when others then

      gw_boerrors.checkerror(SQLCODE, SQLERRM);
      raise ex.CONTROLLED_ERROR;

  end prCertificateCharge;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : prInspectionCharge
  Descripcion    : Procedimiento que durante la legalizaci?n de una orden de inspecci?n valida
                   con qu? concepto se debe generar el cargo dependiendo de la fecha de registro de  la
                   solicitud de revisi?n.


  Autor          : Sayra Ocoro - HT
  Fecha          : 04/08/2014

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/

  procedure prInspectionCharge is
    nuOrderId         or_order.order_id%type;
    nuCausalId        ge_causal.causal_id%type;
    nuClassCausalId   ge_causal.class_causal_id%type;
    nuTaskTypeId      or_task_type.task_type_id%type;
    nuOrderActivityId or_order_activity.order_activity_id%type;
    nuPackageId       mo_packages.package_id%type;
    nuClassCausalRef  ge_causal.class_causal_id%type := 1;
    dtLivePR          date := to_date(dald_parameter.fsbGetValue_Chain('LIVE_DEPARTURE_DATE_PR'),
                                      ut_date.fsbDATE_FORMAT);
    --Cursor para obtener el valor neto de la orden
    cursor cuOrderValue(inuOrderId or_order.order_id%type) is
      SELECT sum(nvl(or_order_items.total_price, 0)) value
        FROM or_order_items
       WHERE or_order_items.order_id = inuOrderId
         AND or_order_items.out_ = 'Y';

    nuProductId        pr_product.product_id%type;
    nuContractId       pr_product.subscription_id%type;
    nuOrderValue       or_order.order_value%type;
    nuConcepto         or_task_type.concept%type;
    onuErrorCode       number;
    osbErrorMessage    varchar2(2000);
    dtfechAsigna       date := sysdate;
    nuItem_id          ge_items.items_id%type;
    onuIdListaCosto    ge_unit_cost_ite_lis.list_unitary_cost_id%type;
    onuCostoItem       ge_unit_cost_ite_lis.price%type;
    onuPrecioVentaItem ge_unit_cost_ite_lis.sales_value%type;
  begin

    ut_trace.trace('Inicio LDC_BCPeriodicReview.prInspectionCharge', 10);
    --Obtener orden de la instancia
    nuOrderId := or_bolegalizeorder.fnuGetCurrentOrder;
    ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prInspectionCharge  => nuOrderId => ' ||
                   nuOrderId,
                   10);
    nuCausalId := daor_order.fnugetcausal_id(nuOrderId);
    ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prInspectionCharge  => nuCausalId => ' ||
                   nuCausalId,
                   10);
    nuClassCausalId := dage_causal.fnugetclass_causal_id(nuCausalId);
    ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prInspectionCharge  => nuClassCausalId => ' ||
                   nuClassCausalId,
                   10);
    nuTaskTypeId := daor_order.fnugettask_type_id(nuOrderId);
    ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prInspectionCharge  => nuTaskTypeId => ' ||
                   nuTaskTypeId,
                   10);
    nuOrderActivityId := ldc_bcfinanceot.fnuGetActivityId(nuOrderId);
    ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prInspectionCharge  => nuOrderActivityId => ' ||
                   nuOrderActivityId,
                   10);
    nuPackageId := daor_order_activity.fnugetpackage_id(nuOrderActivityId);
    ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prInspectionCharge  => nuPackageId => ' ||
                   nuPackageId,
                   10);
    --Validar clase de causal de legalizaci?n
    if nuClassCausalId = nuClassCausalRef and
       nuTaskTypeId = dald_parameter.fnuGetNumeric_Value('TIPO_TRABAJO_RP') and
       damo_packages.fdtgetrequest_date(nuPackageId) < dtLivePR then

      --Obtener contrato
      nuProductId := daor_order_activity.fnugetproduct_id(nuOrderActivityId);
      ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prCertificateCharge  => nuProductId => ' ||
                     nuProductId,
                     10);
      nuContractId := dapr_product.fnugetsubscription_id(nuProductId);
      ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prCertificateCharge  => nuContractId => ' ||
                     nuContractId,
                     10);

      nuOrderValue := daor_order.fnugetorder_value(nuOrderId);
      ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prCertificateCharge nuOrderValue => ' ||
                     nuOrderValue,
                     10);
      ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prCertificateCharge  Inicio de insertar cargo CR',
                     10);
      nuConcepto := daor_task_type.fnugetconcept(nuTaskTypeId);
      OS_CHARGETOBILL(INUSUBSCRIBERSERVICE => nuProductId,
                      INUCONCEPT           => nuConcepto,
                      INUUNITS             => 1,
                      INUCHARGECAUSE       => 3,
                      INUVALUE             => -1 * round(abs(nuOrderValue)),
                      ISBSUPPORTDOCUMENT   => 'PP-' || nuPackageId,
                      INUCONSPERIOD        => NULL,
                      ONUERRORCODE         => onuErrorCode,
                      OSBERRORMSG          => osbErrorMessage);
      ut_trace.trace('CODIGO ERROR --> ' || onuErrorCode);
      ut_trace.trace('DESCRIPCION ERROR --> ' || osbErrorMessage);
      ut_trace.trace('Fin de insertar cargo', 10);
      if onuErrorCode <> 0 then
        ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                         osbErrorMessage);
        raise ex.CONTROLLED_ERROR;
      end if;
      ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prCertificateCharge  Inicio de insertar cargo DB',
                     10);
      nuConcepto := dald_parameter.fnuGetNumeric_Value('CONC_REVISION_PERIODICA');
      nuItem_id  := daor_order_activity.fnugetactivity_id(nuOrderActivityId);
      ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prCertificateCharge nuItem_id => ' ||
                     nuItem_id,
                     10);
      GE_BCCertContratista.ObtenerCostoItemLista(nuItem_id,
                                                 dtfechAsigna,
                                                 null,
                                                 null,
                                                 null,
                                                 null,
                                                 onuIdListaCosto,
                                                 onuCostoItem,
                                                 onuPrecioVentaItem);

      OS_CHARGETOBILL(INUSUBSCRIBERSERVICE => nuProductId,
                      INUCONCEPT           => nuConcepto,
                      INUUNITS             => 1,
                      INUCHARGECAUSE       => 53,
                      INUVALUE             => round(abs(onuPrecioVentaItem)),
                      ISBSUPPORTDOCUMENT   => 'PP-' || nuPackageId,
                      INUCONSPERIOD        => NULL,
                      ONUERRORCODE         => onuErrorCode,
                      OSBERRORMSG          => osbErrorMessage);
      ut_trace.trace('CODIGO ERROR --> ' || onuErrorCode);
      ut_trace.trace('DESCRIPCION ERROR --> ' || osbErrorMessage);
      ut_trace.trace('Fin de insertar cargo', 10);
      if onuErrorCode <> 0 then
        ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                         osbErrorMessage);
        raise ex.CONTROLLED_ERROR;
      end if;

    end if;
    ut_trace.trace('Fin LDC_BCPeriodicReview.prInspectionCharge', 10);
  exception
    when ex.CONTROLLED_ERROR then
      gw_boerrors.checkerror(SQLCODE, SQLERRM);
      raise;
    when others then

      gw_boerrors.checkerror(SQLCODE, SQLERRM);
      raise ex.CONTROLLED_ERROR;
  end prInspectionCharge;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : prRegisterCertificate
  Descripcion    : Procedimiento que ejecuta el objeto OR_BOOBJACTUTILITIES.REGISTERCERTIFICATE
                   s?lo cuando la causal de legalizaci?n est? en el par?metro CAUSAL_TO_CERTIFY.
                   El funcional debe validar en qu? registros configurados en FMIO debe reemplazar
                   el objeto OR_BOOBJACTUTILITIES.REGISTERCERTIFICATE por LDC_BCPeriodicReview.prRegisterCertificate


  Autor          : Sayra Ocoro - HT
  Fecha          : 06/08/2014

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/

  procedure prRegisterCertificate is
    nuOrderId  ge_boInstanceControl.stysbValue;
    nuCausalId or_order.causal_id%type;
  begin
    ut_trace.trace('Inicio LDC_BCPeriodicReview.prRegisterCertificate', 10);
    --Obtener orden de la instancia
    nuOrderId := or_bolegalizeorder.fnugetcurrentorder;
    ut_trace.trace('Ejecuci?n LDC_BCPeriodicReview.prRegisterCertificate => nuOrderId--> ' ||
                   nuOrderId,
                   10);
    --Obtener causal de legalizaci?n
    nuCausalId := daor_order.fnugetcausal_id(nuorderid);
    ut_trace.trace('Ejecuci?n LDC_BCPeriodicReview.prRegisterCertificate => nuCausalId --> ' ||
                   nuCausalId,
                   10);
    if instr(',' || dald_parameter.fsbGetValue_Chain('CAUSAL_TO_CERTIFY') || ',',
             ',' || to_char(nuCausalId) || ',') > 0 then
      OR_BOOBJACTUTILITIES.REGISTERCERTIFICATE;
    end if;
    ut_trace.trace('Fin LDC_BCPeriodicReview.prRegisterCertificate', 10);
  exception
    when others then
      raise;
  end prRegisterCertificate;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : prBrandProdByRepair
  Descripcion    : Procedimiento que marca el producto por no certificar
  Autor          : Sayra Ocoro - HT
  Fecha          : 08/08/2014

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  procedure prBrandProdByRepair is
    nuOrderId         or_order.order_id%type;
    nuOrderActivityId or_order_activity.order_activity_id%type;
    nuProductId       pr_product.product_id%type;
    dtLegalizeRP      date;
    nuIntentos        number := 0;
    nuCausalId        ge_causal.causal_id%type;
    nuCausalClassId   ge_class_causal.class_causal_id%type;
    nuPackage_id      mo_packages.package_id%type;
    nuPackageTypeId   mo_packages.package_type_id%type;
    nuOt              or_order.order_id%type;

  begin
    --Obtener orden de la instancia
    nuOrderId := or_bolegalizeorder.fnuGetCurrentOrder;
    --Obtener causal
    nuCausalId        := daor_order.fnugetcausal_id(nuOrderId);
    nuOrderActivityId := ldc_bcfinanceot.fnuGetActivityId(nuOrderId);
    --Obtener identificador del producto
    nuProductId := daor_order_activity.fnugetproduct_id(nuOrderActivityId);
    --OBTENER LA SOLICITUD
    nuPackage_id := daor_order_activity.Fnugetpackage_Id(nuOrderActivityId);
    -- busco el tipo de paquete
    nuPackageTypeId := damo_packages.fnugetpackage_type_id(nuPackage_id);
    -- OBTENER LA CLASE DE CAUSAL
    nuCausalClassId := dage_causal.fnugetclass_causal_id(nuCausalId);
    --VALIDAR SI LA CAUSAL DE LEGALIZACION ES DE FALLO PARA MARCAR EL PRODUCTO
    if nuPackageTypeId not in (100101) and nuCausalClassId = 2 then

      nuOt := LDCI_PKREVISIONPERIODICAWEB.fnuGetOtUltimaRP(nuProductId);
      if nuOt is null then
        dtLegalizeRP := trunc(sysdate);
      else
        dtLegalizeRP := daor_order.fdtgetlegalization_date(nuOt);
      end if;

      --Validar la existencia de la marcar del producto
      if daldc_marca_producto.fblExist(nuProductId) then
        nuIntentos := daldc_marca_producto.fnuGetINTENTOS(nuProductId);
        nuIntentos := nuIntentos + 1;
        daldc_marca_producto.updFECHA_ULTIMA_ACTU(nuProductId,
                                                  dtLegalizeRP);
        daldc_marca_producto.updINTENTOS(nuProductId, nuIntentos);
        IF nuPackageTypeId not in (100014, 100153) THEN
          daldc_marca_producto.updORDER_ID(nuProductId, nuOrderId);
        end if;
        daldc_marca_producto.updREGISTER_POR_DEFECTO(nuProductId, 'Y');
        daldc_marca_producto.updMEDIO_RECEPCION(nuProductId, 'I');
        daldc_marca_producto.updSUSPENSION_TYPE_ID(nuProductId, 102);
      else
        -- ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prGenerateCertificate  => INSERTA MARCA' ,10);
        insert into ldc_marca_producto
          (id_producto,
           order_id,
           certificado,
           fecha_ultima_actu,
           intentos,
           medio_recepcion,
           register_por_defecto,
           suspension_type_id)
        values
          (nuProductId, nuOrderId, null, dtLegalizeRP, 1, 'I', 'Y', 102);
      end if;

    end if;
  exception
    when others then
      raise;
  end prBrandProdByRepair;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : prTemporalCharge
  Descripcion    : Procedimiento que durante la legalizaci?n elimina cargos. Soluci?n Operativa Temporal
  Autor          : Sayra Ocoro - HT
  Fecha          : 09/08/2014

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  procedure prTemporalCharge is
    nuOrderId         or_order.order_id%type;
    nuCausalId        ge_causal.causal_id%type;
    nuClassCausalId   ge_causal.class_causal_id%type;
    nuTaskTypeId      or_task_type.task_type_id%type;
    nuOrderActivityId or_order_activity.order_activity_id%type;
    nuPackageId       mo_packages.package_id%type;
    nuClassCausalRef  ge_causal.class_causal_id%type := 1;
    dtLivePR          date := trunc(to_date(dald_parameter.fsbGetValue_Chain('LIVE_DEPARTURE_DATE_PR'),
                                            ut_date.fsbDATE_FORMAT));
    --Cursor para obtener el valor neto de la orden
    cursor cuOrderValue(inuOrderId or_order.order_id%type) is
      SELECT sum(nvl(or_order_items.total_price, 0)) value
        FROM or_order_items
       WHERE or_order_items.order_id = inuOrderId
         AND or_order_items.out_ = 'Y';

    nuProductId     pr_product.product_id%type;
    nuContractId    pr_product.subscription_id%type;
    nuOrderValue    or_order.order_value%type;
    nuConcepto      or_task_type.concept%type;
    onuErrorCode    number;
    osbErrorMessage varchar2(2000);

    onuIdListaCosto    ge_unit_cost_ite_lis.list_unitary_cost_id%type;
    onuCostoItem       ge_unit_cost_ite_lis.price%type;
    onuPrecioVentaItem ge_unit_cost_ite_lis.sales_value%type;
    nuItem_id          ge_items.items_id%type;
    dtfechAsigna       date := sysdate;
    nuGenCharge        number := 0;
    nuOriginActivityId or_order_activity.origin_activity_id%type;
    --Cursor para validar si la orden se regener? a partir de una orden de
    ---arbitraje o correcci?n.
    cursor cuIsRegen(inuActivityId or_order_activity.order_activity_id%type) is
      select count(*)
        from or_order_activity, or_order
       where or_order_activity.order_activity_id = inuActivityId
         and or_order.order_id = or_order_activity.order_id
         and ((or_order.task_type_id = 12475 and or_order.causal_id = 9537) or
             (or_order.task_type_id = 10213 and or_order.causal_id = 3162));
    nuIsRegen number := 0;
  begin

    ut_trace.trace('Inicio LDC_BCPeriodicReview.prTemporalCharge', 10);
    --Obtener orden de la instancia
    nuOrderId := or_bolegalizeorder.fnuGetCurrentOrder;
    ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prTemporalCharge  => nuOrderId => ' ||
                   nuOrderId,
                   10);
    nuCausalId := daor_order.fnugetcausal_id(nuOrderId);
    ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prTemporalCharge  => nuCausalId => ' ||
                   nuCausalId,
                   10);
    nuClassCausalId := dage_causal.fnugetclass_causal_id(nuCausalId);
    ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prTemporalCharge  => nuClassCausalId => ' ||
                   nuClassCausalId,
                   10);
    nuTaskTypeId := daor_order.fnugettask_type_id(nuOrderId);
    ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prTemporalCharge  => nuTaskTypeId => ' ||
                   nuTaskTypeId,
                   10);
    --Validar clase de causal de legalizaci?n
    if nuClassCausalId = nuClassCausalRef and
       nuTaskTypeId in (12161, 12162, 12163) then

      nuOrderActivityId := ldc_bcfinanceot.fnuGetActivityId(nuOrderId);
      ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prTemporalCharge  => nuOrderActivityId => ' ||
                     nuOrderActivityId,
                     10);
      nuPackageId := daor_order_activity.fnugetpackage_id(nuOrderActivityId);
      ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prTemporalCharge  => nuPackageId => ' ||
                     nuPackageId,
                     10);
      --Obtener el valor del item
      nuItem_id := daor_order_activity.fnugetactivity_id(nuOrderActivityId);
      ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prTemporalCharge nuItem_id => ' ||
                     nuItem_id,
                     10);
      GE_BCCertContratista.ObtenerCostoItemLista(nuItem_id,
                                                 dtfechAsigna,
                                                 null,
                                                 null,
                                                 null,
                                                 null,
                                                 onuIdListaCosto,
                                                 onuCostoItem,
                                                 onuPrecioVentaItem);
      ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prTemporalCharge onuPrecioVentaItem => ' ||
                     onuPrecioVentaItem,
                     10);
      nuConcepto := daor_task_type.fnugetconcept(nuTaskTypeId);
      ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prTemporalCharge nuConcepto => ' ||
                     nuConcepto,
                     10);
      --Obtener servicio
      nuProductId := daor_order_activity.fnugetproduct_id(nuOrderActivityId);
      ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prTemporalCharge  => nuProductId => ' ||
                     nuProductId,
                     10);
      --Obtener contrato
      nuContractId := dapr_product.fnugetsubscription_id(nuProductId);
      ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prTemporalCharge  => nuContractId => ' ||
                     nuContractId,
                     10);

      if nuTaskTypeId =
         dald_parameter.fnuGetNumeric_Value('TIPO_TRABAJO_RP') then
        --Eliminar cargo
        delete from cargos
         where cargos.cargnuse = nuProductId
           and cargos.cargconc in (174, 739, 137)
           and cargdoso = 'PP-' || nuPackageId;
        nuGenCharge := 1;
        --Validar fecha para crear cargo correcto
        if trunc(damo_packages.fdtgetrequest_date(nuPackageId)) < dtLivePR then
          nuConcepto := dald_parameter.fnuGetNumeric_Value('CONC_REVISION_PERIODICA');

        end if;
      end if;
      if nuTaskTypeId = 12162 and damo_packages.fnugetpackage_type_id(nuPackageId) in
         (100153, 100014) then
        --Eliminar cargo
        delete from cargos
         where cargos.cargnuse = nuProductId
           and cargos.cargconc in (674, 137)
           and cargdoso = 'PP-' || nuPackageId;
        if trunc(damo_packages.fdtgetrequest_date(nuPackageId)) >= dtLivePR then
          --Obtener actividad de origen
          nuOriginActivityId := daor_order_activity.fnugetorigin_activity_id(nuOrderActivityId);
          ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prTemporalCharge  => nuOriginActivityId => ' ||
                         nuOriginActivityId,
                         10);
          --Validar si la orden es regenerada
          if nuOriginActivityId is not null then
            open cuIsRegen(nuOriginActivityId);
            fetch cuIsRegen
              into nuIsRegen;
            close cuIsRegen;
            if nuIsRegen > 0 then
              nuGenCharge := 0;
            else
              nuGenCharge := 1;
            end if;
          else
            nuGenCharge := 1;
          end if;
        end if;
      end if;
      if nuTaskTypeId = 12163 then
        --Eliminar cargo
        delete from cargos
         where cargos.cargnuse = nuProductId
           and cargos.cargconc in (738, 137)
           and cargdoso = 'PP-' || nuPackageId;
        if trunc(damo_packages.fdtgetrequest_date(nuPackageId)) >= dtLivePR then
          --Obtener actividad de origen
          nuOriginActivityId := daor_order_activity.fnugetorigin_activity_id(nuOrderActivityId);
          ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prTemporalCharge  => nuOriginActivityId => ' ||
                         nuOriginActivityId,
                         10);
          --Validar si la orden es regenerada
          if nuOriginActivityId is not null then
            open cuIsRegen(nuOriginActivityId);
            fetch cuIsRegen
              into nuIsRegen;
            close cuIsRegen;
            if nuIsRegen > 0 then
              nuGenCharge := 0;
            else
              nuGenCharge := 1;
            end if;
          else
            nuGenCharge := 1;
          end if;
        end if;
      end if;
      if nuGenCharge > 0 then
        ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prTemporalCharge  Inicio de insertar cargo CR',
                       10);

        OS_CHARGETOBILL(INUSUBSCRIBERSERVICE => nuProductId,
                        INUCONCEPT           => nuConcepto,
                        INUUNITS             => 1,
                        INUCHARGECAUSE       => 53,
                        INUVALUE             => round(abs(onuPrecioVentaItem)),
                        ISBSUPPORTDOCUMENT   => 'PP-' || nuPackageId,
                        INUCONSPERIOD        => NULL,
                        ONUERRORCODE         => onuErrorCode,
                        OSBERRORMSG          => osbErrorMessage);
        ut_trace.trace('CODIGO ERROR --> ' || onuErrorCode);
        ut_trace.trace('DESCRIPCION ERROR --> ' || osbErrorMessage);
        ut_trace.trace('Fin de insertar cargo', 10);
        if onuErrorCode <> 0 then
          ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                           osbErrorMessage);
          raise ex.CONTROLLED_ERROR;
        end if;
        ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prTemporalCharge  FIN de insertar cargo DB ' ||
                       nuConcepto,
                       10);
      end if;
    end if;
    ut_trace.trace('Fin LDC_BCPeriodicReview.prTemporalCharge', 10);
  exception
    when ex.CONTROLLED_ERROR then
      gw_boerrors.checkerror(SQLCODE, SQLERRM);
      raise;
    when others then

      gw_boerrors.checkerror(SQLCODE, SQLERRM);
      raise ex.CONTROLLED_ERROR;
  end prTemporalCharge;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : prFinanceCertificate
  Descripcion    : Procedimiento que durante la legalizaci?n valida
                   que la actividad de certificaci?n sea diferente a la
                   de industriales para financiar.
  Autor          : Sayra Ocoro - HT
  Fecha          : 10/08/2014

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  30-06-2015      SANDRA MU?OZ        Se desactiva la traza
  ******************************************************************/
  procedure prFinanceCertificate

   is
    nuOrderId         or_order.order_id%type;
    nuCausalId        ge_causal.causal_id%type;
    nuClassCausalId   ge_causal.class_causal_id%type;
    nuClassCausalRef  ge_causal.class_causal_id%type := 1;
    nuOrderActivityId or_order_activity.order_activity_id%type;
    nuItemId          ge_items.items_id%type;
    nuPackageId       mo_packages.package_id%type;

  begin

    -- ARA8039. SMUNOZ. Se desactiva la traza
    /*
    ut_trace.init;
    ut_trace.setlevel(99);
    ut_trace.setoutput(ut_trace.fntrace_output_db);
	*/

    ut_trace.trace('Inicio LDC_BCPeriodicReview.prFinanceCertificate', 10);
    --Obtener orden de la instancia
    nuOrderId := or_bolegalizeorder.fnuGetCurrentOrder;
    ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prFinanceCertificate  => nuOrderId => ' ||
                   nuOrderId,
                   10);
    nuCausalId := daor_order.fnugetcausal_id(nuOrderId);
    ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prFinanceCertificate  => nuCausalId => ' ||
                   nuCausalId,
                   10);
    nuClassCausalId := dage_causal.fnugetclass_causal_id(nuCausalId);
    ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prFinanceCertificate  => nuClassCausalId => ' ||
                   nuClassCausalId,
                   10);

    --Validar clase de causal de legalizaci?n
    if nuClassCausalId = nuClassCausalRef then

      nuOrderActivityId := ldc_bcfinanceot.fnuGetActivityId(nuOrderId);
      ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prFinanceCertificate  => nuOrderActivityId => ' ||
                     nuOrderActivityId,
                     10);
      --Obtener identificador de la actividad principal de la orden
      nuItemId := daor_order_activity.fnugetactivity_id(nuOrderActivityId);
      ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prFinanceCertificate  => nuItemId => ' ||
                     nuItemId,
                     10);
      --Obtener identificador de la solicitud
      nuPackageId := daor_order_activity.fnugetpackage_id(nuOrderActivityId);
      ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prFinanceCertificate  => nuPackageId => ' ||
                     nuPackageId,
                     10);
      ut_trace.trace('Ejecucion LDC_BCPeriodicReview.prFinanceCertificate  => damo_packages.fnugetpackage_type_id(nuPackageId) => ' ||
                     damo_packages.fnugetpackage_type_id(nuPackageId),
                     10);
      if damo_packages.fnugetpackage_type_id(nuPackageId) not in
         (323, 271, 100229) and
         nuItemId not in (4295150, 4294344, 100002319, 100002373) then
        --Version anterior: ldc_bcfinanceot.prFinanceOt;

        -- paulaag [12/11/2014] Inicio soluci?n NC 3456:
        -- Si los atributos Plan Acuerdo Pago y N?mero de Cuotas tienen valor -1,
        -- es porque es un pago de contado y no se requiere crear la Financiaci?n.

        -- Obtiene el atributo Plan Acuerdo Pago
        sbPlanAcuerdoPago := LDC_BOORDENES.fsbDatoAdicTmpOrden(nuOrderId,
                                                               5001515,
                                                               'PLAN_ACUERDO_PAGO_CERTIF');

        ut_trace.trace('-- PPASO 01. Ejecucion LDC_BCPeriodicReview.prFinanceCertificate  => nuPlanAcuerdoPago => ' ||
                       sbPlanAcuerdoPago,
                       10);
        -- Obtiene el atributo N?mero de Cuotas
        sbCuotas := LDC_BOORDENES.fsbDatoAdicTmpOrden(nuOrderId,
                                                      5001516,
                                                      'NUM_CUOTAS_FINANC_CERTIF');

        ut_trace.trace('-- PPASO 02. Ejecucion LDC_BCPeriodicReview.prFinanceCertificate  => nuCuotas => ' ||
                       sbCuotas,
                       10);

        /*V1
        if ((to_number(sbPlanAcuerdoPago) != cnuValorDefecto) and (to_number(sbCuotas) != cnuValorDefecto)) then
        ut_trace.trace('-- PPASO 03. Va a crear financiaci?n de la OT Inicia ldc_bcfinanceot.prFinanceOt',10);
        ldc_bcfinanceot.prFinanceOt;
        end if;*/

        if ((to_number(sbPlanAcuerdoPago) = cnuValorDefecto) and
           (to_number(sbCuotas) = cnuValorDefecto)) then
          ut_trace.trace('-- PPASO 03. Va a crear la cuenta de la solicitud Sol[' ||
                         nuPackageId || ']',
                         10);
          CC_BOACCOUNTS.GENERATEACCOUNTBYPACK(nuPackageId);
        else
          ut_trace.trace('-- PPASO 03. Va a crear financiaci?n de la OT Inicia ldc_bcfinanceot.prFinanceOt',
                         10);
          ldc_bcfinanceot.prFinanceOt;
        end if;

        -- paulaag [12/11/2014] Fin soluci?n NC 3456
      end if;

    end if;
    ut_trace.trace('Fin LDC_BCPeriodicReview.prFinanceCertificate', 10);
  end prFinanceCertificate;

  /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : prFillOTREV_Causal
    Descripcion    : Procedimiento para llenar la tabla usada en el reporte prceso OTREV con causal

    Fecha             Autor             Modificacion
    =========       =========           ====================
   14/08/2014         oparra            Aranda 3554: Se adiciona sentencia al reporte OTREV
                                        incluira la causal
  ******************************************************************/

  PROCEDURE prFillOTREV_Causal IS
    sbQuery varchar2(2000);
    nuCant  number := 0;

    CURSOR cuOTREVcaus IS
      select l.*,
             open.dage_causal.fsbgetdescription(Causal_Revision_periodica,
                                                null) CAUSAL
        from (select PRODUCTO "PRODUCT_ID",
                     SUBSCRIBER_ID "CLIENTE",
                     IDENTIFICATION "IDENTIFICACION",
                     SUBSCRIBER_NAME "NOMBRE",
                     nvl(SUBS_LAST_NAME, '-') "APELLIDO",
                     ADDRESS "DIRECCION",
                     GEO_LOCA_FATHER_ID "CODIGO_DEPARTAMENTO",
                     Departamento "DEPARTAMENTO",
                     GEOGRAP_LOCATION_ID "CODIGO_LOCALIDAD",
                     Localidad "LOCALIDAD",
                     nvl(NEIGHBORTHOOD_ID, -1) "CODIGO_BARRIO",
                     DESC_BARR "BARRIO",
                     Ciclo "CICLO",
                     Cat "USO",
                     Subc "ESTRATO",
                     Meses "MESES",
                     nvl((select or_order.causal_id
                           from Open.or_order_activity, Open.or_order
                          where or_order_activity.product_id = PRODUCTO
                            and or_order_activity.task_type_id in
                                (12161, 12162, 12163, 12164)
                            and or_order.order_id =
                                or_order_activity.order_id
                            and or_order.order_status_id = 8
                            and or_order.legalization_date =
                                (select MAX(or_order.legalization_date)
                                   from Open.or_order_activity, Open.or_order
                                  where or_order_activity.product_id =
                                        PRODUCTO
                                    and or_order_activity.task_type_id in
                                        (12161, 12162, 12163, 12164)
                                    and or_order.order_id =
                                        or_order_activity.order_id
                                    and or_order.order_status_id = 8)
                            and rownum = 1),
                         -1) Causal_Revision_periodica
                FROM (select SUSCCODI PRODUCTO,
                             a.SUBSCRIBER_ID,
                             a.IDENTIFICATION,
                             a.SUBSCRIBER_NAME,
                             a.SUBS_LAST_NAME,
                             b.ADDRESS,
                             c.GEO_LOCA_FATHER_ID,
                             open.LDC_BOUTILITIES.fsbGetValorCampoTabla('GE_GEOGRA_LOCATION',
                                                                        'GEOGRAP_LOCATION_ID',
                                                                        'DESCRIPTION',
                                                                        c.GEO_LOCA_FATHER_ID) Departamento,
                             b.GEOGRAP_LOCATION_ID,
                             c.DESCRIPTION Localidad,
                             b.NEIGHBORTHOOD_ID,
                             open.LDC_BOUTILITIES.fsbGetValorCampoTabla('GE_GEOGRA_LOCATION',
                                                                        'GEOGRAP_LOCATION_ID',
                                                                        'DESCRIPTION',
                                                                        b.NEIGHBORTHOOD_ID) DESC_BARR,
                             e.sesucicl Ciclo,
                             e.SESUCATE Cat,
                             e.SESUSUCA Subc,
                             trunc(MONTHS_BETWEEN(trunc(sysdate),
                                                  open.LDC_BOORDENES.fnuGetFechaReision(e.SESUNUSE))) Meses
                        from open.servsusc           e,
                             open.pr_product         f,
                             open.suscripc           d,
                             open.ge_subscriber      a,
                             open.ab_address         b,
                             open.GE_GEOGRA_LOCATION c
                       where e.SESUSERV = 7014
                         and e.sesunuse <> -1
                         and e.sesucate in (1, 2)
                         AND f.product_id = e.sesunuse
                         and f.product_status_id = 1
                         and e.sesuesfn not in ('C')
                         and d.SUSCCODI = f.subscription_id
                         and a.SUBSCRIBER_ID = d.SUSCCLIE
                         AND a.ACTIVE = 'Y'
                         and b.ADDRESS_ID = f.ADDRESS_ID
                         and c.GEOGRAP_LOCATION_ID = b.GEOGRAP_LOCATION_ID
                         and not exists
                       (select 1
                                from mo_packages      a,
                                     ps_motive_status c,
                                     mo_motive        x
                               WHERE a.PACKAGE_TYPE_ID in
                                     (265, 266, 100237, 100153, 100246, 100156,
                                      100248, 100014, 100153, 100270)
                                 AND c.MOTIVE_STATUS_ID = a.MOTIVE_STATUS_ID
                                 AND c.MOTI_STATUS_TYPE_ID = 2
                                 AND c.MOTIVE_STATUS_ID not in (14, 32, 51)
                                 and x.PACKAGE_ID = a.PACKAGE_ID
                                 and x.PRODUCT_ID = f.product_id)
                            --Validar la existencia de solicitudes de servicios
                            --asociados con ordenes certificables
                         and not exists
                       (select 1
                                from ldc_trab_cert,
                                     or_order_activity,
                                     or_order,
                                     mo_packages
                               where or_order_activity.PRODUCT_ID =
                                     f.product_id
                                 and id_trabcert =
                                     or_order_activity.task_type_id
                                 and or_order.order_id =
                                     or_order_activity.order_id
                                 and order_status_id in (0, 5, 7)
                                 and mo_packages.package_id =
                                     or_order_activity.package_id
                                 and mo_packages.package_type_id = 100101)
                         and not exists (select 1
                                from ldc_marca_producto
                               where ldc_marca_producto.id_producto =
                                     f.product_id)

                      )) l
       where l.Causal_Revision_periodica in
             (3103, 3104, 3105, 3106, 3107, 3108, 3109, 3112, 9582);

  BEGIN

    --pkErrors.Push ('LDC_BCPeriodicReview.prFillOTREV_causal');
    dbms_output.put_line('Inicio LDC_BCPeriodicReview.prFillOTREV_causal - ' ||
                         sysdate);
    sbQuery := 'truncate table ldc_otrev_causal';
    execute immediate sbQuery;

    for rgOTREV in cuOTREVcaus loop
      insert into open.ldc_otrev_causal
      values
        (rgOTREV.PRODUCT_ID,
         rgOTREV.CLIENTE,
         rgOTREV.IDENTIFICACION,
         rgOTREV.NOMBRE,
         rgOTREV.APELLIDO,
         rgOTREV.DIRECCION,
         rgOTREV.CODIGO_DEPARTAMENTO,
         rgOTREV.DEPARTAMENTO,
         rgOTREV.CODIGO_LOCALIDAD,
         rgOTREV.LOCALIDAD,
         rgOTREV.CODIGO_BARRIO,
         rgOTREV.BARRIO,
         rgOTREV.CICLO,
         rgOTREV.USO,
         rgOTREV.ESTRATO,
         rgOTREV.MESES,
         rgOTREV.CAUSAL);
      --commit;
      --- Se inserta cada 500 registros
      nuCant := nuCant + 1;
      if mod(nuCant, 500) = 0 then
        commit;
      end if;

    end loop;

    commit;

    dbms_output.put_line('Fin LDC_BCPeriodicReview.prFillOTREV_causal - ' ||
                         sysdate);
    --pkErrors.Pop;

  EXCEPTION
    when others then
      dbms_output.put_line('Error LDC_BCPeriodicReview.prFillOTREV_causal ' ||
                           sqlcode || ' - ' || sqlerrm);
      raise;
  END prFillOTREV_causal;

END LDC_BCPeriodicReview;
/

