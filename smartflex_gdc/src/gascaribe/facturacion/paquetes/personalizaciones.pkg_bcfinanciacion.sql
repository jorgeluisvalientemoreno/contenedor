CREATE OR REPLACE PACKAGE personalizaciones.pkg_bcfinanciacion IS
  /*******************************************************************************
      Propiedad Intelectual de Gases del Caribe
      Paquete          : pkg_bcfinanciacion
      Autor            : Jorge Valiente 
      Fecha            : 11/12/2024   
      Descripcion      : Paquete para obtener DATA relacioanda a las financiaciones, diferidos
                         negociaciones, entre otros.
      Modificaciones   :
      Autor         Fecha       Caso        Descripcion
      fvalencia     24/04/2025  OSF-4294    Se realiza la creación de la función
                                            fnuObtienePorcInteresUsura
                                            Se agrega el metodo  fnuObtCantFinanxProducto
	  jerazomvm		01/04/202	OSF-4155	Se crean las funciones:
												- fnuObtCantidadPlanFinan
												- fnuObtCantDiferidosxProducto
      jpinedc       07/02/2025  OSF-3893    Se crean fnuObtCuenCobrTraslDifFinCorr y
                                            fnuObtCuenCobrTraslDifEnCorr
  *******************************************************************************/

  -- Retorna Categoria del producto
  FUNCTION fnuObtSaldoPendDifeSinReclamo(nudifenuse diferido.difenuse%TYPE)
    RETURN NUMBER;

    -- Obtiene la cuenta creada por al convertir a corriente un diferido de financiacion
    FUNCTION fnuObtCuenCobrTraslDifFinCorr
    (
        inuFinanciacion     IN  diferido.difecofi%type
    )
    RETURN cuencobr.cucocodi%TYPE;
    
    -- Obtiene la cuenta creada por al convertir a corriente un diferido de financiacion
    FUNCTION fnuObtCuenCobrTraslDifEnCorr
    (
        inuDiferido     IN  diferido.difecodi%type
    )
    RETURN cuencobr.cucocodi%TYPE;
    
    -- Obtiene el documento, el saldo y la fecha inicial de la financiacion
    PROCEDURE prcObtDocuSaldoFechIniFinan
    (
        inuFinanciacion     IN  diferido.difecofi%type,
        osbDocumento        OUT diferido.difenudo%TYPE, 
        onuSaldoPendiente   OUT diferido.difesape%TYPE,
        odtFechaInicial     OUT diferido.difefein%TYPE
    );
	
	-- Obtiene la cantidad del plan de financiación por contrato y plan
    FUNCTION fnuObtCantidadPlanFinan(inuContratoId	suscripc.susccodi%TYPE,
									 isbPlanesFinan	parametros.valor_cadena%TYPE
									 )
	RETURN NUMBER;
	
	-- Obtiene la cantidad de diferidos en un rango de fechas y programa del producto
    FUNCTION fnuObtCantDiferidosxProducto(inuProducto		pr_product.product_id%TYPE,
										  idtFechaInicial	DATE,
										  idtFechaFinal		DATE,
										  isbPrograma		diferido.difeprog%TYPE
										  )
	RETURN NUMBER;

    ----Obtiene tasa de usura
    FUNCTION fnuObtienePorcInteresUsura
    RETURN conftain.cotiporc%TYPE;

    -- Obtiene la cantidad de financiación del producto, en un rango de fechas y programa del producto
    FUNCTION fnuObtCantFinanxProducto
    (
        inuProducto		pr_product.product_id%TYPE,
        idtFechaInicial	DATE,
        idtFechaFinal   DATE,
        isbPrograma		diferido.difeprog%TYPE
    )
    RETURN NUMBER;
END pkg_bcfinanciacion;
/

