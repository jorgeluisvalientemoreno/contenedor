CREATE OR REPLACE PACKAGE ADM_PERSON.pkg_bogestion_segmentacion IS
/*******************************************************************************
    Fuente=Propiedad Intelectual de Gases del Caribe
    pkg_bogestion_segmentacion
    Autor       :   Luis Felipe Valencia Hurtado
    Fecha       :   01/04/2024
    Descripcion :   Para publicar Servicios con logica de negocio de sergmentación  
                    comercial
    Modificaciones  :
    Autor               Fecha       Caso    	Descripcion
	felipe.valencia		01/04/2024	OSF-4166  	Creacion

*******************************************************************************/

    -- Retona Identificador del ultimo caso que hizo cambios
    FUNCTION fsbVersion RETURN VARCHAR2;

    --Proceso de actualización de segmentación comercial
    PROCEDURE prcCambiaSegmentacionComercial
    (
        iclSegmentacionComercial    IN CLOB,
        oclResulado                 OUT CLOB,
        iblValida                   IN BOOLEAN DEFAULT FALSE
    );

    FUNCTION fsbObtieneNombrePersona
    RETURN VARCHAR2;

    --Obtiene segmentación comercial
    PROCEDURE prcObtSegmentacionComercial
    (
        orfSegmentacionComercial    OUT constants_per.tyrefcursor,
		onuerrorcode        OUT NUMBER,
		osberrormessage     OUT VARCHAR2
    );

    --Obtiene información de segmentación comercial
    PROCEDURE prcObtInfoSegmentComercial
    (
        inuSegmenacionComercial     IN cc_commercial_segm.commercial_segm_id%TYPE, 
        orfInfoDemografica          OUT constants_per.tyrefcursor,
        orfInfoGeoPolitica          OUT constants_per.tyrefcursor,
        orfInfoComercial            OUT constants_per.tyrefcursor,
        orfInfoFinanciera           OUT constants_per.tyrefcursor, 
        orfPlanesComerciales        OUT constants_per.tyrefcursor, 
        orfPromociones              OUT constants_per.tyrefcursor, 
        orfPlanesFinanciacion       OUT constants_per.tyrefcursor, 
		onuerrorcode                OUT NUMBER,
		osberrormessage             OUT VARCHAR2
    );
END pkg_bogestion_segmentacion;
/

