CREATE OR REPLACE package ADM_PERSON.LD_BCLIQUIDATIONMINUTE is

  -- Author  : Adolfo Jimenez
  -- Created : 18/10/2012 10:37:33 a.m.
  -- Purpose : Logica para la liquidacion de las comisiones de los proveedores

  -- Public type declarations
  cursor cuArticlesSold(inuOrder in or_order.order_id%type) is
    SELECT o.order_id,
           o.sequence,
           o.priority,
           o.external_address_id,
           o.created_date,
           o.legalization_date,
           o.printing_time_number,
           o.operating_unit_id,
           o.order_status_id,
           o.task_type_id,
           o.operating_sector_id,
           o.geograp_location_id,
           o.subscriber_id,
           l.item_work_order_id ItemWorkOrderAct,
           l.article_id ArticleAct,
           l.order_activity_id OrderActivityAct,
           l.value,
           l.amount,
           l.iva,
           a.package_id,
           a.order_id OrderIDOrdAct,
           a.product_id,
           u.contractor_id,
           m.SALE_CHANNEL_ID,
           t.financier_id,
           d.geograp_location_id GeoLoc_ABADDRESS,
           t.subline_id subline_id,
           dald_subline.fnuGetLine_Id(t.subline_id) line_id,
           t.concept_id
      FROM or_order_activity  a,
           or_order           o,
           ld_item_work_order l,
           or_operating_unit  u,
           MO_PACKAGES        m,
           AB_ADDRESS         d,
           ld_article         t
     WHERE o.order_id = a.order_id
       AND a.order_activity_id = l.order_activity_id
       AND o.order_id = inuOrder
       AND u.operating_unit_id = o.operating_unit_id
       AND a.Package_Id = m.package_id
       AND d.address_id = a.address_id
       and t.article_id = l.article_id;
  -- Public constant declarations

  -- Public variable declarations
  TYPE tytbcuArticlesSold IS TABLE OF cuArticlesSold%rowtype;
  vtabArticlesSold tytbcuArticlesSold;
  -- Public function and procedure declarations

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : InsertDetailLiquiSeller
  Descripcion    : Insercion en la tabla Detalle de liquidacion de proveedor.

  Autor          : Adolfo Jimenez
  Fecha          : 23/10/2012

  Parametros              Descripcion
  ============         ===================
  inudetail_liqui_seller_id
  inupackage_id
  inuconcept_id
  inupercentage_liquidation
  inuvalue_paid
  inuarticle_id
  inucontractor_id

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/

  PROCEDURE InsertDetailLiquiSeller(inudetail_liqui_seller_id in ld_detail_liqui_seller.detail_liqui_seller_id%TYPE,
                                    inuconcept_id             in ld_detail_liqui_seller.conccodi%TYPE,
                                    inupercentage_liquidation in ld_detail_liqui_seller.percentage_liquidation%TYPE,
                                    inuvalue_paid             in ld_detail_liqui_seller.value_paid%TYPE,
                                    inuarticle_id             in ld_detail_liqui_seller.article_id%TYPE,
                                    inucontractor_id          in ld_detail_liqui_seller.id_contratista %TYPE,
                                    inuliquidation_seller_id  in ld_detail_liqui_seller.liquidation_seller_id%TYPE,
                                    inuOrder_id               in ld_detail_liqui_seller.base_order_id%TYPE,
                                    inuValueBase              in ld_detail_liqui_seller.value_base%TYPE,
                                    isbInclVatReco            in ld_detail_liqui_seller.inclu_vat_reco_commi%TYPE);
  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : InsertLiquidationSeller
  Descripcion    : Insercion en la tabla de liquidacion de vendedores.

  Autor          : Adolfo Jimenez
  Fecha          : 23/10/2012

  Parametros              Descripcion
  ============         ===================
  inuliquidation_seller_id in
  idtdate_liquidation in
  inuseller_id in
  isbstatus in
  idtdate_suspension in
  isbproduct_id in


  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/

  PROCEDURE InsertLiquidationSeller(inuliquidation_seller_id in ld_liquidation_seller.liquidation_seller_id%TYPE,
                                    idtdate_liquidation      in ld_liquidation_seller.date_liquidation%TYPE,
                                    isbstatus                in ld_liquidation_seller.status%TYPE,
                                    idtdate_suspension       in ld_liquidation_seller.date_suspension%TYPE,
                                    isbproduct_id            in ld_liquidation_seller.funder_id%TYPE,
                                    inuOrder_id              in ld_liquidation_seller.liquidated_order_id%TYPE,
                                    inuPackage_id            in ld_liquidation_seller.package_id%TYPE,
                                    inucontratista           in ld_liquidation_seller.id_contratista%type default null);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ftbArticlesSold
  Descripcion    : Devuelve los articulos vendidos de una Orden.

  Autor          : eramos
  Fecha          : 18/10/2012

  Parametros              Descripcion
  ============         ===================
  inuOrder_Id        Identificador de la orden.


  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  function ftbArticlesSold(inuOrder_Id in or_order.order_id%type)
    return tytbcuArticlesSold;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : FrfGetOrderArticlesSold
  Descripcion    : Retorna las ordenes y articulos para la comision a los proveedores
                   y contratista de venta.

  Autor          : Alex Valencia Ayola
  Fecha          : 26/02/2013

  Parametros                     Descripcion
  ============                   ===================
  inuInputActivity_id            Tipo de actividad
  inuOutputActivity_id           Tipo de actividad a obtener
  inuOrder                       Numerador de la orden

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FrfGetOrderArticlesSold(inuInputActivity_id  IN or_order_activity.activity_id%TYPE,
                                   inuOutputActivity_id IN or_order_activity.activity_id%TYPE,
                                   inuOrder             IN or_order.order_id%TYPE)
    RETURN pkConstante.tyRefCursor;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : FnuGetCountLiqSellerByStatus
  Descripcion    : Retorna la cantidad de ordenes liquidadas por estado en ld_liquidation_seller.

  Autor          : Alex Valencia Ayola
  Fecha          : 26/02/2013

  Parametros                     Descripcion
  ============                   ===================
  inuInputActivity_id            Tipo de actividad
  inuOutputActivity_id           Tipo de actividad a obtener
  inuOrder                       Numerador de la orden

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FnuGetCountLiqSellerByStatus(inuOrder IN or_order.order_id%TYPE,
                                        isbSatus IN ld_liquidation_seller.status%TYPE)
    RETURN Number;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : FnuGetLiqSellerIdByOrder
  Descripcion    : Retorna el identificador de la liquidacion dada la orden

  Autor          : Alex Valencia Ayola
  Fecha          : 27/02/2013

  Parametros                     Descripcion
  ============                   ===================
  inuOrder                       Numerador de la orden

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FnuGetLiqSellerIdByOrder(inuOrder IN or_order.order_id%TYPE,
                                    ISBSTATUS IN LD_LIQUIDATION_SELLER.STATUS%TYPE DEFAULT NULL)
    RETURN Ld_Liquidation_Seller.Liquidation_Seller_Id%TYPE;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : FblExistDetaLiqSeller
  Descripcion    : Determina si existe liquidacion en el detalle dado el numero de liquidacion,
                   la orden y el articulo

  Autor          : Alex Valencia Ayola
  Fecha          : 27/02/2013

  Parametros                     Descripcion
  ============                   ===================
  inuLiqSe                       Numero de liquidacion
  inuOrder                       Numerador de la orden
  inuArtic                       Identificador del articulo

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FblExistDetaLiqSeller(inuLiqSe IN Ld_Detail_Liqui_Seller.Liquidation_Seller_Id%TYPE,
                                 inuOrder IN or_order.order_id%TYPE,
                                 inuArtic IN Ld_Detail_Liqui_Seller.Article_Id%TYPE)
    RETURN BOOLEAN;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : FnuCountDetaLiqSeller
  Descripcion    : Determina numero de ordenes existentes en el detalle dado el numero de liquidacion
                   y la orden.

  Autor          : Alex Valencia Ayola
  Fecha          : 27/02/2013

  Parametros                     Descripcion
  ============                   ===================
  inuLiqSe                       Numero de liquidacion
  inuOrder                       Numerador de la orden

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FnuCountDetaLiqSeller(inuLiqSe IN Ld_Detail_Liqui_Seller.Liquidation_Seller_Id%TYPE)
    RETURN PLS_INTEGER;

