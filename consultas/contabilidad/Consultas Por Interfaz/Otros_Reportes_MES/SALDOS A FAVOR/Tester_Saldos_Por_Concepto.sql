declare
    ircAccountInfo  IC_BCGenCartCompConc.tyrcAccounts;

    dtGenDateLastSecond date := to_date('08/07/2014 23:59:59','dd/mm/yyyy hh24:mi:ss');
    nuCuenta        number := 1030865732;  -- SELECT * FROM cargos WHERE cargcuco = 1030865732
    nuProducto      number := 549205; -- Nummero del producto.

    sbErrMsg        varchar2(1000);

    -- Índice de la tabla de distribución
    sbIdx   Varchar2(100);
    -------------------
    -- Variables
    -------------------
    -- Tipo de comprobante
    nuNuautico  numeauto.nuautico%type;

    -- Ubicaciones geográficas
    nuUbGeo1    ge_geogra_location.geograp_location_id%type;
    nuUbGeo2    ge_geogra_location.geograp_location_id%type;
    nuUbGeo3    ge_geogra_location.geograp_location_id%type;
    nuUbGeo4    ge_geogra_location.geograp_location_id%type;
    nuUbGeo5    ge_geogra_location.geograp_location_id%type;

    -- Tabla para manejar los cargos de la cuenta
    tbCharges   pkConceptValuesMgr.tytbCargosDist;

    -- Indice para recorrer la tabla
    nuIdx       number;

    -- Registro para el almacenamiento de la cartera
    rcPortfolio ic_cartcoco%rowtype;

    -- Tabla para la distribución de cargos
    tbChargesToDist pkConceptValuesMgr.tytbCargosDist;

    -- Llaves de organización de la tabla de distribución
    tbKeys          pkConceptValuesMgr.tyString;
    -- Tabla con los valores distribuidos
    tbValo          pkConceptValuesMgr.tyNumber;
    -- Tabla con los valores base distribuidos
    tbVabl          pkConceptValuesMgr.tyNumber;


    CURSOR cuAccount
        (
            inuAccount  number
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
                    cuencobr.cucocodi,
                    cuencobr.cucofeve,
                    ge_geogra_location.geog_loca_area_type
            FROM    cuencobr, factura, servsusc, suscripc,
                    ge_subscriber, ab_address, ge_geogra_location
                    /*+ IC_BCGenCartCompConc.GetAccounts */
            WHERE
                    /* Factura */
                     cucofact = factcodi
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
            AND     ab_address.geograp_location_id = ge_geogra_location.geograp_location_id
            AND     cucocodi =  inuAccount;


    PROCEDURE FillTableToDist
        (
            ircCharges      in  pkConceptValuesMgr.tyrcCargosDist,
            iotbChgsToDist  in  out nocopy pkConceptValuesMgr.tytbCargosDist
        )
        IS
            -- Índice para pobla la tabla
            nuIdx       number;

        BEGIN
            pkErrors.Push('IC_BOGenCartCompConc.Process.FillTableToDist');

            -- Obtiene la siguiente posición en la tabla
            nuIdx := nvl(iotbChgsToDist.last, 0) + 1;

            -- Traslada los datos
            iotbChgsToDist(nuIdx).cargterm := ircCharges.cargterm;
            iotbChgsToDist(nuIdx).cargsign := ircCharges.cargsign;
            iotbChgsToDist(nuIdx).cargvalo := ircCharges.cargvalo;
            iotbChgsToDist(nuIdx).cargvabl := ircCharges.cargvabl;
            iotbChgsToDist(nuIdx).cargfecr := ircCharges.cargfecr;
            iotbChgsToDist(nuIdx).cargunid := ircCharges.cargunid;
            iotbChgsToDist(nuIdx).cargdoso := ircCharges.cargdoso;
            iotbChgsToDist(nuIdx).cargcodo := ircCharges.cargcodo;

            -- Evalua si el cargo se debe distribuir:
            --  Signo: 'AS' (aplicación de saldo a favor) o 'SA' (Saldo a favor)
            --  Fecha de creación: menor o igual al día procesado
            if
            (
                (
                    ircCharges.cargsign = pkBillConst.APLSALDFAV
                    OR
                    ircCharges.cargsign = pkBillConst.SALDOFAVOR
                    OR
                    ircCharges.cargsign = pkBillConst.PAGO
                )
                AND
                ircCharges.cargfecr <= dtGenDateLastSecond
            ) then
                -- Actualiza el indicador de distribución a SI
                iotbChgsToDist(nuIdx).cargflfa := pkConstante.SI;
            else
                -- Actualiza el indicador de distribución a NO
                iotbChgsToDist(nuIdx).cargflfa := pkConstante.NO;
            end if;

            dbms_output.put_Line(iotbChgsToDist(nuIdx).cargterm||'|'||iotbChgsToDist(nuIdx).cargsign||'|'||iotbChgsToDist(nuIdx).cargflfa );

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
                    sbErrMsg
                );
                pkErrors.pop;
                raise_application_error
                (
                    pkConstante.nuERROR_LEVEL2,
                    sbErrMsg
                );
    END FillTableToDist;



