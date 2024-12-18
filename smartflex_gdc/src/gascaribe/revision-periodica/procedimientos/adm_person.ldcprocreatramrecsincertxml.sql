create or replace PROCEDURE adm_person.ldcprocreatramrecsincertxml(nuorden or_order.order_id%TYPE) IS
/**************************************************************************
Propiedad Intelectual de Gases del caribe S.A E.S.P

Funcion     : ldcprocreatramrecsincertxml
Descripcion : Procedimiento que crea el tramite reconexi?n sin certificaci?n por medio de XML
Autor       : John Jairo Jimenez Marimon
Fecha       : 05-05-2017

Historia de Modificaciones
Fecha               Autor                Modificacion
=========           =========          ====================
27/10/2023			jsoto			   OSF-1843 Se cambio el manejo de trazas y errores por objetos personalizados
									   Se cambia el llamado a registro armado y solicitud por XML a objetos personalizados
09/05/2024          Paola Acosta       OSF-2672: Cambio de esquema ADM_PERSON                                        
**************************************************************************/

    csbMT_NAME 	CONSTANT VARCHAR2(35):= 'ldcprocreatramrecsincertxml';
    cnuNVLTRC 	CONSTANT NUMBER := pkg_traza.cnuNivelTrzDef;
	csbInicio   CONSTANT VARCHAR2(35) := pkg_traza.fsbINICIO;


CURSOR cusolicitudesabiertas(nucuproducto pr_product.product_id%TYPE) IS
   SELECT pv.package_id colsolicitud
     FROM mo_packages pv,mo_motive mv
    WHERE pv.package_type_id IN
						   (SELECT regexp_substr(dald_parameter.fsbgetvalue_chain('VAL_TRAMITES_NUEVOS_FLUJOS',NULL), '[^,]+', 1, LEVEL)AS tipopaq
							FROM dual
						    CONNECT BY regexp_substr(dald_parameter.fsbgetvalue_chain('VAL_TRAMITES_NUEVOS_FLUJOS', NULL), '[^,]+', 1, LEVEL) IS NOT NULL)
      AND pv.motive_status_id = dald_parameter.fnuGetNumeric_Value('ESTADO_SOL_REGISTRADA')
      AND mv.product_id       = nucuproducto
      AND pv.package_id       = mv.package_id;

--Cursor que obtiene el producto, el contrato del producto y el tipo de trabajo de acuerdo a la orden instanciada
CURSOR cuProducto(nucuorden NUMBER) IS
  SELECT product_id, subscription_id, oa.task_type_id,oa.package_id,oa.subscriber_id,ot.operating_unit_id,m.motive_status_id estado_sol
     FROM or_order ot, or_order_activity oa left join mo_packages m on oa.package_id = m.package_id
    WHERE oa.order_id = nucuorden
      AND oa.order_id = ot.order_id
      AND rownum   = 1;
-- Cursor para obtener los componentes asociados a un motivo
CURSOR cuComponente(nucumotivos mo_motive.motive_id%TYPE) IS
 SELECT COUNT(1)
   FROM mo_component C
  WHERE c.package_id = nucumotivos;
  
  
CURSOR cuDatosVisita(inuProducto pr_product.product_id%TYPE) IS
        SELECT di.address_parsed
              ,di.address_id
              ,di.geograp_location_id
              ,pr.category_id
              ,pr.subcategory_id
          FROM pr_product pr,ab_address di
         WHERE pr.product_id = inuProducto
           AND pr.address_id = di.address_id;

