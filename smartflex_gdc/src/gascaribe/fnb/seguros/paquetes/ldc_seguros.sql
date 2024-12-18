CREATE OR REPLACE PACKAGE LDC_SEGUROS is
/*******************************************************************************
    Fuente=Propiedad Intelectual de Gases del Caribe
    Paquete     : LDC_SEGUROS
    Autor       :   
    Fecha       :   
    Descripcion :
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    jpinedc     07-03-2024  OSF-2377    Se cambia el manejo a pkg_gestionArchivos
    jpinedc     14-03-2024  OSF-2377    Ajustes validación técnica
    jpinedc     29-03-2024  OSF-2377    Ajustes validación técnica 2
*******************************************************************************/

  Procedure ProcCancelSeguro;

  PROCEDURE GetAccWithBalOutOfDate(inuProduct  in servsusc.sesunuse%type,
                                   otbAccounts OUT pkBCCuenCobr.tytbAccounts);

End LDC_Seguros;
/

CREATE OR REPLACE PACKAGE BODY LDC_SEGUROS Is

	-- Constantes para el control de la traza
	csbSP_NAME		CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT||'.';
    cnuNVLTRC       CONSTANT NUMBER(2)  	:= pkg_traza.fnuNivelTrzDef;
	
	/*=========================================================================================================================
	Procedimiento: GetAccWithBalOutOfDate
	Descripción: 


	Autor: José Filigrana
	Historia de Modificaciones
	Fecha         Autor                 Modificacion
	=========   =========               ====================
	27/10/2023	jerazomvm				OSF-1808: 
										1. Se reemplazan el servicios:
											2.1. pkGeneralServices.fdtGetSystemDate por LDC_BOCONSGENERALES.FDTGETSYSDATE
	03/01/2023	cgonzalez				OSF-2157: Eliminar la instruccion pkg_error.setApplication
	==================================================================================================================================*/
	PROCEDURE GetAccWithBalOutOfDate(inuProduct  in servsusc.sesunuse%type,
                                     otbAccounts OUT pkBCCuenCobr.tytbAccounts) 
	IS
    
		csbMT_NAME  VARCHAR2(70) := csbSP_NAME || 'GetAccWithBalOutOfDate';
		
		-- Fecha actual
		dtCurrentDate date;
		--variable
		sbErrMsg 	GE_ERROR_LOG.DESCRIPTION%TYPE;
		nuCodError	NUMBER;

		-- CURSOR sobre la tabla cuentas de cobro
		CURSOR cuAccounts IS
		  SELECT *
			FROM cuencobr
		   WHERE cuconuse = inuProduct
			 AND nvl(cucosacu, 0) > 0
			 AND trunc(cucofeve) < trunc(dtCurrentDate);

	BEGIN
	
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.fsbINICIO);
		pkg_traza.trace('inuProduct: ' 	|| inuProduct, cnuNVLTRC);

		-- Asigna fecha actual para consulta
		dtCurrentDate := ldc_boconsgenerales.fdtgetsysdate;

		-- Verifica si encuentra deuda vencida
		open cuAccounts;
		fetch cuAccounts bulk collect into otbAccounts;
		close cuAccounts;
		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

	EXCEPTION
		when OTHERS then
			Pkg_Error.seterror;
			pkg_error.geterror(nuCodError, sbErrMsg);
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
			pkg_traza.trace('nuCodError: ' || nuCodError || ', sbErrMsg: ' || sbErrMsg, cnuNVLTRC);
			raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrMsg);
	END GetAccWithBalOutOfDate;

	/*=========================================================================================================================
	Procedimiento: ProcCancelSeguro
	Descripción: Permite la canelación de un seguro teniendo en cuenta una cantidad de cuentas con saldos
				   y unos días que estan definidos en un parametro, antes de ser facturado por medio de JOB lo desactice
			 se tiene en cuenta la tabla perifact, para hacer la validación de los días preevios a la facturación


	Autor: José Filigrana
	Historia de Modificaciones
	Fecha         Autor                 Modificacion
	=========   =========               ====================
	14/04/2015   SPacheco (ARA 6165)      se mejora log de RESULTADO
	03/11/2020   Miguel Ballesteros	  Se modifica el proceso para que no tenga en cuenta las polizas
										  que esten en la tabla de migracion LDC_MIGRAPOLIZA para el proceso de anulacion
	27/10/2023	jerazomvm				OSF-1808: 
										1. Se elimina la validación fblAplicaEntregaxCaso del caso 0000539
										2. Se reemplazan los servicios:
											2.1. pktblservsusc.fnuGetSesususc por PKG_BCPRODUCTO.FNUCONTRATO
											2.2. pktblsuscripc.fnugetsusccli por PKG_BCCONTRATO.FNUIDCLIENTE
											2.3. pkg_BOPersonal.fnuGetPersonaId por PKG_BOPERSONAL.FNUGETPERSONAID
											2.4. OS_RegisterRequestWithXML por api_registerRequestByXml
											2.5. dage_subscriber.styge_subscriber por pkg_bccliente.styClientes
											2.6. dage_subscriber.getrecord por pkg_bccliente.frcgetRecord
										3. Se ajusta reemplaza el llamado del XML por el servicio PKG_XML_SOL_SEGUROS.getSolicitudCancelaSeguros
	==================================================================================================================================*/
	PROCEDURE ProcCancelSeguro IS

		csbMT_NAME  VARCHAR2(70) := csbSP_NAME || 'ProcCancelSeguro';
		
		tbAccountcharge pktblservsusc.tySesunuse;
		tbAccounts      pkbccuencobr.tytbaccounts;
		nuServSus       servsusc.sesunuse%type;

		ionupoli       ld_policy.policy_id%type;
		nuprodsegu     ld_parameter.numeric_value%type;
		sbState        ld_parameter.value_chain%type;
		nuState        ld_parameter.numeric_value%type;
		nuRecepType    ld_parameter.numeric_value%type;
		nuGeo          ge_geogra_location.geograp_location_id%type;
		nuadd          ab_address.address%type;
		nugesubs       ge_subscriber.subscriber_id%type;
		rcGesubcri     pkg_bccliente.styClientes;
		nuAnswerId     ld_parameter.numeric_value%type;
		sbSol          VARCHAR2(100);
		sbRequestXML   constants_per.TIPO_XML_SOL%type;
		nuPackageId    mo_packages.package_id%type;
		nuMotiveId     mo_motive.motive_id%type;
		nuErrorCode    number;
		sbErrorMessage VARCHAR2(8000);
		nuCause        number;
		nususc         number;
		sbCanBySin     ld_parameter.value_chain%type; -- Parametro del tipo de cancelación

		/*Variables  de conexion*/
		sbFileManagementd pkg_gestionArchivos.styArchivo;

		sbPath varchar2(500);

		----
		sbLog     varchar2(500);
		sbLineLog varchar2(1000);
		----

		sbTimeProc    varchar2(100);
		nuGas_Service ld_parameter.numeric_value%type;
		nuPerVen      ld_parameter.numeric_value%type;
		nuFactProg    ld_parameter.numeric_value%type;

		nupolinocac  number := 0; --10-03-2015 sPACHECO [ARA 6165]:  CONTADOR POLIZA CANCELADA
		nupolicac    number := 0; --10-03-2015 sPACHECO [ARA 6165]:CONTADOR POLIZA NO CANCELADA
		vsbSendEmail ld_parameter.value_chain%TYPE; --10-03-2015 sPACHECO [ARA 6165]:Direccion de email quine firma el email
		vsbrecEmail  ld_parameter.value_chain%TYPE; --10-03-2015 sPACHECO [ARA 6165]:Direccion de email que recibe
		vsbmessage   VARCHAR2(2000); --10-03-2015 sPACHECO [ARA 6165]:MENSAJE LOG CORREO
		
		sbInstanciaBD   VARCHAR2(50);
		-- VARIABLES CASO 539 --
		nuValPolRen	   number;
		blpoli		   boolean := false;
		-- FIN VARIABLES CASO 539 --

		Cursor cuGetMigraPoli(nupoliza ld_policy.policy_id%type)is
			select count(1)
				from LDC_MIGRAPOLIZA
				where poliza_renov = nupoliza;

	BEGIN

		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.fsbINICIO);

		sbPath := dald_parameter.fsbGetValue_Chain(LD_BOConstans.csbRutLogs);
        
        pkg_traza.trace('sbPath: '||sbPath, cnuNVLTRC);

		sbTimeProc := TO_CHAR(SYSDATE, 'yyyymmdd_hh24miss');
		/* Arma nombre del archivo LOG */
		sbLog := 'AN_' || sbTimeProc || '.LOG';
		/* Crea archivo Log */
		sbFileManagementd := pkg_gestionArchivos.ftAbrirArchivo_SMF(sbPath, sbLog, 'w');
		sbLineLog         := 'INICIO PROCESO DE LECTURAS DE CANCELACIÓN DE PÓLIZAS ' ||
							 TO_CHAR(SYSDATE, 'DD/MM/YYYY HH24:MI:SS');

		pkg_gestionArchivos.prcEscribirLinea_SMF(sbFileManagementd, sbLineLog);

		if ((dald_parameter.fblexist(LD_BOConstans.cnuCodPerDefeated)) AND
		   (dald_parameter.fblexist(LD_BOConstans.cnuCodFactProg)) AND
		   (dald_parameter.fblexist(LD_BOConstans.csbCodStatePolicy)) AND
		   (dald_parameter.fblexist(LD_BOConstans.cnuCodTypeProduct))) then

			  nuGas_Service := LD_BOConstans.cnuGasService;
			  nuprodsegu    := DALD_PARAMETER.fnuGetNumeric_Value(LD_BOConstans.cnuCodTypeProduct);
			  nuPerVen      := DALD_PARAMETER.fnuGetNumeric_Value(LD_BOConstans.cnuCodPerDefeated);
			  nuFactProg    := DALD_PARAMETER.fnuGetNumeric_Value(LD_BOConstans.cnuCodFactProg);
			  sbState       := dald_parameter.fsbGetValue_Chain(LD_BOConstans.csbCodStatePolicy);
			  nuRecepType   := dald_parameter.fnuGetNumeric_Value(LD_BOConstans.cnuRecepType);
			  nuCause       := DALD_PARAMETER.fnuGetNumeric_Value('COD_CANCEL_CAUSAL_JOB',
																  null);
			  sbCanBySin    := DALD_PARAMETER.fsbGetValue_Chain(LD_BOConstans.csbCanBySin);

			  if ((nvl(nuGas_Service, LD_BOConstans.cnuCero) <>
				 LD_BOConstans.cnuCero) AND
				 (nvl(nuPerVen, LD_BOConstans.cnuCero) <> LD_BOConstans.cnuCero) AND
				 (nvl(nuFactProg, LD_BOConstans.cnuCero) <> LD_BOConstans.cnuCero) AND
				 (nvl(nuCause, LD_BOConstans.cnuCero) <> LD_BOConstans.cnuCero) AND
				 sbState is not null) then

				/* Busca los servicio suscrito cuya póliza tengan igual o mayor numero de
				periodos vencidos llamando al Ld_BcSecureManagemente.ProcSearchProduct */

				ld_bcsecuremanagement.ProcSearchProduct(nuprodsegu,
														sbState,
														tbAccountcharge);

			if tbAccountcharge.count > 0 then

			  for i in tbAccountcharge.FIRST .. tbAccountcharge.LAST loop

				if tbAccountcharge.EXISTS(i) then

				  nuServSus := tbAccountcharge(i);

				  /*Se obtiene el estado de la poliza */
				  nuState := to_number(substr(sbState,
											  1,
											  instr(sbState, '|', 1, 1) - 1));

				  nususc := PKG_BCPRODUCTO.FNUCONTRATO(nuServSus);

				  GetAccWithBalOutOfDate(nuServSus, tbAccounts);

				  if tbaccounts.count >= nuPerVen then

					ld_bcsecuremanagement.GetServsPolicy(nuServSus,
														 nuState,
														 ionupoli);

					-- INICIO CASO 539 --

					if(cuGetMigraPoli%isopen)then
						close cuGetMigraPoli;
					end if;

					open cuGetMigraPoli(ionupoli);
					fetch cuGetMigraPoli into nuValPolRen;
					close cuGetMigraPoli;

					blpoli := false;

					-- si es mayor a 0 es porque encontro el registro y no se anulará la poliza
					if(nuValPolRen > 0)then

						blpoli := true;

						-- variable para el conteo de poliza no anuladas
						nupolinocac := nupolinocac + 1;

						-- se deja el registro del log de no cancelacion de la poliza
						sbLineLog := 'No se puede anular la poliza = ['||ionupoli||'] porque esta renovada en la tabla de migracion LDC_MIGRAPOLIZA caso 539';
						pkg_gestionArchivos.prcEscribirLinea_SMF(sbFileManagementd, sbLineLog);

					end if;


					
					-- FIN CASO 539 --

					if(blpoli = false)then  --- CASO 539

						Ld_BoSecureManagement.GetAddressBySusc(nususc,
														   nuadd,
														   nuGeo);

						/*Se obtiene la información del cliente a raíz del suscriptor*/
						nugesubs := PKG_BCCONTRATO.FNUIDCLIENTE(nususc);
									   
						pkg_traza.trace('El codigo del cliente' || ' - ' || nugesubs, cnuNVLTRC);

						/*Se obtiene el record del cliente*/
						rcGesubcri := pkg_bccliente.frcgetRecord(nugesubs);

						sbSol := sbCanBySin;
						
						sbRequestXML := PKG_XML_SOL_SEGUROS.getSolicitudCancelaSeguros(PKG_BOPERSONAL.FNUGETPERSONAID,
																					   nuRecepType,
																					   'Cancelacion de seguros por no pago JOB',
																					   trunc(sysdate),
																					   nuadd,
																					   nugesubs,
																					   nususc,
																					   ionupoli,
																					   nuAnswerId,
																					   nuCause,
																					   'Se cancelo la poliza',
																					   sbSol
																					   );

						api_registerRequestByXml(sbRequestXML,
												 nuPackageId,
												 nuMotiveId,
												 nuErrorCode,
												 sbErrorMessage);
												 
						pkg_traza.trace('Finaliza api_registerRequestByXml nuPackageId:' 	 || nuPackageId || chr(10) ||
																		  'nuMotiveId: ' 	 || nuMotiveId  || chr(10) ||
																		  'nuErrorCode: ' 	 || nuErrorCode || chr(10) ||
																		  'sbErrorMessage: ' || sbErrorMessage, cnuNVLTRC);

						/*10-03-2015 sPACHECO [ARA 6165]: Se obtiene adiciona Contrato/Producto/Poliza/colectivo
						al mensaje de log para hacerlo mas explicito*/
						pkg_gestionArchivos.prcEscribirLinea_SMF(sbFileManagementd,
											  '[Contrato:' || nususc ||
											  '- Producto:' || nuServSus ||
											  '- Póliza:' || ionupoli ||
											  '- Colectivo:' ||
											  DAld_policy.fnuGetCOLLECTIVE_NUMBER(ionupoli) || ']' ||
											  'Codigo ' || nuErrorCode);
						pkg_gestionArchivos.prcEscribirLinea_SMF(sbFileManagementd,
											  'Mensaje ' || sbErrorMessage);

						if (nuPackageId is not null) then

						  Ld_BoSecureManagement.UpdateStatePolicy(ionupoli, 4);

						  commit;

						  /*10-03-2015 sPACHECO [ARA 6165]: Se obtiene adiciona Contrato/Producto/Poliza/colectivo
						  al mensaje de log para hacerlo mas explicito*/
						  sbLineLog := '[Contrato:' || nususc || '- Producto:' ||
									   nuServSus || '- Póliza:' || ionupoli ||
									   '- Colectivo:' ||
									   DAld_policy.fnuGetCOLLECTIVE_NUMBER(ionupoli) || ']' ||
									   '  Se creo la solicitud de cancelacion: ' ||
									   nuPackageId || ' con el numero de motivo: ' ||
									   nuMotiveId || ' la poliza a cancelar es: ' ||
									   ionupoli;
						  pkg_gestionArchivos.prcEscribirLinea_SMF(sbFileManagementd, sbLineLog);
						  nupolicac := nupolicac + 1;

						else
						  sbLineLog := '[Contrato:' || nususc || '- Producto:' ||
									   nuServSus || '- Póliza:' || ionupoli ||
									   '- Colectivo:' ||
									   DAld_policy.fnuGetCOLLECTIVE_NUMBER(ionupoli) || ']' ||
									   ' Error creando la solicitud: ' ||
									   nuPackageId || ' con el numero de motivo: ' ||
									   nuMotiveId || ' para el contrato: ' ||
									   nususc || ' y la poliza: ' || ionupoli ||
									   ' Error: ' || nuErrorCode || ' Mensaje:' ||
									   sbErrorMessage;
						  pkg_gestionArchivos.prcEscribirLinea_SMF(sbFileManagementd, sbLineLog);
						  nupolinocac := nupolinocac + 1;

						end if;

					end if;  -- if(blpoli = false)then  --- CASO 539

				  end if;

				end if;

			  end loop;

			end if;

		  else
			sbLineLog := 'Los parametros necesarios para este proceso no se encuentran configurados.';
			pkg_gestionArchivos.prcEscribirLinea_SMF(sbFileManagementd, sbLineLog);

		  end if;
		else
		  sbLineLog := 'Los parametros necesarios para este proceso se no existen';
		  pkg_gestionArchivos.prcEscribirLinea_SMF(sbFileManagementd, sbLineLog);

		end if;
		/*10-03-2015 sPACHECO [ARA 6165]: Se modifica para que
		al mensaje de log para hacerlo mas explicito*/
		sbLineLog := 'Cantidad de pólizas canceladas: ' || nupolicac;

		pkg_gestionArchivos.prcEscribirLinea_SMF(sbFileManagementd, sbLineLog);

		sbLineLog := 'Cantidad de pólizas No canceladas con éxito: ' ||
					 nupolinocac;

		pkg_gestionArchivos.prcEscribirLinea_SMF(sbFileManagementd, sbLineLog);
		pkg_gestionArchivos.prcCerrarArchivo_SMF(sbFileManagementd, NULL, NULL);
		/*10-03-2015 sPACHECO [ARA 6165]: Se modifica para que
		al mensaje de log para hacerlo mas explicito*/
		vsbmessage := 'Notificacion de finalizacion de proceso de CANCELACION ' ||
					  chr(10) || chr(13) ||
					  ' Cantidad de polizas canceladas con exito: ' ||
					  nupolicac || chr(10) || chr(13) ||
					  'Cantidad de polizas No Canceladas: ' || nupolinocac ||
					  chr(10) || chr(13) ||
					  'Para mayor detalle, dirijase al log generado en la ruta ' ||
					  sbPath;
		--identifica parametro de correo de envio osf
		vsbSendEmail := dald_Parameter.fsbGetValue_Chain('LDC_SMTP_SENDER');
		--identifica parametro de correo de recibe notificacion de CANCELACION de seguro
		vsbrecEmail := dald_Parameter.fsbGetValue_Chain('EMAIL_RENO_RENSEGU');
		
		sbInstanciaBD := ldc_boconsgenerales.fsbgetdatabasedesc();
		IF (LENGTH(sbInstanciaBD) > 0) THEN
			sbInstanciaBD := 'BD '||sbInstanciaBD||': ';
		END IF;
		
		--SE ENVIA CORREO DE NOTIFICACION
		ld_bopackagefnb.prosendemail(isbsender     => vsbSendEmail,
									 isbrecipients => vsbrecEmail,
									 isbsubject    => sbInstanciaBD || 'Finalizacion de proceso de CANCELACION',
									 isbmessage    => vsbmessage,
									 isbfilename   => null);
									 
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

	EXCEPTION
		when pkg_error.CONTROLLED_ERROR then
			pkg_error.geterror(nuErrorCode, sbErrorMessage);
			pkg_traza.trace(' sbErrorMessage => ' || sbErrorMessage, pkg_traza.cnuNivelTrzDef);
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);
			raise pkg_error.CONTROLLED_ERROR;
		when others then
			pkg_error.setError;
			pkg_error.geterror(nuErrorCode,sbErrorMessage);
			pkg_traza.trace(' sbErrorMessage => ' || sbErrorMessage, pkg_traza.cnuNivelTrzDef);
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
			pkg_error.setError;
			raise pkg_error.CONTROLLED_ERROR;
	END ProcCancelSeguro;
End LDC_Seguros;
/

