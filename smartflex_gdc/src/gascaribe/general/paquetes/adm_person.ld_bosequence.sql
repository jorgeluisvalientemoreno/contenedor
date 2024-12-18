CREATE OR REPLACE PACKAGE adm_person.LD_BOSequence IS
  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Paquete        : LD_BOSequence
  Descripcion    : Paquete BC con las funciones y/o procedimientos
                   para el consultar mediante una ubicacion geografica
                   los mercados relevantes y la cantidad ejecutada de las
                   unidades constructivas. para la generacion de un archivo
                   excel atravez de un .NET

  Autor          : jvaliente Sincecomp.
  Fecha  : 06-09-2012   SAO156931

  Historia de Modificaciones

  Fecha        Autor<SAONNNN>     Modificacion
  =========    ===============    ====================

  15/07/2024   PAcosta            OSF-2885: Cambio de esquema ADM_PERSON  
  19-11-2013   sgomez.SAO223765   Se modifica forma de obtención de secuencia de
                                  pagaré digital, para utilizar modelo de
                                  numeración autorizada/distribución
                                  consecutivos.
                                  Por ende se elimina <fnuSeqDigitalPromisory>.

  ******************************************************************/

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : fsbVersion
  Descripcion    : Obtiene la version del paquete.
  Autor          : jvaliente
  Fecha          : 14/08/2012 SAO156931

  Parametros         Descripcion
  ============  ===================


  Historia de Modificaciones
  Fecha        Autor<SAONNNN>     Modificacion
  =========    =============      ====================
  ******************************************************************/
  FUNCTION FSBVERSION RETURN VARCHAR2;

  /**************************************************************
  Propiedad intelectual de Open International Systems (c).
  Unidad      :  FnuSeqConUniBudget
  Descripcion :  Retorna el numero de secuencia de la entidad LD_Con_Uni_Budget
                 para registrar un presupuesto de unidad constrcutiva no presupuestada.

  Autor          : jvaliente
  Fecha          : 18/09/2012 SAO156931

  Parametros                  Descripcion
  ============            ===================

  Historia de Modificaciones
  Fecha        Autor<SAONNNN>     Modificacion
  =========    =============      ====================
  ***************************************************************/
  Function FnuSeqConUniBudget RETURN number;

  /**************************************************************
  Propiedad intelectual de Open International Systems (c).
  Unidad               : FnuSeqOrderConsUnit
  Descripcion          : Retorna el numero de secuencia de la
                         entidad LD_Order_Cons_Unit.

  Autor          : jvaliente
  Fecha          : 18/09/2012 SAO156931

  Parametros                  Descripcion
  ============            ===================

  Historia de Modificaciones
  Fecha        Autor<SAONNNN>     Modificacion
  =========    =========          ====================
  ***************************************************************/
  Function FnuSeqExecMeth RETURN number;

  /*****************************************************************
  Propiedad intelectual de Open International Systems. (c).

  Procedure           : FnuSeqOrderConsUnit
  Descripcion         : Retorna el numero de secuencia de la
                        entidad LD_Order_Cons_Unit.

  Autor          : jvaliente
  Fecha          : 18/09/2012 SAO156931

  Parametros                  Descripcion
  ============            ===================

  Historia de Modificaciones
  Fecha        Autor<SAONNNN>     Modificacion
  =========    =========          ====================
  ******************************************************************/
  Function FnuSeqOrderConsUnit RETURN number;

  /*****************************************************************
  Propiedad intelectual de Open International Systems. (c).

  Procedure           : FnuSeqOrderConsUnit
  Descripcion         : Retorna el numero de secuencia de la
                        entidad LD_Order_Cons_Unit.

  Autor          : jvaliente
  Fecha          : 18/09/2012 SAO156931

  Parametros                  Descripcion
  ============            ===================

  Historia de Modificaciones
  Fecha        Autor<SAONNNN>     Modificacion
  =========    =========          ====================
  ******************************************************************/
  Function fnuSeqQuotaBlock RETURN number;

  /*****************************************************************
  Propiedad intelectual de Open International Systems. (c).

  Procedure           : fnuSeqQuotaBlock
  Descripcion         : Retorna el identificador de la tabla de solicitudes
  de venta.

  Autor          : eramos
  Fecha          : 18/09/2012 SAO156931

  Parametros                  Descripcion
  ============            ===================

  Historia de Modificaciones
  Fecha        Autor<SAONNNN>     Modificacion
  =========    =========          ====================
  ******************************************************************/
  Function fnuSeqFNBSale RETURN number;

  /*****************************************************************
  Propiedad intelectual de Open International Systems. (c).

  Procedure           : fnuSeqPolicy
  Descripcion         : Retorna el identificador de la tabla de polizas
  de venta.

  Autor          : AAcuna
  Fecha          : 11/10/2012 SAO147879

  Parametros                  Descripcion
  ============            ===================

  Historia de Modificaciones
  Fecha        Autor<SAONNNN>     Modificacion
  =========    =========          ====================
  ******************************************************************/
  Function fnuSeqPolicy RETURN number;

  /*****************************************************************
  Propiedad intelectual de Open International Systems. (c).

  Procedure           : fnuSeqLiquidation
  Descripcion         : Retorna el identificador de la liquidacion
  de venta.

  Autor          : AAcuna
  Fecha          : 11/10/2012 SAO147879

  Parametros                  Descripcion
  ============            ===================

  Historia de Modificaciones
  Fecha        Autor<SAONNNN>     Modificacion
  =========    =========          ====================
  ******************************************************************/
  Function fnuSeqLiquidation RETURN number;

  /*****************************************************************
  Propiedad intelectual de Open International Systems. (c).

  Procedure           : fnuSeqDetLiquidation
  Descripcion         : Retorna el identificador del detalle de la liquidacion
  de venta.

  Autor          : AAcuna
  Fecha          : 11/10/2012 SAO147879

  Parametros                  Descripcion
  ============            ===================

  Historia de Modificaciones
  Fecha        Autor<SAONNNN>     Modificacion
  =========    =========          ====================
  ******************************************************************/
  Function fnuSeqDetLiquidation RETURN number;

  /**************************************************************
  Propiedad intelectual de Open International Systems (c).
  Unidad      :  FnuSeqSubsidy
  Descripcion :  Retorna el numero de secuencia de la entidad de Subsidio (ld_subsidy).

  Autor          : jvaliente
  Fecha          : 18/09/2012 SAO156931

  Parametros                  Descripcion
  ============            ===================

  Historia de Modificaciones
  Fecha        Autor<SAONNNN>     Modificacion
  =========    =========          ====================
  ***************************************************************/
  Function FnuSeqSubsidy RETURN number;

  /**************************************************************
  Propiedad intelectual de Open International Systems (c).
  Unidad      :  FnuSeqUbication
  Descripcion :  Retorna el numero de secuencia de la entidad de Poblacion (Ld_Ubication).

  Autor          : jvaliente
  Fecha          : 14/10/2012 SAO156577

  Parametros                  Descripcion
  ============            ===================

  Historia de Modificaciones
  Fecha        Autor<SAONNNN>     Modificacion
  =========    =========          ====================
  ***************************************************************/
  Function FnuSeqUbication RETURN number;

  /**************************************************************
  Propiedad intelectual de Open International Systems (c).
  Unidad      :  FnuSeqSubsidyDetail
  Descripcion :  Retorna el numero de secuencia de la entidad Conceptos a Subsidiar (ld_subsidy_detail).

  Autor          : jvaliente
  Fecha          : 14/10/2012 SAO156577

  Parametros                  Descripcion
  ============            ===================

  Historia de Modificaciones
  Fecha        Autor<SAONNNN>     Modificacion
  =========    =========          ====================
  ***************************************************************/
  Function FnuSeqSubsidyDetail RETURN number;

  /**************************************************************
  Propiedad intelectual de Open International Systems (c).
  Unidad      :  FnuSeqSubsidyDetail
  Descripcion :  Retorna el numero de secuencia de la entidad Topes a Cobrar (Ld_Max_Recovery).

  Autor          : jvaliente
  Fecha          : 14/10/2012 SAO156577

  Parametros                  Descripcion
  ============            ===================

  Historia de Modificaciones
  Fecha        Autor<SAONNNN>     Modificacion
  =========    =========          ====================
  ***************************************************************/
  Function FnuSeqSeqMaxRecovery RETURN number;

  /*****************************************************************
  Propiedad intelectual de Open International Systems. (c).

  Procedure           : fnuSeqDetailLiquiSeller
  Descripcion         : Retorna el identificador de la tabla de detalles de liquidacion de proveedor.

  Autor          : eramos
  Fecha          : 23/10/2012 SAO139854

  Parametros                  Descripcion
  ============            ===================

  Historia de Modificaciones
  Fecha        Autor<SAONNNN>     Modificacion
  =========    =========          ====================
  ******************************************************************/
  Function fnuSeqDetailLiquiSeller RETURN number;

  /*****************************************************************
  Propiedad intelectual de Open International Systems. (c).

  Procedure           : fnuSeqLiquidationSeller
  Descripcion         : Retorna el identificador de la tabla de liquidacion de proveedor.

  Autor          : eramos
  Fecha          : 23/10/2012 SAO139854

  Parametros                  Descripcion
  ============            ===================

  Historia de Modificaciones
  Fecha        Autor<SAONNNN>     Modificacion
  =========    =========          ====================
  ******************************************************************/
  Function fnuSeqLiquidationSeller RETURN number;

  /*****************************************************************
  Propiedad intelectual de Open International Systems. (c).

  Procedure           : fnuSeqPriceListDeta
  Descripcion         : Retorna el identificador de la tabla Ld_Price_List_Deta.

  Autor          : jvaliente
  Fecha          : 23/10/2012 SAO139854

  Parametros                  Descripcion
  ============            ===================

  Historia de Modificaciones
  Fecha        Autor<SAONNNN>     Modificacion
  =========    =========          ====================
  ******************************************************************/
  Function fnuSeqPriceListDeta
    RETURN Ld_Price_List_Deta.Price_List_Deta_Id%type;

  /*****************************************************************
  Propiedad intelectual de Open International Systems. (c).

  Procedure           : fnuSeqPriceListDeta
  Descripcion         : Retorna el identificador de la tabla Ld_Propert_By_Article.

  Autor          : jvaliente
  Fecha          : 23/10/2012 SAO139854

  Parametros                  Descripcion
  ============            ===================

  Historia de Modificaciones
  Fecha        Autor<SAONNNN>     Modificacion
  =========    =========          ====================
  ******************************************************************/
  Function fnuSeqPropertArticle
    RETURN Ld_Propert_By_Article.Propert_By_Article_Id%type;

  /*****************************************************************
  Propiedad intelectual de Open International Systems. (c).

  Procedure           : fnuSeqQuotaBySubsc
  Descripcion         : Retorna el identificador de la tabla
                        ld_quota_by_subsc

  Autor          : eramos
  Fecha          : 23/10/2012 SAO139854

  Parametros                  Descripcion
  ============            ===================

  Historia de Modificaciones
  Fecha        Autor<SAONNNN>     Modificacion
  =========    =========          ====================
  ******************************************************************/
  Function fnuSeqQuotaBySubsc RETURN ld_quota_by_subsc.quota_by_subsc_id%type;

  /*****************************************************************
  Propiedad intelectual de Open International Systems. (c).

  Procedure           : fnuSeqCommission
  Descripcion         : Retorna el identificador de la tabla
                        ld_commission

  Autor          : eramos
  Fecha          : 23/10/2012 SAO139854

  Parametros                  Descripcion
  ============            ===================

  Historia de Modificaciones
  Fecha        Autor<SAONNNN>     Modificacion
  =========    =========          ====================
  ******************************************************************/
  Function fnuSeqCommission RETURN ld_commission.commission_id%type;

  /*****************************************************************
  Propiedad intelectual de Open International Systems. (c).

  Procedure           : fnuSeqAssigsub
  Descripcion         : Retorna el identificador de la tabla
                        ld_asig_subsidy

  Autor          : eramos
  Fecha          : 04/11/2012 SAO156577

  Parametros                  Descripcion
  ============            ===================

  Historia de Modificaciones
  Fecha        Autor<SAONNNN>     Modificacion
  =========    =========          ====================
  ******************************************************************/

  /*****************************************************************
  Propiedad intelectual de Open International Systems. (c).

  Procedure           : fnuSeqAssigsub
  Descripcion         : Retorna el identificador de la tabla
                        ld_asig_subsidy

  Autor          : eramos
  Fecha          : 04/11/2012 SAO156577

  Parametros                  Descripcion
  ============            ===================

  Historia de Modificaciones
  Fecha        Autor<SAONNNN>     Modificacion
  =========    =========          ====================
  ******************************************************************/
  Function fnuSeqAssigsub RETURN ld_asig_subsidy.asig_subsidy_id%type;

  /*****************************************************************
  Propiedad intelectual de Open International Systems. (c).

  Procedure           : fnuSeqItemWorkOrder
  Descripcion         : Retorna la secuencia de la tabla
                        ld_item_work_order

  Autor          : eramos
  Fecha          : 04/11/2012 SAO156577

  Parametros                  Descripcion
  ============            ===================

  Historia de Modificaciones
  Fecha        Autor<SAONNNN>     Modificacion
  =========    =========          ====================
  ******************************************************************/
  Function fnuSeqItemWorkOrder
    RETURN ld_item_work_order.item_work_order_id%type;

  /*****************************************************************
  Propiedad intelectual de Open International Systems. (c).

  Procedure           : fnuSeqMoveSub
  Descripcion         : Retorna la secuencia de la tabla
                        ld_Move_Sub

  Autor          : eramos
  Fecha          : 21/11/2012 SAO156577

  Parametros                  Descripcion
  ============            ===================

  Historia de Modificaciones
  Fecha        Autor<SAONNNN>     Modificacion
  =========    =========          ====================
  ******************************************************************/
  Function fnuSeqMoveSub RETURN ld_Move_Sub.Move_Sub_Id%type;

  /************************************************************************
  Propiedad intelectual de Open International Systems (c).

   Unidad         : Fnuseqsaleswithoutsub
   Descripcion    : Retorna la secuencia de la entidad
                    LD_SALE_WITHOUTSUBSIDY
   Autor          : jonathan alberto consuegra lara
   Fecha          : 07/12/2012

   Parametros       Descripcion
   ============     ===================

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   07/12/2012       jconsuegra.SAO156577  Creacion
  /*************************************************************************/
  Function Fnuseqsaleswithoutsub
    RETURN Ld_sales_withoutsubsidy.Sales_Withoutsubsidy_Id%type;

  /************************************************************************
  Propiedad intelectual de Open International Systems (c).

   Unidad         : Fnuseqsubidyconcept
   Descripcion    : Retorna la secuencia de la entidad
                    Ld_subsidy_concept
   Autor          : jonathan alberto consuegra lara
   Fecha          : 13/12/2012

   Parametros       Descripcion
   ============     ===================

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   13/12/2012       jconsuegra.SAO156577  Creacion
  /*************************************************************************/
  Function Fnuseqsubidyconcept
    RETURN Ld_subsidy_concept.Subsidy_concept_Id%type;

  /**************************************************************
  Propiedad intelectual de Open International Systems (c).
  Unidad               : FnuSeqRev_sub_audit
  Descripcion          : Retorna el numero de secuencia de la
                         entidad Ld_Rev_sub_audit.

  Autor          : Evens Herard Gorut - eherard
  Fecha          : 18/12/2012 SAOSAO156577

  Parametros                  Descripcion
  ============            ===================

  Historia de Modificaciones
  Fecha        Autor<SAONNNN>     Modificacion
  =========    =========          ====================
  ***************************************************************/
  Function FnuSeqRev_sub_audit Return Ld_Rev_sub_audit.Rev_Sub_Audit_Id%TYPE;

  /************************************************************************
  Propiedad intelectual de Open International Systems (c).

   Unidad         : Fnuseqld_sub_remain_deliv
   Descripcion    : Retorna la secuencia de la entidad
                    ld_sub_remain_deliv
   Autor          : jonathan alberto consuegra lara
   Fecha          : 11/01/2013

   Parametros       Descripcion
   ============     ===================

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   11/01/2013       jconsuegra.SAO156577  Creacion
  /*************************************************************************/
  Function Fnuseqld_sub_remain_deliv
    RETURN ld_sub_remain_deliv.sub_remain_deliv_id%type;
  /**************************************************************
  Propiedad intelectual de Open International Systems (c).
  Unidad               : FnuSeq_Ld_Record_Collect
  Descripcion          : Retorna el numero de secuencia del acta de cobro: Campo Ld_Asig_Subsidy.Record_Collect
                         .

  Autor          : Evens Herard Gorut - eherard
  Fecha          : 11/01/2013 SAOSAO156577

  Parametros                  Descripcion
  ============            ===================

  Historia de Modificaciones
  Fecha        Autor<SAONNNN>     Modificacion
  =========    =========          ====================
  ***************************************************************/
  Function FnuSeq_Ld_Record_Collect
    Return Ld_Asig_Subsidy.Record_Collect%TYPE;
  /**************************************************************
  Propiedad intelectual de Open International Systems (c).
  Unidad               : FnuSeq_Cha_Sta_Sub_Audi
  Descripcion          : Retorna el numero de secuencia de la entidad Ld_Cha_Sta_Sub_Audi
                         .

  Autor          : Evens Herard Gorut - eherard
  Fecha          : 11/01/2013 SAOSAO156577

  Parametros                  Descripcion
  ============            ===================

  Historia de Modificaciones
  Fecha        Autor<SAONNNN>     Modificacion
  =========    =========          ====================
  ***************************************************************/
  Function FnuSeq_Cha_Sta_Sub_Audi
    Return ld_Cha_Sta_Sub_Audi.Cha_Sta_Sub_Audi_Id%TYPE;
  /**************************************************************
  Propiedad intelectual de Open International Systems (c).
  Unidad               : FnuSeqtmp_max_recovery
  Descripcion          : Retorna el numero de secuencia de la entidad Ld_tmp_max_recovery
                         .

  Autor          : Evens Herard Gorut - eherard
  Fecha          : 23/01/2013 SAOSAO156577

  Parametros                  Descripcion
  ============            ===================

  Historia de Modificaciones
  Fecha        Autor<SAONNNN>     Modificacion
  =========    =========          ====================
  ***************************************************************/
  Function FnuSeqtmp_max_recovery
    Return ld_tmp_max_recovery.tmp_max_recovery_id%type;

  /************************************************************************
  Propiedad intelectual de Open International Systems (c).

   Unidad         : Fnuseqld_temp_clob_fact
   Descripción    : Retorna la secuencia de la entidad
                    ld_temp_clob_fact
   Autor          : jonathan alberto consuegra lara
   Fecha          : 18/02/2013

   Parámetros       Descripción
   ============     ===================

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   18/02/2013       jconsuegra.SAO156577  Creación
  /*************************************************************************/
  Function Fnuseqld_temp_clob_fact
    RETURN ld_temp_clob_fact.temp_clob_fact_id%type;

  /************************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Fnuseqge_subscriber
   Descripción    : Retorna la secuencia de la entidad
                    ge_subscriber
   Autor          : jonathan alberto consuegra lara
   Fecha          : 12/04/2013

   Parámetros       Descripción
   ============     ===================

   Historia de Modificaciones
   Fecha            Autor                 Modificación
   =========        =========             ====================
   12/04/2013       jconsuegra.SAO139854  Creación
  /*************************************************************************/
  Function Fnuseqge_subscriber RETURN ge_subscriber.subscriber_id%type;

  /************************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Fnuseqld_approve_sales_order
   Descripción    : Retorna la secuencia de la entidad
                    ld_approve_sales_order
   Autor          : AAcuna
   Fecha          : 17/04/2013

   Parámetros       Descripción
   ============     ===================

   Historia de Modificaciones
   Fecha            Autor                 Modificación
   =========        =========             ====================
   17/04/2013       AAcuna.SAO139854      Creación
  /*************************************************************************/

  Function Fnuseqld_approve_sales_order

   RETURN ld_approve_sales_order.Approve_Sales_Order_Id%type;

  /************************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Fnuseqld_bill_pending_payment
   Descripción    : Retorna la secuencia de la entidad
                    ld_bill_pending_payment
   Autor          : AAcuna
   Fecha          : 18/04/2013

   Parámetros       Descripción
   ============     ===================

   Historia de Modificaciones
   Fecha            Autor                 Modificación
   =========        =========             ====================
   18/04/2013       AAcuna.SAO139854      Creación
  /*************************************************************************/

  Function Fnuseqld_bill_pending_payment

   RETURN ld_bill_pending_payment.bill_pending_payment_id%type;

  /************************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Fnuseqld_return_item
   Descripción    : Retorna la secuencia de la entidad
                    ld_bill_pending_payment
   Autor          : AAcuna
   Fecha          : 31/05/2013

   Parámetros       Descripción
   ============     ===================

   Historia de Modificaciones
   Fecha            Autor                 Modificación
   =========        =========             ====================
   31/05/2013       AAcuna.SAO139854      Creación
  /*************************************************************************/

  Function Fnuseqld_return_item

   RETURN ld_return_item.return_item_id%type;

  /************************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Fnuseqld_return_item_detail
   Descripción    : Retorna la secuencia de la entidad
                    ld_return_item_detail
   Autor          : AAcuna
   Fecha          : 31/05/2013

   Parámetros       Descripción
   ============     ===================

   Historia de Modificaciones
   Fecha            Autor                 Modificación
   =========        =========             ====================
   31/05/2013       AAcuna.SAO139854      Creación
  /*************************************************************************/

  Function Fnuseqld_return_item_detail

   RETURN ld_return_item_detail.return_item_detail_id%type;

