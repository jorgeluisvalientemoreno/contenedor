CREATE OR REPLACE PACKAGE multiempresa.pkg_ciclo_facturacion IS
/*******************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Paquete     :   pkg_ciclo_facturacion
    Autor       :   Jhon Soto
    Fecha       :   19/02/2025
    Descripcion :   Paquete
    Modificaciones  :
    Autor       Fecha           Caso     Descripcion
    jsoto       12/02/2025  	OSF-3987 Creacion
*******************************************************************************/

    CURSOR cuRegistroRId
    (
        inuCiclo    ciclo_facturacion.ciclo%TYPE
    )
    IS
        SELECT tb.*, tb.Rowid
        FROM ciclo_facturacion tb
        WHERE ciclo = inuCiclo;

    CURSOR cuRegistroRIdLock
    (
        inuCiclo    NUMBER
    )
    IS
        SELECT tb.*, tb.Rowid
        FROM ciclo_facturacion tb
        WHERE
        ciclo = inuCiclo
        FOR UPDATE NOWAIT;

    -- Retorna Identificador del ultimo caso que hizo cambios en este archivo
    FUNCTION fsbVersion RETURN VARCHAR2;
    
	
	-- Obtiene el registro y el rowid
    FUNCTION frcObtRegistroRId(
								inuCiclo    	ciclo_facturacion.ciclo%TYPE, 
								iblBloquea 		BOOLEAN DEFAULT FALSE
							  ) 
	RETURN cuRegistroRId%ROWTYPE;
	
	

    PROCEDURE prInsertaRegisto(
								inuCiclo   		ciclo_facturacion.ciclo%TYPE,
								isbEmpresa	   	ciclo_facturacion.empresa%TYPE
							  );
							  
	FUNCTION fsbObtEmpresa(
							inuCiclo NUMBER
						  )
	RETURN VARCHAR2;

    FUNCTION fblExiste(
						inuCiclo    ciclo_facturacion.ciclo%TYPE
					  ) 
	RETURN BOOLEAN;
	
	    -- Actualiza el valor de la columna EMPRESA
    PROCEDURE prAcEmpresa(
							inuCiclo  		ciclo_facturacion.ciclo%TYPE,
							isbEmpresa    	ciclo_facturacion.empresa%TYPE
						 );


END pkg_ciclo_facturacion;
/

CREATE OR REPLACE PACKAGE BODY multiempresa.pkg_ciclo_facturacion IS

    -- Identificador del ultimo caso que hizo cambios en este archivo
    csbVersion                 VARCHAR2(15) := 'OSF-3987';

    -- Constantes para el control de la traza
    csbSP_NAME		CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT||'.';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
    

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Programa        : fsbVersion 
    Descripcion     : Retona la ultima WO que hizo cambios en el paquete 
    Autor           : jsoto 
    Fecha           : 19/02/2025 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jsoto     	19/02/2025  OSF-3987 Creacion
    ***************************************************************************/    
    FUNCTION fsbVersion RETURN VARCHAR2 IS
    BEGIN
        RETURN csbVersion;
    END fsbVersion;
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Programa        : frcObtieneRegisto 
    Descripcion     : Retorna un registro de la tabla ciclo_facturacion
    Autor           : jsoto 
    Fecha           : 19/02/2025 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jsoto       06/02/2025  OSF-3987 Creacion
    ***************************************************************************/                     
    FUNCTION frcObtieneRegisto(inuCiclo   ciclo_facturacion.ciclo%TYPE)
    RETURN ciclo_facturacion%ROWTYPE
    IS
        -- Nombre de este mtodo
        csbMetodo       CONSTANT VARCHAR2(70) := csbSP_NAME || 'frcObtieneRegisto';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        
        rcCiclo   ciclo_facturacion%ROWTYPE;
        
        CURSOR cuciclo_facturacion
        IS
        SELECT *
        FROM ciclo_facturacion
        where ciclo = inuCiclo;
      
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
        
        OPEN cuciclo_facturacion;
        FETCH cuciclo_facturacion INTO rcCiclo;
        CLOSE cuciclo_facturacion;
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);  
           
        RETURN rcCiclo;
           
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RETURN rcCiclo;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RETURN rcCiclo;
    END frcObtieneRegisto;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Programa        : prInsertaRegisto 
    Descripcion     : Inserta un registro en la tabla ciclo_facturacion
    Autor           : jsoto 
    Fecha           : 06/02/2025 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jsoto       06/02/2025  OSF-3987 Creacion
    ***************************************************************************/                     
    PROCEDURE prInsertaRegisto(inuCiclo   	ciclo_facturacion.ciclo%TYPE,
							  isbEmpresa	ciclo_facturacion.empresa%TYPE)
 
    IS
        -- Nombre de este mtodo
        csbMetodo       CONSTANT VARCHAR2(70) := csbSP_NAME || 'prInsertaRegisto';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        

      
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
        
		INSERT INTO ciclo_facturacion VALUES(inuCiclo,isbEmpresa);
        
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
    Descripcion     : Obtiene dato actual de empresa configurado para el ciclo

    Autor           : Jhon Jairo Soto
    Fecha           : 19/02/2025

    Parametros de Entrada

    Parametros de Salida

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso        Descripcion
  ***************************************************************************/
FUNCTION fsbObtEmpresa(inuCiclo NUMBER) 
RETURN VARCHAR2 IS

	nuError			NUMBER;
	sbError			VARCHAR2(4000);

	csbMT_NAME  	VARCHAR2(200) := csbSP_NAME || 'fsbObtEmpresa';

	sbEmpresa       VARCHAR2(2000);
	
	CURSOR cuEmpresa IS
	SELECT empresa
	FROM   ciclo_facturacion
	WHERE  ciclo = inuCiclo;
	

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
                         inuCiclo    ciclo_facturacion.ciclo%TYPE
                        ) RETURN BOOLEAN IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fblExiste';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroRId   cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroRId := frcObtRegistroRId(inuCiclo, TRUE);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroRId.ciclo IS NOT NULL;
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
							inuCiclo  	ciclo_facturacion.ciclo%TYPE,
							isbEmpresa  ciclo_facturacion.empresa%TYPE
						 )

    IS
        csbMetodo       CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcEmpresa';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct 	cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuCiclo,TRUE);
        IF NVL(isbEmpresa,'-') <> NVL(rcRegistroAct.empresa,'-') THEN
            UPDATE ciclo_facturacion
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
        inuCiclo    ciclo_facturacion.ciclo%TYPE, iblBloquea BOOLEAN DEFAULT FALSE
    ) RETURN cuRegistroRId%ROWTYPE IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'frcObtRegistroRId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroRId   cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF iblBloquea THEN
            OPEN cuRegistroRIdLock(inuCiclo);
            FETCH cuRegistroRIdLock INTO rcRegistroRId;
            CLOSE cuRegistroRIdLock;
        ELSE
            OPEN cuRegistroRId(inuCiclo);
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
     
END pkg_ciclo_facturacion;
/
Prompt Otorgando permisos sobre multiempresa.pkg_ciclo_facturacion
BEGIN
    pkg_Utilidades.prAplicarPermisos(upper('pkg_ciclo_facturacion'), upper('multiempresa'));
END;
/