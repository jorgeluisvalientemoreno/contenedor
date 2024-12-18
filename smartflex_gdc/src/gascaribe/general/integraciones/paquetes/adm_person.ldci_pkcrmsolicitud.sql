CREATE OR REPLACE PACKAGE ADM_PERSON.LDCI_PKCRMSOLICITUD
AS
    /************************************************************************

     PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P



             PAQUETE : LDCI_PKCRMSOLICITUD

             AUTOR   : Hector Fabio Dominguez

             FECHA   : 26/02/2013

             RICEF   : I027

       DESCRIPCION   : Paquete de interfaz que contiene todas las funcionalidades para

                       la consulta y creaci??n de solicitudes.



     Historia de Modificaciones



     Autor        Fecha       Descripcion.

     HECTORFDV    29/01/2013  Creacion del paquete
     JOSDON       23/10/2018  Creacion de procedimiento proCnltaSolicitudesxInteraccion
     JOSDON       04/12/2018  Modificaci?n de procedimiento proCnltaSolicitudesxInteraccion
	 jsoto 		  17/11/2023	Ajustes ((OSF-1806)):
								-Ajustes cambio en llamado a algunos de los objetos de producto por personalizados
								-Ajuste  cambio en manejo de trazas y errores por personalizados (pkg_error y pkg_traza).
								-Ajuste llamado a pkg_xml_sol_seguros para armar los xml de las solicitudes
								-Ajuste llamado a api_registerRequestByXml
								-Ajuste llamado a api_createorder para crear ordenes y actividades
								-Se suprimen llamado a "AplicaEntrega" que no se encuentren activos

    ************************************************************************/

    TYPE tORFENTITY IS REF CURSOR;

    PROCEDURE proCnltaOrdnsPorSolicitud (INUPACKAGEID      IN     NUMBER,
                                         OCUORDERS            OUT SYS_REFCURSOR,
                                         ONUERRORCODE         OUT NUMBER,
                                         OSBERRORMESSAGE      OUT VARCHAR2);

    PROCEDURE proCnltaOrdenPorId (INUORDERID         IN     NUMBER,
                                  OCUORDER              OUT SYS_REFCURSOR,
                                  OCUORDERACTIVITY      OUT SYS_REFCURSOR,
                                  ONUERRORCODE          OUT NUMBER,
                                  OSBERRORMESSAGE       OUT VARCHAR2);

    PROCEDURE proSolicitudDuplicado (
        inuSuscCodi       IN     SUSCRIPC.SUSCCODI%TYPE,
        inuRecepTipo      IN     NUMBER,
        odtLimitePago        OUT DATE,
        onuPackageId         OUT mo_packages.package_id%TYPE,
        onuMotiveId          OUT mo_motive.motive_id%TYPE,
        ONUERRORCODE      IN OUT NUMBER,
        OSBERRORMESSAGE   IN OUT VARCHAR2);

    PROCEDURE proSolicGnraPorIdentif (
        isbIdentif     IN GE_SUBSCRIBER.IDENTIFICATION%TYPE,
        inuTipoRecep   IN NUMBER,
        inuClaseInfo   IN NUMBER,
        inuTipoInfo    IN NUMBER,
        isbObserva     IN VARCHAR2,
        inuRolId       IN NUMBER,
        inuCustomer    IN NUMBER,
        inuIdAddress   IN NUMBER,
        isbTerminal    IN VARCHAR2);

    PROCEDURE proSolicitudGeneral (
        inuSuscCodi       IN     SUSCRIPC.SUSCCODI%TYPE,
        inuTipoRecep      IN     NUMBER,
        inuClaseInfo      IN     NUMBER,
        inuTipoInfo       IN     NUMBER,
        isbObserva        IN     VARCHAR2,
        inuRolId          IN     NUMBER,
        inuCustomer       IN     NUMBER,
        inuContactId      IN     NUMBER,
        inuIdAddress      IN     NUMBER,
        isbTerminal       IN     VARCHAR2,
        nuMotiveId        IN OUT NUMBER,
        nuPackageId       IN OUT NUMBER,
        ONUERRORCODE      IN OUT NUMBER,
        OSBERRORMESSAGE   IN OUT VARCHAR2);

    PROCEDURE proSolVisitBrilla (
        inuSubscription        IN     MO_PACKAGES.SUBSCRIPTION_PEND_ID%TYPE,
        inuPerson              IN     GE_PERSON.PERSON_ID%TYPE,
        inuReception_Type      IN     MO_PACKAGES.RECEPTION_TYPE_ID%TYPE,
        inuSubsType            IN     GE_SUBSCRIBER.SUBSCRIBER_TYPE_ID%TYPE,
        inuTypeId              IN     GE_SUBSCRIBER.IDENT_TYPE_ID%TYPE,
        isbClient_Ident        IN     GE_SUBSCRIBER.IDENTIFICATION%TYPE,
        isbName                IN     GE_SUBSCRIBER.SUBSCRIBER_NAME%TYPE,
        isbLastName            IN     GE_SUBSCRIBER.SUBS_LAST_NAME%TYPE,
        inuRoleId              IN     CC_ROLE.ROLE_ID%TYPE,
        inuVisitType           IN     LD_SALES_VISIT.VISIT_TYPE_ID%TYPE,
        inuItem_id             IN     LD_SALES_VISIT.ITEM_ID%TYPE,
        inuRefer_Mode          IN     MO_PACKAGES.REFER_MODE_ID%TYPE,
        inuVisit_Sale_Cru_Id   IN     LD_SALES_VISIT.VISIT_SALE_CRU_ID%TYPE,
        inuShopkeeper          IN     LD_SHOPKEEPER.SHOPKEEPER_ID%TYPE,
        isbComment             IN     MO_PACKAGES.COMMENT_%TYPE,
        inuoperativa           IN     MO_PACKAGES.OPERATING_UNIT_ID%TYPE,
        onuPackage_Id             OUT MO_PACKAGES.PACKAGE_ID%TYPE,
        onuErrorCode              OUT GE_MESSAGE.MESSAGE_ID%TYPE,
        osbErrorMessage           OUT GE_MESSAGE.DESCRIPTION%TYPE);

    PROCEDURE proSolicGnraPorCttoAsyn (
        inuSuscCodi    IN SUSCRIPC.SUSCCODI%TYPE,
        inuTipoRecep   IN NUMBER,
        inuClaseInfo   IN NUMBER,
        inuTipoInfo    IN NUMBER,
        isbObserva     IN VARCHAR2,
        inuRolId       IN NUMBER,
        inuCustomer    IN NUMBER,
        inuIdAddress   IN NUMBER,
        isbTerminal    IN VARCHAR2);

    PROCEDURE proCnltaSolicitudesxInterac (
        inuInteraccion    IN     MO_PACKAGES.PACKAGE_ID%TYPE,
        ocuSolicitudes       OUT SYS_REFCURSOR,
        onuErrorCode         OUT GE_MESSAGE.MESSAGE_ID%TYPE,
        osbErrorMessage      OUT GE_MESSAGE.DESCRIPTION%TYPE);
