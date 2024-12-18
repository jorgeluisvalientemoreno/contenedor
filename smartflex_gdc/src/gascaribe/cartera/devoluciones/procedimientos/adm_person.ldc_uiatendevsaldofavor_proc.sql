create or replace PROCEDURE adm_person.ldc_uiatendevsaldofavor_proc IS
/*****************************************************************
Propiedad intelectual de Gases del Caribe.

Nombre del Paquete: LDC_UIATENDEVSALDOFAVOR_PROC
Descripción: Procedimiento usado por el proceso PB FADS para validar que la generacion de cargos por
devolucion de depósito se realice correctamente

Autor  : Ludycom/MLopez
Fecha  : 12-07-2017

Historia de Modificaciones

DD-MM-YYYY      <Autor>.                Modificación
-----------     -------------------     -------------------------------------
14/09/2023      jcatuchemvm             OSF-1590: Se corrige  una de las condiciones de salida del
                                        cursor cuProductSaFa que habia quedado desactualizada. Ref OSF-1442
30/08/2023      jcatuchemvm             OSF-1442: Se ajusta procedimiento para que valide
                                        si existe saldo en deposito para la solicitud evitando que se quede en el
                                        loop infinito tratando de crear notas
                                        Se ajusta llamados pkerrors por pkg_error
                                        Se hace cambio del api de regsitro de notas y de detalle PKBILLINGNOTEMGR.CREATEBILLINGNOTE y fa_bobillingnotes.detailregister
                                        por el personalizado api_registranotaydetalle
12/07/2017      MLopez                  Creación
19-04-2024		Adrianavg		        OSF-2569: Se migra del esquema OPEN al esquema ADM_PERSON
******************************************************************/

    SBIDSOLICITUD           GE_BOINSTANCECONTROL.STYSBVALUE;
    NUIDSOLICITUD           MO_PACKAGES.PACKAGE_ID%TYPE;
    NUNOTANUME              NOTAS.NOTANUME%TYPE;

    NUERRORCODE Number;
    SBMENSAJEERROR varchar2(400);

    nuContrato number;
    nuSaldFavor_Ini  number;
    nuSaldFavor_Fin  number;
    NUULTCUENTAPROD number;
    NUPRODUCTTYPE number;
    NUCHARGECAUSE number;
    NUIDSAFA number;

    nuProducto number;
    ValorSAFAPro number;
    ValorDev number;
    ValorPend number;



    cursor cuSaldfavor(nuSusc number) is
       select s.suscsafa
       from suscripc s
       where s.susccodi = nuSusc;

    cursor cuProductSaFa(nuSusc number) is
       select p.sesunuse, p.sesusafa
       from servsusc p
       where p.sesususc = nuSusc;

    cursor cuSafaId(ValorCargo number, nuProduct number) is
       select g.safacons
       from saldfavo  g
       where g.safaorig = 'DE'
         AND G.SAFASESU = nuProduct
         AND nvl((SELECT SUM(H.MOSFVALO)
                                FROM MOVISAFA H
                                WHERE H.MOSFSESU = G.SAFASESU
                                  AND H.MOSFSAFA = G.SAFACONS),0) >= ValorCargo;

    cursor  cuSaldosDev(inuSol number) IS
    select desfidso,desffopd,desfmods,desfmoda,subscription_id,suscsafa,
    (
        select sum(mosfvalo)
        from servsusc, saldfavo, movisafa
        where sesususc = susccodi
        and safasesu = sesunuse
        and safaorig = pkbillconst.DEPOSITO
        and mosfsafa = safacons
        and mosfsesu = safasesu
    ) safadev
    from rc_devosafa,mo_motive,suscripc
    where desfidso = inuSol
    and package_id = desfidso
    and susccodi = subscription_id
    and exists
    (
        select  'x' from mo_packages
        where package_id = desfidso
        and package_type_id = PS_BOPACKAGETYPE.FNUGETPACKTYPEBYTAGNAME('P_DEVOLUCION_DE_DEPOSITO_14')
    );

    rcSaldosDev     cusaldosDev%rowtype;

    rcNota          pkg_bcnotasrecord.tyrcNota;
    tbCargos        pkg_bcnotasrecord.tytbCargos;
    nuerror         number;
    sberror         varchar2(4000);

