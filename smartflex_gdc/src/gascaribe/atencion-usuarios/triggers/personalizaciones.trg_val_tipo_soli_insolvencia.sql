CREATE OR REPLACE TRIGGER PERSONALIZACIONES.TRG_VAL_TIPO_SOLI_INSOLVENCIA
BEFORE INSERT ON mo_motive
FOR EACH ROW
	/************************************************************************************************************
	Autor       : Jhon Erazo
	Fecha       : 09/06/2025
	Proceso     : PERSONALIZACIONES.TRG_VAL_TIPO_SOLI_INSOLVENCIA
	Ticket      : OSF-4544
	Descripcion : Trigger para validar el registro de la solicitud no esta bloqueada para contratos 
				  de insolvencia economica

	Historia de ModIFicaciones
	Fecha           Autor               ModIFicacion
	=========       =========           ====================
	09/06/2025		jerazomvm			OSF-4544: Creación                                                     
	*************************************************************************************************************/
DECLARE
	
	-- IdentIFicador del ultimo caso que hizo cambios
    csbVersion 	VARCHAR2(15) := 'OSF-4544';
	
     --Constantes
	csbSP_NAME  	CONSTANT VARCHAR2(100)	:= $$PLSQL_UNIT;
	cnuNVLTRC   	CONSTANT NUMBER       	:= pkg_traza.cnuNivelTrzDef;
	csbInicio   	CONSTANT VARCHAR2(35) 	:= pkg_traza.fsbINICIO;

	nuError         NUMBER;
	sbError         VARCHAR(4000);

BEGIN

	pkg_traza.trace(csbSP_NAME, cnuNVLTRC, csbInicio);
	
	-- Valida el registro de la solicitud no esta bloqueada para contratos de insolvencia economica
	pkg_boinsolvencia_economica.prcValRegistroDeSolicitud(:NEW.subscription_id,
														  :NEW.package_id
														  );
	
	pkg_traza.trace(csbSP_NAME, cnuNVLTRC, pkg_traza.csbFIN);
	
EXCEPTION
	WHEN pkg_error.CONTROLLED_ERROR THEN
		pkg_Error.getError(nuError, sbError);
		pkg_traza.trace('sbError => ' || sbError, cnuNVLTRC);
		pkg_traza.trace(csbSP_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);
		RAISE pkg_error.CONTROLLED_ERROR;
	WHEN OTHERS THEN
		pkg_Error.setError;
		pkg_Error.getError(nuError, sbError);
		pkg_traza.trace('sbError => ' || sbError, cnuNVLTRC);
		pkg_traza.trace(csbSP_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
		RAISE pkg_error.CONTROLLED_ERROR;
	
END TRG_VAL_TIPO_SOLI_INSOLVENCIA;
/