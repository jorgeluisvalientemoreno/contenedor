CREATE OR REPLACE PROCEDURE adm_person.LDC_PROCREATRAMITECERTI
AS
    /**************************************************************************

        Propiedad Intelectual de Gases del caribe S.A E.S.P



        Funcion     : ldcproccreatramicerprptxml

        Descripcion : Procedimiento que crea el tramite de certificacion por revision periodica por medio de XML,

                      de la misma forma como lo hace ldcproccreatramicerprptxml.





        Historia de Modificaciones

          Fecha               Autor                Modificacion

        =========          =========          ====================

        27/07/2018         lsalazar           Caso 200-2063 Cambio Alcance (Agregar comentario de la orden padre al

                                               inicio del comentario del tramite a generar)
        31/08/2018         dsaltarin           2002017 se modificar para agregar <?xml version="1.0" encoding="ISO-8859-1"?> al xml del tramite
        16/03/2021         LJLB                CA 472 se coloca logica para llamar funcion LDC_PKGESTIONLEGAORRP .FNUGETSOLICERTRP para que genere el
                                               tramite de certificacion.

        11/08/2021         Horbath             CA 767: se coloca llamado a funcion FBLGENERATRAMITEREPARA, para valida si el,
                                               producto relacionado con la orden es apto para generar el trammite.
        25/11/2021         DANVAL              CA 833_1 : Validaciones del caso para la asignacion automatica de las unidades operativas de los datos adicionales definidos
        23/11/2023         epenao              OSF-1863
                                               +Cambio ldc_proinsertaestaprogv2 X pkg_estaproc.prinsertaestaproc
                                               +Cambio ldc_proactualizaestaprogv2 x pkg_estaproc.practualizaestaproc
                                               +Eliminación de las validacions FBLAPLICAENTREGAXCASO.
                                               +Cambio el uso de ldc_boutilities.splitstrings x regexp_substr
                                               +Cambio de traza para que se use el objeto personalizado pkg_traza
                                               +Cambio del manejo de errores para que se use el objeto personalizado pkg_traza
        26/04/2024         PACOSTA             OSF-2598: Se crea el objeto en el esquema adm_person 
    **************************************************************************/
    
    csbMetodo             	       CONSTANT VARCHAR2(35):= $$PLSQL_UNIT; -- Constantes para el control de la traza
    csbVAL_TRAMITES_NUEVOS_FLUJOS  CONSTANT  ld_parameter.value_chain%TYPE := dald_parameter.fsbgetvalue_chain ('VAL_TRAMITES_NUEVOS_FLUJOS',NULL);
    sbproceso                      VARCHAR2(100);

    --CA 833_1
    sbTipoTrabOperaRP     ldc_pararepe.paravast%TYPE
        := DALDC_PARAREPE.FSBGETPARAVAST ('TIPOTRABAJO_OPERARP', NULL);
    nuTipoTrabOperaRP     NUMBER;
    nuTipoCausal          NUMBER;
    nuTipoTrabajo         NUMBER;
    sbDatoAdicional       ldc_pararepe.paravast%TYPE
        := DALDC_PARAREPE.fsbGetPARAVAST ('DATOADICION_UNIDADOPER',
                                               NULL);
    nuCodDatoAdicic       ldc_pararepe.parevanu%TYPE
        := DALDC_PARAREPE.fnuGetPAREVANU ('COD_DATOADICION_UNIDADOPER',
                                               NULL);
    NUUNITOPERADDDATA     NUMBER := NULL;
    sbValorPRCDA          VARCHAR2 (2000);
    nuExisteOU            NUMBER;

    --
    CURSOR cusolicitudesabiertas (nucuproducto pr_product.product_id%TYPE)
    IS
        SELECT pv.package_id     colsolicitud
          FROM mo_packages pv, mo_motive mv
         WHERE     pv.package_type_id IN
                       ( SELECT (regexp_substr(csbVAL_TRAMITES_NUEVOS_FLUJOS,'[^,]+', 1, LEVEL)) AS vlrColumna
                           FROM dual
                        CONNECT BY regexp_substr(csbVAL_TRAMITES_NUEVOS_FLUJOS, '[^,]+', 1, LEVEL) IS NOT NULL        
                        )
               AND pv.motive_status_id =
                   dald_parameter.fnuGetNumeric_Value (
                       'ESTADO_SOL_REGISTRADA')
               AND mv.product_id = nucuproducto
               AND pv.package_id = mv.package_id;

    nuErrorCode           NUMBER;

    sbErrorMessage        VARCHAR2 (4000);
    nuPackageId           mo_packages.package_id%TYPE;

    nuorden               or_order.order_id%TYPE;
    sbComment             VARCHAR2 (2000);
    nuProductId           NUMBER;
    nuContratoId          NUMBER;
    nuTaskTypeId          NUMBER;
    nuCausalOrder         NUMBER;

    nupakageid            mo_packages.package_id%TYPE;
    nucliente             ge_subscriber.subscriber_id%TYPE;
    numediorecepcion      mo_packages.reception_type_id%TYPE;
    sbdireccionparseada   ab_address.address_parsed%TYPE;
    nudireccion           ab_address.address_id%TYPE;
    nulocalidad           ab_address.geograp_location_id%TYPE;
    nucategoria           mo_motive.category_id%TYPE;
    nusubcategori         mo_motive.subcategory_id%TYPE;
    sbmensa               VARCHAR2 (10000);
    nucantotleg           NUMBER (8);
    sbsolicitudes         VARCHAR2 (1000);


    --Cursor que obtiene el producto, el contrato del producto y el tipo de trabajo de acuerdo a la orden instanciada
    CURSOR cuProducto (nuorden NUMBER)
    IS
        SELECT product_id,
               subscription_id,
               ot.task_type_id,
               package_id,
               at.subscriber_id,
               ot.operating_unit_id,
               execution_final_date  --caso: 767
          FROM or_order_activity at, or_order ot
         WHERE     at.order_id = nuorden
               AND package_id IS NOT NULL
               AND at.order_id = ot.order_id
               AND ROWNUM = 1;

    cursor cuTipoTrabOperaRP is
    SELECT COUNT (1)    
        FROM DUAL
        WHERE nuTipoTrabajo IN
                ( SELECT (regexp_substr(sbTipoTrabOperaRP,'[^,]+', 1, LEVEL)) AS vlrColumna
                    FROM dual
                 CONNECT BY regexp_substr(sbTipoTrabOperaRP, '[^,]+', 1, LEVEL) IS NOT NULL );         

    cursor cucantotleg is
    SELECT COUNT (1)      
      FROM or_order_activity oal, or_order otl
     WHERE oal.package_id = nupakageid
           AND otl.task_type_id <>
               dald_parameter.fnuGetNumeric_Value (  'TIPO_TRABAJO_DOC_TRAM_REP',NULL)
           AND otl.order_status_id NOT IN (8, 12)
           AND oal.order_id = otl.order_id;                       

    sbflag                VARCHAR2 (1);
    nuunidadoperativa     or_order.operating_unit_id%TYPE;
    dtExecFinal           or_order.execution_final_date%TYPE;   --caso: 767

