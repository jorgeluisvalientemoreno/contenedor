CREATE OR REPLACE PACKAGE ADM_PERSON.pkg_bogestioncorreo
IS
/*******************************************************************************
    Package:        PERSONALIZACIONES.pkg_bogestioncorreo
    Descripción:    Paquete con procedimientos para la gestión de correos
    Fecha:          26/03/2024

    Historial de Modificaciones
    =============================
    FECHA           AUTOR               Descripción
    20/03/2024      jpinedc             OSF-2490: Creación
    20/03/2024      jpinedc             OSF-2490 : Ajustes por validación Técnica
    22/03/2024      jpinedc             OSF-2513 : * Se ajusta prcEnviaCorreo
                                        * Se crea fblArchivoBinarioValido
    01/04/2024      GDGuevara           OSF-2491: Migrado a Efigas
    12/04/2024      Adrianavg           OSF-2575: Se ajusta prcValidaArchivos y 
                                        prcAnexaArchivos
    16/04/2024      jpinedc             OSF-2576: Se hacen ajustes para envio de
                                        correo con mensaje html
    19/04/2024      jpinedc             OSF-2614: Se hacen ajustes para enviar correos
										con tildes y eñes
    22/04/2024      jpinedc             OSF-2614: Se ajusta reemplazo de chr(10) por 
										CrLf en lugar de <br> ya que en formatos html 
										grandes causa problemas.
    28/04/2024      jpinedc             OSF-2765: * Se ajusta validación en 
                                        fsbCorreosValidos
                                        * Se crea fblCorreoValido
                                        * Se borra fsbCodificaAsunto ya que 
                                        reemplaza underscore (_) por espacio
                                        * Se reemplazan eñes por enes en el asunto
    24/06/2024      jpinedc             OSF-2875 : Se pasa a ADM_PERSON 
                                        * Se anexa al mensaje el listado de 
                                        archivos que no se pudieron adjuntar
                                        * Se hace trim a los correos en 
                                        fsbCorreosValidos
*******************************************************************************/

    -- Envia correos con asunto en formato texto o html
    -- El Separador de correos y archivos es punto y coma (;)
    -- Los Archivos texto deben tener la ruta absoluta
    -- Los Archivos binarios deben tener NOMBRE_DIRECTORIO/nombre_archivo_binario
    PROCEDURE prcEnviaCorreo
    (
        isbCorreoRemitente      IN  VARCHAR2,
        isbCorreosDestino       IN  VARCHAR2,
        isbAsunto               IN  VARCHAR2,
        isbMensaje              IN  VARCHAR2,
        isbCorreosDestinoCC     IN  VARCHAR2 DEFAULT NULL,
        isbCorreosDestinoBCC    IN  VARCHAR2 DEFAULT NULL,
        isbArchivos             IN  VARCHAR2 DEFAULT NULL,
        inuPrioridad            IN  NUMBER  DEFAULT NULL,
        isbDescRemitente        IN  VARCHAR2 DEFAULT NULL        
    );
        
    -- Retorna verdadero si la isbExtension existe en el parámetro TIPO_EXT_ARCHIVO_TEXTO
    FUNCTION fblExtenArchTexto(isbExtension VARCHAR2)
    RETURN BOOLEAN;    
    
    -- Retorna verdadero si isbCorreo es un correo valido
    FUNCTION fblCorreoValido( isbCorreo VARCHAR2) RETURN BOOLEAN;

END pkg_bogestioncorreo;
/