CREATE OR REPLACE PACKAGE BODY ADM_PERSON.pkg_bogestion_segmentacion IS

    -- Identificador del ultimo caso que hizo cambios
    csbVersion                 VARCHAR2(15) := 'OSF-4166';

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
    <Unidad> prcCambiaSegmentacionComercial </Unidad>
    <Autor> Luis Felipe Valencia Hurtado</Autor>
    <Fecha> 27/12/2024 </Fecha>
    <Descripcion> 
       Proceso de actualización de segmentación comercial
    </Descripcion>
    <Historial>
        <Modificacion Autor="felipe.valencia" Fecha="01/04/2024" Inc="OSF-4166" Empresa="EFG">
            CreaciÃ³n
        </Modificacion>
    </Historial>
    </Procedure>
    **************************************************************************/
    PROCEDURE prcCambiaSegmentacionComercial
    (
        iclSegmentacionComercial    IN CLOB,
        oclResulado                 OUT CLOB,
        iblValida                   IN BOOLEAN DEFAULT FALSE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prcCambiaSegmentacionComercial';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);         
    BEGIN
        pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbINICIO); 

        cc_bouicommercialsegm.setcommercialsegment(iclSegmentacionComercial,oclResulado,iblValida);

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
    END prcCambiaSegmentacionComercial;	

    /**************************************************************************
    <FUNCTION Fuente="Propiedad Intelectual de GDC">
    <Unidad> fsbObtieneNombrePersona </Unidad>
    <Autor> felipe.valencia </Autor>
    <Fecha> 01/04/2025 </Fecha>
    <Descripcion> 
        Obtiene el nombre de la persona
    </Descripcion>
    <Retorno Nombre="Versión del paquete" Tipo="VARCHAR2">
        Nombre de la persona conectada
    </Retorno>
    <Historial>
           <Modificacion Autor="felipe.valencia" Fecha="01/04/2025" Inc="OSF-4166" Empresa="GDC"> 
               Creación
           </Modificacion>
    </Historial>
    </FUNCTION>
    **************************************************************************/
    FUNCTION fsbObtieneNombrePersona
    RETURN VARCHAR2
    IS
        -- Nombre de este mtodo
        csbMetodo       CONSTANT VARCHAR2(70) := csbSP_NAME || 'fsbObtieneNombrePersona';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);

        sbNombre        VARCHAR2(4000);
    BEGIN

        pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbINICIO);  

        sbNombre := cc_bopetitionmgr.fsbgetpersonname;

        pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN); 

        RETURN sbNombre;

    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, cnuNVLTRC );
            RETURN sbNombre;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, cnuNVLTRC );
            RETURN sbNombre;
    END fsbObtieneNombrePersona;

	/**************************************************************************
    <Procedure prcValidaDatosBasicoscliente="Propiedad Intelectual de <Empresa>">
    <Unidad> prcObtSegmentacionComercial </Unidad>
    <Autor> Luis Felipe Valencia Hurtado</Autor>
    <Fecha> 27/12/2024 </Fecha>
    <Descripcion> 
       Obtiene segmentación comercial
    </Descripcion>
    <Historial>
        <Modificacion Autor="felipe.valencia" Fecha="01/04/2024" Inc="OSF-4166" Empresa="EFG">
            Creación
        </Modificacion>
    </Historial>
    </Procedure>
    **************************************************************************/
    PROCEDURE prcObtSegmentacionComercial
    (
        orfSegmentacionComercial    OUT constants_per.tyrefcursor,
		onuerrorcode        OUT NUMBER,
		osberrormessage     OUT VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prcObtSegmentacionComercial';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);         
    BEGIN
        pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbINICIO); 

        cc_bscommercialsegm.getcommercialsegments(orfSegmentacionComercial,onuerrorcode,osberrormessage);

        pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN); 
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(onuerrorcode,osberrormessage);        
            pkg_traza.trace('sbError => ' || osberrormessage, cnuNVLTRC );
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(onuerrorcode,osberrormessage);
            pkg_traza.trace('sbError => ' || osberrormessage, cnuNVLTRC );
    END prcObtSegmentacionComercial;	

	/**************************************************************************
    <Procedure prcValidaDatosBasicoscliente="Propiedad Intelectual de <Empresa>">
    <Unidad> prcObtInfoSegmentComercial </Unidad>
    <Autor> Luis Felipe Valencia Hurtado</Autor>
    <Fecha> 27/12/2024 </Fecha>
    <Descripcion> 
       Obtiene información de segmentación comercial
    </Descripcion>
    <Historial>
        <Modificacion Autor="felipe.valencia" Fecha="01/04/2024" Inc="OSF-4166" Empresa="EFG">
            Creación
        </Modificacion>
    </Historial>
    </Procedure>
    **************************************************************************/
    PROCEDURE prcObtInfoSegmentComercial
    (
        inuSegmenacionComercial     IN cc_commercial_segm.commercial_segm_id%TYPE, 
        orfInfoDemografica          OUT constants_per.tyrefcursor,
        orfInfoGeoPolitica          OUT constants_per.tyrefcursor,
        orfInfoComercial            OUT constants_per.tyrefcursor,
        orfInfoFinanciera           OUT constants_per.tyrefcursor, 
        orfPlanesComerciales        OUT constants_per.tyrefcursor, 
        orfPromociones              OUT constants_per.tyrefcursor, 
        orfPlanesFinanciacion       OUT constants_per.tyrefcursor, 
		onuerrorcode                OUT NUMBER,
		osberrormessage             OUT VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prcObtInfoSegmentComercial';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);         
    BEGIN
        pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbINICIO); 

        cc_bscommercialsegm.getcommsegmentdata
        (
            inuSegmenacionComercial, 
            orfInfoDemografica,
            orfInfoGeoPolitica,
            orfInfoComercial,
            orfInfoFinanciera, 
            orfPlanesComerciales, 
            orfPromociones, 
            orfPlanesFinanciacion, 
            onuerrorcode,
            osberrormessage
        );

        pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN); 
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(onuerrorcode,osberrormessage);        
            pkg_traza.trace('sbError => ' || osberrormessage, cnuNVLTRC );
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(onuerrorcode,osberrormessage);
            pkg_traza.trace('sbError => ' || osberrormessage, cnuNVLTRC );
    END prcObtInfoSegmentComercial;	
END pkg_bogestion_segmentacion;
/
PROMPT Otorgando permisos de ejecución para adm_person.pkg_bogestion_segmentacion
BEGIN
    pkg_utilidades.prAplicarPermisos(upper('pkg_bogestion_segmentacion'), 'ADM_PERSON');
END;
/