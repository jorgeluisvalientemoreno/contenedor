CREATE OR REPLACE PROCEDURE PERSONALIZACIONES.OAL_ACTIVAPRODUCTO(inuOrden            IN NUMBER,
                                                                 InuCausal           IN NUMBER,
                                                                 InuPersona          IN NUMBER,
                                                                 idtFechIniEje       IN DATE,
                                                                 idtFechaFinEje      IN DATE,
                                                                 IsbDatosAdic        IN VARCHAR2,
                                                                 IsbActividades      IN VARCHAR2,
                                                                 IsbItemsElementos   IN VARCHAR2,
                                                                 IsbLecturaElementos IN VARCHAR2,
                                                                 IsbComentariosOrden IN VARCHAR2) IS
	/***************************************************************************
      Propiedad Intelectual de Gases del Caribe
      Programa        : OAL_ACTIVAPRODUCTO
      Descripcion     : Servicio para activar el producto y componentes con la definición de 
                        fecha de instalación en el servicio. (El estado de corte no será cambiado en este servicio, 
                        solo se necesita activar el producto para generar lectura y su respectivo cobro)
						
      Autor           : Jorge Valiente
      Fecha           : 22-06-2023
      
      Parametros de Entrada          
        inuOrden              numero de orden
        InuCausal             causal de legalizacion
        InuPersona            persona que legaliza
        idtFechIniEje         fecha de inicio de ejecucion
        idtFechaFinEje        fecha fin de ejecucion
        IsbDatosAdic          datos adicionales
        IsbActividades        actividad principal y de apoyo
        IsbItemsElementos     items a legalizar
        IsbLecturaElementos   lecturas
        IsbComentariosOrden   comentario de la orden
      Parametros de Salida
      
      
      Modificaciones  :
      =========================================================
      Autor       	Fecha       Caso    	Descripcion
	  jerazomvm		08/09/2023	OSF-1530	1. Se crean las variables para obtener los parametros 
											   COD_SOLIINNOVA_ACT_ESTACORT y COD_USUARIO_ACTIVA_ESTACORT.
											2. En el cursor cuSolicitud, se agrega la columna USER_ID.
											3. Se crea el cursor cuValidaString.
											4. Se agrega validación si el tipo de solicitud esta configurado
											   en el parametro COD_SOLIINNOVA_ACT_ESTACORT y si el usuario
											   esta configurado en el parametro COD_USUARIO_ACTIVA_ESTACORT,
											   de estar configurados se asigna el flag sbActivaEstacort en S.
	***************************************************************************/

	nuTipopaquete       			mo_packages.package_type_id%type;
	sbUsuario						mo_packages.user_id%type;
	nuProducto          			pr_product.product_id%type;
	sbTipospaquetesvtas 			varchar2(2000);
	sbCod_soliinnova_act_estacort	varchar2(2000);
	sbCod_usuario_activa_estacort	varchar2(2000);
	sbExiste            			varchar2(1);
	sbExisteUsuario					varchar2(1);
	sbActivaEstacort				varchar2(1);

	--OBTIENE LA SOLICITUD ASOCIADA A LA ORDEN DE INSTANCIA
	CURSOR cuSolicitud IS
		SELECT P.PACKAGE_TYPE_ID, 
			   B.Product_Id, 
			   P.USER_ID
		FROM OR_ORDER_ACTIVITY B, MO_PACKAGES P
		WHERE B.PACKAGE_ID 	= P.PACKAGE_ID
		AND B.ORDER_ID 		= inuOrden;

	--VALIDA EL TIPO DE SOLICITUD EN UN PARAMETRO TIPO CADENA
	CURSOR cuExiste(VALOR NUMBER, SBCADENA VARCHAR2) IS
		SELECT 'S'
		FROM DUAL
		WHERE VALOR IN (SELECT to_number(regexp_substr(SBCADENA, '[^,]+', 1, LEVEL)) AS TIPOSOLICITUD
						FROM dual
						CONNECT BY regexp_substr(SBCADENA, '[^,]+', 1, LEVEL) IS NOT NULL
						);
						
	-- Valida el valor de una cadena en un parametro tipo cadena
	CURSOR cuValidaString(isbValor 			VARCHAR2, 
						  isbValorParametro VARCHAR2
						  ) IS
		SELECT 'S'
		FROM DUAL
		WHERE isbValor IN (SELECT regexp_substr(isbValorParametro, '[^,]+', 1, LEVEL) AS USUARIO
						FROM dual
						CONNECT BY regexp_substr(isbValorParametro, '[^,]+', 1, LEVEL) IS NOT NULL
						);
	
	BEGIN

	UT_TRACE.TRACE('INICIO OAL_ACTIVAPRODUCTO inuOrden: ' 				|| inuOrden 			|| CHR(10) ||
											 'InuCausal: '				|| InuCausal 			|| CHR(10) ||
											 'InuPersona: '				|| InuPersona 			|| CHR(10) ||
											 'idtFechIniEje: '			|| idtFechIniEje 		|| CHR(10) ||
											 'idtFechaFinEje: '			|| idtFechaFinEje 		|| CHR(10) ||
											 'IsbDatosAdic: '			|| IsbDatosAdic 		|| CHR(10) ||
											 'IsbActividades: '			|| IsbActividades 		|| CHR(10) ||
											 'IsbItemsElementos: '		|| IsbItemsElementos 	|| CHR(10) ||
											 'IsbLecturaElementos: '	|| IsbLecturaElementos 	|| CHR(10) ||
											 'IsbComentariosOrden: '	|| IsbComentariosOrden, 5);
	
	IF (cuSolicitud%ISOPEN) THEN
		CLOSE cuSolicitud;
	END IF;	
	
	--OBTIENE LA SOLICITUD ASOCIADA A LA ORDEN
	OPEN cuSolicitud;
	FETCH cuSolicitud
	INTO nuTipopaquete, nuProducto, sbUsuario;
	CLOSE cuSolicitud;
	
	UT_TRACE.TRACE('La orden ' || inuOrden || ' con producto ' || nuProducto || chr(10) ||
				   'el tipo de solicitud es ' || nuTipopaquete || ' y el usuario es ' || sbUsuario, 5);

	--VALIDA QUE HAYA SOLICITUD ASOCIADA A LA ORDEN
	IF (nuTipopaquete IS NOT NULL) THEN
		sbTipospaquetesvtas := pkg_parametros.fsbGetValorCadena('CODIGO_SOLICITUD_VENTA_GAS');
		UT_TRACE.TRACE('El valor del parametro CODIGO_SOLICITUD_VENTA_GAS es: ' || sbTipospaquetesvtas, 5);
			
		IF (cuExiste%ISOPEN) THEN
			CLOSE cuExiste;
		END IF;	
		
		--COMPARA EL TIPO DE SOLICITUD EN EL PARAMETRO CODIGO_SOLICITUD_VENTA_GAS
		OPEN cuExiste(nuTipopaquete, sbTipospaquetesvtas);
		FETCH cuExiste
		INTO SBEXISTE;
		CLOSE cuExiste;
  
		--VALIDA EXISTENCIA DEL TIPO DE SOLICITUD EN EL PARAMETRO COD_SOL_VEN_GAS  
		IF (SBEXISTE = 'S') THEN
			UT_TRACE.TRACE('El tipo de solicitud ' || nuTipopaquete || ' existe en el parametro CODIGO_SOLICITUD_VENTA_GAS', 5);
			
			sbCod_soliinnova_act_estacort := pkg_parametros.fsbGetValorCadena('COD_SOLIINNOVA_ACT_ESTACORT');
			UT_TRACE.TRACE('El valor del parametro COD_SOLIINNOVA_ACT_ESTACORT es: ' || sbCod_soliinnova_act_estacort, 3);
			
			sbCod_usuario_activa_estacort := pkg_parametros.fsbGetValorCadena('COD_USUARIO_ACTIVA_ESTACORT');
			UT_TRACE.TRACE('El valor del parametro COD_USUARIO_ACTIVA_ESTACORT es: ' || sbCod_usuario_activa_estacort, 3);
			
			SBEXISTE := NULL;
			
			IF (cuExiste%ISOPEN) THEN
				CLOSE cuExiste;
			END IF;				
		
			-- Compara si el tipo de solicitud existe en el parametro COD_SOLIINNOVA_ACT_ESTACORT
			OPEN cuExiste(nuTipopaquete, sbCod_soliinnova_act_estacort);
			FETCH cuExiste
			INTO SBEXISTE;
			CLOSE cuExiste;
			
			IF (cuValidaString%ISOPEN) THEN
				CLOSE cuValidaString;
			END IF;	
			
			-- Compara si el usuario existe en el parametro COD_USUARIO_ACTIVA_ESTACORT
			OPEN cuValidaString(sbUsuario, sbCod_usuario_activa_estacort);
			FETCH cuValidaString
			INTO sbExisteUsuario;
			CLOSE cuValidaString;
			
			IF (SBEXISTE = 'S' and sbExisteUsuario = 'S') THEN
				ut_trace.trace('El tipo de solicitud ' || nuTipopaquete || ' esta configurado en el parametro COD_SOLIINNOVA_ACT_ESTACORT', 5);
				ut_trace.trace('El usuario ' || sbUsuario || ' esta configurado en el parametro COD_USUARIO_ACTIVA_ESTACORT', 5);
				
				sbActivaEstacort := 'S';
			ELSE
				ut_trace.trace('El tipo de solicitud ' || nuTipopaquete || ' no esta configurado en el parametro COD_SOLIINNOVA_ACT_ESTACORT', 5);
				ut_trace.trace('El usuario ' || sbUsuario || 'no esta configurado en el parametro COD_USUARIO_ACTIVA_ESTACORT', 5);
				
				sbActivaEstacort := 'N';
			END IF;
			
			PKG_GESTION_PRODUCTO.PRACTIVAPRODUCTO(nuProducto, 
												  idtFechaFinEje, 
												  sbActivaEstacort
												  );
												  
		END IF; --VALIDA EL TIPO DE PAQUETE
  
	END IF; --VALIDA QUE HAYA SOLICITUD ASOCIADA A LA ORDEN

	UT_TRACE.TRACE('FIN OAL_ACTIVAPRODUCTO', 5);

	EXCEPTION
		WHEN PKG_ERROR.CONTROLLED_ERROR THEN
		UT_TRACE.TRACE('PKG_ERROR.CONTROLLED_ERROR OAL_ACTIVAPRODUCTO', 5);
		raise PKG_ERROR.CONTROLLED_ERROR;
	WHEN others THEN
		UT_TRACE.TRACE('others OAL_ACTIVAPRODUCTO', 5);
		Pkg_Error.seterror;
		raise PKG_ERROR.CONTROLLED_ERROR;
END OAL_ACTIVAPRODUCTO;
/

begin
  pkg_utilidades.prAplicarPermisos('OAL_ACTIVAPRODUCTO', 'PERSONALIZACIONES');
end;
/