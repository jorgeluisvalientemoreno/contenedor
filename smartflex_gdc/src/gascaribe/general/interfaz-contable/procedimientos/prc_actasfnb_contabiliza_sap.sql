CREATE OR REPLACE PROCEDURE prc_ActasFNB_Contabiliza_Sap(idtFecIni IN DATE DEFAULT NULL,
                                                         idtFecFin IN DATE DEFAULT NULL) 
IS    
    /******************************************************************
    Propiedad intelectual de Gases del Caribe

    Unidad:       prc_ActasFNB_Contabiliza_Sap
    Descripcion:  Ejecuta el Procedimiento que registra la informacion de la contabilizacion
                  de las actas brilla procesadas el día inmediatamente anterior a su ejecución.
                  Se crea para poder ser usado desde GEMPS

    Autor:        German Dario Guevara Alzate - GlobaMVM
    Fecha:        05/04/2024
    
    Historial de Modificaciones
    --------------------------------------------------------------
    Fecha       Autor           Modificación
    --------------------------------------------------------------
    18/02/2025  Paola Acosta    OSF-3844: Se agregan parámetros de entrada
                                          al proceso e invocación del proceso
                                          pkg_ContabilizaActasAut.prProcesaActasFNB_Sap
                                          Se Aplican pautas tecnicas
    
    ******************************************************************/
    
    cnuNvlTrz      CONSTANT NUMBER       := pkg_traza.cnuNivelTrzDef;
	csbInicio      CONSTANT VARCHAR2(35) := pkg_traza.fsbInicio;
    csbFin         CONSTANT VARCHAR2(35) := pkg_traza.csbFin;  
    csbFin_Err     CONSTANT VARCHAR2(35) := pkg_traza.csbFin_Err;
    
    nuError		    NUMBER;  
	sbMensaje	    VARCHAR2(4000);     
    csbMtd_Nombre   VARCHAR2(70) := 'prc_ActasFNB_Contabiliza_Sap';
    
BEGIN
    pkg_traza.trace(csbMtd_Nombre, cnuNvlTrz, csbInicio);
    
    pkg_ContabilizaActasAut.prProcesaActasFNB_Sap(idtFecIni, idtFecFin);
    
    pkg_traza.trace(csbMtd_Nombre, cnuNvlTrz, csbFin);
EXCEPTION
    WHEN OTHERS THEN
        pkg_error.setError;
		pkg_error.getError(nuError, sbMensaje);
		pkg_traza.trace('Error en procedimiento prc_ActasFNB_Contabiliza_Sap - Error: ' || nuError || ', ' || 'Mensaje: ' || sbMensaje, cnuNvlTrz);
		pkg_traza.trace(csbMtd_Nombre, cnuNvlTrz, csbFin_Err);
END prc_ActasFNB_Contabiliza_Sap;
/

BEGIN
    pkg_utilidades.prAplicarPermisos('PRC_ACTASFNB_CONTABILIZA_SAP','OPEN');
END;
/