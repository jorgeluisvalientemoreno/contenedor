CREATE OR REPLACE PROCEDURE adm_person.ldc_prborramarca 
IS
    /**************************************************************************
    Propiedad Intelectual de Gases del caribe S.A E.S.P
    
    Funcion     : LDC_PRMARCADEFCRIT
    Descripcion : Procedimiento que crea el  marca el producto con 104. Ca 200-1871
    
    Historia de Modificaciones
      Fecha               Autor                Modificacion
    =========           =========          ====================
    17/04/2024          PAcosta             OSF-2532: Se crea el objeto en el esquema adm_person
                                            Se retiran las referencias al esquema a open (.open)
    **************************************************************************/

    CURSOR cuproducto(nuorden NUMBER) IS
    SELECT product_id, subscription_id, ot.task_type_id,package_id,AT.subscriber_id,ot.operating_unit_id
    FROM or_order_activity AT,
         or_order ot
    WHERE AT.order_id = nuorden
      AND package_id IS NOT NULL
      AND AT.order_id = ot.order_id
      AND ROWNUM   = 1;
    
    nuorden         or_order.order_id%TYPE;
    numarca         ldc_marca_producto.suspension_type_id%TYPE;
    numarcaantes    ldc_marca_producto.suspension_type_id%TYPE;
    sbmensa         VARCHAR2(10000);
    rgproducto      cuproducto%rowtype;

BEGIN
    ut_trace.TRACE('Inicia LDC_PRBORRAMARCA', 10);
    
    --Obtener el identificador de la orden  que se encuentra en la instancia
    nuorden := or_bolegalizeorder.fnugetcurrentorder;
    ut_trace.TRACE('Numero de la Orden:'||nuorden, 10);
    
    OPEN cuproducto(nuorden);
    FETCH cuproducto INTO rgproducto;
    
    IF cuproducto%notfound THEN
        sbmensa := 'Proceso termino con errores : '||'El cursor cuProducto no arrojo datos con el # de orden'||to_char(nuorden);
        ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,sbmensa);
        RAISE ex.controlled_error;
    END IF;
    CLOSE cuproducto;
    
    ut_trace.TRACE('Producto:'||rgproducto.product_id, 10);
    numarcaantes := ldc_fncretornamarcaprod(rgproducto.product_id);
    
    ut_trace.TRACE('Marca antes:'||numarcaantes, 10);
    DELETE ldc_marca_producto
    WHERE id_producto = rgproducto.product_id
    AND nvl(suspension_type_id,101) = 101;
    
    ldc_prmarcaproductolog(rgproducto.product_id,numarcaantes, NULL , 'Legalizacion OT :'||nuorden);
    
    ut_trace.TRACE('Fin LDC_PRBORRAMARCA', 10);
EXCEPTION
    WHEN ex.controlled_error THEN
        ut_trace.TRACE('Error LDC_PRBORRAMARCA ex.controlled_error', 10);
        RAISE;
WHEN OTHERS THEN
    ut_trace.TRACE('Error LDC_PRBORRAMARCA OTHERS', 10);
    sbmensa := 'Proceso termino con Errores. '||sqlerrm;
    ERRORS.seterror;
    RAISE ex.controlled_error;
END ldc_prborramarca;
/
PROMPT Otorgando permisos de ejecucion a LDC_PRBORRAMARCA
BEGIN
    pkg_utilidades.praplicarpermisos('LDC_PRBORRAMARCA','ADM_PERSON');
END;
/