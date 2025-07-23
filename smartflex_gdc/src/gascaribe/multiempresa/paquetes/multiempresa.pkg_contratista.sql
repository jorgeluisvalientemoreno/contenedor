CREATE OR REPLACE PACKAGE multiempresa.pkg_contratista IS
/*******************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Paquete     :   pkg_contratista
    Autor       :   Jhon Soto
    Fecha       :   11/02/2025
    Descripcion :   Paquete
    Modificaciones  :
    Autor       Fecha           Caso     Descripcion
    jsoto       12/02/2025  	OSF-3970 Creacion
*******************************************************************************/

    CURSOR cuRegistroRId
    (
        inuContratista    contratista.contratista%TYPE
    )
    IS
        SELECT tb.*, tb.Rowid
        FROM contratista tb
        WHERE contratista = inuContratista;

    CURSOR cuRegistroRIdLock
    (
        inuContratista    NUMBER
    )
    IS
        SELECT tb.*, tb.Rowid
        FROM contratista tb
        WHERE
        contratista = inuContratista
        FOR UPDATE NOWAIT;

    -- Retorna Identificador del ultimo caso que hizo cambios en este archivo
    FUNCTION fsbVersion RETURN VARCHAR2;
    
	
	-- Obtiene el registro y el rowid
    FUNCTION frcObtRegistroRId(
								inuContratista    contratista.contratista%TYPE, 
								iblBloquea BOOLEAN DEFAULT FALSE
							  ) 
	RETURN cuRegistroRId%ROWTYPE;
	
	

    PROCEDURE prInsertaRegisto(
								inuContratista   contratista.contratista%TYPE,
								isbEmpresa	   contratista.empresa%TYPE
							  );
							  
	FUNCTION fsbObtEmpresa(
							inuContratista NUMBER
						  )
	RETURN VARCHAR2;

    FUNCTION fblExiste(
						inucontratista    contratista.contratista%TYPE
					  ) 
	RETURN BOOLEAN;
	
	    -- Actualiza el valor de la columna EMPRESA
    PROCEDURE prAcEmpresa(
							inuContratista  contratista.contratista%TYPE,
							isbEmpresa    	VARCHAR2
						 );


END pkg_contratista;
/

CREATE OR REPLACE PACKAGE BODY multiempresa.pkg_contratista IS

    -- Identificador del ultimo caso que hizo cambios en este archivo
    csbVersion                 VARCHAR2(15) := 'OSF-3970';

    -- Constantes para el control de la traza
    csbSP_NAME		CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT||'.';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
    

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Programa        : fsbVersion 
    Descripcion     : Retona la ultima WO que hizo cambios en el paquete 
    Autor           : Lubin Pineda - MVM 
    Fecha           : 06/02/2025 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jsoto     06/02/2025  OSF-3970 Creacion
    ***************************************************************************/    
    FUNCTION fsbVersion RETURN VARCHAR2 IS
    BEGIN
        RETURN csbVersion;
    END fsbVersion;
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Programa        : frcObtieneRegisto 
    Descripcion     : Retorna un registro de la tabla contratista
    Autor           : jsoto 
    Fecha           : 06/02/2025 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jsoto       06/02/2025  OSF-3970 Creacion
    ***************************************************************************/                     
    FUNCTION frcObtieneRegisto(inuContratista   contratista.contratista%TYPE)
    RETURN contratista%ROWTYPE
    IS
        -- Nombre de este mtodo
        csbMetodo       CONSTANT VARCHAR2(70) := csbSP_NAME || 'frcObtieneRegisto';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        
        rccontratista   contratista%ROWTYPE;
        
        CURSOR cucontratista
        IS
        SELECT *
        FROM contratista
        where contratista = inuContratista;
      
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
        
        OPEN cucontratista;
        FETCH cucontratista INTO rccontratista;
        CLOSE cucontratista;
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);  
           
        RETURN rccontratista;
           
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RETURN rccontratista;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RETURN rccontratista;
    END frcObtieneRegisto;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Programa        : prInsertaRegisto 
    Descripcion     : Inserta un registro de la tabla contratista
    Autor           : jsoto 
    Fecha           : 06/02/2025 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jsoto       06/02/2025  OSF-3970 Creacion
    ***************************************************************************/                     
    PROCEDURE prInsertaRegisto(inuContratista   contratista.contratista%TYPE,
							  isbEmpresa	   contratista.empresa%TYPE)
 
    IS
        -- Nombre de este mtodo
        csbMetodo       CONSTANT VARCHAR2(70) := csbSP_NAME || 'prInsertaRegisto';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        

      
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
        
		INSERT INTO contratista VALUES(inuContratista,isbEmpresa);
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);  
          
           
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
			RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.controlled_error;
    END prInsertaRegisto;



 /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbObtEmpresa
    Descripcion     : Obtiene dato actual de empresa configurado para el contratista

    Autor           : Jhon Jairo Soto
    Fecha           : 12/02/2025

    Parametros de Entrada

    Parametros de Salida

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso        Descripcion
  ***************************************************************************/
