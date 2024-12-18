CREATE OR REPLACE PACKAGE ADM_PERSON.GDC_BOSuspension_XNO_Cert AS
    /***********************************************************
        Propiedad intelectual de GDC.

        Descripción     :   Business Object - SUSPENSION XNO CERT
        Autor           :   GDC
        Fecha           :   Viernes, Ago. 02, 2019 a las 08:56:42 AM GMT-05:00

        Métodos
        Nombre :
        Parámetros      Descripción
        ============    ===================

        Historia de Modificaciones
        Fecha       Autor       Modificación
        =========   ========    ====================
        02-Ago-2019 GDC         Created
        25-09-2021  Horbath     CA667:  Se crea prValidateRepairProduct
                                        Se modifica Run_Process
		03/01/2024	JSOTO		OSF-2004: 
								-Ajustes cambio en llamado a algunos de los objetos de producto por personalizados
								-Ajuste  cambio en manejo de trazas y errores por personalizados (pkg_error y pkg_traza).
								-Ajuste llamado a pkg_xml_soli_rev_periodica para armar los XML de las solicitudes
								-Ajuste llamado a api_registerRequestByXml
								-Se suprimen llamado a "AplicaEntrega" que no se encuentren activos
		14/05/2024	jpinedc		OSF-2603: * Se ajusta SendEmail y se hace público para
                                prueba por medio de tester
        09/07/2024  Adrianavg   OSF-2933: Se ajusta para retirar objetos que se borraron
    ************************************************************/
    FUNCTION fsbVersion  RETURN VARCHAR2;

    PROCEDURE Schedule_Threads (
        inuThreadsQuantity  in  number  -- Threads Quantity
    );

    PROCEDURE Run_Process (
        inuThreadNumber     in  number, -- Thread number
        inuThreadsQuantity  in  number, -- Threads Quantity
        isbProgram          in  estaprog.esprprog%type,
        inuErrorCode        in  ge_error_log.error_log_id%type,
        isbErrorMsg         in  ge_error_log.description%type
    );
            
    PROCEDURE SendEmail;
END;
/

