CREATE OR REPLACE PROCEDURE adm_person.LDC_DistSaldFavoClieCast
IS
/*
    Propiedad Intelectual de REDI

    Funcion     :   LDC_DistSaldFavoClieCast
    Descripcion :   Distribucion del Saldo a Favor para Clientes Castigados
    Autor       :   Hery J Lopez R
    Fecha       :   20-11-2014

    Historia de Modificaciones
    Fecha               Autor               Modificacion
    =========           =========           ====================
    20-11-2014          Hery J Lopez R      Creacion
     9-03/2021          Lguillen            cambio 701 - se modifica en el  cursor UPDCUENCOBR 
                                            se anexa en la consulta los cargos con signo NS  
                                            para que estos sean tenidos en cuenta  en la sumatoria 
                                            para el  cálculo del valor de la columna CUCOVAAB 
	24-03-2022          cgonzalez           OSF-127 Se modifica metodo DistribPunDebt para que al 
											momento de crear el ajuste de saldos se tenga en cuenta
											solo los cargos creados en este procesamiento
	14-10-2022			cgonzalez			OSF-606: Se modifica metodo DistribPunDebt para que al 
											momento de crear el ajuste de saldos se procese 1 solo registro
    18-11-2022			cgonzalez			OSF-693: Se modifica para revertir el cambio de estado de corte
                                            cuando el producto no esta suspendido por Falta de Pago
    15/05/2024          Paola Acosta        OSF-2674: Cambio de esquema ADM_PERSON  
                                            Retiro marcacion esquema .open objetos de lógica                                             
*/
    ----------------------------------------------------------------------------
    -- Constantes
    ----------------------------------------------------------------------------
    -- Mensaje de Nulo
    cnuNULL_ATTR    constant number := 2126;

    ----------------------------------------------------------------------------
    -- Variables
    ----------------------------------------------------------------------------
    -- Log PB
    nuLdlpcons  ldc_log_pb.ldlpcons%type;

    -- Indicador
    nuIndicador number;

    -- Codigo Error
    nuErrorCode     number;
    -- Descripcion Error
    sbErrorMessage  varchar2(4000);

    -- Producto
    sbSesunuse      ge_boInstanceControl.stysbValue;

    --
    nuMovivalo  movisafa.mosfvalo%type;

    --
    nuProyCast  gc_prodprca.prpcprca%type;

    -- Consecutivo gc_debt_negot_prod dummy
    nuDumNegProd gc_debt_negot_prod.debt_negot_prod_id%type;

    -- Plantilla cargo gc_debt_negot_charge
    rcDebtNegoCharg  dagc_debt_negot_charge.styGC_debt_negot_charge;

    --
    nuSaldo     saldfavo.safavalo%type;

    type tytbCargos is table of cargos%rowtype index BY binary_integer;
    tbCargos    tytbCargos;

    type tytbProds is table of servsusc%rowtype index BY binary_integer;
    tbProds     tytbProds;

    --
    tbNegoCharg   gc_bcdebtnegocharge.tytbDebtNegoCharges;

    --
    type tyrcCuenta is record
    (
        cucocodi    cuencobr.cucocodi%type,
        factfege    factura.factfege%type,
        nuSaldo     cuencobr.cucosacu%type
    );

    --
    type tytbCuentas is table of tyrcCuenta index BY binary_integer;
    tbCuentas   tytbCuentas;
    
    nuSuspensionCartera NUMBER;
	nuProducto   		NUMBER;
    
    -- Consulta si no esta suspendido por cartera
    CURSOR cuSuspensionCartera(inuProducto IN NUMBER) IS
        SELECT  count(1)
        FROM    pr_prod_suspension s
        WHERE   s.suspension_type_id <> 2
        AND     s.inactive_date IS null 
        AND     s.active = 'Y' 
        AND     s.product_id = inuProducto;

    -- Obtiene poblaci??n de productos
    CURSOR cuProds IS
        SELECT  servsusc.*
        FROM    servsusc, gc_prodprca
        WHERE   sesunuse = prpcnuse
        AND     prpcsaca - nvl(prpcsare,0) > 0
        AND     sesusafa > 0
        AND     prpcnuse = sbSesunuse;

    -- Obtiene cargos para reactivaci??n de cartera castigada
    CURSOR cuCargos(nuCuenta number) IS
        SELECT      cargcuco, cargconc, sum(decode(cargsign,'CR',cargvalo,'DB',-cargvalo)) saldo
        FROM        (
                        SELECT  cargos.*
                        FROM    cargos, notas
                        WHERE   cargcuco = nuCuenta
                        AND     cargcaca = 2
                        AND     notanume = cargcodo
                        AND     cargprog = notaprog
                        AND     notatino = 'U'
                        AND     notadocu like 'PUN-%'
                        union all
                        SELECT  cargos.*
                        FROM    cargos
                        WHERE   cargcuco = nuCuenta
                        AND     cargcaca = 58
                    )
        GROUP BY    cargcuco, cargconc;

    -- Obtiene saldo castigado por cuenta de cobro, ordenando por fecha de generaci??n de la factura
    --
    CURSOR cuCuentas(nuProd number) IS
        SELECT  cucocodi, factfege, sum(decode(cargsign,'CR',cargvalo,'DB',-cargvalo)) saldo
        FROM    (
                    SELECT  cucocodi, factfege, cargos.*
                    FROM    cuencobr, cargos, factura, notas
                    WHERE   cargnuse = nuProd
                    AND     cargcaca = 2
                    AND     notanume = cargcodo
                    AND     notaprog = cargprog
                    AND     notatino = 'U'
                    AND     notadocu like 'PUN-%'
                    AND     cucofact = factcodi
                    AND     cargcuco = cucocodi
                    union all
                    SELECT  cucocodi, factfege, cargos.*
                    FROM    cuencobr, cargos, factura
                    WHERE   cargnuse = nuProd
                    AND     cargcaca = 58
                    AND     cucofact = factcodi
                    AND     cargcuco = cucocodi
            )
        GROUP BY    cucocodi, factfege
        ORDER BY    factfege asc;


    /*
        updCuencobr
    */
    
    /*cambio 701 - se modifica en el  cursor UPDCUENCOBR se anexa en la consulta los cargos con signo-NS  
      para que estos sean tenidos en cuenta en la sumatoria  para el  cálculo del valor de la columna 
      CUCOVAAB */
      
    PROCEDURE updCuencobr
    (
        nuCucocodi in cuencobr.cucocodi%type
    )
    IS
        nuCucovaab  cuencobr.cucovaab%type;
        nuCucovato  cuencobr.cucovato%type;
    BEGIN
        -- Determina el valor total y el valor abonado
        SELECT NVL ( SUM ( DECODE ( cargsign, 'DB', (cargvalo),
                                              'CR', -(cargvalo),
                                              0 ) ) , 0 ) cucovato,
               NVL ( SUM ( DECODE ( cargsign, 'PA', cargvalo,
                                              'AS', cargvalo,
                                              'SA', -cargvalo,
                                              'AP', -cargvalo,
                                              'NS', cargvalo,
                                              0 ) ) , 0 ) cucovaab
        INTO    nuCucovato, nuCucovaab
        FROM    cargos
        WHERE   cargcuco = nuCucocodi;

        -- Actualiza datos
        pktblcuencobr.updcucovato(nuCucocodi,nuCucovato);
        pktblcuencobr.updcucovaab(nuCucocodi,nuCucovaab);

        -- Efectua commit
        pkgeneralservices.committransaction;

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END updCuencobr;


    /*
        DistribPunDebt:
        Distribuye el saldo a favor entre las cuentas de cobro castigadas.
        La distribuci??n se realiza desde la cuenta de cobro m?!s antigua.
    */
    PROCEDURE DistribPunDebt
    (
        itbCuentas      in  tytbCuentas,
        inuSaldFavo     in  number,
        otbCargos       out gc_bcdebtnegocharge.tytbDebtNegoCharges
    )
    IS
        nuPuniDebt          number;
        nuValordist         number;
        nuSaldFavo          number;
        nuDebtNegoChargeId  gc_debt_negot_charge.debt_negot_charge_id%type;
        nuSaldoCargos       number;
        nuAjustVal          number;
    BEGIN

        nuSaldFavo      := inuSaldFavo;

        /* Distribuye Saldo a favor entre cuentas de cobro */

        for pos in itbCuentas.first..itbCuentas.last loop

            --dbms_output.put_Line('Saldo Favor --> '||nuSaldFavo);

            /* Establece saldo de la cuenta */
            nuPuniDebt := itbCuentas(pos).nuSaldo;

            -- Unicamente procesa la cuenta si la misma tiene saldo castigado
            -- y si a??n resta saldo a favor por aplicar.

            if nuSaldFavo > 0 AND nuPuniDebt > 0 then

                /* Establece Saldo de Cargos distribuidos */
                nuSaldoCargos   := 0;

                if(nuSaldFavo >= nuPuniDebt) then
                    nuValordist := nuPuniDebt;
                    nuSaldFavo  := nuSaldFavo - nuValordist;
                else
                    nuValordist := nuSaldFavo;
                    nuSaldFavo  := 0;
                END if;

                --dbms_output.put_Line('Cuenta --> '||itbCuentas(pos).cucocodi||'-'||nuValordist);

                /* Inserta Cargos dependiendo del valor a distribuir */

                for Cargo in cuCargos(itbCuentas(pos).cucocodi) loop

                    nuDebtNegoChargeId                      := seq_gc_debt_negot_c_197160.nextval;
                    rcDebtNegoCharg.debt_negot_charge_id    := nuDebtNegoChargeId;
                    rcDebtNegoCharg.conccodi                := Cargo.cargconc;

                    /* Si el saldo a distribuir es igual al saldo de la cuenta,
                        se reactiva todo el saldo del cargo
                    */

                    if(nuValordist = nuPuniDebt) then
                        rcDebtNegoCharg.billed_value := abs(Cargo.saldo);

                    /* Si el saldo a distribuir es menor que el saldo de la cuenta
                       se reactiva el cargo proporcionalmente
                    */
                    else
                       rcDebtNegoCharg.billed_value := abs(round((Cargo.saldo/nuPuniDebt)*nuValordist));
                    END if;

                    /* Se asigna el signo de los cargos de reactivaci??n */

                    if(Cargo.saldo < 0) then
                        rcDebtNegoCharg.signcodi := 'CR';
                        nuSaldoCargos   := nuSaldoCargos - rcDebtNegoCharg.billed_value;
                    else
                        rcDebtNegoCharg.signcodi := 'DB';
                        nuSaldoCargos   := nuSaldoCargos + rcDebtNegoCharg.billed_value;
                    END if;

                    rcDebtNegoCharg.cucocodi := Cargo.cargcuco;

                    /* Inserta Cargo a Reactivar */
                    dagc_debt_negot_charge.insrecord(rcDebtNegoCharg);

                    --dbms_output.put_Line('Inserta Cargo! '||rcDebtNegoCharg.conccodi||'-'||rcDebtNegoCharg.signcodi||'-'||rcDebtNegoCharg.billed_value);

                END loop;

                /*
                   Garantiza que el valor distribuido sea igual al saldo de los cargos.
                   Si esto no es as?-, por redondeo se ha perdido precisi??n del valor a distribuir.
                   Se asigna el saldo restante al cargo de mayor valor.
                */

                dbms_output.put_Line(itbCuentas(pos).cucocodi||'|'||nuValordist||'|'||nuSaldoCargos);

                if nuSaldoCargos <> nuValordist then
                       nuAjustVal := nuValordist - nuSaldoCargos;

                       UPDATE   gc_debt_negot_charge
                       SET      billed_value = billed_value + nuAjustVal
                       WHERE    cucocodi = itbCuentas(pos).cucocodi
                                AND billed_value = (
                                                    SELECT max(billed_value)
                                                    FROM   gc_debt_negot_charge
                                                    WHERE  cucocodi = itbCuentas(pos).cucocodi
													AND debt_negot_prod_id = nuDumNegProd
													AND creation_date > trunc(sysdate)
                                                    )
						AND		ROWNUM = 1;
                END if;

            END if;

        END loop;

        /* Llena colecci??n de cargos de negociaci??n */
        gc_bcdebtnegocharge.getdebtnegocharges(rcDebtNegoCharg.debt_negot_prod_id,otbCargos);

        /* Asienta Cambios */
        pkgeneralservices.committransaction;

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END DistribPunDebt;

    /*
        fnuGetProCastbyProd
    */
    FUNCTION fnuGetProCastbyProd
    (
        inuProduct  servsusc.sesunuse%type
    )
    return number
    IS
        nuProyCast  gc_prodprca.prpcprca%type;
    BEGIN

        SELECT  prpcprca
        INTO    nuProyCast
        FROM    gc_prodprca
        WHERE   prpcnuse = inuProduct
                AND prpcsaca > 0
                AND trunc(prpcfeca) =   (
                                            SELECT  max(trunc(prpcfeca))
                                            FROM    gc_prodprca
                                            WHERE   prpcnuse = inuProduct
                                            AND     prpcsaca > 0
                                        );
        return  nuProyCast;
    END fnuGetProCastbyProd;


    /*
        fnuGetMovisafa
    */
    FUNCTION fnuGetMovisafa
    (
        inuProduct  servsusc.sesunuse%type
    )
    return number
    IS
        -- Valor
        nuMovivalo  movisafa.mosfvalo%type := 0;
    BEGIN

        SELECT  sum(mosfvalo)
        INTO    nuMovivalo
        FROM    movisafa
        WHERE   mosfsesu = inuProduct;

        return  nuMovivalo;

    END fnugetMovisafa;


    /*
        ProcessLog
        Inserta o Actualiza el log de PB
    */
    procedure ProcessLog
    (
        inuCons in out  ldc_log_pb.ldlpcons%type,
        isbProc in      ldc_log_pb.ldlpproc%type,
        idtFech in      ldc_log_pb.ldlpfech%type,
        isbInfo in      ldc_log_pb.ldlpinfo%type
    )
    is
        -- Session
        sbSession   varchar2(50);
        -- Usuario
        sbUser      varchar2(50);
        -- Info Aux
        sbInfoAux   ldc_log_pb.ldlpinfo%type;
    begin
        -- Obtiene valor de la session
        SELECT  USERENV('SESSIONID'),
                USER
        INTO    sbSession,
                sbUser
        FROM    dual;

        -- Insertamos o Actualizamos
        if(inuCons is null) then

            -- Obtiene CONS de log pb
            select  SEQ_LDC_LOG_PB.nextval
            into    inuCons
            from    dual;

            insert into ldc_log_pb
            (
                LDLPCONS, LDLPPROC, LDLPUSER, LDLPTERM, LDLPFECH, LDLPINFO
            )
            values
            (
                inuCons,
                isbProc,
                sbUser,
                sbSession,
                idtFech,
                isbInfo
            );

        else
            -- Obtiene Datos
            select  LDLPINFO
            into    sbInfoAux
            from    ldc_log_pb
            where   LDLPCONS = inuCons;

            -- Actualiza Datos
            update  ldc_log_pb
            set     LDLPINFO = LDLPINFO||' '||isbInfo
            where   LDLPCONS = inuCons;
        end if;

        commit;

    end ProcessLog;

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
---------------------------------------------------------------------------------
BEGIN

    -- Obtiene producto de pantalla
    sbSesunuse := ge_boInstanceControl.fsbGetFieldValue ('SERVSUSC', 'SESUNUSE');

    -- Inserta Actualiza Log PB
    ProcessLog
    (
        nuLdlpcons,
        'LDCDSCC',
        sysdate,
        'Producto:'||nvl(to_char(sbSesunuse),'NULL')
    );

    ------------------------------------------------
    -- Required Attributes
    ------------------------------------------------
    if (sbSesunuse is null) then
        Errors.SetError(
            cnuNULL_ATTR,
            'Producto'
        );
        raise ex.CONTROLLED_ERROR;
    end if;

    -- Valida si esta castigado
    nuIndicador := 0;

    select  count(1)
    into    nuIndicador
    from    servsusc
    where   sesunuse = sbSesunuse
    and     sesuesfn <> 'C';

    if(nuIndicador > 0) then
        Errors.SetError(
            -20100,
            'El Producto '||sbSesunuse||' no se encuentra Castigado'
        );
        raise ex.CONTROLLED_ERROR;
    end if;

    -- Valida si tiene saldo a favor
    nuIndicador := 0;

    select  count(1)
    into    nuIndicador
    from    servsusc
    where   sesunuse = sbSesunuse
    and     sesusafa <= 0;

    if(nuIndicador > 0) then
        Errors.SetError(
            -20100,
            'El Producto '||sbSesunuse||' no tiene Saldo a Favor'
        );
        raise ex.CONTROLLED_ERROR;
    end if;

    ------------------------------------------------
    -- User code
    ------------------------------------------------

    -- Establece nombre del programa
    pkerrors.setapplication('SQL');

    -- Inicializa consecutivo dummy
    nuDumNegProd := seq_gc_debt_negot_p_197149.nextval;

    -- Inserta gc_debt_negot_prod dummy servsusc
    INSERT INTO gc_debt_negot_prod
    VALUES (nuDumNegProd,1,-1,sysdate,0,0,0,0,0,0,'N');

    -- Inicializa plantilla gc_debt_negot_charge
    rcDebtNegoCharg := dagc_debt_negot_charge.frcgetrecord(1);

    rcDebtNegoCharg.debt_negot_prod_id := nuDumNegProd;
    rcDebtNegoCharg.creation_date := sysdate;
    rcDebtNegoCharg.user_id := 1;
    rcDebtNegoCharg.is_discount := 'N';
    rcDebtNegoCharg.cacacodi := 58;
    rcDebtNegoCharg.pefacodi := -1;

    -- Ciclo de reactivacion por producto
    for nuProd in cuProds loop

        -- Obtener saldo a reactivar (Saldo a Favor)
        nuSaldo := round(nuProd.sesusafa);

        -- Valida sumatoria de movimientos de saldo
        nuMovivalo := round(fnugetMovisafa(nuProd.sesunuse));

        -- Unicamente reactiva si los movimientos de saldo a favor y el sesusafa
        -- son congruentes
        if (nuMovivalo =  nuSaldo) then

            -- Obtiene proyecto de castigo
            nuProyCast := fnuGetProcastbyProd(nuProd.sesunuse);

            -- Actualiza documento de soporte
            rcDebtNegoCharg.support_document := 'PUN-'||to_char(nuProyCast);

            -- Obtener cuentas de cobro castigadas para distribuir
            open cuCuentas(nuProd.sesunuse);
            fetch cuCuentas bulk collect INTO tbCuentas;
            close cuCuentas;

            -- Distribuir saldo a reactivar por cuenta de cobro e Insertar cargos de reactivaci??n
            DistribPunDebt(tbCuentas,nuSaldo,tbNegoCharg);

            -- Reactivar cartera
            -- Invoca al Servicio de reactivaci??n de cartera por negociaci??n de deuda
            gc_bocastigocartera.reactnegociateddebt(tbNegoCharg,nuProd.sesunuse);

            -- Si
            if(tbNegoCharg.count > 0) then

                -- Actualiza saldos de cuentas de cobro afectadas
                for i in tbNegoCharg.first..tbNegoCharg.last loop
                    UpdCuencobr(tbNegoCharg(i).cucocodi);
                end loop;

                -- Aplica saldo a favor en las cuentas reactivadas
                BEGIN

                    pkAccountMgr.ApplyPositiveBalServ(nuProd.sesunuse);

                EXCEPTION
                    when OTHERS then
                        dbms_output.put_Line('NO Se aplico saldo a favor para el producto: ' || nuProd.sesunuse);
                END;

            end if;

            -- Elimina datos temporales
            DELETE FROM gc_debt_negot_charge
            WHERE  debt_negot_prod_id = nuDumNegProd;

            -- Asienta cambios
            pkgeneralservices.committransaction;

        end if;

    end loop;

    -- Borra registro Dummy
    DELETE FROM gc_debt_negot_prod
    WHERE  debt_negot_prod_id = nuDumNegProd;

    -- Commit
    pkgeneralservices.committransaction;
		
	nuProducto := TO_NUMBER(sbSesunuse);
    
    OPEN cuSuspensionCartera(nuProducto);
    FETCH cuSuspensionCartera INTO nuSuspensionCartera;
    CLOSE cuSuspensionCartera;
    
    IF (nuSuspensionCartera > 0) THEN
        DBMS_LOCK.SLEEP(5);
        
        IF (pktblservsusc.fnugetsesuesco(nuProducto) = 6) THEN

            pktblservsusc.updsesuesco(nuProducto, 1);

			UPDATE 	suspcone
			SET 	sucofeat = SYSDATE
			WHERE 	suconuse = nuProducto
			AND 	sucofeat IS NULL
			AND		sucocoec = 6;

			pkgeneralservices.committransaction;
        END IF;
    END IF;

