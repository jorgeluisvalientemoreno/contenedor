CREATE OR REPLACE PROCEDURE PERSONALIZACIONES.OAL_RealizaCambioDeCiclo
(
    inuOrden				IN NUMBER,
    inuCausal				IN NUMBER,
    inuPersona 			    IN NUMBER,
    idtFechIniEje 		    IN DATE,
    idtFechaFinEje 		    IN DATE,
    isbDatosAdic 			IN VARCHAR2,
    isbActividades 		    IN VARCHAR2,
    isbItemsElementos 	    IN VARCHAR2,
    isbLecturaElementos	    IN VARCHAR2,
    isbComentariosOrden 	IN VARCHAR2
) 
IS
/**************************************************************************
    Propiedad intelectual de Gases del Caribe S.A (c).
            
    Nombre      :   OAL_RealizaCambioDeCiclo
    Descripción :   Objeto de legalización de orden 12134
    Autor       :   jcatuche
    Fecha       :   16/12/2024
    
    Parametros Entrada:
    ----------------------------------------------------------------------------
    inuOrden 				Identificador de la orden
    inuCausal				Idenditificador de la causal de legalizacion
    inuPersona 				Idenditificador de la persona
    idtFechIniEje 			Fecha de inicio de la ejecucion
    idtFechaFinEje 			Fecha de fin de la ejecucion
    isbDatosAdic 			Datos adicionales
    isbActividades 			Actividades
    isbItemsElementos 		Items elementos
    isbLecturaElementos		Lecturas elementos
    isbComentariosOrden 	Comentario de la orden
            
    Historial de Modificaciones
    ---------------------------------------------------------------------------
    Fecha         Autor         Descripcion
    =====         =======       ===============================================
    16/12/2024    jcatuche      OSF-3758: Creación
***************************************************************************/
    -- Constantes para el control de la traza
    csbMetodo           CONSTANT VARCHAR2(32)       := $$PLSQL_UNIT;          -- Constante para nombre de objeto    
    csbNivelTraza       CONSTANT NUMBER(2)          := pkg_traza.cnuNivelTrzDef;    -- Nivel de traza para este objeto. 
    csbInicio           CONSTANT VARCHAR2(4)        := pkg_traza.fsbINICIO;         -- Indica inicio de método
    csbFin              CONSTANT VARCHAR2(4)        := pkg_traza.fsbFIN;            -- Indica Fin de método ok
    csbFin_Erc          CONSTANT VARCHAR2(4)        := pkg_traza.fsbFIN_ERC;        -- Indica fin de método con error controlado
    csbFin_Err          CONSTANT VARCHAR2(4)        := pkg_traza.fsbFIN_ERR;        -- Indica fin de método con error no controlado
    
     
    -------------------------
    --  PRIVATE VARIABLES
    -------------------------
    nuError             NUMBER;
    sbError             VARCHAR2(2000);
    
    sbGrupoAtr          parametros.codigo%type := 'GRUPO_DATO_ADICIONAL_CICLO';
    nuClaseCausal		ge_causal.class_causal_id%type;
    nuGrupoAtributo		parametros.valor_numerico%type;
    sbNombreAtributo    parametros.valor_cadena%type;
    sbDatoAdicional	    or_requ_data_value.value_1%TYPE;	
    nuContrato          NUMBER;
    nuCiclo             NUMBER;
    
    
    
BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
    pkg_traza.trace('inuOrden:              <= '|| inuOrden, csbNivelTraza);
	pkg_traza.trace('inuCausal:             <= '|| inuCausal, csbNivelTraza);
	pkg_traza.trace('inuPersona:            <= '|| inuPersona, csbNivelTraza);
	pkg_traza.trace('idtFechIniEje:         <= '|| idtFechIniEje, csbNivelTraza);
	pkg_traza.trace('idtFechaFinEje:        <= '|| idtFechaFinEje, csbNivelTraza);
	pkg_traza.trace('isbDatosAdic:          <= '|| isbDatosAdic, csbNivelTraza);
	pkg_traza.trace('isbActividades:        <= '|| isbActividades, csbNivelTraza);
	pkg_traza.trace('isbItemsElementos:     <= '|| isbItemsElementos, csbNivelTraza);
	pkg_traza.trace('isbLecturaElementos:   <= '|| isbLecturaElementos, csbNivelTraza);
	pkg_traza.trace('isbComentariosOrden:   <= '|| isbComentariosOrden, csbNivelTraza); 
        
    -- Obtiene la clase de causal de legalización
	nuClaseCausal	:= pkg_bcordenes.fnuObtieneClaseCausal(inuCausal);
	pkg_traza.trace('nuClaseCausal: ' || nuClaseCausal, csbNivelTraza); 

	-- Si la clase de la causal es de exito se realiza el cambio de ciclo
	IF (nuClaseCausal = 1) THEN
	
        --Obtiene el contrato de la orden 
        nuContrato := pkg_bcordenes.fnuObtieneContrato(inuOrden);
        pkg_traza.trace('nuContrato: ' || nuContrato, csbNivelTraza);
        
        --Obtiene el valor del grupo de atributos
        nuGrupoAtributo := pkg_parametros.fnuGetValorNumerico(sbGrupoAtr);
        
        --Obtiene el nombre del atributo
        sbNombreAtributo := pkg_parametros.fsbGetValorCadena(sbGrupoAtr);
        
        if nuGrupoAtributo is null or sbNombreAtributo is null then 
            sberror := 'El parámetro '||sbGrupoAtr||' no existe o no tiene valores configurados';
            pkg_Error.setErrorMessage( isbMsgErrr => sberror);
        end if;
        
        pkg_traza.trace('nuGrupoAtributo: ' || nuGrupoAtributo, csbNivelTraza);
        pkg_traza.trace('sbNombreAtributo: ' || sbNombreAtributo, csbNivelTraza);
        
        -- Obtiene el valor adicional del ciclo para la orden
        sbDatoAdicional := pkg_bcordenes.fsbObtValorDatoAdicional(inuOrden,nuGrupoAtributo,sbNombreAtributo);
        pkg_traza.trace('sbDatoAdicional: ' || sbDatoAdicional, csbNivelTraza);
        
        nuCiclo := to_number(sbDatoAdicional);
        
        --Realiza cambio de ciclo en GIS y Open
        API_ActualizaCiclo
        (
            nuContrato,     --Número del contrato
            nuCiclo,        --Número del ciclo
            inuOrden,        --Número de orden
            nuError,
            sbError
        );
        
        if nuerror != constants_per.ok then
            pkg_Error.setErrorMessage( isbMsgErrr => sberror);
        end if;
        
	END IF;
	
	pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
    
EXCEPTION
    WHEN pkg_Error.Controlled_Error  THEN
        pkg_Error.getError(nuError, sbError);
        pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
        RAISE pkg_Error.Controlled_Error;
    WHEN OTHERS THEN
        pkg_Error.setError;
        pkg_Error.getError(nuError, sbError);
        pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
        RAISE pkg_Error.Controlled_Error;
END OAL_RealizaCambioDeCiclo;
/
PROMPT Otorga Permisos de Ejecución a personalizaciones.OAL_REALIZACAMBIODECICLO
BEGIN
  pkg_utilidades.prAplicarPermisos('OAL_REALIZACAMBIODECICLO','PERSONALIZACIONES');
END;
/
