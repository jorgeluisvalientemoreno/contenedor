CREATE OR REPLACE PROCEDURE ADM_PERSON.LDC_PRFINALIZAPERIODOGRACIA IS
    /**************************************************************************
    Propiedad Intelectual de Gases del caribe S.A E.S.P

    Funcion     : LDC_PRFINALIZAPERIODOGRACIA
    CASO        : SN-611
    Descripcion : Procedimiento que cancela el periodo de gracia, para las solicitudes
                  del piloto de servicios nuevos de cesar

    Historia de Modificaciones
      Fecha               Autor                Modificacion
    =========           =========          ====================
   **************************************************************************/

 CURSOR cuDatosOrden(nuOt open.or_order.order_id%type) IS
 select distinct package_id, product_id
   from open.or_order_activity
  where order_id=nuOt
    and rownum=1;



 CURSOR cuGetFinanc(nuSolicitud open.mo_packages.package_id%type) IS
 select finan_id
 from cc_sales_financ_cond
 where package_id = nuSolicitud;


 CURSOR cuGetPeriodoGracia(nuFina open.cc_sales_financ_cond.finan_id%type,
                           nuCodP open.cc_grace_period.grace_period_id%type,
                           nuProd open.pr_product.product_id%type) IS
 select di.difecodi,
       di.difesape,
       de.grace_peri_defe_id,
       de.grace_period_id,
       de.end_date,
       de.rowid
  from diferido di
  inner join cc_grace_peri_defe de on de.deferred_id=di.difecodi and de.grace_period_id=nuCodP  and de.end_date>sysdate
  where difecofi=nuFina
   and difenuse=nuProd
   and difesape>0;


 nuOrden                        open.or_order.order_id%type;
 rgDatoOt                       cuDatosOrden%rowtype;
 nuFinan                        open.cc_sales_financ_cond.finan_id%type;
 nuPeriGracia                   open.ld_parameter.numeric_value%type:=open.DALD_PARAMETER.fnuGetNumeric_Value('COD_PERI_GRACIA_PILOTO_SN_CES',NULL);
 nuTaskType                     open.or_task_type.task_type_id%type;
 nuCausalId                     open.ge_causal.causal_id%type;
 sbIsMarked                     VARCHAR2(1);


BEGIN
 ut_trace.trace('Inicia LDC_PRFINALIZAPERIODOGRACIA', 99);
 --Obtener el identificador de la orden  que se encuentra en la instancia
 nuorden       := or_bolegalizeorder.fnuGetCurrentOrder;
 ut_trace.trace('nuorden:'||nuorden, 99);
 nuTaskType    := open.daor_order.fnugettask_type_id(nuorden, null);
 ut_trace.trace('nuTaskType:'||nuTaskType, 99);
 nuCausalId	   := open.daor_order.fnugetcausal_id(nuorden, null);
 ut_trace.trace('nuCausalId:'||nuCausalId, 99);
 
 IF nuTaskType != 12162 OR nuCausalId != 9944 THEN
   RETURN;
 END IF;
 IF cuDatosOrden%ISOPEN THEN
    CLOSE cuDatosOrden;
 END IF;
 OPEN cuDatosOrden(nuorden);
 FETCH cuDatosOrden into rgDatoOt;
 CLOSE cuDatosOrden;
 ut_trace.trace('rgDatoOt.package_id:'||rgDatoOt.package_id, 99);
 ut_trace.trace('rgDatoOt.product_id:'||rgDatoOt.product_id, 99);

 IF rgDatoOt.package_id is null or rgDatoOt.product_id is null THEN
   ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,'La orden '||nuorden||' no tiene datos de solicitud o producto ');
   RAISE ex.controlled_error;
 END IF;


 sbIsMarked := ldc_fsbIsSolMarkedPilotoSN(rgDatoOt.package_id);
 ut_trace.trace('sbIsMarked:'||sbIsMarked, 99);

 IF sbIsMarked = 'S' THEN
    IF cuGetFinanc%ISOPEN THEN
      CLOSE cuGetFinanc;
    END IF;
    OPEN cuGetFinanc(rgDatoOt.package_id);
    FETCH cuGetFinanc INTO nuFinan;
    CLOSE cuGetFinanc;
    ut_trace.trace('nuFinan:'||nuFinan, 99);

    IF nuFinan IS NOT NULL THEN
       for reg in cuGetPeriodoGracia(nuFinan,nuPeriGracia, rgDatoOt.product_id) loop
         update cc_grace_peri_defe d set d.end_date=sysdate where d.rowid=reg.rowid and d.grace_peri_defe_id=reg.grace_peri_defe_id;
         --CC_BOGRACE_PERI_DEFE.CANCELGRACEPERIODBYPRO() 
       end loop;
    END IF;
 END IF;

 ut_trace.trace('Fin LDC_PRFINALIZAPERIODOGRACIA', 10);
EXCEPTION
 WHEN ex.controlled_error THEN
  ut_trace.trace('Error LDC_PRFINALIZAPERIODOGRACIA ex.controlled_error', 10);
  RAISE;
 WHEN OTHERS THEN
  ut_trace.trace('Error LDC_PRFINALIZAPERIODOGRACIA OTHERS', 10);
  errors.seterror;
  RAISE ex.controlled_error;
END;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_PRFINALIZAPERIODOGRACIA', 'ADM_PERSON');
END;
/
