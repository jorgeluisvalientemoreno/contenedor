CREATE OR REPLACE package LDC_BcFinanceOt is

  /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : LDC_BcFinanceOt
    Descripcion    : Paquete donde se implementa la lógica para financiar actividades
                     durante la legalización.(Revisión Periódica & Servicios de Ingeniería)
    Autor          : Sayra Ocoro
    Fecha          : 24/05/2013

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============  ===================


    Historia de Modificaciones
    Fecha           Autor                   Modificacion
    =========       =========               ====================
    05/12/2014      JCarmona.CAMBIO5648     Modificación método <GetFinanCondbyProd>.
    05/12/2014      JCarmona.CAMBIO5648     Creación método <fnuValReconexion>.
  ******************************************************************/

  /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : prFinanceOt
    Descripcion    : Procedimiento donde se implementa la lógica para financiar actividades
                     durante la legalización.
    Autor          : Sayra Ocoro
    Fecha          : 24/05/2013

    Nombre         :
    Parametros         Descripcion
    ============  ===================


    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
  ******************************************************************/

procedure prFinanceOt;

/*****************************************************************
Propiedad intelectual de PETI (c).

Unidad         : prFinanceOt
Descripcion    : Procedimiento donde se implementa la lógica obtener las condiciones de financiación
				 de acuerdo con la configuración realizada en PCFR
Autor          : Sayra Ocoro
Fecha          :14/06/2013

Nombre         :
Parametros         Descripcion
============  ===================


Historia de Modificaciones
Fecha             Autor             Modificacion
=========         =========         ====================
******************************************************************/
Procedure GetFinanCondbyProd
(
  inuOrderId         in   or_order.order_id%type,
  inuPackageId       in   mo_packages.package_id%type,
	onuFinanPlanId     out  plandife.pldicodi%type,
	onuQuotasNumber    out  plandife.pldicuma%type
);

/*****************************************************************
Propiedad intelectual de PETI (c).

Unidad         : UpdateOrdersFinancing
Descripcion    : Procedimiento donde se implementa la lógica del objeto de legalización
                 de la actividad de apoyo para actualizar condiciones de financiación.
Autor          : Sayra Ocoro
Fecha          :06/09/2013

Nombre         :
Parametros         Descripcion
============  ===================

Historia de Modificaciones
Fecha             Autor             Modificacion
=========         =========         ====================
******************************************************************/
PROCEDURE prUpdateOrdersFinancing;

/*****************************************************************
Propiedad intelectual de PETI (c).

Unidad         : fnuGetActivityId
Descripcion    : Función para obtener el identificador de la actidad con menor order_activity_id
                 dado el identificador de la orden y de la solicitud.
Autor          : Sayra Ocoro
Fecha          :24/10/2013

Nombre         :
Parametros         Descripcion
============  ===================


Historia de Modificaciones
Fecha             Autor             Modificacion
=========         =========         ====================
******************************************************************/
function fnuGetActivityId
(
  inuOrderId         in   or_order.order_id%type
) return number;


/***************************************************************************
Función que devuelve la versión del pkg
***************************************************************************/
FUNCTION fsbVersion RETURN VARCHAR2;

    /**************************************************************************
      Autor       : Jorge Alejandro Carmona Duque
      Fecha       : 05/12/2014
      Descripcion : Valida si la orden de reconexión asociada a la solicitud debe
                    ser cobrada al cliente como una reconexión desde Centro de
                    Medición o desde Acometida.

     HISTORIA DE MODIFICACIONES
     FECHA          AUTOR                   DESCRIPCION
     05/12/2014     JCarmona.CAMBIO5648     Creación.
    ***************************************************************************/
    FUNCTION fnuValReconexion
    (
        inuProductId    in  OR_order_activity.product_id%type,
        inuPackageId    in  OR_order_activity.package_id%type
    )
    RETURN number;

end LDC_BcFinanceOt;
/
CREATE OR REPLACE package body      LDC_BcFinanceOt is

CSBVERSION                CONSTANT        varchar2(40)  := '5648';
  /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : LDC_BcFinanceOt
    Descripcion    : Paquete donde se implementa la lógica para financiar actividades
                     durante la legalización.(Revisión Periódica y Servicios de Ingeniería)
    Autor          : Sayra Ocoro
    Fecha          : 24/05/2013

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============  ===================


    Historia de Modificaciones
    Fecha             Autor                 Modificacion
    =========         =========             ====================
    05/12/2014      JCarmona.CAMBIO5648     Modificación método <GetFinanCondbyProd>.
    05/12/2014      JCarmona.CAMBIO5648     Creación método <fnuValReconexion>.
    11-11-2013      Sayra Ocoró             fnuGetActivityId:  Se modifica el cursor para obtener el order_activity_id
                                            con menor rowid para una ot dada.
  ******************************************************************/

  /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : prFinanceOt
    Descripcion    : Procedimiento donde se implementa la lógica para financiar actividades
                     durante la legalización.
    Autor          : Sayra Ocoro
    Fecha          : 24/05/2013

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============  ===================


    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
  ******************************************************************/

