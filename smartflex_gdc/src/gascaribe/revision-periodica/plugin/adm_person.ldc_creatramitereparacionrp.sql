create or replace PROCEDURE adm_person.ldc_creatramitereparacionrp AS

  /**************************************************************************
  
    Propiedad Intelectual de Gases del caribe S.A E.S.P

    Funcion     : LDC_CREATRAMITEREPARACIONRP

    Descripcion : Procedimiento que crea el tramite de certificacion por revision periodica por medio de XML, 
  
  
    Historia de Modificaciones
     Fecha               Autor               Modificacion  
    =========           =========         ====================  
    24/07/2018           lsalazar         Caso 200-2063 (Se modifico el cursor cuComponente  
                                          cambiando la validacion "c.package_id = nucumotivos" por  
                                          "c.motive_id = nucumotivos" )  
    27/07/2018           lsalazar         Caso 200-2063 Cambio Alcance (Agregar comentario de la orden padre al  
                                          inicio del comentario del tramite a generar)
    31/08/2018          dsaltarin         2002017 se modificar para agregar <?xml version="1.0" encoding="ISO-8859-1"?> al xml del tramite  
    01/03/2021          LJLB              CA 472 se coloca llamado a funcion LDC_PKGESTIONLEGAORRP.FNUGETSOLIREPA
    11/08/2021          Horbath           CA 767: se coloca llamado a funcion FBLGENERATRAMITEREPARA, para valida si el,
                                          producto relacionado con la orden es apto para generar el trammite.
    25/11/2021          DANVAL            CA 833_1 : Validaciones del caso para la asignacion automatica de las unidades operativas de los datos adicionales definidos  
    21/11/2023          epenao            OSF-1830
                                          Proyecto Organización 
                                          +Cambio dage_causal.fnugetclass_causal_id x pkg_bcordenes.fnuobtieneclasecausal                                          
                                          +Eliminación validaciones con el método FBLAPLICAENTREGAXCASO
                                          +Cambio daor_operating_unit.fblexist x pkg_bcunidadoperativa.fblexiste
                                          +Cambio Daor_order.fnugettask_type_id x pkg_bcordenes.fnuobtienetipotrabajo
                                          +Cambio or_bolegalizeorder.fnuGetCurrentOrder x pkg_bcordenes.fnuobtenerotinstancialegal
                                          +Cambio  or_boorder.fnugetordercausal x pkg_bcordenes.fnuobtienecausal
                                          +Cambio el uso de ldc_boutilities.splitstrings x regexp_substr
                                          +Eliminación de variables no utilizadas.
    15/05/20234         Adrianavg         OSF-2673: Se migra del esquema OPEN al esquema ADM_PERSON
  **************************************************************************/
   csbNOMPROCEDIMIENTO          	CONSTANT VARCHAR2(35):= $$PLSQL_UNIT; -- Constantes para el control de la traza
   csbVAL_TRAMITES_NUEVOS_FLUJOS  CONSTANT ld_parameter.value_chain%type := dald_parameter.fsbgetvalue_chain('VAL_TRAMITES_NUEVOS_FLUJOS',NULL) ;
  --CA 833_1
  sbTipoTrabOperaRP ldc_pararepe.paravast%type := DALDC_PARAREPE.FSBGETPARAVAST('TIPOTRABAJO_OPERARP',NULL);

  nuTipoTrabOperaRP number;
  nuTipoCausal      number;
  nuTipoTrabajo     number;
  sbDatoAdicional   ldc_pararepe.paravast%type := DALDC_PARAREPE.fsbGetPARAVAST('DATOADICION_UNIDADOPER',NULL);
  nuCodDatoAdicic   ldc_pararepe.parevanu%type := DALDC_PARAREPE.fnuGetPAREVANU('COD_DATOADICION_UNIDADOPER',NULL);

  NUUNITOPERADDDATA number := null;
  sbValorPRCDA      varchar2(2000);
  nuExisteOU        number;
  --
  CURSOR cusolicitudesabiertas(nucuproducto pr_product.product_id%TYPE) IS
    SELECT pv.package_id colsolicitud
      FROM mo_packages pv, mo_motive mv
     WHERE pv.package_type_id IN
           ( SELECT vlrColumna
              FROM (SELECT to_number(regexp_substr(csbVAL_TRAMITES_NUEVOS_FLUJOS,'[^,]+', 1, LEVEL)) AS vlrColumna
                      FROM dual
                    CONNECT BY regexp_substr(csbVAL_TRAMITES_NUEVOS_FLUJOS, '[^,]+', 1, LEVEL) IS NOT NULL   
                   )
            )            
       AND pv.motive_status_id =
           dald_parameter.fnuGetNumeric_Value('ESTADO_SOL_REGISTRADA')
       AND mv.product_id = nucuproducto
       AND pv.package_id = mv.package_id;

  nuErrorCode         NUMBER;
  sbErrorMessage      VARCHAR2(4000);
  nuPackageId         mo_packages.package_id%type := null;
  nuMotiveId          mo_motive.motive_id%type;

  nuorden             or_order.order_id%type;
  sbComment           VARCHAR2(2000);
  nuProductId         NUMBER;
  nuContratoId        NUMBER;
  nuTaskTypeId        NUMBER;
  nuCausalOrder       NUMBER;
  
  nupakageid          mo_packages.package_id%TYPE := null;
  nucliente           ge_subscriber.subscriber_id%TYPE;
  numediorecepcion    mo_packages.reception_type_id%TYPE;
  sbdireccionparseada ab_address.address_parsed%TYPE;
  nudireccion         ab_address.address_id%TYPE;
  nulocalidad         ab_address.geograp_location_id%TYPE;
  nucategoria         mo_motive.category_id%TYPE;
  nusubcategori       mo_motive.subcategory_id%TYPE;
  sw                  NUMBER(2) DEFAULT 0; 
  sbmensa             VARCHAR2(10000);
  sbsolicitudes       VARCHAR2(1000);
  sbflag              VARCHAR2(1);
  nuunidadoperativa or_order.operating_unit_id%TYPE;

  --767
  dtExecFinal or_order.execution_final_date%TYPE; --caso: 767
  
  --Variables para la gestión del proceso
  sbProceso   VARCHAR2(100);

  --Cursor que obtiene el producto, el contrato del producto y el tipo de trabajo de acuerdo a la orden instanciada
  CURSOR cuProducto(nuorden NUMBER) IS
    SELECT product_id,
           subscription_id,
           ot.task_type_id,
           package_id,
           at.subscriber_id,
           ot.operating_unit_id,
           execution_final_date --caso: 767
      FROM or_order_activity at, or_order ot
     WHERE at.order_id = nuorden
       AND package_id IS NOT NULL
       AND at.order_id = ot.order_id
       AND rownum = 1;

  -- Cursor para obtener los componentes asociados a un motivo
  CURSOR cuComponente(nucumotivos mo_motive.motive_id%TYPE) IS
    SELECT COUNT(1) FROM mo_component C WHERE c.motive_id = nucumotivos;

