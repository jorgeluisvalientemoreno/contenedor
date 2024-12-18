create or replace PROCEDURE ldcproccreatramirevprpxml AS
    /**************************************************************************************
    Propiedad Intelectual de Gases del caribe S.A E.S.P
    
    Funcion     : ldcproccreatramirevprpxml
    Descripcion : Procedimiento que crea el tramite de revision por medio de XML
    Autor       : John Jairo Jimenez Marimon
    Fecha       : 16-08-2017

    Historia de Modificaciones
      Fecha               Autor                Modificacion
    =========           =========          ====================
    12/03/2018          jbrito             CASO 200-1743 Cursor cuProducto se modifico para obtener el tipo 
                                           de trabajo real de la
                                           tabla OR_ORDER y no de la tabla or_order_activity
    12/03/2018          jbrito             CASO 200-1743 Se anula el condicional que valida la fecha 
                                           mínima de revisión sea mayor a la fecha  actual
    25/05/2018          Jbrito             caso 200-1956 Se elimino La actualización de la marca 
                                           después de la generación del trámite
    06/12/2023          epenao             OSF-1848:  Modificaciones proyecto organización
                                           +Eliminación código en comentarios.
                                           +Eliminación de la variable dtplazominrev ya que se obtenía 
                                           su valor consultando en la tabla ldc_plazos_cert, pero 
                                           la validaciones que se hacían estaban en comentarios. 
                                           +Cambio de ldc_boutilities.splitstrings por el uso de
                                           regexp_substr.
                                           +Cambio de los select into por métodos que retornan valor de acuerdo
                                           con el resultado de la consulta. 
                                           +Ajuste de traza usando la gestión de traza personalizada. 
                                           +Cambio de or_boorder.fnugetordercausal por
                                             pkg_bcordenes.fnuobtienecausal
                                          +Cambio de or_bolegalizeorder.fnuGetCurrentOrder por
                                             pkg_bcordenes.fnuobtenerotinstancialegal
                                          +Cambia la creación de XML manual por el llamado a 
                                             pkg_xml_soli_rev_periodica.getSolicitudRevisionRp


  ***************************************************************************************/
      
csbMetodo                       CONSTANT VARCHAR2(100) := $$PLSQL_UNIT; --Nombre del método en la traza
csbVAL_TRAMITES_NUEVOS_FLUJOS   CONSTANT ld_parameter.value_chain%type   := dald_parameter.fsbgetvalue_chain('VAL_TRAMITES_NUEVOS_FLUJOS',NULL);
csbESTADO_SOL_REGISTRADA        CONSTANT ld_parameter.numeric_value%type := dald_parameter.fnuGetNumeric_Value('ESTADO_SOL_REGISTRADA');
sbNomProceso                    VARCHAR2(100);
    
CURSOR cusolicitudesabiertas(nucuproducto pr_product.product_id%TYPE) IS
   SELECT pv.package_id colsolicitud
     FROM mo_packages pv,mo_motive mv
    WHERE pv.package_type_id  IN ( SELECT (regexp_substr(csbVAL_TRAMITES_NUEVOS_FLUJOS,'[^,]+', 1, LEVEL)) AS vlrColumna
                                     FROM dual
                                  CONNECT BY regexp_substr(csbVAL_TRAMITES_NUEVOS_FLUJOS, '[^,]+', 1, LEVEL) IS NOT NULL  
                                 )
      AND pv.motive_status_id = csbESTADO_SOL_REGISTRADA
      AND mv.product_id       = nucuproducto
      AND pv.package_id       = mv.package_id;

    nuErrorCode         NUMBER;
    sbErrorMessage      VARCHAR2(4000);
    nuPackageId         mo_packages.package_id%type;
    nuMotiveId          mo_motive.motive_id%type;
    sbrequestxml1       constants_per.TIPO_XML_SOL%type;    
    nuorden             or_order.order_id%type;
    sbComment           or_order_comment.order_comment%TYPE;
    nuProductId         NUMBER;
    nuContratoId        NUMBER;
    nuTaskTypeId        NUMBER;
    nuCausalOrder       NUMBER;
    ex_error            EXCEPTION;
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
    numarca             ld_parameter.numeric_value%TYPE;
    numarcaantes        ldc_marca_producto.suspension_type_id%TYPE;
    sbflag              VARCHAR2(1);
    nuunidadoperativa   or_order.operating_unit_id%TYPE;
    sbsolicitudes       VARCHAR2(1000);
    nusaldodiferi       diferido.difesape%TYPE;
  --Cursor que obtiene el producto, el contrato del producto y el tipo de trabajo de acuerdo a la orden instanciada
  CURSOR cuProducto(nuorden NUMBER) IS
    SELECT product_id, subscription_id, ot.task_type_id,package_id,oa.subscriber_id,ot.operating_unit_id
     FROM or_order_activity oa,or_order ot
    WHERE oa.order_id = nuorden
      AND package_id IS NOT NULL
      AND oa.order_id = ot.order_id
      AND rownum   = 1;
  
  function fnuInfoProd return NUMBER 
  IS
      cursor cuInfoprod is 
        SELECT di.address_parsed
        ,di.address_id
        ,di.geograp_location_id
        ,pr.category_id
        ,pr.subcategory_id
    FROM pr_product pr,ab_address di
    WHERE pr.product_id = nuproductid
        AND pr.address_id = di.address_id;

    nuretorno  number := 1;
  begin
      
    open cuInfoprod;
         fetch cuInfoprod into sbdireccionparseada
                               ,nudireccion
                               ,nulocalidad
                               ,nucategoria
                               ,nusubcategori;
    close cuInfoprod;    
    if sbdireccionparseada is null then 
        nuretorno := 0;
    end if;    
    
    return nuretorno;

  end fnuInfoProd;



