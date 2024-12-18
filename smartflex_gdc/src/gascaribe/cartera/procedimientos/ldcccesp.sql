CREATE OR REPLACE PROCEDURE LDCCCESP
(
    inuProgramacion   IN ge_process_schedule.process_schedule_id%TYPE
)
IS

    /*
        Propiedad intelectual de Gases del Caribe. (rgDeudaxConcepto).

        Procedimiento     : LDCCCESP

        Descripcion : Recorre los usuarios de cartera especial y envia mail segun parametrizacion


        Parametros  :       Descripcion

        Retorno     :

        Autor       : HORBATH TECHNOLOGIES.
        Fecha       : 20-11-2018

        Historia de Modificaciones
        Fecha           Autor       IDEntrega   Descripcion
        16-11-2018      Horbath     200-2241    Creacion
        19-01-2019                              MODIFICACION PARA MANEJAR MAILS SEPARADOS 
                                                POR COMAS EN EL PARAMETRO
        02-04-2024      jpinedc     OSF-2378    Se implementan Ãºltimas directrices de programaciÃ³n
    */

    csbMetodo        CONSTANT VARCHAR2(70) :=  'LDCCCESP';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
    
    nuHilos                  NUMBER := 1;
    nuLogProceso             ge_log_process.log_process_id%TYPE;
    sbParametros             ge_process_schedule.parameters_%TYPE;
    sbmenserror              VARCHAR2 (4000);

    CURSOR cuprin IS 
    SELECT ROWID, CODIGO_PRODUCTO 
    FROM LDC_USUCARTERAESP;

    CURSOR CUNOTIFI IS
    SELECT numservicio codigo_producto 
    FROM ldc_notificacartesp;

    CURSOR cuDeudaxConcepto IS
    SELECT *
    FROM ldc_deudaxconceptoce
    ORDER BY conse;

    flArchivo                pkg_gestionArchivos.styArchivo;
    sbNombArchivo            VARCHAR2 (200) := 'estacuentausucartesp.txt';
    onuError                 NUMBER;
    sbRuta                   ld_parameter.value_chain%TYPE;
    sbDestinatarios             ld_parameter.value_chain%TYPE;
    sbAsunto                VARCHAR2 (200);
    sbMensaje               VARCHAR2 (3000);                          --clob;
    sbMessage1               VARCHAR2 (3000);
    nucurrentaccounttotal    NUMBER;                         -- Variable Dummy
    nudeferredaccounttotal   NUMBER;                         -- Variable Dummy
    nucreditbalance          NUMBER;                         -- Variable Dummy
    nuclaimvalue             NUMBER;                         -- Variable Dummy
    nudefclaimvalue          NUMBER;                         -- Variable Dummy
    otbBalanceAccounts       fa_boaccountstatustodate.tytbBalanceAccounts;
    otbDeferredBalance       fa_boaccountstatustodate.tytbDeferredBalance;
    pos                      VARCHAR2 (1000);
    sbDescripcionConce       concepto.concdesc%TYPE;
    nuvalorconc              NUMBER;
    nuCantldcDeudaxConceptoCE                        NUMBER;
    nuconcepto               concepto.conccodi%TYPE;
    nuvalorvenc              NUMBER;
    nuvalornove              NUMBER;
    inicial                  BOOLEAN;
    nuProdAnterior                      NUMBER;
    nudiasvenci              NUMBER;
    nuSumVencido               NUMBER;
    nuSumActual                NUMBER;
    nuSumDiferido              NUMBER;
    sbpropietario            VARCHAR2 (1000);
    
    nuError                 NUMBER;
    sbError                 VARCHAR2(4000);
    
    CURSOR cuCantldcDeudaxConceptoCE
    (
        inuProducto NUMBER,
        inuConcepto NUMBER
    )
    IS
    SELECT COUNT (1)
    FROM ldc_deudaxconceptoce
    WHERE usuario = inuProducto 
    AND concepto = inuConcepto;
    
    CURSOR cuConcDesc
    (
        inuConcepto NUMBER
    )
    IS
    SELECT concdesc
    FROM concepto
    WHERE conccodi = inuConcepto;

    CURSOR cuTotldcDeudaxConceptoCE
    (
        inuProducto NUMBER
    )
    IS
    SELECT SUM (NVL (vencido, 0)),
        SUM (NVL (actual, 0)),
        SUM (NVL (diferido, 0))
    FROM ldc_deudaxconceptoce
    WHERE usuario = inuProducto;
    
    CURSOR cuLDC_USUCARTERAESP( inuProducto NUMBER)
    IS
    SELECT propietario_propietario
    FROM LDC_USUCARTERAESP
    WHERE codigo_producto = inuProducto;
    
    sbRemitente     ld_parameter.value_chain%TYPE;
    
    csbFormatoValorPesos    CONSTANT VARCHAR2(20) := '999G999G999G999G990';        
    
