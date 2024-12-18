CREATE OR REPLACE PACKAGE adm_person.LD_BCEXECCONUNISEGDEG Is
  /*****************************************************************
  Propiedad intelectual de Open International Systems. (c).

  Package      : LD_BCEXECCONUNISEGDEG
  Descripción  : Filtro de las ordenes legalizadas de unidades constructiva,
                 asi como el filtro de conexiones nuevas.

  Autor  : jvaliente Sincecomp.
  Fecha  : 28-08-2012 SAO SAO156931

  Historia de Modificaciones

  Historia de Modificaciones
  Fecha             <Autor>.SAONNNNN             Modificacion
  =========         ================         ====================
  19/06/2024        PAcosta                  OSF-2845: Cambio de esquema ADM_PERSON 
  ******************************************************************/

  -----------------------------------
  -- Metodos publicos del package
  -----------------------------------

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : fsbVersion
  Descripcion    : Obtiene la versión del paquete.
  Autor          : jvaliente
  Fecha          : 28/08/2012 SAO156931

  Parametros         Descripcion
  ============  ===================


  Historia de Modificaciones
  Fecha             <Autor>.SAONNNNN             Modificacion
  =========         ================         ====================
  ******************************************************************/
  FUNCTION fsbVersion return varchar2;

  /*****************************************************************
  Propiedad intelectual de Open International Systems. (c).

  Unidad         : ProLegalizedOrder
  Descripcion    : Retorna las ordenes de trabajo legalizadas con tipo
                        de trabajo asociadas a una unidad construtiva

  Autor          : jvaliente
  Fecha          : 14/08/2012 SAO156931

  Parametros                  Descripcion
  ============            ===================
  idtDate                 Fecha para filtrar las oredenes legalizadas
  inuOrderStatus          Estado de la Orden Legalizada
  inuItemClassif          Codigo de Clasificacion del Item
  otbOlegalizedorder      salidad de registros de las Ordenes legalizadas

  Historia de Modificaciones
  Fecha             <Autor>.SAONNNNN             Modificacion
  =========         ================         ====================
  ******************************************************************/
  PROCEDURE ProLegalizedOrder(idtDate            in OR_Order.Legalization_Date%TYPE,
                              inuOrderStatus     in OR_Order.Order_Status_Id%TYPE,
                              inuItemClassif     in GE_Items.Item_Classif_Id%TYPE,
                              otbOlegalizedOrder out constants.tyRefCursor);

  /*****************************************************************
  Propiedad intelectual de Open International Systems. (c).

  Unidad              : ProConsunitbudget
  Descripcion         : Retorna la unidad constructiva que está
                        definida en un presupuesto y asociada a la
                        misma ubicación geográfica en el mismo
                        año y mes de la orden legalizada,
                        con el fin de establecer si tiene o no
                        configurado un presupuesto y retornar este
                        ppresupuesto si esxite.

  Autor          : jvaliente
  Fecha          : 29/08/2012 SAO156931

  Parametros                  Descripcion
  ============            ===================
  idtDate                 Fecha de legalizacion de ordenes
  inuConstructUnitId      codigo de unidad constructiva
  inuGeograpLocationId    codigo de la ubicación geográfica
  orfConsunitbudget       Registro de la unidades constrcutivas ejecutadas

  Historia de Modificaciones
  Fecha             <Autor>.SAONNNNN             Modificacion
  =========         ================         ====================
  ******************************************************************/
  PROCEDURE ProConsunitbudget(idtDate              in OR_Order.Legalization_Date%TYPE,
                              inuConstructUnitId   in LD_Co_Un_Task_Type.Construct_Unit_Id %TYPE,
                              inuGeograpLocationId in GE_Geogra_Location.Geograp_Location_Id%TYPE,
                              orfConsunitbudget    out constants.tyRefCursor);

  /***************************************************************************
  Propiedad intelectual de Open International Systems. (c).

  Unidad              : ProRelMarkBudget
  Descripcion         : Retorna el registros del presupuesto del
                        mercado relevanteas para generar un presupuesto
                        no definido para una unidad constrcutiva legalizada
                        en un orden de trabajo.

  Autor          : jvaliente
  Fecha          : 08/09/2012 SAO156931

  Parametros                  Descripcion
  ============            ===================
  inuFecha   fecha del sistema
  INUGU      codigo de la ubicación geográfica
  ocuRelMarkBudget Retornar el presupuesto del mercado relevante

  Historia de Modificaciones
  Fecha             <Autor>.SAONNNNN             Modificacion
  =========         ================         ====================
  ******************************************************************/
  PROCEDURE ProRelMarkBudget(idtDate              in OR_Order.Legalization_Date%TYPE,
                             inuGeograpLocationId in GE_Geogra_Location.Geograp_Location_Id%TYPE, --código de la ubicación geográfica
                             orfRelMarkBudget     out constants.tyRefCursor);

  /*****************************************************************
  Propiedad intelectual de Open International Systems. (c).

  Procedure           : ProOrdenServicioGas
  Descripcion         : Retorna las órdenes de nuevas conexiones de gas
                        legalizadas por las gaseras en la fecha que se
                        ingrese (inuFecha). (Esto con relación al mismo
                        día que un proceso en Batch ejecuta este paquete).

  Autor          : jvaliente
  Fecha          : 03/09/2012 SAO156931

  Parametros                  Descripcion
  ============            ===================
  idtDate                 Fecha DE LEGALIZACION DE LA ORDEN DE TRABAJO.
  inuOrderStatusId        código que identifica cuando una orden está legalizada.
  isbTaskTypeIds          código del tipo de trabajo servicio de conexión de gas.
  orfOrdenServicioGas     salidad del registro del total de consumo

  csbVersion        Version del Paquete

  Autor     :       Sincecomp
  Fecha     :       03 de Septiembre de 2012

  Historia de Modificaciones
  Fecha             <Autor>.SAONNNNN             Modificacion
  =========         ================         ====================
  ******************************************************************/
  PROCEDURE ProOrdenServicioGas(idtDate             in OR_Order.LEGALIZATION_DATE%TYPE, --parámetro que manejara la fecha en el momento que se ejecute el método.
                                inuOrderStatusId    in OR_Order.ORDER_STATUS_ID%TYPE, --código que identifica cuando una orden está legalizada.
                                isbTaskTypeIds      in varchar2, --código del tipo de trabajo servicio de conexión de gas.
                                orfOrdenServicioGas out constants.tyRefCursor);

  /*****************************************************************
  Propiedad intelectual de Open International Systems. (c).

  Unidad              : ProServiceGasBudget
  Descripcion         : Retorna el registro de la categoría y subcategoría
                        con servicio de conexión de gas que tiene un
                        presupuesto definido en ese periodo determinado.

  Autor          : jvaliente
  Fecha          : 03/09/2012 SAO156931

  Parametros                  Descripcion
  ============            ===================
  idtDate                 Fecha de registro de servicio presupuestado
  inuCategoryId           código de la categoría
  inuSubcategoryId        código de la subcategoría
  inuGeograpLocationId    código de la ubicación geográfica
  otbServiceBudget        Regsitros de Servicio Presupuestado

  Historia de Modificaciones
  Fecha             <Autor>.SAONNNNN             Modificacion
  =========         ================         ====================
  ******************************************************************/
  PROCEDURE ProServiceGasBudget(idtDate              in OR_Order.Legalization_Date%TYPE, --Fecha con el que se obtendra el periodo delpresupuesto creado
                                inuCategoryId        in PR_Product.Category_Id%TYPE, --código de la categoría
                                inuSubcategoryId     in PR_Product.Subcategory_Id%TYPE, --código de la subcategoría
                                inuGeograpLocationId in GE_Geogra_Location.Geograp_Location_Id%TYPE, --código de la ubicación geográfica
                                otbServiceBudget     out constants.tyRefCursor);

  /*****************************************************************
  Propiedad intelectual de Open International Systems. (c).

  Unidad              : ProDemandGasBudget
  Descripcion         : Retorna la categoría y subcategoría del
                        presupuesto de demanda de gas y
                        definir si tiene asignado un presupuesto.

  Autor          : jvaliente
  Fecha          : 28/08/2012 SAO156931

  Parametros                  Descripcion
  ============            ===================
  idtDate                 Fecha de registro de demanda de gas presupuestada
  otbDemandgasbudget      salidad del registro del total de consumo

  Historia de Modificaciones
  Fecha             <Autor>.SAONNNNN             Modificacion
  =========         ================         ====================
  ******************************************************************/
  PROCEDURE ProDemandGasBudget(idtDate            in OR_Order.Legalization_Date%TYPE, -- parámetro que manejara la fecha en el momento que se ejecute el método.
                               otbDemandgasbudget out constants.tyRefCursor);

  /*****************************************************************
  Propiedad intelectual de Open International Systems. (c).

  Unidad              : ProConsesu
  Descripcion         : Retorna el valor total del consumo se gas
                        en una determinada categoria y subcategoria
                        de un año y mes determinado


  Autor          : jvaliente
  Fecha          : 28/08/2012 SAO156931

  Parametros                  Descripcion
  ============            ===================
  inuCat                  codigo de la categoría
  INUSUBCAT               codigo de la subcategoría
  inuAnno                 año del presupuesto
  inuMes                  mes del presupuesto
  otbOrdenserviciogas     salidad del registro del total de consumo

  Historia de Modificaciones
  Fecha             <Autor>.SAONNNNN             Modificacion
  =========         ================         ====================
  ******************************************************************/
  PROCEDURE ProConsesu(inuYear              in LD_Rel_Mark_Budget.Year %TYPE, --año del presupuesto
                       inuMonth             in LD_Rel_Mark_Budget.Month%TYPE, --mes del presupuesto
                       inuCategoryId        in PR_Product.Category_Id%TYPE, --código de la categoría
                       inuSubcategoryId     in PR_Product.Subcategory_Id%TYPE, --código de la subcategoría
                       inuGeograpLocationId in GE_Geogra_Location.Geograp_Location_Id%TYPE, --código de la ubicación geográfica
                       inuSeSuServ          in ServSusc.SeSuServ%TYPE, --código de la ubicación geográfica
                       onuTotal             out Ld_Demand_Budget.Executed_Amount%type);

  /*****************************************************************
  Propiedad intelectual de Open International Systems. (c).

  Procedure           : ProExecMeth
  Descripcion         : Este método permitirá controlar si el
                        proceso BATCH intenta ejecutar un método
                        nuevamente en la misma fecha de este paquete.

  Autor          : jvaliente
  Fecha          : 28/08/2012 SAO156931

  Parametros                  Descripcion
  ============            ===================
  idtDate                 Fecha de ejecucion del Metodo
  inuMethId               código del método.
  orfExecMeth             Regsitro del control de la entidad LD_Exec_Meth

  Historia de Modificaciones
  Fecha             <Autor>.SAONNNNN             Modificacion
  =========         ================         ====================
  ******************************************************************/
  PROCEDURE ProExecMeth(idtDate     in LD_Exec_Meth.Execute_Date%TYPE,
                        inuMethId   in LD_Exec_Meth.Meth_Id%TYPE,
                        orfExecMeth out constants.tyRefCursor);

  /**********************************************************************
   Propiedad intelectual de OPEN International Systems
   Nombre              fnuGetOrderCost

   Autor       Andrés Felipe Esguerra Restrepo

   Fecha               18-oct-2013

   Descripción         Obtiene el costo de una orden para unidades constructivas

   ***Parametros***
   Nombre        Descripción
   inuOrderId      ID de la orden
   isbItemClassif      Cadena con las clases de items a filtrar

  ***********************************************************************/
  FUNCTION fnuGetOrderCost(inuOrderId     in OR_order.order_id%type,
                           isbItemClassif in ld_parameter.value_chain%type)
    RETURN number;

