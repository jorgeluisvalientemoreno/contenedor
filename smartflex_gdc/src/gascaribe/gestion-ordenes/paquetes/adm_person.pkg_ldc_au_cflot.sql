CREATE OR REPLACE PACKAGE ADM_PERSON.PKG_LDC_AU_CFLOT IS
	/*******************************************************************************
		Fuente=Propiedad Intelectual de Gases del Caribe
		
		Autor       :   Jhon Eduar Erazo
		Fecha       :   21-01-2025
		Descripcion :   Paquete con los metodos para manejo de información sobre los productos
		Modificaciones  :
		Autor       Fecha       Caso     	Descripcion
		jerazomvm	21/01/2025	OSF-3871	Creación
	*******************************************************************************/
	
	TYPE tytbRowIds IS TABLE OF ROWID INDEX BY BINARY_INTEGER;
    TYPE tytbRegistros IS TABLE OF ldc_au_cflot%ROWTYPE INDEX BY BINARY_INTEGER;
	
    CURSOR culdc_au_cflot 
	IS 
		SELECT * 
		FROM ldc_au_cflot;
	
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
	
	-- Inserta los registros en ldc_au_cflot
	PROCEDURE prcInsRegistro(inuorder_id 		IN or_order.order_id%TYPE,
							 idtfech_lega_ante	IN DATE,
							 idtfech_lega_nuev  IN DATE,
							 isbobservacion		IN ldc_au_cflot.observacion%TYPE,
							 idtfecha			IN DATE,
							 isbusuario			IN ldc_au_cflot.observacion%TYPE,
						     isbterminal		IN ldc_au_cflot.terminal%TYPE,
							 isbprograma		IN ldc_au_cflot.programa%TYPE
							);
									
END PKG_LDC_AU_CFLOT;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.PKG_LDC_AU_CFLOT IS

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
    Programa        : prcInsRegistro
    Descripcion     : Inserta los registros en ldc_au_cflot
    Autor           : Jhon Erazo
    Fecha           : 21-01-2025
  
    Parametros de Entrada
		inuorder_id			Identificador de la orden
		idtfech_lega_ante	Fecha de legalización antigua
		idtfech_lega_nuev	Nueva fecha de legalización
		isbobservacion		Observación
		idtfecha			Fecha registro
		isbusuario			Usuario
		isbterminal			Terminal
		isbprograma			Programa
	  
    Parametros de Salida
	
  
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso    	Descripcion
	jerazomvm	21/01/2025	OSF-3871	Creación
	***************************************************************************/	
	PROCEDURE prcInsRegistro(inuorder_id 		IN or_order.order_id%TYPE,
							 idtfech_lega_ante	IN DATE,
							 idtfech_lega_nuev  IN DATE,
							 isbobservacion		IN ldc_au_cflot.observacion%TYPE,
							 idtfecha			IN DATE,
							 isbusuario			IN ldc_au_cflot.observacion%TYPE,
						     isbterminal		IN ldc_au_cflot.terminal%TYPE,
							 isbprograma		IN ldc_au_cflot.programa%TYPE
							)
	IS
	
		csbMETODO   CONSTANT VARCHAR2(100) := csbSP_NAME ||'prcInsRegistro';
		nuError		NUMBER;  
		sbmensaje   VARCHAR2(1000);			

	BEGIN

		pkg_traza.trace(csbMETODO, cnuNVLTRC, csbInicio);
		
		pkg_traza.trace('inuorder_id: '			|| inuorder_id 		 || CHR(10) ||
						'idtfech_lega_ante: '	|| idtfech_lega_ante || CHR(10) ||
						'idtfech_lega_nuev: '	|| idtfech_lega_nuev || CHR(10) ||
						'isbobservacion: '		|| isbobservacion 	 || CHR(10) ||
						'idtfecha: '			|| idtfecha 		 || CHR(10) ||
						'isbusuario: '			|| isbusuario 		 || CHR(10) ||
						'isbterminal: '			|| isbterminal 		 || CHR(10) ||
						'isbprograma: '			|| isbprograma, cnuNVLTRC);
		
		INSERT INTO ldc_au_cflot(order_id,
								 fech_lega_ante,
								 fech_lega_nuev,
								 observacion,
								 fecha,
								 usuario,
								 terminal,
								 programa
								 )
		VALUES (inuorder_id,
				idtfech_lega_ante,
				idtfech_lega_nuev,
				isbobservacion,
				idtfecha,
				isbusuario,
				isbterminal,
				isbprograma
				);

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
	END prcInsRegistro;

END PKG_LDC_AU_CFLOT;
/
PROMPT Otorgando permisos de ejecución para adm_person.PKG_LDC_AU_CFLOT
BEGIN
    pkg_utilidades.prAplicarPermisos('PKG_LDC_AU_CFLOT', 'ADM_PERSON');
END;
/