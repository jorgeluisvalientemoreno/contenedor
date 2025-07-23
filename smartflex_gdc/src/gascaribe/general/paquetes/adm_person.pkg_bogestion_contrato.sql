CREATE OR REPLACE PACKAGE ADM_PERSON.pkg_bogestion_contrato IS
/*******************************************************************************
    Fuente=Propiedad Intelectual de Gases del Caribe
    pkg_bogestion_contrato
    Autor       :   Luis Felipe Valencia Hurtado
    Fecha       :   25/03/2025
    Descripcion :   Para publicar Servicios con logica de negocio de contrato
	
    Modificaciones  :
    Autor               Fecha       Caso    	Descripcion
	felipe.valencia		25/03/2025	OSF-3846  	Creacion
	
*******************************************************************************/

    -- Retona Identificador del ultimo caso que hizo cambios
    FUNCTION fsbVersion RETURN VARCHAR2;

    --Valida datos Basicos de cliente
    PROCEDURE prcValidaDatosBasicoscliente
    (
        inuContrato	IN	SUSCRIPC.SUSCCODI%TYPE
    );

    --Valida datos Basicos de contrato
    PROCEDURE prcValidaContrato
    (
        inuContrato     IN suscripc.susccodi%TYPE,
        inuProducto     IN servsusc.sesunuse%TYPE
    );
END pkg_bogestion_contrato;
/

CREATE OR REPLACE PACKAGE BODY ADM_PERSON.pkg_bogestion_contrato IS

    -- Identificador del ultimo caso que hizo cambios
    csbVersion                 VARCHAR2(15) := 'OSF-3846';

    -- Constantes para el control de la traza
    csbSP_NAME                 CONSTANT VARCHAR2(35)         :=  $$PLSQL_UNIT||'.';
    cnuNVLTRC                  CONSTANT NUMBER                := 5;
    
    nuError                     NUMBER;
    sbError                     VARCHAR2(4000);


    --Retona la ultimo caso que hizo cambios en el paquete 
    FUNCTION fsbVersion RETURN VARCHAR2 IS
    BEGIN
        RETURN csbVersion;
    END fsbVersion;

	/**************************************************************************
    <Procedure prcValidaDatosBasicoscliente="Propiedad Intelectual de <Empresa>">
    <Unidad> frfConsulta </Unidad>
    <Autor> Luis Felipe Valencia Hurtado</Autor>
    <Fecha> 27/12/2024 </Fecha>
    <Descripcion> 
       Valida datos Basicos de cliente
    </Descripcion>
    <Historial>
        <Modificacion Autor="felipe.valencia" Fecha="25/03/2025" Inc="OSF-3846" Empresa="EFG">
            Creación
        </Modificacion>
    </Historial>
    </Procedure>
    **************************************************************************/
    PROCEDURE prcValidaDatosBasicoscliente
    (
        inuContrato	IN	SUSCRIPC.SUSCCODI%TYPE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prcValidaDatosBasicoscliente';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);         
    BEGIN
        pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbINICIO); 
			
        pkSubscriberMgr.ValBasicData(inuContrato);

        pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN); 
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, cnuNVLTRC );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, cnuNVLTRC );
            RAISE pkg_error.Controlled_Error;
    END prcValidaDatosBasicoscliente;	


	/**************************************************************************
    <Procedure prcValidaDatosBasicoscliente="Propiedad Intelectual de <Empresa>">
    <Unidad> frfConsulta </Unidad>
    <Autor> Luis Felipe Valencia Hurtado</Autor>
    <Fecha> 27/12/2024 </Fecha>
    <Descripcion> 
       Valida datos Basicos de contrato
    </Descripcion>
    <Historial>
        <Modificacion Autor="felipe.valencia" Fecha="25/03/2025" Inc="OSF-3846" Empresa="EFG">
            Creación
        </Modificacion>
    </Historial>
    </Procedure>
    **************************************************************************/
    PROCEDURE prcValidaContrato
    (
        inuContrato     IN suscripc.susccodi%TYPE,
        inuProducto     IN servsusc.sesunuse%TYPE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prcValidaContrato';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);         
    BEGIN
        pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbINICIO); 
			
        pkServNumberMgr.ValSubscription(inuContrato,inuProducto);

        pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN); 
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, cnuNVLTRC );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, cnuNVLTRC );
            RAISE pkg_error.Controlled_Error;
    END prcValidaContrato;	
END pkg_bogestion_contrato;
/
PROMPT Otorgando permisos de ejecución para adm_person.pkg_bogestion_contrato
BEGIN
    pkg_utilidades.prAplicarPermisos('pkg_bogestion_contrato', 'ADM_PERSON');
END;
/