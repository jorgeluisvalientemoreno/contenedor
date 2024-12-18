CREATE OR REPLACE package ADM_PERSON.LD_BCCANCELLATIONS is

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : Ld_BcCancellations
    Descripcion    : Realizar las consultas necesarias para el proceso
                     de anulacion/cancelacion
    Autor          : Jonathan Alberto Consuegra Lara
    Fecha          : 03/04/2013

    Historia de Modificaciones
    Fecha             Autor                 Modificacion
    =========         =========             ====================
    25-11-2013        hjgomez.SAO224553     Se modifica <<fnuNonCanclledArticles>>
    14-11-2013        sgomez.SAO222901      Se adiciona método
                                            <frfCancelledArticles> para
                                            obtención de información de
                                            articulos anulados en una solicitud
                                            de devolución.
                                            Se adiciona método
                                            <fnuCancArticlesTotVal> para
                                            obtención de valor total de
                                            artículos anulados en una
                                            devolución.
                                            Se adiciona tipo <tyrcArticle>.

    05-11-2013        sgomez.SAO222244      Se adiciona método
                                            <fnuNonCanclledArticles>
                                            para conteo de artículos anulados
                                            en una solicitud de anulación.

    03/04/2013        jconsuegra.SAO156577  Creacion
  ******************************************************************/

    ------------------------------------------------------------------------
    -- Tipos
    ------------------------------------------------------------------------

    type tyrcArticle is record
    (
        order_id            or_order.order_id%type,
        contractor_id       or_operating_unit.contractor_id%type,
        operating_unit_id   or_order.operating_unit_id%type,
        reception_type_id   mo_packages.reception_type_id%type,
        geograp_location_id ab_address.geograp_location_id%type,
        subline_id          ld_article.subline_id%type,
        line_id             ld_line.line_id%type,
        article_id          ld_item_work_order.article_id%type,
        value               ld_item_work_order.value%type,
        amount              ld_item_work_order.amount%type,
        iva                 ld_item_work_order.iva%type,
        package_sale        ld_return_item.package_sale%type
    );

  -----------------------
  --------------------------------------------------------------------
  -- Variables
  --------------------------------------------------------------------
  --------------------------------------------------------------------
  -- Cursores
  --------------------------------------------------------------------
  -----------------------------------
  -- Metodos publicos del package
  -----------------------------------

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : fsbVersion
    Descripcion    : Retorna el SAO con que se realizo la ultima
                     entrega
    Autor          : jonathan alberto consuegra lara
    Fecha          : 03/04/2013

    Parametros       Descripcion
    ============     ===================

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    03/04/2013       jconsuegra.SAO139854  Creacion
  ******************************************************************/
  FUNCTION fsbVersion RETURN varchar2;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : Fnugetsaleorder
    Descripcion    : Retorna la orden de venta de una solicitud
                     de venta
    Autor          : jonathan alberto consuegra lara
    Fecha          : 03/04/2013

    Parametros       Descripcion
    ============     ===================

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    03/04/2013       jconsuegra.SAO139854  Creacion
  ******************************************************************/
  Function Fnugetsaleorder(inuPackage    in mo_packages.package_id%type,
                           inuRaiseError in number default 1)
    return or_order.order_id%type;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : Fnugetsaleorder
    Descripcion    : Retorna la orden de venta de una solicitud
                     de venta
    Autor          : jonathan alberto consuegra lara
    Fecha          : 03/04/2013

    Parametros       Descripcion
    ============     ===================
    inupackage_id    identificador de la solicitud de anulacion o
                     devolucion

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    03/04/2013       jconsuegra.SAO139854  Creacion
  ******************************************************************/
  Function fnugetretur_item_id_by_sale(inupackage_id in mo_packages.package_id%type,
                                       inuRaiseError in number default 1)
    return Ld_Return_Item.Return_Item_Id%type;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : fnuGetOperUnitByPackSale
    Descripcion    : Retorna la unidad operativa de una solicitud
                     de anulacion
    Autor          : Alex Valencia Ayola
    Fecha          : 05/04/2013

    Parametros       Descripcion
    ============     ===================

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    05/04/2013       aValencia.SAO139854  Creacion
  ******************************************************************/
  FUNCTION fnuGetOperUnitByPackSale(inuPackage    IN mo_packages.package_id%TYPE,
                                    inuRaiseError IN NUMBER DEFAULT 1)
    RETURN or_order.operating_unit_id%TYPE;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : Fnugetitemworder
    Descripcion    : Retorna el consecutivo del item_work_order_id
                       teniendo una ot de entrega.
    Autor          : Kbaquero
    Fecha          : 08/04/2013

    Parametros       Descripcion
    ============     ===================

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    08/04/2013       KBaquero.SAO139854  Creacion
  ******************************************************************/
  Function Fnugetitemworder(inuorder      in or_order.order_id%type,
                            inuRaiseError in number default 1)
    return ld_item_work_order.item_work_order_id%type;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : Fnugetdetail_item
    Descripcion    : Retorna el consecutivo del
                     teniendo una ot de entrega.
    Autor          : Kbaquero
    Fecha          : 09/04/2013

    Parametros       Descripcion
    ============     ===================

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    09/04/2013       KBaquero.SAO139854  Creacion
  ******************************************************************/
  Function Fnugetdetail_item(inureturitem  in ld_return_item.return_item_id%type,
                             inuRaiseError in number default 1)
    return ld_return_item_detail.return_item_detail_id%type;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ProcSearchReturnItem
  Descripcion    : Busca la informacion de los articulos de anulacion

  Autor          : kBaquero
  Fecha          : 10/04/2013 SAO 139854

  Parametros         Descripcion
  ============   ===================
  inuGas_Service:   Parametro del numero de servicio
  inuState:         Parametro del estado de la poliza
  otbAccountcharge: Objeto tipo tabla con los suscritores

  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/

  PROCEDURE ProcSearchReturnItemDetail(inuretItemDetail_id in ld_return_item_detail.return_item_detail_id%type,
                                       inuState            in ld_parameter.value_chain%type,
                                       otbAccountcharge    out pktblservsusc.tySesunuse);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

    Unidad :      GetArticleBy_An_Dev
    Descripcion : Retorna los articulos asociados a una solicitud de anulación
                  /devolución

    Autor : AAcuna
    Fecha : 16/04/2013

    Parametros      Descripcion
    ============   ===================
    inuPackage      Numero de la solicitud de anulación/devolución

    Historia de Modificaciones
    Fecha Autor Modificacion
    ========= ========= ====================

  ******************************************************************/

  FUNCTION GetArticleBy_An_Dev(inuPackage in mo_packages.package_id%type)

   RETURN dald_return_item_detail.tytbArticle_Id;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

    Unidad : GetArticleByPackSa
    Descripcion : Retorna el detalle de los articulos
                  asociados a una solicitud de venta

    Autor : AAcuna
    Fecha : 16/04/2013

    Parametros      Descripcion
    ============   ===================
    inuPackage      Numero de la solicitud de venta
    inuOrder        Numero de la orden de entrega

    Historia de Modificaciones
    Fecha Autor Modificacion
    ========= ========= ====================

  ******************************************************************/

  FUNCTION GetArticleByPackSa(inuPackage in mo_packages.package_id%type,
                              inuOrder   in ld_item_work_order.order_id%type)

   RETURN constants.tyrefcursor;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : FnuGetLastCuencobr
    Descripción    : Obtiene la última cuenta de cobro de un diferido

    Autor          : Jonathan Alberto Consuegra
    Fecha          : 18/04/2013

    Parámetros       Descripción
    ============     ===================
    inudifecodi      Identificador del diferido
    inuRaiseError    Controlador de error

    Historia de Modificaciones
    Fecha            Autor                Modificación
    =========       =========             ====================
    19/04/2013      Jconsuegra.SAO139854  Creación
  ******************************************************************/
  FUNCTION FnuGetLastCuencobr(inudifecodi   in diferido.difecodi%type,
                              inuRaiseError in number default 1)
    return cargos.cargcuco%type;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : frfGetreturnItems
  Descripcion    : Funcion que a partir de una solicitud de venta,
                   obtiene los items, que le van a realizar la devolución.

  Autor          : KBaquero
  Fecha          : 23/05/2013

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  23/05/2013      KBaquero             Creacion
  ******************************************************************/
  FUNCTION frfGetreturnItems(inupackage_id in mo_packages.package_id%type,
                             inuraiseError in number default 1)
    Return constants.tyrefcursor;
  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : frfGetArticleApprovedAnulDev
  Descripcion    :

  Autor          : Evelio Sanjuanelo
  Fecha          : 14/07/2013

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha           Autor                           Modificacion
  =========       =====================           ====================
  14/07/2013      Evelio Sanjuanelo               Creacion
  ******************************************************************/
 FUNCTION frfGetArticleApprovedAnulDev(
    InuPackageType          LD_RETURN_ITEM.TRANSACTION_TYPE%type, --Tipo de Solicitud 'A','D'
    InuTypeIden             GE_SUBSCRIBER.IDENT_TYPE_ID%type,     --Tipo de Identificación
    InuIdentification       GE_SUBSCRIBER.IDENTIFICATION%type,    --Identificación
    InuSubscription_id      SUSCRIPC.SUSCCODI%type,               --Contrato
    InuPackageAnulDev       LD_RETURN_ITEM.PACKAGE_ID%type,       --Solicitud de Devolución
    InuInitialDate          LD_RETURN_ITEM.REGISTER_DATE%type,    --Fecha inicial
    InuFinalDate            LD_RETURN_ITEM.Register_Date%type     --Fecha Final
                                       )
    Return constants.tyrefcursor;

	/**********************************************************************
	Propiedad intelectual de OPEN International Systems
	Nombre              fsbGetPostLegProcBySupplierId

	Autor				Andrés Felipe Esguerra Restrepo

	Fecha               30/07/2013

	Descripción         Obtiene el flag Post_Leg_process a partir del ID del
						proveedor

	***Parametros***
	Nombre				Descripción
	inuSupplierId		Identificador del proveedor

	***Historia de Modificaciones***
	Fecha Modificación				Autor
	.								.
	***********************************************************************/

    FUNCTION fsbGetPostLegProcBySupplierId(
  		inuSupplierId ld_suppli_settings.supplier_id%type)
	RETURN ld_suppli_settings.post_leg_process%type;

    PROCEDURE GetInfoAnnulDev
    (
        inuRequestId        in  ld_return_item.package_id%type,
        onuPackageSale      out ld_return_item.package_sale%type,
        onuReturnId         out ld_return_item.return_item_id%type,
        onuOriginAnnulDev   out ld_return_item.origin_anu_dev%type,
        osbPaytoSeller      out ld_return_item.payment_to_seller%type,
        osbMoveToUser       out ld_return_item.mov_user_portf%type
    );

    /**********************************************************************
    	Propiedad intelectual de OPEN International Systems
    	Nombre              frfGetOrdersToLegalize

    	Autor				Andrés Felipe Esguerra Restrepo

    	Fecha               19-oct-2013

    	Descripción         Obtiene las órdenes de entrega asociadas a una
							solicitud y un artículo, y la cantidad de
							actividades que falta para poder legalizar la orden

    	***Parametros***
    	Nombre				Descripción
    	inuPackage			ID de la solicitud
    	inuArticleId        ID del artículo

    ***********************************************************************/
    FUNCTION frfGetOrdersToLegalize(inuPackage in mo_packages.package_id%type,
	                          inuArticleId   in ld_article.article_id%type)

	RETURN constants.tyrefcursor;

    FUNCTION frfGetSaleOrderToLeg(inuPackage in mo_packages.package_id%type,
	                          inuArticleId   in ld_article.article_id%type)

	RETURN constants.tyrefcursor;

    /**************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad      :  fnuNonCanclledArticles
    Descripcion :  Retorna número de articulos anulados por solicitud de
                   anulación.

    Autor       :  Santiago Gómez Rico
    Fecha       :  05-11-2013
    Parametros  :  inuPackage       Solicitud de anulación.
                   inuActivity      Actividad de venta.
                   isbStatus        Estado anulado.

    Historia de Modificaciones
    Fecha        Autor              Modificacion
    =========    =========          ====================
    05-11-2013   sgomez.SAO222244   Creación.
    ***************************************************************/
    FUNCTION fnuNonCanclledArticles
    (
        inuPackage  in  ld_return_item.package_id%type,
        inuActivity in  or_order_activity.activity_id%type,
        isbStatus   in  ld_item_work_order.state%type
    )
        return number;

    /**************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad      :  fboWorkFlowStandBy
    Descripcion :  Evalúa si un flujo se encuentra detenido, por tipo de unidad.

    Autor       :  Santiago Gómez Rico
    Fecha       :  05-11-2013
    Parametros  :  inuPackage       Solicitud de anulación.
                   inuUnitType      Tipo de unidad.
                   isbStatus        Estado.

    Historia de Modificaciones
    Fecha        Autor              Modificacion
    =========    =========          ====================
    05-11-2013   sgomez.SAO222244   Creación.
    ***************************************************************/
    FUNCTION fboWorkFlowStandBy
    (
        inuPackage  in  mo_packages.package_id%type,
        inuUnitType in  wf_unit_type.unit_type_id%type,
        isbStatus   in  wf_instance.status_id%type
    )
        return boolean;

    /**************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad      :  frfCancelledArticles
    Descripcion :  Retorna información de articulos anulados por solicitud de
                   devolución.

    Autor       :  Santiago Gómez Rico
    Fecha       :  14-11-2013
    Parametros  :  inuPackage           Solicitud de devolución.
                   inuSalesActvty       Actividad de venta.
                   inuCanclActvty       Actividad de aplicación de anulación.
                   isbStatus            Estado anulado.

    Historia de Modificaciones
    Fecha        Autor              Modificacion
    =========    =========          ====================
    14-11-2013   sgomez.SAO222901   Creación.
    ***************************************************************/
    FUNCTION frfCancelledArticles
    (
        inuPackage      in  ld_return_item.package_id%type,
        inuSalesActvty  in  or_order_activity.activity_id%type,
        inuCanclActvty  in  or_order_activity.activity_id%type,
        isbStatus       in  ld_item_work_order.state%type
    )
        return pkConstante.tyRefCursor;

    /**************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad      :  fnuCancArticlesTotVal
    Descripcion :  Retorna valor total (incluye IVA) de articulos anulados por
                   solicitud de devolución.

    Autor       :  Santiago Gómez Rico
    Fecha       :  15-11-2013
    Parametros  :  inuPackage           Solicitud de devolución.
                   inuSalesActvty       Actividad de venta.
                   inuCanclActvty       Actividad de aplicación de anulación.
                   isbStatus            Estado anulado.

    Historia de Modificaciones
    Fecha        Autor              Modificacion
    =========    =========          ====================
    15-11-2013   sgomez.SAO222901    Creación.
    ***************************************************************/

    FUNCTION fnuCancArticlesTotVal
    (
        inuPackage      in  ld_return_item.package_id%type,
        inuSalesActvty  in  or_order_activity.activity_id%type,
        inuCanclActvty  in  or_order_activity.activity_id%type,
        isbStatus       in  ld_item_work_order.state%type
    )
        return number;

    /**************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad      :  fnuNonDeliveredArticles
    Descripcion :  Retorna número de articulos de la venta que NO han sido entregados.

    Autor       :  Jorge Alejandro Carmona Duque
    Fecha       :  19-11-2013
    Parametros  :  inuPackage       Solicitud de Venta.
                   inuActivity      Actividad de Entrega.
                   isbStatus        Estado Finalizado.

    Historia de Modificaciones
    Fecha        Autor                  Modificacion
    =========    =========              ====================
    19-11-2013   JCarmona.SAO223750     Creación.
    ***************************************************************/

    FUNCTION fnuNonDeliveredArticles
    (
        inuPackage  in  ld_return_item.package_id%type,
        inuActivity in  or_order_activity.activity_id%type,
        isbStatus   in  ld_item_work_order.state%type
    )
    return number;

    /**************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad      :  fnuIsQuotaTransferAuto
    Descripcion :  Valida si el traslado de cupo se realizó de forma automática.

    Autor       :  Jorge Alejandro Carmona Duque
    Fecha       :  22-11-2013
    Parametros  :  inuPackage       Solicitud de Venta.

    Retorna     :  1 - Si el traslado de cupo fue automático.
                   0 - Si se generarón órdenes de traslado de cupo.

    Historia de Modificaciones
    Fecha        Autor                  Modificacion
    =========    =========              ====================
    22-11-2013   JCarmona.SAO224114     Creación.
    ***************************************************************/

    FUNCTION fnuIsQuotaTransferAuto
    (
        inuPackage  in  ld_return_item.package_id%type
    )
    return number;

     /**************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad      :  fsbWorkFlowStandBy
    Descripcion :  Evalúa si un flujo se encuentra detenido, por tipo de unidad.

    Autor       :  Erika Alejandra Montenegro Gaviria
    Fecha       :  19-12-2013
    Parametros  :  inuPackage       Solicitud de anulación.
                   inuUnitType      Tipo de unidad.
                   isbStatus        Estado.

    Historia de Modificaciones
    Fecha        Autor                  Modificacion
    =========    =========              ====================
    19-12-2013   emontenegro.SAO228434   Creación.
    ***************************************************************/
    FUNCTION fsbWorkFlowStandBy
    (
        inuPackage  in  mo_packages.package_id%type,
        inuUnitType in  wf_unit_type.unit_type_id%type,
        isbStatus   in  wf_instance.status_id%type
    )
        return varchar2;