procedure prFinanceOt
is
    -- Actividad de Orden
    rcSalesFinanCond    DACC_Sales_Financ_Cond.styCC_Sales_Financ_Cond;
    nuInterestPerc      cc_Sales_Financ_Cond.interest_percent%type;
    rcFinanPlan         plandife%rowtype;
    onuFinanPlanId      plandife.pldicodi%type;
      onuQuotasNumber     plandife.pldicuma%type;
    nuQuotasNumber     plandife.pldicuma%type;

    nuOrderId or_order.order_id%type;
    inuPackageID mo_packages.package_id%type;
    onuFinanId diferido.difecodi%type;
    nuCount number := 0;
    nuPackageTypeId ps_package_type.package_type_id%type;

    --Cursor para validar si la orden que se está legalizando tiene una orden de apoyo para condiciones de financiación asociada
    cursor cuIsFinanced(
           inuOrderId or_order.order_id%type
    ) is
    select count(*)
     from or_order_activity
     where order_id = inuOrderId
     and or_order_activity.activity_id = DALD_parameter.fnuGetNumeric_Value('ID_ACT_ACTUALIZA_COND_FINANC');


    nuControl number := 0;

    nuCausalId ge_causal.causal_id%type;
    nuCausalClassId ge_class_causal.class_causal_id%type;
