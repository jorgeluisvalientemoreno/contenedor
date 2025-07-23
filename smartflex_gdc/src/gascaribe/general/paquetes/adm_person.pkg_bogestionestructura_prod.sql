CREATE OR REPLACE PACKAGE adm_person.pkg_bogestionestructura_prod IS

    /******************************************************************
    <Package Fuente="Propiedad Intelectual de GDC">
    <Unidad> pkg_bogestionestructura_prod </Unidad>
    <Autor> Luis Felipe Valencia Hurtado</Autor>
    <Fecha> 12-12-2024 </Fecha>
    <Descripcion> 
        Paquete con la logica de negocio de estructura de producto
    </Descripcion>
    <Historial>
           <Modificacion Autor="felipe.valencia" Fecha="12-12-2024" Inc="OSF-3746" Empresa="GDC">
               Creación
           </Modificacion>
     </Historial>
     </Package>
    ******************************************************************/

    --Servicio para realizar el llamado del metodo ps_boproductmotive.fnuGetProdMotiveByTagName
    FUNCTION fnuObtieneMotivoporNombreTag
    (   
        isbNombreTag   IN VARCHAR2
    ) 
    RETURN NUMBER;


END pkg_bogestionestructura_prod;
/
CREATE OR REPLACE PACKAGE BODY adm_person.pkg_bogestionestructura_prod IS

    /******************************************************************
    <Package Fuente="Propiedad Intelectual de GDC">
    <Unidad> pkg_bogestionestructura_prod </Unidad>
    <Autor> Luis Felipe Valencia Hurtado</Autor>
    <Fecha> 12-12-2024 </Fecha>
    <Descripcion> 
        Paquete con la logica de negocio de estructura de producto
    </Descripcion>
    <Historial>
        <Modificacion Autor="felipe.valencia" Fecha="12-12-2024" Inc="OSF-3746" Empresa="GDC">
            Creación
        </Modificacion>
     </Historial>
     </Package>
    ******************************************************************/

    --------------------------------------------
    -- Constantes 
    --------------------------------------------
    csbSP_NAME    CONSTANT VARCHAR2(35) := $$PLSQL_UNIT || '.';
    csbNivelTraza CONSTANT NUMBER(2) := pkg_traza.fnuNivelTrzDef;
    csbVERSION  CONSTANT VARCHAR2(10) := 'OSF-3746';

    /**************************************************************************
    <FUNCTION Fuente="Propiedad Intelectual de GDC">
    <Unidad> fsbVersion </Unidad>
    <Autor> felipe.valencia </Autor>
    <Fecha> 12-12-2024 </Fecha>
    <Descripcion> 
        Obtiene la version del paquete.
    </Descripcion>
    <Retorno Nombre="Versión del paquete" Tipo="VARCHAR2">
        Versión del paquete
    </Retorno>
    <Historial>
           <Modificacion Autor="felipe.valencia" Fecha="12-12-2024" Inc="OSF-3746" Empresa="GDC"> 
               Creación
           </Modificacion>
    </Historial>
    </FUNCTION>
    **************************************************************************/
    FUNCTION fsbVersion
    RETURN VARCHAR2
    IS
    BEGIN
        return CSBVERSION;
    END fsbVersion;


    /**************************************************************************
    <FUNCTION Fuente="Propiedad Intelectual de GDC">
    <Unidad> fnuObtieneMotivoporNombreTag </Unidad>
    <Autor> Luis Felipe Valencia Hurtado</Autor>
    <Fecha> 12-12-2024 </Fecha>
    <Descripcion> 
        Obtiene el motivo por nombre del tag
    </Descripcion>
    <Retorno Nombre="Versión del paquete" Tipo="NUMBER">
        Número de motivo
    </Retorno>
    <Historial>
            <Modificacion Autor="felipe.valencia" Fecha="12-12-2024" Inc="OSF-3738" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </FUNCTION>
    **************************************************************************/
    FUNCTION fnuObtieneMotivoporNombreTag
    (   
        isbNombreTag   IN VARCHAR2
    ) 
    RETURN NUMBER 
    IS
        csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'fnuObtieneMotivoporNombreTag';

        nuError NUMBER;

        sbError VARCHAR2(4000);

        nuMotivo NUMBER;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
      
        pkg_traza.trace('Nombre Tag: ' || isbNombreTag, csbNivelTraza);

        nuMotivo := ps_boproductmotive.fnuGetProdMotiveByTagName(isbNombreTag);
      
        pkg_traza.trace('Motivo: ' || nuMotivo, csbNivelTraza);
      
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
      
        RETURN(nuMotivo);
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('Error => ' || sbError, csbNivelTraza);
            RETURN nuMotivo;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('Error => ' || sbError, csbNivelTraza);
            RETURN nuMotivo;
    END fnuObtieneMotivoporNombreTag;

END pkg_bogestionestructura_prod;
/
BEGIN
  -- OSF-3746
  pkg_Utilidades.prAplicarPermisos(UPPER('pkg_bogestionestructura_prod'), UPPER('adm_person'));
END;
/
