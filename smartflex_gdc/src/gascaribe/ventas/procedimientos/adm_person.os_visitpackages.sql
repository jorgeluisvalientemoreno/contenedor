CREATE OR REPLACE PROCEDURE ADM_PERSON.OS_VisitPackages(	 inuSubscription      IN MO_PACKAGES.SUBSCRIPTION_PEND_ID%TYPE,
                                                             inuPerson            IN GE_PERSON.PERSON_ID%TYPE,
                                                             inuReception_Type    IN MO_PACKAGES.RECEPTION_TYPE_ID%TYPE,
                                                             inuSubsType          IN GE_SUBSCRIBER.SUBSCRIBER_TYPE_ID%TYPE,
                                                             inuTypeId            IN GE_SUBSCRIBER.IDENT_TYPE_ID%TYPE,
                                                             isbClient_Ident      IN GE_SUBSCRIBER.IDENTIFICATION%TYPE,
                                                             isbName              IN GE_SUBSCRIBER.SUBSCRIBER_NAME%TYPE,
                                                             IsbLASTName          IN GE_SUBSCRIBER.SUBS_LAST_NAME%TYPE,
                                                             inuRoleId            IN CC_ROLE.ROLE_ID%TYPE,
                                                             inuVisitType         IN LD_SALES_VISIT.VISIT_TYPE_ID%TYPE,
                                                             inuItem_id           IN LD_SALES_VISIT.ITEM_ID%TYPE,
                                                             inuVisitAddress      IN LD_SALES_VISIT.VISIT_ADDRESS_ID%TYPE,
                                                             inuRefer_Mode        IN MO_PACKAGES.REFER_MODE_ID%TYPE,
                                                             inuVisit_Sale_Cru_Id IN LD_SALES_VISIT.VISIT_SALE_CRU_ID%TYPE,
                                                             inuShopkeeper        IN LD_SHOPKEEPER.SHOPKEEPER_ID%TYPE,
                                                             isbComment_          IN MO_PACKAGES.COMMENT_%TYPE,
                                                             inuoperativa         IN MO_PACKAGES.OPERATING_UNIT_ID%TYPE,
                                                             onuPackage_Id        OUT MO_PACKAGES.PACKAGE_ID%TYPE,
                                                             onuErrorCode         OUT GE_MESSAGE.MESSAGE_ID %TYPE,
                                                             osbErrorMessage      OUT GE_MESSAGE.DESCRIPTION%TYPE) IS
												 
	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : OS_VisitPackages
    Descripcion     : Crea registro de solicitud de visita
    Autor           : 
    Fecha           : 2013
  
    Parametros de Entrada
    inuSubscription     NUMBER     	Código de contrato
    inuPerson           NUMBER     	Código del la persona o funcionario
    inuReception_Type   NUMBER     	Código del medio de recepción.
	inuSubsType			NUMBER		Tipo de suscriptor
	inuTypeId			NUMBER		Tipo de identificacion
	isbClient_Ident		VARCHAR2	Identificacion cliente
	isbName				VARCHAR2	Nombre
	IsbLASTName			VARCHAR2	Apellido
	inuRoleId         	NUMBER     	Relación del cliente con el predio
	inuVisitType        NUMBER     	Tipo de visita
    inuItem_id          NUMBER     	Sublinea de producto / tipo de póliza
	inuVisitAddress     NUMBER     	Dirección de visita
    inuRefer_Mode       NUMBER     	Medio por el cual se entero
    inuVisit_Sale_Cru_Id NUMBER     Solicitud cruzada
    inuShopkeeper       NUMBER     	Tendero Referente
    isbComment_         VARCHAR2   	Observación de registro de la solicitud
    inuoperativa     	NUMBER     	Unidad operativa
    

    Parametros de Salida
	 onuPackage_Id      NUMBER 		Id de Solicitu
	 onuErrorCode       NUMBER  	Código de error
	 osbErrorMessage    VARCHAR2	Descripcion del error
	
	
  
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso    	Descripcion
	PACOSTA     02/05/2024  OSF-2638    Se crea el objeto en el esquema adm_person   
    jsoto		10/11/2023	OSF-1790	Ajustes cambio en llamado a algunos de los objetos de producto por personalizados
										Ajuste  cambio en manejo de trazas y errores por personalizados.
										Ajuste llamado a PKG_XML_SOLI_FNB para armar el xml de la solicitud
										Ajuste llamado a API api_registerRequestByXml
	==============================================================================*/


  vboSuscripc      boolean;
  vboChanell       boolean;
  vboPackage       boolean;
  vboGe_subscriber boolean;
  vbosubstype      boolean;
  vborecptype      boolean;
  sbRequestXML     constants_per.tipo_xml_sol%TYPE;
  nuMotiveId       mo_motive.motive_id%type;
  nuGeo            ge_geogra_location.geograp_location_id%type;
  nuadd            ab_address.address%type;
  nuSubscriber     ge_subscriber.subscriber_id%type;
  nuRefer_Mode     mo_packages.refer_mode_id%type;
  nuCont           number := 0;

  csbMT_NAME  VARCHAR2(70) :=  'OS_VisitPackages';


