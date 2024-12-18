create or replace procedure adm_person.API_GENERAESTADOCUENTAXFECHA(INUPRODUCTID             IN           SERVSUSC.SESUNUSE%TYPE,
																	IDTDATE                  IN           DATE,
																	ONUCURRENTACCOUNTTOTAL   OUT          NUMBER,
																	ONUDEFERREDACCOUNTTOTAL  OUT          NUMBER,
																	ONUCREDITBALANCE         OUT          NUMBER,
																	ONUCLAIMVALUE            OUT          NUMBER,
																	ONUDEFCLAIMVALUE         OUT          NUMBER,
																	OTBBALANCEACCOUNTS       OUT  NOCOPY  FA_BOACCOUNTSTATUSTODATE.TYTBBALANCEACCOUNTS,
																	OTBDEFERREDBALANCE       OUT  NOCOPY  FA_BOACCOUNTSTATUSTODATE.TYTBDEFERREDBALANCE
																	)										 
IS
/***************************************************************************
	Propiedad Intelectual de Gases del Caribe
	
    Programa        : API_GENERAESTADOCUENTAXFECHA
    Descripcion     : Api para generar estados de cuenta de un producto por fecha.
    Autor           : Jhon Eduar Erazo Guchavez
    Fecha           : 27-10-2023
	 
    Parametros de Entrada
    
	Parametros de Salida
		
    Modificaciones  :
    =========================================================
    Autor       Fecha       	Caso		Descripción
	jerazomvm	27-10-2023		OSF-1813	Creación
***************************************************************************/

	-- Constantes para el control de la traza
	csbSP_NAME		CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT||'.';
    cnuNVLTRC       CONSTANT NUMBER(2)  	:= pkg_traza.fnuNivelTrzDef;
	
BEGIN

	pkg_traza.trace(csbSP_NAME, cnuNVLTRC, pkg_traza.fsbINICIO);
		
	pkg_traza.trace('INUPRODUCTID: ' || INUPRODUCTID || chr(10) ||
					'IDTDATE: '		 || IDTDATE, cnuNVLTRC);

	FA_BOACCOUNTSTATUSTODATE.PRODUCTBALANCEACCOUNTSTODATE(INUPRODUCTID,
														  IDTDATE,
														  ONUCURRENTACCOUNTTOTAL,
														  ONUDEFERREDACCOUNTTOTAL,
														  ONUCREDITBALANCE,
														  ONUCLAIMVALUE,
														  ONUDEFCLAIMVALUE,
														  OTBBALANCEACCOUNTS,
														  OTBDEFERREDBALANCE
														  );
														  
	pkg_traza.trace('ONUCURRENTACCOUNTTOTAL: ' 	|| ONUCURRENTACCOUNTTOTAL 	|| chr(10) ||
					'ONUDEFERREDACCOUNTTOTAL: '	|| ONUDEFERREDACCOUNTTOTAL 	|| chr(10) ||
					'ONUCREDITBALANCE: '		|| ONUCREDITBALANCE 		|| chr(10) ||
					'ONUCLAIMVALUE: '		 	|| ONUCLAIMVALUE 			|| chr(10) ||
					'ONUDEFCLAIMVALUE: '		|| ONUDEFCLAIMVALUE, cnuNVLTRC);
							
	pkg_traza.trace(csbSP_NAME, cnuNVLTRC, pkg_traza.csbFIN);
							

EXCEPTION
	WHEN PKG_ERROR.CONTROLLED_ERROR THEN
		pkg_traza.trace(csbSP_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);
		RAISE PKG_ERROR.CONTROLLED_ERROR;
	WHEN OTHERS THEN
		pkg_traza.trace(csbSP_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
		pkg_Error.SETERROR;
		RAISE PKG_ERROR.CONTROLLED_ERROR;
END API_GENERAESTADOCUENTAXFECHA;
/
BEGIN

	pkg_utilidades.prAplicarPermisos('API_GENERAESTADOCUENTAXFECHA', 'ADM_PERSON'); 

END;
/