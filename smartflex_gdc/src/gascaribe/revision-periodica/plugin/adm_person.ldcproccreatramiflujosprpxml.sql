create or replace PROCEDURE adm_person.ldcproccreatramiflujosprpxml AS
  /********************************************************************************************************
  Propiedad Intelectual de Gases del caribe S.A E.S.P

  Funcion     : ldcproccreatramiflujosprpxml
  Descripcion : Procedimiento que crea el tramite de revision, defecto critico, reparacion y certificacion
                segun la marca del producto.
  Autor       : John Jairo Jimenez Marimon
  Fecha       : 08-02-2017

  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================
  05/01/2018          DSALTARIN          200-1662. Se corrige para que envie el comentario cuando la marca es 101
  12/03/2018          jbrito             CASO 200-1743 Se anula el condicional que valida la fecha mínima de revisión sea mayor a la fecha  actual
  06/04/2018          HORBATH.           200-1871.SE MODIFICA EL XML DE LAS REPARACIONES Y CERTIFICACIONES.
                                         SE CAMBIA EL TAG <PRODUCTO> POR <PRODUCT>
  13/04/2018          HORBATH            200-1871 Se modifica para que si el tramite es diferente de reconexión 100321 no se ejecute
  23/12/20019         HORBATH            CA 147  se coloca logica para que si el tipo de trabajo es 12460 se inserte en la tabla LDC_ASIGNA_UNIDAD_REV_PER
  16/03/2021          LJLB               CA 472 se consulta parametro LDC_TITRGENSUSP con el fin de generar suspension dummy
  25/11/2021          DANVAL             CA 833_1 : Tipo de Trabajo en TIPOTRABAJO_OPERARP y la causal es de éxito, se consultará de la orden en OR_REQU_DATA_VALUE
                                         el dato adicional definido en DATOADICION_UNIDADOPER se registrará en NUUNITOPERADDDATA si NUUNITOPERADDDATA no es NULL la unidad debe existir en OR_OPERATING_UNIT, se registrará en  LDC_ORDENTRAMITERP, en caso contrario se arroja error.
  18/08/2022          JORVAL             OSF-499 Obtener el pazo minimo de revision del la certificacion del producto y validar
                                         si esta fecha es mayor a la fecha del sistema se utiliza RETURN para salir del proceso sin
                                         continuar el resto de la logica existente.
  24/11/2023          ADRIANAVG          OSF-1850: Se retira el esquema OPEN antepuesto,
                                         Se retira FBLAPLICAENTREGAXCASO('0000833')[se deja el flag sbAplica833], FBLAPLICAENTREGAXCASO('0000147') y FBLAPLICAENTREGAXCASO('0000472') pero se deja la lógica interna.,
                                         Se reemplaza el tipo de dato de la variable sbrequestxml1, de VARCHAR2(32767) por constants_per.tipo_xml_sol%type
                                         Se retira select-into de los datos para inicializar el proceso.
                                         Se reemplaza LDC_PROINSERTAESTAPROG por PKG_ESTAPROC.PRINSERTAESTAPROC
                                         Se reemplaza or_bolegalizeorder.fnuGetCurrentOrder por PKG_BCORDENES.FNUOBTENEROTINSTANCIALEGAL,
                                         Se reemplaza or_boorder.fnugetordercausal(nuorden) por PKG_BCORDENES.FNUOBTIENECAUSAL,
                                         Se reemplaza pkg_error.cnugeneric_message por pkg_error.cnugeneric_message
                                         Se retira la variable ex_error declarada sin uso
                                         Se reemplaza ge_bopersonal.fnugetpersonid por PKG_BOPERSONAL.FNUGETPERSONAID,
                                         Se reemplaza ldc_proactualizaestaprog POR PKG_ESTAPROC.PRACTUALIZAESTAPROC,
                                         Se reemplaza GE_BOERRORS.SETERRORCODEARGUMENT por PKG_ERROR.SETERRORMESSAGE,
                                         Se reemplaza ex.controlled_error por PKG_ERROR.controlled_error,
                                         Se reemplaza damo_packages.fnugetpackage_type_id por PKG_BCSOLICITUDES.FNUGETTIPOSOLICITUD,
                                         Se crea cursor cuPlazoMinRevision, cuDatostramite. Declarar variables para manejo de trazas.
                                         Se reemplaza errors.seterror por pkg_error.seterror,
                                         Se reemplaza OS_RegisterRequestWithXML por API_RegisterRequestByXML.
                                         Se reemplaza armado de los XML 100237, 100294 y 100295 por su correspondiente función del paquete pkg_xml_soli_rev_periodica.
                                         Se reemplaza daor_operating_unit.fblexist por PKG_BCUNIDADOPERATIVA.fblExiste,
                                         Se reemplaza DAOR_ORDER.FNUGETTASK_TYPE_ID por PKG_BCORDENES.FNUOBTIENETIPOTRABAJO,
                                         Se reemplaza DAGE_CAUSAL.FNUGETCLASS_CAUSAL_ID por PKG_BCORDENES.FNUOBTIENECLASECAUSAL.
                                         Se reemplaza select-into por cuExisteUnidOper y ldc_boutilities.splitstrings por regexp_substr.
                                         Se ajusta cursor cusolicitudesabiertas para reemplazar ldc_boutilities.splitstrings por regexp_substr
                                         Se reemplaza DAOR_ORDER_PERSON.FNUGETPERSON_ID por pkg_bcordenes.fnuobtenerpersona
  28/11/2023          ADRIANAVG          OSF-1850: Añadir a los cursores cuPlazoMinRevision, cuDatostramite y cuTipoSolRevPer que si no retornan datos/filas entonces dispare una excepción no data found
                                         Se retira variable sbAplica833 y en el IF-ENDIF  sbAplica833 ='S' and (nuTipoTrabOperaRP > 0 and nuTipoCausal = 1)
                                         Se declara variable sbproceso
  01/12/2023          ADRIANAVG          OSF-1850: Se declara variable sbNameProceso, para que invoque el csbMetodo||TO_CHAR(SYSDATE,'DDMMYYYYHH24MISS') una sola vez, asi se garantiza
                                         que el ID DE PROCESO es el mismo para el PRINSERTAESTAPROC como para el PRACTUALIZAESTAPROC. Se añade antes del exception general el pkg_traza.trace de FIN,
                                         en el Exception general se ajusta para que contemple las minimas instrucciones de impresión del error, como indica las pautas técnicas.
                                         en el Exception del begin-end del cursor cuPlazoMinRevision se ajusta para que contemple las minimas instrucciones de impresión del error, como indica las pautas técnicas.
                                         en el IF-ENDIF que evalua el retorno del cursor cuPlazoMinRevision, se añade setError previo al raise, como indica las pautas técnicas.
  19/04/2024		  ADRIANAVG		     OSF-2569: Se migra del esquema OPEN al esquema ADM_PERSON                                         
  *********************************************************************************************************/
  --CA 833_1
  sbTipoTrabOperaRP ldc_pararepe.paravast%type := DALDC_PARAREPE.FSBGETPARAVAST('TIPOTRABAJO_OPERARP',
                                                                                     NULL);
  nuTipoTrabOperaRP number;
  nuTipoCausalOrd   number;
  nuTipoTrabajo     number;
  sbDatoAdicional   ldc_pararepe.paravast%type := DALDC_PARAREPE.fsbGetPARAVAST('DATOADICION_UNIDADOPER',
                                                                                          NULL);
  nuCodDatoAdicic   ldc_pararepe.parevanu%type := DALDC_PARAREPE.fnuGetPAREVANU('COD_DATOADICION_UNIDADOPER',
                                                                                          NULL);
  NUUNITOPERADDDATA number;
  sbValorPRCDA      varchar2(2000);
  nuExisteOU        number;
  --
  CURSOR cusolicitudesabiertas(nucuproducto pr_product.product_id%TYPE) IS
    SELECT pv.package_id colsolicitud
      FROM mo_packages pv, mo_motive mv
     WHERE pv.package_type_id IN
           (SELECT to_number(column_value)
              FROM ( SELECT regexp_substr(DALD_PARAMETER.fsbGetValue_Chain('VAL_TRAMITES_NUEVOS_FLUJOS',NULL), '[^,]+', 1, LEVEL)AS COLUMN_VALUE
                       FROM dual
                 CONNECT BY regexp_substr(DALD_PARAMETER.fsbGetValue_Chain('VAL_TRAMITES_NUEVOS_FLUJOS',NULL), '[^,]+', 1, LEVEL) IS NOT NULL)
                           )
       AND pv.motive_status_id =
           dald_parameter.fnuGetNumeric_Value('ESTADO_SOL_REGISTRADA')
       AND mv.product_id = nucuproducto
       AND pv.package_id = mv.package_id;
  nuErrorCode         NUMBER;
  sbErrorMessage      VARCHAR2(4000);
  nuPackageId         mo_packages.package_id%type;
  nuMotiveId          mo_motive.motive_id%type;
  sbrequestxml1       constants_per.tipo_xml_sol%type;
  nuorden             or_order.order_id%type;
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
  nuparano            NUMBER(4);
  nuparmes            NUMBER(2);
  nutsess             NUMBER;
  sbparuser           VARCHAR2(30);
  sbmensa             VARCHAR2(10000);
  numarca             ld_parameter.parameter_id%TYPE;
  nuunidadoperativa   or_order.operating_unit_id%TYPE;
  sbflag              VARCHAR2(1);
  nucontacomponentes  NUMBER(4);
  nunumber            NUMBER(4) DEFAULT 0;
  nuprodmotive        mo_component.prod_motive_comp_id%TYPE;
  sbtagname           mo_component.tag_name%TYPE;
  nuclasserv          mo_component.class_service_id%TYPE;
  nucomppadre         mo_component.component_id%TYPE;
  rcComponent         damo_component.stymo_component;
  rcmo_comp_link      damo_comp_link.stymo_comp_link;
  --OSF-499
  dtplazominrev       ldc_plazos_cert.plazo_min_revision%TYPE;
  sbsolicitudes       VARCHAR2(1000);
  nuestadosol         mo_packages.motive_status_id%TYPE;
  nucontaexiste       NUMBER(5);
  nusaldodiferi       diferido.difesape%TYPE;
  nutiposolgene       ps_package_type.package_type_id%TYPE;
  nuTipoSoli          mo_packages.package_type_id%type;

  --Cursor que obtiene el producto, el contrato del producto y el tipo de trabajo de acuerdo a la orden instanciada
  CURSOR cuProducto(nuorden NUMBER) IS
    SELECT product_id,
           subscription_id,
           ot.task_type_id,
           oa.package_id,
           oa.subscriber_id,
           ot.operating_unit_id,
           m.motive_status_id estado_solicitud,
           OT.EXECUTION_FINAL_DATE
      FROM or_order_activity oa, or_order ot, mo_packages m
     WHERE oa.order_id = nuorden
       AND oa.package_id IS NOT NULL
       AND oa.order_id = ot.order_id
       AND oa.package_id = m.package_id
       AND rownum = 1;

  -- Cursor para obtener los componentes asociados a un motivo
  CURSOR cuComponente(nucumotivos mo_motive.motive_id%TYPE) IS
    SELECT COUNT(1) FROM mo_component c WHERE c.motive_id = nucumotivos;

    ---Obtiene el plazo minimo de revision
    CURSOR cuPlazoMinRevision(p_nuProductId ldc_plazos_cert.id_producto%type)
    IS
    SELECT pc.plazo_min_revision
      FROM ldc_plazos_cert pc
     WHERE pc.id_producto = p_nuProductId
       AND rownum = 1;

    --datos para el tramite
    CURSOR cuDatostramite (p_nuproductid ldc_plazos_cert.id_producto%TYPE)
    IS
    SELECT di.address_parsed,
           di.address_id,
           di.geograp_location_id,
           pr.category_id,
           pr.subcategory_id
     FROM pr_product pr, ab_address di
    WHERE pr.product_id = p_nuproductid
      AND pr.address_id = di.address_id;

     --obtiene el tipo de trabajo legalizado por solicitud a generar
     CURSOR cuTipoSolRevPer(p_nutasktypeid ldc_conf_ttsusreco_tisolgene.tipo_trabajo_susp_reco%type)
     IS
     SELECT ts.tipo_solicitud_revper
     FROM ldc_conf_ttsusreco_tisolgene ts
     WHERE ts.tipo_trabajo_susp_reco = p_nutasktypeid;

     --retorna existencia de la unidad iperativa
     CURSOR cuExisteUnidOper(p_nuunidadoperativa or_operating_unit.operating_unit_id%type)
     IS
     SELECT COUNT(1)
                  FROM or_operating_unit uo
                 WHERE uo.operating_unit_id IN
                       (SELECT to_number(column_value)
                          FROM (
                           SELECT regexp_substr(DALD_PARAMETER.fsbGetValue_Chain('VAL_UNIDAD_OPER_REGENERA',NULL), '[^,]+', 1, LEVEL)AS COLUMN_VALUE
                             FROM dual
                           CONNECT BY regexp_substr(DALD_PARAMETER.fsbGetValue_Chain('VAL_UNIDAD_OPER_REGENERA',NULL), '[^,]+', 1, LEVEL) IS NOT NULL))
                   AND uo.operating_unit_id = p_nuunidadoperativa;

    CURSOR cuCantidad(p_nutipotrabajo NUMBER)
    IS
    SELECT COUNT(1)
      FROM dual
     WHERE p_nutipotrabajo IN ( SELECT to_number(column_value)
                                  FROM ( SELECT regexp_substr(sbTipoTrabOperaRP, '[^,]+', 1, level) AS column_value
                                           FROM  dual
                                     CONNECT BY regexp_substr(sbTipoTrabOperaRP, '[^,]+', 1, level) IS NOT NULL )
                                );

  --INICIO CA 147
  sbFlagasiAut VARCHAR2(1) := 'N';
  --FIN CA 147

  --INICIO CA 472
  sbTitrValiSusp        VARCHAR2(4000) := DALDC_PARAREPE.FSBGETPARAVAST('LDC_TITRGENSUSP', NULL);
  blvencido             BOOLEAN := FALSE;
  dtFechaeje            DATE;
  nuCausalSusp          NUMBER := DALDC_PARAREPE.FNUGETPAREVANU('LDC_CAUSDUMMY', NULL);
  numeresuspadmin       NUMBER;
  inuSUSPENSION_TYPE_ID NUMBER;
  nutipoCausal          NUMBER;
  nuLectura             NUMBER;
  nuPersonaLega         ge_person.person_id%TYPE := pkg_bopersonal.fnugetpersonaid;
  nuCodigoAtrib         NUMBER := DALDC_PARAREPE.FNUGETPAREVANU('LDC_CODPALECTRECO', NULL);
  sbNombreoAtrib        VARCHAR2(100) := DALDC_PARAREPE.FSBGETPARAVAST('LDC_NOMPALECTRECO', NULL);
  nuUnidadDummy         NUMBER := daldc_pararepe.fnugetparevanu('UNIT_DUMMY_RP', null);
  --FIN CA 472

    --Variables para gestión de traza
    csbMetodo      CONSTANT VARCHAR2(32) := $$PLSQL_UNIT||'.';
    csbNivelTraza  CONSTANT NUMBER(2)    := pkg_traza.cnuNivelTrzDef;
    sbproceso      VARCHAR2(100 BYTE) :=  SUBSTR(csbMetodo, 1, (INSTR(csbMetodo, '.', 1))-1)||TO_CHAR(SYSDATE,'DDMMYYYYHH24MISS');
    sbNameProceso  sbproceso%TYPE;
