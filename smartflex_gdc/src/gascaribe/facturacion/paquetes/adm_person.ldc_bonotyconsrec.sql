CREATE OR REPLACE PACKAGE ADM_PERSON.LDC_BONOTYCONSREC IS
/*******************************************************************************
    Package:        LDC_BONOTYCONSREC
    Descripcion:    Paquete con procedimientos para notificacion por consumos recuperados altos
    Autor:          Juan Gabriel Catuche Giron 
    Fecha:          22/12/2022

    Historial de Modificaciones
    =============================
    FECHA           AUTOR               DESCRIPCION
    05/06/2024      jpinedc             OSF-2603: Se escribe archivo en el servidor
                                                en lugar de en memoria para enviarlo por
                                                medio de pkg_Correo
    11/01/2023      jcatuchemvm         OSF-748: Se modifican los procedimientos
                                            [pValidaPeriodosD]
                                            [pNotyConsRec]
    04/01/2023      jpinedcmvm          OSF-748: Se modifican cnuRaiseError, pNotyConsRec.proValida, 
                                                 pNotyConsRec.proParam. Se crea pExisteParametro 
                                                 porque dald_parameter muestra un mensaje de error
                                                 errado cuando el parametro no existe
    22/12/2022      jcatuchemvm         OSF-748: Creacion el paquete 
*******************************************************************************/

    -- Retorna la constante con la ultimo caso que lo modifico
    FUNCTION fsbVersion RETURN VARCHAR2; 
    --Realiza identifacion de poblacion objetivo y realiza la notificacion
    PROCEDURE pNotyConsRec(isbPeriodos IN VARCHAR2);
    
    -- Validacion de periodos de facturacion por dia
    PROCEDURE pValidaPeriodosD;
    
    --Programa Job para ejecucion de procedimiento pNotyConsRec
    PROCEDURE pProgramaJob(inuPeriodo IN perifact.pefacodi%TYPE);
    
    --Programa Job para ejecucion diaria de procedimiento pNotyConsRec
    PROCEDURE pJob;
        
END ldc_boNotyConsRec;
/