function fnuValDireccion(inuproducto in pr_product.product_id%type) return number is 
    cursor cuDireccion is 
        SELECT di.address_parsed,
                di.address_id,
                di.geograp_location_id,
                pr.category_id,
                pr.subcategory_id
            FROM pr_product pr, ab_address di
        WHERE pr.product_id = inuproducto
            AND pr.address_id = di.address_id;

       nuretorno number := 1;
  begin       
      open cuDireccion;
           fetch cuDireccion into
                 sbdireccionparseada, 
                 nudireccion,
                 nulocalidad,
                 nucategoria,
                 nusubcategori;
      close cuDireccion;

      if sbdireccionparseada is null then
          nuretorno := 0;
      end if;
      return nuretorno;        
      
  end fnuValDireccion;

   
BEGIN
  pkg_traza.trace(csbNOMPROCEDIMIENTO,pkg_traza.cnuNivelTrzDef,pkg_traza.csbINICIO);
  
  --Obtener el identificador de la orden  que se encuentra en la instancia
  nuorden := pkg_bcordenes.fnuobtenerotinstancialegal;

  -- Inicializamos el proceso
  sbProceso := csbNOMPROCEDIMIENTO||TO_CHAR(SYSDATE,'DDMMYYYYHH24MISS');
  
  pkg_estaproc.prinsertaestaproc(sbProceso,                          
                                 NULL
                                 ); --767
  nucausalorder := pkg_bcordenes.fnuobtienecausal(nuorden);
  
  pkg_traza.trace('Numero de la Orden:' || nuorden,pkg_traza.cnuNivelTrzDef);

    --Si el Tipo de Trabajo está definido en el  Parámetro TIPOTRABAJO_OPERARP y la causal es de éxito
    nuExisteOU := 0;
    sbValorPRCDA := ldc_boordenes.fsbDatoAdicTmpOrden(nuorden,nuCodDatoAdicic,TRIM(sbDatoAdicional));
    if sbValorPRCDA is not null then
       nuUnitOperAdddata := to_number(sbValorPRCDA);
       if pkg_bcunidadoperativa.fblexiste(nuUnitOperAdddata ) then
          nuExisteOU :=1;
       else
          nuExisteOU :=0;
          sbmensa := 'Proceso termino con errores : La Unidad Operativa [' ||
                     NUUNITOPERADDDATA ||
                     '] registrada en el Dato Adicional [' ||
                     sbDatoAdicional || '] no existe';
          pkg_error.setErrorMessage(isbMsgErrr => sbmensa); 
          
       end if;
    end if;
    nuTipoTrabajo := pkg_bcordenes.fnuobtienetipotrabajo(nuorden);
    select count(1)
      into nuTipoTrabOperaRP
      from dual
     where nuTipoTrabajo in (
                            SELECT to_number(regexp_substr(sbTipoTrabOperaRP,'[^,]+', 1, LEVEL)) AS vlrColumna
                              FROM dual
                           CONNECT BY regexp_substr(sbTipoTrabOperaRP, '[^,]+', 1, LEVEL) IS NOT NULL   
                            )  
     ;

      nuTipoCausal := pkg_bcordenes.fnuobtieneclasecausal(nucausalorder);


  -- obtenemos el producto y el paquete
  OPEN cuproducto(nuorden);
  FETCH cuProducto
    INTO nuproductid,
         nucontratoid,
         nutasktypeid,
         nupakageid,
         nucliente,
         nuunidadoperativa,
         dtExecFinal --caso: 0000767
  ;

  IF cuProducto%NOTFOUND THEN

    sbmensa := 'Proceso termino con errores : ' ||
               'El cursor cuProducto no arrojo datos con el # de orden' ||
               to_char(nuorden);
    
  
    pkg_estaproc.prActualizaEstaproc(isbProceso     => sbProceso,
                                    isbEstado      => 'OK',
                                    isbObservacion => sbmensa
                                    );
                              
     
    CLOSE cuproducto;
    pkg_error.setErrorMessage(isbMsgErrr => sbmensa);

  END IF;

  
  pkg_traza.trace('Salio cursor cuProducto, nuProductId: ' || nuProductId ||
                 'nuContratoId:' || 'nuTaskTypeId:' || nuTaskTypeId,pkg_traza.cnuNivelTrzDef);
  --Inicio caso:0000767
  -- Se valida si el producto de la orden es apto para generar tramite de rp   
  IF NUUNITOPERADDDATA is null THEN
    IF FBLGENERATRAMITEREPARA(nutasktypeid, nuProductId, dtExecFinal) =
       FALSE THEN      
      pkg_traza.trace('LDC_CREATRAMITEREPARACIONRP: No genera tramite de RP',pkg_traza.cnuNivelTrzDef);
      
      sbmensa := 'OT:' || nuorden ||
                 '.Usuario vencido no se genera tramite : ';
      
          
      pkg_estaproc.prActualizaEstaproc(isbProceso     => sbProceso,
                                      isbEstado      => 'OK',
                                      isbObservacion => sbmensa
                                     );

      GOTO NoGeneraRp;
    END IF;
  END IF;
  --fin caso:0000767
  -- Actualizamos las solicitud que se esta legalizando para que no salga como pendiente
  UPDATE mo_packages m
     SET m.motive_status_id = 14
   WHERE m.package_id = nupakageid;

  -- Buscamos solicitudes de revisión periodica generadas
  sbsolicitudes := NULL;

  FOR i IN cusolicitudesabiertas(nuproductid) LOOP
    IF sbsolicitudes IS NULL THEN
      sbsolicitudes := i.colsolicitud;
    ELSE
      sbsolicitudes := sbsolicitudes || ',' || to_char(i.colsolicitud);
    END IF;

  END LOOP;

  IF TRIM(sbsolicitudes) IS NULL THEN

    -- Obtenemos los datos de la solicitud de visita de verificacion para generar el tramite de defecto critico
    sbdireccionparseada := NULL;
    nudireccion := NULL;
    nulocalidad := NULL;
    nucategoria := NULL;
    nusubcategori := NULL;
 
    sw := fnuValDireccion(nuproductid);--Retorna cero cuando no encuentra datos.
    IF sw = 1 THEN
      nupackageid    := NULL;
      numotiveid     := NULL;
      nuerrorcode    := NULL;
      sberrormessage := NULL;
      sbcomment      := substr(ldc_retornacomentotlega(nuorden), 1, 2000) ||
                        dald_parameter.fsbGetValue_Chain('COMENTARIO_REPARACION_PRP') ||
                        ' AL LEGALIZAR ORDEN : ' || to_char(nuorden) ||
                        ' CON CAUSAL : ' || to_char(nucausalorder);

      numediorecepcion := dald_parameter.fnuGetNumeric_Value('MEDIO_RECEPCION_REPARACION_PRP');
         
      sbcomment  := substr(pkg_bcunidadoperativa.fsbgetnombre(nuunidadoperativa) || '-' ||
                           sbcomment,
                           1,
                           1999);
      nupackageid := LDC_PKGESTIONLEGAORRP.FNUGETSOLIREPA(nuproductid,
                                                         nucontratoid,
                                                         nucliente,
                                                         numediorecepcion,
                                                         sbcomment,
                                                         sbdireccionparseada,
                                                         nudireccion,
                                                         nulocalidad,
                                                         nucategoria,
                                                         nusubcategori,
                                                         nuerrorcode,
                                                         sberrormessage);

      IF nupackageid IS NULL THEN
          sbmensa := 'OT:' || nuorden || '.Proceso termino con errores : ' ||
                  'Error al generar la solicitud de reparacion prp. Codigo error : ' ||
                  to_char(nuerrorcode) || ' Mensaje de error : ' ||
                  sberrormessage;
     
          pkg_estaproc.prActualizaEstaproc(isbProceso     => sbProceso,
                                          isbEstado      => 'OK',
                                          isbObservacion => sbmensa
                                         );
                                       
      ELSE
         sbflag := ldc_fsbretornaaplicaasigauto(nutasktypeid,
                                              nucausalorder);
         IF nvl(sbflag, 'N') = 'S' THEN
            ldc_procrearegasiunioprevper(nuunidadoperativa,
                                      nuproductid,
                                      nutasktypeid,
                                      nuorden,
                                      nupackageid);
        END IF;
        sbmensa := 'OT:' || nuorden ||
                  '.Proceso termino Ok. Se genero la solicitud Nro : ' ||
                  to_char(nupackageid);
        pkg_estaproc.prActualizaEstaproc(isbProceso     => sbProceso,
                                         isbEstado      => 'OK',
                                         isbObservacion => sbmensa
                                        );
      END IF;
      --CA 833_1
      --Se registrará en la tabla LDC_ORDENTRAMITERP la Orden legalizada, Tipo de Trabajo de la orden, 
      --Causal de legalización de la orden, el Id de la Solicitud Generada y el NUUNITOPERADDDATA (Unidad Operativa del dato adicional)
      --Se modifica el sitio de la validacion pues dependiendo de la aplicacion de una entrega se aplica este codigo       
      IF (nuTipoTrabOperaRP > 0 and nuTipoCausal = 1) THEN
          IF nupackageid is not null THEN
            if NUUNITOPERADDDATA is not null then
              insert into LDC_ORDENTRAMITERP
                (ORDEN, TIPOTRABAJO, CAUSAL, SOLICITUD, UNIDADOPERA)
              values
                (nuorden,
                nuTipoTrabajo,
                nucausalorder,
                nupackageid,
                NUUNITOPERADDDATA);
            end if;
          end if;
      end if;
    ELSE
        sbmensa := 'OT:' || nuorden || '.Proceso termino con errores : ' ||
                   'No se encontraron datos de la solicitud asociada a la orden # ' ||
                   to_char(nuorden);
    
      pkg_estaproc.prActualizaEstaproc(isbProceso     => sbProceso,
                                      isbEstado      => 'OK',
                                      isbObservacion => sbmensa
                                     );

    END IF;
  ELSE
      sbmensa := 'OT:' || nuorden ||
                '.Error al generar la solicitud para el producto : ' ||
                to_char(nuproductid) ||
                ' Tiene las siguientes solicitudes de revisi?n periodica en estado registradas : ' ||
                TRIM(sbsolicitudes);

        
      pkg_estaproc.prActualizaEstaproc(isbProceso     => sbProceso,
                                      isbEstado      => 'OK',
                                      isbObservacion => sbmensa
                                     );


  END IF;
  <<NoGeneraRp>> --caso:767  
  pkg_traza.trace(csbNOMPROCEDIMIENTO,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN);