End LD_BCExecConUniSegDeg;
/
CREATE OR REPLACE PACKAGE BODY adm_person.LD_BCEXECCONUNISEGDEG Is

  /*****************************************************************
  Propiedad intelectual de Open International Systems. (c).

  Package      : LD_BCEXECCONUNISEGDEG
  Descripción  : Filtro de las ordenes legalizadas de unidades constructiva,
                 asi como el filtro de conexiones nuevas.

  Autor  : jvaliente Sincecomp.
  Fecha  : 28-08-2012 SAO SAO156931

  Historia de Modificaciones

  Historia de Modificaciones
  Fecha             <Autor>.SAONNNNN             Modificacion
  =========         ================         ====================
  ******************************************************************/

  -----------------------
  -- Constants
  -----------------------
  -- Constante con el SAO de la ultima version aplicada
  csbVERSION CONSTANT VARCHAR2(10) := 'SAO220642';

  cnuSecondaryActivity constant ge_item_classif.item_classif_id%type := 51;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : fsbVersion
  Descripcion    : Obtiene la versión del paquete.
  Autor          : jvaliente
  Fecha          : 28/08/2012 SAO156931

  Parametros         Descripcion
  ============  ===================


  Historia de Modificaciones
  Fecha             <Autor>.SAONNNNN             Modificacion
  =========         ================         ====================
  ******************************************************************/
  FUNCTION fsbVersion RETURN varchar2 IS
  BEGIN
    pkErrors.Push('LD_BCExecConUniSegDeg.fsbVersion');
    pkErrors.Pop;
    -- Retorna el SAO con que se realizo la ultima entrega
    RETURN(csbVersion);
  END fsbVersion;

  /*****************************************************************
  Propiedad intelectual de Open International Systems. (c).

  Unidad         : ProLegalizedOrder
  Descripcion    : Retorna las ordenes de trabajo legalizadas con tipo
                        de trabajo asociadas a una unidad construtiva

  Autor          : jvaliente
  Fecha          : 14/08/2012 SAO156931

  Parametros                  Descripcion
  ============            ===================
  inuDate                 Fecha para filtrar las oredenes legalizadas
  inuOrderStatus          Estado de la Orden Legalizada
  inuItemClassif          Codigo de Clasificacion del Item
  otbOlegalizedorder      salidad de registros de las Ordenes legalizadas

  Historia de Modificaciones
  Fecha             <Autor>.SAONNNNN             Modificacion
  =========         ================         ====================
  ******************************************************************/
  PROCEDURE ProLegalizedOrder(idtDate            in OR_Order.Legalization_Date%TYPE,
                              inuOrderStatus     in OR_Order.Order_Status_Id%TYPE,
                              inuItemClassif     in GE_Items.Item_Classif_Id%TYPE,
                              otbOlegalizedOrder out constants.tyRefCursor) IS

  BEGIN
    ut_trace.Trace('INICIO LD_BCExecConUniSegDeg.ProLegalizedOrder', 10);

    OPEN otbOlegalizedorder FOR
      SELECT /*+ index (CUTT IX_LD_CO_UN_TASK_TYPE_01) USE_NL(OO OTTI) USE_NL(OO OOI) USE_NL(OOI GI) USE_NL(GI OTTI) USE_NL(CUTT OTTI) */
       ge.GEOGRAP_LOCATION_ID,
       OO.TASK_TYPE_ID,
       OO.ORDER_VALUE,
       CUTT.CONSTRUCT_UNIT_ID,
       (ooi.legal_item_amount / 1000) legal_item_amount, --ooi.legal_item_amount,
       oo.order_id
        FROM OR_ORDER            OO,
             ld_CO_UN_TASK_TYPE  CUTT,
             or_order_items      ooi,
             ge_items            gi,
             or_task_types_items otti,
             ab_address          ab,
             ge_geogra_location  ge
       WHERE OO.ORDER_STATUS_ID = inuOrderStatus
         AND OO.TASK_TYPE_ID = CUTT.Task_Type_ID
         AND TRUNC(Legalization_Date) = trunc(idtDate)
         AND ooi.order_id = oo.order_id
         AND ooi.items_id = gi.items_id
         AND gi.item_classif_id = inuItemClassif
         AND gi.items_id = otti.items_id
         AND otti.task_type_id = oo.task_type_id
         AND oo.external_address_id = ab.address_id
         AND ab.geograp_location_id = ge.geograp_location_id
       GROUP BY ge.GEOGRAP_LOCATION_ID,
                OO.TASK_TYPE_ID,
                OO.ORDER_VALUE,
                CUTT.CONSTRUCT_UNIT_ID,
                (ooi.legal_item_amount / 1000),
                oo.order_id
       ORDER BY ge.GEOGRAP_LOCATION_ID,
                OO.TASK_TYPE_ID,
                OO.ORDER_VALUE,
                CUTT.CONSTRUCT_UNIT_ID,
                (ooi.legal_item_amount / 1000);

    ut_trace.Trace('FIN LD_BCExecConUniSegDeg.ProLegalizedOrder', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;

    when others then
      errors.seterror;
      raise ex.CONTROLLED_ERROR;
  END ProLegalizedOrder;

  /*****************************************************************
  Propiedad intelectual de Open International Systems. (c).

  Unidad              : ProConsunitbudget
  Descripcion         : Retorna la unidad constructiva que está
                        definida en un presupuesto y asociada a la
                        misma ubicación geográfica en el mismo
                        año y mes de la orden legalizada,
                        con el fin de establecer si tiene o no
                        configurado un presupuesto y retornar este
                        ppresupuesto si esxite.

  Autor          : jvaliente
  Fecha          : 29/08/2012 SAO156931

  Parametros                  Descripcion
  ============            ===================
  idtDate                 Fecha de legalizacion de ordenes
  inuConstructUnitId      codigo de unidad constructiva
  inuGeograpLocationId    codigo de la ubicación geográfica
  orfConsunitbudget       Registro de la unidades constrcutivas ejecutadas

  Historia de Modificaciones
  Fecha             <Autor>.SAONNNNN             Modificacion
  =========         ================         ====================
  ******************************************************************/
  PROCEDURE ProConsunitbudget(idtDate              in OR_Order.Legalization_Date%TYPE,
                              inuConstructUnitId   in LD_Co_Un_Task_Type.Construct_Unit_Id %TYPE,
                              inuGeograpLocationId in GE_Geogra_Location.Geograp_Location_Id%TYPE,
                              orfConsunitbudget    out constants.tyRefCursor) IS

  BEGIN
    ut_trace.Trace('INICIO LD_BCExecConUniSegDeg.ProConsunitbudget', 10);

    ---consulta que cruza la entidad de presupuesto de mercado
    ---relevante con la entidad de presupuesto de unidad construciva
    ---filtrando por medio del año y mes de la orden legalizada
    OPEN orfConsunitbudget FOR
      SELECT /*+ index (LDC IX_LD_CON_UNI_BUDGET_01) */
       LDC.CON_UNI_BUDGET_ID,
       LDC.REL_MARK_BUDGET_ID,
       LDC.CONSTRUCT_UNIT_ID,
       LDC.Amount,
       LDC.Value_Budget_Cop,
       LDC.Amount_executed,
       LDC.Value_executed
        FROM LD_CON_UNI_BUDGET LDC, LD_REL_MARK_BUDGET LDR
       WHERE LDC.REL_MARK_BUDGET_ID = LDR.REL_MARK_BUDGET_ID
         AND LDC.CONSTRUCT_UNIT_ID = inuConstructUnitId
         AND LDR.Geograp_Location_Id = inuGeograpLocationId
         AND LDR.YEAR = to_number(to_char(idtDate, 'YYYY'))
         AND LDR.MONTH = to_number(to_char(idtDate, 'MM'));

    ut_trace.Trace('FIN LD_BCExecConUniSegDeg.ProConsunitbudget', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;

    when others then
      errors.seterror;
      raise ex.CONTROLLED_ERROR;
  END ProConsunitbudget;

  /*****************************************************************
  Propiedad intelectual de Open International Systems. (c).

  Unidad              : ProRelMarkBudget
  Descripcion         : Retorna el registros del presupuesto del
                        mercado relevanteas para generar un presupuesto
                        no definido para una unidad constrcutiva legalizada
                        en un orden de trabajo.

  Autor          : jvaliente
  Fecha          : 08/09/2012 SAO156931

  Parametros                  Descripcion
  ============            ===================
  inuFecha   fecha del sistema
  INUGU      codigo de la ubicación geográfica
  ocuRelMarkBudget Retornar el presupuesto del mercado relevante

  Historia de Modificaciones
  Fecha             <Autor>.SAONNNNN             Modificacion
  =========         ================         ====================
  ******************************************************************/
  PROCEDURE ProRelMarkBudget(idtDate              in OR_Order.Legalization_Date%TYPE,
                             inuGeograpLocationId in GE_Geogra_Location.Geograp_Location_Id%TYPE, --código de la ubicación geográfica
                             orfRelMarkBudget     out constants.tyRefCursor) IS

  BEGIN
    ut_trace.Trace('INICIO LD_BCExecConUniSegDeg.ProRel_Mark_Budget', 10);

    ---consulta que cruza la entidad de presupuesto de mercado
    ---relevante con la entidad de presupuesto de unidad construciva
    ---filtrando por medio del año y mes de la orden legalizada
    OPEN orfRelMarkBudget FOR
      SELECT /*+ index (LDR IX_LD_REL_MARK_BUDGET_01) */
       rel_mark_budget_id,
       relevant_market_id,
       geograp_location_id,
       year,
       month
        FROM LD_Rel_Mark_Budget LDR
       WHERE LDR.Geograp_Location_Id = inuGeograpLocationId
         AND LDR.year = to_number(to_char(idtDate, 'YYYY'))
         AND LDR.month = to_number(to_char(idtDate, 'MM'))
       GROUP BY rel_mark_budget_id,
                relevant_market_id,
                geograp_location_id,
                year,
                month;

    ut_trace.Trace('FIN LD_BCExecConUniSegDeg.ProRel_Mark_Budget', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;

    when others then
      errors.seterror;
      raise ex.CONTROLLED_ERROR;
  END ProRelMarkBudget;

  /*****************************************************************
  Propiedad intelectual de Open International Systems. (c).

  Unidad              : ProOrdenServicioGas
  Descripcion         : Retorna las órdenes de nuevas conexiones de gas
                        legalizadas por las gaseras en la fecha que se
                        ingrese (inuFecha). (Esto con relación al mismo
                        día que un proceso en Batch ejecuta este paquete).

  Autor          : jvaliente
  Fecha          : 03/09/2012 SAO156931

  Parametros                  Descripcion
  ============            ===================
  idtDate                 Fecha DE LEGALIZACION DE LA ORDEN DE TRABAJO.
  inuOrderStatusId        código que identifica cuando una orden está legalizada.
  isbTaskTypeIds          códigos de los tipos de trabajo servicio de conexión de gas.
  orfOrdenServicioGas     salidad del registro del total de consumo

  csbVersion        Version del Paquete

  Autor     :       Sincecomp
  Fecha     :       03 de Septiembre de 2012

  Historia de Modificaciones
  Fecha             <Autor>.SAONNNNN             Modificacion
  =========         ================         ====================
  20-08-2013        hveraSAO212714           Se modifica para consultar las ordenes
                                             teniendo en cuenta diferentes tipos de trabajo
                                             que estan en el parámetro isbTaskTypeIds
  01/10/2014        Jorge Valiente           NC2353: cambiar la forma de validar los tipos de trabajo cambio
                                                     la forma de ejecutar la sentecia de este servicio
                                                     el SAO hveraSAO212714 altero el comportamiento original
                                                     del desarrollo se debe establecer un nueva consulta ya que
                                                     la establecida por el SAO no aplica y genera errores en el JOB
  ******************************************************************/
  PROCEDURE ProOrdenServicioGas(idtDate             in OR_Order.Legalization_Date%TYPE, --parámetro que manejara la fecha en el momento que se ejecute el método.
                                inuOrderStatusId    in OR_Order.Order_Status_Id%TYPE, --código que identifica cuando una orden está legalizada.
                                isbTaskTypeIds      in varchar2, --códigos de los tipos de trabajo servicio de conexión de gas.
                                orfOrdenServicioGas out constants.tyRefCursor) IS
    sbSelect varchar2(4000);
    DTFECHA  DATE;
    SBFECHA  VARCHAR2(100);
  BEGIN
    ut_trace.Trace('INICIO LD_BCExecConUniSegDeg.ProOrdenServicioGas', 10);

    /* hveraSAO212714
    sbSelect := 'SELECT /*+ USE_NL (OO OOA) USE_NL (OOA PR) *
       PR.Category_Id,
       PR.Subcategory_Id,
       ge.Geograp_Location_Id,
       COUNT(PR.Category_Id) cantidad
        FROM OR_Order           OO,
             OR_Order_Activity  OOA,
             PR_Product         PR,
             ab_address         abad,
             ge_geogra_location ge
       WHERE OO.Order_Id = OOA.Order_Id' ||
                ' AND OO.Order_Status_Id = ' || inuOrderStatusId ||
                ' AND OO.Task_Type_Id in (' || isbTaskTypeIds || ')' ||
                ' AND OOA.Product_Id = PR.Product_Id
         AND PR.Address_Id = abad.address_id
         AND abad.geograp_location_id = ge.geograp_location_id
         AND trunc(Legalization_Date) = TRUNC(' || idtDate ||
                ') GROUP BY PR.Category_Id, PR.Subcategory_Id, ge.Geograp_Location_Id';

    OPEN orfOrdenServicioGas FOR sbSelect;
    --*/

    OPEN orfOrdenServicioGas FOR
      SELECT /*+ USE_NL (OO OOA) USE_NL (OOA PR) */
       PR.Category_Id,
       PR.Subcategory_Id,
       ge.Geograp_Location_Id,
       COUNT(PR.Category_Id) cantidad
        FROM OR_Order           OO,
             OR_Order_Activity  OOA,
             PR_Product         PR,
             ab_address         abad,
             ge_geogra_location ge
       WHERE OO.Order_Id = OOA.Order_Id
         AND OO.Order_Status_Id = inuOrderStatusId
         AND OO.Task_Type_Id in
             (select to_number(column_value)
                from table(ldc_boutilities.splitstrings(isbTaskTypeIds, ',')))
         AND OOA.Product_Id = PR.Product_Id
         AND PR.Address_Id = abad.address_id
         AND abad.geograp_location_id = ge.geograp_location_id
         AND trunc(Legalization_Date) = trunc(idtDate)
       GROUP BY PR.Category_Id, PR.Subcategory_Id, ge.Geograp_Location_Id;

    ut_trace.Trace('FIN LD_BCExecConUniSegDeg.ProOrdenServicioGas', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;

    when others then
      errors.seterror;
      raise ex.CONTROLLED_ERROR;
  END ProOrdenServicioGas;

  /*****************************************************************
  Propiedad intelectual de Open International Systems. (c).

  Unidad              : ProServiceGasBudget
  Descripcion         : Retorna el registro de la categoría y subcategoría
                        con servicio de conexión de gas que tiene un
                        presupuesto definido en ese periodo determinado.

  Autor          : jvaliente
  Fecha          : 03/09/2012 SAO156931

  Parametros                  Descripcion
  ============            ===================
  idtDate                 Fecha de registro de servicio presupuestado
  inuCategoryId           código de la categoría
  inuSubcategoryId        código de la subcategoría
  inuGeograpLocationId    código de la ubicación geográfica
  otbServiceBudget        Regsitros de Servicio Presupuestado

  Historia de Modificaciones
  Fecha             <Autor>.SAONNNNN             Modificacion
  =========         ================         ====================
  ******************************************************************/
  PROCEDURE ProServiceGasBudget(idtDate              in OR_Order.Legalization_Date%TYPE, --Fecha con el que se obtendra el periodo delpresupuesto creado
                                inuCategoryId        in PR_Product.Category_Id%TYPE, --código de la categoría
                                inuSubcategoryId     in PR_Product.Subcategory_Id%TYPE, --código de la subcategoría
                                inuGeograpLocationId in GE_Geogra_Location.Geograp_Location_Id%TYPE, --código de la ubicación geográfica
                                otbServiceBudget     out constants.tyRefCursor) IS
  BEGIN
    ut_trace.Trace('INICIO LD_BCExecConUniSegDeg.ProServiceGasBudget', 10);

    OPEN otbServiceBudget FOR
      SELECT /*+ USE_NL (LDS LDR) */
       LDS.Service_Budget_id,
       LDS.Rel_Mark_Budget_id,
       LDS.CateCodi,
       LDS.SuCaCodi,
       LDS.Budget_Amount,
       LDS.Executed_Amount
        FROM LD_SERVICE_BUDGET LDS, LD_Rel_Mark_Budget LDR
       WHERE LDS.Rel_Mark_Budget_ID = LDR.Rel_Mark_Budget_ID
         AND LDS.CateCodi = inuCategoryId
         AND LDS.SuCaCodi = inuSubcategoryId
         AND LDR.Geograp_Location_Id = inuGeograpLocationId
         AND LDR.YEAR = to_number(to_char(idtDate, 'YYYY'))
         AND LDR.MONTH = to_number(to_char(idtDate, 'MM'));

    ut_trace.Trace('FIN LD_BCExecConUniSegDeg.ProServiceGasBudget', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;

    when others then
      errors.seterror;
      raise ex.CONTROLLED_ERROR;
  END ProServiceGasBudget;

  /*****************************************************************
  Propiedad intelectual de Open International Systems. (c).

  Unidad              : ProDemandGasBudget
  Descripcion         : Retorna la categoría y subcategoría del
                        presupuesto de demanda de gas y
                        definir si tiene asignado un presupuesto.

  Autor          : jvaliente
  Fecha          : 28/08/2012 SAO156931

  Parametros                  Descripcion
  ============            ===================
  idtDate                 Fecha de registro de demanda de gas presupuestada
  otbDemandgasbudget      salidad del registro del total de consumo

  Historia de Modificaciones
  Fecha             <Autor>.SAONNNNN             Modificacion
  =========         ================         ====================
  ******************************************************************/
  PROCEDURE ProDemandGasBudget(idtDate            in OR_Order.Legalization_Date%TYPE, -- parámetro que manejara la fecha en el momento que se ejecute el método.
                               otbDemandgasbudget out constants.tyRefCursor) IS

  BEGIN
    ut_trace.Trace('INICIO LD_BCExecConUniSegDeg.ProDemandGasBudget', 10);

    OPEN otbDemandgasbudget FOR
      SELECT /*+ USE_NL (LDD LDR) */
       LDD.demand_budget_id,
       LDD.rel_mark_budget_id,
       LDD.Catecodi,
       LDD.Sucacodi,
       LDD.executed_amount,
       LDR.Year,
       LDR.Month,
       LDR.Geograp_Location_ID
        FROM LD_Demand_Budget LDD, LD_Rel_Mark_Budget LDR
       WHERE LDD.Rel_Mark_Budget_Id = LDR.Rel_Mark_Budget_Id
         AND LDR.Year = to_number(to_char(idtDate, 'YYYY'))
         AND LDR.Month = to_number(to_char(idtDate, 'MM'));

    ut_trace.Trace('FIN LD_BCExecConUniSegDeg.ProDemandGasBudget', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;

    when others then
      errors.seterror;
      raise ex.CONTROLLED_ERROR;
  END ProDemandGasBudget;

  /*****************************************************************
  Propiedad intelectual de Open International Systems. (c).

  Unidad              : ProConsesu
  Descripcion         : Retorna el valor total del consumo se gas
                        en una determinada categoria y subcategoria
                        de un año y mes determinado

  Autor          : jvaliente
  Fecha          : 28/08/2012 SAO156931

  Parametros                  Descripcion
  ============            ===================
  inuCat                  codigo de la categoría
  INUSUBCAT               codigo de la subcategoría
  inuAnno                 año del presupuesto
  inuMes                  mes del presupuesto
  otbOrdenserviciogas     salidad del registro del total de consumo

  Historia de Modificaciones
  Fecha             <Autor>.SAONNNNN             Modificacion
  =========         ================         ====================
  ******************************************************************/
  PROCEDURE ProConsesu(inuYear              in LD_Rel_Mark_Budget.Year %TYPE, --año del presupuesto
                       inuMonth             in LD_Rel_Mark_Budget.Month%TYPE, --mes del presupuesto
                       inuCategoryId        in PR_Product.Category_Id%TYPE, --código de la categoría
                       inuSubcategoryId     in PR_Product.Subcategory_Id%TYPE, --código de la subcategoría
                       inuGeograpLocationId in GE_Geogra_Location.Geograp_Location_Id%TYPE, --código de la ubicación geográfica
                       inuSeSuServ          in ServSusc.SeSuServ%TYPE, --código de la ubicación geográfica
                       onuTotal             out Ld_Demand_Budget.Executed_Amount%type) IS

  BEGIN
    ut_trace.Trace('INICIO LD_BCExecConUniSegDeg.ProConsesu', 10);

    ONUTOTAL := 0;

    SELECT /*+ index (CSS IX_CONSSESU09) index (CSS IX_CONSSESU09) USE_NL (SSU PP) USE_NL (AD GL) */
     SUM(cosscoca) cantidad
      INTO onuTotal
      from CONSSESU           CSS,
           SERVSUSC           SSU,
           suscripc,
           ge_subscriber,
           PR_PRODUCT         PP,
           ab_address         AD,
           GE_GEOGRA_LOCATION GL
     WHERE to_number(to_char(CSS.cossfere, 'YYYY')) = inuyear
       AND to_number(to_char(CSS.cossfere, 'MM')) = inumonth
       AND SSU.sesucate = inucategoryid
       AND SSU.sesusuca = inusubcategoryid
       AND SSU.sesunuse = CSS.COSSSESU
       AND CSS.COSSCOCA is not null
       AND suscripc.susccodi = SSU.sesususc
       AND ge_subscriber.subscriber_id = suscripc.suscclie
       and PP.PRODUCT_ID = SSU.sesunuse
       AND AD.address_id = PP.address_id
       AND AD.Geograp_Location_Id = GL.GEOGRAP_LOCATION_ID
       AND GL.geograp_location_id = inugeograplocationid
       AND SSU.sesuserv = inusesuserv;

    ut_trace.Trace('FIN LD_BCExecConUniSegDeg.ProConsesu', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;

    when others then
      errors.seterror;
      raise ex.CONTROLLED_ERROR;
  END ProConsesu;

  /*****************************************************************
  Propiedad intelectual de Open International Systems. (c).

  Procedure           : ProExecMeth
  Descripcion         : Este método permitirá controlar si el
                        proceso BATCH intenta ejecutar un método
                        nuevamente en la misma fecha de este paquete.

  Autor          : jvaliente
  Fecha          : 28/08/2012 SAO156931

  Parametros                  Descripcion
  ============            ===================
  idtDate                 Fecha de ejecucion del Metodo
  inuMethId               código del método.
  orfExecMeth             Regsitro del control de la entidad LD_Exec_Meth

  Historia de Modificaciones
  Fecha             <Autor>.SAONNNNN             Modificacion
  =========         ================         ====================
  ******************************************************************/
  PROCEDURE ProExecMeth(idtDate     in LD_Exec_Meth.Execute_Date%TYPE,
                        inuMethId   in LD_Exec_Meth.Meth_Id%TYPE,
                        orfExecMeth out constants.tyRefCursor) IS

  BEGIN
    ut_trace.Trace('INICIO LD_BCExecConUniSegDeg.ProExecMeth', 10);

    OPEN orfExecMeth FOR
      SELECT exec_meth_id, meth_id, execute_date, state, description, rowid
        FROM LD_Exec_Meth EXME
       WHERE EXME.Meth_Id = inuMethId
         AND trunc(EXME.execute_date) = trunc(idtDate);

    ut_trace.Trace('FIN LD_BCExecConUniSegDeg.ProExecMeth', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;

    when others then
      errors.seterror;
      raise ex.CONTROLLED_ERROR;
  END ProExecMeth;

  /**********************************************************************
    Propiedad intelectual de OPEN International Systems
    Nombre              fnuGetOrderCost

    Autor       Andrés Felipe Esguerra Restrepo

    Fecha               18-oct-2013

    Descripción         Obtiene el costo de una orden sumando los order items

    ***Parametros***
    Nombre        Descripción
    inuOrderId      ID de la orden a consultar

  ***********************************************************************/
  FUNCTION fnuGetOrderCost(inuOrderId     in OR_order.order_id%type,
                           isbItemClassif in ld_parameter.value_chain%type)
    RETURN number IS

    CURSOR cuItemValues(nuOrderId     OR_order.order_id%type,
                        sbItemClassif ld_parameter.value_chain%type) IS
      SELECT nvl(sum(value), 0)
        FROM OR_order_items ooi, ge_items gi
       WHERE ooi.items_id = gi.items_id
         AND instr(',' || sbItemClassif || ',',
                   ',' || gi.item_classif_id || ',') > 0
         AND ooi.order_id = nuOrderId;

    nuTotal number := 0;

  BEGIN
    ut_trace.trace('INICIO LD_BCExecConUniSegDeg.fnuGetOrderCost', 1);

    if cuItemValues%isopen then
      close cuItemValues;
    END if;

    open cuItemValues(inuOrderId, isbItemClassif);
    fetch cuItemValues
      INTO nuTotal;
    close cuItemValues;

    ut_trace.trace('FIN LD_BCExecConUniSegDeg.fnuGetOrderCost', 1);

    return nuTotal;

  END fnuGetOrderCost;

End LD_BCExecConUniSegDeg;
/
PROMPT Otorgando permisos de ejecucion a LD_BCEXECCONUNISEGDEG
BEGIN
    pkg_utilidades.praplicarpermisos('LD_BCEXECCONUNISEGDEG', 'ADM_PERSON');
END;
/
PROMPT Otorgando permisos de ejecucion sobre LD_BCEXECCONUNISEGDEG para reportes
GRANT EXECUTE ON adm_person.LD_BCEXECCONUNISEGDEG TO rexereportes;
/