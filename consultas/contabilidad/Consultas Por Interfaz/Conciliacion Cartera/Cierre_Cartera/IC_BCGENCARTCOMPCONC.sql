CREATE OR REPLACE PACKAGE IC_BCGenCartCompConc IS
/*
    Propiedad intelectual de Open International Systems. (c).

    Package	    :   IC_BCGenCartCompConc

    Descripcion	:   Componente de negocio de primer nivel para la Generacion
                    de Informacion de cartera.

    Autor       :   Adriana Calderón Home
    Fecha       :   21-02-2012

    Historia de Modificaciones
    Fecha	   IDEntrega

    01-09-2014  hlopez.SAO267295
    Se adiciona el servicio <ObtFechaVenc> para obtener la fecha de vencimiento
    mas antigua de un producto.

    20-08-2014  mgutierrSAO264593
    <GenAccountsBalPastPort>

    21-07-204   eurbano.SAO258199
    Se modifica el método <GenAccountsBalPastPort>
                           <GetAccounts>
                mgutierr.SAO258603
    Se modifica el método <GetDeferredInfo>

    12-06-2014  eurbano.SAO245313 se modifican los métodos
    <GenAccountsBalSysdate>
    <GenAccountsBalPastPort>
    <GetCharges>

    19-01-2014  arendon.SAO230033
    Se modifican los métodos:
        - GetDeferredInfo
    Se adiciona el método:
        - GenDeferredInfo
    Se eliminan los métodos:
        - InsTmpDeferred

    12-12-2013  arendon.SAO223290
    Se adiciona el método <GetDeferredInfo>

    19-03-2013  arendon.SAO201909
    Se adicionan los métodos:
        - GetAccounts
        - fboExistPymtsAccDate
        - fnuDeferredToProcess

    09-10-2012  arendon.SAO193224
    Se modifica el método <InsRecordsPortfolio>

    03-10-2012  arendon.SAO192678
    Se modifica el método <InsPastRecords>.
    Se adicionan los métodos:
        -GetBillInfo
    Se adicionan los tipos:
        - tyrcVoucherInfo
        - tytbVoucherInfo

    21-08-2012  arendon.SAO185247
    Se re-crea el paquete por cambio en la funcionalidad.

    21-02-2012  acalderonSAO180618
    Creación
*/

    -------------------
    -- Tipos
    -------------------
    type tyrcAccounts IS record
    (
        caccclie    ic_cartcoco.caccclie%type, -- Cliente
        caccticl    ic_cartcoco.caccticl%type, -- Tipo de Cliente
        caccidcl    ic_cartcoco.caccidcl%type, -- Identificación del cliente
        caccsusc    ic_cartcoco.caccsusc%type, -- Contrato
        caccserv    ic_cartcoco.caccserv%type, -- Tipo de Producto
        caccnuse    ic_cartcoco.caccnuse%type, -- Producto
        caccesco    ic_cartcoco.caccesco%type, -- Estado Corte
        caccubg1    ic_cartcoco.caccubg1%type, -- Ubicación Geográfica
        caccubg2    ic_cartcoco.caccubg2%type, -- Barrio
        cacccate    ic_cartcoco.cacccate%type, -- Categoría
        caccsuca    ic_cartcoco.caccsuca%type, -- Subcategoria
        factconf    factura.factconf%type,     -- Consecutivo
        caccpref    ic_cartcoco.caccpref%type, -- Serie del Comprobante
        caccnufi    ic_cartcoco.caccnufi%type, -- Número Fiscal
        cacccomp    ic_cartcoco.cacccomp%type, -- Comprobante
        cacccuco    ic_cartcoco.cacccuco%type, -- Cuenta de Cobro
        caccfeve    ic_cartcoco.caccfeve%type, -- Fecha de Vencimiento
        cacccicl    ic_cartcoco.cacccicl%type  -- Ciclo
    );

    type tytbAccounts IS table of tyrcAccounts index BY pls_integer;

    type tyrcDeferred IS record
    (
        difecodi            diferido.difecodi%type,
        difesape            diferido.difesape%type,
        difecupa            diferido.difecupa%type,
        difeconc            diferido.difeconc%type,
        difenuse            diferido.difenuse%type,
        difefein            diferido.difefein%type,
        difeinte            diferido.difeinte%type,
        difespre            diferido.difespre%type,
        difetain            diferido.difetain%type,
        difemeca            diferido.difemeca%type,
        difevacu            diferido.difevacu%type,
        difesign            diferido.difesign%type,
        difevatd            diferido.difevatd%type,
        difefagr            diferido.difefagr%type,
        difenucu            diferido.difenucu%type,
        sesucate            servsusc.sesucate%type,
        susccicl            suscripc.susccicl%type,
        suscclie            suscripc.suscclie%type,
        sesuesco            servsusc.sesuesco%type,
        sesuserv            servsusc.sesuserv%type,
        sesusuca            servsusc.sesusuca%type,
        sesususc            servsusc.sesususc%type,
        identification      ge_subscriber.identification%type,
        subscriber_type_id  ge_subscriber.subscriber_type_id%type,
        geograp_location_id ab_address.geograp_location_id%type,
        neighborthood_id    ab_address.neighborthood_id%type,
        geog_loca_area_type ge_geogra_location.geog_loca_area_type%type
    );

    type tytbDeferred IS table of tyrcDeferred index BY pls_integer;

    -------------------
    -- Métodos
    -------------------
    FUNCTION fsbVersion
        return varchar2;

    -- Obtiene fecha de la última ejecución
    FUNCTION fdtLastDate
        return date;

    -- Obtiene los cargos de Aplicación de saldo a favor.
    PROCEDURE GetCharges
    (
        inuCucocodi in  cuencobr.cucocodi%type,
        idtGenDate  in  cargos.cargfecr%type,
        otbCharges  out nocopy pkConceptValuesMgr.tytbCargosDist
    );

    -- Obtiene los regitros de cartera para la fecha
    PROCEDURE GetRecords
    (
        idtDate     in  ic_cartcoco.caccfege%type,
        inuLimit    in  number,
        otbCacccons out nocopy pktblIc_cartcoco.tyCacccons
    );

    -- Inserta temporalmente la información de diferidos
    PROCEDURE GenDeferredInfo
    (
        idtDateLastSec  in  ic_cartcoco.caccfege%type,
        isbRecType      in  diferido.difetire%type
    );

    -- Obtiene las cuentas de cobro a procesar
    PROCEDURE GetAccounts
    (
        inuPivotAcc     in  ic_cuensald.cusacuco%type,
        inuCurrThread   in  number,
        inuTotThreads   in  number,
        inuLimit        in  number,
        otbAccounts     out nocopy tytbAccounts
    );

    -- Obtiene total de cuentas para el hilo
    FUNCTION fnuAccountsToProcess
    (
        inuThread   in  number,
        inuThreads  in  number
    )
        return number;

    -- Obtiene el total de registros de cartera
    FUNCTION fnuTotalRecords
    (
        idtDate in  ic_cartcoco.caccfege%type
    )
        return number;

    -- Obtiene las cuentas de cobro que tienen saldo actualmente
    PROCEDURE GenAccountsBalSysdate
    (
        idtFecha        in date,
        idtFechaUltSeg  in date
    );

    -- Obtiene el saldo de las cuentas a la fecha a partir de la cartera anterior
    PROCEDURE GenAccountsBalPastPort
    (
        idtPortDate in date,
        idtLastGen  in  date,
        isbPortNat  in  varchar
    );

    PROCEDURE GetDeferredInfo
    (
        inuPivot        in  number,
        inuLimit        in  number,
        inuCurrThread   in  number,
        inuTotThreads   in  number,
        otbDeferred     out nocopy tytbDeferred
    );

    PROCEDURE GetExtraPaymtsByDef
    (
        inuDeferred in  cuotextr.cuexdife%type,
        otbExtraPay out pktblCuotextr.tytbCuotExtr
    );

    FUNCTION fnuDeferredToProcess
    (
        inuThread   in  number,
        inuThreads  in  number
    )
    return number;


    FUNCTION ObtFechaVenc
    (
        inuSesunuse     in servsusc.sesunuse%type
    )
    return date;

