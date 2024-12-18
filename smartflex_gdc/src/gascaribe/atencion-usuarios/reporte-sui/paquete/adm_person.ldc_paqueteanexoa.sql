CREATE OR REPLACE PACKAGE adm_person.ldc_paqueteanexoa
IS
    /*****************************************************************
    Propiedad intelectual de JM GESTIONINFORMATICA S.A

    Package      : ldc_paqueteanexoa
    Descripci?n  : SUI ANEXOA
    Autor        : John Jairo Jimenez Marimon
    Fecha        : 15-06-2016

    Historia de Modificaciones
    Autor       Fecha       Modificación
    jpinedc     29/05/2024  OSF-2603: * Se reemplaza utl_file por pkg_gestionCorreo 
                            * Se reemplaza ge_boFileManager por pkg_gestionCorreo  
                            * Se reemplaza LDC_ManagementEmailFNB.PROENVIARCHIVO
                            por pkg_Correo.prcEnviaCorreo
    Adrianavg   26/06/2024 OSF-2883: Migrar del esquema OPEN al esquema ADM_PERSON                       
    ******************************************************************/
    gsbAuxLine      VARCHAR2(32767) := null;
    PROCEDURE regenerareportea(nureporte ldc_detarepoatecli.ateclirepo_id%TYPE,nuano NUMBER,numes NUMBER,sbmail VARCHAR2,sbAprobado VARCHAR2 DEFAULT NULL,sbrutaarch VARCHAR2,sbmensalida IN OUT VARCHAR2);
    FUNCTION ldc_fncretoripsolanula(nusolicitud mo_packages.package_id%TYPE,dtfecharecib DATE) RETURN NUMBER;
    FUNCTION ldc_fncretornalocadanesolaso(nusolicitud mo_packages.package_id%TYPE) RETURN NUMBER;
    FUNCTION ldc_fncretornanroctasolaso(nusolicitud mo_packages.package_id%TYPE) RETURN NUMBER;
    PROCEDURE impresion (vfile IN OUT pkg_gestionArchivos.styArchivo, sbline VARCHAR2);
    PROCEDURE creadetallereporte(ircldc_detarepoatecli IN OUT daldc_detarepoatecli.styldc_detarepoatecli);
    PROCEDURE Processvarsuianexoa;
END ldc_paqueteanexoa;
/