FUNCTION fsbObtEmpresa(inuContratista NUMBER) 
RETURN VARCHAR2 IS

	nuError			NUMBER;
	sbError			VARCHAR2(4000);

	csbMT_NAME  	VARCHAR2(200) := csbSP_NAME || 'fsbObtEmpresa';

	sbEmpresa       VARCHAR2(2000);
	
	CURSOR cuEmpresa IS
	SELECT empresa
	FROM   contratista
	WHERE  contratista = inuContratista;
	

BEGIN

	pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);

	OPEN cuEmpresa;
	FETCH cuEmpresa INTO sbEmpresa;
	CLOSE cuEmpresa;
 
	pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
	
	RETURN sbEmpresa;

EXCEPTION
    WHEN pkg_Error.Controlled_Error THEN
      pkg_Error.getError(nuError, sbError);
      pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
      RAISE pkg_error.Controlled_Error;
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(nuError, sbError);
      pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
      RAISE pkg_Error.Controlled_Error;
END fsbObtEmpresa;

    -- Retorna verdadero si el registro existe
    FUNCTION fblExiste  (
                         inuContratista    contratista.contratista%TYPE
                        ) RETURN BOOLEAN IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fblExiste';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroRId   cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroRId := frcObtRegistroRId(inuContratista, TRUE);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroRId.contratista IS NOT NULL;
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
    END fblExiste;

	    -- Actualiza el valor de la columna EMPRESA
    PROCEDURE prAcEmpresa(
							inuContratista  contratista.contratista%TYPE,
							isbEmpresa    	VARCHAR2
						 )

    IS
        csbMetodo       CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcEmpresa';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct 	cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuContratista,TRUE);
        IF NVL(isbEmpresa,'-') <> NVL(rcRegistroAct.empresa,'-') THEN
            UPDATE contratista
            SET empresa=isbEmpresa
            WHERE Rowid = rcRegistroAct.RowId;
        END IF;
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
    END prAcEmpresa;

    -- Obtiene registro y RowId
    FUNCTION frcObtRegistroRId(
        inuContratista    contratista.contratista%TYPE, iblBloquea BOOLEAN DEFAULT FALSE
    ) RETURN cuRegistroRId%ROWTYPE IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'frcObtRegistroRId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroRId   cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF iblBloquea THEN
            OPEN cuRegistroRIdLock(inuContratista);
            FETCH cuRegistroRIdLock INTO rcRegistroRId;
            CLOSE cuRegistroRIdLock;
        ELSE
            OPEN cuRegistroRId(inuContratista);
            FETCH cuRegistroRId INTO rcRegistroRId;
            CLOSE cuRegistroRId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroRId;
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
    END frcObtRegistroRId;
     
END pkg_contratista;
/
Prompt Otorgando permisos sobre multiempresa.pkg_contratista
BEGIN
    pkg_Utilidades.prAplicarPermisos(upper('pkg_contratista'), upper('multiempresa'));
END;
/