begin

  ut_trace.trace('Inicio LDC_BcFinanceOt.prFinanceOt', 10);
  --Obtener el identificador de la orden  que se encuentra en la instancia
  nuOrderId := or_bolegalizeorder.fnuGetCurrentOrder;
  ut_trace.trace('Ejecucion LDC_BcFinanceOt.prFinanceOt => nuOrderId=>'||nuOrderId, 10);
  --Obtener causal de legalización
  nuCausalId := to_number(LDC_BOUTILITIES.fsbGetValorCampoTabla ('or_order','order_id','causal_id',nuOrderId));
  ut_trace.trace('Ejecucion LDC_BcFinanceOt.prFinanceOt => nuCausalId=>'||nuCausalId, 10);
  --Obtener tipo de causal
  nuCausalClassId := dage_causal.fnugetclass_causal_id(nuCausalId);
  ut_trace.trace('Ejecucion LDC_BcFinanceOt.prFinanceOt => nuCausalClassId=>'||nuCausalClassId, 10);

  --VALIDAR SI LA CAUSAL DE LEGALIZACION ES EXITOSA
  if nuCausalClassId = 1 then
      --Obtener identificador de la solicitud
      inuPackageID := to_number(LDC_BOUTILITIES.fsbGetValorCampoTabla('or_order_activity','order_id','package_id',nuOrderId));
      ut_trace.trace('Ejecucion LDC_BcFinanceOt.prFinanceOt => inuPackageID=>'||inuPackageID, 10);
      if inuPackageID is null or inuPackageID = -1 then
                ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                                 'No existe una solicitud asociada a la órden '||nuOrderId);
                raise ex.CONTROLLED_ERROR;
      end if;
      --Obtener tipo de paquete
      nuPackageTypeId := to_number(LDC_BOUTILITIES.fsbGetValorCampoTabla('mo_packages','package_id','package_type_id',inuPackageID));
      ut_trace.trace('Ejecucion LDC_BcFinanceOt.prFinanceOt => nuPackageTypeId=>'||nuPackageTypeId, 10);
      if nuPackageTypeId is null or nuPackageTypeId = -1 then
                ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                                 'No existe un tipo de solicitud asociado a la solicitud '||inuPackageID);
                raise ex.CONTROLLED_ERROR;
      end if;
      --Buscar si existe configuración en PCFO
      --Obtener el número de cuotas de acuerdo con la
      --configuración realizada para el valor de la Ot y el plan de financiación
      GetFinanCondbyProd (nuOrderId,inuPackageID,onuFinanPlanId, onuQuotasNumber);
      ut_trace.trace('Ejecucion LDC_BcFinanceOt.prFinanceOt => onuFinanPlanId - onuQuotasNumber =>'||onuFinanPlanId||' - '||onuQuotasNumber, 10);
      --Validar si existe una configuració aplicable
      IF onuFinanPlanId IS NOT NULL AND onuQuotasNumber IS NOT NULL THEN
            --Validar si tiene OT de poyo
            open cuIsFinanced(nuOrderId);
            fetch cuIsFinanced into nuCount;
            close cuIsFinanced;
            if nuCount > 0 then
                  --Obtener las n cuotas de CC_Sales_Financ_Cond
                  nuQuotasNumber := DACC_Sales_Financ_Cond.Fnugetquotas_Number(inuPackageID);
                  --Validar el número de de cuotas
                  if  (nuQuotasNumber > onuQuotasNumber) then
                      ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                             'El número de cuotas establecido excede el limite permitido');
                      raise ex.CONTROLLED_ERROR;
                  end if;
                  --Validar que
                  --Obtener el plan de financiacion de la configuración
                  onuQuotasNumber := nuQuotasNumber;
                  --Actualizar condiciones de financiación
            end if;
            --Obtiene la información del plan
            rcFinanPlan := pkTblPlandife.frcGetRecord(onuFinanPlanId);
            --Obtiene el porcentaje de interés
            nuInterestPerc := fnuGetInterestRate(rcFinanPlan.plditain,SYSDATE);
            ut_trace.trace('Ejecucion LDC_BcFinanceOt.prFinanceOt => nuInterestPerc =>'||nuInterestPerc, 10);
            --Actualiza los campos CC_SALES_FINANC_COND
            rcSalesFinanCond.package_id := inuPackageID;
            rcSalesFinanCond.financing_plan_id := onuFinanPlanId;
            rcSalesFinanCond.compute_method_id := pktblplandife.fnugetpaymentmethod(onuFinanPlanId);
            rcSalesFinanCond.interest_rate_id :=  pktblplandife.fnugetinterestratecod(onuFinanPlanId);
            rcSalesFinanCond.first_pay_date := sysdate;
            rcSalesFinanCond.percent_to_finance := 100;
            rcSalesFinanCond.interest_percent := nuInterestPerc;
            rcSalesFinanCond.spread := 0;
            rcSalesFinanCond.quotas_number := onuQuotasNumber;
            rcSalesFinanCond.tax_financing_one := 'N';
            rcSalesFinanCond.value_to_finance := 0;
            rcSalesFinanCond.document_support := 'OR-'||nuOrderId;
            rcSalesFinanCond.initial_payment := 0;
            rcSalesFinanCond.average_quote_value := 0;

            --Validar si para la solicitud ya se definieron conticiones de financiación
            if not dacc_sales_financ_cond.fblexist(inuPackageID) then
                --Inserta la información de las condiciones
                DACC_Sales_Financ_Cond.insrecord(rcSalesFinanCond);
            else
                --Actualizar la información de las condiciones
                 DACC_Sales_Financ_Cond.Updrecord(rcSalesFinanCond);
            end if;
       ELSE
        --Error
            ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                             'No se configuraron condiciones de financiación para la solicitud '||inuPackageID);
            raise ex.CONTROLLED_ERROR;
       END IF;
       --Validar si el flujo del tipo de solicitud valida si se exoneraron los cobros
       if not instr(DALD_PARAMETER.fsbGetValue_Chain('ID_PKG_TYPE_RP_SI'),to_char(nuPackageTypeId)) > 0 then
            ut_trace.trace('pagarcia: entro', 10);
            --Generar una factura con los cargos a la cuenta de cobro -1 generados por la legalización de la orden (estos se identifican
            --porque en la tabla CARGOS, en la tabla CARGDOSO tienen el prefijo "PP" mas el número de la solicitud), usando el método:
            --Donde inuPackageID es un parámetro de entrada que hace referencia al número de la solicitud padre de la orden de trabajo
            CC_BOACCOUNTS.GENERATEACCOUNTBYPACK(inuPackageID);
            ut_trace.trace('pagarcia: Ejecucion LDC_BcFinanceOt.prFinanceOt => onuFinanId =>'||onuFinanId, 10);
            --Realizar la financiación de la factura mediante el método:
            --Donde inuPackageID es un parámetro de entrada que hace referencia al número de la solicitud padre de la orden de trabajo
            --y onuFinanId es el numero de la financiación generada.
            --FI_BOFINANCVENTAPRODUCTOS.FINANCIARFACTURAVENTA(inuPackageID,onuFinanId);
            cc_bofinancing.financingorder(inuPackageID);
            ut_trace.trace('pagarcia: Ejecucion LDC_BcFinanceOt.prFinanceOt => onuFinanId =>'||onuFinanId, 10);
       end if;
   end if;
   ut_trace.trace('Fin LDC_BcFinanceOt.prFinanceOt', 10);
 EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
end prFinanceOt;