BEGIN

	pkg_traza.trace(csbMT_NAME,pkg_traza.cnuNivelTrzDef,pkg_traza.csbINICIO);

	  /*Valida que la subscrition exista*/
	  vboSuscripc := pktblsuscripc.fblexist(inuSubscription);
		/*Valida que el medio de recepcion exista*/
	  vborecptype := dage_reception_type.fblExist(inuReception_Type);
		  /*Valida que el tipo de cliente exista*/
	  vbosubstype := Dage_Subscriber_Type.fblExist(inuSubsType);
	  /*Se obtiene la direccion del contrato*/
	  Ld_BoSecureManagement.GetAddressBySusc(inuSubscription, nuadd, nuGeo);

	  /* Se obiene el subscriber si el tipo de identificacion o identificacion existe*/
	  begin
		nuSubscriber := pkg_bccliente.fnuclienteid(	inuTypeId,
													isbClient_Ident);
		/* Se controla la excepcion si el cliente no existe
		asignandole a la variable nuSubscriber null*/

	  exception
		when others then
		  nuSubscriber := null;
	  end;

	  /*Se obtiene el parametro definido de cuando el medio por el que se entero es venta
	  cruzada*/

	  nuRefer_Mode := dald_parameter.fnuGetNumeric_Value('COD_REFER_MODE_VTACROSS');

	  /* Se valida si el cliente no existe*/

	  if (nuSubscriber is null) then

			/*Se valido si el nombre fue ingresado*/
			
			if (isbName is null) then
			  osbErrorMessage := 'EL NOMBRE DEL CLIENTE ES OBLIGATORIO';
			else
			  /*Si cumple con la condicion se procede a realizar
			  una insercion a ge_subscriber*/

			  /* Se realiza el ingreso a ge_subscriber*/

			  Ld_bononbankfinancing.RegisterProspect(inuTypeId,
													 isbClient_Ident,
													 isbName,
													 IsbLASTName);

			  /* Se obtiene el nuevo registro de ge_subscriber*/

			  nuSubscriber := pkg_bccliente.fnuclienteid(inuTypeId,
														 isbClient_Ident);

			  /*Se actualiza el  tipo de cliente, si el cliente no existe*/

			  Dage_Subscriber.Updsubscriber_Type_Id(nuSubscriber,inuSubsType);

			end if;

	  end if;

	  /* Se valida si el cliente existe*/

	  if (nuSubscriber is not null) then

		/*Si el contrato no existe envia mensaje de error*/

		if (vboSuscripc = false) then
		  osbErrorMessage := 'CONTRATO NO VALIDO';
		else
	 
			if (vborecptype = false ) then

			/* Si el medio de recepcion no existe envia mensaje de error */

			osbErrorMessage := 'Medio de recepcion no valido';

			else

			if (inuRefer_Mode = nuRefer_Mode) then

				  /* Se valida que la solicitud ingresada exista */
				  
				  vboPackage := pkg_bcsolicitudes.fblexiste(inuVisit_Sale_Cru_Id);
				  if (vboPackage = false) then
					osbErrorMessage := 'SOLICITUD CRUZADA NO SE ENCUENTRA REGISTRADA';
					nuCont := 1;
				  else
					nuCont := 0;
				  end if;
				  
			end if;

			if (nuCont = 0) then
			
			  /* Si la direccion del contrato es null no permite la creacion de la solicitud de visita */
			  if (nuadd is null) then
				osbErrorMessage := 'LA SUCRIPCION INGRESADA CONTIENE UNA DIRECCION NULA Y NO PERMITE LA GENERACION DE VISITA FNB';
			  else
			  
				sbRequestXML := pkg_xml_soli_fnb.getsolicitudvisitafnb(inuSubscription,
																		inuPerson,
																		inuReception_Type,
																		nuadd,
																		isbComment_,
																		inuRefer_Mode,
																		inuVisitType,
																		inuShopkeeper,
																		inuVisit_Sale_Cru_Id,
																		inuItem_id,
																		inuRoleId,
																		inuVisitAddress,
																		nuSubscriber,
																		inuoperativa
																		);
				

				--EJECUTA XML
				api_registerRequestByXml(sbRequestXML,
										 onuPackage_Id,
										 nuMotiveId,
										 onuErrorCode,
										 osbErrorMessage);

				/*Si  se genero solicitud de api se envia mensaje
				notificando al usuario que el proceso fue exitoso, sino se realiza
				un rollback sobre el proceso*/

				IF onuPackage_id is not null then
				  osbErrorMessage := 'SE GENERO CON EXITO LA SOLICITUD';
				else
				  rollback;
				end if;
			  end if;
			end if;
		  end if;
		end if;
	  end if;

	pkg_traza.trace(csbMT_NAME,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN);

EXCEPTION
  when pkg_error.CONTROLLED_ERROR then
    pkg_error.getError(onuErrorCode, osbErrorMessage);
	pkg_traza.trace(onuErrorCode||': '||osbErrorMessage,pkg_traza.cnuNivelTrzDef);
	pkg_traza.trace(csbMT_NAME,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERC);
  when OTHERS then
    pkg_error.setError;
    pkg_error.getError(onuErrorCode, osbErrorMessage);
	pkg_traza.trace(onuErrorCode||': '||osbErrorMessage,pkg_traza.cnuNivelTrzDef);
	pkg_traza.trace(csbMT_NAME,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);
END OS_VISITPACKAGES;
/
PROMPT Otorgando permisos de ejecucion a OS_VISITPACKAGES
BEGIN
    pkg_utilidades.praplicarpermisos('OS_VISITPACKAGES', 'ADM_PERSON');
END;
/
PROMPT Otorgando permisos de ejecucion sobre OS_VISITPACKAGES para reportes
GRANT EXECUTE ON adm_person.OS_VISITPACKAGES TO rexereportes;
/
