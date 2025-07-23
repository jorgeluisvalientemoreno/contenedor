CREATE OR REPLACE PACKAGE PERSONALIZACIONES.PKG_BOCLIENTESESTACIONALES
IS
    /******************************************************************
    <Package Fuente="Propiedad Intelectual de GDC">
    <Unidad> PKG_BOCLIENTESESTACIONALES </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 4-10-2024 </Fecha>
    <Descripcion> 
        Logica clientes estacionales
    </Descripcion>
    <Historial>
		<Modificacion Autor="Jhon.Erazo" Fecha="06-12-2024" Inc="OSF-3713" Empresa="GDC">
			1. Se modifican los procedimientos 
				- fdtObtieneFechaRegistro
				- fdtObtiFechaIniVigenc
				- fdtObtiFechaFinVigenc
				- prcvalidaFechafinalVig
				- prcActClienteEstacional
				- prcvalProductoEsGas
			2. Se elimina el procedimiento fsb_ObtieneActivoClieEsta
        </Modificacion>
        <Modificacion Autor="Jhon.Erazo" Fecha="4-10-2024" Inc="OSF-3241" Empresa="GDC">
			Creación
        </Modificacion>
     </Historial>
     </Package>
    ******************************************************************/

    --------------------------------------------
    -- Funciones y Procedimientos
    --------------------------------------------


    /**************************************************************************
    <FUNCTION Fuente="Propiedad Intelectual de GDC">
    <Unidad> fsbVersion </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 4-10-2024 </Fecha>
    <Descripcion> 
        Obtiene la version del paquete.
    </Descripcion>
    <Retorno Nombre="Versión del paquete" Tipo="VARCHAR2">
        Versión del paquete
    </Retorno>
    <Historial>
            <Modificacion Autor="Jhon.Erazo" Fecha="4-10-2024" Inc="OSF-3241" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </FUNCTION>
    **************************************************************************/
    FUNCTION fsbVersion
    RETURN VARCHAR2;
	
	/**************************************************************************
    <FUNCTION Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> prcvalProductoEsGas </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 4-10-2024 </Fecha>
    <Descripcion> 
        Valida si el producto es de gas
    </Descripcion>
	<parametros>
		Entrada: 
			inuProductoId Identificador del producto
		
		Salida:
			osbEsGAs		Valida si el producto es gas(Y/N)
	</parametros>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="4-10-2024" Inc="OSF-3241" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </FUNCTION>
    **************************************************************************/
    PROCEDURE prcvalProductoEsGas(inuProductoId	IN pr_product.product_id%TYPE);
	
	/**************************************************************************
    <FUNCTION Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> fdtObtieneFechaRegistro </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 9-10-2024 </Fecha>
    <Descripcion> 
        Retorna la fecha de registro
    </Descripcion>
	<parametros>
		Entrada: 
			inuContratoId Identificador del contrato
		
		Salida:
	</parametros>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="4-10-2024" Inc="OSF-3241" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </FUNCTION>
    **************************************************************************/
    FUNCTION fdtObtieneFechaRegistro(inuContratoId	IN pr_product.subscription_id%TYPE)
	RETURN DATE;
	
	/**************************************************************************
    <FUNCTION Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> fdtObtiFechaIniVigenc </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 9-10-2024 </Fecha>
    <Descripcion> 
        Retorna la fecha inicial de vigencia
    </Descripcion>
	<parametros>
		Entrada: 
			inuContratoId Identificador del contrato
		
		Salida:
	</parametros>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="4-10-2024" Inc="OSF-3241" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </FUNCTION>
    **************************************************************************/
    FUNCTION fdtObtiFechaIniVigenc(inuContratoId	IN pr_product.subscription_id%TYPE)
	RETURN DATE;
	
	/**************************************************************************
    <FUNCTION Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> fdtObtiFechaFinVigenc </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 9-10-2024 </Fecha>
    <Descripcion> 
        Retorna la fecha final de vigencia
    </Descripcion>
	<parametros>
		Entrada: 
			inuContratoId Identificador del contrato
		
		Salida:
	</parametros>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="4-10-2024" Inc="OSF-3241" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </FUNCTION>
    **************************************************************************/
    FUNCTION fdtObtiFechaFinVigenc(inuContratoId	IN pr_product.subscription_id%TYPE)
	RETURN DATE;
	
	/**************************************************************************
    <PROCEDURE Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> prcActClienteEstacional </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 4-10-2024 </Fecha>
    <Descripcion> 
        Actualiza cliente estacional
    </Descripcion>
	<parametros>
		Entrada: 
			inuContratoId 			Identificador del contrato
			inuContratoId 			Identificador del producto
			idtFechinicialVige		Fecha inicial de vigencia
			idtFechaFinalVig		Fecha final de vigencia
			isbActivo				Flag activo (S/N)
			
		Salida:
	</parametros>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="4-10-2024" Inc="OSF-3241" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </FUNCTION>
    **************************************************************************/
    PROCEDURE prcActClienteEstacional(inuContratoId			IN pr_product.subscription_id%TYPE,
									  inuProductoId			IN pr_product.product_id%TYPE,
									  idtFechinicialVige	IN DATE,
									  idtFechaFinalVig		IN DATE,
									  isbActivo				IN VARCHAR2
									  );	

	/**************************************************************************
    <PROCEDURE Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> prcvalidaFechafinalVig </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 4-10-2024 </Fecha>
    <Descripcion> 
        Valida la fecha final de vigencia
    </Descripcion>
	<parametros>
		Entrada: 
			idtFechaIniVige			Fecha inicial de vigencia
			idtFechafinVige			Fecha final de vigencia
			
		Salida:
		
	</parametros>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="4-10-2024" Inc="OSF-3241" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </FUNCTION>
    **************************************************************************/
    PROCEDURE prcvalidaFechafinalVig(idtFechaIniVige	IN  DATE,
									  idtFechafinVige	IN  DATE
									  );											
	
