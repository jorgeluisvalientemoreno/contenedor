CREATE OR REPLACE PROCEDURE PBRCD (
    inuProgramacion   IN ge_process_schedule.process_schedule_id%TYPE)
AS
    /*
        Autor                       Fecha               Deccripcion
        -----                       -----               -------------
        Jhon Jarney Plaza Rivera    22/11/2014          NC3824
        Jorge Valiente              25/11/2014          NC3698: VAlidacion para establecer un nuevo valor
                                                                   con un nuevo metodo ce calculo establecido
                                                                   por Gases de caribe para la refinanciacion
                                                                   de diferidos
        cgonzalez                   16/05/2020          OSF-252: Se ajusta para realizar la actualización del interés siempre
        cgonzalez                   09/06/2020          OSF-345: Se ajusta para tener en cuenta las tasas de interes configuradas
                                                        en el parametro LDC_TASAS_PBRCD
        jpinedc                     18/06/2024          OSF-2605: * Se usa pkg_Correo
                                                        * Ajustes por estándares
    */

    csbMetodo        CONSTANT VARCHAR2(70) :=  'PBRCD';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
        
    ----NC3698
    NUCuotaCalculada    NUMBER; --valor de la cuota que se calcula con la formula actual.
    NUFactorGradiante   NUMBER; --Corresponde al factor gradiente
    NUNumeroCuotas      NUMBER; --Numero de cuotas ya facturadas del diferido
    NuevoQuotaValue     NUMBER; --Neuvo Valor despues de aplicar el factor gradiante

    CURSOR CUPLANDIFE (NUPLDICODI   PLANDIFE.PLDICODI%TYPE,
                       NUPLDIMCCD   PLANDIFE.PLDIMCCD%TYPE)
    IS
    SELECT *
    FROM PLANDIFE PD
    WHERE PD.PLDICODI = NUPLDICODI AND PD.PLDIMCCD = NUPLDIMCCD;

    TEMPCUPLANDIFE      CUPLANDIFE%ROWTYPE;

    nuNominalPerc       NUMBER;
    nuCantidad          NUMBER;
    nuRoundFactor       NUMBER;
    nuQuotaValue        diferido.DIFEVACU%TYPE;
    nuTasaInte          NUMBER;
    nuSpread            diferido.DIFESPRE%TYPE;
    inuIdCompany        NUMBER := 99;
    nuMethod            diferido.DIFEMECA%TYPE;
    nuInteresPorc       CONFTAIN.COTIPORC%TYPE;
    nuCotitain          CONFTAIN.COTITAIN%TYPE;
    nuPorc              CONFTAIN.COTIPORC%TYPE;
    dtSysdate           DATE := TO_DATE (SYSDATE, LDC_BOConsGenerales.fsbGetFormatoFecha);

    sbFECHA_PROCESO     ge_boInstanceControl.stysbValue;
    dtExecDate          DATE;
    sbError             VARCHAR2(4000);
    nuError             NUMBER;
    nudiferido  NUMBER := 0;

    -- Cursor para obtener los diferidos con saldo pendiente
    CURSOR cuDiferidos (inuTasa diferido.difetain%TYPE)
    IS
    SELECT DIFECODI     idDiferido,
    DIFESUSC     nuSuscripcion,
    DIFENUSE     nuServicio
    FROM diferido
    WHERE DIFESAPE > 0
    AND DIFEINTE <> 0 AND DIFETAIN = inuTasa;

    sbRecipients        VARCHAR2 (20000);
    sbSubject           VARCHAR2 (200);
    sbMessage0          VARCHAR2 (30000);
    sbMessage1          VARCHAR2 (30000);

    TYPE tytblDiferido IS TABLE OF cuDiferidos%ROWTYPE
        INDEX BY PLS_INTEGER;

    tblDiferido         tytblDiferido;
    rgDiferido          cuDiferidos%ROWTYPE;
    limit_in            PLS_INTEGER := 100;

    --Cursor para obtener las tasa de interes modificadas que no han sido procesadas
    CURSOR cuLDC_CONFTAIN (idtExecDate DATE)
    IS
    SELECT COTITAIN, COTIFEIN, COTIPORC
    FROM LDC_CONFTAIN
    WHERE     FLAG = 'N'
    AND idtExecDate BETWEEN TO_DATE (LDC_CONFTAIN.COTIFEIN,
                                    LDC_BOConsGenerales.fsbGetFormatoFecha)
                       AND TO_DATE (LDC_CONFTAIN.COTIFEFI,
                                    LDC_BOConsGenerales.fsbGetFormatoFecha);

    sbProcesar          VARCHAR2 (1) := 'S';
    nuCountTasa         NUMBER := 0;
    nuCount             NUMBER := 0;
    nuCountTotal        NUMBER := 0;
    nuFactor            diferido.DIFEFAGR%TYPE;
    sbParametros        GE_PROCESS_SCHEDULE.PARAMETERS_%TYPE;

    -- Log PB
    nuLdlpcons          ldc_log_pb.ldlpcons%TYPE;

    nuTasaValida        conftain.cotitain%TYPE;

    CURSOR cuTasasPBRCD (inuTasa IN conftain.cotitain%TYPE)
    IS
        SELECT COLUMN_VALUE
          FROM TABLE (
                   ldc_boutilities.splitstrings (
                       pkg_BCLD_Parameter.fsbObtieneValorCadena ('LDC_TASAS_PBRCD'),
                       ','))
         WHERE COLUMN_VALUE = inuTasa;

    /*
    Autor                     Fecha                      Deccripcion
    -----                     -----                      -------------
    Jhon Jarney Plaza Rivera  22/11/2014                 NC3824

        ProcessLog
        Inserta o Actualiza el log de PB
    */
    PROCEDURE ProcessLog (inuCons   IN OUT ldc_log_pb.ldlpcons%TYPE,
                          isbProc   IN     ldc_log_pb.ldlpproc%TYPE,
                          idtFech   IN     ldc_log_pb.ldlpfech%TYPE,
                          isbInfo   IN     ldc_log_pb.ldlpinfo%TYPE)
    IS

        csbMetodo1        CONSTANT VARCHAR2(70) := csbMetodo || '.ProcessLog';
        
        -- Session
        sbSession   VARCHAR2 (50);
        -- Usuario
        sbUser      VARCHAR2 (50);
        -- Info Aux
        sbInfoAux   ldc_log_pb.ldlpinfo%TYPE;
    BEGIN
    
        pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbINICIO); 
        
        -- Obtiene valor de la session
        sbSession   := USERENV ('SESSIONID');
        sbUser      := USER;

        -- Insertamos o Actualizamos
        IF (inuCons IS NULL)
        THEN
            -- Obtiene CONS de log pb
            inuCons := SEQ_LDC_LOG_PB.NEXTVAL;

            INSERT INTO ldc_log_pb (LDLPCONS,
                                    LDLPPROC,
                                    LDLPUSER,
                                    LDLPTERM,
                                    LDLPFECH,
                                    LDLPINFO)
                 VALUES (inuCons,
                         isbProc,
                         sbUser,
                         sbSession,
                         idtFech,
                         isbInfo);
        ELSE
            -- Obtiene Datos
            SELECT LDLPINFO
            INTO sbInfoAux
            FROM ldc_log_pb
            WHERE LDLPCONS = inuCons;

            -- Actualiza Datos
            UPDATE ldc_log_pb
            SET LDLPINFO = LDLPINFO || ' ' || isbInfo
            WHERE LDLPCONS = inuCons;
        END IF;

        COMMIT;
        
        pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbFIN); 
                
    END ProcessLog;
    
    PROCEDURE prcCerraCursorDiferidos
    IS
        csbMetodo2        CONSTANT VARCHAR2(70) := csbMetodo || '.prcCerraCursorDiferidos';
        nuError2         NUMBER;
        sbError2         VARCHAR2(4000);             
    BEGIN

        pkg_traza.trace(csbMetodo2, csbNivelTraza, pkg_traza.csbINICIO); 
            
        IF cuDiferidos%ISOPEN
        THEN
            CLOSE cuDiferidos;
        END IF;

        pkg_traza.trace(csbMetodo2, csbNivelTraza, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError2,sbError2);        
            pkg_traza.trace('sbError2 => ' || sbError2, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError2,sbError2);
            pkg_traza.trace('sbError2 => ' || sbError2, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;         
    END prcCerraCursorDiferidos;

BEGIN
    
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO); 
        
    pkg_Traza.Trace ('INICIO LDC_BcChangeQuotaValue.prRecalculateQuotaValue',10);
    sbFECHA_PROCESO :=
        ut_string.getparametervalue (sbParametros,
                                     'FECHA_PROCESO',
                                     '|',
                                     '=');
    dtExecDate := TO_DATE (sbFECHA_PROCESO, LDC_BOConsGenerales.fsbGetFormatoFecha);
    sbRecipients := pkg_BCLD_Parameter.fsbObtieneValorCadena ('FUNC_ACT_CFMV');

    nuLdlpcons := NULL;

    ProcessLog (nuLdlpcons,
                'PBRCD',
                SYSDATE,
                'Inicia el proceso ' || dtExecDate);

    nuLdlpcons := NULL;

    FOR rgLDC_CONFTAIN IN cuLDC_CONFTAIN (dtSysdate)
    LOOP
        SELECT COUNT (1)
          INTO nuCantidad
          FROM diferido
         WHERE     DIFESAPE > 0
               AND DIFEINTE <> 0
               AND DIFETAIN = rgLDC_CONFTAIN.COTITAIN;

        sbMessage0 :=
               'Se procesaran '
            || nuCantidad
            || ' productos el tipo de tasa '
            || rgLDC_CONFTAIN.COTITAIN;

        ProcessLog (nuLdlpcons,
                    'PBRCD',
                    SYSDATE,
                    sbMessage0);

        nuLdlpcons := NULL;

        nuCotitain := rgLDC_CONFTAIN.cotitain;
        nuPorc := rgLDC_CONFTAIN.cotiporc;

        OPEN cuDiferidos (rgLDC_CONFTAIN.cotitain);

        LOOP
            FETCH cuDiferidos BULK COLLECT INTO tblDiferido LIMIT limit_in;

            --Condicion de salida
            FOR indx IN 1 .. tblDiferido.COUNT
            LOOP
                --Procesamiento a realizar
                rgDiferido := tblDiferido (indx);

                nudiferido := rgDiferido.idDiferido;
                --Validar si la suscripcion asociada al diferido esta en
                --proceso de facturacion
                pkg_Traza.Trace('Proceso Facturación => '||pkg_BCContrato.fnuCodigoProcFacturacion(rgDiferido.nuSuscripcion));
                pkg_Traza.Trace('Contrato => '||rgDiferido.nuSuscripcion);
                IF pkg_BCContrato.fnuCodigoProcFacturacion(rgDiferido.nuSuscripcion) >
                   0
                THEN
                    --Enviar notificacion

                    sbSubject :=
                           'ERROR EN EL PROCESO DE ACTUALIZACION DE LA CUOTA MENSUAL DE LOS DIFERIDOS'
                        || dtExecDate;
                    sbMessage0 :=
                        'Durante la ejecucion del proceso se detecto que al menos uno de los productos se encuentra en proceso de facturacion.';
                    ProcessLog (nuLdlpcons,
                                'PBRCD',
                                SYSDATE,
                                sbSubject || ' ' || sbMessage0);

                    --Enviar correo
                    pkg_Correo.prcEnviaCorreo (
                        isbDestinatarios   => sbRecipients,
                        isbAsunto          => sbSubject,
                        isbMensaje         => sbMessage0);

                    --Detener proceso
                    pkg_error.setErrorMessage( isbMsgErrr => sbMessage0);
                ELSE
                    --Obtiene el porcentaje de interes nominal
                    --Obtener el metodo de calculo asociado al diferido
                    nuMethod :=
                        pktbldiferido.fnugetDIFEMECA (rgDiferido.idDiferido);
                    --Obtener el interes pactado
                    nuTasaInte :=
                        pktbldiferido.fnugetDIFETAIN (rgDiferido.idDiferido);
                    --Obtener tasa de interes efectivo anual
                    nuInteresPorc :=
                        pktbldiferido.fnugetdifeinte (rgDiferido.idDiferido);
                    --Obtener el factor gradiente
                    nuFactor :=
                        pktbldiferido.fnugetdifefagr (rgDiferido.idDiferido);
                    --Obtener el Spread
                    nuSpread :=
                        pktbldiferido.fnugetDIFESPRE (rgDiferido.idDiferido);

                    --OSF 345 - Logica para procesar tasas del parametro LDC_TASAS_PBRCD
                    IF (rgLDC_CONFTAIN.cotitain =
                        pktblparametr.fnugetvaluenumber ('BIL_TASA_USURA'))
                    THEN
                        --Validar el metodo antes de obtener el % interes
                        IF INSTR (
                               pkg_BCLD_Parameter.fsbObtieneValorCadena (
                                   'ID_MECADIFE'),
                               TO_CHAR (nuMethod)) >
                           0
                        THEN
                            --Validar si el % de interes pactado sobrepasa el % de usura
                            IF nuInteresPorc > rgLDC_CONFTAIN.cotiporc
                            THEN
                                nuInteresPorc := rgLDC_CONFTAIN.cotiporc;
                                sbProcesar := 'S';
                            ELSE
                                sbProcesar := 'N';
                            END IF;
                        ELSE
                            nuInteresPorc := rgLDC_CONFTAIN.cotiporc;
                            sbProcesar := 'S';
                        END IF;
                    ELSE
                        OPEN cuTasasPBRCD (rgLDC_CONFTAIN.cotitain);

                        FETCH cuTasasPBRCD INTO nuTasaValida;

                        CLOSE cuTasasPBRCD;

                        IF (nuTasaValida IS NOT NULL)
                        THEN
                            nuInteresPorc := rgLDC_CONFTAIN.cotiporc;
                            sbProcesar := 'S';
                        END IF;
                    END IF;

                    IF sbProcesar = 'S'
                    THEN
                        nuCount := nuCount + 1;
                        nuCountTasa := nuCountTasa + 1;
                        --Calcula el interes nominal
                        pkDeferredMgr.ValInterestSpread (nuMethod, -- Metodo de Calculo
                                                         nuInteresPorc, -- Porcentaje de Interes (Efectivo Anual)
                                                         nuSpread,   -- Spread
                                                         nuNominalPerc -- Interes Nominal (Salida)
                                                                      );

                        -- Obtiene el valor de la cuota
                        pkDeferredMgr.CalculatePayment (
                            pktbldiferido.fnugetdifesape (
                                rgDiferido.idDiferido), -- Saldo a Diferir (difesape)
                            (  pktbldiferido.fnugetDIFENUCU (
                                   rgDiferido.idDiferido)
                             - pktbldiferido.fnugetdifecupa (
                                   rgDiferido.idDiferido)), -- Numero de Cuotas  diferido
                            nuNominalPerc,                  -- Interes Nominal
                            nuMethod,                     -- Metodo de Calculo
                            nuFactor,       --nuSpread,              -- Spread
                            nuInteresPorc + nuSpread, -- Interes Efectivo mas Spread
                            nuQuotaValue         -- Valor de la Cuota (Salida)
                                        );
                        --  Obtiene el factor de redondeo para la suscripcion
                        FA_BOPoliticaRedondeo.ObtFactorRedondeo (
                            rgDiferido.nuSuscripcion,
                            nuRoundFactor,
                            inuIdCompany);

                        pkg_Traza.Trace (
                               'Ingraso al proceso de recalcular valor diferido del metodo '
                            || nuMethod);

                        OPEN CUPLANDIFE (
                            pktbldiferido.fnugetdifepldi (
                                rgDiferido.idDiferido),
                            nuMethod);

                        FETCH CUPLANDIFE INTO TEMPCUPLANDIFE;

                        IF CUPLANDIFE%FOUND
                        THEN

                            NUFactorGradiante := TEMPCUPLANDIFE.PLDIFAGR;
                            pkg_Traza.Trace (
                                   'Factor Gradiante --> '
                                || NUFactorGradiante);
                            NUNumeroCuotas :=
                                pktbldiferido.FNUGETDIFECUPA (
                                    rgDiferido.idDiferido);
                            --NUNumeroCuotas := 3;
                            pkg_Traza.Trace (
                                'Numero cuotas --> ' || NUNumeroCuotas);

                            NUCuotaCalculada :=
                                POWER ((1 + (NUFactorGradiante / 100)),
                                       NUNumeroCuotas);

                            NuevoQuotaValue :=
                                nuQuotaValue / NUCuotaCalculada;

                            pkg_Traza.Trace (
                                   'Valor anterior ['
                                || nuQuotaValue
                                || '] - Nuevo Valor ['
                                || NuevoQuotaValue
                                || ']');

                            nuQuotaValue := NuevoQuotaValue;
                        END IF;

                        CLOSE CUPLANDIFE;

                        --  Aplica politica de redondeo al valor de la cuota
                        nuQuotaValue := ROUND (nuQuotaValue, nuRoundFactor);

                        --Actualizar el valor de la cuota en el diferido
                        pktbldiferido.upddifevacu (rgDiferido.idDiferido,
                                                   nuQuotaValue);

                        --OSF-252
                        pktbldiferido.upddifeinte (rgDiferido.idDiferido,
                                                   rgLDC_CONFTAIN.cotiporc);
                    END IF;

                    sbProcesar := 'S';
                END IF;
            END LOOP;

            EXIT WHEN tblDiferido.COUNT < limit_in;
        END LOOP;

        --cerramos el cursor
        prcCerraCursorDiferidos;

        sbMessage0 :=
               'Se procesaron '
            || nuCountTasa
            || ' productos el tipo de tasa '
            || rgLDC_CONFTAIN.COTITAIN;

        ProcessLog (nuLdlpcons,
                    'PBRCD',
                    SYSDATE,
                    sbMessage0);

        nuLdlpcons := NULL;

        nuCountTasa := 0;

        --Marcar el registro de LDC_CONFTAIN como procesado (Flag y fecha de proceso)
        UPDATE LDC_CONFTAIN
        SET FLAG = 'S', FECHA_PROCESAMIENTO = dtExecDate
        WHERE     COTITAIN = rgLDC_CONFTAIN.cotitain
               AND COTIFEIN = rgLDC_CONFTAIN.COTIFEIN;

        sbMessage1 :=
               sbMessage1
            || 'El proceso de actualizacion de diferidos termino. Se actualizaron los diferidos asociados a la tasa '
            || nuCotitain
            || ' - '
            || pktbltasainte.fsbgetdescription (nuCotitain)
            || ' con porcentaje vigente de '
            || nuPorc
            || '%. Por favor verifique los resultados [Se actualizaron '
            || nuCount
            || ' registros].'
            || '<br>';

        nuCountTotal := nuCountTotal + nuCount;
        nuCount := 0;
    END LOOP;

    pkg_Traza.Trace ('');

    prcCerraCursorDiferidos;

    COMMIT;
    sbSubject :=
        'ACTUALIZACION DE LA CUOTA MENSUAL DE LOS DIFERIDOS' || dtExecDate;

    ProcessLog (nuLdlpcons,
                'PBRCD',
                SYSDATE,
                sbSubject);

    nuLdlpcons := NULL;

    IF (nuCountTotal > 0)
    THEN
        sbMessage0 := sbMessage1;
    ELSE
        sbMessage0 :=
            'El proceso de actualizacion de diferidos termino. No se actualizaron registros ya que no se encontro ningun registro de tasa sin procesar.';
    END IF;

    ProcessLog (nuLdlpcons,
                'PBRCD',
                SYSDATE,
                sbMessage0);

    nuLdlpcons := NULL;

    pkg_Correo.prcEnviaCorreo (isbDestinatarios   => sbRecipients,
                               isbAsunto          => sbSubject,
                               isbMensaje         => sbMessage0);

    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 
    
