CREATE OR REPLACE FUNCTION ADM_PERSON.FSBGETSALEBYORDERVSI (InuOrderVSI IN or_order.order_id%TYPE)
RETURN VARCHAR2 IS
/*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : fsbGetSaleByOrderVSI
  Descripcion    : Devuelve informacion de una venta a a partir de una orden de trabajo de tipo Cotizacion Servicio Brilla
  Autor          : Adrian Baldovino Barrios
  Fecha          : 05/06/2015

  Parametros                 Descripcion
  ============            ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
	05/06/2015    Adrian Baldovino    Creado para ARA 6798
    07/02/2023    Adrianavg           OSF-2097: Migrar del esquema OPEN al esquema ADM_PERSON
                                      Se reemplaza ex.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR 
                                      Se reemplaza Errors.setError por PKG_ERROR.setError
                                      Se reemplaza ldc_boutilities.splitstrings por regexp_substr
                                      Se declaran variables para la gestión de trazas
                                      Se ajusta el bloque de exceptiones según pautas técnicas
  ******************************************************************/
    --Se declaran variables para la gestión de trazas
    csbMetodo            CONSTANT VARCHAR2(32)       := $$PLSQL_UNIT;
    csbNivelTraza        CONSTANT NUMBER(2)          := pkg_traza.cnuNivelTrzDef; 
    csbInicio   	     CONSTANT VARCHAR2(35) 	     := pkg_traza.csbINICIO;   
    Onuerrorcode         NUMBER:= pkg_error.CNUGENERIC_MESSAGE;		
    Osberrormessage      VARCHAR2(2000);

	--Obtiene codigo de solicitud de la venta
	CURSOR cuGetPkgVSI IS
	  SELECT package_id
		FROM or_order_activity
	   WHERE order_id = InuOrderVSI 
         AND ROWNUM = 1;

	--Valida que la orden pertenezca al tipo de trabajo configurado en el parametro
	CURSOR cuValORTaskType IS
  	SELECT 1
	  FROM or_order
	 WHERE order_id = InuOrderVSI 
       AND task_type_id IN (SELECT to_number(regexp_substr(DALD_PARAMETER.fsbGetValue_Chain('TASK_TYPE_OB_NOTI_OT',NULL), '[^,]+', 1,  LEVEL)) AS column_value
                              FROM dual
                        CONNECT BY regexp_substr(DALD_PARAMETER.fsbGetValue_Chain('TASK_TYPE_OB_NOTI_OT',NULL), '[^,]+', 1, LEVEL) IS NOT NULL);

	sbComment     VARCHAR2(5000);
	nuPackageVSI  mo_packages.package_id%TYPE;
BEGIN

    pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
    pkg_error.prInicializaError(onuerrorcode, osberrormessage);
    pkg_traza.trace(csbMetodo ||' InuOrderVSI: ' || InuOrderVSI, csbNivelTraza);

    sbComment := '';
    FOR rgcuValORTaskType IN cuValORTaskType LOOP
    
        FOR rgcuGetPkgVSI IN cuGetPkgVSI LOOP
            nuPackageVSI := rgcuGetPkgVSI.Package_Id;
        END LOOP;
    
        sbComment := fsbgetfnbinfo(nuPackageVSI);
    
    END LOOP;

    pkg_traza.trace(csbMetodo ||' sbComment => '||sbComment, csbNivelTraza);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    
    RETURN sbComment;

EXCEPTION
    WHEN PKG_ERROR.CONTROLLED_ERROR THEN
         PKG_ERROR.setError;
         PKG_ERROR.getError(onuerrorcode, osberrormessage);
         pkg_traza.trace(csbMetodo ||' osberrormessage: ' || osberrormessage, csbNivelTraza);
         pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);    
         RAISE PKG_ERROR.CONTROLLED_ERROR;
    WHEN OTHERS THEN
         PKG_ERROR.setError; 
         PKG_ERROR.getError(onuerrorcode, osberrormessage);
         pkg_traza.trace(csbMetodo ||' osberrormessage: ' || osberrormessage, csbNivelTraza);
         pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);         
         RAISE PKG_ERROR.CONTROLLED_ERROR;
END FSBGETSALEBYORDERVSI;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre funcion FSBGETSALEBYORDERVSI
BEGIN
    pkg_utilidades.prAplicarPermisos('FSBGETSALEBYORDERVSI', 'ADM_PERSON'); 
END;
/
PROMPT OTORGA PERMISOS a REPORTES sobre funcion FSBGETSALEBYORDERVSI
GRANT EXECUTE ON ADM_PERSON.FSBGETSALEBYORDERVSI TO REPORTES;
/
