CREATE OR REPLACE PACKAGE PKG_CLIENTESESTACIONALES
IS
    /******************************************************************
    <Package Fuente="Propiedad Intelectual de GDC">
    <Unidad> PKG_CLIENTESESTACIONALES </Unidad>
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
    <Unidad> prc_ObtieneFechaRegistro </Unidad>
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
    FUNCTION prc_ObtieneFechaRegistro(inuContratoId	IN pr_product.subscription_id%TYPE)
	RETURN DATE;
	
	/**************************************************************************
    <FUNCTION Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> prc_ObtiFechaIniVigenc </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 9-10-2024 </Fecha>
    <Descripcion> 
        Retorna la fecha inicial de vigencia
    </Descripcion>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="4-10-2024" Inc="OSF-3241" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </FUNCTION>
    **************************************************************************/
    FUNCTION prc_ObtiFechaIniVigenc(inuContratoId	IN pr_product.subscription_id%TYPE)
	RETURN DATE;
	
	/**************************************************************************
    <FUNCTION Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> prc_ObtiFechaFinVigenc </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 9-10-2024 </Fecha>
    <Descripcion> 
        Retorna la fecha final de vigencia
    </Descripcion>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="4-10-2024" Inc="OSF-3241" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </FUNCTION>
    **************************************************************************/
    FUNCTION prc_ObtiFechaFinVigenc(inuContratoId	IN pr_product.subscription_id%TYPE)
	RETURN DATE;
	
	/**************************************************************************
    <FUNCTION Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> prc_ObtieneActivoClieEsta </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 9-10-2024 </Fecha>
    <Descripcion> 
        Retorna la fecha final de vigencia
    </Descripcion>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="4-10-2024" Inc="OSF-3241" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </FUNCTION>
    **************************************************************************/
    FUNCTION prc_ObtieneActivoClieEsta
    (
        inuContratoId	IN pr_product.subscription_id%TYPE
    )
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
	