EXCEPTION
    when ex.CONTROLLED_ERROR then
        Errors.GetError(nuErrorCode, sbErrorMessage);
        dbms_output.put_line('ERROR CONTROLLED ');
        dbms_output.put_line('Error onuErrorCode: '||nuErrorCode);
        dbms_output.put_line('Error osbErrorMess: '||sbErrorMessage);

        ProcessLog
        (
            nuLdlpcons,
            null,
            null,
            'Error:'||nvl(to_char(nuErrorCode),'NULL')||' Error_Desc:'||nvl(to_char(sbErrorMessage),'NULL')
        );
        raise;
    when OTHERS then
        Errors.setError;
        Errors.GetError(nuErrorCode, sbErrorMessage);
        dbms_output.put_line('ERROR CONTROLLED ');
        dbms_output.put_line('Error onuErrorCode: '||nuErrorCode);
        dbms_output.put_line('Error osbErrorMess: '||sbErrorMessage);

        ProcessLog
        (
            nuLdlpcons,
            null,
            null,
            'Error:'||nvl(to_char(nuErrorCode),'NULL')||' Error_Desc:'||nvl(to_char(sbErrorMessage),'NULL')
        );
        raise ex.CONTROLLED_ERROR;
END LDC_DistSaldFavoClieCast;
/
PROMPT Otorgando permisos de ejecucion a LDC_DISTSALDFAVOCLIECAST
BEGIN
    pkg_utilidades.praplicarpermisos('LDC_DISTSALDFAVOCLIECAST', 'ADM_PERSON');
END;
/

PROMPT Otorgando permisos de ejecucion sobre LDC_DISTSALDFAVOCLIECAST para reportes
GRANT EXECUTE ON adm_person.LDC_DISTSALDFAVOCLIECAST TO rexereportes;
/

