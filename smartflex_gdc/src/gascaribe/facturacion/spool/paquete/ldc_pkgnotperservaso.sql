CREATE OR REPLACE PACKAGE ldc_pkgnotperservaso
IS
    /*****************************************************************************************************
      Autor       : John Jairo Jimenez Marimon
      Fecha       : 2021-11-23
      Caso        : CA-805
      Descripcion : CA-805 - Paquete para los procesos de Dispapeles

      06-Sep-2023     felipe.valencia   OSF-1388 Se modifica para cambiar el api os_legalizeorders
                                            a api_legalizeorders
      06-Mar-2024     lubin.pineda      OSF-2377: Se cambia manejo de archivos a
                                        pkg_gestionArchivos
      14-Mar-2024     lubin.pineda      OSF-2377: Ajustes Validación Técnica
      20-Mar-2024     lubin.pineda      OSF-2377: Se usa pkg_BCLD_Parameter.fsbObtieneValorCadena
	  21-may-2024	  jsoto				OSF-2377: Se reemplaza uso de ldc_email poro pkg_correo
    ******************************************************************************************************/
    CURSOR cuordenesasig (nmcuestadoot NUMBER)
    IS
          SELECT d.departamento,
                 d.localidad,
                 d.contrato,
                 d.nombres,
                 d.direccion,
                 o.order_id,
                 o.task_type_id,
                 a.order_activity_id,
                 d.tipo_notifi,
                 a.product_id,
                 d.plaz_max,
                 d.codigo_barras
            FROM ldc_detarchrepdisp d, or_order o, or_order_activity a
           WHERE     o.order_status_id = nmcuestadoot
                 AND d.nro_orden = o.order_id
                 AND o.order_id = a.order_id
        ORDER BY d.departamento, d.localidad, direccion;

    PROCEDURE proinsertdetarchrepdisp (isbpadepart       VARCHAR2,
                                       isbpalocali       VARCHAR2,
                                       inupacontr        NUMBER,
                                       isbpoanomb        VARCHAR2,
                                       isbpadirecc       VARCHAR2,
                                       inupatipnot       NUMBER,
                                       isbpafecha        VARCHAR2,
                                       inupaorden        NUMBER,
                                       isbpaplmax        VARCHAR2,
                                       isbpacodbar       VARCHAR2,
                                       onupacoderr   OUT NUMBER,
                                       osbpacoderr     OUT VARCHAR2);

    PROCEDURE proactuadetarchrepdisp (inupaorden     NUMBER,
                                      nmpaestado    NUMBER,
                                      sbpamensaje   VARCHAR2);

    PROCEDURE procotasignanoti;

    PROCEDURE proregisotarcdisp (nmpacoderror   OUT NUMBER,
                                 sbpamensaje    OUT VARCHAR2);

    PROCEDURE procotasignanoreparto;
END ldc_pkgnotperservaso;
/

