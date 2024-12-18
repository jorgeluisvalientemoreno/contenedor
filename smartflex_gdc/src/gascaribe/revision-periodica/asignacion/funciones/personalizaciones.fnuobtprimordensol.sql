CREATE OR REPLACE FUNCTION personalizaciones.fnuObtPrimOrdenSol(inuPackageId  mo_packages.package_id%TYPE) RETURN NUMBER IS
    PRAGMA AUTONOMOUS_TRANSACTION;
    nuError         NUMBER;
    sbError         VARCHAR2(4000);
    nuPrimeraOtSol  or_order.order_id%TYPE;
    -- Constantes para el control de la traza
	csbMetodo		CONSTANT VARCHAR2(32)	:= $$PLSQL_UNIT||'.'; --Constante nombre método
	csbNivelTraza	CONSTANT NUMBER(2)		:= pkg_traza.cnuNivelTrzDef; 		

BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    nuPrimeraOtSol := pkg_bcsolicitudes.fnuGetPrimeraOT(inuPackageId);
    return nuPrimeraOtSol;
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);    
EXCEPTION
    WHEN OTHERS THEN
        pkg_error.seterror;
		pkg_error.geterror(nuError, sbError);
		pkg_traza.trace('Error: '|| sbError, pkg_traza.cnuNivelTrzDef);
		pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);					
        return nuPrimeraOtSol;
END fnuObtPrimOrdenSol;
/
PROMPT Otorgando permisos de ejecución para adm_person.pkg_bcsolicitudes
BEGIN
    pkg_utilidades.prAplicarPermisos('FNUOBTPRIMORDENSOL', 'PERSONALIZACIONES');
END;
/