BEGIN
    
    pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbINICIO);
    sbproceso := csbMetodo||TO_CHAR(SYSDATE,'DDMMYYYYHH24MISS');

    --Obtener el identificador de la orden  que se encuentra en la instancia
    nuorden := pkg_bcordenes.fnuobtenerotinstancialegal; 
    pkg_traza.trace('Numero de la Orden:'|| nuorden,pkg_traza.cnuNivelTrzDef);    
    nucausalorder := pkg_bcordenes.fnuobtienecausal(nuorden);
    pkg_traza.trace('nucausalorder:' || nucausalorder,pkg_traza.cnuNivelTrzDef);
    
    -- Inicializamos el proceso    
    pkg_estaproc.prinsertaestaproc( sbproceso , null);                         

    --CA 833_1
    --Si el Tipo de Trabajo está definido en el  Parámetro TIPOTRABAJO_OPERARP y la causal es de éxito
    nuExisteOU := 0;
    sbValorPRCDA :=  ldc_boordenes.fsbDatoAdicTmpOrden (nuorden,
                                                       nuCodDatoAdicic,
                                                       TRIM (sbDatoAdicional));

    IF sbValorPRCDA IS NOT NULL
    THEN
        nuUnitOperAdddata := TO_NUMBER (sbValorPRCDA);

        IF pkg_bcunidadoperativa.fblexiste(nuUnitOperAdddata) 
        THEN
            nuExisteOU := 1;
        ELSE
            nuExisteOU := 0;
            sbmensa := 'Proceso termino con errores : La Unidad Operativa ['
                      || NUUNITOPERADDDATA
                      || '] registrada en el Dato Adicional ['
                      || sbDatoAdicional
                      || '] no existe';
            pkg_error.seterrormessage (pkg_error.CNUGENERIC_MESSAGE,sbmensa);            
        END IF;
    END IF;

    nuTipoTrabajo := pkg_bcordenes.fnuobtienetipotrabajo(nuorden); 

    open cuTipoTrabOperaRP;
       fetch cuTipoTrabOperaRP into nuTipoTrabOperaRP;
    close cuTipoTrabOperaRP;   

    nuTipoCausal := pkg_bcordenes.fnuobtieneclasecausal(nucausalorder);

    -- obtenemos el producto y el paquete
    OPEN cuproducto (nuorden);
    FETCH cuProducto
        INTO nuproductid,
             nucontratoid,
             nutasktypeid,
             nupakageid,
             nucliente,
             nuunidadoperativa,
             dtExecFinal--caso: 0000767
                        ;

    IF cuProducto%NOTFOUND
    THEN
        sbmensa :='OT:'|| nuorden
                  || '. Proceso termino con errores : '
                  || 'El cursor cuProducto no arrojo datos';
        
        pkg_estaproc.prActualizaEstaproc(isbProceso    => sbProceso,
                                        isbEstado      => 'OK',
                                        isbObservacion => sbmensa
                                        );--767
    END IF;

    CLOSE cuproducto;

    pkg_traza.trace('Salio cursor cuProducto, nuProductId: '
                    || nuProductId
                    || 'nuContratoId:'
                    || 'nuTaskTypeId:'
                    || nuTaskTypeId,pkg_traza.cnuNivelTrzDef);


    --Inicio caso:0000767
    -- Se valida si el producto de la orden
    --CA 833_1 se añade validacion con variable para validar de entrega 767

    IF FBLGENERATRAMITEREPARA (nutasktypeid, nuProductId, dtExecFinal) =
        FALSE
    THEN
        pkg_traza.trace( 'LDC_PROCREATRAMITECERTI: No genera tramite de RP',pkg_traza.cnuNivelTrzDef);        
        sbmensa :='OT:'
                  || nuorden
                  || '.Usuario vencido no se genera tramite : ';
                
        pkg_estaproc.prActualizaEstaproc(isbProceso     => sbProceso,
                                            isbEstado      => 'OK',
                                            isbObservacion => sbmensa
                                        ); --767
        GOTO NoGeneraRp;
    END IF;
    --fin caso:0000767
    -- Obtenemos todas las ordenes legalizadas de esta solicitud
    nucantotleg := 0;

    open cucantotleg;
         fetch cucantotleg into nucantotleg;
    close cucantotleg;

    -- Actualizamos las solicitud que se esta legalizando para que no salga como pendiente
    UPDATE mo_packages m
       SET m.motive_status_id = 14
     WHERE m.package_id = nupakageid;

    -- Buscamos solicitudes de revisión periodica generadas

    sbsolicitudes := NULL;

    FOR i IN cusolicitudesabiertas (nuproductid)
    LOOP
        IF sbsolicitudes IS NULL
        THEN
            sbsolicitudes := i.colsolicitud;
        ELSE
            sbsolicitudes := sbsolicitudes || ',' || TO_CHAR (i.colsolicitud);
        END IF;
    END LOOP;

    IF TRIM (sbsolicitudes) IS NULL AND nucantotleg IN (0, 1)
    THEN
        -- Actualiza a estado atendido el mo_component

        UPDATE mo_component mc
           SET mc.motive_status_id =
                   dald_parameter.fnuGetNumeric_Value ('ESTADO_COMPONENTE_ATENDIDO',NULL)
         WHERE mc.motive_id IN (SELECT mo.motive_id
                                  FROM mo_motive mo
                                 WHERE mo.package_id = nupakageid);

        -- Obtenemos los datos de la solicitud de visita de verificacion para generar el tramite de defecto critico

        sbdireccionparseada := NULL;
        nudireccion := NULL;
        nulocalidad := NULL;
        nucategoria := NULL;
        nusubcategori := NULL;        

        sbcomment :=
               SUBSTR (ldc_retornacomentotlega (nuorden), 1, 2000)
            || dald_parameter.fsbGetValue_Chain (
                   'COMENTARIO_CERTIFICACION_PRP')
            || ' AL LEGALIZAR ORDEN : '
            || TO_CHAR (nuorden)
            || ' CON CAUSAL : '
            || TO_CHAR (nucausalorder);

        numediorecepcion :=
            dald_parameter.fnuGetNumeric_Value ('MEDIO_RECEPCION_CERT_PRP');

        
        nupackageid :=
                LDC_PKGESTIONLEGAORRP.FNUGETSOLICERTRP (nuproductid,
                                                        numediorecepcion,
                                                        sbComment,
                                                        nuerrorcode,
                                                        sberrormessage);
      

        IF nupackageid IS NULL
        THEN
            sbmensa :=
                   'OT:'
                || nuorden
                || '.Proceso termino con errores : '
                || 'Error al generar la solicitud de certificacion prp. Codigo error : '
                || TO_CHAR (nuerrorcode)
                || ' Mensaje de error : '
                || sberrormessage;
            
                pkg_estaproc.prActualizaEstaproc(isbProceso     => sbProceso,
                                                isbEstado      => 'OK',
                                                isbObservacion => sbmensa
                                                ); --767
        ELSE
            sbflag :=
                ldc_fsbretornaaplicaasigauto (nutasktypeid, nucausalorder);

            IF NVL (sbflag, 'N') = 'S'
            THEN
                ldc_procrearegasiunioprevper (nuunidadoperativa,
                                              nuproductid,
                                              nutasktypeid,
                                              nuorden,
                                              nupackageid);
            END IF;

            -- Dejamos la solicitud como estaba

            UPDATE mo_packages m
               SET m.motive_status_id = 13
             WHERE m.package_id = nupakageid;

            sbmensa :=
                   'Proceso termino Ok. Se genero la solicitud Nro : '
                || TO_CHAR (nupackageid);



            --CA 833_1
            --Se registrará en la tabla LDC_ORDENTRAMITERP la Orden legalizada, 
            --Tipo de Trabajo de la orden, Causal de legalización de la orden, 
            --el Id de la Solicitud Generada y el 
            --NUUNITOPERADDDATA (Unidad Operativa del dato adicional)
            IF  (nuTipoTrabOperaRP > 0 AND nuTipoCausal = 1)
            THEN
                IF nupackageid IS NOT NULL
                THEN
                    IF NUUNITOPERADDDATA IS NOT NULL
                    THEN
                        INSERT INTO LDC_ORDENTRAMITERP (ORDEN,
                                                        TIPOTRABAJO,
                                                        CAUSAL,
                                                        SOLICITUD,
                                                        UNIDADOPERA)
                             VALUES (nuorden,
                                     nuTipoTrabajo,
                                     nucausalorder,
                                     nupackageid,
                                     NUUNITOPERADDDATA);
                    END IF;
                END IF;
            END IF;
        
            pkg_estaproc.prActualizaEstaproc(isbProceso     => sbProceso,
                                            isbEstado      => 'OK',
                                            isbObservacion => sbmensa
                                            );--767
        END IF;
    ELSE
        sbmensa :=
               'OT:'
            || nuorden
            || '. Error al generar la solicitud para el producto : '
            || TO_CHAR (nuproductid)
            || ' Tiene las siguientes solicitudes de revisi?n periodica en estado registradas : '
            || TRIM (sbsolicitudes);

          
        pkg_estaproc.prActualizaEstaproc(isbProceso     => sbProceso,
                                        isbEstado      => 'OK',
                                        isbObservacion => sbmensa
                                        ); --767
    END IF;

   <<NoGeneraRp>>                                                   --caso:767
    
    pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN);