CREATE OR REPLACE PACKAGE BODY ADM_PERSON.LDC_BONOTYCONSREC IS
    
    ------------------------------------------------------------------------------
    -- Tipos
    ------------------------------------------------------------------------------
    
    ------------------------------------------------------------------------------
    -- Constantes
    ------------------------------------------------------------------------------
    -- Version del paquete
    csbVersion              CONSTANT VARCHAR2(15) := 'OSF-2603';
    
    -- Para el control de traza:
    csbSP_NAME              CONSTANT VARCHAR2(32) := $$PLSQL_UNIT||'.';
    csbDBNAME               CONSTANT VARCHAR2(20) := SYS_CONTEXT('USERENV', 'DB_NAME');
    cnuNVLTRC               CONSTANT NUMBER := 5;
    cnuRaiseError           CONSTANT NUMBER := 1;
    raise_continuar         Exception;
    sbMensaje               ge_error_log.description%TYPE;
    
    /*******************************************************************************
    Metodo:         fsbVersion
    Descripcion:    Funcion que retorna la csbVersion, la cual indica el ultimo
                    caso que modifico el paquete. Se actualiza cada que se ajusta 
                    algun metodo del paquete
                    
    Autor:          Juan Gabriel Catuche Giron 
    Fecha:          22/12/2022

    Entrada         Descripcion
    NA      

    Salida          Descripcion
    csbVersion      Ultima version del paquete
    
    Historial de Modificaciones
    =============================
    FECHA           AUTOR               DESCRIPCION
    22/12/2022      jcatuchemvm         OSF-748: Creacion
    *******************************************************************************/    
    FUNCTION fsbVersion RETURN VARCHAR2 IS
    BEGIN
        RETURN csbVersion;
    END fsbVersion;
    
    /*******************************************************************************
    Metodo:         pNotyConsRec
    Descripcion:    Procedimiento encargado de generar notificaciones por correo despues de
                    la generacion de las cuentas de cobro FGCC, por consumos recuperados altos
                    
    Autor:          Juan Gabriel Catuche Giron 
    Fecha:          22/12/2022

    Entrada         Descripcion
    isbPeriodos     Periodos de facturacion              

    Salida          Descripcion
    NA
    
    Historial de Modificaciones
    =============================
    FECHA           AUTOR               DESCRIPCION
    25/01/2023      jcatuchemvm         OSF-748: Ajuste, se cambia ordenamiento de validacion de
                                        lectelme, la lectura a evaluar es la ultima registrada para el periodo
                                        Se agrega el cargo de consumo del periodo actual, tanto en el reporte
                                        como para contabilizar el neto de consumos por periodo
                                        neto 
    11/01/2023      jcatuchemvm         OSF-748: Ajuste, se agrega envio de notificacion
                                        de errores en la ejecucion del reporte
    22/12/2022      jcatuchemvm         OSF-748: Creacion
                                        Se adecua procedimiento almacenado LDC_EXPORT_REPORT_EXCEL
                                        para la creacion de reporte en Excel en memoria.
                                        Se adecuan procedimientos del paquete LDC_Email
                                        para el envio de notificacion por correo con archivo anexo.
    *******************************************************************************/
    PROCEDURE pNotyConsRec(isbPeriodos IN VARCHAR2) IS
        ----------------------------------------
        -- Constantes del procedimiento:
        ----------------------------------------
        csbEMailParam           CONSTANT Ld_Parameter.parameter_id%TYPE := 'LDC_EMAILNOCONSREC';
        csbTopeParam            CONSTANT Ld_Parameter.parameter_id%TYPE := 'LDC_TOPENOTICR';
        csbFGCC                 CONSTANT Procesos.Proccodi%TYPE := 'FGCC';
        csbMT_NAME              CONSTANT VARCHAR2(30) := 'pNotyConsRec';
        csbTb                   CONSTANT CHAR(1):= CHR(9);
        csbGn                   CONSTANT CHAR(1):= CHR(45);
        csbEsp                  CONSTANT CHAR(1):= CHR(32);
        csbEstNL                CONSTANT VARCHAR2(200) := 'Estimado por no lectura';
        csbEstCT                CONSTANT VARCHAR2(200) := 'Estimado por critica';
            
        -- Cursor para totatizar cantidad de consumos recuperados para el periodo
        CURSOR cuTotalConsumosRec(inuPefa in perifact.pefacodi%TYPE, inuCant IN NUMBER) IS
        SELECT /*+ index ( f IX_FACTURA04 ) use_nl ( f c )
        index ( c IDXCUCO_RELA ) use_nl ( c g )
        index ( g IX_CARG_NUSE_CUCO_CONC )  */ 
        count(sum(cargvalo)) cantidad
        FROM factura f, cuencobr c, cargos g
        WHERE factpefa = inuPefa
        AND factprog = 6
        AND factcons = 66
        AND cucofact = factcodi
        AND cargnuse = cuconuse
        AND cargcuco = cucocodi
        AND cargconc = 31
        AND cargprog = 5
        AND cargdoso LIKE 'CO%' 
        AND cargsign IN ('DB','CR')
        AND EXISTS
        (
            SELECT 'x' FROM cargos c
            WHERE c.cargnuse = g.cargnuse
            AND c.cargcuco = g.cargcuco
            AND c.cargconc = g.cargconc
            AND c.cargdoso LIKE 'CO%PR%'
        )
        Group By factcodi,cucocodi,cuconuse
        HAVING ABS(SUM(DECODE(cargsign,'CR',-1*cargvalo,cargvalo))) > inuCant 
        ;
        
        CURSOR cuPeriodos(isbCadena IN VARCHAR2) IS
        SELECT COLUMN_VALUE Periodo
        FROM TABLE
        (
            Ldc_Boutilities.Splitstrings(isbCadena, ',')
        );
        
        sbEmailNoti     Ld_Parameter.Value_Chain%TYPE; 
        nuTopeConsRec   Ld_Parameter.Numeric_Value%TYPE;   
        sbNomArch       Varchar2(200); 
        sbNomHoja       Varchar2(2000);
        raise_Ncont     Exception;
        clSentencia     CLOB;
        sbSentemp       Varchar2(4000);
        nuCantidad      Number;
        sbAsuntoEM      Varchar2(2000);
        sbMensajeEME    Varchar2(32767);
        sbMensajeEM     Varchar2(32767);
        sbMensajeEMB    Varchar2(32767);
        sbMensajeEMF    Varchar2(32767);
        nuerror         ge_error_log.message_id%TYPE;
        sberror         ge_error_log.description%TYPE; 
        rcProcejec      procejec%ROWTYPE;
        nuCiclo         perifact.pefacicl%TYPE;
        conn            utl_smtp.connection;
        clReporte       pkg_gestionArchivos.styArchivo;
        gnuPerAnt       perifact.pefacodi%TYPE;
        nuPeriodo       perifact.pefacodi%TYPE;
        nuContador      Number;
        
        --Valida si una cadena contiene un valor numerico
        FUNCTION fnuIsNumber (p_cadena IN VARCHAR2)
        RETURN NUMBER IS
            sbSubMT_NAME  VARCHAR2(30) := '.fnuIsNumber';
            v_numero NUMBER;
        BEGIN
            pkg_traza.trace(csbSP_NAME||csbMT_NAME||sbSubMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);
            
            IF p_cadena IS NOT NULL THEN
                v_numero := TO_NUMBER( REPLACE(p_cadena, ',', '') );
            ELSE
                v_numero := 0;
            END IF;
            
            pkg_traza.trace(csbSP_NAME||csbMT_NAME||sbSubMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
            
            RETURN v_numero;
            
        EXCEPTION
            WHEN VALUE_ERROR THEN
                pkg_traza.trace('Finaliza con Error Controlado ' ||csbSP_NAME||csbMT_NAME||sbSubMT_NAME, cnuNVLTRC);
                v_numero := 0;
                RETURN v_numero;
        END fnuIsNumber;
        
        PROCEDURE pEnvioMail( isbMensaje ld_parameter.parameter_id%TYPE )
        IS
        BEGIN
        
            sbAsuntoEM := REPLACE(sbAsuntoEM,'[FECHA]',TO_CHAR(LDC_BOConsGenerales.fdtGetSysdate-1,'DD/MM/YYYY'));
            sbMensajeEME := REPLACE(sbMensajeEME,'[FECHA]',TO_CHAR(LDC_BOConsGenerales.fdtGetSysdate-1,'DD/MM/YYYY'));
            sbMensajeEME := sbMensajeEME||'        '||isbMensaje||'<br>'||'<br>'||'Por favor verificar';

            pkg_Correo.prcEnviaCorreo
            (
                isbDestinatarios    => TRIM(sbEmailNoti),
                isbAsunto           => sbAsuntoEM,
                isbMensaje          => sbMensajeEME
            );            
            
        
        EXCEPTION
            WHEN OTHERS THEN
                sbMensaje := 'Se presenta error en el envío de notificación de error ['||isbMensaje||']. '||sqlerrm;
                raise raise_continuar;
        END pEnvioMail;
        
        PROCEDURE pExisteParametro( isbParametro ld_parameter.parameter_id%TYPE )
        IS

            CURSOR cuLD_Parameter
            IS
            SELECT parameter_id
            FROM LD_Parameter
            WHERE parameter_id = isbParametro;
            
            rcParameter cuLD_Parameter%ROWTYPE;            
        BEGIN
            OPEN cuLD_Parameter;
            FETCH cuLD_Parameter INTO rcParameter;
            CLOSE cuLD_Parameter;
            
            IF rcParameter.Parameter_id IS NULL THEN
                sbMensaje := 'No existe el Parámetro ['||isbParametro||']';
                raise raise_continuar;
            END IF;
                     
        END pExisteParametro;
        
        PROCEDURE proValida IS
            sbSubMT_NAME  VARCHAR2(30) := '.proValida';                     
        BEGIN
            pkg_traza.trace(csbSP_NAME||csbMT_NAME||sbSubMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);
            
            -- Sin estos parametros no se puede enviar el e-mail
            BEGIN
                pExisteParametro( csbEMailParam );
                sbEmailNoti := pkg_BCLD_Parameter.fsbObtieneValorCadena(csbEMailParam);
                            
            EXCEPTION
                WHEN raise_continuar THEN
                    raise raise_NCont;
            END;
            
            --Valida e-mail
            IF sbEmailNoti is NULL THEN
                sbMensaje := 'La lista de destinatarios para la notificación de consumos recuperados está vacia. Parámetro ['||csbEMailParam||']';
                raise raise_NCont;
            ELSIF INSTR(sbEmailNoti,'@',1,1) = 0 THEN
                sbMensaje := 'La lista de destinatarios para la notificación de consumos recuperados no tiene un formato consistente. Parámetro ['||csbEMailParam||']';
                raise raise_NCont;
            END IF;
            
            pExisteParametro( csbTopeParam );
            nuTopeConsRec := pkg_BCLD_Parameter.fnuObtieneValorNumerico(csbTopeParam);
            
            --Valida tope
            nuTopeConsRec := fnuIsNumber(TO_CHAR(nuTopeConsRec)); 
            
            IF nuTopeConsRec = 0 THEN
                sbMensaje := 'El tope para validación de los consumos recuperados es cero o nulo. Parámetro ['||csbTopeParam||']';
                raise raise_continuar;
            END IF;
            
            pkg_traza.trace(csbSP_NAME||csbMT_NAME||sbSubMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
            
        END proValida;
        
        FUNCTION fnuPeriodoAnt
        RETURN NUMBER IS
            sbSubMT_NAME       VARCHAR2(30) := '.fnuPeriodoAnt';
            nuPeriodoAnt    NUMBER;
            
            CURSOR cuPeriodoAnt IS
            SELECT ant.pefacodi 
            FROM perifact act,perifact ant
            WHERE act.pefacodi = nuPeriodo
            AND ant.pefacicl = act.pefacicl
            AND ant.pefaano = DECODE(act.pefames,1,act.pefaano-1,act.pefaano)
            AND ant.pefames = DECODE(act.pefames,1,12,act.pefames-1);
            
        BEGIN
            pkg_traza.trace(csbSP_NAME||csbMT_NAME||sbSubMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);
            
            Pktblperifact.Acckey(nuPeriodo,1);
            
            IF gnuPerAnt = 0 THEN
                
                nuPeriodoAnt := NULL;
                OPEN cuPeriodoAnt;
                FETCH cuPeriodoAnt INTO nuPeriodoAnt;
                CLOSE cuPeriodoAnt;
                
                IF nuPeriodoAnt IS NULL THEN
                    gnuPerAnt := -99999;
                ELSE
                    gnuPerAnt := nuPeriodoAnt;
                END IF;
                
            END IF;
            
            nuPeriodoAnt := gnuPerAnt;
            
            pkg_traza.trace(csbSP_NAME||csbMT_NAME||sbSubMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
            
            RETURN nuPeriodoAnt;
            
        EXCEPTION
            WHEN OTHERS THEN
                pkg_traza.trace('Finaliza con Error Controlado ' ||csbSP_NAME||csbMT_NAME||sbSubMT_NAME, cnuNVLTRC);
                gnuPerAnt := -99999;
                nuPeriodoAnt := gnuPerAnt;
                RETURN nuPeriodoAnt;
        END fnuPeriodoAnt;
        
        PROCEDURE proParam IS
            sbSubMT_NAME  VARCHAR2(30) := '.proParam';
            sbAmbienteT   VARCHAR2(30);
            sbAmbiente    VARCHAR2(30);
        BEGIN
            pkg_traza.trace(csbSP_NAME||csbMT_NAME||sbSubMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);
            
            nuContador := 0;
                        
            sbNomArch := 'RptClientConsumosRecuperados_[FECHA].xls';
            sbNomHoja := 'Productos Consumos Recuperados';
            
            sbAmbienteT := CASE csbDBNAME WHEN 'SFPL0707' THEN 'PRODUCTIVO' WHEN 'SFQH0707' THEN 'Calidad' ELSE 'Desarrollo' END;
            sbAmbiente := CASE csbDBNAME WHEN 'SFPL0707' THEN 'PRODUCTIVO' WHEN 'SFQH0707' THEN 'de Calidad' ELSE 'de Desarrollo' END;
            
            --Mensaje
            sbAsuntoEM  := 'Consumos Recuperados Altos - Fecha [[FECHA]]**'||sbAmbienteT;
            sbMensajeEM := 'Facturación y Cartera'||'<br>'||'-----------------------------'||'<br><br>';
            sbMensajeEM := sbMensajeEM||'Para el día [[FECHA]], se realiza el proceso ['||csbFGCC||' - Generación De Cuentas De Cobro][[ESTADO]] ';
            sbMensajeEM := sbMensajeEM||'para los siguientes periodos de facturación en ambiente '||sbAmbiente||', los cuales presentan cargos con consumos recuperados altos que exceden el tope de ';
            sbMensajeEM := sbMensajeEM||'[[TOPE]], establecido en el parámetro '||csbTopeParam||'.'||'<br><br>';
            sbMensajeEMF := '<br>'||'Se anexa reporte con los casos detectados'||'<br>'||'        '||'[ARCHIVO]'||'<br>'||'<br>'||'Por favor verificar';
            
            --Mensaje Error
            sbMensajeEME := 'Facturación y Cartera'||'<br>'||'-----------------------------'||'<br>';
            sbMensajeEME := sbMensajeEME||'Para el día [[FECHA]], se presenta el siguiente error en la generación del reporte'||'<br>';
            
            
            -- Validacion de parametros;
            proValida;
            
            pkg_traza.trace(csbSP_NAME||csbMT_NAME||sbSubMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
            
        END proParam;
        
        PROCEDURE proInic IS
            sbSubMT_NAME  VARCHAR2(30) := '.proInic';
        BEGIN
            pkg_traza.trace(csbSP_NAME||csbMT_NAME||sbSubMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);
            
            gnuPerAnt := 0;
            
            sbSentemp := 
            'SELECT /*+ index ( g IX_CARG_NUSE_CUCO_CONC ) use_nl (g c)
                index ( c pk_cuencobr) use_nl ( c f ) 
                index ( f pk_factura ) */  
                (SELECT CONCAT(CONCAT(subscriber_name,'''||csbEsp||'''),subs_last_name) FROM ge_subscriber,suscripc WHERE suscclie = subscriber_id AND susccodi = factsusc) subscriber,
                factsusc,factcodi,factpefa,
                (SELECT CONCAT(CONCAT(document_type_id,'''||csbGn||'''),description) FROM ge_document_type WHERE document_type_id = factcons) factcons,
                (SELECT CONCAT(CONCAT(proccodi,'''||csbGn||'''),procdesc) FROM procesos WHERE proccons = factprog) factprog,
                cucocodi,
                (SELECT CONCAT(CONCAT(catecodi,'''||csbGn||'''),catedesc) FROM categori WHERE catecodi = cucocate) cucocate,
                (SELECT CONCAT(CONCAT(sucacodi,'''||csbGn||'''),sucadesc) FROM subcateg WHERE sucacate = cucocate AND sucacodi = cucosuca) cucosuca,
                (SELECT plsudesc FROM plansusc WHERE plsucodi = cucoplsu) cucoplsu,cuconuse,
                (SELECT CONCAT(CONCAT(conccodi,'''||csbGn||'''),concdesc) FROM concepto WHERE conccodi = cargconc) cargconc,
                cargsign,
                DECODE(cargsign,''CR'',-1*cargvalo,cargvalo) cargvalo,
                CONCAT(cargunid,''-m3'') cargunid,
                cargdoso,
                cargpefa,
                cargfecr,
                (SELECT CONCAT(CONCAT(proccodi,'''||csbGn||'''),procdesc) FROM procesos WHERE proccons = cargprog) cargprog,
                cargpeco,
                DECODE('||fnuPeriodoAnt||',-99999,''No se encontro periodo anterior'','||fnuPeriodoAnt||') perifact_ant,
                NVL((
                    select distinct first_value (decode(nvl(leemleto,-1),-1,'''||csbEstNL||''','''||csbEstCT||''')) over ( order by leemfele desc )
                    from lectelme
                    where leemsesu = cargnuse
                    and leempefa = '||fnuPeriodoAnt||'
                ),''Sin registro de Lecturas'') estimacion
            FROM factura f, cuencobr c, cargos g
            WHERE factprog = 6
            AND factcons = 66
            AND cucofact = factcodi
            AND cargnuse = cuconuse
            AND cargcuco = cucocodi
            AND cargconc = 31
            AND cargprog = 5
            AND cargdoso LIKE ''CO%'' 
            AND cargsign IN (''DB'',''CR'')
            AND (cargcuco,cargnuse) in 
            (
                SELECT /*+ index ( f IX_FACTURA04 ) use_nl ( f c )
                index ( c IDXCUCO_RELA ) use_nl ( c g )
                index ( g IX_CARG_NUSE_CUCO_CONC )  */ 
                cucocodi,cuconuse
                FROM factura f, cuencobr c, cargos g
                WHERE factpefa = '||nuPeriodo||'
                AND factprog = 6
                AND factcons = 66
                AND cucofact = factcodi
                AND cargnuse = cuconuse
                AND cargcuco = cucocodi
                AND cargconc = 31
                AND cargprog = 5
                AND cargdoso LIKE ''CO%'' 
                AND cargsign IN (''DB'',''CR'')
                AND EXISTS
                (
                    SELECT ''x'' FROM cargos c
                    WHERE c.cargnuse = g.cargnuse
                    AND c.cargcuco = g.cargcuco
                    AND c.cargconc = g.cargconc
                    AND c.cargdoso LIKE ''CO%PR%''
                )
                Group By cucocodi,cuconuse
                HAVING ABS(SUM(DECODE(cargsign,''CR'',-1*cargvalo,cargvalo))) > '||nuTopeConsRec||'
            )
            ORDER BY cargnuse';
            
            clSentencia := 
            '
            SELECT 
                INITCAP(utl_raw.cast_to_varchar2(nlssort(SUBSCRIBER, ''nls_sort=binary_ai''))) Cliente,
                FACTSUSC Contrato,
                FACTCODI Factura,
                FACTPEFA Periodo_Factura,
                INITCAP(utl_raw.cast_to_varchar2(nlssort(FACTCONS, ''nls_sort=binary_ai''))) Tipo_Documento,
                INITCAP(utl_raw.cast_to_varchar2(nlssort(FACTPROG, ''nls_sort=binary_ai''))) Programa_Factura,
                CUCOCODI Cuenta,
                INITCAP(utl_raw.cast_to_varchar2(nlssort(CUCOCATE, ''nls_sort=binary_ai''))) Categoria,
                INITCAP(utl_raw.cast_to_varchar2(nlssort(CUCOSUCA, ''nls_sort=binary_ai''))) Subcategoria,
                INITCAP(utl_raw.cast_to_varchar2(nlssort(CUCOPLSU, ''nls_sort=binary_ai''))) Plan,
                CUCONUSE Producto,
                INITCAP(utl_raw.cast_to_varchar2(nlssort(CARGCONC, ''nls_sort=binary_ai''))) Concepto,
                UPPER(utl_raw.cast_to_varchar2(nlssort(CARGSIGN, ''nls_sort=binary_ai''))) Signo,
                CARGVALO Valor_Recupera,
                CARGUNID Unidades_Recupera,
                UPPER(utl_raw.cast_to_varchar2(nlssort(CARGDOSO, ''nls_sort=binary_ai''))) Docu_Soporte,
                CARGPEFA Periodo_Cargo,
                INITCAP(utl_raw.cast_to_varchar2(nlssort(TO_CHAR(CARGFECR,''DD/MM/YYYY HH24:MI:SS''), ''nls_sort=binary_ai''))) Fecha_Creacion,
                INITCAP(utl_raw.cast_to_varchar2(nlssort(CARGPROG, ''nls_sort=binary_ai''))) Programa_Cargo,
                CARGPECO Periodo_Consumo,
                INITCAP(utl_raw.cast_to_varchar2(nlssort(PERIFACT_ANT, ''nls_sort=binary_ai''))) Periodo_Anterior,
                INITCAP(utl_raw.cast_to_varchar2(nlssort(ESTIMACION, ''nls_sort=binary_ai''))) Estimacion
            FROM ('||sbSentemp||')
            ';
            
            rcProcejec := NULL;
            PKBCPROCEJEC.GETRECBYPROGBILLPERIOD (nuPeriodo,csbFGCC,rcProcejec);
            nuCiclo := Pktblperifact.Fnugetcycle(nuPeriodo);

            sbMensajeEMB := sbMensajeEMB||'        '||'Periodo ['||nuPeriodo||'], ciclo ['||nuCiclo||' - '||Pktblciclcons.Fsbgetdescription(nuCiclo)||'], ';
            sbMensajeEMB := sbMensajeEMB||'generado el ['||TO_CHAR(rcProcejec.prejfech,'DD/MM/YYYY HH24:MI:SS')||']';
            
            IF nuContador = 1 THEN
                sbNomArch := REPLACE(sbNomArch,'[FECHA]',TO_CHAR(rcProcejec.prejfech,'DDMMYYYY'));
                sbAsuntoEM := REPLACE(sbAsuntoEM,'[FECHA]',TO_CHAR(rcProcejec.prejfech,'DD/MM/YYYY'));
                sbMensajeEM := REPLACE(sbMensajeEM,'[FECHA]',TO_CHAR(rcProcejec.prejfech,'DD/MM/YYYY'));
                sbMensajeEM := REPLACE(sbMensajeEM,'[ESTADO]',rcProcejec.prejespr);
                sbMensajeEM := REPLACE(sbMensajeEM,'[TOPE]',TRIM(TO_CHAR(nuTopeConsRec,'$9999999999')));
                sbMensajeEMF := REPLACE(sbMensajeEMF,'[ARCHIVO]',sbNomArch);
            END IF;
            
            pkg_traza.trace(csbSP_NAME||csbMT_NAME||sbSubMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
            
        END proInic;
        
        FUNCTION fnuCantidadReg 
        RETURN NUMBER IS
            sbSubMT_NAME  VARCHAR2(30) := '.fnuCantidadReg';
            nuCantReg   NUMBER;
        BEGIN
            pkg_traza.trace(csbSP_NAME||csbMT_NAME||sbSubMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);
            
            IF cuTotalConsumosRec%ISOPEN THEN
                CLOSE cuTotalConsumosRec;
            END IF;
            
            nuCantReg := 0;
            OPEN cuTotalConsumosRec(nuPeriodo,nuTopeConsRec);
            FETCH cuTotalConsumosRec INTO nuCantReg;
            CLOSE cuTotalConsumosRec;
            
            pkg_traza.trace(csbSP_NAME||csbMT_NAME||sbSubMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
            
            RETURN nuCantReg;
        EXCEPTION
            WHEN OTHERS THEN
                pkg_traza.trace('Finaliza con Error Controlado ' ||csbSP_NAME||csbMT_NAME||sbSubMT_NAME, cnuNVLTRC);
                nuCantReg := 0;
                RETURN nuCantReg;    
        END fnuCantidadReg;
        
        PROCEDURE proReporteExcel(p_sql IN VARCHAR2) IS
            sbSubMT_NAME  VARCHAR2(30) := '.proReporteExcel';
            v_v_val     VARCHAR2(4000);
            v_n_val     NUMBER;
            v_d_val     DATE;
            v_ret       NUMBER;
            c           NUMBER;
            d           NUMBER;
            col_cnt     INTEGER;
            f           BOOLEAN;
            rec_tab     DBMS_SQL.DESC_TAB;
            col_num     NUMBER;
        BEGIN
            pkg_traza.trace(csbSP_NAME||csbMT_NAME||sbSubMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);
            
            --Inicia_Query
            c := DBMS_SQL.OPEN_CURSOR;
            -- se analiza la instruccion SQL --
            DBMS_SQL.PARSE(c, p_sql, DBMS_SQL.NATIVE);
            -- se incia la ejecucion de la sentencia SQL --
            d := DBMS_SQL.EXECUTE(c);
            -- se obtiene la descripcion de las columnas devueltas --
            DBMS_SQL.DESCRIBE_COLUMNS(c, col_cnt, rec_tab);
            -- se enlaza las variables a la columnas por medio de un ciclo FOR --
            FOR j in 1..col_cnt LOOP
                CASE rec_tab(j).col_type
                    WHEN 1 THEN DBMS_SQL.DEFINE_COLUMN(c,j,v_v_val,4000);
                    WHEN 2 THEN DBMS_SQL.DEFINE_COLUMN(c,j,v_n_val);
                    WHEN 12 THEN DBMS_SQL.DEFINE_COLUMN(c,j,v_d_val);
                    ELSE DBMS_SQL.DEFINE_COLUMN(c,j,v_v_val,4000);
                END CASE;
            END LOOP;

            -- Aqui se muestra la salida de los encabezados de columna
            IF nuContador = 1 THEN
                pkg_gestionArchivos.prcEscribirLinea_SMF(clReporte,'<ss:Row>');
                FOR j in 1..col_cnt LOOP
                    pkg_gestionArchivos.prcEscribirLinea_SMF(clReporte,'<ss:Cell>');
                    pkg_gestionArchivos.prcEscribirLinea_SMF(clReporte,'<ss:Data ss:Type="String">'||rec_tab(j).col_name||'</ss:Data>');
                    pkg_gestionArchivos.prcEscribirLinea_SMF(clReporte,'</ss:Cell>');
                END LOOP;
                pkg_gestionArchivos.prcEscribirLinea_SMF(clReporte,'</ss:Row>');
            END IF;

            -- datos de salida
            LOOP
                v_ret := DBMS_SQL.FETCH_ROWS(c);
                EXIT WHEN v_ret = 0;
                pkg_gestionArchivos.prcEscribirLinea_SMF(clReporte,'<ss:Row>');
                FOR j in 1..col_cnt LOOP
                    CASE rec_tab(j).col_type
                        WHEN 1 THEN DBMS_SQL.COLUMN_VALUE(c,j,v_v_val);
                             pkg_gestionArchivos.prcEscribirLinea_SMF(clReporte,'<ss:Cell>');
                              pkg_gestionArchivos.prcEscribirLinea_SMF(clReporte,'<ss:Data ss:Type="String">'||v_v_val||'</ss:Data>');
                              pkg_gestionArchivos.prcEscribirLinea_SMF(clReporte,'</ss:Cell>');
                        WHEN 2 THEN DBMS_SQL.COLUMN_VALUE(c,j,v_n_val);
                              pkg_gestionArchivos.prcEscribirLinea_SMF(clReporte,'<ss:Cell>');
                              pkg_gestionArchivos.prcEscribirLinea_SMF(clReporte,'<ss:Data ss:Type="Number">'||to_char(v_n_val)||'</ss:Data>');
                              pkg_gestionArchivos.prcEscribirLinea_SMF(clReporte,'</ss:Cell>');
                        WHEN 12 THEN DBMS_SQL.COLUMN_VALUE(c,j,v_d_val);
                              pkg_gestionArchivos.prcEscribirLinea_SMF(clReporte,'<ss:Cell ss:StyleID="OracleDate">');
                              pkg_gestionArchivos.prcEscribirLinea_SMF(clReporte,'<ss:Data ss:Type="DateTime">'||to_char(v_d_val,'YYYY-MM-DD"T"HH24:MI:SS')||'</ss:Data>');
                              pkg_gestionArchivos.prcEscribirLinea_SMF(clReporte,'</ss:Cell>');
                    ELSE
                        DBMS_SQL.COLUMN_VALUE(c,j,v_v_val);
                        pkg_gestionArchivos.prcEscribirLinea_SMF(clReporte,'<ss:Cell>');
                        pkg_gestionArchivos.prcEscribirLinea_SMF(clReporte,'<ss:Data ss:Type="String">'||v_v_val||'</ss:Data>');
                        pkg_gestionArchivos.prcEscribirLinea_SMF(clReporte,'</ss:Cell>');
                    END CASE;
                END LOOP;
                pkg_gestionArchivos.prcEscribirLinea_SMF(clReporte,'</ss:Row>');
            END LOOP;
            DBMS_SQL.CLOSE_CURSOR(c);
            
            pkg_traza.trace(csbSP_NAME||csbMT_NAME||sbSubMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
        EXCEPTION
            WHEN OTHERS THEN
                pkg_traza.trace('Finaliza con Error No Controlado ' ||csbSP_NAME||csbMT_NAME||sbSubMT_NAME, cnuNVLTRC);
                sbMensaje := 'Error en ejecución sentencia para el reporte. Periodo '||nuPeriodo||'/'||isbPeriodos||'. '||sqlerrm;
                raise raise_continuar;      
        END proReporteExcel;
        
        PROCEDURE proAbrirExcel IS
            sbSubMT_NAME  VARCHAR2(30) := '.proAbrirExcel';
        BEGIN
            pkg_traza.trace(csbSP_NAME||csbMT_NAME||sbSubMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);
            
            clReporte := pkg_gestionArchivos.ftAbrirArchivo_SMF( '/tmp', sbNomArch, 'W' );
            
            --start_workbook
            pkg_gestionArchivos.prcEscribirLinea_SMF(clReporte,'<?xml version="1.0"?>');
            pkg_gestionArchivos.prcEscribirLinea_SMF(clReporte,'<ss:Workbook xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet">');
            --set_date_style
            pkg_gestionArchivos.prcEscribirLinea_SMF(clReporte,'<ss:Styles>');
            pkg_gestionArchivos.prcEscribirLinea_SMF(clReporte,'<ss:Style ss:ID="OracleDate">');
            pkg_gestionArchivos.prcEscribirLinea_SMF(clReporte,'<ss:NumberFormat ss:Format="dd/mm/yyyy\ hh:mm:ss"/>');
            pkg_gestionArchivos.prcEscribirLinea_SMF(clReporte,'</ss:Style>');
            pkg_gestionArchivos.prcEscribirLinea_SMF(clReporte,'</ss:Styles>');
            --start_worksheet
            pkg_gestionArchivos.prcEscribirLinea_SMF(clReporte,'<ss:Worksheet ss:Name="'||sbNomHoja||'">');
            pkg_gestionArchivos.prcEscribirLinea_SMF(clReporte,'<ss:Table>');
            
            pkg_traza.trace(csbSP_NAME||csbMT_NAME||sbSubMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
            
        END proAbrirExcel;
        
        PROCEDURE procierreExcel IS
            sbSubMT_NAME  VARCHAR2(30) := '.proEndExcel';
        BEGIN
            pkg_traza.trace(csbSP_NAME||csbMT_NAME||sbSubMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);
            
            --end_worksheet
            pkg_gestionArchivos.prcEscribirLinea_SMF(clReporte,'</ss:Table>');
            pkg_gestionArchivos.prcEscribirLinea_SMF(clReporte,'</ss:Worksheet>');
            --end_workbook
            pkg_gestionArchivos.prcEscribirLinea_SMF(clReporte,'</ss:Workbook>');
            
            pkg_gestionArchivos.prcCerrarArchivo_SMF(clReporte);
            
            pkg_traza.trace(csbSP_NAME||csbMT_NAME||sbSubMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
            
        END proCierreExcel;

    BEGIN
        pkg_traza.trace(csbSP_NAME||csbMT_NAME,cnuNVLTRC, pkg_traza.csbINICIO);
        
        -- Inicializa parametros y variables
        proParam;
        
        -- Procesa Periodos
        FOR rcPeriodo IN cuPeriodos(isbPeriodos) LOOP
        
            BEGIN
                nuPeriodo := rcPeriodo.Periodo;
                
                -- Consulta total poblacion objetivo
                nuCantidad := fnuCantidadReg;
            
                -- Valida si genera notificacion para el periodo
                IF nuCantidad > 0 THEN
                
                    nuContador := nuContador + 1;
                    -- Inicializacion datos del periodo
                    proInic;
                    
                    IF nuContador = 1 THEN
                        --Abre Excel
                        proAbrirExcel;
                        
                    END IF;
                
                    --Genera informacion del reporte para el anexo en Excel
                    proReporteExcel(clSentencia);
                    
                ELSE
                    pkg_traza.trace(csbTb||'No existen consumos recuperados para el periodo ['||nuPeriodo||'], que excedan el tope ['||TRIM(TO_CHAR(nuTopeConsRec,'$9999999999'))||']',cnuNVLTRC);
                END IF;
            EXCEPTION
                WHEN raise_continuar THEN
                    pkg_traza.trace('Finaliza con Error Controlado ['||nuPeriodo||']-'||csbSP_NAME||csbMT_NAME,cnuNVLTRC);
                    IF cnuRaiseError = 1 THEN
                        raise;
                    END IF;
                WHEN OTHERS THEN
                    pkg_traza.trace('Finaliza con Error No Controlado ['||nuPeriodo||']-'||csbSP_NAME||csbMT_NAME,cnuNVLTRC);
                    IF cnuRaiseError = 1 THEN
                        sbMensaje := 'Error en analisis de periodos. Periodo '||nuPeriodo||'/'||isbPeriodos||'. '||sqlerrm;
                        raise raise_continuar;
                    END IF;
            END;
            
        END LOOP;
        
        IF nuContador > 0 THEN
            -- Cierre Excel
            proCierreExcel;
            
            --Envio de notificacion
            IF sbEmailNoti IS NOT NULL THEN
                    
                BEGIN
                    pkg_traza.trace(csbTb||'Envio de e-mail ['||sbEmailNoti||']',cnuNVLTRC);

                    pkg_Correo.prcEnviaCorreo
                    (
                        isbDestinatarios    => TRIM(sbEmailNoti),
                        isbAsunto           => sbAsuntoEM,
                        isbMensaje          => sbMensajeEM||sbMensajeEMB||sbMensajeEMF||'<br>',
                        isbArchivos         => 'XML_DIR/' || sbNomArch
                    );
                EXCEPTION
                    WHEN OTHERS THEN
                        sbMensaje := 'Se presenta error en el envío de notificación de consumos recuperados altos. Periodos '||isbPeriodos||'. '||sqlerrm;
                        raise raise_continuar;
                END;
            END IF;
        END IF;
        
        pkg_traza.trace(csbSP_NAME||csbMT_NAME,cnuNVLTRC, pkg_traza.csbFIN);
        
    EXCEPTION
        WHEN raise_NCont THEN
            pkg_traza.trace('Finaliza con Error Controlado '||csbSP_NAME||csbMT_NAME||'. '||sbMensaje,cnuNVLTRC);
            IF cnuRaiseError = 1 THEN
                RAISE raise_continuar;
            END IF;
        WHEN raise_continuar THEN
            pkg_traza.trace('Finaliza con Error Controlado '||csbSP_NAME||csbMT_NAME||'. '||sbMensaje,cnuNVLTRC);
            IF cnuRaiseError = 1 THEN
                pEnvioMail(sbMensaje); 
                RAISE;
            END IF;
        WHEN pkg_Error.CONTROLLED_ERROR THEN  
            pkg_Error.getError(nuerror,sberror);
            sbMensaje := sberror;
            pkg_traza.trace('Finaliza con Error Controlado '||csbSP_NAME||csbMT_NAME||'. '||sberror,cnuNVLTRC);
            IF cnuRaiseError = 1 THEN
                pEnvioMail(sbMensaje); 
                RAISE raise_continuar;
            END IF;
        WHEN OTHERS THEN
            sbMensaje := sqlerrm;
            pkg_traza.trace('Finaliza con Error No Controlado '||csbSP_NAME||csbMT_NAME||'. '||sqlerrm,cnuNVLTRC);
            IF cnuRaiseError = 1 THEN
                pEnvioMail(sbMensaje); 
                RAISE raise_continuar;
            END IF;
    END pNotyConsRec;
    
    /*******************************************************************************
    Metodo:         pValidaPeriodosD
    Descripcion:    Identifica periodos de facturacion que ya finalizaron el proceso FGCC 
                    y ejecuta pNotyConsRec para identificacion y notificacion de consumos 
                    recuperados altos
                    
    Autor:          Juan Gabriel Catuche Giron 
    Fecha:          22/12/2022

    Entrada         Descripcion
    NA
    
    Salida          Descripcion
    NA
    
    Historial de Modificaciones
    =============================
    FECHA           AUTOR               DESCRIPCION
    11/01/2023      jcatuchemvm         OSF-748: Ajuste, se agrega log de ejecucion en
                                        ldc_osf_estaproc
    22/12/2022      jcatuchemvm         OSF-748: Creacion
    *******************************************************************************/    
    PROCEDURE pValidaPeriodosD IS
        ----------------------------------------
        -- Constantes del procedimiento:
        ----------------------------------------
        csbMT_NAME              CONSTANT VARCHAR2(30) := 'pValidaPeriodosD';
        
        CURSOR cuProcesos IS 
        SELECT /*+ index ( p IX_PROCEJEC03 ) */ 
        UNIQUE prejcope 
        FROM procejec p
        WHERE prejprog = 'FGCC'
        AND prejespr = 'T'
        AND EXISTS
        (
            SELECT /*+ ( e IX_ESTAPROG02 ) */ 'x'
            FROM estaprog
            WHERE esprpefa = prejcope
            AND esprfefi IS NOT NULL
            AND esprprog like 'FGCC%'
            AND ut_Date.FDTTRUNCATEDATE(esprfefi) = ut_Date.FDTTRUNCATEDATE(LDC_BOConsGenerales.fdtGetSysdate-1)
        )
        ;

        
        -- Variables del procedimiento
        sbPeriodos      VARCHAR2(200);    
        nuvaano         NUMBER(4);
        nuvames         NUMBER(2); 
        nutsess         NUMBER;
        sbparuser       VARCHAR2(30);
        sbrowid         UROWID;
    BEGIN        
        pkg_traza.trace(csbSP_NAME||csbMT_NAME,cnuNVLTRC, pkg_traza.csbINICIO);
                
        nutsess     := USERENV('SESSIONID');
        sbparuser   := USER;
        nuvaano     := TO_NUMBER(TO_CHAR(LDC_BOConsGenerales.fdtGetSysdate,'YYYY'));
        nuvames     := ut_Date.FNUGETNUMBERMONTH(LDC_BOConsGenerales.fdtGetSysdate);
        
        
        ldc_proinsertaestaprogv2(nuvaano,nuvames,'LDCBONOTYCONSREC','En ejecucion',nutsess,sbparuser,sbrowid);
        
        sbPeriodos := NULL;
        FOR rp IN cuProcesos LOOP
            
            IF sbPeriodos IS NULL THEN
                sbPeriodos := rp.prejcope;
            ELSE
                sbPeriodos := sbPeriodos||','||rp.prejcope;
            END IF;
        
        END LOOP;
        
        IF sbPeriodos IS NOT NULL THEN
            sbMensaje := 'Periodos procesados para el día '||TO_CHAR(ut_Date.FDTTRUNCATEDATE(LDC_BOConsGenerales.fdtGetSysdate-1),'DD/MM/YYYY')||' ['||sbPeriodos||']';
            pkg_traza.trace(sbMensaje,cnuNVLTRC);
            -- Analiza y notifica periodos
            ldc_boNotyConsRec.pNotyConsRec(sbPeriodos); 
        ELSE
            sbMensaje := 'Sin periodos a procesar para el día '||TO_CHAR(ut_Date.FDTTRUNCATEDATE(LDC_BOConsGenerales.fdtGetSysdate-1),'DD/MM/YYYY');
            pkg_traza.trace(sbMensaje,cnuNVLTRC);
        END IF;
        
        ldc_proactualizaestaprogv2(nutsess,sbMensaje,'LDCBONOTYCONSREC','Ok',sbrowid);
        
        pkg_traza.trace(csbSP_NAME||csbMT_NAME,cnuNVLTRC, pkg_traza.csbFIN);
    EXCEPTION
        WHEN raise_continuar THEN
            pkg_traza.trace('Finaliza con Error Controlado '||csbSP_NAME||csbMT_NAME||'. '||sbMensaje,cnuNVLTRC);
            IF cnuRaiseError = 1 THEN
                ldc_proactualizaestaprogv2(nutsess,sbMensaje,'LDCBONOTYCONSREC','con errores',sbrowid);
            END IF;
        WHEN OTHERS THEN
            pkg_traza.trace('Finaliza con Error No Controlado '||csbSP_NAME||csbMT_NAME||'. '||sqlerrm,cnuNVLTRC);
            IF cnuRaiseError = 1 THEN
                ldc_proactualizaestaprogv2(nutsess,sqlerrm,'LDCBONOTYCONSREC','con errores',sbrowid);
            END IF;
    END pValidaPeriodosD;
    
    /*******************************************************************************
    Metodo:         pProgramaJob
    Descripcion:    Programa Job para ejecucion del procedimiento pNotyConsRec para
                    ejecucion unica
                    
    Autor:          Juan Gabriel Catuche Giron 
    Fecha:          22/12/2022

    Entrada         Descripcion
    inuPeriodo      Periodo de facturacion      

    Salida          Descripcion
    NA
    
    Historial de Modificaciones
    =============================
    FECHA           AUTOR               DESCRIPCION
    22/12/2022      jcatuchemvm         OSF-748: Creacion
    *******************************************************************************/    
    PROCEDURE pProgramaJob(inuPeriodo IN perifact.pefacodi%TYPE) IS
        ----------------------------------------
        -- Constantes del procedimiento:
        ----------------------------------------
        csbMT_NAME              CONSTANT VARCHAR2(30) := 'pProgramaJob';
        
        -- Variables del procedimiento
        sbJobName               VARCHAR2(30);
    BEGIN        
        pkg_traza.trace(csbSP_NAME||csbMT_NAME,cnuNVLTRC, pkg_traza.csbINICIO);
        
        sbJobName := 'LDC_GEN_NOTI_CONSREC_'||TO_CHAR(inuPeriodo);
        
        DBMS_SCHEDULER.CREATE_JOB 
        (
            job_name            => sbJobName,
            job_type            => 'STORED_PROCEDURE',
            job_action          => 'LDC_BONOTYCONSREC.pNotyConsRec',
            repeat_interval     => NULL,
            start_date          => NULL,
            number_of_arguments => 1,
            auto_drop           => TRUE,
            comments            => 'Procedimiento para identificar consumos recuperados altos. Periodo '||inuPeriodo
        );
            
        DBMS_SCHEDULER.SET_JOB_ARGUMENT_VALUE(job_name => sbJobName, argument_position  => 1, argument_value => TO_CHAR(inuPeriodo));
        
        pkg_traza.trace(csbSP_NAME||csbMT_NAME,cnuNVLTRC, pkg_traza.csbFIN);
    
    EXCEPTION
        WHEN OTHERS THEN
            pkg_traza.trace('Finaliza con Error No Controlado '||csbSP_NAME||csbMT_NAME||'. '||sqlerrm,cnuNVLTRC);
            IF cnuRaiseError = 1 THEN
                pkg_Error.SetError;
                RAISE pkg_Error.CONTROLLED_ERROR;
            END IF;
    END pProgramaJob;
    
    /*******************************************************************************
    Metodo:         pJob
    Descripcion:    Programa Job para ejecucion del procedimiento pNotyConsRec para 
                    ejecucion diaria
                    
    Autor:          Juan Gabriel Catuche Giron 
    Fecha:          22/12/2022

    Entrada         Descripcion
    NA

    Salida          Descripcion
    NA
    
    Historial de Modificaciones
    =============================
    FECHA           AUTOR               DESCRIPCION
    22/12/2022      jcatuchemvm         OSF-748: Creacion
    *******************************************************************************/    
    PROCEDURE pJob IS
        ----------------------------------------
        -- Constantes del procedimiento:
        ----------------------------------------
        csbMT_NAME              CONSTANT VARCHAR2(30) := 'pProgramaJob';
        
        -- Variables del procedimiento
        sbJobName               VARCHAR2(30);
        nuExsisteJob            NUMBER;
    BEGIN        
        pkg_traza.trace(csbSP_NAME||csbMT_NAME,cnuNVLTRC, pkg_traza.csbINICIO);
        
        sbJobName := 'LDC_GENNOTICONSREC';
        
        SELECT COUNT(*) INTO nuExsisteJob  
        FROM ALL_SCHEDULER_JOBS
        WHERE JOB_NAME=sbJobName;
    
        IF nuExsisteJob = 0 THEN
            pkg_traza.trace('Se crea el Job '||sbJobName,cnuNVLTRC);
            DBMS_SCHEDULER.CREATE_JOB 
            (
                job_name            => sbJobName,
                job_type            => 'STORED_PROCEDURE',
                job_action          => 'LDC_BONOTYCONSREC.pValidaPeriodosD',
                repeat_interval     => 'FREQ=DAILY; BYHOUR=6; BYMINUTE=0; BYSECOND=0',
                start_date          => UT_DATE.FDTSYSDATEPLUSONEDAY+21600/86400,
                number_of_arguments => 0,
                auto_drop           => FALSE,
                comments            => 'Job que identifica consumos recuperados altos por dia'
            );
            
            DBMS_SCHEDULER.ENABLE(name => sbJobName);      
        ELSE
            pkg_traza.trace('Ya existe el Job '||sbJobName||', se reprograma',cnuNVLTRC);
            DBMS_SCHEDULER.DISABLE(name => sbJobName);
            DBMS_SCHEDULER.SET_ATTRIBUTE
            (
                name        => sbJobName,
                attribute   => 'job_action',
                value       => 'LDC_BONOTYCONSREC.pValidaPeriodosD'                
            ); 
            
            DBMS_SCHEDULER.SET_ATTRIBUTE
            (
                name        => sbJobName,
                attribute   => 'job_type',
                value       => 'STORED_PROCEDURE'                
            ); 
            
            DBMS_SCHEDULER.SET_ATTRIBUTE
            (
                name        => sbJobName,
                attribute   => 'repeat_interval',
                value       => 'FREQ=DAILY; BYHOUR=6; BYMINUTE=0; BYSECOND=0'                
            ); 
            
            
            DBMS_SCHEDULER.ENABLE(name => sbJobName);   
                 
        END IF;
        
        pkg_traza.trace(csbSP_NAME||csbMT_NAME,cnuNVLTRC, pkg_traza.csbFIN);

    EXCEPTION
        WHEN OTHERS THEN
            pkg_traza.trace('Finaliza con Error No Controlado '||csbSP_NAME||csbMT_NAME||'. '||sqlerrm,cnuNVLTRC);
            IF cnuRaiseError = 1 THEN
                pkg_Error.SetError;
                RAISE pkg_Error.CONTROLLED_ERROR;
            END IF;
    END pJob;

END LDC_BONOTYCONSREC;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_BONOTYCONSREC', 'ADM_PERSON');
END;
/