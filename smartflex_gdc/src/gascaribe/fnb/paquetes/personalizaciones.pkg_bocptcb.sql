CREATE OR REPLACE PACKAGE personalizaciones.pkg_bocptcb
IS
    /******************************************************************
    <Package Fuente="Propiedad Intelectual de GDC">
    <Unidad> pkg_bocptcb </Unidad>
    <Autor> Luis Felipe Valencia Hurtado</Autor>
    <Fecha> 12-12-2024 </Fecha>
    <Descripcion> 
       Paquete con la logica de CPTCB
    </Descripcion>
    <Historial>
           <Modificacion Autor="felipe.valencia" Fecha="12-12-2024" Inc="OSF-3738" Empresa="GDC">
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
    <Autor> Luis Felipe Valencia Hurtado</Autor>
    <Fecha> 12-12-2024 </Fecha>
    <Descripcion> 
        Obtiene la version del paquete.
    </Descripcion>
    <Retorno Nombre="Versión del paquete" Tipo="VARCHAR2">
        Versión del paquete
    </Retorno>
    <Historial>
            <Modificacion Autor="felipe.valencia" Fecha="12-12-2024" Inc="OSF-3738" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </FUNCTION>
    **************************************************************************/
    FUNCTION fsbVersion
    RETURN VARCHAR2;
	
	PROCEDURE prcObjetoCreaProducto
    (
        isbContrato	        IN VARCHAR2,
		isbtipoProducto     IN VARCHAR2,
        isbPlanComercial    IN VARCHAR2
	);

    PROCEDURE prcExpresionValContrato;
	
