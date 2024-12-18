/***************************************************************************
	Propiedad Intelectual de Gas Caribe
	
    Programa        : api_creacargos
    Descripcion     : Api para creción de cargos.
    Autor           : Luis Felipe Valencia Hurtado
    Fecha           : 25-07-2023
	 
    Parametros de Entrada
        inuProducto         Código de producto 
        inuConcepto         Código del Concepto
        inuUnidades         Unidades
        inuCausaCargo       Causa del cargo
        inuValorCargo       Valor del cargo
        isbDocSoporte       Documento de Soorte
        inuPeriodoConsumo   Periodo de consumo

    
	Parametros de Salida
		onuCodigoError        Código de error
		osbMensajeError     Mensaje de error

		
    Modificaciones  :
    =========================================================
    Autor           Fecha           Descripción
	felipe.valencia	25-07-2023		Creación
***************************************************************************/
CREATE OR REPLACE PROCEDURE adm_person.api_creacargos
(
    inuProducto         IN NUMBER,
    inuConcepto         IN NUMBER,
    inuUnidades         IN NUMBER,
    inuCausaCargo       IN NUMBER,
    inuValorCargo       IN NUMBER,
    isbDocSoporte       IN VARCHAR2,
    inuPeriodoConsumo   IN NUMBER,
    onuCodigoError      OUT NUMBER,
    osbMensajeError     OUT VARCHAR2
)
IS
    nuCodigoCodigo      NUMBER(18);
    sbMesajeError       VARCHAR2(2000);                                        
BEGIN

	ut_trace.trace('Inicio api_creacargos ' || chr(10) ||
					'inuProducto: ' 		|| inuProducto 			|| chr(10) ||
					'inuConcepto: ' 	    || inuConcepto 		|| chr(10) ||
					'inuUnidades: '	        || inuUnidades	|| chr(10) ||
					'inuCausaCargo: ' 	    || inuCausaCargo || chr(10) ||
					'inuValorCargo: ' 	    || inuValorCargo || chr(10) ||
					'isbDocSoporte: ' 	    || isbDocSoporte || chr(10) ||
					'inuPeriodoConsumo: ' 	|| inuPeriodoConsumo , 2);
  
    os_chargetobill
    (
        inuProducto,
        inuConcepto,
        inuUnidades,
        inuCausaCargo,
        inuValorCargo,
        isbDocSoporte,
        inuPeriodoConsumo,
        nuCodigoCodigo,
        sbMesajeError
    );
                  
    onuCodigoError := nuCodigoCodigo;
    osbMensajeError := sbMesajeError;

	ut_trace.trace('Termina api_creacargos ' 		|| chr(10) ||
					'onuCodigoError: ' 	|| onuCodigoError 	|| chr(10) ||
					'osbMensajeError: '	|| osbMensajeError, 3);


EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
        ut_trace.trace('PKG_ERROR.CONTROLLED_ERROR.api_creacargos', 4);
        pkg_Error.setError;
        pkg_error.getError(onuCodigoError, osbMensajeError);
    WHEN OTHERS THEN
        ut_trace.trace('OTHERS api_creacargos', 4);
        pkg_Error.SETERROR;
        pkg_error.getError(onuCodigoError, osbMensajeError);
END api_creacargos;
/
BEGIN

	pkg_utilidades.prAplicarPermisos('API_CREACARGOS', 'ADM_PERSON'); 

END;
/
