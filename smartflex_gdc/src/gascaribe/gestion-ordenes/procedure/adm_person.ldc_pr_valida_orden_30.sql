CREATE OR REPLACE PROCEDURE adm_person.ldc_pr_valida_orden_30 
AS
    /**************************************************************************
    
    UNIDAD      :  LDC_PR_VALIDA_ORDEN
    Descripcion :  Procedimiento que valida los criterios de reconexion de un cliente
    Autor       :  Antonio Benitez Llorente
    Fecha       :  16-07-2019
    
    Historia de Modificaciones
    Fecha               Autor                Modificacion
    =========           =========          ====================
    16/04/2024          PAcosta             OSF-2532: Se crea el objeto en el esquema adm_person  
    **************************************************************************/

    nuorden            or_order.order_id%TYPE; --Orden de la instancia
    nuproductid        or_order_activity.product_id%TYPE; --Producto asociado a la orden
    nucategoria        servsusc.sesucate%TYPE; --Categoria
    nusubcategoria     servsusc.sesusuca%TYPE; --Subcategoria
    nuestadocorte      servsusc.sesuesco%TYPE; --Estado corte
    nuciclo            servsusc.sesucicl%TYPE; --Ciclo
    nudepartamento     servsusc.sesudepa%TYPE; --Departamento
    nulocalidad        servsusc.sesuloca%TYPE; --Localidad
    sbestadofinanciero servsusc.sesuesfn%TYPE; --Estado financiero
    nuestadoproducto   pr_product.product_status_id%TYPE; --Estado del producto
    nudireccion        pr_product.address_id%TYPE; --Direccion
    nubarrio           ab_segments.neighborhood_id%TYPE; --Barrio
    nusector           ab_segments.operating_sector_id%TYPE; --Sector operativo
    nudeudacorriente   NUMBER; --Deuda corriente
    nudeudavencida     NUMBER; --Deuda vencida
    nufinanciacion     NUMBER; --Financiaciones en el a?o
    nucuentas_vencidas NUMBER; --Numero de cuentas vencidad
    dtcuenta_cobro     DATE; --Fecha cuenta cobro mas reciente
    validacriterio     VARCHAR2(1); --BOOLEAN; --almacena el resultado de la validadicon de los criterios
    nuerrorcode        NUMBER;
    sberrormsg         VARCHAR2(4000);
    
    sbentrega VARCHAR2(30):='BSS_OL_0000030_5';
    
    
    CURSOR cuproducto(nuorden NUMBER) IS
    SELECT product_id
    FROM   or_order_activity
    WHERE  order_id = nuorden
           AND ROWNUM = 1;


BEGIN
    IF fblaplicaentrega(sbentrega) THEN
        ut_trace.TRACE('INICIA PROCEDIMIENDO  LDC_PR_VALIDA_ORDEN_30 ',5);
        --Obtener el identificador de la orden  que se encuentra en la instancia
        nuorden := or_bolegalizeorder.fnugetcurrentorder;
        
        --Se cierra el cursor si esta abierto
        IF (cuproducto%isopen) THEN
            CLOSE cuproducto;
        END IF;
        --Se abre el cursor  que obtiene el producto a partir del numero de la orden
        OPEN cuproducto(nuorden);
        FETCH cuproducto
        INTO nuproductid;
        CLOSE cuproducto;
        
        --Valida los criterios de reconexion
        validacriterio := fsbvalcritadicreconex(nuproductid);
        
        IF (validacriterio != 'Y') THEN
            ge_boerrors.seterrorcodeargument(2741,'ERROR, NO SE CUMPLEN LOS CRITERIOS DE RECONEXION');
        END IF;
        
        ut_trace.TRACE('FINALIZA  PROCEDIMIENDO  LDC_PR_VALIDA_ORDEN_30 ',5);
    END IF;

EXCEPTION
    WHEN ex.controlled_error THEN
        RAISE ex.controlled_error;
    WHEN OTHERS THEN
        ERRORS.seterror;
        RAISE ex.controlled_error;
END ldc_pr_valida_orden_30;
/
PROMPT Otorgando permisos de ejecucion a LDC_PR_VALIDA_ORDEN_30
BEGIN
pkg_utilidades.praplicarpermisos('LDC_PR_VALIDA_ORDEN_30','ADM_PERSON');
END;
/