END pkg_bocptcb;
/
CREATE OR REPLACE PACKAGE BODY PERSONALIZACIONES.pkg_bocptcb
IS
    /******************************************************************
    <Package Fuente="Propiedad Intelectual de GDC">
    <Unidad> pkg_bocptcb </Unidad>
    <Autor> Luis Felipe Valencia Hurtado</Autor>
    <Fecha> 12-12-2024 </Fecha>
    <Descripcion> 
        Paquete con la logica de CPTCB
    </Descripcion>
    <Historial>
           <Modificacion Autor="felipe.valencia" Fecha="12-12-2024" Inc="OSF-3738" Empresa="GDC">
               Creación
           </Modificacion>
     </Historial>
     </Package>
    ******************************************************************/

    --------------------------------------------
    -- Constantes 
    --------------------------------------------
    csbVERSION          CONSTANT VARCHAR2(10) := 'OSF-3738';
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
    <Autor> felipe.valencia </Autor>
    <Fecha> 12-12-2024 </Fecha>
    <Descripcion> 
        Obtiene la version del paquete.
    </Descripcion>
    <Retorno Nombre="Versión del paquete" Tipo="VARCHAR2">
        Versión del paquete
    </Retorno>
    <Historial>
           <Modificacion Autor="felipe.valencia" Fecha="12-12-2024" Inc="OSF-3738" Empresa="GDC"> 
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
    <Procedure Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> prcObjetoCreaProducto </Unidad>
    <Autor> Luis Felipe Valencia Hurtado</Autor>
    <Fecha> 12-12-2024 </Fecha>
    <Descripcion> 
        Proceso que ejecuta la creación de productos para la opción CPTCB
    </Descripcion>
    <Historial>
        <Modificacion Autor="felipe.valencia" Fecha="12-12-2024" Inc="OSF-3738" Empresa="GDC">
            Creación
        </Modificacion>
    </Historial>
    </Procedure>
    **************************************************************************/
	PROCEDURE prcObjetoCreaProducto
    (
        isbContrato	        IN VARCHAR2,
		isbtipoProducto     IN VARCHAR2,
        isbPlanComercial    IN VARCHAR2
	)
	IS
		csbMT_NAME  		VARCHAR2(70) := csbSP_NAME || 'prcObjetoCreaProducto';
		nuError				NUMBER;  
		sbmensaje			VARCHAR2(4000);  

        nuContrato	        NUMBER;
		nuTipoProducto      NUMBER;
        nuPlanComercial     NUMBER;
        nuTipoServicioGas   NUMBER := pkg_bcld_parameter.fnuobtienevalornumerico('COD_SERV_GAS');
        rcProducto          pkg_producto.styProductos;
        rcDireccion         pkg_bcdirecciones.styDirecciones;
        nuProductoId        NUMBER;
        nuProductoCreado    NUMBER;
        sbPlanComercial     VARCHAR2(250);
        sbTagName           VARCHAR2(250);
        sbparTagName        VARCHAR2(250);
        nuEmpresa           NUMBER;
        nuProductoMotive    NUMBER;
        nuComponente        NUMBER;
        sbProceso VARCHAR2(70) := 'CPTCB'||TO_CHAR(SYSDATE,'DDMMYYYYHH24MISS');
		onuError			NUMBER;  
		osbmensajeError	    VARCHAR2(4000);  
	BEGIN

		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbInicio);

        pkg_estaproc.prInsertaEstaproc(sbProceso,NULL);

		nuContrato := TO_NUMBER(isbContrato);

        nuTipoProducto := TO_NUMBER(isbtipoProducto);

		pkg_traza.trace('nuContrato['||nuContrato||']',cnuNVLTRC);
        pkg_traza.Trace('nuTipoProducto['||nuTipoProducto||']',cnuNVLTRC);

		-- obtiene el producto de gas
		nuProductoId:= pkg_bogestion_producto.fnuObtProductoPorContratoyTipo(nuTipoServicioGas,nuContrato);

		pkg_traza.trace('Product de gas: '||nuProductoId,cnuNVLTRC);

		-- obtiene el record del producto
		rcProducto := pkg_producto.frcObtieneRegistro(nuProductoId);

		/* Obtiene el record de la direccion */
		rcDireccion := pkg_bcdirecciones.frcgetrecord(rcProducto.address_id);

        IF ( isbPlanComercial IS NULL) THEN

            sbPlanComercial := 'COD_COMERCIAL_PLAN_'||nuTipoProducto;

            pkg_traza.Trace('sbPlanComercial['||sbPlanComercial||']',cnuNVLTRC);

            nuPlanComercial := pkg_bcld_parameter.fnuobtienevalornumerico(sbPlanComercial);
        ELSE
            nuPlanComercial := TO_NUMBER(isbPlanComercial);
        END IF;

		pkg_traza.Trace('nuPlanComercial['||nuPlanComercial||']',cnuNVLTRC);

        sbparTagName := 'M_TAG_INSTALACION_DE_'||nuTipoProducto;

        pkg_traza.Trace('sbparTagName['||sbparTagName||']',cnuNVLTRC);

        sbTagName := pkg_bcld_parameter.fsbobtienevalorcadena(sbparTagName);

		/* Obtiene el id de la empresa del usuario conectado */
		nuEmpresa := pkg_session.fnugetempresadeusuario;
		pkg_traza.Trace('nuEmpresa['||nuEmpresa||']',cnuNVLTRC);

        nuProductoMotive := pkg_bogestionestructura_prod.fnuObtieneMotivoporNombreTag(sbTagName);

        pkg_traza.Trace('Producto-Motivo['||nuProductoMotive||']',cnuNVLTRC);

        pkg_bsgestion_producto.prcRegistraProductoyComponente
        (
            nuContrato,
			nuTipoProducto,
			nuPlanComercial,
			sysdate,
			rcProducto.address_id,
			rcProducto.category_id,
			rcProducto.subcategory_id,
			nuEmpresa,
			pkg_bopersonal.fnuGetPersonaId,
			pkg_bopersonal.fnuGetPuntoAtencionId(pkg_bopersonal.fnuGetPersonaId),
			nuProductoCreado,
			pkg_gestion_producto.CNUESTADO_ACTIVO_PRODUCTO, 
			ldc_bcConsGenerales.fsbValorColumna('PARAMETR', 'PAMENUME', 'PAMECODI', 'EST_SERVICIO_SIN_CORTE'),-- estado de corte
			NULL,
			NULL,
			NULL,
			NULL,
            --Componente
            null,    /* inuClassServiceId */
            NULL,               /* isbServiceNumber */
            NULL,               /* idtServiceDate */
            NULL,               /* idtMediationDate */
            NULL,               /* inuQuantity */
            NULL,               /* inuUnchargedTime */
            NULL,               /* isbDirectionality */
            NULL,               /* inuDistributAdminId */
            NULL,               /* inuMeter */
            NULL,               /* inuBuildingId */
            NULL,               /* inuAssignRouteId */
            NULL,               /* isbDistrictId */
            NULL,               /* isbincluded */
            rcDireccion.geograp_location_id,   /* inugeograp_location_id */
            rcDireccion.neighborthood_id,      /* inuneighborthood_id */
            rcDireccion.address,               /* isbaddress */
            NULL,               /* inuProductOrigin */
            NULL,               /* inuIncluded_Features_Id */
            NULL,               /* isbIsMain */
            nuComponente,        /* onuComponentId */
            FALSE,              /* iblRegAddress */
            FALSE,              /* iblElemmedi */
            FALSE,              /* iblSpecialPhone */
            NULL,               /* inuCompProdProvisionId */
            pkg_gestion_producto.CNUESTADO_ACTIVO_COMPONENTE,   /* inuComponentStatusId */
            FALSE,              /* iblValidate */
            nuProductoMotive,   /*inuMotivoProducto*/
            onuError,
            osbmensajeError
        );

        pkg_traza.Trace('ProductoCreado =>: '||nuProductoCreado,cnuNVLTRC);

		COMMIT;

		sbmensaje := 'Se proceso el contrato : '||nuContrato;

		pkg_estaproc.prActualizaEstaproc(sbProceso,'Termino Ok.');

		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
	
	EXCEPTION
		WHEN pkg_Error.Controlled_Error THEN
			pkg_Error.getError(nuError, sbmensaje);
			pkg_traza.trace('nuError: ' || nuError || ', ' || 'sbmensaje: ' || sbmensaje, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);
            pkg_estaproc.practualizaestaproc( sbproceso, 'Error ', sbmensaje );
            ROLLBACK;
			RAISE PKG_ERROR.CONTROLLED_ERROR;
		WHEN others THEN
			Pkg_Error.seterror;
			pkg_error.geterror(nuError, sbmensaje);
			pkg_traza.trace('nuError: ' || nuError || ', ' || 'sbmensaje: ' || sbmensaje, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
            pkg_estaproc.practualizaestaproc( sbproceso, 'Error ', sbmensaje );
            ROLLBACK;
			RAISE PKG_ERROR.CONTROLLED_ERROR;
	END prcObjetoCreaProducto;

	/**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> prcExpresionValContrato </Unidad>
    <Autor> Luis Felipe Valencia Hurtado</Autor>
    <Fecha> 12-12-2024 </Fecha>
    <Descripcion> 
        Proceso que ejecuta la expresion de validación del campo contrato
    </Descripcion>
    <Historial>
        <Modificacion Autor="felipe.valencia" Fecha="12-12-2024" Inc="OSF-3738" Empresa="GDC">
            Creación
        </Modificacion>
    </Historial>
    </Procedure>
    **************************************************************************/
	PROCEDURE prcExpresionValContrato
	IS
		csbMT_NAME  		VARCHAR2(70) := csbSP_NAME || 'prcExpresionValContrato';
		nuError				NUMBER;  
		sbmensaje			VARCHAR2(4000);  

        nuValida            NUMBER;
	BEGIN

		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbInicio);

        nuValida := pkg_bcgestion_ventasfnb.fnuvalidaContrato;

        pkg_traza.trace('nuValida: ['||nuValida||']', cnuNVLTRC);

		IF (nuValida = 2) THEN
			pkg_traza.trace('El contrato no existe', cnuNVLTRC);
			Pkg_Error.SetErrorMessage(pkg_error.CNUGENERIC_MESSAGE,'El contrato no existe');
        ELSIF (nuValida = 3) THEN
            pkg_traza.trace('El contrato no tiene asociado un producto de gas', cnuNVLTRC);
			Pkg_Error.SetErrorMessage(pkg_error.CNUGENERIC_MESSAGE,'El contrato no tiene asociado un producto de gas');
        ELSIF (nuValida = 4) THEN
            pkg_traza.trace('El producto de gas asociado al contrato debe estar activo o suspendido', cnuNVLTRC);
			Pkg_Error.SetErrorMessage
            (
                pkg_error.CNUGENERIC_MESSAGE,
                'El producto de gas asociado al contrato debe estar activo o suspendido'
            );
        ELSIF (nuValida = 5) THEN
            pkg_traza.trace('El contrato ya tiene 3 tipos de producto FNB', cnuNVLTRC);
			Pkg_Error.SetErrorMessage
            (
                pkg_error.CNUGENERIC_MESSAGE,
                'El contrato ya tiene 3 tipos de producto FNB'
            );
		END IF;

		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
	
	EXCEPTION
		WHEN pkg_Error.Controlled_Error THEN
			pkg_Error.getError(nuError, sbmensaje);
			pkg_traza.trace('nuError: ' || nuError || ', ' || 'sbmensaje: ' || sbmensaje, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);
			RAISE PKG_ERROR.CONTROLLED_ERROR;
		WHEN others THEN
			Pkg_Error.seterror;
			pkg_error.geterror(nuError, sbmensaje);
			pkg_traza.trace('nuError: ' || nuError || ', ' || 'sbmensaje: ' || sbmensaje, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
			RAISE PKG_ERROR.CONTROLLED_ERROR;
	END prcExpresionValContrato;
			
END pkg_bocptcb;
/
BEGIN
pkg_utilidades.prAplicarPermisos(upper('pkg_bocptcb'),'PERSONALIZACIONES'); 
END;
/