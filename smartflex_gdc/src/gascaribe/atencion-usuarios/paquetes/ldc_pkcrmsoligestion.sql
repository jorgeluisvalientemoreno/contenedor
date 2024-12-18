CREATE OR REPLACE PACKAGE LDC_PKCRMSOLIGESTION AS

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         :  LDC_PKCRMGESTION
  Descripcion    : Paquete para el manejo de la solicitud de gestion
  Autor          : Karem Baquero
  Fecha          : 27/09/2016 CA 200-426

  Metodos

  Nombre         :
  Parametros         Descripcion
  ============   ===================
  Historia de Modificaciones
  Fecha         Autor                   Modificacion
  =========     =========               ====================
  15-05-2024	 	JSOTO			   OSF-2602 Se reemplaza uso de LDC_Email.mail por pkg_correo.prcEnviaCorreo

  ******************************************************************/

  PROCEDURE ProcinidatsoligestI(inupack         in mo_packages.package_id%type,
                               odtrequest      out mo_packages.request_date%type,
                               onupaktype      out mo_packages.package_type_id%type,
                               osbobs          out mo_packages.comment_%type,
                               OCONTRACT       OUT mo_packages.Subscription_Pend_Id%type,
                               onuErrorCode    out number,
                               osbErrorMessage out varchar2);

  PROCEDURE PROCENVIAMAILSOLIGESTI(INUPACK in mo_packages.package_id%type,
                                 ONUERRORCODE    out number,
                                 OSBERRORMESSAGE out varchar2);