/*****************************************************************
Propiedad intelectual de PETI (c).

Unidad         : prFinanceOt
Descripcion    : Procedimiento donde se implementa la lógica obtener las condiciones de financiación
                 de acuerdo con la configuración realizada en PCFR
Autor          : Sayra Ocoro
Fecha          :14/06/2013

Nombre         :
Parametros         Descripcion
============  ===================

Historia de Modificaciones
Fecha             Autor             Modificacion
=========         =========         ====================
26/06/2014      Katherine Cienfuegos  Se agrega el cursor cuCostItem
                                    para obtener el valor de la actividad
                                    principal. (NC378)

04/08/2014      Jhon Jairo Soto       Se agrega cursor para obtener el valor
                                    de la orden en cambio del paquete de 1 nivel.
                                    (NC 878)  Rollout
05/12/2014      JCarmona.CAMBIO5648 Se modifica para que valide si durante la
                                    legalización de la reconexión, se legalizó el
                                    item "4295053 - Reconexión desde Acometida con
                                    Conector" con cantidad 1, y de ser así, cobrar
                                    la reconexión desde Acomentida como si fuera
                                    una reconexión desde CM.

******************************************************************/
Procedure GetFinanCondbyProd
(
  inuOrderId         in   or_order.order_id%type,
  inuPackageId       in   mo_packages.package_id%type,
    onuFinanPlanId     out  plandife.pldicodi%type,
    onuQuotasNumber    out  plandife.pldicuma%type
)
is
  nuOrderValue or_order.order_value%type := 0;
  -- Producto
    cnuProductID   or_order_activity.product_id%type;

    -- Tipo de Actividad
    nuActivityId          ge_items.items_id%type;

  nuNeighborthoodId   ab_address.neighborthood_id%type;
    nuAdressId          pr_product.address_id%type;
    nuGeograpLoca       ab_address.geograp_location_id%type;
  nuGeograpDepto      ab_address.geograp_location_id%type;
  nuGeograpPais       ab_address.geograp_location_id%type;
    nuCategoryId        servsusc.sesucate%type;
    nuSubcategory       servsusc.sesusuca%type;
    rcRecoFinanCond     ldc_finan_cond%rowtype;
    CURSOR cuFinanCond(
         inuActivityId ge_items.items_id%type,
         isbLocation varchar2,
         inuCateId number,
         inuSucaId number,
         inuOrderValue or_order.order_value%type
  ) IS
    SELECT  *
    FROM    ldc_finan_cond
    WHERE   reco_activity = inuActivityId
            AND geo_location_id in (SELECT TO_NUMBER(COLUMN_VALUE)
                                FROM TABLE(LDC_BOUTILITIES.SPLITSTRINGS(isbLocation,',')))
            AND category_id = inuCateId
            AND subcategory_id = inuSucaId
      and inuOrderValue between nvl(ldc_finan_cond.min_value,0) and nvl(ldc_finan_cond.max_value, 999999999);

  /*Cursor para obtener el valor de la orden por ítem NC 378*/
  cursor cuCostItem is
    select nvl(c.sales_value,0)
      from open.ge_unit_cost_ite_lis c
     where c.items_id = nuActivityId;

  /* Cursor para obtener el valor de la orden  NC 878   */
  cursor cuOrderValue (inuOrderId1   or_order.order_id%type)is
   SELECT sum ( nvl(or_order_items.total_price, 0) ) value
   FROM or_order_items
   WHERE or_order_items.order_id = inuOrderId1
   AND or_order_items.out_ = 'Y';

  sbLocation            varchar2(2000);
  rcOrderActivity       OR_BCOrderActivities.tyrcOrderActivities;

  cnuActRecCM           constant ld_parameter.numeric_value%type := dald_parameter.fnuGetNumeric_Value('LDC_ACT_RECONE_CM',0);
  cnuActRecACO          constant ld_parameter.numeric_value%type := dald_parameter.fnuGetNumeric_Value('LDC_ACT_RECONE_ACOM',0);