CREATE OR REPLACE PACKAGE BODY personalizaciones.pkg_bcfinanciacion IS

  -- Constantes para el control de la traza
  csbSP_NAME CONSTANT VARCHAR2(35) := $$PLSQL_UNIT || '.';
  cnuNVLTRC  CONSTANT NUMBER(2) := pkg_traza.cnuNivelTrzDef;

  /*****************************************************************
  PROPIEDAD INTELECTUAL DE PETI (C).
  
  UNIDAD         : fnuObtSaldoPendDifeSinReclamo
  DESCRIPCION    : Función que permitira retornar el valor total del saldos pendientes de los 
                   diferidoas asociados a un servicio y que estos diferidos no esten asociados 
                   a un proceso en reclamo.
                   En caso de tener no tener saldo pendiente retornara 0
  AUTOR          : Jorge Valiente
  FECHA          : 11/12/2024
  
  PARAMETROS              DESCRIPCION
  ============         ===================
  Entrada 
     nudifenuse        Codigo del servicio a validar
  
  Salida 
     nuValor           suma total de los saldos pendientes de los diferidoas asociados a un servicio
  
  FECHA             AUTOR             MODIFICACION
  =========       =========           ====================
  ******************************************************************/
  FUNCTION fnuObtSaldoPendDifeSinReclamo(nudifenuse diferido.difenuse%TYPE)
    RETURN NUMBER IS
  
    csbMetodo CONSTANT VARCHAR2(100) := csbSP_NAME ||
                                        'fnuObtSaldoPendDifeSinReclamo'; --nombre del metodo
    nuErrorCode    NUMBER;
    sbErrorMessage VARCHAR2(4000);
  
    CURSOR cutotalnoreclamo IS
      SELECT --+ index(diferido IX_DIFE_NUSE)
       SUM(DECODE(difesign, 'DB', difesape, -difesape)) valor_total
        FROM diferido
       WHERE difenuse = nudifenuse
         AND difetire = 'D'
         AND difesign in ('DB', 'CR')
         AND difesape > 0
         AND NVL(difeenre, 'N') = 'N';
  
    rfcutotalnoreclamo cutotalnoreclamo%ROWTYPE;
    nuValor            NUMBER := 0;
  
  BEGIN
  
    pkg_traza.trace(csbMetodo,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbINICIO);
  
    open cutotalnoreclamo;
    fetch cutotalnoreclamo
      into rfcutotalnoreclamo;
    close cutotalnoreclamo;
  
    if rfcutotalnoreclamo.valor_total > 0 then
      nuValor := rfcutotalnoreclamo.valor_total;
    end if;
  
    pkg_traza.trace('Retorna Valor [' || nuValor || ']',
                    pkg_traza.cnuNivelTrzDef);
  
    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    return nuValor;
  
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
      pkg_Error.getError(nuErrorCode, sbErrorMessage);
      pkg_traza.trace('Error: ' || sbErrorMessage,
                      pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMetodo,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERC);
      RETURN(nuValor);
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(nuErrorCode, sbErrorMessage);
      pkg_traza.trace('Error: ' || sbErrorMessage,
                      pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMetodo,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERR);
      RETURN(nuValor);
    
  END fnuObtSaldoPendDifeSinReclamo;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Programa        : fnuObtCuenCobrTraslDifFinCorr 
    Descripcion     : Retorna la cuenta de cobro creada al convertir el diferido
                      de una financiacion en deuda corriente
    Autor           : Lubin Pineda - GlobalMVM 
    Fecha           : 07/02/2025 
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    jpinedc     07/02/2025  OSF-3893    Creacion
    ***************************************************************************/                     
    FUNCTION fnuObtCuenCobrTraslDifFinCorr
    (
        inuFinanciacion     IN  diferido.difecofi%type
    )
    RETURN cuencobr.cucocodi%TYPE
    IS
        -- Nombre de este mtodo
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fnuObtCuenCobrTraslDifFinCorr';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        
        nuCuenCobrConvDifFinCorr    cuencobr.cucocodi%TYPE;

        CURSOR cuObtCuenCobrConvDifFinCorr
        IS
        SELECT MAX(cucocodi)
        FROM cargos c, cuencobr cc, diferido d
        WHERE c.cargcuco = cc.cucocodi
        AND c.cargdoso = 'DF-' || d.difecodi
        AND d.difecofi = inuFinanciacion
        AND trunc(c.cargfecr) = trunc(sysdate);
			        
    BEGIN

        pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbINICIO);  
        
        OPEN cuObtCuenCobrConvDifFinCorr;
        FETCH cuObtCuenCobrConvDifFinCorr INTO nuCuenCobrConvDifFinCorr;
        CLOSE cuObtCuenCobrConvDifFinCorr;
        
        pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN); 
         
        RETURN nuCuenCobrConvDifFinCorr;
           
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, cnuNVLTRC );
            RETURN nuCuenCobrConvDifFinCorr;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, cnuNVLTRC );
            RETURN nuCuenCobrConvDifFinCorr;
    END fnuObtCuenCobrTraslDifFinCorr;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Programa        : fnuObtCuenCobrTraslDifEnCorr 
    Descripcion     : Obtiene la cuenta creada por al convertir a corriente un 
                        diferido
    Autor           : Lubin Pineda - GlobalMVM 
    Fecha           : 07/02/2025 
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    jpinedc     07/02/2025  OSF-3893    Creacion
    ***************************************************************************/
    FUNCTION fnuObtCuenCobrTraslDifEnCorr
    (
        inuDiferido     IN  diferido.difecodi%type
    )
    RETURN cuencobr.cucocodi%TYPE
    IS
        -- Nombre de este mtodo
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fnuObtCuenCobrTraslDifEnCorr';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        
        nuCuenCobrConvDifEnCorr    cuencobr.cucocodi%TYPE;

        CURSOR cuObtCuenCobrConvDifEnCorr
        IS
        SELECT MAX(cucocodi)
        FROM cargos c, cuencobr cc
        WHERE c.cargcuco = cc.cucocodi
        AND c.cargdoso = 'DF-' || inuDiferido
        AND trunc(c.cargfecr) = trunc(sysdate);
			        
    BEGIN

        pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbINICIO);  
        
        OPEN cuObtCuenCobrConvDifEnCorr;
        FETCH cuObtCuenCobrConvDifEnCorr INTO nuCuenCobrConvDifEnCorr;
        CLOSE cuObtCuenCobrConvDifEnCorr;
        
        pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN); 
         
        RETURN nuCuenCobrConvDifEnCorr;
           
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, cnuNVLTRC );
            RETURN nuCuenCobrConvDifEnCorr;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, cnuNVLTRC );
            RETURN nuCuenCobrConvDifEnCorr;
    END fnuObtCuenCobrTraslDifEnCorr;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Programa        : prcObtDocuSaldoFechIniFinan 
    Descripcion     : Obtiene el documento, el saldo y la fecha inicial de la
                      financiacion
    Autor           : Lubin Pineda - GlobalMVM 
    Fecha           : 11/02/2025 
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    jpinedc     11/02/2025  OSF-3893    Creacion
    ***************************************************************************/
    PROCEDURE prcObtDocuSaldoFechIniFinan
    (
        inuFinanciacion     IN  diferido.difecofi%type,
        osbDocumento        OUT diferido.difenudo%TYPE, 
        onuSaldoPendiente   OUT diferido.difesape%TYPE,
        odtFechaInicial     OUT diferido.difefein%TYPE
    )
    IS
        -- Nombre de este mtodo
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prcObtDocuSaldoFechIniFinan';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);    
    
        CURSOR cugetInfodif 
        IS
        SELECT d.difenudo,
                SUM(d.difesape),
                MAX(trunc(d.difefein))
        FROM   diferido d
        WHERE  d.difecofi = inuFinanciacion
        GROUP  BY d.difenudo;
        
    BEGIN

        pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbINICIO); 

        OPEN cugetInfodif;
        FETCH cugetInfodif INTO osbDocumento, onuSaldoPendiente, odtFechaInicial;
        CLOSE cugetInfodif;
        
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
    END prcObtDocuSaldoFechIniFinan;
	
	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Programa        : fnuObtCantidadPlanFinan 
    Descripcion     : Obtiene la cantidad del plan de financiación por contrato y plan
                      de financiacion
					  
    Autor           : Jhon Erazo
    Fecha           : 21/03/2025 
	
    Modificaciones  :
    Autor       Fecha       	Caso        Descripcion
    jerazomvm	21/03/2025   	OSF-4155    Creacion
    ***************************************************************************/
    FUNCTION fnuObtCantidadPlanFinan(inuContratoId	suscripc.susccodi%TYPE,
									 isbPlanesFinan	parametros.valor_cadena%TYPE
									 )
	RETURN NUMBER
    IS
        -- Nombre de este mtodo
        csbMetodo       CONSTANT VARCHAR2(70) := csbSP_NAME || 'fnuObtCantidadPlanFinan';
        
		nuError         NUMBER;
		nuCantidad		NUMBER;
        sbError         VARCHAR2(4000);    
    
        CURSOR cuCantidadPlanFinan
		IS
			SELECT  count(1)
			FROM cc_financing_request c, 
				 mo_packages p
			WHERE c.package_id 		= p.package_id
			AND subscription_id 	= inuContratoId
			AND p.motive_status_id != 32
			AND financing_plan_id  IN ((SELECT TO_NUMBER(regexp_substr(isbPlanesFinan,'[^|,]+', 1, level))
										FROM DUAL A
										CONNECT BY regexp_substr(isbPlanesFinan, '[^|,]+', 1, level) IS NOT NULL))
			AND ROWNUM = 1;
        
    BEGIN

        pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbINICIO); 
		
		pkg_traza.trace('inuContratoId: ' 	|| inuContratoId || CHR(10) ||
						'isbPlanesFinan: ' 	|| isbPlanesFinan, cnuNVLTRC);

        IF (cuCantidadPlanFinan%ISOPEN) THEN
			CLOSE cuCantidadPlanFinan;
		END IF;
		
		OPEN cuCantidadPlanFinan;
		FETCH cuCantidadPlanFinan INTO nuCantidad;			  
		CLOSE cuCantidadPlanFinan;
		
		pkg_traza.trace('nuCantidad: ' || nuCantidad, cnuNVLTRC);
        
        pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN); 
		
		RETURN nuCantidad;
         
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
    END fnuObtCantidadPlanFinan;
	
	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Programa        : fnuObtCantDiferidosxProducto 
    Descripcion     : Obtiene la cantidad de diferidos en un rango de fechas y programa
					  del producto
					  
    Autor           : Jhon Erazo
    Fecha           : 01/04/2025 
	
    Modificaciones  :
    Autor       Fecha       	Caso        Descripcion
    jerazomvm	01/04/2025   	OSF-4155    Creacion
    ***************************************************************************/
    FUNCTION fnuObtCantDiferidosxProducto(inuProducto		pr_product.product_id%TYPE,
										  idtFechaInicial	DATE,
										  idtFechaFinal		DATE,
										  isbPrograma		diferido.difeprog%TYPE
										  )
	RETURN NUMBER
    IS
        -- Nombre de este mtodo
        csbMetodo       CONSTANT VARCHAR2(70) := csbSP_NAME || 'fnuObtCantDiferidosxProducto';
        
		nuError         NUMBER;
		nuCantidad		NUMBER;
        sbError         VARCHAR2(4000);    
    
        CURSOR cuCantidadDiferidos
		IS
			SELECT COUNT(DISTINCT(d.difecodi))
			FROM diferido d
			WHERE d.difenuse = inuProducto
			AND d.difefein 	BETWEEN idtFechaInicial AND idtFechaFinal
			AND d.difeprog 	= isbPrograma;
        
    BEGIN

        pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbINICIO); 
		
		pkg_traza.trace('inuProducto: ' 	|| inuProducto 		|| CHR(10) ||
						'idtFechaInicial: '	|| idtFechaInicial  || CHR(10) ||
						'idtFechaFinal: '	|| idtFechaFinal    || CHR(10) ||
						'isbPrograma: '		|| isbPrograma, cnuNVLTRC);

        IF (cuCantidadDiferidos%ISOPEN) THEN
			CLOSE cuCantidadDiferidos;
		END IF;
		
		OPEN cuCantidadDiferidos;
		FETCH cuCantidadDiferidos INTO nuCantidad;			  
		CLOSE cuCantidadDiferidos;
		
		pkg_traza.trace('nuCantidad: ' || nuCantidad, cnuNVLTRC);
        
        pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN); 
		
		RETURN nuCantidad;
         
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
    END fnuObtCantDiferidosxProducto;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Programa        : fnuObtienePorcInteresUsura 
    Descripcion     : Obtiene porcentaje de interes de usura
    Autor           : Luis Felipe Valencia
    Fecha           : 12/03/2025 
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    fvalencia   12/03/2025  OSF-3846    Creacion
    ***************************************************************************/
    FUNCTION fnuObtienePorcInteresUsura
    RETURN conftain.cotiporc%TYPE
    IS
        -- Nombre de este mtodo
        csbMetodo       CONSTANT VARCHAR2(70) := csbSP_NAME || 'fnuObtienePorcInteresUsura';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        
        nuPorcentajeInteres   conftain.cotiporc%TYPE;

        CURSOR cuObtTasaUsura
        IS
        SELECT  cotiporc
        FROM    conftain t
        WHERE   t.cotitain = pkg_bcparametros_open.fnuObtNumericoParametr('BIL_TASA_USURA')
        AND sysdate BETWEEN t.cotifein AND t.cotifefi;
			        
    BEGIN

        pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbINICIO);  
        
        OPEN cuObtTasaUsura;
        FETCH cuObtTasaUsura INTO nuPorcentajeInteres;
        CLOSE cuObtTasaUsura;
        
        pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN); 
         
        RETURN nuPorcentajeInteres;
           
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, cnuNVLTRC );
            RETURN nuPorcentajeInteres;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, cnuNVLTRC );
            RETURN nuPorcentajeInteres;
    END fnuObtienePorcInteresUsura;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Programa        : fnuObtCantFinanxProducto 
    Descripcion     : Obtiene la cantidad de financiación del producto, en un rango de fechas y programa
					  del producto
					  
    Autor           : Jhon Erazo
    Fecha           : 25/04/2025 
	
    Modificaciones  :
    Autor       Fecha       	Caso        Descripcion
    jerazomvm	25/04/2025   	OSF-4063    Creacion
    ***************************************************************************/
    FUNCTION fnuObtCantFinanxProducto(inuProducto		pr_product.product_id%TYPE,
										  idtFechaInicial	DATE,
										  idtFechaFinal		DATE,
										  isbPrograma		diferido.difeprog%TYPE
										  )
	RETURN NUMBER
    IS
        -- Nombre de este mtodo
        csbMetodo       CONSTANT VARCHAR2(70) := csbSP_NAME || 'fnuObtCantFinanxProducto';
        
		nuError         NUMBER;
		nuCantidad		NUMBER;
        sbError         VARCHAR2(4000);    
    
        CURSOR cuCantidadDiferidos
		IS
        SELECT COUNT(DISTINCT(d.difecofi))
        FROM diferido d
        WHERE d.difenuse = inuProducto
        AND d.difefein 	BETWEEN idtFechaInicial AND idtFechaFinal
        AND d.difeprog 	= isbPrograma;        
    BEGIN
        pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbINICIO); 
		
		pkg_traza.trace('inuProducto: ' 	|| inuProducto 		|| CHR(10) ||
						'idtFechaInicial: '	|| idtFechaInicial  || CHR(10) ||
						'idtFechaFinal: '	|| idtFechaFinal    || CHR(10) ||
						'isbPrograma: '		|| isbPrograma, cnuNVLTRC);
        IF (cuCantidadDiferidos%ISOPEN) THEN
			CLOSE cuCantidadDiferidos;
		END IF;
		
		OPEN cuCantidadDiferidos;
		FETCH cuCantidadDiferidos INTO nuCantidad;			  
		CLOSE cuCantidadDiferidos;
		
		pkg_traza.trace('nuCantidad: ' || nuCantidad, cnuNVLTRC);
        
        pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN); 
		
		RETURN nuCantidad;         
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
    END fnuObtCantFinanxProducto;
END pkg_bcfinanciacion;
/

begin
  pkg_utilidades.prAplicarPermisos('pkg_bcfinanciacion', 'PERSONALIZACIONES');
end;
/

