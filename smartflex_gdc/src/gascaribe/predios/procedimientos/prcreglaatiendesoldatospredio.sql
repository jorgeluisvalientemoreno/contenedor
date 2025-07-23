CREATE OR REPLACE PROCEDURE prcReglaAtiendeSolDatosPredio
IS
    /**************************************************************************
        Propiedad Intelectual de Gases del caribe S.A E.S.P

        Unidad:       prcReglaAtiendeSolDatosPredio
        Descripcion:  procedimiento que ejecuta la regla asociada a la acción
                      Atiende la Solicitud de Actualización de Datos del Predio

        Autor:        Luis Felipe Valencia Hurtado
        
        Caso:         OSF-3198
        Fecha:        08/11/2024
        
        Modificaciones
        08/11/2024      felipe.valencia     Creción
    **************************************************************************/

    nuError                 NUMBER;     
    nuSolicitud             NUMBER;  
    sbError                 VARCHAR2(4000);
    sbSolicitud             VARCHAR2(4000);
    csbMetodo               CONSTANT VARCHAR2(100) := 'prcReglaAtiendeSolDatosPredio';

BEGIN
    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);   

    ge_boinstance.getvalue('MO_PACKAGES', 'PACKAGE_ID', sbSolicitud);

    nuSolicitud := TO_NUMBER(sbSolicitud);

    pkg_boGestionSolicitudes.prcAtenderSolicitud(nuSolicitud, 58);

    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
EXCEPTION
    WHEN pkg_error.controlled_error THEN
        pkg_error.getError(nuError, sbError);    
        pkg_traza.trace('Error controlado en procedimiento prcReglaAtiendeSolDatosPredio '||sbError, pkg_traza.cnuNivelTrzDef);
        RAISE pkg_Error.Controlled_Error;
    WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.getError(nuError, sbError);
        pkg_traza.trace('Error en procedimiento prcReglaAtiendeSolDatosPredio '||sbError, pkg_traza.cnuNivelTrzDef);
        RAISE pkg_Error.Controlled_Error;
END prcReglaAtiendeSolDatosPredio;
/

BEGIN
    pkg_utilidades.prAplicarPermisos('prcReglaAtiendeSolDatosPredio','OPEN');
END;
/