CREATE OR REPLACE PACKAGE BODY adm_person.ldc_paqueteanexoa
IS
    csbSP_NAME		CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT||'.';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
    
    /*****************************************************************
    Propiedad intelectual de JM GESTIONINFORMATICA S.A

    Package      : ldc_paqueteanexoa
    Descripción  : SUI ANEXOA
    Autor        : John Jairo Jimenez Marimon
    Fecha        : 15-06-2016

    Historia de Modificaciones
    ******************************************************************/

    --------------------------------------------
    -- Constantes VERSION DEL PAQUETE
    --------------------------------------------
    sbLineFeed      VARCHAR2(10) := chr(10);
    cnuMAXLENGTH    CONSTANT number := 32000;
    sbFile          VARCHAR2(250);
    nuErrorCode    number;
    sbAsunto varchar2(2000);
    sbMensaje varchar2(2000);

    --------------------------------------------
    -- Constantes PRIVADAS DEL PAQUETE
    --------------------------------------------
    csbSeparador    VARCHAR2(2) := ',';

    --------------------------------------------
    -- Variables PRIVADAS DEL PAQUETE
    --------------------------------------------

    CURSOR cuDetalleReporte (inuATECLIREPO_ID LDC_DETAREPOATECLI.ateclirepo_id%type)
     IS
     SELECT LDC_DETAREPOATECLI.*,LDC_DETAREPOATECLI.rowid
     FROM LDC_DETAREPOATECLI
     WHERE ATECLIREPO_ID = inuATECLIREPO_ID
     AND FLAG_REPORTA = 'S';

    PROCEDURE CreaReporte
        (ircLDC_ATECLIREPO in DALDC_ATECLIREPO.styLDC_ATECLIREPO) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'CreaReporte';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);         
        PRAGMA AUTONOMOUS_TRANSACTION;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
        DALDC_ATECLIREPO.insRecord(ircLDC_ATECLIREPO);
        commit;
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
    END CreaReporte;

    PROCEDURE CreaDetalleReporte
        (ircLDC_DETAREPOATECLI in out DALDC_DETAREPOATECLI.styLDC_DETAREPOATECLI) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'CreaDetalleReporte';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);         
        PRAGMA AUTONOMOUS_TRANSACTION;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO); 
        ircLDC_DETAREPOATECLI.FLAG_REPORTA := 'S';
        daLDC_DETAREPOATECLI.insRecord(ircLDC_DETAREPOATECLI);
        commit;
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
    END CreaDetalleReporte;

    PROCEDURE impresion (vfile IN OUT pkg_gestionArchivos.styArchivo, sbline VARCHAR2)
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'impresion';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);         
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO); 
        
        -- Reporta datos correctos en archivo de salida
        if ( length( gsbAuxLine || sbLine || sbLineFeed) < 32700 ) then
            if sbLine IS not null then
               gsbAuxLine := gsbAuxLine || sbLine || sbLineFeed ;
            END if;
        ELSE
            -- Escribe en disco
            pkg_gestionArchivos.prcEscribirLinea_SMF(vFile, SubStr(gsbAuxLine,0,length( gsbAuxLine)-1));
            -- Conserva la ultima iteracion
            gsbAuxLine := NULL;
            gsbAuxLine := gsbAuxLine || sbLine || sbLineFeed ;
        END if;
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
    END impresion;

    PROCEDURE ReGeneraReporteA
        (nuReporte LDC_DETAREPOATECLI.ateclirepo_id%type,
         nuAno number,
         nuMes number,
         sbMail varchar2,
         sbAprobado varchar2 default null,
         sbrutaarch VARCHAR2,
         sbmensalida IN OUT VARCHAR2)
    IS

        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'ReGeneraReporteA';
        nuError         NUMBER;
        sbError         VARCHAR2(4000); 

        sbLineaDeta           VARCHAR2(2000);
        vFileAnex             pkg_gestionArchivos.styArchivo; -- Archivo de salida
        nuconta               NUMBER DEFAULT 0;
        desc_estado_solicitud ps_motive_status.description%TYPE;
        desc_med_rec          ge_reception_type.description%TYPE;
        sbrespuestaosf        ldc_sui_tipres.descripcion%TYPE;
        sbdesccausal          ge_causal.description%TYPE;
        sbdesctipounit        ge_tipo_unidad.descripcion%TYPE;
        sbdescestadoitera     ps_motive_status.description%TYPE;
        sbtiposolicitud       ps_package_type.description%TYPE;
        nusoliproc            mo_packages.package_id%TYPE;
        
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO); 
            
        sbFile := sbAprobado||'Formato_anexo_A_'||nuAno||'_'||nuMes||'_'||To_Char(SYSDATE,'YYYY_MM_DD_HH_MI_SS')||'.csv';
        vFileAnex := pkg_gestionArchivos.ftAbrirArchivo_SMF(
                               sbrutaarch,
                               sbFile,
                               'W'
                               );
        IF sbAprobado = 'S' THEN
            sbLineaDeta := 'DANE DEPARTAMENTO,DANE MUNICIPIO,DANE POBLACION,RADICADO RECIBIDO,FECHA RADICACION,TIPO DE TRAMITE,CAUSAL,DETALLE DE LA CAUSAL,NUMERO DE CUENTA,NUMERO IDENTIFICADOR DE FACTURA,TIPO RESPUESTA,FECHA RESPUESTA,RADICADO RESPUESTA,FECHA DE NOTIFICACION,TIPO DE NOTIFICACION,FECHA TRASLADO A SSPD';
        ELSE
            sbLineaDeta := 'DANE DEPARTAMENTO,DANE MUNICIPIO,DANE POBLACION,RADICADO RECIBIDO,FECHA RADICACION,TIPO DE TRAMITE,CAUSAL,DETALLE DE LA CAUSAL,NUMERO DE CUENTA,NUMERO IDENTIFICADOR DE FACTURA,TIPO RESPUESTA,FECHA RESPUESTA,RADICADO RESPUESTA,FECHA DE NOTIFICACION,TIPO DE NOTIFICACION,FECHA TRASLADO A SSPD,TIPO_SOLICITUD,ESTADO_SOLICITUD,MEDIO_RECEPCION,TIPO_RESPUESTA_OSF,FECHA_NO_CARTAS,FECHA_CARTAS,CAUSAL LEGALIZACION OT,TIPO_UNIDAD_OPERATIVA,MEDIO_USO,ID_HOMOLOGACION,DIAS_REGISTRO,TIPO_REPORTE,ESTADO_ITERACCION,SOLICITUD,ATENCION_INMEDIATA,CARTA,VAL_FECH_RESP_RADI,VAL_FECH_NOTI_RESP,DIAS_HABIL_FECH_RESP_RAD,UNIDAD_TRABAJO_ORDEN';
        END IF;
        pkg_gestionArchivos.prcEscribirLinea_SMF(vFileAnex,sbLineaDeta);
        sbLineaDeta := null;
        nuconta := 0;
        for rcDetalleReporte in cuDetalleReporte (nuReporte) loop
         nusoliproc := rcDetalleReporte.Package_Id;
         IF sbAprobado = 'N' THEN
          -- Tipo de solicitud
          sbtiposolicitud := NULL;
          BEGIN
           SELECT tsr.description INTO sbtiposolicitud
             FROM ps_package_type tsr
            WHERE tsr.package_type_id = to_number(TRIM(rcDetalleReporte.Tipo_Solicitud));
          EXCEPTION
           WHEN no_data_found THEN
            sbtiposolicitud := NULL;
          END;
          sbtiposolicitud := replace(sbtiposolicitud,',',NULL);
          -- Descripcion estado solicitud
         desc_estado_solicitud := NULL;
         BEGIN
          SELECT est.description INTO desc_estado_solicitud
            FROM ps_motive_status est
           WHERE est.motive_status_id = rcDetalleReporte.estado_solicitud;
         EXCEPTION
          WHEN no_data_found THEN
           desc_estado_solicitud := NULL;
         END;
         desc_estado_solicitud := replace(desc_estado_solicitud,',',NULL);
         -- Medio de recepción
         desc_med_rec := NULL;
         BEGIN
          SELECT mr.description INTO desc_med_rec
            FROM ge_reception_type mr
           WHERE mr.reception_type_id = rcDetalleReporte.medio_recepcion;
         EXCEPTION
          WHEN no_data_found THEN
           desc_med_rec := NULL;
         END;
         desc_med_rec := replace(desc_med_rec,',',NULL);
        -- Tipo respuesta osf
        sbrespuestaosf := NULL;
        BEGIN
         SELECT ty.descripcion INTO sbrespuestaosf
           FROM ldc_sui_tipres ty
          WHERE ty.codigo_resp_osf = rcDetalleReporte.tipo_respuesta_osf;
        EXCEPTION
         WHEN no_data_found THEN
          sbrespuestaosf := NULL;
        END;
        sbrespuestaosf := replace(sbrespuestaosf,',',NULL);
         -- Descripción causal de legalización
       sbdesccausal := NULL;
       BEGIN
         SELECT cl.description INTO sbdesccausal
           FROM ge_causal cl
          WHERE cl.causal_id = rcDetalleReporte.causal_lega_ot;
       EXCEPTION
         WHEN no_data_found THEN
          sbdesccausal := NULL;
       END;
       sbdesccausal := replace(sbdesccausal,',',NULL);
       -- Descripción tipo unidad operativa
       sbdesctipounit := NULL;
       BEGIN
         SELECT gt.descripcion INTO sbdesctipounit
           FROM ge_tipo_unidad gt
          WHERE gt.id_tipo_unidad = rcDetalleReporte.tipo_unidad_oper;
       EXCEPTION
         WHEN no_data_found THEN
          sbdesctipounit := NULL;
       END;
       sbdesctipounit := replace(sbdesctipounit,',',NULL);
       -- Descripción estado iteracción
       sbdescestadoitera := NULL;
       BEGIN
        SELECT emi.description INTO sbdescestadoitera
          FROM ps_motive_status emi
         WHERE emi.motive_status_id = rcDetalleReporte.Estado_Iteraccion;
       EXCEPTION
        WHEN no_data_found THEN
         sbdescestadoitera := NULL;
       END;
       sbdescestadoitera := REPLACE(sbdescestadoitera,',',NULL);
         sbLineaDeta :=               rcdetallereporte.dane_dpto                                       ||
                        csbseparador||rcdetallereporte.dane_municipio                                  ||
                        csbseparador||rcdetallereporte.dane_poblacion                                  ||
                        csbseparador||rcdetallereporte.radicado_ing                                    ||
                        csbseparador||rcdetallereporte.fecha_registro                                  ||
                        csbseparador||rcdetallereporte.tipo_tramite                                    ||
                        csbseparador||rcdetallereporte.causal                                          ||
                        csbseparador||rcdetallereporte.detalle_causal                                  ||
                        csbseparador||rcdetallereporte.numero_identificacion                           ||
                        csbseparador||rcdetallereporte.numero_factura                                  ||
                        csbseparador||rcdetallereporte.tipo_respuesta                                  ||
                        csbseparador||rcdetallereporte.fecha_respuesta                                 ||
                        csbseparador||rcdetallereporte.radicado_res                                    ||
                        csbseparador||rcdetallereporte.fecha_notificacion                              ||
                        csbseparador||rcdetallereporte.tipo_notificacion                               ||
                        csbseparador||rcdetallereporte.fecha_traslado                                  ||
                        csbseparador||rcdetallereporte.tipo_solicitud    ||' - '||sbtiposolicitud      ||
                        csbseparador||rcdetallereporte.estado_solicitud  ||' - '||desc_estado_solicitud||
                        csbseparador||rcdetallereporte.medio_recepcion   ||' - '||desc_med_rec         ||
                        csbseparador||rcdetallereporte.tipo_respuesta_osf||' - '||sbrespuestaosf       ||
                        csbseparador||rcdetallereporte.fecha_fin_ot_soli                               ||
                        csbseparador||rcdetallereporte.fecha_ejec_tt_re                                ||
                        csbseparador||rcdetallereporte.causal_lega_ot    ||' - '||sbdesccausal         ||
                        csbseparador||rcdetallereporte.tipo_unidad_oper  ||' - '||sbdesctipounit       ||
                        csbseparador||rcdetallereporte.medio_uso                                       ||
                        csbseparador||rcdetallereporte.codigo_homologacion                             ||
                        csbseparador||rcdetallereporte.dias_registro                                   ||
                        csbseparador||rcdetallereporte.tipo_reg_reporte                                ||
                        csbseparador||rcdetallereporte.estado_iteraccion||' - '||sbdescestadoitera     ||
                        csbSeparador||rcdetallereporte.package_id                                      ||
                        csbSeparador||rcdetallereporte.atencion_inmediata                              ||
                        csbSeparador||rcdetallereporte.carta                                           ||
                        csbSeparador||rcdetallereporte.val_ferad_feresp                                ||
                        csbSeparador||rcdetallereporte.val_feresp_fenot                                ||
                        csbSeparador||rcdetallereporte.deleysiono                                      ||
                        csbSeparador||rcdetallereporte.unida_oper;
       ELSE
        sbLineaDeta :=                rcdetallereporte.dane_dpto            ||
                        csbseparador||rcdetallereporte.dane_municipio       ||
                        csbseparador||rcdetallereporte.dane_poblacion       ||
                        csbseparador||rcdetallereporte.radicado_ing         ||
                        csbseparador||rcdetallereporte.fecha_registro       ||
                        csbseparador||rcdetallereporte.tipo_tramite         ||
                        csbseparador||rcdetallereporte.causal               ||
                        csbseparador||rcdetallereporte.detalle_causal       ||
                        csbseparador||rcdetallereporte.numero_identificacion||
                        csbseparador||rcdetallereporte.numero_factura       ||
                        csbseparador||rcdetallereporte.tipo_respuesta       ||
                        csbseparador||rcdetallereporte.fecha_respuesta      ||
                        csbseparador||rcdetallereporte.radicado_res         ||
                        csbseparador||rcdetallereporte.fecha_notificacion   ||
                        csbseparador||rcdetallereporte.tipo_notificacion    ||
                        csbseparador||rcdetallereporte.fecha_traslado;
       END IF;

      impresion (vFileAnex,sbLineaDeta);
        nuconta := nuconta + 1;
      end loop;
      -- Verifica si existen datos correctos sin bajar a disco
        if ( gsbAuxLine IS NOT NULL ) then
        --{
            pkg_gestionArchivos.prcEscribirLinea_SMF(vFileAnex,gsbAuxLine);
            gsbAuxLine  := null;
        --}
        END if;

        sbmensalida := 'Se procesar?n : '||to_char(nuconta)||' registros.';
        -- Cierra archivo de impresion
        pkg_gestionArchivos.prcCerrarArchivo_SMF(vFileAnex);

        sbAsunto := 'FORMATO ANEXOA A - '||sbFile;
        sbMensaje := 'Reporte FORMATO ANEXO A '||nuAno||'  '||nuMes;
        
        pkg_Correo.prcEnviaCorreo
        (
            isbDestinatarios    => sbMail,
            isbAsunto           => sbAsunto,
            isbMensaje          => sbMensaje,
            isbArchivos         => sbrutaarch || '/' || sbFile
        );

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 
        
    EXCEPTION
          WHEN pkg_Error.CONTROLLED_ERROR THEN
            sbmensalida := '-1|| Error procensado la solicitud : '||to_char(nusoliproc)||' '||SQLERRM||' proceso : ldc_paqueteanexoa.regenerareportea.';
          WHEN OTHERS THEN
            sbmensalida := '-1|| Error procensado la solicitud : '||to_char(nusoliproc)||' '||SQLERRM||' proceso : ldc_paqueteanexoa.regenerareportea.';
    END ReGeneraReporteA;

    FUNCTION ldc_fncretoripsolanula(nusolicitud mo_packages.package_id%TYPE,dtfecharecib DATE) RETURN NUMBER IS
    /*****************************************************************
      Propiedad intelectual de JM GESTIONINFORMATICA S.A
      Funcion     : ldc_fncretoripsolanula
      Descripcion : Valida la existencia de un tipo de solicitud 9
                    asociada a una solicitud anulada o en anulacion

      Autor  : John Jairo Jimenez Marimon
      Fecha  : 16-06-2016

      Historia de Modificaciones

      DD-MM-YYYY    <Autor>.SAONNNNN        Modificacion
      -----------  -------------------    -------------------------------------
      ******************************************************************/

        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'ldc_fncretoripsolanula';
        nuError         NUMBER;
        sbError         VARCHAR2(4000); 
        
        dtfechsolaso  mo_packages.request_date%TYPE;
        dtmesaso      NUMBER(2);
        dtmesprin     NUMBER(2);
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO); 
            
        BEGIN
            SELECT m.request_date INTO dtfechsolaso
            FROM mo_packages_asso k,mo_packages m
            WHERE m.package_type_id = 9
             AND k.package_id = nusolicitud
             AND k.package_id_asso = m.package_id;
        EXCEPTION
            WHEN no_data_found THEN
                RETURN 0;
        END;
        dtmesaso  := to_number(to_char(dtfechsolaso,'MM'));
        dtmesprin := to_number(to_char(dtfecharecib,'MM'));

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 
                
        IF dtmesaso = dtmesprin THEN
            RETURN 1;
        ELSE
            RETURN 0;
        END IF;
    EXCEPTION
     WHEN OTHERS THEN
      RETURN -1;
    END ldc_fncretoripsolanula;
    
    FUNCTION ldc_fncretornalocadanesolaso(nusolicitud mo_packages.package_id%TYPE) RETURN NUMBER IS
    /*****************************************************************
      Propiedad intelectual de JM GESTIONINFORMATICA S.A
      Funcion     : ldc_fncretornalocadanesolaso
      Descripcion : Obtenemos el codigo dane de la localidad de la solicitud asociada

      Autor  : John Jairo Jimenez Marimon
      Fecha  : 16-06-2016

      Historia de Modificaciones

      DD-MM-YYYY    <Autor>.SAONNNNN        Modificacion
      -----------  -------------------    -------------------------------------
    ******************************************************************/

        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'ldc_fncretornalocadanesolaso';
        nuError         NUMBER;
        sbError         VARCHAR2(4000); 
      
        nulocadane ge_geogra_location.geograp_location_id%TYPE;
        CURSOR cusoliasociadadas(nucursoli mo_packages.package_id%TYPE) IS
        SELECT producto
           ,contrato
           ,cliente
           ,CASE WHEN producto IS NOT NULL THEN
             pr_bosuspendcriterions.fnugetproductlocality(producto)
           ELSE
            CASE WHEN contrato IS NOT NULL THEN
             ldc_fncretornalocacontrato(contrato)
            ELSE
             ldc_fncretornalocacliente(cliente)
            END
           END localidad_dane
        FROM(
        SELECT t.subscriber_id   cliente
           ,a.subscription_id contrato
           ,a.product_id      producto
        FROM mo_packages_asso s
           ,mo_motive a
           ,mo_packages t
        WHERE s.package_id       = nucursoli
        AND t.package_type_id != 268
        AND a.package_id       = s.package_id_asso
        AND a.package_id       = t.package_id
        );
    BEGIN
    
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO); 
            
        nulocadane := NULL;
        FOR i IN cusoliasociadadas(nusolicitud) LOOP
            nulocadane := i.localidad_dane;
        END LOOP;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);         
        RETURN nulocadane;
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
    END ldc_fncretornalocadanesolaso;
    
    FUNCTION ldc_fncretornanroctasolaso(nusolicitud mo_packages.package_id%TYPE) RETURN NUMBER IS
      /*****************************************************************
      Propiedad intelectual de JM GESTIONINFORMATICA S.A
      Funcion     : ldc_fncretornalocadanesolaso
      Descripcion : Obtenemos el nro de cta de la solicitud asociada

      Autor  : John Jairo Jimenez Marimon
      Fecha  : 16-06-2016

      Historia de Modificaciones

      DD-MM-YYYY    <Autor>.SAONNNNN        Modificacion
      -----------  -------------------    -------------------------------------
      ******************************************************************/
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'nombreMetodo';
        nuError         NUMBER;
        sbError         VARCHAR2(4000); 
      
        nrocta servsusc.sesususc%TYPE;
        CURSOR cusoliasociadadas(nucursoli mo_packages.package_id%TYPE) IS
        SELECT producto
           ,contrato
           ,cliente
           ,CASE WHEN producto IS NOT NULL THEN
             pr_bosuspendcriterions.fnugetproductlocality(producto)
           ELSE
            CASE WHEN contrato IS NOT NULL THEN
             contrato
            ELSE
             000
            END
           END nro_cta
        FROM(
        SELECT t.subscriber_id   cliente
           ,a.subscription_id contrato
           ,a.product_id      producto
        FROM mo_packages_asso s
           ,mo_motive a
           ,mo_packages t
        WHERE s.package_id       = nucursoli
        AND t.package_type_id != 268
        AND a.package_id       = s.package_id_asso
        AND a.package_id       = t.package_id
        );
        nutiposolicrere ld_parameter.numeric_value%TYPE;
        nutiposolicrers ld_parameter.numeric_value%TYPE;
        nutiposolicitud mo_packages.package_type_id%TYPE;
        nucontrato      servsusc.sesususc%TYPE;
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO); 
            
        nrocta          := NULL;
        nutiposolicitud := NULL;
        nutiposolicrere := pkg_BCLD_Parameter.fnuObtieneValorNumerico('TIPO_SOLICITUD_50');
        nutiposolicrers := pkg_BCLD_Parameter.fnuObtieneValorNumerico('TIPO_SOLICITUD_52');
        BEGIN
            SELECT s.package_type_id INTO nutiposolicitud
            FROM mo_packages s
            WHERE s.package_id = nusolicitud;
        EXCEPTION
            WHEN no_data_found THEN
                nutiposolicitud := NULL;
        END;
        
        IF nutiposolicitud IS NOT NULL THEN
            IF nutiposolicitud IN(nutiposolicrere,nutiposolicrers) THEN
                FOR i IN cusoliasociadadas(nusolicitud) LOOP
                    nrocta := i.nro_cta;
                END LOOP;
            ELSE
                BEGIN
                    SELECT mt.subscription_id INTO nucontrato
                    FROM mo_motive mt
                    WHERE mt.package_id = nusolicitud;
                EXCEPTION
                    WHEN no_data_found THEN
                        nucontrato := 0;
                END;
                nrocta := nucontrato;
            END IF;
        ELSE
            nrocta := 0;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);         
        RETURN nrocta;
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
    END ldc_fncretornanroctasolaso;

    PROCEDURE Processvarsuianexoa AS

        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'Processvarsuianexoa';
        nuError         NUMBER;
        sbError         VARCHAR2(4000); 
            
        nupano       ge_boInstanceControl.stysbValue;
        nupmes       ge_boInstanceControl.stysbValue;
        sbdirectory  ge_boInstanceControl.stysbValue;
        sbcorreo     ge_boInstanceControl.stysbValue;
        sbregenera   ge_boInstanceControl.stysbValue;
        cnuNULL_ATTRIBUTE constant number := 2126;
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO); 
            
        nupano      := ge_boInstanceControl.fsbGetFieldValue ('MO_PACKAGES', 'INSISTENTLY_COUNTER');
        nupmes      := ge_boInstanceControl.fsbGetFieldValue ('MO_PACKAGES', 'NUMBER_OF_PROD');
        sbdirectory := ge_boInstanceControl.fsbGetFieldValue ('GE_DIRECTORY', 'PATH');
        sbcorreo    := ge_boInstanceControl.fsbGetFieldValue ('GE_SUBSCRIBER', 'E_MAIL');
        sbregenera  := ge_boInstanceControl.fsbGetFieldValue ('GE_SUBSCRIBER', 'ACTIVE');

        ------------------------------------------------
            -- Required Attributes
        ------------------------------------------------

        -- Validamos a?o
        if (nupano is null) then
            pkg_error.setErrorMessage (cnuNULL_ATTRIBUTE, 'ano');
        end if;
        -- Validamos mes
        if (nupmes is null) then
            pkg_error.setErrorMessage (cnuNULL_ATTRIBUTE, 'mes');
        end if;
        -- Validamos ruta
        if (sbdirectory is null) then
            pkg_error.setErrorMessage (cnuNULL_ATTRIBUTE, 'ruta');
        end if;
        -- Validamos mes
        if (sbcorreo is null) then
            pkg_error.setErrorMessage (cnuNULL_ATTRIBUTE, 'correo');
        end if;
        -- Validamos regenera
        if (sbregenera is null) then
            pkg_error.setErrorMessage (cnuNULL_ATTRIBUTE, 'Regenera');
        end if;
        
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
    END Processvarsuianexoa;
END LDC_PAQUETEANEXOA;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre LDC_PAQUETEANEXOA
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_PAQUETEANEXOA', 'ADM_PERSON'); 
END;
/
PROMPT
PROMPT OTORGA PERMISOS EXECUTE a REXEREPORTES sobre LDC_PAQUETEANEXOA
GRANT EXECUTE ON ADM_PERSON.LDC_PAQUETEANEXOA TO REXEREPORTES;
/

