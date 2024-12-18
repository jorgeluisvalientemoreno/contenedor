create or replace PROCEDURE adm_person.prsolcupporweb (
    MED_REEPCION     IN     NUMBER,
    COMENTARIO       IN     VARCHAR2,
    CONTRATO         IN     NUMBER,
    nuPackageId         OUT mo_packages.package_id%TYPE,
    nuErrorCode         OUT NUMBER,
    sbErrorMessage      OUT VARCHAR2)
IS
    /**************************************************************************
    Propiedad Intelectual de HORBATH TECHNOLOGIES

    Funcion     :  PRSOLCUPPORWEB
    Descripcion :  PROCEDIMIENTO PARA LA GENERACION DE LA SOLICITUD DE CUPON POR EL PORTAL WEB
    Autor       : ESANTIAGO
    Fecha       : 07-05-2020
	Caso  : 411

    Historia de Modificaciones
      Fecha               Autor                Modificacion
    =========           =========          ====================
	16/11/2023			jsoto			   	Ajustes cambio en llamado a algunos de los objetos de producto por personalizados
											Ajuste  cambio en manejo de trazas y errores por personalizados.
											Ajuste llamado a PKG_XML_SOLI_ATEN_CLIENTE para armar el xml de la solicitud
											Ajuste llamado a API api_registerRequestByXml
    19/04/2024		    Adrianavg		    OSF-2569: Se migra del esquema OPEN al esquema ADM_PERSON                                            
    **************************************************************************/



    nuProductId       PR_PRODUCT.PRODUCT_ID%TYPE;
    sbComment         VARCHAR2 (2000);
    nuRecept          MO_PACKAGES.RECEPTION_TYPE_ID%TYPE;

    osbErrorMessage   VARCHAR2 (4000);
    onuErrorCode      NUMBER;
    ionuorderid       or_order.order_id%TYPE;
    sbmensamen        VARCHAR2 (4000);


    nuContratoId      NUMBER;
    nuSubscriberId    NUMBER;
    nuActividad       NUMBER;
    sbRequestXML1     constants_per.tipo_xml_sol%TYPE;
    nuMotiveId        mo_motive.motive_id%TYPE;

    csbMT_NAME  VARCHAR2(70) :=  'PRSOLCUPPORWEB';


    CURSOR cuAreaOrganizat (nuUnitop NUMBER)
    IS
        SELECT ORGA_AREA_ID
          FROM or_operating_unit
         WHERE OPERATING_UNIT_ID = nuUnitop;


    CURSOR cuSubscriberId (contrato NUMBER)
    IS
        SELECT gs.SUBSCRIBER_ID
          FROM ge_subscriber gs, suscripc ss
         WHERE gs.subscriber_id = ss.suscclie AND ss.susccodi = contrato;
BEGIN

	pkg_traza.trace(csbMT_NAME,pkg_traza.cnuNivelTrzDef,pkg_traza.csbINICIO);

    nuContratoId := CONTRATO;
    pkg_traza.trace ('PRSOLCUPPORWEB-nuContratoId -->' || nuContratoId, pkg_traza.cnuNivelTrzDef);

    sbComment := COMENTARIO;
    pkg_traza.trace ('PRSOLCUPPORWEB-sbComment -->' || sbComment, pkg_traza.cnuNivelTrzDef);


    nuRecept := MED_REEPCION;
    pkg_traza.trace ('PRSOLCUPPORWEB-nuRecept 2-->' || nuRecept, pkg_traza.cnuNivelTrzDef);


    sbRequestXML1 :=   pkg_xml_soli_aten_cliente.getSolicitudCuponPortal(nuRecept,
																		 sbComment,
																		 nuContratoId);

	pkg_traza.trace ('sbRequestXML1' || sbRequestXML1, pkg_traza.cnuNivelTrzDef);

    api_registerRequestByXml  (sbRequestXML1,
                               nuPackageId,
                               nuMotiveId,
                               onuErrorCode,
                               osbErrorMessage);

    IF onuErrorCode <> 0
    THEN
        nuErrorCode := onuErrorCode;
        sbErrorMessage := osbErrorMessage;
        pkg_traza.trace (
               'PRSOLCUPPORWEB ERROR AL GENERAR EL TRAMITE -->'
            || sbErrorMessage,
            pkg_traza.cnuNivelTrzDef);
    ELSE
        COMMIT;
    END IF;

	pkg_traza.trace(csbMT_NAME,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN);


EXCEPTION
    WHEN pkg_error.controlled_error
    THEN
    	pkg_traza.trace(csbMT_NAME,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERC);
        RAISE;
    WHEN OTHERS
    THEN
        pkg_error.setError;
        pkg_traza.trace (
            'PRSOLCUPPORWEB ERROR AL GENERAR EL TRAMITE --> when others ',
            pkg_traza.cnuNivelTrzDef);
		pkg_traza.trace(csbMT_NAME,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);
        RAISE pkg_error.controlled_error;
END PRSOLCUPPORWEB;
/
PROMPT OTORGA PERMISOS ESQUEMA SOBRE PROCEDIMIENTO PRSOLCUPPORWEB
BEGIN
    pkg_utilidades.prAplicarPermisos('PRSOLCUPPORWEB', 'ADM_PERSON'); 
END;
/