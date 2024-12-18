CREATE OR REPLACE PACKAGE ADM_PERSON.LDCI_PKUPDATECUSTOMER AS
/*
   PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
   PAQUETE       : LDCI_PKUPDATECUSTOMER
   AUTOR         : OLSoftware / Mauricio Ortiz
   FECHA         : 19/03/2013
   RICEF : I020,I038,I039,I040
   DESCRIPCION: Paquete que permite hacer la actualizacion de los datos de cliente

  Historia de Modificaciones
  Autor   Fecha      Descripcion
*/
  -- consulta la informacion del cliente


PROCEDURE proUpdateCustomer(inuContra        IN NUMBER,
						   inuProduct       IN NUMBER,
						   isbServiceNumber IN VARCHAR2,
						   inuClie          IN NUMBER,
						   inuRole          IN NUMBER,
						   idtFecNac        IN DATE,
						   isbSexo          IN VARCHAR2,
						   isbTelefono      IN VARCHAR2,
						   isbEmail         IN VARCHAR2,
						   isbCompany       IN VARCHAR2,
						   isbTeleOfic      IN VARCHAR2,
						   isbTelOfExt      IN VARCHAR2,
						   isbCargo         IN VARCHAR2,
						   idtFecCont       IN DATE,
						   isbDir           IN VARCHAR2,
						   onuErrorCode    OUT NUMBER,
						   osbErrorMessage OUT VARCHAR2);

END LDCI_PKUPDATECUSTOMER;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.LDCI_PKUPDATECUSTOMER AS

PROCEDURE proUpdateCustomer(inuContra        IN NUMBER,
						   inuProduct       IN NUMBER,
						   isbServiceNumber IN VARCHAR2,
						   inuClie          IN NUMBER,
						   inuRole          IN NUMBER,
						   idtFecNac        IN DATE,
						   isbSexo          IN VARCHAR2,
						   isbTelefono      IN VARCHAR2,
						   isbEmail         IN VARCHAR2,
						   isbCompany       IN VARCHAR2,
						   isbTeleOfic      IN VARCHAR2,
						   isbTelOfExt      IN VARCHAR2,
						   isbCargo         IN VARCHAR2,
						   idtFecCont       IN DATE,
						   isbDir           IN VARCHAR2,
						   onuErrorCode    OUT NUMBER,
						   osbErrorMessage OUT VARCHAR2) as


/*
   PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
   PAQUETE       : LDCI_PKUPDATECUSTOMER.proUpdateCustomer
   AUTOR         : OLSoftware / Mauricio Ortiz
   FECHA         : 19/03/2013
   RICEF : I020,I038,I039,I040
   DESCRIPCION: Paquete que permite hacer la actualizacion de los datos de cliente

  Historia de Modificaciones
  Autor   Fecha      Descripcion
*/

-- variables para utilizar api OS_CUSTOMERUPDATE
inuident_type_id        GE_SUBSCRIBER.IDENT_TYPE_ID%type;
isbidentification       GE_SUBSCRIBER.IDENTIFICATION%type;
inuparent_subscriber_id GE_SUBSCRIBER.PARENT_SUBSCRIBER_ID%type;
inusubscriber_type_id   GE_SUBSCRIBER.SUBSCRIBER_TYPE_ID%type;
isbaddress              GE_SUBSCRIBER.ADDRESS%type;
isbsubscriber_name      GE_SUBSCRIBER.SUBSCRIBER_NAME%type;
isbsubs_last_name       GE_SUBSCRIBER.SUBS_LAST_NAME%type;
isburl                  GE_SUBSCRIBER.URL%type;
isbcontact_phone        VARCHAR2(50);
isbcontact_address      VARCHAR2(100);
isbcontact_name         VARCHAR2(100);
inucontact_ident_type   NUMBER(4);
isbcontact_ident        VARCHAR2(20);
inuMarketing_segment_id GE_SUBSCRIBER.MARKETING_SEGMENT_ID%type;
inusubs_status_id       GE_SUBSCRIBER.SUBS_STATUS_ID%type;
nuFlagExiste            NUMBER := 0;

-- variables  api OS_SETCUSTWORKDATA
inuCustomerID           NUMBER(15);
inuIdentificationTypeID NUMBER(4);
isbOccupation           VARCHAR2(100);
isbTitle                VARCHAR2(100);
inuActivityID           NUMBER(15);
isbWorkArea             VARCHAR2(200);
inuExperience           NUMBER(5);
idtHireDate             DATE;
inuOfficeAddressID      NUMBER(15);
isbOfficePhone          VARCHAR2(100);
isbOfficePhoneExtension NUMBER(4);
inuWorkedTime           NUMBER(5);
inuPreviousActivityID   NUMBER(15);
isbPreviousCompany      VARCHAR2(100);
isbPreviousOccupation   VARCHAR2(100);
inuPreviousWorkTime     NUMBER(5);


-- variables tipo registro
orfCustUserData   LDCI_PKREPODATATYPE.tyRefcursor;
reCustUsersByProd LDCI_PKREPODATATYPE.tyCustUsersByProdRecord;

