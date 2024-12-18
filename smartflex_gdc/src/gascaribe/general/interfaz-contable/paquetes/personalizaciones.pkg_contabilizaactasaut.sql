CREATE OR REPLACE PACKAGE personalizaciones.pkg_ContabilizaActasAut
IS
/*
    Propiedad intelectual de Gases del Caribe

    Unidad:       pkg_ContabilizaActasAut
    Descripcion:  Paquete contenedor de los procedimientos usados para
                  la contabilizacion automatica de actas brilla FNB

    Autor:        German Dario Guevara Alzate - GlobaMVM
    Fecha:        04/04/2024

    Historial de Modificaciones
    --------------------------------------------------------------
    Fecha       Autor         Modificación
    --------------------------------------------------------------
    04/04/2024  GDGuevara     Creación: Caso OSF-2174
    09/04/2024  GDGuevara     Ajustes producto de la validacion tecnica
*/

    -- Procesa contabilizacion para SAP
    PROCEDURE prProcesaActasFNB_Sap
    (
        idtFecIni    IN DATE DEFAULT NULL,
        idtFecFin    IN DATE DEFAULT NULL
    );
    -- Reversa hechos economicos
    PROCEDURE prReversaHE_ActasFNB
    (
        idtFecIni    IN DATE DEFAULT NULL,
        idtFecFin    IN DATE DEFAULT NULL
    );
    -- Reversa registros contables
    PROCEDURE prReversaRC_ActasFNB
    (
        idtFecIni    IN DATE DEFAULT NULL,
        idtFecFin    IN DATE DEFAULT NULL
    );
END pkg_ContabilizaActasAut;
/

