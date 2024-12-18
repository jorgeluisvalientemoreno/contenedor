CREATE OR REPLACE PACKAGE PKG_BOINFODATOSFORMATOS IS
/*******************************************************************************
    Fuente=Propiedad Intelectual de Gases del Caribe
    pkg_boinfopredio
    Autor       :   Jhon Jairo Soto
    Fecha       :   24-09-2024
    Descripcion :   Paquete con los metodos para los servicios de consulta de FCED para certificados que salen de SAC

    Modificaciones  :
    Autor               Fecha           Caso        Descripcion
    jsoto			    24-09-2024      OSF-3315    Creacion
*******************************************************************************/

    FUNCTION fsbVersion RETURN VARCHAR2;


    PROCEDURE prcDatosFormConstanciaPagos
    (
        orfcursor Out constants.tyRefCursor
    );
	
    PROCEDURE prcDatosFormEstDeudaporProd
    (
        orfcursor Out constants.tyRefCursor
    );


END PKG_BOINFODATOSFORMATOS;

/
CREATE OR REPLACE PACKAGE BODY PKG_BOINFODATOSFORMATOS IS

    -- Identificador del ultimo caso que hizo cambios
    csbVersion 	VARCHAR2(15) := 'OSF-3315';

    -- Constantes para el control de la traza
    csbSP_NAME 	CONSTANT VARCHAR2(35):= $$PLSQL_UNIT||'.';
    cnuNVLTRC 	CONSTANT NUMBER := 5;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbVersion 
    Descripcion     : Retona el identificador del ultimo caso que hizo cambios
    Autor           : Jhon Jairo Soto
    Fecha           : 24/09/2024
    Modificaciones  :
    Autor               Fecha       Caso        Descripcion
    jsoto			    24/09/2024  OSF-3315    Creacion
    ***************************************************************************/
    FUNCTION fsbVersion RETURN VARCHAR2 IS
    BEGIN
        RETURN csbVersion;
    END fsbVersion;


    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : prcDatosFormConstanciaPagos 
        Descripcion     : Retorna cursor con los datos para imprimir en el formato de constancia de pagos
        Autor           : 
        Fecha           : 24/09/2024
        Parametros de Entrada

        Parametros de Salida        
        Modificaciones  :
        =========================================================
        Autor               Fecha               Descripción
        jsoto			    24/09/2024          OSF-3315: Creación
    ***************************************************************************/
    PROCEDURE prcDatosFormConstanciaPagos
    (
        orfcursor Out constants.tyRefCursor
    )
    IS
        sbError             VARCHAR2(4000);
        nuError             NUMBER;   
        csbMetodo  CONSTANT VARCHAR2(100) := csbSP_NAME||'prcDatosFormConstanciaPagos';

    BEGIN

        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);    

		
		OPEN orfcursor FOR
		SELECT  pktblsistema.fsbgetcompanyname(99) NOM_EMPRESA,
				suscripc.susccodi               CONTRATO,
				FSBGETCADENAENCRIPTADA(add_susc.address_parsed,2) DIRECCION,
				geo_susc.description            MUNICIPIO,
				FSBGETCADENAENCRIPTADA(client.subscriber_name,1) NOMBRE_CLIENTE,
				FSBGETCADENAENCRIPTADA(client.subs_last_name,1)  APELLIDO_CLIENTE,
				(select contact.subscriber_name||' '||contact.subs_last_name
				from ge_subscriber contact where mo_packages.contact_id= contact.subscriber_id) NOM_SOLICITANTE,
				(select contact.identification
				from ge_subscriber contact where mo_packages.contact_id= contact.subscriber_id)DOC_SOLICITANTE,
				(select GE.description from or_operating_unit OP, ab_address DIR, ge_geogra_location GE
				where OP.operating_unit_id=mo_packages.pos_oper_unit_id
				and OP.starting_address=DIR.address_id
				and DIR.geograp_location_id = GE.geograp_location_id) MUN_SOLICITANTE,
				to_char(mo_packages.request_date,'dd/mm/yyyy') FECHA,
				to_char(mo_packages.request_date,'DD') DIA,
				to_char(mo_packages.request_date,'MM') MES,
				to_char(mo_packages.request_date,'YYYY') ANO,
				LDC_CRMPazySalvo.Fsbaddress MUNICIPIO_ATENCION
		FROM    mo_motive, mo_packages, suscripc, ab_address add_susc, ge_geogra_location  geo_susc,ge_subscriber client
		WHERE   mo_motive.motive_id         = cc_bocertificate.fnuMotiveId
		AND     mo_motive.package_id        = mo_packages.package_id
		AND     mo_motive.subscription_id   = suscripc.susccodi
		AND     suscripc.susciddi           = add_susc.address_id
		AND     add_susc.geograp_location_id= geo_susc.geograp_location_id
		AND     suscripc.suscclie           = client.subscriber_id;
	

        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RAISE pkg_Error.Controlled_Error;
    END prcDatosFormConstanciaPagos;


    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : prcDatosFormEstDeudaporProd 
        Descripcion     : Retorna cursor con los datos para imprimir en el formato de Certificado de estado de deuda por producto
        Autor           : 
        Fecha           : 24/09/2024
        Parametros de Entrada

        Parametros de Salida        
        Modificaciones  :
        =========================================================
        Autor               Fecha               Descripción
        jsoto			    24/09/2024          OSF-3315: Creación
    ***************************************************************************/
    PROCEDURE prcDatosFormEstDeudaporProd
    (
        orfcursor Out constants.tyRefCursor
    )
    IS
        sbError             VARCHAR2(4000);
        nuError             NUMBER;   
        csbMetodo  CONSTANT VARCHAR2(100) := csbSP_NAME||'prcDatosFormEstDeudaporProd';

    BEGIN

        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);    

		
		OPEN orfcursor FOR
		SELECT distinct suscripc.susccodi CONTRATO,
						FSBGETCADENAENCRIPTADA(add_susc.address_parsed,2) DIRECCION,
						geo_susc.description MUNICIPIO,
						FSBGETCADENAENCRIPTADA(client.subscriber_name,1) NOMBRE_CLIENTE,
						FSBGETCADENAENCRIPTADA(client.subs_last_name,1) APELLIDO_CLIENTE,
						contact.subscriber_name || ' ' || contact.subs_last_name NOM_SOLICITANTE,
						contact.identification DOC_SOLICITANTE,
						(select LDC_CRMPazySalvo.Fsbaddress from dual) MUNICIPIO_FIRMA,
						to_char(mo_packages.request_date, 'dd/mm/yyyy') FECHA,
						to_char(mo_packages.request_date, 'dd') DIA,
						to_char(mo_packages.request_date, 'mm') MES,
						to_char(mo_packages.request_date, 'yyyy') ANO,
						pktblsistema.fsbgetcompanyname(99) NOM_EMPRESA,
						to_char(daldc_fech_estad_deu_prod.fdtGetfecha_deuda(mo_packages.package_id,0),'dd/mm/yyyy') FECHA_DEUDA,
						to_char(daldc_fech_estad_deu_prod.fdtGetfecha_deuda(mo_packages.package_id,0),'dd') DDEUDA,
						to_char(daldc_fech_estad_deu_prod.fdtGetfecha_deuda(mo_packages.package_id,0),'mm') MDEUDA,
						to_char(daldc_fech_estad_deu_prod.fdtGetfecha_deuda(mo_packages.package_id,0),'yyyy') ADEUDA,
						(select LDC_ESTADOCUENTACASTIGADA.fnuGetIsCastig(suscripc.susccodi) FROM DUAL) ESCASTIGADA,
						to_char((select LDC_ESTADOCUENTACASTIGADA.fnuGetIsCastig(suscripc.susccodi) FROM DUAL),'$999,999,999') VALORCASTIGADA

		  FROM mo_motive,
			   mo_packages,
			   suscripc,
			   or_operating_unit,
			   ab_address         add_susc,
			   ge_geogra_location geo_susc,
			   ge_subscriber      client,
			   ge_subscriber      contact
		 WHERE mo_motive.motive_id = ldc_bocertificado_estdeuda.fnuObtieneMotivo
		   AND mo_motive.package_id = mo_packages.package_id
		   AND mo_motive.subscription_id = suscripc.susccodi
		   AND suscripc.susciddi = add_susc.address_id
		   AND add_susc.geograp_location_id = geo_susc.geograp_location_id
		   AND suscripc.suscclie = client.subscriber_id
		   AND mo_packages.contact_id = contact.subscriber_id
		   AND mo_packages.pos_oper_unit_id = or_operating_unit.operating_unit_id;	

        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RAISE pkg_Error.Controlled_Error;
    END prcDatosFormEstDeudaporProd;

END PKG_BOINFODATOSFORMATOS;
/

PROMPT Otorgando permisos de ejecución para pkg_boinfodatosformatos
BEGIN
    pkg_utilidades.prAplicarPermisos('PKG_BOINFODATOSFORMATOS', 'OPEN');
END;
/