begin
        UT_Trace.Trace('Inicio LDC_BcFinanceOt.GetFinanCondbyProd',5);

       --Obtener actividad principal de la ot
        nuActivityId := daor_order_activity.fnugetactivity_id( fnuGetActivityId(inuOrderId));   --or_bolegalizeorder.prget--rcOrderActivity.nuOrderActivity;
        ut_trace.trace('Ejecucion LDC_BcFinanceOt.GetFinanCondbyProd => nuActivityId=>'||nuActivityId, 10);

        --Obtener valor de la ot a financiar
        -- Inicio NC 878
        nuOrderValue := nvl(daor_order.fnugetorder_value(inuOrderId),0);

        if nuOrderValue = 0 then
          open cuOrderValue(inuOrderId);
          fetch cuOrderValue into nuOrderValue;
          close cuOrderValue;
        end if;
        -- Fin NC 878

        ut_trace.trace('Ejecucion LDC_BcFinanceOt.GetFinanCondbyProd => nuOrderValue=>'||nuOrderValue, 10);

        /*Inicio: Obtener el valor de la actividad principal NC378*/
        if nuOrderValue = 0 then
          open cuCostItem;
          fetch cuCostItem into nuOrderValue;
          close cuCostItem;
          ut_trace.trace('Ejecucion LDC_BcFinanceOt.GetFinanCondbyProd => nuOrderValue=>'||nuOrderValue, 10);
        end if;
        /*Fin NC378*/
        --Obtener el producto
        cnuProductID := to_number(ldc_boutilities.fsbgetvalorcampostabla('or_order_activity','order_id','product_id',inuOrderId,'package_id',inuPackageId));
          ut_trace.trace('Ejecucion LDC_BcFinanceOt.GetFinanCondbyProd => cnuProductID=>'||cnuProductID, 10);
          --Obener la dirección del producto
        nuAdressId    := dapr_product.fnugetaddress_id(cnuProductID);
        ut_trace.trace('Ejecucion LDC_BcFinanceOt.GetFinanCondbyProd => nuAdressId=>'||nuAdressId, 10);
        --Obtener el barrio
        nuNeighborthoodId := daab_address.fnugetneighborthood_id(nuAdressId);
        sbLocation := nuNeighborthoodId||',';
        ut_trace.trace('Ejecucion LDC_BcFinanceOt.GetFinanCondbyProd => nuNeighborthoodId=>'||nuNeighborthoodId, 10);
        --Obtener la localidad
        nuGeograpLoca := daab_address.fnugetgeograp_location_id(nuAdressId);
        sbLocation := sbLocation||nuGeograpLoca||',';
        ut_trace.trace('Ejecucion LDC_BcFinanceOt.GetFinanCondbyProd => nuGeograpLoca =>'||nuGeograpLoca, 10);
            --Obtener el Depto
        nuGeograpDepto := dage_geogra_location.fnugetgeo_loca_father_id(nuGeograpLoca);
        sbLocation := sbLocation||nuGeograpDepto||',';
        ut_trace.trace('Ejecucion LDC_BcFinanceOt.GetFinanCondbyProd => nuGeograpDepto =>'||nuGeograpDepto, 10);
        --Obtener Pais
        --Obtener categoría y subcategoria
        nuGeograpPais := dage_geogra_location.fnugetgeo_loca_father_id(nuGeograpDepto);
        sbLocation := sbLocation||nuGeograpPais;
        ut_trace.trace('Ejecucion LDC_BcFinanceOt.GetFinanCondbyProd => nuGeograpPais =>'||nuGeograpPais, 10);
        nuCategoryId  := pktblservsusc.fnugetcategory(cnuProductID);
        nuSubcategory := pktblservsusc.fnugetsubcategory(cnuProductID);

        UT_Trace.Trace('Ejecucion LDC_BcFinanceOt.GetFinanCondbyProd => sbLocation => '||sbLocation,5);
        UT_Trace.Trace('Ejecucion LDC_BcFinanceOt.GetFinanCondbyProd['||nuGeograpLoca||']['||nuCategoryId||']['||nuSubcategory||']',5);

        rcRecoFinanCond := NULL;

        IF nuActivityId = cnuActRecACO AND fnuValReconexion(cnuProductID,inuPackageId) > ld_boconstans.cnuCero THEN
            nuActivityId := cnuActRecCM;
            -- Busca si existe un criterio que coincida con la ubicacion geografica, categoría
            --y subcategoría del producto
            OPEN cuFinanCond(nuActivityId,sbLocation,nuCategoryId,nuSubcategory, nuOrderValue);
                FETCH cuFinanCond INTO rcRecoFinanCond;
            CLOSE cuFinanCond;

            IF rcRecoFinanCond.rec_finan_cond_id IS NULL THEN
                  /* Se busca configuración por ubicacion geografica y  Categoría*/
                  OPEN cuFinanCond(nuActivityId, sbLocation,nuCategoryId,-1,nuOrderValue);
                  FETCH cuFinanCond INTO rcRecoFinanCond;
                  CLOSE cuFinanCond;
                  IF  rcRecoFinanCond.rec_finan_cond_id IS NULL THEN
                      /* Se busca configuración por ubicacion geografica*/
                      OPEN cuFinanCond(nuActivityId, sbLocation,-1,-1,nuOrderValue);
                      FETCH cuFinanCond INTO rcRecoFinanCond;
                      CLOSE cuFinanCond;
                  END IF;
            END IF;

            /* Si el registro no es nulo se asigna condiciones de Financiación */
            IF rcRecoFinanCond.rec_finan_cond_id IS NOT NULL THEN
                onuFinanPlanId  :=  rcRecoFinanCond.finan_plan_id;
                onuQuotasNumber :=  rcRecoFinanCond.quotas_number;
            END IF;

        ELSE
            /* Busca si existe un criterio que coincida con la ubicacion geografica, categoría
            y subcategoría del producto */
            OPEN cuFinanCond(nuActivityId,sbLocation,nuCategoryId,nuSubcategory, nuOrderValue);
                FETCH cuFinanCond INTO rcRecoFinanCond;
            CLOSE cuFinanCond;

            IF  rcRecoFinanCond.rec_finan_cond_id IS NULL THEN
                  /* Se busca configuración por ubicacion geografica y  Categoría*/
                  OPEN cuFinanCond(nuActivityId, sbLocation,nuCategoryId,-1,nuOrderValue);
                  FETCH cuFinanCond INTO rcRecoFinanCond;
                  CLOSE cuFinanCond;
                  IF  rcRecoFinanCond.rec_finan_cond_id IS NULL THEN
                      /* Se busca configuración por ubicacion geografica*/
                      OPEN cuFinanCond(nuActivityId, sbLocation,-1,-1,nuOrderValue);
                      FETCH cuFinanCond INTO rcRecoFinanCond;
                      CLOSE cuFinanCond;
                  END IF;
            END IF;

            /* Si el registro no es nulo se asigna condiciones de Financiación */
            IF rcRecoFinanCond.rec_finan_cond_id IS NOT NULL THEN
                onuFinanPlanId  :=  rcRecoFinanCond.finan_plan_id;
                onuQuotasNumber :=  rcRecoFinanCond.quotas_number;
            END IF;

        END IF;

        UT_Trace.Trace('Fin LDC_BcFinanceOt.GetFinanCondbyProd',5);
        EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
 end GetFinanCondbyProd;

