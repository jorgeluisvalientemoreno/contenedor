CREATE OR REPLACE Package personalizaciones.ldc_pkvalida_tt_local Is

/*******************************************************************************
    Fuente=Propiedad Intelectual de Gases del Caribe
    ldc_boDiferidosPasoPrepago
    Autor       :   Caren Berdejo. Ludycom S.A.
    Fecha       :   12/10/2016 05:19:07 p.m.
    Descripcion :   
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    cberdejo    12/10/2016          Creacion
    jpinedc     27/02/2024          OSF-2375: Reemplazo de utl_file por
                                    pkg_gestionArchivos
    jpinedc     05/03/2024          OSF-2375: Ajuste Validación Técnica:
                                    Reemplazo LDC_PROINSERTAESTAPROG y
                                    LDC_PROACTUALIZAESTAPROG  
                                    por homologados en PKG_ESTAPROC
    jpinedc     27/05/2024          OSF-2603: Se reemplazan LDC_ENVIAMAIL 
                                    y ut_mailpost.sendmailblobattachsmtp
                                    por pkg_Correo.prcEnviaCorreo
    jpinedc     17/07/2024          OSF-2884: Se migra a adm_person
    jpinedc     02/08/2024          OSF-2884: * Se modifica envia_tt_localidad para
                                    que reporte errores en el proceso hijo y no
                                    sobre el padre y eleve la excepción
                                    de error controlado.
                                    * Se modifica ldc_valida_conf_tt colocando
                                    los mensajes de error al elevar las excepciones
                                    de las validaciones
    jpinedc     19/09/2024          OSF-3162: Se migra el paquete desde adm_person a 
									personalizaciones
									* Se borra compressFile	
    jpinedc     28/10/2024          OSF-3162: Ajustes por cambios en pkg_ldc_tt_local 																	
*******************************************************************************/

  
  Procedure ldc_valida_conf_tt(nucontratista Number);
  Procedure envia_tt_localidad(isbprocesopadre In Varchar2,
                               osberrormessage Out Varchar2);
  Function fbocheckmailformat(isbdata Varchar2) Return Boolean;
  Procedure proceso_job;
  Function valida_trigger(nucontratista Number, nuacta Number) Return Number;

End ldc_pkvalida_tt_local;
/

