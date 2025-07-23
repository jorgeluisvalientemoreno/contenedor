CREATE OR REPLACE PACKAGE PERSONALIZACIONES.PKG_BCFACTURACION IS
/*******************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Paquete     :   pkg_bcfacturacion
    Autor       :   Jhon Jairo Soto
    Fecha       :   06/12/2024
    Descripcion :   Para publicar Servicios que involucren por lo menos dos de las siguientes tablas CARGOS, CUENCOBR, FACTURA
	
    Modificaciones  :
    Autor       Fecha       Caso    	Descripcion
	jerazomvm	24-12-2024	OSF-3801	1. Se crea el cursor cuCuencobr
										2. Se crean el tipo sbtCuencobr y subtipo tytbCuencobr
										3. Se crea el procedimiento prcObtCuentasVencidas
	jsoto		06/12/2024	OSF-3740  	Creacion
    jpinedc     11/02/2025  OSF-3593    Se crea fblContratoTieneFacturas   	
	jerazomvm	14/05/2025	OSF-4480	Se crea el procedimiento prcObtCicloYTipoProduFactura
	jerazomvm	13/06/2025	OSF-4594	Se renombra el procedimiento prcObtCicloYTipoProduFactura a función fnuObtTipoProduFactura
	jsoto		19/06/2025	OSF-4616	Se crea la funcion fnuContarCuentasConSaldo para un producto
*******************************************************************************/

	--CURSORES
	CURSOR cuCuencobr(inuCuenta IN cuencobr.cucocodi%TYPE) 
	IS
		SELECT *
		FROM cuencobr c
		WHERE cucocodi = inuCuenta;

    --TIPOS/SUBTIPOS
   SUBTYPE sbtCuencobr 	IS cuCuencobr%ROWTYPE;
   TYPE tytbCuencobr 	IS TABLE OF sbtCuencobr INDEX BY BINARY_INTEGER;

	-- Retona Identificador del ultimo caso que hizo cambios
    FUNCTION fsbVersion RETURN VARCHAR2;
    
    PROCEDURE prcObtContratoCuenta( inuCuenta 	IN cuencobr.cucocodi%TYPE,
									onuContrato	OUT suscripc.susccodi%TYPE
	);

    FUNCTION fnuObtSaldoPendSinReclamos( inuProducto 	IN servsusc.sesunuse%TYPE
	)RETURN NUMBER;
	
	-- Obtiene las cuentas vencidas del producto
	PROCEDURE prcObtCuentasVencidas(inuProductoId		IN  pr_product.product_id%type,
									otbCuentasVencidas	OUT  tytbCuencobr
									);


    -- Retorna verdadero si el contrato tiene facturas y cuentas de cobro
    FUNCTION fblContratoTieneFacturas( inuContrato IN    suscripc.susccodi%TYPE)
    RETURN BOOLEAN;
	
	-- Obtiene el ciclo y el tipo de producto de la factura
    FUNCTION fnuObtTipoProduFactura(inuFactura IN  factura.factcodi%TYPE)
	RETURN servsusc.sesuserv%TYPE;
	
	FUNCTION fnuContarCuentasConSaldo(inuProductoId		IN  pr_product.product_id%type)
	RETURN NUMBER;
    	
END PKG_BCFACTURACION;
/