BEGIN

  pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
  -- Inicializamos el proceso
  sbNameProceso:= sbproceso; --invocarlo una sola vez
  pkg_traza.trace(csbMetodo||' sbNameProceso: '||sbNameProceso , csbNivelTraza);
  PKG_ESTAPROC.PRINSERTAESTAPROC(sbNameProceso, NULL);

  --Obtener el identificador de la orden  que se encuentra en la instancia
  nuorden       := pkg_bcordenes.fnuobtenerotinstancialegal;
  nucausalorder := pkg_bcordenes.fnuobtienecausal(nuorden);
  pkg_traza.trace(csbMetodo||' Numero de la Orden: '||nuorden , csbNivelTraza);
  pkg_traza.trace(csbMetodo||' Numero causal de la Orden: '||nucausalorder , csbNivelTraza);

  -- obtenemos el producto y el paquete
   OPEN cuproducto(nuorden);
  FETCH cuProducto
   INTO nuproductid,
        nucontratoid,
        nutasktypeid,
        nupakageid,
        nucliente,
        nuunidadoperativa,
        nuestadosol,
        dtFechaeje;
  IF cuProducto%NOTFOUND THEN
    sbmensa := 'Proceso termino con errores : ' || 'El cursor cuProducto no arrojo datos con el # de orden' || to_char(nuorden);
    PKG_ESTAPROC.PRACTUALIZAESTAPROC(sbNameProceso, 'Ok',sbmensa);
    PKG_ERROR.SETERRORMESSAGE(pkg_error.cnugeneric_message, sbmensa);
    RAISE PKG_ERROR.controlled_error;
  END IF;
  CLOSE cuproducto;

  pkg_traza.trace(csbMetodo||' Salio cursor cuProducto, nuProductId: '||nuProductId
                           ||', nuContratoId: ' || nuContratoId || ', nuTaskTypeId: ' || nuTaskTypeId , csbNivelTraza);
  pkg_traza.trace(csbMetodo||' continua cursor cuProducto, nucliente: '|| nucliente
                           || ', nuunidadoperativa: ' || nuunidadoperativa
                           || ', nuestadosol: '  || nuestadosol , csbNivelTraza);

  nuTipoSoli := pkg_bcsolicitudes.fnugettiposolicitud(nupakageid);
  pkg_traza.trace(csbMetodo||' TipoSoli: '||nuTipoSoli , csbNivelTraza);

  if nuTipoSoli !=
    dald_parameter.fnuGetNumeric_Value('TIPO_SOL_RECONEX_SIN_CERTIF', NULL) then
    sbmensa := ' OT ' || nuorden || ' Proceso termino con errores : ' || 'No se dispara la generacion del tramite debido a que no esta en un tramite de reconexion';
    pkg_traza.trace(csbMetodo||' '||sbmensa , csbNivelTraza);
    PKG_ESTAPROC.PRACTUALIZAESTAPROC(sbNameProceso, 'Ok', sbmensa);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    RETURN;
  end if;

   --OSF-499
  BEGIN
    ---Obtiene el plazo minimo de revision
    OPEN cuPlazoMinRevision(nuProductId);
    FETCH cuPlazoMinRevision INTO dtplazominrev;
    CLOSE cuPlazoMinRevision;
    pkg_traza.trace(csbMetodo||' fecha minima de revision: '||dtplazominrev , csbNivelTraza);

    IF dtplazominrev IS NULL THEN
        pkg_error.seterror;
        RAISE NO_DATA_FOUND;
    END IF;

    -- Valida que la fecha minima de revision, sea mayor a la fecha de sistema
    IF trunc(dtplazominrev) > trunc(SYSDATE) THEN
      pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
      return;
    END IF;

  EXCEPTION
    WHEN no_data_found THEN
      NULL;
      pkg_error.geterror(nuErrorCode, sbErrorMessage);
      pkg_traza.trace('sbErrorMessage: ' || sbErrorMessage, csbNivelTraza);
      pkg_traza.trace(csbMetodo,  csbNivelTraza, pkg_traza.csbFIN_ERC);
    WHEN others THEN
      null;
      pkg_error.seterror;
      pkg_error.geterror(nuErrorCode, sbErrorMessage);
      pkg_traza.trace('sbErrorMessage: ' || sbErrorMessage, csbNivelTraza);
      pkg_traza.trace(csbMetodo,  csbNivelTraza, pkg_traza.csbFIN_ERR);
  END;
  ---------------------------------------------------------

  -- Actualizamos las solicitud que se esta legalizando para que no salga como pendiente
  IF nuestadosol = 13 THEN
    UPDATE mo_packages m
       SET m.motive_status_id = 14
     WHERE m.package_id = nupakageid;
     pkg_traza.trace(csbMetodo||' UPDATE motive_status_id en MO_PACKAGES a 14 para que no salga como pendiente, filas afectadas: '||SQL%ROWCOUNT , csbNivelTraza);
  END IF;

  -- Buscamos solicitudes de revisión periodica generadas
  sbsolicitudes := NULL;
  FOR i IN cusolicitudesabiertas(nuproductid) LOOP
    IF sbsolicitudes IS NULL THEN
      sbsolicitudes := i.colsolicitud;
    ELSE
      sbsolicitudes := sbsolicitudes || ',' || to_char(i.colsolicitud);
    END IF;
  END LOOP;
  pkg_traza.trace(csbMetodo||' sbsolicitudes: '||sbsolicitudes , csbNivelTraza);

  IF TRIM(sbsolicitudes) IS NULL THEN
    -- Obtenemos los datos de la solicitud de visita de verificacion para generar el tramite de defecto critico
    sbdireccionparseada := NULL;
    nudireccion         := NULL;
    nulocalidad         := NULL;
    nucategoria         := NULL;
    nusubcategori       := NULL;
    sw                  := 1;
    BEGIN
        OPEN cuDatostramite(nuproductid);
        FETCH cuDatostramite INTO sbdireccionparseada,
             nudireccion,
             nulocalidad,
             nucategoria,
             nusubcategori;
       CLOSE cuDatostramite;

    IF nudireccion IS NULL THEN --por ser el campo not null del cursor
       RAISE NO_DATA_FOUND;
    END IF;

    EXCEPTION
      WHEN no_data_found THEN
        sw := 0;
    END;

    pkg_traza.trace(csbMetodo||' Salio Cursor cuDatostramite, sbdireccionparseada: '|| sbdireccionparseada
                             ||', nudireccion: '  || nudireccion , csbNivelTraza);
    pkg_traza.trace(csbMetodo||' continua Cursor cuDatostramite, nulocalidad: '  || nulocalidad
                             ||', nucategoria: '  || nucategoria, csbNivelTraza);
    pkg_traza.trace(csbMetodo||' continua Cursor cuDatostramite, nusubcategori: '|| nusubcategori, csbNivelTraza);
    pkg_traza.trace(csbMetodo||' sw: '||sw , csbNivelTraza);

    IF sw = 1 THEN
      -- Consultamos configuración del tipo de trabajo legalizado por solicitud a generar
      nutiposolgene := NULL;
      BEGIN
        OPEN cuTipoSolRevPer(nutasktypeid);
        FETCH cuTipoSolRevPer INTO nutiposolgene;
        CLOSE cuTipoSolRevPer;

        IF nutiposolgene IS NULL THEN
           RAISE NO_DATA_FOUND;
        END IF;

      EXCEPTION
        WHEN no_data_found THEN
          nutiposolgene := NULL;
      END;
      pkg_traza.trace(csbMetodo||' nutiposolgene: '|| nutiposolgene , csbNivelTraza);

      -- Asignamos marca
      IF nutiposolgene IS NOT NULL THEN
        IF nutiposolgene =     dald_parameter.fnuGetNumeric_Value('SOLICITUD_VISITA', NULL) THEN
           numarca := ldcfncretornamarcarevprp;
        ELSIF nutiposolgene =  dald_parameter.fnuGetNumeric_Value('TRAMITE_DEFECTO_CRITICO', NULL) THEN
          numarca := ldcfncretornamarcadefcri;
        ELSIF nutiposolgene =  dald_parameter.fnuGetNumeric_Value('TRAMITE_REPARACION_PRP',  NULL) THEN
          numarca := ldcfncretornamarcarepprp;
        ELSIF nutiposolgene =  dald_parameter.fnuGetNumeric_Value('TRAMITE_CERTIFICACION_PRP', NULL) THEN
          numarca := ldcfncretornamarcacerprp;
        END IF;
      ELSE
        -- Consultamos que marca tiene el producto
        numarca := ldc_fncretornamarcaprod(nuproductid);
      END IF;
      pkg_traza.trace(csbMetodo||' Valor Marca Revision prp : '    ||ldcfncretornamarcarevprp , csbNivelTraza);
      pkg_traza.trace(csbMetodo||' Valor Marca defecto critico: '  ||ldcfncretornamarcadefcri , csbNivelTraza);
      pkg_traza.trace(csbMetodo||' Valor Marca certificacion prp: '||ldcfncretornamarcarepprp , csbNivelTraza);
      pkg_traza.trace(csbMetodo||' Valor Marca certificacion prp: '||ldcfncretornamarcacerprp , csbNivelTraza);
      pkg_traza.trace(csbMetodo||' numarca: '||numarca , csbNivelTraza);


        /*Si el Tipo de Trabajo está definido en el  Parámetro TIPOTRABAJO_OPERARP y la causal es de éxito*/
        nuExisteOU := 0;
        sbValorPRCDA := ldc_boordenes.fsbDatoAdicTmpOrden(nuorden,nuCodDatoAdicic,TRIM(sbDatoAdicional));
        pkg_traza.trace(csbMetodo||' sbValorPRCDA: '||sbValorPRCDA , csbNivelTraza);

        if sbValorPRCDA is not null then
           nuUnitOperAdddata := to_number(sbValorPRCDA);
           pkg_traza.trace(csbMetodo||' nuUnitOperAdddata: '||nuUnitOperAdddata , csbNivelTraza);

           if PKG_BCUNIDADOPERATIVA.fblExiste(nuUnitOperAdddata ) then
              nuExisteOU :=1;
           else
              nuExisteOU :=0;
              sbmensa := 'Proceso termino con errores : La Unidad Operativa [' || NUUNITOPERADDDATA || '] registrada en el Dato Adicional [' ||
                         sbDatoAdicional || '] no existe';
              PKG_ERROR.SETERRORMESSAGE(pkg_error.cnugeneric_message, sbmensa);
              RAISE PKG_ERROR.controlled_error;
           end if;
        end if;
        nuTipoTrabajo := PKG_BCORDENES.FNUOBTIENETIPOTRABAJO(nuorden);
        pkg_traza.trace(csbMetodo||' nuTipoTrabajo: '||nuTipoTrabajo , csbNivelTraza);

        OPEN cuCantidad(nuTipoTrabajo);
        FETCH cuCantidad INTO nuTipoTrabOperaRP;
        CLOSE cuCantidad;
        pkg_traza.trace(csbMetodo||' nuTipoTrabOperaRP: '||nuTipoTrabOperaRP , csbNivelTraza);

        nuTipoCausal := PKG_BCORDENES.FNUOBTIENECLASECAUSAL(nucausalorder);
        pkg_traza.trace(csbMetodo||' nuTipoCausal: '||nuTipoCausal , csbNivelTraza);


      IF INSTR(',' || nutasktypeid || ',', ',' || sbTitrValiSusp || ',') > 0 THEN

        blvencido := LDC_PKGESTIONLEGAORRP.FBLGETPRODUCTOVENC(nuproductid,    dtFechaeje);

        IF blvencido THEN
          numeresuspadmin       := dald_parameter.fnuGetNumeric_Value('MEDIO_RECEPCION_SUSPADM_PRP',   NULL);

          inuSUSPENSION_TYPE_ID := LDCI_PKREVISIONPERIODICAWEB.fnuTipoSuspension(nuproductid);
          pkg_traza.trace(csbMetodo||' inuSUSPENSION_TYPE_ID: '||inuSUSPENSION_TYPE_ID , csbNivelTraza);

          nutipoCausal := DALDC_PARAREPE.FNUGETPAREVANU('LDC_TIPOCAUSDUMMY',  NULL);
          pkg_traza.trace(csbMetodo||' nutipoCausal: '||nutipoCausal , csbNivelTraza);

          IF nutipoCausal IS NULL THEN
            PKG_ERROR.SETERRORMESSAGE(pkg_error.cnugeneric_message, 'No existe datos para el parametro TIPO_CAUSAL_100013_SUSP_ACOME, definalos por el comando LDPAR');
            RAISE PKG_ERROR.controlled_error;
          END IF;
          nuLectura := ldc_boordenes.fsbDatoAdicTmpOrden(nuorden,
                                                         nuCodigoAtrib,
                                                         TRIM(sbNombreoAtrib));
          pkg_traza.trace(csbMetodo||' nuLectura: '||nuLectura , csbNivelTraza);

          if nuLectura is null then
            sbmensa := 'Proceso termino con errores : ' ||
                       'No se ha digitado Lectura';
            PKG_ERROR.SETERRORMESSAGE(pkg_error.cnugeneric_message,  sbmensa);
          end if;
          nuPersonaLega := pkg_bcordenes.fnuobtenerpersona(nuorden);
          pkg_traza.trace(csbMetodo||' nuPersonaLega: '||nuPersonaLega , csbNivelTraza);

          sbcomment := SUBSTR(ldc_retornacomentotlega(nuorden) || 'DUMMY| LEGALIZACION ORDEN[' || nuorden || ']|LECTURA['
                                                               || nuLectura || ']|PERSONA[' || nuPersonaLega || '] CON CAUSAL : '
                                                               || to_char(nucausalorder), 1, 2000);
          pkg_traza.trace(csbMetodo||' sbcomment: '||sbcomment , csbNivelTraza);

          --CREAR TRAMITE DE SUSPENSION DUMMY
          nupackageid := LDC_PKGESTIONCASURP.fnuGeneTramSuspRP(nuproductid,
                                                               numeresuspadmin,
                                                               nutipoCausal,
                                                               nuCausalSusp,
                                                               inuSUSPENSION_TYPE_ID,
                                                               sbcomment,
                                                               nuerrorcode,
                                                               sberrormessage);
          pkg_traza.trace(csbMetodo||' nupackageid: '||nupackageid , csbNivelTraza);

          IF nuerrorcode <> 0 THEN
            sbmensa := 'Proceso termino con errores : ' ||
                       'Error al generar la solicitud. Codigo error : ' ||
                       to_char(nuerrorcode) || ' Mensaje de error : ' ||
                       sberrormessage;
            PKG_ESTAPROC.PRACTUALIZAESTAPROC(sbNameProceso, 'Ok',  sbmensa);
            PKG_ERROR.SETERRORMESSAGE(pkg_error.cnugeneric_message,  sbmensa);
          ELSE
            INSERT INTO LDC_BLOQ_LEGA_SOLICITUD (PACKAGE_ID_ORIG, PACKAGE_ID_GENE)
            VALUES (nupakageid, nupackageid);
            pkg_traza.trace(csbMetodo||' BLOQUEA LEGALIZACION POR SOLICITUD ' , csbNivelTraza);

            INSERT INTO LDC_ORDEASIGPROC  (ORAPORPA, ORAPSOGE, ORAOPELE, ORAOUNID, ORAOCALE, ORAOPROC)
            VALUES (nuorden, nupackageid, nuPersonaLega, nuUnidadDummy,  null, 'SUSPDUMYRP');
            pkg_traza.trace(csbMetodo||' REGISTRA ORDEN PARA ASIGNAR EN JOB PROCESO PERSCA' , csbNivelTraza);
          END IF;
        END IF;
      END IF;

      IF NOT blvencido THEN
        pkg_traza.trace(csbMetodo||' Aplica blvencido' , csbNivelTraza);

        IF numarca = ldcfncretornamarcarevprp THEN
          -- Validamos marca del producto
          nusaldodiferi := ldc_fncretornasalddifvisita(nuproductid);
          pkg_traza.trace(csbMetodo||' nusaldodiferi: '||nusaldodiferi , csbNivelTraza);

          IF nusaldodiferi <> 0 THEN
            sbmensa := 'Proceso termino con errores : producto : ' || to_char(nuproductid) ||
                       ' tiene diferidos con saldo del concepto 739 y/o 755. Saldo : ' ||  to_char(nusaldodiferi);
            PKG_ESTAPROC.PRACTUALIZAESTAPROC(sbNameProceso, 'Ok',  sbmensa);
            PKG_ERROR.SETERRORMESSAGE(pkg_error.cnugeneric_message,  sbmensa);
            RAISE PKG_ERROR.controlled_error;
          END IF;
          --200-1662
          sbcomment := substr(ldc_retornacomentotlega(nuorden), 1, 2000) ||
                       ' orden legalizada : ' || to_char(nuorden) ||
                       ' con causal : ' || to_char(nucausalorder) ||
                       ' SE GENERO SOLICITUD VISITA_IDENTIFICACION_CERTIFICADO';
          pkg_traza.trace(csbMetodo||' sbcomment: '||sbcomment , csbNivelTraza);

          --200-1662
          numediorecepcion := dald_parameter.fnuGetNumeric_Value('MEDIO_RECEPCION_VISITA');
          pkg_traza.trace(csbMetodo||' numediorecepcion: '||numediorecepcion , csbNivelTraza);

          sbrequestxml1    := pkg_xml_soli_rev_periodica.getSolicitudRevisionRp(numediorecepcion,   --inuMedioRecepcionId
                                                                                sbcomment,          --isbComentario
                                                                                nuproductid,        --inuProductoId
                                                                                nucliente           --inuClienteId
                                                                                 );

        ELSIF numarca in  (ldcfncretornamarcarepprp, ldcfncretornamarcadefcri) THEN
          sbcomment        := substr(ldc_retornacomentotlega(nuorden),  1,  2000) || ' orden legalizada : ' ||
                              to_char(nuorden) || ' con causal : ' || to_char(nucausalorder) || ' SE GENERO SOLICITUD REPARACION PRP.';
          pkg_traza.trace(csbMetodo||' sbcomment: '||sbcomment , csbNivelTraza);

          numediorecepcion := dald_parameter.fnuGetNumeric_Value('MEDIO_RECEPCION_REPARACION_PRP');
          pkg_traza.trace(csbMetodo||' numediorecepcion: '||numediorecepcion , csbNivelTraza);

           --INICIO CA 147
          IF nutasktypeid = 12460 THEN
            sbFlagasiAut := 'S';
          END IF;
          --FIN CA 147

          sbrequestxml1    := pkg_xml_soli_rev_periodica.getSolicitudReparacionRp(numediorecepcion,    --inuMedioRecepcionId
                                                       sbComment,           --isbComentario
                                                       nuproductid,         --inuProductoId
                                                       nucliente            --inuClienteId
                                                       );


        ELSIF numarca = ldcfncretornamarcacerprp THEN
          sbcomment        := substr(ldc_retornacomentotlega(nuorden), 1,  2000) || ' orden legalizada : ' ||
                            to_char(nuorden) || ' con causal : ' || to_char(nucausalorder) || ' SE GENERO SOLICITUD CERTIFICACION PRP.';
          pkg_traza.trace(csbMetodo||' sbcomment: '||sbcomment , csbNivelTraza);

          numediorecepcion := dald_parameter.fnuGetNumeric_Value('MEDIO_RECEPCION_CERT_PRP');
          pkg_traza.trace(csbMetodo||' numediorecepcion: '||numediorecepcion , csbNivelTraza);

          sbrequestxml1    := pkg_xml_soli_rev_periodica.getXMSolicitudCertificacionRp (numediorecepcion,  --inuMedioRecepcionId
                                                             sbComment,         --isbComentario
                                                             nuproductid,       --inuProductoId
                                                             nucliente          --inuClienteId
                                                             );

        END IF;
        pkg_traza.trace(csbMetodo||' sbrequestxml1: '||sbrequestxml1 , csbNivelTraza);

        -- Generamos la solicitud y la orden de trabajo
        nupackageid    := NULL;
        numotiveid     := NULL;
        nuerrorcode    := NULL;
        sberrormessage := NULL;
        IF numarca IN (ldcfncretornamarcarevprp,
                       ldcfncretornamarcadefcri,
                       ldcfncretornamarcarepprp,
                       ldcfncretornamarcacerprp) THEN
          API_RegisterRequestByXML(sbrequestxml1,
                                    nupackageid,
                                    numotiveid,
                                    nuerrorcode,
                                    sberrormessage);
          pkg_traza.trace(csbMetodo||'API_RegisterRequestByXML retorna, nupackageid: '||nupackageid||', numotiveid: '||numotiveid , csbNivelTraza);

          IF nupackageid IS NULL THEN
            sbmensa := 'Proceso termino con errores : ' || 'Error al generar la solicitud. Codigo error : ' || to_char(nuerrorcode) || ' Mensaje de error : ' || sberrormessage;
            PKG_ESTAPROC.PRACTUALIZAESTAPROC(sbNameProceso, 'Ok', sbmensa);
            PKG_ERROR.SETERRORMESSAGE(pkg_error.cnugeneric_message, sbmensa);
            RAISE PKG_ERROR.controlled_error;
          ELSE
            -- Verificamos la fecha minima del certificado del producto.
            --CA 833_1
            IF (nuTipoTrabOperaRP > 0 and nuTipoCausal = 1) THEN
              IF nuunitoperadddata IS NOT NULL THEN
                INSERT INTO LDC_ORDENTRAMITERP
                  (ORDEN, TIPOTRABAJO, CAUSAL, SOLICITUD, UNIDADOPERA)
                VALUES
                  (nuorden,
                   nuTipoTrabajo,
                   nucausalorder,
                   nupackageid,
                   NUUNITOPERADDDATA);
                   pkg_traza.trace(csbMetodo||' Registrar Orden legalizada y Solicitud asociada' , csbNivelTraza);
              END IF;
            END IF;

            -- Marcamos el producto
            ldcprocinsactumarcaprodu(nuproductid, numarca, nuorden);
            pkg_traza.trace(csbMetodo||' Actualiza o registra marca de producto' , csbNivelTraza);
            ldcproccrearegistrotramtab(ldc_seq_tramites_revper.nextval,
                                       nuproductid,
                                       nupackageid,
                                       numarca,
                                       numarca,
                                       SYSDATE,
                                       'SE GENERA AL REALIZAR LA RECONEXION DEL PRODUCTO.');
            pkg_traza.trace(csbMetodo||' Registro en la tabla ldc_creatami_revper' , csbNivelTraza);

            -- Dejamos la solicitud como estaba
            IF nuestadosol = 13 THEN
              UPDATE mo_packages m
                 SET m.motive_status_id = 13
               WHERE m.package_id = nupakageid;
               pkg_traza.trace(csbMetodo||' UPDATE motive_status_id en MO_PACKAGES a 13, filas afectadas: '||SQL%ROWCOUNT , csbNivelTraza);
            END IF;

            -- Consultamos si el motivo generado tiene asociado los componentes
            IF numarca = ldcfncretornamarcarepprp THEN
               OPEN cuComponente(numotiveid);
              FETCH cuComponente
               INTO nucontacomponentes;
              CLOSE cuComponente;
              pkg_traza.trace(csbMetodo||' nucontacomponentes: '||nucontacomponentes , csbNivelTraza);

              -- Si el motivo no tine los componentes asociados, se procede a registrarlos
              IF (nucontacomponentes = 0) THEN
              pkg_traza.trace(csbMetodo||' el motivo no tiene los componentes asociados ' , csbNivelTraza);

                FOR i IN (SELECT kl.*
                            FROM pr_component kl
                           WHERE kl.product_id = nuProductId
                             AND kl.component_status_id <> 9
                           ORDER BY kl.component_type_id) LOOP
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
                  rcComponent.category_id          := nucategoria;
                  rcComponent.subcategory_id       := nusubcategori;
                  damo_component.Insrecord(rcComponent);
                  UPDATE pr_component fx
                     SET fx.category_id    = nucategoria,
                         fx.subcategory_id = nusubcategori
                   WHERE fx.component_id = i.component_id;
                  IF i.component_type_id = 7038 THEN
                    nucomppadre := rcComponent.component_id;
                  END IF;
                  IF (nuMotiveId IS NOT NULL) THEN
                    rcmo_comp_link.child_component_id := rcComponent.component_id;
                    IF i.component_type_id = 7039 THEN
                      rcmo_comp_link.father_component_id := nucomppadre;
                    ELSE
                      rcmo_comp_link.father_component_id := NULL;
                    END IF;
                    rcmo_comp_link.motive_id := nuMotiveId;
                    damo_comp_link.insrecord(rcmo_comp_link);
                  END IF;
                END LOOP;
              END IF;
            END IF;
            -- Si la unidad operativa no debe asignar automatica, no se guarda el registro
             OPEN cuExisteUnidOper(nuunidadoperativa);
            FETCH cuExisteUnidOper INTO nucontaexiste;
            CLOSE cuExisteUnidOper;
            pkg_traza.trace(csbMetodo||' ExisteUnidOper: '||nucontaexiste , csbNivelTraza);

            sbflag := ldc_fsbretornaaplicaasigauto(nutasktypeid, nucausalorder);
            IF (nvl(sbflag, 'N') = 'S' AND nucontaexiste = 0) OR
               sbFlagasiAut = 'S' THEN
              ldc_procrearegasiunioprevper(nuunidadoperativa,
                                           nuproductid,
                                           nutasktypeid,
                                           nuorden,
                                           nupackageid);
              IF sbFlagasiAut = 'S' THEN
                INSERT INTO LDC_BLOQ_LEGA_SOLICITUD (PACKAGE_ID_GENE)
                VALUES (nupackageid);
                pkg_traza.trace(csbMetodo||' Bloquea legalizacion por solicitud' , csbNivelTraza);
              END IF;
            END IF;
            sbmensa := 'Proceso termino Ok. Se genero la solicitud Nro : ' ||  to_char(nupackageid);
            pkg_traza.trace(csbMetodo||' sbmensa: '||sbmensa , csbNivelTraza);
            PKG_ESTAPROC.PRACTUALIZAESTAPROC(sbNameProceso, 'Ok', sbmensa);
          END IF;
        ELSE
          sbmensa := 'Proceso termino con Errores. Marca nro ' || numarca || ' no es valida.';
          PKG_ESTAPROC.PRACTUALIZAESTAPROC(sbNameProceso, 'Ok', sbmensa);
          PKG_ERROR.SETERRORMESSAGE(pkg_error.cnugeneric_message, sbmensa);
          RAISE PKG_ERROR.controlled_error;
        END IF;
      END IF;
    END IF;
  ELSE
    sbmensa := 'Error al generar la solicitud para el producto : ' ||  to_char(nuproductid) ||
               ' Tiene las siguientes solicitudes de revisión periodica en estado registradas : ' || TRIM(sbsolicitudes);
    PKG_ESTAPROC.PRACTUALIZAESTAPROC(sbNameProceso, 'Ok', sbmensa);
    PKG_ERROR.SETERRORMESSAGE(pkg_error.cnugeneric_message,  sbmensa);
    RAISE PKG_ERROR.controlled_error;
  END IF;
  pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