EXCEPTION
    WHEN PKG_ERROR.CONTROLLED_ERROR
    THEN
        
        
        pkg_error.geterror (nuErrorCode, sbmensa);          
        
        pkg_estaproc.prActualizaEstaproc(isbProceso     => sbProceso,
                                        isbEstado      => 'Error',
                                        isbObservacion => sbmensa
                                        );--767
        pkg_traza.trace('nuErrorCode:'||nuErrorCode||'-'||sbmensa,pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERC); 
        RAISE PKG_ERROR.CONTROLLED_ERROR;
    WHEN OTHERS
    THEN
        sbmensa := 'Proceso termino con Errores. ' || SQLERRM;
        
        pkg_traza.trace('Error2 LDC_PROCREATRAMITECERTI',pkg_traza.cnuNivelTrzDef);

        pkg_error.seterror;
        pkg_error.geterror (nuErrorCode, sbmensa);

          
        pkg_estaproc.prActualizaEstaproc(isbProceso     => sbProceso,
                                         isbEstado      => 'Error',
                                         isbObservacion => sbmensa
                                         );--767
        pkg_traza.trace('nuErrorCode:'||nuErrorCode||'-'||sbmensa,pkg_traza.cnuNivelTrzDef);                                         
        pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);
        RAISE PKG_ERROR.CONTROLLED_ERROR;
END LDC_PROCREATRAMITECERTI;
/

PROMPT Otorgando permisos de ejecucion a LDC_PROCREATRAMITECERTI
BEGIN
    pkg_utilidades.praplicarpermisos('LDC_PROCREATRAMITECERTI', 'ADM_PERSON');
END;
/