BEGIN

    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
    
    ge_boschedule.AddLogToScheduleProcess (inuProgramacion,
                                           nuHilos,
                                           nuLogProceso);

    sbParametros := open.dage_process_schedule.fsbgetparameters_ (inuProgramacion);

    EXECUTE IMMEDIATE ('truncate table ldc_deudaxconceptoce drop storage');

    EXECUTE IMMEDIATE ('truncate table ldc_notificacartesp drop storage');

    pkg_traza.trace ('entre', csbNivelTraza );

    FOR p IN cuprin
    LOOP
        UPDATE LDC_USUCARTERAESP
           SET DIRECCION =
                   LDC_PKCALCDATCARTESP.FNC_DIRECCION (p.CODIGO_PRODUCTO),
               CARTERA_FECHA =
                   LDC_PKCALCDATCARTESP.FNC_CARTERA_FECHA (p.CODIGO_PRODUCTO),
               EDAD_MORA =
                   LDC_PKCALCDATCARTESP.FNC_EDAD_MORA (p.CODIGO_PRODUCTO),
               NO_FACTURAS_DEUDA =
                   LDC_PKCALCDATCARTESP.FNC_NO_FACTURAS_DEUDA (
                       p.CODIGO_PRODUCTO),
               VALOR_CONSUMO =
                   LDC_PKCALCDATCARTESP.FNC_VALOR_CONSUMO (p.CODIGO_PRODUCTO),
               M3_DEUDA =
                   LDC_PKCALCDATCARTESP.FNC_M3_DEUDA (p.CODIGO_PRODUCTO),
               CONSUMO_PROMEDIO_M3 =
                   LDC_PKCALCDATCARTESP.FNC_CONSUMO_PROMEDIO_M3 (
                       p.CODIGO_PRODUCTO),
               VALOR_PROMEDIO_FACTURA =
                   LDC_PKCALCDATCARTESP.FNC_VALOR_PROMEDIO_FACTURA (
                       p.CODIGO_PRODUCTO),
               FECH_VENC_ULT_FACT =
                   LDC_PKCALCDATCARTESP.FNC_FECH_VENC_ULT_FACT (
                       p.CODIGO_PRODUCTO),
               VECES_MORA_ANO =
                   LDC_PKCALCDATCARTESP.FNC_VECES_MORA_ANO (
                       p.CODIGO_PRODUCTO),
               ESTADO_PRODUCTO =
                   LDC_PKCALCDATCARTESP.FNC_ESTADO_PRODUCTO (
                       p.CODIGO_PRODUCTO),
               FECHA_SUSPENSION =
                   LDC_PKCALCDATCARTESP.FNC_FECHA_SUSPENSION (
                       p.CODIGO_PRODUCTO),
               HACE_SUSPENDIDO =
                   LDC_PKCALCDATCARTESP.FNC_HACE_SUSPENDIDO (
                       p.CODIGO_PRODUCTO),
               VIOLA_SERVICIO =
                   LDC_PKCALCDATCARTESP.FNC_VIOLA_SERVICIO (
                       p.CODIGO_PRODUCTO),
               VALOR_RECLAMO =
                   LDC_PKCALCDATCARTESP.FNC_VALOR_RECLAMO (p.CODIGO_PRODUCTO),
               FECHA_RECLAMO =
                   LDC_PKCALCDATCARTESP.FNC_FECHA_RECLAMO (p.CODIGO_PRODUCTO),
               DETALLE_RECLAMO =
                   LDC_PKCALCDATCARTESP.FNC_DETALLE_RECLAMO (
                       p.CODIGO_PRODUCTO),
               PROMEDIO_PAGOS =
                   LDC_PKCALCDATCARTESP.FNC_PROMEDIO_PAGOS (
                       p.CODIGO_PRODUCTO),
               FECHA_PAGO =
                   LDC_PKCALCDATCARTESP.FNC_FECHA_PAGO (p.CODIGO_PRODUCTO),
               DIAS_PAGO_FACTURA =
                   LDC_PKCALCDATCARTESP.FNC_DIAS_PAGO_FACTURA (
                       p.CODIGO_PRODUCTO),
               REFINANCIACION_ACTIVA =
                   LDC_PKCALCDATCARTESP.FNC_REFINANCIACION_ACTIVA (
                       p.CODIGO_PRODUCTO),
               FECHA_REFINANCIACION =
                   LDC_PKCALCDATCARTESP.FNC_FECHA_REFINANCIACION (
                       p.CODIGO_PRODUCTO)
         WHERE ROWID = P.ROWID;

        COMMIT;
        pkg_traza.trace ( 'actualice ===>' || TO_CHAR (p.codigo_producto), csbNivelTraza);
    END LOOP;

    sbRuta :=
        pkg_BCLD_Parameter.fsbObtieneValorCadena ('RUTACONTROLCARTERAESPECIAL');

    IF sbRuta IS NULL
    THEN
        pkg_error.setErrorMessage
        ( 
            isbMsgErrr =>  'No se ha configurado el tipo cadena del parÃ¡metro RUTACONTROLCARTERAESPECIAL'
        );
    END IF;

    sbRemitente :=
        pkg_BCLD_Parameter.fsbObtieneValorCadena ('LDC_SMTP_SENDER');
        
    IF sbRemitente IS NULL
    THEN
        pkg_error.setErrorMessage
        ( 
            isbMsgErrr => 'No se ha configurado el valor tipo cadena del parÃ¡metro LDC_SMTP_SENDER'
        );
    END IF;        
    
    sbDestinatarios :=
        pkg_BCLD_Parameter.fsbObtieneValorCadena ('PARMAILINTECARESP');
        

    IF sbDestinatarios IS NULL
    THEN
        pkg_error.setErrorMessage
        ( 
            isbMsgErrr => 'No se ha configurado el valor tipo cadena del parÃ¡metro PARMAILINTECARESP'
        );
    END IF;

    pkg_traza.trace ('el mail va dirigidio a ====>' || sbDestinatarios, csbNivelTraza);
    flArchivo := pkg_gestionArchivos.ftAbrirArchivo_SMF (sbRuta, sbNombArchivo, 'w');
    sbAsunto :=
           'PRODUCTOS EN SEGUIMIENTO DE CONTROL DE CARTERA CON MODIFICACIONES '
        || TO_CHAR (SYSDATE, 'YYYY/MM/DD');
    sbMensaje :=
           'Cordial saludo. Los productos adjuntos a este mensaje se les presenta estado de cuenta actualizado.'
        || CHR (10)
        || CHR (13);
    pkg_traza.trace ('voy a recorrer a quienes hay que notificar', csbNivelTraza);

    FOR n IN cunotifi
    LOOP
        -- trae el estado de cuenta por ceon
        api_GeneraEstadoCuentaxFecha (
            n.codigo_producto,
            SYSDATE,
            nucurrentaccounttotal,
            nudeferredaccounttotal,
            nucreditbalance,
            nuclaimvalue,
            nudefclaimvalue,
            otbBalanceAccounts,
            otbDeferredBalance);
            
        pkg_traza.trace ('determino estado de cuenta ===>' || TO_CHAR (n.codigo_producto), csbNivelTraza);
        
        pos := otbBalanceAccounts.FIRST;

        WHILE pos IS NOT NULL
        LOOP
            nuconcepto := otbBalanceAccounts (pos).conccodi;
            nuvalorconc := otbBalanceAccounts (pos).saldvalo;
            nudiasvenci := NVL (otbBalanceAccounts (pos).cucodive, 0);

            IF nudiasvenci <= 0
            THEN
                nuvalornove := nuvalorconc;
                nuvalorvenc := 0;
            ELSE
                nuvalorvenc := nuvalorconc;
                nuvalornove := 0;
            END IF;

            OPEN cuCantldcDeudaxConceptoCE ( n.codigo_producto, nuconcepto);
            FETCH cuCantldcDeudaxConceptoCE INTO nuCantldcDeudaxConceptoCE;
            CLOSE cuCantldcDeudaxConceptoCE;

            IF nuCantldcDeudaxConceptoCE = 0
            THEN

                OPEN cuConcDesc( nuconcepto);
                FETCH cuConcDesc INTO sbDescripcionConce;
                CLOSE cuConcDesc;
                
                INSERT INTO ldc_deudaxconceptoce 
                (
                    conse,
                    usuario,
                    concepto,
                    descripcion,
                    vencido,
                    actual,
                    diferido
                )
                VALUES 
                (
                    LDC_SEQUSUCARTERACONCESP.NEXTVAL,
                    n.codigo_producto,
                    nuconcepto,
                    sbDescripcionConce,
                    NVL (nuvalorvenc, 0),
                    NVL (nuvalornove, 0),
                    0
                );

                COMMIT;
            ELSE
            
                UPDATE ldc_deudaxconceptoce
                SET vencido = NVL (vencido, 0) + NVL (nuvalorvenc, 0),
                actual = NVL (actual, 0) + NVL (nuvalornove, 0)
                WHERE usuario = n.codigo_producto AND concepto = nuconcepto;

                COMMIT;
            END IF;

            pos := otbBalanceAccounts.NEXT (pos);
        END LOOP;

        -- Conceptos cartera diferida
        pos := otbDeferredBalance.FIRST;

        WHILE pos IS NOT NULL
        LOOP
            nuconcepto := otbDeferredBalance (pos).conccodi;
            nuvalorconc := otbDeferredBalance (pos).saldvalo;
            pos := otbDeferredBalance.NEXT (pos);

            OPEN cuCantldcDeudaxConceptoCE ( n.codigo_producto, nuconcepto);
            FETCH cuCantldcDeudaxConceptoCE INTO nuCantldcDeudaxConceptoCE;
            CLOSE cuCantldcDeudaxConceptoCE;

            IF nuCantldcDeudaxConceptoCE = 0
            THEN
            
                OPEN cuConcDesc( nuconcepto );
                FETCH cuConcDesc INTO sbDescripcionConce;
                CLOSE cuConcDesc;
                
                INSERT INTO ldc_deudaxconceptoce (conse,
                                                  usuario,
                                                  concepto,
                                                  descripcion,
                                                  vencido,
                                                  actual,
                                                  diferido)
                     VALUES (LDC_SEQUSUCARTERACONCESP.NEXTVAL,
                             n.codigo_producto,
                             nuconcepto,
                             sbDescripcionConce,
                             0,
                             0,
                             NVL (nuvalorconc, 0));

                COMMIT;
            ELSE
                UPDATE ldc_deudaxconceptoce
                   SET diferido = NVL (diferido, 0) + NVL (nuvalorconc, 0)
                 WHERE usuario = n.codigo_producto AND concepto = nuconcepto;

                COMMIT;
            END IF;
        END LOOP;

        pkg_traza.trace ( 'lleno tabla  estado de cuenta ===>' || TO_CHAR (n.codigo_producto), csbNivelTraza);
    END LOOP;

    nuProdAnterior := 0;
    inicial := TRUE;
    pkg_traza.trace ('voy a recorrer tabla esado de cuenta', csbNivelTraza);

    FOR rgDeudaxConcepto IN cuDeudaxConcepto
    LOOP
        IF nuProdAnterior <> rgDeudaxConcepto.usuario
        THEN
            IF NOT INICIAL
            THEN

                OPEN cuTotLdcDeudaxConceptoCE( nuProdAnterior );
                FETCH cuTotLdcDeudaxConceptoCE INTO nuSumVencido, nuSumActual, nuSumDiferido;
                CLOSE cuTotLdcDeudaxConceptoCE;

                sbmessage1 := RPAD ('=', 100, '=');
                pkg_gestionArchivos.prcEscribirLinea_SMF (flArchivo, sbMessage1);
                pkg_traza.trace (sbmessage1, csbNivelTraza);
                sbmessage1 :=
                       LPAD ('TOTALES', 40, ' ')
                    || LPAD (TO_CHAR (nuSumVencido, csbFormatoValorPesos),
                             20,
                             ' ')
                    || LPAD (TO_CHAR (nuSumActual, csbFormatoValorPesos),
                             20,
                             ' ')
                    || LPAD (TO_CHAR (nuSumDiferido, csbFormatoValorPesos),
                             20,
                             ' ');
                pkg_gestionArchivos.prcEscribirLinea_SMF (flArchivo, sbMessage1);
                pkg_gestionArchivos.prcEscribirLinea_SMF (flArchivo, '');
                pkg_traza.trace (sbmessage1, csbNivelTraza);
            END IF;

            inicial := TRUE;

            IF inicial
            THEN

                OPEN cuLDC_USUCARTERAESP( rgDeudaxConcepto.usuario );
                FETCH cuLDC_USUCARTERAESP INTO sbpropietario;
                CLOSE cuLDC_USUCARTERAESP;

                sbmessage1 :=
                       'ESTADO DE CUENTA DEL SERVICIO SUSCRITO : '
                    || TO_CHAR (rgDeudaxConcepto.usuario)
                    || ' - '
                    || sbpropietario;
                pkg_gestionArchivos.prcEscribirLinea_SMF (flArchivo, sbMessage1);
                pkg_gestionArchivos.prcEscribirLinea_SMF (flArchivo, '');
                pkg_traza.trace (sbmessage1, csbNivelTraza);
                sbmessage1 :=
                       LPAD ('CONCEPTO', 40, ' ')
                    || LPAD ('VENCIDO', 20, ' ')
                    || LPAD ('ACTUAL', 20, ' ')
                    || LPAD ('DIFERIDO', 20, ' ');
                pkg_gestionArchivos.prcEscribirLinea_SMF (flArchivo, sbMessage1);
                pkg_traza.trace (sbmessage1, csbNivelTraza);
                sbmessage1 := RPAD ('-', 100, '-');
                pkg_gestionArchivos.prcEscribirLinea_SMF (flArchivo, sbMessage1);
                pkg_gestionArchivos.prcEscribirLinea_SMF (flArchivo, '');
                pkg_traza.trace (sbmessage1, csbNivelTraza);
                inicial := FALSE;
            END IF;
        END IF;

        sbmessage1 :=
               RPAD (TO_CHAR (rgDeudaxConcepto.concepto) || '-' || rgDeudaxConcepto.DESCRIPCION, 40, ' ')
            || LPAD (TO_CHAR (rgDeudaxConcepto.VENCIDO, csbFormatoValorPesos), 20, ' ')
            || LPAD (TO_CHAR (rgDeudaxConcepto.actual, csbFormatoValorPesos), 20, ' ')
            || LPAD (TO_CHAR (rgDeudaxConcepto.diferido, csbFormatoValorPesos), 20, ' ');
        pkg_gestionArchivos.prcEscribirLinea_SMF (flArchivo, sbMessage1);
        pkg_traza.trace (sbmessage1, csbNivelTraza);
        nuProdAnterior := rgDeudaxConcepto.USUARIO;
    END LOOP;

    IF NOT INICIAL
    THEN
    
        OPEN cuTotLdcDeudaxConceptoCE( nuProdAnterior );
        FETCH cuTotLdcDeudaxConceptoCE INTO nuSumVencido, nuSumActual, nuSumDiferido;
        CLOSE cuTotLdcDeudaxConceptoCE;

        sbmessage1 := RPAD ('=', 100, '=');
        pkg_gestionArchivos.prcEscribirLinea_SMF (flArchivo, sbMessage1);
        pkg_traza.trace (sbmessage1, csbNivelTraza);
        sbmessage1 :=
               LPAD ('TOTALES', 40, ' ')
            || LPAD (TO_CHAR (nuSumVencido, csbFormatoValorPesos), 20, ' ')
            || LPAD (TO_CHAR (nuSumActual, csbFormatoValorPesos), 20, ' ')
            || LPAD (TO_CHAR (nuSumDiferido, csbFormatoValorPesos), 20, ' ');
        pkg_gestionArchivos.prcEscribirLinea_SMF (flArchivo, sbMessage1);
        pkg_traza.trace (sbmessage1, csbNivelTraza);
    END IF;

    pkg_gestionArchivos.prcEscribirLinea_SMF (flArchivo, '     ');
    pkg_gestionArchivos.prcCerrarArchivo_SMF (flArchivo);
    pkg_traza.trace ('cerre archivo', csbNivelTraza);

    pkg_Correo.prcEnviaCorreo
    (
        isbRemitente        => sbRemitente,
        isbDestinatarios    => sbDestinatarios,
        isbAsunto           => sbAsunto,
        isbMensaje          => sbMensaje,
        isbDestinatariosCC  => NULL,
        isbDestinatariosBCC => NULL,
        isbArchivos         => sbRuta || '/' || sbNombArchivo
    );
    
    pkg_traza.trace ('mande mail a ' || sbDestinatarios, csbNivelTraza);

    GE_BOSCHEDULE.CHANGELOGPROCESSSTATUS (NULOGPROCESO, 'F');

    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 
        
EXCEPTION
    WHEN pkg_Error.CONTROLLED_ERROR
    THEN
        pkg_Error.getError(nuError,sbError);
        pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
        GE_BOSCHEDULE.CHANGELOGPROCESSSTATUS (NULOGPROCESO, 'F');
        RAISE;
    WHEN OTHERS
    THEN
        pkg_Error.SetError;
        pkg_Error.getError(nuError,sbError);
        pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
        GE_BOSCHEDULE.CHANGELOGPROCESSSTATUS (NULOGPROCESO, 'F');
        sbmenserror := 'Error no controlado ' || sbError;
        ROLLBACK;
        pkg_error.setErrorMessage( isbMsgErrr => sbmenserror );
END LDCCCESP;
/