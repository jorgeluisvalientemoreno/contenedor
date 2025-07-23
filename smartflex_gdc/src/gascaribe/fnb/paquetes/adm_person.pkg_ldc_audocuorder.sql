CREATE OR REPLACE PACKAGE ADM_PERSON.PKG_LDC_AUDOCUORDER AS
    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe y Efigas
        Autor : PKG_LDC_AUDOCUORDER
        Descr : Paquete manejo datos 
        Tabla : LDC_AUDOCUORDER
        Caso  : OSF-3576
        Fecha : 12/11/2024 10:49:37
    ***************************************************************************/
 
    -- Inserta un registro
    PROCEDURE prinsRegistro(
								isbUsuario          IN ldc_audocuorder.usuario%TYPE,
								isbTerminal         IN ldc_audocuorder.terminal%TYPE,
								idtFecha_cambio     IN ldc_audocuorder.fecha_cambio%TYPE,
								inuOrder_id         IN ldc_docuorder.order_id%TYPE,
								isbEstado_anterior  IN ldc_docuorder.status_docu%TYPE,
								isbNuevo_estado     IN ldc_docuorder.status_docu%TYPE
							);
 
 
 END PKG_LDC_AUDOCUORDER;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.PKG_LDC_AUDOCUORDER AS
    csbSP_NAME		CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT||'.';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;

    -- Inserta un registro
    PROCEDURE prinsRegistro(
								isbUsuario          IN ldc_audocuorder.usuario%TYPE,
								isbTerminal         IN ldc_audocuorder.terminal%TYPE,
								idtFecha_cambio     IN ldc_audocuorder.fecha_cambio%TYPE,
								inuOrder_id         IN ldc_docuorder.order_id%TYPE,
								isbEstado_anterior  IN ldc_docuorder.status_docu%TYPE,
								isbNuevo_estado     IN ldc_docuorder.status_docu%TYPE
							) IS

        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prInsRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);

    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
		
        INSERT INTO LDC_AUDOCUORDER
              (usuario,
               terminal,
               fecha_cambio,
               order_id,
               estado_anterior,
               nuevo_estado)
            VALUES
              (isbUsuario,
               isbTerminal,
               idtFecha_cambio,
               inuOrder_id,
               isbEstado_anterior,
               isbNuevo_estado);
               
            COMMIT;
            
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prInsRegistro;
    
END PKG_LDC_AUDOCUORDER;
/
BEGIN
    -- OSF-3576
    pkg_Utilidades.prAplicarPermisos( UPPER('PKG_LDC_AUDOCUORDER'), UPPER('adm_person'));
END;
/