END LDCI_PKCRMSOLICITUD;
/

CREATE OR REPLACE PACKAGE BODY ADM_PERSON.LDCI_PKCRMSOLICITUD
AS
    /************************************************************************

       PROCEDIMIENTO : LDCI_PKCRMSOLICITUD.proSolicGnraPorCttoAsyn

       AUTOR         : Hector Fabio Dominguez

       FECHA         : 28/05/2013

       RICEF         : I041

       DESCRIPCION   : Permite realizar solicitud de atencion general por contrato

                       y de forma asincrona



      Historia de Modificaciones

      Autor   Fecha      Descripcion

    ************************************************************************/
	
	
	csbNOMPKG            CONSTANT VARCHAR2(32)       := $$PLSQL_UNIT||'.';
	nuError				 NUMBER;
	sbError				 VARCHAR2(2000);


    PROCEDURE proSolicGnraPorCttoAsyn (
        inuSuscCodi    IN SUSCRIPC.SUSCCODI%TYPE,
        inuTipoRecep   IN NUMBER,
        inuClaseInfo   IN NUMBER,
        inuTipoInfo    IN NUMBER,
        isbObserva     IN VARCHAR2,
        inuRolId       IN NUMBER,
        inuCustomer    IN NUMBER,
        inuIdAddress   IN NUMBER,
        isbTerminal    IN VARCHAR2)
    AS
        nuMotiveId                NUMBER;
        nuPackageId               NUMBER;
        ONUERRORCODE              NUMBER;
        OSBERRORMESSAGE           VARCHAR2 (2000);
        inuContactId              NUMBER;
        ERROR_CREANDO_SOLICITUD   EXCEPTION;
        PRAGMA EXCEPTION_INIT (ERROR_CREANDO_SOLICITUD, -2291);
		
		csbMetodo  CONSTANT VARCHAR2(100) := csbNOMPKG||'proSolicGnraPorCttoAsyn';
		
    BEGIN
	
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

        /*
         * Consultamos el codigo del suscriptor a partir del la identificaci??n
         *

        */

        proSolicitudGeneral (inuSuscCodi,
                             inuTipoRecep,
                             inuClaseInfo,
                             inuTipoInfo,
                             isbObserva,
                             inuRolId,
                             inuCustomer,
                             inuContactId,
                             inuIdAddress,
                             isbTerminal,
                             nuMotiveId,
                             nuPackageId,
                             ONUERRORCODE,
                             OSBERRORMESSAGE);
		
		pkg_traza.trace(csbMetodo|| ' nuPackageId'|| nuPackageId );

        IF ONUERRORCODE <> 0 THEN
		    pkg_traza.trace(csbMetodo|| ' OSBERRORMESSAGE'|| OSBERRORMESSAGE );
            raise_application_error (
                -20000,
                ONUERRORCODE || ' - ' || OSBERRORMESSAGE);
        END IF;
		
		
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
		
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            ROLLBACK;
            onuErrorCode := -1;
			pkg_error.setErrorMessage(ONUERRORCODE,OSBERRORMESSAGE);
			pkg_error.getError(nuError, sbError);
			pkg_traza.trace(csbMetodo||' :'||OSBERRORMESSAGE||nuError||':'||sbError);
			pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
			raise_application_error ( -20000,'Error creando la solicitud de atencion ' || OSBERRORMESSAGE);
        WHEN OTHERS THEN
 			pkg_error.setErrorMessage(ONUERRORCODE,OSBERRORMESSAGE);
			onuErrorCode := -1;
			pkg_error.getError(nuError, sbError);
			pkg_traza.trace(csbMetodo||' :'||OSBERRORMESSAGE||nuError||':'||sbError);
			pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            raise_application_error ( -20000, 'Error creando la solicitud de atencion ' ||' '|| OSBERRORMESSAGE);
    END;

    /************************************************************************

       PROCEDIMIENTO : LDCI_PKCRMSOLICITUD.proSolicGnraPorIdentif

       AUTOR         : Hector Fabio Dominguez

       FECHA         : 28/05/2013

       REQUERIMIENTO : I041

       DESCRIPCION   : Permite realizar solicitud de atencion general por identificacion

                       y de forma asincrona



      Historia de Modificaciones

      Autor   Fecha      Descripcion

    ************************************************************************/

    PROCEDURE proSolicGnraPorIdentif (
        isbIdentif     IN GE_SUBSCRIBER.IDENTIFICATION%TYPE,
        inuTipoRecep   IN NUMBER,
        inuClaseInfo   IN NUMBER,
        inuTipoInfo    IN NUMBER,
        isbObserva     IN VARCHAR2,
        inuRolId       IN NUMBER,
        inuCustomer    IN NUMBER,
        inuIdAddress   IN NUMBER,
        isbTerminal    IN VARCHAR2)
    AS
        inuSuscCodi               SUSCRIPC.SUSCCODI%TYPE;
        nuMotiveId                NUMBER;
        nuPackageId               NUMBER;
        ONUERRORCODE              NUMBER;
        OSBERRORMESSAGE           VARCHAR2 (2000);
        inuContactId              NUMBER;
        ERROR_CREANDO_SOLICITUD   EXCEPTION;
		
		
		CURSOR cuContrato IS
            SELECT SUBSCRIBER_ID
              FROM GE_SUBSCRIBER
             WHERE IDENTIFICATION = isbIdentif AND ROWNUM = 1;

        PRAGMA EXCEPTION_INIT (ERROR_CREANDO_SOLICITUD, -2291);
		
		csbMetodo  CONSTANT VARCHAR2(100) := csbNOMPKG||'proSolicGnraPorIdentif';

		
    BEGIN


		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);


        /*
         * Consultamos el codigo del suscriptor a partir del la identificaci??n
        */

        BEGIN
			IF cuContrato%ISOPEN THEN
				CLOSE cuContrato;
			END IF;
		
			OPEN cuContrato;
			FETCH cuContrato INTO inuContactId;
				IF cuContrato%NOTFOUND THEN
					CLOSE cuContrato;
					RAISE NO_DATA_FOUND;
				END IF;
			CLOSE cuContrato;
			
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                raise_application_error (-20000,'Error consultando el cliente con la identificacion ['
                                         || isbIdentif || ']');

            WHEN OTHERS THEN
                raise_application_error (-20000,'Otros: Error consultando el cliente con la identificacion ['
                                         || isbIdentif || ']');
        END;

        proSolicitudGeneral (inuSuscCodi,
                             inuTipoRecep,
                             inuClaseInfo,
                             inuTipoInfo,
                             isbObserva,
                             inuRolId,
                             inuCustomer,
                             inuContactId,
                             inuIdAddress,
                             isbTerminal,
                             nuMotiveId,
                             nuPackageId,
                             ONUERRORCODE,
                             OSBERRORMESSAGE);


        IF ONUERRORCODE <> 0 THEN     
			raise_application_error (-20000, ONUERRORCODE || ' - ' || OSBERRORMESSAGE);
        END IF;

		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            ROLLBACK;
            onuErrorCode := -1;
			pkg_error.setErrorMessage(ONUERRORCODE,OSBERRORMESSAGE);
			pkg_error.getError(nuError, sbError);
			pkg_traza.trace(csbMetodo||' :'||OSBERRORMESSAGE||nuError||':'||sbError);
			pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
			raise_application_error ( -20000,'Error creando la solicitud de atencion ' || OSBERRORMESSAGE);
        WHEN OTHERS THEN
            onuErrorCode := -1;
 			pkg_error.setErrorMessage(ONUERRORCODE,OSBERRORMESSAGE);
			onuErrorCode := -1;
			pkg_error.getError(nuError, sbError);
			pkg_traza.trace(csbMetodo||' :'||OSBERRORMESSAGE||nuError||':'||sbError);
			pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            raise_application_error ( -20000, 'Error creando la solicitud de atencion ' ||' '|| OSBERRORMESSAGE);
    END;

    /************************************************************************

       PROCEDIMIENTO : LDCI_PKCRMSOLICITUD.proSolVisitBrilla

       AUTOR         : Hector Fabio Dominguez

       FECHA         : 28/05/2013

       RICEF         : I037

       DESCRIPCION   : Permite realizar la consulta de una orden por el id



      Historia de Modificaciones

      Autor          Fecha              Descripcion

      Kbaquero       17/12/2016         Caso 200-633  se le agrega un campo al proceso

                                        la unidad operativa, para la asignaci?n de la orden

                                        creada.

    ************************************************************************/

    PROCEDURE proSolVisitBrilla (
        inuSubscription        IN     MO_PACKAGES.SUBSCRIPTION_PEND_ID%TYPE,
        inuPerson              IN     GE_PERSON.PERSON_ID%TYPE,
        inuReception_Type      IN     MO_PACKAGES.RECEPTION_TYPE_ID%TYPE,
        inuSubsType            IN     GE_SUBSCRIBER.SUBSCRIBER_TYPE_ID%TYPE,
        inuTypeId              IN     GE_SUBSCRIBER.IDENT_TYPE_ID%TYPE,
        isbClient_Ident        IN     GE_SUBSCRIBER.IDENTIFICATION%TYPE,
        isbName                IN     GE_SUBSCRIBER.SUBSCRIBER_NAME%TYPE,
        isbLastName            IN     GE_SUBSCRIBER.SUBS_LAST_NAME%TYPE,
        inuRoleId              IN     CC_ROLE.ROLE_ID%TYPE,
        inuVisitType           IN     LD_SALES_VISIT.VISIT_TYPE_ID%TYPE,
        inuItem_id             IN     LD_SALES_VISIT.ITEM_ID%TYPE,
        inuRefer_Mode          IN     MO_PACKAGES.REFER_MODE_ID%TYPE,
        inuVisit_Sale_Cru_Id   IN     LD_SALES_VISIT.VISIT_SALE_CRU_ID%TYPE,
        inuShopkeeper          IN     LD_SHOPKEEPER.SHOPKEEPER_ID%TYPE,
        isbComment             IN     MO_PACKAGES.COMMENT_%TYPE,
        inuoperativa           IN     MO_PACKAGES.OPERATING_UNIT_ID%TYPE,
        onuPackage_Id             OUT MO_PACKAGES.PACKAGE_ID%TYPE,
        onuErrorCode              OUT GE_MESSAGE.MESSAGE_ID%TYPE,
        osbErrorMessage           OUT GE_MESSAGE.DESCRIPTION%TYPE)
    AS
        inuVisitAddress   LD_SALES_VISIT.VISIT_ADDRESS_ID%TYPE;
		
		CURSOR cuDireccion IS
        SELECT SUSCIDDI
          FROM SUSCRIPC
         WHERE SUSCCODI = inuSubscription AND ROWNUM = 1;
		 
		csbMetodo  CONSTANT VARCHAR2(100) := csbNOMPKG||'proSolVisitBrilla';
		
		
    BEGIN
	
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
	
		IF cuDireccion%ISOPEN THEN
			CLOSE cuDireccion;
		END IF;
		
		OPEN cuDireccion;
		FETCH cuDireccion INTO inuVisitAddress;
		CLOSE cuDireccion;

        --29-05-2013: carlosvl: Comenta codigo original error en el llamado, algun cambio de parametros de entrada o salida

        OS_VISITPACKAGES (INUSUBSCRIPTION        => INUSUBSCRIPTION,
                          INUPERSON              => INUPERSON,
                          INURECEPTION_TYPE      => INURECEPTION_TYPE,
                          INUSUBSTYPE            => INUSUBSTYPE,
                          INUTYPEID              => INUTYPEID,
                          ISBCLIENT_IDENT        => ISBCLIENT_IDENT,
                          ISBNAME                => ISBNAME,
                          ISBLASTNAME            => ISBLASTNAME,
                          INUROLEID              => INUROLEID,
                          INUVISITTYPE           => INUVISITTYPE,
                          INUITEM_ID             => INUITEM_ID,
                          INUVISITADDRESS        => INUVISITADDRESS,
                          INUREFER_MODE          => INUREFER_MODE,
                          INUVISIT_SALE_CRU_ID   => INUVISIT_SALE_CRU_ID,
                          INUSHOPKEEPER          => INUSHOPKEEPER,
                          ISBCOMMENT_            => ISBCOMMENT,
                          inuoperativa           => inuoperativa,
                          ONUPACKAGE_ID          => ONUPACKAGE_ID,
                          ONUERRORCODE           => ONUERRORCODE,
                          OSBERRORMESSAGE        => OSBERRORMESSAGE);

        COMMIT;

        IF ONUERRORCODE IS NULL
        THEN
            ONUERRORCODE := -666;
        END IF;

        
		pkg_traza.trace ('ONUPACKAGE_ID = ' || ONUPACKAGE_ID);

        pkg_traza.trace ('ONUERRORCODE = ' || ONUERRORCODE);

        pkg_traza.trace ('OSBERRORMESSAGE = ' || OSBERRORMESSAGE);
		
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
		
		
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            ROLLBACK;
            onuErrorCode := -1;
			pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
        WHEN OTHERS THEN
			pkg_error.getError(nuError, sbError);
            osbErrorMessage := 'Error en proceso de consulta de saldo brilla: ' || sbError;       
			pkg_error.setErrorMessage(ONUERRORCODE, osbErrorMessage);
            onuErrorCode := -1;
			pkg_traza.trace(csbMetodo||' :'||osbErrorMessage||nuError||':'||sbError);
			pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
    END proSolVisitBrilla;

    /************************************************************************

       PROCEDIMIENTO : LDCI_PKCRMSOLICITUD.proCnltaOrdenPorId

       AUTOR         : Hector Fabio Dominguez

       FECHA         : 26/02/2013

       RICEF         : I029

       DESCRIPCION   : Permite realizar la consulta de una orden por el id



      Historia de Modificaciones

      Autor   Fecha      Descripcion

    ************************************************************************/

    PROCEDURE proCnltaOrdenPorId (INUORDERID         IN     NUMBER,
                                  OCUORDER              OUT SYS_REFCURSOR,
                                  OCUORDERACTIVITY      OUT SYS_REFCURSOR,
                                  ONUERRORCODE          OUT NUMBER,
                                  OSBERRORMESSAGE       OUT VARCHAR2)
    AS
	
	csbMetodo  CONSTANT VARCHAR2(100) := csbNOMPKG||'proCnltaOrdenPorId';
	
    BEGIN
	
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
		
        API_GETBASICDATAORDER (INUORDERID,
                              OCUORDER,
                              OCUORDERACTIVITY,
                              ONUERRORCODE,
                              OSBERRORMESSAGE);

        IF NOT OCUORDER%ISOPEN THEN

            OPEN OCUORDER FOR SELECT *
                                FROM DUAL
                               WHERE 1 = 2;
        END IF;

        IF NOT OCUORDERACTIVITY%ISOPEN THEN
            OPEN OCUORDERACTIVITY FOR SELECT *
                                        FROM DUAL
                                       WHERE 1 = 2;
        END IF;
		
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
		
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            ROLLBACK;
            pkg_error.getError (nuError, sbError);
			pkg_traza.trace(csbMetodo||' '||OSBERRORMESSAGE||' -'||nuError||' :'||sbError);
			pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
        WHEN OTHERS THEN
			pkg_error.getError (nuError, sbError);
            osbErrorMessage := 'Error consultando los datos basicos de la orden: '||osbErrorMessage ;
            pkg_error.setErrorMessage(onuErrorCode, osbErrorMessage);
			pkg_traza.trace(csbMetodo||' '||OSBERRORMESSAGE||' -'||nuError||' :'||sbError);
			pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
    END;

    /************************************************************************

       PROCEDIMIENTO : LDCI_PKCRMSOLICITUD.proCnltaOrdnsPorSolicitud

       AUTOR         : Hector Fabio Dominguez

       FECHA         : 26/02/2013

       RICEF         : I028

       DESCRIPCION   : Permite listar ordenes por solicitud



      Historia de Modificaciones

      Autor   Fecha      Descripcion

    ************************************************************************/

    PROCEDURE proCnltaOrdnsPorSolicitud (INUPACKAGEID      IN     NUMBER,
                                         OCUORDERS            OUT SYS_REFCURSOR,
                                         ONUERRORCODE         OUT NUMBER,
                                         OSBERRORMESSAGE      OUT VARCHAR2)
    AS
        ORDERID   NUMBER;
		csbMetodo  CONSTANT VARCHAR2(100) := csbNOMPKG||'proCnltaOrdnsPorSolicitud';
    BEGIN
	
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
		
        /* TAREA Se necesita implementaci??n */

        api_getorderbypackage(INUPACKAGEID      => INUPACKAGEID,
                              OCUORDERS         => OCUORDERS,
                              ONUERRORCODE      => ONUERRORCODE,
                              OSBERRORMESSAGE   => OSBERRORMESSAGE);

        IF NOT OCUORDERS%ISOPEN
        THEN
            OPEN OCUORDERS FOR SELECT *
                                 FROM DUAL
                                WHERE 1 = 2;
        END IF;
		
		
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
		
		
		
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            ROLLBACK;
            pkg_error.geterror (nuError, sbError);
			pkg_error.setErrorMessage(onuErrorCode, osbErrorMessage);
			pkg_traza.trace(csbMetodo||' '||OSBERRORMESSAGE||' -'||nuError||' :'||sbError);
			pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
        WHEN OTHERS
        THEN
            osbErrorMessage := 'Error en proceso de consulta de orden por solicitud: '|| OSBERRORMESSAGE;
            pkg_error.geterror (nuError, sbError);
            pkg_error.setErrorMessage(onuErrorCode, osbErrorMessage);
			pkg_traza.trace(csbMetodo||' '||OSBERRORMESSAGE||' -'||nuError||' :'||sbError);
			pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);

    END proCnltaOrdnsPorSolicitud;

    /************************************************************************

       PROCEDIMIENTO : LDCI_PKCRMSOLICITUD.proSolicitudDuplicado

       AUTOR         : Hector Fabio Dominguez

       FECHA         : 26/02/2013

       RICEF         : I025

       DESCRIPCION   : Permite listar ordenes por solicitud



      Historia de Modificaciones

      Autor                 Fecha        Descripcion

      Nivis Carrasquilla    19/09/2916   CA 200542. Se crea cursor cuValidaSolicitudDuplicadoMod

                                         para que busque por contrato y no por cliente

    ************************************************************************/

    PROCEDURE proSolicitudDuplicado (
        inuSuscCodi       IN     SUSCRIPC.SUSCCODI%TYPE,
        inuRecepTipo      IN     NUMBER,
        odtLimitePago        OUT DATE,
        onuPackageId         OUT mo_packages.package_id%TYPE,
        onuMotiveId          OUT mo_motive.motive_id%TYPE,
        ONUERRORCODE      IN OUT NUMBER,
        OSBERRORMESSAGE   IN OUT VARCHAR2)
    AS

        nuIdAddress                     suscripc.SUSCIDDI%TYPE;
        nususclient                     suscripc.SUSCCLIE%TYPE;
        sbDescripcion                   CC_CAUSAL_TYPE.DESCRIPTION%TYPE;
        --variables para invocaci??n de la consulta de factura
        odtUltPago                      DATE;
        onuValorUltPago                 NUMBER (13, 2);
        odtPeriFact                     DATE;
        CUCLIENTES                      SYS_REFCURSOR;
        CUCONTRATOS                     SYS_REFCURSOR;
        CUFACTURAS                      SYS_REFCURSOR;
        CUCUENTAS                       SYS_REFCURSOR;
        onuErrorCodeContlfact           NUMBER;
        osbErrorMessageContlfact        VARCHAR2 (2000);
        nuCantidadDuplicado             NUMBER;
		nuRelacionPredio				NUMBER :=3;
		nuTipoCausal					ge_causal.causal_type_id%type := 26;
		nuCausal						ge_causal.causal_id%type := 73;
		sbxml							constants_per.tipo_xml_sol%TYPE;
		
		csbMetodo  CONSTANT VARCHAR2(100) := csbNOMPKG||'proSolicitudDuplicado';
		

        --Caso 200-2439 Danval 12-04-19 se agregan nuevas variables al proceso
        nuCantidadDuplicado_1           NUMBER := 0;
        numSegMin                       NUMBER
            := dald_parameter.fnuGetNumeric_Value ( 'PAR_NUM_SEG_MIN_SOL100212');

        /*
        * Validacion de la existencia de una solicitud
        * de duplicado para el contrato
        */

        CURSOR cuValidaSolicitudDuplicado IS
            SELECT COUNT (1)
              FROM mo_packages m
             WHERE     m.package_type_id = 100212
                   AND m.subscriber_id = (SELECT suscclie
                                            FROM suscripc s
                                           WHERE s.susccodi = inuSuscCodi)
                   AND m.motive_status_id = 13;

        --Caso 200-2439 DANVAL 12-04-19 se valida que la orden no este en estado ademas del 13 se adiciona 14
        --y se controla que el REQUEST_DATE (Fecha de registro) se encuentre en el tiempo minimo para generarse
        CURSOR cuValidaSolicitudDuplicado1 IS
            SELECT COUNT (1)
              FROM mo_packages m
             WHERE     m.package_type_id = 100212
                   AND m.subscriber_id = (SELECT suscclie
                                            FROM suscripc s
                                           WHERE s.susccodi = inuSuscCodi)
                   AND m.request_date >
                       SYSDATE - ((1 / (24 * 60 * 60)) * numSegMin) --se compara la fecha de registro para que sea menor a la fecha actual
                   AND m.motive_status_id IN (14); --Caso 200-2439 adiciono estado 14

        ---

        -- NCarrasquilla. CA 200642. Se crea cursor para que busque por contrato y no por cliente
        CURSOR cuValidaSolicitudDuplicadoMod IS
            SELECT COUNT (1)
              FROM mo_packages m, mo_motive mo
             WHERE     mo.package_id = m.package_id
                   AND mo.subscription_id = inuSuscCodi
                   AND m.package_type_id = 100212
                   AND m.motive_status_id = 13;

        --Caso 200-2439 DANVAL 12-04-19 se valida que la orden no este en estado ademas del 13 se adiciona 14
        --y se controla que el REQUEST_DATE (Fecha de registro) se encuentre en el tiempo minimo para generarse
        CURSOR cuValidaSolicitudDuplicadoMod1 IS
            SELECT COUNT (1)
              FROM mo_packages m, mo_motive mo
             WHERE     mo.package_id = m.package_id
                   AND mo.subscription_id = inuSuscCodi
                   AND m.package_type_id = 100212
                   AND m.request_date >
                       SYSDATE - ((1 / (24 * 60 * 60)) * numSegMin) --se compara la fecha de registro para que sea menor a la fecha actual
                   AND m.motive_status_id IN (14); --Caso 200-2439 adiciono estado 14

        ---

		CURSOR cuCliente IS
	    SELECT SUSCCLIE
          FROM Suscripc
         WHERE Susccodi = inuSuscCodi;

		
		CURSOR cuTipoCausal IS
        SELECT DESCRIPTION
          FROM CC_CAUSAL_TYPE
         WHERE CAUSAL_TYPE_ID = 26;

        -- variables para recibir la informacion del cursor de contrato

        TYPE tyCUCONTRATOSRecord IS RECORD
        (
            rown                   NUMBER (4, 0),
            nuCodContrato          NUMBER (13, 0),
            nuUbGeografica         VARCHAR (500),
            sbBarrio               VARCHAR (500),
            sbDirCobro             VARCHAR (500),
            sbTipoDirCobro         VARCHAR (500),
            nuDeudaContrato        NUMBER (13, 2),
            sbEntidad              VARCHAR (500),
            sbCuentaBanc           VARCHAR (500),
            nuFacturasAdeudadas    NUMBER (4, 0)
        );

        rcContratosRecord               tyCUCONTRATOSRecord;

        -- variables para recibir la informacion del cursor de factura

        TYPE tyCUFACTURASRecord IS RECORD
        (
            Fecha_Gen           VARCHAR2 (10),
            Fecha_Limite        VARCHAR2 (10),
            Id_Factura          NUMBER,
            Tipo_Comprobante    VARCHAR2 (1000),
            Tipo_Documento      NUMBER,
            Punto_Emision       VARCHAR2 (1000),
            No_Fiscal           NUMBER,
            Prefijo             VARCHAR2 (100),
            Empresa             NUMBER,
            Deuda_Factura       NUMBER,
            Anio_Fact           NUMBER,
            Mes_Fact            NUMBER,
            Periodo_Fact        NUMBER,
            Cod_Autorizacion    NUMBER,
            Venc_Numeracion     NUMBER
        );

        rcFacturassRecord               tyCUFACTURASRecord;

        /*
        * Se declara la excepcion para manejar
        * el caso de que ya exista una solicitud
        * de duplicado en estado registrada
        * para el contrato proporcionado
        *
        */

        SOLICITUD_DUPLICADO_EXISTE      EXCEPTION;

        --Caso 200-2439 danval 12-04-19 NUEVA EXCEPCION
        SOLICITUD_ATENDIDA_TIEMPO_MIN   EXCEPTION;
    ---

    BEGIN
	
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        /*
        * Validamos si este contrato ya tiene un
        * duplicado creado
        *
        */

        pkg_traza.trace ('Tiempo: ' || SYSDATE);

		OPEN cuValidaSolicitudDuplicadoMod;
		FETCH cuValidaSolicitudDuplicadoMod INTO nuCantidadDuplicado;
		CLOSE cuValidaSolicitudDuplicadoMod;

		--Caso 200-2439 danval 12-04-019 Se agrega la nueva condicion sobre el cursor con tiempo
		IF nuCantidadDuplicado = 0 THEN
			OPEN cuValidaSolicitudDuplicadoMod1;
			FETCH cuValidaSolicitudDuplicadoMod1
			   INTO nuCantidadDuplicado_1;
			CLOSE cuValidaSolicitudDuplicadoMod1;
		END IF;

        IF nuCantidadDuplicado > 0 THEN
            RAISE SOLICITUD_DUPLICADO_EXISTE;
        END IF;

        --Caso 200-2439 danval 12-04-19 se agrega respuesta por orden en tiempo minimo
        IF nuCantidadDuplicado_1 > 0 THEN
            RAISE SOLICITUD_ATENDIDA_TIEMPO_MIN;
        END IF;

        odtLimitePago := NULL;

        /*
        * Se invoca la consulta de factura por contrato
        * Para validar la cantidad de facturas que
        * el suscriptor tiene pendientes
        */

        LDCI_PKBSSFACCTTO.proCnltaFactPorCtto (inuSuscCodi,
                                               odtUltPago,
                                               onuValorUltPago,
                                               odtPeriFact,
                                               CUCLIENTES,
                                               CUCONTRATOS,
                                               CUFACTURAS,
                                               CUCUENTAS,
                                               onuErrorCodeContlfact,
                                               osbErrorMessageContlfact);

        IF onuErrorCodeContlfact = 0 AND CUCONTRATOS%ROWCOUNT <> 0 THEN
            pkg_traza.trace ('Error Code  :' || onuErrorCodeContlfact);
            FETCH CUCONTRATOS INTO rcContratosRecord;
            CLOSE CUCONTRATOS;
        END IF;

        /*
        * Se consulta el codigo de cliente
        * que corresponde al contrato
        */

		IF cuCliente%ISOPEN THEN
			CLOSE cuCliente;
		END IF;

		OPEN cuCliente;
		FETCH cuCliente INTO nususclient;
		CLOSE cuCliente;
		

        /*
        * Se valida si el par?!metro tipo de recepci??n es nulo
        */

        IF (inuRecepTipo IS NULL) THEN
            ONUERRORCODE := -1;
            OSBERRORMESSAGE := 'El par?!metro tipo de recepci??n est?! nulo';
        ELSE

			IF cuTipoCausal%ISOPEN THEN
				CLOSE cuTipoCausal;
			END IF;

			OPEN cuTipoCausal;
			FETCH cuTipoCausal INTO sbDescripcion;
			CLOSE cuTipoCausal;

			sbxml := pkg_xml_soli_aten_cliente.getSolicitudDuplicado(inuRecepTipo,
																	sbDescripcion,
																	nususclient,
																	nuRelacionPredio,
																	nuTipoCausal,
																	nuCausal,
																	inuSuscCodi
																	);

			api_registerRequestByXml (sbxml,
										onuPackageId,
										onuMotiveId,
										ONUERRORCODE,
										OSBERRORMESSAGE);

				IF ONUERRORCODE = 0 THEN
				/*
				* Por definicion del proceso actual para GDO
				* se valida la cantidad de facturas adeudada
				*/

				/*

				* Validaci??n de la fecha limite de pago
				* si la cantidad de facturas
				*/

					IF rcContratosRecord.nuFacturasAdeudadas = 0 THEN
						odtLimitePago := odtPeriFact;
					/*
					* Se mira si la catidad de factura es 1
					* si es asi se extrae la fecha limite de pago de esa factura
					*/

					ELSIF rcContratosRecord.nuFacturasAdeudadas = 1 THEN
						/*
						* Se extrae el primer registro del cursor
						* y se coloca la informacion de esa factura
						* en la variable tipo registro
						*/

						FETCH CUFACTURAS INTO rcFacturassRecord;
						odtLimitePago := TO_DATE (rcFacturassRecord.Fecha_Limite);
						CLOSE CUFACTURAS;
					ELSE
						odtLimitePago := NULL;
					END IF;
				END IF;
        END IF;

		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

        COMMIT;
    EXCEPTION
        --Caso 200-2439 danval 12-04-19 se adicional la excepcion SOLICITUD_REGISTRADA_TIEMPO_MIN
        WHEN SOLICITUD_ATENDIDA_TIEMPO_MIN THEN
            osbErrorMessage :=
                   'El contrato ya tiene una solicitud de duplicado en estado atendida en los ultimos '
                || dald_parameter.fnuGetNumeric_Value (
                       'PAR_NUM_SEG_MIN_SOL100212')
                || ' segundos';
            onuErrorCode := 999;
		pkg_traza.trace(csbMetodo||' :'|| osbErrorMessage);
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);

        WHEN SOLICITUD_DUPLICADO_EXISTE THEN
            osbErrorMessage :=
                'El contrato ya tiene una solicitud de duplicado en estado registrada';
            onuErrorCode := 666;
		pkg_traza.trace(csbMetodo||' :'|| osbErrorMessage);
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);

        WHEN pkg_error.controlled_error THEN
            ROLLBACK;
            pkg_error.geterror (onuErrorCode, osbErrorMessage);
            osbErrorMessage := onuErrorCode||': '||osbErrorMessage ;
			pkg_traza.trace(csbMetodo||' :'|| osbErrorMessage);
			pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);

        WHEN OTHERS THEN
            ROLLBACK;
            osbErrorMessage := 'Error en proceso de consulta de saldo brilla: ' ||OSBERRORMESSAGE;
            pkg_error.setErrorMessage ( onuErrorCode,osbErrorMessage);
            pkg_error.geterror (onuErrorCode, osbErrorMessage);
			pkg_traza.trace(csbMetodo||' :'|| osbErrorMessage);
			pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
			
    END proSolicitudDuplicado;

    /************************************************************************

       PROCEDIMIENTO : proSolicitudGeneral

       AUTOR         : Hector Fabio Dominguez

       FECHA         : 26/02/2013

       RICEF         : I041

       DESCRIPCION   : Permite generar una solicitud de atencion

             General



      Historia de Modificaciones

      Autor   Fecha      Descripcion

    ************************************************************************/

    PROCEDURE proSolicitudGeneral (
        inuSuscCodi       IN     SUSCRIPC.SUSCCODI%TYPE,
        inuTipoRecep      IN     NUMBER,
        inuClaseInfo      IN     NUMBER,
        inuTipoInfo       IN     NUMBER,
        isbObserva        IN     VARCHAR2,
        inuRolId          IN     NUMBER,
        inuCustomer       IN     NUMBER,
        inuContactId      IN     NUMBER,
        inuIdAddress      IN     NUMBER,
        isbTerminal       IN     VARCHAR2,
        nuMotiveId        IN OUT NUMBER,
        nuPackageId       IN OUT NUMBER,
        ONUERRORCODE      IN OUT NUMBER,
        OSBERRORMESSAGE   IN OUT VARCHAR2)
    AS
        nuIdAddress    suscripc.SUSCIDDI%TYPE;
        sbRequestXML   constants_per.tipo_xml_sol%TYPE;
        sbObserva      MO_PACKAGES.COMMENT_%TYPE;
        nuContactId    suscripc.SUSCIDDI%TYPE;
        nuCustomer     suscripc.SUSCIDDI%TYPE;
		
		CURSOR cuCliente IS
            SELECT SUSCCLIE
              FROM SUSCRIPC
             WHERE SUSCCODI = inuSuscCodi;

		CURSOR cuObservacion IS
            SELECT DESCRIPTION
              FROM GE_COMMENT_TYPE
             WHERE COMMENT_TYPE_ID = inuTipoInfo
               AND COMMENT_CLASS_ID = inuClaseInfo;

		
	csbMetodo  CONSTANT VARCHAR2(100) := csbNOMPKG||'proSolicitudGeneral';	
		
    BEGIN
	
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
		
        IF isbObserva IS NULL THEN
		
			IF cuObservacion%ISOPEN THEN
				CLOSE cuObservacion;
            END IF;

			OPEN cuObservacion;
			FETCH cuObservacion INTO sbObserva;
			CLOSE cuObservacion;
		
        ELSE
            sbObserva := isbObserva;
        END IF;

        sbObserva := CONVERT (sbObserva, 'UTF8');

        /*
        * Consultar el suscriptor de este contrato
        * y enviarlo en CONTACT_ID
        */

        IF inuContactId IS NULL THEN

			IF cuCliente%ISOPEN THEN
				CLOSE cuCliente;
            END IF;

			OPEN cuCliente;
			FETCH cuCliente INTO nuContactId;
			CLOSE cuCliente;

        ELSE
            nuContactId := inuContactId;
        END IF;

        sbRequestXML := pkg_xml_soli_aten_cliente.getSolicitudInfoGeneral(inuTipoRecep,
																	   nuContactId,
																	   inuIdAddress,
																	   sbObserva,
																	   inuRolId,
																	   inuClaseInfo,
																	   inuTipoInfo,
																	   inuCustomer,
																	   inuSuscCodi);

        api_registerRequestByXml (sbRequestXML,
                                   nuPackageId,
                                   nuMotiveId,
                                   ONUERRORCODE,
                                   OSBERRORMESSAGE);

        IF ONUERRORCODE = 0 AND isbTerminal IS NOT NULL THEN
            UPDATE Mo_Packages
               SET Terminal_Id = isbTerminal
             WHERE Package_Id = nuPackageId;

            COMMIT;
        END IF;

		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

        COMMIT;
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            ROLLBACK;
            pkg_error.geterror (onuErrorCode, osbErrorMessage);
			pkg_traza.trace(csbMetodo||' :'|| osbErrorMessage);
			pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);

        WHEN OTHERS THEN
            osbErrorMessage := 'Error creando la solicitud: '||OSBERRORMESSAGE;
			pkg_error.setErrorMessage(onuErrorCode,osbErrorMessage);
            pkg_error.geterror (nuError, sbError);
			pkg_traza.trace(csbMetodo||' :'|| osbErrorMessage||' '||sbError);
			pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);

    END proSolicitudGeneral;

    PROCEDURE prcCierraCursor (CUCURSOR IN OUT SYS_REFCURSOR)
    AS
    BEGIN
        IF NOT CUCURSOR%ISOPEN THEN
            OPEN CUCURSOR FOR SELECT *
                                FROM DUAL
                               WHERE 1 = 2;
        END IF;
    END;

    /************************************************************************

       PROCEDIMIENTO : LDCI_PKCRMSOLICITUD.proCnltaSolicitudesxInterac

       AUTOR         : Jose Donado

       FECHA         : 23/10/2018

       RICEF         : I149

       DESCRIPCION   : Permite Consultar los datos de solicitudes asociadas a una interacci?n



      Historia de Modificaciones

      Autor   Fecha      Descripcion
      JOSDON  04/12/2018 Se modifica para agregar los campos de actividad, tipoTrabajo, unidadTrabajo,
                         tipoUnidadTrabajo, tipoComentario, claseComentario.
                         Se modifica para quitar concatenaci?n de descripciones, s?lo se enviar? c?digos
                         tambien se quita campo de areaGestiona
    ************************************************************************/

    PROCEDURE proCnltaSolicitudesxInterac (
        inuInteraccion    IN     MO_PACKAGES.PACKAGE_ID%TYPE,
        ocuSolicitudes       OUT SYS_REFCURSOR,
        onuErrorCode         OUT GE_MESSAGE.MESSAGE_ID%TYPE,
        osbErrorMessage      OUT GE_MESSAGE.DESCRIPTION%TYPE)
    AS
        nuCont   NUMBER := 0;
		csbMetodo  CONSTANT VARCHAR2(100) := csbNOMPKG||'proCnltaSolicitudesxInterac';
    BEGIN
	
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
		
        SELECT COUNT (*)
          INTO nuCont
          FROM MO_PACKAGES
         WHERE PACKAGE_ID = inuInteraccion;

        -- Consulta las solicitudes asociadas a la interacci?n
        OPEN ocuSolicitudes FOR
            SELECT P.PACKAGE_ID
                       idSolicitud,
                   P.PACKAGE_TYPE_ID
                       tipoSolicitud,
                   P.MOTIVE_STATUS_ID
                       estado,
                   TO_CHAR (P.REQUEST_DATE,
                            'DD/MM/YYYY HH24:MI:SS')
                       fechaRegistro,
                   TO_CHAR (P.ATTENTION_DATE, 'DD/MM/YYYY HH24:MI:SS')
                       fechaAtencion,
                   P.RECEPTION_TYPE_ID
                       medioRecepcion,
                   P.ORGANIZAT_AREA_ID
                       areaCausante,
                   M.CAUSAL_ID
                       causal,
                      DECODE (P.SUBSCRIBER_ID, NULL, '')
                   || '-'
                   || DECODE (
                          P.SUBSCRIBER_ID,
                          NULL, '', 
                          pkg_bccliente.fsbNombres(P.SUBSCRIBER_ID))
                   || ' '
                   || DECODE (
                          P.SUBSCRIBER_ID,
                          NULL, '',
                          pkg_bccliente.fsbApellidos(P.SUBSCRIBER_ID))
                       cliente,
                   M.SUBSCRIPTION_ID
                       contrato,
                   M.PRODUCT_ID
                       producto,
                   P.COMMENT_
                       comentario,
                   (SELECT OA3.ACTIVITY_ID
                      FROM OR_ORDER_ACTIVITY OA3
                     WHERE     OA3.PACKAGE_ID = P.PACKAGE_ID
                           AND OA3.ORDER_ACTIVITY_ID IN
                                   (SELECT MIN (OA.ORDER_ACTIVITY_ID)    ORDER_ACT
                                      FROM OR_ORDER_ACTIVITY OA
                                     WHERE OA.PACKAGE_ID = P.PACKAGE_ID))
                       actividad,
                   (SELECT OA4.TASK_TYPE_ID
                      FROM OR_ORDER_ACTIVITY OA4
                     WHERE     OA4.PACKAGE_ID = P.PACKAGE_ID
                           AND OA4.ORDER_ACTIVITY_ID IN
                                   (SELECT MIN (OA.ORDER_ACTIVITY_ID)    ORDER_ACT
                                      FROM OR_ORDER_ACTIVITY OA
                                     WHERE OA.PACKAGE_ID = P.PACKAGE_ID))
                       tipoTrabajo,
                   (SELECT OA5.OPERATING_UNIT_ID
                      FROM OR_ORDER_ACTIVITY OA5
                     WHERE     OA5.PACKAGE_ID = P.PACKAGE_ID
                           AND OA5.ORDER_ACTIVITY_ID IN
                                   (SELECT MIN (OA.ORDER_ACTIVITY_ID)    ORDER_ACT
                                      FROM OR_ORDER_ACTIVITY OA
                                     WHERE OA.PACKAGE_ID = P.PACKAGE_ID))
                       unidadTrabajo,
                   (SELECT OU.UNIT_TYPE_ID
                      FROM OR_OPERATING_UNIT OU
                     WHERE OU.OPERATING_UNIT_ID =
                           (SELECT OA5.OPERATING_UNIT_ID
                              FROM OR_ORDER_ACTIVITY OA5
                             WHERE     OA5.PACKAGE_ID = P.PACKAGE_ID
                                   AND OA5.ORDER_ACTIVITY_ID IN
                                           (SELECT MIN (OA.ORDER_ACTIVITY_ID)    ORDER_ACT
                                              FROM OR_ORDER_ACTIVITY OA
                                             WHERE OA.PACKAGE_ID =
                                                   P.PACKAGE_ID)))
                       tipoUnidadTrabajo,
                   (SELECT CM2.COMMENT_TYPE_ID
                      FROM MO_COMMENT CM2
                     WHERE     CM2.PACKAGE_ID = P.PACKAGE_ID
                           AND CM2.COMMENT_ID =
                               (SELECT MIN (CM.COMMENT_ID)
                                  FROM MO_COMMENT CM
                                 WHERE CM.PACKAGE_ID = P.PACKAGE_ID))
                       tipoComentario,
                   (SELECT CMT.COMMENT_CLASS_ID
                      FROM GE_COMMENT_TYPE CMT
                     WHERE CMT.COMMENT_TYPE_ID =
                           (SELECT CM3.COMMENT_TYPE_ID
                              FROM MO_COMMENT CM3
                             WHERE     CM3.PACKAGE_ID = P.PACKAGE_ID
                                   AND CM3.COMMENT_ID =
                                       (SELECT MIN (CM.COMMENT_ID)
                                          FROM MO_COMMENT CM
                                         WHERE CM.PACKAGE_ID = P.PACKAGE_ID)))
                       claseComentario
              FROM MO_PACKAGES_ASSO  PA
                   INNER JOIN MO_PACKAGES P
                       ON (P.PACKAGE_ID = PA.PACKAGE_ID)
                   INNER JOIN PS_PACKAGE_TYPE PT
                       ON (PT.PACKAGE_TYPE_ID = P.PACKAGE_TYPE_ID)
                   INNER JOIN PS_MOTIVE_STATUS MS
                       ON (MS.MOTIVE_STATUS_ID = P.MOTIVE_STATUS_ID)
                   INNER JOIN GE_RECEPTION_TYPE RT
                       ON (RT.RECEPTION_TYPE_ID = P.RECEPTION_TYPE_ID)
                   LEFT JOIN GE_ORGANIZAT_AREA OA1
                       ON (OA1.ORGANIZAT_AREA_ID = P.ORGANIZAT_AREA_ID)
                   LEFT JOIN GE_ORGANIZAT_AREA OA2
                       ON (OA2.ORGANIZAT_AREA_ID = P.MANAGEMENT_AREA_ID)
                   LEFT JOIN MO_MOTIVE M
                       ON (M.PACKAGE_ID = P.PACKAGE_ID)
                   LEFT JOIN CC_CAUSAL C ON (C.CAUSAL_ID = M.CAUSAL_ID)
             WHERE PA.PACKAGE_ID_ASSO = inuInteraccion;

        prcCierraCursor (ocuSolicitudes);

        IF nuCont = 0
        THEN
            onuErrorCode := -1;
            osbErrorMessage :=
                   'La interaccion '
                || inuInteraccion
                || ' no esta registrada en el sistema OSF, por favor validar.';
        ELSE
            onuErrorCode := 0;
            osbErrorMessage := 'Proceso Ejecutado correctamente';
        END IF;
		
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
		
		
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            ROLLBACK;
            pkg_error.geterror (onuErrorCode, osbErrorMessage);
			pkg_traza.trace(csbMetodo||' :'||osbErrorMessage);
			pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
        WHEN OTHERS
        THEN
            osbErrorMessage := 'Error en proceso de consulta de solicitudes asociadas a una interaccion: '||osbErrorMessage;
            pkg_error.geterror (onuErrorCode, osbErrorMessage);
			pkg_error.setErrorMessage(onuErrorCode, osbErrorMessage);
			pkg_traza.trace(csbMetodo||' :'||osbErrorMessage);
			pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
		
    END proCnltaSolicitudesxInterac;
END LDCI_PKCRMSOLICITUD;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDCI_PKCRMSOLICITUD', 'ADM_PERSON'); 
END;
/

GRANT EXECUTE on ADM_PERSON.LDCI_PKCRMSOLICITUD to INTEGRACIONES;
GRANT EXECUTE on ADM_PERSON.LDCI_PKCRMSOLICITUD to INTEGRADESA;
GRANT EXECUTE on ADM_PERSON.LDCI_PKCRMSOLICITUD to REXEINNOVA;
GRANT EXECUTE on ADM_PERSON.LDCI_PKCRMSOLICITUD to EXEBRILLAAPP;
GRANT EXECUTE on ADM_PERSON.LDCI_PKCRMSOLICITUD to BRILLAAPP;

/