sbrequestxml1       constants_per.tipo_xml_sol%TYPE;
nupackageid         mo_packages.package_id%TYPE;
numotiveid          mo_motive.motive_id%TYPE;
nuerrorcode         NUMBER;
sberrormessage      VARCHAR2(10000);
nucont              NUMBER(4);
rcComponent         damo_component.stymo_component;
rcmo_comp_link      damo_comp_link.stymo_comp_link;
nunumber            NUMBER(4) DEFAULT 0;
nuprodmotive        mo_component.prod_motive_comp_id%TYPE;
sbtagname           mo_component.tag_name%TYPE;
nuclasserv          mo_component.class_service_id%TYPE;
nucomppadre         mo_component.component_id%TYPE;
nuparano            NUMBER(4);
nuparmes            NUMBER(2);
nutsess             NUMBER;
sbparuser           VARCHAR2(30);
sbmensa             VARCHAR2(10000);
nupakageid          mo_packages.package_id%TYPE;
nucliente           ge_subscriber.subscriber_id%TYPE;
numediorecepcion    mo_packages.reception_type_id%TYPE;
sbdireccionparseada ab_address.address_parsed%TYPE;
nudireccion         ab_address.address_id%TYPE;
nulocalidad         ab_address.geograp_location_id%TYPE;
nucategoria         mo_motive.category_id%TYPE;
nusubcategori       mo_motive.subcategory_id%TYPE;
sbComment           VARCHAR2(2000);
nuProductId         NUMBER;
nuContratoId        NUMBER;
nuTaskTypeId        NUMBER;
sw                  NUMBER(2) DEFAULT 0;
sbflag              VARCHAR2(1);
nuunidadoperativa   or_order.operating_unit_id%TYPE;
nuestadosolicitud   mo_packages.motive_status_id%TYPE;
sbsolicitudes       VARCHAR2(1000);
nucausalid   ge_causal.causal_id%TYPE;
sbTipoSuspension NUMBER;
sbProceso			VARCHAR2(70):= 'LDCPROCREATRAMRECSINCERTXML'||TO_CHAR(SYSDATE,'DDMMYYYYHH24MISS');

