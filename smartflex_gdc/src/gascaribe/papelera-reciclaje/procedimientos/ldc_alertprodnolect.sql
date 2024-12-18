CREATE OR REPLACE PROCEDURE ldc_AlertProdNoLect
IS
    /*****************************************************************
     Propiedad intelectual de PETI (c).

     Unidad         : ldc_AlertProdNoLect
     Descripcion    : Procedimiento donde se implementa la logica para enviar notificaciones de los productos
                     facturables que no salen a lectura porque no existe periodo de consumo ativo
     Autor          : Sayra Ocoro (socoro@horbath.com)
     Fecha          : 17/05/2016

     Parametros              Descripcion
     ============         ===================

     Fecha             Autor               Modificacion
     =========         =========           ====================
     19/06/2024        jpinedc             OSF-2605: Se usa pkg_Correo
                                           * Ajustes por estándares
     ******************************************************************/

    csbMetodo        CONSTANT VARCHAR2(70) := 'ldc_AlertProdNoLect';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
    nuError         NUMBER;
    sbError         VARCHAR2(4000);

    sbRecipients    ld_parameter.value_chain%TYPE;

    nuCodGas        NUMERIC;
    sbSubject       VARCHAR2 (200);
    sbMessage0      VARCHAR2 (3000);
    sbMessage1      VARCHAR2 (3000);
    actualDate      DATE := UT_DATE.FSBSTR_SYSDATE ();
    sbRuta          ld_parameter.value_chain%TYPE;

    --Cursor que obtiene los productos facturables que no saldrÃ¡n a lectura
    CURSOR cuAlert IS
          SELECT SESUNUSE,
                 TRUNC (SESUFEIN)
                     FECHAINST,
                    SESUESCO
                 || ' - '
                 || pktblestacort.fsbgetdescription (SESUESCO, NULL)
                     ESTCORT,
                    PR.SESUCICL
                 || ' - '
                 || PKTBLCICLO.FSBGETDESCRIPTION (PR.SESUCICL, NULL)
                     CICLOFAC,
                    SESUCICO
                 || ' - '
                 || PKTBLCICLCONS.FSBGETDESCRIPTION (SESUCICO, NULL)
                     CICLOCONS
            FROM ESTACORT                                    --ESTADO DE CORTE
                 JOIN CONFESCO ON COECCODI = ESCOCODI --ESTADO DE CORTE POR SERVICIO
                 JOIN SERVSUSC PR ON ESCOCODI = SESUESCO   --SERVICIO SUSCRITO
                 JOIN CICLO CF ON CICLCODI = SESUCICL   --CICLO DE FACTURACION
           WHERE     COECSERV = 7014                        --TIPO DE SERVICIO
                 AND coecfact = 'S'
                 AND COECSERV = SESUSERV                    --TIPO DE SERVICIO
                 AND CICLCICO = SESUCICO
                 AND NOT EXISTS
                         (SELECT 1
                            FROM PERICOSE, PERIFACT PF
                           WHERE     PEFACICL = CF.CICLCODI
                                 AND PECSCICO = PR.SESUCICO
                                 AND PECSFECF > PR.SESUFEIN
                                 AND PEFAACTU = 'S')
        ORDER BY 1, 2, 3;

    nuBan           NUMBER := 0;
    flArchivo       pkg_gestionArchivos.styArchivo;
    sbNombArchivo   VARCHAR2 (200) := 'ProdNoLect.html';
    onuError        NUMBER;
    sender          VARCHAR2 (250);
    nuTotal         NUMBER := 0;
