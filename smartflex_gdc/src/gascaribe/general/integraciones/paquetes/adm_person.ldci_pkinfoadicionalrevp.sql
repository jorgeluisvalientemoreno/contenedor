CREATE OR REPLACE PACKAGE ADM_PERSON.LDCI_PKINFOADICIONALREVP
AS
    /*************************************************************************************************************
     * Propiedad Intelectual Gases del Caribe SA ESP
     *
     * Script  :
     * CASO   : 200 - 1011
     * Autor   : Karem Baquero Martinez <kbaquero@jmgestioninformatica>
     * Fecha   : 03-01-2017
     * Descripcion : Paquete gestion de informacion adicional de ordenes moviles de revisi?n periodica

     *
     * Historia de Modificaciones
     * Autor           Fecha       Descripcion
       Eduardo Aguera  16/02/2017  Se modifican procedimientos proSolicitudReparacionREV y proSolicitudcertifiREV
                                   ya que los campos sbparserid y nuAddressIdSV2 estaban trocados en el llamado al
                                   proc que genera la solicitud. Se modifica tambien para que no envie codigo de
                                   error si se genera la solicitud pero no se genera la orden.
       Eduardo Aguera  01/03/2017  Se modifican procedimientos proSolicitudReparacionREV y proSolicitudcertifiREV.
                                   Se modifica la respuesta para que devuelva el campo Order_Activity_Id. Estaba
                                   devolviendo el Activity_Id.
       AAcuna          23/10/2017  Se agrega nuevo procedimiento proProcesaXMLAprCertOIA encargado de aprobar o rechazar los
                                   certificados OIA que son enviados desde el sistema externo.
	   Dsaltarin       28/01/2022  806: Se agrega tag de fecha de aprobación
       jsoto 		   17/11/2023	Ajustes ((OSF-1859)):
									-Ajustes cambio en llamado a algunos de los objetos de producto por personalizados
									-Ajuste  cambio en manejo de trazas y errores por personalizados (pkg_error y pkg_traza).
									-Ajuste llamado a pkg_xml_sol_rev_periodica para armar los xml de las solicitudes
									-Ajuste llamado a api_registerRequestByXml
									-Ajuste llamado a api_createorder para crear ordenes y actividades

    ***************************************************************************************************************/

    PROCEDURE proSolicitudReparacionREV (
        inuTipoRecep        IN     NUMBER,
        sbComment           IN     VARCHAR2,
        inuContactId        IN     NUMBER,
        inuSuscCodi         IN     SUSCRIPC.SUSCCODI%TYPE,
        nuProductId         IN     NUMBER,
        inuIdAddress        IN     NUMBER,
        sbparseraddressid   IN     VARCHAR2,
        nugeolocation       IN     NUMBER,
        nucate              IN     NUMBER,
        nusucate            IN     NUMBER,
        inuoper             IN     NUMBER,
        nuMotiveId          IN OUT NUMBER,
        nuPackageId            OUT NUMBER,
        NUORDER_ID             OUT NUMBER,
        NUORDERAct_ID          OUT NUMBER,
        ONUERRORCODE        IN OUT NUMBER,
        OSBERRORMESSAGE     IN OUT VARCHAR2);

    PROCEDURE proSolicitudcertifiREV (
        inuTipoRecep        IN     NUMBER,
        sbComment           IN     VARCHAR2,
        inuContactId        IN     NUMBER,
        inuSuscCodi         IN     SUSCRIPC.SUSCCODI%TYPE,
        nuProductId         IN     NUMBER,
        inuIdAddress        IN     NUMBER,
        sbparseraddressid   IN     VARCHAR2,
        nugeolocation       IN     NUMBER,
        nucate              IN     NUMBER,
        nusucate            IN     NUMBER,
        inuoper             IN     NUMBER,
        nuMotiveId          IN OUT NUMBER,
        nuPackageId            OUT NUMBER,
        NUORDER_ID             OUT NUMBER,
        NUORDERAct_ID          OUT NUMBER,
        ONUERRORCODE        IN OUT NUMBER,
        OSBERRORMESSAGE     IN OUT VARCHAR2);

    PROCEDURE proProcesaXMLSolReparacion (
        MENSAJE_ID      IN     NUMBER,
        isbSistema      IN     VARCHAR2,                                    --
        inuOrden        IN     NUMBER,                                      --
        isbXML          IN     CLOB,                                        --
        isbEstado       IN     VARCHAR2,
        isbOperacion    IN     VARCHAR2,
        inuProcesoExt   IN     NUMBER,
        idtFechaRece    IN     DATE,
        idtFechaProc    IN     DATE,
        idtFechaNoti    IN     DATE,
        inuCodErrOsf    IN     NUMBER,
        isbMsgErrOsf    IN     VARCHAR2,
        ocurRespuesta      OUT SYS_REFCURSOR,
        onuErrorCodi       OUT NUMBER,
        osbErrorMsg        OUT VARCHAR2);

    PROCEDURE proProcesaXMLSolCertificacion (
        MENSAJE_ID      IN     NUMBER,
        isbSistema      IN     VARCHAR2,                                    --
        inuOrden        IN     NUMBER,                                      --
        isbXML          IN     CLOB,                                        --
        isbEstado       IN     VARCHAR2,
        isbOperacion    IN     VARCHAR2,
        inuProcesoExt   IN     NUMBER,
        idtFechaRece    IN     DATE,
        idtFechaProc    IN     DATE,
        idtFechaNoti    IN     DATE,
        inuCodErrOsf    IN     NUMBER,
        isbMsgErrOsf    IN     VARCHAR2,
        ocurRespuesta      OUT SYS_REFCURSOR,
        onuErrorCodi       OUT NUMBER,
        osbErrorMsg        OUT VARCHAR2);

    ---------------------------------------------------------------------------------------

    /*
    * Propiedad Intelectual Gases del Caribe S. A. E.S.P.
    *
    * Proceso     : proProcesaXMLAprCertOIA
    * Tiquete     :
    * Fecha       : 23-10-2017
    * Descripcion : Se encarga de aprobar o rechazar los certificados OIA que son enviadas desde el sistema externo.

    * Historia de Modificaciones
    * Autor       Fecha           Descripcion
    * AAcuna      23-10-2017      Creacion
    *
    *
    **/

    PROCEDURE proProcesaXMLAprCertOIA (MENSAJE_ID      IN     NUMBER,
                                       isbSistema      IN     VARCHAR2,
                                       inuOrden        IN     NUMBER,
                                       isbXML          IN     CLOB,
                                       isbEstado       IN     VARCHAR2,
                                       isbOperacion    IN     VARCHAR2,
                                       inuProcesoExt   IN     NUMBER,
                                       idtFechaRece    IN     DATE,
                                       idtFechaProc    IN     DATE,
                                       idtFechaNoti    IN     DATE,
                                       inuCodErrOsf    IN     NUMBER,
                                       isbMsgErrOsf    IN     VARCHAR2,
                                       ocurRespuesta      OUT SYS_REFCURSOR,
                                       onuErrorCodi       OUT NUMBER,
                                       osbErrorMsg        OUT VARCHAR2);
