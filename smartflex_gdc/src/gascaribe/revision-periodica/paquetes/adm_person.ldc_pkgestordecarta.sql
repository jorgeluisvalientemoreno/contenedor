CREATE OR REPLACE PACKAGE adm_person.LDC_PKGESTORDECARTA
IS

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Paquete        : LDC_PKGESTORDECARTA 
    Descripcion     : Paquete para la gestión de las ordenes de impresión y
                      reparto de cartas
    Autor           : Horbath 
    Fecha           : 2019-12-19 
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    Horbath     2019-12-19  27          Creacion
    Adrianavg   2024-06-18  OSF-2798    Se migra del esquema OPEN al esquema ADM_PERSON
    jpinedc     2024-03-05  OSF-2375    Ajuste Validación Técnica:
                                        Reemplazo LDC_PROINSERTAESTAPROG y
                                        LDC_PROACTUALIZAESTAPROG  
                                        por homologados en PKG_ESTAPROC     
    jpinedc     2024-04-24  OSF-2375    prJobEnvArCo.prgeneraarchivo: Se reemplazan
                                        ut_mailpost.sendmailblobattachsmtp  y 
                                        ldc_sendemail por pkg_Correo.prcEnviaCorreo
    ***************************************************************************/  
    
    PROCEDURE PRVALITEMPAGO;

    /**************************************************************************
       Autor       :  Horbath
       Fecha       : 2019-12-19
       Ticket      : 27
       Proceso     : PRVALITEMPAGO
       Descripcion : Plugin que valida si se esta legalizando los items configurados
                     en los parametros LDC_ITEMLEIMCA o LDC_ITEMLEENCA

       Parametros Entrada

       Valor de salida

       HISTORIA DE MODIFICACIONES
       FECHA        AUTOR       DESCRIPCION
     ***************************************************************************/
    PROCEDURE PRJOBENVARCO;
/**************************************************************************
   Autor       :  Horbath
   Fecha       : 2019-12-19
   Ticket      : 27
   Proceso     : PRJOBENVARCO
   Descripcion : job que envia reporte de ordenes generadas de entrega de carta asignada a RIB

   Parametros Entrada

   Valor de salida

   HISTORIA DE MODIFICACIONES
   FECHA        AUTOR       DESCRIPCION
 ***************************************************************************/
END LDC_PKGESTORDECARTA;
/