BEGIN
    pkErrors.Push('IC_BOGenCartCompConc.Process.ProcessAccount');

    -- Abre el cursor
    open    cuAccount
            (
             nuCuenta
            );

    -- Obtiene los datos
    fetch   cuAccount
    into    ircAccountInfo;

    -- Cierra el cursor
    close   cuAccount;

    /*
    -- Obtiene el tipo de comprobante
    GetVoucherType
    (
        ircAccountInfo.factconf,
        nuNuautico
    );

    -- Obtiene las ubicaciones geográficas
    GetGeograpLocs
    (
        ircAccountInfo.caccubg1,
        ircAccountInfo.caccubg2,
        nuUbGeo1,
        nuUbGeo2,
        nuUbGeo3,
        nuUbGeo4,
        nuUbGeo5
    );
    */
    /*
    -----------------------------------------------------
    -- Inicializa el registro con los datos de la cuenta
    -----------------------------------------------------
    -- Naturaleza Cartera (F - Financiada, N - No Financiada)
  rcPortfolio.caccnaca := IC_BOGenCartCompConc.csbNOT_DEF_PORTFOLIO;
  -- Tipo de Cliente
  rcPortfolio.caccticl := ircAccountInfo.caccticl;
  -- Identificación de Cliente
  rcPortfolio.caccidcl := ircAccountInfo.caccidcl;
  -- Cliente
  rcPortfolio.caccclie := ircAccountInfo.caccclie;
  -- Contrato
  rcPortfolio.caccsusc := ircAccountInfo.caccsusc;
  -- Tipo de Producto
  rcPortfolio.caccserv := ircAccountInfo.caccserv;
  -- Producto
  rcPortfolio.caccnuse := ircAccountInfo.caccnuse;
  -- Estado Corte
  rcPortfolio.caccesco := ircAccountInfo.caccesco;
  -- Ubicación Geográfica 1
  rcPortfolio.caccubg1 := nuUbGeo1;
  -- Ubicación Geográfica 2
  rcPortfolio.caccubg2 := nuUbGeo2;
  -- Ubicación Geográfica 3
  rcPortfolio.caccubg3 := nuUbGeo3;
  -- Ubicación Geográfica 4
  rcPortfolio.caccubg4 := nuUbGeo4;
  -- Ubicación Geográfica 5
  rcPortfolio.caccubg5 := nuUbGeo5;
  -- Categoría
  rcPortfolio.cacccate := ircAccountInfo.cacccate;
  -- Subcategoria
  rcPortfolio.caccsuca := ircAccountInfo.caccsuca;
  -- Tipo de Comprobante
  rcPortfolio.cacctico := nuNuautico;
  -- Serie del Comprobante
  rcPortfolio.caccpref := ircAccountInfo.caccpref;
  -- Número Fiscal
  rcPortfolio.caccnufi := ircAccountInfo.caccnufi;
  -- Comprobante
  rcPortfolio.cacccomp := ircAccountInfo.cacccomp;
  -- Cuenta de Cobro
  rcPortfolio.cacccuco := ircAccountInfo.cacccuco;
  -- Fecha de Vencimiento
  rcPortfolio.caccfeve := ircAccountInfo.caccfeve;
  -- Fecha de Generación
  rcPortfolio.caccfege := idtGenDate;
    */
    pkErrors.Push('IC_BCGenCartCompConc.GetCharges');

    -- Obtiene los cargos de la cuenta
    IC_BCGenCartCompConc.GetCharges
    (
        ircAccountInfo.cacccuco,
        dtGenDateLastSecond,
        tbCharges
    );

    nuIdx := tbCharges.first;

    pkErrors.Push('IC_BCGenCartCompConc.FillTableToDist');
    -- Solo si hay cargos para procesar
    if ( nuIdx IS not null ) then

        -- Recorre cada bloque de cargos, organizandolos en la tabla
        -- de distribución
        loop
            exit when nuIdx IS null;

            -- Inserta en la tabla de distribución

            FillTableToDist
            (
                tbCharges( nuIdx ),
                tbChargesToDist
            );

            -- Actualiza el índice con la siguiente posición
            nuIdx := tbCharges.next( nuIdx );

        end loop;

        /*
        for pos in tbChargesToDist.first..tbChargesToDist.last loop
            dbms_output.put_Line(tbChargesToDist(pos).cargcodo||'-'||tbChargesToDist(pos).cargsign||'-'||tbChargesToDist(pos).cargvalo||'-'||tbChargesToDist(pos).cargfecr);
        END loop;
        */
        pkErrors.Push('pkConceptValuesMgr.GetBalanceByConc');
        -- Distribuye los cargos
        pkConceptValuesMgr.GetBalanceByConc
        (
            nuProducto, --rcPortfolio.caccnuse,
            tbChargesToDist,
            tbKeys,
            tbValo,
            tbVabl,
            1,
            0,
            FALSE
        );

        pkErrors.Push('pkConceptValuesMgr.GetBalanceByConc FIN');

        -- Obtiene la primera posición de la tabla de llaves
        sbIdx := tbKeys.first;

         dbms_output.put_Line('......Saldos por Concepto......');

        loop
            -- Condición de salida
            exit when sbIdx IS null;


            dbms_output.put_Line(sbIdx||'|'||tbValo(sbIdx));

            -- Actualiza el índice con la siguiente posición de la tabla
            sbIdx := tbKeys.next( sbIdx );

        END loop;

        --dbms_output.put_Line('Valor ----> '||tbValo);

        /*
        -- Inserta en tabla en memoria
        MassiveInsertion
        (
            rcPortfolio,
            tbKeys,
            tbValo,
            tbVabl
        );
        */
    end if;

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
            sbErrMsg
        );
        pkErrors.pop;
        raise_application_error
        (
            pkConstante.nuERROR_LEVEL2,
            sbErrMsg
        );
END;