END IC_BCGenCartCompConc;
/


CREATE OR REPLACE PACKAGE BODY IC_BCGenCartCompConc IS
/*
    Propiedad intelectual de Open International Systems (c).

    Paquete     :   IC_BCGenCartCompConc
    Descripción :   Componente de negocio de primer nivel para la Generacion
                    de Informacion de cartera.
                    IC_BCGenCartCompConc.pkg

    Autor       :   Adriana Calderón Home
    Fecha       :   21-02-2012

    Historia de Modificaciones
    Fecha        IDEntrega

    01-09-2014  hlopez.SAO267295
    Se adiciona el servicio <ObtFechaVenc> para obtener la fecha de vencimiento
    mas antigua de un producto.

    21-07-204   eurbano.SAO258199
    Se modifica el método <GenAccountsBalPastPort>
                          <GetAccounts>

    12-06-2014  eurbano.SAO245313 se modifican los métodos
    <GenAccountsBalSysdate>
    <GenAccountsBalPastPort>
    <GetCharges>


    23-01-2014  arendon.SAO230582
    Se modifican los métodos <GetDeferredInfo> y <fnuDeferredToProcess>.

    19-01-2014  arendon.SAO230033
    Se cambian las referencias de IC_CUENCOSA por IC_CUENSALD
    Se modifican los métodos:
        - GetDeferredInfo
        - GenAccountsBalSysdate
        - GenAccountsBalPastPort
    Se adiciona el método:
        - GenDeferredInfo
    Se eliminan los métodos:
        - InsTmpDeferred

    12-12-2013  arendon.SAO223290
    Se modifica el método <InsTmpDeferred>
    Se adicionan los métodos
        - GetDeferredInfo
        - GetExtraPaymtsByDef
        - fnuDeferredToProcess

    04-12-2013  arendon.SAO225934
    Se modifica el método <GetAccounts>.

    19-03-2013  arendon.SAO201909
    Se adicionan los métodos:
        - GetAccounts
        - fboExistPymtsAccDate

    12-10-2012  arendon.SAO194009
    Se modifican los siguientes métodos:
        - GetAccountsAppPosBal
        - InsTmpBillCharges
        - InsTmpNotesCharges

    11-10-2012  arendon.SAO193774
    Se modifican los métodos:
        - InsTmpNotesCharges
        - InsTmpBillCharges

    09-10-2012  arendon.SAO193224
    Se modifica el método <InsRecordsPortfolio>

    03-10-2012  arendon.SAO192678
    Se modifican los siguientes métodos:
        - InsPastRecords
    Se adicionan los siguientes métodos:
        - GetBillInfo
        - GetNotesInfo

    21-08-2012  arendon.SAO185247
    Se re-crea el paquete por cambio en la funcionalidad.

    31-05-2012  gduqueSAO180632
    Se modifica el metodo <frGetDeferred>.

    22-05-2012  gduqueSAO180610
    Se modifica el CURSOR <cuCount> para modificar el indice IX_CUCOSACU por
    IX_CUENCOBR12.
    Se modifica el metodo <frGetPortfolioAccounts>.

    21-02-2012  acalderonSAO180618
    Creación.
*/

    -------------------
    -- Constantes
    -------------------
    -- Esta constante se debe modificar cada vez que se entregue el paquete con
    -- un SAO.
    csbVERSION  constant varchar2(250)  := 'SAO267295';

    -------------------
    -- Variables
    -------------------
    -- Mensaje de Error
    sbErrMsg    ge_error_log.description%type;

    -------------------
    -- Métodos
    -------------------
    /***************************************************************************
    Propiedad intelectual de Open International Systems. (c).
    Procedure    :  fsbVersion
    Descripcion    :  Devuelve la versión del paquete

    Autor        :  Adriana Calderón Home
    Fecha        :  21-02-2012

    Historia de Modificaciones
    Fecha        IDEntrega

    21-02-2012      acalderonSAO180618
    Creacion
    ***************************************************************************/
    FUNCTION fsbVersion RETURN varchar2 IS
    BEGIN
        return IC_BCGenCartCompConc.csbVERSION;
    END fsbVersion;


    /*
        Propiedad intelectual de Open Systems (c).
        Function        :   fdtLastDate
        Descripción     :   Obtiene la fecha de la ultima ejecución

        Retorno         :   Fecha de la última ejecución del proceso

        Autor       :   Alejandro Rendón Gómez
        Fecha       :   21-08-2012 09:51:26

        Historia de Modificaciones
        Fecha       IDEntrega

        21-08-2012  arendon.SAO185247
        Creación.
    */
    FUNCTION fdtLastDate
        return date
    IS
        -------------------
        -- Cursores
        -------------------
        CURSOR cuLastDate
        IS
            SELECT  --+ index_desc (ic_cartcoco IX_IC_CARTCOCO03)
                    max(caccfege)
            FROM    ic_cartcoco
                    /*+IC_BCGenCartCompConc.fdtLastDate*/;

        -------------------
        -- Variables
        -------------------
        dtLastDate  date;

    BEGIN
        pkErrors.Push('IC_BCGenCartCompConc.fdtLastDate');

        -- Evalua si el cursor está cerrado
        if ( cuLastDate%isopen ) then
            close cuLastDate;
        end if;

        -- Abre el cursor
        open cuLastDate;

        -- Obtiene los datos
        fetch   cuLastDate
        into    dtLastDate;

        -- Cierra el cursor
        close cuLastDate;

        pkErrors.Pop;

        return dtLastDate;

    EXCEPTION
        when LOGIN_DENIED then
            pkErrors.pop;
            raise LOGIN_DENIED;

        when pkConstante.exERROR_LEVEL2 then
            -- Error Oracle nivel dos
            pkErrors.pop;
            raise pkConstante.exERROR_LEVEL2;

        when OTHERS then
            pkErrors.NotifyError
            (
                pkErrors.fsbLastObject,
                sqlerrm,
                sbErrMsg
            );
            pkErrors.pop;
            raise_application_error
            (
                pkConstante.nuERROR_LEVEL2,
                sbErrMsg
            );
            return null;
    END fdtLastDate;

    /*
        Propiedad intelectual de Open Systems (c).
        Procedure       :   GetCharges
        Descripción     :   Obtiene los cargos a partir de la cuenta de cobro

        Parámetros
        Entrada         :       Descripción
            inuCucocodi             Cuenta de cobro
            idtGenDate              Fecha de creación de los cargos

        Salida          :       Descripción
            otbCharges              Tabla PL con los cargos seleccionados

        Autor       :   Alejandro Rendón Gómez
        Fecha       :   14-04-2013 13:29:28

        Historia de Modificaciones
        Fecha       IDEntrega

        12-06-2014  eurbano.SAO245313
        Se modifica para ordenar los cargos correctamentente incluyendo
        el consecutivo del cargo (cargcodo).

        14-04-2013  arendon.SAO201909
        Creación.
    */
    PROCEDURE GetCharges
    (
        inuCucocodi in  cuencobr.cucocodi%type,
        idtGenDate  in  cargos.cargfecr%type,
        otbCharges  out nocopy pkConceptValuesMgr.tytbCargosDist
    )
    IS
        -------------------
        -- Cursores
        -------------------

        CURSOR cuCharges
        (
            inuCargcuco in  number,
            idtCargfecr in  date
        )
        IS
            SELECT  --+ index_rs_asc (cargos IX_CARG_CUCO_CONC)
                    pkConceptValuesMgr.fsbKey
                    (
                        0, 0, 0, 0,
                        0, cargconc, pefacicl, 0,
                        0, 0, 0, 1, 0
                    ) sbkey,
                    cargsign,
                    cargvalo,
                    cargvabl,
                    'N',
                    cargfecr,
                    cargunid,
                    cargdoso,
                    cargcodo
        	FROM    cargos, perifact
                    /*+ IC_BCGenCartCompConc.GetCharges */
            WHERE   cargvalo > 0
            AND     cargcuco = inuCargcuco
            AND     cargfecr <= idtCargfecr
            AND     cargpefa = pefacodi
            ORDER BY    cargfecr,
                        cargcodo,
                        decode
                        (
                            cargsign,
                            'AS', decode(cargtipr,'A', 2 ,'P', 5),
                            'PA', 3,
                            'SA', 4,
                            1
                        );

    BEGIN
        pkErrors.Push('IC_BCGenCartCompConc.GetCharges');

        -- Evalua si el cursor está cerrado
        if ( cuCharges%isopen ) then
            close cuCharges;
        end if;

        -- Abre el cursor
        open    cuCharges( inuCucocodi, idtGenDate );

        -- Obtiene los datos
        fetch   cuCharges
        bulk    collect
        into    otbCharges;

        -- Cierra el cursor
        close   cuCharges;

        pkErrors.Pop;
    EXCEPTION
        when LOGIN_DENIED then
            pkErrors.pop;
            raise LOGIN_DENIED;

        when pkConstante.exERROR_LEVEL2 then
            -- Error Oracle nivel dos
            pkErrors.pop;
            raise pkConstante.exERROR_LEVEL2;

        when OTHERS then
            pkErrors.NotifyError
            (
                pkErrors.fsbLastObject,
                sqlerrm,
                IC_BCGenCartCompConc.sbErrMsg
            );
            pkErrors.pop;
            raise_application_error
            (
                pkConstante.nuERROR_LEVEL2,
                IC_BCGenCartCompConc.sbErrMsg
            );
    END GetCharges;

    /*
        Propiedad intelectual de Open Systems (c).
        Procedure       :   GetRecords
        Descripción     :   Obtiene un bloque de registros para la fecha

        Parámetros
        Entrada         :       Descripción
            idtDate                 Fecha
            inuLimit                Límite de selección de datos

        Salida          :       Descripción
            otbCacccons             Tabla con los códigos de los registros

        Autor       :   Alejandro Rendón Gómez
        Fecha       :   30-08-2012 15:24:12

        Historia de Modificaciones
        Fecha       IDEntrega

        30-08-2012  arendon.SAO185247
        Creación.
    */
    PROCEDURE GetRecords
    (
        idtDate     in  ic_cartcoco.caccfege%type,
        inuLimit    in  number,
        otbCacccons out nocopy pktblIc_cartcoco.tyCacccons
    )
    IS
        -------------------
        -- Cursores
        -------------------
        CURSOR cuCartcoco
        (
            idtCaccfege in  date
        )
        IS
            SELECT  --+ index (ic_cartcoco, IX_IC_CARTCOCO03)
                    cacccons
            FROM    ic_cartcoco
                    /*+IC_BCGenCartCompConc.GetRecords*/
            WHERE   caccfege = idtCaccfege;

    BEGIN
        pkErrors.Push('IC_BCGenCartCompConc.GetRecords');

        -- Evalua si el cursor está cerrado
        if ( cuCartcoco%isopen ) then
            close cuCartcoco;
        end if;

        -- Abre el cursor
        open cuCartcoco( idtDate );

        -- Obtiene los datos
        fetch   cuCartcoco
        bulk    collect
        into    otbCacccons
        limit   inuLimit;

        -- Cierra el cursor
        close cuCartcoco;

        pkErrors.Pop;
    EXCEPTION
        when LOGIN_DENIED then
            pkErrors.pop;
            raise LOGIN_DENIED;

        when pkConstante.exERROR_LEVEL2 then
            -- Error Oracle nivel dos
            pkErrors.pop;
            raise pkConstante.exERROR_LEVEL2;

        when OTHERS then
            pkErrors.NotifyError
            (
                pkErrors.fsbLastObject,
                sqlerrm,
                IC_BCGenCartCompConc.sbErrMsg
            );
            pkErrors.pop;
            raise_application_error
            (
                pkConstante.nuERROR_LEVEL2,
                IC_BCGenCartCompConc.sbErrMsg
            );
    END GetRecords;

        /*
        Propiedad intelectual de Open Systems (c).
        Procedure       :   GenDeferredInfo
        Descripción     :   Inserta los movimientos de diferidos

        Parámetros
        Entrada         :       Descripción
            idtDateLastSec          Fecha generación al último segundo del día
            isbRecType              Tipo de registro a excluir

        Autor       :   Alejandro Rendón Gómez
        Fecha       :   19-01-2014 19:31:48

        Historia de Modificaciones
        Fecha       IDEntrega

        19-01-2014  arendon.SAO230033
        Creación.
    */
    PROCEDURE GenDeferredInfo
    (
        idtDateLastSec  in  ic_cartcoco.caccfege%type,
        isbRecType      in  diferido.difetire%type
    )
    IS
    BEGIN
        pkErrors.Push('IC_BCGenCartCompConc.GenDeferredInfo');

        INSERT
        INTO    ic_cuensald
        (
                cusacodi, -- código
                cusadife, -- difecodi
                cusasald, -- difesape
                cusacufa  -- difecupa
        )
        SELECT  sq_ic_cuensald_334231.nextval,
                difecodi,
                difesape,
                difecupa
        FROM
        (
            SELECT      difecodi,
                        sum(difesape) difesape,
                        min(difecupa) difecupa
            FROM        (
                            SELECT  --+ index_rs_asc (diferido, IX_DIFERIDO01)
                                    difecodi, difesape, difecupa
                            FROM    diferido
                            WHERE   difesape > 0
                            AND     difetire <> isbRecType
                            AND     difefein <= idtDateLastSec
                            UNION ALL
                            SELECT  /*+
                                        ordered
                                        index_rs_asc (movidife, IX_MOVIDIFE04)
                                        index (diferido, PK_DIFERIDO)
                                    */
                                    difecodi,
                                    decode( modisign, 'CR', modivacu, 'DB', modivacu * -1,0 ) difesape,
                                    (case modicuap when 0 then null else modicuap-1 end) difecupa -- se resta uno para que queda la cuota real.
                            FROM    movidife, diferido
                            WHERE   difecodi = modidife
                            AND     difetire <> isbRecType
                            AND     modifech > idtDateLastSec
                            AND     difefein <= idtDateLastSec
                        ) diferidos
                        /*+IC_BCGenCartCompConc.GenDeferredInfo*/
            GROUP BY    difecodi
        );

        pkErrors.Pop;
    EXCEPTION
        when LOGIN_DENIED then
            pkErrors.pop;
            raise LOGIN_DENIED;

        when pkConstante.exERROR_LEVEL2 then
            -- Error Oracle nivel dos
            pkErrors.pop;
            raise pkConstante.exERROR_LEVEL2;

        when OTHERS then
            pkErrors.NotifyError
            (
                pkErrors.fsbLastObject,
                sqlerrm,
                IC_BCGenCartCompConc.sbErrMsg
            );
            pkErrors.pop;
            raise_application_error
            (
                pkConstante.nuERROR_LEVEL2,
                IC_BCGenCartCompConc.sbErrMsg
            );
    END GenDeferredInfo;

    /*
        Propiedad intelectual de Open Systems (c).
        Procedure       :   GetAccounts
        Descripción     :   Obtiene las cuentas por bloques

        Parámetros
        Entrada         :       Descripción
            inuPivotAcc             Cuenta pivote para la selección
            inuCurrThread           Hilo actual
            inuTotThreads           Total de hilos
            inuLimit                Límite para la obtención de datos

        Salida          :       Descripción
            otbAccounts             Tabla con las cuentas seleccionadas

        Autor       :   Alejandro Rendón Gómez
        Fecha       :   15-03-2013 09:50:27

        Historia de Modificaciones
        Fecha       IDEntrega
        30-07-2014  eurbano.SAO258199
        Se modifica para filtrar las cuentas de cobro verificando
        que el saldo sea distinto de 0.

        19-01-2014  arendon.SAO230033
        Se modifica la referencia de IC_CUENCOSA por IC_CUENSALD.

        04-12-2013  arendon.SAO225934
        Se modifica la consulta para obligar a Oracle a resolver la consulta
        como se indica en los hint y traiga ordenados los registros. Este
        error se presenta desde Oracle 11g para grandes volumenes de datos,
        cuando el motor ejecuta dos hilos paralelos, uno accede a disco y el
        otro a memoria. El acceso a disco no respeta el ordenamiento de los
        indices y por tal razon el acceso a memoria queda no ordenado.

        15-03-2013  arendon.SAO201909
        Creación.
    */
    PROCEDURE GetAccounts
    (
        inuPivotAcc     in  ic_cuensald.cusacuco%type,
        inuCurrThread   in  number,
        inuTotThreads   in  number,
        inuLimit        in  number,
        otbAccounts     out nocopy tytbAccounts
    )
    IS
        -------------------
        -- Cursores
        -------------------
        CURSOR cuAccounts
        (
            inuAccount  number,
            inuThread   number,
            inuThreads  number
        )
        IS
            SELECT  /*+
                        ordered
                        use_nl   (ic_cuensald, cuencobr, factura, servsusc, suscripc, ge_subscriber, ab_address, ge_geogra_location)
                        index_rs_asc (ic_cuensald,   UX_IC_CUENSALD01)
                        index    (cuencobr,      PK_CUENCOBR)
                        index    (factura,       PK_FACTURA)
                        index    (servsusc,      PK_SERVSUSC)
                        index    (suscripc,      PK_SUSCRIPC)
                        index    (ge_subscriber, PK_GE_SUBSCRIBER)
                        index    (ab_address,    PK_AB_ADDRESS)
                        index    (ge_geogra_location, PK_GE_GEOGRA_LOCATION)
                    */
                    suscripc.suscclie,
                    ge_subscriber.subscriber_type_id,
                    ge_subscriber.identification,
                    servsusc.sesususc,
                    servsusc.sesuserv,
                    cuencobr.cuconuse,
                    servsusc.sesuesco,
                    ab_address.geograp_location_id,
                    nvl(ab_address.neighborthood_id,ab_address.geograp_location_id),
                    cuencobr.cucocate,
                    cuencobr.cucosuca,
                    factura.factconf,
                    factura.factpref,
                    factura.factnufi,
                    cuencobr.cucofact,
                    ic_cuensald.cusacuco,
                    cuencobr.cucofeve,
                    ge_geogra_location.geog_loca_area_type
            FROM    ic_cuensald, cuencobr, factura, servsusc, suscripc,
                    ge_subscriber, ab_address, ge_geogra_location
                    /*+ IC_BCGenCartCompConc.GetAccounts */
            WHERE   cusacuco > inuAccount
            AND     cusasald <> 0
            AND     mod(cusacuco, inuThreads) + 1 = inuThread
                    /* Cuencobr */
            AND     cusacuco = cucocodi
                    /* Factura */
            AND     cucofact = factcodi
                    /* Servsusc */
            AND     cuconuse = sesunuse
                    /* Suscripc */
            AND     sesususc = susccodi
                    /* Ge_subscriber */
            AND     suscclie = ge_subscriber.subscriber_id
                    /* Ab_address */
            AND     cucodiin = ab_address.address_id
                    /* Ge_geogra_location:
                        Se adiciona el join para evitar problemas en el
                        ordenamiento necesario para el pivote. SAO225934 */
            AND     ab_address.geograp_location_id = ge_geogra_location.geograp_location_id;

    BEGIN
        pkErrors.Push('IC_BCGenCartCompConc.GetAccounts');

        -- Evalua si el cursor está cerrado
        if ( cuAccounts%isopen ) then
            close cuAccounts;
        end if;

        -- Abre el cursor
        open    cuAccounts
                (
                    inuPivotAcc,
                    inuCurrThread,
                    inuTotThreads
                );

        -- Obtiene los datos
        fetch   cuAccounts
        bulk    collect
        into    otbAccounts
        limit   inuLimit;

        -- Cierra el cursor
        close   cuAccounts;

        pkErrors.Pop;
    EXCEPTION
        when LOGIN_DENIED then
            pkErrors.pop;
            raise LOGIN_DENIED;

        when pkConstante.exERROR_LEVEL2 then
            -- Error Oracle nivel dos
            pkErrors.pop;
            raise pkConstante.exERROR_LEVEL2;

        when OTHERS then
            pkErrors.NotifyError
            (
                pkErrors.fsbLastObject,
                sqlerrm,
                IC_BCGenCartCompConc.sbErrMsg
            );
            pkErrors.pop;
            raise_application_error
            (
                pkConstante.nuERROR_LEVEL2,
                IC_BCGenCartCompConc.sbErrMsg
            );
    END GetAccounts;

    /*
        Propiedad intelectual de Open Systems (c).
        Function        :   fnuAccountsToProcess
        Descripción     :   Conteo de las cuentas de cobro a procesar

        Parámetros      :       Descripción
            inuThread               Hilo actual
            inuThreads              Total de hilos

        Retorno         :
            Número de cuentas de cobro a prcesar por el hilo

        Autor       :   Alejandro Rendón Gómez
        Fecha       :   21-03-2013 11:03:51

        Historia de Modificaciones
        Fecha       IDEntrega

        19-01-2014  arendon.SAO230033
        Se modifica la referencia de IC_CUENCOSA por IC_CUENSALD.

        21-03-2013  arendon.SAO201909
        Creación.
    */
    FUNCTION fnuAccountsToProcess
    (
        inuThread   in  number,
        inuThreads  in  number
    )
        return number
    IS
        -------------------
        -- Cursores
        -------------------
        CURSOR cuCount
        (
            inuCurrTh   in  number,
            inuTotThs   in  number
        )
        IS
            SELECT  /*+
                        ordered
                        use_nl  (ic_cuensald, cuencobr, factura)
                        use_nl  (cuencobr, servsusc, suscripc, ge_subscriber)
                        use_nl  (cuencobr, ab_address)
                        index   (ic_cuensald,   UX_IC_CUENSALD01)
                        index   (cuencobr,      PK_CUENCOBR)
                        index   (factura,       PK_FACTURA)
                        index   (servsusc,      PK_SERVSUSC)
                        index   (suscripc,      PK_SUSCRIPC)
                        index   (ge_subscriber, PK_GE_SUBSCRIBER)
                        index   (ab_address,    PK_AB_ADDRESS)
                    */
                    count(1)
            FROM    ic_cuensald, cuencobr, factura, servsusc, suscripc,
                    ge_subscriber, ab_address
                    /*+ IC_BCGenCartCompConc.fnuAccountsToProcess */
            WHERE   cusasald > 0
            AND     mod(cusacuco, inuTotThs) + 1 = inuCurrTh
            AND     cusacuco = cucocodi
            AND     cucofact = factcodi
            AND     cuconuse = sesunuse
            AND     sesususc = susccodi
            AND     suscclie = ge_subscriber.subscriber_id
            AND     cucodiin = ab_address.address_id;

        -------------------
        -- Variables
        -------------------
        -- Retorno
        nuReturn    number;

    BEGIN
        pkErrors.Push('IC_BCGenCartCompConc.fnuAccountsToProcess');

        -- Evalua si el cursor está cerrado
        if ( cuCount%isopen ) then
            close cuCount;
        end if;

        -- Abre el cursor
        open    cuCount
                (
                    inuThread,
                    inuThreads
                );

        -- Obtiene los datos
        fetch   cuCount
        into    nuReturn;

        -- Cierra el cursor
        close   cuCount;

        pkErrors.Pop;

        return nuReturn;

    EXCEPTION
        when LOGIN_DENIED then
            pkErrors.pop;
            raise LOGIN_DENIED;

        when pkConstante.exERROR_LEVEL2 then
            -- Error Oracle nivel dos
            pkErrors.pop;
            raise pkConstante.exERROR_LEVEL2;

        when OTHERS then
            pkErrors.NotifyError
            (
                pkErrors.fsbLastObject,
                sqlerrm,
                IC_BCGenCartCompConc.sbErrMsg
            );
            pkErrors.pop;
            raise_application_error
            (
                pkConstante.nuERROR_LEVEL2,
                IC_BCGenCartCompConc.sbErrMsg
            );
            return null;
    END fnuAccountsToProcess;

    /*
        Propiedad intelectual de Open Systems (c).
        Function        :   fnuTotalRecords
        Descripción     :   Retorna el total de registros para la fecha

        Parámetros      :       Descripción
            idtDate                 Fecha de cartera

        Retorno         :
            Cantidad de registros en la fecha

        Autor       :   Alejandro Rendón Gómez
        Fecha       :   22-03-2013 19:24:07

        Historia de Modificaciones
        Fecha       IDEntrega

        22-03-2013  arendon.SAO201909
        Creación.
    */
    FUNCTION fnuTotalRecords
    (
        idtDate in  ic_cartcoco.caccfege%type
    )
        return number
    IS
        -------------------
        -- Cursores
        -------------------
        CURSOR cuCount
        (
            idtCaccfege date
        )
        IS
            SELECT  --+ index (ic_cartcoco, IX_IC_CARTCOCO03)
                    count(1)
            FROM    ic_cartcoco
            WHERE   caccfege = idtCaccfege;

        -------------------
        -- Variables
        -------------------
        -- Variable para el retorno
        nuCount number;

    BEGIN
        pkErrors.Push('IC_BCGenCartCompConc.fnuTotalRecords');

        -- Evalua si el cursor está cerrado
        if ( cuCount%isopen ) then
            close cuCount;
        end if;

        -- Abre el cursor
        open    cuCount( idtDate );

        -- Obtiene los datos
        fetch   cuCount
        into    nuCount;

        -- Cierra el cursor
        close   cuCount;

        pkErrors.Pop;

        -- Retorna el total de registros
        return nuCount;

    EXCEPTION
        when LOGIN_DENIED then
            pkErrors.pop;
            raise LOGIN_DENIED;

        when pkConstante.exERROR_LEVEL2 then
            -- Error Oracle nivel dos
            pkErrors.pop;
            raise pkConstante.exERROR_LEVEL2;

        when OTHERS then
            pkErrors.NotifyError
            (
                pkErrors.fsbLastObject,
                sqlerrm,
                IC_BCGenCartCompConc.sbErrMsg
            );
            pkErrors.pop;
            raise_application_error
            (
                pkConstante.nuERROR_LEVEL2,
                IC_BCGenCartCompConc.sbErrMsg
            );
            return null;
    END fnuTotalRecords;

    /***************************************************************************
    Propiedad intelectual de Open International Systems. (c)

    Procedure     : GenAccountsBalSysdate

    Descripcion   : Obtiene las cuentas de cobro que tienen saldo actualmente

    Parametros    : idtFecha - Fecha de Referencia
                    idtFechaUltSeg - Fecha de referencia al ultimo seg. del día.

    Retorno       :

    Autor         : Héctor Andrés Toro Rodríguez
    Fecha         : 19-02-2013

    Historia de Modificaciones
    Fecha          IDEntrega

    12-06-2014  eurbano.SAO245313
    Se modifica para considerar las aplicaciones de saldo a favor provenientes
    de traslados de saldos y Depósitos.

    19-01-2014  arendon.SAO230033
    Se modifica la referencia de IC_CUENCOSA por IC_CUENSALD.

    19-02-2013    htoro.SAO201909
    Creación
*******************************************************************************/
    PROCEDURE GenAccountsBalSysdate
    (
        idtFecha        in date,
        idtFechaUltSeg  in date
    )
    IS
        cuCursor    pkConstante.tyRefCursor;
    BEGIN
        pkErrors.Push('IC_BCGenCartCompConc.GenAccountsBalSysdate');

        INSERT
        INTO    ic_cuensald
        (
            cusacodi,
            cusacuco,
            cusasald
        )
        (
            SELECT  sq_ic_cuensald_334231.nextval,
                    cusacuco,
                    cusasald
            FROM
            (
                SELECT  cusacuco,
                        sum(cusasald) cusasald
                FROM
                (
                    (
                        SELECT  /*+
                                    leading(cuencobr)
                                    use_nl(cuencobr, factura)
                                    index(cuencobr, IX_CUENCOBR12)
                                    index(factura, PK_FACTURA)
                                */
                                cucocodi cusacuco,
                                cucosacu cusasald
                        FROM    cuencobr,
                                factura
                                /*+IC_BCGenCartCompConc.GenAccountsBalSysdate*/
                        WHERE   (CASE  WHEN cucosacu > 0 THEN cucocodi ELSE NULL END ) > 0
                        AND     factcodi = cucofact
                        AND     factfege <= idtFechaUltSeg
                    )
                    UNION ALL
                    (
                        SELECT  cargcuco cusacuco,
                                - 1 * sum(
                                            case cargsign
                                                when 'DB' then cargvalo
                                                when 'AP' then cargvalo
                                                when 'SA' then cargvalo
                                                when 'CR' then -cargvalo
                                                when 'PA' then -cargvalo
                                                when 'AS' then -cargvalo
                                                when 'NS' then -cargvalo
                                                else 0
                                            end
                                         ) cusasald
                        FROM
                        (
                            (
                                SELECT
                                        /*+
                                            leading(notas)
                                            use_nl(notas, cargos)
                                            use_nl(cargos, cuencobr)
                                            use_nl(cuencobr, factura)
                                            index_rs_asc (notas, IX_NOTAS06)
                                            index_rs_asc (cargos, IX_CARG_CODO)
                                            index (cuencobr, PK_CUENCOBR)
                                            index (factura, PK_FACTURA)
                                        */
                                        cargcuco,
                                        cargvalo,
                                        cargsign
                                FROM    notas,
                                        cargos,
                                        cuencobr,
                                        factura
                                        /*+IC_BCGenCartCompConc.GenAccountsBalSysdate*/
                                WHERE   notanume = cargcodo
                                AND     notaprog = cargprog
                                AND     cargcuco = cucocodi
                                AND     cucofact = factcodi
                                AND     factfege <= idtFechaUltSeg
                                AND     notafeco > idtFecha
                            )
                            UNION ALL
                            (
                                SELECT
                                        /*+
                                            ordered
                                            use_nl(pagos, procesos, cargos)
                                            use_nl(cargos, cuencobr, factura)
                                            index_rs_asc (pagos, IX_PAGOS11)
                                            index (procesos, UX_PROCESOS01)
                                            index_rs_asc (cargos, IC_CARG_CODO)
                                            index (cuencobr, PK_CUENCOBR)
                                            index (factura, PK_FACTURA)
                                        */
                                        cargcuco,
                                        cargvalo,
                                        cargsign
                                FROM    pagos,
                                        procesos,
                                        cargos,
                                        cuencobr,
                                        factura
                                        /*+IC_BCGenCartCompConc.GenAccountsBalSysdate*/
                                WHERE   pagocupo = cargcodo
                                AND     pagoprog = proccodi
                                AND     proccons = cargprog
                                AND     cargcuco = cucocodi
                                AND     cucofact = factcodi
                                AND     factfege <= idtFechaUltSeg
                                AND     trunc(pagofegr) > idtFecha
                            )
                            UNION ALL
                            (
                                SELECT
                                        /*+
                                            ordered
                                            use_nl(rc_pagoanul, procesos, cargos)
                                            use_nl(rc_pagoanul, cuencobr, factura)
                                            index_rs_asc (rc_pagoanul, IX_RC_PAGOANUL01)
                                            index (procesos, UX_PROCESOS01)
                                            index_rs_asc (cargos, IC_CARG_CODO)
                                            index (cuencobr, PK_CUENCOBR)
                                            index (factura, PK_FACTURA)
                                        */
                                        cargcuco,
                                        cargvalo,
                                        cargsign
                                FROM    rc_pagoanul,
                                        procesos,
                                        cargos,
                                        cuencobr,
                                        factura
                                        /*+IC_BCGenCartCompConc.GenAccountsBalSysdate*/
                                WHERE   paancupo = cargcodo
                                AND     paanprog = proccodi
                                AND     proccons = cargprog
                                AND     cargcuco = cucocodi
                                AND     cucofact = factcodi
                                AND     factfege <= idtFechaUltSeg
                                AND     paanfech > idtFecha
                            )
                            UNION ALL
                            (
                                SELECT
                                        /*+
                                            leading(movisafa)
                                            use_nl(movisafa, cuencobr)
                                            use_nl(cuencobr, factura)
                                            index (movisafa IX_MOVISAFA10)
                                            index (cuencobr, PK_CUENCOBR)
                                            index (factura, PK_FACTURA)

                                        */
                                         mosfcuco,
                                         abs(mosfvalo),
                                         'AS'
                                FROM     movisafa, cuencobr, factura
                                WHERE    movisafa.mosffech > idtFecha
                                AND      movisafa.mosfdeta = 'AS'
                                AND      movisafa.mosfcuco = cuencobr.cucocodi
                                AND      movisafa.mosfnota IS null
                                AND      cuencobr.cucofact = factura.factcodi
                                AND      factura.factfege  <= idtFechaUltSeg
                            )
                        )
                        GROUP BY cargcuco
                    )
                )
                GROUP BY cusacuco
            )
        );

        pkErrors.Pop;

    EXCEPTION
        when LOGIN_DENIED OR pkConstante.exERROR_LEVEL2 then
            pkErrors.Pop;
            raise;

        when OTHERS then
            pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrMsg);
            pkErrors.Pop;
            raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrMsg);

    END GenAccountsBalSysdate;

    /*
        Propiedad intelectual de Open Systems (c).
        Procedure       :   GenAccountsBalPastPort
        Descripción     :   Crea el saldo de cuentas a partir del estado de la
                            cartera anterior

        Parámetros
        Entrada         :       Descripción
            idtPortDate             Fecha de corte
            idtLastGen              Fecha de ejecución anterior.

        Autor       :   Alejandro Rendón Gómez
        Fecha       :   22-03-2013 11:44:47

        Historia de Modificaciones
        Fecha       IDEntrega

        20-08-2014  mgutierrSAO264593
        Se modifica para que obtenga por separado los cargos de la factura
        dividiéndola en dos sentencias, una para los cargos de facturación
        con CARGTIPR = 'A' y otra para los cargos de Saldos a Favor por
        Facturación con CARGTIPR = 'P', para que en la sentencia general no
        se tengan en cuenta cargos de notas que tengan fecha de creación igual
        a la fecha de generación de la factura.

        21-07-2014 eurbano.SAO258199
        Se modifica para excluir los cargos de aplicación
        de saldo a favor en la consulta de los cargos asociados
        a la factura.

        12-06-2014  eurbano.SAO245313
        Se modifica para tener en cuenta los AS generados por
        Depósitos y traslados de saldos.

        19-01-2014  arendon.SAO230033
        Se modifica la referencia de IC_CUENCOSA por IC_CUENSALD.

        22-03-2013  arendon.SAO201909
        Creación.
    */
    PROCEDURE GenAccountsBalPastPort
    (
        idtPortDate in date,
        idtLastGen  in  date,
        isbPortNat  in  varchar
    )
    IS
        cuCursor    pkConstante.tyRefCursor;
        -- Esta constante es un segundo de tiempo
        cnuSegundo constant NUMBER  := (5/24/60/60);

    BEGIN
        pkErrors.Push('IC_BCGenCartCompConc.GenAccountsBalPastPort');

        INSERT
        INTO    ic_cuensald
        (
            cusacodi,
            cusacuco,
            cusasald
        )
        (
            SELECT  sq_ic_cuensald_334231.nextval,
                    cusacuco,
                    cusasald
            FROM
            (
                SELECT  cusacuco,
                        sum(cusasald) cusasald
                FROM
                (
                    (
                        SELECT  /*+
                                    index_rs_asc (ic_cartcoco, IX_IC_CARTCOCO03)
                                */
                                cacccuco cusacuco,
                                sum(caccsape) cusasald
                        FROM    ic_cartcoco
                                /*+IC_BCGenCartCompConc.GenAccountsBalPastPort*/
                        WHERE   caccfege = idtLastGen
                        AND     caccnaca = isbPortNat
                        GROUP BY cacccuco
                    )
                    UNION ALL
                    (
                        SELECT  cargcuco cusacuco,
                                sum(
                                        case cargsign
                                            when 'DB' then cargvalo
                                            when 'AP' then cargvalo
                                            when 'SA' then cargvalo
                                            when 'CR' then -cargvalo
                                            when 'PA' then -cargvalo
                                            when 'AS' then -cargvalo
                                            when 'NS' then -cargvalo
                                            else 0
                                        end
                                    )cusasald
                        FROM
                        (
                            (
                                SELECT
                                        /*+
                                            leading(notas)
                                            use_nl(notas, cargos)
                                            use_nl(cargos, cuencobr)
                                            index_rs_asc (notas, IX_NOTAS06)
                                            index_rs_asc (cargos, IX_CARG_CODO)
                                            index (cuencobr, PK_CUENCOBR)
                                        */
                                        cargcuco,
                                        cargvalo,
                                        cargsign
                                FROM    notas,
                                        cargos,
                                        cuencobr
                                        /*+IC_BCGenCartCompConc.GenAccountsBalPastPort*/
                                WHERE   notanume = cargcodo
                                AND     notaprog = cargprog
                                AND     cargcuco = cucocodi
                                AND     notafeco > idtLastGen
                                AND     notafeco <= idtPortDate
                            )
                            UNION ALL
                            (
                                SELECT
                                        /*+
                                            ordered
                                            use_nl(pagos, procesos, cargos)
                                            use_nl(cargos, cuencobr)
                                            index_rs_asc (pagos, IX_PAGOS11)
                                            index (procesos, UX_PROCESOS01)
                                            index_rs_asc (cargos, IC_CARG_CODO)
                                            index (cuencobr, PK_CUENCOBR)
                                        */
                                        cargcuco,
                                        cargvalo,
                                        cargsign
                                FROM    pagos,
                                        procesos,
                                        cargos,
                                        cuencobr
                                        /*+IC_BCGenCartCompConc.GenAccountsBalPastPort*/
                                WHERE   pagocupo = cargcodo
                                AND     pagoprog = proccodi
                                AND     proccons = cargprog
                                AND     proccons = cargprog
                                AND     cargcuco = cucocodi
                                AND     trunc(pagofegr) > idtLastGen
                                AND     trunc(pagofegr) <= idtPortDate
                            )
                            UNION ALL
                            (
                                SELECT
                                        /*+
                                            ordered
                                            use_nl(rc_pagoanul, procesos, cargos)
                                            use_nl(cargos, cuencobr)
                                            index_rs_asc (rc_pagoanul, IX_RC_PAGOANUL01)
                                            index (procesos, UX_PROCESOS01)
                                            index_rs_asc (cargos, IC_CARG_CODO)
                                            index (cuencobr, PK_CUENCOBR)
                                        */
                                        cargcuco,
                                        cargvalo,
                                        cargsign
                                FROM    rc_pagoanul,
                                        procesos,
                                        cargos,
                                        cuencobr
                                        /*+IC_BCGenCartCompConc.GenAccountsBalPastPort*/
                                WHERE   paancupo = cargcodo
                                AND     paanprog = proccodi
                                AND     proccons = cargprog
                                AND     proccons = cargprog
                                AND     cargcuco = cucocodi
                                AND     paanfech > idtLastGen
                                AND     paanfech <= idtPortDate
                            )
                            UNION ALL
                            (
                                SELECT
                                        /*+
                                            leading(movisafa)
                                            use_nl(movisafa, cuencobr)
                                            index (movisafa IX_MOVISAFA10)
                                            index (cuencobr, PK_CUENCOBR)

                                        */
                                         mosfcuco,
                                         abs(mosfvalo),
                                         'AS'
                                FROM     movisafa, cuencobr
                                WHERE    movisafa.mosffech > idtLastGen
                                AND      movisafa.mosffech <= idtPortDate
                                AND      movisafa.mosfdeta = 'AS'
                                AND      movisafa.mosfnota IS null
                                AND      movisafa.mosfcuco = cuencobr.cucocodi

                            )
                            UNION ALL
                            (
                                SELECT  /*+
                                            ordered
                                            index_rs_asc (factura, IX_FACTURA14)
                                            index_rs_asc (cuencobr, IDXCUCO_RELA)
                                            index_rs_asc (cargos, IX_CARGOS02)
                                        */
                                        cargcuco,
                                        cargvalo,
                                        cargsign
                                FROM    factura,
                                        cuencobr,
                                        cargos
                                WHERE   trunc(factfege) > idtLastGen
                                AND     trunc(factfege) <= idtPortDate
                                AND     factcodi = cucofact
                                AND     cargcuco = cucocodi
                                AND     factfege >= cargfecr - cnuSegundo
                                AND     (
                                        -- Ingresos de Facturación
                                            (cargtipr in ('A','M') AND
                                             cargsign in ('DB', 'CR'))
                                             OR
                                        -- Cargos SA de Facturación
                                            (cargtipr in ('P')  AND
                                             cargsign in ('SA') AND
                                             cargdoso not like 'PA%' AND
                                             cargprog in (pkBillConst.fnuFAFS, pkBillConst.fnuFGCC, pkBillConst.fnuFGCO)
                                             )
                                        )
                            )
                        )
                        GROUP BY cargcuco
                    )
                )
                GROUP BY cusacuco
            )
        );

        pkErrors.Pop;

    EXCEPTION
        when LOGIN_DENIED then
            pkErrors.pop;
            raise LOGIN_DENIED;

        when pkConstante.exERROR_LEVEL2 then
            -- Error Oracle nivel dos
            pkErrors.pop;
            raise pkConstante.exERROR_LEVEL2;

        when OTHERS then
            pkErrors.NotifyError
            (
                pkErrors.fsbLastObject,
                sqlerrm,
                IC_BCGenCartCompConc.sbErrMsg
            );
            pkErrors.pop;
            raise_application_error
            (
                pkConstante.nuERROR_LEVEL2,
                IC_BCGenCartCompConc.sbErrMsg
            );

    END GenAccountsBalPastPort;

    /*
        Propiedad intelectual de Open Systems (c).
        Procedure       :   GetDeferredInfo
        Descripción     :   Obtiene la información de los diferidos

        Parámetros
        Entrada         :       Descripción
            inuPivot                Diferido pivote
            inuLimit                Tamaño del bloque de selección
            inuCurrThread           Hilo actual
            inuTotThreads           Total de hilos

        Salida          :       Descripción
            otbDeferred             Información de diferidos

        Autor       :   Alejandro Rendón Gómez
        Fecha       :   12-12-2013 15:18:34

        Historia de Modificaciones
        Fecha       IDEntrega

        28-07-2014  mgutierrSAO258603
        Se adiciona la columna de tasa de interes del diferido

        23-01-2014  arendon.SAO230582
        Se modifica la consulta para obligar a Oracle a resolver la consulta
        como se indica en los hint y traiga ordenados los registros. Este
        error se presenta desde Oracle 11g para grandes volumenes de datos,
        cuando el motor ejecuta dos hilos paralelos, uno accede a disco y el
        otro a memoria. El acceso a disco no respeta el ordenamiento de los
        indices y por tal razon el acceso a memoria queda no ordenado.

        19-01-2014  arendon.SAO230033
        Se modifica para:
            - Adicionar como parámetros de entrada el hilo y total de hilos
            - Se obtiene la información de IC_CUENSALD.

        12-12-2013  arendon.SAO223290
        Creación.
    */
    PROCEDURE GetDeferredInfo
    (
        inuPivot        in  number,
        inuLimit        in  number,
        inuCurrThread   in  number,
        inuTotThreads   in  number,
        otbDeferred     out nocopy tytbDeferred
    )
    IS
        --------------------
        -- Cursores
        --------------------
        CURSOR  cuDeferred
        (
            inuDifecodi number,
            inuThread   number,
            inuThreads  number
        )
        IS
            SELECT  /*+
                        ordered
                        use_nl( ic_cuensald, diferido, servsusc, suscripc, ge_subscriber, pr_product, ab_address, ge_geogra_location)
                        index_rs_asc (ic_cuensald, UX_IC_CUENSALD02)
                        index   (diferido, PK_DIFERIDO)
                        index   (servsusc, PK_SERVSUSC)
                        index   (suscripc, PK_SUSCRIPC)
                        index   (ge_subscriber, PK_GE_SUBSCRIBER)
                        index   (pr_product, PK_PR_PRODUCT)
                        index   (ab_address, PK_AB_ADDRESS)
                        index   (ge_geogra_location, PK_GE_GEOGRA_LOCATION)
                    */
                    cusadife difecodi,
                    cusasald difesape,
                    cusacufa difecupa,
                    difeconc,
                    difenuse,
                    difefein,
                    difeinte,
                    difespre,
                    difetain,
                    difemeca,
                    difevacu,
                    difesign,
                    difevatd,
                    difefagr,
                    difenucu,
                    sesucate,
                    susccicl,
                    suscclie,
                    sesuesco,
                    sesuserv,
                    sesusuca,
                    sesususc,
                    identification,
                    subscriber_type_id,
                    ab_address.geograp_location_id,
                    ab_address.neighborthood_id,
                    ge_geogra_location.geog_loca_area_type
            FROM    ic_cuensald, diferido, servsusc, suscripc, ge_subscriber,
                    pr_product, ab_address, ge_geogra_location
                    /*+ IC_BCGenCartCompConc.GetDeferredInfo */
            WHERE   cusadife > inuDifecodi -- pivote
            AND     mod( cusadife, inuThreads) + 1 = inuThread
            AND     cusasald > 0
                    /* Diferido */
            AND     cusadife = difecodi
                    /* Servsusc */
            AND     difenuse = sesunuse
                    /* Suscripc */
            AND     sesususc = susccodi
                    /* pr_product */
            AND     sesunuse = pr_product.product_id
                    /* ab_address */
            AND     pr_product.address_id = ab_address.address_id
                    /* ge_subscriber */
            AND     suscclie = ge_subscriber.subscriber_id
                    /* Ge_geogra_location:
                        Se adiciona el join para evitar problemas en el
                        ordenamiento necesario para el pivote. SAO230582 */
            AND     ab_address.geograp_location_id = ge_geogra_location.geograp_location_id;

    BEGIN
        pkErrors.Push('IC_BCGenCartCompConc.GetDeferredInfo');

        /* Evalua si el cursor está abierto y lo cierra */
        if ( cuDeferred%isopen ) then
            close cuDeferred;
        end if;

        /* Abre el cursor */
        open    cuDeferred
                (
                    inuPivot,
                    inuCurrThread,
                    inuTotThreads
                );

        /* Obtiene los datos */
        fetch   cuDeferred
        bulk    collect
        into    otbDeferred
        limit   inuLimit;

        /* Cierra el cursor */
        close   cuDeferred;

        pkErrors.Pop;
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.SetError;
            raise ex.CONTROLLED_ERROR;
    END GetDeferredInfo;

    /*
        Propiedad intelectual de Open Systems (c).
        Procedure       :   GetExtraPaymtsByDef
        Descripcion     :   Obtiene las cuotas extras dado un diferido

        Parametros
        Entrada         :       Descripcion
            inuDeferred             Código del diferido

        Salida          :       Descripcion
            otbExtraPay             Tabla PL con la información de las cuotas
                                    extras.

        Autor    :  Alejandro Rendón Gómez
        Fecha    :  12-12-2013 17:30:35

        Historia de Modificaciones
        Fecha       IDEntrega

        12-12-2013  arendon.SAO223290
        Creación.
    */
    PROCEDURE GetExtraPaymtsByDef
    (
        inuDeferred in  cuotextr.cuexdife%type,
        otbExtraPay out pktblCuotextr.tytbCuotExtr
    )
    IS
        -------------------
        -- VARIABLES
        -------------------
        -- Cursor
        cuCuotasExtras  constants.tyRefCursor;

        -- Consulta cuotas extras
        sbStatCuotasExtras  varchar2(2000) :=
            'SELECT  /*+'                                     || chr(10) ||
                        'index (cuotextr PK_CUOTEXTR)'        || chr(10) ||
                    '*/'                                      || chr(10) ||
                    '*'                                       || chr(10) ||
            'FROM    cuotextr'                                || chr(10) ||
            '/*+ IC_BCPortfolioSummary.GetExtraPaymtsByDef */'|| chr(10) ||
            'WHERE   cuexdife = :inuDiferido';

     BEGIN
        pkErrors.Push('IC_BCGenCartCompConc.GetExtraPaymtsByDef');

        -- Evalua si el cursor está cerrado
        if ( cuCuotasExtras%isopen ) then
            close cuCuotasExtras;
        end if;

        -- Abre el cursor
        open    cuCuotasExtras
        for     sbStatCuotasExtras
        using   inuDeferred;

        -- Obtiene los datos
        fetch   cuCuotasExtras
        bulk collect into otbExtraPay;

        -- Cierra el cursor
        close cuCuotasExtras;

        pkErrors.Pop;
     EXCEPTION
         when ex.CONTROLLED_ERROR then
             raise ex.CONTROLLED_ERROR;
         when others then
             Errors.SetError;
             raise ex.CONTROLLED_ERROR;
     END GetExtraPaymtsByDef;

     /*
        Propiedad intelectual de Open Systems (c).
        Function        :   fnuDeferredToProcess
        Descripción     :   Cuenta el total de registro de diferidos

        Retorno         :   El total de registros

        Autor       :   Alejandro Rendón Gómez
        Fecha       :   13-12-2013 10:26:24

        Historia de Modificaciones
        Fecha       IDEntrega

        23-01-2014  arendon.SAO230582
        Se modifica la consulta para obligar a Oracle a resolver la consulta
        como se indica en los hint y traiga ordenados los registros. Este
        error se presenta desde Oracle 11g para grandes volumenes de datos,
        cuando el motor ejecuta dos hilos paralelos, uno accede a disco y el
        otro a memoria. El acceso a disco no respeta el ordenamiento de los
        indices y por tal razon el acceso a memoria queda no ordenado.

        19-01-2014  arendon.SAO230033
        Se modifica la referencia de TMP_CARGPROC por IC_CUENSALD.

        13-12-2013  arendon.SAO223290
        Creación.
    */
     FUNCTION fnuDeferredToProcess
     (
        inuThread   in  number,
        inuThreads  in  number
    )
        return number
    IS
        --------------------
        -- Cursores
        --------------------
        CURSOR cuCount
        (
            inuThread   number,
            inuThreads  number
        )
        IS
            SELECT  /*+
                        ordered
                        use_nl( ic_cuensald, diferido, servsusc, suscripc, ge_subscriber, pr_product, ab_address, ge_geogra_location)
                        index_rs_asc (ic_cuensald, UX_IC_CUENSALD02)
                        index   (diferido, PK_DIFERIDO)
                        index   (servsusc, PK_SERVSUSC)
                        index   (suscripc, PK_SUSCRIPC)
                        index   (ge_subscriber, PK_GE_SUBSCRIBER)
                        index   (pr_product, PK_PR_PRODUCT)
                        index   (ab_address, PK_AB_ADDRESS)
                        index   (ge_geogra_location, PK_GE_GEOGRA_LOCATION)
                    */
                    count(1)
            FROM    ic_cuensald, diferido, servsusc, suscripc, ge_subscriber,
                    pr_product, ab_address, ge_geogra_location
                    /*+ IC_BCGenCartCompConc.GetDeferredInfo */
            WHERE   mod( cusadife, inuThreads) + 1 = inuThread
            AND     cusasald > 0
                    /* Diferido */
            AND     cusadife = difecodi
                    /* Servsusc */
            AND     difenuse = sesunuse
                    /* Suscripc */
            AND     sesususc = susccodi
                    /* pr_product */
            AND     sesunuse = pr_product.product_id
                    /* ab_address */
            AND     pr_product.address_id = ab_address.address_id
                    /* ge_subscriber */
            AND     suscclie = ge_subscriber.subscriber_id
                    /* Ge_geogra_location:
                        Se adiciona el join para evitar problemas en el
                        ordenamiento necesario para el pivote. SAO230582 */
            AND     ab_address.geograp_location_id = ge_geogra_location.geograp_location_id;

        --------------------
        -- Variables
        --------------------
        /* Total de registros */
        nuCount     number;

    BEGIN
        pkErrors.Push('IC_BCGenCartCompConc.fnuDeferredToProcess');

        /* Evalua si el cursor está abierto y lo cierra */
        if ( cuCount%isopen ) then
            close cuCount;
        end if;

        /* Abre el cursor */
        open    cuCount
                (
                    inuThread,
                    inuThreads
                );

        /* Obtiene los datos */
        fetch   cuCount
        into    nuCount;

        /* Cierra el cursor */
        close   cuCount;

        pkErrors.Pop;

        return nuCount;
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.SetError;
            raise ex.CONTROLLED_ERROR;
    END ;


    /*
        Propiedad intelectual de Open International Systems (c).

        Procedimiento : ObtFechaVenc
        Descripción   : Obtiene la fecha de vencimiento mas antigua

        Parámetros    :
              inuProducto  Producto

        Autor	    :   Hery J Lopez R
        Fecha	    :   01-09-2014

        Historia de Modificaciones
        Fecha	    IDEntrega

        01-09-2014  hlopez.SAO267295
        Creación.
    */
    FUNCTION ObtFechaVenc
    (
        inuSesunuse     in servsusc.sesunuse%type
    )
    return date
    IS

        dtFechaVenc ic_cartcoco.caccfeve%type;

        -- CURSOR para obtener la fecha mas antigua de deuda
        CURSOR  cuFecha
                (
                    inuSesunuse in servsusc.sesunuse%type
                )
        IS
            SELECT  /*+
                        ordered
                        index(cuencobr, IX_CUENCOBR09)
                        index(ic_cuensald, UX_IC_CUENSALD01)
                    */
                    min(cucofeve)
            FROM    cuencobr, ic_cuensald
                    /*+ IC_BCGenCartCompConc.ObtFechaVenc */
                    -- cuencobr
            WHERE   cuconuse = inuSesunuse
                    -- ic_cuensald
            AND     cusacuco = cucocodi;
     BEGIN
        pkErrors.Push('IC_BCGenCartCompConc.ObtFechaVenc');

        -- valida cursor
        if ( cuFecha%isopen)  then
             close cuFecha;
        end if;

        -- procesa cursor
        open    cuFecha
                (
                    inuSesunuse
                );
        fetch   cuFecha  INTO  dtFechaVenc;
        close   cuFecha;

        pkErrors.Pop;

        return dtFechaVenc;

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            if( cuFecha%isopen ) then
                close cuFecha;
            end if;
            raise ex.CONTROLLED_ERROR;
        when others then
            if( cuFecha%isopen ) then
                close cuFecha;
            end if;
            Errors.SetError;
            raise ex.CONTROLLED_ERROR;
    END ObtFechaVenc;

END IC_BCGenCartCompConc;
/
