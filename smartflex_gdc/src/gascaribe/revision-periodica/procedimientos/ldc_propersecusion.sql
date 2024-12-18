CREATE OR REPLACE PROCEDURE LDC_ProPersecusion
IS

/*******************************************************************************
Propiedad intelectual de PROYECTO PETI (c).
Unidad               :  LDC_ProPersecusion
Descripcion          :  Procedimiento para generar universo de usuarios suspendidos con variacion de consumo (PERSECUCION)
Autor                :  Emiro Leyva Hernandez
Fecha                :  29/Oct/2013

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============  ===================


    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
	04/08/2020			OL-Software		Caso 47 - Se adiciona la cadena de conexión a los parametros
										en la programación del proceso

	19/02/2024			jpinedc		    OSF-2341: Ajustes nuevos estandares pro 
                                        migración a V8										
*******************************************************************************/

    csbMetodo        CONSTANT VARCHAR2(70) := 'LDC_ProPersecusion';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;

    nuError         NUMBER;
    sbError         VARCHAR2(4000); 

    cnuNULL_ATTRIBUTE constant number := 2126;

    sbORDER_COMMENT       ge_boInstanceControl.stysbValue;
    sbCICLO               ge_boInstanceControl.stysbValue;
    sbDepartamento        ge_boInstanceControl.stysbValue;
    sbLocalidad           ge_boInstanceControl.stysbValue;
    sbMensajeError        GE_ERROR_LOG.DESCRIPTION%TYPE;
        
    CURSOR culdc_Proceso
    (
        inuProcesId LDC_PROCESO.PROCESO_ID%TYPE
    )
    IS
    SELECT LP.*
    FROM LDC_PROCESO LP
    WHERE LP.PROCESO_ID = inuProcesId;

    rcldc_Proceso          culdc_Proceso%ROWTYPE;
        
    nuIdProceso             ldc_proceso.proceso_id%TYPE; 
    
   
BEGIN
    
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
    
    sbORDER_COMMENT := ge_boInstanceControl.fsbGetFieldValue ('OR_ORDER_COMMENT', 'ORDER_COMMENT');
    sbCICLO := ge_boInstanceControl.fsbGetFieldValue ('CICLO', 'CICLCICO');
    sbDepartamento := ge_boInstanceControl.fsbGetFieldValue ('GE_GEOGRA_LOCATION', 'GEO_LOCA_FATHER_ID');
    sbLocalidad := ge_boInstanceControl.fsbGetFieldValue ('GE_GEOGRA_LOCATION', 'GEOGRAP_LOCATION_ID');

    ------------------------------------------------
    -- Required Attributes
    ------------------------------------------------

    if (sbCICLO is null) then
        pkg_error.setErrorMessage(inuCodeError => cnuNULL_ATTRIBUTE,  isbMsgErrr => 'Ciclo' );
    end if;
    
    if (sbDepartamento is null) then
        pkg_error.setErrorMessage(inuCodeError => cnuNULL_ATTRIBUTE,  isbMsgErrr => 'Departamento' );
    end if;
    
    if (sbLocalidad is null) then
        pkg_error.setErrorMessage(inuCodeError => cnuNULL_ATTRIBUTE,  isbMsgErrr => 'Localidad' );
    end if;
    
    if (sbORDER_COMMENT is null) then
        pkg_error.setErrorMessage(inuCodeError => cnuNULL_ATTRIBUTE,  isbMsgErrr => 'Proceso Ejecuta' );
    end if;
    
    nuIdProceso := sbORDER_COMMENT;
    
    OPEN culdc_Proceso(nuIdProceso);
    FETCH culdc_Proceso INTO rcldc_Proceso;
    CLOSE culdc_Proceso;
        
    IF rcldc_Proceso.EMAIL IS NULL THEN
        sbMensajeError := 'No existe E-mail configurado de los funcionarios encargado del proceso de persecucion para ' ||
                      rcldc_Proceso.PROCESO_DESCRIPCION || '.' || chr(10) ||
                      'Si hay más de un e-mail deberán separarse por punto coma (;)';
        pkg_error.setErrorMessage( isbMsgErrr => sbMensajeError );
    END IF;    
    
    -- Se valida si existe otro proceso ejecutandose para el proceso configurado LDC_PROCESOS_NO_PARALELO
    IF (FNUVALPROPERSCA(sbORDER_COMMENT, sbCICLO, sbDepartamento, sbLocalidad) = false) THEN
        sbMensajeError := 'No se puede ejecutar el proceso porque ya existe un proceso en ejecucion con los mismo parámetros. Favor validar';
        pkg_error.setErrorMessage( isbMsgErrr => sbMensajeError);
    END IF;
        
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 
    
EXCEPTION
    WHEN pkg_error.Controlled_Error THEN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
        pkg_Error.getError(nuError,sbError);        
        pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
        RAISE pkg_error.Controlled_Error;
    WHEN OTHERS THEN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
        pkg_error.setError;
        pkg_Error.getError(nuError,sbError);
        pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
        RAISE pkg_error.Controlled_Error;
END LDC_ProPersecusion;
/