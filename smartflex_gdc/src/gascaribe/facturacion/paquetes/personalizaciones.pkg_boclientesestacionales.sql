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
    <Unidad> prc_valProductoEsGas </Unidad>
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
    PROCEDURE prc_valProductoEsGas(inuProductoId	IN pr_product.product_id%TYPE,
								   osbEsGAs			OUT VARCHAR2
								   );
	
	/**************************************************************************
    <FUNCTION Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> fdt_ObtieneFechaRegistro </Unidad>
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
    FUNCTION fdt_ObtieneFechaRegistro(inuContratoId	IN pr_product.subscription_id%TYPE)
	RETURN DATE;
	
	/**************************************************************************
    <FUNCTION Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> fdt_ObtiFechaIniVigenc </Unidad>
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
    FUNCTION fdt_ObtiFechaIniVigenc(inuContratoId	IN pr_product.subscription_id%TYPE)
	RETURN DATE;
	
	/**************************************************************************
    <FUNCTION Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> fdt_ObtiFechaFinVigenc </Unidad>
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
    FUNCTION fdt_ObtiFechaFinVigenc(inuContratoId	IN pr_product.subscription_id%TYPE)
	RETURN DATE;
	
	/**************************************************************************
    <FUNCTION Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> fsb_ObtieneActivoClieEsta </Unidad>
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
    FUNCTION fsb_ObtieneActivoClieEsta(inuContratoId	IN pr_product.subscription_id%TYPE)
	RETURN VARCHAR2;
	
	/**************************************************************************
    <PROCEDURE Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> prc_updClienteEstacional </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 4-10-2024 </Fecha>
    <Descripcion> 
        Actualiza cliente estacional
    </Descripcion>
	<parametros>
		Entrada: 
			inuContratoId 			Identificador del contrato
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
    PROCEDURE prc_updClienteEstacional(inuContratoId		IN pr_product.subscription_id%TYPE,
									   idtFechinicialVige	IN DATE,
									   idtFechaFinalVig		IN DATE,
									   isbActivo			IN VARCHAR2
									   );	

	/**************************************************************************
    <PROCEDURE Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> prc_validaFechafinalVig </Unidad>
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
			osbCumpleFecha			Flag cumple con la fecha (S/N)
	</parametros>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="4-10-2024" Inc="OSF-3241" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </FUNCTION>
    **************************************************************************/
    PROCEDURE prc_validaFechafinalVig(idtFechaIniVige	IN  DATE,
									  idtFechafinVige	IN  DATE,
									  osbCumpleFecha	OUT VARCHAR2
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
    csbVERSION          CONSTANT VARCHAR2(10) := 'OSF-3241';
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
    <Unidad> prc_valProductoEsGas </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 4-10-2024 </Fecha>
    <Descripcion> 
        Valida si el producto es de gas
    </Descripcion>
	<parametros>
		Entrada: 
			inuProductoId 	Identificador del producto
		
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
    PROCEDURE prc_valProductoEsGas(inuProductoId	IN pr_product.product_id%TYPE,
								   osbEsGAs			OUT VARCHAR2
								   )
    IS
	
		csbMT_NAME  		VARCHAR2(70) := csbSP_NAME || 'prc_valProductoEsGas';
		
		nuError				NUMBER;  
		nuTipoProducto		servsusc.sesuserv%TYPE;
		nutipoGas			NUMBER := 0;
		sbmensaje			VARCHAR2(1000);  
        
    BEGIN
		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbInicio);
		
		pkg_traza.trace('inuProductoId: ' || inuProductoId, cnuNVLTRC);
		
		osbEsGAs := 'Y';
		
		nuTipoProducto	:= PKG_BCPRODUCTO.FNUTIPOPRODUCTO(inuProductoId);
		
		pkg_traza.trace('nuTipoProducto: ' || nuTipoProducto, cnuNVLTRC);
		
		-- Si el tipo de producto es diferente de ga
		IF (nuTipoProducto <> 7014) THEN
			pkg_traza.trace('El producto: ' || inuProductoId || 'es diferente a gas', cnuNVLTRC);
			osbEsGAs := 'N';
			
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
    END prc_valProductoEsGas;
	
	/**************************************************************************
    <FUNCTION Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> fdt_ObtieneFechaRegistro </Unidad>
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
    FUNCTION fdt_ObtieneFechaRegistro
    (
        inuContratoId	IN pr_product.subscription_id%TYPE
    )
	RETURN DATE
    IS
	
		csbMT_NAME  		VARCHAR2(70) := csbSP_NAME || 'fdt_ObtieneFechaRegistro';
		
		nuError				NUMBER;  
		dtFechadeRegistro	DATE := NULL;
		sbmensaje			VARCHAR2(1000);  
        
    BEGIN
		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbInicio);
		
		pkg_traza.trace('inuContratoId: ' || inuContratoId, cnuNVLTRC);
		
		dtFechadeRegistro := pkg_clienteestacional.fdtObtFECHA_REGISTRO(inuContratoId);
		
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
    END fdt_ObtieneFechaRegistro;
	
	/**************************************************************************
    <FUNCTION Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> fdt_ObtiFechaIniVigenc </Unidad>
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
    FUNCTION fdt_ObtiFechaIniVigenc
    (
        inuContratoId	IN pr_product.subscription_id%TYPE
    )
	RETURN DATE
    IS
	
		csbMT_NAME  		VARCHAR2(70) := csbSP_NAME || 'fdt_ObtiFechaIniVigenc';
		
		nuError				NUMBER;  
		dtFechaIniVigencia	DATE := NULL;
		sbmensaje			VARCHAR2(1000);   
        
    BEGIN
		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbInicio);
		
		pkg_traza.trace('inuContratoId: ' || inuContratoId, cnuNVLTRC);
		
		dtFechaIniVigencia := pkg_clienteestacional.fdtObtFECHA_INICIAL_VIGENCIA(inuContratoId);
		
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
    END fdt_ObtiFechaIniVigenc;
	
	/**************************************************************************
    <FUNCTION Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> fdt_ObtiFechaFinVigenc </Unidad>
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
    FUNCTION fdt_ObtiFechaFinVigenc
    (
        inuContratoId	IN pr_product.subscription_id%TYPE
    )
	RETURN DATE
    IS
	
		csbMT_NAME  		VARCHAR2(70) := csbSP_NAME || 'fdt_ObtiFechaFinVigenc';
		
		nuError				NUMBER;  
		dtFechaFinVigencia	DATE := NULL;
		sbmensaje			VARCHAR2(1000);

    BEGIN
		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbInicio);
		
		pkg_traza.trace('inuContratoId: ' || inuContratoId, cnuNVLTRC);
		
		dtFechaFinVigencia := pkg_clienteestacional.fdtObtFECHA_FINAL_VIGENCIA(inuContratoId);
		
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
    END fdt_ObtiFechaFinVigenc;
	
	/**************************************************************************
    <FUNCTION Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> fsb_ObtieneActivoClieEsta </Unidad>
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
    FUNCTION fsb_ObtieneActivoClieEsta
    (
        inuContratoId	IN pr_product.subscription_id%TYPE
    )
	RETURN VARCHAR2
    IS
	
		csbMT_NAME  		VARCHAR2(70) := csbSP_NAME || 'fsb_ObtieneActivoClieEsta';
		
		nuError				NUMBER;  
		sbClienteActivo		DATE := NULL;
		sbmensaje			VARCHAR2(1000);     
        
    BEGIN
		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbInicio);
		
		pkg_traza.trace('inuContratoId: ' || inuContratoId, cnuNVLTRC);
		
		sbClienteActivo := pkg_clienteestacional.fsbObtACTIVO(inuContratoId);
		
		pkg_traza.trace('sbClienteActivo: ' || sbClienteActivo, cnuNVLTRC);
        
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
		
		RETURN sbClienteActivo;

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
    END fsb_ObtieneActivoClieEsta;
	
	/**************************************************************************
    <PROCEDURE Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> prc_updClienteEstacional </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 4-10-2024 </Fecha>
    <Descripcion> 
        Actualiza cliente estacional
    </Descripcion>
	<parametros>
		Entrada: 
			inuContratoId 			Identificador del contrato
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
    PROCEDURE prc_updClienteEstacional(inuContratoId		IN pr_product.subscription_id%TYPE,
									   idtFechinicialVige	IN DATE,
									   idtFechaFinalVig		IN DATE,
									   isbActivo			IN VARCHAR2
									   )
    IS
	
		csbMT_NAME  		VARCHAR2(70) := csbSP_NAME || 'prc_updClienteEstacional';
		
		nuError					NUMBER;  
		nuProduct_id			pr_product.product_id%TYPE;
		nurowid             	ROWID;
		sbmensaje				VARCHAR2(1000);  
		rcClienteEstacional		clientes_estacionales%ROWTYPE;
        
    BEGIN
		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbInicio);
		
		pkg_traza.trace('inuContratoId: ' 		|| inuContratoId || CHR(10) ||
						'idtFechinicialVige : ' || idtFechinicialVige || CHR(10) ||
						'idtFechaFinalVig : ' 	|| idtFechaFinalVig || CHR(10) ||
						'isbActivo : ' 			|| isbActivo, cnuNVLTRC);
		
		-- si cliente existe
		IF (pkg_clienteestacional.fblExiste(inuContratoId)) THEN
		
			-- Actualiza la fecha inicial de vigencia
			pkg_clienteestacional.prAcFECHA_INICIAL_VIGENCIA(inuContratoId,
															 to_date(idtFechinicialVige)
															 );
																	
			-- Actualiza la fecha final de vigencia
			pkg_clienteestacional.prAcFECHA_FINAL_VIGENCIA(inuContratoId,
														   to_date(idtFechaFinalVig)
														   );
																
			-- Actualiza si el cliente estacional esta activo
			pkg_clienteestacional.prAcACTIVO(inuContratoId,
											 isbActivo
											 );		

		ELSE
			-- Obtiene el producto 
			PRC_OBTIENEVALORINSTANCIA('WORK_INSTANCE',
									  NULL,
									  'PR_PRODUCT',
									  'PRODUCT_ID',
									  nuProduct_id
									  );
									  
			pkg_traza.trace('nuProduct_id: ' || nuProduct_id, cnuNVLTRC);
			
			-- Llena el resgitro de cliente estacional           
            rcClienteEstacional.CONTRATO 				:= inuContratoId; 
            rcClienteEstacional.PRODUCTO 				:= nuProduct_id; 
            rcClienteEstacional.FECHA_REGISTRO 			:= LDC_BOCONSGENERALES.FDTGETSYSDATE; 
            rcClienteEstacional.FECHA_INICIAL_VIGENCIA 	:= idtFechinicialVige;
            rcClienteEstacional.FECHA_FINAL_VIGENCIA 	:= idtFechaFinalVig;
			rcClienteEstacional.ACTIVO 					:= isbActivo;
			
			-- Inserta el cliente estacional
			pkg_clienteestacional.prInsRegistro(rcClienteEstacional,
												nurowid);
			
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
    END prc_updClienteEstacional;
	
	/**************************************************************************
    <PROCEDURE Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> prc_validaFechafinalVig </Unidad>
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
			osbCumpleFecha			Flag cumple con la fecha (S/N)
	</parametros>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="4-10-2024" Inc="OSF-3241" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </FUNCTION>
    **************************************************************************/
    PROCEDURE prc_validaFechafinalVig(idtFechaIniVige	IN  DATE,
									  idtFechafinVige	IN  DATE,
									  osbCumpleFecha	OUT VARCHAR2
									  )
    IS
	
		csbMT_NAME  		VARCHAR2(70) := csbSP_NAME || 'prc_validaFechafinalVig';
		
		nuError				NUMBER;  
		sbmensaje			VARCHAR2(1000);  
        
    BEGIN
		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbInicio);
		
		pkg_traza.trace('idtFechaIniVige : ' 	|| idtFechaIniVige 	|| CHR(10) ||
						'idtFechafinVige : ' 	|| idtFechafinVige, cnuNVLTRC);
		
		osbCumpleFecha := 'Y';
		
			
		-- Si fecha inicial de vigencia es menor a la de registro
		IF (idtFechafinVige < idtFechaIniVige) THEN
			osbCumpleFecha := 'N';
		END IF;
		
		pkg_traza.trace('La fecha inicial de vigencia cumple: ' || osbCumpleFecha, cnuNVLTRC);
        
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
    END prc_validaFechafinalVig;
	
END PKG_BOCLIENTESESTACIONALES;
/
BEGIN
pkg_utilidades.prAplicarPermisos(upper('PKG_BOCLIENTESESTACIONALES'),'PERSONALIZACIONES'); 
END;
/