BEGIN

    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
    
    --Validar parametrización
    sbRecipients :=
        pkg_BCLD_Parameter.fsbObtieneValorCadena ('LDC_BSS_PRODNOLECT');

    IF sbRecipients IS NULL
    THEN
        pkg_error.setErrorMessage( isbMsgErrr => 
            'No se ha configurado el valor tipo cadena del parámetro LDC_BSS_PRODNOLECT');
    END IF;

    pkg_Traza.Trace ('sbRecipients => ' || sbRecipients);

    nuCodGas := pkg_BCLD_Parameter.fnuObtieneValorNumerico ('COD_SERV_GAS');

    IF sbRecipients IS NULL
    THEN
        pkg_error.setErrorMessage( isbMsgErrr => 
            'No se ha configurado el valor numérico del parámetro COD_SERV_GAS');
    END IF;

    sbRuta :=
        pkg_BCLD_Parameter.fsbObtieneValorCadena ('RUTA_ORIGEN_ARCHIVO_CONSTELE');

    IF sbRuta IS NULL
    THEN
        pkg_error.setErrorMessage( isbMsgErrr => 
            'No se ha configurado el tipo cadena del parámetro RUTA_ORIGEN_ARCHIVO_CONSTELE');
    END IF;

    sender := pkg_BCLD_Parameter.fsbObtieneValorCadena ('LDC_SMTP_SENDER');

    IF sender IS NULL
    THEN
        pkg_error.setErrorMessage( isbMsgErrr => 
            'No se ha configurado el tipo cadena del parámetro LDC_SMTP_SENDER');
    END IF;

    ----------------------------
    flArchivo := pkg_gestionArchivos.ftAbrirArchivo_SMF (sbRuta, sbNombArchivo, 'w');
    --Asunto del correo
    sbSubject :=
        'PRODUCTOS FACTURABLES QUE NO SALDRAN A LECTURA ' || actualDate;
    --Cuerpo del mensaje
    sbMessage0 :=
           'Cordial saludo. Los productos adjuntos a este mensaje no saldrán a lectura.'
        || '<br>'
        || '<br>';

    ---
    pkg_Traza.Trace ('sender => ' || sender);
    pkg_Traza.Trace ('sbRecipients => ' || sbRecipients);
    pkg_Traza.Trace ('sbSubject => ' || sbSubject);
    pkg_Traza.Trace ('sbRuta => ' || sbRuta);
    pkg_Traza.Trace ('sbNombArchivo => ' || sbNombArchivo);
    ---

    --Inicio del adjunto
    sbMessage1 :=
           '<html><body><table BORDER="1"> <tr BGCOLOR="gray"> <th>'
        || RPAD ('SERVICIO SUSCRITO', 23, ' ')
        || '</th> <th>'
        || RPAD ('FECHA DE INSTALACIÓN', 20, ' ')
        || '</th> <th>'
        || RPAD ('ESTADO DE CORTE', 25, ' ')
        || '</th> <th>'
        || RPAD ('CICLO DE FACTURACIÓN', 25, ' ')
        || '</th> <th>'
        || RPAD ('CICLO DE CONSUMO', 25, ' ')
        || '</th>'
        || '</tr>';
    pkg_gestionArchivos.prcEscribirLinea_SMF (flArchivo, sbMessage1);

    --Datos del reporte
    FOR dat IN cuAlert
    LOOP
        sbMessage1 :=
               '<tr> <td>'
            || RPAD (dat.SESUNUSE, 23, ' ')
            || '</td> <td>'
            || RPAD (dat.FECHAINST, 20, ' ')
            || '</td> <td>'
            || RPAD (dat.ESTCORT, 25, ' ')
            || '</td> <td>'
            || RPAD (dat.CICLOFAC, 25, ' ')
            || '</td> <td>'
            || RPAD (dat.CICLOCONS, 25, ' ')
            || '</td>'
            || ' </tr> ';
        pkg_gestionArchivos.prcEscribirLinea_SMF (flArchivo, sbMessage1);
        nuTotal := nuTotal + 1;
        nuBan := 1;
    END LOOP;

    sbMessage1 :=
           '<tr> <td>'
        || RPAD ('TOTAL ', 20, ' ')
        || '</td> <td>'
        || RPAD (nuTotal, 20, ' ')
        || '</td> <tr>';

    pkg_gestionArchivos.prcEscribirLinea_SMF (flArchivo, sbMessage1);
    sbMessage1 := '</table></body></html>';
    pkg_gestionArchivos.prcEscribirLinea_SMF (flArchivo, sbMessage1);

    pkg_gestionArchivos.prcCerrarArchivo_SMF (flArchivo);


    IF (nuTotal > 0 AND nuTotal < 30001)
    THEN
           
        pkg_Correo.prcEnviaCorreo
        (
            isbDestinatarios    => sbRecipients,
            isbAsunto           => sbSubject,
            isbMensaje          => sbMessage0,
            isbArchivos         => sbRuta || '/' || sbNombArchivo
        );
                    
    ELSE
        sbMessage0 :=
               'No se puede enviar el adjunto por el tamaño del archivo.
                                     La cantidad de registros obtenidos es '
            || nuTotal
            || '. Por favor contacte al Administrador para verificar en la ruta ['
            || sbRuta
            || '] el archivo ['
            || sbNombArchivo
            || '].';
            

        pkg_Correo.prcEnviaCorreo
        (
            isbDestinatarios    => sbRecipients,
            isbAsunto           => sbSubject,
            isbMensaje          => sbMessage0
        );
        
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
END ldc_AlertProdNoLect;
/