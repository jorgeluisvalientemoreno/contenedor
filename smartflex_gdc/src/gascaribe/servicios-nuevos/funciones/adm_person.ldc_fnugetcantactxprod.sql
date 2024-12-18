CREATE OR REPLACE FUNCTION ADM_PERSON.LDC_FNUGETCANTACTXPROD (inupackage_id IN or_order_activity.package_id%TYPE,
                                                              inuproducto   IN or_order_activity.product_id%TYPE,
                                                              inuactividad  IN or_order_activity.activity_id%TYPE
) RETURN NUMBER IS

/*****************************************************************
    Propiedad intelectual de GDC.

    Unidad         : LDC_FNUGETCANTACTXPROD
    Descripcion    : funcion que retorna si existe o no un producto con una actividad en or_order_activity
    Autor          : Luis Javier Lopez Barrios
    Ticket         : 200-2550
    Fecha          : 31/05/2019

    Datos de Entrada
      inuPackage_id  Numero de solicitud
      inuProducto    numero de producto
      inuActividad   codigo de la actividad

    Historia de Modificaciones
    Fecha                Autor             Modificacion
    =========            =========         ====================
    10/11/2022           lvalencia         Se modifica para validar cuando la solicitud 323 es registrada desde procesos de innvoación
    20/02/2024           Adrianavg         OSF-2183: Se migra del esquema OPEN al esquema ADM_PERSON
                                           Se declaran variables para la gestión de trazas, se hace uso del pkg_traza.trace	
                                           Se ajusta el bloque de excepciones según las pautas técnicas    
                                           Se reemplaza SELECT-INTO por cursor cuValOrderActivity_1, cuValOrderActivity_2
                                           Se reemplaza GE_BOERRORS.SETERRORCODEARGUMENT por PKG_ERROR.setErrorMessage
                                           Se retira el RAISE ex.controlled_error; ya que el PKG_ERROR.setErrorMessage lo hace en su logica interna
  ******************************************************************/
    --Se declaran variables para la gestión de trazas
    csbMetodo            CONSTANT VARCHAR2(32)       := $$PLSQL_UNIT;
    csbNivelTraza        CONSTANT NUMBER(2)          := pkg_traza.cnuNivelTrzDef;
	csbInicio   	     CONSTANT VARCHAR2(35) 	     := pkg_traza.csbINICIO; 
    Onuerrorcode         NUMBER:= pkg_error.CNUGENERIC_MESSAGE;
    Osberrormessage      VARCHAR2(2000);
    
    PRAGMA AUTONOMOUS_TRANSACTION;
    nuValOrderActivity NUMBER;
    
    CURSOR cuTipoSoli IS
    SELECT package_type_id, user_id
    FROM mo_packages
    WHERE package_id = inuPackage_id;
    
    nuTipoSoli mo_packages.package_type_id%TYPE;
    nuTipoSolicitud     NUMBER := dald_parameter.fnugetnumeric_value('LDC_TTRAMITE_V_CONSTRUCTORA',NULL);
    sbUsuario           VARCHAR2(4000) := dald_parameter.fsbgetvalue_chain('LDC_USUA_V_CONSTRUCTORA', NULL);
    sbUsuarioSolicitud  mo_packages.user_id%TYPE;
    
    CURSOR cuValOrderActivity_1
    IS
    SELECT COUNT(1)
      FROM OR_ORDER_ACTIVITY
     WHERE PACKAGE_ID = inuPackage_id
       AND PRODUCT_ID = inuProducto
       AND ACTIVITY_ID = inuActividad;

    CURSOR cuValOrderActivity_2
    IS
    SELECT COUNT(1)
      FROM OR_ORDER_ACTIVITY oa, OR_ORDER_ACTIVITY oai
     WHERE oa.PACKAGE_ID = inuPackage_id
       AND oa.PRODUCT_ID = inuProducto
       AND oa.ACTIVITY_ID = inuActividad
       AND oa.ORIGIN_ACTIVITY_ID = oai.ORDER_ACTIVITY_ID
       AND oa.task_type_id <> oai.task_type_id;    
    
BEGIN
    
    pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
    pkg_error.prInicializaError(onuerrorcode, osberrormessage);
    pkg_traza.trace(csbMetodo ||' inupackage_id: '  || inupackage_id, csbNivelTraza);
    pkg_traza.trace(csbMetodo ||' inuproducto:   '  || inuproducto, csbNivelTraza);
    pkg_traza.trace(csbMetodo ||' inuactividad:  '  || inuactividad, csbNivelTraza);  
    
    OPEN cuTipoSoli;
    FETCH cuTipoSoli INTO nuTipoSoli, sbUsuarioSolicitud;
    CLOSE cuTipoSoli;
    pkg_traza.trace(csbMetodo ||' TipoSoli: '  || nuTipoSoli, csbNivelTraza);
    pkg_traza.trace(csbMetodo ||' UsuarioSolicitud: '  || sbUsuarioSolicitud, csbNivelTraza);    
    
    IF nuTipoSolicitud IS NULL  THEN
        pkg_error.setErrorMessage(Onuerrorcode,' No existen datos para el parámetro LDC_TTRAMITE_V_CONSTRUCTORA, se debe definir el parámetro en LDPAR');
    END IF;
    
    IF sbUsuario IS NULL THEN
        pkg_error.setErrorMessage(Onuerrorcode,' No existen datos para el parámetro LDC_USUA_V_CONSTRUCTORA, se debe definir el parámetro en LDPAR');
    END IF;

    pkg_traza.trace(csbMetodo ||' TipoSolicitud_param: '  || nuTipoSolicitud, csbNivelTraza);
    pkg_traza.trace(csbMetodo ||' Usuario_param: '  || sbUsuario, csbNivelTraza);
    
    IF nuTipoSoli <> nuTipoSolicitud OR (nuTipoSoli = nuTipoSolicitud AND sbUsuarioSolicitud = sbUsuario)  THEN

        pkg_traza.trace(csbMetodo ||' Ingresa a IF nuTipoSoli <> 323 OR'  , csbNivelTraza);
        
        OPEN cuValOrderActivity_1;
        FETCH cuValOrderActivity_1 INTO nuValOrderActivity;
        CLOSE cuValOrderActivity_1; 
        
    ELSE

        pkg_traza.trace(csbMetodo ||' Ingresa a a ELSE'  , csbNivelTraza);
        
        OPEN cuValOrderActivity_2;
        FETCH cuValOrderActivity_2 INTO nuValOrderActivity;
        CLOSE cuValOrderActivity_2; 
        
    END IF;
    
    pkg_traza.trace(csbMetodo ||' Return:  '  || nuValOrderActivity, csbNivelTraza);    
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    
    RETURN nuValOrderActivity;
EXCEPTION
    WHEN OTHERS THEN
         pkg_Error.setError;
         pkg_Error.getError(onuerrorcode, osberrormessage);
         pkg_traza.trace(csbMetodo ||' osberrormessage: ' || osberrormessage, csbNivelTraza);
         pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR); 
         RETURN 0;
END LDC_FNUGETCANTACTXPROD;
/
PROMPT "                                                            "
PROMPT OTORGA PERMISOS ESQUEMA sobre funcion LDC_FNUGETCANTACTXPROD
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_FNUGETCANTACTXPROD', 'ADM_PERSON'); 
END;
/
