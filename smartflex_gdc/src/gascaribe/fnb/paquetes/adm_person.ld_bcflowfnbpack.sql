CREATE OR REPLACE PACKAGE ADM_PERSON.LD_BCFLOWFNBPACK IS

    /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : LD_bcflowFNBPack
  Descripcion    : Paquete con los servicios del flujo de venta.
  Autor          : Eduar Ramos Barragan
  Fecha          : 09/01/13 09:55:27 a.m.

  Historia de Modificaciones
  Fecha             Autor               Modificación
  =========         =========           ====================
  07-09-2013        mmiraSAO214326      Se adiciona el cursor <cuGetPackInfo>
  ******************************************************************/

  /*****************************************************************
   Declaracion de variables
  ******************************************************************/

  CURSOR    cuGetPackInfo (inuRequestId ld_non_ba_fi_requ.non_ba_fi_requ_id%type )
  IS
      SELECT    /*+ leading(a) use_nl(a b)
                index(a PK_LD_NON_BA_FI_REQU)
                index(b PK_MO_PACKAGES)
                index(c IDX_MO_MOTIVE_02) */
                a.manual_prom_note_cons, b.motive_status_id, c.product_type_id
      FROM      ld_non_ba_fi_requ a, mo_packages b, mo_motive c
                /*+ LD_bcflowFNBPack.cuGetPackInfo */
      WHERE     a.non_ba_fi_requ_id = inuRequestId
      AND       b.package_id = a.non_ba_fi_requ_id
      AND       c.package_id = b.package_id
      AND       c.product_id IS not null;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : LD_bcflowFNBPack
  Descripcion    : Paquete con los servicios de consultas necesarias
                   para el proceso del flujo de venta.
  Autor          : Adolfo Acu?a Beltran
  Fecha          : 18/04/13 11:35:27 a.m.

  Historia de Modificaciones
    Fecha             Autor               Modificacion
  =========         =========         ====================
  05-09-2013        mmira.SAO214195     Se adiciona <GetCatSubBySuscripc>
  18/04/2013    AAcuna.SAO139854      Creacion
  ******************************************************************/

  -- Declaracion de Tipos de datos publicos

  -- Declaracion de constantes publicas

  -- Declaracion de variables publicas

  -- Declaracion de funciones y procedimientos publicos

  FUNCTION fsbVersion RETURN VARCHAR2;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : FnuGetBillExpired
  Descripcion    : Verifica que la factura se encuentra vencida dependiendo las dos siguientes condiciones:
                   1. Que la fecha de limite de pago sea menor al sysdate
                   2. Que la cuenta de cobro  asociada a la factura no tenga saldo pendiente
                   La funcion retornara los siguientes valores:
                   Retorna (0) si la factura no esta vencida
                   Retorna (1) Si se encuentra al dia

  Autor          : AAcuna
  Fecha          : 18/04/2013

  Parametros          Descripcion
  ============     ===================
  inuSuscripc      Numero del contrato



  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  18/04/2013    AAcuna.SAO139854      Creacion
  ******************************************************************/

  FUNCTION FnuGetBillExpired(inuSuscripc in suscripc.susccodi%type)

   RETURN number;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : CreateproducOcupp
  Descripcion    : Identifica si la solicitud de venta la hizo el titular de la factura o no
                   La funcion retornara los siguientes valores:
                   Retorna (0) Si la solicitud de venta no la hizo el titular
                   Retorna (1) Si la solicitud de venta la hizo el titular

  Autor          : AAcuna
  Fecha          : 14/05/2013

  Parametros          Descripción
  ============     ===================
  inuPackage       : Número de la solicitud de venta.
  onuProducOcupp   : Retorna (0) Si la solicitud de venta no la hizo el titular
                     Retorna (1) Si la solicitud de venta la hizo el titular
  onuPromissory_Id : Codigo del promissory

  Historia de Modificaciones
  Fecha             Autor             Modificación
  =========       =========           ====================
  14/05/2013    AAcuna.SAO139854      Creación
  ******************************************************************/

  PROCEDURE CreateproducOcupp(inuPackage       in mo_packages.package_id%type,
                              onuProducOcupp   out number,
                              onuPromissory_Id out ld_promissory.promissory_id%type);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : getServsusByGB
  Descripcion    : Obtiene los productos asociados al contrato y que sean de tipo de producto brilla-brilla_promigas
                   (7055,7056)

  Autor          : AAcuna
  Fecha          : 29/04/2013

  Parametros          Descripcion
  ============     ===================
  inuSuscripc      Numero del contrato

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  29/04/2013    AAcuna.SAO139854      Creacion
  ******************************************************************/

  FUNCTION getServsusByGB(inuSuscripc in suscripc.susccodi%type,
                          inuFinPro   in servsusc.sesuserv%type,
                          inuFinBri   servsusc.sesuserv%type)

   RETURN pktblservsusc.tySesunuse;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : getOrderDeliveryArt
  Descripcion    : Obtiene las ot de entrega y los articulos asociados a la solicitud de venta,
                   ademas las ordenes se deben encontrar legalizadas y ser legalizadas con causal de exito
                   y los articulos tener estado 'RE'

  Autor          : AAcuna
  Fecha          : 29/04/2013

  Parametros          Descripcion
  ============     ===================
  inuSuscripc      Numero del contrato

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  29/04/2013    AAcuna.SAO139854      Creacion
  ******************************************************************/

  FUNCTION getOrderDeliveryArt(inuPackage in mo_packages.package_id%type,
                               inuCausal  in or_order.causal_id%type)

   RETURN constants.tyrefcursor;

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

  FUNCTION ftbValidateFlowmove(inuAccion    in Mo_Wf_Pack_Interfac.Action_Id%type,
                               inupackageid in Mo_Wf_Pack_Interfac.Package_Id%type)

   RETURN damo_wf_pack_interfac.tytbWf_Pack_Interfac_Id;

  FUNCTION ftbgetsalepackagearticles(inuPackage in mo_packages.package_id%type)
    RETURN dald_item_work_order.tytbLD_item_work_order;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ftbgetCreateProductPackAsso
  Descripcion    : Busca el paquete asociado dado un paquete
                 y tipo de paquete
  Autor          : ERAMOS
  Fecha          : 11/04/2013

  Parametros         Descripcion
  ============   ===================
  inuPackage:    Numero de la solicitud de venta


  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION ftbgetPackAssoByType(inuPackage     in mo_packages.package_id%type,
                                inuPackageType in mo_packages.package_type_id%type)
    RETURN damo_packages_asso.tytbMO_packages_asso;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : GetContractBySubsc
  Descripcion    : Identifica si el cliente tiene por lo menos algun contrato asociado.
                   El procedimiento retornara los siguientes valores:
                   Retorna (0) Si el cliente no tiene contrato asociado
                   Retorna (1) Si el cliente tiene contrato asociado

  Autor          : AAcuna
  Fecha          : 14/05/2013

  Parametros          Descripción
  ============     ===================
  inuSusbcriber     : Número del cliente
  nuSuscripc        : Número del contrato
  nuContract        : Valor de retorno
                      Retorna (0) Si el cliente no tiene contrato asociado
                      Retorna (1) Si el cliente tiene contrato asociado

  Historia de Modificaciones
  Fecha             Autor             Modificación
  =========       =========           ====================
  14/05/2013    AAcuna.SAO139854      Creación
  ******************************************************************/

  PROCEDURE GetContractBySubsc(inuSusbcriber in ge_subscriber.subscriber_id %type,
                               onuSuscripc   out suscripc.susccodi%type,
                               onuContract   out number);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : FnuGetActivity
  Descripcion    : Obtiene la actividad asociada a la orden

  Autor          : AAcuna
  Fecha          : 18/04/2013

  Parametros          Descripcion
  ============     ===================
  inuOrder         Número de la orden

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  18/04/2013    AAcuna.SAO139854      Creacion
  ******************************************************************/

  FUNCTION FnuGetActivity(inuOrder in or_order.order_id%type)

   RETURN or_order_activity.order_activity_id%type;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : Propricevariation
  Descripcion    : Verifica si en la tabla de Variación de precio
                   Existe o no datos para enviar esta información al
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

  PROCEDURE Propricevariation(inupackage_id in mo_packages.package_id%type,
                              Osbresp       out varchar2);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : frfgetldpromisory
  Descripcion    : Busca los datos que se encuentran en la tabla Promisory
                   para que sean actualizados en ge_subscriber.
  Autor          : Kbaquero
  Fecha          : 22/05/2013

  Parametros         Descripcion
  ============   ===================
  inuPackage:    Numero de la solicitud de venta


  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/

  FUNCTION frfgetldpromisory(inuPackage in mo_packages.package_id%type)

   RETURN constants.tyrefcursor;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad :         frfGetArticleOrder
  Descripcion    : Busca los articulos asociados a la ot de entrega y ademas esten
                   en estado 'RE' y sean de tipo instalacion
  Autor          : AAcuna
  Fecha          : 23/05/2013

  Parametros         Descripción
  ============   ===================
  inuorden:      Número de orden

  Historia de Modificaciones
  Fecha            Autor       Modificación
  =========      =========  ====================
  23/05/2013     AAcuna     Creación
  ******************************************************************/

  FUNCTION frfGetArticleOrder(inuorden in or_order.order_id%type)

   RETURN constants.tyrefcursor;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : frfGetreturnItems
  Descripcion    : Funcion que a partir de una solicitud de venta,
                   obtiene los articulos a los que se le va a realizar
                   la cdevolución.

  Autor          : KBaquero
  Fecha          : 23/05/2013

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  23/05/2013      Kbaquero             Creacion
  ******************************************************************/
  FUNCTION frfGetreturnItems(inupackage_id in mo_packages.package_id%type,
                             inuraiseError in number default 1)
    Return constants.tyrefcursor;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : frfgetdelorderarticles
  Descripcion    : Funcion que a partir una
                   orden de entrega obtiene los articulos.

  Fecha          : 23/05/2013

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================

  ******************************************************************/
  FUNCTION frfgetdelorderarticles( inuorder   in or_order.order_id%type)

   RETURN constants.tyrefcursor;

   /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : frcgetPromiByTypeIden
  Descripcion    : Obtiene el pagare apartir del tipo de identificación
                   e identificación del cliente.

  Autor          : emontenegro
  Fecha          : 20-08-2013

  Parametros              Descripcion
  ============         ===================
  inuProduct           Identificador del producto.


  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION frcgetPromiByTypeIden(inuTypeIdent ld_promissory.ident_type_id%type,
                                 isbIdentification ld_promissory.identification%type)
  return ld_promissory%rowtype;


   /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : frcgetOperUnitSupplier
  Descripcion    : Obtiene la unidad operativa del proveedor.

  Autor          : emontenegro
  Fecha          : 21-08-2013

  Parametros              Descripcion
  ============         ===================
  inuSupplier          Proveedor.


  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION frcgetOperUnitSupplier(inuSupplier or_operating_unit.contractor_id%type)
  return or_operating_unit%rowtype;

  /**********************************************************************
  	Propiedad intelectual de OPEN International Systems
  	Nombre              updMotiveProdTypeByPack

  	Autor				Andrés Felipe Esguerra Restrepo

  	Fecha               12-sep-2013

  	Descripción         Actualiza el producto y tipo de producto de los motivos
  	                    en el paquete dado

  	***Parametros***
  	Nombre				Descripción
  	inuPackageId        Paquete cuyos motivos se actualizaran
    inuProductId        ID del producto a asignar
	inuProdTypeId       ID de tipo de producto a asignar
  ***********************************************************************/

  PROCEDURE updMotiveProdTypeByPack(	inuPackageId	in mo_packages.package_id%type,
	                                    inuProductId    in pr_product.product_id%type,
										inuProdTypeId	in pr_product.product_type_id%type);

    /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : fnuGetDocRevOrder
    Descripcion    : Retorna la orden de Revisión de Documentos dada la solicitud
                   y el id de la actividad.

    Autor          : Jorge Alejandro Carmona Duque
    Fecha          : 12/11/2013

    Parametros          Descripción
    ============      ===================
    inuPackageId     : Número de la solicitud de venta.
    inuActivityId    : Actividad de Revisión de Documentos

    Historia de Modificaciones
    Fecha             Autor               Modificación
    =========         =========           ====================
    12/11/2013        JCarmona.SAO222244  Creación.
    ******************************************************************/
	FUNCTION fnuGetDocRevOrder
    (
        inuPackageId	in mo_packages.package_id%type,
        inuActivityId   in OR_order_activity.activity_id%type
    )
    return or_order_activity.order_id%type;

    /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : ftbGetQuotaTransferOrder
    Descripcion    : Retorna las órdenes de traslado de cupo de la solicitud.

    Autor          : Jorge Alejandro Carmona Duque
    Fecha          : 12/11/2013

    Parametros          Descripción
    ============      ===================
    inuPackageId     : Número de la solicitud de venta.

    Historia de Modificaciones
    Fecha             Autor               Modificación
    =========         =========           ====================
    12/11/2013        JCarmona.SAO222244  Creación.
    ******************************************************************/
	FUNCTION ftbGetQuotaTransferOrder
    (
        inuPackageId	in mo_packages.package_id%type
    )
    return dald_quota_transfer.tytbORDER_ID;

    /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : ftbGetArticlesFromSale
    Descripcion    : Retorna todos los artículos de la venta.

    Autor          : Jorge Alejandro Carmona Duque
    Fecha          : 15/11/2013

    Parametros          Descripción
    ============      ===================
    inuPackageId     : Número de la solicitud de venta.

    Historia de Modificaciones
    Fecha             Autor               Modificación
    =========         =========           ====================
    15/11/2013        JCarmona.SAO223175  Creación.
    ******************************************************************/
	FUNCTION ftbGetArticlesFromSale
    (
        inuPackageId	in mo_packages.package_id%type
    )
    return dald_item_work_order.tytbItem_Work_Order_Id;

    /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         :    fnuCountNonDelivArticles
    Descripción    :    Valida si todos los artículos entregados fueron devueltos.
                        Retorna 1 si todos los artículos de la orden se encuentran
                        anulados/devueltos.
                        Retorna 0 de lo contrario.

    Autor          :    Jorge Alejandro Carmona Duque
    Fecha          :    10/12/2013

    Parámetros              Descripción
    ============        ===================
    inuOrderId          Orden de entrega
    isbState            Estado de los artículos

    Historia de Modificaciones
    Fecha             Autor             Modificación
    =========       =========           ====================
    10/12/2013      JCarmona.SAO227029  Creación.
    ******************************************************************/
    FUNCTION fnuCountNonDelivArticles
    (
        inuOrderId  in  ld_item_work_order.order_id%TYPE,
        isbState    in  ld_item_work_order.state%TYPE
    )
    RETURN number;