CREATE OR REPLACE PACKAGE BODY ADM_PERSON.pkg_bogestioncorreo
IS

    csbSP_NAME		CONSTANT VARCHAR2(35) := $$PLSQL_UNIT || '.';
    csbNivelTraza   CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;

    TYPE tyrcArchivos IS RECORD ( Ruta VARCHAR2(4000), Archivo VARCHAR2(4000), Observacion VARCHAR2(4000) );
    TYPE tyArchivos  IS TABLE OF tyrcArchivos INDEX BY BINARY_INTEGER;
                  
    TYPE tytbExtTexto IS TABLE OF NUMBER(1) INDEX BY VARCHAR2(50);
    
    gtbExtTexto tytbExtTexto;
     
    csbTIPO_EXT_ARCHIVO_TEXTO CONSTANT parametros.valor_cadena%TYPE 
                            := pkg_parametros.fsbGetValorCadena('TIPO_EXT_ARCHIVO_TEXTO');

    -- Inicia envio de Correo con o sin copias
    FUNCTION fcxInicia_MailCC (isbRemitente       IN VARCHAR2,
                           isbDestinatarios   IN VARCHAR2,
                           isbDestinatariosCC     IN VARCHAR2 DEFAULT NULL,
                           isbDestinatariosbCC    IN VARCHAR2 DEFAULT NULL,
                           isbAsunto      IN VARCHAR2,
                           isbTipo_Mime    IN VARCHAR2 DEFAULT 'text/plain',
                           priority     IN PLS_INTEGER DEFAULT NULL,
                           isbDescRemitente IN VARCHAR2)
    RETURN UTL_SMTP.connection;

    -- Escribe cuerpo de correo en formato texto
    PROCEDURE prcEscribeTexto (ioConexion      IN OUT NOCOPY UTL_SMTP.connection,
                          isbTexto   IN            VARCHAR2);

    -- Escribe cuerpo de correo en Binario
    PROCEDURE prcEscribeRaw (ioConexion      IN OUT NOCOPY UTL_SMTP.connection,
                         MESSAGE   IN            RAW);

    -- Envia un archivo texto grande la ruta del servidor en la que se encuentra el archivo
    PROCEDURE prcAdjuntaArchivoTexto (
        ioConexion        IN OUT NOCOPY UTL_SMTP.connection,
        isbRutaArchivos      IN            VARCHAR2,
        isbNombreArchivo    IN            VARCHAR2,
        isbTipo_Mime   IN            VARCHAR2 DEFAULT 'text/plain',
        iblUltimoArchivo        IN            BOOLEAN DEFAULT FALSE,
        isbCodificacionTransfer   IN            VARCHAR2 DEFAULT 'quoted-printable');

    -- Envia un archivo grande sea binario o texto, usa directory en lugar de path
    PROCEDURE prcAdjuntaArchivoBinario (
        ioConexion           IN OUT NOCOPY UTL_SMTP.connection,
        sbDir          IN            VARCHAR2,
        isbNombreArchivo       IN            VARCHAR2,
        isbTipo_Mime      IN            VARCHAR2 DEFAULT 'application/octet',
        iblUltimoArchivo           IN            BOOLEAN DEFAULT FALSE,
        isbCodificacionTransfer   IN            VARCHAR2 DEFAULT NULL);

    -- Inicia la sección para el envío de archivos adjuntos
    PROCEDURE prcIniArchAdjuntos (
        ioConexion           IN OUT NOCOPY UTL_SMTP.connection,
        isbTipo_Mime      IN            VARCHAR2 DEFAULT 'text/plain',
        inline         IN            BOOLEAN DEFAULT TRUE,
        isbNombreArchivo       IN            VARCHAR2 DEFAULT NULL,
        isbCodificacionTransfer   IN            VARCHAR2 DEFAULT NULL);

    -- Termina la sección para el envío de archivos adjuntos
    PROCEDURE prcFinArchAdjuntos (ioConexion   IN OUT NOCOPY UTL_SMTP.connection,
                              iblUltimoArchivo   IN            BOOLEAN DEFAULT FALSE);

    -- Termina el envío de correo
    PROCEDURE prcFinCorreo (ioConexion IN OUT NOCOPY UTL_SMTP.connection);

    -- Inicia sesión en el servidor de correo
    FUNCTION fcxIniciaSesion
        RETURN UTL_SMTP.connection;

    -- Inicia envio de correo en la sesión con copia y con copia oculta.
    PROCEDURE prcIniciaCorreoEnSesionCC (
        ioConexion         IN OUT NOCOPY UTL_SMTP.connection,
        isbRemitente       IN            VARCHAR2,
        isbDestinatarios   IN            VARCHAR2,
        isbDestinatariosCC     IN            VARCHAR2 DEFAULT NULL,
        isbDestinatariosBCC    IN            VARCHAR2 DEFAULT NULL,
        isbAsunto      IN            VARCHAR2,
        isbTipo_Mime    IN            VARCHAR2 DEFAULT 'text/plain',
        priority     IN            PLS_INTEGER DEFAULT NULL,
        isbDescRemitente    IN  VARCHAR2);


    -- Termina el envio de correo en la sesión
    PROCEDURE prcFinCorreoEnSesion (ioConexion IN OUT NOCOPY UTL_SMTP.connection);

    -- Termina la sesión
    PROCEDURE prcFinSesion (ioConexion IN OUT NOCOPY UTL_SMTP.connection);

    -- Escribe Encabezado MIME
    PROCEDURE prcEscribeEncabezadoMime (ioConexion    IN OUT NOCOPY UTL_SMTP.connection,
                                 name    IN            VARCHAR2,
                                 VALUE   IN            VARCHAR2);

    -- Escribe delimitador de sección 
    PROCEDURE prcEscribeDelimitador (ioConexion   IN OUT NOCOPY UTL_SMTP.connection,
                              iblUltimoArchivo   IN            BOOLEAN DEFAULT FALSE);

    -- Escribe Mensaje del correo en formato texto o html
    PROCEDURE prcEscribeMensaje
    (
        ioConexion IN OUT UTL_SMTP.connection,
        isbMensaje VARCHAR2
    );

    smtp_host                        VARCHAR2 (256)
                                         := ldc_bcConsGenerales.fsbValorColumna (
                                                'OPEN.GE_PARAMETER',
                                                'VALUE',
                                                'PARAMETER_ID',
                                                'HOST_MAIL');

    smtp_port                        PLS_INTEGER
                                         := TO_NUMBER (ldc_bcConsGenerales.fsbValorColumna (
                                                           'OPEN.GE_PARAMETER',
                                                           'VALUE',
                                                           'PARAMETER_ID',
                                                           'HOST_MAIL_PORT'));

    smtp_domain                      VARCHAR2 (256) := smtp_host;

    -- Delimitador de secciones de un correo con varias partes
    BOUNDARY                CONSTANT VARCHAR2 (256) := '-----7D81B75CCC90D2974F7A1CBD';

    -- Delimitador Inicial de secciones de un correo con varias partes
    FIRST_BOUNDARY          CONSTANT VARCHAR2 (256)
                                         := '--' || BOUNDARY || UTL_TCP.CRLF ;

    -- Delimitador Final de secciones de un correo con varias partes                                         
    LAST_BOUNDARY           CONSTANT VARCHAR2 (256)
                                         := '--' || BOUNDARY || '--' || UTL_TCP.CRLF ;

    -- Tipo MIME que indica correo con varias sescciones
    MULTIPART_MIME_TYPE     CONSTANT VARCHAR2 (256)
        := 'multipart/mixed; boundary="' || BOUNDARY || '"' ;
            
    -- Carga gtbExtTexto con las extensiones de archivos tipo texto     
    PROCEDURE prcCargagtbExtTexto
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prcCargagtbExtTexto';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        
        CURSOR cuExtensiones
        IS
        SELECT REPLACE(LOWER(regexp_substr(csbTIPO_EXT_ARCHIVO_TEXTO, '[^|]+', 1, LEVEL)),'.','') AS extension
        FROM dual
        CONNECT BY regexp_substr(csbTIPO_EXT_ARCHIVO_TEXTO, '[^|]+', 1, LEVEL) IS NOT NULL;
           
    BEGIN
    
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        
        pkg_traza.trace('csbTIPO_EXT_ARCHIVO_TEXTO[' || csbTIPO_EXT_ARCHIVO_TEXTO|| ']', csbNivelTraza );
                
        pkg_traza.trace('gtbExtTexto.COUNT[' || gtbExtTexto.COUNT|| ']', csbNivelTraza );

        IF gtbExtTexto.COUNT = 0 THEN
        
            FOR rgExtensiones IN cuExtensiones LOOP

                pkg_traza.trace('rgExtensiones.extension[' || rgExtensiones.extension || ']', csbNivelTraza );
                    
                IF NOT gtbExtTexto.Exists( rgExtensiones.extension ) THEN                    

                    pkg_traza.trace('Agrega rgExtensiones.extension[' || rgExtensiones.extension || ']', csbNivelTraza );

                    gtbExtTexto( rgExtensiones.extension ) := 1;
                END IF;
             
            END LOOP;
            
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
    END prcCargagtbExtTexto;
    
    -- Retorna verdadero si isbExtension está en el parámetro TIPO_EXT_ARCHIVO_TEXTO
    FUNCTION fblExtenArchTexto(isbExtension VARCHAR2)
    RETURN BOOLEAN
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fblExtenArchTexto';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        
        blExtensionTexto    BOOLEAN;
        
        sbExtension         VARCHAR2(50);
           
    BEGIN
    
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);

        pkg_traza.trace('isbExtension|' || isbExtension, csbNivelTraza );

        prcCargagtbExtTexto;
                
        sbExtension := LOWER(TRIM(REPLACE(isbExtension,'.','')));
        
        pkg_traza.trace('sbExtension|' || sbExtension, csbNivelTraza );
        
        blExtensionTexto := gtbExtTexto.Exists( sbExtension );
                
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        
        RETURN blExtensionTexto;

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
    END fblExtenArchTexto;    

    -- Retorna uno a uno los correos que se encuentren en la lista de iosbCorreos
    FUNCTION fsbgetCorreo ( iosbCorreos IN OUT VARCHAR2)
    RETURN VARCHAR2
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fsbgetCorreo';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);

        sbCorreo        VARCHAR2(200);

        nuPosSep        NUMBER;

    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);

        nuPosSep := INSTR (iosbCorreos,';');

        IF nuPosSep > 0 THEN
            sbCorreo := SUBSTR(   iosbCorreos, 1, nuPosSep -1 );
            iosbCorreos := SUBSTR(   iosbCorreos, nuPosSep +1 );
        ELSE
            sbCorreo := iosbCorreos;
            iosbCorreos := NULL;
        END IF;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

        RETURN sbCorreo;

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
    END fsbgetCorreo;

    -- Escribe Encabezado MIME
    PROCEDURE prcEscribeEncabezadoMime (ioConexion    IN OUT NOCOPY UTL_SMTP.connection,
                                 name    IN            VARCHAR2,
                                 VALUE   IN            VARCHAR2)
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prcEscribeEncabezadoMime';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        sbDatos         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        sbDatos := name || ': ' || VALUE || UTL_TCP.CRLF;
        pkg_traza.trace('sbDatos|'|| sbDatos , csbNivelTraza );
        UTL_SMTP.write_data (ioConexion, sbDatos );
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
    END prcEscribeEncabezadoMime;

    -- Escribe delimitador de sección 
    PROCEDURE prcEscribeDelimitador (ioConexion   IN OUT NOCOPY UTL_SMTP.connection,
                              iblUltimoArchivo   IN            BOOLEAN DEFAULT FALSE)
    AS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prcEscribeDelimitador';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF (iblUltimoArchivo)
        THEN
            UTL_SMTP.write_data (ioConexion, LAST_BOUNDARY);
        ELSE
            UTL_SMTP.write_data (ioConexion, FIRST_BOUNDARY);
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
    END prcEscribeDelimitador;

    -- Inicia envio de Correo con o sin copias
    FUNCTION fcxInicia_MailCC (isbRemitente       IN VARCHAR2,
                           isbDestinatarios   IN VARCHAR2,
                           isbDestinatariosCC     IN VARCHAR2 DEFAULT NULL,
                           isbDestinatariosBCC    IN VARCHAR2 DEFAULT NULL,
                           isbAsunto      IN VARCHAR2,
                           isbTipo_Mime    IN VARCHAR2 DEFAULT 'text/plain',
                           priority     IN PLS_INTEGER DEFAULT NULL,
                           isbDescRemitente IN VARCHAR2)
        RETURN UTL_SMTP.connection
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fcxInicia_MailCC';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        ioConexion   UTL_SMTP.connection;
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);

        ioConexion := fcxIniciaSesion;

        prcIniciaCorreoEnSesionCC (ioConexion,
                                 isbRemitente,
                                 isbDestinatarios,
                                 isbDestinatariosCC,
                                 isbDestinatariosBCC,
                                 isbAsunto,
                                 isbTipo_Mime,
                                 priority,
                                 isbDescRemitente);

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

        RETURN ioConexion;
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
    END fcxInicia_MailCC;

    -- Escribe cuerpo de correo en formato texto
    PROCEDURE prcEscribeTexto (ioConexion      IN OUT NOCOPY UTL_SMTP.connection,
                          isbTexto   IN            VARCHAR2)
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prcEscribeTexto';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);

    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        
        pkg_traza.trace('isbTexto|'|| isbTexto, csbNivelTraza);

        UTL_SMTP.write_data (ioConexion, isbTexto );

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
    END prcEscribeTexto;

    -- Escribe cuerpo de correo en Binario    
    PROCEDURE prcEscribeRaw (ioConexion      IN OUT NOCOPY UTL_SMTP.connection,
                         MESSAGE   IN            RAW)
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prcEscribeRaw';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        UTL_SMTP.Write_Raw_data (ioConexion, MESSAGE);
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
    END prcEscribeRaw;

    -- Envia un archivo texto grande la ruta del servidor en la que se encuentra el archivo
    PROCEDURE prcAdjuntaArchivoTexto (
        ioConexion        IN OUT NOCOPY UTL_SMTP.connection,
        isbRutaArchivos      IN            VARCHAR2,
        isbNombreArchivo    IN            VARCHAR2,
        isbTipo_Mime   IN            VARCHAR2 DEFAULT 'text/plain',
        iblUltimoArchivo        IN            BOOLEAN DEFAULT FALSE,
        isbCodificacionTransfer   IN         VARCHAR2 DEFAULT 'quoted-printable')
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prcAdjuntaArchivoTexto';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);

        v_file_handle   pkg_gestionArchivos.styArchivo;
        v_line          VARCHAR2 (32000);
        data            VARCHAR2 (32000);
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);

        prcIniArchAdjuntos (ioConexion,
                          isbTipo_Mime,
                          FALSE,
                          isbNombreArchivo,
                          isbCodificacionTransfer);

        v_file_handle := pkg_gestionArchivos.ftAbrirArchivo_SMF (isbRutaArchivos, isbNombreArchivo, 'r');

        -- Se anexa el contenido del archivo al cuerpo del correo
        BEGIN
            LOOP
                v_line := pkg_gestionArchivos.fsbObtenerLinea_SMF (v_file_handle );
                data := v_line || CHR (10);
                pkg_traza.trace('data|'|| data, csbNivelTraza);
                prcEscribeTexto (ioConexion, UTL_ENCODE.TEXT_ENCODE( REPLACE( data, CHR( 10 ), UTL_TCP.CRLF ), NULL, UTL_ENCODE.QUOTED_PRINTABLE ) );
            END LOOP;
        EXCEPTION
            WHEN OTHERS
            THEN
                NULL;
        END;

        pkg_gestionArchivos.prcCerrarArchivo_SMF (v_file_handle);

        prcFinArchAdjuntos (ioConexion, iblUltimoArchivo);

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
    END prcAdjuntaArchivoTexto;
    
    -- Retorna verdadero si isbNombreArchivo existe en el directorio sbDir y puede leerse
    FUNCTION fblArchivoBinarioValido (
        sbDir          IN            VARCHAR2,
        isbNombreArchivo       IN            VARCHAR2)
    RETURN BOOLEAN
    IS

        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fblArchivoBinarioValido';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);

        v_bfile_handle   BFILE;
        v_bfile_len      NUMBER;
        v_line           RAW (32767);
        vpi              INTEGER;
        vcan             INTEGER;

        blArchivoBinarioValido  BOOLEAN := FALSE;

    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);

        v_bfile_handle := BFILENAME (sbDir, isbNombreArchivo);
        v_bfile_len := DBMS_LOB.getlength (v_bfile_handle);

        IF v_bfile_len > 0 THEN
        
            DBMS_LOB.open (v_bfile_handle, DBMS_LOB.lob_readonly);

            vpi := 1;

            IF vpi + 54 - 1 > v_bfile_len
            THEN
                vcan := v_bfile_len - vpi + 1;
            ELSE
                vcan := 54;
            END IF;

            DBMS_LOB.read (file_loc   => v_bfile_handle,
                           amount     => vcan,
                           offset     => vpi,
                           buffer     => v_line);

            DBMS_LOB.fileclose (v_bfile_handle);

            blArchivoBinarioValido := TRUE;
                    
        END IF;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

        RETURN blArchivoBinarioValido;

    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RETURN blArchivoBinarioValido;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RETURN blArchivoBinarioValido;
    END fblArchivoBinarioValido;
    
    -- Envia un archivo grande sea binario o texto, usa directory en lugar de path    
    PROCEDURE prcAdjuntaArchivoBinario (
        ioConexion           IN OUT NOCOPY UTL_SMTP.connection,
        sbDir          IN            VARCHAR2,
        isbNombreArchivo       IN            VARCHAR2,
        isbTipo_Mime      IN            VARCHAR2 DEFAULT 'application/octet',
        iblUltimoArchivo           IN            BOOLEAN DEFAULT FALSE,
        isbCodificacionTransfer   IN            VARCHAR2 DEFAULT NULL)
    IS

        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prcAdjuntaArchivoBinario';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);

        v_bfile_handle   BFILE;
        v_bfile_len      NUMBER;
        v_line           RAW (32767);
        vpi              INTEGER;
        vcan             INTEGER;
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);

        prcIniArchAdjuntos (ioConexion,
                          isbTipo_Mime,
                          FALSE,
                          isbNombreArchivo,
                          isbCodificacionTransfer);
        v_bfile_handle := BFILENAME (sbDir, isbNombreArchivo);
        v_bfile_len := DBMS_LOB.getlength (v_bfile_handle);
        DBMS_LOB.open (v_bfile_handle, DBMS_LOB.lob_readonly);
        -- Se anexa el contenido del archivo al cuerpo del correo
        vpi := 1;

        LOOP
            BEGIN
                IF vpi + 54 - 1 > v_bfile_len
                THEN
                    vcan := v_bfile_len - vpi + 1;
                ELSE
                    vcan := 54;
                END IF;

                DBMS_LOB.read (file_loc   => v_bfile_handle,
                               amount     => vcan,
                               offset     => vpi,
                               buffer     => v_line);
                prcEscribeRaw (ioConexion, UTL_ENCODE.base64_encode (v_line));
                vpi := vpi + 54;

                IF vpi > v_bfile_len
                THEN
                    EXIT;
                END IF;
            EXCEPTION
                WHEN NO_DATA_FOUND
                THEN
                    EXIT;
                WHEN OTHERS
                THEN
                    NULL;
            END;
        END LOOP;

        DBMS_LOB.fileclose (v_bfile_handle);
        prcFinArchAdjuntos (ioConexion, iblUltimoArchivo);

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
    END prcAdjuntaArchivoBinario;

    -- Inicia la sección para el envío de archivos adjuntos
    PROCEDURE prcIniArchAdjuntos (
        ioConexion           IN OUT NOCOPY UTL_SMTP.connection,
        isbTipo_Mime      IN            VARCHAR2 DEFAULT 'text/plain',
        inline         IN            BOOLEAN DEFAULT TRUE,
        isbNombreArchivo       IN            VARCHAR2 DEFAULT NULL,
        isbCodificacionTransfer   IN            VARCHAR2 DEFAULT NULL)
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prcIniArchAdjuntos';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);

        prcEscribeDelimitador (ioConexion);

        prcEscribeEncabezadoMime (ioConexion, 'Content-Type', isbTipo_Mime );

        IF (isbCodificacionTransfer IS NOT NULL)
        THEN
            prcEscribeEncabezadoMime (ioConexion,
                               'Content-Transfer-Encoding',
                               isbCodificacionTransfer);
        END IF;

        IF (isbNombreArchivo IS NOT NULL)
        THEN
            IF (inline)
            THEN
                prcEscribeEncabezadoMime (ioConexion,
                                   'Content-Disposition',
                                   'inline;' ||  UTL_TCP.CRLF ||'isbNombreArchivo="' || isbNombreArchivo || '"'
                                   );
            ELSE
                prcEscribeEncabezadoMime (
                    ioConexion,
                    'Content-Disposition',
                    'attachment;' ||  UTL_TCP.CRLF ||'isbNombreArchivo="' || isbNombreArchivo || '"');
            END IF;
        END IF;


        UTL_SMTP.write_data (ioConexion, UTL_TCP.CRLF);

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
    END prcIniArchAdjuntos;

    -- Termina la sección para el envío de archivos adjuntos
    PROCEDURE prcFinArchAdjuntos (ioConexion   IN OUT NOCOPY UTL_SMTP.connection,
                              iblUltimoArchivo   IN            BOOLEAN DEFAULT FALSE)
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prcFinArchAdjuntos';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);

        UTL_SMTP.write_data (ioConexion, UTL_TCP.CRLF);

        IF (iblUltimoArchivo)
        THEN
            prcEscribeDelimitador (ioConexion, iblUltimoArchivo);
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
    END prcFinArchAdjuntos;

    -- Termina el envío de correo
    PROCEDURE prcFinCorreo (ioConexion IN OUT NOCOPY UTL_SMTP.connection)
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prcFinCorreo';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        prcFinCorreoEnSesion (ioConexion);
        prcFinSesion (ioConexion);
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
    END prcFinCorreo;

    -- Inicia sesión en el servidor de correo
    FUNCTION fcxIniciaSesion RETURN utl_smtp.connection IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fcxIniciaSesion';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        ioConexion utl_smtp.connection;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        -- open SMTP connection
        pkg_traza.trace('smtp_host:   ('||smtp_host||')',   csbNivelTraza );
        pkg_traza.trace('smtp_port:   ('||smtp_port||')',   csbNivelTraza );
        pkg_traza.trace('smtp_domain: ('||smtp_domain||')', csbNivelTraza );

        ioConexion := utl_smtp.open_connection(smtp_host, smtp_port);
        utl_smtp.helo(ioConexion, smtp_domain);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN ioConexion;
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError-1 => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError-2 => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
    END fcxIniciaSesion;
    
    -- Inicia envio de correo en la sesión con copia y con copia oculta.
    PROCEDURE prcIniciaCorreoEnSesionCC (
        ioConexion         IN OUT NOCOPY UTL_SMTP.connection,
        isbRemitente       IN            VARCHAR2,
        isbDestinatarios   IN            VARCHAR2,
        isbDestinatariosCC     IN            VARCHAR2 DEFAULT NULL,
        isbDestinatariosBCC    IN            VARCHAR2 DEFAULT NULL,
        isbAsunto      IN            VARCHAR2,
        isbTipo_Mime    IN            VARCHAR2 DEFAULT 'text/plain',
        priority     IN            PLS_INTEGER DEFAULT NULL,
        isbDescRemitente    IN  VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prcIniciaCorreoEnSesionCC';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);

        my_sender       VARCHAR2 (32767) := isbRemitente;
        my_recipients   VARCHAR2 (32767) := isbDestinatarios;
        my_recip_CC     VARCHAR2 (32767) := isbDestinatariosCC;
        my_recip_BCC    VARCHAR2 (32767) := isbDestinatariosBCC;
        
        sbAsuntoCodificado  VARCHAR2(4000);
        
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);

        -- Establece el correo remitente.
        UTL_SMTP.mail (ioConexion, fsbgetCorreo (my_sender));

        -- Establece el(los) correos destinatarios
        WHILE (my_recipients IS NOT NULL)
        LOOP
            UTL_SMTP.rcpt (ioConexion, fsbgetCorreo (my_recipients));
        END LOOP;

        -- Establece el(los) correos destinatarios de copia
        WHILE (my_recip_CC IS NOT NULL)
        LOOP
            UTL_SMTP.rcpt (ioConexion, fsbgetCorreo (my_recip_CC));
        END LOOP;

        -- Establece el(los) correos destinatarios de copia oculta
        WHILE (my_recip_BCC IS NOT NULL)
        LOOP
            UTL_SMTP.rcpt (ioConexion, fsbgetCorreo (my_recip_BCC));
        END LOOP;

        -- Inicia el cuerpo del correo
        UTL_SMTP.open_data (ioConexion);

        -- Establece el encabezado MIME "From"
        prcEscribeEncabezadoMime (ioConexion, 'From','"' || isbDescRemitente || '" <' || isbRemitente||'>');

        -- Establece el encabezado MIME "To"
        prcEscribeEncabezadoMime (ioConexion, 'To', isbDestinatarios);
        
        -- Remplaza las eñes
        sbAsuntoCodificado := TRANSLATE(isbAsunto,'Ññ','Nn');

        -- Establece el encabezado MIME "Subject"        
        prcEscribeEncabezadoMime (ioConexion, 'Subject', sbAsuntoCodificado );

        -- Establece el encabezado MIME "Mime-Version"
        prcEscribeEncabezadoMime (ioConexion, 'Mime-Version', '1.0');

        -- Establece el encabezado MIME "Content-Type"
        prcEscribeEncabezadoMime (ioConexion, 'Content-Type', isbTipo_Mime);

        -- Establece la prioridad 
        --   Alta = 1     Normal = 3      Baja = 5
        IF (priority IS NOT NULL)
        THEN
            prcEscribeEncabezadoMime (ioConexion, 'X-Priority', priority);
        END IF;

        -- Send an empty line to denotes end of MIME headers and
        -- Envia una línea vacía para indicar fin de encabezados MIME e 
        -- inicio del cuerpo del mensaje
        UTL_SMTP.write_data (ioConexion, UTL_TCP.CRLF);
        UTL_SMTP.write_data (ioConexion, UTL_TCP.CRLF);

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
    END prcIniciaCorreoEnSesionCC;

    -- Termina el envio de correo en la sesión
    PROCEDURE prcFinCorreoEnSesion (ioConexion IN OUT NOCOPY UTL_SMTP.connection)
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prcFinCorreoEnSesion';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        UTL_SMTP.close_data (ioConexion);
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
    END prcFinCorreoEnSesion;

    -- Termina la sesión
    PROCEDURE prcFinSesion (ioConexion IN OUT NOCOPY UTL_SMTP.connection)
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prcFinSesion';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        UTL_SMTP.quit (ioConexion);
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
    END prcFinSesion;

    -- Retorna los correos válidos contenidos en  isbCorreos   
    FUNCTION fsbCorreosValidos( isbCorreos VARCHAR2, isbListaCorreos VARCHAR2)
    RETURN VARCHAR2
    IS

        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fsbCorreosValidos';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);

        tbCorreos           tStringTable;
        sbCorreosValidos    VARCHAR2(4000);

        sbMensajeError      VARCHAR2(4000);

        sbCorreos           VARCHAR2(4000);

    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);

        sbCorreos := TRIM(isbCorreos);

        sbCorreos := TRANSLATE(sbCorreos, '"<>,|',';;;;;');

        tbCorreos := ldc_bcconsgenerales.ftbSplitString( sbCorreos, ';');

        FOR indtb IN 1..tbCorreos.COUNT LOOP
            IF fblCorreoValido(TRIM(tbCorreos(indtb ))) THEN
                IF sbCorreosValidos IS NOT NULL THEN
                    sbCorreosValidos := sbCorreosValidos || ';';
                END IF;
                sbCorreosValidos := sbCorreosValidos || TRIM(tbCorreos(indtb ));
            END IF;
        END LOOP;

        pkg_traza.trace('isbListaCorreos| '|| isbListaCorreos, csbNivelTraza );
        pkg_traza.trace('sbCorreosValidos| '|| sbCorreosValidos || '|', csbNivelTraza );
        pkg_traza.trace('LENGTH(sbCorreosValidos)| '|| LENGTH(sbCorreosValidos) || '|', csbNivelTraza );
                
        IF NVL(LENGTH(sbCorreosValidos),0) = 0 THEN
            IF isbListaCorreos IN ('Remitente','Destinatarios' ) THEN
                sbMensajeError := 'La lista de correos['|| isbListaCorreos || '][' || isbCorreos || '] no tiene correos validos';
                pkg_error.setErrorMessage( isbMsgErrr => sbMensajeError );
            END IF;
        END IF;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

        RETURN sbCorreosValidos;

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
    END fsbCorreosValidos;

    -- Retorna tablas pl otbArchivosValidos y otbArchivosNoValidos
    PROCEDURE prcValidaArchivos
    (
        isbArchivos             VARCHAR2,
        isbListaArchivos        VARCHAR2,
        otbArchivosValidos  OUT tyArchivos,
        otbArchivosNoValidos OUT tyArchivos
    )
    IS
    /****************************************************************************
    Histórico de modificaciones
    Fecha       Autor           Modificación
    12/04/2024  Adrianavg       OSF-2575: Se ajusta para que use nuevo parámetro TIPO_EXT_ARCHIVO_TEXTO que contenga la lista de extensiones de archivos de tipo texto
    *****************************************************************************/    

        csbMetodo       CONSTANT VARCHAR2(70) := csbSP_NAME || 'prcValidaArchivos';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);

        tbArchivos      tStringTable;
        tbTokens        tStringTable;

        sbRuta          VARCHAR2(4000);
        sbArchivo       VARCHAR2(4000);

        nuIndVal        NUMBER;
        nuIndNoVal      NUMBER;
        
        sbarchivoext    VARCHAR2(50);

    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);

        IF isbArchivos IS NOT NULL THEN

            tbArchivos := ldc_bcconsgenerales.ftbSplitString( isbArchivos, ';');

            FOR indtb IN 1..tbArchivos.COUNT LOOP

                pkg_traza.trace('tbArchivos('||indtb||')|' ||tbArchivos(indtb) , csbNivelTraza);

                tbTokens := ldc_bcconsgenerales.ftbSplitString( tbArchivos(indtb), '/');

                sbRuta      := REPLACE( tbArchivos(indtb), '/' || tbTokens(tbTokens.COUNT), '' );
                sbArchivo   := tbTokens(tbTokens.COUNT);

                pkg_traza.trace('sbRuta   |' ||sbRuta , csbNivelTraza);
                pkg_traza.trace('sbArchivo|' ||sbArchivo , csbNivelTraza );
                
                --extraer la extensión del archivo
                sbarchivoext:= UPPER(substr(sbarchivo, instr(sbarchivo, '.')));
                pkg_traza.trace(csbMetodo||' Extensión del archivo: '||sbarchivoext, csbNivelTraza);
                             
                IF REGEXP_LIKE( tbArchivos(indtb ), '^[\/A-Za-z0-9._%+-]+\.[A-Za-z]{2,4}$') THEN

                    IF fblExtenArchTexto(sbarchivoext) THEN

                        pkg_traza.trace('Archivo es de tipo texto ' , csbNivelTraza );

                        IF pkg_gestionArchivos.fblExisteArchivo_SMF( sbRuta, sbArchivo ) THEN

                            pkg_traza.trace('Sí existe el archivo|' ||sbArchivo , csbNivelTraza );

                            nuIndVal := otbArchivosValidos.count +1;

                            otbArchivosValidos(nuIndVal ).Ruta := sbRuta;
                            otbArchivosValidos(nuIndVal ).Archivo := sbArchivo;
                            otbArchivosValidos(nuIndVal ).Observacion := 'Existe';
                        ELSE

                            pkg_traza.trace('No exise el archivo|' ||sbArchivo , csbNivelTraza );
                            nuIndNoVal := otbArchivosNoValidos.count +1;

                            otbArchivosNoValidos(nuIndNoVal ).Ruta := sbRuta;
                            otbArchivosNoValidos(nuIndNoVal ).Archivo := sbArchivo;
                            otbArchivosNoValidos(nuIndNoVal ).Observacion := 'No Existe';
                        END IF;

                    ELSE
                        
                        pkg_traza.trace('Archivo es de tipo binario ' , csbNivelTraza );
                        IF fblArchivoBinarioValido( sbRuta, sbArchivo ) THEN

                            nuIndVal := otbArchivosValidos.count +1;

                            otbArchivosValidos(nuIndVal ).Ruta := sbRuta;
                            otbArchivosValidos(nuIndVal ).Archivo := sbArchivo;
                            otbArchivosValidos(nuIndVal ).Observacion := 'Existe';

                        ELSE
                        
                            nuIndNoVal := otbArchivosNoValidos.count +1;
                            
                            otbArchivosNoValidos(nuIndNoVal ).Ruta := sbRuta;
                            otbArchivosNoValidos(nuIndNoVal ).Archivo := sbArchivo;
                            otbArchivosNoValidos(nuIndNoVal ).Observacion := 'No Existe';

                        END IF;
                    END IF;

                ELSE

                    pkg_traza.trace('El nombre del archivo no es valido|' ||sbArchivo , csbNivelTraza );

                        nuIndNoVal := otbArchivosNoValidos.count +1;

                        otbArchivosNoValidos(nuIndNoVal ).Ruta := sbRuta;
                        otbArchivosNoValidos(nuIndNoVal ).Archivo := sbArchivo;
                        otbArchivosNoValidos(nuIndNoVal ).Observacion := 'Nombre o ruta invalidos';
                END IF;
            END LOOP;

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
    END prcValidaArchivos;

    -- Escribe Mensaje del correo en formato texto o html    
    PROCEDURE prcEscribeMensaje (ioConexion      IN OUT NOCOPY UTL_SMTP.connection,
                          isbMensaje   IN            VARCHAR2)
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prcEscribeMensaje';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        sbDatos         VARCHAR2(32767);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        
        prcEscribeDelimitador(ioConexion);
        prcEscribeEncabezadoMime(ioConexion, 'Content-Type', 'text/html ; charset="iso-8859-1"' );

        prcEscribeEncabezadoMime(ioConexion, 'Content-Transfer-Encoding', 'quoted-printable' );
        UTL_SMTP.write_data (ioConexion, UTL_TCP.CRLF);        

        sbDatos := UTL_ENCODE.TEXT_ENCODE( REPLACE(isbMensaje, CHR(10), UTL_TCP.CRLF), NULL, UTL_ENCODE.QUOTED_PRINTABLE ) || UTL_TCP.CRLF ;
         
        pkg_traza.trace('sbDatos|'|| sbDatos, csbNivelTraza);

        IF sbDatos IS NOT NULL THEN
            UTL_SMTP.write_data (ioConexion, sbDatos );
            UTL_SMTP.write_data (ioConexion, UTL_TCP.CRLF );
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
    END prcEscribeMensaje;

    -- Anexa archivos válidos contenidos en itbArchivos
    PROCEDURE prcAnexaArchivos
    (
        ioConexion IN OUT UTL_SMTP.connection,
        itbArchivos tyArchivos
    )
    IS
    /****************************************************************************
    Histórico de modificaciones
    Fecha       Autor           Modificación
    12/04/2024  Adrianavg       OSF-2575: Se ajusta para que use nuevo parámetro que contenga la lista de extensiones de archivos de tipo texto
    *****************************************************************************/
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prcAnexaArchivos';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        sbArchivo       VARCHAR2(4000);
        sbarchivoext    VARCHAR2(50);
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);

        FOR indtbArch IN 1..itbArchivos.COUNT LOOP

            pkg_traza.trace('Ruta   |' || itbArchivos(indtbArch).Ruta, csbNivelTraza );
            pkg_traza.trace('Archivo|' || itbArchivos(indtbArch).Archivo, csbNivelTraza );
            
            sbArchivo:= itbArchivos(indtbArch).Archivo;
            
            --extraer la extensión del archivo
            sbarchivoext:= UPPER(substr(sbarchivo, instr(sbarchivo, '.')));
            pkg_traza.trace(csbMetodo||' Extensión del archivo: '||sbarchivoext, csbNivelTraza);
                              
            CASE

                WHEN fblExtenArchTexto(sbarchivoext) THEN
                    pkg_traza.trace('Archivo es de tipo texto ' , csbNivelTraza );
                    
                    prcAdjuntaArchivoTexto
                    (
                        ioConexion,
                        itbArchivos(indtbArch).Ruta,
                        itbArchivos(indtbArch).Archivo,
                        'text/plain;' || UTL_TCP.CRLF || ' name="' || itbArchivos(indtbArch).Archivo || '"',
                        indtbArch = itbArchivos.COUNT,
                        'quoted-printable'
                    );

                ELSE
                    pkg_traza.trace('Archivo es de tipo Binario ' , csbNivelTraza );
                    
                    prcAdjuntaArchivoBinario
                    (
                        ioConexion,
                        itbArchivos(indtbArch).Ruta,
                        itbArchivos(indtbArch).Archivo,
                        'application/octet-stream;' || UTL_TCP.CRLF ||' name="' ||itbArchivos(indtbArch).Archivo || '"',
                        indtbArch = itbArchivos.COUNT,
                        'base64'
                    );

            END CASE;

        END LOOP;

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
    END prcAnexaArchivos;

    -- Envia correos con asunto en formato texto o html
    -- El Separador de correos y archivos es punto y coma (;)
    -- Los Archivos texto deben tener la ruta absoluta
    -- Los Archivos binarios deben tener NOMBRE_DIRECTORIO/nombre_archivo_binario
    PROCEDURE prcEnviaCorreo
    (
        isbCorreoRemitente      IN  VARCHAR2,
        isbCorreosDestino       IN  VARCHAR2,
        isbAsunto               IN  VARCHAR2,
        isbMensaje              IN  VARCHAR2,
        isbCorreosDestinoCC     IN  VARCHAR2 DEFAULT NULL,
        isbCorreosDestinoBCC    IN  VARCHAR2 DEFAULT NULL,
        isbArchivos             IN  VARCHAR2 DEFAULT NULL,
        inuPrioridad            IN  NUMBER   DEFAULT NULL,
        isbDescRemitente        IN  VARCHAR2 DEFAULT NULL        
    )
    IS

        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prcEnviaCorreo';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);


        sbCorreoRemitente       VARCHAR2(4000);
        sbCorreosDestinatarios  VARCHAR2(4000);
        sbCorreosCC             VARCHAR2(4000);
        sbCorreosBCC            VARCHAR2(4000);
        conexion                UTL_SMTP.connection;

        tbArchivosValidos       tyArchivos;
        tbArchivosNoValidos     tyArchivos;

        sbMensaje               varchar2(32000) := isbMensaje;

    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);

        -- Valida correo remitente
        sbCorreoRemitente :=  fsbCorreosValidos( isbCorreoRemitente, 'Remitente' );

        -- Valida correos destino
        sbCorreosDestinatarios := fsbCorreosValidos( isbCorreosDestino, 'Destinatarios' );

        -- Valida correos destino CC
        sbCorreosCC := fsbCorreosValidos( isbCorreosDestinoCC, 'CC' );

        -- Valida correos destino BCC
        sbCorreosBCC := fsbCorreosValidos( isbCorreosDestinoBCC, 'BCC' );

        -- Valida los archivos que se van a anexar
        prcValidaArchivos( isbArchivos, 'Anexos', tbArchivosValidos, tbArchivosNoValidos );
        
        IF tbArchivosNoValidos.count > 0 then

            sbMensaje := sbMensaje || '<br>';
            sbMensaje := sbMensaje || '<br>';
            sbMensaje := sbMensaje || 'Archivos no anexados:' || '<br>';
                    
            FOR indArcNoVal IN 1..tbArchivosNoValidos.COUNT LOOP
                sbMensaje := sbMensaje || tbArchivosNoValidos(indArcNoVal).Ruta || '/' ||  tbArchivosNoValidos(indArcNoVal).Archivo  || ' - ' ||  tbArchivosNoValidos(indArcNoVal).Observacion || '<br>';
            END LOOP;
        END IF;

        conexion := fcxInicia_MailCC (sbCorreoRemitente,
                           sbCorreosDestinatarios,
                           sbCorreosCC,
                           sbCorreosBCC,
                           isbAsunto   ,
                           MULTIPART_MIME_TYPE   ,
                           inuPrioridad,
                           isbDescRemitente);

        prcEscribeMensaje( conexion, sbMensaje );
            
        IF tbArchivosValidos.COUNT > 0 THEN

            prcAnexaArchivos( conexion, tbArchivosValidos );
            
        END IF;

        prcFinCorreo( conexion );

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
    END prcEnviaCorreo;

    -- Retorna verdadero si isbCorreo es un correo valido
    FUNCTION fblCorreoValido( isbCorreo VARCHAR2) RETURN BOOLEAN
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fblCorreoValido';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    
        blCorreoValido  BOOLEAN := FALSE;
    BEGIN
    
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);    
    
        blCorreoValido := REGEXP_LIKE( isbCorreo, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$');

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
                
        RETURN blCorreoValido;
        
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
    END fblCorreoValido;
    
END pkg_bogestioncorreo;
/

