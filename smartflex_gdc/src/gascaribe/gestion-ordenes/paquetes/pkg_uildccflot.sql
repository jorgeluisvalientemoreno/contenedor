CREATE OR REPLACE PACKAGE PKG_UILDCCFLOT IS 
	/*******************************************************************************
		Fuente=Propiedad Intelectual de Gases del Caribe
		
		Autor       :   Jhon Eduar Erazo
		Fecha       :   21-01-2025
		Descripcion :   Paquete UI para el PB LDCCFLOT
		Modificaciones  :
		Autor       Fecha       Caso     	Descripcion
		jerazomvm	21/01/2025	OSF-3871	Creación
	*******************************************************************************/
	
	/**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de GDC">
    <Unidad> fsbVersion </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 27-01-2025 </Fecha>
    <Descripcion> 
        Obtiene la version del paquete.
    </Descripcion>
    <Retorno Nombre="Versión del paquete" Tipo="VARCHAR2">
        Versión del paquete
    </Retorno>
    <Historial>
            <Modificacion Autor="Jhon.Erazo" Fecha="27-01-2025" Inc="OSF-3871" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </Procedure>
    **************************************************************************/
    FUNCTION fsbVersion
    RETURN VARCHAR2;	
	 
	-- Realiza el registro del PB LDCCFLOT
	PROCEDURE prcObjeto;
									
END PKG_UILDCCFLOT;
/
CREATE OR REPLACE PACKAGE BODY PKG_UILDCCFLOT IS

    -- Constantes para el control de la traza
    csbSP_NAME 	CONSTANT VARCHAR2(35) := $$PLSQL_UNIT||'.';
	cnuNVLTRC   CONSTANT NUMBER       := pkg_traza.cnuNivelTrzDef;
	csbInicio   CONSTANT VARCHAR2(35) := pkg_traza.fsbINICIO;
	
    -- Identificador del ultimo caso que hizo cambios
    csbVersion 	VARCHAR2(15) := 'OSF-3871';

	/**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de GDC">
    <Unidad> fsbVersion </Unidad>
    <Autor> Jhon.Erazo </Autor>
    <Fecha> 21-01-2025 </Fecha>
    <Descripcion> 
        Obtiene la version del paquete.
    </Descripcion>
    <Retorno Nombre="Versión del paquete" Tipo="VARCHAR2">
        Versión del paquete
    </Retorno>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="21-01-2025" Inc="OSF-3871" Empresa="GDC"> 
               Creación
           </Modificacion>
    </Historial>
    </Procedure>
    **************************************************************************/
    FUNCTION fsbVersion
    RETURN VARCHAR2
    IS
    BEGIN
        return CSBVERSION;
    END fsbVersion;
	
	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prcObjeto
    Descripcion     : Realiza el registro del PB LDCCFLOT
    Autor           : Jhon Erazo
    Fecha           : 21-01-2025
  
    Parametros de Entrada
	  
    Parametros de Salida
	
  
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso    	Descripcion
	jerazomvm	21/01/2025	OSF-3871	Creación
	***************************************************************************/	
	PROCEDURE prcObjeto
	IS
	
		csbMETODO   				CONSTANT VARCHAR2(100) := csbSP_NAME ||'prcObjeto';
		
		nuError						NUMBER;  
		nuOrdenId					or_order.order_id%TYPE;
		sbmensaje   				VARCHAR2(1000);	
		sbInstanciaActual			VARCHAR2(4000);
		sbOrdenId					VARCHAR2(4000);
		sbFechaLegalizacion			VARCHAR2(4000);
		sbComentario				ldc_au_cflot.observacion%TYPE;
		dtNuevaFechaLegalizacion	DATE;

	BEGIN

		pkg_traza.trace(csbMETODO, cnuNVLTRC, csbInicio);
		
		-- Obtiene la instancia actual
		GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstanciaActual);
		pkg_traza.trace('sbInstanciaActual: ' || sbInstanciaActual, cnuNVLTRC);
	
		-- Obtiene la orden
		prc_obtienevalorinstancia(sbInstanciaActual,
								  NULL,
								  'OR_ORDER',
								  'ORDER_ID',
								  sbOrdenId
								  );

		pkg_traza.trace('sbOrdenId: ' || sbOrdenId, cnuNVLTRC);

		nuOrdenId := TO_NUMBER(sbOrdenId);
		pkg_traza.trace('nuOrdenId: ' || nuOrdenId, cnuNVLTRC);

		
		--Obtiene la nueva fecha de legalizacion dada por forma
		prc_obtienevalorinstancia(sbInstanciaActual,
								  NULL,
								  'OR_ORDER',
								  'LEGALIZATION_DATE',
								  sbFechaLegalizacion
								  );
		pkg_traza.trace('sbFechaLegalizacion: ' || sbFechaLegalizacion, cnuNVLTRC);
		
		dtNuevaFechaLegalizacion :=  TO_DATE(sbFechaLegalizacion, ldc_boConsGenerales.fsbGetFormatoFecha);
		pkg_traza.trace('dtNuevaFechaLegalizacion: ' || dtNuevaFechaLegalizacion, cnuNVLTRC);
		
		--Obtiene el comentario
		prc_obtienevalorinstancia(sbInstanciaActual,
								  NULL,
								  'OR_OPER_UNIT_COMMENT',
								  'COMMENTS',
								  sbComentario
								  );
		pkg_traza.trace('sbComentario: ' || sbComentario, cnuNVLTRC);
		
		-- Procesa el registro
		pkg_boldccflot.prcProcesa(nuOrdenId,
								  dtNuevaFechaLegalizacion,
								  sbComentario
								  );
		
		COMMIT;

		pkg_traza.trace(csbMETODO, cnuNVLTRC, pkg_traza.csbFIN);

	EXCEPTION
		WHEN pkg_error.CONTROLLED_ERROR THEN
			pkg_error.setError;
			pkg_Error.getError(nuError, sbmensaje);
			pkg_traza.trace('nuError: ' || nuError || ' sbmensaje: ' || sbmensaje, cnuNVLTRC);
			pkg_traza.trace(csbSP_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC); 
			RAISE pkg_error.CONTROLLED_ERROR;
		WHEN others THEN
			pkg_Error.setError;
			pkg_Error.getError(nuError, sbmensaje);
			pkg_traza.trace('nuError: ' || nuError || ' sbmensaje: ' || sbmensaje, cnuNVLTRC);
			pkg_traza.trace(csbSP_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR); 
			RAISE pkg_Error.Controlled_Error;
	END prcObjeto;

END PKG_UILDCCFLOT;
/
PROMPT Otorgando permisos de ejecución para PKG_UILDCCFLOT
BEGIN
    pkg_utilidades.prAplicarPermisos('PKG_UILDCCFLOT', 'OPEN');
END;
/