CREATE OR REPLACE PACKAGE BODY ADM_PERSON.GDC_BOSuspension_XNO_Cert AS

    /***********************************************************
        Propiedad intelectual de GDC.

        Descripción     :   Business Object - SUSPENSION XNO CERT
        Autor           :   GDC
        Fecha           :   Viernes, Ago. 02, 2019 a las 08:56:42 AM GMT-05:00

        Métodos
        Nombre :
        Parámetros      Descripción
        ============    ===================

        Historia de Modificaciones
        Fecha           Autor       Modificación
        =========       ========    ====================
        02-Ago-2019     GDC         Created
		17/06/2021  	GDC - N1    CAMBIO 783: Se colocara en comentario la logica del 472 con relacion al llamado de uno de los 
                                                2 servicios GDC_BCSuspension_XNO_Cert.GetProductsToNotifica. Para dejar solo el 
                                                servicio definido en el CAMBIO 472. Con el fin de manejar un solo paramatro de 
                                                tiempo de generacion de notificacion de suspension.
        25-09-2021  	Horbath     CA667:  Se crea prValidateRepairProduct
											Se modifica Run_Process
		03/01/2024		JSOTO		OSF-2004: 
									-Ajustes cambio en llamado a algunos de los objetos de producto por personalizados
									-Ajuste  cambio en manejo de trazas y errores por personalizados (pkg_error y pkg_traza).
									-Ajuste llamado a pkg_xml_soli_rev_periodica para armar los XML de las solicitudes
									-Ajuste llamado a api_registerRequestByXml
									-Se suprimen llamado a "AplicaEntrega" que no se encuentren activos
        09/07/2024      Adrianavg   OSF-2933: Se ajusta para retirar objetos que se borraron
                                    Se retira declaración de variable rcLdc_usuarios_susp_y_noti
                                    Se ajusta Metodo RUN_PROCESS:
                                        Se retira invocación a GDC_DSLDC_Usuarios_Susp_y_Noti.delRecords('S'), el paquete fue borrado
                                        Se retira invocación a GDC_DSUsuarios_no_aplica_su_no.delRecords('S'), el paquete fue borrado
                                        En el IF-ENDIF sbCreaSolicitud= 'N' del Create request se cambia 'N' a 'S' se retira la lógica del IF y se reemplaza por la que tenia el ELSE. Se elimina el ELSE
                                        En el IF-ENDIF sbGeneraSol = 'S', se deja la lógica del IF y se retira el ELSE y su lógica que armaba el registro para rcLdc_usuarios_susp_y_noti
                                        Del IF-ENDIF nvl(nuExiste,0) = 0, se retira el ELSE que hace INSERT-INTO en la entidad usuarios_no_aplica_suspe_notif (tabla borrada).
                                        Del IF-ENDIF sw1 = 0, se retira el ELSE que hace INSERT-INTO en la entidad usuarios_no_aplica_suspe_notif (tabla borrada).
                                        Del IF-ENDIF sbCreaSolicitud= 'N', se cambia 'N' a 'S' se retira la lógica del IF y se reemplaza por la que tenia el ELSE. Se elimina el ELSE
                                        Se reemplaza GDC_DSLDC_Plazos_Cert.fnuValMinSusp por cursor cuValMinSusp, para asignar valor a variable nuOk.                                        
    ************************************************************/
    -- Variables
    csbVersion              constant varchar2(250) := 'OSF-2933';
    sbErrMsg                ge_error_log.description%type;
    nuCodError              ge_error_log.error_log_id%type;
    gsbProgram              estaprog.esprprog%type := 'CERT';
    sbProgram               estaprog.esprprog%type;

    -- Constantes
	csbSP_NAME 				CONSTANT VARCHAR2(35):= $$PLSQL_UNIT||'.';
	cnuNVLTRC 				CONSTANT NUMBER := pkg_traza.cnuNivelTrzDef;
	csbInicio   			CONSTANT VARCHAR2(35) := pkg_traza.fsbINICIO;


    -- define las variables
    sender           		VARCHAR2(2000);
    sbRecipients     		VARCHAR2(2000);
    sbSubject        		VARCHAR2(2000);
    sbMessage0          	VARCHAR2(4000);
    onuErrorCode        	NUMBER;
    osbErrorMessage     	VARCHAR2(4000);
    nuTotal             	NUMBER;
    nuTotalSusp         	NUMBER;
    nuTotalNoti         	NUMBER;
    nuContaSus          	NUMBER;
    nuContaNoti         	NUMBER;
    sbComment           	VARCHAR2(2000) := 'SE GENERAN DESDE JOB (JOB_SUSPENSION_XNO_CERT)';
    sbRequestXML1       	constants_per.tipo_xml_sol%TYPE;
    nuAddress_id        	pr_product.address_id%TYPE;
    rcAb_address        	daab_address.styAB_Address;
    nuPackage_id        	MO_PACKAGES.PACKAGE_ID%TYPE;
    nuMotiveId          	MO_MOTIVE.MOTIVE_ID%TYPE;
    nuSUBSCRIBERId      	ge_subscriber.SUBSCRIBER_id%TYPE;
    nuSUBSCRIPTIONID    	pr_product.SUBSCRIPTION_ID%TYPE;
    nuCate              	servsusc.sesucate%TYPE;
    nuSuca              	servsusc.sesusuca%TYPE;
    nuDias              	NUMBER;
    nuDias_dif          	NUMBER;
    nuDias_dif_repa     	NUMBER;
    nuDias_Anti_Notf    	NUMBER := nvl(pkg_BCLD_Parameter.fnuObtieneValorNumerico('NUM_DIAS_ANTICIPAR_NOTIFI_RP'),0);
    nuDias_repa_OIA     	NUMBER;
    nutipoCausal        	NUMBER;
    nuCausal            	NUMBER;
    fecha_inicio        	DATE;
    sw1                 	NUMBER;
    sbFlag_inge         	VARCHAR2(1);
    v_medidor           	elmesesu.emsscoem%TYPE;
    nuProduct_status_id 	pr_product.product_status_id%type;
    sbCOD_PKG_TYPE_ID_FILTRO_SUSP  ld_parameter.value_chain%type;
    --INICIO CA 472
     sbCOD_PKG_TYPE_ID_FILTRO  ld_parameter.value_chain%type;
     NUDIASANTNOTRP  		NUMBER;
   --FIN CA 472
    -- Producto a procesar
    inuProduct_id         	servsusc.sesunuse%TYPE;
    inuSUSPENSION_TYPE_ID 	ldc_marca_producto.SUSPENSION_TYPE_ID%TYPE;
    v_sector_operativo 		or_operating_sector.operating_sector_id%TYPE;
    v_localidad        		ge_geogra_location.geograp_location_id%TYPE;
    v_departamento     		ge_geogra_location.geo_loca_father_id%TYPE;
    sbcreasolicitud    		varchar2(1);
    v_direccion_parseada 	ab_address.address_parsed%TYPE;
    nuConsecutivo      		number:=0;
    sbError            		varchar2(4000);

    sbmensa            		ldc_osf_estaproc.observacion%TYPE;
    nuregeinssuspe     		NUMBER(10) DEFAULT 0;
    nuregeinsnotif     		NUMBER(10) DEFAULT 0;
    nutotalencontranot 		NUMBER(10) DEFAULT 0;
    nuactivoproc       		NUMBER(4);
    nucontaregsuspx    		NUMBER(3);
    rgplazoscert       		ldc_plazos_cert%ROWTYPE;
    nususpencontra     		NUMBER(10) DEFAULT 0;
    sbGeneraSol        		varchar2(1);
    sbCausal           		ld_parameter.value_chain%type:=nvl(pkg_BCLD_Parameter.fsbObtieneValorCadena('CAUSALES_TT_ACOM_FALLIDA'),'-1');
    sbValidaAcom       		ld_parameter.value_chain%type:=nvl(pkg_BCLD_Parameter.fsbObtieneValorCadena('VALIDA_ACOMET_FALLIDA'),'N');
    nuCantAcome        		number;
    sbVAlidaSolOpe     		ld_parameter.value_chain%type:= nvl(pkg_BCLD_Parameter.fsbObtieneValorCadena('LD_VALI_SOLICITUD_OPEN'),'N');

    -- PARAMETROS REPORTE
    nuIdReporte         	reportes.reponume%type;
    sbEncabezadoDatos   	repoinco.REINDES2%type;
    sbValorDatos        	repoinco.reinobse%type;
    
    sbis_notif      		VARCHAR2(2);
    NUOK            		NUMBER;
    nuExiste 				number := 0;
    nuPersonID      		ge_person.person_id%TYPE;
    nuoperatingunit 		or_order.OPERATING_UNIT_ID%TYPE;
    
    rcProduct       		dapr_product.styPr_product;

    -- Types
    tbServsusc GDC_BCSuspension_XNO_Cert.tbtyServsuscTable;
	--667
	nutipoCausalrepa ldc_pararepe.parevanu%type;
	nuCausalrepa	 ldc_pararepe.parevanu%type;
	nuCausTramite 	 number;
	nutipoCauTram    number;

    sbRemitente     ld_parameter.value_chain%TYPE:= pkg_BCLD_Parameter.fsbObtieneValorCadena('LDC_SMTP_SENDER');

    FUNCTION fsbVersion
    RETURN VARCHAR2
    IS
		csbMT_NAME  VARCHAR2(70) := csbSP_NAME || 'fsbVersion';

    BEGIN
		
		pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbInicio);
		pkg_traza.trace(csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN);

        RETURN ( CSBVERSION );

    END;

    /*
        Metodo      :   Schedule process
        Descripcion :   Programa hilos

        Autor       :   GDC
        Fecha       :   02-Ago-2019

        Historia de Modificaciones
        Fecha       IDEntrega
        02-Ago-2019 Created
    */
    PROCEDURE Schedule_Threads (
        inuThreadsQuantity  in  number  -- Threads Quantity
    )
    IS
        -- Variables
        sbWhat          GE_BOUTILITIES.STYSTATEMENT;
        nuError         ge_error_log.message_id%TYPE;
        nuThreadNumber  number;
        nuErrorCode     number;
        sbProgram       estaprog.esprprog%type;
		csbMT_NAME  VARCHAR2(70) := csbSP_NAME || 'Schedule_Threads';
		
    BEGIN
	
		pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbInicio);
				
        -- Get program for tracking
        sbProgram := pkStatusExeProgramMgr.fsbGetProgramID (gsbProgram);

        -- Loop to schedule threads
        FOR nuThreadNumber IN 1 .. inuThreadsQuantity LOOP
        
            sbWhat :=   'DECLARE'                                               || ' ' ||
                            'nuErrorCode     ge_error_log.error_log_id%type;'   || ' ' ||
                            'sbErrorMessage  ge_error_log.description%type;'    || ' ' ||
                        'BEGIN'                                                 || ' ' ||
                            'GDC_BOSuspension_XNO_Cert.Run_Process('            || ' ' ||
                                to_char(nuThreadNumber)                         || ', ' ||
                                to_char(inuThreadsQuantity)                     || ', ' ||
                                '''' || sbProgram || ''''                       || ', ' ||
                                'nuErrorCode,'                                  || ' ' ||
                                'sbErrorMessage);'                              || ' ' ||
                        'EXCEPTION'                                             || ' ' ||
                            'WHEN LOGIN_DENIED OR pkg_error.controlled_error THEN'     || ' ' ||
                                'RAISE;'                                        || ' ' ||
                            'WHEN OTHERS THEN'                                  || ' ' ||
                                'pkg_error.setError;'                              || ' ' ||
                                'RAISE pkg_error.controlled_error;'                    || ' ' ||
                        'END;';
                        
            -- Create job
            pkBIUT_JobMgr.CreateJob(
                sbWhat,
                sysdate,
                null,
                nuErrorCode
            );

            PKGENERALSERVICES.COMMITTRANSACTION;
        END LOOP;

        -- Sleep
        DBMS_LOCK.SLEEP(5);
		
		pkg_traza.trace(csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN);
		
    END;

    /*
        Metodo      :   fnuCrReportHeader
        Descripcion :   Create report header

        Autor       :   GDC
        Fecha       :   02-Ago-2019

        Historia de Modificaciones
        Fecha       IDEntrega
        02-Ago-2019 Created
    */

    FUNCTION fnuCrReportHeader
    return number
    IS
        -- Variables
        rcRecord Reportes%rowtype;
		csbMT_NAME  VARCHAR2(70) := csbSP_NAME || 'fnuCrReportHeader';

		
    BEGIN
    
		pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbInicio);
				
        -- Fill record
        rcRecord.REPOAPLI := 'SUS_NOT_RP';
        rcRecord.REPOFECH := sysdate;
        rcRecord.REPOUSER := pkg_session.fsbgetterminal;
        rcRecord.REPODESC := 'INCONSISTENCIAS JOB NOTIFICACIONES Y SUSPENSIONES RP' ;
        rcRecord.REPOSTEJ := null;
        rcRecord.REPONUME :=  seq.getnext('SQ_REPORTES');

        -- Insert record
        pktblReportes.insRecord(rcRecord);

		pkg_traza.trace(csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN);

        return rcRecord.Reponume;
    
    END;
    
    /*
        Metodo      :   BuildXML
        Descripcion :   Create report header

        Autor       :   GDC
        Fecha       :   02-Ago-2019

        Historia de Modificaciones
        Fecha       IDEntrega
        02-Ago-2019 Created
    */
    FUNCTION fsbBuildXML(
        inuSubscriberId         in  number,
        isbComment              in  varchar2,
        inuProduct_id           in  number,
        idtFecha_inicio         in  date,
        inuSuspension_type_id   in  number,
        inuTipoCausal           in  number,
        inuCausal               in  number
    )
    return constants_per.tipo_xml_sol%TYPE
    IS
        -- Variables
        sbRequestXML    	constants_per.tipo_xml_sol%TYPE;
		inumediorecepcion	NUMBER := 10;
		csbMT_NAME  		VARCHAR2(70) := csbSP_NAME || 'fsbBuildXML';
		nuErrorCode			NUMBER;
		sbErrorMessage		VARCHAR2(2000);
    BEGIN
	
		pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbInicio);
				
		sbRequestXML := pkg_xml_soli_rev_periodica.getSuspensionAdministrativa(inumediorecepcion,
																			 inuSubscriberId,
																			 NULL,
																			 isbComment,
																			 inuProduct_id,
																			 idtFecha_inicio,
																			 inuSuspension_type_id,
																			 inuTipoCausal,
																			 inuCausal);
		
		pkg_traza.trace('sbRequestXML: '||sbRequestXML);		
		pkg_traza.trace(csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN);																	 
	    
        return sbRequestXML;
		
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
			pkg_error.getError(nuErrorCode,sbErrorMessage);
			pkg_traza.trace(csbMT_NAME||' '||sbErrorMessage, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_error.setError;
			pkg_error.getError(nuErrorCode,sbErrorMessage);
			pkg_traza.trace(csbMT_NAME||' '||sbErrorMessage, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
            RAISE pkg_error.controlled_error;
    END;
    
    /*
        Metodo      :   fsbBuildXMLSusp
        Descripcion :   Build XML Susp

        Autor       :   GDC
        Fecha       :   02-Ago-2019

        Historia de Modificaciones
        Fecha       IDEntrega
        02-Ago-2019 Created
    */
    FUNCTION fsbBuildXMLSusp(
        inuSubscriberId         in  suscripc.suscclie%type,
        isbComment              in  varchar2,
        inuProduct_id           in  pr_product.product_id%type,
        inuSubscriptionID       in  pr_product.subscription_id%type,
        isbAddress              in  ab_address.address%type,
        inuAddress_id           in  ab_address.address_id%type,
        inuGeograp_location_id  in  ab_address.geograp_location_id%type,
        inuCategory             in  categori.catecodi%type,
        inuSubCategory          in  subcateg.sucacodi%type
    )
    return constants_per.tipo_xml_sol%TYPE
    IS
        -- Variables
        sbRequestXML    	constants_per.tipo_xml_sol%TYPE;
		inumediorecepcion	NUMBER := 10;
		csbMT_NAME  		VARCHAR2(70) := csbSP_NAME || 'fsbBuildXMLSusp';
		nuErrorCode			NUMBER;
		sbErrorMessage		VARCHAR2(2000);


    BEGIN
	
		pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbInicio);
		
        --  se crea tramite de notificacion para suspension
		sbRequestXML :=  pkg_xml_soli_rev_periodica.getNotiSuspension(inumediorecepcion,
                                                                        isbComment,
                                                                        inuSubscriberId,
                                                                        inuProduct_id,
                                                                        inuSubscriptionID,
                                                                        isbAddress,
                                                                        inuAddress_id,
                                                                        inuGeograp_location_id,
                                                                        inuCategory,
                                                                        inuSubCategory);
		
		pkg_traza.trace('sbRequestXML: '||sbRequestXML);		
		pkg_traza.trace(csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN);																	 
		
        return sbRequestXML;

    EXCEPTION
        WHEN pkg_error.controlled_error THEN
			pkg_error.getError(nuErrorCode,sbErrorMessage);
			pkg_traza.trace(csbMT_NAME||' '||sbErrorMessage, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_error.setError;
			pkg_error.getError(nuErrorCode,sbErrorMessage);
			pkg_traza.trace(csbMT_NAME||' '||sbErrorMessage, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
            RAISE pkg_error.controlled_error;
    END;

    /*
        Metodo      :   SendEmail
        Descripcion :   Send Email

        Autor       :   GDC
        Fecha       :   02-Ago-2019

        Historia de Modificaciones
        Fecha       IDEntrega
        02-Ago-2019 Created
    */
    PROCEDURE SendEmail
    IS
	
        csbMT_NAME  		VARCHAR2(70) := csbSP_NAME || 'SendEmail';
        nuErrorCode			NUMBER;
        sbErrorMessage		VARCHAR2(2000);
	
    BEGIN
	
		pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbInicio);
		
        -- Set subject
        sbSubject    :=  ' Inicia el JOB DE GENERACION DEL TRAMITE DE NOTIFICACION DE SUSPENSION X NO PRESENTAR CERTIFICADO' ||'---> Fecha: ' ||to_char(SYSDATE, 'dd/mm/yyyy HH:MI:SS am')||'. ';

        -- Get Parameter
        sbRecipients := pkg_BCLD_Parameter.fsbObtieneValorCadena('FUNC_PERIODIC_REVIEW');

        -- Evaluate is null
        IF sbRecipients IS NULL THEN
            pkg_error.setErrorMessage(pkg_error.CNUGENERIC_MESSAGE,'No esta definido el correo para el parametro FUNC_PERIODIC_REVIEW, definalos por el comando LDPAR');
        END IF;

        -- Set message
        sbMessage0 := 'Se inicio el proceso de generacion del tramite';

        -- Send email      
        pkg_Correo.prcEnviaCorreo
        (
            isbRemitente        => sbRemitente,
            isbDestinatarios    => sbRecipients,
            isbAsunto           => sbSubject,
            isbMensaje          => sbMessage0
        );        
            
		pkg_traza.trace(csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN);
		

    EXCEPTION
        WHEN pkg_error.controlled_error THEN
			pkg_error.getError(nuErrorCode,sbErrorMessage);
			pkg_traza.trace(csbMT_NAME||' '||sbErrorMessage, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_error.setError;
			pkg_error.getError(nuErrorCode,sbErrorMessage);
			pkg_traza.trace(csbMT_NAME||' '||sbErrorMessage, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
            RAISE pkg_error.controlled_error;
    END SendEmail;
    
    /*
        Metodo      :   GetParameters
        Descripcion :   Get Parameters

        Autor       :   GDC
        Fecha       :   02-Ago-2019

        Historia de Modificaciones
        Fecha       IDEntrega
        02-Ago-2019 Created
        19/03/2021  CA 472 se obtienen dos nuevos valores para las notificaciones
    */
    PROCEDURE GetParameters
    IS
	
	csbMT_NAME  		VARCHAR2(70) := csbSP_NAME || 'GetParameters';
	nuErrorCode			NUMBER;
	sbErrorMessage		VARCHAR2(2000);
    
    BEGIN
	
		pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbInicio);
		
        -- Get parameter
        nuDias := pkg_BCLD_Parameter.fnuObtieneValorNumerico('DIAS_SUSP_X_DEFECTO');

        IF nuDias IS NULL THEN
        	pkg_error.setErrorMessage(pkg_error.CNUGENERIC_MESSAGE,'No existe datos para el parametro DIAS_SUSP_X_DEFECTO, definalos por el comando LDPAR');
        END IF;

        -- Get parameter
        sbCreaSolicitud := pkg_BCLD_Parameter.fsbObtieneValorCadena('SOLICITUD_SUSP_NOTI_AUTOM');

        -- Get parameter
        nuDias_dif := pkg_BCLD_Parameter.fnuObtieneValorNumerico('NUM_DIAS_NOTIFICAR_RP');

        IF nuDias_dif IS NULL THEN
        	pkg_error.setErrorMessage(pkg_error.CNUGENERIC_MESSAGE,'No existe datos para el parametro NUM_DIAS_NOTIFICAR_RP, definalos por el comando LDPAR');
        END IF;

        -- Get parameter
        nuDias_dif_repa := pkg_BCLD_Parameter.fnuObtieneValorNumerico('NUM_DIAS_NOTIFICAR_RP_REPA');

        IF nuDias_dif_repa IS NULL THEN
        	pkg_error.setErrorMessage(pkg_error.CNUGENERIC_MESSAGE,'No existe datos para el parametro NUM_DIAS_NOTIFICAR_RP_REPA, definalos por el comando LDPAR');
        END IF;

        -- Get Parameter
        nuDias_repa_OIA := pkg_BCLD_Parameter.fnuObtieneValorNumerico('DIAS_SUSP_X_DEFECTO_OIA');

        IF nuDias_repa_OIA IS NULL THEN
        	pkg_error.setErrorMessage(pkg_error.CNUGENERIC_MESSAGE,'No existe datos para el parametro "  DIAS_SUSP_X_DEFECTO_OIA, definalos por el comando LDPAR');
        END IF;

        -- Get parameter
        nutipoCausal := pkg_BCLD_Parameter.fnuObtieneValorNumerico('TIPO_DE_CAUSAL_SUSP_ADMI');

        IF nutipoCausal IS NULL THEN
        	pkg_error.setErrorMessage(pkg_error.CNUGENERIC_MESSAGE,'No existe datos para el parametro TIPO_DE_CAUSAL_SUSP_ADMI, definalos por el comando LDPAR');
        END IF;

        -- Get parameter
        nuCausal := pkg_BCLD_Parameter.fnuObtieneValorNumerico('COD_CAUSA_SUSP_ADM_XML');

        IF nuCausal IS NULL THEN
        	pkg_error.setErrorMessage(pkg_error.CNUGENERIC_MESSAGE,'No existe datos para el parametro COD_CAUSA_SUSP_ADM_XML, definalos por el comando LDPAR');
        END IF;

        -- Get parameter
        nuOperatingUnit := pkg_BCLD_Parameter.fnuObtieneValorNumerico('ID_OPER_UNIT_LEG_OT_RP');

        IF nuOperatingUnit IS NULL THEN
        	pkg_error.setErrorMessage(pkg_error.CNUGENERIC_MESSAGE,'No existe datos para el parametro "ID_OPER_UNIT_LEG_OT_RP", definalos por el comando LDPAR separados por coma');
        END IF;

        -- Get data person id
        nuPersonId := TO_NUMBER(ldc_boutilities.fsbgetvalorcampotabla('OR_OPER_UNIT_PERSONS','OPERATING_UNIT_ID','PERSON_ID',nuoperatingunit));

        -- Get parameter
        sbFlag_inge := pkg_BCLD_Parameter.fsbObtieneValorCadena('FLAG_VAL_TRAMI_INGE');

        -- Get parameter
        sbCOD_PKG_TYPE_ID_FILTRO_SUSP := ',' || replace(pkg_BCLD_Parameter.fsbObtieneValorCadena('COD_PKG_TYPE_ID_FILTRO_SUSP'),' ' ,'')  || ',';
        
        --INICIO CA 472
        SBCOD_PKG_TYPE_ID_FILTRO   := ',' || replace(pkg_BCLD_Parameter.fsbObtieneValorCadena('COD_PKG_TYPE_ID_FILTRO'),' ' ,'')  || ',';
        NUDIASANTNOTRP  :=  pkg_BCLDC_ParaRePe.fnuObtieneValorNumerico('LDC_NUM_DIAS_ANTI_NOTIFI_RP');
        --FIN CA 472
		
		--667
		nutipoCausalrepa :=  pkg_BCLDC_ParaRePe.fnuObtieneValorNumerico('LDC_TIPO_CAUSAL_DEF_NO_REPARA');
		nuCausalrepa :=  pkg_BCLDC_ParaRePe.fnuObtieneValorNumerico('LDC_CAUSAL_DEF_NO_REPARA');
		
		pkg_traza.trace(csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN);
		
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
			pkg_error.getError(nuErrorCode,sbErrorMessage);
			pkg_traza.trace(csbMT_NAME||' '||sbErrorMessage, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_error.setError;
			pkg_error.getError(nuErrorCode,sbErrorMessage);
			pkg_traza.trace(csbMT_NAME||' '||sbErrorMessage, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
            RAISE pkg_error.controlled_error;
    END GetParameters;
    
    /*
        Metodo      :   crReportDetail
        Descripcion :   Report Detail

        Autor       :   GDC
        Fecha       :   02-Ago-2019

        Historia de Modificaciones
        Fecha       IDEntrega
        02-Ago-2019 Created
    */
    PROCEDURE crReportDetail(
        inuIdReporte    in repoinco.reinrepo%type,
        inuProduct      in repoinco.reinval1%type,
        isbError        in repoinco.reinobse%type,
        isbTipo         in repoinco.reindes1%type
    )
    IS
        -- Variables
        rcRepoinco 			repoinco%rowtype;
		csbMT_NAME  		VARCHAR2(70) := csbSP_NAME || 'crReportDetail';
       	nuErrorCode			NUMBER;
    	sbErrorMessage		VARCHAR2(2000);

		
    BEGIN
	
		pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbInicio);
		
        rcRepoinco.reinrepo := inuIdReporte;
        rcRepoinco.reinval1 := inuProduct;
        rcRepoinco.reindes1 := isbTipo;
        rcRepoinco.reinobse := isbError;
        rcRepoinco.reincodi := nuConsecutivo;
        
        -- Insert record
        pktblRepoinco.insrecord(rcRepoinco);
		
		pkg_traza.trace(csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN);
    
    EXCEPTION
	WHEN pkg_error.controlled_error THEN
		pkg_error.getError(nuErrorCode,sbErrorMessage);
		pkg_traza.trace(csbMT_NAME||' '||sbErrorMessage, cnuNVLTRC);
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);
		RAISE pkg_error.controlled_error;
	WHEN OTHERS THEN
		pkg_error.setError;
		pkg_error.getError(nuErrorCode,sbErrorMessage);
		pkg_traza.trace(csbMT_NAME||' '||sbErrorMessage, cnuNVLTRC);
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
		RAISE pkg_error.controlled_error;
    
    END;

  
    /*
        Metodo      :   Run_Process
        Descripcion :   Run Process

        Autor       :   GDC
        Fecha       :   02-Ago-2019

        Historia de Modificaciones
        Fecha        Autor         Observacion
        02-Ago-2019  Created
		    26/01/2020   HORBATH      CA 176 se llama al proceso LDC_PKGESTIONCASURP.PRINDEPRODSUCA para validar
		                              si el producto esta suspendido por cartera
        19/03/2021   ljlb         ca 472 modificar donde llama proceso GDC_BCSUSPENSION_XNO_CERT.GETPRODUCTSTONOTIFICA envie el valor de la variable SBCOD_PKG_TYPE_ID_FILTRO,
                                  y también mandar el valor de la variable NUDIASANTNOTRP
		    17/06/2021    GDC - N1    CAMBIO 783: Se colocara en comentario la logica del 472 con relacion al llamado de uno de los 
                                              2 servicios GDC_BCSuspension_XNO_Cert.GetProductsToNotifica. Para dejar solo el 
                                              servicio definido en el CAMBIO 472. Con el fin de manejar un solo paramatro de 
                                              tiempo de generacion de notificacion de suspension.
                                              
        25-09-2021  Horbath     CA667:  Se modifica para obtener la causal y tipo de causal desde otros parametros si el producto esta marcado como no reparable
    */
    PROCEDURE Run_Process (
        inuThreadNumber     in  number, -- Thread number
        inuThreadsQuantity  in  number, -- Threads Quantity
        isbProgram          in  estaprog.esprprog%type,
        inuErrorCode        in  ge_error_log.error_log_id%type,
        isbErrorMsg         in  ge_error_log.description%type
    )
    IS
        -- Variables
        sbWhat                  GE_BOUTILITIES.STYSTATEMENT;
        nuError                 ge_error_log.message_id%TYPE;
        nuThreadNumber          number;
        nuErrorCode             number;
        nuRecordsToProcess      number;
        nuTotalRecordsProcessed number := 0;
		sbProceso VARCHAR2(70) := 'JOB_SUSPENSION_XNO_CERT_GDC'||TO_CHAR(SYSDATE,'DDMMYYYYHH24MISS');
		
		--inicio ca 176
		nuEstaCorRec NUMBER;
		nuIsvalid    NUMBER;
		sbFlagSupC   VARCHAR2(1) :='N';
        --fin ca 176
		
		csbMT_NAME  	VARCHAR2(70) := csbSP_NAME || 'Run_Process';

        CURSOR cuValMinSusp (p_inuProduct_id ldc_plazos_cert.id_producto%TYPE,
                             p_plazo_min_suspension ldc_plazos_cert.plazo_min_suspension%TYPE)
        IS
        SELECT COUNT(1)
          FROM ldc_plazos_cert a
         WHERE id_producto = p_inuProduct_id
           AND plazo_min_suspension <= p_plazo_min_suspension;        

    BEGIN
    
		pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbInicio);
		
    	nuIdReporte := fnuCrReportHeader;
    	commit;
		
    	-- Start log program
		pkg_estaproc.prInsertaEstaproc(sbProceso,NULL);
	
		
    	-- Send email
        SendEmail;

        -- Get parameters
        GetParameters;

        -- Abre el CURSOR de productos a generar tramite de notificacion
        -- por marcas o por vencimiento de plazos
        tbServsusc.delete;
        nuContaNoti     := 0;
        nuTotalNoti     := 0;
        nuTotalSusp     := 0;
        nuContaSus      := 0;
        nuregeinssuspe  := 0;
        nususpencontra  := 0;

        -- Get product to suspend
        GDC_BCSuspension_XNO_Cert.GetProductsToSuspend (inuThreadNumber,
                                                        inuThreadsQuantity,
                                                        nuDias_Anti_Notf,
                                                        nuDias_repa_OIA,
                                                        nuDias,
                                                        nuDias_dif_repa,
                                                        sbCOD_PKG_TYPE_ID_FILTRO_SUSP,
                                                        tbServsusc);

        IF tbServsusc.first >= 1 THEN
    	
            -- Insert record tracking
            sbProgram := isbProgram || '_SUS-' || inuThreadNumber;

            -- Set records to process
            nuRecordsToProcess := tbServsusc.count;
            
            -- Add tracking
            pkStatusExeProgramMgr.AddRecord(sbProgram, nuRecordsToProcess, NULL);

            COMMIT;

    		FOR i IN tbServsusc.first .. tbServsusc.last LOOP
    		
                -- Set product id
                inuProduct_id         := tbServsusc(i).sesunuse;

                BEGIN

                    -- Inicia CA667
                    IF LDC_BODefectNoRepara.fsbGetMarkLock(inuProduct_id) = 'S' THEN
						nuCausTramite := nuCausalrepa;
						nutipoCauTram := nutipoCausalrepa;
					ELSE
						nuCausTramite := nuCausal;
						nutipoCauTram := nutipoCausal;
                    END IF;
                    -- Fin CA667

                    -- Count
    				nuSuspenContra := nuSuspenContra + 1;

                    -- Get suspension type
    				inuSuspension_type_id := LDCI_PKREVISIONPERIODICAWEB.fnuTipoSuspension(inuProduct_id);

                    IF sbFlag_inge = 'Y' THEN
                    
    					-- Find out if the product has certifiable engineering jobs
                        sw1 := GDC_BCSuspension_XNO_Cert.fnuInge (inuProduct_id);
                    ELSE
    					sw1 := 0;
                    
                    END IF;

    				IF sw1 = 0 THEN
    					-- Obtiene el Total de registros a procesar
    					nuTotalSusp := nuTotalSusp + 1;
    					
    					-- Get record product
						pkg_bcproducto.PRC_TraeRegistroProduct(inuProduct_id,rcProduct);
    					
    					-- Get address id
    					nuAddress_id := rcProduct.address_id; 

                        -- Get address
						rcAb_address := pkg_bcdirecciones.frcgetRecord(nuAddress_id);
						
                        -- Get Subscription id
                        nusubscriptionid     := rcProduct.subscription_id; 

                        -- Get Subscriber
                        nusubscriberid       := pkg_bccontrato.fnuidcliente(nuSUBSCRIPTIONID);

                        -- Get category
                        nuCate     := pkg_bcproducto.fnuCategoria(inuProduct_id);

                        -- Get Subcategory
                        nuSuca     := pkg_bcproducto.fnuSubCategoria(inuProduct_id);   

                        -- Get Product Status id
                        nuProduct_status_id    := rcProduct.product_status_id;

    					v_sector_operativo   := NULL;
    					v_localidad          := NULL;
    					v_departamento       := NULL;
    					v_direccion_parseada := NULL;

                        -- Get data geographic
                        GDC_BCSuspension_XNO_Cert.GetDataGeographic (
                                                    nuAddress_id,
                                                    v_sector_operativo,
                                                    v_localidad,
                                                    v_departamento,
                                                    v_direccion_parseada);

                        v_sector_operativo  := nvl(v_sector_operativo,-1);
                        v_localidad         := nvl(v_localidad,-1);
                        v_departamento      := nvl(v_departamento,-1);

    					-- Elemento de medición
    					v_medidor := NULL;
    					
    					-- Get Measurement Code
    					v_medidor := GDC_BCSuspension_XNO_Cert.fsbMeasurementCode (inuProduct_id);

    					-- Set value
    					nuExiste := 0;

    					if sbValidaSolOpe = 'N' then
    					
                            -- Evaluate if exist request
                            nuExiste := GDC_BCSuspension_XNO_Cert.fnuExistRequest(inuProduct_id,
                                                                                  sbCOD_PKG_TYPE_ID_FILTRO_SUSP);
    					else
                            if (GDC_BCSuspension_XNO_Cert.fblProdHasPackActives(inuProduct_id, sbCOD_PKG_TYPE_ID_FILTRO_SUSP)) then
                                nuExiste := 1;
                            end if;
                        
    					end if;

    					if nvl(nuExiste,0) = 0 then
                        
                            -- Calculate date
    						fecha_inicio  := SYSDATE + 1 / 24 / 60;

                            -- Create request
    						if sbCreaSolicitud = 'S' then

								--INICIO CA 176
								   sbFlagSupC :='N';
								   nuEstaCorRec := NULL;
								   nuIsvalid := NULL;
								   onuErrorCode := NULL;
								   osbErrorMessage := NULL;
								   --se valida si el producto esta suspendido por cartera
									LDC_PKGESTIONCASURP.PRINDEPRODSUCA(inuProduct_id,
																	   nuEstaCorRec,
																	   1,
																	   nuIsvalid);
												   
									 IF nuIsvalid = 0 THEN
										
										--Se marca producto 
										INSERT INTO LDC_PRODRERP(PRREPROD,  PRREFEGE, PRREPROC)
										  VALUES (inuProduct_id, SYSDATE, 'N');
										COMMIT;
										sbFlagSupC := 'S';
									 ELSIF nuIsvalid > 0 THEN 
									    sbFlagSupC := 'S';
									 END IF;
								
								
								IF sbFlagSupC = 'N' THEN
									-- FIN CA 176
									IF  sbValidaAcom = 'S' THEN
									
										-- Get Request Acom Fall
										nuCantAcome := GDC_BCSuspension_XNO_Cert.fnuAcometidFall (inuProduct_id, sbCausal);

										if nuCantAcome > 0 then
											sbGeneraSol := 'N';
										else
											sbGeneraSol := 'S';
										end if;
									else
										sbGeneraSol := 'S';
									
									end if;
									
									
									IF sbGeneraSol = 'S'THEN
									
									
									    
                                            -- Build XML
    										sbRequestXML1 := fsbBuildXML(nuSUBSCRIBERId,
    																	 sbComment,
    																	 inuProduct_id,
    																	 fecha_inicio,
    																	 inuSUSPENSION_TYPE_ID,
    																	 nutipoCauTram,
    																	 nuCausTramite);

    										-- Register Request
    										api_registerrequestbyxml(sbRequestXML1,
    																  nuPackage_id,
    																  nuMotiveId,
    																  onuErrorCode,
    																  osbErrorMessage);

    										IF onuErrorCode <> 0 THEN
    											ROLLBACK;
    											pkg_error.setErrorMessage(onuErrorCode,osbErrorMessage);
    										ELSE
    											nuContaSus := nuContaSus + 1;
    											COMMIT;
    										END IF;									
									END IF;
							    END IF;
    						END IF;
    					end if;
    				END IF;
    			EXCEPTION
                    WHEN OTHERS THEN
                        rollback;
						pkg_error.setError;
    					pkg_error.getError(onuErrorCode, sbError);
    					nuConsecutivo := nuConsecutivo +1;
    					sbError := substr(sbError,1,4000);
    					crReportDetail(nuIdReporte,inuProduct_id,sbError, 'S');
    					commit;
    			END;
    			
    			-- Calculate records processed
    			nuTotalRecordsProcessed := nuTotalRecordsProcessed + 1;

    			-- Update tracking
    			pkStatusExeProgramMgr.UpStatusExeProgramAT( sbProgram,'Procesando producto ... ' || inuProduct_id,
                                                            nuRecordsToProcess,
                                                            nuTotalRecordsProcessed);
            
    		END LOOP;
        
    	END IF;

    	-- Set message
    	sbmensa := 'Total suspensiones encontradas : '||to_char(nususpencontra)||' total primer filtro : '||to_char(nuTotalSusp)||' total activas y registradas : '||to_char(nuContaSus);

		pkg_estaproc.prActualizaAvance(sbProceso, sbmensa, nuTotalSusp,nususpencontra);

    	nuRegeInsNotif             := 0;
    	nuTotalEncontranot         := 0;
    	nuTotalRecordsProcessed    := 0;

    	-- Delete table pl
    	tbServsusc.delete;
       --INICIO CA 472
       --Inicio CAMBIO 783 Colocar en comentario la logica del caso 472 y dejar el llamado de 
       --                  un solo servicio GDC_BCSuspension_XNO_Cert.GetProductsToNotifica activo.
        -- Get records to notifica
        GDC_BCSuspension_XNO_Cert.GetProductsToNotifica(inuThreadNumber,
                                                        inuThreadsQuantity,
                                                        NUDIASANTNOTRP,
                                                        nuDias_repa_OIA,
                                                        nuDias,
                                                        nuDias_dif_repa,
                                                        SBCOD_PKG_TYPE_ID_FILTRO,
                                                        tbServsusc);
      --Fin CAMBIO 783
      --FIN CA 472
    	IF tbServsusc.first >= 1 THEN
        
            -- Insert record tracking
            sbProgram := isbProgram || '_NOT-' || inuThreadNumber;

            -- Set records to process
            nuRecordsToProcess := tbServsusc.count;

            -- Add tracking
            pkStatusExeProgramMgr.AddRecord(sbProgram, nuRecordsToProcess, NULL);

    		COMMIT;

            FOR i IN tbServsusc.first .. tbServsusc.last LOOP
            
                BEGIN
    				nutotalencontranot := nutotalencontranot + 1;

                    -- Obtiene datos del producto a procesar
    				inuProduct_id := tbServsusc(i).sesunuse;

    				IF sbFlag_inge = 'Y' THEN
                        -- Find out if the product has certifiable engineering jobs
                        sw1 := GDC_BCSuspension_XNO_Cert.fnuInge (inuProduct_id);
    				ELSE
    					sw1 := 0;
    				END IF;

    				IF sw1 = 0 THEN
    					-- Obtiene el Total de registros a procesar
    					nuTotalNoti := nuTotalNoti + 1;

    					-- Get record product
    					pkg_bcproducto.PRC_TraeRegistroProduct(inuProduct_id,rcProduct);

                        --  busco el address_id del producto
    					nuAddress_id := rcProduct.address_id; 

                        -- Get address
						
						rcAb_address := pkg_bcdirecciones.frcgetRecord(nuAddress_id);
						
                        -- Get Subscription id
                        nuSubscriptionId     := rcProduct.subscription_id; 

                        -- Get Subscriber
                        nuSubscriberid       := pkg_bccontrato.fnuidcliente(nuSubscriptionId);

                        -- Get category
                        nuCate     := pkg_bcproducto.fnuCategoria(inuProduct_id);  

                        -- Get Subcategory
                        nuSuca     := pkg_bcproducto.fnuSubCategoria(inuProduct_id);  

                        -- Get Product Status id
                        nuProduct_status_id    := rcProduct.product_status_id;
                        
                        nuProduct_status_id   := NULL;

                        inuSUSPENSION_TYPE_ID := null;

                        inuSUSPENSION_TYPE_ID := LDCI_PKREVISIONPERIODICAWEB.fnuTipoSuspension(inuProduct_id);

    					v_sector_operativo   := NULL;
    					v_localidad          := NULL;
    					v_departamento       := NULL;
    					v_direccion_parseada := NULL;

                        -- Get data geographic
                        GDC_BCSuspension_XNO_Cert.GetDataGeographic (
                                                    nuAddress_id,
                                                    v_sector_operativo,
                                                    v_localidad,
                                                    v_departamento,
                                                    v_direccion_parseada);

                        v_sector_operativo  := nvl(v_sector_operativo,-1);
                        v_localidad         := nvl(v_localidad,-1);
                        v_departamento      := nvl(v_departamento,-1);
                        
    					-- Get Measurement Code
    					v_medidor := GDC_BCSuspension_XNO_Cert.fsbMeasurementCode (inuProduct_id);

                        -- Verify Min Susp
    					BEGIN
                            OPEN cuValMinSusp(inuProduct_id, SYSDATE + nuDias_Anti_Notf) ;
                            FETCH cuValMinSusp INTO nuOk;
                            CLOSE cuValMinSusp;
                        EXCEPTION WHEN OTHERS THEN 
                            nuOk:= NULL;
                            CLOSE cuValMinSusp;
                        END; 

    					IF nuOk <> 0 THEN
    						sbis_notif := 'YV';
    					ELSE
    						sbis_notif := 'YR';
    					END IF;

    					IF sbCreaSolicitud = 'S' THEN
                            UPDATE ldc_plazos_cert
    						SET    is_notif = sbis_notif
    						WHERE  id_producto = inuProduct_id;
    					END IF;

    					IF sbcreasolicitud = 'S' THEN                        
                            -- Build XML notificacion suspension
                            sbRequestXML1 := fsbBuildXMLSusp(nuSubscriberId,
                                                             sbComment,
                                                             inuProduct_id,
                                                             nuSubscriptionID,
                                                             rcAb_address.ADDRESS,
                                                             rcAb_address.ADDRESS_ID,
                                                             rcAb_address.GEOGRAP_LOCATION_ID,
                                                             nuCate,
                                                             nuSuca);

                            -- Register Request
    						api_registerrequestbyxml(sbRequestXML1,nuPackage_id,nuMotiveId,onuErrorCode,osbErrorMessage);

    						IF onuErrorCode <> 0 THEN
    							ROLLBACK;
    							pkg_error.setErrorMessage(onuErrorCode,osbErrorMessage);
    						ELSE
    							nuContaNoti := nuContaNoti + 1;
    							COMMIT;
    						END IF;
    					END IF;
    				END IF;
    			EXCEPTION
    				WHEN OTHERS THEN
    					rollback;
						pkg_error.setError;
    				    pkg_error.getError(onuErrorCode, sbError);
    					nuConsecutivo := nuConsecutivo +1;
    					sbError :=substr(sbError,1,4000);
    					crReportDetail(nuIdReporte,inuProduct_id,sbError, 'N');
    					commit;
    			END;
    			
    			-- Calculate records processed
    			nuTotalRecordsProcessed := nuTotalRecordsProcessed + 1;

    			-- Update tracking
    			pkStatusExeProgramMgr.UpStatusExeProgramAT( sbProgram,'Procesando producto ... ' || inuProduct_id,
                                                            nuRecordsToProcess,
                                                            nuTotalRecordsProcessed);
    		END LOOP;
    	END IF;

        -- Set message
    	sbmensa := sbmensa||' Total notificaciones encontradas : '||to_char(nutotalencontranot)||' total primer filtro : '||to_char(nuTotalNoti)||' total activas y registradas : '||to_char(nuContaNoti);
    	
		pkg_estaproc.prActualizaAvance(sbProceso, sbmensa, nuTotalNoti,nutotalencontranot);
		
        -- Accumulate total
    	nuTotal    := nuTotalSusp + nuTotalNoti;

        -- Set subject
    	sbSubject  := ' Termino el JOB DE GENERACION DEL TRAMITE DE NOTIFICACION DE SUSPENSION X NO PRESENTAR CERTIFICADO' ||'---> Fecha: ' || to_char(SYSDATE, 'dd/mm/yyyy HH:MI:SS am')||'. ';

        -- Set message
    	sbMessage0 := 'Termino el proceso ' || '<br>' ||'Total registro procesados = ' || nuTotal || '<br>' ||'Total notificaciones generadas = ' || nuContaNoti ||'<br>' || 'Total Suspensiones generadas = ' ||nuContaSus || '<br>' || '<br>' || '<br>';

    	-- Send approval or rejection email
        pkg_Correo.prcEnviaCorreo
        (
            isbRemitente        => sbRemitente,
            isbDestinatarios    => sbRecipients,
            isbAsunto           => sbSubject,
            isbMensaje          => sbMessage0
        );
    	

    	--200-2487
    	IF nuregeinssuspe >= 1 THEN
    		nuContaSus := nuregeinssuspe;
    	END IF;
    	IF nuregeinsnotif >= 1 THEN
    		nuContaNoti := nuregeinsnotif;
    	END IF;

		pkg_estaproc.prActualizaEstaproc(sbProceso,' Ok',sbmensa);
		
		pkg_traza.trace(csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN);

    	COMMIT;
		
    EXCEPTION
    	WHEN pkg_error.controlled_error THEN
			pkg_error.getError(onuErrorCode,osbErrorMessage);
    		sbmensa := to_char(onuErrorCode)||' '||osbErrorMessage;
			pkg_estaproc.prActualizaEstaproc(sbProceso,' Error',sbmensa);
			pkg_traza.trace(csbMT_NAME||' '||osbErrorMessage, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);
    		COMMIT;
    		RAISE pkg_error.controlled_error;
    	WHEN OTHERS THEN
            pkg_error.setError;
			pkg_error.getError(onuErrorCode,osbErrorMessage);
			pkg_estaproc.prActualizaEstaproc(sbProceso,' Error',osbErrorMessage);
			pkg_traza.trace(csbMT_NAME||' '||osbErrorMessage, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
    		COMMIT;
    		RAISE pkg_error.controlled_error;

    END Run_Process;

END GDC_BOSuspension_XNO_Cert;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('GDC_BOSUSPENSION_XNO_CERT', 'ADM_PERSON');
END;
/