END PKG_CLIENTESESTACIONALES;
/
CREATE OR REPLACE PACKAGE BODY PKG_CLIENTESESTACIONALES
IS
    /******************************************************************
    <Package Fuente="Propiedad Intelectual de GDC">
    <Unidad> PKG_CLIENTESESTACIONALES </Unidad>
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
								   )
    IS
	
		csbMT_NAME  		VARCHAR2(70) := csbSP_NAME || 'prc_valProductoEsGas';
		
		nuError				NUMBER;  
		sbmensaje			VARCHAR2(1000);  
        
    BEGIN
		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbInicio);
		
		pkg_traza.trace('inuProductoId: ' || inuProductoId, cnuNVLTRC);
		
		pkg_boclientesestacionales.prc_valProductoEsGas(inuProductoId,
														osbEsGAs
														);
		
		pkg_traza.trace('El producto es gas: ' || osbEsGAs, cnuNVLTRC);
        
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
    <Unidad> prc_ObtieneFechaRegistro </Unidad>
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
    FUNCTION prc_ObtieneFechaRegistro
    (
        inuContratoId	IN pr_product.subscription_id%TYPE
    )
	RETURN DATE
    IS
	
		csbMT_NAME  		VARCHAR2(70) := csbSP_NAME || 'prc_ObtieneFechaRegistro';
		
		nuError				NUMBER;  
		dtFechadeRegistro	DATE := NULL;
		sbmensaje			VARCHAR2(1000);  
        
    BEGIN
		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbInicio);
		
		pkg_traza.trace('inuContratoId: ' || inuContratoId, cnuNVLTRC);
		
		dtFechadeRegistro := pkg_boclientesestacionales.fdt_ObtieneFechaRegistro(inuContratoId);
		
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
    END prc_ObtieneFechaRegistro;
	
	/**************************************************************************
    <FUNCTION Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> prc_ObtiFechaIniVigenc </Unidad>
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
    FUNCTION prc_ObtiFechaIniVigenc
    (
        inuContratoId	IN pr_product.subscription_id%TYPE
    )
	RETURN DATE
    IS
	
		csbMT_NAME  		VARCHAR2(70) := csbSP_NAME || 'prc_ObtiFechaIniVigenc';
		
		nuError				NUMBER;  
		dtFechaIniVigencia	DATE := NULL;
		sbmensaje			VARCHAR2(1000);   
        
    BEGIN
		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbInicio);
		
		pkg_traza.trace('inuContratoId: ' || inuContratoId, cnuNVLTRC);
		
		dtFechaIniVigencia := pkg_boclientesestacionales.fdt_ObtiFechaIniVigenc(inuContratoId);
		
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
    END prc_ObtiFechaIniVigenc;
	
	/**************************************************************************
    <FUNCTION Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> prc_ObtiFechaFinVigenc </Unidad>
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
    FUNCTION prc_ObtiFechaFinVigenc
    (
        inuContratoId	IN pr_product.subscription_id%TYPE
    )
	RETURN DATE
    IS
	
		csbMT_NAME  		VARCHAR2(70) := csbSP_NAME || 'prc_ObtiFechaFinVigenc';
		
		nuError				NUMBER;  
		dtFechaFinVigencia	DATE := NULL;
		sbmensaje			VARCHAR2(1000);

    BEGIN
		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbInicio);
		
		pkg_traza.trace('inuContratoId: ' || inuContratoId, cnuNVLTRC);
		
		dtFechaFinVigencia := pkg_boclientesestacionales.fdt_ObtiFechaFinVigenc(inuContratoId);
		
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
    END prc_ObtiFechaFinVigenc;
	
	/**************************************************************************
    <FUNCTION Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> prc_ObtieneActivoClieEsta </Unidad>
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
    FUNCTION prc_ObtieneActivoClieEsta
    (
        inuContratoId	IN pr_product.subscription_id%TYPE
    )
	RETURN VARCHAR2
    IS
	
		csbMT_NAME  		VARCHAR2(70) := csbSP_NAME || 'prc_ObtieneActivoClieEsta';
		
		nuError				NUMBER;  
		sbClienteActivo		DATE := NULL;
		sbmensaje			VARCHAR2(1000);     
        
    BEGIN
		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbInicio);
		
		pkg_traza.trace('inuContratoId: ' || inuContratoId, cnuNVLTRC);
		
		sbClienteActivo := pkg_boclientesestacionales.fsb_ObtieneActivoClieEsta(inuContratoId);
		
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
    END prc_ObtieneActivoClieEsta;
	
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
		
		nuError				NUMBER;  
		nuTipoProducto		servsusc.sesuserv%TYPE;
		nutipoGas			NUMBER := 0;
		sbmensaje			VARCHAR2(1000);  
        
    BEGIN
		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbInicio);
		
		pkg_traza.trace('inuContratoId: ' 		|| inuContratoId || CHR(10) ||
						'idtFechinicialVige : ' || idtFechinicialVige || CHR(10) ||
						'idtFechaFinalVig : ' 	|| idtFechaFinalVig || CHR(10) ||
						'isbActivo : ' 			|| isbActivo, cnuNVLTRC);
		
		pkg_boclientesestacionales.prc_updClienteEstacional(inuContratoId,
															to_date(idtFechinicialVige),
															to_date(idtFechaFinalVig),
															isbActivo
															);
        
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
        Actualiza cliente estacional
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
		
		pkg_boclientesestacionales.prc_validaFechafinalVig(TO_DATE(idtFechaIniVige),
														   TO_DATE(idtFechafinVige),
														   osbCumpleFecha
														  );
        
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
	
END PKG_CLIENTESESTACIONALES;
/
BEGIN
pkg_utilidades.prAplicarPermisos(upper('PKG_CLIENTESESTACIONALES'),'OPEN'); 
END;
/