end LD_BCCANCELLATIONS;
/
CREATE OR REPLACE package body ADM_PERSON.LD_BCCANCELLATIONS IS

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : Ld_BcCancellations
    Descripcion    : Realizar las consultas necesarias para el proceso
                     de anulacion/cancelacion
    Autor          : Jonathan Alberto Consuegra Lara
    Fecha          : 03/04/2013

    Historia de Modificaciones
    Fecha             Autor                 Modificacion
    =========         =========             ====================
    25-11-2013        hjgomez.SAO224553     Se modifica <<fnuNonCanclledArticles>>
    14-11-2013        sgomez.SAO222901      Se adiciona método
                                            <frfCancelledArticles> para
                                            obtención de información de
                                            articulos anulados en una solicitud
                                            de devolución.
                                            Se adiciona método
                                            <fnuCancArticlesTotVal> para
                                            obtención de valor total de
                                            artículos anulados en una
                                            devolución.
                                            Se adiciona tipo <tyrcArticle>.

    05-11-2013        sgomez.SAO222244      Se adiciona método
                                            <fnuNonCanclledArticles>
                                            para conteo de artículos anulados
                                            en una solicitud de anulación.

    03/04/2013        jconsuegra.SAO156577  Creacion
  ******************************************************************/

  -----------------------
  -- Constants
  -----------------------
  -- Constante con el SAO de la ultima version aplicada
  csbVERSION CONSTANT VARCHAR2(10) := 'SAO224553';

  csbDelActType constant ld_parameter.parameter_id%type := 'ACT_TYPE_DEL_FNB';

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : fsbVersion
    Descripcion    : Retorna el SAO con que se realizo la ultima
                     entrega
    Autor          : jonathan alberto consuegra lara
    Fecha          : 03/04/2013

    Parametros       Descripcion
    ============     ===================

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    03/04/2013       jconsuegra.SAO139854  Creacion
  ******************************************************************/

  FUNCTION fsbVersion RETURN varchar2 IS
  BEGIN

    ut_trace.trace('Inicio Ld_BcCancellations.fsbVersion', 10);

    pkErrors.Push('Ld_BcCancellations.fsbVersion');
    pkErrors.Pop;

    ut_trace.trace('Fin Ld_BcCancellations.fsbVersion', 10);

    -- Retorna el SAO con que se realizo la ultima entrega
    RETURN(csbVersion);

  Exception
    When ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    When others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END fsbVersion;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : Fnugetsaleorder
    Descripcion    : Retorna la orden de venta de una solicitud
                     de venta
    Autor          : jonathan alberto consuegra lara
    Fecha          : 03/04/2013

    Parametros       Descripcion
    ============     ===================

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    03/04/2013       jconsuegra.SAO139854  Creacion
  ******************************************************************/
  Function Fnugetsaleorder(inuPackage    in mo_packages.package_id%type,
                           inuRaiseError in number default 1)
    return or_order.order_id%type is
    --variable de orden de venta
    nuorder or_order.order_id%type;
    --cursor que identifica la orden de venta
    cursor cuotsale is
      SELECT distinct order_id
        FROM or_order_activity d
       WHERE d.package_id IS NOT NULL
         AND d.package_id = inuPackage
         AND d.activity_id =
             (dald_parameter.fnuGetNumeric_Value('ACTIVITY_TYPE_FNB'));
  Begin

    ut_trace.trace('Inicio Ld_BcCancellations.Fnugetsaleorder', 10);

    -- Busco ot de entrega
    OPEN cuotsale;
    FETCH cuotsale
      INTO nuorder;
    IF cuotsale%NOTFOUND THEN
      CLOSE cuotsale;
      nuorder := 0;
    END IF;
    CLOSE cuotsale;

    ut_trace.trace('Fin Ld_BcCancellations.Fnugetsaleorder', 10);

    Return(nuorder);

  Exception
    When ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    When others then
      if inuRaiseError = 1 then
        Errors.setError;
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  End Fnugetsaleorder;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : Fnugetsaleorder
    Descripcion    : Retorna la orden de venta de una solicitud
                     de venta
    Autor          : jonathan alberto consuegra lara
    Fecha          : 03/04/2013

    Parametros       Descripcion
    ============     ===================
    inupackage_id    identificador de la solicitud de anulacion o
                     devolucion

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    03/04/2013       jconsuegra.SAO139854  Creacion
  ******************************************************************/
  Function fnugetretur_item_id_by_sale(inupackage_id in mo_packages.package_id%type,
                                       inuRaiseError in number default 1)
    return Ld_Return_Item.Return_Item_Id%type is

    nuRetur_item_id Ld_Return_Item.Return_Item_Id%type;

  Begin

    ut_trace.trace('Inicio Ld_BcCancellations.fnugetretur_item_id_by_sale',
                   10);

    SELECT l.return_item_id
      INTO nuRetur_item_id
      FROM ld_return_item l
     WHERE l.package_id = inupackage_id;

    ut_trace.trace('Fin Ld_BcCancellations.fnugetretur_item_id_by_sale',
                   10);

    Return(nuRetur_item_id);

  Exception
    When ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    When others then
      if inuRaiseError = 1 then
        Errors.setError;
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  End fnugetretur_item_id_by_sale;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : fnuGetOperUnitByPackSale
    Descripcion    : Retorna la unidad operativa de una solicitud
                     de anulacion
    Autor          : Alex Valencia Ayola
    Fecha          : 05/04/2013

    Parametros       Descripcion
    ============     ===================

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    05/04/2013       aValencia.SAO139854  Creacion
  ******************************************************************/
  FUNCTION fnuGetOperUnitByPackSale(inuPackage    IN mo_packages.package_id%TYPE,
                                    inuRaiseError IN NUMBER DEFAULT 1)
    RETURN or_order.operating_unit_id%TYPE IS

    nuOperatUnit or_order.operating_unit_id%TYPE;

  BEGIN

    ut_trace.trace('Inicio Ld_BcCancellations.fnuGetOperUnitByPackSale',
                   10);

    SELECT DISTINCT daor_order.fnuGetOperating_Unit_Id(d.order_id, 0) retVal
      INTO nuOperatUnit
      FROM or_order_activity d
     WHERE d.activity_id =
           dald_parameter.fnuGetNumeric_Value('ACTIVITY_TYPE_FNB', 0)
       AND d.task_type_id =
           dald_Parameter.fnuGetNumeric_Value('COD_FNB_SALE_TASK_TYPE', 0)
       AND d.package_id IN
           (SELECT l.package_sale
              FROM ld_return_item l
             WHERE l.package_id = inuPackage
               AND l.package_id = d.package_id);

    ut_trace.trace('Fin Ld_BcCancellations.fnuGetOperUnitByPackSale', 10);

    RETURN nuOperatUnit;

  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      IF inuRaiseError = 1 THEN
        Errors.setError;
        RAISE ex.CONTROLLED_ERROR;
      ELSE
        RETURN NULL;
      END IF;
  END fnuGetOperUnitByPackSale;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : Fnugetitemworder
    Descripcion    : Retorna el consecutivo del item_work_order_id
                       teniendo una ot de entrega.
    Autor          : Kbaquero
    Fecha          : 08/04/2013

    Parametros       Descripcion
    ============     ===================

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    08/04/2013       KBaquero.SAO139854  Creacion
  ******************************************************************/
  Function Fnugetitemworder(inuorder      in or_order.order_id%type,
                            inuRaiseError in number default 1)
    return ld_item_work_order.item_work_order_id%type IS

    nuitemor_id ld_item_work_order.item_work_order_id%type;

  Begin

    ut_trace.trace('Inicio Ld_BcCancellations.Fnugetitemworder', 10);

    SELECT l.item_work_order_id
      INTO nuitemor_id
      FROM ld_item_work_order l
     WHERE l.order_id = inuorder;

    ut_trace.trace('Fin Ld_BcCancellations.Fnugetitemworder', 10);

    RETURN(nuitemor_id);

  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      IF inuRaiseError = 1 THEN
        Errors.setError;
        RAISE ex.CONTROLLED_ERROR;
      ELSE
        RETURN NULL;
      END IF;
  END Fnugetitemworder;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : Fnugetdetail_item
    Descripcion    : Retorna el consecutivo del detalle del articulo
                     teniendo en cuenta el consecutivo de la entidad ld_return_item.
    Autor          : Kbaquero
    Fecha          : 09/04/2013

    Parametros       Descripcion
    ============     ===================

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    09/04/2013       KBaquero.SAO139854  Creacion
  ******************************************************************/
  Function Fnugetdetail_item(inureturitem  in ld_return_item.return_item_id%type,
                             inuRaiseError in number default 1)
    return ld_return_item_detail.return_item_detail_id%type IS

    nureturDetail_id ld_return_item_detail.return_item_detail_id %type;

  Begin

    ut_trace.trace('Inicio Ld_BcCancellations.Fnugetdetail_item', 10);

    SELECT l.return_item_detail_id
      INTO nureturDetail_id
      FROM ld_return_item_detail l
     WHERE l.return_item_id = inureturitem;

    ut_trace.trace('Fin Ld_BcCancellations.Fnugetdetail_item', 10);

    RETURN(nureturDetail_id);

  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      IF inuRaiseError = 1 THEN
        Errors.setError;
        RAISE ex.CONTROLLED_ERROR;
      ELSE
        RETURN NULL;
      END IF;
  END Fnugetdetail_item;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ProcSearchReturnItem
  Descripcion    : Busca la informacion de los articulos de anulacion

  Autor          : kBaquero
  Fecha          : 10/04/2013 SAO 139854

  Parametros         Descripcion
  ============   ===================
  inuGas_Service:   Parametro del numero de servicio
  inuState:         Parametro del estado de la poliza
  otbAccountcharge: Objeto tipo tabla con los suscritores

  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/

  PROCEDURE ProcSearchReturnItemDetail(inuretItemDetail_id in ld_return_item_detail.return_item_detail_id%type,
                                       inuState            in ld_parameter.value_chain%type,
                                       otbAccountcharge    out pktblservsusc.tySesunuse) IS

    orfAccountcharge pkConstante.tyRefCursor;

  BEGIN

    ut_trace.Trace('INICIO Ld_BcCancellations.ProcSearchReturnItemDetail',
                   10);

    /*OPEN orfAccountcharge FOR
        SELECT /*+ INDEX (P IDX_LD_POLICY_09) USE_NL(s su) USE_NL(s p) USE_NL(su p)
         sesunuse, susccodi
          FROM servsusc s, suscripc su, ld_policy p
         WHERE s.sesuserv = inuGas_Service
           AND p.state_policy IN (inuState)
           AND s.sesususc = su.susccodi
           AND s.sesunuse = p.product_id
           AND s.sesususc = p.suscription_id;

      FETCH orfAccountcharge BULK COLLECT
        INTO otbAccountcharge;
      CLOSE orfAccountcharge;
    */
    ut_trace.Trace('FIN Ld_BcCancellations.ProcSearchReturnItemDetail', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;

  END ProcSearchReturnItemDetail;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

    Unidad :      GetArticleBy_An_Dev
    Descripcion : Retorna los articulos asociados a una solicitud de anulación
                  /devolución

    Autor : AAcuna
    Fecha : 16/04/2013

    Parametros      Descripcion
    ============   ===================
    inuPackage      Numero de la solicitud de anulación/devolución

    Historia de Modificaciones
    Fecha Autor Modificacion
    ========= ========= ====================

  ******************************************************************/

  FUNCTION GetArticleBy_An_Dev(inuPackage in mo_packages.package_id%type)

   RETURN dald_return_item_detail.tytbArticle_Id

   IS

    rfArticle constants.tyrefcursor;
    tbArticle dald_return_item_detail.tytbArticle_Id;

  BEGIN

    ut_trace.trace('Inicio Ld_BcCancellation.GetArticleBy_An_Dev', 10);

    OPEN rfArticle FOR
      select lr.article_id
        from ld_return_item l, ld_return_item_detail lr
       where lr.return_item_id = l.return_item_id
         and l.package_id = inuPackage
       group by article_id;

    FETCH rfArticle BULK COLLECT
      INTO tbArticle;
    CLOSE rfArticle;

    ut_trace.trace('Fin Ld_BcCancellation.GetArticleBy_An_Dev', 10);

    RETURN tbArticle;

  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      Errors.setError;
      RAISE ex.CONTROLLED_ERROR;
  END GetArticleBy_An_Dev;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

    Unidad : GetArticleByPackSa
    Descripcion : Retorna el detalle de los articulos
                  asociados a una solicitud de venta

    Autor : AAcuna
    Fecha : 16/04/2013

    Parametros      Descripcion
    ============   ===================
    inuPackage      Numero de la solicitud de venta
    inuOrder        Numero de la orden de entrega

    Historia de Modificaciones
    Fecha Autor Modificacion
    ========= ========= ====================

  ******************************************************************/

  FUNCTION GetArticleByPackSa(inuPackage in mo_packages.package_id%type,
                              inuOrder   in ld_item_work_order.order_id%type)

   RETURN constants.tyrefcursor

   IS

    rfArticle constants.tyrefcursor;

  BEGIN

    ut_trace.trace('Inicio Ld_BcCancellation.GetArticleByPackSa', 10);

    OPEN rfArticle FOR
      SELECT l.item_work_order_id,
             l.article_id,
             l.ORDER_ACTIVITY_ID,
             l.AMOUNT,
             l.VALUE,
             l.IVA,
             l.CREDIT_FEES,
             l.INSTALL_REQUIRED,
             l.SUPPLIER_ID,
             l.ORDER_ID,
             l.DIFECODI,
             l.state
        FROM or_order_activity o, ld_item_work_order l
       WHERE o.package_id = inuPackage
         AND o.activity_id =
             Dald_Parameter.fnuGetNumeric_Value('ACT_TYPE_DEL_FNB')
         AND o.task_type_id =
             Dald_Parameter.fnuGetNumeric_Value('CODI_TITR_EFNB')
         AND l.order_id = o.order_id
         AND l.order_activity_id = o.order_activity_id
         AND l.order_id = inuOrder;

    ut_trace.trace('Fin Ld_BcCancellation.GetArticleByPackSa', 10);

    RETURN rfArticle;

  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      Errors.setError;
      RAISE ex.CONTROLLED_ERROR;
  END GetArticleByPackSa;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : FnuGetLastCuencobr
    Descripción    : Obtiene la última cuenta de cobro de un diferido

    Autor          : Jonathan Alberto Consuegra
    Fecha          : 18/04/2013

    Parámetros       Descripción
    ============     ===================
    inudifecodi      Identificador del diferido
    inuRaiseError    Controlador de error

    Historia de Modificaciones
    Fecha            Autor                Modificación
    =========       =========             ====================
    19/04/2013      Jconsuegra.SAO139854  Creación
  ******************************************************************/
  FUNCTION FnuGetLastCuencobr(inudifecodi   in diferido.difecodi%type,
                              inuRaiseError in number default 1)
    return cargos.cargcuco%type is

    nucuencobr cargos.cargcuco%type;

  BEGIN

    ut_trace.trace('Inicio LD_bcflowFNBPack.FnuGetLastCuencobr', 10);

    SELECT cargcuco
      INTO nucuencobr
      FROM (SELECT c.cargcuco
              FROM cargos c
             WHERE REGEXP_INSTR(c.cargdoso,
                                '(\W|^)' || inudifecodi || '(\W|$)') > 0
             ORDER BY c.cargfecr DESC)
     WHERE rownum = ld_boconstans.cnuonenumber;

    return nucuencobr;

    ut_trace.trace('Fin LD_bcflowFNBPack.FnuGetLastCuencobr', 10);

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
  END FnuGetLastCuencobr;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : frfGetreturnItems
  Descripcion    : Funcion que a partir de una solicitud de venta,
                   obtiene los items, que le van a realizar la devolución.

  Autor          : KBaquero
  Fecha          : 23/05/2013

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  23/05/2013      KBaquero             Creacion
  ******************************************************************/
  FUNCTION frfGetreturnItems(inupackage_id in mo_packages.package_id%type,
                             inuraiseError in number default 1)
    Return constants.tyrefcursor IS

    /*Declaracion de variables*/
    nuParTaskTypeDeliv ld_parameter.numeric_value%type;

    rfCursor           constants.tyrefcursor;

  BEGIN

    ut_trace.trace('Inicia Ld_BcCancellations.frfGetreturnItems');

    /*Obtener el parametro con el tipo de trabajo de Entrega*/
    nuParTaskTypeDeliv := Dald_Parameter.fnuGetNumeric_Value('CODI_TITR_EFNB');

    Open rfCursor for
        select d.activity_delivery_id,  d.order_id, d.return_item_id, d.return_item_detail_id, D.article_id
            from ld_return_item l, ld_return_item_detail d
        where l.return_item_id=d.return_item_id
            and l.package_id=  inupackage_id;

    ut_trace.trace('Finaliza Ld_BcCancellations.frfGetreturnItems');

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

  Unidad         : frfGetArticleApprovedAnulDev
  Descripcion    :

  Autor          : Evelio Sanjuanelo
  Fecha          : 14/07/2013

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha           Autor                           Modificacion
  =========       =====================           ====================
  14/07/2013      Evelio Sanjuanelo               Creacion
  ******************************************************************/
 FUNCTION frfGetArticleApprovedAnulDev(
    InuPackageType          LD_RETURN_ITEM.TRANSACTION_TYPE%type, --Tipo de Solicitud 'A','D'
    InuTypeIden             GE_SUBSCRIBER.IDENT_TYPE_ID%type,     --Tipo de Identificación
    InuIdentification       GE_SUBSCRIBER.IDENTIFICATION%type,    --Identificación
    InuSubscription_id      SUSCRIPC.SUSCCODI%type,               --Contrato
    InuPackageAnulDev       LD_RETURN_ITEM.PACKAGE_ID%type,       --Solicitud de Devolución
    InuInitialDate          LD_RETURN_ITEM.REGISTER_DATE%type,    --Fecha inicial
    InuFinalDate            LD_RETURN_ITEM.Register_Date%type    --Fecha Final
                                       )
    Return constants.tyrefcursor IS
    sbSqlQuery VARCHAR2(32000);
    sbWhere    VARCHAR2(32000);
    curfData   constants.tyrefcursor;

  BEGIN
    --Fecha minima de anulación
    IF InuInitialDate IS NOT NULL THEN
      sbWhere := sbWhere || ' AND trunc(damo_packages.fdtgetrequest_date(r.package_id)) >= ''' ||
                 substr(InuInitialDate, 1, 10) || '''';
    END IF;

    --Fecha maxima de anulación
    IF InuFinalDate IS NOT NULL THEN
      sbWhere := sbWhere || ' AND trunc(damo_packages.fdtgetrequest_date(r.package_id)) <= ''' ||
                 substr(InuFinalDate, 1, 10) || '''';
    ELSE
      sbWhere := sbWhere || ' AND trunc(damo_packages.fdtgetrequest_date(r.package_id)) <= ''' ||
                 to_char(trunc(sysdate), 'dd-mm-yyyy') || '''';
    END IF;

    --Solicitud de anulación
    IF (InuPackageAnulDev IS NOT NULL) THEN
      sbWhere := sbWhere || ' AND l.package_id = ' || InuPackageAnulDev;
    END IF;

    --Tipo identificación - Identificación
    IF (InuTypeIden IS NOT NULL AND InuIdentification IS NOT NULL) THEN
      sbWhere := sbWhere ||
                 ' AND dage_subscriber.fsbGetIdentification( pktblsuscripc.fnuGetSuscclie(damo_packages.fnugetsubscription_pend_id(r.package_sale)) )=''' ||
                 InuTypeIden || '''';
      sbWhere := sbWhere ||
                 ' AND dage_subscriber.fnuGetIdent_Type_Id( pktblsuscripc.fnuGetSuscclie(damo_packages.fnugetsubscription_pend_id(r.package_sale)) )=' ||
                 InuTypeIden;
    END IF;

    --Contrato
    IF (InuSubscription_id IS NOT NULL) THEN
      sbWhere := sbWhere || ' AND damo_packages.fnugetsubscription_pend_id(r.package_sale) = ' || InuSubscription_id;
    END IF;

    sbSqlQuery:= '1';--FALTA ANEXAR LA CONSULTA EVESAN

    dbms_output.put_line(sbSqlQuery);

    OPEN curfData FOR sbSqlQuery;
    Return curfData;
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END frfGetArticleApprovedAnulDev;

	FUNCTION fsbGetPostLegProcBySupplierId(
  		inuSupplierId ld_suppli_settings.supplier_id%type)
	RETURN ld_suppli_settings.post_leg_process%type IS

	sbPostLegProcess ld_suppli_settings.post_leg_process%type;

	CURSOR cuPostLegProcessBySupplierId(nuSupplierId ld_suppli_settings.supplier_id%type) IS
		SELECT a.post_leg_process
		FROM ld_suppli_settings a
		WHERE a.supplier_id = nuSupplierId;
	BEGIN
		FOR rx IN cuPostLegProcessBySupplierId(inuSupplierId) LOOP
			sbPostLegProcess := rx.post_leg_process;
		END LOOP;

		RETURN sbPostLegProcess;

	END fsbGetPostLegProcBySupplierId;

    PROCEDURE GetInfoAnnulDev
    (
        inuRequestId        in  ld_return_item.package_id%type,
        onuPackageSale      out ld_return_item.package_sale%type,
        onuReturnId         out ld_return_item.return_item_id%type,
        onuOriginAnnulDev   out ld_return_item.origin_anu_dev%type,
        osbPaytoSeller      out ld_return_item.payment_to_seller%type,
        osbMoveToUser       out ld_return_item.mov_user_portf%type
    )
    IS

        CURSOR cuOriginAnnulDev
        IS
            SELECT  return_item_id, origin_anu_dev, payment_to_seller, mov_user_portf, package_sale
            FROM    LD_RETURN_ITEM
            WHERE   package_id = inuRequestId;

    BEGIN
        ut_trace.trace('Inicia Ld_BcCancellations.GetInfoAnnulDev', 5);

        -- Valida el estado del CURSOR
        if ( cuOriginAnnulDev%isopen )
        then
            -- Cierra CURSOR
            close cuOriginAnnulDev;
        END if;

        open cuOriginAnnulDev;
        fetch cuOriginAnnulDev INTO onuReturnId, onuOriginAnnulDev, osbPaytoSeller, osbMoveToUser, onuPackageSale;
        close cuOriginAnnulDev;

        ut_trace.trace('Finaliza Ld_BcCancellations.GetInfoAnnulDev', 5);

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END GetInfoAnnulDev;

	FUNCTION frfGetOrdersToLegalize(inuPackage in mo_packages.package_id%type,
	                          inuArticleId   in ld_article.article_id%type)

	RETURN constants.tyrefcursor

	IS

		rfOrdersToLegalize constants.tyrefcursor;

		cnuDelActType constant ld_parameter.numeric_value%type := dald_parameter.fnuGetNumeric_Value(csbDelActType);

	BEGIN

	ut_trace.trace('Inicio Ld_BcCancellation.frfGetOrdersToLegalize', 10);

	OPEN rfOrdersToLegalize FOR
		SELECT o.order_id,(
			select count(1)
			FROM OR_order_activity a
			WHERE a.order_id = o.order_id
			AND a.status != 'F') cant
		FROM OR_order o
		WHERE o.order_status_id not in (or_boconstants.cnuORDER_STAT_CLOSED,
										or_boconstants.cnuORDER_STAT_CANCELED)
		AND o.order_id in (
			SELECT oa.order_id
			FROM ld_item_work_order i, OR_order_activity oa
			WHERE oa.order_activity_id = i.order_activity_id
			AND oa.activity_id = cnuDelActType
			AND i.article_id = inuArticleId
			AND oa.package_id = inuPackage
		);

	ut_trace.trace('Fin Ld_BcCancellation.frfGetOrdersToLegalize', 10);

	RETURN rfOrdersToLegalize;

	EXCEPTION
	WHEN ex.CONTROLLED_ERROR THEN
	  RAISE ex.CONTROLLED_ERROR;
	WHEN OTHERS THEN
	  Errors.setError;
	  RAISE ex.CONTROLLED_ERROR;
	END frfGetOrdersToLegalize;


    FUNCTION frfGetSaleOrderToLeg(inuPackage in mo_packages.package_id%type,
	                          inuArticleId   in ld_article.article_id%type)

	RETURN constants.tyrefcursor

	IS

		rfOrdersToLegalize constants.tyrefcursor;
        cnuActivityTypeFNB     constant ld_parameter.parameter_id%type := Dald_parameter.fnuGetNumeric_Value('ACTIVITY_TYPE_FNB');


	BEGIN

	ut_trace.trace('Inicio Ld_BcCancellation.frfGetSaleOrderToLeg', 10);

	OPEN rfOrdersToLegalize FOR
		SELECT o.order_id,(
			select count(1)
			FROM OR_order_activity a
			WHERE a.order_id = o.order_id
			AND a.status != 'F') cant
		FROM OR_order o
		WHERE o.order_status_id not in (or_boconstants.cnuORDER_STAT_CLOSED,
										or_boconstants.cnuORDER_STAT_CANCELED)
		AND o.order_id in (
			SELECT oa.order_id
			FROM ld_item_work_order i, OR_order_activity oa
			WHERE oa.order_activity_id = i.order_activity_id
			AND oa.activity_id = cnuActivityTypeFNB
			AND i.article_id = inuArticleId
			AND oa.package_id = inuPackage
		);

	ut_trace.trace('Fin Ld_BcCancellation.frfGetSaleOrderToLeg', 10);

	RETURN rfOrdersToLegalize;

	EXCEPTION
	WHEN ex.CONTROLLED_ERROR THEN
	  RAISE ex.CONTROLLED_ERROR;
	WHEN OTHERS THEN
	  Errors.setError;
	  RAISE ex.CONTROLLED_ERROR;
	END frfGetSaleOrderToLeg;

    /**************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad      :  fnuNonCanclledArticles
    Descripcion :  Retorna número de articulos anulados por solicitud de
                   anulación o devolución.

    Autor       :  Santiago Gómez Rico
    Fecha       :  05-11-2013
    Parametros  :  inuPackage       Solicitud de anulación.
                   inuActivity      Actividad de venta.
                   isbStatus        Estado anulado.

    Historia de Modificaciones
    Fecha        Autor              Modificacion
    =========    =========          ====================
    25-11-2013   hjgomez.SAO224553   Se corrigen errores
    05-11-2013   sgomez.SAO222244    Creación.
    ***************************************************************/

    FUNCTION fnuNonCanclledArticles
    (
        inuPackage  in  ld_return_item.package_id%type,
        inuActivity in  or_order_activity.activity_id%type,
        isbStatus   in  ld_item_work_order.state%type
    )
        return number
    IS
        ------------------------------------------------------------------------
        -- Cursores
        ------------------------------------------------------------------------

        CURSOR cuCount
        (
            inuPackage  in  ld_return_item.package_id%type,
            inuActivity in  or_order_activity.activity_id%type,
            isbStatus   in  ld_item_work_order.state%type
        )
        IS
            SELECT  /*+
                        ordered
                        use_nl(ld_return_item or_order_activity ld_item_work_order)
                        index_rs_asc(ld_return_item IDX_LD_RETURN_ITEM01)
                        index_rs_asc(or_order_activity IDX_OR_ORDER_ACTIVITY_06)
                        index_rs_asc(ld_item_work_order IX_LD_ITEM_WORK_ORDER01)
                    */
                    count(1)
            FROM    ld_return_item,
                    or_order_activity,
                    ld_item_work_order /*+ Ld_BcCancellations.fnuNonCanclledArticles */
            WHERE   ld_return_item.package_id = inuPackage
            AND     ld_return_item.package_sale = or_order_activity.package_id
            AND     or_order_activity.activity_id = inuActivity
            AND     or_order_activity.order_activity_id = ld_item_work_order.order_activity_id
            AND     ld_item_work_order.state <> isbStatus;

        ------------------------------------------------------------------------
        -- Variables
        ------------------------------------------------------------------------

        /* Número de articulos */
        nuCount number;

    BEGIN

        UT_Trace.Trace('Inicio Ld_BcCancellations.fnuNonCanclledArticles', 1);

        if(cuCount%isopen) then
            close cuCount;
        end if;

        open  cuCount(inuPackage, inuActivity, isbStatus);
        fetch cuCount into nuCount;
        close cuCount;

        UT_Trace.Trace('Fin Ld_BcCancellations.fnuNonCanclledArticles ['||nuCount||']', 1);

        return nuCount;

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            if(cuCount%isopen) then
                close cuCount;
            end if;
            raise ex.CONTROLLED_ERROR;
        when OTHERS then
            if(cuCount%isopen) then
                close cuCount;
            end if;
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END fnuNonCanclledArticles;

    /**************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad      :  fboWorkFlowStandBy
    Descripcion :  Evalúa si un flujo se encuentra detenido, por tipo de unidad.

    Autor       :  Santiago Gómez Rico
    Fecha       :  05-11-2013
    Parametros  :  inuPackage       Solicitud de anulación.
                   inuUnitType      Tipo de unidad.
                   isbStatus        Estado.

    Historia de Modificaciones
    Fecha        Autor              Modificacion
    =========    =========          ====================
    05-11-2013   sgomez.SAO222244   Creación.
    ***************************************************************/

    FUNCTION fboWorkFlowStandBy
    (
        inuPackage  in  mo_packages.package_id%type,
        inuUnitType in  wf_unit_type.unit_type_id%type,
        isbStatus   in  wf_instance.status_id%type
    )
        return boolean
    IS
        ------------------------------------------------------------------------
        -- Cursores
        ------------------------------------------------------------------------

        CURSOR cuCount
        (
            isbPackage  in  wf_instance.external_id%type,
            inuUnitType in  wf_unit_type.unit_type_id%type,
            isbStatus   in  wf_instance.status_id%type
        )
        IS
            SELECT  --+ index_rs_asc(wf_instance IDX_WF_INSTANCE_08)
                    count(1)
            FROM    wf_instance /*+ Ld_BcCancellations.fboWorkFlowStandBy */
            WHERE   wf_instance.external_id  = isbPackage
            AND     wf_instance.unit_type_id = inuUnitType
            AND     wf_instance.status_id    = isbStatus;

        ------------------------------------------------------------------------
        -- Variables
        ------------------------------------------------------------------------

        /* Número registros */
        nuCount     number;
        /* Flag de existencia */
        boExists    boolean;

    BEGIN

        UT_Trace.Trace('Inicio Ld_BcCancellations.fboWorkFlowStandBy ['||nuCount||']', 1);

        nuCount  := 0;
        boExists := FALSE;

        if(cuCount%isopen) then
            close cuCount;
        end if;

        open  cuCount(to_char(inuPackage), inuUnitType, isbStatus);
        fetch cuCount into nuCount;
        close cuCount;

        -- Si existen registros
        if(nuCount > 0) then
            boExists := TRUE;
        end if;

        UT_Trace.Trace('Fin Ld_BcCancellations.fboWorkFlowStandBy ['||nuCount||']', 1);

        return boExists;

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            if(cuCount%isopen) then
                close cuCount;
            end if;
            raise ex.CONTROLLED_ERROR;
        when OTHERS then
            if(cuCount%isopen) then
                close cuCount;
            end if;
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END fboWorkFlowStandBy;

    /**************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad      :  frfCancelledArticles
    Descripcion :  Retorna información de articulos anulados por solicitud de
                   devolución.

    Autor       :  Santiago Gómez Rico
    Fecha       :  14-11-2013
    Parametros  :  inuPackage           Solicitud de devolución.
                   inuSalesActvty       Actividad de venta.
                   inuCanclActvty       Actividad de aplicación de anulación.
                   isbStatus            Estado anulado.

    Historia de Modificaciones
    Fecha        Autor              Modificacion
    =========    =========          ====================
    14-11-2013   sgomez.SAO222901   Creación.
    ***************************************************************/

    FUNCTION frfCancelledArticles
    (
        inuPackage      in  ld_return_item.package_id%type,
        inuSalesActvty  in  or_order_activity.activity_id%type,
        inuCanclActvty  in  or_order_activity.activity_id%type,
        isbStatus       in  ld_item_work_order.state%type
    )
        return pkConstante.tyRefCursor
    IS

        nuOriginDev LD_RETURN_ITEM.ORIGIN_ANU_DEV%type;
        ------------------------------------------------------------------------
        -- Cursores
        ------------------------------------------------------------------------
        CURSOR CuGetOriginDev IS
        SELECT ORIGIN_ANU_DEV
        FROM LD_RETURN_ITEM WHERE PACKAGE_ID = inuPackage;
        ------------------------------------------------------------------------
        -- Variables
        ------------------------------------------------------------------------

        /* Información de articulos */
        rfCursor    pkConstante.tyRefCursor;

    BEGIN

        UT_Trace.Trace('Inicio Ld_BcCancellations.frfCancelledArticles ['||inuPackage||']', 1);

        if(CuGetOriginDev%isopen) then
            close CuGetOriginDev;
        end if;

        open CuGetOriginDev;
        fetch CuGetOriginDev into nuOriginDev;
        close CuGetOriginDev;

        if (nuOriginDev = 3) then
        -- si es gran superficie no hay ordenes de aplciacion
            open rfCursor for
            SELECT  /*+
                        ordered
                        use_nl(ld_return_item ld_return_item_detail)
                        use_nl(ld_return_item or_order_activity_sales)
                        use_nl(or_order_activity_sales ld_item_work_order)
                        index_rs_asc(ld_return_item IDX_LD_RETURN_ITEM01)
                        index_rs_asc(ld_return_item_detail IDX_LD_RETURN_ITEM_DETAIL01)
                        index_rs_asc(or_order_activity_sales IDX_OR_ORDER_ACTIVITY_06)
                        index_rs_asc(ld_item_work_order IX_LD_ITEM_WORK_ORDER01)
                        index(or_order PK_OR_ORDER)
                        index(ld_article PK_LD_ARTICLE)
                        index(ab_address PK_AB_ADDRESS)
                        index(mo_packages PK_MO_PACKAGES)
                        index(or_operating_unit PK_OR_OPERATING_UNIT)
                    */
                    or_order.order_id,
                    or_operating_unit.contractor_id,
                    or_order.operating_unit_id,
                    mo_packages.reception_type_id,
                    ab_address.geograp_location_id,
                    ld_article.subline_id,
                    DALd_Subline.fnuGetLine_Id(ld_article.subline_id) line_id,
                    ld_item_work_order.article_id,
                    ld_item_work_order.value,
                    ld_item_work_order.amount,
                    ld_item_work_order.iva,
                    ld_return_item.package_sale
            FROM    ld_return_item,
                    ld_return_item_detail,
                    or_order_activity or_order_activity_sales,
                    ld_item_work_order,
                    or_order,
                    ld_article,
                    ab_address,
                    mo_packages,
                    or_operating_unit /*+ Ld_BcCancellations.frfCancelledArticles */
            WHERE   ld_return_item.package_id                  = inuPackage
            AND     ld_return_item.return_item_id              = ld_return_item_detail.return_item_id
            AND     ld_return_item.package_sale                = or_order_activity_sales.package_id
            AND     or_order_activity_sales.activity_id        = inuSalesActvty
            AND     ld_return_item_detail.activity_delivery_id = or_order_activity_sales.order_activity_id
            AND     or_order_activity_sales.order_activity_id  = ld_item_work_order.order_activity_id
            AND     ld_item_work_order.state                   = isbStatus
            AND     ld_item_work_order.order_id                = or_order.order_id
            AND     ld_item_work_order.article_id              = ld_article.article_id
            AND     or_order_activity_sales.address_id         = ab_address.address_id
            AND     or_order_activity_sales.package_id         = mo_packages.package_id
            AND     or_order.operating_unit_id                 = or_operating_unit.operating_unit_id;

        else

            open rfCursor for
            SELECT  /*+
                        ordered
                        use_nl(ld_return_item ld_return_item_detail)
                        use_nl(ld_return_item or_order_activity_sales)
                        use_nl(or_order_activity_sales ld_item_work_order)
                        index_rs_asc(ld_return_item IDX_LD_RETURN_ITEM01)
                        index_rs_asc(ld_return_item_detail IDX_LD_RETURN_ITEM_DETAIL01)
                        index_rs_asc(or_order_activity_sales IDX_OR_ORDER_ACTIVITY_06)
                        index(or_order_activity_cancl PK_OR_ORDER_ACTIVITY)
                        index_rs_asc(ld_item_work_order IX_LD_ITEM_WORK_ORDER01)
                        index(or_order PK_OR_ORDER)
                        index(ld_article PK_LD_ARTICLE)
                        index(ab_address PK_AB_ADDRESS)
                        index(mo_packages PK_MO_PACKAGES)
                        index(or_operating_unit PK_OR_OPERATING_UNIT)
                    */
                    or_order.order_id,
                    or_operating_unit.contractor_id,
                    or_order.operating_unit_id,
                    mo_packages.reception_type_id,
                    ab_address.geograp_location_id,
                    ld_article.subline_id,
                    DALd_Subline.fnuGetLine_Id(ld_article.subline_id) line_id,
                    ld_item_work_order.article_id,
                    ld_item_work_order.value,
                    ld_item_work_order.amount,
                    ld_item_work_order.iva,
                    ld_return_item.package_sale
            FROM    ld_return_item,
                    ld_return_item_detail,
                    or_order_activity or_order_activity_sales,
                    ld_item_work_order,
                    or_order_activity or_order_activity_cancl,
                    or_order,
                    ld_article,
                    ab_address,
                    mo_packages,
                    or_operating_unit /*+ Ld_BcCancellations.frfCancelledArticles */
            WHERE   ld_return_item.package_id                  = inuPackage
            AND     ld_return_item.return_item_id              = ld_return_item_detail.return_item_id
            AND     ld_return_item.package_sale                = or_order_activity_sales.package_id
            AND     or_order_activity_sales.activity_id        = inuSalesActvty
            AND     ld_return_item_detail.activity_delivery_id = or_order_activity_sales.order_activity_id
            AND     or_order_activity_sales.order_activity_id  = ld_item_work_order.order_activity_id
            AND     ld_return_item_detail.order_activity_id    = or_order_activity_cancl.order_activity_id
            AND     or_order_activity_cancl.activity_id        = inuCanclActvty
            AND     ld_item_work_order.state                   = isbStatus
            AND     ld_item_work_order.order_id                = or_order.order_id
            AND     ld_item_work_order.article_id              = ld_article.article_id
            AND     or_order_activity_sales.address_id         = ab_address.address_id
            AND     or_order_activity_sales.package_id         = mo_packages.package_id
            AND     or_order.operating_unit_id                 = or_operating_unit.operating_unit_id;

        END if;
        UT_Trace.Trace('Fin Ld_BcCancellations.frfCancelledArticles ['||inuPackage||']', 1);

        return rfCursor;

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when OTHERS then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END frfCancelledArticles;

    /**************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad      :  fnuCancArticlesTotVal
    Descripcion :  Retorna valor total (incluye IVA) de articulos anulados por
                   solicitud de devolución.

    Autor       :  Santiago Gómez Rico
    Fecha       :  15-11-2013
    Parametros  :  inuPackage           Solicitud de devolución.
                   inuSalesActvty       Actividad de venta.
                   inuCanclActvty       Actividad de aplicación de anulación.
                   isbStatus            Estado anulado.

    Historia de Modificaciones
    Fecha        Autor              Modificacion
    =========    =========          ====================
    13-01-2013  AEcheverrySAO229210  Se modifica para obtener correctamente cuando
                                    el origen es una gran superficie (3)
    15-11-2013   sgomez.SAO222901    Creación.
    ***************************************************************/

    FUNCTION fnuCancArticlesTotVal
    (
        inuPackage      in  ld_return_item.package_id%type,
        inuSalesActvty  in  or_order_activity.activity_id%type,
        inuCanclActvty  in  or_order_activity.activity_id%type,
        isbStatus       in  ld_item_work_order.state%type
    )
        return number
    IS
        nuOriginDev LD_RETURN_ITEM.ORIGIN_ANU_DEV%type;
        ------------------------------------------------------------------------
        -- Cursores
        ------------------------------------------------------------------------
        CURSOR CuGetOriginDev IS
        SELECT ORIGIN_ANU_DEV
        FROM LD_RETURN_ITEM WHERE PACKAGE_ID = inuPackage;

        CURSOR cuTotValue
        (
            inuPackage      in  ld_return_item.package_id%type,
            inuSalesActvty  in  or_order_activity.activity_id%type,
            inuCanclActvty  in  or_order_activity.activity_id%type,
            isbStatus       in  ld_item_work_order.state%type
        )
        IS
            SELECT  /*+
                        ordered
                        use_nl(ld_return_item or_order_activity_sales ld_item_work_order)
                        use_nl(ld_return_item ld_return_item_detail or_order_activity_cancl)
                        index_rs_asc(ld_return_item IDX_LD_RETURN_ITEM01)
                        index_rs_asc(or_order_activity_sales IDX_OR_ORDER_ACTIVITY_06)
                        index_rs_asc(ld_item_work_order IX_LD_ITEM_WORK_ORDER01)
                        index_rs_asc(ld_return_item_detail IDX_LD_RETURN_ITEM_DETAIL01)
                        index(or_order_activity_cancl PK_OR_ORDER_ACTIVITY)
                    */
                    nvl(sum(ld_item_work_order.amount * ld_item_work_order.value), 0) + nvl(SUM(ld_item_work_order.iva), 0)
            FROM    ld_return_item,
                    ld_return_item_detail,
                    or_order_activity or_order_activity_sales,
                    or_order_activity or_order_activity_cancl,
                    ld_item_work_order /*+ Ld_BcCancellations.fnuCancArticlesTotVal */
            WHERE   ld_return_item.package_id                  = inuPackage
            AND     ld_return_item.package_sale                = or_order_activity_sales.package_id
            AND     or_order_activity_sales.activity_id        = inuSalesActvty
            AND     or_order_activity_sales.order_activity_id  = ld_item_work_order.order_activity_id
            AND     ld_item_work_order.state                   = isbStatus
            AND     ld_return_item.return_item_id              = ld_return_item_detail.return_item_id
            AND     ld_return_item_detail.activity_delivery_id = or_order_activity_sales.order_activity_id
            AND     ld_return_item_detail.order_activity_id    = or_order_activity_cancl.order_activity_id
            AND     or_order_activity_cancl.activity_id        = inuCanclActvty;

        -- obtiene el valor a devolver cuando es gran superficie
        CURSOR cuTotValueGS
        (
            inuPackage      in  ld_return_item.package_id%type,
            inuSalesActvty  in  or_order_activity.activity_id%type,
            isbStatus       in  ld_item_work_order.state%type
        )
        IS
            SELECT  /*+
                        ordered
                        use_nl(ld_return_item or_order_activity_sales ld_item_work_order)
                        use_nl(ld_return_item ld_return_item_detail or_order_activity_cancl)
                        index_rs_asc(ld_return_item IDX_LD_RETURN_ITEM01)
                        index_rs_asc(or_order_activity_sales IDX_OR_ORDER_ACTIVITY_06)
                        index_rs_asc(ld_item_work_order IX_LD_ITEM_WORK_ORDER01)
                        index_rs_asc(ld_return_item_detail IDX_LD_RETURN_ITEM_DETAIL01)
                    */
                    nvl(sum(ld_item_work_order.amount * ld_item_work_order.value), 0) + nvl(SUM(ld_item_work_order.iva), 0)
            FROM    ld_return_item,
                    ld_return_item_detail,
                    or_order_activity or_order_activity_sales,
                    ld_item_work_order /*+ Ld_BcCancellations.fnuCancArticlesTotVal */
            WHERE   ld_return_item.package_id                  = inuPackage
            AND     or_order_activity_sales.package_id         = ld_return_item.package_sale
            AND     or_order_activity_sales.activity_id        = inuSalesActvty
            AND     or_order_activity_sales.order_activity_id  = ld_item_work_order.order_activity_id
            AND     ld_item_work_order.state                   = isbStatus
            AND     ld_return_item.return_item_id              = ld_return_item_detail.return_item_id
            AND     ld_return_item_detail.activity_delivery_id = or_order_activity_sales.order_activity_id;
        ------------------------------------------------------------------------
        -- Variables
        ------------------------------------------------------------------------

        /* Valor total de artículos */
        nuTotValue  number;

    BEGIN

        UT_Trace.Trace('Inicio Ld_BcCancellations.fnuCancArticlesTotVal ['||inuPackage||']', 1);


        if(CuGetOriginDev%isopen) then
            close CuGetOriginDev;
        end if;

        open CuGetOriginDev;
        fetch CuGetOriginDev into nuOriginDev;
        close CuGetOriginDev;

        if (nuOriginDev = 3) then
        -- si es una gran superficie no hay ordenes de aplicacion
            if(cuTotValueGS%isopen) then
                close cuTotValueGS;
            end if;
            open  cuTotValueGS
              (
                inuPackage,
                inuSalesActvty,
                isbStatus
              );

            fetch cuTotValueGS into nuTotValue;
            close cuTotValueGS;
        else
        -- si no es gran superficie se validan las ordenes de aplicación.
            if(cuTotValue%isopen) then
                close cuTotValue;
            end if;
            open  cuTotValue
                  (
                    inuPackage,
                    inuSalesActvty,
                    inuCanclActvty,
                    isbStatus
                  );

            fetch cuTotValue into nuTotValue;
            close cuTotValue;

        END if;

        UT_Trace.Trace('Fin Ld_BcCancellations.fnuCancArticlesTotVal ['||nuTotValue||']', 1);

        return nuTotValue;

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            if(cuTotValue%isopen) then
                close cuTotValue;
            end if;
            raise ex.CONTROLLED_ERROR;
        when OTHERS then
            if(cuTotValue%isopen) then
                close cuTotValue;
            end if;
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END fnuCancArticlesTotVal;

    /**************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad      :  fnuNonDeliveredArticles
    Descripcion :  Retorna número de articulos de la venta que NO han sido entregados.

    Autor       :  Jorge Alejandro Carmona Duque
    Fecha       :  19-11-2013
    Parametros  :  inuPackage       Solicitud de Venta.
                   inuActivity      Actividad de Entrega.
                   isbStatus        Estado Finalizado.

    Historia de Modificaciones
    Fecha        Autor                  Modificacion
    =========    =========              ====================
    19-11-2013   JCarmona.SAO223750     Creación.
    ***************************************************************/

    FUNCTION fnuNonDeliveredArticles
    (
        inuPackage  in  ld_return_item.package_id%type,
        inuActivity in  or_order_activity.activity_id%type,
        isbStatus   in  ld_item_work_order.state%type
    )
        return number
    IS
        ------------------------------------------------------------------------
        -- Cursores
        ------------------------------------------------------------------------

        CURSOR cuCount
        (
            nuPackage  in  ld_return_item.package_id%type,
            nuActivity in  or_order_activity.activity_id%type,
            sbStatus   in  ld_item_work_order.state%type
        )
        IS
            SELECT  count(1)
            FROM    or_order_activity
            WHERE   or_order_activity.package_id = nuPackage
            AND     or_order_activity.activity_id = nuActivity
            AND     or_order_activity.status <> sbStatus;

        ------------------------------------------------------------------------
        -- Variables
        ------------------------------------------------------------------------

        /* Número de articulos no entregados */
        nuCount number;

    BEGIN

        UT_Trace.Trace('Inicio Ld_BcCancellations.fnuNonDeliveredArticles', 1);

        if(cuCount%isopen) then
            close cuCount;
        end if;

        open  cuCount(inuPackage, inuActivity, isbStatus);
        fetch cuCount into nuCount;
        close cuCount;

        UT_Trace.Trace('Fin Ld_BcCancellations.fnuNonDeliveredArticles ['||nuCount||']', 1);

        return nuCount;

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            if(cuCount%isopen) then
                close cuCount;
            end if;
            raise ex.CONTROLLED_ERROR;
        when OTHERS then
            if(cuCount%isopen) then
                close cuCount;
            end if;
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END fnuNonDeliveredArticles;

    /**************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad      :  fnuIsQuotaTransferAuto
    Descripcion :  Valida si el traslado de cupo se realizó de forma automática.

    Autor       :  Jorge Alejandro Carmona Duque
    Fecha       :  22-11-2013
    Parametros  :  inuPackage       Solicitud de Venta.

    Retorna     :  1 - Si el traslado de cupo fue automático.
                   0 - Si se generarón órdenes de traslado de cupo.

    Historia de Modificaciones
    Fecha        Autor                  Modificacion
    =========    =========              ====================
    22-11-2013   JCarmona.SAO224114     Creación.
    ***************************************************************/

    FUNCTION fnuIsQuotaTransferAuto
    (
        inuPackage  in  ld_return_item.package_id%type
    )
        return number
    IS
        ------------------------------------------------------------------------
        -- Cursores
        ------------------------------------------------------------------------

        CURSOR cuIsQuotaTransferAuto
        (
            nuPackage  in  ld_return_item.package_id%type
        )
        IS
            SELECT      order_id
            FROM        ld_quota_transfer
            WHERE       package_id = nuPackage;

        ------------------------------------------------------------------------
        -- Variables
        ------------------------------------------------------------------------

        /* Número de orden de traslado de cupo */
        nuOrderId number;

    BEGIN

        UT_Trace.Trace('Inicio Ld_BcCancellations.fnuIsQuotaTransferAuto', 1);

        if(cuIsQuotaTransferAuto%isopen) then
            close cuIsQuotaTransferAuto;
        end if;

        open  cuIsQuotaTransferAuto(inuPackage);
        fetch cuIsQuotaTransferAuto into nuOrderId;
        close cuIsQuotaTransferAuto;

        if nuOrderId IS not null then
            UT_Trace.Trace('Fin Ld_BcCancellations.fnuIsQuotaTransferAuto ['||nuOrderId||']', 1);

            return 0;
        else
            UT_Trace.Trace('Fin Ld_BcCancellations.fnuIsQuotaTransferAuto ['||nuOrderId||']', 1);

            return 1;
        END if;

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            if(cuIsQuotaTransferAuto%isopen) then
                close cuIsQuotaTransferAuto;
            end if;
            raise ex.CONTROLLED_ERROR;
        when OTHERS then
            if(cuIsQuotaTransferAuto%isopen) then
                close cuIsQuotaTransferAuto;
            end if;
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END fnuIsQuotaTransferAuto;

      /**************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad      :  fsbWorkFlowStandBy
    Descripcion :  Evalúa si un flujo se encuentra detenido, por tipo de unidad.

    Autor       :  Erika Alejandra Montenegro Gaviria
    Fecha       :  19-12-2013
    Parametros  :  inuPackage       Solicitud de anulación.
                   inuUnitType      Tipo de unidad.
                   isbStatus        Estado.

    Historia de Modificaciones
    Fecha        Autor                  Modificacion
    =========    =========              ====================
    19-12-2013   emontenegro.SAO228434   Creación.
    ***************************************************************/

    FUNCTION fsbWorkFlowStandBy
    (
        inuPackage  in  mo_packages.package_id%type,
        inuUnitType in  wf_unit_type.unit_type_id%type,
        isbStatus   in  wf_instance.status_id%type
    )
        return varchar2
    IS
       ------------------------------------------------------------------------
       -- Variables
       ------------------------------------------------------------------------
       sbValid varchar2(1);
       boExists boolean;

    BEGIN

        UT_Trace.Trace('Inicio Ld_BcCancellations.fsbWorkFlowStandBy', 1);

        sbValid  := 'N';
        boExists := fboWorkFlowStandBy(inuPackage,inuUnitType,isbStatus);

        if(boExists) then
            sbValid := 'Y';
        end if;

        UT_Trace.Trace('Fin Ld_BcCancellations.fsbWorkFlowStandBy ', 1);

        return sbValid;

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when OTHERS then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END fsbWorkFlowStandBy;

end LD_BCCANCELLATIONS;
/

BEGIN
    pkg_utilidades.prAplicarPermisos('LD_BCCANCELLATIONS', 'ADM_PERSON');
END;
/