CREATE OR REPLACE PACKAGE BODY personalizaciones.pkg_ContabilizaActasAut
IS
    -- Identificador del ultimo caso que hizo cambios
    csbVersion          CONSTANT VARCHAR2(20) := 'OSF-2174_20240404';

    -- Constantes para el control de la traza
    csbMetodo           CONSTANT VARCHAR2(32) := $$PLSQL_UNIT;             -- Constante para nombre de función
    csbNivelTraza       CONSTANT NUMBER(2)    := pkg_traza.cnuNivelTrzDef; -- Nivel de traza para esta función.
    csbInicio           CONSTANT VARCHAR2(4)  := pkg_traza.fsbINICIO;      -- Indica inicio de método
    csbFin              CONSTANT VARCHAR2(4)  := pkg_traza.fsbFIN;         -- Indica Fin de método ok
    csbFin_Erc          CONSTANT VARCHAR2(4)  := pkg_traza.fsbFIN_ERC;     -- Indica fin de método con error controlado
    csbFin_Err          CONSTANT VARCHAR2(4)  := pkg_traza.fsbFIN_ERR;     -- Indica fin de método con error no controlado

    cnu1Seg             CONSTANT NUMBER       := 1/86400;                  -- Un segundo
    cdtNextProg         CONSTANT DATE         := sysdate + 1/24/60;        -- Proxima programacion de la tarea en ICBGHE y ICBGRC en un minuto

    PROCEDURE ValidaDatosRev
    (
        isbNameExecutable       IN VARCHAR2,
        idtFecIni               IN DATE,
        idtFecFin               IN DATE,
        odtFechaIni             OUT DATE,
        odtFechaFin             OUT DATE,
        onuScheduleProcessAux   OUT NUMBER,
        onuExecutable           OUT NUMBER,
        onuError                OUT NUMBER,
        osbError                OUT VARCHAR2
    )
    IS
        csbProgram              CONSTANT VARCHAR2(30) := 'ValidaDatosRev';

        -- Cursor para traer el siguiente numero de process_schedule
        CURSOR cuSchedule IS
            SELECT max(process_schedule_id) + 1
            FROM ge_process_schedule;

        -- Cursor para obtener el id del ejecutable ('ICBGHE', 'ICBGRC')
        CURSOR cuExecutable IS
            SELECT executable_id
            FROM sa_executable
            WHERE name =  isbNameExecutable;
    BEGIN
        osbError := NULL;
        onuError := 0;

        pkg_traza.trace(csbMetodo||'.'||csbProgram, csbNivelTraza, csbInicio);

        -- Valida si hay fecha Inicial en el parametro de entrada. La hora de la fecha inicial siempre es 00:00:00
        IF (idtFecIni is null) THEN
            odtFechaIni := TRUNC(SYSDATE) - 1;    -- el dia anterior
        ELSE
            odtFechaIni := TRUNC(idtFecIni);
        END IF;

        -- Valida si hay fecha Final en el parametro de entrada
        IF (idtFecFin is null) THEN
            odtFechaFin := odtFechaIni;            -- el mismo dia de la fecha inicial
        ELSE
            odtFechaFin := TRUNC(idtFecFin);
        END IF;

        -- La hora de la fecha final siempre son las 23:59:59
        odtFechaFin := odtFechaFin + 1 - cnu1Seg;

        -- Valida que la fecha final no sea anterior a la inicial
        IF odtFechaFin < odtFechaIni THEN
            onuError := -1;
            osbError := 'Error: fecha final: '||TO_CHAR(odtFechaFin,'dd/mm/yyyy')||', no puede ser menor a la inicial: '||TO_CHAR(odtFechaIni,'dd/mm/yyyy');
            RAISE pkg_Error.Controlled_Error;
        END IF;

        -- Valida que el cursor no este abierto
        IF cuSchedule%isopen THEN
            CLOSE cuSchedule;
        END IF;
        --Obtine el siguiente valor para el id de Ge_process_schedule
        OPEN cuSchedule;
        FETCH cuSchedule INTO onuScheduleProcessAux;
        CLOSE cuSchedule;

        -- Valida que el cursor no este abierto
        IF cuExecutable%isopen THEN
            CLOSE cuExecutable;
        END IF;
        --Obtine el id del ejecutable
        OPEN cuExecutable;
        FETCH cuExecutable INTO onuExecutable;
        CLOSE cuExecutable;

        -- Valida que el ejecutable exista
        IF onuExecutable IS NULL THEN
            onuError := -2;
            osbError := 'Error: Ejecutable '|| isbNameExecutable ||' no esta registrado en SA_EXECUTABLE';
            RAISE pkg_Error.Controlled_Error;
        END IF;

        pkg_traza.trace(csbMetodo||'.'||csbProgram, csbNivelTraza, csbFin);

    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_traza.trace('sbError: ' || osbError, csbNivelTraza);
            pkg_traza.trace(csbMetodo||'.'||csbProgram, csbNivelTraza, csbFin_Erc);
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(onuError, osbError);
            pkg_traza.trace('sbError: ' || osbError, csbNivelTraza);
            pkg_traza.trace(csbMetodo||'.'||csbProgram, csbNivelTraza, csbFin_Err);
            RAISE;
    END ValidaDatosRev;

    /*
        Unidad:       prProcesaActasFNB_Sap
        Descripcion:  Procedimiento que registra la informacion de la contabilizacion de las
                      actas de BRILLA en las tablas LDCI_ACTACONT y LDCI_INCOLIQU.
                      Al terminar envia un correo de notificacion a las cuentas registradas en
                      el parametro EMAIL_NOTIF_ACTA_CONTABIL_FNB de la tabla LDCI_CARASEWE.

        Autor:        German Dario Guevara Alzate - GlobaMVM
        Fecha:        04/04/2024
    */
    PROCEDURE prProcesaActasFNB_Sap
    (
        idtFecIni    IN DATE DEFAULT NULL,
        idtFecFin    IN DATE DEFAULT NULL
    )
    IS
        csbTipoCompFNB          CONSTANT VARCHAR2(4)  := 'L7';                     -- Tipo de comprobante de las actas de Brilla
        csbProgram              CONSTANT VARCHAR2(30) := 'prProcesaActasFNB_Sap';

        -- Variables generales
        nuError                 NUMBER;
        nuResult                NUMBER;
        nuPrioridad             NUMBER;
        nuTotal                 NUMBER;
        nuCont                  NUMBER;
        dtFechaIni              DATE;
        dtFechaFin              DATE;
        sRemitente              VARCHAR2(4000);
        sbAsunto                VARCHAR2(4000);
        sbMensaje               VARCHAR2(30000);
        sbDestinatariosCC       VARCHAR2(4000);
        sbDestinatariosBCC      VARCHAR2(4000);
        sbArchivos              VARCHAR2(4000);
        sbError                 VARCHAR2(4000);
        sbDestinatarios         ldci_carasewe.casevalo%TYPE;
        vaTipoContFNB           ldci_carasewe.casevalo%TYPE;

        -- Cursor para consultar las actas pendientes de contabilizar (el que me dio Edmundo)
        CURSOR cuActas (idtFechaIni DATE, idtFechaFin DATE)
        IS
            SELECT a.*
            FROM ge_Acta a,
                 ge_contrato c
            WHERE a.id_contrato  = c.id_contrato
              AND  c.id_tipo_contrato in ( SELECT to_number(regexp_substr(
                                                                          vaTipoContFNB,
                                                                           '[^,]+',
                                                                           1,
                                                                           LEVEL
                                                                          )
                                                            ) AS TipoCont
                                              FROM dual
                                           CONNECT BY regexp_substr(vaTipoContFNB, '[^,]+', 1, LEVEL) IS NOT NULL
                                         )
              AND a.id_tipo_acta = 1                        -- Facturacion
              AND a.estado       = 'C'                      -- Cerrada
              AND a.extern_invoice_num is not null          -- Nro Factura
              AND nvl(a.extern_pay_date, '31-12-4000')  between idtFechaIni AND idtFechaFin      -- Fecha Factura
              AND a.id_acta not in (SELECT ac.idacta        -- No contabilizada
                                    FROM ldci_actacont ac
                                    WHERE ac.idacta = a.id_acta
                                      AND ac.actcontabiliza = 'S');

        -- Cursor para leer el valor del parametro
        CURSOR cuParametro (isbWS VARCHAR2, isbParam VARCHAR2) IS
            SELECT casevalo
            FROM ldci_carasewe
            WHERE casecodi = isbParam
              AND casedese = isbWS;

    BEGIN
        pkg_traza.trace(csbMetodo||'.'||csbProgram, csbNivelTraza, csbInicio);

        -- Valida que el cursor no este abierto
        IF cuParametro%isopen THEN
            CLOSE cuParametro;
        END IF;        
        
        -- Lee el parametro con de los tipos de contrato a tener en cuenta
        OPEN cuParametro ('WS_COSTOS', 'TIPO_CONTRATOS_FNB');
        FETCH cuParametro INTO vaTipoContFNB;
         -- Valida que el parametro exista
        IF cuParametro%notfound THEN
            CLOSE cuParametro;
            pkg_traza.trace('Error en la tabla LDCI_CARASEWE, el parametro TIPO_CONTRATOS_FNB no existe', csbNivelTraza);
            RAISE pkg_Error.Controlled_Error;
        END IF;
        CLOSE cuParametro;  

        sbError            := NULL;
        sbDestinatarios    := NULL;
        sbDestinatariosCC  := NULL;
        sbDestinatariosBCC := NULL;
        sbArchivos         := NULL;
        nuPrioridad        := NULL;
        nuTotal            := 0;
        nuCont             := 0;

        -- Valida si hay fecha Inicial en el parametro de entrada. La hora de la fecha inicial siempre es 00:00:00
        IF (idtFecIni is null) THEN
            dtFechaIni := TRUNC(SYSDATE) - 1;    -- el dia anterior
        ELSE
            dtFechaIni := TRUNC(idtFecIni);
        END IF;

        -- Valida si hay fecha Final en el parametro de entrada
        IF (idtFecFin is null) THEN
            dtFechaFin := dtFechaIni;            -- el mismo dia de la fecha inicial
        ELSE
            dtFechaFin := TRUNC(idtFecFin);
        END IF;

        -- La hora de la fecha final siempre es el mismo dia a las 23:59:59
        dtFechaFin := dtFechaFin + 1 - cnu1Seg;

        -- Valida que la fecha final no sea anterior a la inicial
        IF dtFechaFin < dtFechaIni THEN
            pkg_traza.trace('Error: fecha final: '||TO_CHAR(dtFechaFin,'dd/mm/yyyy')||
                            ', no puede ser menor a la inicial: '||TO_CHAR(dtFechaIni,'dd/mm/yyyy'), csbNivelTraza);
            RAISE pkg_Error.Controlled_Error;
        END IF;

        -- Carga la Informacion que va en el correo
        BEGIN
            sRemitente := pkg_bcld_parameter.fsbobtienevalorcadena('LDC_SMTP_SENDER');
        EXCEPTION
            WHEN OTHERS THEN
                pkg_traza.trace('Error: No existe LDC_SMTP_SENDER en ld_parameter. '||SQLERRM, csbNivelTraza);
                RAISE pkg_Error.Controlled_Error;
        END;
        sbAsunto   := 'Actas de BRILLA Procesadas Automaticamente el ' || TO_CHAR(sysdate,'dd/mm/yyyy');
        sbMensaje  := 'Listado de Actas Contabilizadas el ' || TO_CHAR(dtFechaIni,'dd/mm/yyyy') ||
                      '. ** Favor validar en SAP **' ||chr(10);
        sbMensaje  := sbMensaje || chr(10) || '---------------------------------------';
        sbMensaje  := sbMensaje || chr(10) || '        ID_ACTA    ID_CONTRATO';

        -- Valida que el cursor no este abierto
        IF cuParametro%isopen THEN
            CLOSE cuParametro;
        END IF;

        -- Lee el parametro con los correos para notificar las actas contabilizadas
        OPEN cuParametro ('WS_INTER_CONTABLE', 'EMAIL_NOTIF_ACTA_CONTABIL_FNB');
        FETCH cuParametro INTO sbDestinatarios;
         -- Valida que el parametro exista
        IF cuParametro%notfound THEN
            CLOSE cuParametro;
            pkg_traza.trace('Error en la tabla LDCI_CARASEWE, el parametro EMAIL_NOTIF_ACTA_CONTABIL_FNB no existe', csbNivelTraza);
            RAISE pkg_Error.Controlled_Error;
        END IF;
        CLOSE cuParametro;

        -- Valida que el valor del parametro no sea nulo
        IF sbDestinatarios is null THEN
            pkg_traza.trace('Error en la tabla LDCI_CARASEWE, el parametro EMAIL_NOTIF_ACTA_CONTABIL_FNB no tiene valor', csbNivelTraza);
            RAISE pkg_Error.Controlled_Error;
        END IF;

        -- Valida que el cursor no este abierto
        IF cuActas%isopen THEN
            CLOSE cuActas;
        END IF;

        -- Recorre todas las actas que debe contabilizar
        FOR rc in cuActas (dtFechaIni, dtFechaFin) LOOP
            BEGIN
                nuTotal := nuTotal + 1;
                pkg_traza.trace('Contabilizando el Acta: '||rc.id_acta, csbNivelTraza);

                -- Registra la informacion de la contabilizacion del acta en LDCI_INCOLIQU
                nuResult := null;
                nuResult := pkg_BOInterfazActas.fnuInterCostoSAP
                            (
                                rc.id_acta,
                                csbTipoCompFNB,
                                dtFechaIni,
                                dtFechaFin
                            );
                -- Acta registrada OK en la interfaz de costos LDCI_INCOLIQU
                IF (nuResult = 0) THEN
                    sbMensaje := sbMensaje ||chr(10)|| lpad(rc.id_acta,14) ||' '|| lpad(rc.id_contrato,14);
                    nuCont := nuCont + 1;
                    commit;
                ELSIF (nuResult = -1) THEN
                    sbMensaje := sbMensaje ||chr(10)|| lpad(rc.id_acta,14) ||' '|| lpad(rc.id_contrato,14)|| '    **  Error al contabilizar, favor revisar';
                    rollback;
                ELSE
                    sbMensaje := sbMensaje ||chr(10)|| lpad(rc.id_acta,14) ||' '|| lpad(rc.id_contrato,14)|| '    **  Error: acta no contabilizada en la fecha dada, favor revisar';
                    rollback;
                END IF;
            EXCEPTION
                WHEN OTHERS  THEN
                    sbMensaje := sbMensaje ||chr(10)|| lpad(rc.id_acta,14) ||' '|| lpad(rc.id_contrato,14)|| '    **  Error controlado al contabilizar, favor revisar';
                    rollback;
            END;
        END LOOP;

        sbMensaje := sbMensaje || chr(10) || '---------------------------------------';
        sbMensaje := sbMensaje || chr(10) || 'Total Actas Seleccionadas:  '||nuTotal;
        sbMensaje := sbMensaje || chr(10) || 'Total Actas Contabilizadas: '||nuCont;

        -- Envia el correo
        pkg_correo.prcEnviaCorreo
        (
            sRemitente         ,
            sbDestinatarios    ,
            sbAsunto           ,
            sbMensaje          ,
            sbDestinatariosCC  ,
            sbDestinatariosBCC ,
            sbArchivos         ,
            nuPrioridad
        );

        pkg_traza.trace(csbMetodo||'.'||csbProgram, csbNivelTraza, csbFin);

    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pkg_traza.trace(csbMetodo||'.'||csbProgram, csbNivelTraza, csbFin_Erc);
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pkg_traza.trace(csbMetodo||'.'||csbProgram, csbNivelTraza, csbFin_Err);
    END prProcesaActasFNB_Sap;

    /*
        Unidad:       prReversaHE_ActasFNB
        Descripcion:  Procedimiento para programar la reversión de los hechos económicos (HE),
                      de las actas brilla procesadas el día inmediatamente anterior a su ejecución,
                      esto se hace porque no se puede usar la utilidad de Open ICGIC, porque por
                      obligación siempre hay que digitar la fecha inicial y final.

        Autor:        German Dario Guevara Alzate - GlobaMVM
        Fecha:        04/04/2024
    */
    PROCEDURE prReversaHE_ActasFNB
    (
        idtFecIni    IN DATE DEFAULT NULL,
        idtFecFin    IN DATE DEFAULT NULL
    ) AS
        -- Constantes
        cnuTipoDocu             CONSTANT NUMBER(4)    := 77;    -- Tipo de comprobante de las actas de Brilla
        csbProgram              CONSTANT VARCHAR2(30) := 'prReversaHE_ActasFNB';
        csbMNEM                 CONSTANT VARCHAR2(10) := 'ICBGHE';
        csbFrecuency            CONSTANT VARCHAR2(10) := 'UV';

        -- Variables generales
        nuError                 NUMBER;
        nuScheduleProcessAux    NUMBER;
        nuExecutable            NUMBER;
        dtFechaIni              DATE;
        dtFechaFin              DATE;
        sbConexEncript          VARCHAR2(4000);
        sbParameters            VARCHAR2(4000);
        isbWhat                 VARCHAR2(4000);
        sbError                 VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo||'.'||csbProgram, csbNivelTraza, csbInicio);

        -- Validacion de datos
        ValidaDatosRev
        (
            csbMNEM,
            idtFecIni,
            idtFecFin,
            dtFechaIni,
            dtFechaFin,
            nuScheduleProcessAux,
            nuExecutable,
            nuError,
            sbError
        );

        -- Obtiene cadena de conexion
        IF sbConexEncript IS NULL THEN
            -- Obtiene la cadena de conexion encriptada a la base de datos
            sbConexEncript := pkg_BOConexionBD.fsbConexEncriptada;
        END IF;

        IF sbConexEncript IS NULL THEN
            nuError := -2;
            sbError := 'ERROR: no se pudo consultar las credenciales de conexion';
            pkg_traza.trace(sbError, csbNivelTraza);
            RAISE pkg_Error.Controlled_Error;
        END IF;

        sbParameters := 'OPERATION_MODE_ID=2|TIDCCODI='||cnuTipoDocu||'|DOGEFEMO='||dtFechaIni||'|DOGEFEGE='||dtFechaFin||'|DOGEDETA=|DPINIDPA=|CONEX='||sbConexEncript||'|';
        pkg_traza.trace('sbParameters ['||sbParameters||']', csbNivelTraza);

        isbWhat := 'BEGIN' ||chr(10)||
                   '   SetSystemEnviroment;' ||chr(10)||
                   '   Errors.Initialize;'   ||chr(10)||
                   '   ICBGHE( '||nuScheduleProcessAux||' );' ||chr(10)||
                   '   IF (DAGE_Process_Schedule.fsbGetFrequency( '||nuScheduleProcessAux||' ) in ( GE_BOSchedule.csbSoloUnaVez, GE_BOSchedule.csbSoloUnaVezDH ) ) THEN' ||chr(10)||
                   '      GE_BOSchedule.InactiveSchedule( '||nuScheduleProcessAux||' );' ||chr(10)||
                   '   END IF; '||chr(10)||
                   'EXCEPTION'  ||chr(10)||
                   '   WHEN OTHERS THEN'   ||chr(10)||
                   '     Errors.SetError;' ||chr(10)||
                   '     IF (DAGE_Process_Schedule.fsbGetFrequency( '||nuScheduleProcessAux||' ) in ( GE_BOSchedule.csbSoloUnaVez, GE_BOSchedule.csbSoloUnaVezDH ) ) THEN' ||chr(10)||
                   '         GE_BOSchedule.DropSchedule( '||nuScheduleProcessAux||' );' ||chr(10)||
                   '     END IF; ' ||chr(10)||
                   'END;';

        pkg_traza.trace('isbWhat ['||isbWhat||']', csbNivelTraza);

        -- Crea la programacion de la tarea de reversion
        pkg_BOSchedule.prCreaSchedule
        (
            nuExecutable,
            sbParameters,
            isbWhat,
            nuScheduleProcessAux,
            csbFrecuency,
            cdtNextProg
        );

        COMMIT;

        pkg_traza.trace(csbMetodo||'.'||csbProgram, csbNivelTraza, csbFin);

    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pkg_traza.trace(csbMetodo||'.'||csbProgram, csbNivelTraza, csbFin_Erc);
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pkg_traza.trace(csbMetodo||'.'||csbProgram, csbNivelTraza, csbFin_Err);
    END prReversaHE_ActasFNB;

    /*
        Unidad:       prReversaRC_ActasFNB
        Descripcion:  Procedimiento para programar la reversión de los registros contables (RC),
                      de las actas brilla procesadas el día inmediatamente anterior a su ejecución,
                      esto se hace porque no se puede usar la utilidad de Open ICGIC, porque por
                      obligación siempre hay que digitar la fecha inicial y final.


        Autor:        German Dario Guevara Alzate - GlobaMVM
        Fecha:        04/04/2024
    */
    PROCEDURE prReversaRC_ActasFNB
    (
        idtFecIni    IN DATE DEFAULT NULL,
        idtFecFin    IN DATE DEFAULT NULL
    ) AS
        -- Constantes
        cnuTipoDocu             CONSTANT NUMBER(4)    := 4;    -- Tipo de comprobante de las actas de Brilla
        csbProgram              CONSTANT VARCHAR2(30) := 'prReversaRC_ActasFNB';
        csbMNEM                 CONSTANT VARCHAR2(10) := 'ICBGRC';
        csbFrecuency            CONSTANT VARCHAR2(10) := 'UV';

        -- Variables generales
        nuError                 NUMBER;
        nuScheduleProcessAux    NUMBER;
        nuExecutable            NUMBER;
        dtFechaIni              DATE;
        dtFechaFin              DATE;
        sbConexEncript          VARCHAR2(4000);
        sbParameters            VARCHAR2(4000);
        isbWhat                 VARCHAR2(4000);
        sbError                 VARCHAR2(4000);

    BEGIN
        pkg_traza.trace(csbMetodo||'.'||csbProgram, csbNivelTraza, csbInicio);

        -- Validacion de datos
        ValidaDatosRev
        (
            csbMNEM,
            idtFecIni,
            idtFecFin,
            dtFechaIni,
            dtFechaFin,
            nuScheduleProcessAux,
            nuExecutable,
            nuError,
            sbError
        );

        -- Obtiene cadena de conexion
        IF sbConexEncript IS NULL THEN
            -- Obtiene la cadena de conexion encriptada a la base de datos
            sbConexEncript := pkg_BOConexionBD.fsbConexEncriptada;
        END IF;

        IF sbConexEncript IS NULL THEN
            nuError := -2;
            sbError := 'ERROR: no se pudo consultar las credenciales de conexion';
            pkg_traza.trace(sbError, csbNivelTraza);
            RAISE pkg_Error.Controlled_Error;
        END IF;

        sbParameters := 'OPERATION_MODE_ID=2|TICOCODI=4|COCOCODI='||cnuTipoDocu||'|COGEOBSE=|COGEFEIN='||dtFechaIni||'|COGEFEFI='||dtFechaFin||'|DPINIDPA=|CONEX='||sbConexEncript||'|';
        pkg_traza.trace('sbParameters ['||sbParameters||']', csbNivelTraza);

        isbWhat := 'BEGIN' ||chr(10)||
                   '   SetSystemEnviroment;' ||chr(10)||
                   '   Errors.Initialize;'   ||chr(10)||
                   '   ICBGRC( '||nuScheduleProcessAux||' );' ||chr(10)||
                   '   IF (DAGE_Process_Schedule.fsbGetFrequency( '||nuScheduleProcessAux||' ) in ( GE_BOSchedule.csbSoloUnaVez, GE_BOSchedule.csbSoloUnaVezDH ) ) THEN' ||chr(10)||
                   '      GE_BOSchedule.InactiveSchedule( '||nuScheduleProcessAux||' );' ||chr(10)||
                   '   END IF; '||chr(10)||
                   'EXCEPTION'  ||chr(10)||
                   '   WHEN OTHERS THEN'   ||chr(10)||
                   '     Errors.SetError;' ||chr(10)||
                   '     IF (DAGE_Process_Schedule.fsbGetFrequency( '||nuScheduleProcessAux||' ) in ( GE_BOSchedule.csbSoloUnaVez, GE_BOSchedule.csbSoloUnaVezDH ) ) THEN' ||chr(10)||
                   '         GE_BOSchedule.DropSchedule( '||nuScheduleProcessAux||' );' ||chr(10)||
                   '     END IF; ' ||chr(10)||
                   'END;';

        pkg_traza.trace('isbWhat ['||isbWhat||']', csbNivelTraza);

        -- Crea la programacion de la tarea de reversion
        pkg_BOSchedule.prCreaSchedule
        (
            nuExecutable,
            sbParameters,
            isbWhat,
            nuScheduleProcessAux,
            csbFrecuency,
            cdtNextProg
        );

        COMMIT;

        pkg_traza.trace(csbMetodo||'.'||csbProgram, csbNivelTraza, csbFin);

    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pkg_traza.trace(csbMetodo||'.'||csbProgram, csbNivelTraza, csbFin_Erc);
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pkg_traza.trace(csbMetodo||'.'||csbProgram, csbNivelTraza, csbFin_Err);
    END prReversaRC_ActasFNB;

END pkg_ContabilizaActasAut;
/

PROMPT Otorgando permisos de ejecución a pkg_ContabilizaActasAut
BEGIN
    pkg_utilidades.prAplicarPermisos('PKG_CONTABILIZAACTASAUT','PERSONALIZACIONES');
END;
/