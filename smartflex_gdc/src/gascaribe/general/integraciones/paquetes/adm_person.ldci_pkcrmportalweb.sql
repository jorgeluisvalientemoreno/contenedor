CREATE OR REPLACE PACKAGE ADM_PERSON.LDCI_PKCRMPORTALWEB AS
/*
   PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
   PAQUETE       : LDCI_PKCRMPORTALWEB
   AUTOR         : OLSoftware / Mauricio Ortiz
   FECHA         : 19/03/2013
   RICEF : I020,I038,I039,I040
   DESCRIPCION: Paquete que permite encapsula las operaciones de consulta de suscruptores

  Historia de Modificaciones
  Autor   Fecha      Descripcion
*/
  -- consulta la informacion del cliente
  PROCEDURE proBuscarCliente(inuCustomerID           IN NUMBER,
																												inuIdentificationTypeID IN NUMBER,
																												isbIdentification       IN VARCHAR2,
																												orfCustomerData        OUT LDCI_PKREPODATATYPE.tyRefcursor,
																												orfCustWorkData        OUT LDCI_PKREPODATATYPE.tyRefcursor,
																												onuErrorCode           OUT NUMBER,
																												osbErrorMessage        OUT VARCHAR2);

  -- consulta la informacion de suscriptor
  PROCEDURE proConsultaSuscriptor(inuSERVCODI          in NUMBER,
																																	inuSubscriptionId    in NUMBER,
																																	isbIdentification    in VARCHAR2,
																																	isbPhoneNumber       in VARCHAR2,
																																	orfSubscriptionData OUT LDCI_PKREPODATATYPE.tyRefcursor,
																																	onuErrorCode        OUT NUMBER,
																																	osbErrorMessage     OUT VARCHAR2);

  -- consulta el tipo de cliente producto
  PROCEDURE proConsultaTipoClienteProd(inuProductID     IN NUMBER,
																																						isbServiceNumber IN VARCHAR2,
																																						inuRoleID        IN NUMBER,
																																						orfCustUserData OUT LDCI_PKREPODATATYPE.tyRefcursor,
																																						onuErrorCode    OUT NUMBER,
																																						osbErrorMessage OUT VARCHAR2);

  -- consulta los datos del productos
  PROCEDURE proConsultaDatoProducto(inuProductID         IN NUMBER,
																																			isbServiceNumber     IN VARCHAR2,
																																			inuSubscriptionID    IN NUMBER,
																																			inuPremiseID         IN NUMBER,
																																			inuAddressID         IN NUMBER,
																																			inuProductTypeID     IN NUMBER,
																																			inuProductStatusID   IN NUMBER,
																																			isbOnlyActiveProduct IN VARCHAR2,
																																			orfProductData      OUT LDCI_PKREPODATATYPE.tyRefcursor,
																																			onuErrorCode        OUT NUMBER,
																																			osbErrorMessage     OUT VARCHAR2);

  --consulta de tecnicos
  procedure proConsultaTecnico(sbIdentificacion in GE_PERSON.number_id%TYPE,
																														orfTecnicos      out LDCI_PKREPODATATYPE.tyRefcursor,
																														onuErrorCode     out NUMBER,
																														osbErrorMessage  out VARCHAR2);


END LDCI_PKCRMPORTALWEB;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.LDCI_PKCRMPORTALWEB AS