CREATE OR REPLACE PACKAGE BODY ldc_pkgnotperservaso
IS

    csbSP_NAME		CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT||'.';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
    
    PROCEDURE proinsertdetarchrepdisp (isbpadepart       VARCHAR2,
                                       isbpalocali       VARCHAR2,
                                       inupacontr        NUMBER,
                                       isbpoanomb        VARCHAR2,
                                       isbpadirecc       VARCHAR2,
                                       inupatipnot       NUMBER,
                                       isbpafecha        VARCHAR2,
                                       inupaorden        NUMBER,
                                       isbpaplmax        VARCHAR2,
                                       isbpacodbar       VARCHAR2,
                                       onupacoderr   OUT NUMBER,
                                       osbpacoderr     OUT VARCHAR2)
    IS
    /*********************************************************************************************************
      Empresa     : Horbath Tecnologies
      Autor       : John Jairo Jimenez Marimon
      Fecha       : 2021-11-28
      Descripcion : Inserta registro en la tabla : ldc_detarchrepdisp
      CASO        : CA-805

      Parametros Entrada

       isbpadepart VARCHAR2
       isbpalocali VARCHAR2
       inupacontr  NUMBER
       isbpoanomb  VARCHAR2
       isbpadirecc VARCHAR2
       inupatipnot NUMBER
       isbpafecha  VARCHAR2
       inupaorden  NUMBER
       isbpaplmax  VARCHAR2
       isbpacodbar VARCHAR2

      Valor de salida

      onupacoderr OUT NUMBER
      osbpacoderr   OUT VARCHAR2

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR   DESCRIPCION
    ******************************************************************************************************************************/
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'proinsertdetarchrepdisp';
        
    BEGIN
    
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
        
        onupacoderr := 0;
        osbpacoderr := NULL;

        INSERT INTO ldc_detarchrepdisp (departamento,
                                        localidad,
                                        contrato,
                                        nombres,
                                        direccion,
                                        tipo_notifi,
                                        fecha,
                                        nro_orden,
                                        plaz_max,
                                        codigo_barras,
                                        fecha_reg,
                                        estado,
                                        mensaje)
             VALUES (isbpadepart,
                     isbpalocali,
                     inupacontr,
                     isbpoanomb,
                     isbpadirecc,
                     inupatipnot,
                     isbpafecha,
                     inupaorden,
                     isbpaplmax,
                     isbpacodbar,
                     SYSDATE,
                     0,
                     NULL);
                     
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 
                             
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(onupacoderr,osbpacoderr);
            onupacoderr := -1;
            ROLLBACK;        
            pkg_traza.trace('osbpacoderr => ' || osbpacoderr, csbNivelTraza );
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(onupacoderr,osbpacoderr);
            onupacoderr := -1;
            ROLLBACK;
            pkg_traza.trace('osbpacoderr => ' || osbpacoderr, csbNivelTraza );
    END proinsertdetarchrepdisp;

    -------------------------------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE proactuadetarchrepdisp (inupaorden     NUMBER,
                                      nmpaestado    NUMBER,
                                      sbpamensaje   VARCHAR2)
    IS
    /*********************************************************************************************************
      Empresa     : Horbath Tecnologies
      Autor       : John Jairo Jimenez Marimon
      Fecha       : 2021-11-28
      Descripcion : Inserta registro en la tabla : ldc_detarchrepdisp
      CASO        : CA-805

      Parametros Entrada

       inupaorden   NUMBER
       nmpaestado  NUMBER
       sbpamensaje VARCHAR2

      Valor de salida

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR   DESCRIPCION
    ******************************************************************************************************************************/
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'proactuadetarchrepdisp';
        nuError         NUMBER;
        sbError         VARCHAR2(4000); 
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO); 
            
        UPDATE ldc_detarchrepdisp s
           SET s.estado = nmpaestado, s.mensaje = sbpamensaje
         WHERE s.nro_orden = inupaorden;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);          
    END proactuadetarchrepdisp;

    -------------------------------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE procotasignanoti
    IS
        /*********************************************************************************************************
          Empresa     : Horbath Tecnologies
          Autor       : John Jairo Jimenez Marimon
          Fecha       : 2021-11-23
          Descripcion : Proceso para generar archivo de impresi?n de DISPAPELES
          CASO        : CA-805

          Parametros Entrada

          Valor de salida

          HISTORIA DE MODIFICACIONES
          FECHA        AUTOR   DESCRIPCION
        ***********************************************************************************************************/
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'procotasignanoti';
        nuError         NUMBER;
        
        sbcadena       VARCHAR2 (5000);
        sb_archivo     pkg_gestionArchivos.styArchivo;
        nmcantidad     NUMBER (10);
        sbnomarchini   VARCHAR2 (1000);
        sbnomarchfin   VARCHAR2 (1000);
        sbfechejec     VARCHAR2 (50);
        dtfechaini     DATE;
        dtfechafin     DATE;
        sbnomdirec     VARCHAR2 (50);

        nmtotalreg     NUMBER (13) DEFAULT 0;
        nmtotaltot     NUMBER (13) DEFAULT 0;
        sbmensa        VARCHAR2 (500);
        nuflagejec     NUMBER (4);
        sbvatitulos    VARCHAR2 (3000);
        dtplazmax      DATE;
        sbplazmax      VARCHAR2 (30);
        sbvanoexists   VARCHAR2 (3);
        sbProceso      VARCHAR2 (70)
            :=    'LDC_PKGNOTPERSERVASO.PROCOTASIGNANOTI'
               || TO_CHAR (SYSDATE, 'DDMMYYYYHH24MISS');

        -- Cursor para obtener los departamentos de GDC
        CURSOR cu_departam IS
              SELECT d.geograp_location_id id_dpto, d.description desc_dpto
                FROM ge_geogra_location d
               WHERE d.geog_loca_area_type = 2
            ORDER BY d.geograp_location_id;

        -- Cursor para obtener detalle de las ordenes asignadas por deparatamento
        CURSOR cudatos (nmcu_dpto NUMBER, dtcufechini DATE, dtcufechfin DATE)
        IS
              SELECT l.geograp_location_id,
                     l.description
                         localidad,
                     d.address_parsed
                         direccion,
                     a.subscription_id
                         contrato,
                     a.product_id
                         producto,
                     (SELECT    cl.subscriber_name
                             || ' '
                             || cl.subs_second_last_name
                             || ' '
                             || cl.subs_last_name
                        FROM ge_subscriber cl
                       WHERE cl.subscriber_id = a.subscriber_id)
                         AS nombres,
                     activconf.notificacion
                         AS tipo_noti,
                     o.assigned_date
                         fecha,
                     o.order_id
                         nro_orden
                FROM or_order_activity a,
                     or_order          o,
                     ab_address        d,
                     ge_geogra_location l,
                     (SELECT TO_NUMBER (
                                 TRIM (
                                     SUBSTR (DatosParametro,
                                             1,
                                             INSTR (DatosParametro, ';') - 1)))
                                 notificacion,
                             TO_NUMBER (
                                 TRIM (
                                     SUBSTR (DatosParametro,
                                             INSTR (DatosParametro, ';') + 1)))
                                 actividad_g
                        FROM (    SELECT REGEXP_SUBSTR (
                                             pkg_BCLD_Parameter.fsbObtieneValorCadena (
                                                 'PARAM_NOTI_OT_IMPRESION'),
                                             '[^|]+',
                                             1,
                                             LEVEL)    AS DatosParametro
                                    FROM DUAL
                              CONNECT BY REGEXP_SUBSTR (
                                             pkg_BCLD_Parameter.fsbObtieneValorCadena (
                                                 'PARAM_NOTI_OT_IMPRESION'),
                                             '[^|]+',
                                             1,
                                             LEVEL)
                                             IS NOT NULL)     --DatosParametro
                                                         ) activconf
               WHERE     a.activity_id = activconf.actividad_g
                     AND o.order_status_id = 5
                     AND l.geo_loca_father_id = nmcu_dpto
                     AND o.assigned_date BETWEEN dtcufechini AND dtcufechfin
                     AND o.external_address_id = d.address_id
                     AND d.geograp_location_id = l.geograp_location_id
                     AND a.order_id = o.order_id
            ORDER BY l.geograp_location_id, direccion;
            

            CURSOR cuCantOrdenes(inuDepartamento NUMBER)
            IS
            SELECT COUNT (1)
              FROM or_order_activity   a,
                   or_order            o,
                   ab_address          d,
                   ge_geogra_location  l,
                   (SELECT TO_NUMBER (
                               TRIM (
                                   SUBSTR (DatosParametro,
                                           1,
                                           INSTR (DatosParametro, ';') - 1)))
                               notificacion,
                           TO_NUMBER (
                               TRIM (
                                   SUBSTR (DatosParametro,
                                           INSTR (DatosParametro, ';') + 1)))
                               actividad_g
                      FROM (    SELECT REGEXP_SUBSTR (
                                           pkg_BCLD_Parameter.fsbObtieneValorCadena (
                                               'PARAM_NOTI_OT_IMPRESION'),
                                           '[^|]+',
                                           1,
                                           LEVEL)    AS DatosParametro
                                  FROM DUAL
                            CONNECT BY REGEXP_SUBSTR (
                                           pkg_BCLD_Parameter.fsbObtieneValorCadena (
                                               'PARAM_NOTI_OT_IMPRESION'),
                                           '[^|]+',
                                           1,
                                           LEVEL)
                                           IS NOT NULL)       --DatosParametro
                                                       ) activconf
             WHERE     a.activity_id = activconf.actividad_g
                   AND o.order_status_id = 5
                   AND l.geo_loca_father_id = inuDepartamento
                   AND o.assigned_date BETWEEN dtfechaini AND dtfechafin
                   AND o.external_address_id = d.address_id
                   AND d.geograp_location_id = l.geograp_location_id
                   AND a.order_id = o.order_id;
                   
            CURSOR cuPlazoMaximo(inuProducto NUMBER)
            IS   
            SELECT MAX (plazo_maximo)
            FROM ldc_plazos_cert
            WHERE id_producto = inuProducto;                   
                               
    BEGIN
    
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO); 
            
        nuerror := -1;

        -- Consultamos estado del proceso
        nuflagejec := pkg_BCLD_Parameter.fnuObtieneValorNumerico('FLAG_EJEC_GEN_ARCH_IMP');

        pkg_traza.trace('nuflagejec|' || nuflagejec, csbNivelTraza); 
        
        -- Validamos que el proceso, no se ejecute mas de una vez al tiempo
        IF nuflagejec = 0
        THEN
            UPDATE ld_parameter x
               SET x.numeric_value = 1
             WHERE x.parameter_id = 'FLAG_EJEC_GEN_ARCH_IMP';

            COMMIT;
        ELSE
            RETURN;
        END IF;

        -- Se inicia log del programa
        nuerror := -2;

        pkg_estaproc.prInsertaEstaproc (sbProceso, NULL);

        -- Obtenemos fecha para obtener las ordenes a generar archivos de impresion
        nuerror := -3;
        sbfechejec :=
            pkg_BCLD_Parameter.fsbObtieneValorCadena ('PARAM_FECHA_EJEC_ARCH_OT_IMP');

        pkg_traza.trace('sbfechejec|' || sbfechejec, csbNivelTraza); 
       
        sbfechejec := TRIM (sbfechejec);
        nuerror := -4;
        /*
          Obtenemos el directorio(Ruta en el servidor) donde van a quedar los archivos de
          impresion de dispapeles
        */
        nuerror := -5;
        sbnomdirec :=
            pkg_BCLD_Parameter.fsbObtieneValorCadena ('PARAM_RUTA_ARCH_DEP_GEN');
        sbnomdirec := TRIM (sbnomdirec);

        pkg_traza.trace('sbnomdirec|' || sbnomdirec, csbNivelTraza); 
        /*
          Validamos si la fecha en el parametro PARAM_FECHA_EJEC_ARCH_OT_IMP es null para entonces
          tomar lo asignado en el dia anterior, de lo contrario tomamos la fecha configurada en el
          parametro
        */
        nuerror := -6;

        IF sbfechejec IS NULL
        THEN
            dtfechaini :=
                TO_DATE (TO_CHAR (SYSDATE - 1, 'DD/MM/YYYY') || ' 00:00:00',
                         'DD/MM/YYYY HH24:MI:SS');
            dtfechafin :=
                TO_DATE (TO_CHAR (SYSDATE - 1, 'DD/MM/YYYY') || ' 23:59:59',
                         'DD/MM/YYYY HH24:MI:SS');
        ELSE
            dtfechaini :=
                TO_DATE (sbfechejec || ' 00:00:00', 'DD/MM/YYYY HH24:MI:SS');
            dtfechafin :=
                TO_DATE (sbfechejec || ' 23:59:59', 'DD/MM/YYYY HH24:MI:SS');
        END IF;

        pkg_traza.trace('dtfechaini|' || dtfechaini, csbNivelTraza); 
        pkg_traza.trace('dtfechafin|' || dtfechafin, csbNivelTraza); 
        
        
        pkg_traza.trace('sbnomdirec|' || sbnomdirec, csbNivelTraza );
        
        -- Recorremos los departamentos
        nuerror := -7;
        nmtotaltot := 0;

        FOR i IN cu_departam
        LOOP
            -- Consultamos la cantidad de ordenes en el deparatmento
            nuerror := -8;

            pkg_traza.trace('id_dpto|' || i.id_dpto, csbNivelTraza);
        
            OPEN cuCantOrdenes(i.id_dpto);
            FETCH cuCantOrdenes INTO nmcantidad;
            CLOSE cuCantOrdenes;
    
            -- Validamos si hay ordenes en el departamento para generar archivo
            nuerror := -9;

            pkg_traza.trace('nmcantidad|' || nmcantidad, csbNivelTraza);
            
            IF nmcantidad >= 1
            THEN
                sbnomarchini :=
                       i.desc_dpto
                    || '_'
                    || TO_CHAR (SYSDATE, 'YYYY')
                    || TO_CHAR (SYSDATE, 'MM')
                    || TO_CHAR (SYSDATE, 'DD')
                    || '.txt';
                sbnomarchini := TRIM (sbnomarchini);
                sbnomarchfin := 'DISPAPELES_' || sbnomarchini;
                sbnomarchfin := TRIM (sbnomarchfin);

                -- Abrimos archivo en modo lectura para validar que no exista
                BEGIN
                    sb_archivo :=
                        pkg_gestionArchivos.ftAbrirArchivo_SMF (sbnomdirec, sbnomarchfin, 'r');
                    sbvanoexists := 'S';
                EXCEPTION
                    WHEN OTHERS
                    THEN
                        sbvanoexists := 'N';
                END;

                -- Validamos si el archivo existe
                IF sbvanoexists = 'N'
                THEN
                    --Abrimos el archivo para escribir
                    sb_archivo :=
                        pkg_gestionArchivos.ftAbrirArchivo_SMF (sbnomdirec, sbnomarchini, 'w');
                    -- Generamos archivo de ordenes de impresion
                    nuerror := -10;
                    sbvatitulos :=
                        'DEPARTAMENTO|LOCALIDAD|CONTRATO|NOMBRES|DIRECCION|TIPO_NOTI|FECHA|NRO_ORDEN|PLAZO_MAXIMO';
                    pkg_gestionArchivos.prcEscribirLinea_SMF (sb_archivo, sbvatitulos);
                    nmtotalreg := 0;

                    FOR j IN cudatos (i.id_dpto, dtfechaini, dtfechafin)
                    LOOP
                        nuerror := -11;
                        dtplazmax := NULL;
                        sbplazmax := NULL;

                        BEGIN
                            OPEN cuPlazoMaximo( j.producto);
                            FETCH cuPlazoMaximo INTO dtplazmax;
                            CLOSE cuPlazoMaximo;                            
                        EXCEPTION
                            WHEN OTHERS
                            THEN
                                dtplazmax := NULL;
                        END;

                        -- Validamos que el plazo maximo sea diferente de null
                        IF dtplazmax IS NOT NULL
                        THEN
                            sbplazmax :=    TO_CHAR (dtplazmax, 'DD')
                                   || '/'
                                   ||   CASE (TO_CHAR (dtplazmax, 'MON'))
                                            WHEN 'JAN' THEN 'ENE'
                                            WHEN 'APR' THEN 'ABR'
                                            WHEN 'AUG' THEN 'AGO'
                                            WHEN 'DEC' THEN 'DIC'
                                            ELSE TO_CHAR (dtplazmax, 'MON')
                                        END
                                   || '/'
                                   || TO_CHAR (dtplazmax, 'YYYY');

                            sbplazmax := TRIM (sbplazmax);
                        ELSE
                            sbplazmax := NULL;
                        END IF;

                        sbcadena :=
                               i.desc_dpto
                            || '|'
                            || j.localidad
                            || '|'
                            || j.contrato
                            || '|'
                            || j.nombres
                            || '|'
                            || j.direccion
                            || '|'
                            || j.tipo_noti
                            || '|'
                            || TO_CHAR (j.fecha, 'ddmmyyyy')
                            || '|'
                            || j.nro_orden
                            || '|'
                            || sbplazmax;
                        sbcadena := TRIM (sbcadena);
                        pkg_gestionArchivos.prcEscribirLinea_SMF (sb_archivo, sbcadena);
                        nmtotalreg := nmtotalreg + 1;
                    END LOOP;

                    -- Total registros
                    pkg_gestionArchivos.prcEscribirLinea_SMF (
                        sb_archivo,
                        'TOTAL REGISTROS | ' || TO_CHAR (nmtotalreg));
                    nuerror := -12;
                    -- Cerramos archivo
                    pkg_gestionArchivos.prcCerrarArchivo_SMF (sb_archivo, NULL, NULL);
                    nuerror := -13;
                    -- Renombramos archivo
                    pkg_gestionArchivos.prcRenombraArchivo_SMF (sbnomdirec,
                                      sbnomarchini,
                                      sbnomdirec,
                                      sbnomarchfin,
                                      FALSE);
                    nmtotaltot := nmtotaltot + nmtotalreg;
                ELSE
                    pkg_gestionArchivos.prcCerrarArchivo_SMF (sb_archivo, NULL, NULL);

                    IF sbmensa IS NULL
                    THEN
                        sbmensa :=
                               'Ya existe el archivo con nombre : '
                            || sbnomarchfin
                            || ' no es posible renombrar.';
                    ELSE
                        sbmensa :=
                               sbmensa
                            || ' '
                            || 'Ya existe el archivo con nombre : '
                            || sbnomarchfin
                            || ' no es posible renombrar.';
                    END IF;
                END IF;
            END IF;
        END LOOP;

        nuerror := -14;

        -- Activamos el flag de ejecuci?n
        UPDATE ld_parameter x
           SET x.numeric_value = 0
         WHERE x.parameter_id = 'FLAG_EJEC_GEN_ARCH_IMP';

        COMMIT;

        IF sbmensa IS NULL
        THEN
            sbmensa :=
                'Se procesar?n : ' || TO_CHAR (nmtotaltot) || ' registros.';
        ELSE
            sbmensa :=
                   sbmensa
                || ' '
                || 'Se procesar?n : '
                || TO_CHAR (nmtotaltot)
                || ' registros.';
        END IF;

        pkg_estaproc.prActualizaEstaproc (sbProceso, ' Ok', sbmensa);
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 
                
    EXCEPTION
        WHEN OTHERS
        THEN
            -- Activamos el flag de ejecuci?n
            UPDATE ld_parameter x
               SET x.numeric_value = 0
             WHERE x.parameter_id = 'FLAG_EJEC_GEN_ARCH_IMP';

            COMMIT;
            sbmensa :=
                SQLERRM || ' linea : ' || nuerror || ' cadena : ' || sbcadena;
            pkg_estaproc.prActualizaEstaproc (sbProceso,
                                              'con errores.',
                                              sbmensa);
            ROLLBACK;
    END procotasignanoti;

    ----------------------------------------------------------------------------------------------------------------------
    PROCEDURE proregisotarcdisp (nmpacoderror   OUT NUMBER,
                                 sbpamensaje    OUT VARCHAR2)
    IS
        /*********************************************************************************************************
           Empresa     : Horbath Tecnologies
           Autor       : John Jairo Jimenez Marimon
           Fecha       : 2021-11-24
           Descripcion : Proceso para descargar los archivos que envia dispapeles
                         e insertarlos en la tabla : LDC_DETARCHREPDISP.
           CASO        : CA-805

           Parametros Entrada

           Valor de salida

           HISTORIA DE MODIFICACIONES
           FECHA        AUTOR   DESCRIPCION
        ******************************************************************************************************************************/
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'proregisotarcdisp';
        nuError         NUMBER;
        sbError         VARCHAR2(4000); 
        
        sb_archivo     pkg_gestionArchivos.styArchivo;
        sbnomarchini   VARCHAR2 (1000);
        sbnomarchfin   VARCHAR2 (1000);
        sbnomdirec     VARCHAR2 (1000);
        sbcadena       VARCHAR2 (3000);
        nmcantsep      NUMBER (2);
        nmpossep       NUMBER (2);
        sbdepartam     ldc_detarchrepdisp.departamento%TYPE;
        sblocalida     ldc_detarchrepdisp.localidad%TYPE;
        nmcontrato     ldc_detarchrepdisp.contrato%TYPE;
        sbnombres      ldc_detarchrepdisp.nombres%TYPE;
        sbdireccion    ldc_detarchrepdisp.direccion%TYPE;
        nmtiponoti     ldc_detarchrepdisp.tipo_notifi%TYPE;
        sbfecha        ldc_detarchrepdisp.fecha%TYPE;
        nmnro_orden    ldc_detarchrepdisp.nro_orden%TYPE;
        sbpaplaz_max   ldc_detarchrepdisp.plaz_max%TYPE;
        sbcodbarras    ldc_detarchrepdisp.codigo_barras%TYPE;
        nmcantreg      NUMBER (13);
        nmtotalreg     NUMBER (13);
        sbmensa        VARCHAR2 (500);
        nucoderr       NUMBER;
        sbmensaerr     VARCHAR2 (1000);
        sbhayarchivo   VARCHAR2 (2) DEFAULT 'N';
        sbhayrenombr   VARCHAR2 (2) DEFAULT 'N';
        nminicrecorr   NUMBER (13) DEFAULT 0;

        -- Obtenemos los nombres de los archivos que debe enviar Dispapeles
        CURSOR cuarchivos IS
            SELECT TRIM (l.value_chain)     nombre_archivo
              FROM ld_parameter l
             WHERE l.parameter_id IN
                       ('PARAM_NOMBRE_ARCH_ATLANTICO',
                        'PARAM_NOMBRE_ARCH_CESAR',
                        'PARAM_NOMBRE_ARCH_MAGDALENA');
    BEGIN
    
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO); 
            
        nuerror := -1;
        nmpacoderror := 0;
        sbpamensaje := NULL;
        -- Inicio del proceso
        nuerror := -2;
        -- Obtenemos el directorio donde esta la ruta en la cual Dispapeles coloca los archivos
        sbnomdirec :=
            pkg_BCLD_Parameter.fsbObtieneValorCadena ('PARAM_RUTA_ARCH_DISP_GEN');
        nuerror := -3;
        nmcantsep := 9;
        nmcantreg := 0;
        nmtotalreg := 0;
        nuerror := -4;
        -- Recorremos los nombres de los archivos
        nuerror := -5;

        pkg_traza.trace('sbnomdirec|' || sbnomdirec, csbNivelTraza );

        FOR i IN cuarchivos
        LOOP
            nminicrecorr := 0;
            sbnomarchini := i.nombre_archivo || '.txt';
            sbnomarchini := TRIM (sbnomarchini);

            pkg_traza.trace('sbnomarchini|' || sbnomarchini, csbNivelTraza );

            -- Validamos si existe archivo antes de renombrar
            BEGIN
                sb_archivo := pkg_gestionArchivos.ftAbrirArchivo_SMF (sbnomdirec, sbnomarchini, 'r');
                sbhayarchivo := 'S';
            EXCEPTION
                WHEN OTHERS
                THEN
                    sbhayarchivo := 'N';
            END;

            -- Si hay archivo
            IF sbhayarchivo = 'S'
            THEN
                pkg_gestionArchivos.prcCerrarArchivo_SMF (sb_archivo, NULL, NULL);
                sbnomarchfin := 'INIT_' || sbnomarchini;
                sbnomarchfin := TRIM (sbnomarchfin);
                
                pkg_traza.trace('sbnomarchfin|' || sbnomarchfin, csbNivelTraza );

                -- Validamos si se puede renombrar archivo
                BEGIN
                    sb_archivo :=
                        pkg_gestionArchivos.ftAbrirArchivo_SMF (sbnomdirec, sbnomarchfin, 'r');
                    sbhayrenombr := 'N';
                EXCEPTION
                    WHEN OTHERS
                    THEN
                        sbhayrenombr := 'S';
                END;

                -- Abrimos el archivo
                nuerror := -6;

                IF sbhayrenombr = 'S'
                THEN
                    pkg_gestionArchivos.prcRenombraArchivo_SMF (sbnomdirec,
                                      sbnomarchini,
                                      sbnomdirec,
                                      sbnomarchfin,
                                      FALSE);
                    -- Abrimos archivo
                    sb_archivo :=
                        pkg_gestionArchivos.ftAbrirArchivo_SMF (sbnomdirec, sbnomarchfin, 'r');

                    -- Recorremos el archivo
                    LOOP
                        BEGIN
                            -- Obtenemos cada una de las lineas del archivo
                            nuerror := -7;
                            sbcadena := pkg_gestionArchivos.fsbObtenerLinea_SMF (sb_archivo );
                            sbcadena := TRIM (sbcadena);
                            -- Descomponemos la linea para obtener los valores de los campos
                            nuerror := -8;
                            nminicrecorr := nminicrecorr + 1;

                            IF nminicrecorr >= 2
                            THEN
                                IF SUBSTR (UPPER (sbcadena), 1, 5) <> 'TOTAL'
                                THEN
                                    FOR i IN 1 .. nmcantsep
                                    LOOP
                                        nuerror := -9;

                                        nmpossep := INSTR (sbcadena, '|');
 
                                        IF i = 1
                                        THEN
                                            nuerror := -10;
                                            sbdepartam :=
                                                TRIM (
                                                    SUBSTR (sbcadena,
                                                            1,
                                                            nmpossep - 1));
                                        ELSIF i = 2
                                        THEN
                                            nuerror := -11;
                                            sblocalida :=
                                                TRIM (
                                                    SUBSTR (sbcadena,
                                                            1,
                                                            nmpossep - 1));
                                        ELSIF i = 3
                                        THEN
                                            nuerror := -12;
                                            nmcontrato :=
                                                TO_NUMBER (
                                                    TRIM (
                                                        SUBSTR (sbcadena,
                                                                1,
                                                                nmpossep - 1)));
                                        ELSIF i = 4
                                        THEN
                                            nuerror := -13;
                                            sbnombres :=
                                                TRIM (
                                                    SUBSTR (sbcadena,
                                                            1,
                                                            nmpossep - 1));
                                        ELSIF i = 5
                                        THEN
                                            nuerror := -14;
                                            sbdireccion :=
                                                TRIM (
                                                    SUBSTR (sbcadena,
                                                            1,
                                                            nmpossep - 1));
                                        ELSIF i = 6
                                        THEN
                                            nuerror := -15;
                                            nmtiponoti :=
                                                TO_NUMBER (
                                                    TRIM (
                                                        SUBSTR (sbcadena,
                                                                1,
                                                                nmpossep - 1)));
                                        ELSIF i = 7
                                        THEN
                                            nuerror := -16;
                                            sbfecha :=
                                                TRIM (
                                                    SUBSTR (sbcadena,
                                                            1,
                                                            nmpossep - 1));
                                        ELSIF i = 8
                                        THEN
                                            nuerror := -17;
                                            nmnro_orden :=
                                                TO_NUMBER (
                                                    TRIM (
                                                        SUBSTR (sbcadena,
                                                                1,
                                                                nmpossep - 1)));
                                        ELSE
                                            nuerror := -18;
                                            sbpaplaz_max :=
                                                TRIM (
                                                    SUBSTR (sbcadena,
                                                            1,
                                                            nmpossep - 1));
                                            sbcodbarras :=
                                                SUBSTR (sbcadena,
                                                        nmpossep + 1);
                                        END IF;

                                        nuerror := -19;
                                        sbcadena :=
                                            SUBSTR (sbcadena, nmpossep + 1);
                                    END LOOP;

                                    -- Insertamos registro
                                    nuerror := -20;
                                    proinsertdetarchrepdisp (sbdepartam,
                                                             sblocalida,
                                                             nmcontrato,
                                                             sbnombres,
                                                             sbdireccion,
                                                             nmtiponoti,
                                                             sbfecha,
                                                             nmnro_orden,
                                                             sbpaplaz_max,
                                                             sbcodbarras,
                                                             nucoderr,
                                                             sbmensaerr);
                                    nuerror := -21;
                                    nmcantreg := nmcantreg + 1;

                                    IF nmcantreg >= 100
                                    THEN
                                        COMMIT;
                                        nmtotalreg := nmtotalreg + nmcantreg;
                                        nmcantreg := 0;
                                    END IF;
                                END IF;
                            END IF;
                        EXCEPTION
                            WHEN NO_DATA_FOUND
                            THEN
                                EXIT;
                        END;
                    END LOOP;

                    COMMIT;
                    nuerror := -22;
                    nmtotalreg := nmtotalreg + nmcantreg;
                    nmcantreg := 0;
                    -- Cerramos el archivo
                    nuerror := -23;
                    pkg_gestionArchivos.prcCerrarArchivo_SMF (sb_archivo, NULL, NULL);
                ELSE
                    pkg_gestionArchivos.prcCerrarArchivo_SMF (sb_archivo, NULL, NULL);

                    IF sbpamensaje IS NULL
                    THEN
                        sbpamensaje :=
                               'Ya existe el archivo : '
                            || sbnomarchfin
                            || ' no es posible renombrar.';
                    ELSE
                        sbpamensaje :=
                               sbpamensaje
                            || ' '
                            || 'Ya existe el archivo : '
                            || sbnomarchfin
                            || ' no es posible renombrar.';
                    END IF;
                END IF;
            ELSE
                IF sbpamensaje IS NULL
                THEN
                    sbpamensaje :=
                        'No existe el archivo : ' || sbnomarchini || '.';
                ELSE
                    sbpamensaje :=
                           sbpamensaje
                        || ' '
                        || 'No existe el archivo : '
                        || sbnomarchini
                        || '.';
                END IF;
            END IF;
        END LOOP;

        nuerror := -24;
        nmpacoderror := 0;

        IF sbpamensaje IS NULL
        THEN
            sbpamensaje :=
                   'PROREGISOTARCDISP : Se procesar?n : '
                || NVL (nmtotalreg, 0)
                || ' registros.';
        ELSE
            sbpamensaje :=
                   sbpamensaje
                || ' '
                || 'PROREGISOTARCDISP : Se procesar?n : '
                || NVL (nmtotalreg, 0)
                || ' registros.';
        END IF;
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 
                
    EXCEPTION
        WHEN OTHERS
        THEN
            pkg_gestionArchivos.prcCerrarArchivo_SMF (sb_archivo, NULL, NULL);
            nuerror := -25;
            sbmensa :=
                SQLERRM || ' linea : ' || nuerror || ' cadena : ' || sbcadena;
            ROLLBACK;
            nmpacoderror := -1;
            sbpamensaje := sbmensa;
    END proregisotarcdisp;

    -------------------------------------------------------------------------------------------------------------------------
    PROCEDURE procotasignanoreparto
    IS
        /*********************************************************************************************************
          Empresa     : Horbath Tecnologies
          Autor       : John Jairo Jimenez Marimon
          Fecha       : 2021-11-23
          Descripcion : Proceso para generar archivo CSV de ordenes generadas
          CASO        : CA-805

          Parametros Entrada

          Valor de salida

          HISTORIA DE MODIFICACIONES
          FECHA        AUTOR   DESCRIPCION
        ***********************************************************************************************************/
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'procotasignanoreparto';

        
        nmvacoderr       NUMBER;
        sbvamensajeerr   VARCHAR2 (2000);

        nuflagejec       VARCHAR2 (2);
        nmvacontaproc    NUMBER (10);
        sbmensajetot     VARCHAR2 (30000);
        sbProceso        VARCHAR2 (70)
            :=    'LDC_PKGNOTPERSERVASO.PROCOTASIGNANOREPARTO'
               || TO_CHAR (SYSDATE, 'DDMMYYYYHH24MISS');

        -- Procedimiento de legalizacion de ordenes de los archivos de DISPAPELES
        PROCEDURE prclegaotsdispapeles (nmpacoderror   OUT NUMBER,
                                        sbpamensaje    OUT VARCHAR2)
        IS
            csbMetodo1        CONSTANT VARCHAR2(105) := csbMetodo || '.prclegaotsdispapeles';
                
            rg_ldc_conftitrlega   ldc_conftitrlega%ROWTYPE;
            sbErrorMessage        ldc_detarchrepdisp.mensaje%TYPE;
            sbErrorOrdenes        ldc_detarchrepdisp.mensaje%TYPE;
            nuCodError            NUMBER;
            nmestado              NUMBER (2);
            sbCadenalega          VARCHAR2 (4000);
            nmtipo_causal         ge_causal.causal_type_id%TYPE;
            nmestadoasig          ld_parameter.numeric_value%TYPE;
            
            CURSOR culdc_conftitrlega( inuTipoTrabajo NUMBER)
            IS
            SELECT *
            FROM ldc_conftitrlega l
            WHERE l.task_type_id = inuTipoTrabajo 
            AND ROWNUM = 1;
                                 
        BEGIN

            pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbINICIO); 
                
            -- Obtenemos estado asignado de la orden de trabajo
            nmestadoasig :=
                pkg_BCLD_Parameter.fnuObtieneValorNumerico ('ESTADO_ASIGNADO');

            -- Validamos si hay cpnfiguracion
            IF nmestadoasig IS NULL
            THEN
                nmpacoderror := -1;
                sbpamensaje :=
                    'Se debe configurar el parametro : ESTADO_ASIGNADO con el estado asignado de la orden';
                RETURN;
            END IF;

            -- Recorremos las ordenes de trabajo a legalizar
            nmvacontaproc := 0;

            FOR i IN cuordenesasig (nmestadoasig)
            LOOP
                sbErrorMessage := 'OK.';
                nuCodError := 0;
                nmestado := 1;
                sbErrorOrdenes := NULL;

                -- Consultamos causal y persona en la configuracio de la tabla ldc_conftitrlega
                rg_ldc_conftitrlega := NULL;
                
                OPEN culdc_conftitrlega(i.task_type_id);
                FETCH culdc_conftitrlega INTO rg_ldc_conftitrlega;
                CLOSE culdc_conftitrlega;
                     

                /* Validamos si existe configuracion en ldc_conftitrlega para el tipo de trabajo de la orden
                   que se est? legalizando*/
                IF     rg_ldc_conftitrlega.causal_id IS NOT NULL
                   AND rg_ldc_conftitrlega.person_id IS NOT NULL
                THEN
                    -- Consultamos el tipo de causal
                    nmtipo_causal := CASE pkg_BCOrdenes.fnuObtieneClaseCausal(rg_ldc_conftitrlega.causal_id) 
                                        WHEN 1 THEN
                                            1
                                        ELSE 
                                            0
                                        END;
                        

                    -- Construimos la cadena de legalizacion
                    sbCadenalega :=
                           i.order_id
                        || '|'
                        || rg_ldc_conftitrlega.causal_id
                        || '|'
                        || rg_ldc_conftitrlega.person_id
                        || '||'
                        || i.order_activity_id
                        || '>'
                        || nmtipo_causal
                        || ';;;;|||1277;Orden Legalizada por proceso : LDC_PKGNOTPERSERVASO.PROCOTASIGNANOREPARTO';
                    -- se procede a legalizar la orden de trabajo
                    api_legalizeorders (sbCadenalega,
                                        SYSDATE,
                                        SYSDATE,
                                        NULL,
                                        nuCodError,
                                        sbErrorMessage);

                    -- Validamos si la legalizaci?n fue exitosa o con error
                    IF nuCodError <> 0
                    THEN
                        sbErrorOrdenes :=
                            SUBSTR (
                                   sbErrorOrdenes
                                || ' Orden '
                                || i.order_id
                                || ' con error '
                                || sbErrorMessage,
                                0,
                                3999);
                        ROLLBACK;
                        nmestado := -1;
                    ELSE
                        sbErrorOrdenes := 'OK.';
                        nmestado := 1;
                    END IF;
                ELSE
                    sbErrorOrdenes :=
                           'ORDEN : '
                        || i.order_id
                        || ' no existe configuracion de causal y/o persona en la tabla : ldc_conftitrlega para el tipo de trabajo : '
                        || i.task_type_id;
                    nmestado := -1;
                END IF;

                -- Actualizamos en la tabla estado proceso de registro.
                proactuadetarchrepdisp (i.order_id, nmestado, sbErrorOrdenes);
                nmvacontaproc := NVL (nmvacontaproc, 0) + 1;
                COMMIT;
            END LOOP;

            nmpacoderror := 0;
            sbpamensaje :=
                   'PRCLEGAOTSDISPAPELES : Se procesar?n : '
                || TO_CHAR (nmvacontaproc)
                || ' registros.';
                
            pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbFIN); 
                            
        EXCEPTION
            WHEN OTHERS
            THEN
                ROLLBACK;
                nmpacoderror := -1;
                sbpamensaje := 'Error : ' || SQLCODE || ' - ' || SQLERRM;
        END prclegaotsdispapeles;

        -- Procedimiento de asignaci?n de ordenes de los archivos de DISPAPELES
        PROCEDURE prcasigotsrepdispapeles (nmpacoderror   OUT NUMBER,
                                           sbpamensaje    OUT VARCHAR2)
        IS
            csbMetodo2        CONSTANT VARCHAR2(105) := csbMetodo || '.prcasigotsrepdispapeles';
            
            sbErrorOrdenes       ldc_detarchrepdisp.mensaje%TYPE;
            nuCodError           NUMBER;
            nmestado             NUMBER (2);
            nmestadoleg          ld_parameter.numeric_value%TYPE;
            nuOperaUnitID        or_operating_unit.operating_unit_id%TYPE;
            nmvaot_reparto       or_order.order_id%TYPE;
            sbvafechagen         VARCHAR2 (30);
            sbvalinea            VARCHAR2 (5000);
            sb_archivo           pkg_gestionArchivos.styArchivo;
            sbnomdirec           VARCHAR2 (50);
            sbnomarchini         VARCHAR2 (1000);
            sbnomarchfin         VARCHAR2 (1000);
            sbhayerror           VARCHAR2 (2);
            sbvatitulos          VARCHAR2 (3000);
            nmvalarch            NUMBER (10);
            nmvatotalreg         NUMBER (10) DEFAULT 0;
            sbvahayarch          VARCHAR2 (2);
            rcor_order_comment   daor_order_comment.styor_order_comment;
            nmvapersonid         ge_person.person_id%TYPE;
            nmcontaerr           NUMBER (4);

            -- Cursor para validar si se genera archivo o no
            CURSOR cu_genera_arch (nmcuesleg NUMBER)
            IS
                SELECT COUNT (1)
                  FROM or_order_activity  a,
                       or_order           o,
                       (SELECT TO_NUMBER (
                                   TRIM (
                                       SUBSTR (
                                           DatosParametro,
                                           1,
                                           INSTR (DatosParametro, ';') - 1)))
                                   notificacion,
                               TO_NUMBER (
                                   TRIM (
                                       SUBSTR (
                                           DatosParametro,
                                           INSTR (DatosParametro, ';') + 1)))
                                   actividad_g
                          FROM (    SELECT REGEXP_SUBSTR (
                                               pkg_BCLD_Parameter.fsbObtieneValorCadena (
                                                   'PARAM_NOTI_OT_REPARTO'),
                                               '[^|]+',
                                               1,
                                               LEVEL)    AS DatosParametro
                                      FROM DUAL
                                CONNECT BY REGEXP_SUBSTR (
                                               pkg_BCLD_Parameter.fsbObtieneValorCadena (
                                                   'PARAM_NOTI_OT_REPARTO'),
                                               '[^|]+',
                                               1,
                                               LEVEL)
                                               IS NOT NULL)   --DatosParametro
                                                           ) activconf
                 WHERE     o.order_status_id IN (0, 5)
                       AND (activconf.notificacion, a.product_id) IN
                               (SELECT d.tipo_notifi, a.product_id
                                  FROM ldc_detarchrepdisp  d,
                                       or_order            o,
                                       or_order_activity   a
                                 WHERE     o.order_status_id = nmcuesleg
                                       AND d.nro_orden = o.order_id
                                       AND o.order_id = a.order_id)
                       AND a.activity_id = activconf.actividad_g
                       AND a.order_id = o.order_id;

            -- Cursor ordenes de reparto
            CURSOR cuasigotsrepa (nmcunoti NUMBER, nmcuproduc NUMBER)
            IS
                SELECT o.order_id, o.order_status_id, o.created_date
                  FROM or_order_activity  a,
                       or_order           o,
                       (SELECT TO_NUMBER (
                                   TRIM (
                                       SUBSTR (
                                           DatosParametro,
                                           1,
                                           INSTR (DatosParametro, ';') - 1)))
                                   notificacion,
                               TO_NUMBER (
                                   TRIM (
                                       SUBSTR (
                                           DatosParametro,
                                           INSTR (DatosParametro, ';') + 1)))
                                   actividad_g
                          FROM (    SELECT REGEXP_SUBSTR (
                                               pkg_BCLD_Parameter.fsbObtieneValorCadena (
                                                   'PARAM_NOTI_OT_REPARTO'),
                                               '[^|]+',
                                               1,
                                               LEVEL)    AS DatosParametro
                                      FROM DUAL
                                CONNECT BY REGEXP_SUBSTR (
                                               pkg_BCLD_Parameter.fsbObtieneValorCadena (
                                                   'PARAM_NOTI_OT_REPARTO'),
                                               '[^|]+',
                                               1,
                                               LEVEL)
                                               IS NOT NULL)   --DatosParametro
                                                           ) activconf
                 WHERE     o.order_status_id IN (0, 5)
                       AND activconf.notificacion = nmcunoti
                       AND a.product_id = nmcuproduc
                       AND a.activity_id = activconf.actividad_g
                       AND a.order_id = o.order_id;

            -- Cursor persona
            CURSOR cupersona IS
                SELECT ge_person.person_id
                  FROM sa_user, ge_person
                 WHERE mask = USER AND ge_person.user_id = sa_user.user_id;
                 
            CURSOR cuCantErrores IS
            SELECT COUNT (1)
            FROM ldc_detarchrepdisp er
            WHERE er.estado = -1;
                                              
        BEGIN

            pkg_traza.trace(csbMetodo2, csbNivelTraza, pkg_traza.csbINICIO); 
                    
            -- Obtenemos estado cerrado o legalizado de la orden de trabajo
            nmestadoleg :=
                pkg_BCLD_Parameter.fnuObtieneValorNumerico ('ESTADO_CERRADO');

            -- Validamos si hay configuracion estado orden cerrada
            IF nmestadoleg IS NULL
            THEN
                nmpacoderror := -1;
                sbpamensaje :=
                    'Se debe configurar el parametro : ESTADO_CERRADO con el estado CERRADO O LEGALIZADO de la orden de trabajo';
                RETURN;
            END IF;

            -- Obtenemos la unidad operativa para asignar las ordenes de reparto
            nuOperaUnitID :=
                pkg_BCLD_Parameter.fnuObtieneValorNumerico ('PARAM_UNITASIG_OTREP');

            -- Validamos si hay configuracion unidad operativa
            IF nuOperaUnitID IS NULL
            THEN
                nmpacoderror := -1;
                sbpamensaje :=
                    'Se debe configurar el parametro : PARAM_UNITASIG_OTREP con la unidad operativa para asignar orden de reparto.';
                RETURN;
            END IF;

            -- Validamos que la persona exista

            IF (cupersona%ISOPEN)
            THEN
                CLOSE cupersona;
            END IF;

            OPEN cupersona;

            FETCH cupersona INTO nmvapersonid;

            CLOSE cupersona;

            IF nmvapersonid IS NULL
            THEN
                nmpacoderror := -1;
                sbpamensaje :=
                    'No existe persona asociada al usuario : ' || USER;
                RETURN;
            END IF;

            -- Verificamos si generamos archivo
            nmvalarch := 0;

            IF (cu_genera_arch%ISOPEN)
            THEN
                CLOSE cu_genera_arch;
            END IF;

            OPEN cu_genera_arch (nmestadoleg);

            FETCH cu_genera_arch INTO nmvalarch;

            CLOSE cu_genera_arch;

            IF nmvalarch >= 1
            THEN
                -- Obtenemos la ruta donde se colocar? el archivo CSV de las ordenes de reparto
                sbnomdirec :=
                    pkg_BCLD_Parameter.fsbObtieneValorCadena ('PARAM_RUT_OTREP_ASIG');
                -- Armamos nombre inicial del archivo CSV
                sbnomarchini :=
                    'OTREPARTO_' || TO_CHAR (SYSDATE, 'DDMMYYYY') || '.CSV';
                -- Validamos si al final se puede renombrar el archivo
                sbnomarchfin := 'DISPAPELES_' || sbnomarchini;
                sbnomarchfin := TRIM (sbnomarchfin);
                sbvahayarch := 'N';

                BEGIN
                    sb_archivo :=
                        pkg_gestionArchivos.ftAbrirArchivo_SMF (sbnomdirec, sbnomarchfin, 'r');
                    sbvahayarch := 'S';
                EXCEPTION
                    WHEN OTHERS
                    THEN
                        sbvahayarch := 'N';
                END;

                -- Abrimos el archivo para escritura
                IF sbvahayarch = 'N'
                THEN
                    sb_archivo :=
                        pkg_gestionArchivos.ftAbrirArchivo_SMF (sbnomdirec, sbnomarchini, 'w');
                    -- Creamos titulos de los campos
                    sbvatitulos :=
                        'DEPARTAMENTO|LOCALIDAD|CONTRATO|NOMBRES|DIRECCION|TIPO_NOTI|FECHA|NRO_ORDEN|PLAZO_MAXIMO|COD_BARRAS';
                    pkg_gestionArchivos.prcEscribirLinea_SMF (sb_archivo, sbvatitulos);
                    -- Recorremos las ordenes de trabajo de dispapeles legalizadas
                    sbhayerror := 'N';

                    FOR i IN cuordenesasig (nmestadoleg)
                    LOOP
                        -- Recorremos las ordenes de reparto
                        FOR j IN cuasigotsrepa (i.tipo_notifi, i.product_id)
                        LOOP
                            nuCodError := 0;
                            sbErrorOrdenes := 'OK.';
                            nmestado := 1;
                            nmvaot_reparto := j.order_id;
                            sbvafechagen :=
                                TO_CHAR (j.created_date, 'ddmmyyyy');

                            -- Validamos si la orden de reparto est? generada
                            IF j.order_status_id = 0
                            THEN
                                -- Asignamos la orden de reparto

                                api_assign_order (nmvaot_reparto,
                                                  nuOperaUnitID,
                                                  nuCodError,
                                                  sbErrorOrdenes);

                                -- Validamos si hubo error en la asignacion
                                IF nuCodError = 0
                                THEN
                                    nmestado := 1;
                                    sbErrorOrdenes := 'OK.';
                                    -- Arma el registro del comment de la orden
                                    rcor_order_comment.order_comment_id :=
                                        seq_or_order_comment.NEXTVAL;
                                    rcor_order_comment.order_comment :=
                                        'COD_BARRAS : ' || i.codigo_barras;
                                    rcor_order_comment.order_id :=
                                        nmvaot_reparto;
                                    rcor_order_comment.comment_type_id :=
                                        1277;
                                    rcor_order_comment.register_date :=
                                        SYSDATE;
                                    rcor_order_comment.legalize_comment :=
                                        'N';
                                    rcor_order_comment.person_id :=
                                        nmvapersonid;
                                    daor_order_comment.insrecord (
                                        rcor_order_comment);
                                ELSE
                                    ROLLBACK;
                                    nmestado := -1;
                                    sbhayerror := 'S';
                                END IF;
                            END IF;

                            -- Actualizamos en la tabla estado proceso de registro.
                            proactuadetarchrepdisp (i.order_id,
                                                    nmestado,
                                                    sbErrorOrdenes);
                            COMMIT;

                            -- Validamos si existen errores                             
                            OPEN cuCantErrores;
                            FETCH cuCantErrores INTO nmcontaerr;
                            CLOSE cuCantErrores;

                            -- Registramos en el log las ordenes asignadas ok.
                            IF nuCodError = 0 AND nmvaot_reparto IS NOT NULL
                            THEN
                                sbvalinea :=
                                       i.departamento
                                    || '|'
                                    || i.localidad
                                    || '|'
                                    || i.contrato
                                    || '|'
                                    || i.nombres
                                    || '|'
                                    || i.direccion
                                    || '|'
                                    || i.tipo_notifi
                                    || '|'
                                    || sbvafechagen
                                    || '|'
                                    || nmvaot_reparto
                                    || '|'
                                    || i.plaz_max
                                    || '|'
                                    || i.codigo_barras;
                                sbvalinea := TRIM (sbvalinea);
                                pkg_gestionArchivos.prcEscribirLinea_SMF (sb_archivo, sbvalinea);
                                nmvatotalreg := NVL (nmvatotalreg, 0) + 1;
                            END IF;
                        END LOOP;
                    END LOOP;

                    -- Cerramos archivo csv
                    pkg_gestionArchivos.prcCerrarArchivo_SMF (sb_archivo, NULL, NULL);

                    -- Renombramos archivo
                    IF sbhayerror = 'N' AND nmcontaerr = 0
                    THEN
                        -- Actualizamos estados a los registros
                        UPDATE ldc_detarchrepdisp k
                           SET k.estado = 1
                         WHERE k.estado = 0;

                        -- Borramos los datos de la tabla
                        DELETE ldc_detarchrepdisp l
                         WHERE l.estado NOT IN (-1, 0);

                        COMMIT;
                        pkg_gestionArchivos.prcRenombraArchivo_SMF (sbnomdirec,
                                          sbnomarchini,
                                          sbnomdirec,
                                          sbnomarchfin,
                                          FALSE);
                    END IF;
                ELSE
                    pkg_gestionArchivos.prcCerrarArchivo_SMF (sb_archivo, NULL, NULL);

                    IF sbpamensaje IS NULL
                    THEN
                        sbpamensaje :=
                               'Ya existe el archivo : '
                            || sbnomarchfin
                            || ' no es posible renombrar.';
                    ELSE
                        sbpamensaje :=
                               sbpamensaje
                            || ' '
                            || 'Ya existe el archivo : '
                            || sbnomarchfin
                            || ' no es posible renombrar.';
                    END IF;
                END IF;
            END IF;

            nmpacoderror := 0;

            IF sbpamensaje IS NULL
            THEN
                sbpamensaje :=
                       'PRCASIGOTSREPDISPAPELES : Se procesar?n : '
                    || NVL (nmvatotalreg, 0)
                    || ' registros.';
            ELSE
                sbpamensaje :=
                       sbpamensaje
                    || ' '
                    || 'PRCASIGOTSREPDISPAPELES : Se procesar?n : '
                    || NVL (nmvatotalreg, 0)
                    || ' registros.';
            END IF;
            
            pkg_traza.trace(csbMetodo2, csbNivelTraza, pkg_traza.csbFIN); 
                        
        EXCEPTION
            WHEN OTHERS
            THEN
                ROLLBACK;
                pkg_gestionArchivos.prcCerrarArchivo_SMF (sb_archivo, NULL, NULL);
                nmpacoderror := -1;
                sbpamensaje := SQLCODE || ' - ' || SQLERRM;
        END prcasigotsrepdispapeles;

        -- Procedimiento para enviar correo con los errores presentados
        PROCEDURE prcprocesoenvcorrerr (nmpacoderror   OUT NUMBER,
                                        sbpamensaje    OUT VARCHAR2)
        IS
            csbMetodo3        CONSTANT VARCHAR2(105) := csbMetodo || '.prcprocesoenvcorrerr';
                  
            -- Consultamos los registros con ERROR
            CURSOR cudatoserr IS
                SELECT l.nro_orden, l.mensaje
                  FROM ldc_detarchrepdisp l
                 WHERE l.estado = -1;

            sbcadena_errores   VARCHAR2 (5000);
            sender             VARCHAR2 (1000);
            sbcorreos          VARCHAR2 (5000);
            nmvatotalreg       VARCHAR2 (10) DEFAULT 0;
        BEGIN

            pkg_traza.trace(csbMetodo3, csbNivelTraza, pkg_traza.csbINICIO); 
                    
            nmpacoderror := 0;
            sbpamensaje := 'OK.';
            -- Obtenemos el smtp
            sender :=
                pkg_BCLD_Parameter.fsbObtieneValorCadena ('LDC_SMTP_SENDER');

            -- Validamos que el parametro :LDC_SMTP_SENDER este configurado
            IF sender IS NULL
            THEN
                nmpacoderror := -1;
                sbpamensaje :=
                    'Se debe configurar el parametro : LDC_SMTP_SENDER con el smtp para el envio de correos.';
                RETURN;
            END IF;

            sbcorreos :=
                pkg_BCLD_Parameter.fsbObtieneValorCadena ('PARAM_CORREO_USU_VAL_ERR');

            -- Validamos que el parametro :PARAM_CORREO_USU_VAL_ERR  este configurado
            IF sbcorreos IS NULL
            THEN
                nmpacoderror := -1;
                sbpamensaje :=
                    'Se debe configurar el parametro : PARAM_CORREO_USU_VAL_ERR con los respectivos correos.';
                RETURN;
            END IF;

            sbcorreos := TRIM (sbcorreos);
            -- Construimos el asunto
            sbcadena_errores := NULL;
            nmvatotalreg := 0;

            FOR i IN cudatoserr
            LOOP
                IF sbcadena_errores IS NULL
                THEN
                    sbcadena_errores :=
                           ' Orden : '
                        || i.nro_orden
                        || ' Error : '
                        || i.mensaje;
                ELSE
                    sbcadena_errores :=
                           sbcadena_errores
                        || '|'
                        || ' Orden : '
                        || i.nro_orden
                        || ' Error : '
                        || i.mensaje;
                END IF;

                nmvatotalreg := 1;
            END LOOP;

            -- Enviamos correo con errores presentados
            IF sbcadena_errores IS NOT NULL
            THEN
			   pkg_Correo.prcEnviaCorreo
							(
								isbRemitente        => sender,
								isbDestinatarios    => sbcorreos,
								isbAsunto           => 'Ordenes con errores',
								isbMensaje          => sbcadena_errores

							);

            END IF;

            nmpacoderror := 0;
            sbpamensaje :=
                   'PRCPROCESOENVCORRERR : Se enviaron : '
                || nmvatotalreg
                || ' error(es)';
                
            pkg_traza.trace(csbMetodo3, csbNivelTraza, pkg_traza.csbFIN); 
                            
        EXCEPTION
            WHEN OTHERS
            THEN
                nmpacoderror := -1;
                sbpamensaje := 'Error : ' || SQLCODE || ' - ' || SQLERRM;
        END prcprocesoenvcorrerr;
    -- Programa principal
    BEGIN
    
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO); 
                
        -- Consultamos estado del proceso
        nuflagejec := pkg_BCLD_Parameter.fnuObtieneValorNumerico('FLAG_EJEC_GEN_ARCH_IMP');

        -- Validamos que el proceso, no se ejecute mas de una vez al tiempo
        IF nuflagejec = 0
        THEN
            UPDATE ld_parameter x
               SET x.numeric_value = 1
             WHERE x.parameter_id = 'FLAG_EJEC_GEN_ARCH_REP';

            COMMIT;
        ELSE
            RETURN;
        END IF;

        -- Se inicia log del programa
        pkg_estaproc.prInsertaEstaproc (sbProceso, NULL);
        
        -- Cargamos archivos de DISPAPELES
        proregisotarcdisp (nmvacoderr, sbvamensajeerr);

        IF nmvacoderr <> 0
        THEN
            pkg_estaproc.prActualizaEstaproc (
                sbProceso,
                ' Error',
                'Error en el proceso : proregisotarcdisp. ' || sbvamensajeerr);

            UPDATE ld_parameter x
               SET x.numeric_value = 0
             WHERE x.parameter_id = 'FLAG_EJEC_GEN_ARCH_REP';

            COMMIT;
            RETURN;
        ELSE
            IF sbmensajetot IS NULL
            THEN
                sbmensajetot := sbvamensajeerr;
            ELSE
                sbmensajetot := sbmensajetot || ' ' || sbvamensajeerr;
            END IF;
        END IF;

        -- Legalizaci?n de ordenes que envia DISPAPELES
        prclegaotsdispapeles (nmvacoderr, sbvamensajeerr);

        IF nmvacoderr <> 0
        THEN
            pkg_estaproc.prActualizaEstaproc (
                sbProceso,
                ' Error',
                   'Error en el proceso : prclegaotsdispapeles. '
                || sbvamensajeerr);

            UPDATE ld_parameter x
               SET x.numeric_value = 0
             WHERE x.parameter_id = 'FLAG_EJEC_GEN_ARCH_REP';

            COMMIT;
            RETURN;
        ELSE
            IF sbmensajetot IS NULL
            THEN
                sbmensajetot := sbvamensajeerr;
            ELSE
                sbmensajetot := sbmensajetot || ' ' || sbvamensajeerr;
            END IF;
        END IF;

        -- Asignamos ordenes de reparto y generamos archivo .csv
        prcasigotsrepdispapeles (nmvacoderr, sbvamensajeerr);

        IF nmvacoderr <> 0
        THEN
            pkg_estaproc.prActualizaEstaproc (
                sbProceso,
                ' Error',
                   'Error en el proceso : prcasigotsrepdispapeles. '
                || sbvamensajeerr);

            UPDATE ld_parameter x
               SET x.numeric_value = 0
             WHERE x.parameter_id = 'FLAG_EJEC_GEN_ARCH_REP';

            COMMIT;
            RETURN;
        ELSE
            IF sbmensajetot IS NULL
            THEN
                sbmensajetot := sbvamensajeerr;
            ELSE
                sbmensajetot := sbmensajetot || ' ' || sbvamensajeerr;
            END IF;
        END IF;

        -- Enviamos correo con lo registro con error
        prcprocesoenvcorrerr (nmvacoderr, sbvamensajeerr);

        IF nmvacoderr <> 0
        THEN
            pkg_estaproc.prActualizaEstaproc (
                sbProceso,
                ' Error',
                   ' Error en el proceso : prcprocesoenvcorrerr. '
                || sbvamensajeerr);

            UPDATE ld_parameter x
               SET x.numeric_value = 0
             WHERE x.parameter_id = 'FLAG_EJEC_GEN_ARCH_REP';

            COMMIT;
            RETURN;
        ELSE
            IF sbmensajetot IS NULL
            THEN
                sbmensajetot := sbvamensajeerr;
            ELSE
                sbmensajetot := sbmensajetot || ' ' || sbvamensajeerr;
            END IF;
        END IF;

        --- Proceso termino Ok.
        UPDATE ld_parameter x
           SET x.numeric_value = 0
         WHERE x.parameter_id = 'FLAG_EJEC_GEN_ARCH_REP';

        COMMIT;
        pkg_estaproc.prActualizaEstaproc (sbProceso, ' Ok', 'Finalizado');

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 
                
    EXCEPTION
        WHEN OTHERS
        THEN
            pkg_estaproc.prActualizaEstaproc (
                sbProceso,
                ' Error',
                   'Error en el proceso : procotasignanoreparto. '
                || SQLCODE
                || ' - '
                || SQLERRM);

            UPDATE ld_parameter x
               SET x.numeric_value = 0
             WHERE x.parameter_id = 'FLAG_EJEC_GEN_ARCH_REP';

            COMMIT;
    END procotasignanoreparto;
END ldc_pkgnotperservaso;
/

PROMPT Otorgando permisos de ejecución sobre LDC_PKGNOTPERSERVASO
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_PKGNOTPERSERVASO','OPEN');
END;
/