EXCEPTION

  WHEN PKG_ERROR.CONTROLLED_ERROR THEN
    pkg_error.geterror(nuErrorCode, sbmensa);
    pkg_traza.trace('nuErrorCode:'||nuErrorCode||'-'||sbmensa,pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace(csbNOMPROCEDIMIENTO,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERC);
   
    pkg_estaproc.prActualizaEstaproc(isbProceso     => sbProceso,
                                      isbEstado      => 'OK',
                                      isbObservacion => sbmensa
                                     );   
    RAISE PKG_ERROR.CONTROLLED_ERROR;
  WHEN OTHERS THEN
    sbmensa := 'Proceso termino con Errores. ' || SQLERRM;    
    
    pkg_estaproc.prActualizaEstaproc(isbProceso     => sbProceso,
                                     isbEstado      => 'OK',
                                     isbObservacion => sbmensa
                                    );                                  
    pkg_error.seterror;
    pkg_error.geterror(nuErrorCode, sbmensa);
    pkg_traza.trace('nuErrorCode:'||nuErrorCode||'-'||sbmensa,pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace(csbNOMPROCEDIMIENTO,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);
    RAISE PKG_ERROR.CONTROLLED_ERROR;

END LDC_CREATRAMITEREPARACIONRP;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre LDC_CREATRAMITEREPARACIONRP
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_CREATRAMITEREPARACIONRP', 'ADM_PERSON'); 
END;
/
PROMPT OTORGA PERMISOS a REXEINNOVA sobre LDC_CREATRAMITEREPARACIONRP
GRANT EXECUTE ON ADM_PERSON.LDC_CREATRAMITEREPARACIONRP TO REXEINNOVA;
/