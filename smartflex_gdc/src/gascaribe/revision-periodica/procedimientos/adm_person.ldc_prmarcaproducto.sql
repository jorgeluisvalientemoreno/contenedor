CREATE OR REPLACE PROCEDURE ADM_PERSON.LDC_PRMARCAPRODUCTO IS
    /**************************************************************************
    Propiedad Intelectual de Gases del caribe S.A E.S.P

    Funcion     : LDC_PRMARCAPRODUCTO
    Descripcion : Procedimiento que crea el  marca el producto con 103. Ca 200-1871

    Historia de Modificaciones
      Fecha               Autor                Modificacion
    =========           =========          ====================
   **************************************************************************/

 CURSOR cuProducto(nuorden NUMBER) IS
 SELECT product_id, subscription_id, ot.task_type_id,package_id,at.subscriber_id,ot.operating_unit_id
     FROM or_order_activity at,open.or_order ot
    WHERE at.order_id = nuorden
      AND package_id IS NOT NULL
      AND at.order_id = ot.order_id
      AND rownum   = 1;

 nuOrden  open.or_order.order_id%type;
 numarca  open.ldc_marca_producto.suspension_type_id%type;
 numarcaantes     open.ldc_marca_producto.suspension_type_id%type;
 sbmensa          VARCHAR2(10000);
 rgProducto       cuProducto%rowtype;


BEGIN
 ut_trace.trace('Inicia LDC_PRMARCAPRODUCTO', 10);
 --Obtener el identificador de la orden  que se encuentra en la instancia
 nuorden       := or_bolegalizeorder.fnuGetCurrentOrder;
 ut_trace.trace('Numero de la Orden:'||nuorden, 10);

 open cuProducto(nuorden);
 fetch cuProducto into rgProducto;
 if cuProducto%notfound then
    sbmensa := 'Proceso termino con errores : '||'El cursor cuProducto no arrojo datos con el # de orden'||to_char(nuorden);
    ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,sbmensa);
    RAISE ex.controlled_error;
 end if;
 close cuProducto;
 ut_trace.trace('Producto:'||rgProducto.product_id, 10);
 numarcaantes := ldc_fncretornamarcaprod(rgProducto.product_id);
 ut_trace.trace('Marca antes:'||numarcaantes, 10);
 numarca := ldc_fnugetnuevamarca(nuorden);
 if nvl(numarca, -1) != -1 then
    ldcprocinsactumarcaprodu(rgProducto.product_id,numarca,nuorden);
    ldc_prmarcaproductolog(rgProducto.product_id,numarcaantes, numarca , 'Legalizacion OT :'||nuorden);
 end if;
 ut_trace.trace('Fin LDC_PRMARCAPRODUCTO', 10);
EXCEPTION
 WHEN ex.controlled_error THEN
  ut_trace.trace('Error LDC_PRMARCAPRODUCTO ex.controlled_error', 10);
  RAISE;
 WHEN OTHERS THEN
  ut_trace.trace('Error LDC_PRMARCAPRODUCTO OTHERS', 10);
  sbmensa := 'Proceso termino con Errores. '||SQLERRM;
  errors.seterror;
  RAISE ex.controlled_error;
END;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_PRMARCAPRODUCTO', 'ADM_PERSON');
END;
/