END LD_BCFLOWFNBPACK;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.LD_BCFLOWFNBPACK IS

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : LD_bcflowFNBPack
  Descripcion    : Paquete con los servicios de consultas necesarias
                   para el proceso del flujo de venta.
  Autor          : Adolfo Acu?a Beltran
  Fecha          : 18/04/13 11:35:27 a.m.

  Historia de Modificaciones
    Fecha             Autor               Modificacion
  =========         =========         ====================
  27-feb-2014       AecheverrySAO223739 Se modifica <<frcgetOperUnitSupplier>>
  05-09-2013        mmira.SAO214195     Se adiciona <GetCatSubBySuscripc>
  18/04/2013      AAcuna.SAO139854    Creacion
  ******************************************************************/

  /* Declaracion de Tipos de datos privados */

  /* Declaracion de constantes privados */

  csbVersion CONSTANT VARCHAR2(20) := 'SAO223739';

  /* Declaracion de variables privados */

  /* Declaracion de funciones y procedimientos */

  FUNCTION fsbVersion RETURN VARCHAR2 IS
  BEGIN
    RETURN csbVersion;
  END;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : FnuGetBillExpired
  Descripcion    : Verifica que la factura se encuentra vencida dependiendo las dos siguientes condiciones:
                   1. Que la fecha de limite de pago sea menor al sysdate
                   2. Que la cuenta de cobro  asociada a la factura no tenga saldo pendiente
                   La funcion retornara los siguientes valores:
                   Retorna (0) si la factura no esta vencida
                   Retorna (1) Si se encuentra al dia

  Autor          : AAcuna
  Fecha          : 18/04/2013

  Parametros          Descripcion
  ============     ===================
  inuSuscripc      Numero del contrato

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  18/04/2013    AAcuna.SAO139854      Creacion
  ******************************************************************/

  FUNCTION FnuGetBillExpired(inuSuscripc in suscripc.susccodi%type)

   RETURN number

   IS

    nuBillExpired number;

  BEGIN

    ut_trace.trace('Inicio LD_bcflowFNBPack.FnuGetBillExpired', 10);

    SELECT count(1)
      INTO nuBillExpired
      FROM perifact p
     WHERE p.pefafepa < SYSDATE
       AND p.pefacodi =
           (SELECT f.factpefa
              FROM factura f, cuencobr c
             WHERE f.factcodi = c.cucofact
               AND c.cucofact = (select f.factcodi
                                   from factura f
                                  where f.factsusc = inuSuscripc
                                    and f.factfege =
                                        (select max(factfege)
                                           from factura f
                                          where f.factsusc = inuSuscripc)
                                    and rownum = 1)
               AND (NVL(cucosacu, 0) + NVL(cucovare, 0) + NVL(cucovrap, 0)) > 0
               AND rownum = 1);

    RETURN nuBillExpired;

    ut_trace.trace('Fin LD_bcflowFNBPack.FnuGetBillExpired', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when no_data_found then
      return null;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END FnuGetBillExpired;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : CreateproducOcupp
  Descripcion    : Identifica si la solicitud de venta la hizo el titular de la factura o no
                   El procedimiento retornara los siguientes valores:
                   Retorna (1) Si la solicitud de venta no la hizo el titular
                   Retorna (0) Si la solicitud de venta la hizo el titular

  Autor          : AAcuna
  Fecha          : 14/05/2013

  Parametros          Descripción
  ============     ===================
  inuPackage       : Número de la solicitud de venta.
  onuProducOcupp   : Retorna (1) Si la solicitud de venta no la hizo el titular
                     Retorna (0) Si la solicitud de venta la hizo el titular
  onuPromissory_Id : Codigo del promissory

  Historia de Modificaciones
  Fecha             Autor             Modificación
  =========       =========           ====================
  14/05/2013    AAcuna.SAO139854      Creación
  ******************************************************************/

  PROCEDURE CreateproducOcupp(inuPackage       in mo_packages.package_id%type,
                              onuProducOcupp   out number,
                              onuPromissory_Id out ld_promissory.promissory_id%type)

   IS

  BEGIN

    ut_trace.trace('Inicio LD_bcflowFNBPack.CreateproducOcupp', 10);

    SELECT COUNT(1), Promissory_Id
      INTO onuProducOcupp, onuPromissory_Id
      FROM ld_promissory
     WHERE package_id = inuPackage
       AND promissory_type = 'D'
       AND holder_bill = 'N'
       AND ROWNUM = 1
     GROUP BY Promissory_Id;

    ut_trace.trace('Fin LD_bcflowFNBPack.CreateproducOcupp', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when no_data_found then
      onuProducOcupp   := null;
      onuPromissory_Id := null;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END CreateproducOcupp;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : GetContractBySubsc
  Descripcion    : Identifica si el cliente tiene por lo menos algun contrato asociado.
                   El procedimiento retornara los siguientes valores:
                   Retorna (0) Si el cliente no tiene contrato asociado
                   Retorna (1) Si el cliente tiene contrato asociado

  Autor          : AAcuna
  Fecha          : 14/05/2013

  Parametros          Descripción
  ============     ===================
  inuSusbcriber     : Número del cliente
  nuSuscripc        : Número del contrato
  nuContract        : Valor de retorno
                      Retorna (0) Si el cliente no tiene contrato asociado
                      Retorna (1) Si el cliente tiene contrato asociado

  Historia de Modificaciones
  Fecha             Autor             Modificación
  =========       =========           ====================
  14/05/2013    AAcuna.SAO139854      Creación
  ******************************************************************/

  PROCEDURE GetContractBySubsc(inuSusbcriber in ge_subscriber.subscriber_id %type,
                               onuSuscripc   out suscripc.susccodi%type,
                               onuContract   out number)

   IS

  BEGIN

    ut_trace.trace('Inicio LD_bcflowFNBPack.GetContractBySubsc', 10);

    SELECT COUNT(1), s.susccodi
      INTO onuContract, onuSuscripc
      FROM suscripc s
     WHERE s.suscclie = inuSusbcriber
       AND ROWNUM = 1
     GROUP BY s.susccodi;

    ut_trace.trace('Fin LD_bcflowFNBPack.GetContractBySubsc', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when no_data_found then
      onuSuscripc := null;
      onuContract := 0;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END GetContractBySubsc;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : getServsusByGB
  Descripcion    : Obtiene los productos asociados al contrato y que sean de tipo de producto brilla-brilla_promigas
                   (7055,7056)

  Autor          : AAcuna
  Fecha          : 29/04/2013

  Parametros          Descripcion
  ============     ===================
  inuSuscripc      Numero del contrato

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  29/04/2013    AAcuna.SAO139854      Creacion
  ******************************************************************/

  FUNCTION getServsusByGB(inuSuscripc in suscripc.susccodi%type,
                          inuFinPro   in servsusc.sesuserv%type,
                          inuFinBri   servsusc.sesuserv%type)

   RETURN pktblservsusc.tySesunuse

   IS

    rfServsus constants.tyrefcursor;
    tbServsus pktblservsusc.tySesunuse;

  BEGIN

    ut_trace.trace('Inicio LD_bcflowFNBPack.getServsusByGB', 10);

    OPEN rfServsus FOR
      SELECT s.sesunuse
        FROM servsusc s
       WHERE s.sesususc = inuSuscripc
         AND s.sesuserv IN (inuFinPro, inuFinBri);

    FETCH rfServsus BULK COLLECT
      INTO tbServsus;
    CLOSE rfServsus;

    RETURN tbServsus;

    ut_trace.trace('Fin LD_bcflowFNBPack.getServsusByGB', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;

    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END getServsusByGB;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : getOrderDeliveryArt
  Descripcion    : Obtiene las ot de entrega y los articulos asociados a la solicitud de venta,
                   ademas las ordenes se deben encontrar legalizadas y ser legalizadas con causal de exito
                   y los articulos tener estado 'RE'

  Autor          : AAcuna
  Fecha          : 29/04/2013

  Parametros          Descripcion
  ============     ===================
  inuSuscripc      Numero del contrato

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  29/04/2013    AAcuna.SAO139854      Creacion
  ******************************************************************/

  FUNCTION getOrderDeliveryArt(inuPackage in mo_packages.package_id%type,
                               inuCausal  in or_order.causal_id%type)

   RETURN constants.tyrefcursor

   IS

    rfArticleOtDelivery constants.tyrefcursor;

  BEGIN

    ut_trace.trace('Inicio LD_bcflowFNBPack.getOrderDeliveryArt', 10);

    OPEN rfArticleOtDelivery FOR
      SELECT DISTINCT ld_item_work_order.article_id Articulo,
                      ld_item_work_order.state,
                      ld_item_work_order.order_id
        FROM ld_item_work_order, or_order_activity, or_order
       WHERE ld_item_work_order.order_id = or_order_activity.order_id
         AND ld_item_work_order.order_activity_id =
             or_order_activity.order_activity_id
         AND or_order.order_id = ld_item_work_order.order_id
         AND EXISTS
       (SELECT 1
                FROM suscripc s
               WHERE or_order_activity.subscription_id = s.susccodi)
         AND or_order_activity.activity_id =
             dald_parameter.fnuGetNumeric_Value('ACT_TYPE_DEL_FNB')
         AND or_order_activity.package_id = inuPackage
         AND ld_item_work_order.state = 'RE'
         AND or_order.causal_id = inuCausal
         AND or_order.legalization_date IS NOT NULL
         AND or_order.order_status_id =
             dald_parameter.fnuGetNumeric_Value('COD_ORDER_STATUS', null)
         AND ld_item_work_order.order_id IS NOT NULL;

    RETURN rfArticleOtDelivery;

    ut_trace.trace('Fin LD_bcflowFNBPack.getOrderDeliveryArt', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;

    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END getOrderDeliveryArt;

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

  FUNCTION ftbValidateFlowmove(inuAccion    in Mo_Wf_Pack_Interfac.Action_Id%type,
                               inupackageid in Mo_Wf_Pack_Interfac.Package_Id%type)

   RETURN damo_wf_pack_interfac.tytbWf_Pack_Interfac_Id

   IS

    rfFlowmove     constants.tyrefcursor;
    tbInterface_id damo_wf_pack_interfac.tytbWf_Pack_Interfac_Id;

  BEGIN

    ut_trace.trace('Inicio LD_bcflowFNBPack.frfValidateFlowmove', 10);

    OPEN rfFlowmove FOR
      SELECT Wf_Pack_Interfac_Id
        FROM Mo_Wf_Pack_Interfac
       WHERE Action_Id = inuAccion
         AND Status_Activity_Id =
             MO_BOStatusParameter.fnuGetSTA_ACTIV_STANDBY
         AND Package_Id in (inupackageid);

    FETCH rfFlowmove BULK COLLECT
      INTO tbInterface_id;
    CLOSE rfFlowmove;

    RETURN tbInterface_id;

    ut_trace.trace('Fin LD_bcflowFNBPack.frfValidateFlowmove', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;

    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END ftbValidateFlowmove;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ftbgetsalepackagearticles
  Descripcion    : Busca los articulos de venta.
  Autor          : ERAMOS
  Fecha          : 11/04/2013

  Parametros         Descripcion
  ============   ===================
  inuPackage:    Numero de la solicitud de venta


  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION ftbgetsalepackagearticles(inuPackage in mo_packages.package_id%type)

   RETURN dald_item_work_order.tytbLD_item_work_order

   IS

    cursor cuItems(inuPackage in mo_packages.package_id%type) is
      SELECT /*+ index (li PK_LD_ITEM_WORK_ORDER) index(li IX_LD_ITEM_WORK_ORDER01)  use_nl(li o) use_nl(oa o)*/
       li.*, li.rowid
        FROM or_order_activity oa, ld_item_work_order li
       WHERE oa.activity_id =
             (dald_parameter.fnuGetNumeric_Value('ACT_TYPE_DEL_FNB'))
         AND oa.package_id = inuPackage
         AND li.order_id = oa.order_id
         and li.order_activity_id = oa.order_activity_id
         and li.state = 'RE';

    tbArticle dald_item_work_order.tytbLD_item_work_order;

  BEGIN

    ut_trace.trace('Inicio LD_bcflowFNBPack.frfgetsalepackagearticles', 10);

    OPEN cuItems(inuPackage);
    FETCH cuItems BULK COLLECT
      INTO tbArticle;
    CLOSE cuItems;

    RETURN tbArticle;

    ut_trace.trace('Inicio LD_bcflowFNBPack.frfgetsalepackagearticles', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END ftbgetsalepackagearticles;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ftbgetCreateProductPackAsso
  Descripcion    : Busca el paquete asociado dado un paquete
                 y tipo de paquete
  Autor          : ERAMOS
  Fecha          : 11/04/2013

  Parametros         Descripcion
  ============   ===================
  inuPackage:    Numero de la solicitud de venta


  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION ftbgetPackAssoByType(inuPackage     in mo_packages.package_id%type,
                                inuPackageType in mo_packages.package_type_id%type)
    RETURN damo_packages_asso.tytbMO_packages_asso IS

    cursor cuItems(inuPackage in mo_packages.package_id%type, inuPackageType in mo_packages.package_type_id%type) is
      select mo_packages_asso.*, mo_packages_asso.rowid
        from mo_packages, mo_packages_asso
       where mo_packages.package_id = mo_packages_asso.package_id
         and mo_packages.package_type_id = inuPackageType
         and mo_packages_asso.package_id_asso = inuPackage;

    tbArticle damo_packages_asso.tytbMO_packages_asso;

  BEGIN

    ut_trace.trace('Inicio LD_bcflowFNBPack.frfgetsalepackagearticles', 10);

    OPEN cuItems(inuPackage, inuPackageType);
    FETCH cuItems BULK COLLECT
      INTO tbArticle;
    CLOSE cuItems;

    RETURN tbArticle;

    ut_trace.trace('Inicio LD_bcflowFNBPack.frfgetsalepackagearticles', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END ftbgetPackAssoByType;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : FnuGetActivity
  Descripcion    : Obtiene la actividad asociada a la orden

  Autor          : AAcuna
  Fecha          : 18/04/2013

  Parametros          Descripcion
  ============     ===================
  inuOrder         Número de la orden

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  18/04/2013    AAcuna.SAO139854      Creacion
  ******************************************************************/

  FUNCTION FnuGetActivity(inuOrder in or_order.order_id%type)

   RETURN or_order_activity.order_activity_id%type

   IS

    nuActivity or_order_activity.order_activity_id%type;

  BEGIN

    ut_trace.trace('Inicio LD_bcflowFNBPack.FnuGetActivity', 10);

    SELECT or_order_activity.order_activity_id
      INTO nuActivity
      FROM or_order_activity
     WHERE or_order_activity.order_id = inuOrder;

    RETURN nuActivity;

    ut_trace.trace('Fin LD_bcflowFNBPack.FnuGetActivity', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when no_data_found then
      return null;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END FnuGetActivity;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : Propricevariation
  Descripcion    : Verifica si en la tabla de Variación de precio
                   Existe o no datos para enviar esta información al
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

  PROCEDURE Propricevariation(inupackage_id in mo_packages.package_id%type,
                              Osbresp       out varchar2) is

  Begin
    ut_trace.trace('Inicio Ld_BcflowFNBPack.Propricevariation', 10);

    SELECT DECODE(APPROVED, 'Y', 1, 0, 0)
      into Osbresp
      FROM LD_APPROVE_SALES_ORDER
     WHERE PACKAGE_ID = inupackage_id;

    ut_trace.trace('Fin Ld_BcflowFNBPack.Propricevariation', 10);

  EXCEPTION
    When no_data_found then
      Osbresp := 'N';
    WHEN ex.CONTROLLED_ERROR THEN
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      Errors.setError;
      RAISE ex.CONTROLLED_ERROR;
  END Propricevariation;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : frfgetldpromisory
  Descripcion    : Busca los datos que se encuentran en la tabla Promisory
                   para que sean actualizados en ge_subscriber.
  Autor          : Kbaquero
  Fecha          : 22/05/2013

  Parametros         Descripcion
  ============   ===================
  inuPackage:    Numero de la solicitud de venta


  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/

  FUNCTION frfgetldpromisory(inuPackage in mo_packages.package_id%type)

   RETURN constants.tyrefcursor

   IS

    tbpromisory_id dald_promissory.tytbPromissory_Id;
    rfpromisory_id pkconstante.tyRefCursor;

  BEGIN

    ut_trace.trace('Inicio Ld_BcflowFNBPack.frfgetldpromisory', 10);

    OPEN rfpromisory_id FOR
      SELECT l.*, l.rowid
        FROM ld_promissory l
       WHERE package_id = inuPackage
         AND promissory_type = 'C';

    Return(rfpromisory_id);

    ut_trace.trace('Inicio Ld_BcflowFNBPack.frfgetldpromisory', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END frfgetldpromisory;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad :         frfGetArticleOrder
  Descripcion    : Busca los articulos asociados a la ot de entrega y ademas esten
                   en estado 'RE'
  Autor          : AAcuna
  Fecha          : 23/05/2013

  Parametros         Descripción
  ============   ===================
  inuorden:      Número de orden

  Historia de Modificaciones
  Fecha            Autor       Modificación
  =========      =========  ====================
  23/05/2013     AAcuna     Creación
  ******************************************************************/

  FUNCTION frfGetArticleOrder(inuorden in or_order.order_id%type)

   RETURN constants.tyrefcursor

   IS
    rfGetArticleOrder constants.tyrefcursor;
  BEGIN

    OPEN rfGetArticleOrder FOR
      SELECT distinct w.item_work_order_id,
                      w.article_id,
                      a.description,
                      w.order_activity_id
        FROM ld_item_work_order w,
             or_order_activity  oa,
             ld_article         a,
             or_order           o,
             or_order_status    os
       WHERE w.order_activity_id = oa.order_activity_id
         AND w.order_id = oa.order_id
         AND w.order_id = o.order_id
         AND a.article_id = w.article_id
         AND oa.order_id = oa.order_id
         AND os.order_status_id = o.order_status_id
         AND w.state = 'RE'
         AND a.installation = 'Y'
         AND oa.order_id = o.order_id
         AND o.order_id = inuorden;

    RETURN rfGetArticleOrder;

  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      Errors.setError;
      RAISE ex.CONTROLLED_ERROR;
  END frfGetArticleOrder;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : frfGetreturnItems
  Descripcion    : Funcion que a partir de una solicitud de venta,
                   obtiene los articulos a los que se le va a realizar
                   la cdevolución.

  Autor          : KBaquero
  Fecha          : 23/05/2013

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  23/05/2013      Kbaquero             Creacion
  ******************************************************************/
  FUNCTION frfGetreturnItems(inupackage_id in mo_packages.package_id%type,
                             inuraiseError in number default 1)
    Return constants.tyrefcursor IS

    /*Declaracion de variables*/
    nuParActDelivery   ld_parameter.numeric_value%type;
    nuParTaskTypeDeliv ld_parameter.numeric_value%type;
    sbQuery            varchar2(32000);
    rfCursor           constants.tyrefcursor;

  BEGIN

    ut_trace.trace('Inicia LD_BCNonbankfinancing.frfGetreturnItems');

    /*Obtener el parametro con el tipo de actividad de Entrega FNB*/
    nuParActDelivery := Dald_Parameter.fnuGetNumeric_Value('ACT_TYPE_DEL_FNB');

    /*Obtener el parametro con el tipo de trabajo de Entrega*/
    nuParTaskTypeDeliv := Dald_Parameter.fnuGetNumeric_Value('CODI_TITR_EFNB');

    sbQuery := 'SELECT DISTINCT o.order_id order_id
              FROM or_order_activity o
              WHERE o.package_id = ' || inupackage_id || --Solicitud de venta
               ' AND o.activity_id = ' || nuParActDelivery || --Actividad de entrega FNB
               ' AND o.task_type_id = ' || nuParTaskTypeDeliv; --Tipo de trabajo de Entrega

    Open rfCursor for sbQuery;

    --close rfCursor;

    ut_trace.trace('Finaliza LD_BCNonbankfinancing.frfGetreturnItems');

    return rfCursor;

  EXCEPTION
    When ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    When others then
      if inuRaiseError = 1 then
        Errors.setError;
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;

  END frfGetreturnItems;
  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : frfgetdelorderarticles
  Descripcion    : Funcion que a partir de una solicitud de venta,y una
                   orden de entrega obtiene los articulos.

  Fecha          : 23/05/2013

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================

  ******************************************************************/
  FUNCTION frfgetdelorderarticles(inuorder in or_order.order_id%type)

   RETURN constants.tyrefcursor

   IS

    tbArticle_id dald_item_work_order.tytbArticle_Id;
    rfArticle_id pkconstante.tyRefCursor;

  BEGIN

    ut_trace.trace('Inicio Ld_BcNonBankFinacing.frfgetsalepackagearticles',
                   10);

    OPEN rfArticle_id FOR
      SELECT /*+ index (li PK_LD_ITEM_WORK_ORDER) index(li IX_LD_ITEM_WORK_ORDER01)  use_nl(li o) use_nl(oa o)*/
       li.*, li.rowid
        FROM or_order_activity oa, ld_item_work_order li
       WHERE oa.activity_id =
             (dald_parameter.fnuGetNumeric_Value('ACT_TYPE_DEL_FNB'))
            -- AND oa.package_id = inuPackage
         AND li.order_id = oa.order_id
         and oa.order_activity_id = li.order_activity_id
         and oa.order_id = inuorder
         and li.state = 'RE';

    Return(rfArticle_id);

    ut_trace.trace('Inicio Ld_BcNonBankFinacing.frfgetsalepackagearticles',
                   10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END frfgetdelorderarticles;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : frcgetPromiByTypeIden
  Descripcion    : Obtiene el pagare apartir del tipo de identificación
                   e identificación del cliente.

  Autor          : emontenegro
  Fecha          : 20-08-2013

  Parametros              Descripcion
  ============         ===================
  inuProduct           Identificador del producto.


  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION frcgetPromiByTypeIden(inuTypeIdent ld_promissory.ident_type_id%type,
                                 isbIdentification ld_promissory.identification%type)
    return ld_promissory%rowtype IS

    rcPromissory ld_promissory%rowtype;

    cursor cuGetPromissory(inuTypeIdent ld_promissory.ident_type_id%type,
                           isbIdentification ld_promissory.identification%type) IS
     SELECT /*+ INDEX(ld_promissory IX_LD_PROMISSOYR01)*/ ld_promissory.*
     FROM ld_promissory
     WHERE ident_type_id = inuTypeIdent
     AND identification= isbIdentification;

  BEGIN

    open cuGetPromissory(inuTypeIdent,isbIdentification);
    fetch cuGetPromissory
      into rcPromissory;
    close cuGetPromissory;

    return rcPromissory;

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END frcgetPromiByTypeIden;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : frcgetOperUnitSupplier
  Descripcion    : Obtiene la unidad operativa del proveedor.

  Autor          : emontenegro
  Fecha          : 21-08-2013

  Parametros              Descripcion
  ============         ===================
  inuSupplier           Proveedor.


  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  27-feb-2014   AecheverrySAO223739     Se modifica para solo obtener unidades proveedoras
                                        o contratistas
  ******************************************************************/
  FUNCTION frcgetOperUnitSupplier(inuSupplier or_operating_unit.contractor_id%type)
  return or_operating_unit%rowtype is

    cnuSupplierFNB CONSTANT ld_parameter.numeric_value%TYPE := Dald_parameter.fnuGetNumeric_Value('SUPPLIER_FNB');
    cnuContractFNB CONSTANT ld_parameter.numeric_value%TYPE := Dald_parameter.fnuGetNumeric_Value('CONTRACTOR_SALES_FNB');

    rcOperatingUnit or_operating_unit%rowtype;

    cursor cuGetOperUnit(inuSupplier or_operating_unit.contractor_id%type) IS
     SELECT /*+ INDEX(or_operating_unit IDX_OR_OPERATING_UNIT10)*/ or_operating_unit.*
     FROM or_operating_unit
     WHERE contractor_id = inuSupplier
     AND oper_unit_classif_id in (cnuContractFNB,cnuSupplierFNB)
     AND rownum=1;

  BEGIN

    open cuGetOperUnit(inuSupplier);
    fetch cuGetOperUnit
      into rcOperatingUnit;
    close cuGetOperUnit;

    return rcOperatingUnit;

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END frcgetOperUnitSupplier;

	PROCEDURE updMotiveProdTypeByPack(	inuPackageId	in mo_packages.package_id%type,
	                                    inuProductId    in pr_product.product_id%type,
										inuProdTypeId	in pr_product.product_type_id%type) IS

	CURSOR cuMotivesByPack(packId mo_motive.package_id%type) IS
	SELECT motive_id
	FROM mo_motive
	WHERE PACKAGE_id = packId;

	BEGIN

		FOR rx IN cuMotivesByPack(inuPackageId) LOOP
			damo_motive.updProduct_Id(rx.motive_id,inuProductId);
			damo_motive.updProduct_Type_Id(rx.motive_id,inuProdTypeId);
		END LOOP;

	EXCEPTION
		WHEN ex.CONTROLLED_ERROR then
			RAISE ex.CONTROLLED_ERROR;
		WHEN OTHERS THEN
			Errors.setError;
			RAISE ex.CONTROLLED_ERROR;
	END updMotiveProdTypeByPack;

	/*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : fnuGetDocRevOrder
    Descripcion    : Retorna la orden de Revisión de Documentos dada la solicitud
                   y el id de la actividad.

    Autor          : Jorge Alejandro Carmona Duque
    Fecha          : 12/11/2013

    Parametros          Descripción
    ============      ===================
    inuPackageId     : Número de la solicitud de venta.
    inuActivityId    : Actividad de Revisión de Documentos

    Historia de Modificaciones
    Fecha             Autor               Modificación
    =========         =========           ====================
    12/11/2013        JCarmona.SAO222244  Creación.
    ******************************************************************/
	FUNCTION fnuGetDocRevOrder
    (
        inuPackageId	in mo_packages.package_id%type,
        inuActivityId   in OR_order_activity.activity_id%type
    )
    return or_order_activity.order_id%type
    IS
        nuOrderId       or_order_activity.order_id%type;

    	CURSOR cuGetDocRevOrder
        (
            nuPackageId	    in mo_packages.package_id%type,
            nuActivityId   in OR_order_activity.activity_id%type
        )
        IS
            SELECT      order_id
            FROM        or_order_activity
            WHERE       package_id = nuPackageId
            AND         activity_id = nuActivityId;

	BEGIN
        ut_trace.trace('BEGIN LD_bcflowFNBPack.fnuGetDocRevOrder',1);

        OPEN cuGetDocRevOrder(inuPackageId, inuActivityId);
        FETCH cuGetDocRevOrder
            INTO nuOrderId;
        CLOSE cuGetDocRevOrder;

        ut_trace.trace('END LD_bcflowFNBPack.fnuGetDocRevOrder',1);

        return nuOrderId;
	EXCEPTION
		WHEN ex.CONTROLLED_ERROR then
			RAISE ex.CONTROLLED_ERROR;
		WHEN OTHERS THEN
			Errors.setError;
			RAISE ex.CONTROLLED_ERROR;
	END fnuGetDocRevOrder;

	/*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : ftbGetQuotaTransferOrder
    Descripcion    : Retorna las órdenes de traslado de cupo de la solicitud.

    Autor          : Jorge Alejandro Carmona Duque
    Fecha          : 12/11/2013

    Parametros          Descripción
    ============      ===================
    inuPackageId     : Número de la solicitud de venta.

    Historia de Modificaciones
    Fecha             Autor               Modificación
    =========         =========           ====================
    12/11/2013        JCarmona.SAO222244  Creación.
    ******************************************************************/
	FUNCTION ftbGetQuotaTransferOrder
    (
        inuPackageId	in mo_packages.package_id%type
    )
    return dald_quota_transfer.tytbORDER_ID
    IS
        tbOrderId       dald_quota_transfer.tytbORDER_ID;

    	CURSOR cuGetQuotaTransferOrder
        (
            nuPackageId	    in mo_packages.package_id%type
        )
        IS
            SELECT      ORDER_id
            FROM        ld_quota_transfer
            WHERE       package_id = nuPackageId;

	BEGIN
        ut_trace.trace('BEGIN LD_bcflowFNBPack.ftbGetQuotaTransferOrder',1);

        OPEN cuGetQuotaTransferOrder(inuPackageId);
        FETCH cuGetQuotaTransferOrder
            bulk collect INTO tbOrderId;
        CLOSE cuGetQuotaTransferOrder;

        ut_trace.trace('END LD_bcflowFNBPack.ftbGetQuotaTransferOrder',1);

        return tbOrderId;
	EXCEPTION
		WHEN ex.CONTROLLED_ERROR then
			RAISE ex.CONTROLLED_ERROR;
		WHEN OTHERS THEN
			Errors.setError;
			RAISE ex.CONTROLLED_ERROR;
	END ftbGetQuotaTransferOrder;

	/*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : ftbGetArticlesFromSale
    Descripcion    : Retorna todos los artículos de la venta.

    Autor          : Jorge Alejandro Carmona Duque
    Fecha          : 15/11/2013

    Parametros          Descripción
    ============      ===================
    inuPackageId     : Número de la solicitud de venta.

    Historia de Modificaciones
    Fecha             Autor               Modificación
    =========         =========           ====================
    15/11/2013        JCarmona.SAO223175  Creación.
    ******************************************************************/
	FUNCTION ftbGetArticlesFromSale
    (
        inuPackageId	in mo_packages.package_id%type
    )
    return dald_item_work_order.tytbItem_Work_Order_Id
    IS
        tbItemWorkOrder       dald_item_work_order.tytbItem_Work_Order_Id;

        nuActivityTypeFNB number := DALD_parameter.fnuGetNumeric_Value('ACTIVITY_TYPE_FNB');

    	CURSOR cuGetArticlesFromSale
        (
            nuPackageId	    in mo_packages.package_id%type
        )
        IS
            SELECT  item_work_order_id
            FROM    ld_item_work_order
            WHERE   ld_item_work_order.order_activity_id in
                    (
                        SELECT  or_order_activity.order_activity_id
                        FROM    or_order_activity
                        WHERE   or_order_activity.package_id = nuPackageId
                        AND     or_order_activity.activity_id = nuActivityTypeFNB
                    );

	BEGIN
        ut_trace.trace('BEGIN LD_bcflowFNBPack.ftbGetArticlesFromSale',1);

        OPEN cuGetArticlesFromSale(inuPackageId);
        FETCH cuGetArticlesFromSale
            bulk collect INTO tbItemWorkOrder;
        CLOSE cuGetArticlesFromSale;

        ut_trace.trace('END LD_bcflowFNBPack.ftbGetArticlesFromSale',1);

        return tbItemWorkOrder;
	EXCEPTION
		WHEN ex.CONTROLLED_ERROR then
			RAISE ex.CONTROLLED_ERROR;
		WHEN OTHERS THEN
			Errors.setError;
			RAISE ex.CONTROLLED_ERROR;
	END ftbGetArticlesFromSale;

	/*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         :    fnuCountNonDelivArticles
    Descripción    :    Valida si todos los artículos entregados fueron devueltos.
                        Retorna 1 si todos los artículos de la orden se encuentran
                        anulados/devueltos.
                        Retorna 0 de lo contrario.

    Autor          :    Jorge Alejandro Carmona Duque
    Fecha          :    10/12/2013

    Parámetros              Descripción
    ============        ===================
    inuOrderId          Orden de entrega
    isbState            Estado de los artículos

    Historia de Modificaciones
    Fecha             Autor             Modificación
    =========       =========           ====================
    10/12/2013      JCarmona.SAO227029  Creación.
    ******************************************************************/
    FUNCTION fnuCountNonDelivArticles
    (
        inuOrderId  in  ld_item_work_order.order_id%TYPE,
        isbState    in  ld_item_work_order.state%TYPE
    )
    RETURN number
    IS

        nuCountNonDelivArticles     number;

        CURSOR cuCountNonDelivArticles
        (
            nuOrderId  ld_item_work_order.order_id%TYPE,
            sbState    ld_item_work_order.state%TYPE
        )
        IS
            SELECT  count(1)
            FROM    ld_item_work_order iwo
            WHERE   iwo.order_id = nuOrderId
            AND     iwo.state = sbState;

    BEGIN

        ut_trace.trace('BEGIN Ld_BcflowFNBPack.fnuCountNonDelivArticles['||inuOrderId||']['||isbState||']', 1);

        /* Obtiene la cantidad de artículos devueltos de la orden */
        open cuCountNonDelivArticles(inuOrderId, isbState);
            fetch cuCountNonDelivArticles INTO nuCountNonDelivArticles;
        close cuCountNonDelivArticles;

        ut_trace.trace('END Ld_BcflowFNBPack.fnuCountNonDelivArticles['||nuCountNonDelivArticles||']', 1);

        RETURN nuCountNonDelivArticles;

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            if cuCountNonDelivArticles%isopen then
                close cuCountNonDelivArticles;
            END if;
            raise ex.CONTROLLED_ERROR;
        when others then
            if cuCountNonDelivArticles%isopen then
                close cuCountNonDelivArticles;
            END if;
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END fnuCountNonDelivArticles;

END LD_BCFLOWFNBPACK;
/

BEGIN
    pkg_utilidades.prAplicarPermisos('LD_BCFLOWFNBPACK', 'ADM_PERSON'); 
END;
/
