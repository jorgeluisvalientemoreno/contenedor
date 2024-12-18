create or replace PROCEDURE ldcproccreatramirepprptxml AS
    /**************************************************************************
    Propiedad Intelectual de Gases del caribe S.A E.S.P

    Funcion     : ldcproccreatramirepprptxml
    Descripcion : Procedimiento que crea el tramite de reparacion por revision periodica por medio de XML
    Autor       : John Jairo Jimenez Marimon
    Fecha       : 06-01-2017

    Historia de Modificaciones
      Fecha               Autor                Modificacion
    =========           =========          ====================
    09-01-2018          HORBATH            200-1638
    12/03/2018          jbrito             CASO 200-1743 Se anula el condicional que valida la fecha mínima de revisión sea mayor a la fecha  actual
    06/04/2018          HORBATH.           200-1871.SE MODIFICA EL XML DE LAS REPARACIONES Y CERTIFICACIONES.
                                           SE CAMBIA EL TAG <PRODUCTO> POR <PRODUCT>
    25/05/2018          Jbrito             caso 200-1956 Se elimino La actualización de la marca después de la generación del trámite
    27/07/2018          lsalazar           Caso 200-2063 Cambio Alcance (Agregar comentario de la orden padre al inicio del comentario del tramite a generar)
    24/08/2018          lsalazar           Caso 200-2094 Se concatena parametro LDCPARCASOPEN a la observacion de la solicitud a crear
	  31/08/2018		      dsaltarin		       Caso 200-2094 agregar <?xml version="1.0" encoding="ISO-8859-1"?>
    30/11/2023          Adrianavg          OSF-1849: Se ajusta cursor cusolicitudesabiertas, se reemplaza ldc_boutilities.splitstrings por regexp_substr
                                           y se retira el esquema OPEN antepuedto a la funcion dald_parameter.fsbgetvalue_chain y ldc_boutilities.splitstrings
                                           Se reemplaza el tipo de dato de la variable sbrequestxml1 VARCHAR2(32767) por constants_per.tipo_xml_sol%TYPE;
                                           Se declaran Variables para gestión de traza
                                           Se retira la consulta de datos para inicializar el proceso y las variables nuparano, nuparmes, nutsess, sbparuser
                                           Se reemplaza ldc_proinsertaestaprog por PKG_ESTAPROC.PRINSERTAESTAPROC(sbproceso, NULL)
                                           Se reemplaza or_bolegalizeorder.fnuGetCurrentOrder por PKG_BCORDENES.FNUOBTENEROTINSTANCIALEGAL
                                           Se reemplaza or_boorder.fnugetordercausal(nuorden) por PKG_BCORDENES.FNUOBTIENECAUSAL
                                           Se retira el esquema OPEN antepuesto a or_order, mo_packages, ldc_plazos_cert
                                           Se reemplaza ldc_proactualizaestaprog por PKG_ESTAPROC.PRACTUALIZAESTAPROC
                                           Se reemplaza GE_BOERRORS.SETERRORCODEARGUMENT por PKG_ERROR.SETERRORMESSAGE
                                           Se reemplaza pkg_error.cnugeneric_message por pkg_error.cnugeneric_message
                                           Se reemplaza pkg_error.controlled_error por pkg_error.controlled_error
                                           Se reemplaza armado del XML P_SOLICITUD_REPARACION_PRP_100294 por pkg_xml_soli_rev_periodica.getSolicitudReparacionRp
                                           Se reemplaza os_registerrequestwithxml por API_RegisterRequestByXML
                                           Se reemplaza errors.seterror por pkg_error.seterror;
                                           Se añade pkg_Error.getError(nuErrorCode, sbErrorMessage) en la exception
                                           Se retira la variable ex_error declarada sin uso
   **************************************************************************/
   CURSOR cusolicitudesabiertas(nucuproducto pr_product.product_id%TYPE) IS
   SELECT pv.package_id colsolicitud
     FROM mo_packages pv,mo_motive mv
    WHERE pv.package_type_id  IN (SELECT to_number(column_value)
                                    FROM ( SELECT regexp_substr(dald_parameter.fsbgetvalue_chain('VAL_TRAMITES_NUEVOS_FLUJOS',NULL), '[^,]+', 1, level) AS column_value
                                    FROM  dual
                              CONNECT BY regexp_substr(dald_parameter.fsbgetvalue_chain('VAL_TRAMITES_NUEVOS_FLUJOS',NULL), '[^,]+', 1, level) IS NOT NULL )
                                     )
      AND pv.motive_status_id = dald_parameter.fnuGetNumeric_Value('ESTADO_SOL_REGISTRADA')
      AND mv.product_id       = nucuproducto
      AND pv.package_id       = mv.package_id;

    nuErrorCode         NUMBER;
    sbErrorMessage      VARCHAR2(4000);
    nuPackageId         mo_packages.package_id%TYPE;
    nuMotiveId          mo_motive.motive_id%TYPE;
    sbrequestxml1       constants_per.tipo_xml_sol%TYPE;
    nuorden             or_order.order_id%TYPE;
    sbComment           VARCHAR2(2000);
    nuProductId         NUMBER;
    nuContratoId        NUMBER;
    nuTaskTypeId        NUMBER;
    nuCausalOrder       NUMBER; 
    nupakageid          mo_packages.package_id%TYPE;
    nucliente           ge_subscriber.subscriber_id%TYPE;
    numediorecepcion    mo_packages.reception_type_id%TYPE;
    sbdireccionparseada ab_address.address_parsed%TYPE;
    nudireccion         ab_address.address_id%TYPE;
    nulocalidad         ab_address.geograp_location_id%TYPE;
    nucategoria         mo_motive.category_id%TYPE;
    nusubcategori       mo_motive.subcategory_id%TYPE;
    sw                  NUMBER(2) DEFAULT 0;    
    sbmensa             VARCHAR2(10000);
    numarca             ld_parameter.numeric_value%TYPE;
    numarcaantes        ldc_marca_producto.suspension_type_id%TYPE;
    nucontacomponentes  NUMBER(4);
    nunumber            NUMBER(4) DEFAULT 0;
    nuprodmotive        mo_component.prod_motive_comp_id%TYPE;
    sbtagname           mo_component.tag_name%TYPE;
    nuclasserv          mo_component.class_service_id%TYPE;
    nucomppadre         mo_component.component_id%TYPE;
    rcComponent         damo_component.stymo_component;
    rcmo_comp_link      damo_comp_link.stymo_comp_link;
    dtplazominrev       ldc_plazos_cert.plazo_min_revision%TYPE;
    sbsolicitudes       VARCHAR2(1000);
    sbflag              VARCHAR2(1);
    nuunidadoperativa   or_order.operating_unit_id%TYPE;
    
    --Cursor que obtiene el producto, el contrato del producto y el tipo de trabajo de acuerdo a la orden instanciada
   CURSOR cuProducto(nuorden NUMBER) IS
   SELECT product_id, subscription_id, ot.task_type_id,package_id,at.subscriber_id,ot.operating_unit_id
     FROM or_order_activity at, or_order ot
    WHERE at.order_id = nuorden
      AND package_id IS NOT NULL
      AND at.order_id = ot.order_id
      AND ROWNUM   = 1;
     
   -- Cursor para obtener los componentes asociados a un motivo
   CURSOR cuComponente(nucumotivos mo_motive.motive_id%TYPE) IS
   SELECT COUNT(1)
     FROM mo_component C
    WHERE c.motive_id = nucumotivos;
   
   --obtener datos de tramite defecto critico
   CURSOR cuDatosTramiteDefec(p_nuproductid pr_product.product_id%TYPE )
   IS
   SELECT di.address_parsed
         ,di.address_id
         ,di.geograp_location_id
         ,pr.category_id
         ,pr.subcategory_id 
    FROM pr_product pr, ab_address di
   WHERE pr.product_id = nuproductid
     AND pr.address_id = di.address_id;
     
   ---Obtiene el plazo minimo de revision
    CURSOR cuPlazoMinRevision(p_nuProductId ldc_plazos_cert.id_producto%TYPE)
    IS
    SELECT pc.plazo_min_revision
      FROM ldc_plazos_cert pc
     WHERE pc.id_producto = p_nuProductId
       AND ROWNUM = 1;    
    
    --Variables para gestión de traza
    csbMetodo      CONSTANT VARCHAR2(32) := $$PLSQL_UNIT||'.';
    csbNivelTraza  CONSTANT NUMBER(2)    := pkg_traza.cnuNivelTrzDef;
    sbproceso      VARCHAR2(100 BYTE) :=  SUBSTR(csbMetodo, 1, (INSTR(csbMetodo, '.', 1))-1)||TO_CHAR(SYSDATE,'DDMMYYYYHH24MISS');    
    sbNameproceso  sbproceso%type;   
