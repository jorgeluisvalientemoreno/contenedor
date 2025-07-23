CREATE OR REPLACE PACKAGE adm_person.pkg_cargos IS
/*****************************************************************
    Propiedad intelectual de Gases del Caribe

    Unidad         : adm_person.pkg_cargos
    Descripción    : Paquete de primer nivel para gestión de cargos
    Autor          : jcatuche
    Fecha          : 15/05/2024

    Fecha           Autor               Modificación
    =========       =========           ====================
	15-05-2024      jcatuche            OSF-2467: Creación
	10-12-2024      jpinedc             OSF-3694: prBorraCargos - Creación
******************************************************************/
	
	TYPE TYCARGCUCO IS TABLE OF CARGOS.CARGCUCO%TYPE INDEX BY BINARY_INTEGER;
	TYPE TYCARGNUSE IS TABLE OF CARGOS.CARGNUSE%TYPE INDEX BY BINARY_INTEGER;
	TYPE TYCARGCONC IS TABLE OF CARGOS.CARGCONC%TYPE INDEX BY BINARY_INTEGER;
	TYPE TYCARGCACA IS TABLE OF CARGOS.CARGCACA%TYPE INDEX BY BINARY_INTEGER;
	TYPE TYCARGSIGN IS TABLE OF CARGOS.CARGSIGN%TYPE INDEX BY BINARY_INTEGER;
	TYPE TYCARGPEFA IS TABLE OF CARGOS.CARGPEFA%TYPE INDEX BY BINARY_INTEGER;
	TYPE TYCARGVALO IS TABLE OF CARGOS.CARGVALO%TYPE INDEX BY BINARY_INTEGER;
	TYPE TYCARGDOSO IS TABLE OF CARGOS.CARGDOSO%TYPE INDEX BY BINARY_INTEGER;
	TYPE TYCARGCODO IS TABLE OF CARGOS.CARGCODO%TYPE INDEX BY BINARY_INTEGER;
	TYPE TYCARGUSUA IS TABLE OF CARGOS.CARGUSUA%TYPE INDEX BY BINARY_INTEGER;
	TYPE TYCARGTIPR IS TABLE OF CARGOS.CARGTIPR%TYPE INDEX BY BINARY_INTEGER;
	TYPE TYCARGUNID IS TABLE OF CARGOS.CARGUNID%TYPE INDEX BY BINARY_INTEGER;
	TYPE TYCARGFECR IS TABLE OF CARGOS.CARGFECR%TYPE INDEX BY BINARY_INTEGER;
	TYPE TYCARGPROG IS TABLE OF CARGOS.CARGPROG%TYPE INDEX BY BINARY_INTEGER;
	TYPE TYCARGCOLL IS TABLE OF CARGOS.CARGCOLL%TYPE INDEX BY BINARY_INTEGER;
	TYPE TYCARGPECO IS TABLE OF CARGOS.CARGPECO%TYPE INDEX BY BINARY_INTEGER;
	TYPE TYCARGTICO IS TABLE OF CARGOS.CARGTICO%TYPE INDEX BY BINARY_INTEGER;
	TYPE TYCARGVABL IS TABLE OF CARGOS.CARGVABL%TYPE INDEX BY BINARY_INTEGER;
	TYPE TYCARGTACO IS TABLE OF CARGOS.CARGTACO%TYPE INDEX BY BINARY_INTEGER;
    TYPE tytbRowid IS TABLE OF rowid INDEX BY binary_integer;
	
	TYPE TYTBCARGOS IS RECORD
    (
      CARGCUCO TYCARGCUCO,
      CARGNUSE TYCARGNUSE,
      CARGCONC TYCARGCONC,
      CARGCACA TYCARGCACA,
      CARGSIGN TYCARGSIGN,
      CARGPEFA TYCARGPEFA,
      CARGVALO TYCARGVALO,
      CARGDOSO TYCARGDOSO,
      CARGCODO TYCARGCODO,
      CARGUSUA TYCARGUSUA,
      CARGTIPR TYCARGTIPR,
      CARGUNID TYCARGUNID,
      CARGFECR TYCARGFECR,
      CARGPROG TYCARGPROG,
      CARGCOLL TYCARGCOLL,
      CARGPECO TYCARGPECO,
      CARGTICO TYCARGTICO,
      CARGVABL TYCARGVABL,
      CARGTACO TYCARGTACO,
      CARGFACT pkg_cuencobr.tytbcucofact,
      CARGROWID   tytbRowid  
    );

    --------------------------------------------
    -- Funciones y Procedimientos
    --------------------------------------------
							   

    -- Obtiene la version del paquete.
    FUNCTION fsbVersion
    RETURN VARCHAR2;
    PROCEDURE prInsertaCargo
    (
        inucuco in  cargos.cargcuco%type,
        inunuse in  cargos.cargnuse%type,
        isbsign in  cargos.cargsign%type,
        inuconc in  cargos.cargconc%type,
        inuvalo in  cargos.cargvalo%type,
        inuvabl in  cargos.cargvabl%type,
        inupefa in  cargos.cargpefa%type,
        inufecr in  cargos.cargfecr%type,
        inuprog in  cargos.cargprog%type,
        inucaca in  cargos.cargcaca%type,
        isbdoso in  cargos.cargdoso%type,
        inucodo in  cargos.cargcodo%type,
        inuusua in  cargos.cargusua%type,
        isbtipr in  cargos.cargtipr%type
    );
    
    -- Actualiza el campo cargdoso a partir de cargcodo
    PROCEDURE prcActualizaCargdoso(inuCargcodo 		IN cargos.cargcodo%type,
								   inuProductId		IN cargos.cargnuse%type,
								   inuConceptoId	IN cargos.cargconc%type,
								   inuCargcaca		IN cargos.cargcaca%type,
								   inuCargvalo		IN cargos.cargvalo%type,
								   isbCargsign		IN cargos.cargsign%type,
								   isbCargdoso		IN cargos.cargdoso%type
								   );
    -- Borra cargos
    PROCEDURE prBorraCargos
    (
        inunuse in  cargos.cargnuse%type,
        inucuco in  cargos.cargcuco%type,
        inuconc in  cargos.cargconc%type,
        inuprog in  cargos.cargprog%type        
    );

    PROCEDURE prcActualizaDocumentoSoporte
    (
        inuCuentaCobro  IN cargos.cargcuco%type,
        inuConceptoId	IN cargos.cargconc%type,
        isbSigno		IN cargos.cargsign%type,
        isbCargdoso		IN cargos.cargdoso%type
    );

    --Actualiza el campo cargcodo
    PROCEDURE prcActualizaCargcodo
    (
        inuCuentaCobro  IN cargos.cargcuco%type,
        inuConceptoId	IN cargos.cargconc%type,
        isbSigno		IN cargos.cargsign%type,
        isbCausales     IN VARCHAR2,
        inuCargcodo		IN cargos.cargcodo%type
    );

	PROCEDURE prcActualizacionMasivaCargos
    (
        ircCargos       IN tytbcargos,
        orcCargos        OUT tytbcargos
	);
