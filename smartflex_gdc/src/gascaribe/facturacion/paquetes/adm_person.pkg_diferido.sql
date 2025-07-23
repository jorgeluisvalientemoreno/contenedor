create or replace PACKAGE adm_person.pkg_diferido IS
  CURSOR cuObtRegistro (inuDiferido IN diferido.difecodi%type) IS
  SELECT diferido.*, diferido.rowid
  FROM diferido
  WHERE diferido.difecodi = inuDiferido;

  SUBTYPE sbtDiferido IS diferido%ROWTYPE;
  SUBTYPE sbtRegDiferido IS cuObtRegistro%ROWTYPE;

  FUNCTION fsbVersion RETURN VARCHAR2;
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbVersion
    Descripcion     : Retona el identificador del ultimo caso que hizo cambios
    Autor           : Luis Javier Lopez Barrios
    Fecha           : 15-01-2025

    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
    LJLB       15-01-2025   OSF-3855    Creacion
  ***************************************************************************/

  PROCEDURE prcActualizaSaldPendDife (inuDiferido    IN diferido.difecodi%type,
                                      inuSaldoAct    IN  diferido.difevatd%type,
                                      iblActuaNucupa IN  BOOLEAN DEFAULT FALSE);
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prcActualizaSaldPendDife
    Descripcion     : proceso que actualiza saldo pendiente de diferido
    Autor           : Luis Javier Lopez Barrios
    Fecha           : 15-01-2025

    Parametros Entrada
     inuDiferido        codigo del diferido
     inuSaldoAct        valor actualizar en saldo pendiente
     iblActuaNucupa     actualiza numero de cuota pagada
    Parametros de salida

    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
    LJLB       15-01-2025   OSF-3855    Creacion
  ***************************************************************************/
  FUNCTION frcObtInfoDiferido (inuDiferido IN diferido.difecodi%type) RETURN sbtRegDiferido;
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : frcObtInfoDiferido
    Descripcion     : Retona informacion de diferidos
    Autor           : Luis Javier Lopez Barrios
    Fecha           : 15-01-2025

    Parametros Entrada
     inuDiferido  codigo del diferido
    Parametros de salida

    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
    LJLB       15-01-2025   OSF-3855    Creacion
  ***************************************************************************/
  FUNCTION fblExisteDiferido (inuDiferido IN diferido.difecodi%type) RETURN BOOLEAN;
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fblExisteDiferido
    Descripcion     :  valida si existe diferido
    Autor           : Luis Javier Lopez Barrios
    Fecha           : 15-01-2025

    Parametros Entrada
     inuDiferido  codigo del diferido
    Parametros de salida

    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
    LJLB       15-01-2025   OSF-3855    Creacion
  ***************************************************************************/

  -- Inserta un registro
  PROCEDURE prinsRegistro( ircRegistro diferido%ROWTYPE);
  
    -- Obtiene la cantidad de saldos diferidos por producto, plan y programa
    FUNCTION fnuObtCantiSaldDifexProducPlan(inuProducto	IN diferido.difenuse%TYPE,
											inuPlan		IN diferido.difepldi%TYPE,
											isbPrograma	IN diferido.difeprog%TYPE
											)  
	RETURN NUMBER;

    -- Obtiene la cantidad de saldos diferidos por producto y programa
    FUNCTION fnuObtCantiSaldDifexProducProg(inuProducto	IN diferido.difenuse%TYPE,
											isbPrograma	IN diferido.difeprog%TYPE
											)
	RETURN NUMBER;

    -- Actualiza a una sola cuota el diferido
    PROCEDURE prcActuDifeCuotaUnica
    ( 
        inuDiferido         diferido.difecodi%TYPE,
        onuError        OUT NUMBER,
        osbError        OUT NUMBER
    );
    	
END pkg_diferido;
/

