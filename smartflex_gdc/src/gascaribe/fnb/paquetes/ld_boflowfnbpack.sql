CREATE OR REPLACE PACKAGE LD_BOFLOWFNBPACK IS
  /************************************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : LD_boflowFNB
  Descripcion    : Paquete con los servicios del flujo de venta.
  Autor          : Eduar Ramos Barragan
  Fecha          : 09/01/13 09:55:27 a.m.

  Historia de Modificaciones
  Fecha             Autor               Modificacion
  =========         =================   ================================================
  17/01/2024        jsoto               (OSF-2019) Ajuste en los métodos LegSaleOrder, GenerateOrdersByArt
                                        y createproducReal reemplazando API OS_LEGALIZEORDERALLACTIVITIES y 
                                        y OS_REGISTERREQUESTWITHXML por API_LEGALIZEORDERS y API_REGISTERREQUESTBYXML
  01-03-2018        Sebastian Tapias     REQ.2001695 se modifica el servicio <<frfgetdelarticlesleg>>
  02-06-2017        Sebastian Tapias        Caso 200-1306, se agrega servicio ActEstacortyComp,
                                        este se llama al final del proceso GenerateOrdersByArt.
  16-05-2017        Jorge Valiente          CASO 200-1164
  08-05-2017        STapias.Caso[200-1268] Cambio de alcance, se modifica <<GenerateOrdersByArt>>
  26-04-2017        STapias.Caso[200-564] Cambio de alcance, se modifica <<GenerateOrdersByArt>>
  08-08-2016        KBaquero.Caso[200-311] Se modifica el metodo <<cancellationSaleorder>>
  08-08-2016        KBaquero.Caso[200-311] Se modifica el metodo<<createproducReal>>
  02-07-2015        KCienfuegos.ARA7715 Se modifica el metodo <<frfgetdelarticlesleg>>
  23-06-2015        KCienfuegos.ARA7715 Se modifica el metodo <<frfgetdelarticlesleg>>
  11-06-2015        ABaldovino [7810]   Se modifica el metodo <<frfgetdelarticlesleg>>
  10-06-2015        jhinestroza [7213]  Se modifica el motodo <<cancellationSaleorder>>
  08-05-2015        KCienfuegos.SAO312817 Se modifica el metodo <<AttendPackAndUpdCons>>
  22-04-2014        SLemus.ARA7049      Se modifica el metodo <<CreateDelivOrderCharg>>
  20-04-2015        ABaldovino [ARA 6286]   Se modifica el m?todo <<frfgetdelarticlesleg>>
  05-03-2015        Llozada [ARA 6099]  Se modifica el m?todo <<frfgetdelarticlesleg>>
  20-01-2015        KCienfuegos.ARA5737 Se crea m?todo <<registerDelivDate>>
  09-01-2015        KCienfuegos.RNP1224 Se modifica el m?todo <<frfgetdelarticlesleg>>
                                        Se crea m?todo        <<registerInvoice>>
  19-12-2014        Llozada [NC 4303]   Se modifica el m?todo <<cancellationSaleorder>>
  04-12-2014        KCienfuegos.NC4068  Se modifica metodos <<AssignActToNewOrders>>
  02-12-2014        KCienfuegos.NC3012  Se modifica metodo <<cancellationSaleorder>>
  26-11-2014        KCienfuegos.NC4059  Se modifica metodo <<ActivateProduct>>
  13-11-2014        KCienfuegos.NC2860  Se modifica metodo <<createproducReal>>
  12-11-2014        KCienfuegos.NC3686  Se modifica metodo <<ActivateProduct>>
  28-10-2014        KCienfuegos.RNP1808 Se modifica metodo <<createdelivery>>
  18-10-2014        KCienfuegos.RNP2860 Se modifica metodo <<createproducOcuppier>>
  10-10-2014        KCienfuegos.RNP1179 Se modifica metodo <<createdelivery>>
  10-10-2014        KCienfuegos.RNP1179 Se crea metodo <<CreateInstallationOrder>>
  01-10-2014        KCienfuegos.RNP1810 Se modifica metodo <<fnuValidaGranSuper>>
  05-09-2014        AEcheverry.4769     Se modifica  <<cancellationSaleorder>>
  21-08-2014        KCienfuegos.NC1489  Se modifica metodo <<AttendVisitPackage>>
  21-08-2014        KCienfuegos.NC1664  Se modifica metodo <<RegChargeFinancing>>
  20-08-2014        KCienfuegos.NC1555  Se modifica metodo <<Executerules>>
  19-08-2014        KCienfuegos.RNP156  Se crea el metodo <<commentDelOrder>>
                                        Se modifica el metodo <<LegSaleOrder>>
  02-08-2014        KCienfuegos.NC629   Se modifica metodo <<frfgetdelarticlesleg>>
  03-07-2014        aecheverry.4074     Se modifica <<CreateDelivOrderCharg>>
  26-05-2014        darevalo.3638       Se adiciona metodo <<ApplyCouponPP>>
  26-05-2014        darevalo.3638       Se modifica <<createCupon>>
                      y <<cancellationSaleorder>>
  11/04/2014        JCarmona.3361       Se adiciona metodo <<fnuValLegDelOrder>>
  25-02-2014        eurbano.SAO234145   se modifica <<CreateDelivOrderCharg>>
  15-01-2013        AEcheverrySAO229596 Se modifican los servicios <<createproducreal>> y
                                        <<createproducOcuppier>>
  10-12-2013        JCarmona.SAO226940  Se modifica el metodo <<AttendVisitPackage>>
  10-12-2013        JCarmona.SAO227029  Se modifica el metodo <<fnuVerifacancelot>>
  09-12-2013        JCarmona.SAO226625  Se modifica el metodo <<CreateDelivOrderCharg>>
  22-11-2013        hjgomez.SAO224494   Se modifica <<createproducReal>>
  21-11-2013        hjgomez.SAO224456   Se modifica <cancellationSaleorder>
  20-11-2013        hjgomez.SAO223711   Se modifica <CreateDelivOrderCharg>
  12-11-2013        anietoSAO223132     1 - Se modifica el paquete para eliminar el codigo
                                            comentado e inutil.
  23-10-2013        jrobayo.SAO221150   Se modifica el metodo <ActivateProduct>
  07-10-2013        LDiuza.SAO218287    Se modifica el metodo <GenerateOrderFNB>
  06-10-2013        LDiuza.SAO218424    Se adiciona metodo privado <AttendVisitPackage>
                                        Se modifica metodo <AttendPackAndUpdCons>
                                        Se crean las siguientes constantes privadas:
                                            <cnuBrillaVisitType>
                                            <nuOrderAssigned>
                                            <nusuccessCausalId>
                                            <nuRegisteredPackage>
                                        Se crean los siguinetes cursores privados:
                                            <cuGetVisitPackageId>
                                            <cuGetVisitOrdersId>
                                        Se crea el subtipo de registro <tyrcOrderIdRow>
                                        Se crea el tipo de tabla <tytbOrders>
  07-09-2013        mmiraSAO214326      Se adiciona <AttendPackAndUpdCons>
  06-09-2013        mmiraSAO216533      Se modifica <createproducOcuppier>.
  06-09-2013        llopezSAO213559     Se modifica createReviewOrderActivity
  06-09-2013        llopez.SAO213520    Se modifica AssignActToNewOrders
  05-09-2013        mmira.SAO214195     Se adiciona <GetCatSubBySuscripc>
  04-09-2013        mmira.SAO212290     Se modifica <createproducOcuppier>
  04-09-2013        llopez.SAO213566    Se modifica LegDelOrder
  04-09-2013        mmira.SAO213637     Se modifica <createproduc>.
  03-09-2013        llopez.SAO213520    Se modifica LegDelOrder
                                        Se adiciona AssignActToNewOrders
  05-12-2016        mmoreno CDC200-564  Cobro de comision publicidad
  ******************************************************************************************/

  -- variable X para debug
  blDebugMode boolean := FALSE;

  -- Declaracion de Tipos de datos publicos

  /*Record de la tabla ld_item_work_order*/

  TYPE rfArticleOtDelivery IS RECORD(
    article_id

    ld_item_work_order.article_id%type,
    state      ld_item_work_order.state%type,
    order_id   ld_item_work_order.order_id%type);

  -- Public type declarations
  TYPE rfOrderp IS RECORD(
    order_id          or_order.order_id%TYPE,
    order_activity_id or_order_activity.order_activity_id%TYPE,
    contractor_id     or_operating_unit.contractor_id%TYPE,
    operating_unit_id or_order.operating_unit_id%TYPE,
    package_id        or_order_activity.package_id%TYPE,
    reception_type_id mo_packages.reception_type_id%TYPE,
    geoloc_abaddress  ab_address.geograp_location_id%TYPE,
    subline_id        ld_article.subline_id%TYPE,
    line_id           ld_subline.Line_Id%TYPE,
    ArticleAct        ld_item_work_order.article_id%TYPE,
    value             ld_item_work_order.value%TYPE,
    amount            ld_item_work_order.amount%TYPE,
    iva               ld_item_work_order.iva%TYPE,
    financier_id      ld_article.financier_id%TYPE,
    concept_id        ld_article.concept_id%TYPE);

  /* Subtipos */
  SUBTYPE styLD_Commissionp IS Ld_Commission%ROWTYPE;

  /* Tipos */
  TYPE tytbLD_Commissionp IS TABLE OF styLD_Commissionp INDEX BY BINARY_INTEGER;

  TYPE tbArticleOtDelivery IS TABLE OF rfArticleOtDelivery;

  -- Declaracion de constantes publicas
  -- Tipo de visita Brilla
  cnuBrillaVisitType constant ld_sales_visit.visit_type_id%type := 1;
  -- Tipo visita Microseguros
  cnuMicroInsuranceType constant ld_sales_visit.visit_type_id%type := 2;
  -- Tipo de visita puntos fijos
  cnuPuntoFijoVisitType constant ld_sales_visit.visit_type_id%type := 3;

  -- Declaracion de variables publicas

  nuPackageId MO_PACKAGES.PACKAGE_ID%TYPE;

  -- Declaracion de funciones y procedimientos publicos

  FUNCTION fsbVersion RETURN VARCHAR2;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : CreateSaleAndReviwOrder
   Descripcion    : Crea las ordenes de venta y revisi?n de documentos.

   Autor          : Eduar Ramos Barragan
   Fecha          : 09/01/2013 09:55:27 a.m.

   Parametros              Descripcion
   ============            ===================
   inuOrder                Numero de la orden.

   Historia de Modificaciones
   Fecha             Autor             Modificacion
   =========         =========         ====================

  ******************************************************************/
  PROCEDURE CreateSaleAndReviwOrder(inupackage_id IN mo_packages.package_id%TYPE);

  /**********************************************************************
    Propiedad intelectual de OPEN International Systems
    Nombre              fblHasCallCenterVisit

    Autor        Andres Felipe Esguerra Restrepo

    Fecha               07-OCT-2013

    Descripcion         Se encarga de validar si el contrato tiene solicitudes de visita
                        de tipo Brilla o Punto fijo cuyo medio por el cual se entero sea
                        Call Center. De ser asi retorna el ID del Canal de Venta Call Center
                        De lo contrario retorna 0

    ***Parametros***
    Nombre        Descripcion
    inuSubscripcId    Contrato
    return              ID del canal de venta Call Center

    ***Historia de Modificaciones***
    Fecha Modificacion        Autor
    .                .
  ***********************************************************************/

  FUNCTION fblHasCallCenterVisit(inuSubscripcId in suscripc.susccodi%type)
    return ld_parameter.numeric_value%type;

  FUNCTION fnuApproveTransferQuota(inupackage IN mo_packages.package_id%TYPE)
    return number;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : cancellationSaleorder
   Descripcion    : Metodo que Obtiene y Anula una OT de venta,
                    a partir d ela solicitud de venta.

   Autor          : Evens Herard Gorut
   Fecha          : 17/04/2013

   Parametros       Descripcion
   ============     ===================

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   17/04/2013       Eherard.SAO156577     Creacion
  ******************************************************************/
  PROCEDURE cancellationSaleorder(inuPackage_id in mo_packages.package_id%type);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : fsbchangearticlesprice
  Descripcion    : Obtener a partir de una solicitud de venta los articulos asociados a una orden de venta y para cada uno de ellos
                   determinar si cambio el precio si el precio vario en al menos un articulo,
                   entonces la respuesta de la funcion debera ser ?Y?. Es decir,
                   que si hubo variacion de precio, en caso contrario la funcion retornara valor ?N?.

  Autor          : AAcuna
  Fecha          : 10/04/2013

  Parametros         Descripcion
  ============   ===================
  inuPackage:    Numero de la solicitud de venta


  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/

  FUNCTION fsbchangearticlesprice(inuPackage in mo_packages.package_id%type)
    RETURN varchar2;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : PayableInvoices
  Descripcion    : Verifica a partir de la solicitud de venta el contrato asociado a esta y a partir
                   del contrato obtener la ultima factura registrada y determinar si se encuentra vencida.
                   Para saber si se encuentra vencida la factura debe cumplir las siguientes condiciones:
                   1. Que la fecha de limite de pago sea menor al sysdate
                   2. Que la cuenta de cobro  asociada a la factura no tenga saldo pendiente
                   La funcion retornara los siguientes valores:
                   Retorna (Y) Si la factura esta vencida
                   Retorna (N) Si se encuentra al dia

  Autor          : AAcuna
  Fecha          : 18/04/2013 11:53:27 a.m.

  Parametros         Descripcion
  ============   ===================
  inuPackage:    Solicitud de venta

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  18/04/2013    AAcuna.SAO139854      Creacion
  ******************************************************************/

  FUNCTION PayableInvoices(inuPackage in mo_packages.package_id%type)

   RETURN varchar2;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : GetOperantingUnitSaleorder
  Descripcion    : retorna 1 si es proveedor y 0 si es contratista de venta.
  Autor          : Alex Valencia Ayola
  Fecha          : 18/04/2013

  Parametros              Descripcion
  ============         ===================
  inupacksale          Identificador de la solicitud.

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================

  ******************************************************************/
  FUNCTION GetOperantingUnitSaleorder(inupacksale mo_packages.package_id%TYPE)
    RETURN PLS_INTEGER;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : fnuIdentifyRules
  Descripcion    : retorna 1 si la configuracion existe y esta seteada con valor o en Y.
                   retorna 0 si la configuracion existe y esta seteada en Null o N.
                   en otro caso retorna Null
  Autor          : Alex Valencia Ayola
  Fecha          : 19/04/2013

  Parametros              Descripcion
  ============         ===================
  inupackagesale       Identificador de la solicitud
  isbColNameSuppl      Columna en ld_suppli_settings a evaluar

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================

  ******************************************************************/
  FUNCTION fnuIdentifyRules(inupackagesale  IN mo_packages.package_id%TYPE,
                            isbColNameSuppl IN VARCHAR2) RETURN PLS_INTEGER;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : LegSaleOrder
    Descripcion    : Legaliza una o varias orde(nes) de venta o
                     entrega

    Autor          : Jonathan Alberto Consuegra
    Fecha          : 19/04/2013

    Parametros       Descripcion
    ============     ===================
    inupackage_id    Identificador de la solicitud
    inuTypeactivity  Tipo de actividad

    Historia de Modificaciones
    Fecha            Autor                Modificacion
    =========       =========             ====================
    19/04/2013      Jconsuegra.SAO139854  Creacion
  ******************************************************************/
  Procedure LegSaleOrder(inupackage_id   mo_packages.package_id%Type,
                         inuTypeactivity ge_items.items_id%type);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : Executerules
  Descripcion    :
  Autor          : Alex Valencia Ayola
  Fecha          : 19/04/2013

  Parametros         Descripcion
  ============   ===================
  inuPackage:    Identificacion de la solicitud

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================

  ******************************************************************/

  PROCEDURE Executerules(inuPackage IN mo_packages.package_id%TYPE);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : fnuVerifacancelot
  Descripcion    : retorna 0 si todas las ordenes de entrega de la solictud
                   se legalizan con causal de fallo en otro caso retorna 1
  Autor          : Alex Valencia Ayola
  Fecha          : 26/04/2013

  Parametros              Descripcion
  ============         ===================
  inupackagesale       Identificador de la solicitud de venta

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================

  ******************************************************************/
  FUNCTION fnuVerifacancelot(inupackagesale IN mo_packages.package_id%TYPE)
    RETURN PLS_INTEGER;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : GetLdparamater
   Descripcion    : Metodo que Obtiene el valor de un parametro teniendo
                    en cuenta el parametro y su tipo.

   Autor          : Karem Baquero Martinez
   Fecha          : 26/04/2013

   Parametros       Descripcion
   ============     ===================

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   26/04/2013       Karbaq.SAO139854      Creacion
  ******************************************************************/
  PROCEDURE GetLdparamater(sbParametr in ld_parameter.parameter_id%type,
                           sbtipo     in varchar2,
                           sbvalue    out ld_parameter.value_chain%type);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : createproduc
  Descripcion    : recibe como parametro la solicitud e ventad, luego identifica la orden de entrega, paso siguiente recorre cada uno de los articulos de la ot de entrega,
                   e identifica los articulos, con los articulos (ld_article) identifica el servicio al cual esta asociado
                   (los articulos pueden tener configuradion brilla o brilla promigas) y preguntara si ya existe
                   para el cliente producto brilla o brilla promigas y si no existe crearlo
  Autor          : AAcuna
  Fecha          : 28/04/2013 09:55:27 a.m.

  Parametros              Descripcion
  ============            ===================
  inuPackage      :        Numero de solicitud
  inuSuscripc     :        Numero de suscripcion
  onuErrorCode    :        Numero de error
  osbErrorMessage :        Mensaje de error

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========         =========         ====================

  ******************************************************************/
  PROCEDURE createproduc(inuPackage      IN mo_packages.package_id%type,
                         inuSuscripc     IN suscripc.susccodi%type,
                         onuErrorCode    OUT number,
                         osbErrorMessage OUT varchar2);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : CreateDelivery
  Descripcion    : Crea ordenes de entrega
  Autor          : Eduar Ramos
  Fecha          : 10/04/2013

  Parametros              Descripcion
  ============         ===================
  inupackage_id         identificador del paquete.


  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================

  ******************************************************************/
  PROCEDURE CreateDelivery(inupackage_id IN mo_packages.package_id%TYPE);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ftbValidateFlowmove
  Descripcion    : Obtiene todas las actividades que se ecuentren en estado stop a partir
                   de una determinada accion y actividad.


  Autor          : AAcuna
  Fecha          : 29/04/2013

  Parametros          Descripcion
  ============     ===================
  inuAccion       Numero de accion
  inuActivity     Numero de actividad


  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  29/04/2013    AAcuna.SAO139854      Creacion
  ******************************************************************/

  PROCEDURE procvalidateFlowmove(inuAccion       in Mo_Wf_Pack_Interfac.Action_Id%type,
                                 inuPackage_Id   in Mo_Wf_Pack_Interfac.Package_Id%type,
                                 onuErrorCode    OUT number,
                                 osbErrorMessage OUT varchar2);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : CreateChargeFNB
  Descripcion    : Crea cargos FNB
  Autor          : Eduar Ramos
  Fecha          : 10/04/2013

  Parametros              Descripcion
  ============         ===================
  inupackage_id         identificador del paquete.


  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================

  ******************************************************************/
  PROCEDURE CreateChargeFNB(inupackage_id IN mo_packages.package_id%TYPE);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : createproducOcuppier
  Descripcion    : recibe como parametro la solicitud e ventad, luego identifica la orden de entrega, paso siguiente
                   recorre cada uno de los articulos de la ot de entrega, e identifica los articulos, con los articulos (ld_article)
                   identifica el servicio al cual esta asociado (los articulos pueden tener configuradion brilla o brilla promigas)
                   y preguntara si ya existe  para el cliente producto brilla o brilla promigas y si no existe crearlo
  Autor          : KBaquero
  Fecha          : 02/05/2013 09:56:27 p.m.

  Parametros              Descripcion
  ============            ===================
  inuPackage              Numero de solicitud
  onuErrorCode            Numero de error
  osbErrorMessage         Mensaje de error

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========         =========         ====================

  ******************************************************************/
  PROCEDURE createproducOcuppier(inuPackage      IN mo_packages.package_id%type,
                                 onuErrorCode    OUT number,
                                 osbErrorMessage OUT varchar2);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : frfgetdelarticlesleg
  Descripcion    : recibe como parametro la solicitud e ventad, luego identifica la orden de entrega, paso siguiente
                   recorre cada uno de los articulos de la ot de entrega, e identifica los articulos, con los articulos (ld_article)
                   identifica el servicio al cual esta asociado (los articulos pueden tener configuradion brilla o brilla promigas)
                   y preguntara si ya existe  para el cliente producto brilla o brilla promigas y si no existe crearlo
  Autor          :
  Fecha          : 02/05/2013 09:56:27 p.m.

  Parametros              Descripcion
  ============            ===================
  inuPackage              Numero de solicitud
  onuErrorCode            Numero de error
  osbErrorMessage         Mensaje de error

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========         =========         ====================

  ******************************************************************/
  FUNCTION frfgetdelarticlesleg(inuPackage in mo_packages.package_id%type,
                                inuorder   in or_order.order_id%type,
                                inuClient  in mo_packages.subscriber_id%type,
                                idtdatemin in date,
                                idtdatemax in date)
    RETURN constants.tyrefcursor;
  /*****************************************************************
  Propiedad intelectual de Open International Systems (coffee).

  Unidad         : GenerateOrderFNB
  Descripcion    : Busca las ot de entrega a partir de la solicitud de venta,
                   al momento de tener todas esas ot de entrega se busca la unidad
                   operativa y a parti de hay se crean dos ordes asociadas a las siguientes
                   actividades:
                   1.ACT_TYPE_PROVIDERS_COM
                   2.ACT_TYPE_DEL_DESC_PROV_FNB

  Autor          : AAcuna
  Fecha          : 03/05/2013 09:56:27 p.m.

  Parametros              Descripcion
  ============            ===================
  inuPackage              Numero de solicitud
  onuError                Numero de error
  osbMessage              Mensaje de error

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========         =========         ====================

  ******************************************************************/
  PROCEDURE GenerateOrderFNB(inuPackage in mo_packages.package_id%type,
                             onuError   OUT number,
                             osbMessage OUT varchar2);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : Propricevariation
  Descripcion    : Verifica si en la tabla de Variacion de precio
                   Existe o no datos para enviar esta informacion al
                   flujo.
  Autor          : Karem Baquero
  Fecha          : 20/05/2013

  Parametros              Descripcion
  ============         ===================
  inupackage_id         identificador del paquete.


  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================

  ******************************************************************/

  FUNCTION fnupricevariation(inupackage_id in mo_packages.package_id%type)
    return number;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : UpdateOrderActivityInst
   Descripcion    : Metodo que realiza la actualizacion del codigo de la
                    Instancia en todos las actividades de Or_order_activity
                    de la ordenes que se generaron de entrega.

   Autor          : KBaquero
   Fecha          : 21/05/2013

   Parametros       Descripcion
   ============     ===================
    Inupackage:       Id. paquete
    Inuorder:         Id. De orden


   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   21/05/2013       KBaquero                 Creacion
  ******************************************************************/

  procedure UpdateOrderActivityInst(Inupackage in mo_packages.package_id%type,
                                    Instance   in OR_ORDER_ACTIVITY.Instance_Id%type);

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : LegDelOrder
   Descripcion    : Este servicio recibe como parametro de entrada, paquete, orden, causal, cadena (contiene las actividades
                    , y realizacion de actividad 1 (si) 0 (no))(id actividad,1(exito) 0 (fallo)|??.), ademas debe realizar la legalizacion
                    de ordenes.
                    La cadena debe tener el siguiente formato:
                    1243|1|1212|1
                    Actividad|Causal|Actividad|Causal
   Autor          : AAcuna
   Fecha          : 21/05/2013

   Parametros       Descripcion
   ============     ===================
   inuOrder:        Numero de la orden
   inuCausal:       Numero de la causal
   isbCad:          Cadena de actividades con su causal

   Historia de Modificaciones

    Fecha             Autor                   Modificacion
   =========        =========             ====================
   21/05/2013       AAcuna                Creacion
  ******************************************************************/

  PROCEDURE LegDelOrder(inuOrder  in or_order.order_id%type,
                        inuCausal in cc_causal.causal_id%type,
                        isbCad    in varchar2);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : createReviewOrderActivity
  Descripcion    : Crea las actividades de tipo instalacion, permitiendo el servicio
                   crear ordenes de diferentes tipos de actividades y ademas permite
                   registrar comentario.

  Autor          : AAcuna
  Fecha          : 23/05/2013

  Parametros              Descripcion
  ============         ===================
  inuOrderActivity     Actividad de la orden
  ionuOrder            Numero de la orden
  inuOrderActivityRev  Actividad

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  23/05/2013      AAcuna              Creacion
  ******************************************************************/

  PROCEDURE createReviewOrderActivity(inuOrderActivity    in ge_items.items_id%type,
                                      ionuOrder           in out or_order.order_id%type,
                                      inuOrderActivityRev in or_order_activity.order_activity_id%type,
                                      inupackage          in mo_packages.package_id%type,
                                      isbComment          in or_order_activity.comment_%type default null,
                                      onuOrderActivity    out or_order_activity.order_activity_id%type);

  PROCEDURE ActivateProduct(inuPackageId in mo_packages.package_id%type);

  /**************************************************************************/
  FUNCTION fnuValApproveTransferQuota(inupackage IN mo_packages.package_id%TYPE)
    RETURN PLS_INTEGER;

  /***************************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : GetCatSubBySuscripc
  Descripcion    : Obtiene la categoria y subcategoria del contrato.
  ***************************************************************************/
  PROCEDURE GetCatSubBySuscripc(inuSuscripc in suscripc.susccodi%type,
                                onuCategory out categori.catecodi%type,
                                onuSubcateg out subcateg.sucacodi%type);

  /***************************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : GetParsedAddrById
  Descripcion    : Unidad         : GetParsedAddrById
  Descripcion    : Obtiene la direccion parseada y la ubicacion geografica a
                  partir del identificador de la direccion.
  ***************************************************************************/
  PROCEDURE GetParsedAddrById(inuAddressId  in ab_address.address_id%type,
                              onuParsedAddr out ab_address.address_parsed%type,
                              onuGeoLoc     out ab_address.geograp_location_id%type);

  /***************************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         :    AttendPackAndUpdCons
  Descripcion    :    Atiende la venta y actualiza el estado del consecutivo.
  ***************************************************************************/
  PROCEDURE AttendPackAndUpdCons(inuPackageId in mo_packages.package_id%type);

  /***************************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         :    fnuValOperUnitIsSupplierFNB
  Descripcion    :    Obtiene la clasificacion de la unidad operativa de la
                      orden de venta.
                      Retorna 1 si la clasificacion es 70 - Proveedor FNB.
                      Retorna 0 de lo contrario.
  ***************************************************************************/
  FUNCTION fnuValOperUnitIsSupplierFNB(inupacksale mo_packages.package_id%TYPE)
    RETURN PLS_INTEGER;

  PROCEDURE AttendVisitPackage(inuSalePackage IN mo_packages.package_id%type);

  PROCEDURE CounterPayment(inuPackageId in mo_packages.package_id%type);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : fnuValidaGranSuper
  Descripcion    : retorna 1 si el contratista conectado es el EXITO.
                 retorna 0 en caso contrario

  Autor          : Jorge Alejandro Carmona Duque
  Fecha          : 13/11/2013

  Parametros              Descripcion
  ============         ===================
  inupackagesale       Identificador de la solicitud

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================

  ******************************************************************/
  FUNCTION fnuValidaGranSuper(inupackagesale IN mo_packages.package_id%TYPE)
    RETURN PLS_INTEGER;

  /*****************************************************************
  Unidad         : createprodByExito
  Descripcion    : crea el producto desde el Job del exito
  ******************************************************************/
  PROCEDURE createprodByExito(inuPackage IN mo_packages.package_id%type);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : fnuValLegDelOrder
  Descripcion    : retorna 1 si por lo menos una de las ordenes de entrega de
                   la solicitud se encuentra registrada o asignada.
                   retorna 0 en caso contrario, es decir que todas las ordenes
                   se encuentran legalizadas (FLOTE).

  Autor          : Jorge Alejandro Carmona Duque
  Fecha          : 11/04/2014

  Parametros              Descripcion
  ============         ===================
  inupackagesale       Identificador de la solicitud

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  11/04/2014      JCarmona.3361       Creacion.
  ******************************************************************/
  FUNCTION fnuValLegDelOrder(inuPackageId in mo_packages.package_id%type)
    return number;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : ApplyCouponPP
   Descripcion    : Metodo que Aplica el saldo a favor generado
                    por el pago del cupon PP.

   Autor          : Diego Armando Arevalo Gomez
   Fecha          : 21/05/2013

   Parametros       Descripcion
   ============     ===================

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   26/05/2014       darevalo.3638       Creacion.
  ******************************************************************/
  PROCEDURE ApplyCouponPP(inuPackage_id in mo_packages.package_id%type);

  /*****************************************************************
  PROPIEDAD INTELECTUAL DE PETI (C).

  UNIDAD         : commentDelOrder
  DESCRIPCION    : Procedimiento para registrar la observacion de la orden de entrega
  AUTOR          : Katherine Cienfuegos
  RNP            : 156
  FECHA          : 12/08/2014

  PARAMETROS              DESCRIPCION
  ============         ===================
  inuSubscription     codigo del suscriptor

  FECHA             AUTOR             MODIFICACION
  =========       =========           ====================
  12/08/2014      KCienfuegos.RNP156    Creacion.
  ******************************************************************/

  PROCEDURE CommentDelOrder(inuOrder   in or_order.order_id%type,
                            isbComment in or_order_comment.order_comment%type);

  /*****************************************************************
  Propiedad intelectual de PETI (c).


  Unidad         : CreateInstallationOrder
  Descripcion    : Crea ordenes de instalacion de gasodomesticos FNB.
  Autor          : KCienfuegos
  Fecha          : 10/10/2014

  Parametros              Descripcion
  ============         ===================
  inupackage_id         identificador del paquete.
  inuOrdActivityId      id de actividad
  inuOperatUnitId       id de la unidad operativa

  Historia de Modificaciones
  Fecha             Autor                Modificacion
  =========       =========             ====================
  10-10-2014    KCienfuegos.RNP1179    Creacion.
  ******************************************************************/
  PROCEDURE CreateInstallationOrder(inupackage_id    IN mo_packages.package_id%TYPE,
                                    inuOrdActivityId IN or_order_activity.order_activity_id%TYPE,
                                    inuOperatUnitId  IN or_operating_unit.operating_unit_id%TYPE);

  /*****************************************************************
  PROPIEDAD INTELECTUAL DE PETI (C).

  UNIDAD         : registerInvoice
  DESCRIPCION    : Procedimiento para registrar la informaci?n de la factura.
  AUTOR          : Katherine Cienfuegos
  RNP            : 1224
  FECHA          : 13/01/2015

  PARAMETROS            DESCRIPCION
  ============      ===================
  inuOrder           C?digo de la orden

  FECHA             AUTOR             MODIFICACION
  =========       =========           ====================
  13/01/2015    KCienfuegos.RNP1224    Creaci?n.
  ******************************************************************/
  PROCEDURE registerInvoice(inuOrder   in or_order.order_id%type,
                            isbInvoice in ldc_invoice_fnb_sales.invoice%type);

  /*****************************************************************
  PROPIEDAD INTELECTUAL DE PETI (C).

  UNIDAD         : registerDelivDate
  DESCRIPCION    : Procedimiento para registrar la fecha de entrega del objeto de venta (si aplica).
                   Es utilizado desde el .NET Fifap.
  AUTOR          : KCienfuegos
  ARANDA         : 5737
  FECHA          : 20/01/2015

  PARAMETROS            DESCRIPCION
  ============      ===================
  inuPackageId       C?digo de la orden
  idtDelivDate       Fecha de entrega

  FECHA             AUTOR             MODIFICACION
  =========       =========           ====================
  20/01/2015    KCienfuegos.ARA5737    Creaci?n.
  ******************************************************************/
  PROCEDURE registerDelivDate(inuPackageId in or_order_activity.package_id%type,
                              idtDelivDate in mo_packages.request_date%type);
  /*  PROCEDURE createproducReal(inuPackage      IN mo_packages.package_id%type,
  iblProdOccupier in boolean,
  onuProductId    out pr_product.product_id%type,
  inuSubscriberId in ge_subscriber.subscriber_id%type,
  onuErrorCode    OUT number,
  osbErrorMessage OUT varchar2) ;    */

  /*******************************************************************
  Propiedad Intelectual de SINCECOMP (C).

  Procedimiento : ActEstacortyComp
  Descripcion : Actualiza el estado de corte y el componente de acuerdad a una solicitud de venta

  Autor       : Sebastian Tapias || 200-1306
  Fecha       : 02-06-2017

  ---***Variables de Entrada***---
  inuPackage
  --------------------------------
                         Historia de Modificaciones

          Fecha               Autor                Modificacion
        =========           =========          ====================
  ********************************************************************/
  PROCEDURE ActEstacortyComp(inuPackage in mo_packages.package_id%type);
END LD_boflowFNBPack;
/
CREATE OR REPLACE PACKAGE BODY LD_BOFLOWFNBPACK IS
  /************************************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : LD_boflowFNB
  Descripcion    : Paquete con los servicios del flujo de venta.
  Autor          : Eduar Ramos Barragan
  Fecha          : 09/01/13 09:55:27 a.m.

  Historia de Modificaciones
  Fecha        Autor                Modificacion
  =========    =================    ================================================
  01-03-2018   Sebastian Tapias     REQ.2001695 se modifica el servicio <<frfgetdelarticlesleg>>
  07-06-2017    Jorge Valiente          CASO 200-1164: Se modifico la logica del cursor cuExiteSerguroVoluntario
                                                       para validar la existencia del articulo directamente con la
                                                       tabla LD_ARTICLE
                                                       Se modifico la logica del servicio frfgetdelarticlesleg con relacion
                                                       a la forma de obtener las ordenes de entrega permitiendo mostrar
                                                       ordenes de serguro volunatio utilizadas en al venta BRILLA
                                                       Esta modificacion fue solicitada por la funcionaria Julia Gonzalez
  02-06-2017    Sebastian Tapias        Caso 200-1306, se agrega servicio ActEstacortyComp,
                                        este se llama al final del proceso GenerateOrdersByArt.
  16-05-2017    Jorge Valiente          CASO 200-1164
  08-05-2017    STapias.[200-1268]      Cambio de alcance, se modifica <<GenerateOrdersByArt>>
  26-04-2017    STapias.[200-564]       Cambio de alcance, se modifica <<GenerateOrdersByArt>>
  08-08-2016    KBaquero.Caso200-311    Se modifica el metodo<<createproducReal>>
  02-07-2015    KCienfuegos.ARA7715     Se modifica el metodo <<frfgetdelarticlesleg>>
  23-06-2015    KCienfuegos.ARA7715     Se modifica el metodo <<frfgetdelarticlesleg>>
  11-06-2015    ABaldovino [7810]       Se modifica el metodo <<frfgetdelarticlesleg>>
  08-05-2015    KCienfuegos.SAO312817   Se modifica el metodo <<AttendPackAndUpdCons>>
  22-04-2014    SLemus.ARA7049          Se modifica el metodo <<CreateDelivOrderCharg>>
  20-04-2015    ABaldovino [ARA 6286]   Se modifica el m?todo <<frfgetdelarticlesleg>>
  05-03-2015    Llozada [ARA 6099]      Se modifica el m?todo <<frfgetdelarticlesleg>>
  20-01-2015    KCienfuegos.ARA5737     Se crea m?todo <<registerDelivDate>>
  09-01-2015    KCienfuegos.RNP1224     Se modifica el m?todo <<frfgetdelarticlesleg>>
                                        Se crea m?todo        <<registerInvoice>>
  19-12-2014    Llozada [NC 4303]       Se modifica el m?todo <<cancellationSaleorder>>
  04-12-2014    KCienfuegos.NC4068      Se modifica metodos <<AssignActToNewOrders>>
  02-12-2014    KCienfuegos.NC3012      Se modifica metodo <<cancellationSaleorder>>
  26-11-2014    KCienfuegos.NC4059      Se modifica metodo <<ActivateProduct>>
  13-11-2014    KCienfuegos.NC2860      Se modifica metodo <<createproducReal>>
  12-11-2014    KCienfuegos.NC3686      Se modifica metodo <<ActivateProduct>>
  28-10-2014    KCienfuegos.RNP1808     Se modifica metodo <<createdelivery>>
  18-10-2014    KCienfuegos.RNP2860     Se modifica metodo <<createproducOcuppier>>
  10-10-2014    KCienfuegos.RNP1179     Se modifica metodo <<createdelivery>>
  10-10-2014    KCienfuegos.RNP1179     Se crea metodo <<CreateInstallationOrder>>
  01-10-2014    KCienfuegos.RNP1810     Se modifica metodo <<fnuValidaGranSuper>>
  05-09-2014    AEcheverry.4769         Se modifica  <<cancellationSaleorder>>
  21-08-2014    KCienfuegos.NC1489      Se modifica metodo <<AttendVisitPackage>>
  21-08-2014    KCienfuegos.NC1664      Se modifica metodo <<RegChargeFinancing>>
  20-08-2014    KCienfuegos.NC1555      Se modifica metodo <<Executerules>>
  19-08-2014    KCienfuegos.RNP156      Se crea el metodo <<commentDelOrder>>
                                        Se modifica el metodo <<LegSaleOrder>>
  15-08-2014    Aecheverrry.4279        Se modifica el metodo <<cancellationSaleorder>>
  02-08-2014    KCienfuegos.NC629       Se modifica metodo <<frfgetdelarticlesleg>>
  03-07-2014    AEcheverry.4074         Se modifica <<CreateDelivOrderCharg>>
  16-06-2014    aesguerra.3649      Se modifica <<GenerateOrderFNB>> y <<LegDelOrder>>
                        y se crea <<GenerateOrdersByArt>>
  13-06-2014    aesguerra.3853      Se modifica <<CreateDelivOrderCharg>>
  26-05-2014    darevalo.3638      Se adiciona metodo <<ApplyCouponPP>>
  26-05-2014    darevalo.3638      Se modifica <<createCupon>>
                        y <<cancellationSaleorder>>
  11/04/2014    JCarmona.3361      Se adiciona metodo <<fnuValLegDelOrder>>
  10-04-2014    aesguerra.3374      Se modifica <<cancellationSaleorder>>
                        y <<CreateDelivOrderCharg>>
  08-04-2014    aesguerra.3360      Se modifica <<createproducReal>>
  04-04-2014    AEcheverry.SAO237025  Se modifican los metodos
                        <<CreateDelivOrderCharg>>
                        <<createCupon>> y
                        <<cancellationSaleorder>>
  01/04/2014    AEcheverrySAO236627    Se modifica <<LegSaleOrder>>
  25-03-2014    AEcheverry.SAO236047  Se modifica <<CreateDelivOrderCharg>>
  17-03-2014    AEcheverry.SAO235311  Se modifica  <<CreateDelivOrderCharg>>
  25-02-2014    eurbano.SAO234145    Se modifica <<CreateDelivOrderCharg>>
  06-02-2013    AEcheverrySAO232141    Se modifica <<createproducReal>>
  25-Ene-2014    AEcheverrySAO230811    Se modifica  <<CreateChargeFNB>>
  15-01-2013    AEcheverrySAO229596    Se modifican los servicios <<createproducreal>> y
                        <<createproducOcuppier>>
  10-12-2013    JCarmona.SAO226940    Se modifica el metodo <<AttendVisitPackage>>
  10-12-2013    JCarmona.SAO227029    Se modifica el metodo <<fnuVerifacancelot>>
  09-12-2013    JCarmona.SAO226625    Se modifica el metodo <<CreateDelivOrderCharg>>
  05-12-2013    JCarmona.SAO226159    Se modifica el metodo <<AttendVisitPackage>>
  22-11-2013    hjgomez.SAO224494    Se modifica <<createproducReal>>
  21-11-2013    hjgomez.SAO224456    Se modifica <cancellationSaleorder>
  20-11-2013    hjgomez.SAO223711    Se modifica <CreateDelivOrderCharg>
  12-11-2013    anietoSAO223132      1 - Se modifica el paquete para eliminar el codigo
                        comentado e inutil.
  23-10-2013    jrobayo.SAO221150    Se modifica el metodo <ActivateProduct>
  07-10-2013    LDiuza.SAO218287    Se modifica el metodo <GenerateOrderFNB>
  06-10-2013    LDiuza.SAO218424    Se adiciona metodo privado <AttendVisitPackage>
                      Se modifica metodo <AttendPackAndUpdCons>
                      Se crean las siguientes constantes privadas:
                        <cnuBrillaVisitType>
                        <nuOrderAssigned>
                        <nusuccessCausalId>
                        <nuRegisteredPackage>
                      Se crean los siguinetes cursores privados:
                        <cuGetVisitPackageId>
                        <cuGetVisitOrdersId>
                      Se crea el subtipo de registro <tyrcOrderIdRow>
                      Se crea el tipo de tabla <tytbOrders>
  07-09-2013    mmiraSAO214326      Se adiciona <AttendPackAndUpdCons>
  06-09-2013    mmiraSAO216533      Se modifica <createproducOcuppier>.
  06-09-2013    llopezSAO213559      Se modifica createReviewOrderActivity
  06-09-2013    llopez.SAO213520    Se modifica AssignActToNewOrders
  05-09-2013    mmira.SAO214195      Se adiciona <GetCatSubBySuscripc>
  04-09-2013    mmira.SAO212290      Se modifica <createproducOcuppier>
  04-09-2013    llopez.SAO213566    Se modifica LegDelOrder
  04-09-2013    mmira.SAO213637      Se modifica <createproduc>.
  03-09-2013    llopez.SAO213520    Se modifica LegDelOrder
                      Se adiciona AssignActToNewOrders
  ******************************************************************************************/
  /* Declaracion de constantes privados */

  csbVersion CONSTANT VARCHAR2(20) := 'OSF-2019';

  csbCallCenterParameter constant ld_parameter.parameter_id%type := 'REF_MOD_CALL_CENTER';
  csbCallCenterReceType  constant ld_parameter.parameter_id%type := 'SALE_CALL_CENT';
  --  causa de cargo de venta fnb
  cnuCause       Constant ld_parameter.numeric_value%type := DALD_Parameter.fnuGetNumeric_Value('COD_CAUSA_CARG_VENTA_FNB');
  cnuSupplierFNB CONSTANT ld_parameter.numeric_value%TYPE := Dald_parameter.fnuGetNumeric_Value('SUPPLIER_FNB');

  /*Carga de parametros*/

  /*Actividad de entrega articulos Brilla*/
  cnuDelivActiv constant ld_parameter.numeric_value%type := ld_boconstans.cnuAct_Type_Del_FNB;

  --Estado Entregado de la actividad
  csbEntregado   constant varchar2(3) := 'RE';
  csbEnProcesoAD constant varchar2(2) := 'EP';

  --Constante de estado de la orden
  nuOrderAssigned CONSTANT NUMBER := 5;
  -- Causal de legalizacion exitosa
  nusuccessCausalId CONSTANT NUMBER := 1;

  --Estado de solicitud Registrada
  nuRegisteredPackage CONSTANT NUMBER := 13;
  nuOrderGl or_order.order_id%type;

  /* Declaracion de funciones y procedimientos */

  ------------------------------------------------------------------------
  --  Cursores
  ------------------------------------------------------------------------
  --  Obtiene la cuenta asociada a la factura
  CURSOR cuAccount(inuPackage in mo_packages.package_id%type) IS
    SELECT /*+ index(pp IDX_MO_PACKAGE_PAYMENT)
                                                                            index(mp IDX_MO_MOTIVE_PAYMENT_05)
                                                                            index(cuencobr IDXCUCO_RELA)  */
     cucocodi
      FROM mo_package_payment pp, mo_motive_payment mp, cuencobr
     WHERE pp.package_id = inuPackage
       AND pp.package_payment_id = mp.package_payment_id
       AND mp.account = cucofact
       AND rownum = 1;

  CURSOR cuValTotaVen(inuPackage mo_packages.package_id%type, inuDelivActiv or_order_activity.activity_id%type) IS
    SELECT nvl(SUM(w.amount * w.value), 0) + nvl(SUM(w.iva), 0) valor
      FROM ld_item_work_order w, or_order_activity oa
     WHERE oa.package_id = inuPackage
       AND oa.activity_id = cnuDelivActiv
       AND w.order_activity_id = oa.order_activity_id;

  CURSOR cuGetVisitPackageId(nuSubscriptionId IN suscripc.susccodi%type) IS
    SELECT p.package_id
      FROM mo_packages p, ld_sales_visit sv
     WHERE p.package_id = sv.package_id
       AND p.subscription_pend_id = nuSubscriptionId
       AND p.motive_status_id = nuRegisteredPackage
       AND sv.visit_type_id in (cnuBrillaVisitType, cnuPuntoFijoVisitType);

  CURSOR cuGetVisitPackId(nuSubscriptionId IN suscripc.susccodi%type, nuCallCenterId in ld_parameter.numeric_value%type) IS
    SELECT count(1)
      FROM mo_packages p, ld_sales_visit sv
     WHERE p.package_id = sv.package_id
       AND p.subscription_pend_id = nuSubscriptionId
       AND p.motive_status_id = nuRegisteredPackage
       AND p.refer_mode_id = nuCallCenterId
       AND sv.visit_type_id in (cnuBrillaVisitType, cnuPuntoFijoVisitType);

  CURSOR cuGetVisitOrdersId(nuVisitPackageId IN mo_packages.package_id%type) IS
    SELECT DISTINCT oa.order_id
      FROM or_order_activity oa
     WHERE oa.package_id = nuVisitPackageId;

  CURSOR cuOrdersToLegalize(inuSubscriptionId suscripc.susccodi%type, isbParamAct ld_parameter.value_chain%type, inuOperUnitId OR_operating_unit.operating_unit_id%type) IS
    SELECT distinct oa.order_id
      FROM OR_order o, or_order_activity oa, ld_sales_visit sv
     WHERE o.order_id = oa.order_id
       AND sv.package_id = oa.package_id
       AND sv.visit_type_id in (1, 3)
       AND instr(',' || isbParamAct || ',', ',' || oa.activity_id || ',') > 0
       AND subscription_id = inuSubscriptionId
       AND o.order_status_id not in (OR_BOConstants.cnuORDER_STAT_CLOSED,
            OR_BOConstants.cnuORDER_STAT_CANCELED)
       AND (o.operating_unit_id = inuOperUnitId OR inuOperUnitId IS null)
    union
    SELECT distinct oa.order_id
      FROM OR_order o, or_order_activity oa
     WHERE o.order_id = oa.order_id
       AND oa.package_id IS null
       AND instr(',' || isbParamAct || ',', ',' || oa.activity_id || ',') > 0
       AND subscription_id = inuSubscriptionId
       AND o.order_status_id not in (OR_BOConstants.cnuORDER_STAT_CLOSED,
            OR_BOConstants.cnuORDER_STAT_CANCELED)
       AND (o.operating_unit_id = inuOperUnitId OR inuOperUnitId IS null);

  /* Declaracion de Tipos de datos privados */
  SUBTYPE tyrcOrderIdRow IS cuOrdersToLegalize%rowtype;
  TYPE tytbOrders IS TABLE OF tyrcOrderIdRow INDEX BY BINARY_INTEGER;

  FUNCTION fsbVersion RETURN VARCHAR2 IS
  BEGIN
    RETURN csbVersion;
  END;

  /**********************************************************************
    Propiedad intelectual de OPEN International Systems
    Nombre              ajustaCuenta

    Autor        Andres Felipe Esguerra Restrepo

    Fecha               06-may-2014

    Descripcion         Creado para cuadrar las cuentas de cobro despues de crearles notas.
                        Esto debido a que cuando se estan generando las notas, las cuentas
            estan quedando descuadradas

    ***Parametros***
    Nombre        Descripcion
  inuCuenta           Cuenta de cobro a ajustar
  ***********************************************************************/
  PROCEDURE ajustaCuenta(inucuenta in cuencobr.cucocodi%type) is

    nuError NUMBER;
    sbError VARCHAR2(2000);
    nuIndex number;

    rcCargos       cargos%ROWTYPE := NULL;
    varcucovato    cuencobr.cucovato%type;
    varCUCOVAAB    cuencobr.cucovaab%type;
    varcucovafa    cuencobr.cucovafa%type;
    varcucoimfa    cuencobr.cucoimfa%type;
    inuConcSaFa    cargos.cargconc%type default NULL;
    inuSalFav      pkBCCuencobr.styCucosafa Default pkBillConst.CERO;
    isbTipoProceso cargos.cargtipr%type Default pkBillConst.POST_FACTURACION;
    idtFechaCargo  cargos.cargfecr%type Default sysdate;

    CURSOR cuDatos(inuCucocodi in cuencobr.cucocodi%type) IS
      SELECT cargos.cargcuco CUENTA,
             cargos.cargnuse PRODUCTO,
             NVL(SUM(DECODE(cargsign,
                            'DB',
                            (cargvalo),
                            'CR',
                            - (cargvalo),
                            0)),
                 0) cucovato,
             NVL(SUM(DECODE(cargsign,
                            'PA',
                            cargvalo,
                            'AS',
                            cargvalo,
                            'SA',
                            -cargvalo,
                            0)),
                 0) cucovaab,
             NVL(SUM(DECODE(cargtipr,
                            'P',
                            0,
                            DECODE(INSTR('DF-CX-',
                                         LPAD(SUBSTR(cargdoso, 1, 3), 3, ' ')),
                                   0,
                                   DECODE(cargsign,
                                          'DB',
                                          (cargvalo),
                                          'CR',
                                          - (cargvalo),
                                          0),
                                   0))),
                 0) cucovafa,
             NVL(SUM(DECODE(cargtipr,
                            'P',
                            0,
                            DECODE(INSTR('DF-CX-',
                                         LPAD(SUBSTR(cargdoso, 1, 3), 3, ' ')),
                                   0,
                                   CASE
                                     WHEN concticl = pkBillConst.fnuObtTipoImp THEN
                                      DECODE(cargsign, 'DB', cargvalo, 'CR', -cargvalo, 0)
                                     ELSE
                                      0
                                   END,
                                   0))),
                 0) cucoimfa,
             NVL(SUM(DECODE(SIGN(cargvalo), -1, 1, 0)), 0) cucocane
        FROM cargos, concepto
       WHERE cargcuco = inuCucocodi
         AND cargconc = conccodi
         AND cargsign IN ('DB', 'CR', -- Facturado
              'PA', -- Pagos
              'RD', 'RC', 'AD', 'AC', -- Reclamos
              'AS', 'SA', 'ST', 'TS' -- Saldo favor
             )
       GROUP BY cargos.cargcuco, cargos.cargnuse;

    v_datos cuDatos%rowtype;

  BEGIN

    pkerrors.setapplication(CC_BOConstants.csbCUSTOMERCARE);

    open cuDatos(inucuenta);
    fetch cuDatos
      into v_datos;
    close cuDatos;

    SELECT CUENCOBR.cucovato,
           CUENCOBR.CUCOVAAB,
           CUENCOBR.cucovafa,
           CUENCOBR.cucoimfa
      INTO varcucovato, varCUCOVAAB, varcucovafa, varcucoimfa
      FROM CUENCOBR
     WHERE CUCOCODI = v_datos.CUENTA;

    if (v_datos.cucovato != varcucovato OR v_datos.cucovaab != varCUCOVAAB OR
       v_datos.cucoimfa != varcucoimfa) then

      ut_trace.SetOutPut(ut_trace.cnuTRACE_OUTPUT_DB);
      ut_trace.SetLevel(2);

      ut_trace.trace('SDFGHK Cucocodi: ' || v_datos.cucovato, 1);

      ut_trace.trace('cucovato ' || v_datos.cucovato || '/' || varcucovato ||
                     ' - Cucovaab ' || v_datos.cucovaab || '/' ||
                     varCUCOVAAB,
                     2);

      UPDATE cuencobr
         SET cucovato = NVL(v_datos.cucovato, 0),
             cucovaab = NVL(v_datos.cucovaab, 0),
             cucovafa = NVL(v_datos.cucovafa, 0),
             cucoimfa = NVL(v_datos.cucoimfa, 0)
       WHERE cucocodi = v_datos.CUENTA;

      ut_trace.trace('Despues updateCuenta: ' || v_datos.CUENTA || ' - ' ||
                     pktblcuencobr.fnugetcucovato(v_datos.CUENTA, 0) ||
                     ' - ' ||
                     pktblcuencobr.fnugetcucovaab(v_datos.CUENTA, 0),
                     2);

      pkAccountMgr.AdjustAccount(v_datos.CUENTA,
                                 v_datos.PRODUCTO,
                                 47,
                                 1,
                                 rcCargos.cargsign,
                                 rcCargos.cargvalo);

      ut_trace.trace('Despues ajuste Cuenta: ' || v_datos.CUENTA || ' - ' ||
                     pktblcuencobr.fnugetcucovato(v_datos.CUENTA, 0) ||
                     ' - ' ||
                     pktblcuencobr.fnugetcucovaab(v_datos.CUENTA, 0),
                     2);

      pkAccountMgr.GenPositiveBal(v_datos.CUENTA,
                                  inuConcSaFa,
                                  inuSalFav,
                                  isbTipoProceso,
                                  idtFechaCargo);

      ut_trace.trace('Despues GenPosBal Cuenta: ' || v_datos.CUENTA ||
                     ' - ' ||
                     pktblcuencobr.fnugetcucovato(v_datos.CUENTA, 0) ||
                     ' - ' ||
                     pktblcuencobr.fnugetcucovaab(v_datos.CUENTA, 0),
                     2);

      ut_trace.SetLevel(0);

      pkAccountMgr.ApplyPositiveBalServ(v_datos.PRODUCTO);

    END if;

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END ajustaCuenta;

  FUNCTION fblHasCallCenterVisit(inuSubscripcId in suscripc.susccodi%type)
    return ld_parameter.numeric_value%type IS

    nuCallCenterParam    ld_parameter.numeric_value%type;
    nuCallCenterReceType ld_parameter.numeric_value%type;
    nuCount              number;
    nuReturn             number := 0;

  BEGIN

    ut_trace.trace('Inicio LD_boflowFNBPack.fblHasCallCenterVisit', 10);

    if dald_parameter.fblExist(csbCallCenterParameter) then

      nuCallCenterParam := dald_parameter.fnuGetNumeric_Value(csbCallCenterParameter);

      if nuCallCenterParam IS not null then

        if cuGetVisitPackId%isopen then
          close cuGetVisitPackId;
        END if;

        open cuGetVisitPackId(inuSubscripcId, nuCallCenterParam);
        fetch cuGetVisitPackId
          INTO nuCount;
        close cuGetVisitPackId;

        if nuCount > 0 then

          if dald_parameter.fblExist(csbCallCenterReceType) then

            nuCallCenterReceType := dald_parameter.fnuGetNumeric_Value(csbCallCenterReceType);

            if nuCallCenterReceType IS not null then

              nuReturn := nuCallCenterReceType;

            else

              ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                               'El parametro ' ||
                                               csbCallCenterReceType ||
                                               ' no tiene valor numerico registrado');

            END if;
          else

            ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                             'El parametro ' ||
                                             csbCallCenterReceType ||
                                             ' no existe');

          END if;

        END if;

      else

        ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                         'El parametro ' ||
                                         csbCallCenterParameter ||
                                         ' no tiene valor numerico registrado');

      END if;

    else
      ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                       'El parametro ' ||
                                       csbCallCenterParameter ||
                                       ' no existe');
    END if;

    ut_trace.trace('Fin LD_boflowFNBPack.fblHasCallCenterVisit', 10);

    return nuReturn;

  END fblHasCallCenterVisit;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : CreateSaleAndReviwOrder
  Descripcion    : Crea orden de venta y revision de documento
  Autor          : Eduar Ramos
  Fecha          : 10/04/2013

  Parametros              Descripcion
  ============         ===================
  isbIdentification
  onuErrCod            Codigo de error
  osbErrMsg            Mensaje de error

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  21/05/2013      KBaquero            Se le agrega la actualizacion del
                                      coodeudor siempre y cuando se haya registrado
                                      Y para colocarle el llamado al proceso de variacion
                                      de precio.
  ******************************************************************/
  PROCEDURE CreateSaleAndReviwOrder(inupackage_id IN mo_packages.package_id%TYPE)

   IS
    rgmo_packages damo_packages.styMO_packages;

    tbItems         dald_non_ban_fi_item.tytbld_non_ban_fi_item;
    rcSaleRequest   dald_non_ba_fi_requ.styLD_non_ba_fi_requ;
    nuIndex         number;
    nuOrder         or_order.order_id%type;
    nuOrderActivity or_order_activity.order_activity_id%type;
    nuRevOrder      or_order.order_id%type;
    nuActivityRev   or_order_activity.order_activity_id%type;
    tbSuppliSett    dald_suppli_settings.tytbLD_suppli_settings;
    nuerror         ge_message.message_id%type;
    sbmessage       ge_message.description%type;
    nuCupon         number;
    rcld_promisory  dald_promissory.tytbLD_promissory;
    nupromiid       ld_promissory.promissory_id%type;
    sbdebname       ld_promissory.debtorname%type;
    sbidentif       ld_promissory.identification%type;
    nuphone         ld_promissory.Propertyphone_Id%type;
    sbmail          ld_promissory.Email%type;
    nuitipident     ld_promissory.Ident_Type_Id%type;
    sblastname      ld_promissory.last_name%type;
    Inusubs         ge_subscriber.subscriber_id%type;
    sbAddress       ld_promissory.address_id%type;
    dtBirth         ld_promissory.birthdaydate%type;
    sbGender        ld_promissory.gender%type;
    sbCvlSt         ld_promissory.civil_state_id%type;
    sbProf          ld_promissory.occupation%type;
    sbSchool        ld_promissory.school_degree_%type;

    /*Actualizacion de coodeudor*/
    frfpromisoy_id constants.tyrefcursor;
    recpromiso     dald_promissory.tytbLD_promissory;
    nuIndexpro     number;
    nuContOt       number := 0;
    /*Proceso de variacion de precio*/
    sbflag         varchar2(1);
    nuContractorid ge_contratista.id_contratista%type;
    sbComment      ldc_fnb_comment.sale_comment%type;

  BEGIN

    --identifica registro del paquete
    rgmo_packages := damo_packages.frcGetRecord(inuPackage_Id => inupackage_id);

    --identifica la fecha de venta
    rcSaleRequest  := dald_non_ba_fi_requ.frcGetRecord(inupackage_id);
    nuContractorid := daor_operating_unit.fnuGetContractor_Id(rgmo_packages.operating_unit_id);

    -- se valida la parametrizacion de la unidad
    if (nuContractorId IS null) then
      ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                       'No posee configuracion para el proveedor');
    END if;

    dald_suppli_settings.getRecords('ld_suppli_settings.supplier_id = ' ||
                                    nuContractorid,
                                    tbSuppliSett);
    /*Obtiene los items de la solicitud*/
    dald_non_ban_fi_item.getRecords(' Non_Ba_Fi_Requ_Id = ' ||
                                    inupackage_id ||
                                    ' ORDER BY Supplier_Id ',
                                    tbItems);

    if tbSuppliSett.count > 0 then

      /*Recorre los items*/
      nuIndex := tbItems.first;

      while nuIndex is not null loop

        nuOrderActivity := null;
        ld_bononbankfinancing.createSaleOrderActivity(tbItems(nuIndex)
                                                      .Non_Ban_Fi_Item_Id,
                                                      nuOrder,
                                                      nuOrderActivity);

        nuIndex := tbItems.next(nuIndex);
      end loop;
      ut_trace.trace('Creo orden de venta:' || nuOrder, 10);
      or_boprocessorder.ProcessOrder(nuOrder,
                                     null,
                                     rgmo_packages.operating_unit_id,
                                     null,
                                     FALSE,
                                     NULL,
                                     NULL);

      ld_bononbankfinancing.createReviewOrderActivity(nuOrderActivity,
                                                      nuRevOrder,
                                                      nuActivityRev);

    else

      ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                       'No posee configuracion para el proveedor');

    end if;

    /*Se verifica si se actualiza el coodeudor*/

    frfpromisoy_id := Ld_BcflowFNBPack.frfgetldpromisory(inupackage_id);

    FETCH frfpromisoy_id BULK COLLECT
      INTO recpromiso;
    CLOSE frfpromisoy_id;

    nuIndexpro := recpromiso.FIRST;

    WHILE nuIndexpro IS NOT NULL LOOP
      nuContOt := nuContOt + 1;

      nupromiid := recpromiso(nuIndexpro).promissory_id;

      sbdebname := dald_promissory.fsbGetDebtorname(nupromiid, null);

      sbidentif := dald_promissory.fsbGetIdentification(nupromiid, null);

      nuphone := dald_promissory.fnuGetPropertyphone_Id(nupromiid, null);

      sbmail := dald_promissory.fsbGetEmail(nupromiid, null);

      nuitipident := dald_promissory.fnuGetIdent_Type_Id(nupromiid, null);

      sblastname := dald_promissory.fsbGetLast_Name(nupromiid, null);

      /*variables adicionales para creacion del cliente*/

      sbAddress := dald_promissory.fnuGetAddress_Id(nupromiid, null);
      dtBirth   := dald_promissory.fdtGetBirthdaydate(nupromiid, null);
      sbGender  := dald_promissory.fsbGetGender(nupromiid, null);
      sbCvlSt   := dald_promissory.fnuGetCivil_State_Id(nupromiid, null);
      sbProf    := dald_promissory.fsbGetOccupation(nupromiid, null);
      sbSchool  := dald_promissory.fnuGetSchool_Degree_(nupromiid, null);

      begin

        Inusubs := ge_bosubscriber.getsubscriberid(nuitipident, sbidentif);

        /* Se controla la excepcion si el cliente no existe
        asignandole a la variable nuSubscriber null*/

      exception
        when others then
          Inusubs := null;
      end;

      if Inusubs is not null then
        LD_BONonbankfinancing.UpdDebCos(nuitipident,
                                        sbidentif,
                                        nuPhone,
                                        sbdebname,
                                        sblastname,
                                        sbmail,
                                        sbAddress,
                                        dtBirth,
                                        sbGender,
                                        sbCvlSt,
                                        sbSchool,
                                        sbProf,
                                        'C');
      end if;

      nuIndexpro := recpromiso.NEXT(nuIndexpro);
    END LOOP;

    sbflag := Ld_BoflowFNBPack.fsbchangearticlesprice(inupackage_id);

    if sbflag is null then
      ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                       'No se obtuvo informacion sobre la variacion de precio');

    end if;

    if (rgmo_packages.person_id IS not null AND
       rgmo_packages.organizat_area_id IS null) then
      --actualiza la solicitud con el area de la persona conectada
      damo_packages.updorganizat_area_id(inupackage_id,
                                         dage_person.fnuGetOrganizat_Area_Id(rgmo_packages.person_id));
    END if;

  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      Errors.setError;
      RAISE ex.CONTROLLED_ERROR;
  END CreateSaleAndReviwOrder;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : fsbApproveTransferQuota
  Descripcion    : retorna Y si la orden de traslado fue aprobada y N
                   sino fue. Si la orden no existe retorna null
  Autor          : Eduar Ramos
  Fecha          : 10/04/2013

  Parametros              Descripcion
  ============         ===================
  isbIdentification
  onuErrCod            Codigo de error
  osbErrMsg            Mensaje de error

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  13-09-2013      hvera.SAO           Se modifica para recorrer todas las ordenes
                                      Retornar 0 si al menos una fue rechazada

  ******************************************************************/
  function fnuApproveTransferQuota(inupackage IN mo_packages.package_id%TYPE)
    return number IS

    nuCausalFallo   ld_parameter.numeric_value%type;
    nuCausalExito   ld_parameter.numeric_value%type;
    nuactivityTrasn ld_parameter.numeric_value%type;
    nuError         number;
    sbMessage       varchar2(3200);

    inuIndex    number;
    nuCausal    number;
    nuValue     number;
    tbDataOrder LD_BCQUOTATRANSFER.tytbOrderData;
  BEGIN

    nuactivityTrasn := dald_parameter.fnuGetNumeric_Value('TRANSFER_QUOTA_FNB_ACTIVI_TYPE');

    nuCausalFallo := dald_parameter.fnuGetNumeric_Value('TRASNFER_FAIL_CAUSA');

    nuCausalExito := dald_parameter.fnuGetNumeric_Value('TRASNFER_SUCC_CAUSAL');

    tbDataOrder := LD_BCQUOTATRANSFER.ftbDataOrderLeg(inupackage,
                                                      nuactivityTrasn);

    inuIndex := tbDataOrder.first;

    nuValue := 1;

    while (inuIndex IS not null) loop

      nuCausal := daor_order.fnuGetCausal_Id(tbDataOrder(inuIndex)
                                             .nuOrderId);

      if (nuCausal IS null OR nuCausal = nuCausalFallo) then
        nuValue := 0;
        exit;
      END if;

      inuIndex := tbDataOrder.next(inuIndex);
    END loop;

    return nuValue;

  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      errors.GetError(nuError, sbMessage);
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      Errors.setError;
      RAISE ex.CONTROLLED_ERROR;
  END fnuApproveTransferQuota;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : cancellationSaleorder
    Descripcion    : Metodo que Obtiene y Anula una OT de venta,
                    a partir d ela solicitud de venta.

    Autor          : Evens Herard Gorut
    Fecha          : 17/04/2013

    Parametros       Descripcion
    ============     ===================

    Historia de Modificaciones
    Fecha            Autor                   Modificacion
    =========        =========               ====================
    08-08-2016      KBaquero[200311]        Se unifica el paquete para en este proceso, para que se
                                            tener una sola version.
    10-06-2015      jhinestroza [7213]      Se valida si la solicitud de Servicios financieros
                                            ya se encuentra cerrada, para no anularla y generar un error.
    19-12-2014      Llozada [NC 4303]        Se hace el llamado al nuevo m?todo de anulaci?n que solo anula la solicitud,
                                             el motivo y los componentes
    02-12-2014      KCienfuegos.NC3012      Se modifica para que tambien anule la orden de
                                            revision de documentos y la orden de instalacion.
    05-09-2014      AEcheverry.4769         Se modifica par no actualizar el flag
                                            de actualizable en base de datos a FALSE
    15-08-2014      Aecheverrry.4279        Se modifica para realizar la devolucion
                                            de la cuota inicial solo si no se ha
                                            generado ninguna orden de entrega
    26-05-2014      darevalo.3638           Se modifica para no crear la nota credito siempre,
                                            solo se creara cuando el cupon se encuentre pago.
    10-04-2014      aesguerra.3374          Se modifica para que la anulacion del cobro de la cuota
                                            inicial se haga con notas de anulacion en lugar de
                                            crear un cargo manualmente. Con este cambio se soluciona
                                            el error que dejaba la cuenta descuadrada.
    04-04-2014      AEcheverry.SAO237025    Se modifica para que se generen los
                                            cargos con el tipo de proceso automatico
    21-11-2013       hjgomez.SAO224456       Se valida el tipo de producto
    15/11/2013       JCarmona.SAO223175      Se modifica para que anule todos los
                                            articulos de la venta.
    12/11/2013       JCarmona.SAO222244      Se modifica para que anule las ordenes
                                            de Revision de Documentos y traslado
                                            de cupo cuando se anula la venta.
    17/04/2013       Eherard.SAO156577       Creacion
  ******************************************************************/
  PROCEDURE cancellationSaleorder(inuPackage_id in mo_packages.package_id%type)

   IS
    /*Variables*/
    nuOrder_Id            or_order.order_id%type;
    nuServFinanPackageId  mo_packages.package_id%type;
    csbTagVentaServFinan  ps_package_type.tag_name%type := 'P_VENTA_SERVICIOS_FINANCIEROS_100219';
    csbTagVentaServFinanP ps_package_type.tag_name%type := 'P_VENTA_PROMIGAS_XML_100218';
    rcPackage             damo_packages.styMO_packages;
    csbComment            mo_packages.comment_%type := 'Se anula venta de servicios financieros';
    nuCausalId            mo_motive.causal_id%type;
    tbQuotaTransferOrder  dald_quota_transfer.tytbORDER_ID;
    nuIndexId             number;
    nuIdxId               number;
    tbItemWorkOrder       dald_item_work_order.tytbItem_Work_Order_Id;
    nuProductTypeId       pr_product.product_type_id%type;
    nuPaymentValue        number;
    nuproduct             number;
    nuCucocodi            cuencobr.cucocodi%type;
    nuTipoSolVentaFNB     number := DALD_Parameter.fnuGetNumeric_Value('TIPO_SOL_VENTA_FNB');
    nuCantidadSol         number;

    cnuInitQuotaConc constant ld_parameter.numeric_value%type := dald_parameter.fnuGetNumeric_Value('CONC_INI_QUOTA');
    cnuNoteCause     constant ld_parameter.numeric_value%type := dald_parameter.fnuGetNumeric_Value('COD_CAUSA_CARG_ANUL_DEVO');

    nuNote notas.notanume%type;

    nuCuponume   cupon.cuponume%type;
    nuBill       factura.factcodi%type;
    nuCantidad   number := 0;
    blCreateNote boolean := FALSE;
    nuOrdReviFNB or_order.order_id%type;
    nuOrdInstall or_order.order_id%type;

    CURSOR cuProductType IS
      SELECT product_type_id, product_id
        FROM mo_motive
       WHERE PACKAGE_id = inuPackage_id
         AND rownum = 1;

    CURSOR cuCuentas(inuFacturaId in factura.factcodi%type) IS
      SELECT cucocodi FROM CUENCOBR WHERE CUCOFACT = inuFacturaId;

    CURSOR cuPackBills(inuPackId mo_packages.package_id%type) IS
      SELECT mp.coupon_id, mp.account
        FROM mo_package_payment pp, mo_motive_payment mp
       WHERE pp.package_payment_id = mp.package_payment_id
         AND mp.account IS not null
         AND mp.coupon_id IS not null
         AND pp.package_id = inuPackId;

    CURSOR cuCupon(inuPackId mo_packages.package_id%type) IS
      SELECT *
        FROM cupon
       WHERE cupotipo = pkBillConst.CSBTOKEN_SOLICITUD
         AND cupodocu = inuPackId
         AND cupoflpa = 'S';

    CURSOR cuCountOrdEntrega(inuPackageSaleId in mo_packages.package_id%type) IS
      SELECT count(1)
        FROM ld_item_work_order
       WHERE ORDER_activity_id in
             (select ORDER_activity_id
                FROM OR_order_activity
               WHERE PACKAGE_id = inuPackageSaleId
                 AND activity_id = cnuDelivActiv);

    CURSOR cuSolRegistradasoAtendidas(inuTipoSol number, inuProduct mo_motive.product_id%type) IS
      select count(1)
        from open.mo_packages a, open.mo_motive b
       where b.product_id = inuProduct
         and a.package_type_id = inuTipoSol
         and a.motive_status_id = 13
         and a.package_id = b.package_id;

    rcCupon cuCupon%rowtype;

    PROCEDURE RegisterNote(nuServSusc    in servsusc.sesunuse%type,
                           nuSubsc       in servsusc.sesususc%type,
                           nucuencobr    in cuencobr.cucocodi%type,
                           nuConcept     in concepto.conccodi%type,
                           nuNoteCuase   in ld_parameter.numeric_value%type,
                           sbDescription in varchar2,
                           nuValue       ld_item_work_order.value%type) IS
    BEGIN
      ut_trace.trace('Inicia LD_BOcancellations.cancellationSaleorder.RegisterNote',
                     5);

      pkErrors.SetApplication(CC_BOConstants.csbCUSTOMERCARE);

      FA_BOBillingNotes.SetUpdateDataBaseFlag;

      --  Crea la nota por el pago inicial
      pkBillingNoteMgr.CreateBillingNote(nuServSusc,
                                         nucuencobr,
                                         GE_BOConstants.fnuGetDocTypeCreNote,
                                         sysdate,
                                         sbDescription,
                                         pkBillConst.csbTOKEN_NOTA_CREDITO,
                                         nuNote);

      ut_trace.trace('Termino pkBillingNoteMgr.CreateBillingNote', 5);

      -- Crear Detalle Nota Credito
      FA_BOBillingNotes.DetailRegister(nuNote,
                                       nuServSusc,
                                       nuSubsc,
                                       nucuencobr,
                                       nuConcept,
                                       nuNoteCuase,
                                       nuValue,
                                       null,
                                       pkBillConst.csbTOKEN_NOTA_CREDITO ||
                                       nuNote,
                                       pkBillConst.CREDITO,
                                       pkConstante.SI,
                                       null,
                                       pkConstante.SI);

      ajustaCuenta(nucuencobr);

      ut_trace.trace('Termina LD_BOcancellations.cancellationSaleorder.RegisterNote',
                     5);

    EXCEPTION
      When ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
      When others then
        Errors.setError;
        raise ex.CONTROLLED_ERROR;
    END RegisterNote;

  BEGIN
    ut_trace.trace('Inicia ld_boflowfnbpack.cancellationSaleorder', 5);

    /*Obtener la OT de venta*/
    nuOrder_Id := Ld_BcCancellations.Fnugetsaleorder(inuPackage_id, null);

    /*Anular la OT de venta*/
    Or_BOAnullOrder.AnullOrderWithOutVal(nuOrder_Id);

    /*Busca la ot de revision de documentos - NC3012*/
    nuOrdReviFNB := ld_bocancellations.FnugetReviFNBorder(inuPackage_id);

    /*Anula la orden de revision de documentos - NC3012*/
    if nuOrdReviFNB <> ld_boconstans.cnuCero then
      Or_BOAnullOrder.AnullOrderWithOutVal(nuOrdReviFNB);
    end if;

    /*Busca la ot de instalacion - NC3012*/
    nuOrdInstall := ld_bocancellations.FnugetInstallFNBorder(inuPackage_id);

    /*Anula la orden de instalacion - NC3012*/
    if nuOrdInstall <> ld_boconstans.cnuCero then
      Or_BOAnullOrder.AnullOrderWithOutVal(nuOrdInstall);
    end if;

    --Se obtiene el tipo de producto del motivo de la solicitud
    open cuProductType;
    fetch cuProductType
      INTO nuProductTypeId, nuProduct;
    close cuProductType;

    if (nuProductTypeId = 7055) then
      /*Se realiza la anulacion de la solicitud de venta de servicios financieros*/
      nuServFinanPackageId := mo_bopackages_asso.fnuGetPackageFather(inuPackage_id,
                                                                     csbTagVentaServFinan);
    else
      /*Se realiza la anulacion de la solicitud de venta de Promigas*/
      nuServFinanPackageId := mo_bopackages_asso.fnuGetPackageFather(inuPackage_id,
                                                                     csbTagVentaServFinanP);
    end if;

    ut_trace.trace('Solicitud venta de Servicios Financieros ' ||
                   nuServFinanPackageId,
                   5);
    /*19-12-2014 Llozada [NC 4303]: Se hace el llamado al nuevo m?todo de anulaci?n que solo anula la solicitud,
    el motivo y los componentes*/
    if (nuServFinanPackageId IS not null) then

      open cuSolRegistradasoAtendidas(nuTipoSolVentaFNB, nuProduct);
      fetch cuSolRegistradasoAtendidas
        into nuCantidadSol;
      close cuSolRegistradasoAtendidas;

      rcPackage := damo_packages.frcgetrecord(nuServFinanPackageId);

      if (nuCantidadSol is not null AND nuCantidadSol > 1) then
        LDC_AnulaSolicitud(inuPackage_id);
      else

        -- Se verifica si la entrega aplica o no caso 200-311
        If fblAplicaEntrega('FNB_BRI_KBM_200311_1') Then
          /* C?digo que se ejecuta cuando si aplica la entrega */

          -- 10-06-2015 jhinestroza[7213]: Se valida si la solicitud de Servicios financieros esta atendida
          -- si el estado es diferente de 14- Atendido, procedera a anular esta solicitud.
          if (rcPackage.MOTIVE_STATUS_ID <> 14) then
            MO_BOANNULMENT.PACKAGEINTTRANSITION(nuServFinanPackageId,
                                                GE_BOPARAMETER.FNUGET('ANNUL_CAUSAL'));
          end if;
        else

          MO_BOANNULMENT.PACKAGEINTTRANSITION(nuServFinanPackageId,
                                              GE_BOPARAMETER.FNUGET('ANNUL_CAUSAL'));
        end if;
      end if;
      --19-12-2014 Llozada [NC 4303]: Se comenta ya que esta es la versi?n que deja el producto en estado retirado
      --rcPackage := damo_packages.frcgetrecord(nuServFinanPackageId);
      --MO_BOANNULMENT.PACKAGEINTTRANSITION(nuServFinanPackageId,GE_BOPARAMETER.FNUGET('ANNUL_CAUSAL'));
    END if;

    /* Se obtienen las ordenes de traslado de cupo dada la solicitud */
    tbQuotaTransferOrder := LD_bcflowFNBPack.ftbGetQuotaTransferOrder(inuPackage_id);

    nuIndexId := tbQuotaTransferOrder.first;

    /*Se realiza la anulacion de las ordenes de traslado de cupo */
    WHILE nuIndexId IS not null LOOP
      if (tbQuotaTransferOrder(nuIndexId) IS NOT NULL) then
        Or_BOAnullOrder.AnullOrderWithOutVal(tbQuotaTransferOrder(nuIndexId));
      end if;
      nuIndexId := tbQuotaTransferOrder.next(nuIndexId);
    END LOOP;

    /* Se obtienen todos los articulos de la venta */

    tbItemWorkOrder := LD_bcflowFNBPack.ftbGetArticlesFromSale(inuPackage_id);

    nuIdxId := tbItemWorkOrder.first;

    /* Se realiza la anulacion de todos los articulos de la venta */
    WHILE nuIdxId IS not null LOOP
      if (tbItemWorkOrder(nuIdxId) IS NOT NULL) then
        dald_item_work_order.updState(tbItemWorkOrder(nuIdxId), 'AN');
      end if;
      nuIdxId := tbItemWorkOrder.next(nuIdxId);
    END LOOP;

    open cuCountOrdEntrega(inuPackage_id);
    fetch cuCountOrdEntrega
      INTO nuCantidad;
    close cuCountOrdEntrega;
    -- si no se han creado actividades de entrega para ningun articulo se devuelve la cuota inicial
    if (nvl(nuCantidad, 0) = 0) Then

      if cuPackBills%isopen then
        close cuPackBills;
      END if;

      open cuPackBills(inuPackage_id);
      fetch cuPackBills
        INTO nuCuponume, nuBill;
      close cuPackBills;

      if nuCuponume IS not null then
        blCreateNote := TRUE;
      END if;

      if not blCreateNote then
        if cuCupon%isopen then
          close cuCupon;
        END if;

        open cuCupon('' || inuPackage_id);
        fetch cuCupon
          INTO rcCupon;
        close cuCupon;

        if rcCupon.cuponume IS not null then
          blCreateNote := TRUE;
        END if;
      END if;

      if blCreateNote then
        -- si hubo cuota inicial y es contratista se reversa el cargo DB
        nuPaymentValue := dald_non_ba_fi_requ.fnuGetPayment(inuPackage_id);

        open cuCuentas(mo_bopackagepayment.fnugetaccountbypackage(inuPackage_id));
        fetch cuCuentas
          INTO nuCucocodi;
        close cuCuentas;

        ut_trace.trace('Se registrara nota credito para devolucion de cuota inicial',
                       10);

        RegisterNote(nuProduct,
                     pktblservsusc.fnugetsuscription(nuProduct),
                     nuCucocodi,
                     cnuInitQuotaConc,
                     cnuNoteCause,
                     'Devolucion de cuota inicial Brilla ',
                     nuPaymentValue);

        ut_trace.trace('Se actualizo saldo de cuenta de cobro', 10);

        -- Aplica el saldo a favor del producto
        pkaccountmgr.applypositivebalserv(nuProduct);
      END if;
    END if;
    ut_trace.trace('Inicio ld_boflowfnbpack.cancellationSaleorder', 5);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;

  END cancellationSaleorder;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : fsbchangearticlesprice
  Descripcion    : Obtener a partir de una solicitud de venta los articulos asociados a una orden de venta y para cada uno de ellos
          determinar si cambio el precio si el precio vario en al menos un articulo,
          entonces la respuesta de la funcion debera ser ?Y?. Es decir,
          que si hubo variacion de precio, en caso contrario la funcion retornara valor ?N?.

  Autor          : AAcuna
  Fecha          : 10/04/2013

  Parametros         Descripcion
  ============   ===================
  inuPackage:    Numero de la solicitud de venta


  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/

  FUNCTION fsbchangearticlesprice(inuPackage in mo_packages.package_id%type)

   RETURN varchar2

   IS

    --nuOrder      Or_order.order_id%type;
    --tbArticle_id dald_item_work_order.tytbArticle_Id;
    --nuArticle_id Or_order.order_id%type;

    frfArticle_id constants.tyrefcursor;
    recArticle_id dald_item_work_order.styLD_item_work_order;

    nuPriceApproved ld_price_list_deta.price%type;
    rcPackage       damo_packages.styMO_packages;
    tbApprove_sales dald_approve_sales_order.styLD_approve_sales_order;
    sw              number;

    nuSalesChannel    mo_packages.sale_channel_id%type;
    nuGeograpLocation ab_address.geograp_location_id%type;
    nuPriceListDeta   ld_price_list_deta.price_list_deta_id%type;

    CURSOR cuGetData(nuPackage in mo_packages.package_id%type) IS
      SELECT mo_packages.reception_type_id, ab_address.geograp_location_id
        FROM mo_packages, ld_promissory, ab_address
       WHERE mo_packages.package_id = ld_promissory.package_id
         AND ld_promissory.promissory_type = 'D'
         AND ab_address.address_id = ld_promissory.address_id
         AND mo_packages.PACKAGE_id = nuPackage;
  BEGIN

    ut_trace.trace('Inicio Ld_BoflowFNBPack.fsbchangearticlesprice', 10);

    /* Obtengo el registro de la solicitud de venta */

    rcPackage := damo_packages.frcgetrecord(inuPackage);

    /* Obtengo los articulos asociados a la solicitud de venta este proceso se realiza
    llamando al servicio Ld_BoNonBankFinacing.frfgetsalepackagearticles que me trae
    un cursor referenciado con los articulos asociados a las ordenes de entrega de la solicitud
    ingresada*/

    frfArticle_id := ld_bcnonbankfinancing.frfgetsalepackagearticles(inuPackage);

    /* Recorro los articulos asociados a la solicitud de venta */
    sw := 0;

    LOOP

      FETCH frfArticle_id
        INTO recArticle_id;

      EXIT WHEN frfArticle_id%NOTFOUND;

      ut_trace.trace('Revisando articulo ' || recArticle_id.article_id, 20);

      /* Verifico si el precio del articulo ha cambiado a partir de la fecha
      del sistema*/

      IF dald_article.fsbGetPrice_Control(recArticle_id.article_id) =
         ld_boconstans.csbYesFlag THEN

        ut_trace.trace('El articulo controla precio', 21);

        open cuGetData(inuPackage);
        fetch cuGetData
          INTO nuSalesChannel, nuGeograpLocation;
        close cuGetData;

        nuPriceApproved := recArticle_id.value;
        -- se obtiene el detalle que aplica para la fecha de solicitud de la venta
        nuPriceListDeta := ld_bcnonbankfinancing.fnuvalsha_geo(recArticle_id.article_id,
                                                               nuSalesChannel,
                                                               nuGeograpLocation,
                                                               recArticle_id.supplier_id,
                                                               rcPackage.request_date);

        if (dald_price_list_deta.fblExist(nuPriceListDeta)) then
          nuPriceApproved := dald_price_list_deta.fnuGetPrice_Aproved(nuPriceListDeta);
        END if;
        /*
        ld_bononbankfinancing.GetPriceArticle(recArticle_id.article_id,
                            rcPackage.subscription_pend_id,
                            recArticle_id.value,
                            rcPackage.request_date,
                            sbMessage,
                            nuPriceApproved,
                            sbError);

                            */

        /* Si el articulo vario precio se inserta el registro en la tabla
        ld_approve_sales_order */

        if (nuPriceApproved <> recArticle_id.value) then

          if sw = 0 then

            /*Se realiza el ingreso del registro*/

            tbApprove_sales.approve_sales_order_id := ld_bosequence.Fnuseqld_approve_sales_order;

            tbApprove_sales.order_id := recArticle_id.order_id;

            tbApprove_sales.package_id := inuPackage;

            tbApprove_sales.approved := 'P';

            tbApprove_sales.register_date := sysdate;

            tbApprove_sales.terminal := userenv('TERMINAL');

            dald_approve_sales_order.insRecord(tbApprove_sales);

            sw := 1;

          end if;

          /*Actualizacion del campo State de  LD_ITEM_WORK_ORDER recArticle_id*/
          dald_item_work_order.updState(recArticle_id.item_work_order_id,
                                        'PA');

        end if;

      END IF;

    END LOOP;

    CLOSE frfArticle_id;

    /* Retorno el mensaje */

    IF sw = 0 THEN
      return ld_boconstans.csbNOFlag;
    ELSE
      return ld_boconstans.csbYesFlag;
    END IF;

    ut_trace.trace('Fin Ld_BoflowFNBPack.fsbchangearticlesprice', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when no_data_found then
      return null;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END fsbchangearticlesprice;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : PayableInvoices
  Descripcion    : Verifica a partir de la solicitud de venta el contrato asociado a esta y a partir
                   del contrato obtener la ultima factura registrada y determinar si se encuentra vencida.
                   Para saber si se encuentra vencida la factura debe cumplir las siguientes condiciones:
                   1. Que la fecha de limite de pago sea menor al sysdate
                   2. Que la cuenta de cobro  asociada a la factura no tenga saldo pendiente
                   La funcion retornara los siguientes valores:
                   Retorna (Y) Si la factura esta vencida
                   Retorna (N) Si se encuentra al dia

  Autor          : AAcuna
  Fecha          : 18/04/2013 11:53:27 a.m.

  Parametros         Descripcion
  ============   ===================
  inuPackage:    Solicitud de venta

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  18/04/2013    AAcuna.SAO139854      Creacion
  ******************************************************************/

  FUNCTION PayableInvoices(inuPackage in mo_packages.package_id%type)

   RETURN varchar2

   IS

    sbPayableInvoices varchar2(2);
    nuPayableInvoices number;
    rcMopackage       damo_packages.styMO_packages;

  BEGIN

    ut_trace.trace('Inicio Ld_BoflowFNBPack.PayableInvoices', 10);

    /*  \* Se obtiene los registros asociados a la solicitud de venta*\

      damo_packages.getRecord(inuPackage, rcMopackage);
    */
    /*Llamo al servicio que me verifica si la factura se encuentra vencida */
    BEGIN
      SELECT decode(PAYMENT, 'N', 0, 'Y', 1)
        INTO nuPayableInvoices
        FROM LD_BILL_PENDING_PAYMENT
       WHERE PACKAGE_ID = inuPackage;
    EXCEPTION
      WHEN OTHERS THEN
        nuPayableInvoices := 1;
    END;

    /*  nuPayableInvoices := LD_bcflowFNBPack.FnuGetBillExpired(rcMopackage.subscription_pend_id);
    */
    if (nuPayableInvoices = 0) then

      sbPayableInvoices := 'N';

    else

      sbPayableInvoices := 'Y';

    end if;

    return sbPayableInvoices;

    ut_trace.trace('Fin Ld_BoflowFNBPack.PayableInvoices', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when no_data_found then
      return null;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;

  END PayableInvoices;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : GetOperantingUnitSaleorder
  Descripcion    : retorna 1 si es proveedor y 0 si es contratista de venta.
  Autor          : Alex Valencia Ayola
  Fecha          : 18/04/2013

  Parametros              Descripcion
  ============         ===================
  inupacksale          Identificador de la solicitud.

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================

  ******************************************************************/
  FUNCTION GetOperantingUnitSaleorder(inupacksale mo_packages.package_id%TYPE)
    RETURN PLS_INTEGER IS

    cnuCVEFNB CONSTANT ld_parameter.numeric_value%TYPE := Dald_parameter.fnuGetNumeric_Value('CONTRACTOR_SALES_FNB');

    nuOrder_sale     or_order.order_id%TYPE;
    nuOperation_unit or_order.operating_unit_id%TYPE;
    nuUnit_Type_Id   or_operating_unit.Oper_Unit_Classif_Id%TYPE;

  BEGIN

    ut_trace.trace('INICIA Ld_BoflowFNBPack.GetOperantingUnitSaleorder',
                   10);

    /*Obtiene la orden de venta*/
    nuOrder_sale := Ld_bccancellations.fnugetsaleorder(inupacksale, 0);

    /*Obtiene la unidad operativa de la orden*/
    nuOperation_unit := Daor_Order.fnuGetOperating_Unit_Id(nuOrder_sale, 0);

    /*Obtiene clasificacion   de la unidad operativa de la orden de venta*/
    nuUnit_Type_Id := daor_operating_unit.fnuGetOper_Unit_Classif_Id(nuOperation_unit,
                                                                     0);

    ut_trace.trace('FIN Ld_BoflowFNBPack.GetOperantingUnitSaleorder', 10);

    RETURN sys.diutil.bool_to_int(nuUnit_Type_Id != cnuCVEFNB);

  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      Errors.setError;
      RAISE ex.CONTROLLED_ERROR;
  END GetOperantingUnitSaleorder;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : fnuIdentifyRules
  Descripcion    : retorna 1 si la configuracion existe y esta seteada con valor o en Y.
                   retorna 0 si la configuracion existe y esta seteada en Null o N.
                   en otro caso retorna Null
  Autor          : Alex Valencia Ayola
  Fecha          : 19/04/2013

  Parametros              Descripcion
  ============         ===================
  inupackagesale       Identificador de la solicitud
  isbColNameSuppl      Columna en ld_suppli_settings a evaluar

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================

  ******************************************************************/
  FUNCTION fnuIdentifyRules(inupackagesale  IN mo_packages.package_id%TYPE,
                            isbColNameSuppl IN VARCHAR2) RETURN PLS_INTEGER IS

    nuOrder_sale     or_order.order_id%TYPE;
    nuOperating_Unit or_order.operating_unit_id%TYPE;
    nuContractor_Id  or_operating_unit.contractor_id%TYPE;

    frgSuppSettings dald_suppli_settings.tyRefCursor;
    rcRecSuppliSett dald_suppli_settings.styLD_suppli_settings;

    csbExeRule CONSTANT VARCHAR2(30) := 'EXE_RULE_POST_SALE';
    csbLegDeli CONSTANT VARCHAR2(30) := 'POST_LEG_PROCESS';
    csbLegAuto CONSTANT VARCHAR2(30) := 'LEG_DELIV_ORDE_AUTO';

  BEGIN
    --valida q la variablr de paquete tenga algo
    IF inupackagesale IS NULL THEN
      RETURN NULL;
    END IF;

    /*Obtiene la orden de venta*/
    nuOrder_sale := Ld_BcCancellations.Fnugetsaleorder(inupackagesale, 0);

    /*Obtiene la unidad operativa de la orden*/
    nuOperating_Unit := Daor_Order.fnuGetOperating_Unit_Id(nuOrder_sale, 0);

    /*Obtiene el identificador del contratista*/
    nuContractor_Id := daor_operating_unit.fnuGetContractor_Id(nuOperating_Unit,
                                                               0);

    /*Obtiene configuracion del proveedor*/
    frgSuppSettings := dald_suppli_settings.frfGetRecords(' SUPPLIER_ID=' ||
                                                          nuContractor_Id);
    FETCH frgSuppSettings
      INTO rcRecSuppliSett;
    CLOSE frgSuppSettings;

    CASE isbColNameSuppl
      WHEN csbExeRule THEN
        CASE
          WHEN rcRecSuppliSett.EXE_RULE_POST_SALE IS NOT NULL THEN
            RETURN 1;
          ELSE
            RETURN 0;
        END CASE;
      WHEN csbLegDeli THEN
        CASE
          WHEN rcRecSuppliSett.POST_LEG_PROCESS = 'Y' THEN
            RETURN 0;
          ELSE
            RETURN 1;
        END CASE;
      WHEN csbLegAuto THEN
        CASE
          WHEN rcRecSuppliSett.LEG_DELIV_ORDE_AUTO = 'Y' THEN
            RETURN 1;
          ELSE
            RETURN 0;
        END CASE;

    END CASE;

    RETURN NULL;
  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      Errors.setError;
      RAISE ex.CONTROLLED_ERROR;
  END fnuIdentifyRules;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : LegSaleOrder
    Descripcion    : Legaliza una o varias orde(nes) de venta o
                     entrega

    Autor          : Jonathan Alberto Consuegra
    Fecha          : 19/04/2013

    Parametros       Descripcion
    ============     ===================
    inupackage_id    Identificador de la solicitud
    inuTypeactivity  Tipo de actividad

    Historia de Modificaciones
    Fecha            Autor                Modificacion
    =========       =========             ====================
	17/01/2024		jsoto				  (OSF-2019)
										  Se crea cursor cuCadenaLegalizacion para armar la cadena de legalización
										  se reemplaza OS_LEGALIZEORDERALLACTIVITIES por API_LEGALIZEORDERS
	19/08/2014      KCienfuegos.RNP156    Se modifica para que la ot de entrega quede con la observacion
                                          del registro de la venta.
    01/04/2014      AEcheverrySAO236627     Se modifica para no tomar las ordenes anuladas
    19/04/2013      Jconsuegra.SAO139854  Creacion
  ******************************************************************/
  Procedure LegSaleOrder(inupackage_id   mo_packages.package_id%Type,
                         inuTypeactivity ge_items.items_id%type) is
    --identifica las ordenes segun la actividad que no esten legalizadas
    CURSOR saledeliveryorders is
      SELECT distinct ot.order_id order_id, ot.operating_unit_id
        FROM or_order_activity o, or_order ot
       WHERE o.package_id = inupackage_id
         AND o.activity_id = inuTypeactivity
         and ot.order_id = o.order_id
         and ot.order_status_id not in (8, 12);

    nuError number;
    sbError varchar2(4000);
    /*RNP 156*/
    nuTypeActivityDel ld_parameter.numeric_value%type;
    sbComment         or_order_comment.order_comment%type;

    cursor cuObseVenta is
      select mo.comment_
        from mo_packages mo
       where mo.package_id = inupackage_id;
	   
    --CURSOR PARA GENERAR CADENA QUE SERA UTILIZADA PARA LEGALIZAR LA ORDEN
    CURSOR cuCadenaLegalizacion (NUORDER_ID OR_ORDER.ORDER_ID%TYPE,
								nuPersona GE_PERSON.PERSON_ID%TYPE)
        IS
            SELECT    O.ORDER_ID
                   || '|'||pkg_gestionordenes.cnucausalexito||'|'
                   || nuPersona
                   || '||'
                   || A.ORDER_ACTIVITY_ID
                   || '>'||pkg_bcordenes.fnuobtieneclasecausal(pkg_gestionordenes.cnucausalexito)||';;;;|||1277;'
                   || '-' Cadenalegalizacion
              FROM OR_ORDER O, OR_ORDER_ACTIVITY A
             WHERE O.ORDER_ID = A.ORDER_ID
               AND O.ORDER_ID = TO_NUMBER (NUORDER_ID);        

    sbCadenaLegalizacion   VARCHAR2 (4000);

	   

  Begin

    ut_trace.trace('Inicio LD_boflowFNBPack.LegSaleOrder', 10);

    nuTypeActivityDel := DALD_PARAMETER.FNUGETNUMERIC_VALUE('ACT_TYPE_DEL_FNB',
                                                            0);
    --recorre las ot no legalizadas
    FOR rgorders in saledeliveryorders LOOP
	
			IF cuCadenaLegalizacion%ISOPEN THEN
				CLOSE cuCadenaLegalizacion;
			END IF;
	
	        OPEN cuCadenaLegalizacion (rgorders.order_id, ld_boutilflow.fnuGetPersonToLegal(rgorders.operating_unit_id));
            FETCH cuCadenaLegalizacion INTO sbCadenaLegalizacion;
            CLOSE cuCadenaLegalizacion;
			
      --legaliz la ot con causal de exito

            api_legalizeorders(isbDataOrder     => sbCadenaLegalizacion, 
                               idtInitDate      => SYSDATE,
                               idtFinalDate     => SYSDATE, 
                               idtChangeDate    => SYSDATE,
                               onuerrorcode     => nuError,
                               osberrormessage  => sbError);                                        
			
      --si existe error levanta mensaje
      if nuerror <> 0 then
        RAISE ex.CONTROLLED_ERROR;
      end if;

      if nuTypeActivityDel = inuTypeactivity then
        open cuObseVenta;
        fetch cuObseVenta
          into sbComment;
        if cuObseVenta%found then
          BEGIN
            commentDelOrder(rgorders.order_id, sbComment);
          EXCEPTION
            WHEN OTHERS THEN
              RAISE ex.CONTROLLED_ERROR;
          END;
        end if;
        close cuObseVenta;
      end if;
    END LOOP;

    ut_trace.trace('Fin LD_boflowFNBPack.LegSaleOrder', 10);

  Exception
    When ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    When others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  End LegSaleOrder;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : Executerules
  Descripcion    :
  Autor          : Alex Valencia Ayola
  Fecha          : 19/04/2013

  Parametros         Descripcion
  ============   ===================
  inuPackage:    Identificacion de la solicitud

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  20/08/2014      KCienfuegos.NC1555  Se pone el return en comentario.

  ******************************************************************/

  PROCEDURE Executerules(inuPackage IN mo_packages.package_id%TYPE) IS

    nuOperating_Unit or_order.operating_unit_id%TYPE;
    nuContractor_Id  or_operating_unit.contractor_id%TYPE;

    frgSuppSettings dald_suppli_settings.tyRefCursor;
    frgDelivOrders  daor_order_activity.tyRefCursor;

    rcRecSuppliSett dald_suppli_settings.styLD_suppli_settings;
    rcDelivOrder    daor_order_activity.tytbOrder_Id;

    nuIndex PLS_INTEGER;
  BEGIN

    ut_trace.trace('Inicio Ld_BoflowFNBPack.Executerules', 10);

    IF inupackage IS NULL THEN
      RETURN;
    END IF;

    LD_boflowFNBPack.nuPackageId := inuPackage;

    /* Obtiene las ordenes de entrega */
    frgDelivOrders := ld_bcNonBankFinancing.frfGetDeliverOrders(inuPackage);

    FETCH frgDelivOrders BULK COLLECT
      INTO rcDelivOrder;
    CLOSE frgDelivOrders;

    nuIndex := rcDelivOrder.FIRST;

    WHILE nuIndex IS NOT NULL LOOP
      /* Obtiene la unidad operativa por cada una de las ordenes de entrega  */
      nuOperating_Unit := Daor_Order.fnuGetOperating_Unit_Id(rcDelivOrder(nuIndex),
                                                             0);

      /* Obtiene el identificador del contratista */
      nuContractor_Id := daor_operating_unit.fnuGetContractor_Id(nuOperating_Unit,
                                                                 0);

      /* Obtiene configuracion del proveedor */
      IF nuContractor_Id IS NOT NULL THEN
        frgSuppSettings := dald_suppli_settings.frfGetRecords(' SUPPLIER_ID=' ||
                                                              nuContractor_Id);

        FETCH frgSuppSettings
          INTO rcRecSuppliSett;
        CLOSE frgSuppSettings;

        IF (rcRecSuppliSett.POST_LEG_PROCESS = 'Y') THEN
          IF (rcRecSuppliSett.LEG_PROCESS_ORDERS IS NOT NULL) THEN
            ld_bopackagefnb.proexeproc(rcRecSuppliSett.LEG_PROCESS_ORDERS);
            --RETURN;
          END IF;
        END IF;
      END IF;

      nuIndex := rcDelivOrder.NEXT(nuIndex);
    END LOOP;
    ut_trace.trace('Fin Ld_BoflowFNBPack.Executerules', 10);

  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      Errors.setError;
      RAISE ex.CONTROLLED_ERROR;

  END Executerules;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : fnuVerifacancelot
  Descripcion    : retorna 0 si todas las ordenes de entrega de la solictud
                 se legalizan con causal de fallo en otro caso retorna 1
  Autor          : Alex Valencia Ayola
  Fecha          : 26/04/2013

  Parametros              Descripcion
  ============         ===================
  inupackagesale       Identificador de la solicitud de venta

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
   10/12/2013     JCarmona.SAO227029  Se modifica para validar que si todos los
                                      articulos estan devueltos el flujo de
                                      venta debe anularse.
  ******************************************************************/
  FUNCTION fnuVerifacancelot(inupackagesale IN mo_packages.package_id%TYPE)
    RETURN PLS_INTEGER IS

    frgDelivOrders daor_order_activity.tyRefCursor;

    rcDelivOrder daor_order_activity.tytbOrder_Id;

    nuIndex PLS_INTEGER;

    nuTotalRecords  PLS_INTEGER := 0; --contador de ot de entrega
    nuRecords       PLS_INTEGER := 0; --contador de ot de entr con causal exito
    nuRecordsf      PLS_INTEGER := 0; --contador de ot de entr con causal diferente exito
    nuDelArti       number := 0; --Contador de articulos devueltos de la orden
    nuCausalId      OR_order.causal_id%type;
    nuCountArticles number;
  BEGIN
    ut_trace.trace('Inicio Ld_BoflowFNBPack.fnuVerifacancelot', 10);
    --valida si tiene paquete
    IF inupackagesale IS NULL THEN
      RETURN NULL;
    END IF;

    /* Obtiene las ordenes de entrega */
    frgDelivOrders := ld_bcNonBankFinancing.frfGetDeliverOrders(inupackagesale);
    --identifica cada una de las ordenes
    FETCH frgDelivOrders BULK COLLECT
      INTO rcDelivOrder;
    CLOSE frgDelivOrders;

    nuIndex := rcDelivOrder.FIRST;
    --recorre cada uno de ella
    WHILE nuIndex IS NOT NULL LOOP
      dbms_output.put_line(rcDelivOrder(nuIndex));
      --contador de orden
      nuTotalRecords := nuTotalRecords + 1;
      --valida que la orden este legalizada

      ut_trace.trace('estado orden: ' ||
                     daor_order.fnugetorder_status_id(rcDelivOrder(nuIndex)),
                     1);

      if daor_order.fnugetorder_status_id(rcDelivOrder(nuIndex)) = 8 OR
         daor_order.fnugetorder_status_id(rcDelivOrder(nuIndex)) = 12 then
        /* Obtiene la causal de cada una de las ordenes de entrega  */
        nuCausalId := daor_order.fnugetcausal_id(rcDelivOrder(nuIndex));

        ut_trace.trace('nuCausalId: ' || nuCausalId, 1);

        if nuCausalId IS not null then

          if dage_causal.fnuGetClass_Causal_Id(nuCausalId) =
             ld_boconstans.cnuclascauexito then
            --contador de ot de entrega legalizadas con causal exitosa
            nuRecords := nuRecords + 1;

            /* Se valida que los articulos entregados no esten devueltos */
            nuCountArticles := Ld_BcflowFNBPack.fnuCountNonDelivArticles(rcDelivOrder(nuIndex),
                                                                         'RE');

            if (nuCountArticles > 0) then
              nuDelArti := nuDelArti + 1;
            end if;

          else
            --contador de ot de entrega legalizadas con causal diferente a exitosa
            nuRecordsF := nuRecordsf + 1;
          end if;
        else
          nuRecordsF := nuRecordsF + 1;
        END if;
      end if;

      nuIndex := rcDelivOrder.NEXT(nuIndex);
    END LOOP;
    --si la cantidad de ordenes legalizadas con fallo es igual al numero total
    --de ordenes retorna 1 y se anula venta en caso contrario sigue flujo con las ot
    --legalizadas
    ut_trace.trace('nuRecordsF: ' || nuRecordsF, 1);
    ut_trace.trace('nuTotalRecords: ' || nuTotalRecords, 1);
    if nuRecordsF = nuTotalRecords then
      return 1;
    else
      /* Se valida que los articulos entregados no esten devueltos */
      if nuDelArti > 0 then
        return 0;
      else
        return 1;
      end if;
    end if;

    ut_trace.trace('Finaliza Ld_BoflowFNBPack.fnuVerifacancelot', 10);

  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      Errors.setError;
      RAISE ex.CONTROLLED_ERROR;

  END fnuVerifacancelot;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : GetLdparamater
   Descripcion    : Metodo que Obtiene el valor de un parametro teniendo
                    en cuenta el parametro y su tipo.

   Autor          : Karem Baquero Martinez
   Fecha          : 26/04/2013

   Parametros       Descripcion
   ============     ===================

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   17/04/2013       Eherard.SAO156577     Creacion
  ******************************************************************/
  PROCEDURE GetLdparamater(sbParametr in ld_parameter.parameter_id%type,
                           sbtipo     in varchar2,
                           sbvalue    out ld_parameter.value_chain%type)

   IS
    /*Variables*/

  BEGIN
    ut_trace.trace('Inicia ld_boflowfnbpack.GetLdparamater');

    if sbtipo = ld_boconstans.csbafirmation then

      sbvalue := dald_parameter.fsbGetValue_Chain(sbParametr, null);

    else
      sbvalue := to_char(dald_parameter.fnuGetNumeric_Value(sbParametr,
                                                            null));
    end if;

    ut_trace.trace('Inicio ld_boflowfnbpack.GetLdparamater');

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;

  END GetLdparamater;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : createCupon
    Descripcion    : recibe como parametro la solicitud e ventad, luego identifica la orden de entrega, paso siguiente recorre cada uno de los articulos de la ot de entrega,
                   e identifica los articulos, con los articulos (ld_article) identifica el servicio al cual esta asociado
                   (los articulos pueden tener configuradion brilla o brilla promigas) y preguntara si ya existe
                   para el cliente producto brilla o brilla promigas y si no existe crearlo
    Autor          : AAcuna
    Fecha          : 28/04/2013 09:55:27 a.m.

    Parametros              Descripcion
    ============            ===================
    inuPackage      :        Numero de solicitud
    inuSuscripc     :        Numero de suscripcion
    onuErrorCode    :        Numero de error
    osbErrorMessage :        Mensaje de error

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
    26-05-2014      darevalo.3638       Se modifica para no crear el cargo DB en
                                        el momento de la venta.
    04-04-2014  AEcheverry.SAO237025    Se modifica para que se generen los
                                        cargos con el tipo de proceso automatico
  ******************************************************************/
  PROCEDURE createCupon(inuOperatingUnitId in or_operating_unit.operating_unit_id%type,
                        inuPackageId       in mo_packages.package_id%type,
                        inuProductId       in pr_product.product_id%type,
                        inuPayment         in ld_non_ba_fi_requ.payment%type) IS

    nuConcept      concepto.conccodi%type := dald_parameter.fnuGetNumeric_Value('CONC_INI_QUOTA');
    nuCupon        number;
    nuFacturaId    factura.factcodi%type;
    nuCuentaId     cuencobr.cucocodi%TYPE;
    nuPackPayId    mo_package_payment.package_payment_id%type;
    dtLimitDate    date;
    nuPaymentValue number := 0;

    CURSOR cuCuentas(inuFacturaId in factura.factcodi%type) IS
      SELECT cucocodi FROM CUENCOBR WHERE CUCOFACT = inuFacturaId;

  BEGIN
    ut_trace.trace('Inicia Ld_BoflowFNBPack.createCupon', 5);
    --valida si es contratista de venta y recibe cuota inicial
    if ld_bopackagefnb.fsbGetTypeUserbyOperUnit(inuOperatingUnitId) = 'CV' and
       inuPayment > 0 then
      nuPaymentValue := inuPayment;

      --Se Comenta Fragmento de Codigo para no Generar el cargo DB en el Momento de la Venta.
      /*
        --Se crea la factura
        nuFacturaId := LD_BOUtilFlow.fnuGenerateInternalBill(inuPackageId, inuProductId);

        open cuCuentas(nuFacturaId);
        fetch cuCuentas INTO nuCuentaId;
        CLOSE cuCuentas;

        ut_trace.trace('nuFacturaId['||nuFacturaId||']nuCuentaId['||nuCuentaId, 10);

        -- genera un cargo par el cobro de la cuota inicial
        pkChargeMgr.GenerateCharge( inuProductId,
                                      nuCuentaId,
                                      nuConcept,
                                      cnuCause,
                                      nuPaymentValue,
                                      'DB',
                                      'PP-' || inuPackageId,
                                      'A',
                                      null,
                                      null,
                                      null,
                                      null,
                                      true,
                                      sysdate );

      pkTblCuencobr.UpAccoReceiv( nuCuentaId, nuPaymentValue, 0 );
      */
      --registra cupon
      pkCouponMgr.GenerateCouponService(pkBillConst.CSBTOKEN_SOLICITUD, --pkBillConst.csbTOKEN_CUENTA,
                                        inuPackageId, -- documento=nuCuentaId,
                                        inuPayment,
                                        null,
                                        sysdate,
                                        nuCupon);

      ut_trace.trace('nuCupon ' || nuCupon, 5);

      if (nuCupon IS not null) then
        mo_boPackagePayment.InsertRegBasic(inuPackageId, null, nuPackPayId);

        --Se comenta Fragmento de codigo para no generar registro en MO_MOTIVE_PAYMENT
        /*
        -- Obtiene la fecha de vencimiento de la factura
        dtLimitDate:=cc_boBssUtil.fdtGetBillAccountExpiration(nuFacturaId);

        MO_BOMotivePayment.Register
        (
              null,
              inuPackageId,
              ut_convert.fsbToChar(nuFacturaId),
              dtLimitDate ,
              inuPayment,
              nuCupon,
              nuFacturaId,
              0,
              nuPackPayId
          );*/
      else
        ge_boerrors.seterrorcodeargument(2741,
                                         'No se ha realizado la creacion del cupon.');
      END if;

    end if;

    ut_trace.trace('Fin Ld_BoflowFNBPack.createCupon', 5);
  Exception
    When ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    When others then
      Errors.setError;
      RAISE ex.CONTROLLED_ERROR;
  END createCupon;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : createproducreal
  Descripcion    : recibe como parametro la solicitud e ventad, luego identifica la orden de entrega, paso siguiente recorre cada uno de los articulos de la ot de entrega,
                   e identifica los articulos, con los articulos (ld_article) identifica el servicio al cual esta asociado
                   (los articulos pueden tener configuradion brilla o brilla promigas) y preguntara si ya existe
                   para el cliente producto brilla o brilla promigas y si no existe crearlo
  Autor          : AAcuna
  Fecha          : 28/04/2013 09:55:27 a.m.

  Parametros              Descripcion
  ============            ===================
  inuPackage      :        Numero de solicitud
  inuSuscripc     :        Numero de suscripcion
  onuErrorCode    :        Numero de error
  osbErrorMessage :        Mensaje de error

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    =========       =========           ====================
	17/01/2024		jsoto 				(OSF-2019) Se reemplaza API OS_REGISTERREQUESTWITHXML por API_REGISTERREQUESTBYXML
    08-08-2016      KBaquero.C200-311   Se modifica para que busque si tiene un porducto en estado
                                        de prodcuto 1 (activo) p?ro con estado de corte no facturable
                                        se reactivar? para utilizar este mismo.
    13-11-2014      KCienfuegos.NC2860  Se modifica para que busque el codigo del producto
                                        del contrato titular, y no un producto inquilino.
    08-04-2014      aesguerra.3360      Se quita la activacion de la traza
    06-02-2013      AEcheverrySAO232141 Se modifica para que al obtner la solicitud
                                        de creacion de producto asociado, se valida
                                        si dicha solicitud no genero el producto
                                        entonces se ejecuta el servicio para la generacion del mismo
    15-01-2014      AEcheverrySAO229596 Se incluye la creacion del usuario de
                                        servicio cuando el usuario es inquilino
    22-11-2013      hjgomez.SAO224494   Se obtiene el estrato del producto de gas asociado al contrato
    23-10-2013      jrobayo.SAO221150   Se modifica para cambio de estado para productos
                                        creados por tipo de solicitud  100218
    23-10-2013      JCarmona.SAO221047  Se modifica para que obtenga la categoria y
                                        subcategoria del cliente deudor (inquilino)
                                        y no del cliente due?o del contrato (titular).
    17-oct-2013     AEcheverrySAO       Se renombra metodo CreateProduct para encapsularlo
    09-10-2013      JCarmona.SAO218821  Se modifica la estructura XML y se envia
                                        en el campo mo_packages.cust_care_reques_num
                                        la solicitud de interaccion de la venta FNB.
                                        Se modifica la fecha de registro para que
                                        almacene horas, minutos y segundos.
    04-09-2013      mmira.SAO213637     Se corrige la estructura XML, segun el
                                        producto a crear.
  ******************************************************************/
  PROCEDURE createproducReal(inuPackage      IN mo_packages.package_id%type,
                             iblProdOccupier in boolean,
                             onuProductId    out pr_product.product_id%type,
                             inuSubscriberId in ge_subscriber.subscriber_id%type,
                             onuErrorCode    OUT number,
                             osbErrorMessage OUT varchar2) IS

    frfArticle_id constants.tyrefcursor;
    recArticle_id dald_item_work_order.styLD_item_work_order;

    rcmo_packages damo_packages.stymo_packages;
    rcSaleRequest dald_non_ba_fi_requ.styLD_non_ba_fi_requ;

    nuTypePackage    number;
    nuCupon          number;
    sbLabelP         varchar2(200);
    sbLabelM         varchar2(200);
    sbLabelC         varchar2(200);
    sbLabelPack      varchar2(200);
    sbLabelAddr      varchar2(200);
    nuProduct        pr_product.product_id%type;
    nuProdType       pr_product.product_type_id%type;
    sbRequestXML     VARCHAR2(8000);
    nuPackageId      mo_packages.package_id%type;
    nuMotiveId       mo_motive.motive_id%type;
    nuSuscripc       suscripc.susccodi%type;
    vfinan           servicio.servcodi%type;
    nuMotive         mo_motive.motive_id%type;
    nuAnswerId       ld_parameter.numeric_value%type;
    nuClien          suscripc.suscclie%type;
    nuIdentType      ge_subscriber.ident_type_id%type;
    nuIdentification ge_subscriber.identification%type;
    rcPromissory     ld_promissory%rowtype;
    rcProduct        dapr_product.stypr_product;
    rcServsusc       servsusc%rowtype;
    nuSubcategory    number;
    nuCategory       number;
    nuGasProduct     pr_product.product_id%type;
    nuProductinact   pr_product.product_id%type;

    cnuActivityTypeFNB constant ld_parameter.numeric_value%type := dald_parameter.fnuGetNumeric_Value('ACTIVITY_TYPE_FNB');
    cnuRoleUser        CONSTANT NUMBER := 2;
    cnuRoleOwner       CONSTANT NUMBER := 3;

    Cursor cufinan is
      SELECT /*+ index (li PK_LD_ITEM_WORK_ORDER) index(li IX_LD_ITEM_WORK_ORDER01)  use_nl(li o) use_nl(oa o)*/
      distinct dald_article.fnuGetFinancier_Id(li.ARTICLE_ID)
        FROM or_order_activity oa, ld_item_work_order li
       WHERE oa.activity_id = cnuActivityTypeFNB
         AND li.order_id = oa.order_id
         and oa.order_activity_id = li.order_activity_id
         and oa.package_id = inuPackage;

    -- obtiene las solicitud de creacion de producto previas
    CURSOR cuGetPrevPack IS
      SELECT mo_packages.PACKAGE_id
        FROM mo_packages_asso, mo_packages
       WHERE mo_packages_asso.PACKAGE_id = inuPackage
         AND mo_packages_asso.PACKAGE_id_asso = mo_packages.PACKAGE_id
         AND mo_packages.PACKAGE_type_id in (100218, 100219);

    --Obtener el producto del titular
    cursor cu_ProductSubscrib(nuSuscription suscripc.susccodi%type, nuProductType pr_product.product_type_id%type) is
      select p.product_id
        from pr_product p, suscripc s
       where p.subscription_id = s.susccodi
         and p.subscription_id = nuSuscription
         and instr(dald_parameter.fsbGetValue_Chain('FNB_VALID_PROD_STATUS'),
                   p.product_status_id) > 0
         and p.product_type_id = nuProductType
         and not exists (select op.product_id
                from pr_subs_type_prod op, pr_product ps
               where op.product_id = p.product_id
                 and ps.product_type_id = nuProductType
                 and op.subscriber_id <> s.suscclie);

    /*Agosto/8 /2016 caso 200-311 JM - Karbaq*/
    cursor cu_ProductESTCORT(nuSuscription suscripc.susccodi%type, nuProduct pr_product.product_id%type, nutipoprod pr_product.PRODUCT_TYPE_ID%type) is
      select p.SESUNUSE
        from servsusc p, suscripc s
       where p.sesususc = s.susccodi
         and p.sesususc = nuSuscription
         and instr(dald_parameter.fsbGetValue_Chain('FNB_VALID_PROD_STATUS_FACT'),
                   p.SESUESCO) > 0
         and P.SESUNUSE = nuProduct
         AND P.SESUSERV = nutipoprod;

  BEGIN

    ut_trace.trace('Inicia Ld_BoflowFNBPack.createproducReal', 10);

    /*identifica datos de la solicitud*/
    rcmo_packages := damo_packages.frcGetRecord(inuPackage);

    if cufinan%isopen then
      CLOSE cufinan;
    END if;

    OPEN cufinan;
    FETCH cufinan
      INTO vfinan;
    IF cufinan%NOTFOUND THEN
      CLOSE cufinan;
      vfinan := -1;
      RAISE ex.CONTROLLED_ERROR;
    END IF;

    if cufinan%isopen then
      CLOSE cufinan;
    END if;

    ut_trace.trace('vfinan ' || vfinan, 5);

    nuSuscripc := rcmo_packages.subscription_pend_id;

    /*Valida Cual es el producto a crear (PROMIGAS | BRILLA)*/
    if vfinan =
       dald_parameter.fnuGetNumeric_Value(inuParameter_Id => ld_boconstans.cnuCodTypeProductBRP) then

      ut_trace.trace('Producto Brilla PromiGas ', 5);

      -- si no es un inquilino
      if (not iblProdOccupier) then

        /*identifica si tiene producto brilla promigas*/
        /*nuProduct := pr_boproduct.fnugetProdBySuscAndType(dald_parameter.fnuGetNumeric_Value(ld_boconstans.cnuCodTypeProductBRP),
        nuSuscripc );*/
        /*identifica si tiene producto titular brilla promigas*/
        open cu_ProductSubscrib(nuSuscripc,
                                dald_parameter.fnuGetNumeric_Value(ld_boconstans.cnuCodTypeProductBRP));
        fetch cu_ProductSubscrib
          into nuProduct;
        close cu_ProductSubscrib;

        ut_trace.trace('nuProduct ' || nuProduct, 5);

        --si existe producto brilla promigas se retorna
        if nuProduct is not null then

          /*Se obtiene el tipo de producto*/
          nuProdType := dapr_product.fnugetproduct_type_id(nuProduct);

          /*Se actualiza el producto y tipo de producto para todos los motivos de la venta*/
          ld_bcflowfnbpack.updMotiveProdTypeByPack(inuPackage,
                                                   nuProduct,
                                                   nuProdType);

          /* Inicia c200-311 Se consulta si este producto tiene el estado de corta no facturable*/
          open cu_ProductESTCORT(nuSuscripc, nuProduct, nuProdType);
          fetch cu_ProductESTCORT
            into nuProductinact;
          close cu_ProductESTCORT;

          /*Si el prodcuto brila tiene estado de corte no facturable*/
          if nuProductinact is not null then

            /*se produce el cambio de estado de corte*/
            begin

              pktblservsusc.updsesuesco(nuProductinact, 1);
              UPDATE OPEN.PR_COMPONENT
                 SET COMPONENT_STATUS_ID = 5
               WHERE PRODUCT_ID = nuProduct;
              --  commit;

            EXCEPTION
              when ex.CONTROLLED_ERROR then
                raise ex.CONTROLLED_ERROR;
              when others then
                Errors.setError;
                raise ex.CONTROLLED_ERROR;
            END;

          end if;
          /*Finaliza caso200-311*/

          rcSaleRequest := dald_non_ba_fi_requ.frcGetRecord(inuPackage);
          createCupon(rcmo_packages.operating_unit_id,
                      inuPackage,
                      nuProduct,
                      rcSaleRequest.payment);

          return;

        end if;
      END if;

      nuTypePackage := 100218;
      sbLabelPack   := 'PACKAGE_ID';
      sbLabelAddr   := 'ADDRESS_ID';
      sbLabelP      := 'P_VENTA_PROMIGAS_XML_100218';
      sbLabelM      := 'M_INSTALACION_DE_SERVICIOS_FINANCIEROS_PROMIGAS_100215';
      sbLabelC      := 'C_SERVICIOS_FINANCIEROS_PROMIGAS_10304';
    elsif vfinan =
          dald_parameter.fnuGetNumeric_Value(inuParameter_Id => ld_boconstans.cnuCodTypeProductBR) then

      ut_trace.trace('Producto Brilla ', 5);
      -- si no es un inquilino
      if (not iblProdOccupier) then

        /*identifica si tiene producto brilla */
        /*nuProduct := pr_boproduct.fnugetProdBySuscAndType(dald_parameter.fnuGetNumeric_Value( ld_boconstans.cnuCodTypeProductBR),
        nuSuscripc \*rcmo_packages.subscription_pend_id*\);*/
        /*identifica si tiene producto titular brilla activo */
        open cu_ProductSubscrib(nuSuscripc,
                                dald_parameter.fnuGetNumeric_Value(ld_boconstans.cnuCodTypeProductBR));
        fetch cu_ProductSubscrib
          into nuProduct;
        close cu_ProductSubscrib;

        ut_trace.trace('nuProduct ' || nuProduct, 5);
        --si existe producto brilla se retorna
        if nuProduct is not null then

          /*Se obtiene el tipo de producto*/
          nuProdType := dapr_product.fnugetproduct_type_id(nuProduct);

          /*Se actualiza el producto y tipo de producto para todos los motivos de la venta*/
          ld_bcflowfnbpack.updMotiveProdTypeByPack(inuPackage,
                                                   nuProduct,
                                                   nuProdType);

          /* Inicia c200-311 Se consulta si este producto tiene el estado de corta no facturable*/
          open cu_ProductESTCORT(nuSuscripc, nuProduct, nuProdType);
          fetch cu_ProductESTCORT
            into nuProductinact;
          close cu_ProductESTCORT;

          /*Si el prodcuto brila tiene estado de corte no facturable*/
          if nuProductinact is not null then

            /*se produce el cambio de estado de corte*/
            begin

              pktblservsusc.updsesuesco(nuProductinact, 1);
              UPDATE OPEN.PR_COMPONENT
                 SET COMPONENT_STATUS_ID = 5
               WHERE PRODUCT_ID = nuProduct;
              -- commit;
            EXCEPTION
              when ex.CONTROLLED_ERROR then
                raise ex.CONTROLLED_ERROR;
              when others then
                Errors.setError;
                raise ex.CONTROLLED_ERROR;
            END;

          end if;
          /*Finaliza caso200-311*/

          rcSaleRequest := dald_non_ba_fi_requ.frcGetRecord(inuPackage);
          createCupon(rcmo_packages.operating_unit_id,
                      inuPackage,
                      nuProduct,
                      rcSaleRequest.payment);

          return;
        end if;
      END if;
      nuTypePackage := 100219;
      sbLabelPack   := 'PACKAGE_ID';
      sbLabelP      := 'P_VENTA_SERVICIOS_FINANCIEROS_100219';
      sbLabelM      := 'M_INSTALACION_DE_SERVICIOS_FINANCIEROS_100218';
      sbLabelC      := 'C_SERVICIOS_FINANCIEROS_10306';
    end if;

    if (inuSubscriberId IS null) then
      /*Obtiene el cliente del contrato*/
      nuClien := pktblsuscripc.fnugetsuscclie(nuSuscripc);
      ut_trace.trace('nuClien: ' || nuClien, 5);

      /*Obtiene el tipo de identificacion e identificacion del cliente*/
      nuIdentType      := dage_subscriber.fnugetident_type_id(nuClien);
      nuIdentification := dage_subscriber.fsbgetidentification(nuClien);

      /*Obtiene pagare con el tipo de identificacion e identificacion del cliente*/
      rcPromissory := ld_bcflowfnbpack.frcgetPromiByTypeIden(nuIdentType,
                                                             nuIdentification);
    else
      /*Obtiene el tipo de identificacion e identificacion del cliente*/
      nuIdentType      := dage_subscriber.fnugetident_type_id(inuSubscriberId);
      nuIdentification := dage_subscriber.fsbgetidentification(inuSubscriberId);

      /*Obtiene pagare con el tipo de identificacion e identificacion del cliente*/
      rcPromissory := ld_bcflowfnbpack.frcgetPromiByTypeIden(nuIdentType,
                                                             nuIdentification);
    END if;

    --Obtengo el producto de gas para sacar la categoria y subcategoria
    nuGasProduct := ld_bononbankfinancing.fnugetGasProduct(nuSuscripc);
    ut_trace.trace('nuGasProduct: ' || nuGasProduct || '  nuSuscripc:' ||
                   nuSuscripc,
                   5);
    if nuGasProduct is not null then
      --dapr_product.getrecord(nuGasProduct, rcProduct);
      rcServsusc    := pktblservsusc.frcGetRecord(nuGasProduct);
      nuSubcategory := rcServsusc.Sesusuca;
      nuCategory    := rcServsusc.Sesucate;
    else
      nuSubcategory := rcPromissory.subcategory_id;
      nuCategory    := rcPromissory.category_id;
    end if;
    ut_trace.trace('nuSubcategory: ' || nuSubcategory || '  nuCategory:' ||
                   nuCategory,
                   5);
    /*Obtiene respuesta configurada en parametro ANSWER_ID_FNB*/
    nuAnswerId := dald_parameter.fnuGetNumeric_Value('ANSWER_ID_FNB');

    /*Valida que el parametro este configurado*/
    if (nuAnswerId IS null) then

      ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                       'El parametro ANSWER_ID_FNB no ha sido configurado');
    else

      open cuGetPrevPack;
      fetch cuGetPrevPack
        INTO nuPackageId;
      close cuGetPrevPack;

      -- si registra solicitud de creacion de producto si no se ha registrado una previamente
      if (nuPackageId IS null) then

        /*Arma el XML*/
        sbRequestXML := '<' || sbLabelP || ' ID_TIPOPAQUETE="' ||
                        to_char(nuTypePackage) || '">
           <CONTRACT>' || nuSuscripc /*rcmo_packages.subscription_pend_id*/
                        || '</CONTRACT>
               <INTERACCION>' ||
                        rcmo_packages.cust_care_reques_num ||
                        '</INTERACCION>
           <FECHA_DE_SOLICITUD>' ||
                        ut_date.fdtdatewithformat(sysdate) ||
                        '</FECHA_DE_SOLICITUD>
           <RECEPTION_TYPE_ID>' ||
                        rcmo_packages.reception_type_id ||
                        '</RECEPTION_TYPE_ID>
           <CONTACT_ID>' ||
                        rcmo_packages.subscriber_id || '</CONTACT_ID>';

        IF (sbLabelAddr IS not null) then
          sbRequestXML := sbRequestXML || '
                    <' || sbLabelAddr || '>' ||
                          rcmo_packages.address_id || '</' || sbLabelAddr || '>';
        END if;

        sbRequestXML := sbRequestXML || '
               <COMMENT_>FIFAP</COMMENT_>
               <CATEGORIA>' || nuCategory ||
                        '</CATEGORIA>
               <SUBCATEGORIA>' || nuSubcategory ||
                        '</SUBCATEGORIA>
               <' || sbLabelPack || '>' ||
                        inuPackage || '</' || sbLabelPack || '>
                <' || sbLabelM || '>
               <ANSWER_ID>' || nuAnswerId ||
                        '</ANSWER_ID>
               <' || sbLabelC || ' />
               </' || sbLabelM || '>
               </' || sbLabelP || '>';

        ut_trace.trace('XML registrar producto: ' || sbRequestXML, 10);

        /*Crea el producto*/
        execute immediate 'ALTER SESSION SET NLS_DATE_FORMAT = ' ||
                          '''DD-MM-YYYY HH24:MI:SS''';

        api_registerrequestbyxml(sbRequestXML,
                                  nuPackageId,
                                  nuMotiveId,
                                  onuErrorCode,
                                  osbErrorMessage);
        gw_boerrors.checkerror(onuErrorCode, osbErrorMessage);

      else
        nuMotiveId := mo_bopackages.fnugetinitialmotive(nuPackageId);
        if damo_motive.fnugetproduct_id(nuMotiveId, 0) IS null then
          -- se ejecuta la accion de creacion de producto
          PR_BOCREATIONPRODUCT.INITIALCREATIONPRODUCT(nuPackageId);
        END if;
      END if;
      ut_trace.trace('Existente -->nuMotiveId-' || nuMotiveId ||
                     '-nuPackageId ' || nuPackageId,
                     5);
    END if;

    if (nuPackageId is not null) then

      /*Obtiene el producto asociado al motivo*/
      nuProduct := damo_motive.fnuGetProduct_Id(nuMotiveId);

      -- por si acaso (aunque no deberia estar)
      if nuProduct IS null then
        -- se ejecuta la accion de creacion de producto
        PR_BOCREATIONPRODUCT.INITIALCREATIONPRODUCT(nuPackageId);

        nuProduct := damo_motive.fnuGetProduct_Id(nuMotiveId);
      END if;

      /*Se obtiene el tipo de producto*/
      nuProdType := dapr_product.fnugetproduct_type_id(nuProduct);

      /*Se actualiza el producto y tipo de producto para todos los motivos de la venta*/
      ld_bcflowfnbpack.updMotiveProdTypeByPack(inuPackage,
                                               nuProduct,
                                               nuProdType);

      --identifica la fecha de venta
      rcSaleRequest := dald_non_ba_fi_requ.frcGetRecord(inuPackage);

      createCupon(rcmo_packages.operating_unit_id,
                  inuPackage,
                  nuProduct,
                  rcSaleRequest.payment);

      -- se retorna el producto creado
      onuProductId := nuProduct;

      if (iblProdOccupier) then
        -- se crea el usuario de servicio del producto pr_subs_type_prod
        pr_bosubsbyproduct.regproductcustomer(nuProduct,
                                              dapr_product.fsbgetservice_number(nuProduct),
                                              cnuRoleUser,
                                              inuSubscriberId,
                                              sysdate);
      end if;

    end if;

    ut_trace.trace('Fin Ld_BoflowFNBPack.createproducReal', 10);

  Exception
    When ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    When others then
      Errors.setError;
      RAISE ex.CONTROLLED_ERROR;
  END createproducReal;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : createproduc
  Descripcion    :

  Parametros              Descripcion
  ============            ===================
  inuPackage      :        Numero de solicitud
  inuSuscripc     :        Numero de suscripcion
  onuErrorCode    :        Numero de error
  osbErrorMessage :        Mensaje de error

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    =========       =========           ====================
    15-01-2014      AEcheverrySAO229596 Se Crea el producto si la venta no fue realizada
                                        por el EXITO.
    15-01-2013      AEcheverrySAOxxxxx  AEcheverry Se encapsula metodo para incluir
                                        nuevos parametros sin afectar el flujo
  ******************************************************************/
  PROCEDURE createproduc(inuPackage      IN mo_packages.package_id%type,
                         inuSuscripc     IN suscripc.susccodi%type,
                         onuErrorCode    OUT number,
                         osbErrorMessage OUT varchar2) IS

    nuProductId pr_product.product_id%type;

  BEGIN

    ut_trace.trace('inicio Ld_BoflowFNBPack.createproduc', 10);

    -- Si la venta es del EXITO no se debe generar el producto, esto lo realizara el JOB
    if (ld_boflowfnbpack.fnuValidaGranSuper(inuPackage) <> 1) then
      createproducReal(inuPackage,
                       false,
                       nuProductId,
                       null,
                       onuErrorCode,
                       osbErrorMessage);
    END IF;

    ut_trace.trace('Fin Ld_BoflowFNBPack.createproduc', 10);

  Exception
    When ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    When others then
      Errors.setError;
      RAISE ex.CONTROLLED_ERROR;
  END createproduc;
  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).


  Unidad         : CreateDelivery
  Descripcion    : Crea ordenes de entrega
  Autor          : Eduar Ramos
  Fecha          : 10/04/2013

  Parametros              Descripcion
  ============         ===================
  inupackage_id         identificador del paquete.


  Historia de Modificaciones
  Fecha             Autor               Modificacion
  =========       =========             ====================
  16-05-2017      Jorge Valiente        CASO 200-1164: Creacion de cursor para identificar articulo configurado
                                                       para generacion orden de entrega de CARDIF
                                                       Registrar datos de venta de seguro.
  28-10-2017      KCienfuegos.RNP1808   Se modifica para validar si fue una venta empaquetada, para
                                        registrar la orden de instalacion.
  10-10-2014      KCienfuegos.RNP1179   Se modifica para validar si se debe crear orden de instalacion
                                        de gasodomestico.
  ******************************************************************/
  PROCEDURE CreateDelivery(inupackage_id IN mo_packages.package_id%TYPE)

   IS

    rgmo_packages      damo_packages.styMO_packages;
    rcSaleRequest      dald_non_ba_fi_requ.styLD_non_ba_fi_requ;
    tbItems            ld_bcnonbankfinancing.tytbItemWordPack;
    nuIndex            number;
    nuOrderDev         or_order.order_id%type;
    nuActivityDev      or_order_activity.order_activity_id%type;
    tbSuppliSett       dald_suppli_settings.tytbLD_suppli_settings;
    nuerror            ge_message.message_id%type;
    sbmessage          ge_message.description%type;
    nuSupplier         number := 0;
    nuIdxLegalize      number;
    nuContractorId     number;
    tbPOS_Settings     Dald_Pos_Settings.tytbLD_pos_settings;
    nuOperatingUnit    or_operating_unit.operating_unit_id%type;
    rcOperUnitSupplier or_operating_unit%rowtype;
    nuContInst         number;
    nuValOrder         number := 0;
    nuOrderDl          or_order.order_id%type;
    nuOrdActivit       or_order_activity.order_activity_id%type;
    nuContVtaEmpaq     number := 0;

    /*Obtiene el registro de instalacion de gasodomestico*/
    cursor cu_ldc_instal_gasodom_fnb is
      select count(1)
        from ldc_instal_gasodom_fnb ig
       where ig.package_id = inupackage_id;

    /*Obtiene el registro de venta empaquetada*/
    cursor cu_ldc_venta_empaquetada is
      select count(1)
        from ldc_venta_empaquetada ve
       where ve.package_fnb_id = inupackage_id
         and ve.gas_applianc_sale = ld_boconstans.csbYesFlag;

  BEGIN

    rgmo_packages := damo_packages.frcGetRecord(inuPackage_Id => inupackage_id);

    rcSaleRequest := dald_non_ba_fi_requ.frcGetRecord(inupackage_id);

    nuContractorId := daor_operating_unit.fnuGetContractor_Id(rgmo_packages.operating_unit_id);
    -- se valida la parametrizacion de la unidad
    if (nuContractorId IS null) then
      ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                       'No posee configuracion para el proveedor');
    END if;

    dald_suppli_settings.getRecords('ld_suppli_settings.supplier_id = ' ||
                                    nuContractorId,
                                    tbSuppliSett);

    /*Obtiene los items, no anulados, de la solicitud de venta*/
    tbItems := ld_bcnonbankfinancing.ftbGetItemWorkOrderByPack(inupackage_id);

    if tbSuppliSett.count > 0 then

      /*Recorre los items*/
      nuIndex := tbItems.first;

      /*Consulta si es venta con instalacion*/
      open cu_ldc_instal_gasodom_fnb;
      fetch cu_ldc_instal_gasodom_fnb
        into nuContInst;
      close cu_ldc_instal_gasodom_fnb;

      /*Consulta si es venta empaquetada*/
      open cu_ldc_venta_empaquetada;
      fetch cu_ldc_venta_empaquetada
        into nuContVtaEmpaq;
      close cu_ldc_venta_empaquetada;

      while nuIndex is not null loop

        if nuSupplier <> tbItems(nuIndex).supplier_id then
          nuOrderDev := null;
        end if;

        ld_bononbankfinancing.createDeliveryOrderActivity(tbItems(nuIndex)
                                                          .order_activity_id,
                                                          nuOrderDev,
                                                          nuActivityDev);

        nuSupplier := tbItems(nuIndex).supplier_id;

        /*Valida si se creo una orden de entrega y si requiere instalacion de gasodomestico*/
        if nuOrderDev is not null and
           (nvl(nuContInst, -1) > 0 or nvl(nuContVtaEmpaq, -1) > 0) then

          /*Valida si ya se obtuvo los datos de la actividad y de la orden*/
          if nuValOrder = 0 then
            nuOrdActivit := tbItems(nuIndex).order_activity_id;
            nuOrderDl    := nuOrderDev;
            nuValOrder   := 1;
          end if;

        end if;

        if (tbItems(nuIndex).supplier_id = nuContractorId) then
          /*Obteniene la configuracion de la unidad operativa*/
          begin
            dald_pos_settings.GetRecords(' ld_pos_settings.pos_id =' ||
                                         rgmo_packages.operating_unit_id,
                                         tbPOS_Settings);

            nuOperatingUnit := tbPOS_Settings(tbPOS_Settings.first)
                              .default_operating_unit;

          EXCEPTION
            WHEN ex.CONTROLLED_ERROR THEN
              if (ld_bccancellations.fsbGetPostLegProcBySupplierId(tbItems(nuIndex)
                                                                   .supplier_id) = 'Y') then
                RAISE ex.CONTROLLED_ERROR;
              else
                nuOperatingUnit := rgmo_packages.operating_unit_id;
              END if;

          END;

          /*Asigna la orden de venta a la unidad */
          or_boprocessorder.ProcessOrder(nuOrderDev,
                                         null,
                                         nuOperatingUnit,
                                         null,
                                         FALSE,
                                         NULL,
                                         NULL);
        else

          begin
            dald_pos_settings.getRecords(' ld_pos_settings.supplier_id = ' ||
                                         tbItems(nuIndex)
                                         .supplier_id ||
                                         ' order by ld_pos_settings.pos_settings_id ',
                                         tbPOS_Settings);

            nuOperatingUnit := tbPOS_Settings(tbPOS_Settings.FIRST)
                              .DEFAULT_OPERATING_UNIT;
          EXCEPTION
            WHEN ex.CONTROLLED_ERROR THEN
              if (ld_bccancellations.fsbGetPostLegProcBySupplierId(tbItems(nuIndex)
                                                                   .supplier_id) = 'Y') then
                RAISE ex.CONTROLLED_ERROR;
              else
                rcOperUnitSupplier := ld_bcflowfnbpack.frcgetOperUnitSupplier(tbItems(nuIndex)
                                                                              .supplier_id);
                nuOperatingUnit    := rcOperUnitSupplier.operating_unit_id;
              END if;

          END;

          or_boprocessorder.ProcessOrder(nuOrderDev,
                                         null,
                                         nuOperatingUnit,
                                         null,
                                         FALSE,
                                         NULL,
                                         NULL);

        end if;

        nuIndex := tbItems.next(nuIndex);
      end loop;

      /*Se crea la orden de instalacion de gasodomestico RNP1179*/
      if nvl(nuContInst, -1) > 0 and nuOrderDl is not null then
        createinstallationorder(inupackage_id,
                                nuOrdActivit,
                                nuOperatingUnit);

        /*Se crea la orden de instalacion por venta empaquetada RNP1808*/
      elsif nvl(nuContVtaEmpaq, -1) > 0 and nuOrderDl is not null then
        LDC_BOVentaEmpaquetada.CreateInstallGasFnbOrder(inupackage_id,
                                                        nuOrdActivit,
                                                        null);

      end if;

      --Incio CASO 200-1164
      --Registrar datos de venta de seguro CARDIF
      --despues de generar orden de entrega
      ldc_pkventasegurovoluntario.prregistroventaseguro(inupackage_id);
      --Fin CASO 200-1164

    else

      ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                       'No posee configuracion para el proveedor');

    end if;

  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      Errors.setError;
      RAISE ex.CONTROLLED_ERROR;
  END CreateDelivery;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ftbValidateFlowmove
  Descripcion    : Obtiene todas las actividades que se ecuentren en estado stop a partir
                   de una determinada accion y actividad.


  Autor          : AAcuna
  Fecha          : 29/04/2013

  Parametros          Descripcion
  ============     ===================
  inuAccion       Numero de accion
  inuActivity     Numero de actividad


  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  29/04/2013    AAcuna.SAO139854      Creacion
  ******************************************************************/

  PROCEDURE procvalidateFlowmove(inuAccion       in Mo_Wf_Pack_Interfac.Action_Id%type,
                                 inuPackage_Id   in Mo_Wf_Pack_Interfac.Package_Id%type,
                                 onuErrorCode    OUT number,
                                 osbErrorMessage OUT varchar2) IS

    tbInterface   damo_wf_pack_interfac.tytbWf_Pack_Interfac_Id;
    rcInterfaceId damo_wf_pack_interfac.styMO_wf_pack_interfac;
    nuInterfaceId Mo_Wf_Pack_Interfac.Activity_id%type;

  BEGIN

    ut_trace.trace('Inicia Ld_BoflowFNBPack.procvalidateFlowmove', 10);

    tbInterface :=  /*ld_bcflowfnbpack.*/
     LD_bcflowFNBPack.ftbValidateFlowmove(inuAccion,
                                                        inuPackage_Id);

    /*Si encuentra datos continua con el proceso*/

    if tbInterface.count > 0 then

      for i in tbInterface.FIRST .. tbInterface.LAST loop

        if tbInterface.EXISTS(i) then

          /*Se obtiene el sesunuse para verificar si es de tipo brilla
          promigas o brilla*/

          nuInterfaceId := tbInterface(i);

          damo_wf_pack_interfac.getRecord(nuInterfaceId, rcInterfaceId);

          /*Se llama el servicio para hacer continuar el flujo*/

          mo_bowf_pack_interfac.PrepNotToWfPack(rcInterfaceId.package_id,
                                                inuAccion,
                                                MO_BOCausal.fnuGetSuccess,
                                                MO_BOStatusParameter.fnuGetSTA_ACTIV_STANDBY,
                                                FALSE);

        end if;

      end loop;

    end if;

    ut_trace.trace('Fin Ld_BoflowFNBPack.procvalidateFlowmove', 10);

  Exception
    When ex.CONTROLLED_ERROR Then
      Raise ex.CONTROLLED_ERROR;
    When Others Then
      Errors.setError;
      Raise ex.CONTROLLED_ERROR;
  End procvalidateFlowmove;

  /**************************************************************
  Propiedad intelectual de Open International Systems (c).
  Unidad      :  RegChargeFinancing
  Descripcion :  Registra financiacion para el cargo enviado

  Autor       :  Luis E. Fernandez
  Fecha       :  26-08-2013
  Parametros  :

      inuProducto     Producto
      inuAccount      Cuenta
      inuPlanDife     Plan de financiacion
      inuDifeNucu     Numero de cuotas
      isbDocuSopo     Documento de soporte
      itbCargos       Coleccion de cargos

  Historia de Modificaciones
  Fecha       Autor               Modificacion
  =========   =========           ====================
  21-08-2014  KCienfuegos.NC1664  Se modifica procedimiento FinanciarConceptosFactura
                                  para corregir la fecha final del periodo de gracia.
  26-08-2013  lfernandez.SAO212650 Creacion
  ***************************************************************/
  PROCEDURE RegChargeFinancing(inuProducto     in servsusc.sesunuse%type,
                               inuAccount      in cuencobr.cucocodi%type,
                               inuPlanDife     in plandife.pldicodi%type,
                               inuDifeNucu     in diferido.difenucu%type,
                               isbDocuSopo     in cargos.cargdoso%type,
                               idtFirstPayDate in diferido.difefein%type,
                               itbCargos       in FI_BOVentasDirectasFinanciadas.tytbCargos) IS
    ------------------------------------------------------------------------
    --  Variables
    ------------------------------------------------------------------------
    rcPlanDife    plandife%rowtype;
    tbBillAccount mo_tytbBillAccount;
    tbCharges     mo_tytbCharges;
    ------------------------------------------------------------------------
    PROCEDURE LoadConceptBalance(itbBillAccount in mo_tytbBillAccount,
                                 itbCharges     in mo_tytbCharges) IS
      /* PRAGMA para implementacion de transacciones autonomas */
      PRAGMA AUTONOMOUS_TRANSACTION;
    BEGIN

      UT_Trace.Trace('LD_boflowFNBPack.RegChargeFinancing.LoadConceptBalance',
                     16);

      -- Inicializa la tabla temporal
      DELETE cc_tmp_bal_by_conc;

      INSERT INTO cc_tmp_bal_by_conc
        (tmp_bal_by_concept_id,
         selected,
         subscription_id,
         product_id,
         base_product_id,
         product_type_id,
         concept_id,
         deferrable,
         pending_balance,
         tax_pending_balance,
         financing_balance,
         tax_financing_balance,
         not_financing_balance,
         cancel_serv_estat_id,
         account_number,
         financing_concept_id,
         balance_account,
         amount_account_total,
         payment_date,
         expiration_date,
         company_id,
         is_interest_concept,
         discount_percentage)
        SELECT /*+ leading( charges )
                                                                                                                                                                use_nl( charges concepto )
                                                                                                                                                                use_nl( charges servsusc )
                                                                                                                                                                use_nl( servsusc estacort )
                                                                                                                                                                index( concepto PK_CONCEPTO )
                                                                                                                                                                index( servsusc PK_SERVSUSC )
                                                                                                                                                                index( estacort PK_ESTACORT ) */
         ROWNUM nuIndex, -- Consecutivo para identificar el concepto
         GE_BOConstants.csbYES selected,
         sesususc,
         product_id,
         null,
         sesuserv product_type_id,
         concept_id,
         nvl(concdife, pkConstante.NO) deferrable,
         SaldoConc,
         pkBillConst.CERO SaldoIva,
         SaldoConc financing_balance,
         pkBillConst.CERO tax_financing_balance,
         0 not_financing_balance,
         sesuesco,
         bill_account_id, --cargcuco,
         conccore,
         bill_account_balance, --cucosacu,
         bill_acc_total_value, --cucovato,
         payment_date, --cucofepa,
         expiration_date, --cucofeve
         sesusist,
         (SELECT 'Y'
            FROM concepto
           WHERE (conccoin = concept_id and ROWNUM = 1)) SourceConceptIsIntConcept,
         apply_for_discount
          FROM ( /******************************************************************/
                /* Cartera corriente que se encuentra causada                     */
                /******************************************************************/
                SELECT /*+ leading( ba )
                                                                                                                                                                                                                                                                                                            use_nl( ba g ) */
                 g.product_id,
                  g.concept_id,
                  nvl(sum(g.balance), 0) SaldoConc,
                  g.bill_account_id,
                  bill_account_balance,
                  bill_acc_total_value,
                  payment_date,
                  expiration_date,
                  pkBillConst.CERO apply_for_discount
                  FROM TABLE(CAST(itbCharges AS mo_tytbCharges)) g,
                        TABLE(CAST(itbBillAccount AS mo_tytbBillAccount)) ba
                 WHERE g.bill_account_id = ba.bill_account_id
                   AND charge_value > pkBillConst.CERO HAVING
                 nvl(sum(g.balance), 0) <> 0
                 GROUP BY g.product_id,
                           g.bill_account_id,
                           g.concept_id,
                           bill_account_balance,
                           bill_acc_total_value,
                           payment_date,
                           expiration_date) charges,
               concepto,
               servsusc,
               estacort
         WHERE conccodi = concept_id
           AND sesunuse = product_id
           AND escocodi = sesuesco;

      -- Se verifica si se insertaron registros en la tabla temporal
      ut_trace.trace('-- Se insertaron ' || sql%rowcount ||
                     ' registros en la tabla temporal',
                     1);

      -- Evita dejar nulos
      UPDATE cc_tmp_bal_by_conc
         SET is_interest_concept     = nvl(is_interest_concept,
                                           pkConstante.NO),
             pend_balance_to_finance = 0,
             tax_bal_to_finance      = 0;

      /* Se asientan los cambios realizados en la base de datos */
      pkGeneralServices.CommitTransaction;

      UT_Trace.Trace('Fin LD_boflowFNBPack.RegChargeFinancing.LoadConceptBalance',
                     16);

    EXCEPTION
      when LOGIN_DENIED OR pkConstante.exERROR_LEVEL2 OR
           ex.CONTROLLED_ERROR then
        /* Se reversan los cambios realizados en la base de datos */
        pkGeneralServices.RollBackTransaction;
        raise;
      when OTHERS then
        /* Se reversan los cambios realizados en la base de datos */
        pkGeneralServices.RollBackTransaction;
        Errors.SetError;
        raise ex.CONTROLLED_ERROR;
    END LoadConceptBalance;
    ------------------------------------------------------------------------
    PROCEDURE LoadChargesFromBillAcc(otbCharges out nocopy mo_tytbCharges) IS
    BEGIN

      UT_Trace.Trace('LD_boflowFNBPack.RegChargeFinancing.LoadChargesFromBillAcc',
                     16);

      SELECT CAST(MULTISET (SELECT inuAccount, -- BILL_ACCOUNT_ID
                          inuProducto, -- PRODUCT_ID
                          pktblservsusc.fnugetservice(inuProducto), --sesuserv, -- PRODUCT_TYPE_ID
                          itbCargos(1) .cargconc, -- CONCEPT_ID
                          1, -- CHARGE_CAUSE
                          itbCargos(1) .cargsign, -- SIGN_
                          1, -- BILLING_PERIOD
                          itbCargos(1) .cargvalo, -- CHARGE_VALUE
                          '-', -- DOCUMENT_SUPPORT
                          1, -- DOCUMENT_ID
                          1, -- PROCESS_TYPE
                          1, -- UNITS
                          sysdate, -- CREATION_DATE
                          1, -- PROGRAM
                          1, -- CALL_SEQUENCE
                          1, -- OUTSIDER_MONEY_VALUE
                          itbCargos(1) .cargvalo, -- BALANCE   ,
                          0, -- ORIGINAL_BALANCE
                          null, -- LIST_DIST_CREDITS
                          1, -- ROW_NUMBER_
                          pkConstante.NO, -- IS_DISCOUNT
                          0, -- DISCOUNT_PERCENTAGE
                          1 -- USERNAME
                     FROM dual) AS mo_tytbCharges)
        INTO otbCharges
        FROM dual;

      UT_Trace.Trace('Fin LD_boflowFNBPack.RegChargeFinancing.LoadChargesFromBillAcc',
                     16);

    EXCEPTION
      when LOGIN_DENIED OR pkConstante.exERROR_LEVEL2 OR
           ex.CONTROLLED_ERROR then
        raise;
      when OTHERS then
        Errors.SetError;
        raise ex.CONTROLLED_ERROR;
    END LoadChargesFromBillAcc;
    ------------------------------------------------------------------------
    PROCEDURE LoadBillAccByAccStatus(otbBillAccount out nocopy mo_tytbBillAccount) IS
    BEGIN

      UT_Trace.Trace('LD_boflowFNBPack.RegChargeFinancing.LoadBillAccByAccStatus',
                     16);

      SELECT CAST(MULTISET (SELECT /*+ ORDERED use_nl (CUENCOBR, SERVSUSC)
                                                                                                                                                                                                                                                                                                                                                                   index(CUENCOBR PK_CUENCOBR)
                                                                                                                                                                                                                                                                                                                                                                   index(SERVSUSC PK_SERVSUSC) */
                    CUCOCODI, --BILL_ACCOUNT_ID
                    SESUSUSC, --SUBSCRIBER_ID
                    CUCODEPA, --DEPARTMENT_ID
                    CUCOLOCA, --LOCATE_ID
                    CUCOPLSU, --BILLING_PLAN_ID
                    CUCOCATE, --BILLING_CATEGORY_ID
                    CUCOSUCA, --BILL_SUBCATEGORY_ID
                    CUCOVAAP, --AUTHORIZED_PAY_VALUE
                    CUCOVARE, --CLAIM_VALUE
                    CUCOVAAB, --PARTIAL_PAY_VALUE
                    CUCOVATO, --BILL_ACC_TOTAL_VALUE
                    CUCOFEPA, --PAYMENT_DATE
                    CUCONUSE, --PRODUCT_ID
                    CUCOSACU, --BILL_ACCOUNT_BALANCE
                    CUCOVRAP, --NOT_PAID_CLAIM_VALUE
                    CUCOFACT, --BILL_ID
                    SESUSERV, --PRODUCT_TYPE_ID
                    CUCOFAAG, --BILL_GROUPING_ID
                    CUCOFEVE, --EXPIRATION_DATE
                    CUCOVAFA, --BILLING_VALUE
                    CUCOIMFA, --BILLING_TAX_VALUE
                    CUCOSIST, --COMPANY_ID
                    CUCOGRIM --PRINT_GROUP
                     FROM /*+LD_boflowFNBPack.RegChargeFinancing.LoadBillAccByAccStatus*/
                          CUENCOBR,
                          SERVSUSC
                    WHERE cucocodi = inuAccount
                      AND cucocodi != pkBillConst.NULOSAT
                      AND cuconuse = sesunuse) AS mo_tytbBillAccount)
        INTO otbBillAccount
        FROM dual;

      UT_Trace.Trace('Fin LD_boflowFNBPack.RegChargeFinancing.LoadBillAccByAccStatus',
                     16);

    EXCEPTION
      WHEN LOGIN_DENIED OR pkConstante.exERROR_LEVEL2 OR
           ex.CONTROLLED_ERROR then
        raise;
      when others then
        Errors.setError;
        raise ex.CONTROLLED_ERROR;
    END LoadBillAccByAccStatus;
    ------------------------------------------------------------------------
    PROCEDURE SetAccountStatus IS
    BEGIN

      UT_Trace.Trace('LD_boflowFNBPack.RegChargeFinancing.SetAccountStatus',
                     16);

      cc_bcfinancing.ClearMemTables;
      CC_BOFinancing.ClearMemoryFinancing;

      -- Inicializa tabla de conceptos y colecciones
      cc_bcfinancing.clearBalByConcept;

      -- Carga de colecciones
      LoadBillAccByAccStatus(tbBillAccount);

      LoadChargesFromBillAcc(tbCharges);

      /* Se carga la coleccion de saldos por concepto con la deuda a financiar
      para la suscripcion */
      LoadConceptBalance(tbBillAccount, tbCharges);

      UT_Trace.Trace('Fin LD_boflowFNBPack.RegChargeFinancing.SetAccountStatus',
                     16);

    EXCEPTION
      WHEN LOGIN_DENIED OR pkConstante.exERROR_LEVEL2 OR
           ex.CONTROLLED_ERROR then
        raise;
      when others then
        Errors.setError;
        raise ex.CONTROLLED_ERROR;
    END SetAccountStatus;
    ------------------------------------------------------------------------
    PROCEDURE FinanciarConceptosFactura IS
      -- Numero de productos a financiar
      nuNumProdsFinanc number;
      -- Variables de salida del proceso de financiacion
      onuAcumCuota         number;
      onuSaldo             number;
      onuTotalAcumCapital  number;
      onuTotalAcumCuotExtr number;
      onuTotalAcumInteres  number;
      osbRequiereVisado    varchar2(1);
      nuDifeCofi           diferido.difecofi%type;
      nuQuotaMethod        plandife.pldimccd%type;
      nuTaincodi           plandife.plditain%type;
      nuInteRate           plandife.pldipoin%type;
      nuGracePeriod        cc_grace_period.grace_period_id%type;
      nuGraceDays          number;
      dtFirstPaymDate      date;
      boSpread             boolean;
    BEGIN

      UT_Trace.Trace('LD_boflowFNBPack.RegChargeFinancing.FinanciarConceptosFactura',
                     16);

      -- Se asigna el consecutivo de financiacion
      pkDeferredMgr.nuGetNextFincCode(nuDifeCofi);

      -- Se instancian en la tabla temporal de saldos por concepto, los
      -- conceptos de la factura
      SetAccountStatus;

      -- Se actualiza la tabla temporal para que sean procesados solo los conceptos
      -- financiables
      CC_BCFinancing.SelectAllowedProducts(pkConstante.SI,
                                           nuNumProdsFinanc);

      -- Obtiene tasa de interes
      pkDeferredPlanMgr.ValPlanConfig(rcPlandife.pldicodi,
                                      pkGeneralServices.fdtGetSystemDate,
                                      nuQuotaMethod,
                                      nuTaincodi,
                                      nuInteRate,
                                      boSpread);

      pkErrors.SetApplication(CC_BOConstants.csbCUSTOMERCARE);

      /*Se obtiene el periodo de gracia del plan de financiacion*/
      nuGracePeriod := pktblplandife.fnugetpldipegr(inuPlandife);

      if nuGracePeriod is not null then
        nuGraceDays     := daCC_GRACE_PERIOD.fnugetmax_grace_days(nuGracePeriod);
        dtFirstPaymDate := ut_date.fdtsysdate + nvl(nuGraceDays, 0);
      else
        dtFirstPaymDate := idtFirstPayDate;
      end if;

      -- Se ejecuta el proceso de financiacion
      CC_BOFinancing.ExecDebtFinanc(rcPlandife.pldicodi,
                                    rcPlandife.pldimccd,
                                    dtFirstPaymDate, --idtFirstPayDate,
                                    nuInteRate,
                                    pkBillConst.CERO,
                                    inuDifeNucu,
                                    isbDocuSopo,
                                    pkBillConst.CIENPORCIEN,
                                    pkBillConst.CERO,
                                    pkConstante.NO,
                                    pkErrors.fsbGetApplication,
                                    pkConstante.NO,
                                    pkConstante.NO,
                                    nuDifeCofi,
                                    onuAcumCuota,
                                    onuSaldo,
                                    onuTotalAcumCapital,
                                    onuTotalAcumCuotExtr,
                                    onuTotalAcumInteres,
                                    osbRequiereVisado,
                                    'Y');

      -- Se guarda la informacion de la financiacion en la base de datos
      CC_BOFinancing.CommitFinanc;

      UT_Trace.Trace('Fin LD_boflowFNBPack.RegChargeFinancing.FinanciarConceptosFactura',
                     16);

    EXCEPTION
      when LOGIN_DENIED OR pkConstante.exERROR_LEVEL2 OR
           ex.CONTROLLED_ERROR then
        raise;
      when OTHERS then
        Errors.SetError;
        raise ex.CONTROLLED_ERROR;
    END FinanciarConceptosFactura;
    ------------------------------------------------------------------------
  BEGIN
    --{
    UT_Trace.Trace('LD_boflowFNBPack.RegChargeFinancing', 15);

    --  Obtiene la informacion del plan de financiacion
    rcPlanDife := pktblPlandife.frcGetRecord(inuPlanDife);

    -- Se financia la factura generada
    FinanciarConceptosFactura;

    UT_Trace.Trace('Fin LD_boflowFNBPack.RegChargeFinancing', 15);

  EXCEPTION
    when LOGIN_DENIED OR pkConstante.exERROR_LEVEL2 OR ex.CONTROLLED_ERROR then
      raise;
    when OTHERS then
      Errors.SetError;
      raise ex.CONTROLLED_ERROR;
  END RegChargeFinancing;

  /**************************************************************
  Propiedad intelectual de Open International Systems (c).
  Unidad      :  CreateDelivOrderCharg
  Descripcion :  Crea los cargos de la orden de entrega

  Autor       :  Luis E. Fernandez
  Fecha       :  27-08-2013
  Parametros  :

      inuOrder        Codigo de la orden
      inuPackage      Codigo del paquete
      inuCause        Codigo de la causa
      inuBilledValue  Valor facturado
      iboIsSupplier   Es proveedor?
      ionuAccount     Codigo de la cuenta     (se actualiza)
      ionuValorAbono  Valor del abono         (va disminuyendo)
      ionuValTotVen   Valor total de la venta (va disminuyendo)

  Historia de Modificaciones
  Fecha       Autor               Modificacion
  =========   =========           ====================
  22-04-2014  SLemus.ARA7049      Se modifica el parametro que recibe el procedimiento
                                  FA_BOBillingNotes.DetailRegister para que reciba el numero
                                  de solicitud al momento de crear el detalle de la nota.
  03-07-2014  AEcheverry.4074          Se aplica politica de redondeo al valor de
                                      los items y a la proporcion de cuto inicial
                                      que le corresponde

  13-06-2014  aesguerra.3853          Se modifica para generar notas debito en lugar de cargos
                  cuando la factura ya existe, ya que presentaba inconvenientes
                  con la interfaz contable.
  10-04-2014  aesguerra.3374          Se modifica la parte que actualiza cartera para poder
                  financiar. Ahora no se fija un valor en cucovato sino que
                  suma sobre el valor anterior. Esto con el fin de no
                  descuadrar la cuenta cuando la venta la hizo un contratista
                  y hubo cuota inicial
  04-04-2014  AEcheverry.SAO237025    Se modifica para que se generen los cargos
                                      con el tipo de proceso automatico
  25-03-2014  AEcheverry.SAO236047    se modifica para que realice los movimientos
                                      correctamente cuando se tiene cuota inicial
  17-03-2014  AEcheverry.SAO235311    Se modifica para que cuando sea proveedor
                                      y pago de contado actualice el diferido a cero
  25-02-2014  eurbano.SAO234145
  se modifica para:
  1. tener en cuenta el escenario en que la venta se realiza en el proveedor y
  se realiza el pago total para que no cree cargos ni cuentas de cobro.
  2. tener en cuenta el escenario en que se realiza un pago parcial y se
  debe distribuir el valor en cada uno de los articulos.

  09-12-2013  JCarmona.SAO226625  Se modifica para que devuelva el estado
                                  financiero del producto a "Al Dia", cuando
                                  el producto no se encuentra castigado ni
                                  con saldo.
  20-11-2013  hjgomez.SAO223711   Se aplica el saldo a favor
  16-09-2013  lfernandez.SAO213274 Se adiciona parametro iboIsSupplier para
                                  saber la forma en la que deben actualizarse
                                  los valores de la cuenta
  10-09-2013  lfernandez.SAO213274 Se actualiza al final del metodo el
                                  cucovato y cucovaab con el valor del pago
                                  inicial para que el saldo de la cuenta quede
                                  en cero
  28-08-2013  lfernandez.SAO211681 Se adiciona parametro inuBilledValue y se
                                   actualiza el valor facturado de la cuenta
                                   de cobro
  27-08-2013  lfernandez.SAOxxxxx Creacion
  26-10-2017  rcolpas.SAO2001537  Se valida que no proporcion de la cuota inicial
                                  para el articulo CARDIF
  ***************************************************************/
  PROCEDURE CreateDelivOrderCharg(inuOrder        in or_order.order_id%type,
                                  inuPackage      in mo_packages.package_id%type,
                                  inuCause        in number,
                                  inuBilledValue  in number,
                                  inuPaymentValue in number,
                                  iboIsSupplier   in boolean,
                                  ionuAccount     in out cuencobr.cucocodi%type,
                                  ionuValorAbono  in out number,
                                  ionuValTotVen   in out number) IS
    ------------------------------------------------------------------------
    --  Variables
    ------------------------------------------------------------------------
    dtDiferido        date;
    nuProportion      number;
    nuValorAbono      number;
    nuDifecodi        number;
    nudifevatd_t      number := 0;
    nuvvalaboprov     number := 0;
    nuIndexItems      binary_integer;
    nuConcept         cargos.cargconc%type;
    nuAccount         cuencobr.cucocodi%type;
    nuProduct         pr_product.product_id%type;
    nuMotive          mo_motive.motive_id%type;
    tbnonbaitem       dald_non_ban_fi_item.tytbLD_non_ban_fi_item;
    tbCharges         FI_BOVentasDirectasFinanciadas.tytbCargos;
    nuWriteOffBal     number;
    nuProdBal         number;
    nuChargeValue     cargos.cargvalo%type;
    nuLastVaab        cuencobr.cucovaab%type;
    sbTakeGracePeriod ld_non_ba_fi_requ.take_grace_period%type;

    nuExistCARDIF number; --caso 2001537

    ------------------------------------------------------------------------
    --  Cursores
    ------------------------------------------------------------------------
    CURSOR cuArticulo IS
      SELECT /*+ index(oa IDX_OR_ORDER_ACTIVITY_05)
                                                                                                                  index(li IX_LD_ITEM_WORK_ORDER01) */
       li.*, li.rowid
        FROM or_order_activity oa, ld_item_work_order li
       WHERE oa.activity_id = cnuDelivActiv
         AND oa.order_activity_id = li.order_activity_id
         and oa.order_id = inuorder
         AND li.state = csbEntregado;

    --  identifica diferido creado
    CURSOR cuValdife(isbNudo in diferido.difenudo%type, inuProduct in diferido.difenuse%type) IS
      SELECT difecodi
        FROM diferido d
       WHERE d.difenuse = inuProduct
         AND d.difenudo = isbNudo;

    --  Obtiene la ultima cuenta asociada a la solicitud
    CURSOR cuLastAccount(inuCargnuse in cargos.cargnuse%type, isbCargDoso in cargos.cargdoso%type) IS
      SELECT cargcuco
        FROM cargos
       WHERE cargdoso = isbCargDoso
         AND cargnuse = inuCargnuse
       ORDER BY cargfecr desc, cargcuco desc;

    CURSOR cuCuentas(inuPackageId in mo_packages.package_id%type) IS
      SELECT cucocodi
        FROM mo_package_payment pp, mo_motive_payment mp, CUENCOBR cu
       WHERE pp.package_payment_id = mp.package_payment_id
         and mp.account = cu.cucofact
         and pp.package_id = inuPackageId;

    --caso2001537 consulto el articulo cardif
    cursor cuArtCARDIF(nuArti ld_article.article_id%type) is
      SELECT count(*)
        FROM open.LD_ARTICLE L
       WHERE L.Concept_Id IN
             (select nvl(to_number(column_value), 0)
                from table(open.ldc_boutilities.splitstrings(open.dald_parameter.fsbgetvalue_chain('CONCEPTO_EXCLUIDO_CUPO_BRILLA',
                                                                                                   NULL),
                                                             ',')))
         AND L.ARTICLE_ID = nuArti;
    ------------------------------------------------------------------------
    PROCEDURE RegisterNote(nuServSusc    in servsusc.sesunuse%type,
                           nucuencobr    in cuencobr.cucocodi%type,
                           nuConcept     in concepto.conccodi%type,
                           nuNoteCuase   in ld_parameter.numeric_value%type,
                           sbDescription in varchar2,
                           nuValue       ld_item_work_order.value%type) IS

      nuSubsc servsusc.sesususc%type;
      nuNote  notas.notanume%type;

    BEGIN
      ut_trace.trace('Inicia LD_boflowFNBPack.CreateDelivOrderCharg.RegisterNote',
                     5);

      pkErrors.SetApplication(CC_BOConstants.csbCUSTOMERCARE);

      nuSubsc := pktblservsusc.fnugetsesususc(nuServSusc);

      --  Crea la nota por el pago inicial
      pkBillingNoteMgr.CreateBillingNote(nuServSusc,
                                         nucuencobr,
                                         GE_BOConstants.fnuGetDocTypeDebNote,
                                         sysdate,
                                         sbDescription,
                                         pkBillConst.csbTOKEN_NOTA_DEBITO,
                                         nuNote);

      ut_trace.trace('Termino pkBillingNoteMgr.CreateBillingNote', 5);

      -- Crear Detalle Nota Debito
      FA_BOBillingNotes.DetailRegister

      (nuNote,
       nuServSusc,
       nuSubsc,
       nucuencobr,
       nuConcept,
       nuNoteCuase,
       nuValue,
       null,
       'PP-' || inupackage, --pkBillConst.csbTOKEN_NOTA_DEBITO || nuNote,
       pkBillConst.DEBITO,
       pkConstante.SI,
       null,
       pkConstante.SI);

      ut_trace.trace('Termina LD_boflowFNBPack.CreateDelivOrderCharg.RegisterNote',
                     5);

    EXCEPTION
      When ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
      When others then
        Errors.setError;
        raise ex.CONTROLLED_ERROR;
    END RegisterNote;

  BEGIN

    UT_Trace.Trace('LD_boflowFNBPack.CreateDelivOrderCharg', 15);

    /* NO hay que crear cargos ni factura si se paga de contado y es
    proveedor*/
    if (nvl(ionuValorAbono, 0) = nvl(ionuValTotVen, 0)) then

      UT_Trace.Trace('Es proveedor y es pago de contado. Retorna', 15);

      FOR rgarticulo IN cuArticulo LOOP
        DALD_Item_Work_Order.updDifeCodi(rgarticulo.item_work_order_id, 0);
      END loop;

      return;

    END if;

    if (nvl(ionuAccount, pkConstante.NULLNUM) = pkConstante.NULLNUM) then

      open cuCuentas(inuPackage);
      fetch cuCuentas
        INTO ionuAccount;
      close cuCuentas;

      ionuAccount := nvl(ionuAccount, pkConstante.NULLNUM);
    END if;

    --  Obtiene el motivo asociado a la solicitud
    nuMotive := mo_bopackages.fnugetinitialmotive(inuPackage);

    --  Obtiene el producto asociado al motivo
    nuProduct := damo_motive.fnuGetProduct_Id(nuMotive);

    -- se debe tomar periodo de gracia?
    sbTakeGracePeriod := nvl(dald_non_ba_fi_requ.fsbGetTake_Grace_Period(inuPackage),
                             'N');

    /*Obtiene los articulos asociados a la solicitud*/
    FOR rgarticulo IN cuArticulo LOOP

      --  Asigna el concepto
      nuConcept := DALD_Article.fnuGetConcept_Id(rgarticulo.article_id);

      FOR i IN 1 .. rgarticulo.Amount LOOP

        /*identifica el valor de venta por articulo para financiacion*/
        nudifevatd_t := nvl(rgarticulo.value, 0) + nvl(rgarticulo.iva, 0);

        --caso 200-1537 Valido que el articulo no sea seguro voluntario CARDIF
        open cuArtCARDIF(rgarticulo.article_id);
        fetch cuArtCARDIF
          into nuExistCARDIF;
        close cuArtCARDIF;
        if nuExistCARDIF = 0 then

          nuProportion := nudifevatd_t / ionuValTotVen;

          --  Calcula la proporcion del abono que le corresponde al articulo
          nuvvalaboprov := round(ionuValorAbono * nuProportion, 2);

          -- aplica politica de redondeo para valor proporcional de este articulo
          --Para no ejecutar la polica si el valor ya es cero
          if (nvl(nuvvalaboprov, pkBillConst.CERO) != pkBillConst.CERO) then
            -- Aplica politica de redondeo
            FA_BOPoliticaRedondeo.AplicaPolitica(nuProduct, nuvvalaboprov);
          END if;

          --  Se le disminuye al total de la venta el articulo
          ionuValTotVen := ionuValTotVen - nudifevatd_t;

          -- aplica politica de redondeo para valor del articulo
          if (nvl(nudifevatd_t, pkBillConst.CERO) != pkBillConst.CERO) then
            -- Aplica politica de redondeo
            FA_BOPoliticaRedondeo.AplicaPolitica(nuProduct, nudifevatd_t);
          END if;

          /* Si hay abono este fue aplicado desde el principio */
          if (nvl(ionuValorAbono, 0) > 0) then
            nuChargeValue := nudifevatd_t - nuvvalaboprov;
          else
            nuChargeValue := nudifevatd_t;
          END if;

        else
          nuChargeValue := nudifevatd_t;
          nuvvalaboprov := 0;
        end if;

        ut_trace.trace('nuChargeValue[' || nuChargeValue ||
                       ']nuvvalaboprov[' || nuvvalaboprov,
                       50);

        if nvl(ionuAccount, pkConstante.NullNum) != pkConstante.NullNum then
          RegisterNote(nuProduct,
                       ionuAccount,
                       nuConcept,
                       inuCause,
                       'Nota cobro articulo Brilla[' || inuPackage || ']',
                       nuChargeValue);
        else
          /*Crea un cargo */
          pkChargeMgr.GenerateCharge(nuProduct,
                                     ionuAccount,
                                     nuConcept,
                                     inuCause,
                                     nuChargeValue,
                                     'DB',
                                     'PP-' || inuPackage,
                                     'A',
                                     null,
                                     null,
                                     null,
                                     null,
                                     true,
                                     sysdate);
        end if;

        --  Se le disminuye al valor del abono el valor aplicado
        ionuValorAbono := ionuValorAbono - nuvvalaboprov;

      END LOOP;

      ut_trace.trace('ValorTotalVenta[' || ionuValTotVen || ']ValorAbono=' ||
                     ionuValorAbono);

      --  Si no existe cuenta debe crearla
      if (ionuAccount = pkConstante.NULLNUM) then

        /*Generacion de cuentas y facturas*/
        cc_boaccounts.GenerateAccountByPack(inuPackage);

        --  Obtiene la ultima cuenta asociada a la solicitud
        open cuLastAccount(nuProduct, 'PP-' || inuPackage);
        fetch cuLastAccount
          INTO ionuAccount;
        close cuLastAccount;

        if (ionuAccount IS null) then
          --  Obtiene la cuenta asociada a la solicitud
          open cuAccount(inuPackage);
          fetch cuAccount
            INTO ionuAccount;
          close cuAccount;
        END if;

      END if;

      /*Obtiene el plan de financiacion amarrado al articulo y la fecha del primer pago de la cuota*/
      dald_non_ban_fi_item.getRecords(' ld_non_ban_fi_item.non_ba_fi_requ_id=' ||
                                      inuPackage ||
                                      ' and ld_non_ban_fi_item.article_id=' ||
                                      rgarticulo.article_id,
                                      tbnonbaitem);

      nuIndexItems := tbnonbaitem.first;

      /* Se recorre registro por item*/
      while nuIndexItems is not null loop

        if (tbnonbaitem(nuIndexItems).first_payment_date < sysdate) then
          dtDiferido := sysdate;
        else
          dtDiferido := tbnonbaitem(nuIndexItems).first_payment_date;
        end if;

        tbCharges(1).cargconc := nuConcept;
        tbCharges(1).cargvalo := (nudifevatd_t * rgarticulo.Amount) -
                                 nuvvalaboprov;
        tbCharges(1).cargsign := pkBillConst.DEBITO;

        --Registra la financiacion para el cargo
        RegChargeFinancing(nuProduct,
                           ionuAccount,
                           tbnonbaitem(nuIndexItems).finan_plan_id,
                           rgarticulo.credit_fees,
                           rgarticulo.item_work_order_id,
                           dtDiferido,
                           tbCharges);

        nuDifecodi := 0; -- deberia ser nul??

        -- Busco el DIFERIDO CREADO
        OPEN cuVALDIFE(rgarticulo.item_work_order_id, nuProduct);
        FETCH cuVALDIFE
          INTO nuDifecodi;
        CLOSE cuVALDIFE;

        -- si no se utiliza periodo de gracia
        if ((nvl(nuDifecodi, 0) <> 0) AND (sbTakeGracePeriod = 'N')) then
          DELETE FROM CC_Grace_Peri_Defe WHERE Deferred_Id = nuDifecodi;
          -- (Sii sii no debio ser asi, pero no autorizaron modificar producto )
        END if;

        --ACTUALIZA EL DIFERIDO EN EL ITEM DEL REGISTRO DE LA VENTA
        DALD_Item_Work_Order.updDifeCodi(rgarticulo.item_work_order_id,
                                         nuDifecodi);

        nuIndexItems := tbnonbaitem.next(nuIndexItems);

      end loop;

    end loop;

    --  Si se envio o genero cuenta
    if (ionuAccount <> pkConstante.NULLNUM) then

      --  Si se trata de un proveedor
      if (iboIsSupplier) then

        --  Actualiza el valor de la cuenta y el valor abonado que
        --  siempre es cero si se trata de proveedor
        -- pkTblCuencobr.UpAccoReceiv( ionuAccount, nvl(inuBilledValue,0) - nvl(inuPaymentValue,0), 0);

        --  Actualiza el valor facturado
        pkTblCuencobr.updCucovafa(ionuAccount,
                                  inuBilledValue - inuPaymentValue);

        --  Si es un contratista
      else

        --  Actualiza el valor facturado
        pkTblCuencobr.updCucovafa(ionuAccount, inuBilledValue);

        pkAccountMgr.SetRequestInMemory(inuPackage);
        -- Actualiza el saldo a favor de la solicitud (NO ES NECESARIO)
        pkaccountmgr.applypositivebalserv(nuProduct);

      end if;

      /* Obtiene saldo castigo */
      nuWriteOffBal := GC_BCCastigoCartera.fnuObtCarCastPorServS(nuProduct);

      /* Producto NO esta castigado */
      if (nuWriteOffBal <= 0) then
        /* Obtiene saldo cuentas */
        nuProdBal := pkBCCuencobr.fnuGetOutStandBal(nuProduct);

        /* Producto a Paz y Salvo */
        if (nuProdBal = 0) then
          pktblServsusc.UpdSesuesfn(nuProduct, pkBillConst.csbEST_AL_DIA);
        end if;
      end if;

    end if;

    UT_Trace.Trace('Fin LD_boflowFNBPack.CreateDelivOrderCharg', 15);

  EXCEPTION
    when LOGIN_DENIED OR pkConstante.exERROR_LEVEL2 OR ex.CONTROLLED_ERROR then
      raise;
    when OTHERS then
      Errors.SetError;
      raise ex.CONTROLLED_ERROR;
  END CreateDelivOrderCharg;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : CreateChargeFNB
  Descripcion    : Crea cargos FNB
  Autor          : Eduar Ramos
  Fecha          : 10/04/2013

  Parametros              Descripcion
  ============         ===================
  inupackage_id         identificador del paquete.


  Historia de Modificaciones
  Fecha       Autor                 Modificacion
  =========   =========             ====================
  25-Ene-2014   AEcheverrySAO230811 Se modifica para que tambien genere los cargos
                                    si la venta fue del EXITO (GS)
  13-12-2013    aesguerra.SAO227053 Se altera para que la cuota inicial de
                                    articulos anulados se conserve como saldo a favor
  16-09-2013  lfernandez.SAO213274  Se obtiene si el vendedor es proveedor o
                                    contratista y se le envia a
                                    CreateDelivOrderCharg
  10-09-2013  lfernandez.SAO213274  Se le envia a CreateDelivOrderCharg el valor
                                    del pago inicial
  29-08-2013  lfernandez.SAO212650  Se le envia a fnuIdentifyRules
                                    LEG_DELIV_ORDE_AUTO y la condicion de salida
                                    del metodo se actualiza respecto a la
                                    condicion en el flujo
  28-08-2013  lfernandez.SAO211681  Se envia el valor facturado a
                                    CreateDelivOrderCharg
  ******************************************************************/
  PROCEDURE CreateChargeFNB(inupackage_id IN mo_packages.package_id%TYPE) IS
    ------------------------------------------------------------------------
    --  Variables
    ------------------------------------------------------------------------
    nuIndexor      number;
    nuValorAbono   number;
    nuPaymentValue number;
    nuValTVen      number;
    nuBilledValue  number;
    nuFlagValid    number;
    nuDelivInPoint number;
    boIsSupplier   boolean;
    nuAccount      cuencobr.cucocodi%type := pkConstante.NULLNUM;
    nuSellOperUnit or_operating_unit.operating_unit_id%type;
    frgDelivOrders daor_order_activity.tyRefCursor;
    rcDelivOrder   daor_order_activity.tytbOrder_Id;
  BEGIN

    ut_trace.Trace('Inicio ld_boflowfnbpack.CreateChargeFNB', 1);

    --  Obtiene el flag de validacion (el mismo del flujo)
    nuFlagValid := ld_boflowfnbpack.fnuIdentifyRules(inupackage_id,
                                                     'LEG_DELIV_ORDE_AUTO');

    --  Si la entrega es en punto
    if (DALD_Non_Ba_Fi_Requ.fsbGetDelivery_Point(inupackage_id) =
       GE_BOConstants.csbYES) then
      nuDelivInPoint := 1;
    else
      nuDelivInPoint := 0;
    end if;

    --  Solo se generan cargos si la legalizacion no fue automatica o si es una gran superficie (EXITO).
    if ((nuFlagValid = 0 and nuDelivInPoint = 0) and
       (fnuValidaGranSuper(inupackage_id) <> 1)) then

      UT_Trace.Trace('Los cargos fueron creados en la legalizacion manual',
                     3);
      return;

    END if;

    /*Lanza programa para la ejecucion de cargos*/
    pkerrors.setapplication(cc_boconstants.csbCUSTOMERCARE);

    --identifica el valor de la cuota inicial dada en la solicitud de venta
    nuValorAbono := NVL(DALD_NON_BA_FI_REQU.fnuGetPayment(inupackage_id), 0);

    --  Obtiene la unidad operativa del vendedor
    nuSellOperUnit := DAMO_Packages.fnuGetPos_Oper_Unit_Id(inupackage_id);

    --  Asigna si la clase de unidad es proveedor
    boIsSupplier := DAOR_Operating_unit.fnuGetOper_Unit_Classif_Id(nuSellOperUnit) =
                    cnuSupplierFNB;

    -- Busco el valor total
    OPEN cuValTotaVen(inupackage_id, cnuDelivActiv);
    FETCH cuValTotaVen
      INTO nuValTVen;
    CLOSE cuValTotaVen;

    --  Asigna el valor facturado
    nuBilledValue := nuValTVen;
    --  Asigna el valor del pago
    nuPaymentValue := nuValorAbono;

    --IDENTIFICA LAS ORDENES DE ENTREGA ASOCIADA A LA SOLICITUD DE VENTA
    frgDelivOrders := ld_bcNonBankFinancing.frfGetDeliverOrders(inupackage_id);
    FETCH frgDelivOrders BULK COLLECT
      INTO rcDelivOrder;
    CLOSE frgDelivOrders;

    --  Si no hay ordenes generadas
    if rcDelivOrder.first IS null then
      ge_boerrors.SETERRORCODEARGUMENT(2741,
                                       'No se encontraron ordenes de entrega asociadas');
    END if;

    nuIndexor := rcDelivOrder.FIRST;

    --recorre los ordenes de entregas
    WHILE (nuIndexor IS NOT NULL) LOOP

      --  Crea los cargos para la orden
      CreateDelivOrderCharg(rcDelivOrder(nuIndexor),
                            inupackage_id,
                            cnuCause,
                            nuBilledValue,
                            nuPaymentValue,
                            boIsSupplier,
                            nuAccount,
                            nuValorAbono,
                            nuValTVen);

      nuIndexor := rcDelivOrder.NEXT(nuIndexor);

    end loop;

    ut_trace.Trace('Fin ld_boflowfnbpack.CreateChargeFNB', 1);

  EXCEPTION
    When ex.CONTROLLED_ERROR then
      RAISE ex.CONTROLLED_ERROR;
    When others then
      errors.SetError;
      RAISE ex.CONTROLLED_ERROR;
  END CreateChargeFNB;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : createproducOcuppier
  Descripcion    : recibe como parametro la solicitud e ventad, luego identifica la orden de entrega, paso siguiente
             recorre cada uno de los articulos de la ot de entrega, e identifica los articulos, con los articulos (ld_article)
             identifica el servicio al cual esta asociado (los articulos pueden tener configuradion brilla o brilla promigas)
             y preguntara si ya existe  para el cliente producto brilla o brilla promigas y si no existe crearlo
  Autor          : KBaquero
  Fecha          : 02/05/2013 09:56:27 p.m.

  Parametros              Descripcion
  ============            ===================
  inuPackage              Numero de solicitud
  onuErrorCode            Numero de error
  osbErrorMessage         Mensaje de error

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========         =========         ====================
  18-10-2014      KCienfuegos.NC2860  Se modifica para que valide si ya existe un producto
                                      creado a partir de la financiacion del deudor de la venta,
                                      en cuyo caso no cree otro producto.
  15-01-2014      AEcheverrySAO229596 Se Crea el producto si la venta no fue realizada
                                      por el EXITO.
                                      Se elimina la creacion del usuario de servicio,
                                      esto se realizara en <<createproducreal>>
  06-09-2013      mmira.SAO216533     Se adiciona actualizacion del contrato de la solicitud.
  04-09-2013      mmira.SAO212290     Se adiciona la direccion de cobro al contrato inquilino.
  ******************************************************************/
  PROCEDURE createproducOcuppier(inuPackage      IN mo_packages.package_id%type,
                                 onuErrorCode    OUT number,
                                 osbErrorMessage OUT varchar2) IS
    ------------------------------------------------------------------------
    --  Variables
    ------------------------------------------------------------------------
    boClientExists  boolean;
    rcPromissory    dald_promissory.styLD_promissory;
    rcMopackage     damo_packages.stymo_packages;
    nuPromissory_Id ld_promissory.promissory_id%type;
    nuSubscriber    ge_subscriber.subscriber_id%type;
    nuProductId     pr_product.product_id%type;

    nuValidatorProd number;
    nuContract      number;
    nuProducOcupp   number;
    rcProduct       dapr_product.tytbpr_product;
    nuMotive        mo_motive.motive_id%type;
    rcMotive        damo_motive.styMO_motive;
    rcSubsGenData   DAGE_Subs_General_Data.styGE_Subs_General_Data;
    blValidatOcupp  boolean := false;
    blCreateProd    boolean := true;
    nuProductOcupId pr_product.product_id%type;
    nuProdType      pr_product.product_type_id%type;
    rcSaleRequest   dald_non_ba_fi_requ.styLD_non_ba_fi_requ;
    cnuActivityTypeFNB constant ld_parameter.numeric_value%type := dald_parameter.fnuGetNumeric_Value('ACTIVITY_TYPE_FNB');
    nuProductTypeId pr_product.product_type_id%type;

    /*Cursor para obtener producto por deudor de venta fnb*/
    cursor cu_OcuppierProd(nuOcuppier ge_subscriber.subscriber_id%type, nuSuscription suscripc.susccodi%type, nuProductType pr_product.product_type_id%type) is
      select op.product_id
        from pr_subs_type_prod op, pr_product p
       where op.role_id =
             DALD_PARAMETER.fnuGetNumeric_Value('USER_ROLE_TYPE')
         and op.subscriber_id = nuOcuppier
         and p.product_id = op.product_id
         and p.subscription_id = nuSuscription
         and p.product_type_id = nuProductType
         and instr(dald_parameter.fsbGetValue_Chain('FNB_VALID_PROD_STATUS'),
                   p.product_status_id) > 0
      --p.product_status_id = dald_parameter.fnuGetNumeric_Value('ID_PRODUCT_STATUS_ACTIVO')
       order by op.product_id desc;

    /*Cursor para obtener el financiador/tipo producto*/
    Cursor cu_ProductType is
      SELECT /*+ index (li PK_LD_ITEM_WORK_ORDER) index(li IX_LD_ITEM_WORK_ORDER01)  use_nl(li o) use_nl(oa o)*/
      distinct dald_article.fnuGetFinancier_Id(li.ARTICLE_ID)
        FROM or_order_activity oa, ld_item_work_order li
       WHERE oa.activity_id = cnuActivityTypeFNB
         AND li.order_id = oa.order_id
         and oa.order_activity_id = li.order_activity_id
         and oa.package_id = inuPackage;

  begin

    ut_trace.trace('Fin Ld_BcflowFNBPack.createproducOcuppier', 10);

    /*Se verifica si la solicitud de venta la hizo el titular o no,
    si no es el titular retorna la variable nuProducOcupp el valor uno (1)*/
    Ld_BcflowFNBPack.CreateproducOcupp(inuPackage,
                                       nuProducOcupp,
                                       nuPromissory_Id);

    damo_packages.getrecord(inuPackage, rcMopackage);

    dbms_output.put_Line('nuProducOcupp: ' || nuProducOcupp);
    /* Si la solicitud de venta no la hizo el titular se procede
    a realizar el proceso de creacion de producto por inquilino*/
    if (nuProducOcupp = 1) then

      dald_promissory.getRecord(nuPromissory_Id, rcPromissory);

      /* Se obiene el subscriber si el tipo de identificacion o identificacion existe*/
      boClientExists := ge_bosubscriber.ValidIdentification(rcPromissory.identification,
                                                            rcPromissory.ident_type_id,
                                                            nuSubscriber); --out

      dbms_output.put_Line('nuSubscriber: ' || nuSubscriber);
      /* Se valida si el inquilino no existe como cliente*/
      if (nuSubscriber is null) then

        /* Se realiza el ingreso a ge_subscriber*/
        GE_BOSubscriber.Register(nuSubscriber, --in/out
                                 rcPromissory.ident_type_id,
                                 rcPromissory.identification,
                                 null, --cliente padre
                                 GE_BOConstants.cnuSubscriberTypeNormal,
                                 null, --direccion (no se usa)
                                 rcPromissory.phone1_id,
                                 rcPromissory.debtorname,
                                 rcPromissory.last_name,
                                 rcPromissory.email,
                                 null, --url
                                 rcPromissory.phonepersrefe,
                                 null, --direccion referencia (no se usa)
                                 null, --nombre contacto
                                 null, --tipo identificacion contacto
                                 null, --identificacion contacto
                                 null, --segmento de mercado
                                 1,
                                 FALSE, --valida cliente?
                                 rcPromissory.address_id,
                                 rcPromissory.birthdaydate,
                                 null, --direccion contacto
                                 rcPromissory.gender);

        --  Obtiene los datos generales del cliente que fue creado
        rcSubsGenData := DAGE_Subs_General_Data.frcGetRecord(nuSubscriber);

        --  Asigna campos que el metodo no asigna
        rcSubsGenData.civil_state_id   := rcPromissory.civil_state_id;
        rcSubsGenData.SCHOOL_DEGREE_ID := rcPromissory.school_degree_;

        --  Actualiza los datos
        DAGE_Subs_General_Data.updRecord(rcSubsGenData);
      else
        blValidatOcupp := true;

      end if;

      if blValidatOcupp then
        /*Se obtiene el tipo de producto a crear*/
        if cu_ProductType%isopen then
          close cu_ProductType;
        end if;

        open cu_ProductType;
        fetch cu_ProductType
          into nuProductTypeId;
        if cu_ProductType%notfound then
          close cu_ProductType;
          nuProductTypeId := -1;
          raise ex.CONTROLLED_ERROR;
        end if;

        if cu_ProductType%isopen then
          close cu_ProductType;
        end if;

        --Validar
        open cu_OcuppierProd(nuSubscriber,
                             rcMopackage.subscription_pend_id,
                             nuProductTypeId);
        fetch cu_OcuppierProd
          into nuProductOcupId;
        close cu_OcuppierProd;

        if nuProductOcupId is not null then
          blCreateProd := false;
        end if;

      end if;

      -- Se crea producto si la venta no fue realizada por el EXITO
      if (ld_boflowfnbpack.fnuValidaGranSuper(inuPackage) <> 1) then

        /*Se valida si se crea el producto*/
        if blCreateProd then
          /*Se crea el producto asociado al contrato origen*/
          createproducReal(inuPackage,
                           true,
                           nuProductId,
                           nuSubscriber,
                           onuErrorCode,
                           osbErrorMessage);

          gw_boerrors.checkerror(onuErrorCode, osbErrorMessage);

        else
          /*Se obtiene el tipo de producto*/
          nuProdType := dapr_product.fnugetproduct_type_id(nuProductOcupId);

          /*Se actualiza el producto y tipo de producto para todos los motivos de la venta*/
          ld_bcflowfnbpack.updMotiveProdTypeByPack(inuPackage,
                                                   nuProductOcupId,
                                                   nuProdType);

          rcSaleRequest := dald_non_ba_fi_requ.frcGetRecord(inuPackage);
          createCupon(rcMopackage.operating_unit_id,
                      inuPackage,
                      nuProductOcupId,
                      rcSaleRequest.payment);

        end if;
      end if;
    end if;

    -- Se obtiene el motivo inicial de la solicitud
    rcMotive := MO_BOPackages.frcGetInitialMotive(inuPackage, FALSE);
    damo_motive.updsubscription_id(rcMotive.motive_id,
                                   rcMopackage.subscription_pend_id);

    ut_trace.trace('Fin Ld_BoflowFNBPack.createproducOcuppier', 10);

  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      Errors.setError;
      RAISE ex.CONTROLLED_ERROR;
  END createproducOcuppier;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : Executerules
  Descripcion    :
  Autor          : Alex Valencia Ayola
  Fecha          : 19/04/2013


  comentario:    Identificacion las ordenes de entrega a legalizar lote
  Parametros         Descripcion
  ============   ===================
  inuPackage     paquete
  inuorder       orden
  inususccodi    suscripcion
  idtdatemin     fecha minima de asignacion de la ot de entrega
  idtdatemax     fecha maxima de asignacion de la ot de entrega

  Historia de Modificaciones
  Fecha                Autor                Modificacion
  ==============       ==================   ====================
  01-03-2018           Sebastian Tapias     REQ.2001695 se modifica para que no haga uso de comodines, se convierte la consulta
                                            en dinamica. Y solo realiza los filtros cuando estos son usados desde la forma.
                                            Se cambia la obtencion de algunas de las variables(fijas) que maneja la consulta para
                                            evitar errores al usar la consulta como texto. [Solo aplica para la consulta de GDC]
  25-07-2017           samuel pacheco       se modifica para que si es consulta por orden o por paquete ejecute query
                                            independiente
  07-06-2017           Jorge Valiente       CASO 200-1164: Se modifico la logica del servicio frfgetdelarticlesleg con relacion
                                                           a la forma de obtener las ordenes de entrega permitiendo mostrar
                                                           ordenes de serguro volunatio utilizadas en al venta BRILLA
                                                           Esta modificacion fue solicitada por la funcionaria Julia Gonzalez
  08-08-2016           KBaquero. C200311    Se unifica los procesos entre Efigas Y gases del caribe
  02-07-2015           KCienfuegos.ARA7715  Se quitan los hints de la consulta.
  23-06-2015           KCienfuegos.ARA7715  Se modifica la consulta para que ya no tenga en cuenta el estado de las
                                            ??nes de la solicitud de anulaci??evoluci??y s??se tenga en cuenta
                                            que el art?lo se encuentre en estado registrado RE.
  11-06-2015           ABaldovino[ARA 7810] Se elimina el uso del hint para utilizar el indice IDX_OR_ORDER_3
                                            al cursor rfArticle_id
  20-04-2015           ABaldovino[ARA 6286] Se modifica procedimiento para que devuelva las ordenes
                                            que pertenezcan al mismo contratista del usuario que esta conectado,
                                            para esto el valor del parametro FLAG_LEGAL_X_CONTRATISTA debe estar en S
  05-03-2015           Llozada [ARA 6099]   Se modifica la l?gica para que no tome los art?culos que est?n
                                            en proceso de anulaci?n y para que tome los que tienen una sol de
                                            anulaci?n con una orden de recuperaci?n legalizada con ?xito
  09/01/2015           KCienfuegos.RNP1224  Se modifica para colocar en comentario el estado de la actividad.
  02/08/2014           KCienfuegos.NC629    Se agregan los parametros COD_OLIMPICA_FLOTE y COD_EXITO_FLOTE
  16/Julio/2013        EveSan               Se filtra las ordenes, para que solo muestren
                                            las que no esten finalizadas
  27/01/2015           AOyola               Modifica sentencia para que busque los dos estados(csbEntregado, csbEnProcesoAD)
  ******************************************************************/
  FUNCTION frfgetdelarticlesleg(inuPackage in mo_packages.package_id%type,
                                inuorder   in or_order.order_id%type,
                                inuClient  in mo_packages.subscriber_id%type,
                                idtdatemin in date,
                                idtdatemax in date)
    RETURN constants.tyrefcursor IS
    rfArticle_id    pkconstante.tyRefCursor;
    inuorderq       or_order.order_id%type; --variable que identifica la orden en consulta
    inuPackageq     mo_packages.package_id%type; --variable que identifica el paquete
    nuClient        mo_packages.subscriber_id%type; -- variable que identifica el suscriptor
    idtdateminq     date; -- variable que identifica la fecha minima en la consulta
    idtdatemaxq     date; -- variable que identifica la fecha maxima en la consulta
    nuValueExito    ld_parameter.parameter_id%type;
    nuValueOlimpica ld_parameter.parameter_id%type;
    nuContratorId   ge_contratista.id_contratista%type;
    nuOperUnitId    or_operating_unit.operating_unit_id%type;
    nuEstadoAtenSol mo_packages.motive_status_id%type;
    nuEstadoRegSol  mo_packages.motive_status_id%type;
    nuTTRecupera    or_order.task_type_id%type;
    nuCausalFallo   ge_causal.causal_id%type;

    sbLegalXCont ld_parameter.value_chain%TYPE;

    ------------------------------
    -- REQ.2001695 -->
    -- Variables.
    ------------------------------
    /* Hint consulta Dinamica */
    sbhintaux ge_boutilities.stystatement;
    /* Atributos consulta Dinamica */
    sbattributesorders ge_boutilities.stystatement;
    /* Tablas de la consulta Dinamica */
    sbfrom ge_boutilities.stystatement;
    /* Criterios de consulta Dinamica */
    sbwherorders ge_boutilities.stystatement;
    /* SQL Consulta Dinamica */
    sbsqlorders ge_boutilities.stystatement;
    /* Criterios Adicionales de consulta Dinamica */
    sbwherglobal ge_boutilities.stystatement;
    /* Variable para sacar el servicio de la consulta. */
    CNUORDER_STAT_ASSIGNED CONSTANT OR_ORDER_STATUS.ORDER_STATUS_ID%TYPE := or_boconstants.cnuORDER_STAT_ASSIGNED;

    SBdtdatemax VARCHAR2(4000);
    SBdtdatemin VARCHAR2(4000);

    datemin date := TO_DATE('01-01-1900', 'DD-MM-YYYY');
    datemax date := TO_DATE('12-12-2032', 'DD-MM-YYYY');
    ------------------------------
    -- REQ.2001695 <--
    ------------------------------

  BEGIN

    ut_trace.trace('Inicio LD_BOFLOWFNBPACK.frfgetdelarticlesleg', 10);

    -- almacena la fecha minima en la varibla de consulta
    IF idtdatemin IS NOT NULL then
      idtdateminq := idtdatemin;
    else
      --si es nula usa un comodin
      idtdateminq := trunc(sysdate - 9999);
    END IF;
    -- almacena la fecha maxima en la varibla de consulta
    IF idtdatemax IS NOT NULL THEN

      idtdatemaxq := idtdatemax;
    else
      --si es nula usa un comodin
      idtdatemaxq := trunc(sysdate + 9999);
    end if;
    --setea la variable de consulta de la orden
    IF inuorder IS NULL THEN
      inuorderq := -1;
    else
      inuorderq := inuorder;
    end if;
    --setea la variable de consulta del paquete
    if inuPackage is null then
      inuPackageq := -1;
    else
      inuPackageq := inuPackage;
    end if;
    --setea la variable de consulta de suscripcion
    if inuClient is null then
      nuClient := -1;
    else
      nuClient := inuClient;
    end if;

    --Se consulta la unidad operativa del funcionario conectado
    nuOperUnitId := ld_bcnonbankfinancing.fnuGetUnitBySeller;

    ut_trace.trace('nuOperUnitId ' || nuOperUnitId, 10);

    nuContratorId := daor_operating_unit.fnugetcontractor_id(nuOperUnitId);
    ut_trace.trace('nuContratorId ' || nuContratorId, 10);

    --nuValueExito := Dald_Parameter.fnuGetNumeric_Value('CODI_CUAD_EXITO');
    --nuValueOlimpica := Dald_Parameter.fnuGetNumeric_Value('CODI_CUAD_OLIMPICA');
    nuValueExito    := Dald_Parameter.fnuGetNumeric_Value('COD_EXITO_FLOTE');
    nuValueOlimpica := Dald_Parameter.fnuGetNumeric_Value('COD_OLIMPICA_FLOTE');

    --05-03-2015 Llozada [ARA 6099]
    nuEstadoAtenSol := Dald_parameter.fnuGetNumeric_Value('FNB_ESTADOSOL_ANULACION');
    nuEstadoRegSol  := Dald_parameter.fnuGetNumeric_Value('FNB_ESTADOSOL_REG');
    nuTTRecupera    := Dald_parameter.fnuGetNumeric_Value('FNB_TT_RECUPERACION');
    nuCausalFallo   := Dald_parameter.fnuGetNumeric_Value('FNB_CAUSAL_FALLO');

    --ABaldovino ARA 6286
    sbLegalXCont := Dald_Parameter.fsbGetValue_Chain('FLAG_LEGAL_X_CONTRATISTA');

    If fblAplicaEntrega('FNB_BRI_KBM_200311_1') Then
      ut_trace.trace('Se construye consulta dinamica', 15);
      ------------------------------
      -- REQ.2001695 -->
      -- Se construye y se ejecuta la consulta Dinamica.
      -- Teniendo en cuenta los filtros agregados.
      ------------------------------
      sbhintaux := 'INDEX (oa IDX_OR_ORDER_ACTIVITY_05) INDEX (p IDX_MO_PACKAGES_02)';
      ut_trace.trace('Agrega Hint', 15);

      sbattributesorders := 'oa.order_id,
       oa.order_activity_id,
       os.description order_status_id,
       dage_subscriber.fsbgetsubscriber_name(p.subscriber_id, 0) || '' '' ||
       dage_subscriber.fsbgetsubs_last_name(p.subscriber_id, 0) nomclien,
       daab_address.fsbgetaddress(p.address_id, 0) direccion,
       o.assigned_date assigned_date,
       l.article_id,
       l.article_id || ''-'' ||
       dald_article.fsbgetdescription(l.article_id, 0) description,
       open.ldc_pkventasegurovoluntario.fsbsergurovoluntario(oa.package_id) seguro_voluntario';
      ut_trace.trace('Agrega Atributos', 15);

      sbfrom := 'ld_item_work_order l,
       or_order_activity  oa,
       mo_packages        p,
       or_order           o,
       or_order_status    os';
      ut_trace.trace('Agrega Tablas', 15);

      sbwherorders := 'oa.order_activity_id = l.order_activity_id
   AND p.package_id = oa.package_id
   AND o.order_id = oa.order_id
   AND os.order_status_id = o.order_status_id
   AND l.supplier_id = ' || nucontratorid || '
   AND l.supplier_id NOT IN (' || nuvalueexito || ', ' ||
                      nuvalueolimpica || ')
   AND l.state IN (''' || csbentregado || ''')
   AND l.difecodi IS NULL
   AND oa.activity_id = ' || cnudelivactiv || '
   AND oa.status <> ''F''
   AND o.order_status_id = ' || CNUORDER_STAT_ASSIGNED || '
   AND o.operating_unit_id =
       DECODE(''' || sblegalxcont ||
                      ''', ''S'', o.operating_unit_id, ' || nuoperunitid || ')' ||
                      chr(10);
      ut_trace.trace('Agrega Condiciones', 15);

      -- Si el campo no es nulo, lo agregamos al query.
      IF idtdatemin IS NOT NULL then
        /* Si la fecha es igual al valor quemado, no se compara */
        IF TRUNC(datemin) = TRUNC(idtdatemin) THEN
          ut_trace.trace('No aplica Fecha Minima', 15);
        ELSE
          SBdtdatemin := TO_CHAR(idtdatemin, 'DD/MM/YYYY');

          sbwherorders := sbwherorders ||
                          '    AND TRUNC(o.assigned_date) >= TRUNC(TO_DATE(''' ||
                          SBdtdatemin || ''',''DD/MM/YYYY''))' || chr(10);
          ut_trace.trace('Agrega el campo idtdatemin[' || idtdatemin || ']',
                         15);
        END IF;
      END IF;
      -- Si el campo no es nulo, lo agregamos al query.
      IF idtdatemax IS NOT NULL THEN
        /* Si la fecha es igual al valor quemado, no se compara */
        IF TRUNC(datemax) = TRUNC(idtdatemax) THEN
          ut_trace.trace('No aplica Fecha Maxima', 15);
        ELSE
          SBdtdatemax  := TO_CHAR(idtdatemax, 'DD/MM/YYYY');
          sbwherorders := sbwherorders ||
                          '    AND TRUNC(o.assigned_date) <= TRUNC(TO_DATE(''' ||
                          SBdtdatemax || ''',''DD/MM/YYYY''))' || chr(10);
          ut_trace.trace('Agrega el campo idtdatemax[' || idtdatemax || ']',
                         15);
        END IF;
      end if;
      -- Si el campo no es nulo, lo agregamos al query.
      IF inuorder IS NOT NULL THEN
        sbwherorders := sbwherorders || '    AND oa.order_id = ' ||
                        inuorder || ' ' || chr(10);
        ut_trace.trace('Agrega el campo inuorder[' || inuorder || ']', 15);
      end if;
      -- Si el campo no es nulo, lo agregamos al query.
      if inuPackage IS NOT NULL then
        sbwherorders := sbwherorders || '    AND oa.package_id = ' ||
                        inuPackage || ' ' || chr(10);
        ut_trace.trace('Agrega el campo inuPackage[' || inuPackage || ']',
                       15);
      end if;
      -- Si el campo no es nulo, lo agregamos al query.
      if inuClient IS NOT NULL then
        sbwherorders := sbwherorders || '    AND p.subscriber_id = ' ||
                        inuClient || ' ' || chr(10);
        ut_trace.trace('Agrega el campo inuClient[' || inuClient || ']',
                       15);
      end if;

      sbwherglobal := 'ORDER BY oa.order_id, oa.order_activity_id';
      ut_trace.trace('Agrega atributos adicinales', 15);

      ut_trace.trace('Construyendo SELECT...', 15);
      
      --Se quita el indice. REQ.2001695 02/04/2018
      /*sbsqlorders := 'SELECT \*+ ' || sbhintaux || ' *\ ' || chr(10) ||
                     sbattributesorders || ' FROM ' || sbfrom || ' WHERE ' ||
                     sbwherorders || ' ' || sbwherglobal || ' ';*/
                     
      sbsqlorders := 'SELECT ' || chr(10) ||
                     sbattributesorders || ' FROM ' || sbfrom || ' WHERE ' ||
                     sbwherorders || ' ' || sbwherglobal || ' ';               

      ut_trace.trace('sbsqlorders:[' || sbsqlorders || ']', 15);

      OPEN rfArticle_id FOR sbsqlorders;
      ------------------------------
      -- REQ.2001695 <--
      ------------------------------
      ------------------------------
      -- REQ.2001695 -->
      -- Se comenta para trabajar por consulta dinamica.
      ------------------------------
      /*if inuorder IS not NULL and inuPackage is null and inuClient is null and
         idtdatemin IS NULL and idtdatemax IS NULL then
        begin
          select package_id
            into inuPackageq
            from open.or_order_activity d
           where d.order_id = inuorder
             AND rownum = 1;
        exception
          when others then
            inuPackageq := -1;
        end;
        OPEN rfArticle_id FOR
          select oa.order_id,
                 oa.order_activity_id,
                 os.description order_status_id,
                 dage_subscriber.fsbgetsubscriber_name(p.subscriber_id, 0) || ' ' ||
                 dage_subscriber.fsbgetsubs_last_name(p.subscriber_id, 0) nomclien,
                 daab_address.fsbgetaddress(p.address_id, 0) direccion,
                 o.assigned_Date ASSIGNED_DATE,
                 l.article_id,
                 l.article_id || '-' ||
                 dald_article.fsbGetDescription(l.article_id, 0) Description,
                 open.LDC_PKVENTASEGUROVOLUNTARIO.FSBSERGUROVOLUNTARIO(oa.package_id) Seguro_Voluntario
            from ld_item_work_order l,
                 or_order_activity  oa,
                 mo_packages        p,
                 or_order           o,
                 or_order_status    os
           where oa.order_activity_id = l.order_activity_id
             AND p.package_id = oa.package_id
             AND o.order_id = oa.order_id
             AND os.order_status_id = o.order_status_id
             AND l.supplier_id = nuContratorId
             AND l.supplier_id NOT IN (nuValueExito, nuValueOlimpica)
             AND l.state in (csbEntregado \*, csbEnProcesoAD*\
                 ) --se coloca en comentario ARA.7715
             AND l.difecodi is null
             AND oa.activity_id = cnuDelivActiv
             AND oa.status <> 'F'
             AND trunc(o.Assigned_Date) >= trunc(idtdateminq)
             AND trunc(o.Assigned_Date) <= trunc(idtdatemaxq)
             and oa.order_id = inuorderq
             and oa.package_id = inuPackageq
             and o.order_Status_Id = or_boconstants.cnuORDER_STAT_ASSIGNED
                --ABaldovino ARA 6286
             AND o.operating_unit_id =
                 decode(sbLegalXCont,
                        'S',
                        o.operating_unit_id,
                        nuOperUnitId)
           order by oa.order_id, oa.order_activity_id;

      elsif inuorder IS NULL and inuPackage is not null and
            inuClient is null and idtdatemin IS NULL and idtdatemax IS NULL then
        OPEN rfArticle_id FOR
          select oa.order_id,
                 oa.order_activity_id,
                 os.description order_status_id,
                 dage_subscriber.fsbgetsubscriber_name(p.subscriber_id, 0) || ' ' ||
                 dage_subscriber.fsbgetsubs_last_name(p.subscriber_id, 0) nomclien,
                 daab_address.fsbgetaddress(p.address_id, 0) direccion,
                 o.assigned_Date ASSIGNED_DATE,
                 l.article_id,
                 l.article_id || '-' ||
                 dald_article.fsbGetDescription(l.article_id, 0) Description,
                 open.LDC_PKVENTASEGUROVOLUNTARIO.FSBSERGUROVOLUNTARIO(oa.package_id) Seguro_Voluntario
            from ld_item_work_order l,
                 or_order_activity  oa,
                 mo_packages        p,
                 or_order           o,
                 or_order_status    os
           where oa.order_activity_id = l.order_activity_id
             AND p.package_id = oa.package_id
             AND o.order_id = oa.order_id
             AND os.order_status_id = o.order_status_id
             AND l.supplier_id = nuContratorId
             AND l.supplier_id NOT IN (nuValueExito, nuValueOlimpica)
             AND l.state in (csbEntregado \*, csbEnProcesoAD*\
                 ) --se coloca en comentario ARA.7715
             AND l.difecodi is null
             AND oa.activity_id = cnuDelivActiv
             AND oa.status <> 'F'
             AND trunc(o.Assigned_Date) >= trunc(idtdateminq)
             AND trunc(o.Assigned_Date) <= trunc(idtdatemaxq)
             and oa.package_id = inuPackageq
             and o.order_Status_Id = or_boconstants.cnuORDER_STAT_ASSIGNED
                --ABaldovino ARA 6286
             AND o.operating_unit_id =
                 decode(sbLegalXCont,
                        'S',
                        o.operating_unit_id,
                        nuOperUnitId)
           order by oa.order_id, oa.order_activity_id;
      else
        --desarrolla la consulta
        OPEN rfArticle_id FOR
          select oa.order_id,
                 oa.order_activity_id,
                 \*Decode(oa.STATUS,
                                'R',
                                'Registrada',
                                'A',
                                'Asignada',
                                'F',
                                'Finalizada',
                                oa.STATUS) STATUS,*\ \*RNP1224*\
                 os.description order_status_id,
                 dage_subscriber.fsbgetsubscriber_name(p.subscriber_id, 0) || ' ' ||
                 dage_subscriber.fsbgetsubs_last_name(p.subscriber_id, 0) nomclien,
                 daab_address.fsbgetaddress(p.address_id, 0) direccion,
                 o.assigned_Date ASSIGNED_DATE,
                 l.article_id,
                 l.article_id || '-' ||
                 dald_article.fsbGetDescription(l.article_id, 0) Description,
                 LDC_PKVENTASEGUROVOLUNTARIO.FSBSERGUROVOLUNTARIO(oa.package_id) Seguro_Voluntario
            from ld_item_work_order l,
                 or_order_activity  oa,
                 mo_packages        p,
                 or_order           o,
                 or_order_status    os
           where oa.order_activity_id = l.order_activity_id
             AND p.package_id = oa.package_id
             AND o.order_id = oa.order_id
             AND os.order_status_id = o.order_status_id
             AND l.supplier_id = nuContratorId
             AND l.supplier_id NOT IN (nuValueExito, nuValueOlimpica)
             AND l.state in (csbEntregado \*, csbEnProcesoAD*\
                 ) --se coloca en comentario ARA.7715
             AND l.difecodi is null
                --Se valida que el Art?culo no se encuentre en proceso de Anulaci?n
                \*and not exists (select 'x'
                              from ld_return_item a, mo_packages b, ld_return_item_detail c
                              where a.package_sale = oa.package_id --Sol venta
                              and a.package_id = b.package_id
                              and b.motive_status_id = nuEstadoRegSol
                              and c.article_id = l.article_id --Articulo
                              and a.return_item_id = c.return_item_id
                              and transaction_type = 'A'
                              )*\ --Se coloca en comentario ARA7715
                --Se valida que el Art?culo no tenga una Sol de anulaci?n legalizada con Fallo
                \*and not exists (select 'x'
                              from ld_return_item a, mo_packages b, ld_return_item_detail c
                              where a.package_sale = oa.package_id --Sol venta
                              and  a.package_id = b.package_id
                              and b.motive_status_id = nuEstadoAtenSol
                              and c.article_id = l.article_id --Articulo
                              and a.return_item_id = c.return_item_id
                              and exists (select 'x'
                                          from or_order d, or_order_activity e
                                          where e.package_id = a.package_id
                                          and d.task_type_id = nuTTRecupera --RECUPERACION VENTA BRILLA - FNB
                                          and d.causal_id = nuCausalFallo --FAllO
                                          and d.order_id = e.order_id)
                              )*\ --Se coloca en comentario ARA7715
             AND oa.activity_id = cnuDelivActiv
             AND oa.status <> 'F'
             AND trunc(o.Assigned_Date) >= trunc(idtdateminq)
             AND trunc(o.Assigned_Date) <= trunc(idtdatemaxq)
             and oa.order_id =
                 decode(inuorderq, -1, oa.order_id, inuorderq)
             and oa.package_id =
                 decode(inuPackageq, -1, oa.package_id, inuPackageq)
             and p.subscriber_id =
                 decode(nuClient, -1, p.subscriber_id, nuClient)
             and o.order_Status_Id = or_boconstants.cnuORDER_STAT_ASSIGNED
                --ABaldovino ARA 6286
             AND o.operating_unit_id =
                 decode(sbLegalXCont,
                        'S',
                        o.operating_unit_id,
                        nuOperUnitId)
           order by oa.order_id, oa.order_activity_id;
      end if;*/
      ------------------------------
      -- REQ.2001695 <--
      ------------------------------
    else
      /*Unificacion paquete con EFIGAS*/
      --desarrolla la consulta
      OPEN rfArticle_id FOR
        select /*+ leading ( o )
                                                                                                                                      index(o IDX_OR_ORDER_3)
                                                                                                                                      index(oa IDX_OR_ORDER_ACTIVITY_05)
                                                                                                                                      index(l IX_LD_ITEM_WORK_ORDER01)
                                                                                                                                      index(p PK_MO_PACKAGES)*/
         oa.order_id,
         oa.order_activity_id,
         /*Decode(oa.STATUS,
                  'R',
                  'Registrada',
                  'A',
                  'Asignada',
                  'F',
                  'Finalizada',
                  oa.STATUS) STATUS,*/ /*RNP1224*/
         os.description order_status_id,
         dage_subscriber.fsbgetsubscriber_name(p.subscriber_id, 0) || ' ' ||
         dage_subscriber.fsbgetsubs_last_name(p.subscriber_id, 0) nomclien,
         daab_address.fsbgetaddress(p.address_id, 0) direccion,
         o.assigned_Date ASSIGNED_DATE,
         l.article_id,
         l.article_id || '-' ||
         dald_article.fsbGetDescription(l.article_id, 0) Description,
         LDC_PKVENTASEGUROVOLUNTARIO.FSBSERGUROVOLUNTARIO(oa.package_id) Seguro_Voluntario
          from ld_item_work_order l,
               or_order_activity  oa,
               mo_packages        p,
               or_order           o,
               or_order_status    os
         where oa.order_activity_id = l.order_activity_id
           AND p.package_id = oa.package_id
           AND o.order_id = oa.order_id
           AND os.order_status_id = o.order_status_id
           AND l.supplier_id = nuContratorId
           AND l.supplier_id NOT IN (nuValueExito, nuValueOlimpica)
           AND l.state in (csbEntregado, csbEnProcesoAD)
              --Se valida que el Art?culo no se encuentre en proceso de Anulaci?n
           and not exists (select 'x'
                  from ld_return_item        a,
                       mo_packages           b,
                       ld_return_item_detail c
                 where a.package_sale = oa.package_id --Sol venta
                   and a.package_id = b.package_id
                   and b.motive_status_id = nuEstadoRegSol
                   and c.article_id = l.article_id --Articulo
                   and a.return_item_id = c.return_item_id
                   and transaction_type = 'A')
              --Se valida que el Art?culo no tenga una Sol de anulaci?n legalizada con Fallo
           and not exists
         (select 'x'
                  from ld_return_item        a,
                       mo_packages           b,
                       ld_return_item_detail c
                 where a.package_sale = oa.package_id --Sol venta
                   and a.package_id = b.package_id
                   and b.motive_status_id = nuEstadoAtenSol
                   and c.article_id = l.article_id --Articulo
                   and a.return_item_id = c.return_item_id
                   and exists (select 'x'
                          from or_order d, or_order_activity e
                         where e.package_id = a.package_id
                           and d.task_type_id = nuTTRecupera --RECUPERACION VENTA BRILLA - FNB
                           and d.causal_id = nuCausalFallo --FAllO
                           and d.order_id = e.order_id))
           AND oa.activity_id = cnuDelivActiv
           AND oa.status <> 'F'
           AND trunc(o.Assigned_Date) >= trunc(idtdateminq)
           AND trunc(o.Assigned_Date) <= trunc(idtdatemaxq)
           and oa.order_id = decode(inuorderq, -1, oa.order_id, inuorderq)
           and oa.package_id =
               decode(inuPackageq, -1, oa.package_id, inuPackageq)
           and p.subscriber_id =
               decode(nuClient, -1, p.subscriber_id, nuClient)
           and o.order_Status_Id = or_boconstants.cnuORDER_STAT_ASSIGNED
              --ABaldovino ARA 6286
           AND o.operating_unit_id =
               decode(sbLegalXCont, 'S', o.operating_unit_id, nuOperUnitId)
         order by oa.order_id, oa.order_activity_id;

    end if;

    Return(rfArticle_id);

    ut_trace.trace('Fin LD_BOFLOWFNBPACK.frfgetdelarticlesleg', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END frfgetdelarticlesleg;

  /**********************************************************************
   Propiedad intelectual de OPEN International Systems
   Nombre              GenerateOrdersByArt

   Autor        Andres Felipe Esguerra Restrepo

   Fecha               16-06-2014

   Descripcion         Genera las ordenes de pago y cobro a proveedores para un articulo entregado.
                       Se recibe como parametro los tipos de actividad que se van a usar para mejorar
                       el rendimiento cuando se trata de un proceso masivo (es decir, es llamado
                       por GenerateOrderFNB)

   ***Parametros***
   Nombre        Descripcion
  inuPackageId      ID de la solicitud
  inuOrderId        ID de la orden
  iblBatch          Flag para establecer si es por legalizacion automatica
  inuActProvCom     ID de Actividad de Cobro de comision a proveedor
  inuActSalCom      ID de Actividad de Pago de comision a contratista
  inuActDelDesc     ID de Actividad de Pago de articulo a proveedor
  inuActivityIns    ID de Actividad de Instalacion

   ***Historia de Modificaciones***
   Fecha Modificacion        Autor
   17-Enero-2024			jsoto(OSF-2019)
							se crea cursor cuCadenaLegalizacion para armar la cadena de legalizacion
							se reemplaza OS_LEGALIZEORDERALLACTIVITIES por API_LEGALIZEORDERS
   08-Mayo-2017              Sebastian Tapias || Caso 200-1268 || se realiza una modificacion en el cursor cuComision
                             de la funcion (GetCommissionSale), para validar que el contratista se encuentre activo.
                             Ademas se crean condiciones y dunciones que permitan controlar la generacion de ordenes.
   26-Abril-2017             Sebastian Tapias|| Caso 200-564 || se realiza una modificacion en el cursor cuComision
                             de la funcion (GetCommissionSale), para pasar la consulta de articulos
                             a contratistas.
   05-marzo-2015             Samuel Pacheco Se modifica para redondea valor de la ordenes generadas
                             para efectos de liquidacion de ot NC 4416
   16-06-2014            aesguerra.3649
   Creacion encapsulando el codigo de <<GenerateOrdeFNB>> para poder reutilizarlo
  ***********************************************************************/
  PROCEDURE GenerateOrdersByArt(inuPackageId   in mo_packages.package_id%type,
                                inuOrderId     in or_order.order_id%type,
                                iblBatch       in boolean default false,
                                inuActProvCom  in or_order_activity.order_activity_id%TYPE default null,
                                inuActSalCom   in or_order_activity.order_activity_id%TYPE default null,
                                inuActDelDesc  in or_order_activity.order_activity_id%TYPE default null,
                                inuActivityIns in or_order_activity.order_activity_id%TYPE default null) IS

    nuError number;
    sbError varchar2(4000);

    /* SEBTAP || 200-1268 */
    v_cobro_comis  number; /*Variable para controlar la creacion de las ordenes */
    v_create_orden number; /*Controla el LOOP de cracion de ordenes*/
    --------------------------------

    /*Cobro de comision a proveedor*/
    nuActProvCom ld_parameter.numeric_value%type;

    /*Pago de comision a contratista*/
    nuActSalCom ld_parameter.numeric_value%type;

    -- Hace parte del cambio 200-564
    /* Pago de comision publicidad a contratista */
    nuActSalPub ld_parameter.numeric_value%type;
    --------------------------------

    /*Pago de articulo a proveedor*/
    nuActDelDesc ld_parameter.numeric_value%type;

    /*Actividad de instalacion*/
    nuActivityIns ld_parameter.numeric_value%type;

    /*Contador de orden a generar*/
    nuContOrder PLS_INTEGER := 1;

    /*Actividad*/
    nuActivity or_order_activity.order_activity_id%TYPE;

    nuOrderId or_order.order_id%TYPE;
    nuOrder   Or_order.order_id%type;

    nuValidator      boolean := true;
    nuIndexArticleOr number := 0;
    nuOrderActi      or_order_activity.order_activity_id%type;
    nuOperating_Unit or_order.operating_unit_id%TYPE;

    TYPE tyrcArticleAct IS RECORD(
      article_id         ld_article.article_id%type,
      item_work_order_id ld_item_work_order.item_work_order_id%type,
      description        ld_article.description%type,
      order_activity_id  ld_item_work_order.order_activity_id%type);

    TYPE tyrcArticleActiv IS TABLE OF tyrcArticleAct;
    rcArticleOrd tyrcArticleActiv := tyrcArticleActiv();

    rfArticleOrder constants.tyrefcursor;

    /*Parametros de valor de actualizacion de las ordenes y actividad*/
    nuValOrder or_order.order_value%type;
    vnucasal   ge_causal.causal_id%type;

    nuOrderItem        or_order_activity.order_item_id%type;
    nuOrderActivityRev or_order_activity.order_activity_id%type;

    CURSOR cuCadenaLegalizacion (	NUORDER_ID OR_ORDER.ORDER_ID%TYPE,
									nuPersona GE_PERSON.PERSON_ID%TYPE,
									nuCausal GE_CAUSAL.CAUSAL_ID%TYPE)
    IS
            SELECT    O.ORDER_ID
                   || '|'||nuCausal||'|'
                   || nuPersona
                   || '||'
                   || A.ORDER_ACTIVITY_ID
                   || '>'||pkg_bcordenes.fnuobtieneclasecausal(nuCausal)||';;;;|||1277;'
                   || '-' Cadenalegalizacion
              FROM OR_ORDER O, OR_ORDER_ACTIVITY A
             WHERE O.ORDER_ID = A.ORDER_ID
               AND O.ORDER_ID = TO_NUMBER (NUORDER_ID);        

    sbCadenaLegalizacion   VARCHAR2 (4000);





    -- miguelm
    -- Funcion creada para el caso 200-1268
    --
    FUNCTION GetCommissionSale(inuOrder_id IN or_order.order_id%TYPE)
      RETURN number IS
      ------------------------------------------------------------------------
      --  Variables
      ------------------------------------------------------------------------
      rcRecord         rfOrderp;
      rcCommission     tytbLD_Commissionp;
      frfResult        constants.tyrefcursor;
      nuLiquidSellerId ld_liquidation_seller.liquidation_seller_id%TYPE;
      nuCountOrderLiqu PLS_INTEGER := 0;
      nuSw             PLS_INTEGER := 0;
      nuIndex          PLS_INTEGER;
      nuCalcValue      NUMBER := 0;
      nuCalcFin        NUMBER := 0;
      NUORDSALE        OR_ORDER.ORDER_ID%TYPE;
      nuSupplierId     or_operating_unit.contractor_id%type;
      nuContractorId   or_operating_unit.contractor_id%type;
      nuUnitClassif    or_operating_unit.oper_unit_classif_id%type;
      nuAddressId      ab_address.address_id%type;
      nuGeograpId      ab_address.geograp_location_id%type;
      nuVendedorCont   ge_contratista.id_contratista%type;
      nuCommission     LD_CONS_COPU_ACTI.COPUCOMI%TYPE;
      cnuActTypDeliv   CONSTANT ld_parameter.numeric_value%TYPE := Dald_parameter.fnuGetNumeric_Value('ACT_TYPE_DEL_FNB'); --Orden de entrega
      cnuActTypSaleCom CONSTANT ld_parameter.numeric_value%TYPE := Dald_parameter.fnuGetNumeric_Value('ACT_TYPE_SALE_COM'); --Comision vendedor
      cnuActTypProvCom CONSTANT ld_parameter.numeric_value%TYPE := Dald_parameter.fnuGetNumeric_Value('ACT_TYPE_PROVIDERS_COM'); --Comision proveedor
      cnuAllRows       CONSTANT PLS_INTEGER := -1;
      cnuCero_Value    CONSTANT PLS_INTEGER := 0;
      cnuOneNumber     CONSTANT PLS_INTEGER := 1;

      /* CURSOR cuComision IS
      SELECT ARCOCOMI FROM LD_CONS_COPU WHERE ARCOCONT = rcRecord.contractor_id; */

      -- Cambio de alcance || CA 200-1268 || Jm Desarrollo || SEBTAP ||08/05/2017
      /*Se cambia la consulta anterior, ahora se consultara por contratistas y se tendra en cuenta que el
      estado del contratista sea activo (Y)*/
      CURSOR cuComision IS
        SELECT COPUCOMI
          FROM LD_CONS_COPU_ACTI
         WHERE COPUCONT = rcRecord.contractor_id
           AND COPUACTI = 'Y';
      ---------------------

    BEGIN

      ut_trace.trace('Inicia Ld_Boliquidationminute.GetCommissionSale', 10);
      /*  Funcion que Retorna las ordenes y articulos para la comision a los proveedores
      y contratista de venta.*/
      frfResult := Ld_BcLiquidationMinute.FrfGetOrderArticlesSold(inuInputActivity_id  => cnuActTypSaleCom, -- Orden de Comision al Vendedor
                                                                  inuOutputActivity_id => cnuActTypDeliv, -- Orden de entrega
                                                                  inuOrder             => inuOrder_id);

      LOOP
        FETCH frfResult
          INTO rcRecord;
        EXIT WHEN frfResult%NOTFOUND;

        --IDENTIFICA ORDEN DE VENTA
        NUORDSALE := Ld_bccancellations.fnugetsaleorder(rcRecord.package_id,
                                                        null);

        --IDENTIFICA CONTRATISTA QUE VENDE
        nuVendedorCont := DAOR_OPERATING_UNIT.fnuGetContractor_Id(DAOR_ORDER.fnuGetOperating_Unit_Id(NUORDSALE,
                                                                                                     0),
                                                                  0);

        -- asigno el proveedor del articulo a procesar
        nuSupplierId := rcRecord.CONTRACTOR_ID;

        nuAddressId := daor_order.fnugetexternal_address_id(rcRecord.order_id,
                                                            0);
        nuGeograpId := ge_bogeogra_location.fnuGetGeo_LocaByAddress(nuAddressId,
                                                                    AB_BOConstants.csbToken_LOCALIDAD);

        OPEN cuComision;
        FETCH cuComision
          INTO nuCommission;
        IF cuComision%NOTFOUND THEN
          nuCommission := 0;
        END IF;
        CLOSE cuComision;

        /*Se omite mensaje de error, si la comison es 0, porque se contralara la creeacion de ordenes*/
        /* SEBTAP ||200-1268 */
        /*IF nuCommission = 0 THEN
          GE_BOErrors.SetErrorCodeArgument(2741,
                                           'No existe configuracion de comisiones para los criterios Ubicacion [' ||
                                           rcRecord.GEOLOC_ABADDRESS ||
                                           '] Contratista [' ||
                                           rcRecord.CONTRACTOR_ID ||
                                           '] Canal de venta [' ||
                                           rcRecord.RECEPTION_TYPE_ID ||
                                           '] Articulo [' ||
                                           rcRecord.ARTICLEACT ||
                                           '] Linea [' || rcRecord.LINE_ID ||
                                           '] Sublinea [' ||
                                           rcRecord.SUBLINE_ID ||
                                           '] Unidad operativa [' ||
                                           rcRecord.OPERATING_UNIT_ID ||
                                           '] Fecha [' || SYSDATE);

        END IF;*/

        nuCalcValue := (nuCommission * (rcRecord.value /*+ rcRecord.iva*/
                       ) * rcRecord.amount) / 100;

        IF nuSw = 0 THEN

          nuLiquidSellerId := Ld_Bcliquidationminute.FnuGetLiqSellerIdByOrder(inuOrder_id,
                                                                              'V');

          IF nuLiquidSellerId IS NULL THEN

            nuLiquidSellerId := pkgeneralservices.fnuGetNextSequenceVal('SEQ_LD_LIQUIDATION_SELLER'); --ld_bosequence.fnuSeqLiquidationSeller;

            /*Insert tabla liquidacion vendedor*/
            LD_BCLIQUIDATIONMINUTE.InsertLiquidationSeller(inuliquidation_seller_id => nuLiquidSellerId,
                                                           idtdate_liquidation      => SYSDATE,
                                                           isbstatus                => 'V', --PAGO DE COMISION CONTRATISTA - PROVEEDOR
                                                           idtdate_suspension       => sysdate,
                                                           isbproduct_id            => rcRecord.financier_id,
                                                           inuOrder_id              => inuOrder_id,
                                                           inuPackage_id            => rcRecord.PACKAGE_ID,
                                                           inucontratista           => rcRecord.CONTRACTOR_ID);
          END IF;

          nuSw := 1;

        END IF;

        IF NOT
            Ld_Bcliquidationminute.FblExistDetaLiqSeller(inuLiqSe => nuLiquidSellerId,
                                                         inuOrder => rcRecord.order_id,
                                                         inuArtic => rcRecord.ARTICLEACT) THEN

          /*Insert tabla detalle liquidacion */
          LD_BCLIQUIDATIONMINUTE.InsertDetailLiquiSeller(inudetail_liqui_seller_id => pkgeneralservices.fnuGetNextSequenceVal('SEQ_LD_DETAIL_LIQUI_SELLER'), --ld_bosequence.fnuSeqDetailLiquiSeller,--
                                                         inuconcept_id             => rcRecord.CONCEPT_ID,
                                                         inupercentage_liquidation => nuCommission,
                                                         inuvalue_paid             => nuCalcValue,
                                                         inuarticle_id             => rcRecord.ARTICLEACT,
                                                         inucontractor_id          => rcRecord.CONTRACTOR_ID,
                                                         inuliquidation_seller_id  => nuLiquidSellerId,
                                                         inuOrder_id               => rcRecord.order_id,
                                                         inuValueBase              => rcRecord.value *
                                                                                      rcRecord.amount,
                                                         isbInclVatReco            => 'Y');
        END IF;

        nuCalcFin := nuCalcFin + nuCalcValue;

        nuCountOrderLiqu := nuCountOrderLiqu + cnuOneNumber;

      END LOOP;

      CLOSE frfResult;

      ut_trace.trace('Final Ld_Boliquidationminute.GetCommissionSale', 10);
      RETURN nuCalcFin;

    EXCEPTION
      when LOGIN_DENIED OR pkConstante.exERROR_LEVEL2 OR
           ex.CONTROLLED_ERROR then
        raise;
      when OTHERS then
        Errors.SetError;
        raise ex.CONTROLLED_ERROR;
    END GetCommissionSale;

    FUNCTION ldc_fnugeneracomision(inuOrder_id IN or_order.order_id%TYPE)
      RETURN number IS
      /**************************************************************************************
      Propiedad Intelectual de SINCECOMP (C).

      Funcion     : ldc_fnugeneracomision
      Descripcion : Funcion que retona:
                    (1) --> Se realiza cobro de comision
                    (0) --> Para aquellos que NO.

      Autor       : Sebastian Tapias || 200-1268
      Fecha       : 10-05-2017

      ---------------------
      ***Variables de Entrada***

      inuOrder_id -- Orden de entrega (Es la misma variable que entra al paquete).

      ***Variables de Salida***

      v_cobrocomi -- Variabe de retorno.

      ---------------------

      Historia de Modificaciones

        Fecha               Autor                Modificacion
      =========           =========          ====================

      ***************************************************************************************/
      ------------------------------------------------------------------------
      --  Variables
      ------------------------------------------------------------------------
      v_cobrocomi    NUMBER := 0;
      v_nuVendedor   ge_contratista.id_contratista%type;
      v_nuCommission LD_CONS_COPU_ACTI.COPUCOMI%TYPE;

      /* Cursor para consultar la comision asignada al contratista*/
      CURSOR c_cuComision IS
        SELECT COPUCOMI
          FROM LD_CONS_COPU_ACTI
         WHERE COPUCONT = v_nuVendedor -- CONTRATISTA QUE VENDE
           AND COPUACTI = 'Y';
		   
	     --CURSOR PARA GENERAR CADENA QUE SERA UTILIZADA PARA LEGALIZAR LA ORDEN
		   

    BEGIN
      --IDENTIFICA CONTRATISTA QUE VENDE
      v_nuVendedor := DAOR_OPERATING_UNIT.fnuGetContractor_Id(DAOR_ORDER.fnuGetOperating_Unit_Id(inuOrder_id,
                                                                                                 0),
                                                              0);
      OPEN c_cuComision;
      FETCH c_cuComision
        INTO v_nuCommission;
      IF c_cuComision%NOTFOUND THEN
        v_nuCommission := 0;
      END IF;
      CLOSE c_cuComision;
      /*Si obtiene una comision mayor a 0, nos devolvera 1*/
      IF (v_nuCommission > 0) THEN
        v_cobrocomi := 1;
        /*Si obtiene una igual a cero o menor, nos devolvera 0*/
      ELSE
        v_cobrocomi := 0;
      END IF;

      RETURN v_cobrocomi;

    EXCEPTION
      when LOGIN_DENIED OR pkConstante.exERROR_LEVEL2 OR
           ex.CONTROLLED_ERROR then
        raise;
      when OTHERS then
        Errors.SetError;
        raise ex.CONTROLLED_ERROR;
    END ldc_fnugeneracomision;

  BEGIN
    ut_trace.trace('Inicio LD_BOFlowFNBPack.GenerateOrdersByArt', 1);

    if not iblBatch then

      -- 1 --4294431 - COBRO COMISION A PROVEEDOR - FNB ACT_TYPE_PROVIDERS_COM
      nuActProvCom := DALD_Parameter.fnuGetNumeric_Value('ACT_TYPE_PROVIDERS_COM');
      nuActSalCom  := DALD_Parameter.fnuGetNumeric_Value('ACT_TYPE_SALE_COM');
      -- 3 --4294430 - PAGO DE ARTICULO A PROVEEDOR - FNB ACTI_PAGO_ARTI_PROV
      nuActDelDesc  := DALD_Parameter.fnuGetNumeric_Value('ACTI_PAGO_ARTI_PROV');
      nuActivityIns := DALD_Parameter.fnuGetNumeric_Value('COD_ACTIVITY_INSTALL');
      nuActSalPub   := DALD_Parameter.fnuGetNumeric_Value('ACT_TYPE_SALE_PUB');

      if nuActProvCom + nuActSalCom + nuActDelDesc + nuActivityIns +
         nuActSalPub is null then
        return;
      end if;

    else

      nuActProvCom  := inuActProvCom;
      nuActSalCom   := inuActSalCom;
      nuActDelDesc  := inuActDelDesc;
      nuActivityIns := inuActivityIns;
      /* nuActSalPub   := 0;*/
      nuActSalPub := DALD_Parameter.fnuGetNumeric_Value('ACT_TYPE_SALE_PUB'); -- SEBTAP || 200-1268

    end if;

    /* Se obtiene los articulos a partir de la orden de entrega que sean
    de tipos de instalacion y se encuentren en estado csbEntregado*/
    rfArticleOrder := ld_bcflowfnbpack.frfGetArticleOrder(inuOrderId);
    FETCH rfArticleOrder BULK COLLECT
      INTO rcArticleOrd; -- Tabla PL con los articulos de la orden actualmente procesada.
    CLOSE rfArticleOrder;

    nuIndexArticleOr := rcArticleOrd.FIRST;

    WHILE nuIndexArticleOr IS NOT NULL LOOP
      -- LOOP Artitculos de la orden

      /*Se crean las actividades asociadas a una orden*/
      createReviewOrderActivity(nuActivityIns,
                                nuOrderGl,
                                rcArticleOrd(nuIndexArticleOr)
                                .order_activity_id,
                                null,
                                'Instalacion venta brilla: ' ||
                                 rcArticleOrd(nuIndexArticleOr)
                                .article_id || ' ' ||
                                 rcArticleOrd(nuIndexArticleOr).description,
                                nuOrderActi);

      nuIndexArticleOr := rcArticleOrd.NEXT(nuIndexArticleOr);

    END LOOP; -- FIN LOOP Artitculos de la orden

    /*Para cada solicitud se reinicia el contador de ordenes a 1*/
    nuContOrder := 1;

    /*Se recorren los tipos de ordenes que se van a crear */
    --
    -- Caso 200-1268 ||SEBTAP
    /*Para el cobro de comision de publicidad se cambia de 3 a 4 ordenes.
    Pero se tendra en cuenta si debe o no generar la 4 orden si el contratista cumple con los
    criterios para el cobro de la comision*/
    v_cobro_comis := ldc_fnugeneracomision(inuOrderId);
    IF v_cobro_comis = 1 THEN
      v_create_orden := 4;
    ELSE
      v_create_orden := 3;
    END IF;
    /*Con la variable v_create_orden controlaremos:
    Si la comision a publicidad es diferente de 0 ejecutaremos el loop 4 veces.
    si la comision es 0 o menor, restringiremos al loop a 3 veces para evitar que se genera la comision por publicidad
    Esta validacion se hace dentro de la funcion ldc_fnugeneracomision */

    WHILE nuContOrder <= v_create_orden LOOP
      -- LOOP de Creacion de ordenes

      nuValidator := true;

      /* Si la orden es de cobro  comision a proveedor.*/
      if (nuContOrder = 1) then

        nuActivity := nuActProvCom;
        --
        -- 01-12-2016 miguelm csc 200564
        -- se registra el contador no 4
        --
      elsif (nuContOrder = 2) then
        /* Si la orden es de comision a contratista de venta*/

        /*Obtiene la orden de venta*/
        nuOrder := Ld_bccancellations.fnugetsaleorder(inuPackageId, null);

        /*Obtiene la unidad operativa asociada a la ot de venta*/
        nuOperating_Unit := Daor_Order.fnuGetOperating_Unit_Id(nuOrder,
                                                               null);
        if (nuOperating_Unit is not null) then

          /*Se valida que la unidad operativa de la ot de venta se de tipo
          contratista de venta fnb*/
          if (daor_operating_unit.fnugetoper_unit_classif_id(nuOperating_Unit) =
             Dald_parameter.fnuGetNumeric_Value('CONTRACTOR_SALES_FNB')) THEN

            nuActivity := nuActSalCom;
          else
            nuValidator := false;

          end if;

        else
          nuValidator := false;

        end if;

      elsif (nuContOrder = 3) then
        /* Si la orden es de Pago articulo por proveedor*/
        nuActivity := nuActDelDesc;
      ELSIF (nuContOrder = 4) THEN
        /*Obtiene la unidad operativa asociada a la ot de ENTREGA*/
        nuOperating_Unit := Daor_Order.fnuGetOperating_Unit_Id(inuOrderId,
                                                               null);

        if (nuOperating_Unit is not null) then

          nuActivity := nuActSalPub;

        else
          nuValidator := false;

        end if;

      end if;

      /*Se valida si se puede crear la orden de pago articulo por proveedor,
      pago comision a contratista de venta,cobro  comision a proveedor. */
      if (nuValidator) then

        /* Se crea orden dependiendo al tipo de actividad */
        nuorderid := null;

        /*Se obtiene la actividad de entrega de la orden*/
        BEGIN
          SELECT max(oa.order_activity_id)
            INTO nuOrderActivityRev
            FROM or_order_activity oa
           WHERE oa.activity_id = (cnuDelivActiv)
             AND oa.order_id = inuOrderId
             AND oa.package_id = inuPackageId;
        EXCEPTION
          when others then
            nuOrderActivityRev := null;
        END;

        createReviewOrderActivity(nuActivity,
                                  nuOrderId,
                                  nuOrderActivityRev,
                                  inuPackageId,
                                  'Generacion de orden',
                                  nuOrderActi);

        if (nuOrderId is not null) then

          /*Si el tipo de orden es cobro  comision a proveedor,Pago articulo por proveedor se asigna
          a la unidad operativa de la orden de entrega*/
          /*SE INCLUYE ASIGANACION A LA UNIDAD OPERATIVA DE LA ENTREGA SI (nuContOrder = 4) || SEBTAP || 200-1268*/
          if (nuContOrder = 1) or (nuContOrder = 3) or (nuContOrder = 4) then

            /* Obtiene la unidad operativa por cada una de las ordenes de entrega  */
            nuOperating_Unit := Daor_Order.fnuGetOperating_Unit_Id(inuOrderId,
                                                                   0);
          else

            /*Sino se asigna a la unidad operativa de la ot de venta*/
            nuOperating_Unit := Daor_Order.fnuGetOperating_Unit_Id(nuOrder,
                                                                   0);
          end if;

          /*Asigna la orden*/
          or_boprocessorder.ProcessOrder(nuOrderId,
                                         null,
                                         nuOperating_Unit,
                                         null,
                                         FALSE,
                                         NULL,
                                         NULL);

          /*Se procede actualizar los datos de valor y valor de referencia y
          se procede a legalizar la orden*/
          nuActivity := ld_bcflowfnbpack.FnuGetActivity(nuOrderId);

          /*Actualizo los campos valor de la orden de trabajo y valor de referencia,
          dependiendo a la opcion que se esta creando.*/

          /*

          IMPACTAR PARA QUE SOLO TRAIGA LOS VALORES DE LO LEGALIZADO

          */

          /*Si la opcion es pago articulos a proveedor*/
          if (nuContOrder = 3) then
            nuValOrder := ld_bopackagefnb.fnugetValueofSale(inuOrderId);
            ut_trace.trace('************if (nuContOrder = 3) then', 1);
          else
            /*Si la opcion es cobro comision a proveedor*/
            if (nuContOrder = 1) then
              nuValOrder := ld_boliquidationminute.GetCommission(inuOrderId);
              ut_trace.trace('************if (nuContOrder = 1) then', 1);
            else

              /*Si la opcion es pago comision a contratista de venta*/
              if (nuContOrder = 2) then
                nuValOrder := ld_boliquidationminute.GetCommissionSale(inuOrderId);
                --
                -- csc 200564 miguelm 01-12-2016
                --
                ut_trace.trace('************if (nuContOrder = 2) then', 1);
              ELSIF (nuContOrder = 4) then
                nuValOrder := GetCommissionSale(inuOrderId);
                ut_trace.trace('************if (nuContOrder = 4) then', 1);
              end if;

            end if;

          end if;
          --nc 4416 se redondea para efectos de liquidacion
          nuValOrder := round(nuValOrder);
          /*Se legaliza la ordenes pago articulos a proveedores,cobro a comision etc..*/
          BEGIN
            SELECT o.causal_id
              INTO vnucasal
              FROM OR_TASK_TYPE_CAUSAL o, ge_causal g
             WHERE task_type_id = daor_order.FNUGETTASK_TYPE_ID(nuOrderId)
               AND g.causal_id = o.causal_id
               AND g.class_causal_id = ld_boconstans.cnuclascauexito
               AND rownum = 1;
          EXCEPTION
            when others then
              vnucasal := or_boconstants.cnuSuccesCausal;
          END;

		IF cuCadenaLegalizacion%ISOPEN THEN
			CLOSE cuCadenaLegalizacion;
		END IF;
	
		OPEN cuCadenaLegalizacion (	nuOrderId, 
									ld_boutilflow.fnuGetPersonToLegal(daor_order.fnugetoperating_unit_id(nuOrderId)),
									vnucasal);
		FETCH cuCadenaLegalizacion INTO sbCadenaLegalizacion;
		CLOSE cuCadenaLegalizacion;
		

		--legaliz la ot con causal de exito

		api_legalizeorders(isbDataOrder     => sbCadenaLegalizacion, 
						   idtInitDate      => SYSDATE,
						   idtFinalDate     => SYSDATE, 
						   idtChangeDate    => SYSDATE,
						   onuerrorcode     => nuError,
						   osberrormessage  => sbError);                                        



          if (nuError <> 0) then
            ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                             sbError);
          end if;

          /*Se actualizan los valores*/
          daor_order.updorder_value(nuOrderId, nuValOrder);

          daor_order_activity.updvalue_reference(nuActivity, nuValOrder);

          -- Obtiene el ORDER_item de la actividad
          nuOrderItem := DAOR_Order_Activity.fnuGetOrder_Item_Id(nuActivity);

          -- Actualiza el valor al ORDER_item
          DAOR_Order_Items.UpdValue(nuOrderItem, nuValOrder);

        end if;

      end if;

      nuContOrder := nuContOrder + 1;
    END LOOP; -- LOOP de Creacion de ordenes
    /*Se actualiza el estado de corte y el estado de componente || Caso 200-1306*/
    ActEstacortyComp(inuPackageId);
    --Fin caso 200-1306

    ut_trace.trace('Fin LD_BOFlowFNBPack.GenerateOrdersByArt', 1);

  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      nuOrderGl := null;
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      nuOrderGl := null;
      Errors.setError;
      RAISE ex.CONTROLLED_ERROR;
  END GenerateOrdersByArt;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (coffee).

  Unidad         : GenerateOrderFNB
  Descripcion    : Busca las ot de entrega a partir de la solicitud de venta,
                   al momento de tener todas esas ot de entrega se busca la unidad
                   operativa y a partir de hay se crean tres ordes asociadas a las siguientes
                   actividades:
                   1. ACTI_PAGO_ARTI_PROV Pago articulo por proveedor
                   2. ACT_TYPE_SALE_COM Pago comision a contratista de venta
                   3. ACT_TYPE_PROVIDERS_COM cobro  comision a proveedor.

  Autor          : AAcuna
  Fecha          : 03/05/2013 09:56:27 p.m.

  Parametros              Descripcion
  ============            ===================
  inuPackage              Numero de solicitud
  onuError                Numero de error
  osbMessage              Mensaje de error

    Historia de Modificaciones
    Fecha       Autor                   Modificacion
    =========   =========               ====================
    16-06-2014  aesguerra.3649          Se encapsula la logica para reutilizarla
                    en legalizacion manual. Ahora este servicio solo se ejecuta
                    para los casos de legalizacion automatica.
    07-10-2013  LDiuza.SAO218287        Se adiciona reinicio de contador usado
                                        para generar ordenes por cada orden de entrega.
    05-09-2013  lfernandez.SAO215820    La actualizacion del valor de la orden,
                                        orden_activity y ORDER_item se hacen
                                        despues de legalizar la orden
    04-09-2013  lfernandez.SAO214404    No se le envia codigo y mensaje de error
                                        a GetCommission y GetCommissionSale. Se
                                        actualiza el valor del ORDER_item
  ******************************************************************/
  PROCEDURE GenerateOrderFNB(inuPackage in mo_packages.package_id%type,
                             onuError   OUT number,
                             osbMessage OUT varchar2) IS
    ------------------------------------------------------------------------
    --  Variables
    ------------------------------------------------------------------------

    nuErrorCode number;
    sbErrorMsg  varchar2(32000);

    /*                                        Parametros                                        */

    /*Cobro de comision a proveedor*/
    nuActProvCom constant ld_parameter.numeric_value%type := DALD_Parameter.fnuGetNumeric_Value('ACT_TYPE_PROVIDERS_COM');
    /*Pago de comision a contratista*/
    nuActSalCom constant ld_parameter.numeric_value%type := DALD_Parameter.fnuGetNumeric_Value('ACT_TYPE_SALE_COM');
    /*Pago de articulo a proveedor*/
    nuActDelDesc constant ld_parameter.numeric_value%type := DALD_Parameter.fnuGetNumeric_Value('ACTI_PAGO_ARTI_PROV');
    /*Actividad de instalacion*/
    nuActivityIns constant ld_parameter.numeric_value%type := DALD_Parameter.fnuGetNumeric_Value('COD_ACTIVITY_INSTALL');

    /*Tabla con ordenes a procesar*/
    rcDelivOrder daor_order_activity.tytbOrder_Id;

    /*Obtenga solo las ordenes con alguna entrega*/
    CURSOR cuGetOrder(inuPackage in mo_packages.package_id%type) IS
      SELECT DISTINCT o.order_id order_id
        FROM or_order_activity o, ld_item_work_order w
       WHERE o.package_id = inuPackage
         AND o.activity_id = cnuDelivActiv
         AND o.order_activity_id = w.order_activity_id
         AND w.state = 'RE';

    CURSOR cuPreviousLiquidation(inuOrderId or_order.order_id%type) IS
      SELECT count(1)
        FROM ld_detail_liqui_seller
       where base_order_id = inuOrderId;

    nuValidation number;

  BEGIN

    ut_trace.trace('Inicia LD_boflowFNBPack.GenerateOrderFNB', 10);

    /* Si la solicitud no existe envia mensaje que la solicitud ingresada no existe*/
    if (not damo_packages.fblexist(inuPackage)) then
      ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                       'SOLICITUD INGRESADA NO EXISTE');
    END if;

    if (nvl(nuActProvCom, LD_BOConstans.cnuCero) = LD_BOConstans.cnuCero OR
       nvl(nuActSalCom, LD_BOConstans.cnuCero) = LD_BOConstans.cnuCero OR
       nvl(nuActDelDesc, LD_BOConstans.cnuCero) = LD_BOConstans.cnuCero OR
       nvl(nuActivityIns, LD_BOConstans.cnuCero) = LD_BOConstans.cnuCero) then
      return;
    END if;

    /* Obtiene las ordenes de entrega asociadas a la solicitud */
    OPEN cuGetOrder(inuPackage);
    FETCH cuGetOrder BULK COLLECT
      INTO rcDelivOrder; -- Volcado Tabla PL de las ordenes de entrega, es UNA ORDEN POR CADA PROVEEDOR!!!
    CLOSE cuGetOrder;

    /*
    Si hay articulos entregados se generan
    ordenes de cobro y pago a proveedores
    por cada orden de entrega
    */
    IF rcDelivOrder.count > 0 THEN
      FOR n IN rcDelivOrder.first .. rcDelivOrder.last LOOP

        /*
        Se valida si esta orden se liquido previamente
        Esto con el fin de evitar que los flujos quemados antes del cambio 3649
        liquiden doble a los contratistas
        */
        if cuPreviousLiquidation%isopen then
          close cuPreviousLiquidation;
        end if;

        open cuPreviousLiquidation(rcDelivOrder(n));
        fetch cuPreviousLiquidation
          into nuValidation;
        close cuPreviousLiquidation;

        if nuValidation = 0 then
          /*Si no se ha generado liquidacion a contratistas para esta orden, se ejecuta*/
          GenerateOrdersByArt(inuPackageId   => inuPackage,
                              inuOrderId     => rcDelivOrder(n),
                              iblBatch       => true,
                              inuActProvCom  => nuActProvCom,
                              inuActSalCom   => nuActSalCom,
                              inuActDelDesc  => nuActDelDesc,
                              inuActivityIns => nuActivityIns);

        end if;
      END LOOP;
    END IF;

    ut_trace.trace('Fin LD_BOFlowFNBPack.GenerateOrderFNB', 1);

  EXCEPTION
    when LOGIN_DENIED OR pkConstante.exERROR_LEVEL2 OR ex.CONTROLLED_ERROR then
      nuOrderGl := null;
      raise;
    when OTHERS then
      nuOrderGl := null;
      Errors.SetError;
      raise ex.CONTROLLED_ERROR;
  END GenerateOrderFNB;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : Propricevariation
  Descripcion    : Verifica si en la tabla de Variacion de precio
                   Existe o no datos para enviar esta informacion al
                   flujo.
  Autor          : Karem Baquero
  Fecha          : 20/05/2013

  Parametros              Descripcion
  ============         ===================
  inupackage_id         identificador del paquete.


  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================

  ******************************************************************/

  FUNCTION fnupricevariation(inupackage_id in mo_packages.package_id%type)
    return number is

    Onuresp number;

  Begin
    ut_trace.trace('Inicio Ld_BoflowFNBPack.Propricevariation', 10);

    Ld_BcflowFNBPack.Propricevariation(inupackage_id, Onuresp);

    ut_trace.trace('Fin Ld_BoflowFNBPack.Propricevariation', 10);

  EXCEPTION
    When no_data_found then
      Onuresp := 0;
    WHEN ex.CONTROLLED_ERROR THEN
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      Errors.setError;
      RAISE ex.CONTROLLED_ERROR;
  END fnupricevariation;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : UpdateOrderActivityInst
   Descripcion    : Metodo que realiza la actualizacion del codigo de la
                    Instancia en todos las actividades de Or_order_activity
                    de la ordenes que se generaron de entrega.

   Autor          : KBaquero
   Fecha          : 21/05/2013

   Parametros       Descripcion
   ============     ===================
    Inupackage:       Id. paquete
    Inuorder:         Id. De orden


   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   21/05/2013       KBaquero                 Creacion
  ******************************************************************/

  procedure UpdateOrderActivityInst(Inupackage in mo_packages.package_id%type,
                                    Instance   in OR_ORDER_ACTIVITY.Instance_Id%type) is

    rcor_orderact  daor_order_activity.tytbOR_order_activity;
    nuorderacti    or_order_activity.order_activity_id%type;
    frgDelivOrders constants.tyrefcursor;
    tbDelivOrder   daor_order_activity.tytbOrder_Id;
    nuIndex        number;
    nuContOt       number := 0;

  begin

    ut_trace.Trace('INICIO LD_boflowFNBPack.UpdateOrderActivityInst', 10);

    /*Obtener de la tabla (or_order_activity), las ordenes de entrega asociadas
    a la solicitid de venta*/
    frgDelivOrders := ld_bcNonBankFinancing.frfGetDeliverOrders(Inupackage);

    FETCH frgDelivOrders BULK COLLECT
      INTO tbDelivOrder;
    CLOSE frgDelivOrders;

    nuIndex := tbDelivOrder.FIRST;

    WHILE nuIndex IS NOT NULL LOOP
      nuContOt := nuContOt + 1;

      daor_order_activity.getRecords('order_id =' || tbDelivOrder(nuIndex),
                                     rcor_orderact);

      if rcor_orderact.count > 0 then

        for i in rcor_orderact.FIRST .. rcor_orderact.LAST loop

          if rcor_orderact.EXISTS(i) then

            /*Se obtienen el numero de la actividad por orden */

            nuorderacti := rcor_orderact(i).order_activity_id;

            daor_order_activity.updInstance_Id(nuorderacti, Instance);

          end if;

        end loop;

      end if;

      nuIndex := tbDelivOrder.NEXT(nuIndex);

    END LOOP;

    ut_trace.Trace('FIN LD_boflowFNBPack.UpdateOrderActivityInst', 10);

  Exception
    When ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    When others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  end UpdateOrderActivityInst;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : AssignActToNewOrders
  Descripcion    : Asigna las actividades de entrega a ordenes regeneradas

  Autor          : Luis Alberto Lopez Agudelo
  Fecha          : 04-09-2013

  Parametros              Descripcion
  ============         ===================
  inuOrder              Numero de la orden
  inuCausal             Causal de legalizacion

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  04-12-2014      KCienfuegos.NC4068    Se modifica cursor cuArticleActByOrder para que tenga
                                        en cuenta articulos que estan en proceso A/D.
  06-09-2013      llopez.SAO213520      Se modifica para asignar las ordenes registradas
  04-09-2013      llopez.SAO213520      Creacion
  ******************************************************************/
  PROCEDURE AssignActToNewOrders(inuOrder   in or_order.order_id%type,
                                 inuCausal  in cc_causal.causal_id%type,
                                 inuOriUnit in or_operating_unit.operating_unit_id%type) IS

    nuOriOrder         or_order.order_id%type;
    nuNewOrder         or_order.order_id%type;
    nuNewActOrder      or_order_activity.order_activity_id%type;
    tbrcArticleAct     dald_item_work_order.tytbLD_item_work_order;
    nuIdxArtActByOrder number;
    nuAnullCausal      ld_parameter.numeric_value%type;

    CURSOR cuOrdRegenerada(inuActOrderId or_order_activity.order_activity_id%type) IS
      SELECT /*+ index(or_order_activity IDX_OR_ORDER_ACTIVITY_03) */
       or_order_activity.order_id, or_order_activity.order_activity_id
        FROM or_order_activity
       WHERE or_order_activity.origin_activity_id = inuActOrderId;

    CURSOR cuArticleActByOrder(inuOrderId or_order.order_id%type) IS
      SELECT /*+ index(ld_item_work_order IX_LD_ITEM_WORK_ORDER) */
       ld_item_work_order.*, LD_item_work_order.rowid
        FROM ld_item_work_order, or_order_activity, or_order_items
       WHERE or_order_activity.order_activity_id =
             ld_item_work_order.order_activity_id
         AND or_order_items.order_items_id =
             or_order_activity.order_item_id
         AND or_order_items.legal_item_amount = 0
         AND ld_item_work_order.order_id = inuOrderId
         AND ld_item_work_order.state in (csbEntregado, csbEnProcesoAD);

  BEGIN
    ut_trace.trace('Inicia ld_boflowfnbpack.AssignActToNewOrders = ' ||
                   inuOrder,
                   15);
    -- Asocia las actividades de entrega a las nuevas ordenes creadas por regeneracion
    -- Obtiene las actividades de entrega de articulos
    open cuArticleActByOrder(inuOrder);
    fetch cuArticleActByOrder BULK COLLECT
      INTO tbrcArticleAct;
    close cuArticleActByOrder;
    nuIdxArtActByOrder := tbrcArticleAct.first;
    -- Si hay actividades de entrega pendientes se valida si se anulan, se reasignan
    -- o no se deja legalizar la orden por falta de configuracion
    while (nuIdxArtActByOrder is not null) loop
      -- Obtiene la orden asociada a la actividad de orden
      nuOriOrder := daor_order_activity.fnuGetOrder_Id(tbrcArticleAct(nuIdxArtActByOrder)
                                                       .order_activity_id,
                                                       0);
      -- Si la la orden de la actividad es la misma a la del registro de entrega se valida si se regenero orden
      if (nuOriOrder = tbrcArticleAct(nuIdxArtActByOrder).order_id) then
        -- Obtiene la orden regenerada para la actvidad
        open cuOrdRegenerada(tbrcArticleAct(nuIdxArtActByOrder)
                             .order_activity_id);
        fetch cuOrdRegenerada
          INTO nuNewOrder, nuNewActOrder;
        close cuOrdRegenerada;

        ut_trace.trace('ld_boflowfnbpack.AssignActToNewOrders -->nuNewOrder ' ||
                       nuNewOrder,
                       15);

        -- Si regenero orden actualiza el registro de entrega
        if (nuNewOrder is not null) then
          -- Actualiza el registro de entrega
          tbrcArticleAct(nuIdxArtActByOrder).order_id := nuNewOrder;
          tbrcArticleAct(nuIdxArtActByOrder).order_activity_id := nuNewActOrder;
          dald_item_work_order.updRecord(tbrcArticleAct(nuIdxArtActByOrder));

          -- Si NO regenero orden
        else
          -- Obtiene la causal de anulacion de la entrega
          nuAnullCausal := dald_parameter.fnuGetNumeric_Value('ANULL_DELIVERY_FNB_CAUSAL');
          -- Si la causal de legalizacion es para anulacion de la entrega
          if (nuAnullCausal = inuCausal) then
            -- Actualiza el registro de entrega
            tbrcArticleAct(nuIdxArtActByOrder).state := 'AN';
            dald_item_work_order.updRecord(tbrcArticleAct(nuIdxArtActByOrder));
            -- Si no regenero orden levanta error indicando que no hay configuracion de regeneracion
          else
            ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                             'No posee configuracion para regenerar la actividad de entrega que no se realizo');
          end if;
        end if;
        -- Si la orden fue sacada de la agrupacion en una orden nueva
      elsif (nuOriOrder <> tbrcArticleAct(nuIdxArtActByOrder).order_id) then
        if (inuOriUnit is not null) then
          -- Actualiza el registro de entrega
          tbrcArticleAct(nuIdxArtActByOrder).order_id := nuOriOrder;
          dald_item_work_order.updRecord(tbrcArticleAct(nuIdxArtActByOrder));
          or_boprocessorder.ProcessOrder(nuOriOrder,
                                         null,
                                         inuOriUnit,
                                         null,
                                         FALSE,
                                         NULL,
                                         NULL);
        else
          ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                           'No posee configuracion para regenerar la actividad de entrega que no se realizo');
        end if;
      else
        ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                         'No posee configuracion para regenerar la actividad de entrega que no se realizo');
      end if;
      nuIdxArtActByOrder := tbrcArticleAct.next(nuIdxArtActByOrder);
    end loop;

    ut_trace.trace('Fin ld_boflowfnbpack.AssignActToNewOrders', 15);
  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      Errors.setError;
      RAISE ex.CONTROLLED_ERROR;
  END AssignActToNewOrders;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : LegDelOrder
   Descripcion    : Este servicio recibe como parametro de entrada, paquete, orden, causal, cadena (contiene las actividades
                    , y realizacion de actividad 1 (si) 0 (no))(id actividad,1(exito) 0 (fallo)|??.), ademas debe realizar la legalizacion
                    de ordenes.,legaliza las ordenes de entrega
                    La cadena debe tener el siguiente formato:
                    1243|1|1212|1
                    Actividad|Causal|Actividad|Causal
   Autor          : AAcuna
   Fecha          : 21/05/2013

   Parametros       Descripcion
   ============     ===================
   inuOrder:        Numero de la orden
   inuCausal:       Numero de la causal
   isbCad:          Cadena de actividades con su causal

   Historia de Modificaciones

    Fecha       Autor                   Modificacion
    =========   =========               ====================
    07-06-2017  Jorge Valiente          CASO 200-1164: Se modifico la logica del cursor cuExiteSerguroVoluntario
                                                       para validar la existencia del articulo directamente con la
                                                       tabla LD_ARTICLE
    16-06-2014  aesguerra.3649          Se a?ade llamado al servicio para generacion
                                        de ordenes de cobro y pago a proveedores y contratistas
    16-09-2013  lfernandez.SAO213274    Ya no se valida si hay valor de pago
                                        para consultar la cuenta, ya que puede
                                        ser que con la legalizacion de la
                                        primera orden se crea la cuenta y cuando
                                        se vaya a legalizar la segunda orden se
                                        sebe usar la misma cuenta. Se obtiene si
                                        el vendedor es proveedor o contratista y
                                        se le envia a CreateDelivOrderCharg
    10-09-2013  lfernandez.SAO213274    Se le envia a CreateDelivOrderCharg el
                                        valor del pago inicial
    04-09-2013  llopez.SAO213566        Se modifica para que la cantidad no dependa
                                        de la causal de legalizacion
    03-09-2013  llopez.SAO213520        Se modifica para soportar regeneracion
                                        de ordenes
    30-08-2013  lfernandez.SAO211681    Se establece la aplicacion
    28-08-2013  lfernandez.SAO211681    Se envia el valor facturado a
                                        CreateDelivOrderCharg
   21/05/2013       AAcuna                Creacion
   26-10-2017  rcolpas.SAO2001537       Se calcula el valor de la venta el articulo
                                        CARDIF (seguro voluntario)
                                        para restarselo al total venta
  ******************************************************************/
  PROCEDURE LegDelOrder(inuOrder  in or_order.order_id%type,
                        inuCausal in cc_causal.causal_id%type,
                        isbCad    in varchar2) IS
    ------------------------------------------------------------------------
    --  Variables
    ------------------------------------------------------------------------
    sbSep          varchar2(2) := '|';
    sbSep2         varchar2(2) := ',';
    nuError        number;
    sbMessage      varchar2(2000);
    blCausalType   boolean;
    nuIdx          binary_integer;
    nuQuantity     number;
    sbActivity     varchar2(32000);
    sbQuantity     varchar2(32000);
    sbActivQuant   varchar2(32000);
    nuValorAbono   number;
    nuPaymentValue number;
    nuValTVen      number;

    nuValcardif number; --caso 200-1537

    boIsSupplier boolean;
    nuAccount    cuencobr.cucocodi%type := pkConstante.NULLNUM;
    nuPackage    or_order_activity.package_id%type;
    nuActivity   or_order_activity.order_activity_id%type;
    nuorderItem  or_order_activity.order_item_id%type;

    tbActivities   UT_String.TyTb_String;
    nuOriOperUnit  or_operating_unit.operating_unit_id%type;
    nuSellOperUnit or_operating_unit.operating_unit_id%type;
    ------------------------------------------------------------------------
    --  Cursores
    ------------------------------------------------------------------------
    CURSOR cuPackageOrder IS
      SELECT package_id
        FROM or_order_activity
       WHERE ORDER_id = inuOrder
         AND rownum = 1;

    --CASO 200-1164
    cursor cuExiteSerguroVoluntario(inupackage_id mo_packages.package_id%type) is

      select nvl(oo.order_id, 0) OrdenSeguro,
             nvl(ooa.order_activity_id, 0) OrdenActividad
        from open.Or_Order_Activity  ooa,
             open.ld_item_work_order liwo,
             open.or_order           oo
       where ooa.package_id = inupackage_id
         and liwo.order_id = ooa.order_id
         and liwo.order_activity_id = ooa.order_activity_id
         and (SELECT /*+ index (L PK_LD_ARTICLE IX_LD_ARTICLE_04) */
               count(1)
                FROM LD_ARTICLE L
               WHERE l.concept_id IN
                     (select nvl(to_number(column_value), 0)
                        from table(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('CONCEPTO_EXCLUIDO_CUPO_BRILLA',
                                                                                                 NULL),
                                                                ','))
                       where l.article_id = liwo.ARTICLE_ID)) > 0
         and oo.order_id = ooa.order_id
         and oo.order_status_id = 5;

    --Caso 20-1537
    --Calculamos el valor del articulo CARDIF
    CURSOR cuValVenCARDIF(inuPackage mo_packages.package_id%type, inuDelivActiv or_order_activity.activity_id%type) IS
      SELECT nvl(SUM(w.amount * w.value), 0) + nvl(SUM(w.iva), 0) valor
        FROM ld_item_work_order w, or_order_activity oa
       WHERE oa.package_id = inuPackage
         AND oa.activity_id = cnuDelivActiv
         AND w.article_id IN
             (SELECT l.article_id
                FROM open.LD_ARTICLE L
               WHERE L.Concept_Id IN
                     (select nvl(to_number(column_value), 0)
                        from table(open.ldc_boutilities.splitstrings(open.dald_parameter.fsbgetvalue_chain('CONCEPTO_EXCLUIDO_CUPO_BRILLA',
                                                                                                           NULL),
                                                                     ',')))) --caso 2001537 excluir articulo cardif del total de la venta
         AND w.order_activity_id = oa.order_activity_id;

    rfcuExiteSerguroVoluntario cuExiteSerguroVoluntario%rowtype;
    --CASO 200-1164

    ------------------------------------------------------------------------
    --  Metodos encapsulados
    ------------------------------------------------------------------------
    PROCEDURE NotifyFlow IS
      cnuFLOW_ACTION constant number := 8190;

      nuResult       number;
      nuErrorCode    number;
      sbErrorMessage varchar2(2000);

      CURSOR cuPackageDeliOrders IS
        SELECT 1
          FROM or_order_activity oa, or_order o
         WHERE oa.order_id = o.order_id
           AND oa.package_id = nuPackage
           AND oa.activity_id = cnuDelivActiv
           AND o.order_status_id in (OR_BOConstants.cnuORDER_STAT_REGISTERED,
                OR_BOConstants.cnuORDER_STAT_ASSIGNED)
           AND rownum = 1;
    BEGIN

      UT_Trace.Trace('LD_BOFlowFNBPack.LegDelOrder.NotifyFlow', 16);

      --  Consulta las ordenes de entrega de la solicitud registradas o asignadas
      open cuPackageDeliOrders;
      fetch cuPackageDeliOrders
        INTO nuResult;
      close cuPackageDeliOrders;

      --  Si no encuentra le notifica al flujo para que continue
      if (nuResult IS null) then

        UT_Trace.Trace('No hay ordenes de entrega pendientes, se notifica el flujo',
                       3);
        procValidateFlowMove(cnuFLOW_ACTION,
                             nuPackage,
                             nuErrorCode,
                             sbErrorMessage);
      END if;

      UT_Trace.Trace('Fin LD_BOFlowFNBPack.LegDelOrder.NotifyFlow', 16);

    EXCEPTION
      when LOGIN_DENIED OR pkConstante.exERROR_LEVEL2 OR
           ex.CONTROLLED_ERROR then
        raise;
      when OTHERS then
        Errors.SetError;
        raise ex.CONTROLLED_ERROR;
    END NotifyFlow;
    ------------------------------------------------------------------------

  BEGIN

    ut_trace.trace('Inicia ld_boflowfnbpack.LegDelOrder = ' || inuOrder,
                   15);
    ut_trace.trace('    ld_boflowfnbpack.LegDelOrder(' || inuOrder || ',' ||
                   inuCausal || ',' || isbCad || ');');

    if (inuOrder is null OR inuCausal is null OR isbCad is null) then
      return;
    END if;

    --  Establece la aplicacion
    pkErrors.SetApplication(CC_BOConstants.csbCUSTOMERCARE);
    blCausalType := ge_bocausal.fblGetSucessfullClassCausal(inuCausal);

    --  Pasa el listado de actividades de cadena a tabla PL como: actividad,valor
    UT_String.ExtString(isbCad, sbSep, tbActivities);
    nuIdx := tbActivities.first;

    while (nuIdx IS not null) loop

      sbActivQuant := tbActivities(nuIdx);

      sbActivity := substr(sbActivQuant, 1, instr(sbActivQuant, sbSep2) - 1);
      sbQuantity := substr(sbActivQuant, instr(sbActivQuant, sbSep2) + 1);

      nuActivity := to_number(sbActivity);

      nuorderItem := DAOR_Order_Activity.fnuGetOrder_Item_Id(nuActivity);

      /* Sin importar la causal la cantidad es la ingresada en la forma */
      nuQuantity := TO_NUMBER(sbQuantity);
      if nuQuantity > 0 THEN
        nuQuantity := 1;
      END IF;

      DAOR_Order_Items.updLegal_Item_Amount(nuorderItem, nuQuantity);

      nuIdx := tbActivities.next(nuIdx);

    END loop;

    nuOriOperUnit := daor_order.fnugetoperating_unit_id(inuOrder, 0);

    --  Obtiene la solicitud de la orden
    open cuPackageOrder;
    fetch cuPackageOrder
      INTO nuPackage;
    close cuPackageOrder;

    --  Obtiene la unidad operativa del vendedor
    nuSellOperUnit := DAMO_Packages.fnuGetPos_Oper_Unit_Id(nuPackage);

    --  Asigna si la clase de unidad es proveedor
    boIsSupplier := DAOR_Operating_unit.fnuGetOper_Unit_Classif_Id(nuSellOperUnit) =
                    cnuSupplierFNB;

    /*Luego se llama al proceso de legalizacion de ordenes de trabajo:*/
    LD_Legalize(inuOrder,
                inuCausal,
                nvl(ld_boutilflow.fnuGetPersonToLegal(nuOriOperUnit),
                    ge_bopersonal.fnugetpersonid),
                sysdate,
                sysdate,
                nuError,
                sbMessage);

    gw_boerrors.checkerror(nuError, sbMessage);

    --identifica el valor de la cuota inicial dada en la solicitud de venta
    nuValorAbono := NVL(DALD_Non_Ba_Fi_Requ.fnuGetPayment(nuPackage), 0);
    --  Asigna el valor del pago
    nuPaymentValue := nuValorAbono;

    -- Busco el valor total
    OPEN cuValTotaVen(nuPackage, cnuDelivActiv);
    FETCH cuValTotaVen
      INTO nuValTVen;
    CLOSE cuValTotaVen;

    --caso 2001537 busco el valor del articulo cardif (seguro voluntario)
    OPEN cuValVenCARDIF(nuPackage, cnuDelivActiv);
    FETCH cuValVenCARDIF
      INTO nuValcardif;
    CLOSE cuValVenCARDIF;

    --caso 2001537 se resta al total de la venta el valor de la venta cardif
    nuValTVen := nuValTVen - nuValcardif;

    --  Crea los cargos para la orden
    CreateDelivOrderCharg(inuOrder,
                          nuPackage,
                          cnuCause,
                          nuValTVen,
                          nuPaymentValue,
                          boIsSupplier,
                          nuAccount,
                          nuValorAbono,
                          nuValTVen);

    -- Asigna las actividades de entrega a ordenes regeneradas
    AssignActToNewOrders(inuOrder, inuCausal, nuOriOperUnit);

    GenerateOrdersByArt(inuPackageId => nuPackage, inuOrderId => inuOrder);

    --  Trata de notificar al flujo que continue si todas las ordenes de entrega
    --  fueron cerradas
    NotifyFlow;

    --CASO 200-1164
    --Legaliza la Orden de entrega generada para el articulo de Seguro Volunatio
    --para que este proceso de legalizacion se realiza se manera automatica con
    --la le galizacion del 1ar articulo de la orden de entrega original de BRILLA

    open cuExiteSerguroVoluntario(nuPackage);
    fetch cuExiteSerguroVoluntario
      into rfcuExiteSerguroVoluntario;
    if cuExiteSerguroVoluntario%found then
      if rfcuExiteSerguroVoluntario.Ordenseguro > 0 then

        ut_trace.trace('Orden Serguro Voluntario[' ||
                       rfcuExiteSerguroVoluntario.Ordenseguro || ']',
                       10);
        ut_trace.trace('Orden Actividad Serguro Voluntario[' ||
                       rfcuExiteSerguroVoluntario.Ordenactividad || ']',
                       10);

        --Actualizar la cantidad de items para proceso de legalizacion
        nuorderItem := DAOR_Order_Activity.fnuGetOrder_Item_Id(rfcuExiteSerguroVoluntario.Ordenactividad);
        nuQuantity  := 1;
        DAOR_Order_Items.updLegal_Item_Amount(nuorderItem, nuQuantity);
        ------------------------------------------

        nuOriOperUnit := daor_order.fnugetoperating_unit_id(rfcuExiteSerguroVoluntario.Ordenseguro,
                                                            0);

        /*Luego se llama al proceso de legalizacion de ordenes de trabajo:*/
        LD_Legalize(rfcuExiteSerguroVoluntario.Ordenseguro,
                    inuCausal,
                    nvl(ld_boutilflow.fnuGetPersonToLegal(nuOriOperUnit),
                        ge_bopersonal.fnugetpersonid),
                    sysdate,
                    sysdate,
                    nuError,
                    sbMessage);

        gw_boerrors.checkerror(nuError, sbMessage);

        --identifica el valor de la cuota inicial dada en la solicitud de venta
        --nuValorAbono := NVL(DALD_Non_Ba_Fi_Requ.fnuGetPayment(nuPackage), 0);
        nuValorAbono := 0;
        --  Asigna el valor del pago
        nuPaymentValue := nuValorAbono;

        -- Busco el valor total
        OPEN cuValTotaVen(nuPackage, cnuDelivActiv);
        FETCH cuValTotaVen
          INTO nuValTVen;
        CLOSE cuValTotaVen;

        --caso 2001537 busco el valor del articulo cardif (seguro voluntario)
        OPEN cuValVenCARDIF(nuPackage, cnuDelivActiv);
        FETCH cuValVenCARDIF
          INTO nuValcardif;
        CLOSE cuValVenCARDIF;

        --caso 2001537 se resta al total de la venta el valor de la venta cardif
        nuValTVen := nuValTVen - nuValcardif;

        --  Crea los cargos para la orden
        CreateDelivOrderCharg(rfcuExiteSerguroVoluntario.Ordenseguro,
                              nuPackage,
                              cnuCause,
                              nuValTVen,
                              nuPaymentValue,
                              boIsSupplier,
                              nuAccount,
                              nuValorAbono,
                              nuValTVen);

        -- Asigna las actividades de entrega a ordenes regeneradas
        AssignActToNewOrders(rfcuExiteSerguroVoluntario.Ordenseguro,
                             inuCausal,
                             nuOriOperUnit);

        GenerateOrdersByArt(inuPackageId => nuPackage,
                            inuOrderId   => rfcuExiteSerguroVoluntario.Ordenseguro);

        --  Trata de notificar al flujo que continue si todas las ordenes de entrega
        --  fueron cerradas
        NotifyFlow;
      end if;
    end if;

    close cuExiteSerguroVoluntario;
    --Fin CASO 200-1164

    ut_trace.trace('Fin ld_boflowfnbpack.LegDelOrder', 15);

  Exception
    When ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    When others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END LegDelOrder;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : createReviewOrderActivity
  Descripcion    : Crea las actividades de tipo instalacion, permitiendo el servicio
                   crear ordenes de diferentes tipos de actividades y ademas permite
                   registrar comentario.

  Autor          : AAcuna
  Fecha          : 23/05/2013

  Parametros              Descripcion
  ============         ===================
  inuOrderActivity     Actividad de la orden
  ionuOrder            Numero de la orden
  inuOrderActivityRev  Actividad

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  06-09-2013      llopezSAO213559     Se modifica para que los intentos de legalizacion
                                      sean 0 y no nulo para poder regenerar la
                                      orden y asignarla a la misma vez
  23/05/2013      AAcuna              Creacion
  ******************************************************************/

  PROCEDURE createReviewOrderActivity(inuOrderActivity    in ge_items.items_id%type,
                                      ionuOrder           in out or_order.order_id%type,
                                      inuOrderActivityRev in or_order_activity.order_activity_id%type,
                                      inupackage          in mo_packages.package_id%type,
                                      isbComment          in or_order_activity.comment_%type default null,
                                      onuOrderActivity    out or_order_activity.order_activity_id%type) IS

    rcOrderActivy daor_order_activity.styOR_order_activity;

  begin

    ut_trace.trace('Inicio ld_boflowfnbpack.createReviewOrderActivity', 15);

    daor_order_activity.getRecord(inuOrderActivityRev, rcOrderActivy);

    if inupackage = null then
      rcOrderActivy.package_id := inupackage;
    end if;

    /*Genera Orden de entrega*/
    or_boorderactivities.createactivity(inuitemsid          => inuOrderActivity,
                                        inupackageid        => rcOrderActivy.package_id,
                                        inumotiveid         => rcOrderActivy.motive_Id,
                                        inucomponentid      => null,
                                        inuinstanceid       => null,
                                        inuaddressid        => rcOrderActivy.address_id,
                                        inuelementid        => null,
                                        inusubscriberid     => rcOrderActivy.subscriber_id,
                                        inusubscriptionid   => rcOrderActivy.subscription_id,
                                        inuproductid        => rcOrderActivy.product_id,
                                        inuopersectorid     => null,
                                        inuoperunitid       => null,
                                        idtexecestimdate    => null,
                                        inuprocessid        => null,
                                        isbcomment          => isbComment,
                                        iblprocessorder     => false,
                                        inupriorityid       => null,
                                        ionuorderid         => ionuOrder,
                                        ionuorderactivityid => onuOrderActivity,
                                        inuordertemplateid  => null,
                                        isbcompensate       => null,
                                        inuconsecutive      => null,
                                        inurouteid          => null,
                                        inurouteconsecutive => null,
                                        inulegalizetrytimes => 0,
                                        isbtagname          => null,
                                        iblisacttogroup     => false,
                                        inurefvalue         => null);

    daor_order_activity.updOrigin_Activity_Id(onuOrderActivity,
                                              inuOrderActivityRev);

    ut_trace.trace('Fin ld_boflowfnbpack.createReviewOrderActivity', 15);

  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      Errors.setError;
      RAISE ex.CONTROLLED_ERROR;
  END createReviewOrderActivity;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ActivateProduct
  Descripcion    : Crea las actividades de tipo instalacion, permitiendo el servicio
                   crear ordenes de diferentes tipos de actividades y ademas permite
                   registrar comentario.

  Parametros              Descripcion
  ============         ===================
  inuPackageId         Numero de solicitud asociada

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  26/11/2014      KCienfuegos.NC4059  Se corrige la subconsulta del cursor cuVentaServFinan
  12/11/2014      KCienfuegos.NC3686  Se modifica para obtener la solicitud de creacion de productos
                                      financieros, con base al producto asociado al motivo de la solicitud
                                      de venta FNB. Esto permite que el producto pueda ser activado, con la
                                      atencion de cualquier solicitud de venta que lo tenga asociado, y no que
                                      se active solo con la venta que dio paso a la creacion el producto, tal
                                      como estaba anteriormente. Se crea cursor cuVentaServFinan.
  23/10/2013      jrobayo.SAO221150   Se modifica para permitir la activacion de productos
                                      7056 - Servicios financieros promigas creados desde
                                      la Financiacion de Articulos de Proveedor.
  ******************************************************************/

  PROCEDURE ActivateProduct(inuPackageId in mo_packages.package_id%type) IS

    nuSalePackId number;

    CURSOR cuSalePack(inuPackageId in mo_packages.package_id%type) IS
      SELECT mo_packages_asso.PACKAGE_id_asso
        FROM mo_packages_asso, mo_packages
       WHERE mo_packages_asso.package_id_asso = mo_packages.package_id
         AND mo_packages.package_type_id in (100218, 100219) -- solicitud de venta
         AND mo_packages_asso.package_id = inuPackageId;

    cursor cuVentaServFinan(inuPackageId in mo_packages.package_id%type) is
      select vs.package_id
        from mo_packages vs, mo_motive m
       where vs.package_id = m.package_id
         and vs.package_type_id in
             (dald_parameter.fnuGetNumeric_Value('PACK_TYPE_FNB'),
              dald_parameter.fnuGetNumeric_Value('PACK_TYPE_FNB_PRO'))
         and m.product_id = (select product_id
                               from mo_motive mt
                              where mt.package_id = inuPackageId
                                and rownum = 1);

  BEGIN

    /* IF cuSalePack%ISOPEN THEN
        CLOSE cuSalePack;
    END IF;

    OPEN cuSalePack(inuPackageId);
    FETCH cuSalePack INTO nuSalePackId;
    CLOSE cuSalePack;*/

    --INI NC3686
    IF cuVentaServFinan%ISOPEN THEN
      CLOSE cuVentaServFinan;
    END IF;

    OPEN cuVentaServFinan(inuPackageId);
    FETCH cuVentaServFinan
      INTO nuSalePackId;
    CLOSE cuVentaServFinan;
    --FIN NC3686

    if (pkErrors.fsbGetApplication IS null) then
      pkerrors.setapplication('CUSTOMER');
    END if;

    MO_BOATTENTION.ATTENDCREATIONPRODBYPACKMASS(nuSalePackId,
                                                60,
                                                PR_BOPARAMETER.FNUGETPRODACTI());

  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      Errors.setError;
      RAISE ex.CONTROLLED_ERROR;
  END ActivateProduct;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : fnuVerifacancelot
  Descripcion    : retorna 0 si ot de tranferecia de cupo legalizada con fallo
                   se legalizan con causal de exito retorna 1
  Autor          : Alex Valencia Ayola
  Fecha          : 26/04/2013

  Parametros              Descripcion
  ============         ===================
  inupackage       Identificador de la solicitud de venta

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================

  ******************************************************************/
  FUNCTION fnuValApproveTransferQuota(inupackage IN mo_packages.package_id%TYPE)
    RETURN PLS_INTEGER IS

    nuactivityTrasn ld_parameter.numeric_value%type;
    tbactivity      daor_order_activity.tytbOR_order_activity;

  BEGIN
    ut_trace.trace('Inicio Ld_BoflowFNBPack.fnuValApproveTransferQuota',
                   10);

    --identifica actividad de traslada de cupo
    nuactivityTrasn := dald_parameter.fnuGetNumeric_Value('TRANSFER_QUOTA_FNB_ACTIVI_TYPE');
    --consulta la orden de trabajo asociado al paquete y la actividad

    daor_order_activity.getRecords('or_order_activity.package_id = ' ||
                                   inupackage ||
                                   ' and or_order_activity.activity_id = ' ||
                                   nuactivityTrasn,
                                   tbactivity);

    --si hay registro registro es por q se genero ordenes y por ende requiere aprobacion.
    if tbactivity.count > 0 then
      --verifica q la ot exista
      if daor_order.fblexist(tbactivity(tbactivity.first).order_Id) then
        --verifica q la ot este legalizada
        if daor_order.fnugetorder_status_id(tbactivity(tbactivity.first)
                                            .order_Id) =
           Dald_Parameter.fnuGetNumeric_Value('COD_ORDER_STATUS') then
          /* Obtiene la causal de la ordenes de transferencia de cupo */
          if dage_causal.fnuGetClass_Causal_Id(daor_order.fnugetcausal_id(tbactivity(tbactivity.first)
                                                                          .order_Id)) =
             ld_boconstans.cnuclascauexito then

            return 1;

          else

            return 0;

          end if;
        end if;
      end if;
    end if;

    ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                     'La orden de traslado de cupo no tiene condiciones de verificacion validas verifique');
    ut_trace.trace('Final Ld_BoflowFNBPack.fnuValApproveTransferQuota', 10);
    --------------------
  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      Errors.setError;
      RAISE ex.CONTROLLED_ERROR;
  END fnuValApproveTransferQuota;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : GetCatSubBySuscripc
  Descripcion    : Obtiene la categoria y subcategoria del contrato.

  Autor          : Mmira
  Fecha          : 04/09/2013

  Parametros              Descripcion
  ============         ===================
  inuSuscripc         Contrato
  onuCategory         Categoria
  onuSubcateg         Subcategoria

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================

  ******************************************************************/
  PROCEDURE GetCatSubBySuscripc(inuSuscripc in suscripc.susccodi%type,
                                onuCategory out categori.catecodi%type,
                                onuSubcateg out subcateg.sucacodi%type) IS
    tbAddress daab_address.styAB_address;
    nuAddress suscripc.susciddi%type;

  BEGIN

    ut_trace.Trace('INICIO LD_boflowFNBPack.GetCatSubBySuscripc', 10);

    nuAddress := pktblsuscripc.fnugetsusciddi(inuSuscripc);

    if (daab_address.fblexist(nuAddress)) then
      tbAddress := daab_address.frcgetrecord(nuAddress);

      if (tbAddress.estate_number IS not null) then
        onuCategory := daab_premise.fnugetcategory_(tbAddress.estate_number);
        onuSubcateg := daab_premise.fnugetsubcategory_(tbAddress.estate_number);
      END if;

      if (onuCategory IS null OR onuSubcateg IS null) then
        onuCategory := daab_segments.fnugetcategory_(tbAddress.segment_id);
        onuSubcateg := daab_segments.fnuGetsubcategory_(tbAddress.segment_id);
      END if;
    END if;

    onuCategory := nvl(onuCategory, pkconstante.NULLNUM);
    onuSubcateg := nvl(onuSubcateg, pkconstante.NULLNUM);

    ut_trace.Trace('FIN LD_boflowFNBPack.GetCatSubBySuscripc', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END GetCatSubBySuscripc;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : GetParsedAddrById
  Descripcion    : Obtiene la direccion parseada y la ubicacion geografica a
                  partir del identificador de la direccion.

  Autor          : Mmira
  Fecha          : 05/09/2013

  Parametros              Descripcion
  ============         ===================
  inuAddressId        Direccion
  onuParsedAddr       Direccion parseada
  onuGeoLoc           Ubicacion geografica

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================

  ******************************************************************/
  PROCEDURE GetParsedAddrById(inuAddressId  in ab_address.address_id%type,
                              onuParsedAddr out ab_address.address_parsed%type,
                              onuGeoLoc     out ab_address.geograp_location_id%type) IS
    tbAddress daab_address.styAB_address;

  BEGIN

    ut_trace.Trace('INICIO LD_boflowFNBPack.GetParsedAddrById', 10);

    if (daab_address.fblexist(inuAddressId)) then

      tbAddress := daab_address.frcgetrecord(inuAddressId);

      onuParsedAddr := tbAddress.address_parsed;
      onuGeoLoc     := tbAddress.geograp_location_id;
    END if;

    ut_trace.Trace('FIN LD_boflowFNBPack.GetParsedAddrById', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END GetParsedAddrById;

  PROCEDURE AttendVisitPackage(inuSalePackage IN mo_packages.package_id%type) IS
    --Codigo del contrato en el que se encuentra asociada la solcitud
    nuSubscriptionId suscripc.susccodi%type;
    -- Codigo de la solictud de visita asociada
    nuVisitpackage mo_packages.package_id%type;
    -- Unidad operativa Solicitud Venta
    nuSalePackOperatingUnit or_operating_unit.operating_unit_id%type;
    -- Unidad operativa Solicitud de visita
    nuVisitPackOperatingUnit or_operating_unit.operating_unit_id%type;
    -- Tabla PL donde se almacenan las ordenes asociadas a la solicitud de visita
    tbOrders tytbOrders;
    --Indice para recorrer las ordenes
    nuIndexOrders NUMBER := 0;
    --Variables para gestion de errores
    nuError   number;
    sbMessage varchar2(2000);
    -- Codigo de la accion asociada en la solicitud de venta
    nuAccion NUMBER := 100;

    sbParamActivities ld_parameter.value_chain%type := dald_parameter.fsbGetValue_Chain('ACT_LEG_VISIT');

  BEGIN
    ut_trace.Trace('INICIO LD_BOFlowFNBPack.AttendVisitPackage', 10);

    -- Se obtiene el codigo del contrato
    nuSubscriptionId := damo_packages.fnugetsubscription_pend_id(inuSalePackage);
    ut_trace.Trace('Codigo Contrato ' || nuSubscriptionId, 10);

    -- Si esta abierto el CURSOR que obtiene el id de la solicitud de visita se cierra
    IF (cuGetVisitPackageId%ISOPEN) THEN
      CLOSE cuGetVisitPackageId;
    END IF;

    --Se obtiene el id de la solicitud de visita
    OPEN cuGetVisitPackageId(nuSubscriptionId);
    FETCH cuGetVisitPackageId
      INTO nuVisitpackage;
    CLOSE cuGetVisitPackageId;

    -- Valida que se haya encontrado solicitud de visita
    /* IF(nuVisitpackage IS NULL) THEN
        RETURN;
    END IF; */
    ut_trace.Trace('Codigo Solicitud de Visita ' || nuVisitpackage, 10);

    --Obtiene la unidad operativa que registra la solicitud de visita
    --nuVisitPackOperatingUnit := damo_packages.fnugetpos_oper_unit_id(nuVisitpackage);

    --Obtiene unidad operativa que registra la solicitud de venta
    nuSalePackOperatingUnit := damo_packages.fnugetpos_oper_unit_id(inuSalePackage);
    ut_trace.Trace('Codigo Unidad Operativa de la solicitud de venta ' ||
                   nuSalePackOperatingUnit,
                   10);

    /* Valida si son diferentes las unidades operativas de la solicitud de venta y la solicitud de visita
        y solo legaliza ordenes de visita de la unidad operativa que solicita la venta, no se realiza
        el proceso
    */

    --Si esta abierto el CURSOR que obtiene las ordenes a legalizar
    IF (cuOrdersToLegalize%ISOPEN) THEN
      CLOSE cuOrdersToLegalize;
    END IF;

    IF (dald_parameter.fsbGetValue_Chain('LEGA_SOVI_VENTA') = 'N') THEN
      -- Se obtienen las ordenes asociadas a la solicitud de visita
      OPEN cuOrdersToLegalize(nuSubscriptionId,
                              sbParamActivities,
                              nuSalePackOperatingUnit);
      FETCH cuOrdersToLegalize BULK COLLECT
        INTO tbOrders;
      CLOSE cuOrdersToLegalize;
    else
      -- Se obtienen las ordenes asociadas a la solicitud de visita
      OPEN cuOrdersToLegalize(nuSubscriptionId, sbParamActivities, null);
      FETCH cuOrdersToLegalize BULK COLLECT
        INTO tbOrders;
      CLOSE cuOrdersToLegalize;
    END IF;

    --Se obtiene el primer indice para la lista de ordenes
    nuIndexOrders := tbOrders.FIRST;

    --Itera la tabla de ordenes, se detiene cuando ya no encuentre registros
    WHILE (nuIndexOrders IS NOT NULL) LOOP

      ut_trace.Trace('Orden de visita ' || tbOrders(nuIndexOrders)
                     .order_id,
                     10);
      -- Valida que la orden ya no se encuentre asignada
      IF (daor_order.fnugetorder_status_id(tbOrders(nuIndexOrders).order_id) <>
         nuOrderAssigned) THEN
        --Asigna la orden
        or_boprocessorder.ProcessOrder(tbOrders(nuIndexOrders).order_id,
                                       null,
                                       nuSalePackOperatingUnit,
                                       null,
                                       FALSE,
                                       NULL,
                                       NULL);
        ut_trace.Trace('Orden de visita ' || tbOrders(nuIndexOrders)
                       .order_id || ' asignada con exito',
                       10);
      END IF;
      -- legaliza la orden
      or_boexternallegalizeactivity.LegalizeOrder(tbOrders(nuIndexOrders)
                                                  .order_id,
                                                  nusuccessCausalId,
                                                  ld_boutilflow.fnuGetPersonToLegal(daor_order.fnugetoperating_unit_id(tbOrders(nuIndexOrders)
                                                                                                                       .order_id)),
                                                  sysdate,
                                                  sysdate,
                                                  'LEGALIZACION AUTOMATICA DE VISITA FNB',
                                                  ge_boparameter.fnuValorNumerico('COMM_TYPE_LEGA_ORAPI'));

      nuIndexOrders := tbOrders.next(nuIndexOrders);
    END LOOP;

    ut_trace.trace('FIN LD_BOFlowFNBPack.AttendVisitPackage', 10);

  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      Errors.setError;
      RAISE ex.CONTROLLED_ERROR;
  END AttendVisitPackage;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         :    AttendPackAndUpdCons
  Descripcion    :    Atiende la venta y actualiza el estado del consecutivo.

  Autor          :    Mmira
  Fecha          :    07/09/2013

  Parametros              Descripcion
  ============         ===================
  inuPackageId        Solicitud de venta

  Historia de Modificaciones
  Fecha             Autor                Modificacion
  =========       =========              ====================
  08-05-2015    KCienfuegos.SAO312817    Se modifica para actualizar el estado de pagare digital a
                                         V-Vendido, cuando la orden de venta no se encuentra anulada.
  ******************************************************************/
  PROCEDURE AttendPackAndUpdCons(inuPackageId in mo_packages.package_id%type) IS
    nuTypeComp    fa_histcodi.hicdtico%type;
    nuManualCons  ld_non_ba_fi_requ.manual_prom_note_cons%type;
    nuDigitalCons ld_non_ba_fi_requ.digital_prom_note_cons%type;
    nuStatusPack  mo_packages.motive_status_id%type;
    nuProdType    mo_motive.product_type_id%type;
    sbNewStatus   varchar2(1) := 'V';
    nuCountSale   number := 0;
    nuVENPAGA     number := 0;

    /*Cursor para obtener el pagare digital/manual*/
    CURSOR cuGetPackInfo(inuRequestId ld_non_ba_fi_requ.non_ba_fi_requ_id%type) IS
      SELECT /*+ leading(a) use_nl(a b)
                                                                                                                              index(a PK_LD_NON_BA_FI_REQU)
                                                                                                                              index(b PK_MO_PACKAGES)
                                                                                                                              index(c IDX_MO_MOTIVE_02) */
       a.manual_prom_note_cons,
       a.digital_prom_note_cons,
       b.motive_status_id,
       c.product_type_id
        FROM ld_non_ba_fi_requ a, mo_packages b, mo_motive c
       WHERE a.non_ba_fi_requ_id = inuRequestId
         AND b.package_id = a.non_ba_fi_requ_id
         AND c.package_id = b.package_id
         AND c.product_id IS not null;

    /*Cursor para validar si la orden de venta fue anulada*/
    CURSOR cuValidSales(inuPackage mo_packages.package_id%type) IS
      SELECT count(1)
        FROM or_order_activity oa, or_order o
       WHERE oa.package_id = inuPackage
         AND o.order_id = oa.order_id
         AND oa.task_type_id =
             dald_parameter.fnuGetNumeric_Value('COD_FNB_SALE_TASK_TYPE')
         AND o.order_status_id <> or_boconstants.CNUORDER_STAT_CANCELED;

    /*Cursor para validar si la SOL ES DE PAGARE UNICO 200-1564*/
    CURSOR CUVALIPAUN(inuPackage mo_packages.package_id%type) IS
      SELECT count(1)
        from OPEN.ldc_pagunidet
       where package_id_sale = inuPackage;
  BEGIN

    ut_trace.Trace('INICIO LD_boflowFNBPack.AttendPackAndUpdCons', 10);
    ---busco el pagare unico
    -- Valida el estado del cursor
    if (CUVALIPAUN%isopen) then
      close CUVALIPAUN;
    end if;

    open CUVALIPAUN(inuPackageId);
    fetch CUVALIPAUN
      INTO nuVENPAGA;
    close CUVALIPAUN;

    -- Se Atiende la venta
    CF_BOActions.AttendRequest(inuPackageId);

    -- Se atiende la solicitud de visita
    AttendVisitPackage(inuPackageId);

    -- Valida el estado del cursor
    if (cuGetPackInfo%isopen) then
      close cuGetPackInfo;
    end if;

    open cuGetPackInfo(inuPackageId);
    fetch cuGetPackInfo
      INTO nuManualCons, nuDigitalCons, nuStatusPack, nuProdType;
    close cuGetPackInfo;

    IF nuVENPAGA = 0 THEN

      /* Valida si existe un consecutivo manual asignado para actualizar su estado
      en el historico */
      if (nuManualCons IS not null) then

        /*Valida el tipo de producto para obtener el tipo de comprobante*/
        if (nuProdType =
           dald_parameter.fnuGetNumeric_Value('COD_PRODUCT_TYPE_BRILLA')) then
          /*Obtener el parametro del tipo de comprobante */
          nuTypeComp := Dald_Parameter.fnuGetNumeric_Value('COD_TYPE_OF_PROOF');

        elsif (nuProdType =
              dald_parameter.fnuGetNumeric_Value('COD_PRODUCT_TYPE_BRILLA_PROM')) then
          /*Obtener el parametro del tipo de comprobante de promigas*/
          nuTypeComp := Dald_Parameter.fnuGetNumeric_Value('TYPE_OF_PROOF_PROMIGAS');
        END if;

        if (nuStatusPack = MO_BOConstants.cnuSTATUS_ANNUL_PACK) then
          sbNewStatus := 'A';
        END if;

        ut_trace.trace('Tipo Producto: ' || nuProdType || ' - Numero: ' ||
                       nuManualCons || ' - Nuevo Estado: ' || sbNewStatus,
                       5);

        /* Actualiza el estado del consecutivo */
        pkConsecutiveMgr.ChangeStSaleAuthNumber(nuManualCons,
                                                nuTypeComp,
                                                sbNewStatus);
        /*KCienfuegos.SAO312817  */
      ELSIF nuDigitalCons IS NOT NULL THEN

        OPEN cuValidSales(inuPackageId);
        FETCH cuValidSales
          INTO nuCountSale;
        CLOSE cuValidSales;

        IF (nuCountSale > 0) THEN
          /*Obtener el parametro del tipo de pagare de digital*/
          nuTypeComp := Dald_Parameter.fnuGetNumeric_Value('VOUCHER_TYPE_DIGITAL_PROM_NOTE',
                                                           0);

          /* Actualiza el estado del consecutivo */
          pkConsecutiveMgr.ChangeStSaleAuthNumber(nuDigitalCons,
                                                  nuTypeComp,
                                                  sbNewStatus);

        END IF;
        /********* FIN SAO312817 **********/
      END if;

    END IF;

    ut_trace.Trace('FIN LD_boflowFNBPack.AttendPackAndUpdCons', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      if (cuGetPackInfo%isopen) then
        close cuGetPackInfo;
      end if;
      if (cuValidSales%isopen) then
        close cuValidSales;
      end if;
      raise ex.CONTROLLED_ERROR;
    when others then
      if (cuGetPackInfo%isopen) then
        close cuGetPackInfo;
      end if;
      if (cuValidSales%isopen) then
        close cuValidSales;
      end if;
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END AttendPackAndUpdCons;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         :    fnuValOperUnitIsSupplierFNB
  Descripcion    :    Obtiene la clasificacion de la unidad operativa de la
                      orden de venta.
                      Retorna 1 si la clasificacion es 70 - Proveedor FNB.
                      Retorna 0 de lo contrario.

  Autor          :    Jorge Alejandro Carmona Duque
  Fecha          :    07/09/2013

  Parametros              Descripcion
  ============         ===================
  inuPackageId         Solicitud de venta

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  07/09/2013      JCarmona.SAO216373  Creacion.
  ******************************************************************/
  FUNCTION fnuValOperUnitIsSupplierFNB(inupacksale mo_packages.package_id%TYPE)
    RETURN PLS_INTEGER IS

    nuOrderSaleId     or_order.order_id%TYPE;
    nuOperatingUnitId or_order.operating_unit_id%TYPE;
    nuUnitClassifId   or_operating_unit.Oper_Unit_Classif_Id%TYPE;

  BEGIN

    ut_trace.trace('INICIA Ld_BoflowFNBPack.fnuValOperUnitIsSupplierFNB[' ||
                   inupacksale || ']',
                   1);

    /*Obtiene la orden de venta*/
    nuOrderSaleId := Ld_bccancellations.fnugetsaleorder(inupacksale, 0);
    ut_trace.trace('Orden de Venta: ' || nuOrderSaleId, 2);

    /*Obtiene la unidad operativa de la orden*/
    nuOperatingUnitId := Daor_Order.fnuGetOperating_Unit_Id(nuOrderSaleId,
                                                            0);
    ut_trace.trace('Unidad Operativa de la orden: ' || nuOperatingUnitId,
                   2);

    /*Obtiene clasificacion de la unidad operativa de la orden de venta*/
    nuUnitClassifId := daor_operating_unit.fnuGetOper_Unit_Classif_Id(nuOperatingUnitId,
                                                                      0);
    ut_trace.trace('Clasificacion unidad operativa de la orden:' ||
                   nuUnitClassifId || '-Clasificacion Proveedor FNB:' ||
                   cnuSupplierFNB,
                   2);

    ut_trace.trace('FIN Ld_BoflowFNBPack.fnuValOperUnitIsSupplierFNB', 1);

    RETURN sys.diutil.bool_to_int(nuUnitClassifId = cnuSupplierFNB);

  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      Errors.setError;
      RAISE ex.CONTROLLED_ERROR;
  END fnuValOperUnitIsSupplierFNB;

  /**********************************************************************
    Propiedad intelectual de OPEN International Systems
    Nombre              CounterPayment

    Autor        Andres Felipe Esguerra Restrepo

    Fecha               31-oct-2013

    Descripcion         Genera cargos para contrarestar el pago de la cuota
                        inicial de Brilla

    ***Parametros***
    Nombre        Descripcion
    inuPackageId        ID de la solicitud de venta brilla

    ***Historia de Modificaciones***
    Fecha Modificacion        Autor
    .                .
  ***********************************************************************/
  PROCEDURE CounterPayment(inuPackageId in mo_packages.package_id%type) IS

    nuMotive mo_motive.motive_id%type;

    nuProduct pr_product.product_id%type;

    nuAccount cuencobr.cucocodi%type;

    nuInitQuota ld_non_ba_fi_requ.payment%type;

    nuSuscription suscripc.susccodi%type;

    nuConcept concepto.conccodi%type := dald_parameter.fnuGetNumeric_Value('CONC_INI_QUOTA');

  BEGIN

    ut_trace.trace('INICIO LD_BOFlowFNBPack.CounterPayment', 1);

    ut_trace.trace('Se obtiene el primer motivo de la venta', 10);
    nuMotive := mo_bopackages.fnugetfirstmotive(inuPackageId);

    nuSuscription := damo_packages.fnugetsubscription_pend_id(inuPackageId);

    ut_trace.trace('Se obtiene el producto asociado al motivo de la venta',
                   10);
    nuProduct := damo_motive.fnugetproduct_id(nuMotive);

    if cuAccount%isopen then
      close cuAccount;
    END if;

    open cuAccount(inuPackageId);
    fetch cuAccount
      INTO nuAccount;
    close cuAccount;

    if nuAccount IS null then
      ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                       'No hay cuenta de cobro a la cual asociarle el cargo');
    END if;

    ut_trace.trace('Se obtuvo la cuenta de cobro: ' || nuAccount, 10);

    nuInitQuota := dald_non_ba_fi_requ.fnuGetPayment(inuPackageId);

    ut_trace.trace('Se obtuvo cuota inicial de ' || nuInitQuota, 10);

    pkerrors.setapplication('CUSTOMER');

    ut_trace.trace('Se creara el cargo que cancela el pago realizado', 10);
    -- Crea un cargo por cada producto
    pkChargeMgr.GenerateCharge(nuProduct,
                               nuAccount,
                               nuConcept,
                               cnuCause,
                               nuInitQuota,
                               'DB',
                               'PP-' || inuPackageId,
                               'A',
                               null,
                               null,
                               null,
                               null,
                               true,
                               sysdate);

    ut_trace.trace('Se actualizara la cuenta de cobro', 10);
    pkUpdAccoReceiv.UpdAccoRec(pkBillConst.cnuSUMA_CARGO,
                               nuAccount,
                               nuSuscription,
                               nuProduct,
                               nuConcept,
                               'DB',
                               abs(nuInitQuota),
                               pkBillConst.cnuUPDATE_DB);

    ut_trace.trace('Se aplica el saldo a favor del producto', 10);
    pkaccountmgr.applypositivebalserv(nuProduct, nuAccount);

    ut_trace.trace('FIN LD_BOFlowFNBPack.CounterPayment', 1);

  END CounterPayment;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : fnuValidaGranSuper
  Descripcion    : retorna 1 si el contratista conectado es el EXITO y opera como EXITO
                 retorna 0 en caso contrario.

  Autor          : Jorge Alejandro Carmona Duque
  Fecha          : 13/11/2013

  Parametros              Descripcion
  ============         ===================
  inupackagesale       Identificador de la solicitud

  Historia de Modificaciones
  Fecha             Autor              Modificacion
  =========       =========            ====================
  01-10-2014      KCienfuegos.RNP1810  Se modifica para que retorne 1 si a parte de ser Exito,
                                       opera como Exito (JOB). Se evita modificar el flujo.
  ******************************************************************/
  FUNCTION fnuValidaGranSuper(inupackagesale IN mo_packages.package_id%TYPE)
    RETURN PLS_INTEGER IS

    nuOrder_sale     or_order.order_id%TYPE;
    nuOperating_Unit or_order.operating_unit_id%TYPE;
    nuContractor_Id  or_operating_unit.contractor_id%TYPE;
    sbYesFlag        varchar2(1) := ld_boconstans.csbYesFlag;

  BEGIN
    ut_trace.trace('BEGIN LD_boflowFNBPack.fnuValidaGranSuper', 1);
    /*Obtiene la orden de venta*/
    nuOrder_sale := Ld_BcCancellations.Fnugetsaleorder(inupackagesale, 0);

    /*Obtiene la unidad operativa de la orden*/
    nuOperating_Unit := Daor_Order.fnuGetOperating_Unit_Id(nuOrder_sale, 0);

    /*Obtiene el identificador del contratista*/
    nuContractor_Id := daor_operating_unit.fnuGetContractor_Id(nuOperating_Unit,
                                                               0);

    /*Se valida si el contratista es el EXITO*/
    IF nuContractor_Id =
       dald_parameter.fnuGetNumeric_Value('CODI_CUAD_EXITO') and dald_parameter.fsbGetValue_Chain('USA_ITEM_GENERIC_EXITO') =
       sbYesFlag THEN

      ut_trace.trace('END LD_boflowFNBPack.fnuValidaGranSuper', 1);
      return 1;
    ELSE
      ut_trace.trace('END LD_boflowFNBPack.fnuValidaGranSuper', 1);
      return 0;
    END IF;

  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      Errors.setError;
      RAISE ex.CONTROLLED_ERROR;
  END fnuValidaGranSuper;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : createprodByExito
  Descripcion    : crea el producto desde el Job del exito

  Parametros              Descripcion
  ============            ===================
  inuPackage      :        Numero de solicitud


  Historia de Modificaciones
  Fecha           Autor               Modificacion
  =========       =========           ====================
  15-01-2014      AEcheverrySAO229596 <<Creacion>>
  ******************************************************************/
  PROCEDURE createprodByExito(inuPackage IN mo_packages.package_id%type) IS

    nuProductId     pr_product.product_id%type;
    nuProducOcupp   number;
    nuPromissory_Id ld_promissory.promissory_id%type;

    blProductOcupp boolean := FALSE;
    nuErrorCode    number;
    sbErrorMessage varchar2(2000);
  BEGIN

    ut_trace.trace('inicio Ld_BoflowFNBPack.createprodByExito', 10);

    blDebugMode := TRUE;
    Ld_BcflowFNBPack.CreateproducOcupp(inuPackage,
                                       nuProducOcupp,
                                       nuPromissory_Id);

    -- si la venta se realizo al inquilino
    if (nuProducOcupp = 1) then
      blProductOcupp := TRUE;
    END if;

    createproducReal(inuPackage,
                     blProductOcupp,
                     nuProductId,
                     null,
                     nuErrorCode,
                     sbErrorMessage);

    gw_boerrors.checkerror(nuErrorCode, sbErrorMessage);

    ut_trace.trace('Fin Ld_BoflowFNBPack.createprodByExito=' ||
                   nuProductId,
                   10);

  Exception
    When ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    When others then
      Errors.setError;
      RAISE ex.CONTROLLED_ERROR;
  END createprodByExito;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : fnuValLegDelOrder
  Descripcion    : retorna 1 si por lo menos una de las ordenes de entrega de
                   la solicitud se encuentra registrada o asignada.
                   retorna 0 en caso contrario, es decir que todas las ordenes
                   se encuentran legalizadas (FLOTE).

  Autor          : Jorge Alejandro Carmona Duque
  Fecha          : 11/04/2014

  Parametros              Descripcion
  ============         ===================
  inupackagesale       Identificador de la solicitud

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  11/04/2014      JCarmona.3361       Creacion.
  ******************************************************************/
  FUNCTION fnuValLegDelOrder(inuPackageId in mo_packages.package_id%type)
    return number IS
    nuResult number;

    CURSOR cuPackageDeliOrders IS
      SELECT 1
        FROM or_order_activity oa, or_order o
       WHERE oa.order_id = o.order_id
         AND oa.package_id = inuPackageId
         AND oa.activity_id = cnuDelivActiv
         AND o.order_status_id in (OR_BOConstants.cnuORDER_STAT_REGISTERED,
              OR_BOConstants.cnuORDER_STAT_ASSIGNED)
         AND rownum = 1;
  BEGIN

    UT_Trace.Trace('Inicio LD_BOFlowFNBPack.fnuValLegDelOrder[' ||
                   inuPackageId || ']',
                   1);

    --  Consulta las ordenes de entrega de la solicitud que se encuentren registradas o asignadas
    open cuPackageDeliOrders;
    fetch cuPackageDeliOrders
      INTO nuResult;
    close cuPackageDeliOrders;

    --  Si no encuentra retorna 0, de lo contrario retorna 1
    if (nuResult IS null) then
      UT_Trace.Trace('Final LD_BOFlowFNBPack.fnuValLegDelOrder[' ||
                     ld_boconstans.cnuCero || ']',
                     1);
      return ld_boconstans.cnuCero;
    else
      UT_Trace.Trace('Final LD_BOFlowFNBPack.fnuValLegDelOrder[' ||
                     ld_boconstans.cnuonenumber || ']',
                     1);
      return ld_boconstans.cnuonenumber;
    END if;

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END fnuValLegDelOrder;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : ApplyCouponPP
   Descripcion    : Metodo que Aplica el saldo a favor generado
                    por el pago del cupon PP.

   Autor          : Diego Armando Arevalo Gomez
   Fecha          : 21/05/2013

   Parametros       Descripcion
   ============     ===================

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   26/05/2014       darevalo.3638       Creacion.
  ******************************************************************/

  PROCEDURE ApplyCouponPP(inuPackage_id in mo_packages.package_id%type) IS
    /*Variables*/
    nuProduct pr_product.product_id%type;
    nuMotive  mo_motive.motive_id%type;
    nuConcept concepto.conccodi%type := dald_parameter.fnuGetNumeric_Value('CONC_INI_QUOTA');
    cnuCause Constant ld_parameter.numeric_value%type := DALD_Parameter.fnuGetNumeric_Value('COD_CAUSA_CARG_VENTA_FNB');
    nuOrderSaleId     or_order.order_id%TYPE;
    nuOperatingUnitId or_order.operating_unit_id%TYPE;
    nuInitQuota       ld_non_ba_fi_requ.payment%type;
    nuCuponPago       number;

    CURSOR cuGetCuponPP(inupackage in mo_packages.package_id%type) IS
      SELECT DECODE((SELECT CUPOFLPA
                      FROM CUPON
                     WHERE CUPOTIPO = 'PP'
                       AND CUPODOCU = TO_CHAR(inupackage)),
                    'S',
                    1,
                    0)
        FROM DUAL;

  BEGIN
    ut_trace.trace('Inicia ld_boflowfnbpack.ApplyCouponPP', 5);

    pkerrors.setapplication('CUSTOMER');

    --  Obtiene el motivo asociado a la solicitud
    nuMotive := mo_bopackages.fnugetinitialmotive(inuPackage_id);

    --  Obtiene el producto asociado al motivo
    nuProduct := damo_motive.fnuGetProduct_Id(nuMotive);

    /*Obtiene la orden de venta*/
    nuOrderSaleId := Ld_bccancellations.fnugetsaleorder(inuPackage_id, 0);
    ut_trace.trace('Orden de Venta: ' || nuOrderSaleId, 2);

    /*Obtiene la unidad operativa de la orden*/
    nuOperatingUnitId := Daor_Order.fnuGetOperating_Unit_Id(nuOrderSaleId,
                                                            0);
    ut_trace.trace('Unidad Operativa de la orden: ' || nuOperatingUnitId,
                   2);

    /* Obtiene la cuota Inicial de Brilla*/
    nuInitQuota := dald_non_ba_fi_requ.fnuGetPayment(inuPackage_id);
    ut_trace.trace('Se obtuvo cuota inicial de ' || nuInitQuota, 10);

    /* Se valida que sea contratista y que la cuota Inicial sea mayor que cero*/
    if ld_bopackagefnb.fsbGetTypeUserbyOperUnit(nuOperatingUnitId) = 'CV' and
       nuInitQuota > 0 then

      open cuGetCuponPP(inuPackage_id);
      fetch cuGetCuponPP
        INTO nuCuponPago;
      close cuGetCuponPP;

      if nuCuponPago = 1 then
        /*Se crea el cargo debito por el concepto de la cuota inicial se asigna a la cuenta -1*/
        pkChargeMgr.GenerateCharge(nuProduct,
                                   -1,
                                   nuConcept,
                                   cnuCause,
                                   nuInitQuota,
                                   'DB',
                                   'PP-' || inuPackage_id,
                                   'A',
                                   null,
                                   null,
                                   null,
                                   null,
                                   true,
                                   sysdate);

        /*Se factura la solicitud*/
        cc_boaccounts.GenerateAccountByPack(inuPackage_id);

      end if;

    end if;

    ut_trace.trace('Fin ld_boflowfnbpack.ApplyCouponPP', 5);
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;

  END ApplyCouponPP;

  /*****************************************************************
  PROPIEDAD INTELECTUAL DE PETI (C).

  UNIDAD         : commentDelOrder
  DESCRIPCION    : Procedimiento para registrar la observacion de la orden de entrega
  AUTOR          : Katherine Cienfuegos
  RNP            : 156
  FECHA          : 19/08/2014

  PARAMETROS              DESCRIPCION
  ============         ===================
  inuSubscription     codigo del suscriptor

  FECHA             AUTOR             MODIFICACION
  =========       =========           ====================
  19/08/2014    KCienfuegos.RNP156    Creacion.
  ******************************************************************/

  PROCEDURE CommentDelOrder(inuOrder   in or_order.order_id%type,
                            isbComment in or_order_comment.order_comment%type) IS

    rcOrderComment daor_order_comment.styOR_order_comment;

  BEGIN
    ut_trace.trace('INICIO ld_boflowfnbpack.commentDelOrder[' || inuOrder || ']',
                   1);

    IF isbComment IS NOT NULL THEN
      /* Se obtiene proximo consecutivo del comentario */
      rcOrderComment.order_comment_id := or_bosequences.fnuNextOr_Order_Comment;

      /* Se asigna el valor del comentario */
      rcOrderComment.order_comment := isbComment;

      /* Se asigna el valor de la orden */
      rcOrderComment.order_id := inuOrder;

      /* Se setea el tipo de comentario*/
      rcOrderComment.comment_type_id := DALD_Parameter.fnuGetNumeric_Value('TIPO_COMENT_ORD_ENTR');

      /* Se registra la fecha del sistema*/
      rcOrderComment.register_date := ut_date.fdtSysdate;

      /* Indica que el comentario es de legalizacion*/
      rcOrderComment.legalize_comment := GE_BOConstants.csbNO;

      /* Se setea la persona conectada*/
      rcOrderComment.person_id := ge_boPersonal.fnuGetPersonId;

      /* Se inserta el comentario de la orden */
      daor_order_comment.insRecord(rcOrderComment);

    END IF;

    ut_trace.trace('FIN ld_boflowfnbpack.commentDelOrder', 1);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END commentDelOrder;

  /*****************************************************************
  Propiedad intelectual de PETI (c).


  Unidad         : CreateInstallationOrder
  Descripcion    : Crea ordenes de instalacion de gasodomesticos FNB.
  Autor          : KCienfuegos
  Fecha          : 10/10/2014

  Parametros              Descripcion
  ============         ===================
  inupackage_id         identificador del paquete.
  inuOrdActivityId      id de actividad
  inuOperatUnitId       id de la unidad operativa

  Historia de Modificaciones
  Fecha             Autor                Modificacion
  =========       =========             ====================
  10-10-2014    KCienfuegos.RNP1179    Creacion.
  ******************************************************************/
  PROCEDURE CreateInstallationOrder(inupackage_id    IN mo_packages.package_id%TYPE,
                                    inuOrdActivityId IN or_order_activity.order_activity_id%TYPE,
                                    inuOperatUnitId  IN or_operating_unit.operating_unit_id%TYPE)

   IS

    rgmo_packages      damo_packages.styMO_packages;
    rcSaleRequest      dald_non_ba_fi_requ.styLD_non_ba_fi_requ;
    tbItems            ld_bcnonbankfinancing.tytbItemWordPack;
    nuIndex            number;
    nuOrderDev         or_order.order_id%type;
    nuActivityDev      or_order_activity.order_activity_id%type;
    tbSuppliSett       dald_suppli_settings.tytbLD_suppli_settings;
    nuerror            ge_message.message_id%type;
    sbmessage          ge_message.description%type;
    nuSupplier         number := 0;
    nuIdxLegalize      number;
    nuContractorId     number;
    tbPOS_Settings     Dald_Pos_Settings.tytbLD_pos_settings;
    nuOperatingUnit    or_operating_unit.operating_unit_id%type;
    rcOperUnitSupplier or_operating_unit%rowtype;
  BEGIN

    rgmo_packages := damo_packages.frcGetRecord(inuPackage_Id => inupackage_id);

    rcSaleRequest := dald_non_ba_fi_requ.frcGetRecord(inupackage_id);

    ld_bononbankfinancing.createInstallOrderActivity(inuOrdActivityId,
                                                     nuOrderDev,
                                                     'Se genera la orden de instalacion de gasodomesticos',
                                                     nuActivityDev);

    if inuOperatUnitId is not null then
      /*Asigna la orden de venta a la unidad */
      or_boprocessorder.ProcessOrder(nuOrderDev,
                                     null,
                                     inuOperatUnitId,
                                     null,
                                     FALSE,
                                     NULL,
                                     NULL);
    end if;

  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      Errors.setError;
      RAISE ex.CONTROLLED_ERROR;
  END CreateInstallationOrder;

  /*****************************************************************
  PROPIEDAD INTELECTUAL DE PETI (C).

  UNIDAD         : registerInvoice
  DESCRIPCION    : Procedimiento para registrar la informaci?n de la factura.
  AUTOR          : Katherine Cienfuegos
  RNP            : 1224
  FECHA          : 13/01/2015

  PARAMETROS            DESCRIPCION
  ============      ===================
  inuOrder           C?digo de la orden

  FECHA             AUTOR             MODIFICACION
  =========       =========           ====================
  13/01/2015    KCienfuegos.RNP1224    Creaci?n.
  ******************************************************************/
  PROCEDURE registerInvoice(inuOrder   in or_order.order_id%type,
                            isbInvoice in ldc_invoice_fnb_sales.invoice%type) IS

    rcInvoice     daldc_invoice_fnb_sales.styLDC_INVOICE_FNB_SALES;
    nuConsecutive ldc_invoice_fnb_sales.consecutive%type;
    nuPackageId   mo_packages.package_id%type;

    cursor cuGetPackOrder is
      select package_id
        from or_order_activity oa
       where oa.order_id = inuOrder
         and rownum = 1;

  BEGIN
    ut_trace.trace('INICIO ld_boflowfnbpack.registerInvoice[' || inuOrder || ']',
                   1);

    IF isbInvoice IS NOT NULL AND inuOrder IS NOT NULL THEN
      nuConsecutive := PKGENERALSERVICES.FNUGETNEXTSEQUENCEVAL('SEQ_LDC_INVOICE_FNB');

      /* Se obtiene el c?digo de la solicitud */
      open cuGetPackOrder;
      fetch cuGetPackOrder
        into nuPackageId;
      close cuGetPackOrder;

      rcInvoice.consecutive := nuConsecutive;

      /* Se asigna el valor del comentario */
      rcInvoice.invoice := isbInvoice;

      /* Se asigna el valor de la orden */
      rcInvoice.order_id := inuOrder;

      /* Se setea el tipo de comentario*/
      rcInvoice.package_id := nuPackageId;

      /* Se registra la fecha del sistema*/
      rcInvoice.register_date := ut_date.fdtSysdate;

      /* Se inserta el comentario de la orden */
      daldc_invoice_fnb_sales.insRecord(rcInvoice);

    END IF;

    ut_trace.trace('FIN ld_boflowfnbpack.registerInvoice', 1);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END registerInvoice;

  /*****************************************************************
  PROPIEDAD INTELECTUAL DE PETI (C).

  UNIDAD         : registerDelivDate
  DESCRIPCION    : Procedimiento para registrar la fecha de entrega del objeto de venta (si aplica).
                   Es utilizado desde el .NET Fifap.
  AUTOR          : KCienfuegos
  ARANDA         : 5737
  FECHA          : 20/01/2015

  PARAMETROS            DESCRIPCION
  ============      ===================
  inuOrder           C?digo de la orden

  FECHA             AUTOR             MODIFICACION
  =========       =========           ====================
  20/01/2015    KCienfuegos.ARA5737    Creaci?n.
  ******************************************************************/
  PROCEDURE registerDelivDate(inuPackageId in or_order_activity.package_id%type,
                              idtDelivDate in mo_packages.request_date%type) IS

    rcDeliveries  daldc_fnb_deliver_date.styLDC_FNB_DELIVER_DATE;
    nuConsecutive ldc_fnb_deliver_date.consecutive%type;

  BEGIN
    ut_trace.trace('INICIO ld_boflowfnbpack.registerDelivDate[' ||
                   inuPackageId || ']',
                   1);

    IF inuPackageId IS NOT NULL AND idtDelivDate IS NOT NULL THEN

      /* Se obtiene el pr?ximo valor de la secuencia*/
      nuConsecutive := PKGENERALSERVICES.FNUGETNEXTSEQUENCEVAL('SEQ_LDC_FNB_DELIVER_DATE');

      /* Se setea el consecutivo */
      rcDeliveries.consecutive := nuConsecutive;

      /* Se asigna el c?digo del paquete */
      rcDeliveries.package_id := inuPackageId;

      /* Se setea la fecha de entrega*/
      rcDeliveries.deliver_date := idtDelivDate;

      /* Se inserta el registro */
      daldc_fnb_deliver_date.insRecord(rcDeliveries);

    END IF;

    ut_trace.trace('FIN ld_boflowfnbpack.registerDelivDate', 1);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END registerDelivDate;

  /*******************************************************************
  Propiedad Intelectual de SINCECOMP (C).

  Procedimiento : ActEstacortyComp
  Descripcion : Actualiza el estado de corte y el componente de acuerdad a una solicitud de venta

  Autor       : Sebastian Tapias || 200-1306
  Fecha       : 02-06-2017

  ---***Variables de Entrada***---
  inuPackage
  --------------------------------
                         Historia de Modificaciones

          Fecha               Autor                Modificacion
        =========           =========          ====================
  ********************************************************************/
  PROCEDURE ActEstacortyComp(inuPackage in mo_packages.package_id%type) IS
    /* Varibales */
    nuProductinact pr_product.product_id%type;
    nuProducto     pr_product.product_id%type;
    rcmo_packages  damo_packages.stymo_packages;
    nuSuscripc     suscripc.susccodi%type;
    nuProduct      pr_product.product_id%type;
    nuProdType     pr_product.product_type_id%type;
    nuSolicitud    mo_motive.package_id%type;
    ---------------------------------------------------

    -- Cursor para obtener el producto y el tipo de producto.
    CURSOR cu_obteprodvent IS
      SELECT m.product_id, m.product_type_id
        FROM mo_motive m, pr_product p
       WHERE m.package_id = nuSolicitud
         AND p.product_id = m.product_id
         AND m.product_type_id = p.product_type_id;

    rfc_producto cu_obteprodvent%rowtype;
    --

    -- Cursor para obtener los productos con estados de cortes no facturables
    cursor cu_ProductESTCORT(nuSuscription suscripc.susccodi%type, nuProduct pr_product.product_id%type, nutipoprod pr_product.PRODUCT_TYPE_ID%type) is
      select p.SESUNUSE
        from servsusc p, suscripc s
       where p.sesususc = s.susccodi
         and p.sesususc = nuSuscription
         and p.SESUESCO IN
             (select nvl(to_number(column_value), 0)
                from table(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('FNB_VALID_PROD_STATUS_FACT',
                                                                                         NULL),
                                                        ',')))
         and P.SESUNUSE = nuProduct
         AND P.SESUSERV = nutipoprod;
    --

    -- Cursor para obtener los productos con componentes diferentes a 5
    cursor cu_prcomponent(producto pr_product.product_id%type) is
      SELECT p.product_id
        FROM pr_component p
       where p.product_id = producto
         and p.component_status_id <> 5
       group by p.product_id;
    --
  BEGIN
    ut_trace.trace('Inicia ActEstacortyComp', 1);
    /* identifica datos de la solicitud */
    rcmo_packages := damo_packages.frcGetRecord(inuPackage);

    /* Asigno la Suscripcion */
    nuSuscripc := rcmo_packages.subscription_pend_id;

    /* Identifica producto y tipo de producto en base a la solicitud */
    nuSolicitud := inuPackage;
    FOR rfc_producto IN cu_obteprodvent LOOP
      nuProduct  := rfc_producto.product_id;
      nuProdType := rfc_producto.product_type_id;
    END LOOP;

    open cu_ProductESTCORT(nuSuscripc, nuProduct, nuProdType);
    fetch cu_ProductESTCORT
      into nuProductinact;
    close cu_ProductESTCORT;

    open cu_prcomponent(nuProductinact);
    fetch cu_prcomponent
      into nuProducto;
    close cu_prcomponent;

    /*Si el producto brilla tiene estado de corte no facturable*/
    if nuProductinact is not null then

      /*Se produce el cambio de estado de corte*/
      begin

        pktblservsusc.updsesuesco(nuProductinact, 1);

      EXCEPTION
        when ex.CONTROLLED_ERROR then
          raise ex.CONTROLLED_ERROR;
        when others then
          Errors.setError;
          raise ex.CONTROLLED_ERROR;
      END;
      ut_trace.trace('Cambia el estado de corte', 1);
    end if;

    /*Si el componente es difirente de 5*/
    if nuProducto is not null then

      /*Se actualiza el componente*/
      begin

        UPDATE OPEN.PR_COMPONENT
           SET COMPONENT_STATUS_ID = 5
         WHERE PRODUCT_ID = nuProducto;

      EXCEPTION
        when ex.CONTROLLED_ERROR then
          raise ex.CONTROLLED_ERROR;
        when others then
          Errors.setError;
          raise ex.CONTROLLED_ERROR;
      END;
      ut_trace.trace('Cambia el componente', 1);
    end if;
    ut_trace.trace('Fin ActEstacortyComp', 1);
  Exception
    When ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    When others then
      Errors.setError;
      RAISE ex.CONTROLLED_ERROR;
  END ActEstacortyComp;

END LD_boflowFNBPack;
/