/*****************************************************************
Propiedad intelectual de PETI (c).

Unidad         : prUpdateOrdersFinancing
Descripcion    : Procedimiento donde se implementa la lógica del objeto de legalización
                 de la actividad de apoyo para actualizar condiciones de financiación.
Autor          : Sayra Ocoro
Fecha          : 06/09/2013

Nombre         :
Parametros         Descripcion
============  ===================

Historia de Modificaciones
Fecha             Autor             Modificacion
=========         =========         ====================
******************************************************************/
PROCEDURE prUpdateOrdersFinancing
    IS

        rcOrderActivity     OR_BCOrderActivities.tyrcOrderActivities;

        rcFinancingPlan         plandife%rowtype;

        sbValue                 varchar2(4000);
        -- Número de cuotas de planes de financiación
        csbNUM_QUOTAS       constant        varchar2(30) := 'NUM_QUOTAS';
        cnuQUOTAS_ERROR         constant  number := 902083;

         -- El plan de financiación [%s1] no permite financiar el 100% de la deuda
         cnuNO100FINANCIANG       constant number(6)  := 901052;

        /***************************************************************************/
        /**  Procedimiento para Crear Condiciones de Finanaciación       **/
        /***************************************************************************/

        PROCEDURE CreatePackFinanCond
        IS

            rcFinancingConditions   dacc_sales_financ_cond.styCC_sales_financ_cond;
            nuDifeCofi              diferido.difecofi%type;
        BEGIN

           UT_Trace.Trace( 'Inicio ldc_bcfinanceot.prUpdateOrdersFinancing.CreatePackFinanCond', 11 );

            -- Información de las condiciones de finanaciación diferido
            /* Se asigna el consecutivo de financiación */
               pkDeferredMgr.nuGetNextFincCode( nuDifeCofi );
            rcFinancingConditions.finan_id             := nuDifeCofi;
            rcFinancingConditions.PACKAGE_ID           := rcOrderActivity.nuPackageId;
            rcFinancingConditions.FINANCING_PLAN_ID    := rcFinancingPlan.Pldicodi;
            rcFinancingConditions.COMPUTE_METHOD_ID    := rcFinancingPlan.pldimccd;
            rcFinancingConditions.INTEREST_RATE_ID     := rcFinancingPlan.plditain;
            rcFinancingConditions.FIRST_PAY_DATE       := trunc( sysdate );
            rcFinancingConditions.PERCENT_TO_FINANCE   := rcFinancingPlan.PLDIPMAF;
            rcFinancingConditions.INTEREST_PERCENT     := pkEffectiveInterestRateMgr.fnuInteresRateValue( rcFinancingPlan.plditain, sysdate );
            rcFinancingConditions.SPREAD               := rcFinancingPlan.PLDISPMI;
            rcFinancingConditions.QUOTAS_NUMBER        := to_number( sbValue ); -- Número de cuotas de las instancia
            rcFinancingConditions.TAX_FINANCING_ONE    := CC_BOConstants.csbNO;
            rcFinancingConditions.VALUE_TO_FINANCE     := pkBillConst.CERO; --nugVlrFinanciable;
            rcFinancingConditions.DOCUMENT_SUPPORT     := CC_BOConstants.csbSEPDOCPAYMENT;
            rcFinancingConditions.INITIAL_PAYMENT      := pkBillConst.CERO; --nugVlrNoFinanciableCargos;

          DACC_Sales_Financ_Cond.insRecord( rcFinancingConditions );

          UT_Trace.Trace( 'Fin ldc_bcfinanceot.prUpdateOrdersFinancing.CreatePackFinanCond', 11 );

        EXCEPTION
            when OTHERS then
                Errors.SetError;
                raise ex.CONTROLLED_ERROR;

        END CreatePackFinanCond;
        -------------------------------------------------------------
    BEGIN

        ut_trace.Trace('INICIO: ldc_bcFinanceOt.UpdateOrdersFinancing',10);

        -- Obtiene el registro de la actividad actual
        OR_BOLegalizeActivities.GetActivityRecord(rcOrderActivity);

        -- Valida que exista la solicitud
        damo_packages.AccKey(rcOrderActivity.nuPackageId);

        -- Obtiene el valor del campo en la instancia ('NUM_QUOTAS', actividad de la orden)
        sbValue := or_boinstanceactivities.fsbGetAttributeValue(csbNUM_QUOTAS, rcOrderActivity.nuOrderActivity);
        ut_trace.trace('sbValue '||sbValue, 3);

        --Valida si se encontró un valor para el número de cuotas
        if ( sbValue IS null) then
            --Muestra mensaje de error indicando que el número de cuotas es requerido
            ut_trace.trace('Error, número de cuotas null', 3);
            Errors.SetError(cnuQUOTAS_ERROR);
            raise ex.CONTROLLED_ERROR;
        END if;

        -- Valida que la solicitud tiene condiciones de financiación
        IF  not (dacc_sales_financ_cond.fblExist(rcOrderActivity.nuPackageId)) THEN

            -- Obtiene el producto asociado a la actividad de la orden. (1)
            IF  (rcOrderActivity.nuProductId IS NULL) THEN

                -- Valida si el motivo es no nulo.
                IF  (rcOrderActivity.nuMotiveId IS NOT NULL) THEN

                    -- Obtiene el producto asociado al motivo. (2)
                    rcOrderActivity.nuProductId := damo_motive.fnuGetProduct_Id(rcOrderActivity.nuMotiveId);

                END IF;

            END IF;

            -- Obtiene el contrato asociado a la actividad de la orden. (1)
            IF  (rcOrderActivity.nuSubscriptionId IS NULL) THEN

                -- Valida si el producto es no nulo.
                IF  (rcOrderActivity.nuProductId IS NOT NULL) THEN

                    -- Obtiene el contrato asociado al producto. (2)
                    rcOrderActivity.nuSubscriptionId    := dapr_product.fnuGetSubscription_Id(rcOrderActivity.nuProductId);

                -- Valida si el motivo es no nulo.
                ELSIF (rcOrderActivity.nuMotiveId IS NOT NULL) THEN

                    -- Obtiene el contrato asociado al motivo. (3)
                    rcOrderActivity.nuSubscriptionId    := damo_motive.fnuGetSubscription_Id(rcOrderActivity.nuMotiveId);

                END IF;

            END IF;

            -- Obtiene el plan de financiación.
            rcFinancingPlan := CC_BOFinancing.frcBestFinancingPlan
            (
                inuSubscriptionID=>rcOrderActivity.nuSubscriptionId,
                inuProductID=>rcOrderActivity.nuProductId
            );

            -- Valida que el plan de financiación permita financiar el 100%
            if (rcFinancingPlan.pldipmaf < 100) then

                -- Levanta la excepcion
                ge_boerrors.SetErrorCodeArgument(cnuNO100FINANCIANG, rcFinancingPlan.PLDICODI);

            end if;

            -- Crea el registro de las condiciones de financiación de la solicitud
            CreatePackFinanCond;

        END IF;

        ut_trace.Trace('FIN: ldc_bcFinanceOt.UpdateOrdersFinancing',11);

    EXCEPTION
        when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 or ex.CONTROLLED_ERROR then
            raise;
        when OTHERS then
            Errors.SetError;
            raise ex.CONTROLLED_ERROR;
    END prUpdateOrdersFinancing;

