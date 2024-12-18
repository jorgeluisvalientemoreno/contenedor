CREATE OR REPLACE PACKAGE ADM_PERSON.LD_BOLIQUIDATIONMINUTE IS
  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : LD_BOLIQUIDATIONMINUTE
  Descripcion    : Logica del calculo de comision del proveedor
  Autor          : ??????
  Fecha          : 18-10-2012 15:35:16

  Historia de Modificaciones
  Fecha             Autor               Modificación
  =========         =========           ====================
  14-11-2013        sgomez.SAO222901    Se publica procedimiento
                                        <GetConfCommissionSupplier>.

  18-10-2012        ?????.SAO??????     Creación.
  ******************************************************************/

  -- Author  : ADMINISTRADOR
  -- Created :
  -- Purpose :

  -- Public type declarations
  TYPE rfOrder IS RECORD(
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
  SUBTYPE styLD_Commission IS Ld_Commission%ROWTYPE;

  /* Tipos */
  TYPE tytbLD_Commission IS TABLE OF styLD_Commission INDEX BY BINARY_INTEGER;

  /* Public constant declarations */

  /* Public variable declarations */

  /* Public function and procedure declarations */

  FUNCTION fsbVersion RETURN VARCHAR2;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : GetConfCommissionSupplier
  Descripcion    : Obtiene la configuracion de la tabla ld_commission.

  Autor          : Alex Valencia Ayola
  Fecha          : 18/10/2012

  Parametros              Descripcion
  ============         ===================
  inuGeoLocId          Identificador ubicacion geografica.
  inuContractorId      Identificador contratista.
  inuSaleChannel       Identificador Canal de Venta.
  inuArticleId         Identificador Articulo.
  inuLineId            Identificador de la linea
  inuSublineId         Identificador de la sublinea
  idtInitDate          Fecha de vigencia
  orcCommission        Cursor de salida.

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE GetConfCommissionSupplier(inuGeoLocId     IN ld_commission.Geograp_Location_Id%TYPE,
                                      inuContractorId IN ld_commission.Contrator_Id%TYPE,
                                      inuSaleChannel  IN ld_commission.Sale_Chanel_Id%TYPE,
                                      inuArticleId    IN ld_commission.Article_Id%TYPE,
                                      inuLineId       IN ld_commission.Line_Id%TYPE,
                                      inuSublineId    IN ld_commission.Subline_Id%TYPE,
                                      inuSupplierId   IN ld_commission.Supplier_Id%TYPE,
                                      idtInitDate     IN ld_commission.Initial_Date%TYPE,
                                      orcCommission   OUT NOCOPY tytbLD_Commission);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : GetCommission
  Descripcion    : Obtiene la comision para los proveedores

  Autor          : eramos
  Fecha          : 22/10/2012

  Parametros           Descripcion
  ============         ===================
  inuOrder_Id          Identificador de la orden.

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION GetCommission
  (
    inuOrder_id  IN or_order.order_id%TYPE
  )
  RETURN NUMBER;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : GetCommissionSale
  Descripcion    : Obtiene la comision para los proveedores

  Autor          : eramos
  Fecha          : 22/10/2012

  Parametros           Descripcion
  ============         ===================
  inuOrder_Id          Identificador de la orden.

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION GetCommissionSale
  (
    inuOrder_id  IN or_order.order_id%TYPE
  )
  RETURN number;

END LD_BOLIQUIDATIONMINUTE;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.LD_BOLIQUIDATIONMINUTE IS

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : LD_BOLIQUIDATIONMINUTE
  Descripcion    : Logica del calculo de comision del proveedor
  Autor          : ??????
  Fecha          : 18-10-2012 15:35:16

  Historia de Modificaciones
  Fecha             Autor               Modificación
  =========         =========           ====================
  14-11-2013        sgomez.SAO222901    Se publica procedimiento
                                        <GetConfCommissionSupplier>.
                                        Se elimina procedimiento
                                        <GetConfCommissionContrator> ya que no
                                        es invocado.

  18-10-2012        ?????.SAO??????     Creación.
  ******************************************************************/

  -- Private type declarations

  -- Private constant declarations
  cnuAllRows       CONSTANT PLS_INTEGER := -1;
  cnuCero_Value    CONSTANT PLS_INTEGER := 0;
  cnuOneNumber     CONSTANT PLS_INTEGER := 1;
  cnuActTypDeliv   CONSTANT ld_parameter.numeric_value%TYPE := Dald_parameter.fnuGetNumeric_Value('ACT_TYPE_DEL_FNB'); --Orden de entrega
  cnuActTypSaleCom CONSTANT ld_parameter.numeric_value%TYPE := Dald_parameter.fnuGetNumeric_Value('ACT_TYPE_SALE_COM'); --Comision vendedor
  cnuActTypProvCom CONSTANT ld_parameter.numeric_value%TYPE := Dald_parameter.fnuGetNumeric_Value('ACT_TYPE_PROVIDERS_COM'); --Comision proveedor

  csbVERSION constant varchar2(20) := 'SAO222901';


  -- Private variable declarations

  -- Function and procedure implementations

  FUNCTION fsbVersion RETURN VARCHAR2 IS
  BEGIN
    RETURN csbVersion;
  END;

  /************************************************************************
    Propiedad intelectual de Open International Systems (c).

     Unidad         : FsbConverttobin
     Descripción    : Transforma un valor numérico en binario
     Autor          : jonathan alberto consuegra lara
     Fecha          : 10/10/2012

     Parametros       Descripción
     ============     ===================
     inuDeal_Id       identificador del convenio

     Historia de Modificaciones
     Fecha            Autor                 Modificación
     =========        =========             ====================
     10/10/2012       jconsuegra            Creación
  /*************************************************************************/
  FUNCTION FsbConverttobin(inuValnum IN NUMBER) RETURN VARCHAR2 IS
    /* DECLARACIÿN DE VARIABLES */
    nuCopiNume NUMBER;
    nuResi     NUMBER;
    sbBina     VARCHAR2(100);

  BEGIN

    IF inuValnum <= 0 THEN
      RETURN '0';
    END IF;

    sbBina     := '';
    nuCopiNume := inuValnum;

    WHILE (nuCopiNume > 0) LOOP
      nuResi     := MOD(nuCopiNume, 2);
      nuCopiNume := trunc(nuCopiNume / 2);
      sbBina     := to_char(nuResi) || sbBina;
    END LOOP;

    RETURN sbBina;
  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      Errors.setError;
      RAISE ex.CONTROLLED_ERROR;
  END fsbConverttobin;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : GetConfCommissionSupplier
  Descripcion    : Obtiene la configuracion de la tabla ld_commission.

  Autor          : Alex Valencia Ayola
  Fecha          : 18/10/2012

  Parametros              Descripcion
  ============         ===================
  inuGeoLocId          Identificador ubicacion geografica.
  inuContractorId      Identificador contratista.
  inuSaleChannel       Identificador Canal de Venta.
  inuArticleId         Identificador Articulo.
  inuLineId            Identificador de la linea
  inuSublineId         Identificador de la sublinea
  idtInitDate          Fecha de vigencia
  orcCommission        Cursor de salida.

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE GetConfCommissionSupplier(inuGeoLocId     IN ld_commission.Geograp_Location_Id%TYPE,
                                      inuContractorId IN ld_commission.Contrator_Id%TYPE,
                                      inuSaleChannel  IN ld_commission.Sale_Chanel_Id%TYPE,
                                      inuArticleId    IN ld_commission.Article_Id%TYPE,
                                      inuLineId       IN ld_commission.Line_Id%TYPE,
                                      inuSublineId    IN ld_commission.Subline_Id%TYPE,
                                      inuSupplierId   IN ld_commission.Supplier_Id%TYPE,
                                      idtInitDate     IN ld_commission.Initial_Date%TYPE,
                                      orcCommission   OUT NOCOPY tytbLD_Commission) IS

    /* Cursor para obtener datos de la comision ordenados por el porcentaje de pago */
    /* Es importante el orden de los parametros de entrada del cursor, no tiene trascendencia el orden en la clausula where*/
    CURSOR cuCommission(inuArticle    IN NUMBER,
                        inuSaleChann  IN NUMBER,
                        inuGeoLocat   IN NUMBER,
                        inuContractor IN NUMBER,
                        inuSupplier   IN NUMBER) IS
      SELECT c.*
        FROM ld_commission c
       WHERE Line_id = inuLineId
         AND Subline_Id = inuSublineId
         AND nvl(Contrator_Id, cnuAllRows) =
             Decode(inuContractor, cnuOneNumber, inuContractorId, cnuAllRows)
         AND nvl(Supplier_Id, cnuAllRows) =
             Decode(inuSupplier, cnuOneNumber, inuSupplierId, cnuAllRows)

         AND nvl(Geograp_Location_Id, cnuAllRows) =
             Decode(inuGeoLocat, cnuOneNumber, inuGeoLocId, cnuAllRows)
         AND nvl(sale_chanel_id, cnuAllRows) =
             Decode(inuSaleChann, cnuOneNumber, inuSaleChannel, cnuAllRows)
         AND nvl(Article_Id, cnuAllRows) =
             Decode(inuArticle, cnuOneNumber, inuArticleId, cnuAllRows)

         AND Trunc(Initial_Date) <= Trunc(idtInitDate)
      --AND    Rownum = cnuonenumber
       ORDER BY Pyment_Percentage, Initial_Date;

    nuCont        NUMBER;
    sbContBina    VARCHAR2(100);
    nuPaddeLength NUMBER;
  BEGIN

    /*
    Se obtienen las permutaciones (en la que el orden importa y se puede repetir)
    en este caso se resta uno en la formula ya que se incluye el 0 en binario
    nPr = n exp r con n=2 y r=7
    nPr = power( 2, 7 ) -1 = 127;
    */

    /* El numero binario 111 1111 equivale a 127 en decimal */

    nuCont        := power(2, 4) - cnuOneNumber;


    if(inuContractorId is not null) then
        nuCont        := power(2, 5) - cnuOneNumber;
    END if;

    nuPaddeLength := Length(FsbConverttobin(nuCont));

    WHILE nuCont >= cnuCero_Value LOOP

      /* Rellena de ceros a la izquierda */
      sbContBina := Lpad(FsbConverttobin(nuCont),
                         nuPaddeLength,
                         cnuCero_Value);

      if (inuContractorId is not null) then
        OPEN cuCommission(Substr(sbContBina, 5, cnuOneNumber),    -- inuArticle
                          Substr(sbContBina, 4, cnuOneNumber),    -- inuGeoLocat
                          Substr(sbContBina, 3, cnuOneNumber),    -- inuSaleChann
                          Substr(sbContBina, 2, cnuOneNumber),     -- inuContractor
                          Substr(sbContBina, 1, cnuOneNumber));   -- inuSupplier
      else
        OPEN cuCommission(Substr(sbContBina, 4, cnuOneNumber),    -- inuArticle
                          Substr(sbContBina, 3, cnuOneNumber),    -- inuGeoLocat
                          Substr(sbContBina, 2, cnuOneNumber),    -- inuSaleChann
                                                        0,    -- inuContractor
                          Substr(sbContBina, 1, cnuOneNumber)    -- inuSupplier
                          );
      end if;


      FETCH cuCommission BULK COLLECT
        INTO orcCommission;

      IF (cuCommission%ROWCOUNT >= cnuOneNumber) THEN
        CLOSE cuCommission;
        EXIT;
      END IF;

      nuCont := nuCont - cnuOneNumber;

      CLOSE cuCommission;
    END LOOP;


    IF cuCommission%ISOPEN THEN
      CLOSE cuCommission;
    END IF;

  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      Errors.setError;
      RAISE ex.CONTROLLED_ERROR;
  END GetConfCommissionSupplier;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : GetCommission
  Descripcion    : Obtiene la comision para los proveedores

  Autor          : eramos
  Fecha          : 22/10/2012

  Parametros           Descripcion
  ============         ===================
  inuOrder_Id          Identificador de la orden de cobro de comision a pagar a proveedor().

    Historia de Modificaciones
    Fecha       Autor                   Modificacion
    =========   =========               ====================
    04-09-2013  lfernandez.SAO214404    Se eliminan parámetros código y mensaje
                                        de error. Se genera error si no
                                        encuentra configuración en ld_commission
  ******************************************************************/
  FUNCTION GetCommission
  (
    inuOrder_id  IN or_order.order_id%TYPE
  )
  RETURN NUMBER
  IS
    ------------------------------------------------------------------------
    --  Variables
    ------------------------------------------------------------------------
    rcRecord        rfOrder;
    rcCommission    tytbLD_Commission;
    frfResult       constants.tyrefcursor;
    nuLiquidSellerId ld_liquidation_seller.liquidation_seller_id%TYPE;
    nuCountOrderLiqu PLS_INTEGER := 0;
    nuSw             PLS_INTEGER := 0;
    nuIndex          PLS_INTEGER;
    nuCalcValue      NUMBER := 0;
    NUORDSALE        OR_ORDER.ORDER_ID%TYPE;
    nuCalcFin        NUMBER := 0;
    nuSupplierId     or_operating_unit.contractor_id%type;
    nuContractorId   or_operating_unit.contractor_id%type;
    nuUnitClassif    or_operating_unit.oper_unit_classif_id%type;
    nuAddressId      ab_address.address_id%type;
    nuGeograpId      ab_address.geograp_location_id%type;
    nuVendedorCont   ge_contratista.id_contratista%type;
  BEGIN

    ut_trace.trace('Inicia Ld_Boliquidationminute.GetCommission', 10);

    frfResult := Ld_BcLiquidationMinute.FrfGetOrderArticlesSold(
                                        inuInputActivity_id  => cnuActTypProvCom, -- Orden de Comision al proveedor
                                        inuOutputActivity_id => cnuActTypDeliv, --  Orden de entrega
                                        inuOrder             => inuOrder_id);

    LOOP

      FETCH frfResult INTO rcRecord;
      EXIT WHEN frfResult%NOTFOUND;

      --IDENTIFICA ORDEN DE VENTA
      NUORDSALE := Ld_bccancellations.fnugetsaleorder(rcRecord.package_id,
                                                      null);

      --IDENTIFICA CONTRATISTA QUE VENDE
      nuVendedorCont := DAOR_OPERATING_UNIT.fnuGetContractor_Id(
                    DAOR_ORDER.fnuGetOperating_Unit_Id(NUORDSALE, 0), 0);

      -- asigno el proveedor del articulo a procesar
      nuSupplierId := rcRecord.CONTRACTOR_ID;

      -- si el proveedor es diferente de quien vende, quien vendio es un contratistas
      nuContractorId :=null;
      if (nuSupplierId <> nuVendedorCont) then
          nuContractorId := nuVendedorCont;
      END if;

      nuAddressId := daor_order.fnugetexternal_address_id(rcRecord.order_id, 0);
      nuGeograpId := ge_bogeogra_location.fnuGetGeo_LocaByAddress(nuAddressId, AB_BOConstants.csbToken_LOCALIDAD);

      LD_BOLIQUIDATIONMINUTE.GetConfCommissionsupplier(inuGeoLocId     => nuGeograpId,
                                                       inuContractorId => nuContractorId,
                                                       inuSaleChannel  => rcRecord.RECEPTION_TYPE_ID,
                                                       inuArticleId    => rcRecord.ARTICLEACT,
                                                       inuLineId       => rcRecord.LINE_ID,
                                                       inuSublineId    => rcRecord.SUBLINE_ID,
                                                       inuSupplierId   => nuSupplierId,
                                                       idtInitDate     => SYSDATE,
                                                       orcCommission   => rcCommission);

      if ((rcCommission.first is null) OR (nuGeograpId <> nvl(rcCommission(rcCommission.first).geograp_location_id, -1))) then
        nuGeograpId := ge_bogeogra_location.fnuGetGeo_LocaByAddress(nuAddressId, AB_BOConstants.csbToken_DEPARTAMENTO);
        LD_BOLIQUIDATIONMINUTE.GetConfCommissionsupplier(inuGeoLocId     => nuGeograpId,
                                                         inuContractorId => nuContractorId,
                                                         inuSaleChannel  => rcRecord.RECEPTION_TYPE_ID,
                                                         inuArticleId    => rcRecord.ARTICLEACT,
                                                         inuLineId       => rcRecord.LINE_ID,
                                                         inuSublineId    => rcRecord.SUBLINE_ID,
                                                         inuSupplierId   => nuSupplierId,
                                                         idtInitDate     => SYSDATE,
                                                         orcCommission   => rcCommission);
      end if;

      nuIndex := rcCommission.FIRST;

      /*Si la configuracion no trae resultados no debe liquidar*/
      IF nuIndex IS NULL THEN

        GE_BOErrors.SetErrorCodeArgument(
            2741,
            'No existe configuracion de comisiones para los criterios Ubicación [' ||
            rcRecord.GEOLOC_ABADDRESS       || '] Contratista ['        ||
            rcRecord.CONTRACTOR_ID          || '] Canal de venta ['     ||
            rcRecord.RECEPTION_TYPE_ID        || '] Artículo ['           ||
            rcRecord.ARTICLEACT             || '] Línea ['              ||
            rcRecord.LINE_ID                || '] Sublínea ['           ||
            rcRecord.SUBLINE_ID             || '] Unidad operativa ['   ||
            rcRecord.OPERATING_UNIT_ID      || '] Fecha ['              ||
            SYSDATE );

      END IF;

      IF rcCommission(nuIndex).INCLU_VAT_RECO_COMMI = 'Y' THEN
        nuCalcValue := (rcCommission(nuIndex).RECOVERY_PERCENTAGE *
                        ( rcRecord.value + rcRecord.iva ) * rcRecord.amount ) / 100;
      ELSE
        nuCalcValue := (rcCommission(nuIndex).RECOVERY_PERCENTAGE *
                        (rcRecord.value * rcRecord.amount)) / 100;
      END IF;

      IF nuSw = 0 THEN

        nuLiquidSellerId := Ld_Bcliquidationminute.FnuGetLiqSellerIdByOrder(inuOrder_id,
                                                                            'P');

        IF nuLiquidSellerId IS NULL THEN

          nuLiquidSellerId := pkgeneralservices.fnuGetNextSequenceVal('SEQ_LD_LIQUIDATION_SELLER'); --ld_bosequence.fnuSeqLiquidationSeller;

          /*Insert tabla liquidacion vendedor*/
          LD_BCLIQUIDATIONMINUTE.InsertLiquidationSeller(inuliquidation_seller_id => nuLiquidSellerId,
                                                         idtdate_liquidation      => SYSDATE,
                                                         isbstatus                => 'P', --COBRO COMISIÿN A PROVEEDOR - FNB
                                                         idtdate_suspension       => rcCommission(nuIndex)
                                                                                     .INITIAL_DATE,
                                                         isbproduct_id            => rcRecord.financier_id,
                                                         inuOrder_id              => inuOrder_id,
                                                         inuPackage_id            => rcRecord.PACKAGE_ID,
                                                         inucontratista           => rcRecord.CONTRACTOR_ID);
        END IF;

        nuSw := 1;

      END IF;

      IF NOT  -- tal vez toque quitar esta validacion
          Ld_Bcliquidationminute.FblExistDetaLiqSeller(inuLiqSe => nuLiquidSellerId,
                                                       inuOrder => rcRecord.order_id,
                                                       inuArtic => rcRecord.ARTICLEACT) THEN

        /*Insert tabla detalle liquidacion */
        LD_BCLIQUIDATIONMINUTE.InsertDetailLiquiSeller(inudetail_liqui_seller_id => pkgeneralservices.fnuGetNextSequenceVal('SEQ_LD_DETAIL_LIQUI_SELLER'), --ld_bosequence.fnuSeqDetailLiquiSeller,--
                                                       inuconcept_id             => rcRecord.CONCEPT_ID,
                                                       inupercentage_liquidation => rcCommission(nuIndex)
                                                                                    .RECOVERY_PERCENTAGE,
                                                       inuvalue_paid             => nuCalcValue,
                                                       inuarticle_id             => rcRecord.ARTICLEACT,
                                                       inucontractor_id          => rcRecord.contractor_id,
                                                       inuliquidation_seller_id  => nuLiquidSellerId,
                                                       inuOrder_id               => rcRecord.order_id,
                                                       inuValueBase              => rcRecord.value *
                                                                                    rcRecord.amount,
                                                       isbInclVatReco            => rcCommission(nuIndex)
                                                                                    .INCLU_VAT_RECO_COMMI);

      END IF;

      nuCalcFin := nuCalcFin + nuCalcValue;

      nuCountOrderLiqu := nuCountOrderLiqu + cnuOneNumber;

    END LOOP;

    CLOSE frfResult;

    ut_trace.trace('Final Ld_Boliquidationminute.GetCommission', 10);
    return nuCalcFin;

  EXCEPTION
    when LOGIN_DENIED OR pkConstante.exERROR_LEVEL2 OR ex.CONTROLLED_ERROR then
        raise;
    when OTHERS then
        Errors.SetError;
        raise ex.CONTROLLED_ERROR;
  END GetCommission;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : GetCommissionSale
  Descripcion    : A partir del la orden de venta genera la comision.

  Autor          : AAcuna
  Fecha          : 22/02/2013

  Parametros           Descripcion
  ============         ===================
  inuOrder_id          Numero de orden.

    Historia de Modificaciones
    Fecha       Autor                   Modificacion
    =========   =========               ====================
    05-09-2013  llopez.SAO214246        Se modifica para enviar el contratista o
                                        el proveedor segun la clasificación de la UdT
    04-09-2013  lfernandez.SAO214404    Se eliminan parámetros código y mensaje
                                        de error. Se genera error si no
                                        encuentra configuración en ld_commission
  ******************************************************************/
  FUNCTION GetCommissionSale
  (
    inuOrder_id  IN or_order.order_id%TYPE
  )
  RETURN number
  IS
    ------------------------------------------------------------------------
    --  Variables
    ------------------------------------------------------------------------
    rcRecord        rfOrder;
    rcCommission    tytbLD_Commission;
    frfResult       constants.tyrefcursor;
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
  BEGIN

    ut_trace.trace('Inicia Ld_Boliquidationminute.GetCommissionSale', 10);

    frfResult := Ld_BcLiquidationMinute.FrfGetOrderArticlesSold(
                                        inuInputActivity_id  => cnuActTypSaleCom, -- Orden de Comision al Vendedor
                                        inuOutputActivity_id => cnuActTypDeliv, -- Orden de entrega
                                        inuOrder             => inuOrder_id);

    LOOP
      FETCH frfResult INTO rcRecord;
      EXIT WHEN frfResult%NOTFOUND;

      --IDENTIFICA ORDEN DE VENTA
      NUORDSALE := Ld_bccancellations.fnugetsaleorder(rcRecord.package_id,
                                                      null);

      --IDENTIFICA CONTRATISTA QUE VENDE
      nuVendedorCont := DAOR_OPERATING_UNIT.fnuGetContractor_Id(
                    DAOR_ORDER.fnuGetOperating_Unit_Id(NUORDSALE, 0), 0);

      -- asigno el proveedor del articulo a procesar
      nuSupplierId := rcRecord.CONTRACTOR_ID;

      -- si el proveedor es diferente de quien vende, quien vendio es un contratistas
      nuContractorId :=null;
      if (nuSupplierId <> nuVendedorCont) then
          nuContractorId := nuVendedorCont;
      END if;

      nuAddressId := daor_order.fnugetexternal_address_id(rcRecord.order_id, 0);
      nuGeograpId := ge_bogeogra_location.fnuGetGeo_LocaByAddress(nuAddressId, AB_BOConstants.csbToken_LOCALIDAD);

      LD_BOLIQUIDATIONMINUTE.GetConfCommissionsupplier(inuGeoLocId     => nuGeograpId,
                                                       inuContractorId => nuContractorId,
                                                       inuSaleChannel  => rcRecord.RECEPTION_TYPE_ID,
                                                       inuArticleId    => rcRecord.ARTICLEACT,
                                                       inuLineId       => rcRecord.LINE_ID,
                                                       inuSublineId    => rcRecord.SUBLINE_ID,
                                                       inuSupplierId   => nuSupplierId,
                                                       idtInitDate     => SYSDATE,
                                                       orcCommission   => rcCommission);

      if ((rcCommission.first is null) OR (nuGeograpId <> nvl(rcCommission(rcCommission.first).geograp_location_id, -1))) then
        nuGeograpId := ge_bogeogra_location.fnuGetGeo_LocaByAddress(nuAddressId, AB_BOConstants.csbToken_DEPARTAMENTO);
        LD_BOLIQUIDATIONMINUTE.GetConfCommissionsupplier(inuGeoLocId     => nuGeograpId,
                                                         inuContractorId => nuContractorId,
                                                         inuSaleChannel  => rcRecord.RECEPTION_TYPE_ID,
                                                         inuArticleId    => rcRecord.ARTICLEACT,
                                                         inuLineId       => rcRecord.LINE_ID,
                                                         inuSublineId    => rcRecord.SUBLINE_ID,
                                                         inuSupplierId   => nuSupplierId,
                                                         idtInitDate     => SYSDATE,
                                                         orcCommission   => rcCommission);
      end if;

      nuIndex := rcCommission.FIRST;

      /*Si la configuracion no trae resultados no debe liquidar*/
      IF nuIndex IS NULL THEN

        GE_BOErrors.SetErrorCodeArgument(
            2741,
            'No existe configuracion de comisiones para los criterios Ubicación [' ||
            rcRecord.GEOLOC_ABADDRESS       || '] Contratista ['        ||
            rcRecord.CONTRACTOR_ID          || '] Canal de venta ['     ||
            rcRecord.RECEPTION_TYPE_ID      || '] Artículo ['           ||
            rcRecord.ARTICLEACT             || '] Línea ['              ||
            rcRecord.LINE_ID                || '] Sublínea ['           ||
            rcRecord.SUBLINE_ID             || '] Unidad operativa ['   ||
            rcRecord.OPERATING_UNIT_ID      || '] Fecha ['              ||
            SYSDATE );

      END IF;

      IF rcCommission(nuIndex).INCLU_VAT_PAY_COMMI = 'Y' THEN
        nuCalcValue := (rcCommission(nuIndex).PYMENT_PERCENTAGE *
                        ( rcRecord.value + rcRecord.iva ) * rcRecord.amount ) / 100;
      ELSE
        nuCalcValue := (rcCommission(nuIndex).PYMENT_PERCENTAGE *
                        (rcRecord.value * rcRecord.amount)) / 100;
      END IF;

      IF nuSw = 0 THEN

        nuLiquidSellerId := Ld_Bcliquidationminute.FnuGetLiqSellerIdByOrder(inuOrder_id,
                                                                            'V');

        IF nuLiquidSellerId IS NULL THEN

          nuLiquidSellerId := pkgeneralservices.fnuGetNextSequenceVal('SEQ_LD_LIQUIDATION_SELLER'); --ld_bosequence.fnuSeqLiquidationSeller;

          /*Insert tabla liquidacion vendedor*/
          LD_BCLIQUIDATIONMINUTE.InsertLiquidationSeller(inuliquidation_seller_id => nuLiquidSellerId,
                                                         idtdate_liquidation      => SYSDATE,
                                                         isbstatus                => 'V', --PAGO DE COMISIÿN CONTRATISTA - FNB
                                                         idtdate_suspension       => rcCommission(nuIndex)
                                                                                     .INITIAL_DATE,
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
                                                       inupercentage_liquidation => rcCommission(nuIndex)
                                                                                    .PYMENT_PERCENTAGE,
                                                       inuvalue_paid             => nuCalcValue,
                                                       inuarticle_id             => rcRecord.ARTICLEACT,
                                                       inucontractor_id          => rcRecord.CONTRACTOR_ID,
                                                       inuliquidation_seller_id  => nuLiquidSellerId,
                                                       inuOrder_id               => rcRecord.order_id,
                                                       inuValueBase              => rcRecord.value *
                                                                                    rcRecord.amount,
                                                       isbInclVatReco            => rcCommission(nuIndex)
                                                                                    .INCLU_VAT_RECO_COMMI);
      END IF;

      nuCalcFin := nuCalcFin + nuCalcValue;

      nuCountOrderLiqu := nuCountOrderLiqu + cnuOneNumber;

    END LOOP;

    CLOSE frfResult;

    ut_trace.trace('Final Ld_Boliquidationminute.GetCommissionSale', 10);
    RETURN nuCalcFin;

  EXCEPTION
    when LOGIN_DENIED OR pkConstante.exERROR_LEVEL2 OR ex.CONTROLLED_ERROR then
        raise;
    when OTHERS then
        Errors.SetError;
        raise ex.CONTROLLED_ERROR;
  END GetCommissionSale;

BEGIN
  -- Initialization
  NULL;
END LD_BOLIQUIDATIONMINUTE;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LD_BOLIQUIDATIONMINUTE', 'ADM_PERSON'); 
END;
/
GRANT EXECUTE on ADM_PERSON.LD_BOLIQUIDATIONMINUTE to EXEBRILLAAPP;
/
GRANT EXECUTE on ADM_PERSON.LD_BOLIQUIDATIONMINUTE to REXEREPORTES;
/
