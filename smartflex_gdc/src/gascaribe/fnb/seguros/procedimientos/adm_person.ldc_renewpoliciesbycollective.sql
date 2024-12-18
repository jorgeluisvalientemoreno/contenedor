CREATE OR REPLACE PROCEDURE adm_person.ldc_renewpoliciesbycollective
(
	inuLinea	IN 	NUMBER,
	inuTipoReno IN 	NUMBER,
	inuDatoReno IN	NUMBER
) 
IS
	/***********************************************************************************************************************
	Propiedad intelectual de PETI .

	Unidad         : LDC_RenewPoliciesByCollective
	Descripcion    : Procedimiento de renovacion de polizas a partir del colectivo
	Autor          : Lyda Larrarte
	Fecha          : 14-10-2014

	Parametros              Descripcion
	============         ===================

	Fecha             Autor             Modificacion
	=========       =========           ====================
    27/06/2024      Lubin Pineda    OSF-2606: * Se usa pkg_Correo
    30/04/2024      PACOSTA         OSF-2598: Se crea el objeto en el esquema adm_person     
    10/04/2024      Lubin Pineda    OSF-2379: Reemplazo de utl_file por pkg_gestionArchivos
                                    e implementación de últimos estandares de 
                                     programación
    27/11/2023   	jsoto  			 Ajustes ((OSF-1807)):
									-Ajustes cambio en llamado a algunos de los objetos de producto por personalizados
									-Ajuste  cambio en manejo de trazas y errores por personalizados (pkg_error y pkg_traza).
									-Ajuste llamado a pkg_xml_sol_seguros para armar los xml de las solicitudes
									-Ajuste llamado a api_registerRequestByXml
									-Ajuste llamado a api_createorder, api_assign_order en reemplazo de api's de producto

	04/04/2023	  	cgonzalez			OSF-952: Se modifica para adicionar log en estaprog, eliminar aplica entregas y mejoras de rendimiento
	22/11/2022		cgonzalez			OSF-689: Se modifica para procesar todas las lineas de productos cuando se 
												selecciona la opcion "-1 - Todos"
	06/04/2021      Olsoftware		  CA 718  Se modifica para que cuente las cuotas pendientes pero del diferido de la poliza
	15/03/2019      Rcolpas             CA200-2324  Se modifica para agregar la descripcion RENOVACION
									  campo DESCRIPTION_POLICY tabla ld_policy


	18/09/2017      Karem Baquero       CA-200-1480  Se modifca la consulta donde se menciona el parametro
									  MIN_QUOT_RENEW, para que el condicional sea sysdate-fecha_inicial >MIN_QUOT_RENEW
									  Tambi?n se agrega el llamado al paquete <<ldc_pkrenewpolicies>> que dependiendo de la opci?n que
									  se tome en la forma LDRPC entonces realiza la consulta. Tambi?n se le coloca que no haga nada si
									  el proceso de la solicitud sale bien.
	21/09/2015      Agordillo.SAO334174  Se modifica la logica para que cuando se envie el correo email.
									   Se adjunte el archivo .CSV
	02/09/2015      Spacheco ARa 8586   se modifica proceso para que al momento de identificar la categoria y el estrato de la poliza
									  a renovar lo haga teniendo en cuenta la que esta asociada al producto a esta.
	08/07/2015      mgarcia.SAO334174   Se modifica proceso para que genere un
									  archivo de log de errores en formato csv.
	29/02/2015      Spacheco(ARA 6745)  se adiciona validacion para que Solo renueve nuevas vigencias si cumple con
									  tener los 12 meses de la vigencia de la poliza (calculados a partir de la fecha
									  fin de vigencia menos la fecha inicio de vigencia de la poliza) menos los meses
									  configurados en el parametro MIN_QUOT_RENEW.
	12/03/2015      SPacheco (ARA 6165) se mejora log de proceso
	29-12-2014      Llozada [ARA 5843]  Se obtiene el POLICY_ID de la poliza para traer la venta
	29/10/2020	  	Miguel Ballesteros  Se valida si la unidad operativa y el tipo de poliza esten en la tabla LDC_CONDESPRENOVSEG en los campos de origen,
									  si llega a estar alli se procede a realizar el proceso de renovacion con los datos configurados en los campos 
									  Unidad operativa Destino (Aseguradora Destino) y tipo de póliza de destino de la tabla LDC_CONDESPRENOVSEG.

	*****************************************************************************************************************************/

	sbAsunto 	varchar2(2000);

	cnuZERO 	constant number := ld_boconstans.cnuCero_Value;
	cnuONE  	constant number := LD_BOConstans.cnuonenumber;
	nuMonth   	number;
	nudatreno 	number;

	rfCursorPolicy constants_per.tyRefCursor;
	nuNextPolicy   number;
	nuStateRenew   ld_parameter.numeric_value%TYPE;
	nuGeo          ge_geogra_location.geograp_location_id%TYPE;
	nuadd          ab_address.address%TYPE;

	nuOrderPay 			ld_parameter.numeric_value%TYPE;
	nuOrderCharge     	ld_parameter.numeric_value%TYPE;
	nuorderid         	or_order.order_id%TYPE;
	nuorderactivityid 	or_order_activity.order_activity_id%TYPE;

	rfPolicy     LD_BOConstans.rfPolicy%type;
	nuPolicy     ld_policy.policy_id%type;
	nuValue      number;
	
	rcPolicyType 			dald_policy_type.styLD_policy_type;
	rcValidityPolicyType 	dald_validity_policy_type.styLD_validity_policy_type;

	nuSolicNoRen  number;
	nuPackage     mo_packages.package_id%type;
	nuerror       number;
	sbmessage     varchar2(2000);
	
	/*Variables de archivo de log*/
	sbLog            varchar2(500); -- Log de errores
	sbLineLog        varchar2(1000);
	sbFileManagement pkg_gestionArchivos.styArchivo;
	sbTimeProc       varchar2(500);
	sbPath           varchar2(500);

	nuSuscripc suscripc.susccodi%type;
	onuSusc    suscripc.susccodi%type;
	nuServsusc servsusc.sesunuse%type;

	frfOperating constants_per.tyrefcursor;
	recOrope     or_operating_unit%ROWTYPE;

	nuUnitOper     mo_packages.pos_oper_unit_id%type;
	dtEndpolicy    ld_validity_policy_type.final_date%type;
	dtIniPolicy    ld_validity_policy_type.initial_date%type;
	nugesubs       ge_subscriber.subscriber_id%type;
	nurecptype     ld_parameter.numeric_value%type;
	nuplandif      ld_parameter.numeric_value%type;
	sbState        ld_parameter.value_chain%type;
	nuCategory     ab_segments.category_%type;
	nuSubcategory  ab_segments.subcategory_%type;
	rcSecureSale   dald_secure_sale.styLD_secure_sale;
	nuContactId    suscripc.suscclie%type;
	sbXML          constants_per.tipo_xml_sol%TYPE;
	nuPackageId    mo_packages.package_id%type;
	nuMotiveId     mo_motive.motive_id%type;
	nuErrorCode    NUMBER;
	sbErrorMessage VARCHAR2(4000);
	nuValiPolTyp   number;
	nuordervalue   number;
	-- bloqueo del proceso
	blHasCateg         boolean;
	blSamePolType      boolean;
	nuNewPolicyTyp     ld_policy_type.policy_type_id%type;
	nuCategory_        subcateg.sucacate%type;
	nuSubcategory_     subcateg.sucacodi%type;
	nuSubscriber       ge_subscriber.subscriber_id%type;
	nuProductLine      ld_policy_type.product_line_id%type;
	nuContratista      ld_policy_type.contratista_id%type;
	nuChangePolTyp     number;
	nuMaxQuotRenew     number;
	nuMinQuota		   number;
	nuLastPolicyId     ld_policy.policy_id%type;
	nuCollectiveNumber number;
	nuCollectNumber	   number;
	sbProdLineDesc	   varchar2(500);
	sbPrograma         estaprog.esprprog%Type := 'LDRPC';
	nuEstaprog         NUMBER;
	nuTotalRecords	   NUMBER;
	nuProcessedRecords NUMBER;
	sbInstanciaBD 	   VARCHAR2(100);
	csbMetodo  	  		CONSTANT VARCHAR2(100) := 'LDC_RENEWPOLICIESBYCOLLECTIVE';

	------------
	sbFile            varchar2(500);
	sbLineFile        varchar2(1000);
	sbFileManagementf pkg_gestionArchivos.styArchivo;
	------------

	--11-12-2014 Llozada [NC 4230]
	type tyPoliza is record(
	sbLinea varchar2(4000));
	type tbtyPoliza is table of tyPoliza index by binary_integer;
	tbPoliza tbtyPoliza;

	nuContador   number := 1;
	nuIndex      number;
	nuPolicy_ID  ld_policy.policy_id%type;
	nuCantCommit number;

	vnuexito     number := 0; --10-03-2015 sPACHECO [ARA 6165]:se adiciona variable contador para identificar polizas renovadas
	vnunoexito   number := 0; --10-03-2015 sPACHECO [ARA 6165]:se adiciona variable contador para identificar polizas norenovadas
	sbDestinatarios  ld_parameter.value_chain%TYPE; --10-03-2015 sPACHECO [ARA 6165]:Direccion de email que recibe
	sbMensaje   varchar2(4000); --10-03-2015 sPACHECO [ARA 6165]:almacena descripcion notificacion

	NUpolRe number;
	sbdataorder       	   VARCHAR2 (2000);

	NuExistPol	   number;
	nuValCaso539	   number := 0;
	
	sbCodStateRenew ld_parameter.value_chain%TYPE := pkg_BCLD_Parameter.fsbObtieneValorCadena(LD_BOConstans.cnuCodStateRenew);

	------------------------

	/*29-12-2014 Llozada [ARA 5843]: Se obtiene el POLICY_ID de la poliza para traer la venta*/
	CURSOR cuPolicy(inuProductId in servsusc.sesunuse%type) IS
	SELECT policy_id
	  FROM (SELECT /*+ index(ld_policy IDX_LD_POLICY_03) */
				   policy_id
			  FROM ld_policy
			 WHERE product_id = inuProductId
			   AND state_policy = sbCodStateRenew
			 ORDER BY dtcreate_policy desc)
	 where rownum = 1;
	
	-- cursor para validar la informacion de la unidad operativa y del tipo de poliza CASO 539
	Cursor cuValConfAsegura(nuOperating		or_operating_unit.operating_unit_id%type,
							nuTipopoliza	ld_policy_type.policy_type_id%type)is
		
		select tipo_poli_dest tiPolDest,
			   corriente_descuen DescCorr
		from LDC_CONDESPRENOVSEG
		where und_oper_org = nuOperating
		and   tipo_poli_org = nuTipopoliza;
			
	rcCondesprenovseg 		cuValConfAsegura%ROWTYPE;
	
	-- cursor para obtener la informacion del tipo de poliza
	Cursor cuGetInfoTipoPoliza (nuTipoPol	ld_policy_type.policy_type_id%type) is
	
		SELECT lp.contratista_id contratista, 
			   lp.product_line_id linea_producto,
			   (select operating_unit_id 
					from or_operating_unit 
						where contractor_id = ld.contratistas_id 
						and rownum = 1) unidad_operativa
		FROM ld_policy_type lp,
			 ld_prod_line_ge_cont ld, 
			 ld_validity_policy_type lvpt
		WHERE lvpt.policy_type_id = lp.policy_type_id
		and sysdate between lvpt.initial_date AND lvpt.final_date
		and lp.contratista_id = ld.contratistas_id
		and lp.product_line_id = ld.product_line_id
		and lp.policy_type_id = nuTipoPol;
		
	rcInfoTipoPoliza 		cuGetInfoTipoPoliza%ROWTYPE;

      CURSOR cuLastQuota(inuPolizaId in ld_policy.policy_id%type) IS
      SELECT nvl(difenucu - difecupa,0)
        FROM diferido, ld_policy
       WHERE  policy_id = inuPolizaId
        and   difecodi = deferred_policy_id;
      nuCantCuotas number:=0;

	CURSOR cuLineaProducto(inuLineaProducto in ld_product_line.product_line_id%type)IS
		SELECT 	product_line_id
		FROM 	ld_product_line
		WHERE 	product_line_id = DECODE(inuLineaProducto, -1, product_line_id, inuLineaProducto)
		ORDER BY product_line_id ASC;
		
		
	CURSOR cuCantPolizas(inuPoliza ld_policy.policy_id%TYPE, 
						 inuMinCuota NUMBER)IS
		SELECT count(1)
		FROM ld_policy P
		WHERE policy_id = inuPoliza
		and  months_between(sysdate , DT_IN_POLICY) > inuMinCuota
		and state_policy = 1;

	CURSOR cuSoliRenov(inuPoliza ld_policy.policy_id%TYPE)IS
		SELECT or_order_activity.PACKAGE_ID
		FROM ld_renewall_securp,
						or_order,
						or_order_activity,
						ge_causal
		WHERE ld_renewall_securp.policy_id = inuPoliza
		AND or_order_activity.package_id = ld_renewall_securp.package_id
		AND or_order_activity.order_id = or_order.order_id
		AND or_order.order_status_id = 8
		AND or_order.causal_id = ge_causal.causal_id
		AND ge_causal.class_causal_id = 2
		AND rownum = 1;

				
	TYPE tytbLineaProducto IS TABLE OF cuLineaProducto%ROWTYPE INDEX BY BINARY_INTEGER;
	tbLineaProducto tytbLineaProducto;
		
	nuIdx 	NUMBER;
	