-- excepciones
excep_OS_CUSTOMERUPDATE     exception;
excep_OS_GETCUSTUSERSBYPROD exception;
excep_No_CustUsersByProd    exception;
excep_OS_SETCUSTWORKDATA    exception;
BEGIN
  -- actualiza los datos del cliente
  -- validar rol y/o tipo de cliente
  if (inuRole = 1) then
		-- si es el suscriptor
		-- actualizar datos en GE_SUSBCRIBER

		isbcontact_phone := isbTelefono;
		OS_CUSTOMERUPDATE(inuClie,
						  inuident_type_id,
						  isbidentification,
						  inuparent_subscriber_id,
						  inusubscriber_type_id,
						  isbaddress,
						  isbTelefono,
						  isbsubscriber_name,
						  isbsubs_last_name,
						  isbEmail,
						  isburl,
						  isbcontact_phone,
						  isbcontact_address,
						  isbcontact_name,
						  inucontact_ident_type,
						  isbcontact_ident,
						  inuMarketing_segment_id,
						  inusubs_status_id,
						  isbSexo,
						  idtFecNac,
						  onuErrorCode,
						  osbErrorMessage);

		-- valida la ejeucion del API
		if (onuErrorCode <> 0) then
			raise excep_OS_CUSTOMERUPDATE;
		end if;--if (onuErrorCode <> 0) then
  else
     --si es dueño o usuario
     LDCI_PKCRMPORTALWEB.proConsultaTipoClienteProd(inuProduct,
  												    isbServiceNumber,
												    inuRole,
												    orfCustUserData,
												    onuErrorCode,
												    osbErrorMessage);

    if (onuErrorCode = 0) then
        Loop
        Fetch  orfCustUserData  Into reCustUsersByProd;
           EXIT WHEN orfCustUserData%notfound;
           --validar que el cliente de la tabla PR_SUBS_TYPE_PROD, sea
           nuFlagExiste := 1;
        End Loop; -- Loop

		if (nuFlagExiste = 1) then
			-- actualizar datos en GE_SUSBCRIBER
			OS_CUSTOMERUPDATE(inuClie,
							  inuident_type_id,
							  isbidentification,
							  inuparent_subscriber_id,
							  inusubscriber_type_id,
							  isbaddress,
							  isbTelefono,
							  isbsubscriber_name,
							  isbsubs_last_name,
							  isbEmail,
							  isburl,
							  isbcontact_phone,
							  isbcontact_address,
							  isbcontact_name,
							  inucontact_ident_type,
							  isbcontact_ident,
							  inuMarketing_segment_id,
							  inusubs_status_id,
							  isbSexo,
							  idtFecNac,
							  onuErrorCode,
							  osbErrorMessage);

			-- valida la ejeucion del API
			if (onuErrorCode <> 0) then
				raise excep_OS_CUSTOMERUPDATE;
			end if;--if (onuErrorCode <> 0) then
		else
			raise excep_No_CustUsersByProd;
		end if;--if (nuFlagExiste = 1) then
    else
		raise excep_OS_GETCUSTUSERSBYPROD;
    end if;--if (onuErrorCode = 0) then
  end if;--if (inuRole = 1) then

  OS_SETCUSTWORKDATA(inuClie,
                     inuident_type_id,
																					isbidentification,
																					isbTitle,
																					isbCargo,
																					inuActivityID,
																					isbWorkArea,
																					isbCompany,
																					inuExperience,
																					idtFecCont,
																					inuOfficeAddressID,
																					isbTeleOfic,
																					isbTelOfExt,
																					inuWorkedTime,
																					inuPreviousActivityID,
																					isbPreviousCompany,
																					isbPreviousOccupation,
																					inuPreviousWorkTime,
																					onuErrorCode,
																					osbErrorMessage);

	-- valida la ejeucion del API
	if (onuErrorCode <> 0) then
		raise excep_OS_SETCUSTWORKDATA;
	end if;--if (onuErrorCode <> 0) then

	-- confirma los datos
	commit;
EXCEPTION
   WHEN excep_OS_SETCUSTWORKDATA THEN
     rollback;
     Errors.seterror (-1, '[LDCI_PKUPDATECUSTOMER.proUpdateCustomer.excep_OS_SETCUSTWORKDATA]: Error ejecucion API :' || osbErrorMessage);

   WHEN excep_OS_GETCUSTUSERSBYPROD THEN
     rollback;
     Errors.seterror (-1, '[LDCI_PKUPDATECUSTOMER.proUpdateCustomer.excep_OS_GETCUSTUSERSBYPROD]: Error ejecucion API :' || osbErrorMessage);

   WHEN excep_OS_CUSTOMERUPDATE THEN
     rollback;
     Errors.seterror (-1, '[LDCI_PKUPDATECUSTOMER.proUpdateCustomer.excep_OS_CUSTOMERUPDATE]: Error ejecucion API :' || osbErrorMessage);

   WHEN excep_No_CustUsersByProd THEN
     rollback;
	 onuErrorCode    := -1;
	 osbErrorMessage := '[LDCI_PKUPDATECUSTOMER.proUpdateCustomer.excep_No_CustUsersByProd]: No se ha encontrado el Servicio ' || isbServiceNumber || ' para el producto ' || inuProduct || ', rol ' || inuRole;
     Errors.seterror (onuErrorCode, osbErrorMessage);

   WHEN OTHERS THEN
	 rollback;
	 pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, osbErrorMessage);
	 Errors.seterror;
	 Errors.geterror (onuErrorCode, osbErrorMessage);
END proUpdateCustomer;

END LDCI_PKUPDATECUSTOMER;
/

PROMPT Asignación de permisos para el paquete LDCI_PKUPDATECUSTOMER
begin
  pkg_utilidades.prAplicarPermisos('LDCI_PKUPDATECUSTOMER', 'ADM_PERSON');
end;
/
GRANT EXECUTE on ADM_PERSON.LDCI_PKUPDATECUSTOMER to INTEGRACIONES;
GRANT EXECUTE on ADM_PERSON.LDCI_PKUPDATECUSTOMER to INTEGRADESA;
/