BEGIN
 
  pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
  -- Inicializamos el proceso
  sbNameproceso:= sbproceso;-- para que capture una sola vez el DDMMYYYYHH24MISS
  PKG_ESTAPROC.PRINSERTAESTAPROC(sbNameproceso, NULL);
  
  --Obtener el identificador de la orden  que se encuentra en la instancia
  nuorden       := PKG_BCORDENES.FNUOBTENEROTINSTANCIALEGAL;
  nucausalorder := PKG_BCORDENES.FNUOBTIENECAUSAL(nuorden);
  pkg_traza.trace(csbMetodo||' Numero de la Orden: '||nuorden , csbNivelTraza);
  pkg_traza.trace(csbMetodo||' Numero causal de la Orden: '||nucausalorder , csbNivelTraza);

  -- obtenemos el producto y el paquete
    OPEN cuproducto(nuorden);
   FETCH cuProducto INTO nuproductid, nucontratoid, nutasktypeid,nupakageid,nucliente,nuunidadoperativa;
      IF cuProducto%NOTFOUND THEN
         sbmensa := 'Proceso termino con errores : '||'El cursor cuProducto no arrojo datos con el # de orden'||TO_CHAR(nuorden);
         PKG_ESTAPROC.PRACTUALIZAESTAPROC(sbNameproceso, 'Ok',sbmensa);
         PKG_ERROR.SETERRORMESSAGE(pkg_error.cnugeneric_message,sbmensa);
         RAISE pkg_error.controlled_error;
  END IF;
   CLOSE cuproducto;
  pkg_traza.trace(csbMetodo||' Salio cursor cuProducto, nuProductId: '||nuProductId
                           ||', nuContratoId: ' || nuContratoId || ', nuTaskTypeId: ' || nuTaskTypeId , csbNivelTraza);
  pkg_traza.trace(csbMetodo||' continua cursor cuProducto, nupakageid: '|| nupakageid
                           || ', nucliente: ' || nucliente
                           || ', nuunidadoperativa: '  || nuunidadoperativa , csbNivelTraza);

    -- Actualizamos las solicitud que se esta legalizando para que no salga como pendiente
  UPDATE mo_packages m
     SET m.motive_status_id = 14
   WHERE m.package_id       = nupakageid;
   pkg_traza.trace(csbMetodo||' Actualizar a Atendido(14) en MO_PACKAGES para que no salga como pendiente, filas afectadas: '||SQL%ROWCOUNT , csbNivelTraza);
   
    -- Buscamos solicitudes de revisión periodica generadas
    sbsolicitudes := NULL;
    FOR i IN cusolicitudesabiertas(nuproductid) LOOP
        IF sbsolicitudes IS NULL THEN
           sbsolicitudes := i.colsolicitud;
        ELSE
           sbsolicitudes := sbsolicitudes||','||TO_CHAR(i.colsolicitud);
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
         OPEN cuDatosTramiteDefec(nuproductid);
        FETCH cuDatosTramiteDefec INTO sbdireccionparseada
             ,nudireccion
             ,nulocalidad
             ,nucategoria
             ,nusubcategori;
        CLOSE cuDatosTramiteDefec; 
        
        IF nudireccion IS NULL THEN --por ser el campo not null del cursor
            RAISE NO_DATA_FOUND;
        END IF;
        
     EXCEPTION
      WHEN NO_DATA_FOUND THEN
       sw := 0;
     END;
      pkg_traza.trace(csbMetodo||' Salio cursor cuDatosTramiteDefec, sbdireccionparseada: '||sbdireccionparseada
                               ||', nudireccion: ' || nudireccion || ', nulocalidad: ' || nulocalidad , csbNivelTraza);
      pkg_traza.trace(csbMetodo||' continua cursor cuDatosTramiteDefec, nucategoria: '|| nucategoria
                               || ', nusubcategori: ' || nusubcategori, csbNivelTraza);     
      pkg_traza.trace(csbMetodo||' sw: '||sw , csbNivelTraza);
    IF sw = 1 THEN
     -- Construimos XML para generar el tramite
     nupackageid      := NULL;
     numotiveid       := NULL;
     nuerrorcode      := NULL;
     sberrormessage   := NULL;
     sbcomment        := dald_parameter.fsbGetValue_Chain('LDCPARCASOPEN')||' '||substr(ldc_retornacomentotlega(nuorden),1,2000)||' '|| dald_parameter.fsbGetValue_Chain('COMENTARIO_REPARACION_PRP')||' AL LEGALIZAR ORDEN : '||TO_CHAR(nuorden)||' CON CAUSAL : '||TO_CHAR(nucausalorder);
     numediorecepcion := dald_parameter.fnuGetNumeric_Value('MEDIO_RECEPCION_REPARACION_PRP');
     sbrequestxml1 := pkg_xml_soli_rev_periodica.getSolicitudReparacionRp(numediorecepcion, --inuMedioRecepcionId
                                                                          sbComment,        --isbComentario
                                                                          nuproductid,      --inuProductoId
                                                                          nucliente         --inuClienteId
                                                                           );
     pkg_traza.trace(csbMetodo||' sbrequestxml1: '||sbrequestxml1 , csbNivelTraza);
     
    -- Se crea la solicitud y la orden de trabajo
     API_RegisterRequestByXML(
                               sbrequestxml1,
                               nupackageid,
                               numotiveid,
                               nuerrorcode,
                               sberrormessage
                             );
     pkg_traza.trace(csbMetodo||'API_RegisterRequestByXML retorna, nupackageid: '||nupackageid||', numotiveid: '||numotiveid , csbNivelTraza);                        
     
     IF nupackageid IS NULL THEN
        sbmensa := 'Proceso termino con errores : '||'Error al generar la solicitud de reparacion prp. Codigo error : '||TO_CHAR(nuerrorcode)||' Mensaje de error : '||sberrormessage;
        PKG_ESTAPROC.PRACTUALIZAESTAPROC(sbNameproceso, 'Ok',sbmensa);
        PKG_ERROR.SETERRORMESSAGE(pkg_error.cnugeneric_message,sbmensa);
        RAISE pkg_error.controlled_error;
     ELSE
      -- Verificamos la fecha minima del certificado del producto.
      BEGIN
         OPEN cuPlazoMinRevision(nuProductId);
        FETCH cuPlazoMinRevision INTO dtplazominrev;
        CLOSE cuPlazoMinRevision;
        
        IF dtplazominrev IS NULL THEN
            RAISE NO_DATA_FOUND;
        END IF;
        
      EXCEPTION
      WHEN NO_DATA_FOUND THEN
           dtplazominrev := TO_DATE('01/01/1900','dd/mm/yyyy');
      END;
      pkg_traza.trace(csbMetodo||' dtplazominrev: '||dtplazominrev , csbNivelTraza);
      
      ldcproccrearegistrotramtab(ldc_seq_tramites_revper.nextval,nuproductid,nupackageid,numarcaantes,numarca,SYSDATE,'Se atiende la solicitud nro : '||TO_CHAR(nupakageid));
      sbflag := ldc_fsbretornaaplicaasigauto(nutasktypeid,nucausalorder);
      pkg_traza.trace(csbMetodo||' sbflag: '||sbflag , csbNivelTraza);
      
      IF nvl(sbflag,'N') = 'S' THEN
         ldc_procrearegasiunioprevper(nuunidadoperativa,nuproductid,nutasktypeid,nuorden,nupackageid);
      END IF;
        -- Dejamos la solicitud como estaba
          UPDATE  mo_packages m
             SET m.motive_status_id = 13
           WHERE m.package_id       = nupakageid;
        pkg_traza.trace(csbMetodo||' Actualizar a Registrado(13) en MO_PACKAGES para que no salga como pendiente, filas afectadas: '||SQL%ROWCOUNT , csbNivelTraza);
        sbmensa := 'Proceso termino Ok. Se genero la solicitud Nro : '||TO_CHAR(nupackageid);
        PKG_ESTAPROC.PRACTUALIZAESTAPROC(sbNameproceso, 'Ok',sbmensa);
     END IF;
     
      -- Consultamos si el motivo generado tiene asociado los componentes
       OPEN cuComponente(numotiveid);
      FETCH cuComponente INTO nucontacomponentes;
      CLOSE cuComponente;
      pkg_traza.trace(csbMetodo||' nucontacomponentes: '||nucontacomponentes , csbNivelTraza);

       -- Si el motivo no tine los componentes asociados, se procede a registrarlos
       IF (nucontacomponentes=0)THEN
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
      sbmensa := 'Proceso termino con errores : '||'No se encontraron datos de la solicitud asociada a la orden # '||TO_CHAR(nuorden);
      PKG_ESTAPROC.PRACTUALIZAESTAPROC(sbNameproceso, 'Ok',sbmensa);
      PKG_ERROR.SETERRORMESSAGE(pkg_error.cnugeneric_message,sbmensa);
      RAISE pkg_error.controlled_error;
    END IF;
   ELSE
    sbmensa := 'Error al generar la solicitud para el producto : '||TO_CHAR(nuproductid)||' Tiene las siguientes solicitudes de revisión periódica en estado registradas : '||TRIM(sbsolicitudes);
    PKG_ESTAPROC.PRACTUALIZAESTAPROC(sbNameproceso, 'Ok',sbmensa);
    PKG_ERROR.SETERRORMESSAGE(pkg_error.cnugeneric_message,sbmensa);
    RAISE pkg_error.controlled_error;
   END IF;
   pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 
   
EXCEPTION
    WHEN PKG_ERROR.CONTROLLED_ERROR THEN
         pkg_Error.getError(nuErrorCode, sbErrorMessage);
         pkg_traza.trace('sbErrorMessage: ' || sbErrorMessage, pkg_traza.cnuNivelTrzDef);
         pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
         RAISE;   
    WHEN OTHERS THEN
         sbmensa := 'Proceso termino con Errores. '||SQLERRM;
         PKG_ESTAPROC.PRACTUALIZAESTAPROC(sbNameproceso, 'Ok',sbmensa);
         pkg_Error.setError;
         pkg_Error.getError(nuErrorCode, sbErrorMessage); 
         pkg_traza.trace('sbErrorMessage: ' || sbErrorMessage, pkg_traza.cnuNivelTrzDef);
         pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
         RAISE pkg_Error.Controlled_Error;
    
END ldcproccreatramirepprptxml;
/
PROMPT Otorgando permisos de ejecucion a LDCPROCCREATRAMIREPPRPTXML
BEGIN
  pkg_utilidades.prAplicarPermisos('LDCPROCCREATRAMIREPPRPTXML','OPEN');
END;
/