END PKG_BOCLIENTESESTACIONALES;
/
CREATE OR REPLACE PACKAGE BODY PERSONALIZACIONES.PKG_BOCLIENTESESTACIONALES
IS
    /******************************************************************
    <Package Fuente="Propiedad Intelectual de GDC">
    <Unidad> PKG_BOCLIENTESESTACIONALES </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 4-10-2024 </Fecha>
    <Descripcion> 
        Logica clientes estacionales
    </Descripcion>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="4-10-2024" Inc="OSF-3241" Empresa="GDC">
               Creación
           </Modificacion>
     </Historial>
     </Package>
    ******************************************************************/

    --------------------------------------------
    -- Constantes 
    --------------------------------------------
    csbVERSION          CONSTANT VARCHAR2(10) := 'OSF-3713';
    csbSP_NAME          CONSTANT VARCHAR2(100):= $$PLSQL_UNIT||'.';
    cnuNVLTRC           CONSTANT NUMBER       := pkg_traza.cnuNivelTrzDef;
	csbInicio   		CONSTANT VARCHAR2(35) := pkg_traza.fsbINICIO;
    
    -----------------------------------
    -- Variables privadas del package
    -----------------------------------
	
    --------------------------------------------
    -- Funciones y Procedimientos
    --------------------------------------------

    /**************************************************************************
    <FUNCTION Fuente="Propiedad Intelectual de GDC">
    <Unidad> fsbVersion </Unidad>
    <Autor> Jhon.Erazo </Autor>
    <Fecha> 4-10-2024 </Fecha>
    <Descripcion> 
        Obtiene la version del paquete.
    </Descripcion>
    <Retorno Nombre="Versión del paquete" Tipo="VARCHAR2">
        Versión del paquete
    </Retorno>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="4-10-2024" Inc="OSF-3241" Empresa="GDC"> 
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
    <FUNCTION Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> prcvalProductoEsGas </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 4-10-2024 </Fecha>
    <Descripcion> 
        Valida si el producto es de gas
    </Descripcion>
	<parametros>
		Entrada: 
			inuProductoId 	Identificador del producto
		
		Salida:
		
	</parametros>
    <Historial>
		<Modificacion Autor="Jhon.Erazo" Fecha="12-12-2024" Inc="OSF-3713" Empresa="GDC">
			1. Se elimina el parametro de salida osbEsGAs
			2. Si el producto es diferente de gas, hace raise de error			
        </Modificacion>
        <Modificacion Autor="Jhon.Erazo" Fecha="4-10-2024" Inc="OSF-3241" Empresa="GDC">
			Creación
        </Modificacion>
    </Historial>
    </FUNCTION>
    **************************************************************************/
    PROCEDURE prcvalProductoEsGas(inuProductoId	IN pr_product.product_id%TYPE)
    IS
	
		csbMT_NAME  		VARCHAR2(70) := csbSP_NAME || 'prcvalProductoEsGas';
		
		nuError				NUMBER;  
		nuTipoProducto		servsusc.sesuserv%TYPE;
		nutipoGas			NUMBER := 0;
		sbmensaje			VARCHAR2(1000);  
        
    BEGIN
		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbInicio);
		
		pkg_traza.trace('inuProductoId: ' || inuProductoId, cnuNVLTRC);
		
		-- Obtiene el tipo de producto
		nuTipoProducto	:= PKG_BCPRODUCTO.FNUTIPOPRODUCTO(inuProductoId);		
		pkg_traza.trace('nuTipoProducto: ' || nuTipoProducto, cnuNVLTRC);
		
		-- Si el tipo de producto es diferente de ga
		IF (nuTipoProducto <> 7014) THEN
			pkg_traza.trace('El producto: ' || inuProductoId || 'es diferente a gas', cnuNVLTRC);
			
			pkg_Error.setErrorMessage(2741, 'El tramite solo se puede ejecutar sobre productos de tipo Gas.');
			
		END IF;
        
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
    END prcvalProductoEsGas;
	
	/**************************************************************************
    <FUNCTION Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> fdtObtieneFechaRegistro </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 9-10-2024 </Fecha>
    <Descripcion> 
        Retorna la fecha de registro
    </Descripcion>
	<parametros>
		Entrada: 
			inuContratoId Identificador del contrato
		
		Salida:
	</parametros>
    <Historial>
		<Modificacion Autor="Jhon.Erazo" Fecha="11-12-2024" Inc="OSF-3713" Empresa="GDC">
			1. Se ajusta para que valide si el contrato existe y esta activo retorne la fecha de registro
				de lo contrario, retorna la fecha del sistema.
        </Modificacion>
        <Modificacion Autor="Jhon.Erazo" Fecha="4-10-2024" Inc="OSF-3241" Empresa="GDC">
			Creación
        </Modificacion>
    </Historial>
    </FUNCTION>
    **************************************************************************/
    FUNCTION fdtObtieneFechaRegistro
    (
        inuContratoId	IN pr_product.subscription_id%TYPE
    )
	RETURN DATE
    IS
	
		csbMT_NAME  		VARCHAR2(70) := csbSP_NAME || 'fdtObtieneFechaRegistro';
		
		nuError				NUMBER;  
		dtFechadeRegistro	DATE := NULL;
		sbmensaje			VARCHAR2(1000);  
        
    BEGIN
		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbInicio);
		
		pkg_traza.trace('inuContratoId: ' || inuContratoId, cnuNVLTRC);
		
		-- Si el contrato existe y esta activo
		IF (pkg_clientes_estacionales.fblExiste(inuContratoId) AND pkg_clientes_estacionales.fsbObtACTIVO(inuContratoId) = 'Y') THEN
			
			-- Obtiene la fecha de registro
			dtFechadeRegistro := pkg_clientes_estacionales.fdtObtFECHA_REGISTRO(inuContratoId);
		ELSE
			-- Obtiene la fecha del sistema
			dtFechadeRegistro := LDC_BOCONSGENERALES.FDTGETSYSDATE;
		END IF;		
		
		pkg_traza.trace('dtFechadeRegistro: ' || dtFechadeRegistro, cnuNVLTRC);
        
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
		
		RETURN dtFechadeRegistro;

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
    END fdtObtieneFechaRegistro;
	
	/**************************************************************************
    <FUNCTION Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> fdtObtiFechaIniVigenc </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 9-10-2024 </Fecha>
    <Descripcion> 
        Retorna la fecha inicial de vigencia
    </Descripcion>
	<parametros>
		Entrada: 
			inuContratoId Identificador del contrato
		
		Salida:
	</parametros>
    <Historial>
		<Modificacion Autor="Jhon.Erazo" Fecha="11-12-2024" Inc="OSF-3713" Empresa="GDC">
			1. Se ajusta para que valide si el contrato existe y está activo retorne la fecha inicial de vigencia
				de lo contrario, retorna la fecha del sistema.
        </Modificacion>
        <Modificacion Autor="Jhon.Erazo" Fecha="4-10-2024" Inc="OSF-3241" Empresa="GDC">
			Creación
        </Modificacion>
    </Historial>
    </FUNCTION>
    **************************************************************************/
    FUNCTION fdtObtiFechaIniVigenc
    (
        inuContratoId	IN pr_product.subscription_id%TYPE
    )
	RETURN DATE
    IS
	
		csbMT_NAME  		VARCHAR2(70) := csbSP_NAME || 'fdtObtiFechaIniVigenc';
		
		nuError				NUMBER;  
		dtFechaIniVigencia	DATE := NULL;
		sbmensaje			VARCHAR2(1000);   
        
    BEGIN
		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbInicio);
		
		pkg_traza.trace('inuContratoId: ' || inuContratoId, cnuNVLTRC);
		
		-- Si el contrato existe y esta activo
		IF (pkg_clientes_estacionales.fblExiste(inuContratoId) AND pkg_clientes_estacionales.fsbObtACTIVO(inuContratoId) = 'Y') THEN
			
			-- Obtiene la fecha inicial de vigencia
			dtFechaIniVigencia := pkg_clientes_estacionales.fdtObtFECHA_INICIAL_VIGENCIA(inuContratoId);
		ELSE
			-- Obtiene la fecha del sistema
			dtFechaIniVigencia := LDC_BOCONSGENERALES.FDTGETSYSDATE;
		END IF;			
		
		pkg_traza.trace('dtFechaIniVigencia: ' || dtFechaIniVigencia, cnuNVLTRC);
        
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
		
		RETURN dtFechaIniVigencia;

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
    END fdtObtiFechaIniVigenc;
	
	/**************************************************************************
    <FUNCTION Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> fdtObtiFechaFinVigenc </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 9-10-2024 </Fecha>
    <Descripcion> 
        Retorna la fecha final de vigencia
    </Descripcion>
	<parametros>
		Entrada: 
			inuContratoId Identificador del contrato
		
		Salida:
	</parametros>
    <Historial>
		<Modificacion Autor="Jhon.Erazo" Fecha="11-12-2024" Inc="OSF-3713" Empresa="GDC">
			1. Se ajusta para que valide si el contrato existe y esta activo retorne la fecha final de vigencia
				de lo contrario, retorna la fecha maxima de oracle.
        </Modificacion>
           <Modificacion Autor="Jhon.Erazo" Fecha="4-10-2024" Inc="OSF-3241" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </FUNCTION>
    **************************************************************************/
    FUNCTION fdtObtiFechaFinVigenc
    (
        inuContratoId	IN pr_product.subscription_id%TYPE
    )
	RETURN DATE
    IS
	
		csbMT_NAME  		VARCHAR2(70) := csbSP_NAME || 'fdtObtiFechaFinVigenc';
		
		nuError				NUMBER;  
		dtFechaFinVigencia	DATE := NULL;
		sbmensaje			VARCHAR2(1000);

    BEGIN
		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbInicio);
		
		pkg_traza.trace('inuContratoId: ' || inuContratoId, cnuNVLTRC);
		
		-- Si el contrato existe y esta activo
		IF (pkg_clientes_estacionales.fblExiste(inuContratoId) AND pkg_clientes_estacionales.fsbObtACTIVO(inuContratoId) = 'Y') THEN
			
			-- Obtiene la fecha final de vigencia
			dtFechaFinVigencia := pkg_clientes_estacionales.fdtObtFECHA_FINAL_VIGENCIA(inuContratoId);
		ELSE
			-- Obtiene la fecha maxima de oracle
			dtFechaFinVigencia := LDC_BOCONSGENERALES.fdtGetMaxDate;
		END IF;	
		
		pkg_traza.trace('dtFechaFinVigencia: ' || dtFechaFinVigencia, cnuNVLTRC);
        
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
		
		RETURN dtFechaFinVigencia;

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
    END fdtObtiFechaFinVigenc;
	
	/**************************************************************************
    <PROCEDURE Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> prcActClienteEstacional </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 4-10-2024 </Fecha>
    <Descripcion> 
        Actualiza cliente estacional
    </Descripcion>
	<parametros>
		Entrada: 
			inuContratoId 			Identificador del contrato
			inuProductoId			Identificador del producto
			idtFechinicialVige		Fecha inicial de vigencia
			idtFechaFinalVig		Fecha final de vigencia
			isbActivo				Flag activo (S/N)
			
		Salida:
	</parametros>
    <Historial>
		<Modificacion Autor="Jhon.Erazo" Fecha="12-12-2024" Inc="OSF-3713" Empresa="GDC">
			1. Se agrega validación para que actualice si el cliente existe y esta activo
			2. Si se va desactivar el cliente, se inserta la fecha de inactivación
			3. Se agrega el parametro de entrada inuProductoId
        </Modificacion>
        <Modificacion Autor="Jhon.Erazo" Fecha="4-10-2024" Inc="OSF-3241" Empresa="GDC">
			Creación
        </Modificacion>
    </Historial>
    </FUNCTION>
    **************************************************************************/
    PROCEDURE prcActClienteEstacional(inuContratoId			IN pr_product.subscription_id%TYPE,
									  inuProductoId			IN pr_product.product_id%TYPE,
									  idtFechinicialVige	IN DATE,
									  idtFechaFinalVig		IN DATE,
									  isbActivo				IN VARCHAR2
									  )
    IS
	
		csbMT_NAME  		VARCHAR2(70) := csbSP_NAME || 'prcActClienteEstacional';
		
		cdtFechaSistema		DATE := LDC_BOCONSGENERALES.FDTGETSYSDATE;
		
		nuError					NUMBER;  
		nurowid             	ROWID;
		sbmensaje				VARCHAR2(1000);  
		rcClienteEstacional		clientes_estacionales%ROWTYPE;
        
    BEGIN
		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbInicio);
		
		pkg_traza.trace('inuContratoId: ' 		|| inuContratoId 		|| CHR(10) ||
						'inuProductoId : ' 		|| inuProductoId 		|| CHR(10) ||
						'idtFechinicialVige : ' || idtFechinicialVige 	|| CHR(10) ||
						'idtFechaFinalVig : ' 	|| idtFechaFinalVig 	|| CHR(10) ||
						'isbActivo : ' 			|| isbActivo, cnuNVLTRC);
		
		-- si cliente existe y si el cliente esta activo
		IF (pkg_clientes_estacionales.fblExiste(inuContratoId) AND pkg_clientes_estacionales.fsbObtACTIVO(inuContratoId) = 'Y') THEN
		
			-- Actualiza la fecha inicial de vigencia
			pkg_clientes_estacionales.prAcFECHA_INICIAL_VIGENCIA(inuContratoId,
															 to_date(idtFechinicialVige)
															 );
																	
			-- Actualiza la fecha final de vigencia
			pkg_clientes_estacionales.prAcFECHA_FINAL_VIGENCIA(inuContratoId,
														   to_date(idtFechaFinalVig)
														   );
																
			-- Si se desactiva el cliente
			IF (isbActivo = 'N') THEN
				-- se ingresa fecha de inactivación
				pkg_clientes_estacionales.prcActFechaInactivacion(inuContratoId,
															  cdtFechaSistema
															  );
															  
				-- Actualiza si el cliente estacional esta activo
				pkg_clientes_estacionales.prAcACTIVO(inuContratoId,
												 isbActivo
												 );
			END IF;

		ELSE
			
			-- Llena el resgitro de cliente estacional           
            rcClienteEstacional.CONTRATO 				:= inuContratoId; 
            rcClienteEstacional.PRODUCTO 				:= inuProductoId; 
            rcClienteEstacional.FECHA_REGISTRO 			:= cdtFechaSistema; 
            rcClienteEstacional.FECHA_INICIAL_VIGENCIA 	:= idtFechinicialVige;
            rcClienteEstacional.FECHA_FINAL_VIGENCIA 	:= idtFechaFinalVig;
			rcClienteEstacional.ACTIVO 					:= isbActivo;
			rcClienteEstacional.FECHA_INACTIVACION		:= NULL;
			
			-- Inserta el cliente estacional
			pkg_clientes_estacionales.prInsRegistro(rcClienteEstacional,
													nurowid
													);
			
		END IF;
        
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
    END prcActClienteEstacional;
	
	/**************************************************************************
    <PROCEDURE Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> prcvalidaFechafinalVig </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 4-10-2024 </Fecha>
    <Descripcion> 
        Valida la fecha final de vigencia
    </Descripcion>
	<parametros>
		Entrada: 
			idtFechaIniVige			Fecha inicial de vigencia
			idtFechafinVige			Fecha final de vigencia
			
		Salida:
		
	</parametros>
    <Historial>
		<Modificacion Autor="Jhon.Erazo" Fecha="06-12-2024" Inc="OSF-3713" Empresa="GDC">
			1. Se elimina el parametro de salida osbCumpleFecha
			2. Se agrega validacion de que la fecha final de vigencia 
			   no sea menor a la del sistema.
        </Modificacion>
        <Modificacion Autor="Jhon.Erazo" Fecha="4-10-2024" Inc="OSF-3241" Empresa="GDC">
			Creación
        </Modificacion>
    </Historial>
    </FUNCTION>
    **************************************************************************/
    PROCEDURE prcvalidaFechafinalVig(idtFechaIniVige	IN  DATE,
									  idtFechafinVige	IN  DATE
									  )
    IS
	
		csbMT_NAME  		VARCHAR2(70) := csbSP_NAME || 'prcvalidaFechafinalVig';
		
		nuError				NUMBER;  
		sbmensaje			VARCHAR2(1000);  
        
    BEGIN
		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbInicio);
		
		pkg_traza.trace('idtFechaIniVige : ' 	|| idtFechaIniVige 	|| CHR(10) ||
						'idtFechafinVige : ' 	|| idtFechafinVige, cnuNVLTRC);
		
			
		-- Si fecha inicial de vigencia es menor a la de registro
		IF (idtFechafinVige < idtFechaIniVige OR idtFechafinVige < TRUNC(LDC_BOCONSGENERALES.FDTGETSYSDATE)) THEN
			
			pkg_traza.trace('La fecha inicial de vigencia no cumple', cnuNVLTRC);
			
			pkg_Error.setErrorMessage(2741, 'La fecha final de vigencia no puede ser menor a la fecha actual o a la fecha inicial de vigencia');
		END IF;
		
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
    END prcvalidaFechafinalVig;
	
END PKG_BOCLIENTESESTACIONALES;
/
BEGIN
pkg_utilidades.prAplicarPermisos(upper('PKG_BOCLIENTESESTACIONALES'),'PERSONALIZACIONES'); 
END;
/