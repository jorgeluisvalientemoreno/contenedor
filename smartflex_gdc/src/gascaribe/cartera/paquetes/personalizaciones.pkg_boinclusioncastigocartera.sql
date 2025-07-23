CREATE OR REPLACE PACKAGE PERSONALIZACIONES.pkg_boinclusioncastigocartera IS
	/*******************************************************************************
		Fuente=Propiedad Intelectual de Gases del Caribe
		
		Autor       :   Jhon Eduar Erazo
		Fecha       :   24-04-2025
		Descripcion :   Paquete con logica el proyecto de castigo a usuarios por inclusion manual
		ModIFicaciones  :
		Autor       Fecha       Caso     	Descripcion
		jerazomvm	24-04-2025	OSF-4170	Creación
	*******************************************************************************/
	
	-- Obtiene la version del paquete.
    FUNCTION fsbVersion
    RETURN VARCHAR2;	
	
	-- Procesa el proyecto de castigo a usuarios por inclusion manual
	PROCEDURE prcProcesa(inuProgramacion 	IN ge_process_schedule.process_schedule_id%TYPE,
						 isbMetodo			IN VARCHAR2
						 );
									
END pkg_boinclusioncastigocartera;
/
CREATE OR REPLACE PACKAGE BODY PERSONALIZACIONES.pkg_boinclusioncastigocartera IS

    -- Constantes para el control de la traza
    csbSP_NAME 	CONSTANT VARCHAR2(35) := $$PLSQL_UNIT||'.';
	cnuNVLTRC   CONSTANT NUMBER       := pkg_traza.cnuNivelTrzDef;
	csbInicio   CONSTANT VARCHAR2(35) := pkg_traza.fsbINICIO;
	
    -- IdentIFicador del ultimo caso que hizo cambios
    csbVersion 	VARCHAR2(15) := 'OSF-4170';

	/**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de GDC">
    <Unidad> fsbVersion </Unidad>
    <Autor> Jhon.Erazo </Autor>
    <Fecha> 24-04-2025 </Fecha>
    <Descripcion> 
        Obtiene la version del paquete.
    </Descripcion>
    <Retorno Nombre="Versión del paquete" Tipo="VARCHAR2">
        Versión del paquete
    </Retorno>
    <Historial>
           <ModIFicacion Autor="Jhon.Erazo" Fecha="24-04-2025" Inc="OSF-4170" Empresa="GDC"> 
               Creación
           </ModIFicacion>
    </Historial>
    </Procedure>
    **************************************************************************/
    FUNCTION fsbVersion
    RETURN VARCHAR2
    IS
    BEGIN
        return CSBVERSION;
    END fsbVersion;
	
	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prcProcesa
    Descripcion     : Procesa el proyecto de castigo a usuarios por inclusion manual
    Autor           : Jhon Erazo
    Fecha           : 24-04-2025
  
    Parametros de Entrada
		inuProgramacion		Identificador de la programación
		isbMetodo			Metodo
		
    Parametros de Salida
  
    ModIFicaciones  :
    =========================================================
    Autor       Fecha       	Caso    	Descripcion
    jerazomvm	23/04/2258  	OSF-4170	Creación
	***************************************************************************/	
	PROCEDURE prcProcesa(inuProgramacion 	IN ge_process_schedule.process_schedule_id%TYPE,
						 isbMetodo			IN VARCHAR2
						 )
	IS
	
		csbMETODO		CONSTANT VARCHAR2(100) 	:= csbSP_NAME ||'prcProcesa';
		
		TYPE t_indice IS TABLE OF VARCHAR2(1000) INDEX BY BINARY_INTEGER;
		TYPE t_proy_cast_inclu IS TABLE OF ldc_usu_eva_cast%ROWTYPE INDEX BY BINARY_INTEGER;
		
		dtFechaExcl   			gc_prodprca.prpcfeex%TYPE;
		dtSysdate				DATE := ldc_boConsGenerales.fdtGetSysDate;
		nuError					NUMBER;  
		nuProducto				servsusc.sesunuse%TYPE;
		nuHilos         		NUMBER 					:= 1;
		nuLogProceso    		ge_log_process.log_process_id%TYPE;
		nucantiregcom   		NUMBER(15) DEFAULT 0;
		nucantiregtot   		NUMBER(15) DEFAULT 0;
		nucontareg      		NUMBER(15) DEFAULT 0;
		nuInfoUsuaCastigarIdx	BINARY_INTEGER;
		nuvatipr        		servsusc.sesuserv%TYPE;
		nucontaindice   		NUMBER(6);
		nuEstadoCorte   		servsusc.sesuesco%TYPE	:= NULL;
		nuEstadoProd  			pr_product.product_status_id%TYPE;
		nuTipoProducto  		servsusc.sesuserv%TYPE	:= NULL;
		nurefarrind     		NUMBER(6);
		nuposicap       		NUMBER(6);
		nuExisteEstadoCorte     NUMBER := 0;
		nuExisteEstaProd		NUMBER;
		nuValTipoProd   		NUMBER := 0;
		nuPlanFacturacion		servsusc.sesuplfa%TYPE;
		nuParamPlanMediPrepa	ld_parameter.numeric_value%TYPE	:= NULL;
		nuconseproycast       	gc_proycast.prcacons%TYPE;
		nuconsepp             	gc_prodprca.prpccons%TYPE;
		sbmensaje				VARCHAR2(5000);	
		sbmensajeinco   		VARCHAR2(100);
		sbproceso       		VARCHAR2(100 BYTE) 		:=  isbMetodo||TO_CHAR(dtSysdate,'DDMMYYYYHH24MISS');
		sbNameProceso			sbproceso%TYPE; 	
		sbrutaarchiv    		VARCHAR2(30);	
		sbParametros    		ge_process_schedule.parameters_%TYPE;	
		sbnombrearchivo			VARCHAR2(2000);
		sbnombrearinco			VARCHAR2(2000);
		sbCadena        		VARCHAR2(4000);
		sbOk                  	VARCHAR2(3);
		sw              		NUMBER(1) DEFAULT 0;
		sbRespuesta 			VARCHAR2(200);
		sbproyeccod           	VARCHAR2(5000);
		vfileinco       		pkg_gestionarchivos.styarchivo;
		vfile           		pkg_gestionarchivos.styarchivo;
		tbInfoUsuarioCastigar	pkg_bcinclusioncastigocartera.tytbInfoUsuariosCastigar;
		tbTablaIndice    		t_indice;
		tbproy_cast_inclu 		t_proy_cast_inclu;
		
	BEGIN

		pkg_traza.trace(csbMETODO, cnuNVLTRC, csbInicio);
		
		pkg_traza.trace('inuProgramacion: ' || inuProgramacion || CHR(10) || 
						'isbMetodo: ' 		|| isbMetodo, cnuNVLTRC);
						
		pkg_error.prInicializaError(nuError, sbmensaje);
		
		-- inicializar el proceso
		BEGIN
			sbNameProceso:= sbproceso; --invocarlo una sola vez
			pkg_traza.trace('sbNameProceso: '||sbNameProceso , cnuNVLTRC);
			pkg_estaproc.prinsertaestaproc(sbNameProceso, NULL); 
		EXCEPTION
			WHEN OTHERS THEN
				 pkg_error.seterror;
				 pkg_error.geterror(nuError, sbmensaje );
				 pkg_traza.trace(csbMetodo||' Error: '||sbmensaje , cnuNVLTRC);
				 pkg_estaproc.practualizaestaproc( sbNameProceso, 'Error ', sbmensaje  );
		END;  
    
		-- se adiciona al log de procesos
		pkg_gestionprocesosprogramados.prc_AgregaLogAlProceso(inuProgramacion, nuHilos, nuLogProceso);
		pkg_traza.trace('nuLogProceso: ' || nuLogProceso , cnuNVLTRC);
		nucantiregcom   := 0;
		nucantiregtot   := 0;
		nucontareg      := pkg_bcld_parameter.fnuobtienevalornumerico('COD_CANTIDAD_REG_GUARDAR');
		pkg_traza.trace('nucontareg: ' || nucontareg , cnuNVLTRC);
		
		sbmensaje       := NULL;
		sbmensajeinco   := NULL;
		sbrutaarchiv    := TRIM(pkg_bcld_parameter.fsbObtieneValorCadena('RUTA_PROY_CAST_INCLUSI'));
		pkg_traza.trace('sbrutaarchiv: ' || sbrutaarchiv , cnuNVLTRC);
		
		-- se obtiene parametros
		sbParametros    := pkg_gestionprocesosprogramados.fsbObtParametrosProceso(inuProgramacion);
		pkg_traza.trace('sbParametros: ' || sbParametros , cnuNVLTRC);
		
		sbnombrearchivo := pkg_gestionprocesosprogramados.fsbObtValorParametroProceso(sbParametros, 'SUBSCRIBER_NAME', '|', '=');
		sbnombrearchivo := LOWER(sbnombrearchivo);
		pkg_traza.trace('sbnombrearchivo: ' || sbnombrearchivo , cnuNVLTRC);
		
		sbnombrearinco  := 'inconsist.txt';
		pkg_traza.trace('Nombre archivo de inconsistencias: ' || sbnombrearinco , cnuNVLTRC);
		
		pkg_traza.trace('abrir archivo de inconsistencias ' || sbnombrearinco || ' modo W', cnuNVLTRC);
		vfileinco       := pkg_gestionarchivos.ftabrirarchivo_smf(sbrutaarchiv, sbnombrearinco, 'W');
		
		pkg_traza.trace('abrir archivo ' || sbnombrearchivo || ' modo R', cnuNVLTRC);        
		vfile           := pkg_gestionarchivos.ftabrirarchivo_smf(sbrutaarchiv, sbnombrearchivo, 'R');    
		
		-- Recorre el archivo
		LOOP
			BEGIN
				sbCadena := pkg_gestionarchivos.fsbobtenerlinea_smf(vfile);
				pkg_traza.trace('Linea: ' || sbCadena , cnuNVLTRC);
			EXCEPTION
				WHEN no_data_found THEN
				EXIT;
			END;
			
			-- Obtiene el producto
			nuProducto := TO_NUMBER(TRIM(REPLACE(SUBSTR(sbCadena, 1, 10), CHR(13), '')));
			pkg_traza.trace('producto: '||nuProducto , cnuNVLTRC);
			
			-- Limpia la tabla tbInfoUsuarioCastigar
			tbInfoUsuarioCastigar.DELETE;
			
			-- Obtiene en tipo tabla la información de los usuarios a castigar	
			pkg_bcinclusioncastigocartera.prcObtInfoUsuariosCastigar(nuProducto,
																	 tbInfoUsuarioCastigar
																	 );
																	 
			nuInfoUsuaCastigarIdx := tbInfoUsuarioCastigar.FIRST;
			
			WHILE nuInfoUsuaCastigarIdx IS NOT NULL LOOP
				nuvatipr := tbInfoUsuarioCastigar(nuInfoUsuaCastigarIdx).nuTipoProducto;
				
				pkg_traza.trace('tipo_producto: ' || nuvatipr , cnuNVLTRC);
			
				-- Llenamos el arreglo de indice con sus respectivas agrupaciones
				nurefarrind := tbTablaIndice.COUNT;
				
				IF (nurefarrind = 0) THEN
					nucontaindice := 1;
					tbTablaIndice(nucontaindice) := nuvatipr;
					nuposicap := nucontaindice;
				ELSE
					sw := 0;
					FOR indice IN 1 .. nurefarrind LOOP
						IF (TRIM(tbTablaIndice(indice)) = nuvatipr) THEN
							nuposicap := indice;
							sw        := 1;
							EXIT;
						ELSE
							sw := 0;
						END IF;
					END LOOP;
			
					IF (sw = 0) THEN
						nucontaindice := nurefarrind + 1;
						tbTablaIndice(nucontaindice) := nuvatipr;
						nuposicap := nucontaindice;
					END IF;
				END IF;
				
				--Caso 604_1: Validacion del Estado de corte actual
				/*Logica:
				Se modificara el procedimiento LDC_PROCINCLUMAS, para agregar la validación del estado de corte actual del producto no se encuentre configurado en el par¿metro 
				¿ESTACORT_NO_PERMI_CASTIGO¿, si es correcta esta validaci¿n continuara con el proceso normal, en caso contrario terminara el proceso para el producto actual y 
				continuara con el siguiente producto en el ciclo. Así será la lógica:
					1. Se creara el cursor ¿cuValestacort¿, que retornara 1 si el código estado de corte se encuentra en el parámetro ¿ESTACORT_NO_PERMI_CASTIGO¿.
					2. Se validara si el cursor ¿cuValestacort¿ es diferente de 1, si es correcta esta validación continuará con el proceso normal, en caso contrario, 
						terminara el proceso para el producto actual, dejando el mensaje ¿el producto (#producto_actual) se encuentra en estado de corte valido para el proceso 
						de castigo¿, en el archivo de log y continuara con el siguiente producto en el ciclo.
				*/
				
				nuExisteEstadoCorte 	:= 0;
				nuValTipoProd 			:= 0;
				dtFechaExcl 			:= NULL;
				
				-- Obtiene el estado de corte y tipo de producto
				nuEstadoCorte 	:= pkg_bcproducto.fnuEstadoCorte(nuProducto);
				nuTipoProducto	:= pkg_bcproducto.fnuTipoProducto(nuProducto);
				 
				pkg_traza.trace('nuEstadoCorte: '  || nuEstadoCorte || CHR(10) || 
								'nuTipoProducto: ' || nuTipoProducto , cnuNVLTRC);
				
				
				-- Valida si el estado de corte existe en el parametro ESTACORT_NO_PERMI_CASTIGO 
				nuExisteEstadoCorte := pkg_parametros.fnuValidaSiExisteCadena('ESTACORT_NO_PERMI_CASTIGO', ',', nuEstadoCorte);
				pkg_traza.trace('Estado corte entre los permitidos(>0): ' || nuExisteEstadoCorte , cnuNVLTRC);
				
				-- Si no existe el estado de corte en el parametro
				IF (nuExisteEstadoCorte = 0) THEN
					--Caso 604_3 se cambio de lugar el registro de los proyectos
					--Fin Caso 604_3
					sbrespuesta := '0';
					dtfechaexcl := NULL;
					--
					--Caso 604_1
				ELSE
					sbmensajeinco := ' [ El producto (' || TO_CHAR(tbInfoUsuarioCastigar(nuInfoUsuaCastigarIdx).nuProducto) ||  ') no se encuentra en estado de corte valido para el proceso de castigo ] ';
					pkg_traza.trace('sbmensajeinco: ' || sbmensajeinco , cnuNVLTRC);
					
					--604_2
					sbrespuesta := 'El producto (' || TO_CHAR(tbInfoUsuarioCastigar(nuInfoUsuaCastigarIdx).nuProducto) || ') no tiene un estado de corte valido';
					pkg_traza.trace('sbrespuesta: ' || sbrespuesta , cnuNVLTRC);
					--
					dtfechaexcl := dtSysdate;
					pkg_traza.trace('dtfechaexcl: ' || dtfechaexcl , cnuNVLTRC);
					
					pkg_gestionarchivos.prcescribirlineasinterm_smf(vfileinco, sbmensajeinco);
				END IF;
			
				pkg_traza.trace('Val Estacort - Producto: ' || nuProducto 	|| CHR(10) ||
								'EstadoCorte: ' || nuEstadoCorte 			|| CHR(10) ||
								'sbRespuesta: '	|| sbRespuesta 				|| CHR(10) ||
								'dtFechaExcl: ' || dtFechaExcl, cnuNVLTRC); 
				
				-- Valida si el tipo de producto existe en el parametro TIPOPROD_VAL_ESTPROD_INCLU 
				nuValTipoProd := pkg_parametros.fnuValidaSiExisteCadena('TIPOPROD_VAL_ESTPROD_INCLU', ',', nuTipoProducto);
				pkg_traza.trace('Tipo Prod aplica(>0): ' || nuValTipoProd, cnuNVLTRC); 
				
				--Si no fallo por estado de corte, se valida el estado de producto
				IF (nuExisteEstadoCorte = 0 AND nuValTipoProd > 0) THEN
					
					-- Obtiene el plan de facturación del producto
					nuPlanFacturacion := pkg_bcproducto.fnuPlanFacturacion(nuProducto);
					pkg_traza.trace('Plan de facturación del producto es: ' || nuPlanFacturacion, cnuNVLTRC); 
					
					-- Obtiene el valor del parametro PLAN_FACTU_MEDIDOR_PREPAGO
					nuParamPlanMediPrepa := pkg_bcld_parameter.fnuObtieneValorNumerico('PLAN_FACTU_MEDIDOR_PREPAGO');
					pkg_traza.trace('nuParamPlanMediPrepa: ' || nuParamPlanMediPrepa, cnuNVLTRC); 
					
					-- Si el plan de facturación es 58
					IF (nuPlanFacturacion = nuParamPlanMediPrepa) THEN 
						sbRespuesta := '0';
						dtFechaExcl := NULL;
					ELSE
						-- Obtiene el estado del producto
						nuEstadoProd := pkg_bcproducto.fnuEstadoProducto(nuProducto);
						pkg_traza.trace('Estado del Prod: ' || nuEstadoProd , cnuNVLTRC); 
					
						-- Valida si el estado del producto existe en el parametro ESTPROD_NO_PERMI_CASTIGO 
						nuExisteEstaProd := pkg_parametros.fnuValidaSiExisteCadena('ESTPROD_NO_PERMI_CASTIGO', ',', nuEstadoProd);
						pkg_traza.trace('Estado del Prod entre los NO permitidos(>0): ' || nuExisteEstaProd, cnuNVLTRC); 
					
						IF (nuExisteEstaProd = 0) THEN
				
							sbRespuesta := '0';
							dtFechaExcl := NULL;
						ELSE
							sbmensajeinco := ' [ El producto (' || TO_CHAR(tbInfoUsuarioCastigar(nuInfoUsuaCastigarIdx).nuProducto) || ') no tiene estado de producto valido para el proceso de castigo] ';							
							sbRespuesta := 'El producto (' || TO_CHAR(tbInfoUsuarioCastigar(nuInfoUsuaCastigarIdx).nuProducto) || ') no tiene un estado de producto valido'; 					
							dtFechaExcl := dtSysdate; 					
							pkg_gestionarchivos.prcescribirlineasinterm_smf(vfileinco, sbmensajeinco);
						END IF;
					END IF;
				END IF;
				
				pkg_traza.trace('Val ProductStatus - Producto: ' || nuProducto 	|| CHR(10) || 
								'nuEstadoProd: ' 	|| nuEstadoProd				|| CHR(10) ||
								'sbRespuesta: ' 	|| sbRespuesta				|| CHR(10) ||
								'dtFechaExcl: ' 	|| dtFechaExcl, cnuNVLTRC); 
				
				--604_2
				--Inicio 604_3
				pkg_traza.trace('nuposicap: ' || nuposicap, cnuNVLTRC); 
				
				IF (tbproy_cast_inclu.EXISTS(nuposicap)) THEN
					
					pkg_traza.trace('Dato total_deuda del usuario a castigar: ' || NVL(tbInfoUsuarioCastigar(nuInfoUsuaCastigarIdx).nuTotalDeuda, 0), cnuNVLTRC); 
					tbproy_cast_inclu(nuposicap).total_deuda := tbproy_cast_inclu(nuposicap).total_deuda + NVL(tbInfoUsuarioCastigar(nuInfoUsuaCastigarIdx).nuTotalDeuda,  0);
					pkg_traza.trace('total_deuda: ' || tbproy_cast_inclu(nuposicap).total_deuda, cnuNVLTRC); 
					
					tbproy_cast_inclu(nuposicap).producto := tbproy_cast_inclu(nuposicap).producto + 1;
					pkg_traza.trace('producto: ' || tbproy_cast_inclu(nuposicap).producto, cnuNVLTRC); 
					
					nuconseproycast := tbproy_cast_inclu(nuposicap).contrato;
					pkg_traza.trace('consecutivo del proyecto de castigo: ' || nuconseproycast, cnuNVLTRC);
					
				ELSE
					
					sbmensaje := 'Error al registrar el proyecto de castigo.';
					
					-- Creamos el proyecto de castigo
					pkg_gc_proycast.prcInserRegistro(dtSysdate, 
													 'PRUEBA CASTIGO INCLUSION MANUAL POR PROCESO BASH ' || TO_CHAR(nuvatipr),
													 1,
													 1, 
													 0, 
													 0, 
													 NULL, 
													 nuvatipr, 
													 'SALD_CAST_PROC_BACH_' || TO_CHAR(nuvatipr),
													 nuconseproycast
													 );    
					 
					tbproy_cast_inclu(nuposicap).total_deuda := NVL(tbInfoUsuarioCastigar(nuInfoUsuaCastigarIdx).nuTotalDeuda, 0);
					pkg_traza.trace('total_deuda: ' || tbproy_cast_inclu(nuposicap).total_deuda, cnuNVLTRC);
					
					tbproy_cast_inclu(nuposicap).producto := 1;
					pkg_traza.trace('producto: ' || tbproy_cast_inclu(nuposicap).producto, cnuNVLTRC);
					
					tbproy_cast_inclu(nuposicap).contrato := nuconseproycast;
					pkg_traza.trace('contrato: ' || tbproy_cast_inclu(nuposicap).contrato, cnuNVLTRC);
					
					IF (sbproyeccod IS NULL) THEN
						sbproyeccod := 'PROYECTO CASTIGO NRO(S) : ' || TO_CHAR(nuconseproycast);
					ELSE
						sbproyeccod := sbproyeccod || ',' || TO_CHAR(nuconseproycast);
					END IF;
					
					pkg_traza.trace('sbproyeccod: ' || sbproyeccod, cnuNVLTRC);
					
				END IF;
				
				--Fin Caso 604_3
				--se valida el consecutivo del proyecto
				IF (nuconseproycast IS NOT NULL) THEN
					
					pkg_traza.trace('Datos del usuario a Castigar ' 			|| CHR(10) ||
									'cliente: ' 		|| tbInfoUsuarioCastigar(nuInfoUsuaCastigarIdx).nuCliente 			|| CHR(10) ||
									'contrato: ' 		|| tbInfoUsuarioCastigar(nuInfoUsuaCastigarIdx).nuContrato 			|| CHR(10) ||
									'tipo_producto: '	|| tbInfoUsuarioCastigar(nuInfoUsuaCastigarIdx).nuTipoProducto 		|| CHR(10) ||
									'producto: '		|| tbInfoUsuarioCastigar(nuInfoUsuaCastigarIdx).nuProducto 			|| CHR(10) ||
									'estado_corte: '	|| tbInfoUsuarioCastigar(nuInfoUsuaCastigarIdx).nuEstadoCorte 		|| CHR(10) ||
									'categoria: '		|| tbInfoUsuarioCastigar(nuInfoUsuaCastigarIdx).nuCategoria 		|| CHR(10) ||
									'subcategoria: '	|| tbInfoUsuarioCastigar(nuInfoUsuaCastigarIdx).nuSubcategoria 		|| CHR(10) ||
									'departamento: '	|| tbInfoUsuarioCastigar(nuInfoUsuaCastigarIdx).nuDepartamento 		|| CHR(10) ||
									'localidad: '		|| tbInfoUsuarioCastigar(nuInfoUsuaCastigarIdx).nuLocalidad 		|| CHR(10) ||
									'ciclo: '			|| tbInfoUsuarioCastigar(nuInfoUsuaCastigarIdx).nuCiclo 			|| CHR(10) ||
									'deuda_facturada: '	|| tbInfoUsuarioCastigar(nuInfoUsuaCastigarIdx).nuDeudaFacturada	|| CHR(10) || 
									'deuda_diferida: '	|| tbInfoUsuarioCastigar(nuInfoUsuaCastigarIdx).nuDeudaDiferida 	|| CHR(10) ||
									'edad_deuda: '		|| tbInfoUsuarioCastigar(nuInfoUsuaCastigarIdx).nuEdadDeuda, cnuNVLTRC);                  
					
					--se registraran los hallazgos en la tabla gc_prodprca
					BEGIN
						-- Inserta registros en gc_prodprca
						pkg_gc_prodprca.prcInserRegistro(nuconseproycast, NULL, 1, TRIM(tbInfoUsuarioCastigar(nuInfoUsuaCastigarIdx).sbIdentificacion), 
														 tbInfoUsuarioCastigar(nuInfoUsuaCastigarIdx).nuCliente, tbInfoUsuarioCastigar(nuInfoUsuaCastigarIdx).nuContrato, 
														 tbInfoUsuarioCastigar(nuInfoUsuaCastigarIdx).nuTipoProducto, tbInfoUsuarioCastigar(nuInfoUsuaCastigarIdx).nuProducto, 
														 tbInfoUsuarioCastigar(nuInfoUsuaCastigarIdx).nuEstadoCorte, tbInfoUsuarioCastigar(nuInfoUsuaCastigarIdx).nuCategoria, 
														 tbInfoUsuarioCastigar(nuInfoUsuaCastigarIdx).nuSubcategoria, NULL, 
														 tbInfoUsuarioCastigar(nuInfoUsuaCastigarIdx).nuDepartamento, tbInfoUsuarioCastigar(nuInfoUsuaCastigarIdx).nuLocalidad, 
														 NULL, NULL, tbInfoUsuarioCastigar(nuInfoUsuaCastigarIdx).nuCiclo, NULL, NULL, NULL, 
														 tbInfoUsuarioCastigar(nuInfoUsuaCastigarIdx).nuDeudaFacturada, tbInfoUsuarioCastigar(nuInfoUsuaCastigarIdx).nuDeudaDiferida, 
														 tbInfoUsuarioCastigar(nuInfoUsuaCastigarIdx).nuEdadDeuda, 1, 2, 
														 'PRUEBA CASTIGO EN BACH ' || TO_CHAR(nuvatipr), dtFechaExcl, NULL, 0, 0, sbRespuesta, nuconsepp
														);
						
						pkg_traza.trace('INSERT INTO gc_prodprca: PRPCCONS[CONSE]= ' || nuconsepp || ', PRPCPRCA[PROYECTO DE CASTIGO]= ' || nuconseproycast ||
										', PRPCFEEX[FECHA DE EXCLUSION]= ' || dtFechaExcl || ', PRPCRECA[RESULTADO DE CASTIGO]=' || sbRespuesta ||
										', PRPCSACA[SALDO CASTIGADO]= 0, PRPCSARE[SALDO REACTIVADO]=0', cnuNVLTRC);   
					EXCEPTION
						WHEN OTHERS THEN
							sbmensajeinco := ' [ Error al procesar el producto : ' || TO_CHAR(tbInfoUsuarioCastigar(nuInfoUsuaCastigarIdx).nuProducto) || ' ' || SQLERRM || ' ] ';
							pkg_traza.trace('[ Error al procesar el producto : ' || TO_CHAR(tbInfoUsuarioCastigar(nuInfoUsuaCastigarIdx).nuProducto) || ' ' || SQLERRM || ' ] ', cnuNVLTRC);  
							pkg_gestionarchivos.prcescribirlineasinterm_smf(vfileinco, sbmensajeinco);
					END;
				ELSE
					sbmensajeinco := ' [ Error al procesar el producto : ' || to_char(tbInfoUsuarioCastigar(nuInfoUsuaCastigarIdx).nuProducto) || ' no tiene un proyecto de castigo ] ';
					pkg_traza.trace('[ Error al procesar el producto : ' || to_char(tbInfoUsuarioCastigar(nuInfoUsuaCastigarIdx).nuProducto) || ' no tiene un proyecto de castigo ]', cnuNVLTRC);
					pkg_gestionarchivos.prcescribirlineasinterm_smf(vfileinco, sbmensajeinco);
				END IF;
				
				nucantiregcom := nucantiregcom + 1;
				
				IF (nucantiregcom >= nucontareg) THEN
					COMMIT;
					nucantiregtot := nucantiregtot + nucantiregcom;
					nucantiregcom := 0;
				END IF;
			
			nuInfoUsuaCastigarIdx := tbInfoUsuarioCastigar.NEXT(nuInfoUsuaCastigarIdx);
			
			END LOOP;
		END LOOP;
		
		-- Fin de archivo
		
		pkg_gestionarchivos.prccerrararchivo_smf(vfile);
		pkg_gestionarchivos.prccerrararchivo_smf(vfileinco);
		
		-- Actualizamos el proyecto de castigo
		FOR i IN 1 .. tbproy_cast_inclu.COUNT LOOP
			-- Actualiza el producto a castigar
			pkg_gc_proycast.prcActProductoCastigar(tbproy_cast_inclu(i).contrato,
												   tbproy_cast_inclu(i).producto
												   );
												   
			-- Actualiza el saldo a castigar
			pkg_gc_proycast.prcActSaldoCastigar(tbproy_cast_inclu(i).contrato,
												tbproy_cast_inclu(i).total_deuda
												);
			
			pkg_traza.trace('UPDATE gc_proycast where prcacons= ' || tbproy_cast_inclu(i).contrato, cnuNVLTRC);
		END LOOP;
		
		COMMIT;
		
		nucantiregtot := nucantiregtot + nucantiregcom;
		pkg_traza.trace('nucantiregtot: '||nucantiregtot, cnuNVLTRC);
		
		IF (sbmensajeinco IS NULL) THEN
			sbmensaje := 'Proceso terminó Ok: se procesaron : ' || TO_CHAR(nucantiregtot) || ' registros. ' || TRIM(sbproyeccod);
			sbOk      := 'Ok';
		ELSE
			sbmensaje := 'Proceso terminó con inconsistencias: se procesaron : ' || TO_CHAR(nucantiregtot) || ' registros. Revisar archivo de inconsistencias. ' || TRIM(sbproyeccod);
			sbOk      := 'Nok';
		END IF;
		
		pkg_traza.trace('sbmensaje: ' || sbmensaje, cnuNVLTRC);
		pkg_estaproc.practualizaestaproc(sbNameProceso, sbOk, sbmensaje); 
		pkg_gestionprocesosprogramados.prc_ActEstadoLogProceso(nuLogProceso, 'F');

		pkg_traza.trace(csbMETODO, cnuNVLTRC, pkg_traza.csbFIN);
		
	EXCEPTION
		WHEN pkg_error.CONTROLLED_ERROR THEN
			pkg_error.setError;
			pkg_Error.getError(nuError, sbmensaje);
			pkg_traza.trace('nuError: ' || nuError || ' sbmensaje: ' || sbmensaje, cnuNVLTRC);
			pkg_traza.trace(csbSP_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC); 
			RAISE pkg_error.CONTROLLED_ERROR;
		WHEN others THEN
			pkg_Error.setError;
			pkg_Error.getError(nuError, sbmensaje);
			pkg_traza.trace('nuError: ' || nuError || ' sbmensaje: ' || sbmensaje, cnuNVLTRC);
			pkg_traza.trace(csbSP_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR); 
			RAISE pkg_Error.Controlled_Error;
	END prcProcesa;

END pkg_boinclusioncastigocartera;
/
PROMPT OtorgANDo permisos de ejecución para adm_person.pkg_boinclusioncastigocartera
BEGIN
    pkg_utilidades.prAplicarPermisos(UPPER('pkg_boinclusioncastigocartera'), 'PERSONALIZACIONES');
END;
/