END LD_BOSequence;
/
CREATE OR REPLACE PACKAGE Body adm_person.LD_BOSequence IS
  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Paquete        : LD_BOSequence
  Descripcion    : Paquete para identificar los metodos que premitira realizar extraer
                   la secuencia el ID de las entidades de la LDC

  Autor          : jvaliente Sincecomp.
  Fecha          : 20-09-2012   SAO156931

  Historia de Modificaciones

  Fecha        Autor<SAONNNN>     Modificacion
  =========    =========          ====================
  19-11-2013   sgomez.SAO223765   Se modifica forma de obtención de secuencia de
                                  pagaré digital, para utilizar modelo de
                                  numeración autorizada/distribución
                                  consecutivos.
                                  Por ende se elimina <fnuSeqDigitalPromisory>.

  ******************************************************************/
  --------------------------------------------
  -- Constantes VERSION DEL PAQUETE
  --------------------------------------------
  csbVERSION CONSTANT VARCHAR2(10) := 'SAO223765';

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : fsbVersion
  Descripcion    : Obtiene la version del paquete.
  Autor          : jvaliente
  Fecha          : 14/08/2012 SAO156931

  Parametros         Descripcion
  ============  ===================


  Historia de Modificaciones
  Fecha             <Autor>.SAONNNNN             Modificacion
  =========         ================         ====================
  ******************************************************************/
  FUNCTION FSBVERSION RETURN VARCHAR2 IS
  BEGIN
    return CSBVERSION;
  END FSBVERSION;

  /**************************************************************
  Propiedad intelectual de Open International Systems (c).
  Unidad      :  FnuSeqConUniBudget
  Descripcion :  Retorna el numero de secuencia de la entidad LD_Con_Uni_Budget
                 para registrar un presupuesto de unidad constrcutiva no presupuestada.

  Autor          : jvaliente
  Fecha          : 18/09/2012 SAO156931

  Parametros                  Descripcion
  ============            ===================

  Historia de Modificaciones
  Fecha        Autor<SAONNNN>     Modificacion
  =========    =========          ====================
  ***************************************************************/
  Function FnuSeqConUniBudget RETURN number IS

    nuSeqConUniBudget LD_Con_Uni_Budget.Con_Uni_Budget_Id%TYPE;

  BEGIN
    ut_trace.Trace('INICIO LD_BOSequence.FnuSeqConUniBudget', 10);

    ---consulta que cruza la entidad de presupuesto de mercado
    ---relevante con la entidad de presupuesto de unidad construciva
    ---filtrando por medio del a?o y mes de la orden legalizada
    select SEQ_LD_CON_UNI_BUDGET.NEXTVAL into nuSeqConUniBudget from dual;
    RETURN(nuSeqConUniBudget);

    ut_trace.Trace('FIN LD_BOSequence.FnuSeqConUniBudget', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;

    when others then
      errors.seterror;
      raise ex.CONTROLLED_ERROR;
  END FnuSeqConUniBudget;

  /**************************************************************
  Propiedad intelectual de Open International Systems (c).
  Unidad               : FnuSeqExecMeth
  Descripcion          : Retorna el numero de secuencia de la
                         entidad LD_Exec_Meth para registrar
                         un metodo ejecutado.

  Autor          : jvaliente
  Fecha          : 18/09/2012 SAO156931

  Parametros                  Descripcion
  ============            ===================

  Historia de Modificaciones
  Fecha        Autor<SAONNNN>     Modificacion
  =========    =========          ====================
  ***************************************************************/
  Function FnuSeqExecMeth RETURN number IS

    nuSeqExecMeth Ld_Exec_Meth.Exec_Meth_Id%TYPE;

  BEGIN
    ut_trace.Trace('INICIO LD_BOSequence.FnuSeqExecMeth', 10);

    ---consulta que cruza la entidad de presupuesto de mercado
    ---relevante con la entidad de presupuesto de unidad construciva
    ---filtrando por medio del a?o y mes de la orden legalizada
    select SEQ_LD_EXEC_METH.NEXTVAL into nuSeqExecMeth from dual;
    RETURN(nuSeqExecMeth);

    ut_trace.Trace('FIN LD_BOSequence.FnuSeqExecMeth', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;

    when others then
      errors.seterror;
      raise ex.CONTROLLED_ERROR;
  END FnuSeqExecMeth;

  /*****************************************************************
  Propiedad intelectual de Open International Systems. (c).

  Procedure           : FnuSeqOrderConsUnit
  Descripcion         : Retorna el numero de secuencia de la
                        entidad LD_Order_Cons_Unit.

  Autor          : jvaliente
  Fecha          : 18/09/2012 SAO156931

  Parametros                  Descripcion
  ============            ===================

  Historia de Modificaciones
  Fecha        Autor<SAONNNN>     Modificacion
  =========    =========          ====================
  ******************************************************************/
  Function FnuSeqOrderConsUnit RETURN number IS

    nuSeqOrderConsUnit Ld_Exec_Meth.Exec_Meth_Id%TYPE;

  BEGIN
    ut_trace.Trace('INICIO LD_BOSequence.FnuSeqOrderConsUnit', 10);

    ---consulta que cruza la entidad de presupuesto de mercado
    ---relevante con la entidad de presupuesto de unidad construciva
    ---filtrando por medio del a?o y mes de la orden legalizada
    select SEQ_LD_Order_Cons_Unit.Nextval
      into nuSeqOrderConsUnit
      from dual;
    RETURN(nuSeqOrderConsUnit);

    ut_trace.Trace('FIN LD_BOSequence.FnuSeqOrderConsUnit', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;

    when others then
      errors.seterror;
      raise ex.CONTROLLED_ERROR;
  END FnuSeqOrderConsUnit;

  /*****************************************************************
  Propiedad intelectual de Open International Systems. (c).

  Procedure           : fnuSeqQuotaBlock
  Descripcion         : Retorna el identificador de la tabla de bloqueos.

  Autor          : eramos
  Fecha          : 18/09/2012 SAO156931

  Parametros                  Descripcion
  ============            ===================

  Historia de Modificaciones
  Fecha        Autor<SAONNNN>     Modificacion
  =========    =========          ====================
  ******************************************************************/
  Function fnuSeqQuotaBlock RETURN number IS

    nuSeqQuotaBlock ld_quota_block.quota_block_id%type;

  BEGIN
    ut_trace.Trace('INICIO LD_BOSequence.fnuSeqQuotaBlock', 10);

    select seq_ld_quota_block.Nextval into nuSeqQuotaBlock from dual;

    ut_trace.Trace('FIN LD_BOSequence.fnuSeqQuotaBlock', 10);

    RETURN(nuSeqQuotaBlock);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      errors.seterror;
      raise ex.CONTROLLED_ERROR;
  END fnuSeqQuotaBlock;

  /*****************************************************************
  Propiedad intelectual de Open International Systems. (c).

  Procedure           : fnuSeqQuotaBlock
  Descripcion         : Retorna el identificador de la tabla de solicitudes
  de venta.

  Autor          : eramos
  Fecha          : 18/09/2012 SAO156931

  Parametros                  Descripcion
  ============            ===================

  Historia de Modificaciones
  Fecha        Autor<SAONNNN>     Modificacion
  =========    =========          ====================
  ******************************************************************/
  Function fnuSeqFNBSale RETURN number IS

    --nuSeqFNBSale ld_non_bank_finan_requ.non_bank_finan_requ_id%type;

  BEGIN
    ut_trace.Trace('INICIO LD_BOSequence.fnuSeqFNBSale', 10);

    --select SEQ_LD_NON_BA_FI_REQU.NEXTVAL
    --into nuSeqFNBSale
    --      from dual;

    ut_trace.Trace('FIN LD_BOSequence.fnuSeqFNBSale', 10);

    RETURN(0); --nuSeqFNBSale);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      errors.seterror;
      raise ex.CONTROLLED_ERROR;
  END fnuSeqFNBSale;

  /*****************************************************************
  Propiedad intelectual de Open International Systems. (c).

  Procedure           : fnuSeqPolicy
  Descripcion         : Retorna el identificador de la tabla de polizas
  de venta.

  Autor          : AAcuna
  Fecha          : 11/10/2012 SAO147879

  Parametros                  Descripcion
  ============            ===================

  Historia de Modificaciones
  Fecha        Autor<SAONNNN>     Modificacion
  =========    =========          ====================
  ******************************************************************/
  Function fnuSeqPolicy RETURN number IS

    nuSeqPolicy number;

  BEGIN
    ut_trace.Trace('INICIO LD_BOSequence.fnuSeqPolicy', 10);



    nuSeqPolicy:= SEQ_LD_POLICY.nextval;

    while dald_policy.fblExist(nuSeqPolicy) loop

        nuSeqPolicy:= SEQ_LD_POLICY.nextval;

    end loop;


    ut_trace.Trace('FIN LD_BOSequence.fnuSeqPolicy', 10);

    RETURN(nuSeqPolicy);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      errors.seterror;
      raise ex.CONTROLLED_ERROR;
  END fnuSeqPolicy;

  /*****************************************************************
  Propiedad intelectual de Open International Systems. (c).

  Procedure           : fnuSeqPolicy
  Descripcion         : Retorna el identificador de la tabla de polizas
  de venta.

  Autor          : AAcuna
  Fecha          : 11/10/2012 SAO147879

  Parametros                  Descripcion
  ============            ===================

  Historia de Modificaciones
  Fecha        Autor<SAONNNN>     Modificacion
  =========    =========          ====================
  ******************************************************************/
  Function fnuSeqLiquidation RETURN number IS

    nuSeqLiquidation number;

  BEGIN
    ut_trace.Trace('INICIO LD_BOSequence.fnuSeqLiquidation', 10);

    select SEQ_LD_LIQUIDATION.nextval into nuSeqLiquidation from dual;

    ut_trace.Trace('FIN LD_BOSequence.fnuSeqLiquidation', 10);

    RETURN(nuSeqLiquidation);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      errors.seterror;
      raise ex.CONTROLLED_ERROR;
  END fnuSeqLiquidation;

  /*****************************************************************
  Propiedad intelectual de Open International Systems. (c).

  Procedure           : fnuSeqPolicy
  Descripcion         : Retorna el identificador de la tabla de polizas
  de venta.

  Autor          : AAcuna
  Fecha          : 11/10/2012 SAO147879

  Parametros                  Descripcion
  ============            ===================

  Historia de Modificaciones
  Fecha        Autor<SAONNNN>     Modificacion
  =========    =========          ====================
  ******************************************************************/
  Function fnuSeqDetLiquidation RETURN number IS

    nuSeqDetLiqu number;

  BEGIN
    ut_trace.Trace('INICIO LD_BOSequence.fnuSeqDetLiquidation', 10);

    select SEQ_LD_DETAIL_LIQUIDATION.nextval into nuSeqDetLiqu from dual;

    ut_trace.Trace('FIN LD_BOSequence.fnuSeqDetLiquidation', 10);

    RETURN(nuSeqDetLiqu);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      errors.seterror;
      raise ex.CONTROLLED_ERROR;
  END fnuSeqDetLiquidation;

  /**************************************************************
  Propiedad intelectual de Open International Systems (c).
  Unidad      :  FnuSeqSubsidy
  Descripcion :  Retorna el numero de secuencia de la entidad de Subsidio (ld_subsidy).

  Autor          : jvaliente
  Fecha          : 14/10/2012 SAO156577

  Parametros                  Descripcion
  ============            ===================

  Historia de Modificaciones
  Fecha        Autor<SAONNNN>     Modificacion
  =========    =========          ====================
  ***************************************************************/
  Function FnuSeqSubsidy RETURN number IS

    nuSeqSubsidy Ld_Subsidy.Subsidy_Id%TYPE;

  BEGIN
    ut_trace.Trace('INICIO LD_BOSequence.FnuSeqSubsidy', 10);

    select SEQ_Ld_Subsidy.Nextval into nuSeqSubsidy from dual;
    RETURN(nuSeqSubsidy);

    ut_trace.Trace('FIN LD_BOSequence.FnuSeqSubsidy', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;

    when others then
      errors.seterror;
      raise ex.CONTROLLED_ERROR;
  END FnuSeqSubsidy;

  /**************************************************************
  Propiedad intelectual de Open International Systems (c).
  Unidad      :  FnuSeqUbication
  Descripcion :  Retorna el numero de secuencia de la entidad de Poblacion (Ld_Ubication).

  Autor          : jvaliente
  Fecha          : 14/10/2012 SAO156577

  Parametros                  Descripcion
  ============            ===================

  Historia de Modificaciones
  Fecha        Autor<SAONNNN>     Modificacion
  =========    =========          ====================
  ***************************************************************/
  Function FnuSeqUbication RETURN number IS

    nuSeqUbication ld_ubication.ubication_id%TYPE;

  BEGIN
    ut_trace.Trace('INICIO LD_BOSequence.FnuSeqUbication', 10);

    select SEQ_ld_ubication.Nextval into nuSeqUbication from dual;
    RETURN(nuSeqUbication);

    ut_trace.Trace('FIN LD_BOSequence.FnuSeqUbication', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;

    when others then
      errors.seterror;
      raise ex.CONTROLLED_ERROR;
  END FnuSeqUbication;

  /**************************************************************
  Propiedad intelectual de Open International Systems (c).
  Unidad      :  FnuSeqSubsidyDetail
  Descripcion :  Retorna el numero de secuencia de la entidad Conceptos a Subsidiar (ld_subsidy_detail).

  Autor          : jvaliente
  Fecha          : 14/10/2012 SAO156577

  Parametros                  Descripcion
  ============            ===================

  Historia de Modificaciones
  Fecha        Autor<SAONNNN>     Modificacion
  =========    =========          ====================
  ***************************************************************/
  Function FnuSeqSubsidyDetail RETURN number IS

    nuSeqSubsidyDetail ld_subsidy_detail.subsidy_detail_id%TYPE;

  BEGIN
    ut_trace.Trace('INICIO LD_BOSequence.FnuSeqSubsidyDetail', 10);

    select SEQ_ld_subsidy_detail.Nextval into nuSeqSubsidyDetail from dual;
    RETURN(nuSeqSubsidyDetail);

    ut_trace.Trace('FIN LD_BOSequence.FnuSeqSubsidyDetail', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;

    when others then
      errors.seterror;
      raise ex.CONTROLLED_ERROR;
  END FnuSeqSubsidyDetail;

  /**************************************************************
  Propiedad intelectual de Open International Systems (c).
  Unidad      :  FnuSeqSubsidyDetail
  Descripcion :  Retorna el numero de secuencia de la entidad Topes a Cobrar (Ld_Max_Recovery).

  Autor          : jvaliente
  Fecha          : 14/10/2012 SAO156577

  Parametros                  Descripcion
  ============            ===================

  Historia de Modificaciones
  Fecha        Autor<SAONNNN>     Modificacion
  =========    =========          ====================
  ***************************************************************/
  Function FnuSeqSeqMaxRecovery RETURN number IS

    nuSeqMaxRecovery ld_max_recovery.max_recovery_id%TYPE;

  BEGIN
    ut_trace.Trace('INICIO LD_BOSequence.FnuSeqSeqMaxRecovery', 10);

    select SEQ_ld_max_recovery.Nextval into nuSeqMaxRecovery from dual;
    RETURN(nuSeqMaxRecovery);

    ut_trace.Trace('FIN LD_BOSequence.FnuSeqSeqMaxRecovery', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;

    when others then
      errors.seterror;
      raise ex.CONTROLLED_ERROR;
  END FnuSeqSeqMaxRecovery;

  /*****************************************************************
  Propiedad intelectual de Open International Systems. (c).

  Procedure           : fnuSeqDetailLiquiSeller
  Descripcion         : Retorna el identificador de la tabla de detalles de liquidacion de proveedor.

  Autor          : ajimenez
  Fecha          : 23/10/2012 SAO139854

  Parametros                  Descripcion
  ============            ===================

  Historia de Modificaciones
  Fecha        Autor<SAONNNN>     Modificacion
  =========    =========          ====================
  ******************************************************************/
  Function fnuSeqDetailLiquiSeller RETURN number IS

    nuSeqDetailLiquiSeller ld_detail_Liqui_seller.Detail_Liqui_Seller_Id%type;

  BEGIN
    ut_trace.Trace('INICIO LD_BOSequence.fnuSeqDetailLiquiSeller', 10);

    select seq_ld_detail_Liqui_seller.Nextval
      into nuSeqDetailLiquiSeller
      from dual;

    ut_trace.Trace('FIN LD_BOSequence.fnuSeqDetailLiquiSeller', 10);

    RETURN(nuSeqDetailLiquiSeller);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      errors.seterror;
      raise ex.CONTROLLED_ERROR;
  END fnuSeqDetailLiquiSeller;

  /*****************************************************************
  Propiedad intelectual de Open International Systems. (c).

  Procedure           : fnuSeqLiquidationSeller
  Descripcion         : Retorna el identificador de la tabla de liquidacion de proveedor.

  Autor          : ajimenez
  Fecha          : 23/10/2012 SAO139854

  Parametros                  Descripcion
  ============            ===================

  Historia de Modificaciones
  Fecha        Autor<SAONNNN>     Modificacion
  =========    =========          ====================
  ******************************************************************/
  Function fnuSeqLiquidationSeller RETURN number IS

    nuSeqLiquidationSeller ld_Liquidation_seller.Liquidation_Seller_Id%type;

  BEGIN
    ut_trace.Trace('INICIO LD_BOSequence.fnuSeqLiquidationSeller', 10);

    select seq_ld_Liquidation_seller.Nextval
      into nuSeqLiquidationSeller
      from dual;

    ut_trace.Trace('FIN LD_BOSequence.fnuSeqLiquidationSeller', 10);

    RETURN(nuSeqLiquidationSeller);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      errors.seterror;
      raise ex.CONTROLLED_ERROR;
  END fnuSeqLiquidationSeller;

  /*****************************************************************
  Propiedad intelectual de Open International Systems. (c).

  Procedure           : fnuSeqPriceListDeta
  Descripcion         : Retorna el identificador de la tabla Ld_Price_List_Deta.

  Autor          : jvaliente
  Fecha          : 23/10/2012 SAO139854

  Parametros                  Descripcion
  ============            ===================

  Historia de Modificaciones
  Fecha        Autor<SAONNNN>     Modificacion
  =========    =========          ====================
  ******************************************************************/
  Function fnuSeqPriceListDeta
    RETURN Ld_Price_List_Deta.Price_List_Deta_Id%type IS

    nuSeqPriceListDeta Ld_Price_List_Deta.Price_List_Deta_Id%type;

  BEGIN
    ut_trace.Trace('INICIO LD_BOSequence.fnuSeqPriceListDeta', 10);

    select seq_Ld_Price_List_Deta.Nextval
      into nuSeqPriceListDeta
      from dual;

    ut_trace.Trace('FIN LD_BOSequence.fnuSeqPriceListDeta', 10);

    RETURN(nuSeqPriceListDeta);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      errors.seterror;
      raise ex.CONTROLLED_ERROR;
  END fnuSeqPriceListDeta;

  /*****************************************************************
  Propiedad intelectual de Open International Systems. (c).

  Procedure           : fnuSeqPriceListDeta
  Descripcion         : Retorna el identificador de la tabla Ld_Propert_By_Article.

  Autor          : jvaliente
  Fecha          : 23/10/2012 SAO139854

  Parametros                  Descripcion
  ============            ===================

  Historia de Modificaciones
  Fecha        Autor<SAONNNN>     Modificacion
  =========    =========          ====================
  ******************************************************************/
  Function fnuSeqPropertArticle
    RETURN Ld_Propert_By_Article.Propert_By_Article_Id%type IS

    nuSequencePropertArticleId Ld_Propert_By_Article.Propert_By_Article_Id%type;

  BEGIN
    ut_trace.Trace('INICIO LD_BOSequence.fnuSeqPropertArticle', 10);

    SELECT Seq_Ld_Propert_By_Article.NEXTVAL
      INTO nuSequencePropertArticleId
      FROM dual;

    ut_trace.Trace('FIN LD_BOSequence.fnuSeqPropertArticle', 10);

    RETURN(nuSequencePropertArticleId);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      errors.seterror;
      raise ex.CONTROLLED_ERROR;
  END fnuSeqPropertArticle;

  /*****************************************************************
  Propiedad intelectual de Open International Systems. (c).

  Procedure           : fnuSeqQuotaBySubsc
  Descripcion         : Retorna el identificador de la tabla
                        ld_quota_by_subsc

  Autor          : eramos
  Fecha          : 23/10/2012 SAO139854

  Parametros                  Descripcion
  ============            ===================

  Historia de Modificaciones
  Fecha        Autor<SAONNNN>     Modificacion
  =========    =========          ====================
  ******************************************************************/
  Function fnuSeqQuotaBySubsc RETURN ld_quota_by_subsc.quota_by_subsc_id%type IS

    nuQuotaBySubsc ld_quota_by_subsc.quota_by_subsc_id%type;

  BEGIN
    ut_trace.Trace('INICIO LD_BOSequence.fnuSeqPropertArticle', 10);

    SELECT Seq_Ld_Quota_By_Subsc.Nextval INTO nuQuotaBySubsc FROM dual;

    ut_trace.Trace('FIN LD_BOSequence.fnuSeqPropertArticle', 10);

    RETURN(nuQuotaBySubsc);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      errors.seterror;
      raise ex.CONTROLLED_ERROR;
  END fnuSeqQuotaBySubsc;

  /*****************************************************************
  Propiedad intelectual de Open International Systems. (c).

  Procedure           : fnuSeqCommission
  Descripcion         : Retorna el identificador de la tabla
                        ld_commission

  Autor          : eramos
  Fecha          : 23/10/2012 SAO139854

  Parametros                  Descripcion
  ============            ===================

  Historia de Modificaciones
  Fecha        Autor<SAONNNN>     Modificacion
  =========    =========          ====================
  ******************************************************************/
  Function fnuSeqCommission RETURN ld_commission.commission_id%type IS

    nuCommissionId ld_commission.commission_id%type;

  BEGIN
    ut_trace.Trace('INICIO LD_BOSequence.fnuSeqCommission', 10);

    --ELECT SEQ_LD_COMMISSION.Nextval INTO nuCommissionId FROM dual;
    nuCommissionId := GE_BOSEQUENCE.FNUGETNEXTVALSEQUENCE('LD_COMMISSION', 'SEQ_LD_COMMISSION');
    ut_trace.Trace('FIN LD_BOSequence.fnuSeqCommission', 10);

    RETURN(nuCommissionId);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      errors.seterror;
      raise ex.CONTROLLED_ERROR;
  END fnuSeqCommission;

  /*****************************************************************
  Propiedad intelectual de Open International Systems. (c).

  Procedure           : fnuSeqAssigsub
  Descripcion         : Retorna el identificador de la tabla
                        ld_asig_subsidy

  Autor          : eramos
  Fecha          : 04/11/2012 SAO156577

  Parametros                  Descripcion
  ============            ===================

  Historia de Modificaciones
  Fecha        Autor<SAONNNN>     Modificacion
  =========    =========          ====================
  ******************************************************************/
  Function fnuSeqAssigsub RETURN ld_asig_subsidy.asig_subsidy_id%type IS

    nuasig_subsidy_id ld_asig_subsidy.asig_subsidy_id%type;

  BEGIN
    ut_trace.Trace('INICIO LD_BOSequence.fnuSeqAssigsub', 10);

    SELECT Seq_ld_asig_subsidy.Nextval INTO nuasig_subsidy_id FROM dual;

    ut_trace.Trace('FIN LD_BOSequence.fnuSeqAssigsub', 10);

    RETURN(nuasig_subsidy_id);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      errors.seterror;
      raise ex.CONTROLLED_ERROR;
  END fnuSeqAssigsub;

  /*****************************************************************
  Propiedad intelectual de Open International Systems. (c).

  Procedure           : fnuSeqItemWorkOrder
  Descripcion         : Retorna la secuencia de la tabla
                        ld_item_work_order

  Autor          : eramos
  Fecha          : 04/11/2012 SAO156577

  Parametros                  Descripcion
  ============            ===================

  Historia de Modificaciones
  Fecha        Autor<SAONNNN>     Modificacion
  =========    =========          ====================
  ******************************************************************/
  Function fnuSeqItemWorkOrder
    RETURN ld_item_work_order.item_work_order_id%type IS

    nuitem_work_order_id ld_item_work_order.item_work_order_id%type;

  BEGIN
    ut_trace.Trace('INICIO LD_BOSequence.fnuSeqItemWorkOrder', 10);

    SELECT Seq_ld_item_work_order.Nextval
      INTO nuitem_work_order_id
      FROM dual;

    ut_trace.Trace('FIN LD_BOSequence.fnuSeqItemWorkOrder', 10);

    RETURN(nuitem_work_order_id);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      errors.seterror;
      raise ex.CONTROLLED_ERROR;
  END fnuSeqItemWorkOrder;

  /*****************************************************************
  Propiedad intelectual de Open International Systems. (c).

  Procedure           : fnuSeqMoveSub
  Descripcion         : Retorna la secuencia de la tabla
                        ld_Move_Sub

  Autor          : eramos
  Fecha          : 21/11/2012 SAO156577

  Parametros                  Descripcion
  ============            ===================

  Historia de Modificaciones
  Fecha        Autor<SAONNNN>     Modificacion
  =========    =========          ====================
  ******************************************************************/
  Function fnuSeqMoveSub RETURN ld_Move_Sub.Move_Sub_Id%type IS

    nuMove_Sub_Id ld_Move_Sub.Move_Sub_Id%type;

  BEGIN

    ut_trace.Trace('INICIO LD_BOSequence.fnuSeqMoveSub', 10);

    SELECT SEQ_LD_MOVE_SUB.Nextval INTO nuMove_Sub_Id FROM dual;

    ut_trace.Trace('FIN LD_BOSequence.fnuSeqMoveSub', 10);

    RETURN(nuMove_Sub_Id);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      errors.seterror;
      raise ex.CONTROLLED_ERROR;
  END fnuSeqMoveSub;
  /************************************************************************
  Propiedad intelectual de Open International Systems (c).

   Unidad         : Fnuseqsaleswithoutsub
   Descripcion    : Retorna la secuencia de la entidad
                    LD_SALE_WITHOUTSUBSIDY
   Autor          : jonathan alberto consuegra lara
   Fecha          : 07/12/2012

   Parametros       Descripcion
   ============     ===================

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   07/12/2012       jconsuegra.SAO156577  Creacion
  /*************************************************************************/
  Function Fnuseqsaleswithoutsub
    RETURN Ld_sales_withoutsubsidy.Sales_Withoutsubsidy_Id%type IS

    nuSale_Withoutsub_Id Ld_sales_withoutsubsidy.Sales_Withoutsubsidy_Id%type;

  BEGIN

    ut_trace.Trace('Inicio LD_BOSequence.Fnuseqsaleswithoutsub', 10);

    SELECT SEQ_LD_SALES_WITHOUTSUBSIDY.Nextval
      INTO nuSale_Withoutsub_Id
      FROM dual;

    ut_trace.Trace('Fin LD_BOSequence.Fnuseqsaleswithoutsub', 10);

    RETURN(nuSale_Withoutsub_Id);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      errors.seterror;
      raise ex.CONTROLLED_ERROR;
  END Fnuseqsaleswithoutsub;

  /************************************************************************
  Propiedad intelectual de Open International Systems (c).

   Unidad         : Fnuseqsubidyconcept
   Descripcion    : Retorna la secuencia de la entidad
                    Ld_subsidy_concept
   Autor          : jonathan alberto consuegra lara
   Fecha          : 13/12/2012

   Parametros       Descripcion
   ============     ===================

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   13/12/2012       jconsuegra.SAO156577  Creacion
  /*************************************************************************/
  Function Fnuseqsubidyconcept
    RETURN Ld_subsidy_concept.Subsidy_concept_Id%type is

    nuSubsidy_concept_Id Ld_subsidy_concept.Subsidy_concept_Id%type;

  BEGIN

    ut_trace.Trace('Inicio LD_BOSequence.Fnuseqsubidyconcept', 10);

    SELECT SEQ_Ld_subsidy_concept.Nextval
      INTO nuSubsidy_concept_Id
      FROM dual;

    ut_trace.Trace('Fin LD_BOSequence.Fnuseqsubidyconcept', 10);

    RETURN(nuSubsidy_concept_Id);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      errors.seterror;
      raise ex.CONTROLLED_ERROR;
  END Fnuseqsubidyconcept;

  /**************************************************************
  Propiedad intelectual de Open International Systems (c).
  Unidad               : FnuSeqRev_sub_audit
  Descripcion          : Retorna el numero de secuencia de la
                         entidad Ld_Rev_sub_audit.

  Autor          : eherard
  Fecha          : 18/12/2012 SAOSAO156577

  Parametros                  Descripcion
  ============            ===================

  Historia de Modificaciones
  Fecha        Autor<SAONNNN>     Modificacion
  =========    =========          ====================
  ***************************************************************/
  Function FnuSeqRev_sub_audit RETURN Ld_Rev_sub_audit.Rev_Sub_Audit_Id%TYPE IS

    nuSeqRev_sub_audit Ld_Rev_sub_audit.Rev_Sub_Audit_Id%TYPE;

  BEGIN
    ut_trace.Trace('INICIO LD_BOSequence.FnuSeqRev_sub_audit', 10);

    --Obtiene la siguiente secuencia y la retorna a la aplicaion que la implemente
    select SEQ_LD_REV_SUB_AUDIT.NEXTVAL into nuSeqRev_sub_audit from dual;
    RETURN(nuSeqRev_sub_audit);

    ut_trace.Trace('FIN LD_BOSequence.FnuSeqRev_sub_audit', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;

    when others then
      errors.seterror;
      raise ex.CONTROLLED_ERROR;
  END FnuSeqRev_sub_audit;

  /************************************************************************
  Propiedad intelectual de Open International Systems (c).

   Unidad         : Fnuseqld_sub_remain_deliv
   Descripcion    : Retorna la secuencia de la entidad
                    ld_sub_remain_deliv
   Autor          : jonathan alberto consuegra lara
   Fecha          : 11/01/2013

   Parametros       Descripcion
   ============     ===================

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   11/01/2013       jconsuegra.SAO156577  Creacion
  /*************************************************************************/
  Function Fnuseqld_sub_remain_deliv
    RETURN ld_sub_remain_deliv.sub_remain_deliv_id%type is

    nusub_remain_deliv_id ld_sub_remain_deliv.sub_remain_deliv_id%type;

  BEGIN

    ut_trace.Trace('Inicio LD_BOSequence.Fnuseqld_sub_remain_deliv', 10);

    SELECT SEQ_LD_SUB_REMAIN_DELIV.Nextval
      INTO nusub_remain_deliv_id
      FROM dual;

    ut_trace.Trace('Fin LD_BOSequence.Fnuseqld_sub_remain_deliv', 10);

    RETURN(nusub_remain_deliv_id);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      errors.seterror;
      raise ex.CONTROLLED_ERROR;
  END Fnuseqld_sub_remain_deliv;

  /**************************************************************
  Propiedad intelectual de Open International Systems (c).
  Unidad               : FnuSeq_Ld_Record_Collect
  Descripcion          : Retorna el numero de secuencia del acta de cobro: Campo Ld_Asig_Subsidy.Record_Collect
                         .

  Autor          : Evens Herard Gorut - eherard
  Fecha          : 11/01/2013 SAOSAO156577

  Parametros                  Descripcion
  ============            ===================

  Historia de Modificaciones
  Fecha        Autor<SAONNNN>     Modificacion
  =========    =========          ====================
  ***************************************************************/
  Function FnuSeq_Ld_Record_Collect
    Return Ld_Asig_Subsidy.Record_Collect%TYPE is
    nuSeq_Record_Collect Ld_Asig_Subsidy.Record_Collect%TYPE;

  BEGIN
    ut_trace.Trace('INICIO LD_BOSequence.FnuSeq_Ld_Record_Collect', 10);

    --Obtiene la siguiente secuencia y la retorna a la aplicaion que la implemente
    select SEQ_LD_RECORD_COLLECT.NEXTVAL
      into nuSeq_Record_Collect
      from dual;
    RETURN(nuSeq_Record_Collect);

    ut_trace.Trace('FIN LD_BOSequence.FnuSeq_Ld_Record_Collect', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      errors.seterror;
      raise ex.CONTROLLED_ERROR;
  END FnuSeq_Ld_Record_Collect;
  /**************************************************************
  Propiedad intelectual de Open International Systems (c).
  Unidad               : FnuSeq_Cha_Sta_Sub_Audi
  Descripcion          : Retorna el numero de secuencia de la entidad Ld_Cha_Sta_Sub_Audi
                         .

  Autor          : Evens Herard Gorut - eherard
  Fecha          : 11/01/2013 SAOSAO156577

  Parametros                  Descripcion
  ============            ===================

  Historia de Modificaciones
  Fecha        Autor<SAONNNN>     Modificacion
  =========    =========          ====================
  ***************************************************************/
  Function FnuSeq_Cha_Sta_Sub_Audi
    Return ld_Cha_Sta_Sub_Audi.Cha_Sta_Sub_Audi_Id%TYPE is
    nuSeq_Cha_Sta_Sub_Audi ld_Cha_Sta_Sub_Audi.Cha_Sta_Sub_Audi_Id%TYPE;

  BEGIN
    ut_trace.Trace('INICIO LD_BOSequence.FnuSeq_Cha_Sta_Sub_Audi', 10);

    --Obtiene la siguiente secuencia y la retorna a la aplicaion que la implemente
    select SEQ_LD_CHA_STA_SUB_AUDI.NEXTVAL
      into nuSeq_Cha_Sta_Sub_Audi
      from dual;
    RETURN(nuSeq_Cha_Sta_Sub_Audi);

    ut_trace.Trace('FIN LD_BOSequence.FnuSeq_Cha_Sta_Sub_Audi', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      errors.seterror;
      raise ex.CONTROLLED_ERROR;
  END FnuSeq_Cha_Sta_Sub_Audi;
  /**************************************************************
  Propiedad intelectual de Open International Systems (c).
  Unidad               : FnuSeqtmp_max_recovery
  Descripcion          : Retorna el numero de secuencia de la entidad Ld_tmp_max_recovery
                         .

  Autor          : Evens Herard Gorut - eherard
  Fecha          : 23/01/2013 SAOSAO156577

  Parametros                  Descripcion
  ============            ===================

  Historia de Modificaciones
  Fecha        Autor<SAONNNN>     Modificacion
  =========    =========          ====================
  ***************************************************************/
  Function FnuSeqtmp_max_recovery
    Return ld_tmp_max_recovery.tmp_max_recovery_id%type is
    nuSeqtmp_max_recovery ld_tmp_max_recovery.tmp_max_recovery_id%type;

  BEGIN
    ut_trace.Trace('INICIO LD_BOSequence.FnuSeqtmp_max_recovery', 10);

    --Obtiene la siguiente secuencia y la retorna a la aplicaion que la implemente
    select SEQ_ld_tmp_max_recovery.NEXTVAL
      into nuSeqtmp_max_recovery
      from dual;
    RETURN(nuSeqtmp_max_recovery);

    ut_trace.Trace('FIN LD_BOSequence.FnuSeqtmp_max_recovery', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      errors.seterror;
      raise ex.CONTROLLED_ERROR;
  END FnuSeqtmp_max_recovery;

  /************************************************************************
  Propiedad intelectual de Open International Systems (c).

   Unidad         : Fnuseqld_temp_clob_fact
   Descripción    : Retorna la secuencia de la entidad
                    ld_temp_clob_fact
   Autor          : jonathan alberto consuegra lara
   Fecha          : 18/02/2013

   Parámetros       Descripción
   ============     ===================

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   18/02/2013       jconsuegra.SAO156577  Creación
  /*************************************************************************/
  Function Fnuseqld_temp_clob_fact
    RETURN ld_temp_clob_fact.temp_clob_fact_id%type is

    nutemp_clob_fact ld_temp_clob_fact.temp_clob_fact_id%type;

  BEGIN

    ut_trace.Trace('Inicio LD_BOSequence.Fnuseqld_temp_clob_fact', 10);

    SELECT SEQ_LD_TEMP_CLOB_FACT.Nextval INTO nutemp_clob_fact FROM dual;

    ut_trace.Trace('Fin LD_BOSequence.Fnuseqld_temp_clob_fact', 10);

    RETURN(nutemp_clob_fact);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      errors.seterror;
      raise ex.CONTROLLED_ERROR;
  END Fnuseqld_temp_clob_fact;

  /************************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Fnuseqge_subscriber
   Descripción    : Retorna la secuencia de la entidad
                    ge_subscriber
   Autor          : jonathan alberto consuegra lara
   Fecha          : 12/04/2013

   Parámetros       Descripción
   ============     ===================

   Historia de Modificaciones
   Fecha            Autor                 Modificación
   =========        =========             ====================
   12/04/2013       jconsuegra.SAO139854  Creación
  /*************************************************************************/
  Function Fnuseqge_subscriber RETURN ge_subscriber.subscriber_id%type is

    nusubscriber_id ge_subscriber.subscriber_id%type;

  BEGIN

    ut_trace.Trace('Inicio LD_BOSequence.Fnuseqge_subscriber', 10);

    SELECT seq_ge_subscriber.nextval INTO nusubscriber_id FROM dual;

    ut_trace.Trace('Fin LD_BOSequence.Fnuseqge_subscriber', 10);

    RETURN(nusubscriber_id);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      errors.seterror;
      raise ex.CONTROLLED_ERROR;
  END Fnuseqge_subscriber;

  /************************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Fnuseqld_approve_sales_order
   Descripción    : Retorna la secuencia de la entidad
                    ld_approve_sales_order
   Autor          : AAcuna
   Fecha          : 17/04/2013

   Parámetros       Descripción
   ============     ===================

   Historia de Modificaciones
   Fecha            Autor                 Modificación
   =========        =========             ====================
   17/04/2013       AAcuna.SAO139854      Creación
  /*************************************************************************/

  Function Fnuseqld_approve_sales_order

   RETURN ld_approve_sales_order.Approve_Sales_Order_Id%type

   is

    nuApprove_Sales_Order_Id ld_approve_sales_order.Approve_Sales_Order_Id%type;

  BEGIN

    ut_trace.Trace('Inicio LD_BOSequence.Fnuseqld_approve_sales_order', 10);

    SELECT seq_ld_approve_sales_order.nextval
      INTO nuApprove_Sales_Order_Id
      FROM dual;

    ut_trace.Trace('Fin LD_BOSequence.Fnuseqld_approve_sales_order', 10);

    RETURN(nuApprove_Sales_Order_Id);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      errors.seterror;
      raise ex.CONTROLLED_ERROR;
  END Fnuseqld_approve_sales_order;

  /************************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Fnuseqld_bill_pending_payment
   Descripción    : Retorna la secuencia de la entidad
                    ld_bill_pending_payment
   Autor          : AAcuna
   Fecha          : 18/04/2013

   Parámetros       Descripción
   ============     ===================

   Historia de Modificaciones
   Fecha            Autor                 Modificación
   =========        =========             ====================
   18/04/2013       AAcuna.SAO139854      Creación
  /*************************************************************************/

  Function Fnuseqld_bill_pending_payment

   RETURN ld_bill_pending_payment.bill_pending_payment_id%type

   is

    nuBill_pending_payment_id ld_bill_pending_payment.bill_pending_payment_id%type;

  BEGIN

    ut_trace.Trace('Inicio LD_BOSequence.Fnuseqld_bill_pending_payment',
                   10);

    SELECT seq_ld_bill_pending_payment.nextval
      INTO nuBill_pending_payment_id
      FROM dual;

    ut_trace.Trace('Fin LD_BOSequence.Fnuseqld_bill_pending_payment', 10);

    RETURN(nuBill_pending_payment_id);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      errors.seterror;
      raise ex.CONTROLLED_ERROR;
  END Fnuseqld_bill_pending_payment;

  /************************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Fnuseqld_return_item
   Descripción    : Retorna la secuencia de la entidad
                    ld_return_item
   Autor          : AAcuna
   Fecha          : 31/05/2013

   Parámetros       Descripción
   ============     ===================

   Historia de Modificaciones
   Fecha            Autor                 Modificación
   =========        =========             ====================
   31/05/2013       AAcuna.SAO139854      Creación
  /*************************************************************************/

  Function Fnuseqld_return_item

   RETURN ld_return_item.return_item_id%type

   is

    nuReturn_item_id ld_return_item.return_item_id%type;

  BEGIN

    ut_trace.Trace('Inicio LD_BOSequence.Fnuseqld_return_item', 10);

    SELECT seq_ld_return_item.nextval INTO nuReturn_item_id FROM dual;

    ut_trace.Trace('Fin LD_BOSequence.Fnuseqld_return_item', 10);

    RETURN(nuReturn_item_id);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      errors.seterror;
      raise ex.CONTROLLED_ERROR;
  END Fnuseqld_return_item;

  /************************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Fnuseqld_return_item_detail
   Descripción    : Retorna la secuencia de la entidad
                    ld_return_item_detail
   Autor          : AAcuna
   Fecha          : 31/05/2013

   Parámetros       Descripción
   ============     ===================

   Historia de Modificaciones
   Fecha            Autor                 Modificación
   =========        =========             ====================
   31/05/2013       AAcuna.SAO139854      Creación
  /*************************************************************************/

  Function Fnuseqld_return_item_detail

   RETURN ld_return_item_detail.return_item_detail_id%type

   is

    nuReturn_item_id ld_return_item_detail.return_item_detail_id%type;

  BEGIN

    ut_trace.Trace('Inicio LD_BOSequence.Fnuseqld_return_item_detail', 10);

    SELECT seq_ld_return_item_detail.nextval
      INTO nuReturn_item_id
      FROM dual;

    ut_trace.Trace('Fin LD_BOSequence.Fnuseqld_return_item_detail', 10);

    RETURN(nuReturn_item_id);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      errors.seterror;
      raise ex.CONTROLLED_ERROR;
  END Fnuseqld_return_item_detail;

END LD_BOSequence;
/
PROMPT Otorgando permisos de ejecucion a LD_BOSEQUENCE
BEGIN
    pkg_utilidades.praplicarpermisos('LD_BOSEQUENCE', 'ADM_PERSON');
END;
/

PROMPT Otorgando permisos de ejecucion sobre LD_BOSEQUENCE para reportes
GRANT EXECUTE ON adm_person.LD_BOSEQUENCE TO rexereportes;
/
