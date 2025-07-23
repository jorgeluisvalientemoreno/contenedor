CREATE OR REPLACE PROCEDURE pbgada(inuProgramacion IN ge_process_schedule.process_schedule_id%type)
/**************************************************************************
<Procedure Fuente="Propiedad Intelectual de <Empresa>">
<Unidad> pbgada </Unidad>
<Autor>Paola Acosta</Autor>
<Fecha> 26-02-2025 </Fecha>
<Descripcion> 
    Servicio de procesamiento de la funcionalidad PBGADA
</Descripcion>
<Historial>
       <Modificacion Autor="Paola.Acosta" Fecha="26-02-2025" Inc="OSF-4041" Empresa="GDC">
           Creación
       </Modificacion>
</Historial>
</Procedure>
**************************************************************************/
IS
    -- Variables privadas del package    
    nuError		NUMBER;  		
    sbMensaje   VARCHAR2(1000);

    --Constantes
    csbMtd_nombre       VARCHAR2(70)          := 'pbgada';   
    nuHilos             NUMBER := 1;
    cnuNvlTrc           CONSTANT NUMBER       := pkg_traza.cnuniveltrzdef;
    csbInicio   		CONSTANT VARCHAR2(35) := pkg_traza.csbInicio;
    csbFin              CONSTANT VARCHAR2(35) := pkg_traza.csbFin;
    csbFin_err          CONSTANT VARCHAR2(35) := pkg_traza.csbFin_err;
    csbFin_erc          CONSTANT VARCHAR2(35) := pkg_traza.csbfin_erc;  
    
    
    --Variables
    nuPFmes         ge_boInstanceControl.stysbValue;
    nuPFAno         ge_boInstanceControl.stysbValue;        
    nuPFCiclo       ge_boInstanceControl.stysbValue;       
    nuPFcodigo      ge_boInstanceControl.stysbValue; 
    nuLogProcesoId  ge_process_log.process_log_id%type;
    sbParametros    ge_process_schedule.parameters_%type;
    
    --Cursores
    CURSOR cuPeiodoFact(inuPFAno    IN perifact.pefaano%TYPE, 
                        inuPFMes    IN perifact.pefames%TYPE,                            
                        inuPFCiclo  IN perifact.pefacicl%TYPE)
    IS                            
    SELECT  pefacodi
    FROM    perifact
    WHERE   pefaano = inuPFAno
        AND pefames = inuPFMes
        AND pefacicl = inuPFCiclo;
    
        /**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> prcGenerarArchivoDA </Unidad>
    <Autor>Paola Acosta</Autor>
    <Fecha> 27-02-2025 </Fecha>
    <Descripcion> 
        Procedimiento para generar Archivos de Debito Automatico basados en las Configuraciones de FGIA       
    </Descripcion>
    <Historial>
           <Modificacion Autor="Paola.Acosta" Fecha="27-02-2025" Inc="OSF-4041" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </Procedure>
    **************************************************************************/
    PROCEDURE prcGenerarArchivoDA(inuPeriFact IN perifact.pefacodi%TYPE) 
    IS    
        --Constantes
        csbMtd_nombre       VARCHAR2(70) := 'prcGenerarArchivoDA';    
        
        sbagrupxdpto       VARCHAR2(2);
        sbconsecutivo      VARCHAR2(2);
        sbmodoejecucion    VARCHAR2(2);
        sbquery            VARCHAR2(4000);
        nudiasejecucion    NUMBER;
        
        --codigos de bancos a procesar
        CURSOR curbancos IS
        SELECT column_value
        FROM   TABLE ( ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('JOBDEBAUTOENTBANC'), ',') );
    
        sbbanco            VARCHAR2(4);
      
        --formatos por banco
        CURSOR curformatos (
            inubancoid NUMBER
        ) IS
        SELECT pdenpren,
               pdenprde,
               pdenprto,
               pdenpres,
               pdenprva,
               pdenpato
        FROM   prdaenti p
        WHERE  p.pdenbanc = inubancoid
           AND p.pdeneven = 2
           AND ROWNUM = 1;
    
        sbpdenpren         VARCHAR2(120);
        sbpdenprde         VARCHAR2(120);
        sbpdenprto         VARCHAR2(120);
        sbpdenpres         VARCHAR2(120);
        sbpdenprva         VARCHAR2(120);
        sbpdenpato         VARCHAR2(200);
        
        CURSOR curobjetos (
            isbformato VARCHAR2
        ) IS
        SELECT frarcrar,
               crartida,
               frarloma,
               nvl(frardeci, 0),
               frarfoca,
               frarcoca
        FROM   forearre,
               carearre
        WHERE  crarnoca = frarcrar
           AND frartrar = isbformato
        ORDER BY frarpoin;
        --
        sbfrarcrar         VARCHAR2(100);
        sbcrartida         VARCHAR2(100);
        nufrarloma         NUMBER;
        nufrardeci         NUMBER;
        sbfrarfoca         VARCHAR2(100);
        sbfrarcoca         VARCHAR2(100);
        sbaplicarfecha     VARCHAR2(2);
        sbtempcadena       VARCHAR2(4000);
        sbencabezadofile   VARCHAR2(4000);
        sbencabezadolote   VARCHAR2(4000);
        
        TYPE detallesarray IS 
        TABLE OF VARCHAR2(4000) INDEX BY PLS_INTEGER;
        
        sbarraydetalles    detallesarray;
        sbtotaldetalle     VARCHAR2(4000);
        sbtotalfile        VARCHAR2(4000);
        sbquerydpto        VARCHAR2(4000);
        
        TYPE cur_typ IS 
        REF CURSOR;
        
        curdepto           cur_typ;
        nucoddepto         NUMBER;
        sbdescdepto        VARCHAR2(5);
        --
        curfechas          SYS_REFCURSOR;
        dtfecha            DATE;
        sbquerydetail      VARCHAR2(4000);
        curdetalles        SYS_REFCURSOR;
        nucontdetail       NUMBER;
        nususccodi         NUMBER;
        nupefames          NUMBER;
        nususccicl         NUMBER;
        --nuCucosacu         number(14, 2); --Caso 656_2
        nucucosacu         NUMBER;
        sbcucofepa         VARCHAR2(20);
        sbsusccuco         VARCHAR2(30);
        nususctcba         NUMBER;
        sbidentification   VARCHAR2(20);
        --nuTotalesV         number(14, 2); --Caso 656_2
        nutotalesv         NUMBER;
        nucuponnume        NUMBER;
        sbnamefile         VARCHAR2(50);
        fldebitoauto       utl_file.file_type;
        nuciclo            NUMBER;
        sbstatusfile       VARCHAR2(4000) := NULL;
      --Caso 656_2
        CURSOR curdestinatarios IS
        SELECT column_value
        FROM   TABLE ( ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('JOBDEBAUTOMAILRECEIVE'), ';') );
    
        sbdestinatariomail VARCHAR2(100);
        sbasuntomail       VARCHAR2(200);
        sbmsgerror         VARCHAR2(255) := NULL;
      --
        nusecuencia        NUMBER := 97; --codigo ascii de la letra a
      --Caso 656_3
        nuparano           NUMBER(4);
        nuparmes           NUMBER(2);
        nutsess            NUMBER;
        sbparuser          VARCHAR2(30);
      --
      --caso 656_8
        nucodgst_prevdeau  NUMBER;
        nuperiodofact      NUMBER;
        sbnumfactura       VARCHAR2(100);
        nueventbanc        NUMBER := dald_parameter.fnugetnumeric_value('JOBDEBAUTOEVENTBANC');
        sbstathistevpr     VARCHAR2(10) := dald_parameter.fsbgetvalue_chain('JOBDEBAUTOESTHISTEVPR');
        sbstathistdesusc   VARCHAR2(10) := dald_parameter.fsbgetvalue_chain('JOBDEBAUTOESTHISTDEBSUSC');
        
        CURSOR cuexistgstprevdeau (
            inubanco   NUMBER,
            inuevento  NUMBER,
            inuciclo   NUMBER,
            inuperiodo NUMBER
        ) IS
        SELECT g.prdecodi
        FROM   gst_prevdeau g
        WHERE  g.prdebanc = inubanco
           AND g.prdeevda = inuevento
           AND g.prdecifa = inuciclo
           AND g.prdepefa = inuperiodo;
        --
        --Caso 656_10
        nuvaluedebit       NUMBER;
        --
        PROCEDURE sendmail (
            isbmsg VARCHAR2
        ) IS
        BEGIN
            sbasuntomail := dald_parameter.fsbgetvalue_chain('JOBDEBAUTOMAILSUBJECT');
        --Caso 656_2
            OPEN curdestinatarios;
            LOOP
                FETCH curdestinatarios INTO sbdestinatariomail;
                EXIT WHEN curdestinatarios%notfound;
                ldc_sendemail(sbdestinatariomail, sbasuntomail, isbmsg);
            END LOOP;
    
            CLOSE curdestinatarios;
        END sendmail;
    
    BEGIN
        pkg_traza.trace(csbMtd_nombre, cnuNvlTrc, csbInicio);
        --Caso 656_3
        -- Consultamos datos para inicializar el proceso
        SELECT
            to_number(to_char(sysdate, 'YYYY')),
            to_number(to_char(sysdate, 'MM')),
            userenv('SESSIONID'),
            user
        INTO
            nuparano,
            nuparmes,
            nutsess,
            sbparuser
        FROM
            dual;
        -- Inicializamos el proceso
        ldc_proinsertaestaprog(nuparano, nuparmes, 'prcGenerarArchivoDA', 'En ejecucion', nutsess,
                              sbparuser);
        --
        /*lOGICA:
        1.  Se deberá inicializar las siguientes variables:
        a.  Se determinará a partir del valor del parámetro JOBDEBAUTOAGRUPADPTO si el archivo estará agrupado o no por Departamento*/
        /*i.  Si se va a aplicar agrupamiento por departamento, se deberán identificar todos los departamentos disponibles.*/ /*se hace durante el proceso de consulta de cuentas*/
        sbagrupxdpto := dald_parameter.fsbgetvalue_chain('JOBDEBAUTOAGRUPADPTO');
        IF
            sbagrupxdpto <> 'S'
            AND sbagrupxdpto <> 'N'
        THEN
            sbmsgerror := 'Indique en el parametro JOBDEBAUTOAGRUPADPTO si se realizara Agrupamiento por Departamentos.';
            RAISE ex.controlled_error;
        END IF;
        /*b.  Se inicializará el consecutivo que se agregará a los nombres del archivo y al encabezado del archivo, esta variable se inicializará con la letra a.
        i.  El consecutivo deberá incrementar con cada archivo pasando hasta z y continuando del 0 al 9*/
        sbconsecutivo := chr(nusecuencia);
        /*c.  Se deberán identificar los contratos que cumplan las siguientes condiciones:
        i.  Cuentas de cobro que estén pendientes de pago (CUENCOBR.CUCOSACU > 0)
        ii. Contratos que implemente el Debito Automático (SUSCRIPC.SUSCTDCO = `DA¿)
       */
        sbmodoejecucion := dald_parameter.fsbgetvalue_chain('JOBDEBAUTOMODOEJEC');
        nudiasejecucion := nvl(dald_parameter.fnugetnumeric_value('JOBDEBAUTODIASEJEC'), 0);
        --cambio cucofepa por cucofeve --Caso 656_3
        --se controla la fecha para que no se repitan --Caso 656_7
        sbquery := 'select to_date(fecha, ''yyyy-mm-dd'') from (Select to_char(cc.cucofeve, ''yyyy-mm-dd'') as fecha';       
        --cambio cucofepa por cucofeve --Caso 656_3
        
        sbquery := sbquery
                   || ' From suscripc s, servsusc ss, cuencobr cc, perifact p, factura f
                    where ss.sesususc = s.susccodi
                    and cc.cuconuse = ss.sesunuse
                    and cc.cucofact = f.factcodi
                    and f.factpefa = p.pefacodi
                    and s.susctdco = ''DA''
                    and cc.cucosacu > 0
                    and cc.cucofeve is not null
                    and pefacodi = '||inuPeriFact;
                    
        --cambio cucofepa por cucofeve --Caso 656_3
        sbquery := sbquery || ' Group by to_char(cc.cucofeve, ''yyyy-mm-dd''))';
        /*2.  Se creará un primer agrupamiento por Banco. Los Bancos estarán definidos por el parámetro JOBDEBAUTOENTBANC*/
        OPEN curbancos;
        LOOP
            FETCH curbancos INTO sbbanco;
            EXIT WHEN curbancos%notfound;
            /*a.  Se deberán identificar los formatos que apliquen al Banco identificado, para ello se validara en la tabla PRDAENTI en donde el código del banco este asociado en el campo PDENBANC y PDENEVEN = 2 (Evento de Débito Automático de Envió). Esta configuración son las diseñadas desde FGIA.*/
            OPEN curformatos(to_number(sbbanco));
            FETCH curformatos INTO
                sbpdenpren,
                sbpdenprde,
                sbpdenprto,
                sbpdenpres,
                sbpdenprva,
                sbpdenpato;
            CLOSE curformatos;
            /*b.  Se creará un segundo agrupamiento a partir de las fechas de pago identificadas en el punto 1.c.*/
            OPEN curfechas FOR sbquery;
    
            LOOP
                FETCH curfechas INTO dtfecha;
                EXIT WHEN curfechas%notfound;
                /*i.  Se aplicará un ciclo repetitivo que estará condicionado de la siguiente forma para controlar el agrupamiento por departamento
                1.  Si no está agrupado por departamento el ciclo solo se ejecutará una vez
                2.  Si esta agrupado por departamentos, se ejecutara una vez por cada departamento identificado en el punto 1.a.i. */
                IF sbagrupxdpto = 'S' THEN
                    sbquerydpto := 'select gel.geograp_location_id codigo, lpad(gel.description, 3) from ge_geogra_location gel where gel.geog_loca_area_type = 2';
                ELSE
                    sbquerydpto := 'select 1 as codigo, ''XXX'' as descripcion from dual';
                END IF;
    
                OPEN curdepto FOR sbquerydpto;
    
                LOOP
                    FETCH curdepto INTO
                        nucoddepto,
                        sbdescdepto;
                    EXIT WHEN curdepto%notfound;
                    /*ii. Se diseñará el Encabezado del Archivo basado en el formato del campo PDENPREN identificado en el punto 2.a. (Las configuraciones para cada uno de los formatos se obtiene de cruzar las tablas FOREARRE y CAREARRE por CRARNOCA = FRARCRAR y condicionarlo por el formato identificado en FRARTRAR)*/
                    /*CRARTIDA  FRARLOMA  FRARDECI  Descripción
                    N XX    Se completaran los campos con 0 a la izquierda del numero hasta completar el valor de dígitos definidos por FRARLOMA
                    N XX  XX  Se completarán los campos con 0 a la izquierda del numero hasta completar el valor de dígitos definidos de FRARLOMA mas FRARDECI. Se debe tener en cuenta que la cifra original debe tener 2 decimales y no debe tener el indicador de decimal
                    C XX    Se completara con espacios en blanco a la derecha hasta completar el tamaño de dígitos definidos en FARLOMA
                    1.  A los objetos con valor en FRARCOCA se les asignara ese valor por defecto y se les aplicara el formato definido en FRARFOCA si lo tienen.
                    2.  Se aplicará en el PROCESS_DATE el formato designado por el campo FRARFOCA
                    a.  Dependiendo del valor del parámetro JOBDEBAUTOFECHPAG se asignará el valor
                    i.  Si vale ¿S¿, se le asignara la fecha de pago identificada
                    ii. Si vale ¿N¿, se le asignara el sysdate
                    3.  Se aplicará en el PROCESS_HOUR el formato designado por el campo FRARFOCA
                    a.  Dependiendo del valor del parámetro JOBDEBAUTOFECHPAG se asignará el valor
                    i.  Si vale ¿S¿, se le asignara 00:01
                    ii. Si vale ¿N¿, se le asignara el sysdate
                    4.  Se aplicará en el FILE_MODIFIER el consecutivo correspondiente
                    a.  A este objeto se le ignorara la configuración en FRARCOCA
                    5.  Se aplicará en el FILLER el valor de ¿ ¿ (espacio en blanco) aplicando los formatos de relleno indicados en la tabla.
                    6.  La línea generada será guardada en una variable para su registro posterior en el archivo*/
                    sbaplicarfecha := dald_parameter.fsbgetvalue_chain('JOBDEBAUTOFECHPAG');
                    IF
                        sbaplicarfecha <> 'S'
                        AND sbaplicarfecha <> 'N'
                    THEN
                        sbmsgerror := 'Defina en el Parametro JOBDEBAUTOFECHPAG si se aplicara la Fecha de Limite de Pago';
                        RAISE ex.controlled_error;
                    END IF;
    
                    sbencabezadofile := '';
                    OPEN curobjetos(sbpdenpren);
                    LOOP
                        FETCH curobjetos INTO
                            sbfrarcrar,
                            sbcrartida,
                            nufrarloma,
                            nufrardeci,
                            sbfrarfoca,
                            sbfrarcoca;
                        EXIT WHEN curobjetos%notfound;
                        sbtempcadena := '';
                        CASE
                            WHEN sbfrarcrar = 'BANK_CODE' THEN
                                sbtempcadena := sbbanco;
                            WHEN sbfrarcrar = 'PROCESS_DATE' THEN
                                IF sbaplicarfecha = 'S' THEN
                                    sbtempcadena := to_char(dtfecha, 'yyyymmdd');
                                ELSE
                                    sbtempcadena := to_char(sysdate, 'yyyymmdd');
                                END IF;
                            WHEN sbfrarcrar = 'PROCESS_HOUR' THEN
                                IF sbaplicarfecha = 'S' THEN
                                    sbtempcadena := '0001';
                                ELSE
                                    sbtempcadena := to_char(sysdate, 'hh24mi');
                                END IF;
                            WHEN sbfrarcrar = 'FILE_MODIFIER' THEN
                                sbtempcadena := sbconsecutivo;
                            WHEN sbfrarcrar = 'FILLER' THEN
                                sbtempcadena := ' ';
                            ELSE
                                sbtempcadena := sbfrarcoca;
                        END CASE;
    
                        IF sbcrartida = 'C' THEN
                            sbtempcadena := rpad(sbtempcadena, nufrarloma, ' ');
                        ELSIF sbcrartida = 'N' THEN
                            --sbTempcadena := lpad(sbTempcadena, nuFrarloma + nuFrardeci, '0'); --Caso 656_2
                            sbtempcadena := lpad(sbtempcadena, nufrarloma, '0');
                        END IF;
    
                        sbencabezadofile := sbencabezadofile || sbtempcadena;
                    END LOOP;
    
                    CLOSE curobjetos;
                    /*iii.  Se diseñará el Encabezado del Lote basado en el formato del campo PDENPRDE identificado en el punto 2.a.
                    1.  A los objetos con valor en FRARCOCA se les asignara ese valor por defecto y se les aplicara el formato definido en FRARFOCA si lo tienen.
                    2.  Se aplicará en el FILLER2 el valor de ¿ ¿ (espacio en blanco) aplicando los formatos de relleno indicados en la tabla.
                    3.  La línea generada será guardada en una variable para su registro posterior en el archivo*/
                    sbencabezadolote := '';
                    OPEN curobjetos(sbpdenprde);
                    LOOP
                        FETCH curobjetos INTO
                            sbfrarcrar,
                            sbcrartida,
                            nufrarloma,
                            nufrardeci,
                            sbfrarfoca,
                            sbfrarcoca;
                        EXIT WHEN curobjetos%notfound;
                        sbtempcadena := '';
                        CASE
                            WHEN sbfrarcrar = 'FILLER 2' THEN
                                sbtempcadena := ' ';
                            ELSE
                                sbtempcadena := sbfrarcoca;
                        END CASE;
    
                        IF sbcrartida = 'C' THEN
                            sbtempcadena := rpad(sbtempcadena, nufrarloma, ' ');
                        ELSIF sbcrartida = 'N' THEN
                            --sbTempcadena := lpad(sbTempcadena, nuFrarloma + nuFrardeci, '0'); --Caso 656_2
                            sbtempcadena := lpad(sbtempcadena, nufrarloma, '0');
                        END IF;
    
                        sbencabezadolote := sbencabezadolote || sbtempcadena;
                    END LOOP;
    
                    CLOSE curobjetos;
                    /*iv. Se buscarán y recorrerán todas las Cuentas de Cobro, en las cuales su contrato asociado se halle relacionado al Banco (SUSCRIPC.SUSCBANC), que ese contrato tenga asignado el Debito Automático (SUSCRIPC.SUSCTDCO = 'DA'), que la fecha de pago (CUENCOBR.CUCOFEPA) este entre las identificadas en el punto 1.c., que la Cuenta de Cobro este pendiente de pago (CUENCOBR.CUCOSACU > 0) y si se determinó que se agrupara por departamento se deberá validar por el departamento asignado en el ciclo 2.b.i.
                    1.  Se diseñará el Detalle basado en el formato del campo PDENPRTO identificado en el punto 2.a.
                    a.  A los objetos con valor en FRARCOCA se les asignara ese valor por defecto y se les aplicara el formato definido en FRARFOCA si lo tienen.
                    b.  Se aplicará en el COUPON el valor del campo CUENCOBR.CUPONUME aplicando los formatos de relleno indicados en la tabla.
                    c.  Se aplicará en el INSTALATION el valor del campo SUSCRIPC.SUSCCODI aplicando los formatos de relleno indicados en la tabla.
                    d.  Se aplicará en el MONTH el valor del campo PERIFACT.PEFAMES aplicando los formatos de relleno indicados en la tabla.
                    e.  Se aplicará en el CYCLE el valor del campo SUSCRIPC.SUSCCICL aplicando los formatos de relleno indicados en la tabla.
                    i.  El campo viene configurado para 3 dígitos. Para ciclos de más de 3 dígitos solo se tomarán los tres primeros dígitos, Ej: Ciclo 1521, solo se tomará el 152 (Definido en apoyo con el Ing Ismael Uribe)
                    f.  Se aplicará en el VALUE_DEBIT el valor del campo CUENCOBR.CUCOSACU aplicando los formatos de relleno indicados en la tabla.
                    g.  Se aplicará en el EXPIRATION_DATE el valor del campo CUENCOBR.CUCOFEPA aplicando los formatos definidos en FRARFOCA.
                    h.  Se aplicará en el ACCOUNT_NUMBER el valor del campo SUSCRIPC.SUSCCUCO aplicando los formatos de relleno indicados en la tabla.
                    i.  Se aplicará en el ACCOUNT_TYPE el valor del campo SUSCRIPC.SUSCTCBA aplicando los formatos de relleno indicados en la tabla.
                    j.  Se aplicará en el SUBS_ID_NUMBER el valor del campo GE_SUBSCRIBER.IDENTIFICACTION aplicando los formatos de relleno indicados en la tabla.
                    k.  Se aplicará en el FILLER 2 el valor de ¿ ¿ (espacio en blanco) aplicando los formatos de relleno indicados en la tabla.
                    l.  La línea generada será guardada en una Array para su registro posterior en el archivo*/
                    --cambio cucofepa por cucofeve --Caso 656_3
                    --Se agrego la sumatoria de los valores a pagar Caso 656_5
                    --Se modifico la logica para obtener el cupon, pues una factura puede tener mas de uno asociado Caso 656_5
                    --Se agrego el campo de periodo de facturacion Caso 656_8
                    --Se modifica el campo identification del ge_subsscriber por el campo suscidtt de suscripc Caso 656_9
                    --Se modifica la consulta se retira el valor round(cc.CUCOSACU,0) por un 0, se hallara el valor del cupon al momento de registrar el detalle del archivo Caso 656_10
                    sbquerydetail := 'Select cupon, contrato, mes, ciclo, sum(valor), fecha, cuenta, banco, identificacion, periodo, factura from (Select (select c.cuponume from cupon c where c.cupodocu = f.factcodi and c.cupoflpa = ''N'' and c.cupotipo = ''FA'' and c.cupoprog = ''FIDF'' and c.cuposusc = s.susccodi and c.cupofech = (select max(c1.cupofech) from cupon c1 where c1.cupodocu = f.factcodi and c1.cupoflpa = ''N'' and c1.cupotipo = ''FA'' and c1.cupoprog = ''FIDF'' and c1.cuposusc = s.susccodi) and rownum = 1) as cupon, s.SUSCCODI as contrato, p.pefames as mes, s.SUSCCICL as ciclo, 0 as valor, to_char(cc.cucofeve, ''yyyymmdd'') as fecha, s.SUSCCUCO as cuenta, s.SUSCTCBA as banco, nvl(s.suscidtt, ''0'') as identificacion, f.factpefa as periodo, f.factcodi as factura';
                    IF sbagrupxdpto = 'S' THEN
                        IF sbmodoejecucion = 'M' THEN
                            --cambio cucofepa por cucofeve --Caso 656_3
                            sbquerydetail := sbquerydetail
                                             || ' From suscripc s, servsusc ss, cuencobr cc, perifact p, ge_subscriber g, factura f, ab_address a
                                                where ss.sesususc = s.susccodi
                                                and s.suscbanc = '
                                             || sbbanco
                                             || '
                                                and cc.cuconuse = ss.sesunuse
                                                and s.susctdco = ''DA''
                                                and cc.cucosacu > 0
                                                and cc.cucofact = f.factcodi
                                                and f.factpefa = p.pefacodi
                                                and f.factprog = 6
                                                and s.suscclie = g.subscriber_id
                                                and to_char(cc.cucofeve, ''yyyy-mm-dd'') = '''
                                             || to_char(dtfecha, 'yyyy-mm-dd')
                                             || '''
                                                and a.address_id = cc.cucodiin
                                                and dage_geogra_location.fnugetgeo_loca_father_id(a.geograp_location_id,null) = '
                                             || nucoddepto
                                             || '
                                                and to_char(p.pefaffmo + '
                                             || to_char(nudiasejecucion)
                                             || ', ''yyyy-mm-dd'') = to_char(sysdate, ''yyyy-mm-dd'')';
    
                        ELSE
                            --cambio cucofepa por cucofeve --Caso 656_3
                            sbquerydetail := sbquerydetail
                                             || ' From suscripc s, servsusc ss, cuencobr cc, ge_subscriber g, perifact p, factura f, ab_address a
                                                where ss.sesususc = s.susccodi
                                                and s.suscbanc = '
                                             || sbbanco
                                             || '
                                                and cc.cuconuse = ss.sesunuse
                                                and s.susctdco = ''DA''
                                                and cc.cucosacu > 0
                                                and cc.cucofact = f.factcodi
                                                and f.factpefa = p.pefacodi
                                                and f.factprog = 6
                                                and s.suscclie = g.subscriber_id
                                                and a.address_id = cc.cucodiin
                                                and dage_geogra_location.fnugetgeo_loca_father_id(a.geograp_location_id,null) = '
                                             || nucoddepto
                                             || '
                                                and to_char(cc.cucofeve, ''yyyy-mm-dd'') = '''
                                             || to_char(dtfecha, 'yyyy-mm-dd')
                                             || '''';
                        END IF;
                    ELSE
                        IF sbmodoejecucion = 'M' THEN
                            --cambio cucofepa por cucofeve --Caso 656_3
                            sbquerydetail := sbquerydetail
                                             || ' From suscripc s, servsusc ss, cuencobr cc, perifact p, ge_subscriber g, factura f
                                                where ss.sesususc = s.susccodi
                                                and s.suscbanc = '
                                             || sbbanco
                                             || '
                                                and cc.cuconuse = ss.sesunuse
                                                and s.susctdco = ''DA''
                                                and cc.cucosacu > 0
                                                and cc.cucofact = f.factcodi
                                                and f.factpefa = p.pefacodi
                                                and f.factprog = 6
                                                and s.suscclie = g.subscriber_id
                                                and to_char(cc.cucofeve, ''yyyy-mm-dd'') = '''
                                             || to_char(dtfecha, 'yyyy-mm-dd')
                                             || '''
                                                and to_char(p.pefaffmo + '
                                             || to_char(nudiasejecucion)
                                             || ', ''yyyy-mm-dd'') = to_char(sysdate, ''yyyy-mm-dd'')';
    
                        ELSE
                            --cambio cucofepa por cucofeve --Caso 656_3
                            sbquerydetail := sbquerydetail
                                             || ' From suscripc s, servsusc ss, cuencobr cc, ge_subscriber g, perifact p, factura f
                                                where ss.sesususc = s.susccodi
                                                and s.suscbanc = '
                                             || sbbanco
                                             || '
                                                and cc.cuconuse = ss.sesunuse
                                                and s.susctdco = ''DA''
                                                and cc.cucosacu > 0
                                                and cc.cucofact = f.factcodi
                                                and f.factpefa = p.pefacodi
                                                and f.factprog = 6
                                                and s.suscclie = g.subscriber_id
                                                and to_char(cc.cucofeve, ''yyyy-mm-dd'') = '''
                                             || to_char(dtfecha, 'yyyy-mm-dd')
                                             || '''';
                        END IF;
                    END IF;
                    --Caso 656_3 Se agrego el agrupamiento
                    --Caso 656_8 Se agrega el periodo de facturacion
                    sbquerydetail := sbquerydetail || ') group by cupon, contrato, mes, ciclo, fecha, cuenta, banco, identificacion, periodo, factura';
                    nucontdetail := 0;
                    nutotalesv := 0;
                    OPEN curdetalles FOR sbquerydetail;
    
                    LOOP
                        FETCH curdetalles INTO
                            nucuponnume,
                            nususccodi,
                            nupefames,
                            nususccicl,
                            nucucosacu,
                            sbcucofepa,
                            sbsusccuco,
                            nususctcba,
                            sbidentification,
                            nuperiodofact, --Caso 656_8: se agrega el Periodo de facturacion
                            sbnumfactura; --Caso 656_8: se agrega la factura
                        EXIT WHEN curdetalles%notfound;
                        --Se valida cuando el Cupon no este vacio. Caso 656_6
                        IF nucuponnume IS NOT NULL THEN
                            --Cambio 656_8: se agrego el registro en la tabla GST_PREVDEAU y GST_HIDASUSC
                            --validacion de registro en GST_PREVDEAU
                            nucodgst_prevdeau := NULL;
                            OPEN cuexistgstprevdeau(to_number(sbbanco), nueventbanc, nususccicl, nuperiodofact);
                            FETCH cuexistgstprevdeau INTO nucodgst_prevdeau;
                            CLOSE cuexistgstprevdeau;
                            --si no encuentra el evento programado en GST_PREVDEAU lo inserta
                            IF ( nucodgst_prevdeau IS NULL ) THEN
                                nucodgst_prevdeau := sqgst_prdecodi.nextval;
                                INSERT INTO gst_prevdeau (
                                    prdecodi,
                                    prdebanc,
                                    prdeevda,
                                    prdecifa,
                                    prdepefa,
                                    prdefepr,
                                    prdeflca,
                                    prdeobse
                                ) VALUES (
                                    nucodgst_prevdeau,
                                    to_number(sbbanco),
                                    nueventbanc,
                                    nususccicl,
                                    nuperiodofact,
                                    sysdate,
                                    sbstathistevpr,
                                    'Generado desde prcGenerarArchivoDA'
                                );
    
                                COMMIT;
                            END IF;
                            --elimino historicos previos registrados para evitar errores
                            DELETE FROM gst_hidasusc
                            WHERE
                                    hisufact = sbnumfactura
                                AND hisususc = nususccodi;
                            --se registra el historico
                            INSERT INTO gst_hidasusc (
                                hisuprde,
                                hisufact,
                                hisususc,
                                hisuvaco,
                                hisufeen,
                                hisuesta
                            ) VALUES (
                                nucodgst_prevdeau,
                                sbnumfactura,
                                nususccodi,
                                nucucosacu,
                                sysdate,
                                sbstathistdesusc
                            );
    
                            COMMIT;
                            --Fin 656_8
                            --
                            nucontdetail := nucontdetail + 1;
                            sbarraydetalles(nucontdetail) := '';
                            OPEN curobjetos(sbpdenprto);
                            LOOP
                                FETCH curobjetos INTO
                                    sbfrarcrar,
                                    sbcrartida,
                                    nufrarloma,
                                    nufrardeci,
                                    sbfrarfoca,
                                    sbfrarcoca;
                                EXIT WHEN curobjetos%notfound;
                                sbtempcadena := '';
                                CASE
                                    WHEN sbfrarcrar = 'COUPON' THEN
                                        sbtempcadena := to_char(nucuponnume);
                                    WHEN sbfrarcrar = 'INSTALATION' THEN
                                        sbtempcadena := to_char(nususccodi);
                                    WHEN sbfrarcrar = 'MONTH' THEN
                                        sbtempcadena := to_char(nupefames);
                                    WHEN sbfrarcrar = 'CYCLE' THEN
                                        sbtempcadena := to_char(nususccicl);
                                    WHEN sbfrarcrar = 'VALUE_DEBIT' THEN
                                        --sbTempcadena := to_char(nuCucosacu * 100);
                                        --nuTotalesV   := nuTotalesV + nuCucosacu;
                                        --656_10 se consulta el valor del Cupon
                                        SELECT
                                            round(c.cupovalo, 0)
                                        INTO nuvaluedebit
                                        FROM
                                            cupon c
                                        WHERE
                                            c.cuponume = nucuponnume;
    
                                        sbtempcadena := to_char(nuvaluedebit * 100);
                                        nutotalesv := nutotalesv + nuvaluedebit;
                                    --
                                    WHEN sbfrarcrar = 'ADITIONAL_SERVICE_VALUE' THEN
                                        sbtempcadena := '0';
                                    WHEN sbfrarcrar = 'EXPIRATION_DATE' THEN
                                        sbtempcadena := sbcucofepa;
                                    WHEN sbfrarcrar = 'ACCOUNT_NUMBER' THEN
                                        sbtempcadena := sbsusccuco;
                                    WHEN sbfrarcrar = 'ACCOUNT_TYPE' THEN
                                        sbtempcadena := to_char(nususctcba);
                                    WHEN sbfrarcrar = 'SUBS_ID_NUMBER' THEN
                                        sbtempcadena := sbidentification;
                                    WHEN sbfrarcrar = 'FILLER 4' THEN
                                        sbtempcadena := ' ';
                                    WHEN sbfrarcrar = 'FILLER 2' THEN
                                        sbtempcadena := ' ';
                                    ELSE
                                        sbtempcadena := sbfrarcoca;
                                END CASE;
    
                                IF sbcrartida = 'C' THEN
                                    sbtempcadena := rpad(sbtempcadena, nufrarloma, ' ');
                                ELSIF sbcrartida = 'N' THEN
                                    --sbTempcadena := lpad(sbTempcadena,nuFrarloma + nuFrardeci,'0'); --Caso 656_2
                                    sbtempcadena := lpad(sbtempcadena, nufrarloma, '0');
                                END IF;
    
                                sbarraydetalles(nucontdetail) := sbarraydetalles(nucontdetail)
                                                                 || sbtempcadena;
                            END LOOP;
    
                            CLOSE curobjetos;
                        END IF;
    
                    END LOOP;
    
                    CLOSE curdetalles;
                    /*v.  Solo se procede a la definición de los totales, si el total de registros identificados en el punto anterior (2.b.iv) es mayor a 0*/
                    IF nucontdetail > 0 THEN
                        /*1.  Se diseñará el Total del Lote basado en el formato del campo PDENPRES identificado en el punto 2.a.
                        a.  A los objetos con valor en FRARCOCA se les asignara ese valor por defecto y se les aplicara el formato definido en FRARFOCA si lo tienen.
                        b.  Se aplicara en el RECORDS_NUMBER el total de Cuentas de Cobro recorridas en el punto 2.b.iv. aplicando los formatos de relleno indicados en la tabla.
                        c.  Se aplicara en el RECEIVED_TOTALNUMBER el valor de la sumatoria de los valores a pagar (CUENCOBR.CUCOSACU) identificados en el punto 2.b.iv. aplicando los formatos de relleno indicados en la tabla.
                        d.  Se aplicará en el RECEIVED_TOTAL_VAL_ADITIONAL el valor de 0 aplicando los formatos de relleno indicados en la tabla.
                        e.  Se aplicará en el CONSECUTIVE el valor de 1 aplicando los formatos de relleno indicados en la tabla.
                        f.  Se aplicará en el FILLER el valor de ¿ ¿ (espacio en blanco) aplicando los formatos de relleno indicados en la tabla.
                        g.  La línea generada será guardada en una variable para su registro posterior en el archivo*/
                        sbtotaldetalle := '';
                        OPEN curobjetos(sbpdenpres);
                        LOOP
                            FETCH curobjetos INTO
                                sbfrarcrar,
                                sbcrartida,
                                nufrarloma,
                                nufrardeci,
                                sbfrarfoca,
                                sbfrarcoca;
                            EXIT WHEN curobjetos%notfound;
                            sbtempcadena := '';
                            CASE
                                WHEN sbfrarcrar = 'RECORDS_NUMBER' THEN
                                    sbtempcadena := to_char(nucontdetail);
                                WHEN sbfrarcrar = 'RECEIVED_TOTAL_VALUE' THEN
                                    sbtempcadena := to_char(nutotalesv * 100);
                                WHEN sbfrarcrar = 'RECEIVED_TOTAL_VAL_ADITIONAL' THEN
                                    sbtempcadena := '0';
                                WHEN sbfrarcrar = 'CONSECUTIVE' THEN
                                    sbtempcadena := '1';
                                WHEN sbfrarcrar = 'FILLER' THEN
                                    sbtempcadena := ' ';
                                ELSE
                                    sbtempcadena := sbfrarcoca;
                            END CASE;
    
                            IF sbcrartida = 'C' THEN
                                sbtempcadena := rpad(sbtempcadena, nufrarloma, ' ');
                            ELSIF sbcrartida = 'N' THEN
                                --sbTempcadena := lpad(sbTempcadena,nuFrarloma + nuFrardeci,'0'); --Caso 656_2
                                sbtempcadena := lpad(sbtempcadena, nufrarloma, '0');
                            END IF;
    
                            sbtotaldetalle := sbtotaldetalle || sbtempcadena;
                        END LOOP;
    
                        CLOSE curobjetos;
                        /*2.  Se diseñará el Total del Archivo basado en el formato del campo PDENPRVA identificado en el punto 2.a.
                        a.  A los objetos con valor en FRARCOCA se les asignara ese valor por defecto y se les aplicara el formato definido en FRARFOCA si lo tienen.
                        b.  Se aplicara en el RECORDS_NUMBER el total de cuentas de cobro recorridas en el punto 2.b.iv. aplicando los formatos de relleno indicados en la tabla.
                        c.  Se aplicara en el RECEIVED_TOTAL_VALUE el valor de sumatoria de los valores a pagar (CUENCOBR.CUCOSACU) identificados en el punto 2.b.iv. aplicando los formatos de relleno indicados en la tabla.
                        d.  Se aplicará en el FILLER el valor de ¿ ¿ (espacio en blanco) aplicando los formatos de relleno indicados en la tabla.
                        e.  La línea generada será guardada en una variable para su registro posterior en el archivo*/
                        sbtotalfile := '';
                        OPEN curobjetos(sbpdenprva);
                        LOOP
                            FETCH curobjetos INTO
                                sbfrarcrar,
                                sbcrartida,
                                nufrarloma,
                                nufrardeci,
                                sbfrarfoca,
                                sbfrarcoca;
                            EXIT WHEN curobjetos%notfound;
                            sbtempcadena := '';
                            CASE
                                WHEN sbfrarcrar = 'RECORDS_NUMBER' THEN
                                    sbtempcadena := to_char(nucontdetail);
                                WHEN sbfrarcrar = 'RECEIVED_TOTAL_VALUE' THEN
                                    sbtempcadena := to_char(nutotalesv * 100);
                                WHEN sbfrarcrar = 'FILLER' THEN
                                    sbtempcadena := ' ';
                                ELSE
                                    sbtempcadena := sbfrarcoca;
                            END CASE;
    
                            IF sbcrartida = 'C' THEN
                                sbtempcadena := rpad(sbtempcadena, nufrarloma, ' ');
                            ELSIF sbcrartida = 'N' THEN
                                --sbTempcadena := lpad(sbTempcadena,nuFrarloma + nuFrardeci,'0'); --Caso 656_2
                                sbtempcadena := lpad(sbtempcadena, nufrarloma, '0');
                            END IF;
    
                            sbtotalfile := sbtotalfile || sbtempcadena;
                        END LOOP;
    
                        CLOSE curobjetos;
                        /*3.  Para la creación del Archivo plano se tendrán en cuenta las siguientes consideraciones:
                        a.  El nombre del archivo se asignará de la siguiente forma:
                        i.  Código del Banco: Se colocará con un formato de 4 dígitos
                        ii. Fecha de Pago: Se colocará en el formato YYYYMMDD
                        iii.  Departamento: se colocarán las iniciales (3 dígitos)
                        1.  Solo aplicara si se agrupo por departamento
                        iv. Consecutivo: El consecutivo correspondiente al archivo
                        v.  La información de los puntos anteriores estará separada por un guion bajo (_) y el archivo será guardado en formato txt.
                        vi. Ejemplo: 0007_20210127_ATL_a.txt /  0007_20210127_a.txt
                        b.  El archivo ha crear será guardado en la ruta definida en el campo PDENPATO identificado en el punto 2.a.
                        i.  El contenido del archivo será generado a partir de las variables y el Array que se generaron durante el proceso
                        ii. Si el archivo se guarda con éxito, al terminar de crear el archivo el consecutivo debe continuar con su secuencia.*/
                        IF sbagrupxdpto = 'S' THEN
                            sbnamefile := lpad(sbbanco, 4, '0')
                                          || '_'
                                          || to_char(dtfecha, 'yyyymmdd')
                                          || '_'
                                          || sbdescdepto
                                          || '_'
                                          || sbconsecutivo
                                          || '.txt';
                        ELSE
                            sbnamefile := lpad(sbbanco, 4, '0')
                                          || '_'
                                          || to_char(dtfecha, 'yyyymmdd')
                                          || '_'
                                          || sbconsecutivo
                                          || '.txt';
                        END IF;
    
                        BEGIN
                            fldebitoauto := utl_file.fopen(sbpdenpato, sbnamefile, 'W');
                            utl_file.put_line(fldebitoauto, sbencabezadofile);
                            utl_file.put_line(fldebitoauto, sbencabezadolote);
                            FOR nuciclo IN 1..nucontdetail LOOP
                                utl_file.put_line(fldebitoauto, sbarraydetalles(nuciclo));
                            END LOOP;
    
                            utl_file.put_line(fldebitoauto, sbtotaldetalle);
                            utl_file.put_line(fldebitoauto, sbtotalfile);
                            utl_file.fclose(fldebitoauto);
                            sbstatusfile := sbstatusfile
                                            || sbnamefile
                                            || ' - Ok<br>';
                            /*ASCII (97-122)(a - z) y (48-57)(0-9)*/
                            IF
                                nusecuencia >= 97
                                AND nusecuencia < 122
                            THEN
                                nusecuencia := nusecuencia + 1;
                            ELSIF nusecuencia = 122 THEN
                                nusecuencia := 48;
                            ELSIF
                                nusecuencia >= 48
                                AND nusecuencia < 57
                            THEN
                                nusecuencia := nusecuencia + 1;
                            END IF;
    
                            sbconsecutivo := chr(nusecuencia);
                        EXCEPTION
                            WHEN OTHERS THEN
                                IF sbagrupxdpto = 'S' THEN
                                    sbstatusfile := sbstatusfile
                                                    || 'El archivo Correspondiente al Banco ('
                                                    || sbbanco
                                                    || '), Fecha de Pago ('
                                                    || to_char(dtfecha, 'yyyy-mm-dd')
                                                    || ') y Departamento ('
                                                    || sbdescdepto
                                                    || ') no pudo ser creado - Error<br>';
    
                                ELSE
                                    sbstatusfile := sbstatusfile
                                                    || 'El archivo Correspondiente al Banco ('
                                                    || sbbanco
                                                    || ') y Fecha de Pago ('
                                                    || to_char(dtfecha, 'yyyy-mm-dd')
                                                    || ') no pudo ser creado - Error<br>';
                                END IF;
                        END;
    
                    END IF;
    
                END LOOP;
    
                CLOSE curdepto;
            END LOOP;
    
            CLOSE curfechas;
        END LOOP;
    
        CLOSE curbancos;
        /*3.  Al finalizar el proceso se usará el servicio LDC_SENDEMAIL, con el cual se enviará un correo con un resumen de los archivos creados en el proceso
        a.  El correo que recibe deberá ser el configurado en el Parámetro MAILRECEIVEDEBAUTO
        b.  El correo tendrá por Asunto el valor del contenido en el Parámetro MAILSUBJECTDEBAUTO
        c.  El correo detallara en el mensaje las Entidades, la Fecha de Pago y los ciclos que fueron procesados y cuales terminaron con éxito o no. Además, indicara el Departamento en caso de estar agrupado por departamentos.
        */
        IF sbstatusfile IS NOT NULL THEN
            sbstatusfile := '<html><head><title>Resumen de Archivos Procesados</title><meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"></head><body><h3>Resumen de Archivos Procesados</h3><br><br>'
                            || sbstatusfile
                            || '</body></html>';
        ELSE
            sbstatusfile := '<html><head><title>Resumen de Archivos Procesados</title><meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"></head><body><h3>Resumen de Archivos Procesados</h3><br><br>Ningun Archivo de Debito Automatico fue creado.</body></html>';
        END IF;
    
        sendmail(sbstatusfile);
        
        pkg_traza.trace(csbMtd_nombre, cnuNvlTrc, csbFin);
        --Caso 656_3
        ldc_proactualizaestaprog(nutsess, 'Registro de Debitos Automaticos', 'prcGenerarArchivoDA', 'Ok');
    EXCEPTION
        WHEN ex.controlled_error THEN
            sendmail(sbmsgerror);
            RAISE;
        WHEN OTHERS THEN
            sbmsgerror := sqlerrm;
            RAISE ex.controlled_error;
    END prcGenerarArchivoDA;           
    
BEGIN
    pkg_traza.trace(csbMtd_nombre, cnuNvlTrc, csbInicio);
    pkg_traza.trace('inuProgramacion: '||inuProgramacion, cnuNvlTrc);
        
    -- Adiciona el registro de programacion del proceso
    Ge_Boschedule.Addlogtoscheduleprocess(inuProgramacion, nuHilos, nuLogProcesoId);
    pkg_traza.trace('nuLogProcesoId: '||nuLogProcesoId, cnuNvlTrc);
    
    -- se obtiene parametros 
    sbParametros := dage_process_schedule.fsbGetParameters_(inuProgramacion);
    
    --se separan parametros ingresados en la aplicacion PB PBGADA
    nuPFAno := to_number(ut_string.getparametervalue(sbParametros,'PEFAANO','|','='));
    nuPFMes := to_number(ut_string.getparametervalue(sbParametros, 'PEFAMES', '|', '='));   
    nuPFCiclo := to_number(ut_string.getparametervalue(sbParametros,'PEFACICL','|','='));
    
    OPEN cuPeiodoFact(nuPFAno, nuPFMes, nuPFCiclo);
    FETCH cuPeiodoFact INTO nuPFcodigo;
    CLOSE cuPeiodoFact;
            
    pkg_traza.trace('nuPFcodigo: ' ||nuPFcodigo, cnuNvlTrc);    
    prcGenerarArchivoDA(nuPFcodigo);  
    
    -- Actualiza registro de programacion del proceso
    Ge_Boschedule.Changelogprocessstatus(nuLogProcesoId, 'F');
    
    pkg_traza.trace(csbMtd_nombre, cnuNvlTrc, csbFin);
EXCEPTION
    WHEN pkg_error.controlled_error THEN
        pkg_error.setError;
        pkg_error.getError(nuError, sbMensaje);
        pkg_traza.trace('nuError: ' || nuError || ' sbMensaje: ' || sbMensaje, cnuNvlTrc);
        pkg_traza.trace(csbMtd_nombre, cnuNvlTrc, csbFin_erc); 
        RAISE pkg_error.controlled_error;
    WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.getError(nuError, sbMensaje);
        pkg_traza.trace('nuError: ' || nuError || ' sbMensaje: ' || sbMensaje, cnuNvlTrc);
        pkg_traza.trace(csbMtd_nombre, cnuNvlTrc, csbFin_err); 
        RAISE pkg_error.controlled_error;
END pbgada; 
/   
BEGIN
    pkg_utilidades.praplicarpermisos(UPPER('pbgada'),'OPEN'); 
END;
/