/*****************************************************************
Propiedad intelectual de PETI (c).

Unidad         : fnuGetActivityId
Descripcion    : Función para obtener el identificador de la actidad con menor order_activity_id
                 dado el identificador de la orden y de la solicitud.
Autor          : Sayra Ocoro
Fecha          :24/10/2013

Nombre         :
Parametros         Descripcion
============  ===================


Historia de Modificaciones
Fecha             Autor             Modificacion
=========         =========         ====================
11-11-2013       Sayra Ocoró     * fnuGetActivityId:  Se modifica el cursor para obtener el order_activity_id
                                 con menor rowid para una ot dada.
11-12-2013       Sayra Ocoró     * Se modifica el cursor para solucionar la NC 2158

19-03-2013       Sayra Ocoró     *Aranda 3150:Se modifica el cursor cuActivityId para adicionarle filtro por el campo STATUS

******************************************************************/
function fnuGetActivityId
(
  inuOrderId         in   or_order.order_id%type
) return number
is
 cursor cuActivityId
 is
 SELECT order_activity_id
 FROM or_order_activity
 WHERE  order_id = inuOrderId
        AND register_date = (SELECT min (or_order_activity.register_date)
                              FROM or_order_activity, open.or_order_items
                              WHERE or_order_activity.order_id = inuOrderId
                               and or_order_items.order_items_id = or_order_activity.order_item_id
                            and or_order_items.legal_item_amount <> -1
                            );
 /*select order_activity_id
  from or_order_activity
       where order_id = inuOrderId
        and rownum = 1
      order by or_order_activity.register_date asc;*/


  nuActivityId            or_order_activity.order_activity_id%type;