CREATE OR REPLACE PACKAGE BODY personalizaciones.ldc_pkvalida_tt_local
IS

    csbSP_NAME		CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT ||  '.';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
    
    sbLDC_VAL_CONT_CUENTAMULTAS  ld_parameter.value_chain%type := pkg_BCLD_Parameter.fsbObtieneValorCadena ( 'LDC_VAL_CONT_CUENTAMULTAS');

    sbRemitente     ld_parameter.value_chain%TYPE:= pkg_BCLD_Parameter.fsbObtieneValorCadena('LDC_SMTP_SENDER');
    
    sbclasact VARCHAR2(3000):= pkg_ldci_carasewe.fsbObtCASEVALO('CLASIACTIVOS','WS_COSTOS');
    
    sbdatoadic VARCHAR2(3000):= pkg_ldci_carasewe.fsbObtCASEVALO('NOMB_ATRIB_ACTIVO_OT','WS_COSTOS');
            
    sbValidaActivoTabla   ld_parameter.value_chain%TYPE := NVL (
                                                           pkg_BCLD_Parameter.fsbObtieneValorCadena (
                                                               'LDC_VAL_CONF_ACTIV_EN_TABLA'),
                                                           'N');
                                                           
    CURSOR cuClasificadoresActas( inuClasificador NUMBER, isbClasAct  VARCHAR2)
    IS
    SELECT 1
    FROM
    (
        SELECT regexp_substr(isbClasAct,'[^,]+', 1,LEVEL) COLUMN_VALUE
        FROM dual                                
        CONNECT BY regexp_substr(isbClasAct, '[^,]+', 1, LEVEL) IS NOT NULL
    )
    WHERE COLUMN_VALUE = inuClasificador;
    
    CURSOR cuValContMultCuenta( isbCuentaCosto VARCHAR2)
    IS
    SELECT COUNT(1)
    FROM
    (
        SELECT TO_NUMBER( regexp_substr(sbLDC_VAL_CONT_CUENTAMULTAS,'[^,]+', 1,LEVEL)) cuenta
        FROM dual                                
        CONNECT BY regexp_substr(sbLDC_VAL_CONT_CUENTAMULTAS, '[^,]+', 1, LEVEL) IS NOT NULL
    )
    WHERE cuenta = TO_NUMBER (TRIM (isbCuentaCosto));       
            
    PROCEDURE ldc_valida_conf_tt (nucontratista NUMBER)
    IS
        /*****************************************************************
          Propiedad intelectual de Gases del Caribe / Efigas S.A.

          Nombre del Proceso: ldc_valida_conf_tt
          Descripcion: Proceso que realiza la validacion de la configuracion
                       contable de los tipos de trabajo por localidad
          Autor  : Caren Berdejo, Ludycom S.A.
          Fecha  : 12-10-2016

          Historia de Modificaciones

          DD-MM-YYYY    <Autor>.              Modificacion
          -----------  -------------------    -------------------------------------
       19/07/2018     dsaltarin             200-1957 se modifica para tratar de optimazar la consulta
                                              y para que valide el dato adicional del activo en caso
                                              que no encuentre el dato adicional
        09/11/2018     Elkin Alvarez          PROCEDIMIENTO : ldc_valida_conf_tt Linea 158 se modifica OSS_CONT_DSS_2001957_1 por OSS_CONT_DSS_2001957_2
                                                            se agrega la cuenta de costo a la consulta de la linea 192

     21/10/2021   Horbath      CA:840 Se modifica el procedimineto para que  se tengan Se cuenten las ordenes que no tienen lleno el
              campo external_address_id y poder enviar un mensaje de error con la siguiente cadena Existen N ordenes sin direccion

        ******************************************************************/

        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'ldc_valida_conf_tt';
        nuError         NUMBER;
          
        crOrdRangoFechXClasifContable Constants_Per.tyRefCursor;
        
        TYPE tyrgcuordenes IS RECORD 
        (  
            order_id                NUMBER,  
            task_type_id            NUMBER,
            tipo_trabajo_validar    NUMBER,
            geograp_location_id     NUMBER,
            clctclco                NUMBER,
            cantidad                NUMBER
        );
        
        rgcuordenes tyrgcuordenes;
        
        nuclasicontab         NUMBER(15);
        sberror               VARCHAR2 (4000);
        
        nupaso                NUMBER;
        nuorden_id            NUMBER(15);
        nuactivo              NUMBER;
        nudatoadic            NUMBER;
        nutipotrabajo         or_task_type.task_type_id%TYPE;
        nulocalidad           ge_geogra_location.geograp_location_id%TYPE;
        nucentrocosto         NUMBER;

        dtFechaIni            DATE;
        dtFechaFin            DATE;
        sbCorreos             VARCHAR2 (4000)
            := pkg_BCLD_Parameter.fsbObtieneValorCadena ('CORREO_CONFIG_TT_DEST');
        sbcuentacosto         VARCHAR2(20);
        nucontacuenta         NUMBER (8);
        
        rcLdc_TT_Local        pkg_Ldc_TT_Local.cuLdc_TT_Local%ROWTYPE;
                            
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
        
        IF (pkg_BCLD_Parameter.fsbObtieneValorCadena ('VALIDA_CONFIG_TT') = 'S')
        THEN
            
            pkg_ldc_tt_local.prBorraRegistros;

            COMMIT;
            
            IF SUBSTR (sbCorreos, LENGTH (sbCorreos), 1) = ';'
            THEN
                sbCorreos :=
                    SUBSTR (sbCorreos, 1, LENGTH (sbCorreos) - 1);
            END IF;

            pkg_BCValida_tt_local.prcFechasCierreCom( dtFechaIni, dtFechaFin);

            IF dtFechaIni IS NULL
            THEN
                IF sbCorreos IS NOT NULL
                THEN
                
                    sbError := 'Error al ejecutar proceso Validacion Contable: No se encontraron Fechas del cierre';
                    
                    pkg_Correo.prcEnviaCorreo
                    (
                        isbRemitente        => sbRemitente,
                        isbDestinatarios    => sbCorreos,
                        isbAsunto           => 'Validacion Contable',
                        isbMensaje          => sbError
                    );
                END IF;
                
                pkg_error.setErrorMessage( isbMsgErrr => sbError ); 

            END IF;

            IF sbclasact IS NULL
            THEN
                IF sbCorreos IS NOT NULL
                THEN
                
                    sbError := 'Error al ejecutar proceso Validacion Contable: No se encontro parametro de clasificadores de activo';
                    
                    pkg_Correo.prcEnviaCorreo
                    (
                        isbRemitente        => sbRemitente,
                        isbDestinatarios    => sbCorreos,
                        isbAsunto           => 'Validacion Contable',
                        isbMensaje          => sbError
                    );
                END IF;

                pkg_error.setErrorMessage( isbMsgErrr => sbError ); 
                
            END IF;
            
            crOrdRangoFechXClasifContable := pkg_BCValida_tt_local.fcrOrdRangoFechXClasifContable
            ( dtFechaIni, dtFechaFin, sbclasact);

            IF crOrdRangoFechXClasifContable%IsOpen THEN
            
                LOOP
                
                    rgcuordenes := NULL;
                
                    FETCH crOrdRangoFechXClasifContable INTO rgcuordenes;
                    
                    EXIT WHEN crOrdRangoFechXClasifContable%NotFound;
                
                    nuorden_id := rgcuordenes.order_id;
                    nutipotrabajo := rgcuordenes.task_type_id;
                    nulocalidad := rgcuordenes.geograp_location_id;
                    nuclasicontab := rgcuordenes.clctclco;

                    IF nuclasicontab IS NOT NULL
                    THEN
                        sbcuentacosto := pkg_BCValida_tt_local.fsbObtienCuentaCosto(nuclasicontab);
                        
                        IF sbcuentacosto IS NOT NULL
                        THEN
                            
                            nuactivo := NULL;
                            
                            OPEN cuClasificadoresActas( nuclasicontab, sbClasAct ); 
                            FETCH cuClasificadoresActas INTO nuactivo;
                            CLOSE cuClasificadoresActas;

                            IF nuactivo = 1
                            THEN
                                IF sbdatoadic IS NOT NULL
                                THEN
                                    
                                    nudatoadic := pkg_BCValida_tt_local.fnuObtieneDatoAdicional( nuorden_id, sbdatoadic );
                                
                                    IF     nudatoadic IS NULL
                                       AND sbValidaActivoTabla = 'S'
                                    THEN 
                                        nudatoadic := pkg_BCValida_tt_local.fnuObtieneCantActTiTrLoc( rgcuordenes.geograp_location_id,rgcuordenes.task_type_id); 
                                    END IF;

                                    IF    nudatoadic IS NULL
                                       OR nudatoadic > 0
                                       OR nudatoadic = 0
                                    THEN
                                    
                                        rcLdc_TT_Local.task_type_id         := rgcuordenes.tipo_trabajo_validar;
                                        rcLdc_TT_Local.geograp_location_id  := nulocalidad;
                                        pkg_Ldc_TT_Local.prinsRegistro( rcLdc_TT_Local);  

                                    END IF;
     
                                ELSE
                                
                                    rcLdc_TT_Local.task_type_id         := rgcuordenes.tipo_trabajo_validar;
                                    rcLdc_TT_Local.geograp_location_id  := nulocalidad;
                                    pkg_Ldc_TT_Local.prinsRegistro( rcLdc_TT_Local);                              

                                END IF;
                            ELSE
                                
                                nucentrocosto := pkg_BCValida_tt_local.fnuObtieneCentCostTiTrLoc
                                                (rgcuordenes.geograp_location_id,
                                                rgcuordenes.task_type_id
                                                );

                                IF nucentrocosto IS NULL
                                THEN
                                                                                                   
                                    OPEN cuValContMultCuenta(sbcuentacosto);
                                    FETCH cuValContMultCuenta INTO nucontacuenta;
                                    CLOSE cuValContMultCuenta;
                                    
                                    IF nucontacuenta = 0
                                    THEN
                                        rcLdc_TT_Local.task_type_id         := rgcuordenes.tipo_trabajo_validar;
                                        rcLdc_TT_Local.geograp_location_id  := nulocalidad;
                                        pkg_Ldc_TT_Local.prinsRegistro( rcLdc_TT_Local);   
                                    END IF;
                                END IF;
                            END IF;
                        ELSE
                            rcLdc_TT_Local.task_type_id         := rgcuordenes.tipo_trabajo_validar;
                            rcLdc_TT_Local.geograp_location_id  := nulocalidad;
                            pkg_Ldc_TT_Local.prinsRegistro( rcLdc_TT_Local);  
                        END IF;
                    ELSE
                        rcLdc_TT_Local.task_type_id         := rgcuordenes.tipo_trabajo_validar;
                        rcLdc_TT_Local.geograp_location_id  := nulocalidad;
                        pkg_Ldc_TT_Local.prinsRegistro( rcLdc_TT_Local);  
                    END IF;

                    COMMIT;
                END LOOP;
                
                CLOSE crOrdRangoFechXClasifContable;
                
            END IF;

            COMMIT;

        END IF;
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 
                
    EXCEPTION
        WHEN pkg_Error.CONTROLLED_ERROR
        THEN
            IF crOrdRangoFechXClasifContable%IsOpen THEN
                CLOSE crOrdRangoFechXClasifContable;
            END IF;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);             
            sberror :=
                   sberror
                || csbMetodo
                || '.'
                || nupaso
                || ' - '
                || nuorden_id;

            pkg_error.setErrorMessage( isbMsgErrr => sberror );
        WHEN OTHERS
        THEN
            IF crOrdRangoFechXClasifContable%IsOpen THEN
                CLOSE crOrdRangoFechXClasifContable;
            END IF;        
            pkg_Error.setError;
            pkg_Error.getError(nuError,sbError); 
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);                       
            sberror :=
                   csbMetodo
                || '.'
                || nupaso
                || ' - '
                || nuorden_id
                || ' - '
                || sbError;
            pkg_error.setErrorMessage( isbMsgErrr => sberror );            
    END ldc_valida_conf_tt;

    PROCEDURE envia_tt_localidad (isbprocesopadre   IN     VARCHAR2,
                                  osberrormessage      OUT VARCHAR2)
    IS
        /*****************************************************************
          Propiedad intelectual de Gases del Caribe / Efigas S.A.

          Nombre del Proceso: envia_tt_localidad
          Descripcion: Proceso que notifica por correo todos los tipos de
                       trabajo por localidad que no tengan la configuracion
                       contable completa
          Autor  : Caren Berdejo, Ludycom S.A.
          Fecha  : 12-10-2016

          Historia de Modificaciones

          DD-MM-YYYY    <Autor>.              Modificacion
          -----------  -------------------    -------------------------------------

        ******************************************************************/

        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'envia_tt_localidad';

        --Datos flArchivo adjunto
        flArchivo        pkg_gestionArchivos.styArchivo;

        --nombre del flArchivo EJ: REPORTE_ACTIVIDADES_DETENIDAS_20160613_0832.CSV
        sbnombrearch     VARCHAR2 (100)
            :=    'REPORTE_TIPOTRABAJO_LOCALIDAD'
               || TO_CHAR (SYSDATE, 'YYYYMMDD_HH24MI');

        --Nombre del Directorio donde se almacenaran los archivos
        directorio       VARCHAR2 (255)
            := pkg_BCLD_Parameter.fsbObtieneValorCadena ('DIRECTORIO_CONFIG_TT'); ----------
        sbruta           VARCHAR2 (255);                 --Ruta del directorio
        sbpath           VARCHAR2 (255);         --Ruta completa del flArchivo
        blfile           BFILE;   --file type para crear el flArchivo en disco
        nuarchexiste     NUMBER;  --valida si creo algun flArchivo en el disco

        --Fuente donde el proceso tomara los datos
        sbfilesrcdesc    VARCHAR2 (100);
        --********** Parametros correo **********--
        sbfromdisplay    VARCHAR2 (4000) := 'Open SmartFlex';
        --Destinatarios
        sbto             VARCHAR2 (4000)
            := pkg_BCLD_Parameter.fsbObtieneValorCadena ('CORREO_CONFIG_TT_DEST'); ------------

        --asunto
        sbsubject        VARCHAR2 (255)
            := 'REPORTE DIARIO DE TIPO DE TRABAJO POR LOCALIDAD';

        --Cuerpo del correo electronico
        sbmsg            VARCHAR2 (32000)
            :=    '<div align="center"><b>REPORTE DIARIO DE TIPO DE TRABAJO POR LOCALIDAD</b><p>Fecha de Proceso: '
               || SYSDATE
               || '<br>Fuente de Datos: ##FUENTE##
                                 <br></p><br><br><style type="text/css">
                                          .tg  {border-collapse:collapse;border-spacing:0}
                                          .tg td{font-family:Arial, sans-serif;font-size:14px;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;}
                                          .tg th{font-family:Arial, sans-serif;font-size:14px;font-weight:normal;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;}
                                          .tg .tg-1{text-align:left}
                                          .tg .tg-2{text-align:center}
                                          .tg .tg-3{text-align:right}
                                          .tgh {background-color: #E5ECF9}
                                        </style><table class="tg"><tr><th class="tgh tg-2">Cantidad de Registros</th></tr>
                                        ##TABLA##
                                        <br><br><br><table width="100%" border="0">
                                        <tr bgcolor="#E5ECF9"><td><div align="center"><font face="Tahoma" size="1" color="#FFFFFF"><font color="#003333"><b> '
               || REPLACE (isbprocesopadre, csbSP_NAME || '.', '')
               || ' </b></font></font></div></td></tr>
                                        <tr bgcolor="#E5ECF9"><td><div align="center"><font face="Tahoma" size="1" color="#FFFFFF"><font color="#003333"><b> Open SmartFlex </b></font></font></div></td></tr></table></div>';

        sbmsgtbl         VARCHAR2 (32000);
        sbfileext        VARCHAR2 (10) := 'CSV'; --especifica el tipo de flArchivo que se enviará. zip o CSV

        exnofile         EXCEPTION;
        exparam          EXCEPTION;
        exruta           EXCEPTION;
        nupaso           NUMBER;

        CURSOR cubodyemail IS
            SELECT COUNT (*)     cantidad
              FROM (  SELECT DISTINCT t.task_type_id, t.geograp_location_id
                        FROM ldc_tt_local t
                    ORDER BY t.task_type_id, t.geograp_location_id);

        CURSOR cubodyreport IS
              SELECT DISTINCT
                        t.task_type_id
                     || ' - '
                     || (SELECT INITCAP (tt.description)
                           FROM or_task_type tt
                          WHERE tt.task_type_id = t.task_type_id)
                         AS task_type_id,
                        t.geograp_location_id
                     || ' - '
                     || (SELECT INITCAP (g.description)
                           FROM ge_geogra_location g
                          WHERE g.geograp_location_id = t.geograp_location_id)
                         AS geograp_location_id
                FROM ldc_tt_local t
            ORDER BY task_type_id, geograp_location_id;

        CURSOR cucorreos (isbdata VARCHAR2)
        IS
        SELECT ROWNUM Id, regexp_substr(isbdata,'[^;]+', 1,LEVEL) COLUMN_VALUE
        FROM dual
        CONNECT BY regexp_substr(isbdata, '[^;]+', 1, LEVEL) IS NOT NULL;

        sbproceso  VARCHAR2(100)  := 'ENVIA_TT_LOCALIDAD'||TO_CHAR(SYSDATE,'DDMMYYYYHH24MISS');
                  
    BEGIN
    
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
            
        nupaso := 10;

        IF (pkg_BCLD_Parameter.fsbObtieneValorCadena ('VALIDA_CONFIG_TT') = 'S')
        THEN
            COMMIT;
            pkg_Traza.trace ('INICIO ' || csbSP_NAME || '.' || csbMetodo);
            nupaso := 20;

            --inicio el LOG
            pkg_estaproc.prinsertaestaproc( sbproceso , 1);
            
            nupaso := 30;

            --valido que la cadena del remitente y destinatarios este bien formada
            IF    fbocheckmailformat (sbto) = FALSE
               OR fbocheckmailformat (sbRemitente) = FALSE
               OR directorio IS NULL
            THEN
                RAISE exparam;
                nupaso := 40;
            END IF;

            nupaso := 50;

            --se obtiene la ruta del directorio
            BEGIN
                                         
                 sbruta := pkg_BOUtilidades.fsbRutaDirectorioOracle( directorio );
                 
            EXCEPTION
                WHEN NO_DATA_FOUND
                THEN
                    RAISE exruta;
                WHEN OTHERS
                THEN
                    RAISE exruta;
            END;

            nupaso := 60;

            --****** SE ARMA EL CUERPO DEL MENSAJE DE CORREO ******--
            --Se insertan los datos en la tabla HTML
            --Se insertan los datos en la tabla HTML
            FOR cureg IN cubodyemail
            LOOP
                sbmsgtbl :=
                       sbmsgtbl
                    || '<tr><td class="tg-2">'
                    || cureg.cantidad
                    || '</td></tr>';
            END LOOP;

            nupaso := 80;
            --Se Cierra la tabla html
            sbmsgtbl := sbmsgtbl || '</table>';

            nupaso := 90;
            --Coloco la fuente de datos que usa el proceso en el cuerpo del correo electronico.
            sbmsg := REPLACE (sbmsg, '##FUENTE##', sbfilesrcdesc);
            nupaso := 100;
            --INSERTO LA TABLA CON DATOS EN EL BODY DEL MENSAJE
            sbmsg := REPLACE (sbmsg, '##TABLA##', sbmsgtbl);
            nupaso := 110;
            --****** FIN CUERPO DEL MENSAJE DE CORREO ******--
            nupaso := 120;

            --****** SE CREA EL flArchivo DEL REPORTE EN LA RUTA ESPECIFICADA ******--
            BEGIN
                flArchivo :=
                    pkg_gestionArchivos.ftAbrirArchivo_SMF (
                        sbruta,
                        sbnombrearch || '.' || sbfileext,
                        pkg_gestionArchivos.csbMODO_ESCRITURA);
            EXCEPTION
                WHEN OTHERS
                THEN
                    RAISE exruta;
            END;

            nupaso := 130;
            --Titulo
            pkg_gestionArchivos.prcEscribeTermLinea_SMF (flArchivo);
            pkg_gestionArchivos.prcEscribirLinea_SMF (
                flArchivo,
                'REPORTE DIARIO DE TIPO DE TRABAJO POR LOCALIDAD');
            pkg_gestionArchivos.prcEscribirLinea_SMF (
                flArchivo,
                   'PROCESO FUENTE: '
                || REPLACE (isbprocesopadre, csbSP_NAME || '.', ''));
            pkg_gestionArchivos.prcEscribirLinea_SMF (
                flArchivo,
                'OPEN SMARTFLEX');
            pkg_gestionArchivos.prcEscribeTermLinea_SMF (flArchivo);
            pkg_gestionArchivos.prcEscribirLineaSinTerm_SMF (
                flArchivo,
                'Fecha de Proceso: ' || SYSDATE);
            pkg_gestionArchivos.prcEscribeTermLinea_SMF (flArchivo);
            pkg_gestionArchivos.prcEscribeTermLinea_SMF (flArchivo);
            nupaso := 140;
            --Encabezado flArchivo adjunto
            pkg_gestionArchivos.prcEscribirLineaSinTerm_SMF (flArchivo,
                                                             'TIPO_TRABAJO');
            pkg_gestionArchivos.prcEscribirLinea_SMF (flArchivo,
                                                             ';LOCALIDAD');
            nupaso := 150;

            --Relleno el detalle del flArchivo
            FOR rccurpt IN cubodyreport
            LOOP
                nupaso := 160;
                pkg_gestionArchivos.prcEscribirLinea_SMF (
                    flArchivo,
                       rccurpt.task_type_id
                    || ';'
                    || rccurpt.geograp_location_id);
                nupaso := 170;
            END LOOP;

            nupaso := 180;
            pkg_gestionArchivos.prcCerrarArchivo_SMF (
                flArchivo,
                sbruta,
                sbnombrearch || '.' || sbfileext);
            nupaso := 190;
            --Se establece la ruta completa del flArchivo en la variable PATH (Solo para la compresion)
            sbpath := sbruta || '/' || sbnombrearch;
            nupaso := 200;
            --Comprimir archivos
            pkg_BOUtilidades.prcGeneraArchivoZip (sbruta , sbnombrearch || '.' || sbfileext);
            nupaso := 210;
            --Se valida si el flArchivo ZIP fue creado correctamente se adjunta, si no se envia el CSV
            --y Se indica con la variable SBFILEEXT
            blfile := BFILENAME (directorio, sbnombrearch || '.zip');
            nupaso := 220;
            nuarchexiste := DBMS_LOB.fileexists (blfile);
            nupaso := 230;

            IF nuarchexiste = 1
            THEN
                nupaso := 240;
                sbfileext := 'zip';
            ELSE
                nupaso := 250;
                blfile := NULL;
                blfile :=
                    BFILENAME (directorio, sbnombrearch || '.' || sbfileext);
                nuarchexiste := DBMS_LOB.fileexists (blfile);

                IF nuarchexiste = 1
                THEN
                    nupaso := 260;
                    sbfileext := 'CSV';
                END IF;

                nupaso := 270;
            END IF;

            --Se valida si hay flArchivo a enviar
            IF sbfileext = 'zip' OR sbfileext = 'CSV'
            THEN

                nupaso := 290;

                --Por requisito del proceso que envia el mensaje se hace envio por cada destinario
                FOR i IN cucorreos (sbto)
                LOOP
                    nupaso := 300;
                    --Enviar el correo electronico con el adjunto

                    pkg_Correo.prcEnviaCorreo
                    (
                        isbRemitente        => sbRemitente,
                        isbDestinatarios    => i.COLUMN_VALUE,
                        isbAsunto           => sbsubject,
                        isbMensaje          => sbmsg,
                        isbArchivos         => directorio || '/' || sbnombrearch || '.' || sbfileext,
                        isbDescRemitente    => sbfromdisplay
                    );

                    nupaso := 310;
                END LOOP;

                nupaso := 320;

                nupaso := 330;

                --Se borran los archivos que se generaron en el servidor.
                BEGIN
                    IF sbfileext = 'CSV'
                    THEN
                        nupaso := 340;
                        pkg_gestionArchivos.prcBorrarArchivo_SMF (
                            sbruta,
                            sbnombrearch || '.CSV');
                    ELSIF sbfileext = 'zip'
                    THEN
                        nupaso := 350;
                        pkg_gestionArchivos.prcBorrarArchivo_SMF (
                            sbruta,
                            sbnombrearch || '.zip');
                        pkg_gestionArchivos.prcBorrarArchivo_SMF (
                            sbruta,
                            sbnombrearch || '.CSV');
                    END IF;

                    nupaso := 360;
                EXCEPTION
                    WHEN OTHERS
                    THEN
                        osberrormessage :=
                               nupaso
                            || ' - '
                            || 'ERROR AL BORRAR LOS ARCHIVOS TEMPORALES DEL SERVIDOR';
                END;
            ELSE
                --Se genera el error
                nupaso := 370;
                RAISE exnofile;
            END IF;

            nupaso := 380;
            -- estado del Proceso Actual
            pkg_estaproc.prActualizaEstaproc( isbproceso => sbproceso, isbEstado => 'OK', isbObservacion => 'Termino OK / correo enviado!.');
            

            pkg_Traza.trace ('FIN ' || csbSP_NAME || '.' || csbMetodo);
        END IF;

        nupaso := 410;
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);  
                
    EXCEPTION
        WHEN exparam
        THEN
            osberrormessage :=
                   nupaso
                || ' - '
                || 'ENVIA_TT_LOCALIDAD: NO SE ENVIO EL MENSAJE. VERIFICAR QUE LOS PARAMETROS (DIRECTOPRIO_CONFIG_TT, CORREO_CONFIG_TT_DEST, FUENTE_DATOS_CONFIG_TT) TENGAN DATOS VALIDOS.';
            pkg_Traza.trace (osberrormessage);
            --Actualiza LDC_OSF_ESTAPROC
            pkg_estaproc.prActualizaEstaproc( isbproceso => sbproceso, isbEstado => 'Error', isbObservacion => osberrormessage);
            pkg_error.setErrorMessage( isbMsgErrr => osberrormessage ); 
        WHEN exruta
        THEN
            osberrormessage :=
                   nupaso
                || ' - '
                || 'ENVIA_TT_LOCALIDAD: NO SE ENVIO EL MENSAJE. VERIFICAR QUE EL DIRECTORIO DEFINIDO EN EL PARAMETRO DIRECTOPRIO_CONFIG_TT TENGA UNA RUTA VALIDA EN EL SERVIDOR PARA GENERAR EL ADJUNTO.';
            pkg_Traza.trace (osberrormessage);
            --Actualiza LDC_OSF_ESTAPROC
            pkg_estaproc.prActualizaEstaproc( isbproceso => sbproceso, isbEstado => 'Error', isbObservacion => osberrormessage);
            pkg_error.setErrorMessage( isbMsgErrr => osberrormessage );            
        WHEN exnofile
        THEN
            osberrormessage :=
                   nupaso
                || ' - '
                || 'ENVIA_TT_LOCALIDAD: NO SE ENVIO EL MENSAJE. ERROR AL CARGAR EL flArchivo ADJUNTO; VALIDAR LOS PERMISOS EN EL DIRECTORIO PARAMETRIZADO.'
                || CHR (10)
                || SQLERRM
                || CHR (10);
            pkg_Traza.trace (osberrormessage);
            --Actualiza LDC_OSF_ESTAPROC
            pkg_estaproc.prActualizaEstaproc( isbproceso => sbproceso, isbEstado => 'Error', isbObservacion => osberrormessage);
            pkg_error.setErrorMessage( isbMsgErrr => osberrormessage );            
        WHEN OTHERS
        THEN
            osberrormessage :=
                   nupaso
                || ' - '
                || 'ENVIA_TT_LOCALIDAD: TERMINO CON ERROR NO CONTROLADO. '
                || CHR (10)
                || SQLERRM;
            pkg_Traza.trace (osberrormessage);
            --Actualiza LDC_OSF_ESTAPROC
            pkg_estaproc.prActualizaEstaproc( isbproceso => sbproceso, isbEstado => 'Error', isbObservacion => osberrormessage);
            pkg_error.setErrorMessage( isbMsgErrr => osberrormessage );            
    END envia_tt_localidad;

    FUNCTION fbocheckmailformat (isbdata VARCHAR2)
        RETURN BOOLEAN
    IS
        /*****************************************************************
          Propiedad intelectual de Gases del Caribe / Efigas S.A.

          Nombre del Proceso: FBOCHECKMAILFORMAT
          Descripcion: Funcion que valida si la cadena pasada como parametro cumple con la estructura .

          Autor  : Ing. Oscar Ospino Patino, Ludycom S.A.
          Fecha  : 20-06-2016

          Historia de Modificaciones

          DD-MM-YYYY    <Autor>.              Modificacion
          -----------  -------------------    -------------------------------------

        ******************************************************************/
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fbocheckmailformat';
    
        boresult     BOOLEAN := FALSE;
        nucant       NUMBER;
        nucantmail   NUMBER;
    BEGIN
    
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
            
        --Contar la cantidad de datos
        BEGIN
            SELECT COUNT(regexp_substr(isbdata,'[^;]+', 1,LEVEL))
            INTO nucant
            FROM dual
            CONNECT BY regexp_substr(isbdata, '[^;]+', 1, LEVEL) IS NOT NULL;              
        EXCEPTION
            WHEN OTHERS
            THEN
                boresult := FALSE;
        END;

        --Contar la cantidad de datos que cumplen la estructura de correo electronico
        BEGIN
            SELECT COUNT (COLUMN_VALUE)
            INTO nucantmail
            FROM
            (
                SELECT regexp_substr(isbdata,'[^;]+', 1,LEVEL) COLUMN_VALUE
                FROM dual
                CONNECT BY regexp_substr(isbdata, '[^;]+', 1, LEVEL) IS NOT NULL            
            )
             WHERE REGEXP_LIKE (
                       COLUMN_VALUE,
                       '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$');
        EXCEPTION
            WHEN OTHERS
            THEN
                boresult := FALSE;
        END;

        --Comparo las cantidades. Si son iguales la cadena esta bien formada. (TRUE)
        IF nucantmail = nucant
        THEN
            boresult := TRUE;
        ELSE
            boresult := FALSE;
        END IF;
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);          

        RETURN boresult;
    EXCEPTION
        WHEN OTHERS
        THEN
            boresult := FALSE;
            RETURN boresult;
    END fbocheckmailformat;

    PROCEDURE proceso_job
    IS
        /*****************************************************************
          Propiedad intelectual de Gases del Caribe / Efigas S.A.

          Nombre del Proceso: proceso_job
          Descripcion: Proceso que es llamado por el Job para el envio de los correos
          Autor  : Caren Berdejo, Ludycom S.A.
          Fecha  : 12-10-2016

          Historia de Modificaciones

          DD-MM-YYYY    <Autor>.              Modificacion
          -----------  -------------------    -------------------------------------
        14/12/2017     María José Lara        Se debe modificar el paquete ldc_pkvalida_tt_local
                                              en la función valida_trigger para que si no se encuentra activo
                                              el tipo de trabajo en la tabla ldc_tt_tb ttb, la función retorne 0
                                              (Linea 906)---CA 200-1581

        ******************************************************************/
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'proceso_job';        
        osberrormessage   VARCHAR2 (4000);
        contratista       NUMBER;
        
        sbproceso       VARCHAR2(100)  := 'JOB_TT_LOCALIDAD_CONFIG_CONTAB'||TO_CHAR(SYSDATE,'DDMMYYYYHH24MISS');


        nuError         NUMBER;
        sbError         VARCHAR2(4000);
          
    BEGIN
    
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  

        pkg_estaproc.prinsertaestaproc( sbproceso , 1);
                        
        contratista := -1;
        
        ldc_pkvalida_tt_local.ldc_valida_conf_tt (contratista);
        
        envia_tt_localidad ('JOB', osberrormessage);

        pkg_estaproc.prActualizaEstaproc( isbproceso => sbproceso, isbEstado => 'OK', isbObservacion => 'Termino OK  / correo enviado!.');

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
          
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            pkg_estaproc.prActualizaEstaproc( isbproceso => sbproceso, isbEstado => 'Error' , isbObservacion => 'Termino con Error!.[' || sbError || ']'); 
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);             
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );            
            pkg_estaproc.prActualizaEstaproc( isbproceso => sbproceso, isbEstado => 'Error' , isbObservacion => 'Termino con Error!.[' || sbError || ']');
    END proceso_job;

    FUNCTION valida_trigger (nucontratista NUMBER, nuacta NUMBER)
        RETURN NUMBER
    IS
        --200-1957 19/07/2018 dsaltarin se modifica para tratar de optimazar la consulta
        --         y para que valide el dato adicional del activo en caso
        --         que no encuentre el dato adicional
        /*  200-2227 09/11/2018 Elkin Alvarez  200-2227 PROCEDIMIENTO : valida_trigger Linea  1100, Se agrega la consulta la sbcuentacosto
                                                    Linea  1210, Se valida si la cuenta de costo es null,
                                                    devuelva lo configurado en el parametro : LDC_VAL_CONT_CUENTAMULTAS.*/
        /*  CA:840 21/10/2021 Horbath   CA:840 Se modifica el procedimineto para que  se tengan Se cuenten las ordenes que no tienen lleno el
               campo external_address_id y poder enviar un mensaje de error con la siguiente cadena Existen N ordenes sin direccion*/
               
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'valida_trigger';
                   
        nuOrdenes             NUMBER;
        
        nuorden_id            NUMBER(15);
        nuactivo              NUMBER;
        nudatoadic            NUMBER;

        nucentrocosto         NUMBER;
        nuclasicontab         NUMBER(15);
        sbttactivo            VARCHAR2(1);
        sbMensaje             VARCHAR2 (4000);
        sbcuentacosto         VARCHAR2(20);
        nucontacuenta         NUMBER (8);
        nucantorSindir        NUMBER := 0;                         -- caso:840

        nucantacta            NUMBER;
        
        crOrdContratistaActa  constants_per.tyRefCursor;
        
        TYPE tyrgcuordenes IS RECORD 
        (   order_id            NUMBER,
            task_type_id        NUMBER,    
            titr_validar        NUMBER,
            geograp_location_id NUMBER,
            defined_contract_id NUMBER
        ); 
        
        rgcuordenes         tyrgcuordenes; 

    BEGIN
    
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
            
        nuOrdenes := 0;
        nucantacta := 0;
        pkg_Traza.trace ('entro valida_trigger', 10);
        
        nucantacta := pkg_BCValida_tt_local.fnuCantOrdDetalleActa( nuActa );
        
        IF nucantacta > 0
        THEN
        
            crOrdContratistaActa := pkg_BCValida_tt_local.fcrOrdContratistaActa(nucontratista,nuActa);
            
            IF crOrdContratistaActa%IsOpen THEN
            
                LOOP
                
                    FETCH crOrdContratistaActa INTO rgcuordenes;
                    
                    EXIT WHEN crOrdContratistaActa%NotFound;
                    
                    nuorden_id := rgcuordenes.order_id;
                    
                    sbttactivo := pkg_ldc_tt_tb.fsbObtACTIVE_FLAG(rgcuordenes.task_type_id);
                
                    sbttactivo := NVL(sbttactivo,'N');

                    IF (UPPER (sbttactivo) = 'Y' /*Or rgcuordenes.defined_contract_id Is Not Null*/
                                                )
                    THEN
                    
                        nuclasicontab := pkg_BCValida_tt_local.fnuObtieneClasifContabTiTr(rgcuordenes.task_type_id);
      
                        IF nuclasicontab IS NOT NULL
                        THEN
                            sbcuentacosto := NULL;
                            
                            sbcuentacosto := pkg_BCValida_tt_local.fsbObtienCuentaCosto( nuclasicontab );

                            IF sbcuentacosto IS NOT null THEN

                                nuactivo := NULL;
                                
                                OPEN cuClasificadoresActas( nuclasicontab, sbClasAct ); 
                                FETCH cuClasificadoresActas INTO nuactivo;
                                CLOSE cuClasificadoresActas;

                                IF nuactivo = 1
                                THEN
                                    IF sbdatoadic IS NOT NULL
                                    THEN

                                        nudatoadic := pkg_BCValida_tt_local.fnuObtieneDatoAdicional( nuorden_id, sbdatoadic );

                                        IF     nudatoadic IS NULL
                                           AND sbValidaActivoTabla = 'S'
                                        THEN
                                        
                                            nudatoadic := pkg_BCValida_tt_local.fnuObtieneCantActTiTrLoc( rgcuordenes.geograp_location_id,rgcuordenes.task_type_id); 
      
                                        END IF;

                                        IF    nudatoadic IS NULL
                                           OR nudatoadic > 1
                                           OR nudatoadic = 0
                                        THEN
                                            nuOrdenes := nuOrdenes + 1;

                                            IF NVL (
                                                   INSTR (
                                                       sbMensaje,
                                                       rgcuordenes.task_type_id),
                                                   0) =
                                               0
                                            THEN
                                                sbMensaje :=
                                                       sbMensaje
                                                    || ','
                                                    || rgcuordenes.titr_validar;
                                            END IF;
                                        END IF;
                                    --200-1957
                                    ELSE
                                        nuOrdenes := nuOrdenes + 1;

                                        IF NVL (
                                               INSTR (sbMensaje,
                                                      rgcuordenes.task_type_id),
                                               0) =
                                           0
                                        THEN
                                            sbMensaje :=
                                                   sbMensaje
                                                || ','
                                                || rgcuordenes.titr_validar;
                                        END IF;
                                    END IF;
                                ELSE
                                    
                                    nucentrocosto := pkg_BCValida_tt_local.fnuObtieneCentCostTiTrLoc
                                                    (rgcuordenes.geograp_location_id,
                                                    rgcuordenes.task_type_id
                                                    );                                

                                    IF nucentrocosto IS NULL
                                    THEN
                                               
                                        OPEN cuValContMultCuenta(sbcuentacosto);
                                        FETCH cuValContMultCuenta INTO nucontacuenta;
                                        CLOSE cuValContMultCuenta;
                                    
                                        IF nucontacuenta = 0
                                        THEN
                                            nuOrdenes := nuOrdenes + 1;

                                            IF NVL (
                                                   INSTR (
                                                       sbMensaje,
                                                       rgcuordenes.task_type_id),
                                                   0) =
                                               0
                                            THEN
                                                sbMensaje :=
                                                       sbMensaje
                                                    || ','
                                                    || rgcuordenes.titr_validar;
                                            END IF;
                                        END IF;
                                    ELSE
                                        nuOrdenes := nuOrdenes + 0;
                                    END IF;
                                END IF;
                            ELSE
                                nuOrdenes := nuOrdenes + 1;

                                IF NVL (
                                       INSTR (sbMensaje,
                                              rgcuordenes.task_type_id),
                                       0) =
                                   0
                                THEN
                                    sbMensaje :=
                                           sbMensaje
                                        || ','
                                        || rgcuordenes.titr_validar;
                                END IF;
                            END IF;
                        ELSE
                            nuOrdenes := nuOrdenes + 1;          ---CASO 200-1581}

                            IF NVL (INSTR (sbMensaje, rgcuordenes.task_type_id),
                                    0) =
                               0
                            THEN
                                sbMensaje :=
                                    sbMensaje || ',' || rgcuordenes.titr_validar;
                            END IF;
                        END IF;
                    ELSE
                        nuOrdenes := nuOrdenes + 0;
                    END IF;
                END LOOP;
                        
                CLOSE crOrdContratistaActa;
            
            END IF;
            
            nucantorSindir := pkg_BCValida_tt_local.fnuCantOrdContActSinDir( nucontratista, nuActa );
                
        END IF;

        IF nuOrdenes > 0 AND nucantorSindir > 0
        THEN
            pkg_Traza.trace ('nuOrdenes 1', 10);
            sbMensaje :=
                   'Existen ordenes de los siguientes tipos de trabajo sin configuración contable: '
                || sbMensaje;
            sbMensaje :=
                   sbMensaje
                || ' Existen '
                || nucantorSindir
                || ' ordenes sin dirección';
            sbMensaje := SUBSTR (sbMensaje, 0, 3999);
            pkg_error.setErrorMessage( isbMsgErrr => sbMensaje );
        END IF;

        IF nucantorSindir > 0 AND nuOrdenes = 0
        THEN
            pkg_Traza.trace ('nuOrdenes 1', 10);
            sbMensaje :=
                'Existen ' || nucantorSindir || ' ordenes sin dirección';
            pkg_error.setErrorMessage( isbMsgErrr => sbMensaje );            
        END IF;

        IF nuOrdenes > 0
        THEN
            pkg_Traza.trace ('nuOrdenes 1', 10);
            sbMensaje :=
                   'Existen ordenes de los siguientes tipos de trabajo sin configuración contable: '
                || sbMensaje;
            pkg_error.setErrorMessage( isbMsgErrr => sbMensaje );
        END IF;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);  
        
        RETURN 0;
                                    
    EXCEPTION
        WHEN OTHERS
        THEN
            IF crOrdContratistaActa%IsOpen THEN
                CLOSE crOrdContratistaActa;
            END IF;
            sbMensaje := SQLERRM;
            pkg_Traza.trace ('Exception 0 - ' || SQLERRM, 10);
            pkg_Error.getError (nuOrdenes, sbMensaje);
            pkg_Traza.trace (sbMensaje);
            RAISE;
    END valida_trigger;

END ldc_pkvalida_tt_local;
/

Prompt Otorgando permisos sobre PERSONALIZACIONES.ldc_pkvalida_tt_local
BEGIN
    pkg_Utilidades.prAplicarPermisos(upper('ldc_pkvalida_tt_local'), 'PERSONALIZACIONES');
END;
/