BEGIN
 pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbINICIO);
 -- Inicializamos el proceso
 sbNomProceso :=  csbMetodo||TO_CHAR(SYSDATE,'DDMMYYYYHH24MISS');
 pkg_estaproc.prInsertaEstaproc(isbProceso  => sbNomProceso,
                               inuTotalRegi => NULL);
  
 --Obtener el identificador de la orden  que se encuentra en la instancia
 nuorden           := pkg_bcordenes.fnuobtenerotinstancialegal;
 nucausalorder     := pkg_bcordenes.fnuobtienecausal(nuorden); 
 pkg_traza.trace('Numero de la Orden:'||nuorden,pkg_traza.cnuNivelTrzDef);
 
 -- obtenemos el producto y el paquete
    OPEN cuproducto(nuorden);
     FETCH cuProducto INTO nuproductid, nucontratoid, nutasktypeid,nupakageid,nucliente,nuunidadoperativa;
     IF cuProducto%NOTFOUND THEN
         sbmensa := 'Proceso termino con errores : '||'El cursor cuProducto no arrojo datos con el # de orden'||to_char(nuorden);
         pkg_estaproc.practualizaestaproc( sbNomProceso, 'Ok ', sbmensa);
         pkg_error.setErrorMessage(isbMsgErrr => sbmensa);
    END IF;
   CLOSE cuproducto;
   pkg_traza.trace('Salio cursor cuProducto, nuProductId: '||nuProductId||'nuContratoId:'||'nuTaskTypeId:'||nuTaskTypeId,pkg_traza.cnuNivelTrzDef);
   
   -- Verificamos si el producto tiene saldo diferido en los conceptos 739 y 755
   nusaldodiferi := ldc_fncretornasalddifvisita(nuproductid);
   IF nusaldodiferi <> 0 THEN
    sbmensa := 'Proceso termino con errores : producto : '||to_char(nuproductid)||' tiene diferidos con saldo del concepto 739 y/o 755. Saldo : '||to_char(nusaldodiferi);   
    pkg_estaproc.practualizaestaproc( sbNomProceso, 'O', sbmensa  );
    pkg_error.setErrorMessage(isbMsgErrr => sbmensa);     
   END IF;

   -- Actualizamos las solicitud que se esta legalizando para que no salga como pendiente
  UPDATE mo_packages m
     SET m.motive_status_id = 14
   WHERE m.package_id       = nupakageid;
  -- Buscamos solicitudes de revisión periodica generadas
  sbsolicitudes := NULL;
  FOR i IN cusolicitudesabiertas(nuproductid) LOOP
   IF sbsolicitudes IS NULL THEN
    sbsolicitudes := i.colsolicitud;
   ELSE
    sbsolicitudes := sbsolicitudes||','||to_char(i.colsolicitud);
   END IF;
  END LOOP;
  IF TRIM(sbsolicitudes) IS NULL THEN
     -- Obtenemos los datos de la solicitud de visita de verificacion para generar el tramite de control de defecto critico
     sbdireccionparseada := NULL;
     nudireccion         := NULL;
     nulocalidad         := NULL;
     nucategoria         := NULL;
     nusubcategori       := NULL;
     sw                  := 1;
     
    --Cambio del select into
    sw := fnuInfoProd;
     
    IF sw = 1 THEN
     -- Construimos XML para generar el tramite
     nupackageid      := NULL;
     numotiveid       := NULL;
     nuerrorcode      := NULL;
     sberrormessage   := NULL;
     sbcomment        := substr(ldc_retornacomentotlega(nuorden),1,2000)||' ord?n legalizada : '||to_char(nuorden)||' con causal : '||to_char(nucausalorder);
     numediorecepcion := dald_parameter.fnuGetNumeric_Value('MEDIO_RECEPCION_VISITA');


    --Creación XML para registro de la solicitud: P_LDC_SOLICITUD_VISITA_IDENTIFICACION_CERTIFICADO_100237
    sbrequestxml1 := pkg_xml_soli_rev_periodica.getSolicitudRevisionRp(inuMedioRecepcionId  => numediorecepcion,
                                                                       isbComentario    => sbComment,
                                                                       inuProductoId    => nuproductid,
                                                                       inuClienteId     => nucliente
                                                                      );
    pkg_traza.trace('XML: '||sbrequestxml1,pkg_traza.cnuNivelTrzDef);                                                                      
    -- Se crea la solicitud y la orden de trabajo
    api_registerrequestbyxml(
                             sbrequestxml1,
                             nupackageid,
                             numotiveid,
                             nuerrorcode,
                             sberrormessage
                            );

   

     IF nupackageid IS NULL THEN
      sbmensa := 'Proceso termino con errores : '||'Error al generar la solicitud de control de visita identificacion de certificado. Codigo error : '||to_char(nuerrorcode)||' Mensaje de error : '||sberrormessage;       
      pkg_estaproc.practualizaestaproc( sbNomProceso, 'Ok', sbmensa);
      pkg_error.setErrorMessage(isbMsgErrr => sbmensa);       
     ELSE
      -- Verificamos la fecha minima del certificado del producto.
       ldcproccrearegistrotramtab(ldc_seq_tramites_revper.nextval,nuproductid,nupackageid,numarcaantes,numarca,SYSDATE,'Se atiende la solicitud nro : '||to_char(nupakageid));

       sbflag := ldc_fsbretornaaplicaasigauto(nutasktypeid,nucausalorder);
       IF nvl(sbflag,'N') = 'S' THEN
        ldc_procrearegasiunioprevper(nuunidadoperativa,nuproductid,nutasktypeid,nuorden,nupackageid);
       END IF;
        -- Dejamos la solicitud como estaba
          UPDATE open.mo_packages m
             SET m.motive_status_id = 13
           WHERE m.package_id       = nupakageid;
       sbmensa := 'Proceso termino Ok. Se genero la solicitud Nro : '||to_char(nupackageid);
        
       pkg_estaproc.practualizaestaproc( sbNomProceso, 'Ok', sbmensa);
     END IF;
    ELSE
      sbmensa := 'Proceso termino con errores : '||'No se encontraron datos de la solicitud asociada a la orden # '||to_char(nuorden);
       
      pkg_estaproc.practualizaestaproc( sbNomProceso, 'Ok', sbmensa);
      pkg_error.setErrorMessage(isbMsgErrr => sbmensa);
    END IF;
   ELSE
     sbmensa := 'Error al generar la solicitud para el producto : '||to_char(nuproductid)||' Tiene las siguientes solicitudes de revisi?n periodica en estado registradas : '||TRIM(sbsolicitudes);
     
     pkg_estaproc.practualizaestaproc( sbNomProceso, 'Ok', sbmensa);
     pkg_error.setErrorMessage(isbMsgErrr => sbmensa);
   END IF;
pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN);   
EXCEPTION
 WHEN PKG_ERROR.CONTROLLED_ERROR THEN  
  pkg_error.getError(nuErrorCode, sbErrorMessage);
  pkg_traza.trace('Error:'||nuErrorCode||'-'||sbErrorMessage,pkg_traza.cnuNivelTrzDef);
  pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERC);  
  RAISE PKG_ERROR.CONTROLLED_ERROR;

 WHEN OTHERS THEN
  sbmensa := 'Proceso termino con Errores. '||SQLERRM;  
  pkg_estaproc.practualizaestaproc( sbNomProceso, 'Error', sbmensa);
  Pkg_Error.setError;
  pkg_error.getError(nuErrorCode, sbErrorMessage);
  pkg_traza.trace('Error:'||nuErrorCode||'-'||sbErrorMessage,pkg_traza.cnuNivelTrzDef);
  pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);
  RAISE PKG_ERROR.CONTROLLED_ERROR;
END ldcproccreatramirevprpxml;
/
PROMPT Asignación de permisos para el paquete ldcproccreatramirevprpxml
begin
  pkg_utilidades.prAplicarPermisos('LDCPROCCREATRAMIREVPRPXML', 'OPEN');
end;
/