EXCEPTION
  WHEN PKG_ERROR.controlled_error THEN
       PKG_ERROR.geterror(nuErrorCode, sbErrorMessage);
       pkg_traza.trace('sbErrorMessage: ' || sbErrorMessage, csbNivelTraza);
       pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
       RAISE;
  WHEN OTHERS THEN
       sbmensa := 'Proceso termino con Errores. ' || SQLERRM;
       PKG_ESTAPROC.PRACTUALIZAESTAPROC(sbNameProceso, sbmensa, 'Ok');
       PKG_ERROR.seterror;
       PKG_ERROR.getError(nuErrorCode, sbErrorMessage);
       pkg_traza.trace('sbErrorMessage: ' || sbErrorMessage, csbNivelTraza);
       pkg_traza.trace(csbMetodo,  csbNivelTraza, pkg_traza.csbFIN_ERR);
       RAISE PKG_ERROR.controlled_error;
END LDCPROCCREATRAMIFLUJOSPRPXML;
/
PROMPT OTORGA PERMISOS ESQUEMA SOBRE PROCEDIMIENTO LDCPROCCREATRAMIFLUJOSPRPXML
BEGIN
    pkg_utilidades.prAplicarPermisos('LDCPROCCREATRAMIFLUJOSPRPXML', 'ADM_PERSON'); 
END;
/
PROMPT OTORGA PERMISOS a REXEREPORTES sobre funcion LDCPROCCREATRAMIFLUJOSPRPXML
GRANT EXECUTE ON ADM_PERSON.LDCPROCCREATRAMIFLUJOSPRPXML TO REXEREPORTES;
/