end LD_BCLIQUIDATIONMINUTE;
/
CREATE OR REPLACE package body ADM_PERSON.LD_BCLIQUIDATIONMINUTE is

  -- Private type declarations

  -- Private constant declarations

  -- Private variable declarations

  -- Function and procedure implementations
  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : InsertDetailLiquiSeller
  Descripcion    : Insercion en la tabla Detalle de liquidacion de proveedor.

  Autor          : Adolfo Jimenez
  Fecha          : 23/10/2012

  Parametros              Descripcion
  ============         ===================
  inudetail_liqui_seller_id
  inupackage_id
  inuconcept_id
  inupercentage_liquidation
  inuvalue_paid
  inuarticle_id
  inucontractor_id

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/

  PROCEDURE InsertDetailLiquiSeller(inudetail_liqui_seller_id in ld_detail_liqui_seller.detail_liqui_seller_id%TYPE,
                                    inuconcept_id             in ld_detail_liqui_seller.conccodi%TYPE,
                                    inupercentage_liquidation in ld_detail_liqui_seller.percentage_liquidation%TYPE,
                                    inuvalue_paid             in ld_detail_liqui_seller.value_paid%TYPE,
                                    inuarticle_id             in ld_detail_liqui_seller.article_id%TYPE,
                                    inucontractor_id          in ld_detail_liqui_seller.id_contratista %TYPE,
                                    inuliquidation_seller_id  in ld_detail_liqui_seller.liquidation_seller_id%TYPE,
                                    inuOrder_id               in ld_detail_liqui_seller.base_order_id%TYPE,
                                    inuValueBase              in ld_detail_liqui_seller.value_base%TYPE,
                                    isbInclVatReco            in ld_detail_liqui_seller.inclu_vat_reco_commi%TYPE) is
    ircld_detail_liqui_seller dald_detail_liqui_seller.styLD_detail_liqui_seller;
  BEGIN
    ircld_detail_liqui_seller.detail_liqui_seller_id := inudetail_liqui_seller_id;
    ircld_detail_liqui_seller.conccodi               := inuconcept_id;
    ircld_detail_liqui_seller.percentage_liquidation := inupercentage_liquidation;
    ircld_detail_liqui_seller.value_paid             := inuvalue_paid;
    ircld_detail_liqui_seller.article_id             := inuarticle_id;
    ircld_detail_liqui_seller.id_contratista         := inucontractor_id;
    ircld_detail_liqui_seller.liquidation_seller_id  := inuliquidation_seller_id;
    ircld_detail_liqui_seller.base_order_id          := inuOrder_id;
    ircld_detail_liqui_seller.value_base             := inuValueBase;
    ircld_detail_liqui_seller.inclu_vat_reco_commi   := isbInclVatReco;

    /*guarda en la tabla*/
    dald_detail_liqui_seller.insRecord(ircLD_detail_liqui_seller => ircld_detail_liqui_seller);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END InsertDetailLiquiSeller;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : InsertLiquidationSeller
  Descripcion    : Insercion en la tabla de liquidacion de vendedores.

  Autor          : Adolfo Jimenez
  Fecha          : 23/10/2012

  Parametros              Descripcion
  ============         ===================
  inuliquidation_seller_id in
  idtdate_liquidation in
  inuseller_id in
  isbstatus in
  idtdate_suspension in
  isbproduct_id in


  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/

  PROCEDURE InsertLiquidationSeller(inuliquidation_seller_id in ld_liquidation_seller.liquidation_seller_id%TYPE,
                                    idtdate_liquidation      in ld_liquidation_seller.date_liquidation%TYPE,
                                    isbstatus                in ld_liquidation_seller.status%TYPE,
                                    idtdate_suspension       in ld_liquidation_seller.date_suspension%TYPE,
                                    isbproduct_id            in ld_liquidation_seller.funder_id%TYPE,
                                    inuOrder_id              in ld_liquidation_seller.liquidated_order_id%TYPE,
                                    inuPackage_id            in ld_liquidation_seller.package_id%TYPE,
                                    inucontratista           in ld_liquidation_seller.id_contratista%type default null) is
    ircLd_liquidation_seller dald_liquidation_seller.styLD_liquidation_seller;
  BEGIN
    ircLd_liquidation_seller.liquidation_seller_id := inuliquidation_seller_id;
    ircLd_liquidation_seller.date_liquidation      := idtdate_liquidation;
    ircLd_liquidation_seller.status                := isbstatus;
    ircLd_liquidation_seller.date_suspension       := idtdate_suspension;
    ircLd_liquidation_seller.funder_id             := isbproduct_id;
    ircLd_liquidation_seller.liquidated_order_id   := inuOrder_id;
    ircLd_liquidation_seller.package_id            := inuPackage_id;
    ircLd_liquidation_seller.id_contratista        := inucontratista;
    /*guarda en la tabla*/
    dald_liquidation_seller.insRecord(ircLD_liquidation_seller => ircLd_liquidation_seller);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END InsertLiquidationSeller;
  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ftbArticlesSold
  Descripcion    : Devuelve los articulos vendidos de una Orden.

  Autor          : eramos
  Fecha          : 18/10/2012

  Parametros              Descripcion
  ============         ===================
  inuOrder_Id        Identificador de la orden.


  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION ftbArticlesSold(inuOrder_Id in or_order.order_id%TYPE)
    return tytbcuArticlesSold is

  BEGIN
    open cuArticlesSold(inuOrder_Id);
    fetch cuArticlesSold bulk collect
      into vtabArticlesSold;
    close cuArticlesSold;
    return vtabArticlesSold;
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END ftbArticlesSold;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : FrfGetOrderArticlesSold
  Descripcion    : Retorna las ordenes y articulos para la comision a los proveedores
                   y contratista de venta.

  Autor          : Alex Valencia Ayola
  Fecha          : 26/02/2013

  Parametros                     Descripcion
  ============                   ===================
  inuInputActivity_id            Tipo de actividad
  inuOutputActivity_id           Tipo de actividad a obtener
  inuOrder                       Numerador de la orden

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FrfGetOrderArticlesSold(inuInputActivity_id  IN or_order_activity.activity_id%TYPE,
                                   inuOutputActivity_id IN or_order_activity.activity_id%TYPE,
                                   inuOrder             IN or_order.order_id%TYPE)
    RETURN pkConstante.tyRefCursor IS

    rfcursor pkConstante.tyRefCursor;

  BEGIN

    ut_trace.Trace('INICIO Ld_BcLiquidationMinute.FrfGetOrderArticlesSold',
                   10);

    OPEN rfcursor FOR
      SELECT o.order_id,
             oa.order_activity_id,
             u.contractor_id contractor_id, --
             o.operating_unit_id operating_unit_id, --
             oa.package_id, --
             m.reception_type_id sale_channel_id, --
             d.geograp_location_id geoloc_abaddress, --
             t.subline_id subline_id, --
             dald_subline.fnuGetLine_Id(t.subline_id) line_id, --
             l.article_id ArticleAct, --
             l.value,
             l.amount,
             l.iva,
             t.financier_id, --
             t.concept_id
        FROM ld_item_work_order l, --
             or_order_activity  oa, --
             ld_article         t, --
             or_order           o, --
             mo_packages        m,
             or_operating_unit  u,
             or_order_status    os, --*
             ab_address         d
       WHERE l.order_activity_id = oa.order_activity_id
         AND l.order_id = oa.order_id
         AND l.order_id = o.order_id
         AND t.article_id = l.article_id
         AND oa.order_id = oa.order_id
         AND os.order_status_id = o.order_status_id
         AND l.state = 'RE'
            /*  AND a.installation = 'Y'*/
         AND oa.order_id = o.order_id
         AND o.order_id = /*343926 --*/
             inuOrder
         AND d.address_id = oa.address_id
         AND oa.Package_Id = m.package_id
         AND u.operating_unit_id = o.operating_unit_id
         AND oa.activity_id = inuOutputActivity_id --ACTV OT ENTREGA
         AND dage_causal.fnuGetclass_causal_id(o.causal_id, 0) =
        or_boconstants.cnuSUCCESCAUSAL; -- Causal exitosa;
    ut_trace.Trace('FIN Ld_BcLiquidationMinute.FrfGetOrderArticlesSold',
                   10);

    Return(rfcursor);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      RAISE ex.CONTROLLED_ERROR;
  END FrfGetOrderArticlesSold;
  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : FnuGetCountLiqSellerByStatus
  Descripcion    : Retorna la cantidad de ordenes liquidadas por estado en ld_liquidation_seller.

  Autor          : Alex Valencia Ayola
  Fecha          : 26/02/2013

  Parametros                     Descripcion
  ============                   ===================
  inuInputActivity_id            Tipo de actividad
  inuOutputActivity_id           Tipo de actividad a obtener
  inuOrder                       Numerador de la orden

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FnuGetCountLiqSellerByStatus(inuOrder IN or_order.order_id%TYPE,
                                        isbSatus IN ld_liquidation_seller.status%TYPE)
    RETURN NUMBER IS
    CURSOR cuCountOrders IS
      SELECT COUNT(1)
        FROM ld_liquidation_seller l
       WHERE liquidated_order_id = inuOrder
         AND status = isbSatus;

    nuCount NUMBER;
  BEGIN
    ut_trace.Trace('INICIO Ld_BcLiquidationMinute.FnuGetCountLiqSellerByStatus',
                   10);

    OPEN cuCountOrders;
    FETCH cuCountOrders
      INTO nuCount;
    CLOSE cuCountOrders;

    ut_trace.Trace('INICIO Ld_BcLiquidationMinute.FnuGetCountLiqSellerByStatus',
                   10);
    RETURN nuCount;
  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      Errors.setError;
      RAISE ex.CONTROLLED_ERROR;
  END FnuGetCountLiqSellerByStatus;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : FnuGetLiqSellerIdByOrder
  Descripcion    : Retorna el identificador de la liquidacion dada la orden

  Autor          : Alex Valencia Ayola
  Fecha          : 27/02/2013

  Parametros                     Descripcion
  ============                   ===================
  inuOrder                       Numerador de la orden

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FnuGetLiqSellerIdByOrder(inuOrder IN or_order.order_id%TYPE,
                                    ISBSTATUS IN LD_LIQUIDATION_SELLER.STATUS%TYPE DEFAULT NULL)
    RETURN Ld_Liquidation_Seller.Liquidation_Seller_Id%TYPE IS

    CURSOR cuCountOrders IS
      SELECT liquidation_seller_id
        FROM Ld_Liquidation_Seller
       WHERE liquidated_order_id = inuOrder
       AND STATUS = ISBSTATUS;

    nuLiqSellerId Ld_Liquidation_Seller.Liquidation_Seller_Id%TYPE;
  BEGIN
    ut_trace.Trace('INICIO Ld_BcLiquidationMinute.FnuGetLiqSellerIdByOrder',
                   10);

    OPEN cuCountOrders;
    FETCH cuCountOrders
      INTO nuLiqSellerId;
    CLOSE cuCountOrders;

    ut_trace.Trace('INICIO Ld_BcLiquidationMinute.FnuGetLiqSellerIdByOrder',
                   10);

    RETURN nuLiqSellerId;
  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      Errors.setError;
      RAISE ex.CONTROLLED_ERROR;
  END FnuGetLiqSellerIdByOrder;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : FblExistDetaLiqSeller
  Descripcion    : Determina si existe liquidacion en el detalle dado el numero de liquidacion,
                   la orden y el articulo

  Autor          : Alex Valencia Ayola
  Fecha          : 27/02/2013

  Parametros                     Descripcion
  ============                   ===================
  inuLiqSe                       Numero de liquidacion
  inuOrder                       Numerador de la orden
  inuArtic                       Identificador del articulo

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FblExistDetaLiqSeller(inuLiqSe IN Ld_Detail_Liqui_Seller.Liquidation_Seller_Id%TYPE,
                                 inuOrder IN or_order.order_id%TYPE,
                                 inuArtic IN Ld_Detail_Liqui_Seller.Article_Id%TYPE)
    RETURN BOOLEAN IS

    CURSOR cuCountOrders IS
      SELECT 1
        FROM Ld_Detail_Liqui_Seller
       WHERE liquidation_seller_id = inuLiqSe
         AND base_order_id = inuOrder
         AND article_id = inuArtic;

    nuExist PLS_INTEGER;
  BEGIN
    ut_trace.Trace('INICIO Ld_BcLiquidationMinute.FblExistDetaLiqSeller',
                   10);

    OPEN cuCountOrders;
    FETCH cuCountOrders
      INTO nuExist;
    CLOSE cuCountOrders;

    ut_trace.Trace('INICIO Ld_BcLiquidationMinute.FblExistDetaLiqSeller',
                   10);

    RETURN sys.diutil.int_to_bool(NVL(nuExist, 0));
  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      Errors.setError;
      RAISE ex.CONTROLLED_ERROR;
  END FblExistDetaLiqSeller;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : FnuCountDetaLiqSeller
  Descripcion    : Determina numero de ordenes existentes en el detalle dado el numero de liquidacion
                   y la orden.

  Autor          : Alex Valencia Ayola
  Fecha          : 27/02/2013

  Parametros                     Descripcion
  ============                   ===================
  inuLiqSe                       Numero de liquidacion
  inuOrder                       Numerador de la orden

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FnuCountDetaLiqSeller(inuLiqSe IN Ld_Detail_Liqui_Seller.Liquidation_Seller_Id%TYPE)
    RETURN PLS_INTEGER IS

    CURSOR cuCountOrders IS
      SELECT Count(1)
        FROM Ld_Detail_Liqui_Seller
       WHERE liquidation_seller_id = inuLiqSe;

    nuCount PLS_INTEGER;
  BEGIN
    ut_trace.Trace('INICIO Ld_BcLiquidationMinute.FnuCountDetaLiqSeller',
                   10);

    OPEN cuCountOrders;
    FETCH cuCountOrders
      INTO nuCount;
    CLOSE cuCountOrders;

    ut_trace.Trace('INICIO Ld_BcLiquidationMinute.FnuCountDetaLiqSeller',
                   10);

    RETURN nuCount;
  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      Errors.setError;
      RAISE ex.CONTROLLED_ERROR;
  END FnuCountDetaLiqSeller;
END LD_BCLIQUIDATIONMINUTE;
/

BEGIN
    pkg_utilidades.prAplicarPermisos('LD_BCLIQUIDATIONMINUTE', 'ADM_PERSON'); 
END;
/