BEGIN

 pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbInicio);
 
 -- Inicializamos el proceso
 pkg_estaproc.prInsertaEstaproc(sbProceso,NULL);
 
 pkg_traza.trace('Numero de la Orden:'||nuorden, cnuNVLTRC);
 -- obtenemos el producto y el paquete
    OPEN cuproducto(nuorden);
   FETCH cuProducto INTO nuproductid, nucontratoid, nutasktypeid,nupakageid,nucliente,nuunidadoperativa,nuestadosolicitud;
      IF cuProducto%NOTFOUND THEN
         sbmensa := 'Proceso termino con errores : '||'El cursor cuProducto no arrojo datos con el # de orden'||to_char(nuorden);
         pkg_estaproc.prActualizaEstaproc(sbProceso,'Ok',sbmensa);
         pkg_error.setErrorMessage(ld_boconstans.cnugeneric_error,sbmensa);
         RAISE pkg_error.controlled_error;
     END IF;
   CLOSE cuproducto;
   pkg_traza.trace('Salio cursor cuProducto, nuProductId: '||nuProductId||'nuContratoId:'||'nuTaskTypeId:'||nuTaskTypeId, cnuNVLTRC);
   nucausalid    := pkg_bcordenes.fnuobtienecausal(nuorden);
  -- Actualizamos las solicitud que se esta legalizando para que no salga como pendiente
  IF nuestadosolicitud = 13 THEN
   UPDATE mo_packages m
      SET m.motive_status_id = 14
    WHERE m.package_id       = nupakageid;
  END IF;
  -- Buscamos solicitudes de revisi?n periodica generadas
  sbsolicitudes := NULL;
  FOR i IN cusolicitudesabiertas(nuproductid) LOOP
   IF sbsolicitudes IS NULL THEN
    sbsolicitudes := i.colsolicitud;
   ELSE
    sbsolicitudes := sbsolicitudes||','||to_char(i.colsolicitud);
   END IF;
  END LOOP;
    IF TRIM(sbsolicitudes) IS NULL THEN
       -- Obtenemos los datos de la solicitud de visita de verificacion para generar el tramite de defecto critico
       sbdireccionparseada := NULL;
       nudireccion         := NULL;
       nulocalidad         := NULL;
       nucategoria         := NULL;
       nusubcategori       := NULL;
       sw                  := 1;
       BEGIN
	    
		IF cuDatosVisita%ISOPEN THEN
			CLOSE cuDatosVisita;
		END IF;

		OPEN cuDatosVisita(nuproductid);
		FETCH cuDatosVisita INTO sbdireccionparseada,nudireccion,nulocalidad,nucategoria,nusubcategori;
		IF cuDatosVisita%NOTFOUND THEN
			CLOSE cuDatosVisita;
			RAISE no_data_found;
        END IF;
		CLOSE cuDatosVisita;
	   
       EXCEPTION
        WHEN no_data_found THEN
             sw := 0;
       END;
       IF sw = 1 THEN
        -- Construimos el XML para generar la ord?n de reconexi?n sin certificaci?n
        sbcomment        :=substr(ldc_retornacomentotlega(nuorden),1,1980)||' orden legalizada : '||to_char(nuorden)||' con causal : '||to_char(nucausalid);
        numediorecepcion := dald_parameter.fnuGetNumeric_Value('MEDIO_RECEPCION_RECO_SIN_CERT');
		sbTipoSuspension := -1;
		
		sbrequestxml1 := pkg_xml_soli_rev_periodica.getXMSolicitudReconexionRp(
																				numediorecepcion,
																				sbcomment,
																				nuproductid,
																				nucliente,
																				sbTipoSuspension
																				);
		
        -- Procesamos el XML y generamos la solicitud
        api_registerRequestByXml(
                                  sbrequestxml1,
                                  nupackageid,
                                  numotiveid,
                                  nuerrorcode,
                                  sberrormessage
                                 );
       IF nupackageid IS NULL THEN
          sbmensa := 'Proceso termino con errores : '||'Error al generar la solicitud. Codigo error : '||to_char(nuerrorcode)||' Mensaje de error : '||sberrormessage;
		  pkg_estaproc.prActualizaEstaproc(sbProceso,'Ok',sbmensa);
          pkg_error.setErrorMessage(ld_boconstans.cnugeneric_error,sbmensa);
          RAISE pkg_error.controlled_error;
       ELSE
          -- Dejamos la solicitud como estaba
        IF nuestadosolicitud = 13 THEN
          UPDATE mo_packages m
             SET m.motive_status_id = 13
           WHERE m.package_id       = nupakageid;
        END IF;
        sbmensa := 'Proceso termino Ok. Se genero la solicitud Nro : '||to_char(nupackageid);
		pkg_estaproc.prActualizaEstaproc(sbProceso,'Ok',sbmensa);
        sbflag := ldc_fsbretornaaplicaasigauto(nutasktypeid,-1);
        IF nvl(sbflag,'N') = 'S' THEN
          ldc_procrearegasiunioprevper(nuunidadoperativa,nuproductid,nutasktypeid,nuorden,nupackageid);
        END IF;
       END IF;
       -- Consultamos si el motivo generado tiene asociado los componentes
        OPEN cuComponente(numotiveid);
       FETCH cuComponente INTO nucont;
       CLOSE cuComponente;
       -- Si el motivo no tine los componentes asociados, se procede a registrarlos
       IF (nucont=0)THEN
        FOR i IN (
                  SELECT kl.*,mk.package_id solicitud,mk.subcategory_id subcategoria
                    FROM mo_motive mk,pr_component kl
                   WHERE mk.motive_id = numotiveid
                     AND kl.component_status_id <> 9
                     AND mk.product_id = kl.product_id
                   ORDER BY kl.component_type_id
                  ) LOOP
         IF i.component_type_id = 7038 THEN
            nunumber     := 1;
            nuprodmotive := 10346;
            sbtagname    := 'C_GAS_10346';
            nuclasserv   := NULL;
         ELSIF i.component_type_id = 7039 THEN
            nunumber     := 2;
            nuprodmotive := 10348;
            sbtagname    := 'C_MEDICION_10348';
            nuclasserv   := 3102;
         END IF;
         rcComponent.component_id         := mo_bosequences.fnugetcomponentid();
         rcComponent.component_number     := nunumber;
         rcComponent.obligatory_flag      := 'N';
         rcComponent.obligatory_change    := 'N';
         rcComponent.notify_assign_flag   := 'N';
         rcComponent.authoriz_letter_flag := 'N';
         rcComponent.status_change_date   := SYSDATE;
         rcComponent.recording_date       := SYSDATE;
         rcComponent.directionality_id    := 'BI';
         rcComponent.custom_decision_flag := 'N';
         rcComponent.keep_number_flag     := 'N';
         rcComponent.motive_id            := numotiveid;
         rcComponent.prod_motive_comp_id  := nuprodmotive;
         rcComponent.component_type_id    := i.component_type_id;
         rcComponent.motive_type_id       := 75;
         rcComponent.motive_status_id     := 15;
         rcComponent.product_motive_id    := 100304;
         rcComponent.class_service_id     := nuclasserv;
         rcComponent.package_id           := nupackageid;
         rcComponent.product_id           := i.product_id;
         rcComponent.service_number       := i.product_id;
         rcComponent.component_id_prod    := i.component_id;
         rcComponent.uncharged_time       := 0;
         rcComponent.product_origin_id    := i.product_id;
         rcComponent.quantity             := 1;
         rcComponent.tag_name             := sbtagname;
         rcComponent.is_included          := 'N';
         rcComponent.category_id          := i.category_id;
         rcComponent.subcategory_id       := i.subcategoria;
         damo_component.Insrecord(rcComponent);
         IF i.component_type_id = 7038 THEN
          nucomppadre :=  rcComponent.component_id;
         END IF;
         IF(nuMotiveId IS NOT NULL)THEN
           rcmo_comp_link.child_component_id  := rcComponent.component_id;
           IF i.component_type_id = 7039 THEN
              rcmo_comp_link.father_component_id := nucomppadre;
           ELSE
              rcmo_comp_link.father_component_id := NULL;
           END IF;
           rcmo_comp_link.motive_id           := nuMotiveId;
           damo_comp_link.insrecord(rcmo_comp_link);
         END IF;
        END LOOP;
       END IF;
     ELSE
      sbmensa := 'Proceso termino con errores : '||'No se encontraron datos de la solicitud asociada a la orden # '||to_char(nuorden);
      pkg_estaproc.prActualizaEstaproc(sbProceso,'Ok',sbmensa);
      pkg_error.setErrorMessage(ld_boconstans.cnugeneric_error,sbmensa);
      RAISE pkg_error.controlled_error;
     END IF;
    ELSE
     sbmensa := 'Proceso termino. : El producto : '||to_char(nuproductid)||' ya tiene una solicitud de reconexi?n sin certificaci?n en estado registrada.';
     pkg_estaproc.prActualizaEstaproc(sbProceso,'Ok',sbmensa);
	 pkg_error.setErrorMessage(ld_boconstans.cnugeneric_error,sbmensa);
     RAISE pkg_error.controlled_error;
    END IF;
	
	pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
	