BEGIN

	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
  
	nuMonth := inuTipoReno;

	nudatreno := inuDatoReno;

	IF (dald_parameter.fblExist(LD_BOConstans.csbCodStatePolicy) AND
		dald_parameter.fblExist(LD_BOConstans.cnuCodStateRenew) AND
		dald_parameter.fblexist(LD_BOConstans.CsbActivityPay) AND
		dald_parameter.fblexist(LD_BOConstans.CsbActivityCharge) AND
		dald_parameter.fblexist('FINANCING_PLAN_ID') AND
		dald_parameter.fblexist('COD_REC_TYPE') AND
		dald_parameter.fblexist('FNB_CANT_COMMIT_PROC_RENEW')) THEN

    
		sbPath 		  := pkg_BCLD_Parameter.fsbObtieneValorCadena(LD_BOConstans.csbRutLogs);
		nuOrderPay    := to_number(pkg_BCLD_Parameter.fsbObtieneValorCadena(LD_BOConstans.CsbActivityPay));
		nuOrderCharge := to_number(pkg_BCLD_Parameter.fsbObtieneValorCadena(LD_BOConstans.CsbActivityCharge));
		nurecptype    := pkg_BCLD_Parameter.fnuObtieneValorNumerico('COD_REC_TYPE');
		nuplandif     := pkg_BCLD_Parameter.fnuObtieneValorNumerico('FINANCING_PLAN_ID');
		sbState       := pkg_BCLD_Parameter.fsbObtieneValorCadena(LD_BOConstans.csbCodStatePolicy);
		nuStateRenew  := pkg_BCLD_Parameter.fsbObtieneValorCadena(LD_BOConstans.cnuCodStateRenew);
		nuCantCommit  := pkg_BCLD_Parameter.fnuObtieneValorNumerico('FNB_CANT_COMMIT_PROC_RENEW');
		
		nuMaxQuotRenew := pkg_BCLD_Parameter.fnuObtieneValorNumerico(ld_boconstans.csbMaxQuotRenew);
		nuMinQuota	   := pkg_BCLD_Parameter.fnuObtieneValorNumerico('MIN_QUOT_RENEW');
		
		--identifica parametro de correo de recibe notificacion de renovacion de seguro
		sbDestinatarios := pkg_BCLD_Parameter.fsbObtieneValorCadena('EMAIL_RENO_RENSEGU');

		OPEN cuLineaProducto(inuLinea);
		FETCH cuLineaProducto BULK COLLECT INTO tbLineaProducto;
		CLOSE cuLineaProducto;
		
		nuIdx := tbLineaProducto.first;
		
		WHILE (nuIdx IS NOT NULL) LOOP
		
			nuProductLine := tbLineaProducto(nuIdx).product_line_id;
            vnunoexito := 0;
            vnuexito := 0;
			
			sbTimeProc := TO_CHAR(SYSDATE, 'yyyymmdd_hh24miss');

			/* Arma nombre del archivo LOG */
			sbLog := 'RE_' || nuProductLine || '_' || sbTimeProc || '.LOG';
			/* Arma nombre del archivo CSV */
			sbFile := 'RE_' || nuProductLine || '_'  || sbTimeProc || '.CSV'; -- SAO[334174]
			/* Crea archivo Log */
			sbFileManagement := pkg_gestionArchivos.ftAbrirArchivo_SMF(sbPath, sbLog, 'w');
			/* Crea archivo Csv */
			sbFileManagementf := pkg_gestionArchivos.ftAbrirArchivo_SMF(sbPath, sbFile, 'w'); -- SAO[334174]

			sbLineLog := ' INICIO PROCESO DE RENOVACION ' || TO_CHAR(SYSDATE, 'DD/MM/YYYY HH24:MI:SS');

			pkg_gestionArchivos.prcEscribirLinea_SMF(sbFileManagement, sbLineLog);

			sbLinefile := 'CONTRATO;PRODUCTO;POLIZA;COLECTIVO;VALOR;CAMPO;MENSAJE';
			pkg_gestionArchivos.prcEscribirLinea_SMF(sbFileManagementf, sbLinefile);

			IF nuStateRenew is not null THEN
				
				nuProcessedRecords := 0;
				nuTotalRecords := 0;
				
				IF nuMonth = 1 THEN
					/*Si es para renovar mes colectivo total caso 200-1480*/
					LDC_PKRenewPolicies.CountPolByCollecAndProdLine(nudatreno, nuProductLine, nuTotalRecords);
					LDC_PKRenewPolicies.getPolByCollecAndProdLine(nudatreno, nuProductLine, rfCursorPolicy);
				elsif nuMonth = 2 THEN
					/*Si es para renovar colectivo total caso 200-1480*/
					ldc_pkrenewpolicies.Countpolbycollectandprodline(nudatreno, nuProductLine, nuTotalRecords);
					ldc_pkrenewpolicies.getpolbycollectandprodline(nudatreno, nuProductLine, rfCursorPolicy);
				else
					/*Si es para renovar por p?liza caso 200-1480*/
					ldc_pkrenewpolicies.CountPolBypolizaAndProdLine(nudatreno, nuProductLine, nuTotalRecords);
					LDC_PKRenewPolicies.getPolBypolizaAndProdLine(nudatreno, nuProductLine,rfCursorPolicy);
				END IF;
				
				nuEstaprog := sqesprprog.nextval;
				
				pkstatusexeprogrammgr.addrecord(sbPrograma||'_'||nuProductLine||'_'||nuEstaprog, 'Calculando Registros a Procesar ...', 0);
				Pkgeneralservices.Committransaction;
					
				pkstatusexeprogrammgr.upstatusexeprogramat(sbPrograma||'_'||nuProductLine||'_'||nuEstaprog, 'Proceso en ejecucion...', nuTotalRecords, nuProcessedRecords);
				Pkgeneralservices.Committransaction;
			
				loop
					fetch rfCursorPolicy bulk collect into rfPolicy limit 100;
					nuNextPolicy := rfPolicy.first;
					
					while (nuNextPolicy is not null) loop
						SAVEPOINT TEMPPOLICY;
						nuPolicy := rfPolicy(nuNextPolicy).policy_number;
						--10-03-2015 sPACHECO [ARA 6165]:limpia variable para evitar doble registro en archivo plano
						sbLineLog  := null;
						sbLinefile := null;
						nuProcessedRecords := nuProcessedRecords + 1;

						BEGIN
							--Inicio ca 718
							nuCantCuotas:= ld_bcsecuremanagement.fnuGetPendQuotas(rfPolicy(nuNextPolicy).product_id);
							--Fin ca 718			 
							
							IF (nuCantCuotas > nuMaxQuotRenew) THEN
							
								nuCollectNumber := DAld_policy.fnuGetCOLLECTIVE_NUMBER(rfPolicy(nuNextPolicy).policy_id);
								
								-- SAO[334174]
								sbLinefile := rfPolicy(nuNextPolicy)
																.suscription_id || ';' || rfPolicy(nuNextPolicy)
																.product_id || ';' || rfPolicy(nuNextPolicy)
																.policy_number || ';' ||
																 nuCollectNumber || ';' ||
																 to_char(nuCantCuotas)|| ';' ||
																 'CUOTAS PENDIENTES' || ';' ||
																 'La poliza no cumple con la cantidad maxima de cuotas pendientes para ser renovada';
								pkg_gestionArchivos.prcEscribirLinea_SMF(sbFileManagementf, sbLinefile);
								/*10-03-2015 sPACHECO [ARA 6165]: Se obtiene adiciona Contrato/Producto/Poliza/colectivo
								al mensaje de log para hacerlo mas explicito*/
								sbLineLog := '[Contrato:' || rfPolicy(nuNextPolicy)
															.suscription_id || '- Producto:' || rfPolicy(nuNextPolicy)
															.product_id || '- Poliza:' || rfPolicy(nuNextPolicy)
															.policy_number || '- Colectivo:' ||
															 nuCollectNumber ||
															 '- Cuotas pendientes: ' ||
															to_char(nuCantCuotas)||
															 '] No cumple con la cantidad maxima de cuotas pendientes para ser renovada';
								--10-03-2015 sPACHECO [ARA 6165]:se adiciona contador para identificar polizas no renovadas
								vnunoexito := vnunoexito + 1;
								pkg_error.setErrorMessage(ld_boconstans.cnuGeneric_Error, sbLineLog);

							END IF;

							--29-05-2015 Spacheco (ARA 6745): se adiciona para que validacion para que
							--Solo renueve nuevas vigencias si cumple con tener los 12 meses de la vigencia de la poliza
							--(calculados a partir de la fecha fin de vigencia menos la fecha inicio de vigencia de la poliza)
							--menos los meses configurados en el parametro MIN_QUOT_RENEW.
							/*Se modifica para el caso 200-1480 para reajustar el calculo a tener en cuenta en el momento en que se define
							cuanto es el tiempo minimo para ser renovada la p?liza*/
							
							IF cuCantPolizas%ISOPEN THEN
								CLOSE cuCantPolizas;
							END IF;
							
							OPEN cuCantPolizas(rfPolicy(nuNextPolicy).policy_id,nuMinQuota);
							FETCH cuCantPolizas INTO NUpolRe;
							CLOSE cuCantPolizas;
							

							IF NUpolRe = 0 THEN
							
								nuCollectNumber := DAld_policy.fnuGetCOLLECTIVE_NUMBER(rfPolicy(nuNextPolicy).policy_id);
								
								-- SAO[334174]
								sbLinefile := rfPolicy(nuNextPolicy)
																.suscription_id || ';' || rfPolicy(nuNextPolicy)
																.product_id || ';' || rfPolicy(nuNextPolicy)
																.policy_number || ';' ||
																 nuCollectNumber || ';' || rfPolicy(nuNextPolicy)
																.policy_number || ';' || 'NUMERO POLIZA' || ';' ||
																 'La poliza no ha cumplido la vigencia para ser renovada';
								pkg_gestionArchivos.prcEscribirLinea_SMF(sbFileManagementf, sbLinefile);
								/*10-03-2015 sPACHECO [ARA 6165]: Se obtiene adiciona Contrato/Producto/Poliza/colectivo
								al mensaje de log para hacerlo mas explicito*/
								sbLineLog := '[Contrato:' || rfPolicy(nuNextPolicy)
															.suscription_id || '- Producto:' || rfPolicy(nuNextPolicy)
															.product_id || '- Poliza:' || rfPolicy(nuNextPolicy)
															.policy_number || '- Colectivo:' ||
															 nuCollectNumber ||
															 '- Numero poliza: ' || rfPolicy(nuNextPolicy)
															.policy_number ||
															 '] La poliza no ha cumplido la vigencia para ser renovada';
									--10-03-2015 sPACHECO [ARA 6165]:se adiciona contador para identificar polizas no renovadas
								vnunoexito := vnunoexito + 1;
								pkg_error.setErrorMessage(ld_boconstans.cnuGeneric_Error, sbLineLog);

							END IF;

							IF (LD_BCSecureManagement.fblHasPendSales(rfPolicy(nuNextPolicy).product_id)) THEN
								
								nuCollectNumber := DAld_policy.fnuGetCOLLECTIVE_NUMBER(rfPolicy(nuNextPolicy).policy_id);								
								
									-- SAO[334174]
								sbLinefile := rfPolicy(nuNextPolicy)
																.suscription_id || ';' || rfPolicy(nuNextPolicy)
																.product_id || ';' || rfPolicy(nuNextPolicy)
																.policy_number || ';' ||
																 nuCollectNumber || ';' || rfPolicy(nuNextPolicy)
																.product_id || ';' || 'PRODUCTO' || ';' ||
																 'El producto tiene solicitudes de ventas de seguros sin atender';
								pkg_gestionArchivos.prcEscribirLinea_SMF(sbFileManagementf, sbLinefile);
								/*10-03-2015 sPACHECO [ARA 6165]: Se obtiene adiciona Contrato/Producto/Poliza/colectivo
								al mensaje de log para hacerlo mas explicito*/
								sbLineLog := '[Contrato:' || rfPolicy(nuNextPolicy)
															.suscription_id || '- Producto:' || rfPolicy(nuNextPolicy)
															.product_id || '- Poliza:' || rfPolicy(nuNextPolicy)
															.policy_number || '- Colectivo:' ||
															 nuCollectNumber ||
															 '- Producto: ' || rfPolicy(nuNextPolicy)
															.product_id ||
															 '] El producto tiene solicitudes de ventas de seguros sin atender';
								--10-03-2015 sPACHECO [ARA 6165]:se adiciona contador para identificar polizas no renovadas
								vnunoexito := vnunoexito + 1;

								pkg_error.setErrorMessage(ld_boconstans.cnuGeneric_Error, sbLineLog);

							END IF;

							nuChangePolTyp := cnuZERO;

							/*Valida si el tipo de poliza tiene configurado categoria y subcategoria*/
							blHasCateg := LD_BCSecureManagement.fblPolicyTypeHasCateg(rfPolicy(nuNextPolicy).policy_type_id);

							IF blHasCateg THEN
								nuSubscriber := pkg_bccontrato.fnuidcliente(rfPolicy(nuNextPolicy).suscription_id);

								--spacheco ara 8586 --tomar la categoria del producto asociado a la poliza a renovar
								nuCategory_ := pkg_bcproducto.fnucategoria(rfPolicy(nuNextPolicy).product_id);
								
								--spacheco ara 8586 --tomar el estrato del producto asociado a la poliza a renovar
								nuSubcategory_ := pkg_bcproducto.fnusubcategoria(rfPolicy(nuNextPolicy).product_id);

								/*Valida a partir de la categoria y subcategoria del cliente si se puede aplicar el mismo tipo de p?liza*/
								blSamePolType := LD_BCSecureManagement.fblSamePolicyType(rfPolicy(nuNextPolicy).policy_type_id,nuCategory_,nuSubcategory_);
								
								IF not blSamePolType THEN
									nuProductLine := dald_policy_type.fnuGetPRODUCT_LINE_ID(rfPolicy(nuNextPolicy).policy_type_id);
									nuContratista := dald_policy_type.fnuGetCONTRATISTA_ID(rfPolicy(nuNextPolicy).policy_type_id);
									
									/*Obtiene un nuevo tipo de p?liza de acuerdo a la categoria y subcategoria*/
									LD_BCSecureManagement.GetNewPolicyType(nuProductLine,nuContratista,nuCategory_,nuSubcategory_,nuNewPolicyTyp);
									
									IF nuNewPolicyTyp is null THEN
									
										nuCollectNumber := DAld_policy.fnuGetCOLLECTIVE_NUMBER(rfPolicy(nuNextPolicy).policy_id);
										
										-- SAO[334174]
										sbLinefile := rfPolicy(nuNextPolicy).suscription_id || ';' || rfPolicy(nuNextPolicy)
																		.product_id || ';' || rfPolicy(nuNextPolicy)
																		.policy_number || ';' ||
																		 nuCollectNumber || ';' || rfPolicy(nuNextPolicy)
																		.policy_type_id || ';' || 'TIPO POLIZA' || ';' ||
																		 'No existe un tipo de poliza que cubra la categoria [' ||
																		 nuCategory_ || '] o la subcategoria [' ||
																		 nuSubcategory_ || ']';
										pkg_gestionArchivos.prcEscribirLinea_SMF(sbFileManagementf, sbLinefile);
										/*10-03-2015 sPACHECO [ARA 6165]: Se obtiene adiciona Contrato/Producto/Poliza/colectivo
										al mensaje de log para hacerlo mas explicito*/
										sbLineLog := '[Contrato:' || rfPolicy(nuNextPolicy)
																	.suscription_id || '- Producto:' || rfPolicy(nuNextPolicy)
																	.product_id || '- Poliza:' || rfPolicy(nuNextPolicy)
																	.policy_number || '- Colectivo:' ||
																	 nuCollectNumber ||
																	 '- Tipo poliza: ' || rfPolicy(nuNextPolicy)
																	.policy_type_id ||
																	 '] No existe un tipo de poliza que cubra la categoria [' ||
																	 nuCategory_ || '] o la subcategoria [' ||
																	 nuSubcategory_ || ']';
										--10-03-2015 sPACHECO [ARA 6165]:se adiciona contador para identificar polizas no renovadas
										vnunoexito := vnunoexito + 1;
										pkg_error.setErrorMessage(ld_boconstans.cnuGeneric_Error,
																											 sbLineLog);

									else
											
										rfPolicy(nuNextPolicy).policy_type_id := nuNewPolicyTyp;
										nuChangePolTyp := cnuONE;

									END IF;

								END IF;
							END IF;
						
							-- se valida CASO 539--
							IF(cuValConfAsegura%isopen)THEN
								close cuValConfAsegura;
							END IF;
					
							dald_policy_type.getRecord(rfPolicy(nuNextPolicy).policy_type_id,rcPolicyType);
					
							-- se busca la unidad operativa
							frfOperating := ld_bcsecuremanagement.frfGetOperating(rcPolicyType.policy_type_id);
							
							FETCH frfOperating INTO recOrope;
							
							nuUnitOper := recOrope.operating_unit_id;
							
							CLOSE frfOperating;
					
							-- se valida si la unidad operativa y el tipo de poliza esten en la tabla LDC_CONDESPRENOVSEG en los campos de origen
							open cuValConfAsegura(nuUnitOper, rfPolicy(nuNextPolicy).policy_type_id);
							fetch cuValConfAsegura into rcCondesprenovseg;
							IF(cuValConfAsegura%found)THEN
								NuExistPol:= 1;
							else
								NuExistPol:= 0;
							END IF;
							close cuValConfAsegura;
					
							-- si es mayor a 0 es porque existe un registro en la tabla
							IF(NuExistPol = 1)THEN					
						
								IF(cuGetInfoTipoPoliza%isopen)THEN
									close cuGetInfoTipoPoliza;
								END IF;
						
								open cuGetInfoTipoPoliza (rcCondesprenovseg.tiPolDest);
								fetch cuGetInfoTipoPoliza into rcInfoTipoPoliza;
								close cuGetInfoTipoPoliza;
						
								nuUnitOper := rcInfoTipoPoliza.unidad_operativa;
								rfPolicy(nuNextPolicy).policy_type_id:= rcCondesprenovseg.tiPolDest;
								nuValCaso539 := 1;
								--- se actualiza el valor de la asguradora 
								rfPolicy(nuNextPolicy).contratist_code := rcInfoTipoPoliza.contratista;
								--- se actualiza el valor de la linea de producto
								rfPolicy(nuNextPolicy).product_line_id := rcInfoTipoPoliza.linea_producto;
						
							END IF;
							-- FIN CASO 539--
					
							dald_policy_type.getRecord(rfPolicy(nuNextPolicy).policy_type_id, rcPolicyType);
								
							/*Obtiene la vigencia para el tipo de poliza*/
							ld_bcsecuremanagement.GetValidityPolicyType(rcPolicyType.policy_type_id, ldc_boconsgenerales.fdtgetsysdate,nuValiPolTyp);

							-- Se obtiene el record de la Vigencia por Tipo de Poliza   -- JCASTRO
							IF (nuValiPolTyp IS not null) THEN

								dald_validity_policy_type.getRecord(nuValiPolTyp,rcValidityPolicyType);

							else
								nuCollectNumber := DAld_policy.fnuGetCOLLECTIVE_NUMBER(rfPolicy(nuNextPolicy).policy_id);
								
								-- SAO[334174]
								sbLinefile := rfPolicy(nuNextPolicy).suscription_id || ';' || rfPolicy(nuNextPolicy)
																.product_id || ';' || rfPolicy(nuNextPolicy)
																.policy_number || ';' ||
																 nuCollectNumber || ';' || rfPolicy(nuNextPolicy)
																.policy_type_id || ';' || 'TIPO POLIZA' || ';' ||
																 'El tipo de poliza no se encuentra vigente para el numero de poliza';
								pkg_gestionArchivos.prcEscribirLinea_SMF(sbFileManagementf, sbLinefile);
									/*10-03-2015 sPACHECO [ARA 6165]: Se obtiene adiciona Contrato/Producto/Poliza/colectivo
									al mensaje de log para hacerlo mas explicito*/
								sbLineLog := '[Contrato:' || rfPolicy(nuNextPolicy)
															.suscription_id || '- Producto:' || rfPolicy(nuNextPolicy)
															.product_id || '- Poliza:' || rfPolicy(nuNextPolicy)
															.policy_number || '- Colectivo:' ||
															 nuCollectNumber ||
															 '- Tipo poliza: ' || rfPolicy(nuNextPolicy)
															.policy_type_id ||
															 '] El tipo de poliza no se encuentra vigente para el numero de poliza';
									--10-03-2015 sPACHECO [ARA 6165]:se adiciona contador para identificar polizas no renovadas
								vnunoexito := vnunoexito + 1;
								pkg_error.setErrorMessage(ld_boconstans.cnuGeneric_Error,
																									 sbLineLog);

							END IF;

							--- se valida que el producto no se encuentre en un estdo de retiro voluntario
							IF (pkg_bcproducto.fnuestadocorte(rfPolicy(nuNextPolicy).product_id) in (94, 95)) THEN
								
								nuCollectNumber := DAld_policy.fnuGetCOLLECTIVE_NUMBER(rfPolicy(nuNextPolicy).policy_id);
								
								-- SAO[334174]
								sbLinefile := rfPolicy(nuNextPolicy).suscription_id || ';' || rfPolicy(nuNextPolicy)
																.product_id || ';' || rfPolicy(nuNextPolicy)
																.policy_number || ';' ||
																 nuCollectNumber || ';' ||
																 pkg_bcproducto.fnuestadocorte(rfPolicy(nuNextPolicy)
																															.product_id) || ';' ||
																 'ESTADO CORTE' || ';' ||
																 'El producto se encuentra en proceso de retiro voluntario';
								pkg_gestionArchivos.prcEscribirLinea_SMF(sbFileManagementf, sbLinefile);
								/*10-03-2015 sPACHECO [ARA 6165]: Se obtiene adiciona Contrato/Producto/Poliza/colectivo
								al mensaje de log para hacerlo mas explicito*/
								sbLineLog := '[Contrato:' || rfPolicy(nuNextPolicy)
															.suscription_id || '- Producto:' || rfPolicy(nuNextPolicy)
															.product_id || '- Poliza:' || rfPolicy(nuNextPolicy)
															.policy_number || '- Colectivo:' ||
															 nuCollectNumber ||
															 '- Estado Corte: ' ||
															 pkg_bcproducto.fnuestadocorte(rfPolicy(nuNextPolicy)
																														.product_id) ||
															 '] El producto se encuentra en proceso de retiro voluntario';
									--10-03-2015 sPACHECO [ARA 6165]:se adiciona contador para identificar polizas no renovadas
								vnunoexito := vnunoexito + 1;
								pkg_error.setErrorMessage(ld_boconstans.cnuGeneric_Error,
																									 sbLineLog);

							END IF;

							/*Retorna 1 si la fecha del sistema se encuentra entre el rango*/
							ld_bcsecuremanagement.GetPolicyType(rfPolicy(nuNextPolicy).policy_type_id,nuValue);

							dtIniPolicy := dald_policy.fdtGetDT_EN_POLICY(rfPolicy(nuNextPolicy).policy_id);
							
							IF (dtIniPolicy IS null) THEN
								dtIniPolicy := trunc(sysdate);
							else
								dtIniPolicy := trunc(dtIniPolicy + 1);
							END IF;

							/*Retorna la fecha final con la que se creara la poliza*/
							dtEndPolicy := Ld_BcSecureManagement.fdtfechendtypoli(rcValidityPolicyType.coverage_month,dtIniPolicy); -- JCASTRO

							/*Obtiene el contrato al cual se encuentra asociado la poliza*/
							ld_bcsecuremanagement.GetSuscPol(rfPolicy(nuNextPolicy).policy_id,onuSusc);

								-- se valida si se tiene un producto de gas activo
							begin
								-- SAO[334174]
								ld_bosecuremanagement.ProcValidateProductparam(onuSusc);
							exception
								WHEN others THEN
								
									nuCollectNumber := DAld_policy.fnuGetCOLLECTIVE_NUMBER(rfPolicy(nuNextPolicy).policy_id);
									
									sbLinefile := rfPolicy(nuNextPolicy)
																	.suscription_id || ';' || rfPolicy(nuNextPolicy)
																	.product_id || ';' || rfPolicy(nuNextPolicy)
																	.policy_number || ';' ||
																	 nuCollectNumber || ';' || rfPolicy(nuNextPolicy)
																	.suscription_id || ';' || 'CONTRATO' || ';' ||
																	 'El producto de gas no cumple con los estados del parametro [COD_STATE_PROD_SECURE]';
									pkg_gestionArchivos.prcEscribirLinea_SMF(sbFileManagementf, sbLinefile);

									sbLineLog := '[Contrato:' || rfPolicy(nuNextPolicy)
																.suscription_id || '- Producto:' || rfPolicy(nuNextPolicy)
																.product_id || '- Poliza:' || rfPolicy(nuNextPolicy)
																.policy_number || '- Colectivo:' ||
																 nuCollectNumber ||
																 '- Contrato: ' || rfPolicy(nuNextPolicy)
																.suscription_id ||
																 '] El producto de gas no cumple con los estados del parametro [COD_STATE_PROD_SECURE]';

									vnunoexito := vnunoexito + 1;
									pkg_error.setErrorMessage(ld_boconstans.cnuGeneric_Error,
																										 sbLineLog);
							END;

							/*Identifica si una poliza tiene solicitudes de no renovaci?n con orden en estado cerrado*/
							nuSolicNoRen := Ld_BcSecureManagement.GetSolicNoRenewall(rfPolicy(nuNextPolicy).policy_id);
							
							IF (nuSolicNoRen = 0) THEN
								--{ nuSolicNoRen
								IF (nuValue = 1) THEN
									--{ nuvalue
									/* Se obtiene la Categoria y Subcategoria dado el producto */
									nuCategory := pkg_BCProducto.fnuCategoria(rfPolicy(nuNextPolicy).product_id);
									
									nuSubcategory := pkg_BCProducto.fnuSubCategoria(rfPolicy(nuNextPolicy).product_id);

									/* Se obtine el suscriptor del contrato */
									nuContactId := pkg_bccontrato.fnuidcliente(rfPolicy(nuNextPolicy).suscription_id);

										/* Actualizar poliza anterior */
									dald_policy.updComments(rfPolicy(nuNextPolicy).policy_id, 'Esta poliza fue renovada');

									dald_policy.updState_Policy(rfPolicy(nuNextPolicy).policy_id,nuStateRenew);

									/*Obtiene la ultima poliza asociada al producto que se renovo*/
									nuPolicy := ld_bcsecuremanagement.fnuGetRenewPolicyByProduct(rfPolicy(nuNextPolicy).product_id);

										/*29-12-2014 Llozada [ARA 5843]: Se obtiene el POLICY_ID de la poliza para traer la venta*/
									open cuPolicy(rfPolicy(nuNextPolicy).product_id);
									fetch cuPolicy into nuPolicy_ID;
									close cuPolicy;

									/* Se obtiene la fecha de nacimiento de la venta de seguros */
									rcSecureSale := Ld_BcSecureManagement.fnuGetSecureSale(nuPolicy_ID);	

									/* Se crea la poliza nueva a traves del tramite de Venta de Seguros por XML */
									
									sbXML:= pkg_xml_sol_seguros.getSolicitudVentaSeguros(
																						 rfPolicy(nuNextPolicy).suscription_id,
																						 nurecptype,
																						 'Poliza creada por proceso de renovacion de seguros',
																						 ldc_boconsgenerales.fdtgetsysdate,
																						 NULL,
																						 nuContactId,
																						 nuplandif,
																						 NULL,
																						 nuCategory,
																						 nuSubcategory,
																						 'N',
																						 rfPolicy(nuNextPolicy).contratist_code,
																						 rcSecureSale.identification_id,
																						 rfPolicy(nuNextPolicy).product_line_id,
																						 rcSecureSale.born_date,
																						 rcPolicyType.policy_type_id,
																						 nuPolicy,
																						 rcValidityPolicyType.policy_value,
																						 NULL,
																						 NULL,
																						 rfPolicy(nuNextPolicy).product_id
																						 );

									pkg_traza.trace('sbXML '||sbXML, pkg_traza.cnuNivelTrzDef);

									api_registerRequestByXml(sbXML,
															nuPackageId,
															nuMotiveId,
															nuErrorCode,
															sbErrorMessage);
															
									-- SAO[334174]
									IF (nuPackageId is not null) THEN
										null; --se cambia caso 200-1480
										 -- commit;
									else
										
										nuCollectNumber := DAld_policy.fnuGetCOLLECTIVE_NUMBER(rfPolicy(nuNextPolicy).policy_id);
									
										sbLinefile := rfPolicy(nuNextPolicy)
																		.suscription_id || ';' || rfPolicy(nuNextPolicy)
																		.product_id || ';' || rfPolicy(nuNextPolicy)
																		.policy_number || ';' ||
																		 nuCollectNumber || ';' ||
																		 nuPolicy || ';' || 'POLIZA' || ';' ||
																		 'Error creando solicitud de venta de seguros para poliza, Error(' ||
																		 nuErrorCode || ') : ' || sbErrorMessage;
										pkg_gestionArchivos.prcEscribirLinea_SMF(sbFileManagementf, sbLinefile);

										sbLineLog := '[Contrato:' || rfPolicy(nuNextPolicy)
																	.suscription_id || '- Producto:' || rfPolicy(nuNextPolicy)
																	.product_id || '- Poliza:' || rfPolicy(nuNextPolicy)
																	.policy_number || '- Colectivo:' ||
																	 nuCollectNumber ||
																	 '- Poliza: ' || nuPolicy ||
																	 '] Error creando solicitud de venta de seguros para poliza, Error(' ||
																	 nuErrorCode || ') : ' || sbErrorMessage;

										vnunoexito := vnunoexito + 1;
										pkg_error.setErrorMessage(nuErrorCode, sbErrorMessage);
										RAISE pkg_error.controlled_error;

									END IF;

									/*Obtiene un identificador asociado al numero de la poliza*/
									nuLastPolicyId := ld_bcsecuremanagement.fnuGetIdByPolicyNumber(nuPolicy);

									-- se actualiza la nueva poliza con las fechas correspondientes segun la poliza anterior
									IF (dald_policy.fblExist(nuLastPolicyId)) THEN
											dald_policy.updDT_IN_POLICY(nuLastPolicyId, dtIniPolicy);
											dald_policy.updDT_EN_POLICY(nuLastPolicyId, dtEndPolicy);
									END IF;
									
									nuCollectiveNumber := DAld_policy.fnuGetCOLLECTIVE_NUMBER(rfPolicy(nuNextPolicy).policy_id);

									update ld_policy
									set collective_number = nuCollectiveNumber,
												 description_policy = 'RENOVACION' --C200-2324
									where policy_id = nuLastPolicyId;

									/*Se obtiene la unidad operativa del tipo de poliza, esta unidad operativa se usara para la
									asignacion de ordenes*/

									---- validacion CASO 539 ---
									IF(nuValCaso539 = 0)THEN
										frfOperating := ld_bcsecuremanagement.frfGetOperating(rcPolicyType.policy_type_id);
										FETCH frfOperating
										INTO recOrope;
										nuUnitOper := recOrope.operating_unit_id;
										CLOSE frfOperating;
									END IF;
									---- fin validacion CASO 539 ---
						

									nuSuscripc := rfPolicy(nuNextPolicy).suscription_id;
									nuServsusc := rfPolicy(nuNextPolicy).product_id;
									ld_bosecuremanagement.GetAddressBySusc(nuSuscripc,nuadd,nuGeo);

									/*Se obtiene la informacion del cliente a raiz del suscriptor*/
									nugesubs := pkg_bccontrato.fnuidcliente(nuSuscripc);

									-- Crea orden de facturacion
									nuorderid         := null;
									nuorderactivityid := null;
																			
									api_createorder(
													nuOrderPay,
													nuPackageId,
													nuMotiveId,
													NULL,
													NULL,
													nuadd,                 
													NULL,
													nugesubs, 
													nuSuscripc, 
													nuServsusc,
													NULL,
													NULL,
													NULL,
													'Orden de pago para la aseguradora',
													FALSE,
													NULL,
													NULL,
													NULL,
													NULL,
													NULL,
													NULL,
													0,
													NULL,
													TRUE,
													NULL,
													NULL,
													nuorderid,
													nuorderactivityid,
													nuErrorCode,
													sbErrorMessage
													);


									api_assign_order(nuOrderId,
													 nuUnitOper,
													 nuErrorCode,
													 sbErrorMessage);

									IF nuUnitOper is null THEN
										nuCollectNumber := DAld_policy.fnuGetCOLLECTIVE_NUMBER(rfPolicy(nuNextPolicy).policy_id);
									
										-- SAO[334174]
										sbLinefile := rfPolicy(nuNextPolicy)
																		.suscription_id || ';' || rfPolicy(nuNextPolicy)
																		.product_id || ';' || rfPolicy(nuNextPolicy)
																		.policy_number || ';' ||
																		 nuCollectNumber || ';' ||
																		 nuPolicy || ';' || 'POLIZA' || ';' ||
																		 'no se pudo asignar la orden de pago [' ||
																		 nuorderid || '] a la aseguradora';
										pkg_gestionArchivos.prcEscribirLinea_SMF(sbFileManagementf, sbLinefile);
										/*10-03-2015 sPACHECO [ARA 6165]: Se obtiene adiciona Contrato/Producto/Poliza/colectivo
										al mensaje de log para hacerlo mas explicito*/
										sbLineLog := '[Contrato:' || rfPolicy(nuNextPolicy)
																	.suscription_id || '- Producto:' || rfPolicy(nuNextPolicy)
																	.product_id || '- Poliza:' || rfPolicy(nuNextPolicy)
																	.policy_number || '- Colectivo:' ||
																	 nuCollectNumber ||
																	 '- Poliza: ' || nuPolicy ||
																	 '] No se pudo asignar la orden de pago [' ||
																	 nuorderid || '] a la aseguradora';
										--10-03-2015 sPACHECO [ARA 6165]:se adiciona contador para identificar polizas no renovadas
										vnunoexito := vnunoexito + 1;
										pkg_error.setErrorMessage(ld_boconstans.cnuGeneric_Error,sbLineLog);

									END IF;

									/* Se legaliza la orden de pago con causal de exito*/
									
									sbdataorder := NULL;
									sbdataorder :=
										   nuOrderId
										|| '|'
										|| pkg_gestionordenes.cnucausalexito
										|| '|'
										|| LD_BOUtilFlow.fnuGetPersonToLegal(nuUnitOper)
										|| '||'
										|| nuorderactivityid
										|| '>'
										|| 1
										|| ';;;;|||1277;Legalizacion de la orden de cobro';

									
									api_legalizeorders (sbdataorder,
														SYSDATE,
														SYSDATE,
														SYSDATE,
														nuError,
														sbMessage
														);


									IF (nuError <> 0) THEN
									
										nuCollectNumber := DAld_policy.fnuGetCOLLECTIVE_NUMBER(rfPolicy(nuNextPolicy).policy_id);
										-- SAO[334174]
										sbLinefile := rfPolicy(nuNextPolicy).suscription_id || ';' || rfPolicy(nuNextPolicy)
																		.product_id || ';' || rfPolicy(nuNextPolicy)
																		.policy_number || ';' ||
																		 nuCollectNumber || ';' ||
																		 nuOrderId || ';' || 'ORDEN PAGO' || ';' ||
																		 'Error al tratar de legalizar la orden de pago con causal [' ||
																		 pkg_gestionordenes.cnucausalexito || ']';
										pkg_gestionArchivos.prcEscribirLinea_SMF(sbFileManagementf, sbLinefile);

										sbLineLog := '[Contrato:' || rfPolicy(nuNextPolicy)
																	.suscription_id || '- Producto:' || rfPolicy(nuNextPolicy)
																	.product_id || '- Poliza:' || rfPolicy(nuNextPolicy)
																	.policy_number || '- Colectivo:' ||
																	 nuCollectNumber ||
																	 '- Orden Pago: ' || nuOrderId ||
																	 '] Error al tratar de legalizar la orden de pago con causal [' ||
																	 pkg_gestionordenes.cnucausalexito || ']';

										vnunoexito := vnunoexito + 1;
										pkg_error.setErrorMessage(nuError, sbMessage);
										RAISE pkg_error.controlled_error;
									END IF;

									-- actualizar valor de liquidacion de la actividad
									nuordervalue := NULL;

									/* INICIO Modificaci?n para el caso 200-1054 campo comision para renovacion*/
									LD_BOSECUREMANAGEMENT.GETLIQUIDATIONSECUREVALUE(nuOrderId,nuordervalue);
									/* FIN Modificaci?n para el caso 200-1054 campo comision para renovacion*/

									daor_order_items.updvalue(daor_order_activity.fnugetorder_item_id(nuorderactivityid),nuordervalue);
									daor_order.updorder_value(daor_order_activity.fnugetorder_id(nuorderactivityid),nuordervalue);

									-- Crea orden de comision
									nuorderid         := null;
									nuorderactivityid := null;
																						
																						
									api_createorder(
													nuOrderCharge,
													nuPackageId,
													nuMotiveId,
													NULL,
													NULL,
													nuadd,                 
													NULL,
													nugesubs, 
													nuSuscripc, 
													nuServsusc,
													NULL,
													NULL,
													NULL,
													'Orden de cobro a la aseguradora',
													FALSE,
													NULL,
													NULL,
													NULL,
													NULL,
													NULL,
													NULL,
													0,
													NULL,
													TRUE,
													NULL,
													NULL,
													nuorderid,
													nuorderactivityid,
													nuErrorCode,
													sbErrorMessage
													);


									api_assign_order(nuOrderId,
													 nuUnitOper,
													 nuErrorCode, 
													 sbErrorMessage);

									IF nuUnitOper is null THEN
										
										nuCollectNumber := DAld_policy.fnuGetCOLLECTIVE_NUMBER(rfPolicy(nuNextPolicy).policy_id);
										
										-- SAO[334174]
										sbLinefile := rfPolicy(nuNextPolicy)
																		.suscription_id || ';' || rfPolicy(nuNextPolicy)
																		.product_id || ';' || rfPolicy(nuNextPolicy)
																		.policy_number || ';' ||
																		 nuCollectNumber || ';' ||
																		 nuPolicy || ';' || 'POLIZA' || ';' ||
																		 'no se pudo asignar la orden de comision [' ||
																		 nuorderid || '] a la aseguradora';
										pkg_gestionArchivos.prcEscribirLinea_SMF(sbFileManagementf, sbLinefile);
										/*10-03-2015 sPACHECO [ARA 6165]: Se obtiene adiciona Contrato/Producto/Poliza/colectivo
										al mensaje de log para hacerlo mas explicito*/
										sbLineLog := '[Contrato:' || rfPolicy(nuNextPolicy)
																	.suscription_id || '- Producto:' || rfPolicy(nuNextPolicy)
																	.product_id || '- Poliza:' || rfPolicy(nuNextPolicy)
																	.policy_number || '- Colectivo:' ||
																	 nuCollectNumber ||
																	 '- Poliza: ' || nuPolicy ||
																	 '] No se pudo asignar la orden de comision [' ||
																	 nuorderid || '] a la aseguradora';
											--10-03-2015 sPACHECO [ARA 6165]:se adiciona contador para identificar polizas no renovadas
										vnunoexito := vnunoexito + 1;
										pkg_error.setErrorMessage(ld_boconstans.cnuGeneric_Error,sbLineLog);

									else

										/* Se legaliza la orden de pago con causal de exito*/

										sbdataorder := NULL;
										sbdataorder :=
											   nuOrderId
											|| '|'
											|| pkg_gestionordenes.cnucausalexito
											|| '|'
											|| LD_BOUtilFlow.fnuGetPersonToLegal(nuUnitOper)
											|| '||'
											|| nuorderactivityid
											|| '>'
											|| 1
											|| ';;;;|||1277;Legalizacion de la orden de cobro';

										api_legalizeorders (sbdataorder,
															SYSDATE,
															SYSDATE,
															SYSDATE,
															nuError,
															sbMessage
															);


										IF (nuError <> 0) THEN
										
											nuCollectNumber := DAld_policy.fnuGetCOLLECTIVE_NUMBER(rfPolicy(nuNextPolicy).policy_id);
											
											-- SAO[334174]
											sbLinefile := rfPolicy(nuNextPolicy)
																			.suscription_id || ';' || rfPolicy(nuNextPolicy)
																			.product_id || ';' || rfPolicy(nuNextPolicy)
																			.policy_number || ';' ||
																			 nuCollectNumber || ';' ||
																			 nuOrderId || ';' || 'ORDEN COMISION' || ';' ||
																			 'Error al tratar de legalizar la orden de comision con causal [' ||
																			 pkg_gestionordenes.cnucausalexito || ']';
											pkg_gestionArchivos.prcEscribirLinea_SMF(sbFileManagementf, sbLinefile);

											sbLineLog := '[Contrato:' || rfPolicy(nuNextPolicy)
																		.suscription_id || '- Producto:' || rfPolicy(nuNextPolicy)
																		.product_id || '- Poliza:' || rfPolicy(nuNextPolicy)
																		.policy_number || '- Colectivo:' ||
																		 nuCollectNumber ||
																		 '- Orden Comision: ' || nuPolicy ||
																		 '] Error al tratar de legalizar la orden de comision con causal [' ||
																		 pkg_gestionordenes.cnucausalexito || ']';

											vnunoexito := vnunoexito + 1;
											pkg_error.setErrorMessage(nuError, sbMessage);
											RAISE pkg_error.controlled_error;
										END IF;

										-- se actualiza valor de la liquidacion
										nuordervalue := NULL;
										/* INICIO Modificaci?n para el caso 200-1054 campo comision para renovacion*/
										LD_BOSECUREMANAGEMENT.GETLIQUIDATIONSECUREVALUE(nuOrderId,nuordervalue);

										/* FIN Modificaci?n para el caso 200-1054 campo comision para renovacion*/
										daor_order_items.updvalue(daor_order_activity.fnugetorder_item_id(nuorderactivityid),nuordervalue);
										daor_order.updorder_value(daor_order_activity.fnugetorder_id(nuorderactivityid),nuordervalue);

									END IF;
								--} nuvalue
								ELSE
									nuCollectNumber := DAld_policy.fnuGetCOLLECTIVE_NUMBER(rfPolicy(nuNextPolicy).policy_id);
								
									-- SAO[334174]
									sbLinefile := rfPolicy(nuNextPolicy)
																	.suscription_id || ';' || rfPolicy(nuNextPolicy)
																	.product_id || ';' || rfPolicy(nuNextPolicy)
																	.policy_number || ';' ||
																	 nuCollectNumber || ';' || rfPolicy(nuNextPolicy)
																	.policy_type_id || ';' || 'TIPO POLIZA' || ';' ||
																	 'El tipo de poliza no se encuentra vigente para el numero de poliza';
									pkg_gestionArchivos.prcEscribirLinea_SMF(sbFileManagementf, sbLinefile);
									/*10-03-2015 sPACHECO [ARA 6165]: Se obtiene adiciona Contrato/Producto/Poliza/colectivo
									al mensaje de log para hacerlo mas explicito*/
									sbLineLog := '[Contrato:' || rfPolicy(nuNextPolicy)
																.suscription_id || '- Producto:' || rfPolicy(nuNextPolicy)
																.product_id || '- Poliza:' || rfPolicy(nuNextPolicy)
																.policy_number || '- Colectivo:' ||
																 nuCollectNumber ||
																 '- Tipo Poliza: ' || nuPolicy ||
																 '] El tipo de poliza no se encuentra vigente para el numero de poliza';
									--10-03-2015 sPACHECO [ARA 6165]:se adiciona contador para identificar polizas no renovadas
									vnunoexito := vnunoexito + 1;
									pkg_error.setErrorMessage(ld_boconstans.cnuGeneric_Error,sbLineLog);

								END IF;
							ELSE

								-- SAO[334174]
							
								BEGIN
								
									IF cuSoliRenov%ISOPEN THEN
										CLOSE cuSoliRenov;
									END IF;
									
									OPEN cuSoliRenov(rfPolicy(nuNextPolicy).policy_id);
									FETCH cuSoliRenov INTO nuPackage;
										IF cuSoliRenov%NOTFOUND THEN
											CLOSE cuSoliRenov;
											RAISE NO_DATA_FOUND;
										END IF;
									CLOSE cuSoliRenov;
									
								EXCEPTION
									WHEN NO_DATA_FOUND THEN
									RAISE pkg_error.controlled_error;
								END;
							
								
								nuCollectNumber := DAld_policy.fnuGetCOLLECTIVE_NUMBER(rfPolicy(nuNextPolicy).policy_id);

								sbLinefile := rfPolicy(nuNextPolicy)
																.suscription_id || ';' || rfPolicy(nuNextPolicy)
																.product_id || ';' || rfPolicy(nuNextPolicy)
																.policy_number || ';' ||
																 nuCollectNumber || ';' ||
																 nuPackage || ';' || 'SOLICITUD' || ';' ||
																 'La poliza tiene registrada una solicitud de no renovacion';
								pkg_gestionArchivos.prcEscribirLinea_SMF(sbFileManagementf, sbLinefile);
								/*10-03-2015 sPACHECO [ARA 6165]: Se obtiene adiciona Contrato/Producto/Poliza/colectivo
								al mensaje de log para hacerlo mas explicito*/
								sbLineLog := '[Contrato:' || rfPolicy(nuNextPolicy)
															.suscription_id || '- Producto:' || rfPolicy(nuNextPolicy)
															.product_id || '- Poliza:' || rfPolicy(nuNextPolicy)
															.policy_number || '- Colectivo:' ||
															 nuCollectNumber ||
															 '- Solicitud: ' || nuPackage ||
															 '] La poliza tiene registrada una solicitud de no renovacion';
								--10-03-2015 sPACHECO [ARA 6165]:se adiciona contador para identificar polizas no renovadas
								vnunoexito := vnunoexito + 1;
								pkg_error.setErrorMessage(ld_boconstans.cnuGeneric_Error,sbLineLog);

							END IF;

							IF sbLineLog is not null THEN
								pkg_gestionArchivos.prcEscribirLinea_SMF(sbFileManagement, sbLineLog);
							END IF;

							nuContador := nuContador + 1;

							IF nuChangePolTyp = cnuZERO THEN
							
								nuCollectNumber := DAld_policy.fnuGetCOLLECTIVE_NUMBER(rfPolicy(nuNextPolicy).policy_id);
								-- SAO[334174]
								sbLinefile := rfPolicy(nuNextPolicy)
																.suscription_id || ';' || rfPolicy(nuNextPolicy)
																.product_id || ';' || rfPolicy(nuNextPolicy)
																.policy_number || ';' ||
																 nuCollectNumber || ';' ||
																 nuPolicy || ';' || 'POLIZA RENOVADA' || ';' ||
																 'Nueva poliza creada para el asegurado [' || rfPolicy(nuNextPolicy)
																.name_insured ||
																 ']. El proceso ha terminado con exito.';
								pkg_gestionArchivos.prcEscribirLinea_SMF(sbFileManagementf, sbLinefile);
								/*10-03-2015 sPACHECO [ARA 6165]: Se obtiene adiciona Contrato/Producto/Poliza/colectivo
								al mensaje de log para hacerlo mas explicito*/
								sbLineLog := '[Contrato:' || rfPolicy(nuNextPolicy)
															.suscription_id || '- Producto:' || rfPolicy(nuNextPolicy)
															.product_id || '- Poliza:' || rfPolicy(nuNextPolicy)
															.policy_number || '- Colectivo:' ||
															 nuCollectNumber ||
															 '- Poliza Renovada: ' || nuPolicy ||
															 '] Nueva poliza creada para el asegurado [' || rfPolicy(nuNextPolicy)
															.name_insured ||
															 ']. El proceso ha terminado con exito.';

								tbPoliza.delete;
								tbPoliza(nuContador).sbLinea := sbLineLog;
								--10-03-2015 sPACHECO [ARA 6165]:se adiciona contador para identificar polizas renovadas
								vnuexito := vnuexito + 1;
							else
								nuCollectNumber := DAld_policy.fnuGetCOLLECTIVE_NUMBER(rfPolicy(nuNextPolicy).policy_id);
								-- SAO[334174]
								sbLinefile := rfPolicy(nuNextPolicy)
																.suscription_id || ';' || rfPolicy(nuNextPolicy)
																.product_id || ';' || rfPolicy(nuNextPolicy)
																.policy_number || ';' ||
																 nuCollectNumber || ';' ||
																 nuPolicy || ';' || 'POLIZA RENOVADA' || ';' ||
																 'La poliza creada con diferente tipo de poliza por cambio de categoria. El proceso ha terminado con exito.';
								pkg_gestionArchivos.prcEscribirLinea_SMF(sbFileManagementf, sbLinefile);
								/*10-03-2015 sPACHECO [ARA 6165]: Se obtiene adiciona Contrato/Producto/Poliza/colectivo
								al mensaje de log para hacerlo mas explicito*/
								sbLineLog := '[Contrato:' || rfPolicy(nuNextPolicy)
															.suscription_id || '- Producto:' || rfPolicy(nuNextPolicy)
															.product_id || '- Poliza:' || rfPolicy(nuNextPolicy)
															.policy_number || '- Colectivo:' ||
															 nuCollectNumber ||
															 '- Poliza Renovada: ' || nuPolicy ||
															 '] La poliza creada con diferente tipo de poliza por cambio de categoria. El proceso ha terminado con exito.';

								tbPoliza.delete;
								tbPoliza(nuContador).sbLinea := sbLineLog;
									--10-03-2015 sPACHECO [ARA 6165]:se adiciona contador para identificar polizas renovadas
								vnuexito := vnuexito + 1;
							END IF;
									
							--- CASO 539 ---
							-- se valida el campo (Descuenta corriente) si esta en N debe registrar la informacion en la tabla de migracion
							IF(rcCondesprenovseg.DescCorr = 'N')THEN
						
								declare
							
									poliAnt 	ld_policy.policy_id%type;
									poliNew 	ld_policy.policy_id%type;
							
									Cursor CugetInfoPolAnt (nuContrato   ld_policy.suscription_id%type) is
										select policy_id
										from ld_policy 
										where suscription_id = nuContrato
										and  product_id = rfPolicy(nuNextPolicy).product_id
										and  state_policy = 5; -- poliza renovada;
										
									Cursor CugetInfoPolNew (nuContrato   ld_policy.suscription_id%type) is
										select policy_id
										from ld_policy 
										where suscription_id = nuContrato
										and  product_id = rfPolicy(nuNextPolicy).product_id
										and  state_policy = 1; -- poliza activa;
								
								begin
						
									IF(CugetInfoPolAnt%isopen)THEN
										close CugetInfoPolAnt;
									END IF;
							
									open CugetInfoPolAnt(rfPolicy(nuNextPolicy).suscription_id);
									fetch CugetInfoPolAnt into poliAnt;
									close CugetInfoPolAnt;
							
									IF(CugetInfoPolNew%isopen)THEN
										close CugetInfoPolNew;
									END IF;
							
									open CugetInfoPolNew(rfPolicy(nuNextPolicy).suscription_id);
									fetch CugetInfoPolNew into poliNew;
									close CugetInfoPolNew;
							
									IF(poliAnt > 0 and poliNew > 0)THEN
							
										Insert into LDC_MIGRAPOLIZA (
														POLIZA_ANT,
														POLIZA_RENOV,
														FECHA_RENOV,
														IDENT_USER
													)
										values  (	
														poliAnt, -- poliza anterior
														poliNew, --poliza renovada	
														sysdate,
														pkg_bopersonal.fnugetpersonaid -- usuario
													);
									END IF;

								END;

							END IF;
							--- FIN CASO 539 ---
										
							IF mod(nuContador, nuCantCommit) = 0 THEN
								IF tbPoliza.count > 0 THEN
									nuIndex := tbPoliza.first;
									commit;
									loop
										pkg_gestionArchivos.prcEscribirLinea_SMF(sbFileManagement,tbPoliza(nuIndex).sbLinea);
										EXIT WHEN nuIndex = tbPoliza.LAST();
										nuIndex := tbPoliza.next(nuIndex);
									END loop;
									
									pkstatusexeprogrammgr.upstatusexeprogramat(sbPrograma||'_'||nuProductLine||'_'||nuEstaprog, 'Proceso en ejecucion...', nuTotalRecords, nuProcessedRecords);
									
								END IF;

								tbPoliza.delete;
							END IF;

						exception
							WHEN pkg_error.controlled_error THEN
								pkg_error.getError(nuError, sbMessage);
								IF sbLineLog IS NULL THEN
									sbLineLog := '     Error ... procesando la poliza ' ||
																 nuPolicy || ', Ruta: ' || sbPath || ' ' ||
																 sbLog || ' ' || sbmessage;
								END IF;
								pkg_gestionArchivos.prcEscribirLinea_SMF(sbFileManagement, sbLineLog);
								ROLLBACK TO TEMPPOLICY;
							WHEN others THEN
								pkg_error.setError;
								pkg_error.getError(nuError, sbMessage);
								IF sbLineLog IS NULL THEN
									sbLineLog := '     Error ... procesando la poliza ' ||
																 nuPolicy || ', Ruta: ' || sbPath || ' ' ||
																 sbLog || ' ' || sbmessage;
								END IF;
								pkg_gestionArchivos.prcEscribirLinea_SMF(sbFileManagement, sbLineLog);
								ROLLBACK TO TEMPPOLICY;
						END;
						
						nuNextPolicy := rfPolicy.next(nuNextPolicy);
					END LOOP;

					EXIT WHEN rfCursorPolicy%NOTFOUND;

				END loop;

				close rfCursorPolicy;
				
				pkstatusexeprogrammgr.upstatusexeprogramat(sbPrograma||'_'||nuProductLine||'_'||nuEstaprog, 'Proceso en ejecucion...', nuTotalRecords, nuProcessedRecords);
				Pkstatusexeprogrammgr.Processfinishnok(sbPrograma||'_'||nuProductLine||'_'||nuEstaprog, 'Proceso Finalizado');
				Pkgeneralservices.Committransaction;
				
			else
				sbLineLog := '     Error ... Los parametros que se utilizan se encuentran en blanco' || sbPath;
				pkg_gestionArchivos.prcEscribirLinea_SMF(sbFileManagement, sbLineLog);
			END IF;
			
			sbLineLog := 'Cantidad de polizas Renovadas con exito: ' || vnuexito;

			pkg_gestionArchivos.prcEscribirLinea_SMF(sbFileManagement, sbLineLog);

			sbLineLog := 'Cantidad de polizas No Renovadas con exito: ' || vnunoexito;

			pkg_gestionArchivos.prcEscribirLinea_SMF(sbFileManagement, sbLineLog);

			-- SAO[334174]
			sbLinefile := 'Polizas Procesadas' || ';' || (vnuexito + vnunoexito);
			pkg_gestionArchivos.prcEscribirLinea_SMF(sbFileManagementf, sbLinefile);
			sbLinefile := 'Polizas Renovadas' || ';' || vnuexito;
			pkg_gestionArchivos.prcEscribirLinea_SMF(sbFileManagementf, sbLinefile);
			sbLinefile := 'Polizas No Renovadas' || ';' || vnunoexito;
			pkg_gestionArchivos.prcEscribirLinea_SMF(sbFileManagementf, sbLinefile);

			pkg_gestionArchivos.prcCerrarArchivo_SMF(sbFileManagement);
			pkg_gestionArchivos.prcCerrarArchivo_SMF(sbFileManagementf); -- SAO[334174]

			commit;
			
			sbProdLineDesc := DALD_PRODUCT_LINE.fsbGetDescription(nuProductLine);

			sbMensaje := 'Notificacion de finalizacion de proceso de RENOVACION (o CANCELACION) para la linea ' ||
												nuProductLine || '-' ||
												sbProdLineDesc ||
												', el tipo de renovacion ' || nuMonth ||
												' y el dato de la renovacion ' || nudatreno || '.' || '<br><br>' ||
												'Cantidad de polizas Renovadas (o canceladas) con exito: ' ||
												vnuexito || '<br><br>' ||
												'Cantidad de polizas No Renovadas (o No Canceladas): ' ||
												vnunoexito || '<br><br>' ||
												'Para mayor detalle, dirijase al log generado en la ruta ' ||
												sbPath;

			sbAsunto := '';
			
			sbInstanciaBD := ldc_boconsgenerales.fsbgetdatabasedesc();

			if (length(sbInstanciaBD) > 0) then
			  sbInstanciaBD := 'BD '||sbInstanciaBD||': ';
			end if;

			sbAsunto := sbInstanciaBD ||sbAsunto;

			sbAsunto := sbAsunto||'Finalizacion proceso de RENOVACION Linea ' ||
											nuProductLine || '-' ||
											sbProdLineDesc ||
											', tipo de renovacion ' || nuMonth ||
											' y dato de renovacion ' || nudatreno;

			BEGIN
			
                pkg_Correo.prcEnviaCorreo
                (
                    isbDestinatarios    => sbDestinatarios,
                    isbAsunto           => sbAsunto,
                    isbMensaje          => sbMensaje,
                    isbArchivos         => sbPath || '/' || sbFile
                );

			EXCEPTION
				WHEN pkg_error.controlled_error THEN
					pkg_error.setError;
				WHEN others THEN
					pkg_error.setError;
			END;
			-- Fin Agordillo SAO.334174
			nuIdx := tbLineaProducto.NEXT(nuIdx);
		END LOOP;
	END IF; --
	
	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
			
EXCEPTION
	WHEN pkg_error.controlled_error THEN
		pkg_error.setError;
		pkg_error.getError(nuerror,sbMessage);
		pkg_traza.trace(csbMetodo||' '||sbMessage, pkg_traza.cnuNivelTrzDef);
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
		RAISE;
	WHEN OTHERS THEN
		pkg_error.setError;
		pkg_error.getError(nuerror,sbMessage);
		pkg_traza.trace(csbMetodo||' '||sbMessage, pkg_traza.cnuNivelTrzDef);
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
		RAISE pkg_error.controlled_error;
END ldc_renewpoliciesbycollective;
/