/*
   PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
   PAQUETE       : LDCI_PKCRMPORTALWEB
   AUTOR         : OLSoftware / Mauricio Ortiz
   FECHA         : 19/03/2013
   RICEF : I020,I038,I039,I040
   DESCRIPCION: Paquete que permite encapsula las operaciones de consulta de suscruptores

  Historia de Modificaciones
  Autor   Fecha      Descripcion
*/
  PROCEDURE proConsultaSuscriptor(inuSERVCODI          in NUMBER,
								   inuSubscriptionId    in NUMBER,
							     isbIdentification    in VARCHAR2,
							     isbPhoneNumber       in VARCHAR2,
							     orfSubscriptionData OUT LDCI_PKREPODATATYPE.tyRefcursor,
  								 onuErrorCode        OUT NUMBER,
							  	 osbErrorMessage     OUT VARCHAR2) AS
  /*
	   PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
	   PAQUETE       : LDCI_PKCRMPORTALWEB.proConsultaSuscriptor
	   AUTOR         : OLSoftware / Carlos E. Virgen
	   FECHA         : 19/03/2013
	   RICEF : I020,I038,I039,I040
	   DESCRIPCION: Paquete que permite encapsula las operaciones de consulta de suscruptores

	  Historia de Modificaciones
	  Autor      Fecha         Descripcion
    KBaquero   19/05/2015    Aranda 151478 Se optimiza la consulta para que se obtenga la información
                             del cliente Independiente si tiene dirección o no.
  */
  -- variables
  nuSERVCODI       SERVICIO.SERVCODI%type;
  nuSUSCCODI       SUSCRIPC.SUSCCODI%type;
  sbIDENTIFICATION GE_SUBSCRIBER.IDENTIFICATION%type;
  sbPHONE          GE_SUBSCRIBER.PHONE%type;
  reContractData   LDCI_PKREPODATATYPE.tyContractDataRecord;

  excep_Sin_Codigo_Servicio    exception;
  excep_Sin_Parametros_Entrada exception;
  excep_No_Encontro_Registro   exception;
  BEGIN
					-- valida los parametros de entrada
					nuSERVCODI       := nvl(inuSERVCODI,-1);
					nuSUSCCODI       := nvl(inuSubscriptionId,-1);
					sbIDENTIFICATION := nvl(isbIdentification,'-1');
					sbPHONE          := nvl(isbPhoneNumber,'-1');

								-- valida que se haya ingresado los parametros de busqueda
					if ((inuSubscriptionId is null or inuSubscriptionId = -1)    and
              (isbIdentification is null or isbIdentification = '-1')	 and
              (isbPhoneNumber is null or isbPhoneNumber = '-1'))       then
						raise excep_Sin_Parametros_Entrada;
					end if; --If (inuSubscriptionId is null or inuSubscriptionId = -1) .. Then

				-- carga el cusor referenciado
       if (inuSubscriptionId is not null or isbIdentification is not null) THEN

				open orfSubscriptionData for
        /*KBaquero  19/05/2015 se optimiza la consulta colocandole  outer join*/
        select Cont.SUSCCODI CONTRATO,
                  SeSu.SESUNUSE NRO_SERVICIO,
                  SeSu.SESUSERV CODIGO_SERVICIO,
                  Serv.SERVDESC SERVICIO_DESC,
                  Cont.SUSCCLIE CODIGO_CLIENTE,
                  Clie.SUBSCRIBER_NAME || ' ' || Clie.SUBS_LAST_NAME CLIENTE,
                  Pred.ADDRESS_ID CODIGO_DIRECCION_COBRO,
                  Pred.ADDRESS    DIRECCION_COBRO,
                  DepLocPred.GEOGRAP_LOCATION_ID CODIGO_DEPTO,
                  DepLocPred.DISPLAY_DESCRIPTION DEPTO_DIRECCION_COBRO,
                  LocPred.GEOGRAP_LOCATION_ID CODIGO_LOCALIDAD,
                  LocPred.DISPLAY_DESCRIPTION LOCALIDAD_DIRECCION_COBRO,
                  Cate.CATECODI CODIGO_CATEGORIA,
                 Cate.CATEDESC CATEGORIA,
                 SuCa.SUCACODI CODIGO_SUBCATEGORIA,
                 SuCa.SUCADESC SUBCATEGORIA
              from open.SUSCRIPC Cont,
                  open.SERVSUSC SeSu,
                  open.SERVICIO Serv,
                  open.GE_SUBSCRIBER Clie,
                  open.PR_PRODUCT Prod,
                  open.AB_ADDRESS Dire,
                  open.AB_ADDRESS Pred,
                  open.CATEGORI Cate,
                  open.SUBCATEG SuCa ,
                 open.GE_GEOGRA_LOCATION LocDire,
                  open.GE_GEOGRA_LOCATION LocPred,
                  open.GE_GEOGRA_LOCATION DepLocDire,
                  open.GE_GEOGRA_LOCATION DepLocPred
            where SeSu.SESUSUSC = Cont.SUSCCODI
                and Serv.SERVCODI = SeSu.SESUSERV
                and Serv.SERVCODI = decode(nuSERVCODI, -1, Serv.SERVCODI, nuSERVCODI)
								and Cont.SUSCCODI = decode(nuSUSCCODI, -1, Cont.SUSCCODI, nuSUSCCODI)
               -- and Serv.SERVCODI = decode(7014, -1, Serv.SERVCODI, 7014)
               -- and Cont.SUSCCODI = decode(66284502, -1, Cont.SUSCCODI, 66284502)
                and Clie.IDENTIFICATION = decode('-1', '-1', nvl(Clie.IDENTIFICATION, '-1'), '-1')
                and nvl(Clie.PHONE,'-1') = decode('-1', '-1', nvl(Clie.PHONE, '-1'), '-1')
                and Cont.SUSCCLIE = Clie.SUBSCRIBER_ID
                and Cont.SUSCCODI = Prod.SUBSCRIPTION_ID
                and Dire.ADDRESS_ID(+) = Clie.ADDRESS_ID
                and Dire.GEOGRAP_LOCATION_ID = LocDire.GEOGRAP_LOCATION_ID(+)
                and DepLocDire.GEOGRAP_LOCATION_ID(+) = LocDire.GEO_LOCA_FATHER_ID
                and Pred.ADDRESS_ID = Cont.SUSCIDDI
                and Pred.GEOGRAP_LOCATION_ID = LocPred.GEOGRAP_LOCATION_ID(+)
                and DepLocPred.GEOGRAP_LOCATION_ID(+) = LocPred.GEO_LOCA_FATHER_ID
                and SeSu.SESUCATE = Cate.CATECODI
                and SeSu.SESUCATE = SuCa.SUCACATE
                and SeSu.SESUSUCA = SuCa.SUCACODI;
				/*	select Cont.SUSCCODI CONTRATO,
									SeSu.SESUNUSE NRO_SERVICIO,
									SeSu.SESUSERV CODIGO_SERVICIO,
									Serv.SERVDESC SERVICIO_DESC,
									Cont.SUSCCLIE CODIGO_CLIENTE,
									Clie.SUBSCRIBER_NAME || ' ' || Clie.SUBS_LAST_NAME CLIENTE,
									Pred.ADDRESS_ID CODIGO_DIRECCION_COBRO,
									Pred.ADDRESS    DIRECCION_COBRO,
									DepLocPred.GEOGRAP_LOCATION_ID CODIGO_DEPTO,
									DepLocPred.DISPLAY_DESCRIPTION DEPTO_DIRECCION_COBRO,
									LocPred.GEOGRAP_LOCATION_ID CODIGO_LOCALIDAD,
									LocPred.DISPLAY_DESCRIPTION LOCALIDAD_DIRECCION_COBRO,
									Cate.CATECODI CODIGO_CATEGORIA,
									Cate.CATEDESC CATEGORIA,
									SuCa.SUCACODI CODIGO_SUBCATEGORIA,
									SuCa.SUCADESC SUBCATEGORIA
							from SUSCRIPC Cont,
									SERVSUSC SeSu,
									SERVICIO Serv,
									GE_SUBSCRIBER Clie,
									PR_PRODUCT Prod,
									AB_ADDRESS Dire,
									AB_ADDRESS Pred,
									CATEGORI Cate,
									SUBCATEG SuCa,
									GE_GEOGRA_LOCATION LocDire,
									GE_GEOGRA_LOCATION LocPred,
									GE_GEOGRA_LOCATION DepLocDire,
									GE_GEOGRA_LOCATION DepLocPred
						where SeSu.SESUSUSC = Cont.SUSCCODI
								and Serv.SERVCODI = SeSu.SESUSERV
								and Serv.SERVCODI = decode(nuSERVCODI, -1, Serv.SERVCODI, nuSERVCODI)
								and Cont.SUSCCODI = decode(nuSUSCCODI, -1, Cont.SUSCCODI, nuSUSCCODI)
								and Clie.IDENTIFICATION = decode(sbIDENTIFICATION, '-1', Clie.IDENTIFICATION, sbIDENTIFICATION)
								and nvl(Clie.PHONE,'-1') = decode(sbPHONE, '-1', nvl(Clie.PHONE, '-1'), sbPHONE)
								and Cont.SUSCCLIE = Clie.SUBSCRIBER_ID
								and Cont.SUSCCODI = Prod.SUBSCRIPTION_ID
								and Dire.ADDRESS_ID = Clie.ADDRESS_ID
								and Dire.GEOGRAP_LOCATION_ID = LocDire.GEOGRAP_LOCATION_ID
								and DepLocDire.GEOGRAP_LOCATION_ID = LocDire.GEO_LOCA_FATHER_ID
								and Pred.ADDRESS_ID = Cont.SUSCIDDI
								and Pred.GEOGRAP_LOCATION_ID = LocPred.GEOGRAP_LOCATION_ID
								and DepLocPred.GEOGRAP_LOCATION_ID = LocPred.GEO_LOCA_FATHER_ID
								and SeSu.SESUCATE = Cate.CATECODI
								and SeSu.SESUCATE = SuCa.SUCACATE
								and SeSu.SESUSUCA = SuCa.SUCACODI;*/


      ELSIF (isbPhoneNumber IS NOT NULL) THEN

          open orfSubscriptionData for
					select Cont.SUSCCODI CONTRATO,
									SeSu.SESUNUSE NRO_SERVICIO,
									SeSu.SESUSERV CODIGO_SERVICIO,
									Serv.SERVDESC SERVICIO_DESC,
									Cont.SUSCCLIE CODIGO_CLIENTE,
									Clie.SUBSCRIBER_NAME || ' ' || Clie.SUBS_LAST_NAME CLIENTE,
									Pred.ADDRESS_ID CODIGO_DIRECCION_COBRO,
									Pred.ADDRESS    DIRECCION_COBRO,
									DepLocPred.GEOGRAP_LOCATION_ID CODIGO_DEPTO,
									DepLocPred.DISPLAY_DESCRIPTION DEPTO_DIRECCION_COBRO,
									LocPred.GEOGRAP_LOCATION_ID CODIGO_LOCALIDAD,
									LocPred.DISPLAY_DESCRIPTION LOCALIDAD_DIRECCION_COBRO,
									Cate.CATECODI CODIGO_CATEGORIA,
									Cate.CATEDESC CATEGORIA,
									SuCa.SUCACODI CODIGO_SUBCATEGORIA,
									SuCa.SUCADESC SUBCATEGORIA
							from SUSCRIPC Cont,
									SERVSUSC SeSu,
									SERVICIO Serv,
									GE_SUBSCRIBER Clie,
									PR_PRODUCT Prod,
									AB_ADDRESS Dire,
									AB_ADDRESS Pred,
									CATEGORI Cate,
									SUBCATEG SuCa,
									GE_GEOGRA_LOCATION LocDire,
									GE_GEOGRA_LOCATION LocPred,
									GE_GEOGRA_LOCATION DepLocDire,
									GE_GEOGRA_LOCATION DepLocPred
						where SeSu.SESUSUSC = Cont.SUSCCODI
								and Serv.SERVCODI = SeSu.SESUSERV
								and Serv.SERVCODI = decode(nuSERVCODI, -1, Serv.SERVCODI, nuSERVCODI)
                and Cont.SUSCCLIE     in (select SUBSCRIBER_ID from GE_SUBSCRIBER  where PHONE =sbPHONE )
								and Cont.SUSCCLIE = Clie.SUBSCRIBER_ID
								and Cont.SUSCCODI = Prod.SUBSCRIPTION_ID
								and Dire.ADDRESS_ID = Clie.ADDRESS_ID
								and Dire.GEOGRAP_LOCATION_ID = LocDire.GEOGRAP_LOCATION_ID
								and DepLocDire.GEOGRAP_LOCATION_ID = LocDire.GEO_LOCA_FATHER_ID
								and Pred.ADDRESS_ID = Cont.SUSCIDDI
								and Pred.GEOGRAP_LOCATION_ID = LocPred.GEOGRAP_LOCATION_ID
								and DepLocPred.GEOGRAP_LOCATION_ID = LocPred.GEO_LOCA_FATHER_ID
								and SeSu.SESUCATE = Cate.CATECODI
								and SeSu.SESUCATE = SuCa.SUCACATE
								and SeSu.SESUSUCA = SuCa.SUCACODI;


      END IF;
			onuErrorCode := 0;
  EXCEPTION
    WHEN excep_Sin_Parametros_Entrada THEN
      rollback;
      OPEN orfSubscriptionData FOR SELECT * FROM DUAL WHERE 1 = 2;
	     onuErrorCode    := -1;
	     osbErrorMessage := '[LDCI_PKCRMPORTALWEB.proConsultaSuscriptor.excep_Sin_Parametros_Entrada]: ' || chr(13) || 'No ingreso parametros de busqueda (Busqueda por Contrado o Documento Identidad o Telefono).';
      Errors.seterror (onuErrorCode, osbErrorMessage);

    WHEN excep_No_Encontro_Registro THEN
      rollback;
      OPEN orfSubscriptionData FOR SELECT * FROM DUAL WHERE 1 = 2;
	  onuErrorCode    := -1;
	  osbErrorMessage := '[LDCI_PKCRMPORTALWEB.proConsultaSuscriptor.excep_No_Encontro_Registro]: ' || chr(13) ||
	                     'No se encontro registro con el criterio de busqueda ingresado.' || chr(13) ||
						 'Servicio: ' || nuSERVCODI	  || chr(13) ||
						 'Contrato: ' || nuSUSCCODI   || chr(13) ||
						 'Identificacion: ' || sbIDENTIFICATION  || chr(13) ||
						 'Nro. Telefono: ' || sbPHONE;
      Errors.seterror (onuErrorCode, osbErrorMessage);

	WHEN OTHERS THEN
				rollback;
				OPEN orfSubscriptionData FOR SELECT * FROM DUAL WHERE 1 = 2;
				pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, osbErrorMessage);
				Errors.seterror;
				Errors.geterror (onuErrorCode, osbErrorMessage);
  END proConsultaSuscriptor;

  PROCEDURE proConsultaDatoProducto(inuProductID         IN NUMBER,
                                   isbServiceNumber     IN VARCHAR2,
								   inuSubscriptionID    IN NUMBER,
								   inuPremiseID         IN NUMBER,
								   inuAddressID         IN NUMBER,
								   inuProductTypeID     IN NUMBER,
								   inuProductStatusID   IN NUMBER,
								   isbOnlyActiveProduct IN VARCHAR2,
								   orfProductData      OUT LDCI_PKREPODATATYPE.tyRefcursor,
								   onuErrorCode        OUT NUMBER,
								   osbErrorMessage     OUT VARCHAR2) AS
  /*
	   PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
	   PAQUETE       : LDCI_PKCRMPORTALWEB.proConsultaDatoProducto
	   AUTOR         : OLSoftware / Carlos E. Virgen
	   FECHA         : 20/03/2013
	   RICEF : I020,I038,I039,I040
	   DESCRIPCION: Carga la informacion del producto

	  Historia de Modificaciones
	  Autor   Fecha      Descripcion
  */
  excep_OS_GETPRODUCTDATA exception;
  BEGIN
     -- ejecuta el API OS_GETPRODUCTDATA
					OS_GETPRODUCTDATA(inuProductID,
																							isbServiceNumber,
																							inuSubscriptionID,
																							inuPremiseID,
																							inuAddressID,
																							inuProductTypeID,
																							inuProductStatusID,
																							isbOnlyActiveProduct,
																							orfProductData,
																							onuErrorCode,
																							osbErrorMessage);


     IF (onuErrorCode = 0) THEN
	    -- valida que el cursor este abierto
        If (orfProductData%ISOPEN = false) then
          OPEN orfProductData FOR SELECT * FROM DUAL WHERE 1 = 2;
        end if;-- IF (orfProductData%ISOPEN = false) then
	 else
       OPEN orfProductData FOR SELECT * FROM DUAL WHERE 1 = 2;
       raise excep_OS_GETPRODUCTDATA;
     END IF;-- IF (onuErrorCode = 0) THEN
  EXCEPTION
    WHEN excep_OS_GETPRODUCTDATA THEN
      rollback;
      Errors.seterror (-1, '[LDCI_PKCRMPORTALWEB.proConsultaDatoProducto.excep_OS_GETPRODUCTDATA]: Error ejecucion API :' || osbErrorMessage);
	WHEN OTHERS THEN
		rollback;
		pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, osbErrorMessage);
		Errors.seterror;
		Errors.geterror (onuErrorCode, osbErrorMessage);
        --RAISE_APPLICATION_ERROR(-20100, '[LDCI_PKCRMPORTALWEB.proConsultaDatoProducto.OTHERS]:' || chr(13) ||  'Error no controlado: ' || SQLERRM || ' | '||  DBMS_UTILITY.format_error_backtrace);
  END proConsultaDatoProducto;


  PROCEDURE proConsultaTipoClienteProd(inuProductID      IN NUMBER,
                                      isbServiceNumber  IN VARCHAR2,
																																						inuRoleID         IN NUMBER,
																																						orfCustUserData  OUT LDCI_PKREPODATATYPE.tyRefcursor,
																																						onuErrorCode     OUT NUMBER,
																																						osbErrorMessage  OUT VARCHAR2) AS
	/*
	   PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
	   PAQUETE       : LDCI_PKCRMPORTALWEB.proConsultaTipoClienteProd
	   AUTOR         : OLSoftware / Mauricio Ortiz
	   FECHA         : 19/03/2013
	   RICEF : I020,I038,I039,I040
	   DESCRIPCION: Paquete que permite encapsula las operaciones de consulta de suscruptores

	  Historia de Modificaciones
	  Autor   Fecha      Descripcion
	*/
  excep_OS_GETCUSTUSERSBYPROD exception;
  BEGIN
     -- ejecuta el API OS_GETCUSTUSERSBYPROD
     OS_GETCUSTUSERSBYPROD (inuProductID,
																												isbServiceNumber,
																												inuRoleID,
																												orfCustUserData,
																												onuErrorCode,
																												osbErrorMessage);

     IF (onuErrorCode = 0) THEN
        If (orfCustUserData%ISOPEN = false) then
          OPEN orfCustUserData FOR SELECT * FROM DUAL WHERE 1 = 2;
        end if;-- IF (orfCustUserData%ISOPEN = false) then
	 else
       OPEN orfCustUserData FOR SELECT * FROM DUAL WHERE 1 = 2;
       raise excep_OS_GETCUSTUSERSBYPROD;
     END IF;-- IF (onuErrorCode = 0) THEN
  EXCEPTION
    WHEN excep_OS_GETCUSTUSERSBYPROD THEN
      rollback;
      Errors.seterror (-1, '[LDCI_PKCRMPORTALWEB.proConsultaTipoClienteProd.excep_OS_GETCUSTUSERSBYPROD]: Error ejecucion API :' || osbErrorMessage);
      --RAISE_APPLICATION_ERROR(-20100, '[LDCI_PKCRMPORTALWEB.proConsultaTipoClienteProd.excep_OS_GETCUSTUSERSBYPROD]:' || chr(13) ||  'Error no controlado: ' || SQLERRM || ' | '||  DBMS_UTILITY.format_error_backtrace);
	WHEN OTHERS THEN
		rollback;
		pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, osbErrorMessage);
		Errors.seterror;
		Errors.geterror (onuErrorCode, osbErrorMessage);
        --RAISE_APPLICATION_ERROR(-20100, '[LDCI_PKCRMPORTALWEB.proBuscarCliente.OTHERS]:' || chr(13) ||  'Error no controlado: ' || SQLERRM || ' | '||  DBMS_UTILITY.format_error_backtrace);
  END proConsultaTipoClienteProd;

  PROCEDURE proBuscarCliente(inuCustomerID           IN NUMBER,
																												inuIdentificationTypeID IN NUMBER,
																												isbIdentification       IN VARCHAR2,
																												orfCustomerData        OUT LDCI_PKREPODATATYPE.tyRefcursor,
																												orfCustWorkData        OUT LDCI_PKREPODATATYPE.tyRefcursor,
																												onuErrorCode           OUT NUMBER,
																												osbErrorMessage        OUT VARCHAR2) as
	/*
	   PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
	   PAQUETE       : LDCI_PKCRMPORTALWEB.proBuscarCliente
	   AUTOR         : OLSoftware / Mauricio Ortiz
	   FECHA         : 19/03/2013
	   RICEF : I020,I038,I039,I040
	   DESCRIPCION: Consulta cliente

	  Historia de Modificaciones
	  Autor   Fecha      Descripcion
	*/

  excep_OS_GETCUSTOMERDATA exception;
  BEGIN
    -- recupera los datos del cliente ejecutando el API OS_GETCUSTOMERDATA
    OS_GETCUSTOMERDATA(inuCustomerID,
																							inuIdentificationTypeID,
																							isbIdentification,
																							orfCustomerData,
																							onuErrorCode,
																							osbErrorMessage);

				-- extrae la informaci??n de la informacion laboral
				open orfCustWorkData for
						select COMPANY,
												HIRE_DATE,
												PHONE_OFFICE,
												TITLE,
												PHONE_EXTENSION
						  from GE_SUBS_WORK_RELAT
          where SUBSCRIBER_ID = inuCustomerID;


    IF (onuErrorCode = 0) THEN
						If (orfCustomerData%ISOPEN = false) then
								OPEN orfCustomerData FOR SELECT * FROM DUAL WHERE 1 = 2;
						end if;-- IF (orfCustomerData%ISOPEN = false) then
				else
						OPEN orfCustomerData FOR SELECT * FROM DUAL WHERE 1 = 2;
						raise excep_OS_GETCUSTOMERDATA;
    END IF;-- IF (onuErrorCode = 0) THEN
  EXCEPTION
    WHEN excep_OS_GETCUSTOMERDATA THEN
      rollback;
      Errors.seterror (-1, '[LDCI_PKCRMPORTALWEB.proBuscarCliente.excep_OS_GETCUSTOMERDATA]: Error ejecucion API :' || osbErrorMessage);
				WHEN OTHERS THEN
					rollback;
					pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, osbErrorMessage);
					Errors.seterror;
					Errors.geterror (onuErrorCode, osbErrorMessage);
  END proBuscarCliente;

  procedure proConsultaTecnico(sbIdentificacion in GE_PERSON.number_id%TYPE,
																														orfTecnicos      out LDCI_PKREPODATATYPE.tyRefcursor,
																														onuErrorCode     out NUMBER,
																														osbErrorMessage  out VARCHAR2) as
	/*
	   PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
	   PAQUETE       : LDCI_PKCRMPORTALWEB.proConsultaTecnico
	   AUTOR         : OLSoftware / Mauricio Ortiz
	   FECHA         : 19/03/2013
	   RICEF : I020,I038,I039,I040
	   DESCRIPCION: Consulta informacion del tecnioc

	  Historia de Modificaciones
	  Autor     Fecha       Descripcion
			carlosvl  21-08-2013  Se ajusta la consulta para que filtre los tecnicos por la tabla OR_OPER_UNIT_PERSONS y no por el campo
                          OR_OPERATING_UNIT.PERSON_IN_CHARGE
	*/
    recConTecnicos   LDCI_PKREPODATATYPE.tyTecnicoRecord;
  begin
    -- carga el cusor referenciado
	open orftecnicos for
			select ou.OPERATING_UNIT_ID OPER_UNIT_ID,
									pe.NUMBER_ID CEDULA,
									pe.NAME_ NOMBRE,
									pe.PERSON_ID ID_PERSON,
									ou.OPER_UNIT_STATUS_ID ID_ESTADO,
									ous.DESCRIPTION ESTADO,
									ou.OPER_UNIT_CLASSIF_ID ID_CLASIF,
									cl.DESCRIPTION CLASIFICACION,
									pe.PERSONAL_TYPE ID_TIPO_PERSONAL,
									pt.DESCRIPTION TIPO_PERSONAL,
									pe.PHONE_NUMBER TELEFONO,
									pe.BEEPER BEEPER,
									pe.E_MAIL EMAIL,
									pe.ADDRESS_ID ID_DIRECCION,
									LDCI_PKBSSRECA.fsbGenAddress(PE.ADDRESS_ID) DIRECCION,
									co.ID_CONTRATISTA ID_CONTRATISTA,
									co.NOMBRE_CONTRATISTA CONTRATISTA
					from OR_OPERATING_UNIT ou,
									GE_PERSON  pe,
									OR_OPER_UNIT_CLASSIF cl,
									OR_OPER_UNIT_STATUS ous,
									GE_PERSONAL_TYPE pt,
									GE_CONTRATISTA co,
									OR_OPER_UNIT_PERSONS oup
					where pe.NUMBER_ID = sbidentificacion
 						and ou.OPER_UNIT_CLASSIF_ID = cl.OPER_UNIT_CLASSIF_ID
	 					and ou.OPER_UNIT_STATUS_ID = ous.OPER_UNIT_STATUS_ID
		 				and pe.PERSONAL_TYPE = pt.PERSONAL_TYPE
			 			and co.ID_CONTRATISTA = CONTRACTOR_ID
				 		and oup.OPERATING_UNIT_ID = ou.OPERATING_UNIT_ID
					 	and oup.PERSON_ID = pe.PERSON_ID;

    onuErrorCode:= 0;
  exception
    when others then
      pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, osbErrorMessage);
      Errors.seterror;
      Errors.geterror (onuErrorCode, osbErrorMessage);
  end proConsultaTecnico;

END LDCI_PKCRMPORTALWEB;
/

PROMPT Asignación de permisos para el paquete LDCI_PKCRMPORTALWEB
begin
  pkg_utilidades.prAplicarPermisos('LDCI_PKCRMPORTALWEB', 'ADM_PERSON');
end;
/
GRANT EXECUTE on ADM_PERSON.LDCI_PKCRMPORTALWEB to INTEGRACIONES;
GRANT EXECUTE on ADM_PERSON.LDCI_PKCRMPORTALWEB to INTEGRADESA;
/