CREATE OR REPLACE PACKAGE BODY PERSONALIZACIONES.PKG_BCFACTURACION IS

    -- Identificador del ultimo caso que hizo cambios
    csbVersion                 VARCHAR2(15) := 'OSF-4616';

    -- Constantes para el control de la traza
    csbSP_NAME                 CONSTANT VARCHAR2(35)         :=  $$PLSQL_UNIT||'.';
    cnuNVLTRC                  CONSTANT NUMBER                := 5;
    
    CNURECORD_NO_EXISTE CONSTANT NUMBER(1) := 1; 
    nuError                     NUMBER;
    sbError                     VARCHAR2(4000);


    --Retona la ultimo caso que hizo cambios en el paquete 
    FUNCTION fsbVersion RETURN VARCHAR2 IS
    BEGIN
        RETURN csbVersion;
    END fsbVersion;


     /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prcObtContratoCuenta 
    Descripcion     : Obtener contrato de una cuenta de cobro 
    Autor           : Jhon Jairo Soto 
    Fecha           : 06/12/2024
	
	Parametros de entrada
		inuCuenta 	Id de la cuenta de cobro
	
	Parametros de salida
		onuContrato	Id del contrato
	
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    jsoto		06-12-2024  OSF-3740    Creacion
    ***************************************************************************/  
    PROCEDURE prcObtContratoCuenta( inuCuenta 	IN cuencobr.cucocodi%TYPE,
									onuContrato	OUT suscripc.susccodi%TYPE
	) IS
	-- Nombre de este método
    csbMT_NAME  VARCHAR2(70) := csbSP_NAME ||  '.prcObtContratoCuenta';      
    nuerrorcode NUMBER;         -- se almacena codigo de error
    sbmenserror VARCHAR2(2000);  -- se almacena descripcion del error 
	nuContrato	NUMBER;
		
	CURSOR cuContrato IS
	SELECT factsusc
	FROM   cuencobr,factura
	WHERE  cucocodi = inuCuenta
	AND    cucofact = factcodi;
		
   BEGIN
        
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO); 

		IF cuContrato%ISOPEN THEN  
			CLOSE cuContrato;
		END IF;     		

		OPEN cuContrato;
		FETCH cuContrato INTO nuContrato;
		CLOSE cuContrato;

		onuContrato := nuContrato;
        
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
        
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
			pkg_error.getError(nuErrorCode,sbMensError);
			pkg_traza.trace(csbMT_NAME||' '||sbMensError, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME,cnuNVLTRC,pkg_traza.fsbFIN_ERC);	
			WHEN OTHERS THEN
            pkg_error.SetError;
			pkg_error.getError(nuErrorCode,sbMensError);
			pkg_traza.trace(csbMT_NAME||' '||sbMensError, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME,cnuNVLTRC,pkg_traza.fsbFIN_ERR);	

    END prcObtContratoCuenta;

     /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuObtSaldoPendSinReclamos 
    Descripcion     : Obtener saldo pendiente de un producto 
    Autor           : Jhon Jairo Soto 
    Fecha           : 11/12/2024
	
	Parametros de entrada
	
		inuProducto  Id de producto
	
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    jsoto		11-12-2024  OSF-3740    Creacion
    ***************************************************************************/  
    FUNCTION fnuObtSaldoPendSinReclamos( inuProducto 	IN servsusc.sesunuse%TYPE
	)RETURN NUMBER
	IS
	-- Nombre de este método
    csbMT_NAME  		VARCHAR2(70) := csbSP_NAME ||  '.fnuObtSaldoPendSinReclamos';      
    nuerrorcode 		NUMBER;         -- se almacena codigo de error
    sbmenserror 		VARCHAR2(2000);  -- se almacena descripcion del error 
	nuSaldoPendiente	NUMBER :=0;
		
	CURSOR cuSaldo IS
		SELECT nvl(sum(cucosacu),0) valor_total
		FROM cuencobr
		WHERE cuconuse = inuProducto
		AND nvl(cucosacu,0) > 0
		and nvl(cucovare,0) = 0
		and nvl(CUCOVRAP,0) = 0;	

   BEGIN
        
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO); 

		IF cuSaldo%ISOPEN THEN  
			CLOSE cuSaldo;
		END IF;     		

		OPEN cuSaldo;
		FETCH cuSaldo INTO nuSaldoPendiente;
		CLOSE cuSaldo;

        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
		
		RETURN(nuSaldoPendiente);
        
        EXCEPTION
			WHEN OTHERS THEN
            pkg_error.SetError;
			pkg_error.getError(nuErrorCode,sbMensError);
			pkg_traza.trace(csbMT_NAME||' '||sbMensError, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME,cnuNVLTRC,pkg_traza.fsbFIN_ERR);	
			RETURN(nuSaldoPendiente);
    END fnuObtSaldoPendSinReclamos;
	
	/**************************************************************************
    <PROCEDURE Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> prcObtCuentasVencidas </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 24-12-2024 </Fecha>
    <Descripcion> 
        Obtiene las cuentas vencidas del producto
    </Descripcion>
	<parametros>
		Entrada: 
			inuProductoId	Identificador del producto.
			
		Salida:
			otbCuentasVencidas	Tipo tabla de las cuentas vencidas del producto.
			
	</parametros>
    <Historial>
        <Modificacion Autor="Jhon.Erazo" Fecha="24-12-2024" Inc="OSF-3801" Empresa="GDC">
			Creación
        </Modificacion>
    </Historial>
    </FUNCTION>
    **************************************************************************/
    PROCEDURE prcObtCuentasVencidas(inuProductoId		IN  pr_product.product_id%type,
									otbCuentasVencidas	OUT	tytbCuencobr
									)
    IS
	
		csbMT_NAME  		VARCHAR2(70) := csbSP_NAME || 'prcObtCuentasVencidas';
		
		nuError				NUMBER;  
		sbmensaje			VARCHAR2(1000);  
		
		-- Cursor que retorna las cuentas vencidas del producto
		CURSOR cuCuentasVencidas
		IS 
			SELECT * 
			FROM cuencobr 
			WHERE cuconuse = inuProductoId
			AND cucosacu   > 0
			AND cucofeve   < LDC_BOCONSGENERALES.FDTGETSYSDATE
			AND (nvl(cucosacu,0) - (nvl(cucovare, 0 ) + nvl(cucovrap, 0))) > 0; 
        
    BEGIN
		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);
		
		pkg_traza.trace('inuProductoId: ' 	|| inuProductoId, cnuNVLTRC);
		
		IF (cuCuentasVencidas%ISOPEN) THEN
			CLOSE cuCuentasVencidas;
		END IF;
		
		OPEN cuCuentasVencidas;
		FETCH cuCuentasVencidas BULK COLLECT INTO otbCuentasVencidas;
		CLOSE cuCuentasVencidas;
		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    EXCEPTION
		WHEN pkg_error.CONTROLLED_ERROR THEN
			pkg_error.setError;
			pkg_Error.getError(nuError, sbmensaje);
			pkg_traza.trace('nuError: ' || nuError || ' sbmensaje: ' || sbmensaje, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC); 
			RAISE pkg_error.CONTROLLED_ERROR;
		WHEN others THEN
			pkg_Error.setError;
			pkg_Error.getError(nuError, sbmensaje);
			pkg_traza.trace('nuError: ' || nuError || ' sbmensaje: ' || sbmensaje, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR); 
			RAISE pkg_Error.Controlled_Error;
    END prcObtCuentasVencidas;
    
    -- Retorna verdadero si el contrato tiene facturas y cuentas de cobro
    FUNCTION fblContratoTieneFacturas( inuContrato IN    suscripc.susccodi%TYPE)
    RETURN BOOLEAN
    IS
        csbMetodo       VARCHAR2(100) := csbSP_NAME || '.fblContratoTieneFacturas';
        
        blTienFacturasYcuentas  BOOLEAN := FALSE;
        
        CURSOR cuTienFacturasYcuentas IS
        SELECT factcodi
        FROM factura, cuencobr
        WHERE factsusc = inuContrato
        and factcodi = cucofact;
        
        nuFactura   factura.factcodi%TYPE;
        
        PROCEDURE prCierraCursor
        IS
        BEGIN
        
            IF cuTienFacturasYcuentas%ISOPEN THEN
                CLOSE cuTienFacturasYcuentas;
            END IF;
        
        END prCierraCursor;
                    
    BEGIN

        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        
        OPEN cuTienFacturasYcuentas;
        FETCH cuTienFacturasYcuentas INTO nuFactura;
        CLOSE cuTienFacturasYcuentas;
        
        IF nuFactura IS NOT NULL THEN
            blTienFacturasYcuentas := TRUE;
        ELSE
            blTienFacturasYcuentas := FALSE;        
        END IF;
        
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
        
        RETURN blTienFacturasYcuentas;
    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sberror: ' || sbError, pkg_traza.cnuNivelTrzDef);
            prCierraCursor;
            pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RETURN blTienFacturasYcuentas;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sberror: ' || sbError, pkg_traza.cnuNivelTrzDef);
            prCierraCursor;
            pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RETURN blTienFacturasYcuentas;
    END fblContratoTieneFacturas;        

	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuObtTipoProduFactura
    Descripcion     : Obtiene el tipo de producto facturable
	
    Autor           : Jhon Erazo - MVM
    Fecha           : 13/05/2025
	
    Parametros de Entrada
		inuFactura	Identificador de la factura
		
    Parametros de Salida
		nuTipoProducto	Tipo Producto Facturable

    Modificaciones  :
    Autor       Fecha       Caso     	Descripcion
	jeerazo		13/06/2025	OSF-4594	1. Se cambia a función y solo retornará el tipo de
											producto facturable.
    jerazomvm   13/05/2025  OSF-4480	Creacion
    ***************************************************************************/
    FUNCTION fnuObtTipoProduFactura(inuFactura IN  factura.factcodi%TYPE)
	RETURN servsusc.sesuserv%TYPE
    IS
	
		csbMT_NAME  	VARCHAR2(70) := csbSP_NAME || 'fnuObtTipoProduFactura';
		
		nuError			NUMBER; 
		nuTipoProducto	servsusc.sesuserv%TYPE;
		sbmensaje		VARCHAR2(1000);  
		
		CURSOR cuTipoproducFacturable
		IS 
			SELECT sesuserv
			FROM servsusc, 
				 factura, 
				 confesco
			WHERE factcodi	= inuFactura
            AND sesususc	= factsusc
            AND coecserv 	= sesuserv
            AND coeccodi 	= sesuesco
            AND coecfact 	= 'S'
            AND sesuserv 	NOT IN (3)
            ORDER BY sesuserv; 
        
    BEGIN
		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);
		
		pkg_traza.trace('inuFactura: ' 	|| inuFactura, cnuNVLTRC);
		
		IF (cuTipoproducFacturable%ISOPEN) THEN
			CLOSE cuTipoproducFacturable;
		END IF;
		
		OPEN cuTipoproducFacturable;
		FETCH cuTipoproducFacturable INTO nuTipoProducto;
		CLOSE cuTipoproducFacturable;
		
		pkg_traza.trace('nuTipoProducto: '	|| nuTipoProducto, cnuNVLTRC);
		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
		
		RETURN nuTipoProducto;

    EXCEPTION
		WHEN pkg_error.CONTROLLED_ERROR THEN
			pkg_error.setError;
			pkg_Error.getError(nuError, sbmensaje);
			pkg_traza.trace('nuError: ' || nuError || ' sbmensaje: ' || sbmensaje, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC); 
			RAISE pkg_error.CONTROLLED_ERROR;
		WHEN others THEN
			pkg_Error.setError;
			pkg_Error.getError(nuError, sbmensaje);
			pkg_traza.trace('nuError: ' || nuError || ' sbmensaje: ' || sbmensaje, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR); 
			RAISE pkg_Error.Controlled_Error;
    END fnuObtTipoProduFactura;


	/**************************************************************************
    <FUNCTION Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> fnuContarCuentasConSaldo </Unidad>
    <Autor> JSOTO</Autor>
    <Fecha> 19-06-2025 </Fecha>
    <Descripcion> 
        Obtiene las cuentas con saldo del producto
    </Descripcion>
	<parametros>
		Entrada: 
			inuProductoId	Identificador del producto.
			
		Salida
			
	</parametros>
    <Historial>
        <Modificacion Autor="jsoto" Fecha="19-06-2025" Inc="OSF-4616" Empresa="GDC">
			Creación
        </Modificacion>
    </Historial>
    </FUNCTION>
    **************************************************************************/
    FUNCTION fnuContarCuentasConSaldo(inuProductoId		IN  pr_product.product_id%type)
	RETURN NUMBER
    IS
	
		csbMT_NAME  		VARCHAR2(70) := csbSP_NAME || 'fnuContarCuentasConSaldo';
		
		nuError				NUMBER;  
		sbmensaje			VARCHAR2(1000);  
		nuCantCuentas		NUMBER;
		
		-- Cursor que retorna las cuentas vencidas del producto
		CURSOR cuCuentasConSaldo
		IS 
		 select /*+ index(cuencobr IX_CUENCOBR03)*/  count(1)
		 from cuencobr c 
		 where c.cuconuse=inuProductoId 
		 and c.cucosacu>0; 
		 
    BEGIN
		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);
		
		pkg_traza.trace('inuProductoId: ' 	|| inuProductoId, cnuNVLTRC);
		
		IF (cuCuentasConSaldo%ISOPEN) THEN
			CLOSE cuCuentasConSaldo;
		END IF;
		
		OPEN cuCuentasConSaldo;
		FETCH cuCuentasConSaldo INTO nuCantCuentas;
		CLOSE cuCuentasConSaldo;
		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
		
		RETURN nuCantCuentas;

    EXCEPTION
		WHEN pkg_error.CONTROLLED_ERROR THEN
			pkg_error.setError;
			pkg_Error.getError(nuError, sbmensaje);
			pkg_traza.trace('nuError: ' || nuError || ' sbmensaje: ' || sbmensaje, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC); 
			RAISE pkg_error.CONTROLLED_ERROR;
		WHEN others THEN
			pkg_Error.setError;
			pkg_Error.getError(nuError, sbmensaje);
			pkg_traza.trace('nuError: ' || nuError || ' sbmensaje: ' || sbmensaje, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR); 
			RAISE pkg_Error.Controlled_Error;
    END fnuContarCuentasConSaldo;


END PKG_BCFACTURACION;
/
PROMPT Otorgando permisos de ejecución para personalizaciones.pkg_bcfacturacion
BEGIN
    pkg_utilidades.prAplicarPermisos('PKG_BCFACTURACION', 'PERSONALIZACIONES');
END;
/