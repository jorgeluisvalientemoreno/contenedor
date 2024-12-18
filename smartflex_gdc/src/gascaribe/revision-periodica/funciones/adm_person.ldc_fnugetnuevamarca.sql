CREATE OR REPLACE FUNCTION "ADM_PERSON"."LDC_FNUGETNUEVAMARCA" (nuOrden or_order.order_id%type)  RETURN NUMBER  IS
    /**************************************************************************
    Propiedad Intelectual de Gases del caribe S.A E.S.P

    Funcion     : LDC_FNUGETNUEVAMARCA
    Descripcion : Procedimiento que crea el  marca el producto con 103. Ca 200-1871

    Historia de Modificaciones
      Fecha               Autor                Modificacion
    =========           =========          ====================
   **************************************************************************/


 nuTitr  open.or_order.task_type_id%type;
 nuCausal open.ge_causal.causal_id%type;
 numarca  open.ldc_marca_producto.suspension_type_id%type;
 sbmensa          VARCHAR2(10000);


BEGIN
 ut_trace.trace('Inicio LDC_FNUGETNUEVAMARCA', 10);
 nuTitr := daor_order.fnugettask_type_id(nuOrden, null);
 ut_trace.trace('Tipo Trabajo:'||nuTitr, 10);

 nuCausal := daor_order.fnugetcausal_id(nuOrden, null);
 ut_trace.trace('Causal :'||nuCausal, 10);

 begin
 select suspension_type_id
   into numarca
  from ldc_osf_marcacausal
 where task_type_id = nuTitr
   and causal_id = nuCausal;
 exception
	when others then
	 numarca  := null;
 end;
 IF numarca is null then
	numarca :=-1;
 end if;
 return numarca;
 ut_trace.trace('Fin LDC_FNUGETNUEVAMARCA', 10);
EXCEPTION
 WHEN ex.controlled_error THEN
  ut_trace.trace('Error LDC_FNUGETNUEVAMARCA ex.controlled_error', 10);
  RAISE;
 WHEN OTHERS THEN
  ut_trace.trace('Error LDC_FNUGETNUEVAMARCA OTHERS', 10);
  sbmensa := 'Proceso termino con Errores. '||SQLERRM;
  errors.seterror;
  RAISE ex.controlled_error;
END;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_FNUGETNUEVAMARCA', 'ADM_PERSON');
END;
/
