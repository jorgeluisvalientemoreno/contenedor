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
		<Modificacion Autor="Jhon.Erazo" Fecha="06-12-2024" Inc="OSF-3713" Empresa="GDC">
			1. Se renombran los procedimiento
				- prc_ObtieneFechaRegistro por prcObtieneFechaRegistro
				- prc_ObtiFechaIniVigenc por prcObtiFechaIniVigenc
				- prc_ObtiFechaFinVigenc por prcObtiFechaFinVigenc
				- prc_valProductoEsGas por prcvalProductoEsGas
				- prc_updClienteEstacional por prcActClienteEstacional
				- prc_validaFechafinalVig por prcvalidaFechafinalVig
			2. Se elimina el procedimiento prc_ObtieneActivoClieEsta
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
		
		Salida:
		
	</parametros>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="4-10-2024" Inc="OSF-3241" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </FUNCTION>
    **************************************************************************/
    PROCEDURE prcvalProductoEsGas;
	
	/**************************************************************************
    <PROCEDURE Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> prcObtieneFechaRegistro </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 9-10-2024 </Fecha>
    <Descripcion> 
        Retorna la fecha de registro
    </Descripcion>
	<parametros>
		Entrada: 
		
		Salida:
		
	</parametros>
    <Historial>
		<Modificacion Autor="Jhon.Erazo" Fecha="12-12-2024" Inc="OSF-3713" Empresa="GDC">
			1. Se renombra por el procedimiento prcObtieneFechaRegistro
        </Modificacion>
        <Modificacion Autor="Jhon.Erazo" Fecha="4-10-2024" Inc="OSF-3241" Empresa="GDC">
			Creación
        </Modificacion>
    </Historial>
    </PROCEDURE>
    **************************************************************************/
    PROCEDURE prcObtieneFechaRegistro;
	
	/**************************************************************************
    <PROCEDURE Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> prcObtiFechaIniVigenc </Unidad>
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
    </PROCEDURE>
    **************************************************************************/
    PROCEDURE prcObtiFechaIniVigenc;
	
	/**************************************************************************
    <PROCEDURE Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> prcObtiFechaFinVigenc </Unidad>
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
    </PROCEDURE>
    **************************************************************************/
    PROCEDURE prcObtiFechaFinVigenc;
	
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
			
		Salida:
		
	</parametros>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="4-10-2024" Inc="OSF-3241" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </FUNCTION>
    **************************************************************************/
    PROCEDURE prcActClienteEstacional;
									   
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
			
		Salida:
		
	</parametros>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="4-10-2024" Inc="OSF-3241" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </FUNCTION>
    **************************************************************************/
    PROCEDURE prcvalidaFechafinalVig;								   
	
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
    <Unidad> prcvalProductoEsGas </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 4-10-2024 </Fecha>
    <Descripcion> 
        Valida si el producto es de gas
    </Descripcion>
	<parametros>
		Entrada: 
		
		Salida:
		
	</parametros>
    <Historial>
		<Modificacion Autor="Jhon.Erazo" Fecha="12-12-2024" Inc="OSF-3713" Empresa="GDC">
			1. Se renombra por el procedimiento prcvalProductoEsGas
			2. Se elimina los parametros de entrada inuProductoId y osbEsGAs
			3. Se obtiene el producto de la instancia
        </Modificacion>
        <Modificacion Autor="Jhon.Erazo" Fecha="4-10-2024" Inc="OSF-3241" Empresa="GDC">
			Creación
        </Modificacion>
    </Historial>
    </FUNCTION>
    **************************************************************************/
    PROCEDURE prcvalProductoEsGas
    IS
	
		csbMT_NAME  		VARCHAR2(70) := csbSP_NAME || 'prcvalProductoEsGas';
		
		nuError			NUMBER;  
		nuProducto		pr_product.product_id%TYPE;
		sbmensaje		VARCHAR2(1000);  
        
    BEGIN
		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbInicio);
		
		-- Obtiene el producto 
		PRC_OBTIENEVALORINSTANCIA('WORK_INSTANCE',
								  NULL,
								  'PR_PRODUCT',
								  'PRODUCT_ID',
								  nuProducto
								  );
		pkg_traza.trace('nuProducto: ' || nuProducto, cnuNVLTRC);
		
		pkg_boclientesestacionales.prcvalProductoEsGas(nuProducto);
        
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
    <PROCEDURE Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> prcObtieneFechaRegistro </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 9-10-2024 </Fecha>
    <Descripcion> 
        Retorna la fecha de registro
    </Descripcion>
	<parametros>
		Entrada: 
		
		Salida:
		
	</parametros>
    <Historial>
		<Modificacion Autor="Jhon.Erazo" Fecha="12-12-2024" Inc="OSF-3713" Empresa="GDC">
			1. Se renombra por el procedimiento prcObtieneFechaRegistro
			2. Se elimina el parametro de entrada inuContratoId
			3. Se obtiene el contrato de la instancia
			4. Instancia la fecha de registro
        </Modificacion>
		<Modificacion Autor="Jhon.Erazo" Fecha="4-10-2024" Inc="OSF-3241" Empresa="GDC">
			Creación
        </Modificacion>
    </Historial>
    </PROCEDURE>
    **************************************************************************/
    PROCEDURE prcObtieneFechaRegistro
    IS
	
		csbMT_NAME  		VARCHAR2(70) := csbSP_NAME || 'prcObtieneFechaRegistro';
		
		nuError				NUMBER;
		nuContrato			suscripc.susccodi%type;
		dtFechadeRegistro	DATE := NULL;
		sbmensaje			VARCHAR2(1000);  
        
    BEGIN
		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbInicio);
		
		-- Obtiene el contrato 
		PRC_OBTIENEVALORINSTANCIA('WORK_INSTANCE',
								  NULL,
								  'SUSCRIPC',
								  'SUSCCODI',
								  nuContrato
								  );
		pkg_traza.trace('nuContrato: ' || nuContrato, cnuNVLTRC);
		
		-- Obtiene la fecha de registro
		dtFechadeRegistro := pkg_boclientesestacionales.fdtObtieneFechaRegistro(nuContrato);
		
		pkg_traza.trace('dtFechadeRegistro: ' || dtFechadeRegistro, cnuNVLTRC);
		
		-- Instancia la fecha de registro
		GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(dtFechadeRegistro);
        
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
    END prcObtieneFechaRegistro;
	
	/**************************************************************************
    <PROCEDURE Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> prcObtiFechaIniVigenc </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 9-10-2024 </Fecha>
    <Descripcion> 
        Retorna la fecha inicial de vigencia
    </Descripcion>
	<parametros>
		Entrada: 
		
		Salida:
		
	</parametros>
    <Historial>
		<Modificacion Autor="Jhon.Erazo" Fecha="12-12-2024" Inc="OSF-3713" Empresa="GDC">
			1. Se renombra por el procedimiento prcObtiFechaIniVigenc
			2. Se elimina el parametro de entrada inuContratoId
			3. Se obtiene el contrato de la instancia
			4. Instancia la fecha de registro
        </Modificacion>
		<Modificacion Autor="Jhon.Erazo" Fecha="4-10-2024" Inc="OSF-3241" Empresa="GDC">
			Creación
        </Modificacion>
    </Historial>
    </PROCEDURE>
    **************************************************************************/
    PROCEDURE prcObtiFechaIniVigenc
    IS
	
		csbMT_NAME  		VARCHAR2(70) := csbSP_NAME || 'prcObtiFechaIniVigenc';
		
		nuError				NUMBER;  
		nuContrato			suscripc.susccodi%type;
		dtFechaIniVigencia	DATE := NULL;
		sbmensaje			VARCHAR2(1000);   
        
    BEGIN
		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbInicio);
		
		-- Obtiene el contrato 
		PRC_OBTIENEVALORINSTANCIA('WORK_INSTANCE',
								  NULL,
								  'SUSCRIPC',
								  'SUSCCODI',
								  nuContrato
								  );
		pkg_traza.trace('nuContrato: ' || nuContrato, cnuNVLTRC);
		
		-- Obtiene la fecha inicial de vigencia
		dtFechaIniVigencia := pkg_boclientesestacionales.fdtObtiFechaIniVigenc(nuContrato);
		
		pkg_traza.trace('dtFechaIniVigencia: ' || dtFechaIniVigencia, cnuNVLTRC);
		
		-- Instancia la fecha de registro
		GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(dtFechaIniVigencia);
        
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
    END prcObtiFechaIniVigenc;
	
	/**************************************************************************
    <PROCEDURE Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> prcObtiFechaFinVigenc </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 9-10-2024 </Fecha>
    <Descripcion> 
        Retorna la fecha final de vigencia
    </Descripcion>
	<parametros>
		Entrada: 
		
		Salida:
		
	</parametros>
    <Historial>
		<Modificacion Autor="Jhon.Erazo" Fecha="12-12-2024" Inc="OSF-3713" Empresa="GDC">
			1. Se renombra por el procedimiento prcObtiFechaFinVigenc
			2. Se elimina el parametro de entrada inuContratoId
			3. Se obtiene el contrato de la instancia
			4. Instancia la fecha de registro
        </Modificacion>
		<Modificacion Autor="Jhon.Erazo" Fecha="4-10-2024" Inc="OSF-3241" Empresa="GDC">
			Creación
        </Modificacion>
    </Historial>
    </PROCEDURE>
    **************************************************************************/
    PROCEDURE prcObtiFechaFinVigenc
    IS
	
		csbMT_NAME  		VARCHAR2(70) := csbSP_NAME || 'prcObtiFechaFinVigenc';
		
		nuError				NUMBER;  
		nuContrato			suscripc.susccodi%type;
		dtFechaFinVigencia	DATE := NULL;
		sbmensaje			VARCHAR2(1000);

    BEGIN
		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbInicio);
		
		-- Obtiene el contrato 
		PRC_OBTIENEVALORINSTANCIA('WORK_INSTANCE',
								  NULL,
								  'SUSCRIPC',
								  'SUSCCODI',
								  nuContrato
								  );
		pkg_traza.trace('nuContrato: ' || nuContrato, cnuNVLTRC);
		
		-- Obtiene la fecha final de vigencia
		dtFechaFinVigencia := pkg_boclientesestacionales.fdtObtiFechaFinVigenc(nuContrato);
		
		pkg_traza.trace('dtFechaFinVigencia: ' || dtFechaFinVigencia, cnuNVLTRC);
		
		-- Instancia la fecha de registro
		GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(dtFechaFinVigencia);
        
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
    END prcObtiFechaFinVigenc;
	
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
			
		Salida:
		
	</parametros>
    <Historial>
		<Modificacion Autor="Jhon.Erazo" Fecha="12-12-2024" Inc="OSF-3713" Empresa="GDC">
			1. Se renombra por el procedimiento prcActClienteEstacional
			2. Se elimina los parametros de entrada inuContratoId, idtFechinicialVige, 
			   idtFechaFinalVig y isbActivo.
			3. Se obtiene el contrato, producto, fecha inicial de vigencia, fecha final de vigencia
			   y flag activo de la instancia
        </Modificacion>
		<Modificacion Autor="Jhon.Erazo" Fecha="4-10-2024" Inc="OSF-3241" Empresa="GDC">
			Creación
        </Modificacion>
    </Historial>
    </PROCEDURE>
    **************************************************************************/
    PROCEDURE prcActClienteEstacional
    IS
	
		csbMT_NAME  		VARCHAR2(70) := csbSP_NAME || 'prcActClienteEstacional';
		
		nuError				NUMBER;  
		nuContrato			suscripc.susccodi%type;
		nuProduct_id		pr_product.product_id%TYPE;
		sbmensaje			VARCHAR2(1000); 
		sbActivo			VARCHAR2(1); 
		dtFechaInicial		DATE;
		dtFechaFinal		DATE;
        
    BEGIN
		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbInicio);
						
		-- Obtiene el contrato
		PRC_OBTIENEVALORINSTANCIA('WORK_INSTANCE',
								  NULL,
								  'SUSCRIPC',
								  'SUSCCODI',
								  nuContrato
								  );
		pkg_traza.trace('nuContrato: ' || nuContrato, cnuNVLTRC);
		
		-- Obtiene el producto 
		PRC_OBTIENEVALORINSTANCIA('WORK_INSTANCE',
								  NULL,
								  'PR_PRODUCT',
								  'PRODUCT_ID',
								  nuProduct_id
								  );
		pkg_traza.trace('nuProduct_id: ' || nuProduct_id, cnuNVLTRC);
		
		-- Obtiene la fecha inicial de vigencia
		PRC_OBTIENEVALORINSTANCIA('M_INSTALACION_DE_GAS_100334-2',
								  NULL,
								  'MO_PROCESS',
								  'INITIAL_DATE',
								  dtFechaInicial
								  );
		pkg_traza.trace('dtFechaInicial: ' || dtFechaInicial, cnuNVLTRC);
		
		-- Obtiene la fecha final de vigencia
		PRC_OBTIENEVALORINSTANCIA('M_INSTALACION_DE_GAS_100334-2',
								  NULL,
								  'MO_PROCESS',
								  'FINAL_DATE',
								  dtFechaFinal
								  );
		pkg_traza.trace('dtFechaFinal: ' || dtFechaFinal, cnuNVLTRC);
		
		-- Obtiene el valor de activo
		PRC_OBTIENEVALORINSTANCIA('M_INSTALACION_DE_GAS_100334-2',
								  NULL,
								  'MO_PROCESS',
								  'FLAG',
								  sbActivo
								  );
		pkg_traza.trace('sbActivo: ' || sbActivo, cnuNVLTRC);
		
		-- Actualiza el cliente estacional
		pkg_boclientesestacionales.prcActClienteEstacional(nuContrato,
														   nuProduct_id,
														   to_date(dtFechaInicial),
														   to_date(dtFechaFinal),
														   sbActivo
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
    END prcActClienteEstacional;
	
	/**************************************************************************
    <PROCEDURE Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> prcvalidaFechafinalVig </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 4-10-2024 </Fecha>
    <Descripcion> 
        Actualiza cliente estacional
    </Descripcion>
	<parametros>
		Entrada: 
			
		Salida:
		
	</parametros>
    <Historial>
		<Modificacion Autor="Jhon.Erazo" Fecha="12-12-2024" Inc="OSF-3713" Empresa="GDC">
			1. Se renombra por el procedimiento prcvalidaFechafinalVig
			2. Se elimina los parametros de entrada idtFechaIniVige y idtFechafinVige.
			2. Se elimina el parametro de salida osbCumpleFecha.
			3. Se obtiene la fecha inicial de vigencia y fecha final de vigencia de la instancia
        </Modificacion>
		<Modificacion Autor="Jhon.Erazo" Fecha="4-10-2024" Inc="OSF-3241" Empresa="GDC">
			Creación
        </Modificacion>
    </Historial>
    </PROCEDURE>
    **************************************************************************/
    PROCEDURE prcvalidaFechafinalVig
    IS
	
		csbMT_NAME  		VARCHAR2(70) := csbSP_NAME || 'prcvalidaFechafinalVig';
		
		nuError				NUMBER;  
		sbmensaje			VARCHAR2(1000);  
		dtFechaInicial		DATE;
		dtFechaFinal		DATE;
        
    BEGIN
		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbInicio);
						
		-- Obtiene la fecha inicial de vigencia
		PRC_OBTIENEVALORINSTANCIA('M_INSTALACION_DE_GAS_100334-2',
								  NULL,
								  'MO_PROCESS',
								  'INITIAL_DATE',
								  dtFechaInicial
								  );
		pkg_traza.trace('dtFechaInicial: ' || dtFechaInicial, cnuNVLTRC);
		
		-- Obtiene la fecha final de vigencia
		PRC_OBTIENEVALORINSTANCIA('M_INSTALACION_DE_GAS_100334-2',
								  NULL,
								  'MO_PROCESS',
								  'FINAL_DATE',
								  dtFechaFinal
								  );
		pkg_traza.trace('dtFechaFinal: ' || dtFechaFinal, cnuNVLTRC);				
		
		-- Valida la fecha final de vigencia
		pkg_boclientesestacionales.prcvalidaFechafinalVig(TO_DATE(dtFechaInicial),
														   TO_DATE(dtFechaFinal)
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
    END prcvalidaFechafinalVig;
	
END PKG_CLIENTESESTACIONALES;
/
BEGIN
pkg_utilidades.prAplicarPermisos(upper('PKG_CLIENTESESTACIONALES'),'OPEN'); 
END;
/