END LDCI_PKINFOADICIONALREVP;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.LDCI_PKINFOADICIONALREVP
AS
    /*************************************************************************************************************
       PROCEDIMIENTO : proSolicitudReparacionREV
       AUTOR         : Karem Baquero Martinez
       FECHA         : 03/01/2017
       CASO         :  200-1011
       DESCRIPCION   : Permite generar una solicitud de REPARACION DE REVISION PERIODICA DESDE
                       EL MOVIL
             General
      Historia de Modificaciones
      Autor           Fecha        Descripcion
      KBaquero        05/01/2017   Creaci?n
      Eduardo Aguera  16/02/2017   Se modifica ya que los campos sbparserid y nuAddressIdSV2 estaban trocados
                                   en el llamado al proc que genera la solicitud. Se modifica tambien para que
                                   no envie codigo de error si se genera la solicitud pero no se genera la orden.
      Eduardo Aguera  01/03/2017   Se modifica la respuesta para que devuelva el campo Order_Activity_Id. Estaba
                                   devolviendo el Activity_Id.
      AAcuna          23/10/2017   Se agrega nuevo procedimiento proProcesaXMLAprCertOIA encargado de aprobar o rechazar los
                                   certificados OIA que son enviados desde el sistema externo.
                                   
     jsoto 		        17/11/2023	Ajustes ((OSF-1859)):
                                    -Ajustes cambio en llamado a algunos de los objetos de producto por personalizados
                                    -Ajuste  cambio en manejo de trazas y errores por personalizados (pkg_error y pkg_traza).
                                    -Ajuste llamado a pkg_xml_sol_rev_periodica para armar los xml de las solicitudes
                                    -Ajuste llamado a api_registerRequestByXml
                                    -Ajuste llamado a api_createorder para crear ordenes y actividades
     jsoto              24/01/2024  Ajuste (OSF-2006) Ajuste en las Excepciones y captura de mensaje de las excepciones
	
	**************************************************************************************************************/

	
	csbNOMPKG            CONSTANT VARCHAR2(32)       := $$PLSQL_UNIT||'.';
	nuError				 NUMBER;
	sbError				 VARCHAR2(2000);

    PROCEDURE proSolicitudReparacionREV (
        inuTipoRecep        IN     NUMBER,
        sbComment           IN     VARCHAR2,
        inuContactId        IN     NUMBER,
        inuSuscCodi         IN     SUSCRIPC.SUSCCODI%TYPE,
        nuProductId         IN     NUMBER,
        inuIdAddress        IN     NUMBER,
        sbparseraddressid   IN     VARCHAR2,
        nugeolocation       IN     NUMBER,
        nucate              IN     NUMBER,
        nusucate            IN     NUMBER,
        inuoper             IN     NUMBER,
        nuMotiveId          IN OUT NUMBER,
        nuPackageId            OUT NUMBER,
        NUORDER_ID             OUT NUMBER,
        NUORDERAct_ID          OUT NUMBER,
        ONUERRORCODE        IN OUT NUMBER,
        OSBERRORMESSAGE     IN OUT VARCHAR2)
    AS
        sbRequestXML          constants_per.tipo_xml_sol%TYPE;
        sbObserva             MO_PACKAGES.COMMENT_%TYPE;
        nuOrder_Activity_Id   or_order_activity.order_activity_id%TYPE;
        nuErrorAsig           NUMBER;
        sbMensajeAsig         VARCHAR2 (4000);

        --INICIO CURSOR ORDEN
        CURSOR CUOR_ORDER_ACTIVITY (
            INUPACKAGE_ID   MO_PACKAGES.PACKAGE_ID%TYPE)
        IS
            SELECT OOA.ORDER_ID, ooa.order_activity_id, ooa.activity_id
              FROM OR_ORDER_ACTIVITY OOA
             WHERE OOA.PACKAGE_ID = INUPACKAGE_ID 
               AND ROWNUM = 1;



        INUORDER_ID           OR_ORDER.ORDER_ID%TYPE;
        nuoract_Id            NUMBER;
		csbMetodo  			  CONSTANT VARCHAR2(100) := csbNOMPKG||'proSolicitudReparacionREV';

    BEGIN
	
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
		
        --Validamos que el producto no sea null
        IF nuProductId IS NULL
        THEN
            ONUERRORCODE := -1;
            OSBERRORMESSAGE :=
                'El identificador del producto no puede ser nulo.';
            RAISE pkg_error.controlled_error;
        END IF;

        /*Se convierte a Observaci?n */
        sbObserva := CONVERT (sbComment, 'UTF8');

		sbRequestXML := pkg_xml_soli_rev_periodica.getSolicitudReparacionRp(inuTipoRecep,
																			 sbObserva,
																			 nuProductId,
																			 inuContactId);


		/*Ejecuta el XML creado*/
		api_registerRequestByXml(sbRequestXML,
								  nuPackageId,
								  nuMotiveId,
								  ONUERRORCODE,
								  OSBERRORMESSAGE);

        IF ONUERRORCODE <> 0
        THEN
            pkg_traza.trace ('ROLLBACK proSolicitudReparacionREV');
            ONUERRORCODE := ONUERRORCODE;
            OSBERRORMESSAGE := OSBERRORMESSAGE;
            ROLLBACK;
            RAISE pkg_error.controlled_error;
        ELSE
            COMMIT;
            OSBERRORMESSAGE :=
                   OSBERRORMESSAGE
                || 'Solicitud '
                || NUPACKAGEID
                || ' generada de manera exitosa. ';
            pkg_traza.trace (
                'COMMIT DESpUEs DE GENERAR TRAMITE proSolicitudReparacionREV');
            DBMS_LOCK.Sleep (10);
            nuPackageId := NUPACKAGEID;
            nuMotiveId := NUMOTIVEID;

            --Buscamos el numero de orden generada y su id de actividad para devolver en la respuesta
            OPEN CUOR_ORDER_ACTIVITY (nuPackageId);

            FETCH CUOR_ORDER_ACTIVITY
                INTO INUORDER_ID, nuOrder_Activity_Id, nuoract_Id;

            CLOSE CUOR_ORDER_ACTIVITY;

            nuOrder_Id := NVL (INUORDER_ID, 0);
            nuOrderAct_Id := NVL (nuOrder_Activity_Id, 0);

            --Asignamos la orden de la actividad que se encuentra en el parametro
            IF NVL (inuoper, NULL) IS NOT NULL AND INUORDER_ID IS NOT NULL
            THEN
                api_assign_order (INUORDER_ID,
                                 inuoper,
                                 nuErrorAsig,
                                 sbMensajeAsig);

                --Si no se pudo asignar se notifica en el mensaje
                IF nuErrorAsig <> 0
                THEN
                    OSBERRORMESSAGE := OSBERRORMESSAGE || sbMensajeAsig;
                ELSE
                    pkg_traza.trace (
                        'SOLO COMMIT SI LOGR? ASIGNAR UNIDAD OPERATIVA proSolicitudReparacionREV');
                    COMMIT;
                END IF;
            ELSE
                OSBERRORMESSAGE :=
                    OSBERRORMESSAGE || 'Orden de trabajo no generada.';
            END IF;
        END IF;
		
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
		
    EXCEPTION
        WHEN pkg_error.controlled_error
        THEN
			pkg_error.getError(nuerror, sbError);
			pkg_traza.trace(csbMetodo||' '||osbErrorMessage||'nuerror: '||nuerror|| ' sbError: '||sbError);
			pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            ROLLBACK;
        WHEN OTHERS
        THEN
		    pkg_error.setError;
            osbErrorMessage :=
                   'Error creando la solicitud '|| DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
			pkg_error.getError(nuerror, sbError);
			pkg_traza.trace(csbMetodo||' '||osbErrorMessage|| ' nuerror: '||nuerror||' sbError: '||sbError);
			pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
    END proSolicitudReparacionREV;

    /************************************************************************************************************
       PROCEDIMIENTO : proSolicitudReparacionREV
       AUTOR         : Karem Baquero Martinez
       FECHA         : 03/01/2017
       CASO         :  200-1011
       DESCRIPCION   : Permite generar una solicitud de REPARACION DE REVISION PERIODICA DESDE
                       EL MOVIL
             General

      Historia de Modificaciones
      Autor           Fecha        Descripcion
      KBaquero        05/01/2017   Creaci?n
      Eduardo Aguera  16/02/2017   Se modifica ya que los campos sbparserid y nuAddressIdSV2 estaban trocados
                                   en el llamado al proc que genera la solicitud. Se modifica tambien para que
                                   no envie codigo de error si se genera la solicitud pero no se genera la orden.
      Eduardo Aguera  01/03/2017   Se modifica la respuesta para que devuelva el campo Order_Activity_Id. Estaba
                                   devolviendo el Activity_Id.
    *************************************************************************************************************/

    PROCEDURE proSolicitudcertifiREV (
        inuTipoRecep        IN     NUMBER,
        sbComment           IN     VARCHAR2,
        inuContactId        IN     NUMBER,
        inuSuscCodi         IN     SUSCRIPC.SUSCCODI%TYPE,
        nuProductId         IN     NUMBER,
        inuIdAddress        IN     NUMBER,
        sbparseraddressid   IN     VARCHAR2,
        nugeolocation       IN     NUMBER,
        nucate              IN     NUMBER,
        nusucate            IN     NUMBER,
        inuoper             IN     NUMBER,
        nuMotiveId          IN OUT NUMBER,
        nuPackageId            OUT NUMBER,
        NUORDER_ID             OUT NUMBER,
        NUORDERAct_ID          OUT NUMBER,
        ONUERRORCODE        IN OUT NUMBER,
        OSBERRORMESSAGE     IN OUT VARCHAR2)
    AS
        sbRequestXML          constants_per.tipo_xml_sol%TYPE;
        sbObserva             MO_PACKAGES.COMMENT_%TYPE;
        nuOrder_Activity_Id   or_order_activity.order_activity_id%TYPE;
        nuErrorAsig           NUMBER;
        sbMensajeAsig         VARCHAR2 (4000);

        --INICIO CURSOR ORDEN
        CURSOR CUOR_ORDER_ACTIVITY (
            INUPACKAGE_ID   MO_PACKAGES.PACKAGE_ID%TYPE)
        IS
            SELECT OOA.ORDER_ID, ooa.order_activity_id, ooa.activity_id
              FROM OR_ORDER_ACTIVITY OOA
             WHERE OOA.PACKAGE_ID = INUPACKAGE_ID 
               AND ROWNUM = 1;
												  
												  											  
        INUORDER_ID           OR_ORDER.ORDER_ID%TYPE;
        nuoract_Id            NUMBER;
		csbMetodo  			  CONSTANT VARCHAR2(100) := csbNOMPKG||'proSolicitudcertifiREV';
		
    BEGIN
	
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
		
        --Validamos que el producto no sea null
        IF nuProductId IS NULL
        THEN
            ONUERRORCODE := -1;
            OSBERRORMESSAGE :=
                'El identificador del producto no puede ser nulo.';
            RAISE pkg_error.controlled_error;
        END IF;

        /*Se convierte a Observaci?n */
        sbObserva := CONVERT (sbComment, 'UTF8');


		sbRequestXML := pkg_xml_soli_rev_periodica.getXMSolicitudCertificacionRp(inuTipoRecep,
																				  sbObserva,
																				  nuProductId,
																				  inuContactId);
		
		/*Ejecuta el XML creado*/
		api_registerRequestByXml(sbRequestXML,
								  nuPackageId,
								  nuMotiveId,
								  ONUERRORCODE,
								  OSBERRORMESSAGE);

        IF ONUERRORCODE <> 0
        THEN
            pkg_traza.trace ('ROLLBACK proSolicitudcertifiREV');
            ONUERRORCODE := ONUERRORCODE;
            OSBERRORMESSAGE := OSBERRORMESSAGE;
            ROLLBACK;
            RAISE pkg_error.controlled_error;
        ELSE
            COMMIT;
            OSBERRORMESSAGE :=
                   OSBERRORMESSAGE
                || 'Solicitud '
                || NUPACKAGEID
                || ' generada de manera exitosa. ';
            pkg_traza.trace (
                'COMMIT DESPUES DE GENERAR TRAMITE proSolicitudcertifiREV');
            DBMS_LOCK.Sleep (10);
            nuPackageId := NUPACKAGEID;
            nuMotiveId := NUMOTIVEID;

            --Buscamos el numero de orden generada y su id de actividad para devolver en la respuesta
            OPEN CUOR_ORDER_ACTIVITY (nuPackageId);

            FETCH CUOR_ORDER_ACTIVITY
                INTO INUORDER_ID, nuOrder_Activity_Id, nuoract_Id;

            CLOSE CUOR_ORDER_ACTIVITY;

            NUORDER_ID := NVL (INUORDER_ID, 0);
            NUORDERAct_ID := NVL (nuOrder_Activity_Id, 0);

            /*Se procede asignar la orden de la actividad que se encuentra en el parametro*/
            IF inuoper IS NOT NULL AND INUORDER_ID IS NOT NULL
            THEN
                api_assign_order (INUORDER_ID,
                                 inuoper,
                                 nuErrorAsig,
                                 sbMensajeAsig);

                IF nuErrorAsig <> 0
                THEN
                    OSBERRORMESSAGE := OSBERRORMESSAGE || sbMensajeAsig;
                ELSE
                    pkg_traza.trace (
                        'COMMIT DESPUES DE ASIGNAR UNIDAD OPERATIVA proSolicitudcertifiREV');
                    COMMIT;
                END IF;
            ELSE
                OSBERRORMESSAGE :=
                    OSBERRORMESSAGE || 'Orden de trabajo no generada.';
            END IF;
        END IF;
		
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
		
    EXCEPTION
        WHEN pkg_error.controlled_error
        THEN
		    pkg_error.getError(nuerror, sbError);
			pkg_traza.trace(csbMetodo||' '||osbErrorMessage|| ' nuerror: '||nuerror||' sbError: '||sbError);
			pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            ROLLBACK;
        WHEN OTHERS
        THEN
            osbErrorMessage :=
                   'Error creando la solicitud '|| DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
			pkg_error.setError;
            pkg_error.getError(nuerror, sbError);
			pkg_traza.trace(csbMetodo||' '||osbErrorMessage|| ' nuerror: '||nuerror||' sbError: '||sbError);
			pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
    END proSolicitudcertifiREV;

    /*
    * Propiedad Intelectual Gases del Caribe S. A. E.S.P.
    *
    * Proceso      : proProcesaXMLSolReparacion
    * Tiquete      :
    *  Fecha       : 03-01-2017
    * Caso         : 200-1011
    * Descripcion : Registra la solicitud de reparaci?n revision periiodica.
    *
    * Historia de Modificaciones
    * Autor                    Fecha       Descripcion
    * Kbaquero                 03-01-2017  Creaci?n
    **/

    PROCEDURE proProcesaXMLSolReparacion (
        MENSAJE_ID      IN     NUMBER,
        isbSistema      IN     VARCHAR2,                                    --
        inuOrden        IN     NUMBER,                                      --
        isbXML          IN     CLOB,                                        --
        isbEstado       IN     VARCHAR2,
        isbOperacion    IN     VARCHAR2,
        inuProcesoExt   IN     NUMBER,
        idtFechaRece    IN     DATE,
        idtFechaProc    IN     DATE,
        idtFechaNoti    IN     DATE,
        inuCodErrOsf    IN     NUMBER,
        isbMsgErrOsf    IN     VARCHAR2,
        ocurRespuesta      OUT SYS_REFCURSOR,
        onuErrorCodi       OUT NUMBER,
        osbErrorMsg        OUT VARCHAR2)
    AS
        --Estructura de respuesta
        tabRespuesta     LDCI_PkRepoDataType.tyTabRespuesta;
        tyRegRespuesta   LDCI_PkRepoDataType.tyWSRespTrabAdicRecord;

        /*cursor para leer el xml*/
        CURSOR cuxmlsercv (isbXMLserv IN VARCHAR2)
        IS
                            SELECT Datosprom.*
                              FROM XMLTABLE (
                                       '/solicitudReparacion'
                                       PASSING XMLType (isbXMLserv)
                                       COLUMNS RECEPTION_TYPE_ID      NUMBER (15) PATH 'idTipoRecepcion',
                                               COMMENT_               VARCHAR2 (200) PATH 'comentario',
                                               CONTACT_ID             NUMBER (15) PATH 'idCliente',
                                               contrato               NUMBER (15) PATH 'idContrato',
                                               PRODUCT                NUMBER (15) PATH 'idProducto',
                                               ADDRESS_ID             NUMBER (15) PATH 'idDireccion',
                                               PARSER_ADDRESS_ID      VARCHAR2 (200) PATH 'direccion',
                                               GEOGRAP_LOCATION_ID    NUMBER (6) PATH 'idLocalidad',
                                               CATEGORY_ID            NUMBER (15) PATH 'idCategoria',
                                               SUBCATEGORY_ID         NUMBER (15) PATH 'idSubcategoria',
                                               POS_OPER_UNIT_ID       NUMBER (15) PATH 'idUnidadOper')                                                                       As   Datosprom;

        rgInfoserv       cuxmlsercv%ROWTYPE;

        onuorden         NUMBER;
        onupackages      NUMBER;
        onumotive        NUMBER;
        onuordenact      NUMBER;
		csbMetodo  		 CONSTANT VARCHAR2(100) := csbNOMPKG||'proProcesaXMLSolReparacion';
		
    BEGIN
	
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
		
        --identifica valores del XML

        OPEN cuxmlsercv (isbXML);

        FETCH cuxmlsercv INTO rgInfoserv;

        CLOSE cuxmlsercv;

        --registra la solicitud
        proSolicitudReparacionREV (rgInfoserv.Reception_Type_Id,
                                   rgInfoserv.Comment_,
                                   rgInfoserv.Contact_Id,
                                   rgInfoserv.Contrato,
                                   rgInfoserv.Product,
                                   rgInfoserv.Address_Id,
                                   rgInfoserv.PARSER_ADDRESS_ID,
                                   rgInfoserv.GEOGRAP_LOCATION_ID,
                                   rgInfoserv.CATEGORY_ID,
                                   rgInfoserv.SUBCATEGORY_ID,
                                   rgInfoserv.POS_OPER_UNIT_ID,
                                   onumotive,
                                   onupackages,
                                   onuorden,
                                   onuordenact,
                                   onuErrorCodi,
                                   osbErrorMsg);

        OPEN ocurRespuesta FOR
            SELECT 'idSolicitud' parametro, TO_CHAR (onupackages) valor
              FROM DUAL
            UNION
            SELECT 'idMotivo' parametro, TO_CHAR (onumotive) valor FROM DUAL
            UNION
            SELECT 'idOrden' parametro, TO_CHAR (onuorden) valor FROM DUAL
            UNION
            SELECT 'idOrdenActivity' parametro, TO_CHAR (onuordenact) valor
              FROM DUAL
            UNION
            SELECT 'codigoError' parametro, TO_CHAR (onuErrorCodi) valor
              FROM DUAL
            UNION
            SELECT 'mensajeError' parametro, osbErrorMsg valor FROM DUAL;
    
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

	-- Manejo de excepciones
	
    EXCEPTION
        WHEN OTHERS
        THEN
		    pkg_error.setError;
			pkg_error.getError(nuerror, sbError);
            onuErrorCodi := -1;
            osbErrorMsg :=
                   '[ldci_pkinfoadicionalREVP.proProcesaXMLSolReparacion.Others] '||' nuerror: '||nuerror||' sbError:'||sbError;
            OPEN ocurRespuesta FOR
                SELECT 'idSolicitud' parametro, TO_CHAR (-1) valor FROM DUAL
                UNION
                SELECT 'idMotivo' parametro, TO_CHAR (-1) valor FROM DUAL
                UNION
                SELECT 'idOrden' parametro, TO_CHAR (-1) valor FROM DUAL
                UNION
                SELECT 'idOrdenActivity'         parametro,
                       TO_CHAR (onuordenact)     valor
                  FROM DUAL
                UNION
                SELECT 'codigoError' parametro, TO_CHAR (onuErrorCodi) valor
                  FROM DUAL
                UNION
                SELECT 'mensajeError' parametro, osbErrorMsg valor FROM DUAL;
			pkg_traza.trace(csbMetodo||' '||osbErrorMsg||' nuerror: '||nuerror||' sbError:'||sbError);
			pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);

    END proProcesaXMLSolReparacion;

    ---------------------------------------------------------------------------------------

    /*
    * Propiedad Intelectual Gases del Caribe S. A. E.S.P.
    *
    * Proceso     : proProcesaXMLSolCertificacion
    * Tiquete     :
    *  Fecha       : 03-01-2017
    * Descripcion : Genera Solicitud de certificaci?n de revision periodica.
    *
    * Historia de Modificaciones
    * Autor                    Fecha           Descripcion
    * Karem Baquero            03-01-2017      Creaci?n
    *
    *
    **/

    PROCEDURE proProcesaXMLSolCertificacion (
        MENSAJE_ID      IN     NUMBER,
        isbSistema      IN     VARCHAR2,                                    --
        inuOrden        IN     NUMBER,                                      --
        isbXML          IN     CLOB,                                        --
        isbEstado       IN     VARCHAR2,
        isbOperacion    IN     VARCHAR2,
        inuProcesoExt   IN     NUMBER,
        idtFechaRece    IN     DATE,
        idtFechaProc    IN     DATE,
        idtFechaNoti    IN     DATE,
        inuCodErrOsf    IN     NUMBER,
        isbMsgErrOsf    IN     VARCHAR2,
        ocurRespuesta      OUT SYS_REFCURSOR,
        onuErrorCodi       OUT NUMBER,
        osbErrorMsg        OUT VARCHAR2)
    AS
        --Estructura de respuesta
        tabRespuesta     LDCI_PkRepoDataType.tyTabRespuesta;
        tyRegRespuesta   LDCI_PkRepoDataType.tyWSRespTrabAdicRecord;

        /*cursor para leer el xml*/
        CURSOR cuxmlsercv (isbXMLserv IN VARCHAR2)
        IS
                            SELECT Datosprom.*
                              FROM XMLTABLE (
                                       '/solicitudCertificacion'
                                       PASSING XMLType (isbXMLserv)
                                       COLUMNS RECEPTION_TYPE_ID      NUMBER (15) PATH 'idTipoRecepcion',
                                               COMMENT_               VARCHAR2 (200) PATH 'comentario',
                                               CONTACT_ID             NUMBER (15) PATH 'idCliente',
                                               contrato               NUMBER (15) PATH 'idContrato',
                                               PRODUCT                NUMBER (15) PATH 'idProducto',
                                               ADDRESS_ID             NUMBER (15) PATH 'idDireccion',
                                               PARSER_ADDRESS_ID      VARCHAR2 (200) PATH 'direccion',
                                               GEOGRAP_LOCATION_ID    NUMBER (6) PATH 'idLocalidad',
                                               CATEGORY_ID            NUMBER (15) PATH 'idCategoria',
                                               SUBCATEGORY_ID         NUMBER (15) PATH 'idSubcategoria',
                                               POS_OPER_UNIT_ID       NUMBER (15) PATH 'idUnidadOper')                                                                       As   Datosprom;

        rgInfoserv       cuxmlsercv%ROWTYPE;

        onuorden         NUMBER;
        onupackages      NUMBER;
        onumotive        NUMBER;
        onuordenact      NUMBER;
		csbMetodo  		 CONSTANT VARCHAR2(100) := csbNOMPKG||'proProcesaXMLSolCertificacion';
		
    BEGIN
	
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
		
        --identifica valores del XML

        OPEN cuxmlsercv (isbXML);

        FETCH cuxmlsercv INTO rgInfoserv;

        CLOSE cuxmlsercv;

        --registra la solicitud
        proSolicitudcertifiREV (rgInfoserv.Reception_Type_Id,
                                rgInfoserv.Comment_,
                                rgInfoserv.Contact_Id,
                                rgInfoserv.Contrato,
                                rgInfoserv.Product,
                                rgInfoserv.Address_Id,
                                rgInfoserv.PARSER_ADDRESS_ID,
                                rgInfoserv.GEOGRAP_LOCATION_ID,
                                rgInfoserv.CATEGORY_ID,
                                rgInfoserv.SUBCATEGORY_ID,
                                rgInfoserv.POS_OPER_UNIT_ID,
                                onumotive,
                                onupackages,
                                onuorden,
                                onuordenact,
                                onuErrorCodi,
                                osbErrorMsg);

        OPEN ocurRespuesta FOR
            SELECT 'idSolicitud' parametro, TO_CHAR (onupackages) valor
              FROM DUAL
            UNION
            SELECT 'idMotivo' parametro, TO_CHAR (onumotive) valor FROM DUAL
            UNION
            SELECT 'idOrden' parametro, TO_CHAR (onuorden) valor FROM DUAL
            UNION
            SELECT 'idOrdenActivity' parametro, TO_CHAR (onuordenact) valor
              FROM DUAL
            UNION
            SELECT 'codigoError' parametro, TO_CHAR (onuErrorCodi) valor
              FROM DUAL
            UNION
            SELECT 'mensajeError' parametro, osbErrorMsg valor FROM DUAL;
			
			
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
			
    -- Manejo de excepciones

    EXCEPTION
        WHEN OTHERS
        THEN
		    pkg_error.setError;
			pkg_error.getError(nuerror, sbError);
            onuErrorCodi := -1;
            osbErrorMsg :=
                   '[ldci_pkinfoadicionalREVP.proProcesaXMLSolReparacion.Others]: '
                || 'nuerror: '||nuerror||' sbError: '||sbError;

            OPEN ocurRespuesta FOR
                SELECT 'idSolicitud' parametro, TO_CHAR (-1) valor FROM DUAL
                UNION
                SELECT 'idMotivo' parametro, TO_CHAR (-1) valor FROM DUAL
                UNION
                SELECT 'idOrden' parametro, TO_CHAR (-1) valor FROM DUAL
                UNION
                SELECT 'idOrdenActivity'         parametro,
                       TO_CHAR (onuordenact)     valor
                  FROM DUAL
                UNION
                SELECT 'codigoError' parametro, TO_CHAR (onuErrorCodi) valor
                  FROM DUAL
                UNION
                SELECT 'mensajeError' parametro, osbErrorMsg valor FROM DUAL;
				pkg_traza.trace(csbMetodo||' '||osbErrorMsg|| 'nuerror: '||nuerror||' sbError: '||sbError);
				pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
    END proProcesaXMLSolCertificacion;

    ---------------------------------------------------------------------------------------

    /*
    * Propiedad Intelectual Gases del Caribe S. A. E.S.P.
    *
    * Proceso     : proProcesaXMLAprCertOIA
    * Tiquete     :
    * Fecha       : 23-10-2017
    * Descripcion : Se encarga de aprobar o rechazar los certificados OIA que son enviadas desde el sistema externo.

    * Historia de Modificaciones
    * Autor       Fecha           Descripcion
    * AAcuna      23-10-2017      Creacion
    *dsaltarin 28-01-2022     806: Se agrega tag de fecha de aprobacion
    *
    **/

    PROCEDURE proProcesaXMLAprCertOIA (MENSAJE_ID      IN     NUMBER,
                                       isbSistema      IN     VARCHAR2,
                                       inuOrden        IN     NUMBER,
                                       isbXML          IN     CLOB,
                                       isbEstado       IN     VARCHAR2,
                                       isbOperacion    IN     VARCHAR2,
                                       inuProcesoExt   IN     NUMBER,
                                       idtFechaRece    IN     DATE,
                                       idtFechaProc    IN     DATE,
                                       idtFechaNoti    IN     DATE,
                                       inuCodErrOsf    IN     NUMBER,
                                       isbMsgErrOsf    IN     VARCHAR2,
                                       ocurRespuesta      OUT SYS_REFCURSOR,
                                       onuErrorCodi       OUT NUMBER,
                                       osbErrorMsg        OUT VARCHAR2)
    AS
        tabRespuesta     LDCI_PkRepoDataType.tyTabRespuesta;
        tyRegRespuesta   LDCI_PkRepoDataType.tyWSRespTrabAdicRecord;

        CURSOR cuxmlaprcert (isbXMLserv IN VARCHAR2)
        IS
                     SELECT DatosCert.*
                       FROM XMLTABLE (
                                '/RegistroAprobarCertReq'
                                PASSING XMLType (isbXML)
                                COLUMNS certificado     NUMBER (15) PATH 'certificado',
                                        estado          VARCHAR2 (200) PATH 'estado',
                                        observacion     VARCHAR2 (3200) PATH 'observacion',
                                        dtFechaAprob    VARCHAR2 (200) PATH 'Fecha_Aprob')                                                                               As   DatosCert;

        rgInfoAprCert    cuxmlaprcert%ROWTYPE;

        onuorden         NUMBER;
        onupackages      NUMBER;
        onumotive        NUMBER;
        onuordenact      NUMBER;
        dtFechaApro      DATE;
		csbMetodo  		 CONSTANT VARCHAR2(100) := csbNOMPKG||'proProcesaXMLAprCertOIA';
		
    BEGIN
        
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
		
		OPEN cuxmlaprcert (isbXML);

        FETCH cuxmlaprcert INTO rgInfoAprCert;

        CLOSE cuxmlaprcert;

        dtFechaApro :=
            TO_DATE (rgInfoAprCert.dtFechaAprob, 'dd/mm/yyyy hh24:mi:ss');
        LDCI_PROUPDOBSTATUSCERTOIAWS (rgInfoAprCert.Certificado,
                                      rgInfoAprCert.Estado,
                                      rgInfoAprCert.Observacion,
                                      dtFechaApro,
                                      onuErrorCodi,
                                      osbErrorMsg);

        OPEN ocurRespuesta FOR
            SELECT 'idProcesoExterno'          parametro,
                   TO_CHAR (inuProcesoExt)     valor
              FROM DUAL
            UNION
            SELECT 'codigoError' parametro, TO_CHAR (onuErrorCodi) valor
              FROM DUAL
            UNION
            SELECT 'mensajeError' parametro, osbErrorMsg valor FROM DUAL;
			
			
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);	
			
    EXCEPTION
        WHEN OTHERS
        THEN
		    pkg_error.setError;
			pkg_error.getError(nuerror, sbError);
            onuErrorCodi := -1;
            osbErrorMsg :=
                   '[ldci_pkinfoadicionalREVP.proProcesaXMLAprCertOIA.Others]' ||' nuerror: '||nuerror||' sbError:'||sbError;

            OPEN ocurRespuesta FOR
                SELECT 'idProcesoExterno'          parametro,
                       TO_CHAR (inuProcesoExt)     valor
                  FROM DUAL
                UNION
                SELECT 'codigoError' parametro, TO_CHAR (onuErrorCodi) valor
                  FROM DUAL
                UNION
                SELECT 'mensajeError' parametro, osbErrorMsg valor FROM DUAL;
			pkg_traza.trace(csbMetodo||' '||osbErrorMsg||' nuerror: '||nuerror||' sbError:'||sbError);
			pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
    END proProcesaXMLAprCertOIA;
END LDCI_PKINFOADICIONALREVP;
/

PROMPT Otorgando permisos de ejecucion a LDCI_PKINFOADICIONALREVP
BEGIN
  pkg_utilidades.prAplicarPermisos('LDCI_PKINFOADICIONALREVP','ADM_PERSON');
END;
/
