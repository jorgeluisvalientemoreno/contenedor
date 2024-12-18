create or replace PROCEDURE            GENERATEFILEDEBITAUTO
IS
    /**************************************************************************
     Autor       : Daniel Valiente / Horbath
     Fecha       : 2021-01-05
     Ticket      : 656
     Proceso     : GENERATEFILEDEBITAUTO
     Descripcion : Procedimiento para generar de Forma Masiva los Archivos de Debito Automatico basados en las Configuraciones de FGIA

     HISTORIA DE MODIFICACIONES
     FECHA        AUTOR       DESCRIPCION
     22/02/2021   DANVAL      Caso: 656_2 Se modifica el servicio de envio de correo para que pueda enviar a mas de un destinatario. Se modifica la logica en el uso de los formatos para omitir el uso de los decimales en las cifras
     24/02/2021   DANVAL      Caso: 656_3 Se modifica el campo por el cual se toma la fecha de vencimiento de las cuentas de cobro de cucofepa por cucofeve. se agrego control de inicio y fin del proceso
     02/03/2021   DANVAL      Caso: 656_5 Se aplico agrupacion a la consulta del detalle para que sume los valores a cobrar y no repita cupones en el listado. Se identifico que las facturas pueden estar asociadas a mas de un cupo, se tomara el mas reciente.
     04/03/2021   DANVAL      Caso: 656_6 Se modifica para validar cuando la cuenta de cobro aosciada a su factura correspondiente no tiene un cupo asignado o este no es valido
     05/03/2021   DANVAL      Caso: 656_7 Se modifica para controlar la aplicacion de la fecha y se agrupen
     12/03/2021   DANVAL      Caso: 656_8 Se agrega el proceso de registro en las tablas de historico GST_PREVDEAU y GST_HIDASUSC
     08/04/2021   DANVAL      Caso: 656_9 Se reemplaza la identificacion del cliente que se envia en el archivo por la identificacion del titular de la cuenta registrada en SUSCRIPC
     29/04/2021   DANVAL      Caso 656_10 Se reemplaza el valor del VALUE_DEBIT que se obtiene de CUENCOBR.CUCOSACU por el valor a pagar del Cupon Asociado del campo CUPON.CUPOVALO
     26/02/2024   jpinedc     Caso: OSF-2375 - Ajustes por nuevas directrices y
                                    reemplazo de utl_file por pkg_gestionArchivos
     05/03/2024   jpinedc     Caso: OSF-2375: Ajuste Validación Técnica:
                                    Reemplazo LDC_PROINSERTAESTAPROG y
                                    LDC_PROACTUALIZAESTAPROG
                                    por homologados en PKG_ESTAPROC
    ***************************************************************************/

    csbMetodo        CONSTANT VARCHAR2(70) :=  'GENERATEFILEDEBITAUTO';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
    nuError         NUMBER;
    sbError         VARCHAR2(4000);


    sbAgrupxDpto         VARCHAR2 (2);
    sbConsecutivo        VARCHAR2 (2);
    sbModoEjecucion      VARCHAR2 (2);
    sbQuery              VARCHAR2 (4000);
    nuDiasejecucion      NUMBER;

    --codigos de bancos a procesar
    CURSOR curBancos IS
    SELECT to_number(regexp_substr(dald_parameter.fsbgetvalue_chain ('JOBDEBAUTOENTBANC'),'[^,]+', 1,LEVEL))
    FROM dual
    CONNECT BY regexp_substr(dald_parameter.fsbgetvalue_chain ('JOBDEBAUTOENTBANC'), '[^,]+', 1, LEVEL) IS NOT NULL;

    sbBanco              VARCHAR2 (4);

    --
    --formatos por banco
    CURSOR curFormatos (inuBancoId NUMBER)
    IS
        SELECT Pdenpren,
               Pdenprde,
               Pdenprto,
               Pdenpres,
               Pdenprva,
               Pdenpato
          FROM prdaenti p
         WHERE p.pdenbanc = inuBancoId AND p.pdeneven = 2 AND ROWNUM = 1;

    sbPdenpren           VARCHAR2 (120);
    sbPdenprde           VARCHAR2 (120);
    sbPdenprto           VARCHAR2 (120);
    sbPdenpres           VARCHAR2 (120);
    sbPdenprva           VARCHAR2 (120);
    sbPdenpato           VARCHAR2 (200);

    CURSOR curObjetos (isbFormato VARCHAR2)
    IS
          SELECT Frarcrar,
                 Crartida,
                 Frarloma,
                 NVL (Frardeci, 0),
                 Frarfoca,
                 Frarcoca
            FROM forearre, carearre
           WHERE crarnoca = frarcrar AND frartrar = isbFormato
        ORDER BY frarpoin;

    --
    sbFrarcrar           VARCHAR2 (100);
    sbCrartida           VARCHAR2 (100);
    nuFrarloma           NUMBER;
    nuFrardeci           NUMBER;
    sbFrarfoca           VARCHAR2 (100);
    sbFrarcoca           VARCHAR2 (100);
    sbAplicarFecha       VARCHAR2 (2);
    sbTempcadena         VARCHAR2 (4000);
    sbEncabezadoFile     VARCHAR2 (4000);
    sbEncabezadoLote     VARCHAR2 (4000);

    TYPE detallesarray IS TABLE OF VARCHAR2 (4000)
        INDEX BY PLS_INTEGER;

    sbArrayDetalles      detallesarray;
    sbTotaldetalle       VARCHAR2 (4000);
    sbTotalFile          VARCHAR2 (4000);
    sbQueryDpto          VARCHAR2 (4000);

    TYPE cur_typ IS REF CURSOR;

    curDepto             cur_typ;
    nuCoddepto           NUMBER;
    sbDescdepto          VARCHAR2 (5);
    --
    curFechas            SYS_REFCURSOR;
    dtFecha              DATE;
    sbQuerydetail        VARCHAR2 (4000);
    curDetalles          SYS_REFCURSOR;
    nuContDetail         NUMBER;
    nuSusccodi           NUMBER;
    nuPefames            NUMBER;
    nuSusccicl           NUMBER;
    --nuCucosacu         number(14, 2); --Caso 656_2
    nuCucosacu           NUMBER;
    sbCucofepa           VARCHAR2 (20);
    sbSusccuco           VARCHAR2 (30);
    nuSusctcba           NUMBER;
    sbIdentification     VARCHAR2 (20);
    --nuTotalesV         number(14, 2); --Caso 656_2
    nuTotalesV           NUMBER;
    nuCuponnume          NUMBER;
    sbNamefile           VARCHAR2 (50);
    flDebitoAuto         pkg_gestionArchivos.styArchivo;
    nuciclo              NUMBER;
    sbStatusFile         VARCHAR2 (4000) := NULL;

    --Caso 656_2
    CURSOR curDestinatarios IS
    SELECT regexp_substr(dald_parameter.fsbgetvalue_chain ('JOBDEBAUTOMAILRECEIVE'),'[^,]+', 1,LEVEL)
    FROM dual
    CONNECT BY regexp_substr(dald_parameter.fsbgetvalue_chain ('JOBDEBAUTOMAILRECEIVE'), '[^,]+', 1, LEVEL) IS NOT NULL;

    sbDestinatariomail   VARCHAR2 (100);
    sbAsuntomail         VARCHAR2 (200);

    --
    nuSecuencia          NUMBER := 97;            --codigo ascii de la letra a
    --Caso 656_3
    nuparano             NUMBER (4);
    nuparmes             NUMBER (2);
    nutsess              NUMBER;
    sbparuser            VARCHAR2 (30);
    --
    --caso 656_8
    nucodGST_PREVDEAU    NUMBER;
    nuPeriodoFact        NUMBER;
    sbnumfactura         VARCHAR2 (100);
    nuEventBanc          NUMBER
        := dald_parameter.fnuGetNumeric_Value ('JOBDEBAUTOEVENTBANC');
    sbStatHistevpr       VARCHAR2 (10)
        := dald_parameter.fsbGetValue_Chain ('JOBDEBAUTOESTHISTEVPR');
    sbStatHistdesusc     VARCHAR2 (10)
        := dald_parameter.fsbGetValue_Chain ('JOBDEBAUTOESTHISTDEBSUSC');

    CURSOR cuExistGSTPREVDEAU (inubanco     NUMBER,
                               inuevento    NUMBER,
                               inuciclo     NUMBER,
                               inuperiodo   NUMBER)
    IS
        SELECT g.prdecodi
          FROM GST_PREVDEAU g
         WHERE     g.prdebanc = inubanco
               AND g.prdeevda = inuevento
               AND g.prdecifa = inuciclo
               AND g.prdepefa = inuperiodo;

    --
    --Caso 656_10
    nuValueDebit         NUMBER;

    sbMsgError          VARCHAR2(200);

    sbproceso  VARCHAR2(100)  := 'GENERATEFILEDEBITAUTO'||TO_CHAR(SYSDATE,'DDMMYYYYHH24MISS');

    --
    PROCEDURE sendmail (isbmsg VARCHAR2)
    IS

        csbMetodo1        CONSTANT VARCHAR2(105) :=  csbMetodo || '.sendmail';
        nuError1             NUMBER;
        sbError1             VARCHAR2(4000);

        sbRemitente  ld_parameter.Value_Chain%TYPE;

        sbInstanciaBD   VARCHAR2(40);

    BEGIN

        pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbINICIO);

        sbInstanciaBD := ldc_boConsGenerales.fsbGetDatabaseDesc;

        IF (LENGTH(sbInstanciaBD)) > 0 THEN
            sbInstanciaBD := 'BD ' || sbInstanciaBD || ': ';
        END IF;

        sbRemitente :=
            dald_parameter.fsbGetValue_Chain('LDC_SMTP_SENDER', null);
        sbAsuntomail :=
            sbInstanciaBD || dald_parameter.fsbGetValue_Chain ('JOBDEBAUTOMAILSUBJECT');

        --Caso 656_2
        OPEN curDestinatarios;

        LOOP
            FETCH curDestinatarios INTO sbDestinatariomail;

            EXIT WHEN curDestinatarios%NOTFOUND;

            pkg_Correo.prcEnviaCorreo
            (
                isbRemitente        =>  sbRemitente,
                isbDestinatarios    =>  sbDestinatariomail,
                isbAsunto           =>  sbAsuntomail,
                isbMensaje          =>  isbmsg
            );

        END LOOP;

        CLOSE curDestinatarios;

        pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError1,sbError1);
            pkg_traza.trace('sbError1 => ' || sbError1, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            pkg_Error.getError(nuError1,sbError1);
            pkg_traza.trace('sbError1 => ' || sbError1, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
    END sendmail;

BEGIN

    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);

    -- Inicializamos el proceso
    pkg_estaproc.prinsertaestaproc( sbproceso , 1);

    --
    /*lOGICA:
    1.  Se deberá inicializar las siguientes variables:
    a.  Se determinará a partir del valor del parámetro JOBDEBAUTOAGRUPADPTO si el archivo estará agrupado o no por Departamento*/
    /*i.  Si se va a aplicar agrupamiento por departamento, se deberán identificar todos los departamentos disponibles.*/
                         /*se hace durante el proceso de consulta de cuentas*/
    sbAgrupxDpto := dald_parameter.fsbGetValue_Chain ('JOBDEBAUTOAGRUPADPTO');

    pkg_traza.trace('sbAgrupxDpto|' || sbAgrupxDpto, csbNivelTraza);

    IF sbAgrupxDpto <> 'S' AND sbAgrupxDpto <> 'N'
    THEN
        sbMsgError :=
            'Indique en el parametro JOBDEBAUTOAGRUPADPTO si se realizara Agrupamiento por Departamentos.';
        pkg_error.setErrorMessage( isbMsgErrr => sbMsgError );
    END IF;

    /*b.  Se inicializará el consecutivo que se agregará a los nombres del archivo y al encabezado del archivo, esta variable se inicializará con la letra a.
    i.  El consecutivo deberá incrementar con cada archivo pasando hasta z y continuando del 0 al 9*/
    sbConsecutivo := CHR (nuSecuencia);

    pkg_traza.trace('sbConsecutivo|' || sbConsecutivo, csbNivelTraza);
    /*c.  Se deberán identificar los contratos que cumplan las siguientes condiciones:
    i.  Cuentas de cobro que estén pendientes de pago (CUENCOBR.CUCOSACU > 0)
    ii. Contratos que implemente el Debito Automático (SUSCRIPC.SUSCTDCO = `DA¿)
    iii.  Basado en el valor del parámetro JOBDEBAUTOMODOEJEC:
    1.  Cuando el parámetro tenga el valor de M: Se validará que el SYSDATE = PERIFACT.PEFAFFMO + X días (este valor se obtendrá del parámetro JOBDEBAUTODIASEJEC)
    2.  Cuando el parámetro tenga el valor de P:  Se validará que SYSDATE = CUENCOBR.CUCOFEPA - X días (este valor se obtendrá del parámetro JOBDEBAUTODIASEJEC)*/
    /*se agruparan las diferentes fechas de pago*/
    sbModoEjecucion :=
        dald_parameter.fsbGetValue_Chain ('JOBDEBAUTOMODOEJEC');
    pkg_traza.trace('sbModoEjecucion|' || sbModoEjecucion, csbNivelTraza);

    nuDiasejecucion :=
        NVL (dald_parameter.fnuGetNumeric_Value ('JOBDEBAUTODIASEJEC'), 0);
    pkg_traza.trace('nuDiasejecucion|' || nuDiasejecucion, csbNivelTraza);

    --cambio cucofepa por cucofeve --Caso 656_3
    --se controla la fecha para que no se repitan --Caso 656_7
    sbQuery :=
        'select to_date(fecha, ''yyyy-mm-dd'') from (Select to_char(cc.cucofeve, ''yyyy-mm-dd'') as fecha';

    IF sbModoEjecucion = 'M'
    THEN
        --cambio cucofepa por cucofeve --Caso 656_3
        sbQuery :=
               sbQuery
            || ' From suscripc s, servsusc ss, cuencobr cc, perifact p, factura f
where ss.sesususc = s.susccodi
and cc.cuconuse = ss.sesunuse
and cc.cucofact = f.factcodi
and f.factpefa = p.pefacodi
and s.susctdco = ''DA''
and cc.cucosacu > 0
and cc.cucofeve is not null
and to_char(p.pefaffmo + '
            || TO_CHAR (nuDiasejecucion)
            || ', ''yyyy-mm-dd'') = to_char(sysdate, ''yyyy-mm-dd'')';
    ELSIF sbModoEjecucion = 'P'
    THEN
        --cambio cucofepa por cucofeve --Caso 656_3
        sbQuery :=
               sbQuery
            || ' From suscripc s, servsusc ss, cuencobr cc
where ss.sesususc = s.susccodi
and cc.cuconuse = ss.sesunuse
and s.susctdco = ''DA''
and cc.cucosacu > 0
and to_char(cc.cucofeve - '
            || TO_CHAR (nuDiasejecucion)
            || ', ''yyyy-mm-dd'') = to_char(sysdate, ''yyyy-mm-dd'')';
    ELSE
        sbMsgError :=
            'Defina en el Parametro JOBDEBAUTOMODOEJEC el modo de Ejecucion.';
        pkg_error.setErrorMessage( isbMsgErrr => sbMsgError );
    END IF;

    --cambio cucofepa por cucofeve --Caso 656_3
    sbQuery := sbQuery || ' Group by to_char(cc.cucofeve, ''yyyy-mm-dd''))';

    pkg_traza.trace('sbQuery|' || sbQuery, csbNivelTraza);

    /*2.  Se creará un primer agrupamiento por Banco. Los Bancos estarán definidos por el parámetro JOBDEBAUTOENTBANC*/
    OPEN curBancos;

    LOOP
        FETCH curBancos INTO sbBanco;

        EXIT WHEN curBancos%NOTFOUND;

        pkg_traza.trace('sbBanco|' || sbBanco, csbNivelTraza);

        /*a.  Se deberán identificar los formatos que apliquen al Banco identificado, para ello se validara en la tabla PRDAENTI en donde el código del banco este asociado en el campo PDENBANC y PDENEVEN = 2 (Evento de Débito Automático de Envió). Esta configuración son las diseñadas desde FGIA.*/
        OPEN curFormatos (TO_NUMBER (sbBanco));

        FETCH curFormatos
            INTO sbPdenpren,
                 sbPdenprde,
                 sbPdenprto,
                 sbPdenpres,
                 sbPdenprva,
                 sbPdenpato;

        CLOSE curFormatos;

        pkg_traza.trace('sbPdenpren|' || sbPdenpren, csbNivelTraza);
        pkg_traza.trace('sbPdenprde|' || sbPdenprde, csbNivelTraza);
        pkg_traza.trace('sbPdenprto|' || sbPdenprto, csbNivelTraza);
        pkg_traza.trace('sbPdenpres|' || sbPdenpres, csbNivelTraza);
        pkg_traza.trace('sbPdenprva|' || sbPdenprva, csbNivelTraza);
        pkg_traza.trace('sbPdenpato|' || sbPdenpato, csbNivelTraza);

        /*b.  Se creará un segundo agrupamiento a partir de las fechas de pago identificadas en el punto 1.c.*/
        OPEN curFechas FOR sbQuery;

        LOOP
            FETCH curFechas INTO dtFecha;

            EXIT WHEN curFechas%NOTFOUND;

            pkg_traza.trace('dtFecha|' || TO_CHAR(dtFecha,'dd/mm/yyyy hh24:mi:ss'), csbNivelTraza);

            /*i.  Se aplicará un ciclo repetitivo que estará condicionado de la siguiente forma para controlar el agrupamiento por departamento
            1.  Si no está agrupado por departamento el ciclo solo se ejecutará una vez
            2.  Si esta agrupado por departamentos, se ejecutara una vez por cada departamento identificado en el punto 1.a.i. */
            IF sbAgrupxDpto = 'S'
            THEN
                sbQueryDpto :=
                    'select gel.geograp_location_id codigo, lpad(gel.description, 3) from ge_geogra_location gel where gel.geog_loca_area_type = 2';
            ELSE
                sbQueryDpto :=
                    'select 1 as codigo, ''XXX'' as descripcion from dual';
            END IF;

            pkg_traza.trace('sbQueryDpto|' || sbQueryDpto, csbNivelTraza);

            OPEN curDepto FOR sbQueryDpto;

            LOOP
                FETCH curDepto INTO nuCoddepto, sbDescdepto;

                EXIT WHEN curDepto%NOTFOUND;

                pkg_traza.trace('nuCoddepto|' || nuCoddepto || '|sbDescdepto|' || sbDescdepto, csbNivelTraza);
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
                sbAplicarFecha :=
                    dald_parameter.fsbGetValue_Chain ('JOBDEBAUTOFECHPAG');

                pkg_traza.trace('sbAplicarFecha|' || sbAplicarFecha , csbNivelTraza);

                IF sbAplicarFecha <> 'S' AND sbAplicarFecha <> 'N'
                THEN
                    sbMsgError :=
                        'Defina en el Parametro JOBDEBAUTOFECHPAG si se aplicara la Fecha de Limite de Pago';
                    pkg_error.setErrorMessage( isbMsgErrr => sbMsgError );
                END IF;

                sbEncabezadofile := '';

                OPEN curObjetos (sbPdenpren);

                LOOP
                    FETCH curObjetos
                        INTO sbFrarcrar,
                             sbCrartida,
                             nuFrarloma,
                             nuFrardeci,
                             sbFrarfoca,
                             sbFrarcoca;

                    EXIT WHEN curObjetos%NOTFOUND;
                    sbTempcadena := '';

                    pkg_traza.trace('sbFrarcrar|' || sbFrarcrar , csbNivelTraza);
                    pkg_traza.trace('sbCrartida|' || sbCrartida , csbNivelTraza);
                    pkg_traza.trace('nuFrarloma|' || nuFrarloma , csbNivelTraza);
                    pkg_traza.trace('nuFrardeci|' || nuFrardeci , csbNivelTraza);
                    pkg_traza.trace('sbFrarfoca|' || sbFrarfoca , csbNivelTraza);
                    pkg_traza.trace('sbFrarcoca|' || sbFrarcoca , csbNivelTraza);

                    CASE
                        WHEN sbFrarcrar = 'BANK_CODE'
                        THEN
                            sbTempcadena := sbBanco;
                        WHEN sbFrarcrar = 'PROCESS_DATE'
                        THEN
                            IF sbAplicarFecha = 'S'
                            THEN
                                sbTempcadena := TO_CHAR (dtFecha, 'yyyymmdd');
                            ELSE
                                sbTempcadena := TO_CHAR (SYSDATE, 'yyyymmdd');
                            END IF;
                        WHEN sbFrarcrar = 'PROCESS_HOUR'
                        THEN
                            IF sbAplicarFecha = 'S'
                            THEN
                                sbTempcadena := '0001';
                            ELSE
                                sbTempcadena := TO_CHAR (SYSDATE, 'hh24mi');
                            END IF;
                        WHEN sbFrarcrar = 'FILE_MODIFIER'
                        THEN
                            sbTempcadena := sbConsecutivo;
                        WHEN sbFrarcrar = 'FILLER'
                        THEN
                            sbTempcadena := ' ';
                        ELSE
                            sbTempcadena := sbFrarcoca;
                    END CASE;

                    IF sbCrartida = 'C'
                    THEN
                        sbTempcadena := RPAD (sbTempcadena, nuFrarloma, ' ');
                    ELSIF sbCrartida = 'N'
                    THEN
                        --sbTempcadena := lpad(sbTempcadena, nuFrarloma + nuFrardeci, '0'); --Caso 656_2
                        sbTempcadena := LPAD (sbTempcadena, nuFrarloma, '0');
                    END IF;

                    sbEncabezadofile := sbEncabezadofile || sbTempcadena;
                END LOOP;

                CLOSE curObjetos;

                pkg_traza.trace('sbEncabezadofile|' || sbEncabezadofile , csbNivelTraza);

                /*iii.  Se diseñará el Encabezado del Lote basado en el formato del campo PDENPRDE identificado en el punto 2.a.
                1.  A los objetos con valor en FRARCOCA se les asignara ese valor por defecto y se les aplicara el formato definido en FRARFOCA si lo tienen.
                2.  Se aplicará en el FILLER2 el valor de ¿ ¿ (espacio en blanco) aplicando los formatos de relleno indicados en la tabla.
                3.  La línea generada será guardada en una variable para su registro posterior en el archivo*/
                sbEncabezadoLote := '';

                OPEN curObjetos (sbPdenprde);

                LOOP
                    FETCH curObjetos
                        INTO sbFrarcrar,
                             sbCrartida,
                             nuFrarloma,
                             nuFrardeci,
                             sbFrarfoca,
                             sbFrarcoca;

                    EXIT WHEN curObjetos%NOTFOUND;
                    sbTempcadena := '';

                    CASE
                        WHEN sbFrarcrar = 'FILLER 2'
                        THEN
                            sbTempcadena := ' ';
                        ELSE
                            sbTempcadena := sbFrarcoca;
                    END CASE;

                    IF sbCrartida = 'C'
                    THEN
                        sbTempcadena := RPAD (sbTempcadena, nuFrarloma, ' ');
                    ELSIF sbCrartida = 'N'
                    THEN
                        --sbTempcadena := lpad(sbTempcadena, nuFrarloma + nuFrardeci, '0'); --Caso 656_2
                        sbTempcadena := LPAD (sbTempcadena, nuFrarloma, '0');
                    END IF;

                    sbEncabezadoLote := sbEncabezadoLote || sbTempcadena;
                END LOOP;

                CLOSE curObjetos;

                pkg_traza.trace('sbEncabezadoLote|' || sbEncabezadoLote , csbNivelTraza);

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
                sbQuerydetail :=
                    'Select cupon, contrato, mes, ciclo, sum(valor), fecha, cuenta, banco, identificacion, periodo, factura from (Select (select c.cuponume from cupon c where c.cupodocu = f.factcodi and c.cupoflpa = ''N'' and c.cupotipo = ''FA'' and c.cupoprog = ''FIDF'' and c.cuposusc = s.susccodi and c.cupofech = (select max(c1.cupofech) from cupon c1 where c1.cupodocu = f.factcodi and c1.cupoflpa = ''N'' and c1.cupotipo = ''FA'' and c1.cupoprog = ''FIDF'' and c1.cuposusc = s.susccodi) and rownum = 1) as cupon, s.SUSCCODI as contrato, p.pefames as mes, s.SUSCCICL as ciclo, 0 as valor, to_char(cc.cucofeve, ''yyyymmdd'') as fecha, s.SUSCCUCO as cuenta, s.SUSCTCBA as banco, nvl(s.suscidtt, ''0'') as identificacion, f.factpefa as periodo, f.factcodi as factura';

                IF sbAgrupxDpto = 'S'
                THEN
                    IF sbModoEjecucion = 'M'
                    THEN
                        --cambio cucofepa por cucofeve --Caso 656_3
                        sbQuerydetail :=
                               sbQuerydetail
                            || ' From suscripc s, servsusc ss, cuencobr cc, perifact p, ge_subscriber g, factura f, ab_address a
where ss.sesususc = s.susccodi
and s.suscbanc = '
                            || sbBanco
                            || '
and cc.cuconuse = ss.sesunuse
and s.susctdco = ''DA''
and cc.cucosacu > 0
and cc.cucofact = f.factcodi
and f.factpefa = p.pefacodi
and f.factprog = 6
and s.suscclie = g.subscriber_id
and to_char(cc.cucofeve, ''yyyy-mm-dd'') = '''
                            || TO_CHAR (dtFecha, 'yyyy-mm-dd')
                            || '''
and a.address_id = cc.cucodiin
and dage_geogra_location.fnugetgeo_loca_father_id(a.geograp_location_id,null) = '
                            || nuCoddepto
                            || '
and to_char(p.pefaffmo + '
                            || TO_CHAR (nuDiasejecucion)
                            || ', ''yyyy-mm-dd'') = to_char(sysdate, ''yyyy-mm-dd'')';
                    ELSE
                        --cambio cucofepa por cucofeve --Caso 656_3
                        sbQuerydetail :=
                               sbQuerydetail
                            || ' From suscripc s, servsusc ss, cuencobr cc, ge_subscriber g, perifact p, factura f, ab_address a
where ss.sesususc = s.susccodi
and s.suscbanc = '
                            || sbBanco
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
                            || nuCoddepto
                            || '
and to_char(cc.cucofeve, ''yyyy-mm-dd'') = '''
                            || TO_CHAR (dtFecha, 'yyyy-mm-dd')
                            || '''';
                    END IF;
                ELSE
                    IF sbModoEjecucion = 'M'
                    THEN
                        --cambio cucofepa por cucofeve --Caso 656_3
                        sbQuerydetail :=
                               sbQuerydetail
                            || ' From suscripc s, servsusc ss, cuencobr cc, perifact p, ge_subscriber g, factura f
where ss.sesususc = s.susccodi
and s.suscbanc = '
                            || sbBanco
                            || '
and cc.cuconuse = ss.sesunuse
and s.susctdco = ''DA''
and cc.cucosacu > 0
and cc.cucofact = f.factcodi
and f.factpefa = p.pefacodi
and f.factprog = 6
and s.suscclie = g.subscriber_id
and to_char(cc.cucofeve, ''yyyy-mm-dd'') = '''
                            || TO_CHAR (dtFecha, 'yyyy-mm-dd')
                            || '''
and to_char(p.pefaffmo + '
                            || TO_CHAR (nuDiasejecucion)
                            || ', ''yyyy-mm-dd'') = to_char(sysdate, ''yyyy-mm-dd'')';
                    ELSE
                        --cambio cucofepa por cucofeve --Caso 656_3
                        sbQuerydetail :=
                               sbQuerydetail
                            || ' From suscripc s, servsusc ss, cuencobr cc, ge_subscriber g, perifact p, factura f
where ss.sesususc = s.susccodi
and s.suscbanc = '
                            || sbBanco
                            || '
and cc.cuconuse = ss.sesunuse
and s.susctdco = ''DA''
and cc.cucosacu > 0
and cc.cucofact = f.factcodi
and f.factpefa = p.pefacodi
and f.factprog = 6
and s.suscclie = g.subscriber_id
and to_char(cc.cucofeve, ''yyyy-mm-dd'') = '''
                            || TO_CHAR (dtFecha, 'yyyy-mm-dd')
                            || '''';
                    END IF;
                END IF;

                --Caso 656_3 Se agrego el agrupamiento
                --Caso 656_8 Se agrega el periodo de facturacion
                sbQuerydetail :=
                       sbQuerydetail
                    || ') group by cupon, contrato, mes, ciclo, fecha, cuenta, banco, identificacion, periodo, factura';
                nuContDetail := 0;
                nuTotalesV := 0;

                pkg_traza.trace('sbQuerydetail|' || sbQuerydetail , csbNivelTraza);

                OPEN curDetalles FOR sbQuerydetail;

                LOOP
                    FETCH curDetalles
                        INTO nuCuponnume,
                             nuSusccodi,
                             nuPefames,
                             nuSusccicl,
                             nuCucosacu,
                             sbCucofepa,
                             sbSusccuco,
                             nuSusctcba,
                             sbIdentification,
                             nuPeriodoFact, --Caso 656_8: se agrega el Periodo de facturacion
                             sbnumfactura;  --Caso 656_8: se agrega la factura

                    EXIT WHEN curDetalles%NOTFOUND;

                    --Se valida cuando el Cupon no este vacio. Caso 656_6
                    IF nuCuponnume IS NOT NULL
                    THEN
                        --Cambio 656_8: se agrego el registro en la tabla GST_PREVDEAU y GST_HIDASUSC
                        --validacion de registro en GST_PREVDEAU
                        nucodGST_PREVDEAU := NULL;

                        OPEN cuExistGSTPREVDEAU (TO_NUMBER (sbBanco),
                                                 nuEventBanc,
                                                 nuSusccicl,
                                                 nuPeriodoFact);

                        FETCH cuExistGSTPREVDEAU INTO nucodGST_PREVDEAU;

                        CLOSE cuExistGSTPREVDEAU;

                        --si no encuentra el evento programado en GST_PREVDEAU lo inserta
                        IF (nucodGST_PREVDEAU IS NULL)
                        THEN
                            nucodGST_PREVDEAU := SQGST_PRDECODI.NEXTVAL;

                            INSERT INTO GST_PREVDEAU (prdecodi,
                                                      prdebanc,
                                                      prdeevda,
                                                      prdecifa,
                                                      prdepefa,
                                                      prdefepr,
                                                      prdeflca,
                                                      prdeobse)
                                     VALUES (
                                                nucodGST_PREVDEAU,
                                                TO_NUMBER (sbBanco),
                                                nuEventBanc,
                                                nuSusccicl,
                                                nuPeriodoFact,
                                                SYSDATE,
                                                sbStatHistevpr,
                                                'Generado desde GENERATEFILEDEBITAUTO');

                            COMMIT;
                        END IF;

                        --elimino historicos previos registrados para evitar errores
                        DELETE FROM
                            gst_hidasusc
                              WHERE     hisufact = sbnumfactura
                                    AND hisususc = nuSusccodi;

                        --se registra el historico
                        INSERT INTO gst_hidasusc (hisuprde,
                                                  hisufact,
                                                  hisususc,
                                                  hisuvaco,
                                                  hisufeen,
                                                  hisuesta)
                             VALUES (nucodGST_PREVDEAU,
                                     sbnumfactura,
                                     nuSusccodi,
                                     nuCucosacu,
                                     SYSDATE,
                                     sbStatHistdesusc);

                        COMMIT;
                        --Fin 656_8
                        --
                        nuContDetail := nuContDetail + 1;
                        sbArrayDetalles (nuContDetail) := '';

                        OPEN curObjetos (sbPdenprto);

                        LOOP
                            FETCH curObjetos
                                INTO sbFrarcrar,
                                     sbCrartida,
                                     nuFrarloma,
                                     nuFrardeci,
                                     sbFrarfoca,
                                     sbFrarcoca;

                            EXIT WHEN curObjetos%NOTFOUND;
                            sbTempcadena := '';

                            CASE
                                WHEN sbFrarcrar = 'COUPON'
                                THEN
                                    sbTempcadena := TO_CHAR (nuCuponnume);
                                WHEN sbFrarcrar = 'INSTALATION'
                                THEN
                                    sbTempcadena := TO_CHAR (nuSusccodi);
                                WHEN sbFrarcrar = 'MONTH'
                                THEN
                                    sbTempcadena := TO_CHAR (nuPefames);
                                WHEN sbFrarcrar = 'CYCLE'
                                THEN
                                    sbTempcadena := TO_CHAR (nuSusccicl);
                                WHEN sbFrarcrar = 'VALUE_DEBIT'
                                THEN
                                    --sbTempcadena := to_char(nuCucosacu * 100);
                                    --nuTotalesV   := nuTotalesV + nuCucosacu;
                                    --656_10 se consulta el valor del Cupon
                                    SELECT ROUND (c.cupovalo, 0)
                                      INTO nuValueDebit
                                      FROM cupon c
                                     WHERE c.cuponume = nuCuponnume;

                                    sbTempcadena :=
                                        TO_CHAR (nuValueDebit * 100);
                                    nuTotalesV := nuTotalesV + nuValueDebit;
                                --
                                WHEN sbFrarcrar = 'ADITIONAL_SERVICE_VALUE'
                                THEN
                                    sbTempcadena := '0';
                                WHEN sbFrarcrar = 'EXPIRATION_DATE'
                                THEN
                                    sbTempcadena := sbCucofepa;
                                WHEN sbFrarcrar = 'ACCOUNT_NUMBER'
                                THEN
                                    sbTempcadena := sbSusccuco;
                                WHEN sbFrarcrar = 'ACCOUNT_TYPE'
                                THEN
                                    sbTempcadena := TO_CHAR (nuSusctcba);
                                WHEN sbFrarcrar = 'SUBS_ID_NUMBER'
                                THEN
                                    sbTempcadena := sbIdentification;
                                WHEN sbFrarcrar = 'FILLER 4'
                                THEN
                                    sbTempcadena := ' ';
                                WHEN sbFrarcrar = 'FILLER 2'
                                THEN
                                    sbTempcadena := ' ';
                                ELSE
                                    sbTempcadena := sbFrarcoca;
                            END CASE;

                            IF sbCrartida = 'C'
                            THEN
                                sbTempcadena :=
                                    RPAD (sbTempcadena, nuFrarloma, ' ');
                            ELSIF sbCrartida = 'N'
                            THEN
                                --sbTempcadena := lpad(sbTempcadena,nuFrarloma + nuFrardeci,'0'); --Caso 656_2
                                sbTempcadena :=
                                    LPAD (sbTempcadena, nuFrarloma, '0');
                            END IF;

                            sbArrayDetalles (nuContDetail) :=
                                   sbArrayDetalles (nuContDetail)
                                || sbTempcadena;
                        END LOOP;

                        CLOSE curObjetos;
                    END IF;
                END LOOP;

                CLOSE curDetalles;

                /*v.  Solo se procede a la definición de los totales, si el total de registros identificados en el punto anterior (2.b.iv) es mayor a 0*/
                IF nuContDetail > 0
                THEN
                    /*1.  Se diseñará el Total del Lote basado en el formato del campo PDENPRES identificado en el punto 2.a.
                    a.  A los objetos con valor en FRARCOCA se les asignara ese valor por defecto y se les aplicara el formato definido en FRARFOCA si lo tienen.
                    b.  Se aplicara en el RECORDS_NUMBER el total de Cuentas de Cobro recorridas en el punto 2.b.iv. aplicando los formatos de relleno indicados en la tabla.
                    c.  Se aplicara en el RECEIVED_TOTALNUMBER el valor de la sumatoria de los valores a pagar (CUENCOBR.CUCOSACU) identificados en el punto 2.b.iv. aplicando los formatos de relleno indicados en la tabla.
                    d.  Se aplicará en el RECEIVED_TOTAL_VAL_ADITIONAL el valor de 0 aplicando los formatos de relleno indicados en la tabla.
                    e.  Se aplicará en el CONSECUTIVE el valor de 1 aplicando los formatos de relleno indicados en la tabla.
                    f.  Se aplicará en el FILLER el valor de ¿ ¿ (espacio en blanco) aplicando los formatos de relleno indicados en la tabla.
                    g.  La línea generada será guardada en una variable para su registro posterior en el archivo*/
                    sbTotaldetalle := '';

                    OPEN curObjetos (sbPdenpres);

                    LOOP
                        FETCH curObjetos
                            INTO sbFrarcrar,
                                 sbCrartida,
                                 nuFrarloma,
                                 nuFrardeci,
                                 sbFrarfoca,
                                 sbFrarcoca;

                        EXIT WHEN curObjetos%NOTFOUND;
                        sbTempcadena := '';

                        CASE
                            WHEN sbFrarcrar = 'RECORDS_NUMBER'
                            THEN
                                sbTempcadena := TO_CHAR (nuContDetail);
                            WHEN sbFrarcrar = 'RECEIVED_TOTAL_VALUE'
                            THEN
                                sbTempcadena := TO_CHAR (nuTotalesV * 100);
                            WHEN sbFrarcrar = 'RECEIVED_TOTAL_VAL_ADITIONAL'
                            THEN
                                sbTempcadena := '0';
                            WHEN sbFrarcrar = 'CONSECUTIVE'
                            THEN
                                sbTempcadena := '1';
                            WHEN sbFrarcrar = 'FILLER'
                            THEN
                                sbTempcadena := ' ';
                            ELSE
                                sbTempcadena := sbFrarcoca;
                        END CASE;

                        IF sbCrartida = 'C'
                        THEN
                            sbTempcadena :=
                                RPAD (sbTempcadena, nuFrarloma, ' ');
                        ELSIF sbCrartida = 'N'
                        THEN
                            --sbTempcadena := lpad(sbTempcadena,nuFrarloma + nuFrardeci,'0'); --Caso 656_2
                            sbTempcadena :=
                                LPAD (sbTempcadena, nuFrarloma, '0');
                        END IF;

                        sbTotaldetalle := sbTotaldetalle || sbTempcadena;
                    END LOOP;

                    CLOSE curObjetos;

                    /*2.  Se diseñará el Total del Archivo basado en el formato del campo PDENPRVA identificado en el punto 2.a.
                    a.  A los objetos con valor en FRARCOCA se les asignara ese valor por defecto y se les aplicara el formato definido en FRARFOCA si lo tienen.
                    b.  Se aplicara en el RECORDS_NUMBER el total de cuentas de cobro recorridas en el punto 2.b.iv. aplicando los formatos de relleno indicados en la tabla.
                    c.  Se aplicara en el RECEIVED_TOTAL_VALUE el valor de sumatoria de los valores a pagar (CUENCOBR.CUCOSACU) identificados en el punto 2.b.iv. aplicando los formatos de relleno indicados en la tabla.
                    d.  Se aplicará en el FILLER el valor de ¿ ¿ (espacio en blanco) aplicando los formatos de relleno indicados en la tabla.
                    e.  La línea generada será guardada en una variable para su registro posterior en el archivo*/
                    sbTotalFile := '';

                    OPEN curObjetos (sbPdenprva);

                    LOOP
                        FETCH curObjetos
                            INTO sbFrarcrar,
                                 sbCrartida,
                                 nuFrarloma,
                                 nuFrardeci,
                                 sbFrarfoca,
                                 sbFrarcoca;

                        EXIT WHEN curObjetos%NOTFOUND;
                        sbTempcadena := '';

                        CASE
                            WHEN sbFrarcrar = 'RECORDS_NUMBER'
                            THEN
                                sbTempcadena := TO_CHAR (nuContDetail);
                            WHEN sbFrarcrar = 'RECEIVED_TOTAL_VALUE'
                            THEN
                                sbTempcadena := TO_CHAR (nuTotalesV * 100);
                            WHEN sbFrarcrar = 'FILLER'
                            THEN
                                sbTempcadena := ' ';
                            ELSE
                                sbTempcadena := sbFrarcoca;
                        END CASE;

                        IF sbCrartida = 'C'
                        THEN
                            sbTempcadena :=
                                RPAD (sbTempcadena, nuFrarloma, ' ');
                        ELSIF sbCrartida = 'N'
                        THEN
                            --sbTempcadena := lpad(sbTempcadena,nuFrarloma + nuFrardeci,'0'); --Caso 656_2
                            sbTempcadena :=
                                LPAD (sbTempcadena, nuFrarloma, '0');
                        END IF;

                        sbTotalFile := sbTotalFile || sbTempcadena;
                    END LOOP;

                    CLOSE curObjetos;

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
                    IF sbAgrupxDpto = 'S'
                    THEN
                        sbNamefile :=
                               LPAD (sbBanco, 4, '0')
                            || '_'
                            || TO_CHAR (dtFecha, 'yyyymmdd')
                            || '_'
                            || sbDescdepto
                            || '_'
                            || sbConsecutivo
                            || '.txt';
                    ELSE
                        sbNamefile :=
                               LPAD (sbBanco, 4, '0')
                            || '_'
                            || TO_CHAR (dtFecha, 'yyyymmdd')
                            || '_'
                            || sbConsecutivo
                            || '.txt';
                    END IF;

                    BEGIN
                        flDebitoAuto :=
                            pkg_gestionArchivos.ftAbrirArchivo_SMF (sbPdenpato, sbNamefile, 'W');
                        pkg_gestionArchivos.prcEscribirLinea_SMF (flDebitoAuto, sbEncabezadoFile);
                        pkg_gestionArchivos.prcEscribirLinea_SMF (flDebitoAuto, sbEncabezadoLote);

                        FOR nuCiclo IN 1 .. nuContDetail
                        LOOP
                            pkg_gestionArchivos.prcEscribirLinea_SMF (flDebitoAuto,
                                               sbArrayDetalles (nuCiclo));
                        END LOOP;

                        pkg_gestionArchivos.prcEscribirLinea_SMF (flDebitoAuto, sbTotaldetalle);
                        pkg_gestionArchivos.prcEscribirLinea_SMF (flDebitoAuto, sbTotalFile);
                        pkg_gestionArchivos.prcCerrarArchivo_SMF (flDebitoAuto, sbPdenpato, sbNamefile);
                        sbStatusFile :=
                            sbStatusFile || sbNamefile || ' - Ok<br>';

                        /*ASCII (97-122)(a - z) y (48-57)(0-9)*/
                        IF nuSecuencia >= 97 AND nuSecuencia < 122
                        THEN
                            nuSecuencia := nuSecuencia + 1;
                        ELSIF nuSecuencia = 122
                        THEN
                            nuSecuencia := 48;
                        ELSIF nuSecuencia >= 48 AND nuSecuencia < 57
                        THEN
                            nuSecuencia := nuSecuencia + 1;
                        END IF;

                        sbConsecutivo := CHR (nuSecuencia);
                    EXCEPTION
                        WHEN OTHERS
                        THEN
                            IF sbAgrupxDpto = 'S'
                            THEN
                                sbStatusFile :=
                                       sbStatusFile
                                    || 'El archivo Correspondiente al Banco ('
                                    || sbBanco
                                    || '), Fecha de Pago ('
                                    || TO_CHAR (dtFecha, 'yyyy-mm-dd')
                                    || ') y Departamento ('
                                    || sbDescdepto
                                    || ') no pudo ser creado - Error<br>';
                            ELSE
                                sbStatusFile :=
                                       sbStatusFile
                                    || 'El archivo Correspondiente al Banco ('
                                    || sbBanco
                                    || ') y Fecha de Pago ('
                                    || TO_CHAR (dtFecha, 'yyyy-mm-dd')
                                    || ') no pudo ser creado - Error<br>';
                            END IF;
                    END;
                END IF;
            END LOOP;

            CLOSE curDepto;
        END LOOP;

        CLOSE curFechas;
    END LOOP;

    CLOSE curbancos;

    /*3.  Al finalizar el proceso se usará el servicio LDC_SENDEMAIL, con el cual se enviará un correo con un resumen de los archivos creados en el proceso
    a.  El correo que recibe deberá ser el configurado en el Parámetro MAILRECEIVEDEBAUTO
    b.  El correo tendrá por Asunto el valor del contenido en el Parámetro MAILSUBJECTDEBAUTO
    c.  El correo detallara en el mensaje las Entidades, la Fecha de Pago y los ciclos que fueron procesados y cuales terminaron con éxito o no. Además, indicara el Departamento en caso de estar agrupado por departamentos.
    */
    IF sbStatusFile IS NOT NULL
    THEN
        sbStatusFile :=
               '<html><head><title>Resumen de Archivos Procesados</title><meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"></head><body><h3>Resumen de Archivos Procesados</h3><br><br>'
            || sbStatusFile
            || '</body></html>';
    ELSE
        sbStatusFile :=
            '<html><head><title>Resumen de Archivos Procesados</title><meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"></head><body><h3>Resumen de Archivos Procesados</h3><br><br>Ningun Archivo de Debito Automatico fue creado.</body></html>';
    END IF;

    pkg_traza.trace('sbStatusFile|' || sbStatusFile, csbNivelTraza);

    sendmail (sbStatusFile);

    pkg_estaproc.practualizaestaproc(isbproceso => sbproceso, isbEstado => 'Ok', isbObservacion => 'Registro de Debitos Automaticos' );

    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);


    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            sendmail (sbError);
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            sendmail (sbError);
            RAISE pkg_error.Controlled_Error;
END GENERATEFILEDEBITAUTO;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('GENERATEFILEDEBITAUTO', 'ADM_PERSON');
END;
/