begin
  open cuActivityId;
  fetch cuActivityId into nuActivityId;
  if cuActivityId%notfound then
     nuActivityId := -1;
  end if;
  close cuActivityId;
  return nuActivityId;
end fnuGetActivityId;


/*Función que devuelve la versión del pkg*/
FUNCTION fsbVersion RETURN VARCHAR2 IS
BEGIN
     return CSBVERSION;
END FSBVERSION;

    /**************************************************************************
      Autor       : Jorge Alejandro Carmona Duque
      Fecha       : 05/12/2014
      Descripcion : Valida si la orden de reconexión asociada a la solicitud debe
                    ser cobrada al cliente como una reconexión desde Centro de
                    Medición o desde Acometida.

     HISTORIA DE MODIFICACIONES
     FECHA          AUTOR                   DESCRIPCION
     05/12/2014     JCarmona.CAMBIO5648     Creación.
    ***************************************************************************/
    FUNCTION fnuValReconexion
    (
        inuProductId    in  OR_order_activity.product_id%type,
        inuPackageId    in  OR_order_activity.package_id%type
    )
    RETURN number
    IS

        sbItemsReconexionCM varchar2(4000) := '|'||dald_parameter.fsbGetValue_Chain('LDC_ITEMS_RECONEXION_CM',0)||'|';
        nuReconexionCM number;

        CURSOR cuValReconexion
        (
            nuProductId    in  OR_order_activity.product_id%type,
            nuPackageId    in  OR_order_activity.package_id%type
        )
        IS
            SELECT  count(1)
            FROM    OR_order_activity a,
                    OR_order_items b
            WHERE   a.order_id = b.order_id
            AND     a.ORDER_activity_id = b.ORDER_activity_id
            AND     a.product_id = nuProductId
            AND     a.package_id = nuPackageId
            AND     instr(sbItemsReconexionCM,'|'||b.items_id||'|') > 0
            AND     b.legal_item_amount = ld_boconstans.cnuonenumber;

    BEGIN

        ut_trace.trace('Inicio Procedimiento LDC_BcFinanceOt.fnuValReconexion', 5);
        ut_trace.trace('Producto: '||inuProductId, 5);
        ut_trace.trace('Solicitud: '||inuPackageId, 5);

        -- Si el CURSOR está abierto, se cierra
        if cuValReconexion%isopen then
            close cuValReconexion;
        end if;

        -- Se crea un registro del CURSOR
        open cuValReconexion(inuProductId,inuPackageId);
            fetch cuValReconexion INTO nuReconexionCM;
        close cuValReconexion;

        ut_trace.trace('Fin Procedimiento LDC_BcFinanceOt.fnuValReconexion['||nuReconexionCM||']', 5);

        return nuReconexionCM;

    EXCEPTION

        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;

        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;

    END fnuValReconexion;

end LDC_BcFinanceOt;
/
GRANT EXECUTE on LDC_BCFINANCEOT to SYSTEM_OBJ_PRIVS_ROLE;
GRANT EXECUTE on LDC_BCFINANCEOT to REXEOPEN;
GRANT EXECUTE on LDC_BCFINANCEOT to RSELSYS;
GRANT EXECUTE on LDC_BCFINANCEOT to REXEGISOSF;
/