END pkg_cargos;
/

CREATE OR REPLACE PACKAGE BODY adm_person.pkg_cargos IS

    /******************************************************************
    <Package Fuente="Propiedad Intelectual de GDC">
    <Unidad> PKG_CARGOS </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 30-10-2024 </Fecha>
    <Descripcion> 
        Paquete primer nivel para la tabla cargos
    </Descripcion>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="30-10-2024" Inc="OSF-2926" Empresa="GDC">
               Creación
           </Modificacion>
     </Historial>
     </Package>
    ******************************************************************/

    -- Constantes para el control de la traza
    csbVERSION          CONSTANT VARCHAR2(10) := 'OSF-4294';
    csbSP_NAME          CONSTANT VARCHAR2(100)       := $$PLSQL_UNIT||'.';           -- Constante para nombre de función    
    cnuNivelTraza       CONSTANT NUMBER(2)          := pkg_traza.cnuNivelTrzDef;    -- Nivel de traza para esta función. 
    csbInicio           CONSTANT VARCHAR2(4)        := pkg_traza.fsbINICIO;         -- Indica inicio de método
    csbFin              CONSTANT VARCHAR2(4)        := pkg_traza.fsbFIN;            -- Indica Fin de método ok
    csbFin_Erc          CONSTANT VARCHAR2(4)        := pkg_traza.fsbFIN_ERC;        -- Indica fin de método con error controlado
    csbFin_Err          CONSTANT VARCHAR2(4)        := pkg_traza.fsbFIN_ERR;        -- Indica fin de método con error no controlado
    
    
    -----------------------------------
    -- Variables privadas del package
    -----------------------------------
    sberror             VARCHAR2(4000);
    nuerror             NUMBER;

    --------------------------------------------
    -- Funciones y Procedimientos
    --------------------------------------------


    /**************************************************************************
    <FUNCTION Fuente="Propiedad Intelectual de GDC">
    <Unidad> fsbVersion </Unidad>
    <Autor> Jhon.Erazo </Autor>
    <Fecha> 30-10-2024 </Fecha>
    <Descripcion> 
        Obtiene la version del paquete.
    </Descripcion>
    <Retorno Nombre="Versi�n del paquete" Tipo="VARCHAR2">
        Versi�n del paquete
    </Retorno>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="30-10-2024" Inc="OSF-2926" Empresa="GDC"> 
               Creaci�n
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

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prInsertaCuenta
    Descripción     : Inserta registro en cuencobr

    Autor           : jcatuche
    Fecha           : 15-05-2024

    Parametros de Entrada
        inucuco     identificador de la cuenta
        inunuse     identificador del producto
        isbsign     signo del cargo
        inuconc     identificador del concepto
        inuvalo     valor del cargo
        inuvabl     valor base de liquidación
        inupefa     identificador del periodo de facturación
        inufecr     fecha de creación del cargo
        inuprog     identificador del programa
        inucaca     identificador de la causal
        isbdoso     documento de soporte
        inucodo     consecutivo del documento
        inuusua     identificador del usuario
        isbtipr     tipo de proceso
        
    Parametros de Salida
        NA
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso        Descripción
    jcatuche    15-05-2024  OSF-2467    Creación
  ***************************************************************************/
    PROCEDURE prInsertaCargo
    (
        inucuco in  cargos.cargcuco%type,
        inunuse in  cargos.cargnuse%type,
        isbsign in  cargos.cargsign%type,
        inuconc in  cargos.cargconc%type,
        inuvalo in  cargos.cargvalo%type,
        inuvabl in  cargos.cargvabl%type,
        inupefa in  cargos.cargpefa%type,
        inufecr in  cargos.cargfecr%type,
        inuprog in  cargos.cargprog%type,
        inucaca in  cargos.cargcaca%type,
        isbdoso in  cargos.cargdoso%type,
        inucodo in  cargos.cargcodo%type,
        inuusua in  cargos.cargusua%type,
        isbtipr in  cargos.cargtipr%type
    ) IS
        csbMT_NAME   CONSTANT VARCHAR2(100) := csbSP_NAME||'prInsertaCargo';
    BEGIN
        pkg_traza.trace(csbMT_NAME, cnuNivelTraza, csbInicio);
        
        INSERT INTO cargos
        (
            cargcuco,
            cargnuse,            
            cargsign,
            cargconc,
            cargvalo,
            cargvabl,
            cargpefa,
            cargfecr,
            cargprog,
            cargcaca,
            cargdoso,
            cargcodo,
            cargusua,
            cargtipr
        )
        VALUES
        (
            inucuco,
            inunuse,
            isbsign,
            inuconc,
            inuvalo,
            inuvabl,            
            inupefa,
            inufecr,
            inuprog,
            inucaca,
            isbdoso,
            inucodo,
            inuusua,
            isbtipr
        );
        
        pkg_traza.trace(csbMT_NAME, cnuNivelTraza, csbFin);
    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_traza.trace(csbMT_NAME, cnuNivelTraza, csbFin_Erc);
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_traza.trace(csbMT_NAME, cnuNivelTraza, csbFin_Err);
            RAISE pkg_Error.Controlled_Error;
    END prInsertaCargo;

	/**************************************************************************
    <FUNCTION Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> prcActualizaCargdoso </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 30-10-2024 </Fecha>
    <Descripcion> 
        Actualiza el campo cargdoso a partir de cargcodo
    </Descripcion>
	<Parametros> 
		Entrada:
			inuCargcodo		Identificador de cargcodo
			inuProductId	Identificador del producto
			inuConceptoId	Identificador del concepto
			inuCargcaca		Causa del cargo
			inuCargvalo		Valor del cargo
			isbCargsign		Signo del cargo
			isbCargdoso		Valor Cargdoso
		
		Salida:
		
    </Parametros>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="30-10-2024" Inc="OSF-2926" Empresa="GDC">
               Creaci�n
           </Modificacion>
    </Historial>
    </FUNCTION>
    **************************************************************************/
    PROCEDURE prcActualizaCargdoso(inuCargcodo 		IN cargos.cargcodo%type,
								   inuProductId		IN cargos.cargnuse%type,
								   inuConceptoId	IN cargos.cargconc%type,
								   inuCargcaca		IN cargos.cargcaca%type,
								   inuCargvalo		IN cargos.cargvalo%type,
								   isbCargsign		IN cargos.cargsign%type,
								   isbCargdoso		IN cargos.cargdoso%type
								   )
    IS
	
		csbMT_NAME  		VARCHAR2(200) := csbSP_NAME || 'prcActualizaCargdoso';
		
		nuError					NUMBER;  
		sbmensaje				VARCHAR2(1000);  
        
    BEGIN
		
		pkg_traza.trace(csbMT_NAME, cnuNivelTraza, csbInicio);
		
		pkg_traza.trace('inuCargcodo: ' 	|| inuCargcodo   || CHR(10) || 
						'inuProductId: ' 	|| inuProductId  || CHR(10) || 
						'inuConceptoId: '	|| inuConceptoId || CHR(10) || 
						'inuCargcaca: ' 		|| inuCargcaca  	 || CHR(10) || 
						'inuCargvalo: ' 	|| inuCargvalo   || CHR(10) || 
						'isbCargsign: ' 	|| isbCargsign   || CHR(10) || 
						'isbCargdoso: ' 	|| isbCargdoso, cnuNivelTraza); 
						
		-- Actualiza cargdoso
		UPDATE cargos
		SET cargdoso 	= isbCargdoso
		WHERE cargcodo 	= inuCargcodo
		AND cargnuse	= inuProductId
		AND cargconc	= inuConceptoId
		AND cargcaca	= inuCargcaca
		AND cargvalo	= inuCargvalo
		AND cargsign	= isbCargsign;

		pkg_traza.trace(csbMT_NAME, cnuNivelTraza, pkg_traza.csbFIN);

    EXCEPTION
		WHEN pkg_error.CONTROLLED_ERROR THEN
			pkg_error.setError;
			pkg_Error.getError(nuError, sbmensaje);
			pkg_traza.trace('nuError: ' || nuError || ' sbmensaje: ' || sbmensaje, cnuNivelTraza);
			pkg_traza.trace(csbMT_NAME, cnuNivelTraza, pkg_traza.csbFIN_ERC); 
			RAISE pkg_error.CONTROLLED_ERROR;
		WHEN others THEN
			pkg_Error.setError;
			pkg_Error.getError(nuError, sbmensaje);
			pkg_traza.trace('nuError: ' || nuError || ' sbmensaje: ' || sbmensaje, cnuNivelTraza);
			pkg_traza.trace(csbMT_NAME, cnuNivelTraza, pkg_traza.csbFIN_ERR); 
			RAISE pkg_Error.Controlled_Error;
    END prcActualizaCargdoso;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prBorraCargos
    Descripción     : Borra cargos

    Autor           : jpinedc
    Fecha           : 10-12-2024

    Parametros de Entrada
        inunuse     identificador del producto
        inucuco     identificador de la cuenta de cobro
        inucuco     identificador del concepto
        inuprog     identificador del programa
        
    Parametros de Salida
        NA
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso        Descripción
    jpinedc     10-12-2024  OSF-3694    Creación
  ***************************************************************************/
    PROCEDURE prBorraCargos
    (
        inunuse in  cargos.cargnuse%type,
        inucuco in  cargos.cargcuco%type,
        inuconc in  cargos.cargconc%type,
        inuprog in  cargos.cargprog%type        
    ) IS
    
        csbMT_NAME   CONSTANT VARCHAR2(100) := csbSP_NAME||'prBorraCargos';
    BEGIN
        pkg_traza.trace(csbMT_NAME, cnuNivelTraza, csbInicio);

        pkg_traza.trace('inuNuSe|'|| inuNuSe, cnuNivelTraza);
        pkg_traza.trace('inucuco|'|| inucuco, cnuNivelTraza);
        pkg_traza.trace('inuconc|'|| inuconc, cnuNivelTraza);
        pkg_traza.trace('inuProg|'|| inuProg, cnuNivelTraza);
                
        DELETE cargos
        WHERE cargnuse = inuNuSe
        AND cargcuco = inuCuCo
        AND cargconc = inuConc
        AND cargprog = inuProg;
            
        pkg_traza.trace(csbMT_NAME, cnuNivelTraza, csbFin);
        
    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_traza.trace(csbMT_NAME, cnuNivelTraza, csbFin_Erc);
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_traza.trace(csbMT_NAME, cnuNivelTraza, csbFin_Err);
            RAISE pkg_Error.Controlled_Error;
    END prBorraCargos;    

	/**************************************************************************
    <FUNCTION Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> prcActualizaCargdoso </Unidad>
    <Autor> Luis Felipe Valencia Hurtado </Autor>
    <Fecha> 25-03-2025 </Fecha>
    <Descripcion> 
        Actualiza el campo cargdoso a partir de la cuenta de cobro
    </Descripcion>
	<Parametros> 
		Entrada:
			inuCuentaCobro		Identificador de la cuenta de cobro
			inuConceptoId	Identificador del concepto
			isbCargsign		Signo del cargo
			isbCargdoso		Valor Cargdoso
		
		Salida:
		
    </Parametros>
    <Historial>
           <Modificacion Autor="felipe.valencia" Fecha="25-03-2025" Inc="OSF-3846" Empresa="GDC">
               Creaci�n
           </Modificacion>
    </Historial>
    </FUNCTION>
    **************************************************************************/
    PROCEDURE prcActualizaDocumentoSoporte
    (
        inuCuentaCobro  IN cargos.cargcuco%type,
        inuConceptoId	IN cargos.cargconc%type,
        isbSigno		IN cargos.cargsign%type,
        isbCargdoso		IN cargos.cargdoso%type
    )
    IS
	
		csbMT_NAME  		VARCHAR2(200) := csbSP_NAME || 'prcActualizaDocumentoSoporte';
		
		nuError					NUMBER;  
		sbmensaje				VARCHAR2(1000);  
        
    BEGIN
		
		pkg_traza.trace(csbMT_NAME, cnuNivelTraza, csbInicio);
		
		pkg_traza.trace('inuCuentaCobro: ' 	|| inuCuentaCobro   || CHR(10) || 
						'inuConceptoId: ' 	|| inuConceptoId  || CHR(10) || 
						'isbSigno: '	|| isbSigno || CHR(10) || 
						'isbCargdoso: ' 	|| isbCargdoso, cnuNivelTraza); 
						
		-- Actualiza cargdoso
		UPDATE cargos
		SET cargdoso 	= isbCargdoso
		WHERE cargcuco 	= inuCuentaCobro
        AND cargconc	= inuConceptoId
		AND cargsign	= isbSigno;

		pkg_traza.trace(csbMT_NAME, cnuNivelTraza, pkg_traza.csbFIN);
																
	
 

    EXCEPTION
		WHEN pkg_error.CONTROLLED_ERROR THEN
			pkg_error.setError;
			pkg_Error.getError(nuError, sbmensaje);
			pkg_traza.trace('nuError: ' || nuError || ' sbmensaje: ' || sbmensaje, cnuNivelTraza);
			pkg_traza.trace(csbMT_NAME, cnuNivelTraza, pkg_traza.csbFIN_ERC); 
			RAISE pkg_error.CONTROLLED_ERROR;
		WHEN others THEN
			pkg_Error.setError;
			pkg_Error.getError(nuError, sbmensaje);
			pkg_traza.trace('nuError: ' || nuError || ' sbmensaje: ' || sbmensaje, cnuNivelTraza);
			pkg_traza.trace(csbMT_NAME, cnuNivelTraza, pkg_traza.csbFIN_ERR); 
			RAISE pkg_Error.Controlled_Error;
    END prcActualizaDocumentoSoporte;	
    
	/**************************************************************************
    <FUNCTION Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> prcActualizaCargcodo </Unidad>
    <Autor> Luis Felipe Valencia Hurtado </Autor>
    <Fecha> 25-03-2025 </Fecha>
    <Descripcion> 
        Actualiza el campo cargcodo
    </Descripcion>
	<Parametros> 
		Entrada:
			inuCuentaCobro		Identificador de la cuenta de cobro
			inuConceptoId	Identificador del concepto
			isbCargsign		Signo del cargo
			isbCargdoso		Valor Cargdoso
		
		Salida:
		
    </Parametros>
    <Historial>
           <Modificacion Autor="felipe.valencia" Fecha="25-03-2025" Inc="OSF-3846" Empresa="GDC">
               Creaci�n
           </Modificacion>
    </Historial>
    </FUNCTION>
    **************************************************************************/
    PROCEDURE prcActualizaCargcodo
    (
        inuCuentaCobro  IN cargos.cargcuco%type,
        inuConceptoId	IN cargos.cargconc%type,
        isbSigno		IN cargos.cargsign%type,
        isbCausales     IN VARCHAR2,
        inuCargcodo		IN cargos.cargcodo%type
    )
    IS	
		csbMT_NAME  		VARCHAR2(200) := csbSP_NAME || 'prcActualizaCargcodo';
		
		nuError					NUMBER;  
		sbmensaje				VARCHAR2(1000);          
    BEGIN
		
		pkg_traza.trace(csbMT_NAME, cnuNivelTraza, csbInicio);
		
		pkg_traza.trace('inuCuentaCobro: ' 	|| inuCuentaCobro   || CHR(10) || 
						'inuConceptoId: ' 	|| inuConceptoId  || CHR(10) || 
						'isbSigno: '	|| isbSigno || CHR(10) || 
						'inuCargcodo: ' 	|| inuCargcodo, cnuNivelTraza); 
						
        UPDATE  cargos
        SET     cargcodo = inuCargcodo
        WHERE   cargcuco = inuCuentaCobro
        AND cargconc = inuConceptoId
        AND cargsign = isbSigno
        AND cargcaca IN (nvl( (SELECT (regexp_substr(isbCausales,
                                                        '[^,]+',
                                                        1,
                                                        LEVEL)
                                                        ) AS column_value
                                                FROM dual
                                                CONNECT BY regexp_substr(isbCausales,
                                                                        '[^,]+',
                                                                        1,
                                                                        LEVEL
                                                                            ) IS NOT NULL)
                                ,0
                            )
                        );

		pkg_traza.trace(csbMT_NAME, cnuNivelTraza, pkg_traza.csbFIN);

    EXCEPTION
		WHEN pkg_error.CONTROLLED_ERROR THEN
			pkg_error.setError;
			pkg_Error.getError(nuError, sbmensaje);
			pkg_traza.trace('nuError: ' || nuError || ' sbmensaje: ' || sbmensaje, cnuNivelTraza);
			pkg_traza.trace(csbMT_NAME, cnuNivelTraza, pkg_traza.csbFIN_ERC); 
			RAISE pkg_error.CONTROLLED_ERROR;
		WHEN others THEN
			pkg_Error.setError;
			pkg_Error.getError(nuError, sbmensaje);
			pkg_traza.trace('nuError: ' || nuError || ' sbmensaje: ' || sbmensaje, cnuNivelTraza);
			pkg_traza.trace(csbMT_NAME, cnuNivelTraza, pkg_traza.csbFIN_ERR); 
			RAISE pkg_Error.Controlled_Error;
    END prcActualizaCargcodo;	

	/**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> prcActualizacionMasivaCargos </Unidad>
    <Autor> Luis Felipe Valencia Hurtado</Autor>
    <Fecha> 27/12/2024 </Fecha>
    <Descripcion> 
        Actualiza cargos masiva
    </Descripcion>
    <Historial>
        <Modificacion Autor="felipe.valencia" Fecha="27/12/2024" Inc="OSF-3041" Empresa="EFG">
            Creación
        </Modificacion>
    </Historial>
    </Procedure>
    **************************************************************************/
	PROCEDURE prcActualizacionMasivaCargos
    (
        ircCargos        IN tytbcargos,
        orcCargos        OUT tytbcargos
	)
	IS
		csbMT_NAME  		VARCHAR2(70) := csbSP_NAME || 'prcActualizacionMasivaCargos';
		nuError				NUMBER;  
		sbmensaje			VARCHAR2(4000);  

	BEGIN
		pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);

        FORALL nuIndex in ircCargos.cargfact.FIRST .. ircCargos.cargfact.LAST
        UPDATE  cargos
        SET     cargcuco = ircCargos.cargcuco(nuIndex),
                cargfecr = ircCargos.cargfecr(nuIndex),
                cargtipr = ircCargos.cargtipr(nuIndex)
        WHERE  rowid    = ircCargos.cargrowid(nuIndex)
        RETURNING cargnuse, cargconc, cargvalo, cargvabl, cargsign, cargcaca, cargdoso, cargfecr
        BULK COLLECT INTO orcCargos.cargnuse, orcCargos.cargconc, orcCargos.cargvalo, orcCargos.cargvabl, orcCargos.cargsign, orcCargos.cargcaca, orcCargos.cargdoso, orcCargos.cargfecr;

		pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
	EXCEPTION
		WHEN pkg_Error.Controlled_Error THEN
			pkg_Error.getError(nuError, sbmensaje);
			pkg_traza.trace('nuError: ' || nuError || ', ' || 'sbmensaje: ' || sbmensaje, pkg_traza.cnuNivelTrzDef);
			pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
			RAISE pkg_Error.Controlled_Error;
		WHEN others THEN
			Pkg_Error.seterror;
			pkg_error.geterror(nuError, sbmensaje);
			pkg_traza.trace('nuError: ' || nuError || ', ' || 'sbmensaje: ' || sbmensaje, pkg_traza.cnuNivelTrzDef);
			pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
			RAISE pkg_Error.Controlled_Error;
	END prcActualizacionMasivaCargos;
END pkg_cargos;
/

begin
    pkg_utilidades.prAplicarPermisos('PKG_CARGOS','ADM_PERSON');
end;
/