create or replace PACKAGE BODY adm_person.pkg_diferido IS
  -- Identificador del ultimo caso que hizo cambios
    csbVersion                 VARCHAR2(15) := 'OSF-4537';

    -- Constantes para el control de la traza
    csbSP_NAME     CONSTANT VARCHAR2(35) := $$PLSQL_UNIT||'.'; 
    cnuNVLTRC      CONSTANT NUMBER(2)    := pkg_traza.cnuNivelTrzDef; 
    nuError     NUMBER; 
    sbError     VARCHAR2(4000);
    FUNCTION fsbVersion RETURN VARCHAR2 IS
      /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : fsbVersion
        Descripcion     : Retona el identificador del ultimo caso que hizo cambios
        Autor           : Luis Javier Lopez Barrios
        Fecha           : 22-11-2024

        Modificaciones  :
        Autor       Fecha       Caso       Descripcion
        LJLB      22-11-2024   OSF-3540    Creacion
      ***************************************************************************/
      csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.fsbVersion';
    BEGIN
        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        pkg_traza.trace('csbVersion => ' || csbVersion, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

        RETURN csbVersion;
     EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            pkg_error.geterror(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            pkg_error.setError;
            pkg_error.geterror(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RAISE pkg_error.CONTROLLED_ERROR;
  END fsbVersion;
  PROCEDURE prcActualizaSaldPendDife (inuDiferido    IN diferido.difecodi%type,
                                      inuSaldoAct    IN  diferido.difevatd%type,
                                      iblActuaNucupa IN  BOOLEAN DEFAULT FALSE) IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prcActualizaSaldPendDife
    Descripcion     : proceso que actualiza saldo pendiente de diferido
    Autor           : Luis Javier Lopez Barrios
    Fecha           : 15-01-2025

    Parametros Entrada
     inuDiferido        codigo del diferido
     inuSaldoAct        valor actualizar en saldo pendiente
     iblActuaNucupa     actualiza numero de cuota pagada
    Parametros de salida

    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
    LJLB       15-01-2025   OSF-3855    Creacion
  ***************************************************************************/
      csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.prcActualizaSaldPendDife';
    BEGIN
        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        pkg_traza.trace(' inuDiferido => ' || inuDiferido, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(' inuSaldoAct => ' || inuSaldoAct, pkg_traza.cnuNivelTrzDef);
        
        IF iblActuaNucupa THEN
          pkg_traza.trace(' iblActuaNucupa => Verdadero' , pkg_traza.cnuNivelTrzDef);
          UPDATE diferido
              set difesape =  difesape -  inuSaldoAct,
                  difecupa = difenucu,
                  difefumo = sysdate
          WHERE difecodi = inuDiferido;
      ELSE
         pkg_traza.trace(' iblActuaNucupa => Falso' , pkg_traza.cnuNivelTrzDef);
         UPDATE diferido
            set difesape =  difesape -  inuSaldoAct,
                 difefumo = sysdate
         WHERE difecodi = inuDiferido;
      END IF;
        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
     EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            pkg_error.geterror(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            pkg_error.setError;
            pkg_error.geterror(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RAISE pkg_error.CONTROLLED_ERROR;
  END prcActualizaSaldPendDife;
  PROCEDURE prCierracuObtRegistro IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prCierracuObtRegistro
    Descripcion     : proceso que cierra cursor cuObtRegistro
    Autor           : Luis Javier Lopez Barrios
    Fecha           : 15-01-2025

    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
    LJLB       15-01-2025   OSF-3855    Creacion
  ***************************************************************************/
      csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.prcInsertarMoviDife';
  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
     IF cuObtRegistro%ISOPEN THEN CLOSE cuObtRegistro; END IF;
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
        pkg_error.geterror(nuError,sbError);
        pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
        RAISE pkg_error.CONTROLLED_ERROR;
    WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.geterror(nuError,sbError);
        pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
        RAISE pkg_error.CONTROLLED_ERROR;
  END prCierracuObtRegistro;
  FUNCTION frcObtInfoDiferido (inuDiferido IN diferido.difecodi%type) RETURN sbtRegDiferido IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : frcObtInfoDiferido
    Descripcion     : Retona informacion de diferidos
    Autor           : Luis Javier Lopez Barrios
    Fecha           : 15-01-2025

    Parametros Entrada
     inuDiferido  codigo del diferido
    Parametros de salida

    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
    LJLB       15-01-2025   OSF-3855    Creacion
  ***************************************************************************/
    csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.frcObtInfoDiferido';
    rcDiferido      sbtRegDiferido;
  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
    pkg_traza.trace(' inuDiferido => ' || inuDiferido, pkg_traza.cnuNivelTrzDef);
    prCierracuObtRegistro;
    OPEN cuObtRegistro(inuDiferido);
    FETCH cuObtRegistro INTO rcDiferido;
    CLOSE cuObtRegistro;

    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    RETURN rcDiferido;
  EXCEPTION
   WHEN pkg_error.CONTROLLED_ERROR THEN
        pkg_error.geterror(nuError,sbError);
        prCierracuObtRegistro;
        pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
        RAISE pkg_error.CONTROLLED_ERROR;
    WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.geterror(nuError,sbError);
        prCierracuObtRegistro;
        pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
        RAISE pkg_error.CONTROLLED_ERROR;
  END frcObtInfoDiferido;
  FUNCTION fblExisteDiferido (inuDiferido IN diferido.difecodi%type) RETURN BOOLEAN IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fblExisteDiferido
    Descripcion     :  valida si existe diferido
    Autor           : Luis Javier Lopez Barrios
    Fecha           : 15-01-2025

    Parametros Entrada
     inuDiferido  codigo del diferido
    Parametros de salida

    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
    LJLB       15-01-2025   OSF-3855    Creacion
  ***************************************************************************/
    csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.fblExisteDiferido';
    blExisteDife    BOOLEAN := TRUE;
    rcDiferido      sbtRegDiferido;
  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
    pkg_traza.trace(' inuDiferido => ' || inuDiferido, pkg_traza.cnuNivelTrzDef);
    prCierracuObtRegistro;
    OPEN cuObtRegistro(inuDiferido);
    FETCH cuObtRegistro INTO rcDiferido;
    IF cuObtRegistro%NOTFOUND THEN
       blExisteDife := FALSE;
    END IF;
    CLOSE cuObtRegistro;

    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    RETURN blExisteDife;
  EXCEPTION
   WHEN pkg_error.CONTROLLED_ERROR THEN
        pkg_error.geterror(nuError,sbError);
        prCierracuObtRegistro;
        pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
        RAISE pkg_error.CONTROLLED_ERROR;
    WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.geterror(nuError,sbError);
        prCierracuObtRegistro;
        pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
        RAISE pkg_error.CONTROLLED_ERROR;
  END fblExisteDiferido;

    -- Inserta un registro
    PROCEDURE prInsRegistro( ircRegistro diferido%ROWTYPE) IS
        csbMT_NAME        CONSTANT VARCHAR2(70) := csbSP_NAME||'prInsRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        INSERT INTO diferido(
            DIFECODI,DIFESUSC,DIFECONC,DIFEVATD,DIFEVACU,DIFECUPA,DIFENUCU,DIFESAPE,DIFENUDO,DIFEINTE,DIFEINAC,DIFEUSUA,DIFETERM,DIFESIGN,DIFENUSE,DIFEMECA,DIFECOIN,DIFEPROG,DIFEPLDI,DIFEFEIN,DIFEFUMO,DIFESPRE,DIFETAIN,DIFEFAGR,DIFECOFI,DIFETIRE,DIFEFUNC,DIFELURE,DIFEENRE
        )
        VALUES (
            ircRegistro.DIFECODI,ircRegistro.DIFESUSC,ircRegistro.DIFECONC,ircRegistro.DIFEVATD,ircRegistro.DIFEVACU,ircRegistro.DIFECUPA,ircRegistro.DIFENUCU,ircRegistro.DIFESAPE,ircRegistro.DIFENUDO,ircRegistro.DIFEINTE,ircRegistro.DIFEINAC,ircRegistro.DIFEUSUA,ircRegistro.DIFETERM,ircRegistro.DIFESIGN,ircRegistro.DIFENUSE,ircRegistro.DIFEMECA,ircRegistro.DIFECOIN,ircRegistro.DIFEPROG,ircRegistro.DIFEPLDI,ircRegistro.DIFEFEIN,ircRegistro.DIFEFUMO,ircRegistro.DIFESPRE,ircRegistro.DIFETAIN,ircRegistro.DIFEFAGR,ircRegistro.DIFECOFI,ircRegistro.DIFETIRE,ircRegistro.DIFEFUNC,ircRegistro.DIFELURE,ircRegistro.DIFEENRE
        );
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, pkg_traza.cnuNivelTrzDef );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, pkg_traza.cnuNivelTrzDef );
                RAISE pkg_error.Controlled_Error;
    END prInsRegistro;
        
/***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Programa        : fnuObtCantiSaldDifexProducPlan 
    Descripcion     : Obtiene la cantidad de saldos diferidos por producto, plan
					  y programa
					  
    Autor           : Jhon Erazo
    Fecha           : 11/04/2025 
	
    Modificaciones  :
    Autor       Fecha       	Caso        Descripcion
    jerazomvm	11/04/2025   	OSF-4155    Creacion
    ***************************************************************************/
    FUNCTION fnuObtCantiSaldDifexProducPlan(inuProducto	IN diferido.difenuse%TYPE,
											inuPlan		IN diferido.difepldi%TYPE,
											isbPrograma	IN diferido.difeprog%TYPE
											)
	RETURN NUMBER
    IS
        -- Nombre de este mtodo
        csbMetodo       CONSTANT VARCHAR2(70) := csbSP_NAME || 'fnuObtCantiSaldDifexProducPlan';
        
		nuError         NUMBER;
		nuCantSaldoPen	NUMBER;
        sbError         VARCHAR2(4000);    
    
        CURSOR cuCantSaldoPendiente
		IS
			SELECT COUNT(1)
			FROM diferido 
			WHERE difenuse 	= inuProducto
			AND difepldi 	= inuPlan
			AND difeprog 	= isbPrograma 
			AND difesape 	> 0;
        
    BEGIN

        pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbINICIO); 
		
		pkg_traza.trace('inuProducto: '	|| inuProducto	|| CHR(10) ||
						'inuPlan: ' 	|| inuPlan		|| CHR(10) ||
						'isbPrograma: '	|| isbPrograma, cnuNVLTRC);

        IF (cuCantSaldoPendiente%ISOPEN) THEN
			CLOSE cuCantSaldoPendiente;
		END IF;
		
		OPEN cuCantSaldoPendiente;
		FETCH cuCantSaldoPendiente INTO nuCantSaldoPen;			  
		CLOSE cuCantSaldoPendiente;
		
		pkg_traza.trace('nuCantSaldoPen: ' || nuCantSaldoPen, cnuNVLTRC);
        
        pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN); 
		
		RETURN nuCantSaldoPen;
         
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
    END fnuObtCantiSaldDifexProducPlan;
	
	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Programa        : fnuObtCantiSaldDifexProducProg 
    Descripcion     : Obtiene la cantidad de saldos diferidos por producto y programa
					  
    Autor           : Jhon Erazo
    Fecha           : 04/06/2025 
	
    Modificaciones  :
    Autor       Fecha       	Caso        Descripcion
    jerazomvm	04/06/2025    	OSF-4535    Creacion
    ***************************************************************************/
    FUNCTION fnuObtCantiSaldDifexProducProg(inuProducto	IN diferido.difenuse%TYPE,
											isbPrograma	IN diferido.difeprog%TYPE
											)
	RETURN NUMBER
    IS
        -- Nombre de este mtodo
        csbMetodo       CONSTANT VARCHAR2(70) := csbSP_NAME || 'fnuObtCantiSaldDifexProducProg';
        
		nuError         NUMBER;
		nuCantSaldoPen	NUMBER;
        sbError         VARCHAR2(4000);    
    
        CURSOR cuCantSaldoPendiente
		IS
			SELECT COUNT(1)
			FROM diferido 
			WHERE difenuse 	= inuProducto
			AND difeprog 	= isbPrograma 
			AND difesape 	> 0;
        
    BEGIN

        pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbINICIO); 
		
		pkg_traza.trace('inuProducto: '	|| inuProducto	|| CHR(10) ||
						'isbPrograma: '	|| isbPrograma, cnuNVLTRC);

        IF (cuCantSaldoPendiente%ISOPEN) THEN
			CLOSE cuCantSaldoPendiente;
		END IF;
		
		OPEN cuCantSaldoPendiente;
		FETCH cuCantSaldoPendiente INTO nuCantSaldoPen;			  
		CLOSE cuCantSaldoPendiente;
		
		pkg_traza.trace('nuCantSaldoPen: ' || nuCantSaldoPen, cnuNVLTRC);
        
        pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN); 
		
		RETURN nuCantSaldoPen;
         
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
    END fnuObtCantiSaldDifexProducProg;    

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Programa        : prcActuDifeCuotaUnica 
    Descripcion     : Actualiza el numero de cuotas de un diferido a 1 
    Autor           : Lubin Pineda - GlobalMVM 
    Fecha           : 26/05/2025 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     29/05/2025  OSF-4537 Creacion
    ***************************************************************************/    
    PROCEDURE prcActuDifeCuotaUnica
    ( 
        inuDiferido         diferido.difecodi%TYPE,
        onuError        OUT NUMBER,
        osbError        OUT NUMBER
    )
    IS
        -- Nombre de este mtodo
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prcActuDifeCuotaUnica';
                        
        rcDiferido      pkg_Diferido.sbtRegDiferido;

        nugMetodo       diferido.difemeca%TYPE; -- Metodo Cuota
        nugFactor       diferido.difefagr%TYPE; -- Factor Gradiente
        nugSpread       diferido.difespre%TYPE; -- valor del Spread
        nugPorcInteres  diferido.difeinte%TYPE; -- Interes Efectivo
        nugPorIntNominal diferido.difeinte%TYPE; -- Interes Nominal
        nugTasaInte     diferido.difetain%TYPE;
        
        nuValorCuota    diferido.difevacu%TYPE;
                   
    BEGIN
    
        pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbINICIO);      

        rcDiferido := pkg_Diferido.frcObtInfoDiferido( inuDiferido );
        
        IF rcDiferido.difecupa > 0 then
            pkg_error.setErrorMessage( isbMsgErrr => 'No se puede actualizar el numero de cuotas del diferido[' || inuDiferido || '] porque tiene cuotas pagadas' );         
        ELSE
          
            IF rcDiferido.difenucu = 1 THEN
                pkg_traza.trace('El diferido[' || inuDiferido ||'] ya tiene numero de cuotas = 1', cnuNVLTRC); 
            ELSE
                UPDATE diferido
                SET difenucu = 1,
                difevacu = difevatd
                WHERE difecodi = inuDiferido;
            END IF;
            
        END IF;

        pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN);  
        
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(onuError,osbError);        
            pkg_traza.trace('osbError => ' || osbError, cnuNVLTRC );
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(onuError,osbError);
            pkg_traza.trace('osbError => ' || osbError, cnuNVLTRC );
            RAISE pkg_error.Controlled_Error;    
    END prcActuDifeCuotaUnica;
    
END pkg_diferido;
/

BEGIN
    pkg_utilidades.prAplicarPermisos('PKG_DIFERIDO','ADM_PERSON'); 
END;
/