END LDC_PKCRMSOLIGESTION;
/
CREATE OR REPLACE package body LDC_PKCRMSOLIGESTION AS
  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         :  LDC_PKCRMGESTION
  Descripcion    : Paquete para el manejo de la solicitud de gestion
  Autor          : Karem Baquero
  Fecha          : 27/09/2016 CA 200-426

  Metodos

  Nombre         :
  Parametros         Descripcion
  ============   ===================
  Historia de Modificaciones
  Fecha         Autor                   Modificacion
  =========     =========               ====================
  22/03/2019     JM-ROBPAR              Se agrego un correo comodin para los
                                        casos en los que el correo se null.
  ******************************************************************/

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         :  Procinidatsoligest
  Descripcion    : Proceso para obtener los datos que se van a registrar en la tabla LDC_SOLIGESTI
  Autor          : Karem Baquero
  Fecha          : 29/09/2016 CA 200-426

  Metodos

  Nombre         :
  Parametros         Descripcion
  ============   ===================
  Historia de Modificaciones
  Fecha         Autor                   Modificacion
  =========     =========               ====================

  ******************************************************************/

  --********************************************************************************************

  PROCEDURE ProcinidatsoligestI(inupack         in mo_packages.package_id%type,
                               odtrequest      out mo_packages.request_date%type,
                               onupaktype      out mo_packages.package_type_id%type,
                               osbobs          out mo_packages.comment_%type,
                               OCONTRACT       OUT mo_packages.Subscription_Pend_Id%type,
                               onuErrorCode    out number,
                               osbErrorMessage out varchar2) IS

  BEGIN
    UT_TRACE.TRACE('**************** INICIO LDC_PKCRMGESTION.Procinidatsoligest  ',
                   10);

    SELECT m.request_date, m.package_type_id, m.comment_ , O.SUBSCRIPTION_ID
      INTO odtrequest, onupaktype, osbobs , OCONTRACT
      FROM mo_packages m, MO_MOTIVE O
     WHERE m.package_id = inupack
     AND M.PACKAGE_ID=O.PACKAGE_ID;

    UT_TRACE.TRACE('**************** Fin LDC_PKCRMGESTION.Procinidatsoligest  ',
                   10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      errors.geterror(onuErrorCode, osbErrorMessage);
      raise ex.CONTROLLED_ERROR;

  END ProcinidatsoligestI;

  --********************************************************************************************

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         :  PROCENVIAMAILSOLIGEST
  Descripcion    : Proceso de acci?n del tr?mite de solicitud de gestion con el cual se va a enviar
                   el correo electronico.
  Autor          : Karem Baquero
  Fecha          : 29/09/2016 CA 200-426

  Metodos

  Nombre         :
  Parametros         Descripcion
  ============   ===================
  Historia de Modificaciones
  Fecha         Autor                   Modificacion
  =========     =========               ====================

  ******************************************************************/

  PROCEDURE PROCENVIAMAILSOLIGESTI(INUPACK         in mo_packages.package_id%type,
                                 ONUERRORCODE    out number,
                                 OSBERRORMESSAGE out varchar2) IS

    /*Cursor para obtener la infdormaci?n de la solicitud de gestion*/
    cursor cusoligest is
      SELECT l.subscription_id, l.package_id_asso, l.person_id
        FROM LDC_SOLIGESTI l
       WHERE l.package_id = INUPACK;

    sender     varchar2(2000);
    sbAsunto   varchar2(200);
    sbMensaje  varchar2(8000);
    sbcomment  mo_packages.comment_%type;
    sbcommento mo_packages.comment_%type;
    Sbpacktype ps_package_type.description%type;
    dtfechreg  mo_packages.request_date%type;
    sbcorreo   ge_person.e_mail%type;
    sbperson   ge_person.name_%type;
    INUPACKO   mo_packages.package_id%type;
    INUPERSID  mo_packages.person_id%type;
    Inususc    mo_packages.subscription_pend_id%type;

    -- inicio 329
    sbAddress  		AB_ADDRESS.ADDRESS%type;
    sbUbicacion    	GE_GEOGRA_LOCATION.DISPLAY_DESCRIPTION%type;

    cursor cuaddress is
    	select a.ADDRESS,
		DAGE_GEOGRA_LOCATION.FSBGETDISPLAY_DESCRIPTION(a.GEOGRAP_LOCATION_ID)
		from AB_ADDRESS a
		where a.ADDRESS_ID = (select DAPR_PRODUCT.FNUGETADDRESS_ID(SESUNUSE) from SERVSUSC
                            where SESUSUSC = Inususc and SESUSERV = DALD_PARAMETER.FNUGETNUMERIC_VALUE('COD_SERV_GAS',NULL));
    -- fin 329

  BEGIN
    UT_TRACE.TRACE('**************** INICIO LDC_PKCRMGESTION.PROCENVIAMAILSOLIGEST  ',
                   10);

      open cusoligest;
    fetch cusoligest
      INTO Inususc,INUPACKO,INUPERSID;
    close cusoligest;

    open cuaddress;
    fetch cuaddress
      INTO sbAddress,sbUbicacion;
    close cuaddress;


      UT_TRACE.TRACE('**************** INUPACK ' || INUPACK, 10);

    sbcomment := damo_packages.fsbgetcomment_(INUPACK, null);
    sbperson  := dage_person.fsbgetname_(damo_packages.fnugetperson_id(INUPACK,
                                                                       null),
                                         null);

    sbcommento := damo_packages.fsbgetcomment_(INUPACKO, null);
    Sbpacktype := daps_package_type.fsbgetdescription(damo_packages.fnugetpackage_type_id(INUPACKO,
                                                                                          null));
    dtfechreg  := damo_packages.fdtgetrequest_date(INUPACKO, null);

    sbcorreo := dage_person.fsbgete_mail(INUPERSID, null);

    sender    := DALD_PARAMETER.fsbGetValue_Chain('LDC_SMTP_SENDER');
    sbAsunto  := 'Notificacion de la Solicitud de Gestion, creado desde la solicitud ' ||
                 INUPACK;
    sbMensaje := 'Se requiere dar prioridad en el menor tiempo posible al siguiente requerimiento: ' ||
                 sbcomment || chr(13) ||chr(13) ||
                 'Teniendo en cuenta que los datos del cliente son:  CONTRATO ' || Inususc || chr(13) ||
                  ' DIRECCION: ' || sbAddress || chr(13) ||
                  ' UBICACION GEOGRAFICA DE CONTACTO: ' || sbUbicacion || chr(13) ||chr(13) ||
                  ' Numero de la solicitud : ' || INUPACKO || '    Nombre de la solicitud : ' || Sbpacktype || chr(13) ||
                  ' Fecha de Registro : ' || dtfechreg || chr(13) || chr(13) ||
                 ' Observacion de la solicitud:  ' || sbcommento || chr(13) || chr(13) ||
                 chr(13) || 'Agradecemos la pronta gestion.' || chr(13) ||
                 chr(13) || sbperson;

    /*modificacion(Inicio)*/
      --En caso de que el correo llegue vacio se cambiara por un correo comodin
      --Cambio solicitado en el caso 200-2482
    if  sbcorreo is null  then
      sbcorreo:=Open.Dald_parameter.fsbgetvalue_chain('CORR_COMO_SOLI_GEST');
    end if;
    /*modificacion(Fin)*/
	
    pkg_Correo.prcEnviaCorreo
							(
								isbRemitente        => sender,
								isbDestinatarios    => sbcorreo,
								isbAsunto           => sbAsunto,
								isbMensaje          => sbMensaje
							);


    UT_TRACE.TRACE('**************** Fin LDC_PKCRMGESTION.PROCENVIAMAILSOLIGEST  ',
                   10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      Errors.setError;
      errors.geterror(onuErrorCode, osbErrorMessage);
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      errors.geterror(onuErrorCode, osbErrorMessage);
      raise ex.CONTROLLED_ERROR;

  END PROCENVIAMAILSOLIGESTI;

END LDC_PKCRMSOLIGESTION;
/