BEGIN
    UT_TRACE.TRACE( 'Inicio: LDC_UIATENDEVSALDOFAVOR_PROC', 3 );

    Pkg_Error.initialize;

        --Obtenemos la solicitud de la instancia
    SBIDSOLICITUD := GE_BOINSTANCECONTROL.FSBGETFIELDVALUE( 'MO_PACKAGES', 'PACKAGE_ID' );
    NUIDSOLICITUD := TO_NUMBER( SBIDSOLICITUD );
    UT_TRACE.TRACE( 'Solicitud: ' || NUIDSOLICITUD   , 3 );

    --Validación de saldo Deposito pendiente para la solicitud
    if cuSaldosDev%isopen then
        close cuSaldosDev;
    end if;

    rcSaldosDev := null;
    open cuSaldosDev(NUIDSOLICITUD);
    fetch cuSaldosDev into rcSaldosDev;
    close cuSaldosDev;

    if nvl(rcSaldosDev.safadev,0) = 0 or nvl(rcSaldosDev.suscsafa,0) = 0 then
        Pkg_Error.setErrorMessage(isbMsgErrr => 'La solicitud '||NUIDSOLICITUD||' no cuenta con saldo de depósito pendiente para la devolución');
    end if;

    --consultamos el contrato asociado a la solicitud
    nuContrato := rcSaldosDev.subscription_id;

    UT_TRACE.TRACE( 'Contrato: ' || nuContrato   , 3 );

    if cuSaldfavor%isopen then
        close cuSaldfavor;
    end if;

    --consultamos el saldo a favor de la subscripción antes del llamado del proceso original
    nuSaldFavor_Ini := rcSaldosDev.suscsafa;

    UT_TRACE.TRACE( 'Saldo a favor Inicial: ' || nuSaldFavor_Ini   , 3 );

    UT_TRACE.TRACE( 'Se llama procedimiento de devolucion desde LDC_UIATENDEVSALDOFAVOR_PROC' , 3 );

    --realizamos el llamado al procedimiento del sistema que realiza la devolucion de saldo a favor por depósito.
    RC_UIATENDEVSALDOFAVOR.PROCESAR;

    UT_TRACE.TRACE( 'Finaliza procedimiento de devolucion y regresa a LDC_UIATENDEVSALDOFAVOR_PROC' , 3 );


    --obtenemos las variables de error para verificar que no se haya presentado ningun inconveniente
    Pkg_Error.getError( NUERRORCODE, SBMENSAJEERROR );

    UT_TRACE.TRACE( 'Valida el codigo de erro obtenido' , 3 );
    UT_TRACE.TRACE( 'NUERRORCODE: ' || NUERRORCODE   , 3 );
    UT_TRACE.TRACE( 'SBMENSAJEERROR: ' || SBMENSAJEERROR   , 3 );
    /*si el codigo de error es diferente a 0 es porque se produjo algun error durante el proceso, en este caso no es necesario
    validar si se realizó bien la devolucion*/
    if NUERRORCODE <> constants_per.OK then

       --consultamos el saldo a favor despues del proceso de devolucion de depósito
       open cuSaldfavor(nuContrato);
       fetch cuSaldfavor into nuSaldFavor_Fin;
       close cuSaldfavor;

       UT_TRACE.TRACE( 'Saldo a favor final: ' || nuSaldFavor_Fin   , 3 );
        --si el saldo a favor antes del proceso de devolucion es igual al que se registra despues del proceso, entonces se forza la creacion de cargos
        if nuSaldFavor_Ini = nuSaldFavor_Fin then

            --Consultamos el valor a devolver, registrado en la solicitud.
            ValorPend := rcSaldosDev.desfmoda;
            UT_TRACE.TRACE( 'Saldo autorizado para devolver: ' || ValorPend   , 3 );

            --revisamos los saldos a favor de los productos.
            if cuProductSaFa%isopen then
                close cuProductSaFa;
            end if;

            open cuProductSaFa(nuContrato);
            loop

                fetch cuProductSaFa into nuProducto, ValorSAFAPro;
                exit when cuProductSaFa%notfound or ValorPend = 0;

                UT_TRACE.TRACE( 'Producto: ' || nuProducto || ', Saldo producto: ' || ValorSAFAPro  , 3 );

                NUPRODUCTTYPE := PKTBLSERVSUSC.FNUGETSERVICE(nuProducto);
                NUCHARGECAUSE := FA_BOCHARGECAUSES.FNUDEVOLUTIONCHCAUSE(NUPRODUCTTYPE);
                if ValorSAFAPro >= ValorPend then
                    ValorDev := ValorPend;
                    ValorPend := 0;
                else
                    ValorDev := ValorSAFAPro;
                    ValorPend := ValorPend - ValorSAFAPro;
                end if;

                --consultamos la ultima cuenta de cobro del producto
                NUULTCUENTAPROD := PKACCOUNTMGR.FNUGETLASTACCOUNTSERV( nuProducto );
                if NUULTCUENTAPROD is null then
                    NUULTCUENTAPROD := -1;
                end if;

                UT_TRACE.TRACE( 'Se creará nota'  , 3 );
                UT_TRACE.TRACE( 'Cuenta: ' || NUULTCUENTAPROD   , 3 );
                UT_TRACE.TRACE( 'Saldo autorizado para devolver: ' || ValorPend   , 3 );

                rcNota.sbPrograma   := 'FADS';
                rcNota.nuProducto   := nuProducto;
                rcNota.nuCuencobr   := NUULTCUENTAPROD;
                rcNota.nuNotacons   := NULL;
                rcNota.dtNotafeco   := SYSDATE;
                rcNota.sbNotaobse   := CC_BOCONSTANTS.CSBPREFIJODOC || PKCONSTANTE.NULLSB || TO_CHAR( NUIDSOLICITUD );
                rcNota.sbNotaToken  := PKBILLCONST.DEVOLUCION || '-';

                tbCargos(1).nuProducto      := nuProducto;
                tbCargos(1).nuContrato      := nuContrato;
                tbCargos(1).nuCuencobr      := NUULTCUENTAPROD;
                tbCargos(1).nuConcepto      := GE_BOPARAMETER.FNUVALORNUMERICO ('CONCEPTO_DEPOSITO');
                tbCargos(1).NuCausaCargo    := NUCHARGECAUSE;
                tbCargos(1).nuValor         := ValorDev;
                tbCargos(1).nuValorBase     := NULL;
                tbCargos(1).sbCargdoso      := NULL; --Para que genere el cargo con el signo y el número de la nota
                tbCargos(1).sbSigno         := PKBILLCONST.DEVOLUCION;
                tbCargos(1).sbAjustaCuenta  := pkConstante.SI;
                tbCargos(1).sbNotaDocu      := NULL;
                tbCargos(1).sbBalancePostivo := pkConstante.SI;


                api_registranotaydetalle
                (
                    rcNota,
                    tbCargos,
                    NUNOTANUME,
                    nuerror,
                    sberror
                );

                UT_TRACE.TRACE( 'Numero nota: ' || NUNOTANUME   , 3 );
                UT_TRACE.TRACE( 'nuerror: ' || nuerror   , 3 );
                UT_TRACE.TRACE( 'sberror: ' || sberror   , 3 );

                if nuerror <> constants_per.OK then
                   raise pkg_Error.CONTROLLED_ERROR;
                end if;


                if cuSafaId%isopen then
                    close cuSafaId;
                end if;
                open cuSafaId(ValorDev,nuProducto);
                fetch cuSafaId into NUIDSAFA;
                close cuSafaId;

                UT_TRACE.TRACE( 'ID Saldo a favor:' || NUIDSAFA   , 3 );

                PKBCMOVISAFA.CREATERECORD (
                                          nuProducto,
                                          NUIDSAFA,
                                          SYSDATE,
                                          ValorDev * -1,
                                          NUULTCUENTAPROD,
                                          NUNOTANUME,
                                          'AS'
                                      );
                COMMIT;
            end loop;
            close cuProductSaFa;

        end if;
    end if;
    UT_TRACE.TRACE( 'Fin: LDC_UIATENDEVSALDOFAVOR_PROC', 3 );
    EXCEPTION
        WHEN LOGIN_DENIED OR pkg_Error.CONTROLLED_ERROR OR PKCONSTANTE.EXERROR_LEVEL2 THEN
            UT_TRACE.TRACE( 'Error: [LDC_UIATENDEVSALDOFAVOR_PROC]', 3 );
            RAISE;

        WHEN OTHERS THEN
            PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, SBMENSAJEERROR );
            UT_TRACE.TRACE( 'Error: [LDC_UIATENDEVSALDOFAVOR_PROC]', 3 );
            RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, SBMENSAJEERROR );
END LDC_UIATENDEVSALDOFAVOR_PROC;
/
PROMPT OTORGA PERMISOS ESQUEMA SOBRE PROCEDIMIENTO LDC_UIATENDEVSALDOFAVOR_PROC
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_UIATENDEVSALDOFAVOR_PROC', 'ADM_PERSON'); 
END;
/