EXCEPTION
    WHEN pkg_Error.CONTROLLED_ERROR
    THEN
        ROLLBACK;
        prcCerraCursorDiferidos;
        pkg_Error.getError(nuError, sbError);
        pkg_traza.trace('sbError: ' || sbError||' Diferido Error :'||nudiferido, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
        RAISE pkg_Error.Controlled_Error;
    WHEN OTHERS
    THEN
        ROLLBACK;
        prcCerraCursorDiferidos;
        sbSubject :=
               'ERROR EN EL PROCESO DE ACTUALIZACION DE LA CUOTA MENSUAL DE LOS DIFERIDOS'
            || dtExecDate;
        sbMessage0 :=
               'Durante la ejecucion del proceso se presento un error no controlado ['
            || SQLCODE
            || ' - '
            || SQLERRM
            || ']. Por favor contacte al Administrador.';
        ProcessLog (nuLdlpcons,
                    'PBRCD',
                    SYSDATE,
                    sbSubject);

        ProcessLog (nuLdlpcons,
                    'PBRCD',
                    SYSDATE,
                    sbMessage0||' Diferido Error :'||nudiferido);
        nuLdlpcons := NULL;
        
        pkg_Correo.prcEnviaCorreo (isbDestinatarios   => sbRecipients,
                               isbAsunto          => sbSubject,
                               isbMensaje         => sbMessage0);

        pkg_Error.setError;
        pkg_Error.getError(nuError, sbError);
        pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
        RAISE pkg_Error.Controlled_Error;   
END PBRCD;
/