EXCEPTION
 WHEN pkg_error.controlled_error THEN
  pkg_traza.trace(csbMT_NAME, cnuNVLTRC,pkg_traza.fsbFIN_ERC); 
  RAISE;
 WHEN OTHERS THEN
  sbmensa := 'Proceso termino con Errores. '||SQLERRM;
  pkg_estaproc.prActualizaEstaproc(sbProceso,'Ok',sbmensa);
  pkg_error.setError;
  pkg_traza.trace(csbMT_NAME||' :'||sbmensa, cnuNVLTRC); 
  pkg_traza.trace(csbMT_NAME, cnuNVLTRC,pkg_traza.fsbFIN_ERR); 
  RAISE pkg_error.controlled_error;
END LDCPROCREATRAMRECSINCERTXML;
/
PROMPT Otorgando permisos de ejecucion a LDCPROCREATRAMRECSINCERTXML
BEGIN
    pkg_utilidades.praplicarpermisos('LDCPROCREATRAMRECSINCERTXML', 'ADM_PERSON');
END;
/

PROMPT Otorgando permisos de ejecucion sobre LDCPROCREATRAMRECSINCERTXML para reportes
GRANT EXECUTE ON adm_person.LDCPROCREATRAMRECSINCERTXML TO rexereportes;
/