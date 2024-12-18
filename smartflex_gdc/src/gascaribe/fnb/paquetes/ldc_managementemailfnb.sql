CREATE OR REPLACE PACKAGE LDC_MANAGEMENTEMAILFNB
AS
    /*******************************************************************************
    Propiedad intelectual de PROYECTO PETI

    Descripcion    : Implementa la logica requerida para el manejo de envio de archivos .LOG x email generados en la carga de microseguros
    Autor          : Emiro Leyva Hernandez
    Fecha          : 04-09-2013

    Fecha                IDEntrega           Modificacion
    ============    ================    ============================================
    28-08-2014      KCienfuegos.NC1177  Creacion del metodo <<PROENVIARCHIVOCC>>
    04-09-2013      Emirol               creacion del paquete y adicion de los procedimientos pronotifvigencia, proNotifPorcentEjecucion
    07-03-2024      jpinedc             OSF-2376: Se cambia utl_file por
                                        pkg_gestionArchivos
    12-03-2024      jpinedc             OSF-2376: Se reversa el cambio en el nombre
                                        de los argumentos de PROENVIARCHIVO
    20-03-2024      jpinedc             OSF-2376: Ajustes validación técnica
    13-06-2024      jpinedc             OSF-2604: Se usa pkg_Correo
    *******************************************************************************/

    PROCEDURE PROENVIARCHIVO(sbRemite      VARCHAR2,
                            sbRecibe      VARCHAR2,
                            sbAsunto      VARCHAR2 ,
                            sbNomArchivo  VARCHAR2 ,
                            sbTipoArchivo VARCHAR2 ,
                            sbMens        VARCHAR2 DEFAULT NULL,
                            sbDirectorio  VARCHAR2,
							nuError      out number);

    PROCEDURE ProcObtenerFile;
    
    PROCEDURE PROENVIARCHIVOCC (isbRemite            VARCHAR2,
                                isbRecibe            VARCHAR2,
                                isbCC                VARCHAR2 DEFAULT NULL,
                                isbAsunto            VARCHAR2,
                                isbNomArchivo        VARCHAR2,
                                isbTipoArchivo       VARCHAR2,
                                isbMens              VARCHAR2 DEFAULT NULL,
                                isbDirectorio        VARCHAR2,
                                onuError         OUT NUMBER);
                                
END LDC_ManagementEmailFNB;
/