CREATE OR REPLACE PACKAGE BODY adm_person.LDC_PKGESTORDECARTA
IS
    csbSP_NAME		CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT || '.';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
    
    PROCEDURE prValItemPago
    IS
        /**************************************************************************
           Autor       :  Horbath
           Fecha       : 2019-12-19
           Ticket      : 27
           Proceso     : prValItemPago
           Descripcion : Plugin que valida si se esta legalizando los items configurados
                         en los parametros LDC_ITEMLEIMCA o LDC_ITEMLEENCA

           Parametros Entrada

           Valor de salida

           HISTORIA DE MODIFICACIONES
           FECHA        AUTOR       DESCRIPCION
         ***************************************************************************/
         
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prValItemPago';
        
        nuError         NUMBER;
        sbError         VARCHAR2(4000); 
             
        nuorden           NUMBER;               --Se almacena orden de trabajo
        sbItemsEntrCart   VARCHAR2 (4000)
            := pkg_BCLD_Parameter.fsbObtieneValorCadena ('LDC_ITEMLEENCA'); --se almacenan items de entrega de carta
        sbItemsImprCart   VARCHAR2 (4000)
            := pkg_BCLD_Parameter.fsbObtieneValorCadena ('LDC_ITEMLEIMCA'); --se almacena items de impresion de carta
        nuActividad       NUMBER;

        nuActivImprIni    VARCHAR2 (4000)
            := pkg_BCLD_Parameter.fsbObtieneValorCadena ('LDC_ACTICAR_NOTI_INI'); --se almacena actividad de impresion de carta 54
        nuActivImprSeg    VARCHAR2 (4000)
            := pkg_BCLD_Parameter.fsbObtieneValorCadena ('LDC_ACTICAR_SEG_NOTI'); --se almacena actividad de impresion de carta 57
        sbActEntreCart    VARCHAR2 (4000)
            := pkg_BCLD_Parameter.fsbObtieneValorCadena ('LDC_ACTIVENCART'); --se almacena actividad de entrega de carta

        nuValiActi55      NUMBER;
        nuValiActi        NUMBER;
        sbItemValid       VARCHAR2 (4000);

        nucantItemLeg     NUMBER := 0;
        nuCantItemConf    NUMBER := 0;

        --obtiene la cantidad de items legalizado
        CURSOR cugetItemsLega (isbItems VARCHAR2)
        IS
            SELECT COUNT (*)
              FROM or_order_items i
             WHERE     i.order_id = nuorden
                   AND i.LEGAL_ITEM_AMOUNT > 0
                   AND i.ITEMS_ID IN
                           (
                                SELECT to_number(regexp_substr(isbItems,'[^,]+', 1,LEVEL))
                                FROM dual
                                CONNECT BY regexp_substr(isbItems, '[^,]+', 1, LEVEL) IS NOT NULL
                            );

        --se valida cantidad de item configurados
        CURSOR cuGetItemConf (isbItems VARCHAR2)
        IS
            SELECT COUNT (1)
              FROM (
                        SELECT regexp_substr(isbItems,'[^,]+', 1,LEVEL) ITEMS
                        FROM dual
                        CONNECT BY regexp_substr(isbItems, '[^,]+', 1, LEVEL) IS NOT NULL
                    )
             WHERE ITEMS IS NOT NULL;

        --se valida cantidad de item configurados
        CURSOR cuGetActiConf (isbActividad VARCHAR2)
        IS
            SELECT COUNT (1)
            FROM (
                    SELECT regexp_substr(isbActividad,'[^,]+', 1,LEVEL) Actividad
                    FROM dual
                    CONNECT BY regexp_substr(isbActividad, '[^,]+', 1, LEVEL) IS NOT NULL
                 )
             WHERE actividad = nuActividad;

        --se obtiene  actvidad de la orden
        CURSOR cugetActividad IS
        SELECT oa.activity_id
        FROM or_order_activity oa
        WHERE oa.order_id = nuorden;

        nuClasCausal      NUMBER;                --se almacena clase de causal
        sbmensa           VARCHAR2 (4000);      --se almacena mensaje de error
    BEGIN
    
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
    
        --Obtener el identificador de la orden  que se encuentra en la instancia
        nuorden := pkg_BCOrdenes.fnuObtenerOTInstanciaLegal;
        
        pkg_traza.trace( 'Numero de la Orden:' || nuorden, csbNivelTraza);
         
        nuClasCausal :=
            pkg_BCOrdenes.fnuObtieneClaseCausal (
                pkg_BCOrdenes.fnuObtieneCausal (nuorden)
            );                            --se obtiene clase de causal

        IF nuClasCausal = 1
        THEN
            --se obtiene actividad de la orden
            OPEN cugetActividad;
            FETCH cugetActividad INTO nuActividad;
            CLOSE cugetActividad;

            --Se valida si la actividad es impresion de carta
            OPEN cuGetActiConf (nuActivImprIni);
            FETCH cuGetActiConf INTO nuValiActi55;
            CLOSE cuGetActiConf;

            --Se valida si la actividad es impresion de carta
            OPEN cuGetActiConf (nuActivImprSeg);
            FETCH cuGetActiConf INTO nuValiActi;
            CLOSE cuGetActiConf;


            IF nuValiActi > 0 OR nuValiActi55 > 0
            THEN
                sbItemValid := sbItemsImprCart;
            ELSE
                --Se valida si la actividad es de entrega de carta
                OPEN cuGetActiConf (sbActEntreCart);
                FETCH cuGetActiConf INTO nuValiActi;
                CLOSE cuGetActiConf;

                IF nuValiActi > 0
                THEN
                    sbItemValid := sbItemsEntrCart;
                END IF;
            END IF;

            --si la actividad esta configura se validan los items
            IF sbItemValid IS NOT NULL
            THEN
                OPEN cuGetItemConf (sbItemValid);
                FETCH cuGetItemConf INTO nuCantItemConf;
                CLOSE cuGetItemConf;
 
                OPEN cugetItemsLega (sbItemValid);
                FETCH cugetItemsLega INTO nucantItemLeg;
                CLOSE cugetItemsLega;

                --si las cantidades son diferentes se generar error
                IF nuCantItemConf <> nucantItemLeg
                THEN
                    sbmensa :=
                           'Se deben legalizar los items '
                        || sbItemValid
                        || ' obligatoriamente';
                    pkg_error.setErrorMessage( isbMsgErrr => sbmensa );
                END IF;
            END IF;
        END IF;
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 
                
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
    END prValItemPago;

    PROCEDURE prJobEnvArCo
    IS
        /**************************************************************************
           Autor       :  Horbath
           Fecha       : 2019-12-19
           Ticket      : 27
           Proceso     : prJobEnvArCo
           Descripcion : job que envia reporte de ordenes generadas de entrega de carta asignada a RIB

           Parametros Entrada

           Valor de salida

           HISTORIA DE MODIFICACIONES
           FECHA        AUTOR       DESCRIPCION
         ***************************************************************************/
         
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prJobEnvArCo';
        
        nuError         NUMBER;
        sbError         VARCHAR2(4000); 
                 
        sbActEntreCart     VARCHAR2 (4000)
            := pkg_BCLD_Parameter.fsbObtieneValorCadena ('LDC_ACTIVENCART'); --se almacena actividad de entrega de carta
        sbContRib          VARCHAR2 (4000)
            := pkg_BCLD_Parameter.fsbObtieneValorCadena ('LDC_COCONTRIB'); --se almacena codigo de contratista RIB
        sbContdisp         VARCHAR2 (4000)
            := pkg_BCLD_Parameter.fsbObtieneValorCadena ('LDC_COCODISP'); --se almacena codigo de contratista dispapeles

        sbActivImpre       VARCHAR2 (400)
            := pkg_BCLD_Parameter.fnuObtieneValorNumerico ('LDC_ACTICARM60');
        sbEncabezado       VARCHAR2 (4000)
            := 'DEPARTAMENTO|LOCALIDAD|CONTRATO|NOMBRE USUARIO|PRODUCTO|ORDEN|FECHA DE CREACION|FECHA DE ASIGANCION|PRODUCTO|UNIDAD OPERATIVA|TIPO DE TRABAJO|ACTIVIDAD|DIRECCION';
        sbNombreArchivo    VARCHAR2 (250)
            :=    'InforOrdenesEntrega_'
               || TO_CHAR (SYSDATE, 'DDMMYYYY_HH24MISS'); -- se almacena el nombre del flArchivo
        sbNombreArchivoI   VARCHAR2 (250)
            :=    'InforOrdenesImpresion_'
               || TO_CHAR (SYSDATE, 'DDMMYYYY_HH24MISS'); -- se almacena el nombre del flArchivo
        flArchivo            pkg_GestionArchivos.styArchivo;

        sbMensaje          VARCHAR2 (200)
            := 'Proceso termino, por favor valide flArchivo adjunto';

        --  flArchivo
        BLFILE             BFILE;

        nuarchexiste       NUMBER; -- valida si creo algun flArchivo en el disco

        sbfrom             VARCHAR2 (4000)
            := pkg_BCLD_Parameter.fsbObtieneValorCadena ('LDC_SMTP_SENDER'); --  se coloca el emisor del correo
        sbfromdisplay      VARCHAR2 (4000) := 'Open SmartFlex'; -- Nombre del emisor

        sbTipoBD           VARCHAR2 (4000);
        -- Destinatarios
        sbtodisplay        VARCHAR2 (4000) := '';
        sbcc               ut_string.tytb_string;
        sbccdisplay        ut_string.tytb_string;
        sbbcc              ut_string.tytb_string;
        -- asunto

        sbmsg              VARCHAR2 (10000) := sbMensaje;
        sbcontenttype      VARCHAR2 (100) := 'text/html';

        sbfileext          VARCHAR2 (10) := 'txt'; -- especifica el tipo de flArchivo que se enviar?. ZIP o CSV
        nutam_archivo      NUMBER;              -- tamano del flArchivo a enviar

        sbDato             VARCHAR2 (4000);
        adjunto            BLOB;       -- file type del flArchivo final a enviar
        sbEmail            VARCHAR2 (4000);
        nuCantMailUniOper           NUMBER;
        
        --sbHtml VARCHAR2(4000); --  se almacena estructura HTML.
        sbDirectorio         VARCHAR2 (255)
            := pkg_BCLD_Parameter.fsbObtieneValorCadena ('LDC_RUTAARORD'); -- se consulta sbDirectorio del flArchivo
            
        sbEmailFunc        VARCHAR2 (4000)
            := pkg_BCLD_Parameter.fsbObtieneValorCadena ('LDC_EMAIFUNO'); --Se almacena email de funcionarios
        sbErrorMessage     VARCHAR2 (4000);
        nuOk               NUMBER;

        sbArchivo           VARCHAR2(255);

        sbproceso  VARCHAR2(100)  := 'prJobEnvArCo'||TO_CHAR(SYSDATE,'DDMMYYYYHH24MISS');

        sbRemitente     ld_parameter.value_chain%TYPE:= pkg_BCLD_Parameter.fsbObtieneValorCadena('LDC_SMTP_SENDER');
                    
        CURSOR cugetOrdenes (isbActividades VARCHAR2, isbContratista VARCHAR2)
        IS
            SELECT    pkg_BCDirecciones.fsbGetDescripcionUbicaGeo (
                          (SELECT L.GEO_LOCA_FATHER_ID
                             FROM GE_GEOGRA_LOCATION l
                            WHERE l.GEOGRAP_LOCATION_ID =
                                  pkg_BCDirecciones.FNUGETLOCALIDAD (OA.ADDRESS_ID)))
                   || '|'
                   || (SELECT REPLACE (
                                     L.GEOGRAP_LOCATION_ID
                                  || ' - '
                                  || L.DESCRIPTION,
                                  '|',
                                  '')
                         FROM GE_GEOGRA_LOCATION l
                        WHERE l.GEOGRAP_LOCATION_ID =
                              pkg_BCDirecciones.FNUGETLOCALIDAD (OA.ADDRESS_ID)
                       )
                   || '|'
                   || OA.SUBSCRIPTION_ID
                   || '|'
                   || OA.PRODUCT_ID
                   || '|'
                   || (SELECT REPLACE (
                                     S.SUBSCRIBER_NAME
                                  || ' '
                                  || S.SUBS_LAST_NAME
                                  || ' '
                                  || S.SUBS_SECOND_LAST_NAME,
                                  '|',
                                  '')
                         FROM GE_SUBSCRIBER s
                        WHERE s.SUBSCRIBER_ID = Oa.SUBSCRIBER_ID)
                   || '|'
                   || o.order_id
                   || '|'
                   || o.CREATED_DATE
                   || '|'
                   || o.ASSIGNED_DATE
                   || '|'
                   || oa.product_id
                   || '|'
                   || o.OPERATING_UNIT_ID
                   || '|'
                   || o.task_type_id
                   || ' '
                   || REPLACE (
                          daor_task_type.fsbgetdescription (o.task_type_id,
                                                            NULL),
                          '|',
                          '')
                   || '|'
                   || oa.activity_id
                   || '|'
                   || pkg_BCDirecciones.fsbGetDireccionParseada (OA.ADDRESS_ID)
                       datos,
                    pkg_BCUnidadOperativa.fsbGetCorreo(o.OPERATING_UNIT_ID) email
              FROM or_order o, OR_ORDER_ACTIVITY oa
             WHERE     o.order_id = oa.order_id
                    AND o.OPERATING_UNIT_ID IN
                    (
                        SELECT ou.OPERATING_UNIT_ID
                        FROM OR_OPERATING_UNIT ou
                        WHERE ou.CONTRACTOR_ID IN
                        (
                            SELECT to_number(regexp_substr(isbContratista,'[^,]+', 1,LEVEL))
                            FROM dual
                            CONNECT BY regexp_substr(isbContratista, '[^,]+', 1, LEVEL) IS NOT NULL
                        )
                    )
                    AND OA.Activity_id IN
                    (
                        SELECT to_number(regexp_substr(isbActividades,'[^,]+', 1,LEVEL))
                        FROM dual
                        CONNECT BY regexp_substr(isbActividades, '[^,]+', 1, LEVEL) IS NOT NULL
                    )
                   AND o.order_status_id = 5
                   AND o.ASSIGNED_DATE BETWEEN TRUNC (SYSDATE) AND SYSDATE;

        --  Se consulta correo
        CURSOR cuCorreo IS
            SELECT *
            FROM 
            (
                SELECT regexp_substr(sbEmail,'[^,]+', 1,LEVEL) e_mail
                FROM dual
                CONNECT BY regexp_substr(sbEmail, '[^,]+', 1, LEVEL) IS NOT NULL
                UNION ALL
                SELECT regexp_substr(sbEmailFunc,'[^,]+', 1,LEVEL) e_mail
                FROM dual
                CONNECT BY regexp_substr(sbEmailFunc, '[^,]+', 1, LEVEL) IS NOT NULL
            )
            WHERE e_mail IS NOT NULL;
        
        CURSOR cuCantMailUniOper( isbEmail VARCHAR2, isbEmailUniOper VARCHAR2)
        IS
        SELECT COUNT (1)
        FROM 
        (
            SELECT regexp_substr(isbEmail,'[^,]+', 1,LEVEL) e_mail
            FROM dual
            CONNECT BY regexp_substr(isbEmail, '[^,]+', 1, LEVEL) IS NOT NULL
        )
        WHERE e_mail = isbEmailUniOper;        

        PROCEDURE prgeneraarchivo (isbNombre        VARCHAR2,
                                   isbTitulo        VARCHAR2,
                                   isbActividades   VARCHAR2,
                                   isbContratista   VARCHAR2,
                                   isbasunto        VARCHAR2)
        IS
            csbMetodo1        CONSTANT VARCHAR2(105) := csbMetodo || '.prgeneraarchivo';
                          
        BEGIN

            pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbINICIO);
            
            sbArchivo :=   isbNombre || '.' || sbfileext;
            
            -- se abre flArchivo para su escritura
            BEGIN
                flArchivo :=
                    pkg_GestionArchivos.ftAbrirArchivo_SMF (sbDirectorio,
                                   sbArchivo,
                                    pkg_GestionArchivos.csbMODO_ESCRITURA);
            EXCEPTION
                WHEN OTHERS
                THEN
                    NULL;
            END;

            pkg_GestionArchivos.prcEscribeTermLinea_SMF (flArchivo);
            pkg_GestionArchivos.prcEscribirLinea_SMF  (flArchivo, isbTitulo);
            pkg_GestionArchivos.prcEscribirLineaSinTerm_SMF (flArchivo, sbEncabezado);
            sbEmail := NULL;

            FOR reg IN cugetOrdenes (isbActividades, isbContratista)
            LOOP
                pkg_GestionArchivos.prcEscribeTermLinea_SMF (flArchivo);
                pkg_GestionArchivos.prcEscribirLineaSinTerm_SMF (flArchivo, reg.datos);

                IF reg.email IS NOT NULL
                THEN
                    IF sbEmail IS NULL
                    THEN
                        sbEmail := reg.email;
                    ELSE
                        
                        OPEN cuCantMailUniOper( sbEmail, reg.email );
                        FETCH cuCantMailUniOper INTO nuCantMailUniOper;
                        CLOSE cuCantMailUniOper;

                        IF nuCantMailUniOper = 0
                        THEN
                            sbEmail := sbEmail || ',' || reg.email;
                        END IF;
                    END IF;
                END IF;
            END LOOP;


            -- se escribe en el flArchivo
            blfile := BFILENAME (sbDirectorio,sbArchivo);
            nuarchexiste := DBMS_LOB.fileexists (blfile); -- se valida si existe flArchivo

            pkg_GestionArchivos.prcCerrarArchivo_SMF (flArchivo,sbDirectorio,sbArchivo);                    -- se cierra flArchivo

            DBMS_LOB.open (blfile, DBMS_LOB.file_readonly);
            nutam_archivo := DBMS_LOB.getlength (blfile);
            DBMS_LOB.createtemporary (adjunto, TRUE);
            DBMS_LOB.loadfromfile (adjunto, blfile, nutam_archivo);
            DBMS_LOB.close (blfile);

            -- si existe flArchivo se procede a enviar correo
            IF nutam_archivo >= 1
            THEN
                BEGIN
                    FOR regco IN cuCorreo
                    LOOP
                    
                        pkg_Correo. prcEnviaCorreo
                        (
                            isbRemitente        => sbfrom,
                            isbDestinatarios    => regco.e_mail,
                            isbAsunto           => isbasunto,
                            isbMensaje          => sbmsg,
                            isbArchivos         => sbDirectorio || '/' || sbArchivo,
                            isbDescRemitente    => sbfromdisplay
                        );                        
                        
                    END LOOP;
                EXCEPTION
                    WHEN OTHERS
                    THEN
                        FOR regco IN cuCorreo
                        LOOP
                            pkg_Correo.prcEnviaCorreo
                            (
                                isbRemitente        =>  sbRemitente,
                                isbDestinatarios    =>  regco.e_mail,
                                isbAsunto           =>  isbasunto,
                                isbMensaje          =>  'Se creo flArchivo plano con el nombre de ['
                                || isbNombre
                                || '] en la ruta['
                                || sbDirectorio
                                || ']'
                            );  

                        END LOOP;
                END;
            ELSE
                sbErrorMessage := 'No se pudo crear flArchivo';
                nuOk := -1;
            END IF;
            
            pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbFIN);  
                        
        END prgeneraarchivo;
    BEGIN
    
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
                    
        -- Inicializamos el proceso
        pkg_estaproc.prinsertaestaproc( sbproceso , 1);
                                               
        --envia correo de carta
        prgeneraarchivo (
            sbNombreArchivo,
            'Informacion de Ordenes de Entrega de Carta asignadas en el dia ',
            sbActEntreCart,
            sbContRib,
            'Informacion de Ordenes de Entrega de Carta Asignadas');

        prgeneraarchivo (
            sbNombreArchivoi,
            'Informacion de Ordenes de Impresion de Carta asignadas en el dia ',
            sbActivImpre,
            sbContdisp,
            'Informacion de Ordenes de Impresion de Carta Asignadas ');

        pkg_estaproc.practualizaestaproc(isbproceso => sbproceso, isbEstado => 'Ok', isbObservacion => sbErrorMessage );
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 
                
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            pkg_estaproc.practualizaestaproc(isbproceso => sbproceso, isbEstado => 'sbError|'||sbError, isbObservacion => sbErrorMessage );
            pkg_GestionArchivos.prcCerrarArchivo_SMF (flArchivo,sbDirectorio,sbArchivo);
        WHEN OTHERS THEN     
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);                 
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            pkg_estaproc.practualizaestaproc(isbproceso => sbproceso, isbEstado => 'sbError|'||sbError, isbObservacion => sbErrorMessage );
            pkg_GestionArchivos.prcCerrarArchivo_SMF (flArchivo,sbDirectorio,sbArchivo);
    END prJobEnvArCo;
END LDC_PKGESTORDECARTA;
/

Prompt Otorgando permisos sobre ADM_PERSON.LDC_PKGESTORDECARTA
BEGIN
    pkg_Utilidades.prAplicarPermisos(upper('LDC_PKGESTORDECARTA'), 'ADM_PERSON');
END;
/