CREATE OR REPLACE PACKAGE BODY LDC_MANAGEMENTEMAILFNB
AS
    csbSP_NAME		CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT ||'.';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
    
    /*****************************************
    Metodo      : PROENVIARCHIVO
    Descripcion : envia el correo con arhivos adjunto

    Autor: Emiro Rafael Leyva Hernandez
    Fecha: Septiembre 04/2013
   ******************************************/

    PROCEDURE PROENVIARCHIVO(sbRemite      VARCHAR2,
                            sbRecibe      VARCHAR2,
                            sbAsunto      VARCHAR2 ,
                            sbNomArchivo  VARCHAR2 ,
                            sbTipoArchivo VARCHAR2 ,
                            sbMens        VARCHAR2 DEFAULT NULL,
                            sbDirectorio  VARCHAR2,
							nuError      out number)
    IS

        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'PROENVIARCHIVO';

        sbError          VARCHAR2 (2000) := NULL;

    BEGIN
    
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
        
        IF sbRemite IS NULL
        THEN
            raise_application_error (
                -20501,
                'El correo origen no puede ser nulo. ' || SQLERRM);
        ELSIF sbRecibe IS NULL
        THEN
            raise_application_error (
                -20501,
                'El correo destino no puede ser nulo.' || SQLERRM);
        ELSIF sbAsunto IS NULL
        THEN
            raise_application_error (
                -20501,
                'El asunto no puede ser nulo.' || SQLERRM);
        ELSIF sbNomArchivo IS NULL
        THEN
            raise_application_error (
                -20501,
                'El nombre del archivo no puede ser nulo.' || SQLERRM);
        ELSIF sbTipoArchivo IS NULL
        THEN
            raise_application_error (
                -20501,
                'El tipo de archivo no puede ser nulo.' || SQLERRM);
        ELSIF sbDirectorio IS NULL
        THEN
            raise_application_error (
                -20501,
                'El directorio no puedes ser nulo.' || SQLERRM);
        END IF;

        pkg_Correo.prcEnviaCorreo
        (
            isbRemitente        => sbRemite,
            isbDestinatarios    => sbRecibe,
            isbAsunto           => sbAsunto,
            isbMensaje          => sbMens,
            isbArchivos         => sbDirectorio || '/' || sbNomArchivo,
            iblElevaErrores     => TRUE
        );

        nuError := 0;
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);  
    
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            ROLLBACK;                    
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
        WHEN OTHERS THEN       
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
            ROLLBACK;              
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
    END PROENVIARCHIVO;


    /*****************************************
     Metodo      : ProcObtenerFile
     Descripcion : Obtiene los archivo .LOG del directorio del servidor segun la ruta parametrizada y los envia por correo
                   al los correos configurados LDPAR.

     Autor: Emiro Rafael Leyva Hernandez
     Fecha: Septiembre 04/2013
   ******************************************/

    PROCEDURE ProcObtenerFile
    IS


        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'ProcObtenerFile';
        onuError         NUMBER;
        sbError         VARCHAR2(4000);        

        sbFileGl                  VARCHAR2 (100);

        /* Variables para conexion*/

        sbPath                    VARCHAR2 (500);
        SBRUTLOGS                 VARCHAR2 (500);

        vArray                    t_string_table := t_string_table ();
        sbL_file                  VARCHAR2 (500);
        sbL_nom                   VARCHAR2 (500);
        sbMsg                     VARCHAR2 (4000);
        nuPos                     NUMBER;
        nuOk                      NUMBER;
        nuErrorCode               NUMBER;
        sender                    VARCHAR2 (1000);
        sbcorreos                 VARCHAR2 (1000);
        sbeMailscc                VARCHAR2 (1000);
        sbMaineMail               VARCHAR2 (1000);
        isbAsunto                  VARCHAR2 (1000);
        ctrl                      VARCHAR2 (20) := '<br>'; -- Salto de linea..
        vsbfecsis                 VARCHAR2 (30); -- Variable para fecha el sistema..
                
    BEGIN
    
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  

        
        sender := pkg_BCLD_Parameter.fsbObtieneValorCadena ('LDC_SMTP_SENDER');
        sbcorreos := pkg_BCLD_Parameter.fsbObtieneValorCadena ('LDC_SMTP_RECIBE_FNB');

        pkg_traza.trace('sender|' || sender, csbNivelTraza ); 
        pkg_traza.trace('sbcorreos|' || sbcorreos, csbNivelTraza );
        

        isbAsunto := 'Resultado generados por la carga de venta masiva de microseguros';

        pkg_traza.trace('isbAsunto|' || isbAsunto, csbNivelTraza );

        IF (    (dald_parameter.fblexist (LD_BOConstans.csbRutLogs))
            AND (sender IS NOT NULL OR sender <> '')
            AND (sbcorreos IS NOT NULL OR sbcorreos <> ''))
        THEN
            sbMaineMail := SUBSTR (sbcorreos, 0, INSTR (sbcorreos, ',') - 1); --Se obtiene el correo principal
            sbeMailscc :=
                SUBSTR (sbcorreos,
                        INSTR (sbcorreos, ',') + 1,
                        LENGTH (sbcorreos)); --Se obtienen los correos secundarios para el envio de copia
            sbRutLogs :=
                pkg_BCLD_Parameter.fsbObtieneValorCadena (LD_BOConstans.csbRutLogs);
            sbPath := sbRutLogs;

            -- Buscamos fecha del sistema para el mensaje..
            vsbfecsis := TO_CHAR (TRUNC (SYSDATE), 'Month DD, YYYY');

            /* Busca los archivo en el directorio de la ruta de la variable sbPath del parametro 'RUT_FILE_SECURE' con extension .LOG   ..*/

            ld_file_api.ProcGetDirList (sbPath, '.LOG', vArray);

            FOR i IN 1 .. vArray.COUNT
            LOOP
                nuPos :=
                    INSTR (vArray (i),
                           ' ',
                           -1,
                           1);
                sbL_file :=
                    SUBSTR (vArray (i),
                            nuPos + 1,
                            LENGTH (vArray (i)) - nuPos);
                sbL_nom := SUBSTR (vArray (i), 1, LENGTH (vArray (i)) - 4);

                IF UPPER (vArray (i)) LIKE '%VE_%'
                THEN
                    /* Asignamos nombre del archivo...*/
                    sbMsg := NULL;
                    sbMsg := sbMsg || vsbfecsis || ctrl || ctrl;
                    sbMsg := sbMsg || 'Apreciados Señores.' || ctrl || ctrl;
                    sbMsg :=
                           sbMsg
                        || 'Asunto : Archivo generado en el proceso de carga masiva de venta de microseguros '
                        || sbL_file
                        || ctrl
                        || ctrl;
                    sbMsg :=
                           sbMsg
                        || 'Adjunto enviamos resultado generado en el proceso de carga masiva venta microseguro '
                        || sbL_file
                        || ', favor verificar la informacion '
                        || ctrl;
                    sbFileGl := sbL_file;

                    SELECT COUNT (1)
                      INTO nuOk
                      FROM LDC_ARCHFNBENV
                     WHERE NOMBARCHI_ID = sbFileGl;

                    IF nuOk = 0
                    THEN
                        PROENVIARCHIVOCC (sender,
                                          sbMaineMail,
                                          sbeMailscc,
                                          isbAsunto,
                                          sbFileGl,
                                          'text/plain',
                                          sbMsg,
                                          sbPath,
                                          nuErrorCode);

                        IF nuErrorCode = 0
                        THEN
                            INSERT INTO LDC_ARCHFNBENV (NOMBARCHI_ID,
                                                        FECHA_ENVIO,
                                                        ENVIADO_A,
                                                        ASUNTO)
                                 VALUES (sbFileGl,
                                         SYSDATE,
                                         sbcorreos,
                                         isbAsunto);

                            COMMIT;

                            pkg_gestionArchivos.prcRenombraArchivo_SMF (sbPath,
                                              vArray (i),
                                              sbPath,
                                              vArray (i) || '.OK',
                                              TRUE);
                        END IF;
                    END IF;
                END IF;
            END LOOP;
        END IF;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
         
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_Error.getError(onuError,sbError);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);                    
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN       
            pkg_error.setError;
            pkg_Error.getError(onuError,sbError);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);               
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
    END ProcObtenerFile;

    PROCEDURE PROENVIARCHIVOCC (isbRemite            VARCHAR2,
                                isbRecibe            VARCHAR2,
                                isbCC                VARCHAR2 DEFAULT NULL,
                                isbAsunto            VARCHAR2,
                                isbNomArchivo        VARCHAR2,
                                isbTipoArchivo       VARCHAR2,
                                isbMens              VARCHAR2 DEFAULT NULL,
                                isbDirectorio        VARCHAR2,
                                onuError         OUT NUMBER)
    IS
    
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'PROENVIARCHIVOCC';
        
        sbError         VARCHAR2(4000);
        
    BEGIN
    
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
    
        IF isbRemite IS NULL
        THEN
            raise_application_error (
                -20501,
                'El correo origen no puede ser nulo. ' || SQLERRM);
        ELSIF isbRecibe IS NULL
        THEN
            raise_application_error (
                -20501,
                'El correo destino no puede ser nulo.' || SQLERRM);
        ELSIF isbAsunto IS NULL
        THEN
            raise_application_error (
                -20501,
                'El asunto no puede ser nulo.' || SQLERRM);
        ELSIF isbNomArchivo IS NULL
        THEN
            raise_application_error (
                -20501,
                'El nombre del archivo no puede ser nulo.' || SQLERRM);
        ELSIF isbTipoArchivo IS NULL
        THEN
            raise_application_error (
                -20501,
                'El tipo de archivo no puede ser nulo.' || SQLERRM);
        ELSIF isbDirectorio IS NULL
        THEN
            raise_application_error (
                -20501,
                'El directorio no puedes ser nulo.' || SQLERRM);
        END IF;
        
        pkg_Correo.prcEnviaCorreo
        (
            isbRemitente        => isbRemite,
            isbDestinatarios    => isbRecibe,
            isbDestinatariosCC  => isbCC,
            isbAsunto           => isbAsunto,
            isbMensaje          => isbMens,
            isbArchivos         => isbDirectorio || '/' || isbNomArchivo,
            iblElevaErrores     => TRUE
        );
        
        onuError := 0;        

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_Error.getError(onuError,sbError);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            ROLLBACK;                    
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
        WHEN OTHERS THEN       
            pkg_error.setError;
            pkg_Error.getError(onuError,sbError);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
            ROLLBACK;              
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
    END PROENVIARCHIVOCC;
END LDC_ManagementEmailFNB;
/

