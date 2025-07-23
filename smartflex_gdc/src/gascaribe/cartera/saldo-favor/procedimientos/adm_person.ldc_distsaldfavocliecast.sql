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
    23/12/2024          jcatuche            OSF-3787: A nivel general se estandariza la traza y el manejo de errores.
                                            Se crean constantes csbSesion y csbUser y se eliminan las variables locales de ProcessLog
                                            Se refactoriza procedimiento interno ProcessLog
                                            Se cambian llamados a procedimientos open con los procedimientos homologados
                                            Se ajusta cursor de procedimiento interno fnuGetProCastbyProd para adicionar la misma validación 
                                            de saldo castigado que tiene el cursor cuProds, considerando los saldos reactivados
*/
    ----------------------------------------------------------------------------
    -- Constantes
    ----------------------------------------------------------------------------
    csbMetodo           CONSTANT VARCHAR2(32)       := $$PLSQL_UNIT;                -- Constante para nombre de función    
    cnuNivelTraza       CONSTANT NUMBER(2)          := pkg_traza.cnuNivelTrzDef;    -- Nivel de traza para esta función. 
    csbInicio           CONSTANT VARCHAR2(4)        := pkg_traza.fsbINICIO;         -- Indica inicio de método
    csbFin              CONSTANT VARCHAR2(4)        := pkg_traza.fsbFIN;            -- Indica Fin de método ok
    csbFin_Erc          CONSTANT VARCHAR2(4)        := pkg_traza.fsbFIN_ERC;        -- Indica fin de método con error controlado
    csbFin_Err          CONSTANT VARCHAR2(4)        := pkg_traza.fsbFIN_ERR;        -- Indica fin de método con error no controlado
    
    -- Mensaje de Nulo
    cnuNULL_ATTR    constant number := 2126;
    
    csbSesion       constant varchar2(50) := pkg_session.fnuGetSesion;
    csbUser         constant varchar2(50) := pkg_session.getUser;

    ----------------------------------------------------------------------------
    -- Variables
    ----------------------------------------------------------------------------
    -- Log PB
    nuLdlpcons  ldc_log_pb.ldlpcons%type;
    
    dtFecha     DATE;

    -- Indicador
    nuIndicador     number;
    
    nuError         NUMBER;
    sbError         VARCHAR2(4000);

    -- Producto
    sbSesunuse      ge_boInstanceControl.stysbValue;

    --
    nuMovivalo      movisafa.mosfvalo%type;

    --
    nuProyCast      gc_prodprca.prpcprca%type;
    
    rcRegNegProd    pkg_gc_debt_negot_prod.styRegistro;

    -- Consecutivo gc_debt_negot_prod dummy
    nuDumNegProd    gc_debt_negot_prod.debt_negot_prod_id%type;
    
    nuBilled_Value  gc_debt_negot_charge.Billed_Value%type;

    -- Plantilla cargo gc_debt_negot_charge
    rcDebtNegoCharg  pkg_gc_debt_negot_charge.styRegistro;

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

    -- Obtiene población de productos
    CURSOR cuProds IS
        SELECT  servsusc.*
        FROM    servsusc, gc_prodprca
        WHERE   sesunuse = prpcnuse
        AND     prpcsaca - nvl(prpcsare,0) > 0
        AND     sesusafa > 0
        AND     prpcnuse = sbSesunuse;

    -- Obtiene cargos para reactivación de cartera castigada
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

    -- Obtiene saldo castigado por cuenta de cobro, ordenando por fecha de generación de la factura
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
    
    --Obtiene los registros de los cargos de negociación insertados para la negociación dummy
    CURSOR cuCargosNegociacion (inuNegotChargeProd in Number) IS
        SELECT debt_negot_charge_id
        FROM gc_debt_negot_charge
        WHERE  debt_negot_prod_id = inuNegotChargeProd;


    --Obtiene elRowId del registro suspecone a actualizar
    CURSOR cuSuspcone (inuProducto in number) IS
        SELECT s.suconuse,s.rowid row_id 
        FROM suspcone s
        WHERE 	suconuse = inuProducto
		AND 	sucofeat IS NULL
        AND		sucocoec = 6;
        
    rcSuspcone  cuSuspcone%rowtype;
    /*
        updCuencobr
    */
    
    /*cambio 701 - se modifica en el  cursor UPDCUENCOBR se anexa en la consulta los cargos con signo-NS  
      para que estos sean tenidos en cuenta en la sumatoria  para el  cálculo del valor de la columna 
      CUCOVAAB */
      
    PROCEDURE updCuencobr
    (
        inuCucocodi in cuencobr.cucocodi%type
    )
    IS
        csbSubMet           CONSTANT VARCHAR2(50) := csbMetodo||'.updCuencobr';
        
        cursor cuCuenta is
        SELECT NVL ( SUM ( DECODE ( cargsign, 'DB', (cargvalo),
                                              'CR', -(cargvalo),
                                              0 ) ) , 0 ) cucovato,
               NVL ( SUM ( DECODE ( cargsign, 'PA', cargvalo,
                                              'AS', cargvalo,
                                              'SA', -cargvalo,
                                              'AP', -cargvalo,
                                              'NS', cargvalo,
                                              0 ) ) , 0 ) cucovaab
        FROM    cargos
        WHERE   cargcuco = inuCucocodi;
        
        nuCucovaab  cuencobr.cucovaab%type;
        nuCucovato  cuencobr.cucovato%type;
    BEGIN
        pkg_traza.trace(csbSubMet, cnuNivelTraza, csbInicio);
        pkg_traza.trace('inuCucocodi    <= '||inuCucocodi, cnuNivelTraza);
        
        if cuCuenta%isopen then close cuCuenta; end if;
        
        -- Determina el valor total y el valor abonado
        open cuCuenta;
        fetch cuCuenta into nuCucovato, nuCucovaab;
        close cuCuenta;
        
        -- Actualiza datos
        pkg_cuencobr.prAcCUCOVATO(inuCucocodi,nuCucovato);
        pkg_cuencobr.prAcCUCOVAAB(inuCucocodi,nuCucovaab);

        -- Efectua commit
        
        pkg_traza.trace(csbSubMet, cnuNivelTraza, csbFin);
        
    EXCEPTION
        when pkg_error.CONTROLLED_ERROR then
            pkg_error.GetError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, cnuNivelTraza);
            pkg_traza.trace(csbSubMet, cnuNivelTraza, csbFin_Erc);
            raise pkg_error.CONTROLLED_ERROR;
        when others then
            pkg_error.setError;
            pkg_error.GetError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, cnuNivelTraza);
            pkg_traza.trace(csbSubMet, cnuNivelTraza, csbFin_Err);
            raise pkg_error.CONTROLLED_ERROR;
    END updCuencobr;
    
    FUNCTION fnuGetMaxNegoCharge
    (
        inuCuenta       cuencobr.cucocodi%type,
        inuNegotProd    gc_debt_negot_charge.debt_negot_prod_id%type
    )
    return number
    IS
        cursor cuMaxNegoCharge is
        select  DEBT_NEGOT_CHARGE_ID
        FROM gc_debt_negot_charge
        WHERE  cucocodi = inuCuenta
        AND billed_value = 
        (
            SELECT max(billed_value)
            FROM   gc_debt_negot_charge
            WHERE  cucocodi = inuCuenta
            AND debt_negot_prod_id = inuNegotProd
            AND creation_date > trunc(sysdate)
        )
		AND	ROWNUM = 1;
                                        
        nuNegotProd  gc_debt_negot_charge.debt_negot_prod_id%type;
    BEGIN

        if cuMaxNegoCharge%isopen then close cuMaxNegoCharge; end if;
        
        open cuMaxNegoCharge;
        fetch cuMaxNegoCharge into nuNegotProd;
        close cuMaxNegoCharge;
        
        return  nuNegotProd;
        
    END fnuGetMaxNegoCharge;


    /*
        DistribPunDebt:
        Distribuye el saldo a favor entre las cuentas de cobro castigadas.
        La distribución se realiza desde la cuenta de cobro m?!s antigua.
    */
    PROCEDURE DistribPunDebt
    (
        itbCuentas      in  tytbCuentas,
        inuSaldFavo     in  number,
        otbCargos       out gc_bcdebtnegocharge.tytbDebtNegoCharges
    )
    IS
        csbSubMet           CONSTANT VARCHAR2(50) := csbMetodo||'.DistribPunDebt';
        nuPuniDebt          number;
        nuValordist         number;
        nuSaldFavo          number;
        nuDebtNegoChargeId  gc_debt_negot_charge.debt_negot_charge_id%type;
        nuSaldoCargos       number;
        nuAjustVal          number;
    BEGIN
        pkg_traza.trace(csbSubMet, cnuNivelTraza, csbInicio);
        pkg_traza.trace('itbCuentas     <= '||itbCuentas.count, cnuNivelTraza);
        pkg_traza.trace('inuSaldFavo    <= '||inuSaldFavo, cnuNivelTraza);
        
        nuSaldFavo      := inuSaldFavo;

        /* Distribuye Saldo a favor entre cuentas de cobro */

        for pos in itbCuentas.first..itbCuentas.last loop
            
            pkg_traza.trace('===============================',cnuNivelTraza);
            pkg_traza.trace('Cuenta: '||itbCuentas(pos).cucocodi,cnuNivelTraza);
            pkg_traza.trace('Saldo: '||itbCuentas(pos).nuSaldo,cnuNivelTraza);

            /* Establece saldo de la cuenta */
            nuPuniDebt := itbCuentas(pos).nuSaldo;

            -- Unicamente procesa la cuenta si la misma tiene saldo castigado
            -- y si aún resta saldo a favor por aplicar.

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

                pkg_traza.trace('nuValordist: '||nuValordist,cnuNivelTraza);
                pkg_traza.trace('nuSaldFavo: '||nuSaldFavo,cnuNivelTraza);

                /* Inserta Cargos dependiendo del valor a distribuir */

                for Cargo in cuCargos(itbCuentas(pos).cucocodi) loop

                    pkg_traza.trace('------------------------------',cnuNivelTraza);
                    nuDebtNegoChargeId                      := null;
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

                    /* Se asigna el signo de los cargos de reactivación */

                    if(Cargo.saldo < 0) then
                        rcDebtNegoCharg.signcodi := 'CR';
                        nuSaldoCargos   := nuSaldoCargos - rcDebtNegoCharg.billed_value;
                    else
                        rcDebtNegoCharg.signcodi := 'DB';
                        nuSaldoCargos   := nuSaldoCargos + rcDebtNegoCharg.billed_value;
                    END if;

                    rcDebtNegoCharg.cucocodi := Cargo.cargcuco;
                    
                    pkg_traza.trace('conccodi: '||rcDebtNegoCharg.conccodi,cnuNivelTraza);
                    pkg_traza.trace('signcodi: '||rcDebtNegoCharg.signcodi,cnuNivelTraza);
                    pkg_traza.trace('billed_value: '||rcDebtNegoCharg.billed_value,cnuNivelTraza);
                    pkg_traza.trace('nuSaldoCargos: '||nuSaldoCargos,cnuNivelTraza);

                    /* Inserta Cargo a Reactivar */
                    pkg_gc_debt_negot_charge.prInsRegistro(rcDebtNegoCharg,nuDebtNegoChargeId);
                    pkg_traza.trace('Consecutivo insertado: '||nuDebtNegoChargeId,cnuNivelTraza);

                END loop;

                /*
                   Garantiza que el valor distribuido sea igual al saldo de los cargos.
                   Si esto no es as?-, por redondeo se ha perdido precisión del valor a distribuir.
                   Se asigna el saldo restante al cargo de mayor valor.
                */

                if nuSaldoCargos <> nuValordist then
                        
                        pkg_traza.trace('Ajuste por diferencia entre el saldo y el valor a distribuir: ['||nuSaldoCargos||']['||nuValordist||']',cnuNivelTraza);
                        
                        nuDebtNegoChargeId := null;
                        nuDebtNegoChargeId := fnuGetMaxNegoCharge(itbCuentas(pos).cucocodi,nuDumNegProd);
                        pkg_traza.trace('Consecutivo máximo valor cargo en la tabla de negociación: '||nuDebtNegoChargeId,cnuNivelTraza);
                        
                        nuAjustVal := nuValordist - nuSaldoCargos;
                        pkg_traza.trace('nuAjustVal: '||nuAjustVal,cnuNivelTraza);
                        
                        nuBilled_Value := pkg_gc_debt_negot_charge.fnuObtBILLED_VALUE(nuDebtNegoChargeId);
                        pkg_traza.trace('nuBilled_Value: '||nuBilled_Value,cnuNivelTraza);
                        
                        pkg_gc_debt_negot_charge.prAcBILLED_VALUE(nuDebtNegoChargeId,nuBilled_Value + nuAjustVal);

                END if;
            ELSE
                pkg_traza.trace('Sin saldo a favor para cruzar o cuenta sin saldo pendiente para reactivar: ['||nuSaldFavo||']['||nuPuniDebt||']',cnuNivelTraza);
            END if;

        END loop;

        /* Llena colección de cargos de negociación */
        gc_bcdebtnegocharge.getdebtnegocharges(nuDumNegProd,otbCargos);

        /* Asienta Cambios */
        commit;
        
        pkg_traza.trace('otbCargos     => '||otbCargos.count, cnuNivelTraza);
        pkg_traza.trace(csbSubMet, cnuNivelTraza, csbFin);
        
    EXCEPTION
        when pkg_error.CONTROLLED_ERROR then
            pkg_error.GetError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, cnuNivelTraza);
            pkg_traza.trace(csbSubMet, cnuNivelTraza, csbFin_Erc);
            raise pkg_error.CONTROLLED_ERROR;
        when others then
            pkg_error.setError;
            pkg_error.GetError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, cnuNivelTraza);
            pkg_traza.trace(csbSubMet, cnuNivelTraza, csbFin_Err);
            raise pkg_error.CONTROLLED_ERROR;
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
        cursor cuprpcprca is
        SELECT  prpcprca
        FROM    gc_prodprca
        WHERE   prpcnuse = inuProduct
                AND (prpcsaca - nvl(prpcsare,0)) > 0
                AND trunc(prpcfeca) =   (
                                            SELECT  max(trunc(prpcfeca))
                                            FROM    gc_prodprca
                                            WHERE   prpcnuse = inuProduct
                                            AND     (prpcsaca - nvl(prpcsare,0)) > 0
                                        );
                                        
        nuProyCast  gc_prodprca.prpcprca%type;
    BEGIN

        if cuprpcprca%isopen then close cuprpcprca; end if;
        
        open cuprpcprca;
        fetch cuprpcprca into nuProyCast;
        close cuprpcprca;
        
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
        cursor cuMovisafa is
        SELECT  sum(mosfvalo)
        FROM    movisafa
        WHERE   mosfsesu = inuProduct;
        
        -- Valor
        nuMovivalo  movisafa.mosfvalo%type := 0;
    BEGIN

        if cuMovisafa%isopen then close cuMovisafa; end if;
        
        open cuMovisafa;
        fetch cuMovisafa INTO nuMovivalo;
        close cuMovisafa;

        return  nuMovivalo;

    END fnugetMovisafa;


    -- Inserta o Actualiza el log de PB
    procedure ProcessLog
    (
        isbInfo in      ldc_log_pb.ldlpinfo%type
    )
    is
        rcLogPb     pkg_ldc_log_pb.styRegistro;
        
    begin
        
        
        rcLogPb.LDLPCONS := nuLdlpcons;
        rcLogPb.LDLPPROC := 'LDCDSCC';
        rcLogPb.LDLPUSER := csbUser;
        rcLogPb.LDLPTERM := csbSesion;
        rcLogPb.LDLPFECH := dtFecha;
        rcLogPb.LDLPINFO := isbInfo;
        
        
        -- Insertamos o Actualizamos
        if ( nuLdlpcons is null) then

            pkg_ldc_log_pb.prInsRegistro(rcLogPb,nuLdlpcons);
            
        else
            -- Actualiza Datos
            pkg_ldc_log_pb.prActRegistro(rcLogPb);
            
        end if;

    end ProcessLog;
    
    --Borra producto por negociación
    procedure prBorraNegoProducto is
        csbSubMet           CONSTANT VARCHAR2(50) := csbMetodo||'.prBorraNegoProducto';
    begin
        pkg_traza.trace(csbSubMet, cnuNivelTraza, csbInicio);
        
        if nuDumNegProd is not null then
            pkg_gc_debt_negot_prod.prBorRegistro(nuDumNegProd);
            commit;
        end if;
        
        pkg_traza.trace(csbSubMet, cnuNivelTraza, csbFin);
    EXCEPTION
        when pkg_error.CONTROLLED_ERROR then
            pkg_error.GetError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, cnuNivelTraza);
            pkg_traza.trace(csbSubMet, cnuNivelTraza, csbFin_Erc);
            raise pkg_error.CONTROLLED_ERROR;
        when others then
            pkg_error.setError;
            pkg_error.GetError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, cnuNivelTraza);
            pkg_traza.trace(csbSubMet, cnuNivelTraza, csbFin_Err);
            raise pkg_error.CONTROLLED_ERROR;
    end prBorraNegoProducto;
    
    --Borra cargos por negociación
    procedure prBorraNegoCargos is
        csbSubMet           CONSTANT VARCHAR2(50) := csbMetodo||'.prBorraNegoCargos';
    begin
        pkg_traza.trace(csbSubMet, cnuNivelTraza, csbInicio);
        
        if nuDumNegProd is not null then
            for rc in cuCargosNegociacion(nuDumNegProd) loop
            
                pkg_gc_debt_negot_charge.prBorRegistro(rc.DEBT_NEGOT_CHARGE_ID);
                
            end loop;

            -- Asienta cambios
            commit;
        end if;
        
        pkg_traza.trace(csbSubMet, cnuNivelTraza, csbFin);
    EXCEPTION
        when pkg_error.CONTROLLED_ERROR then
            pkg_error.GetError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, cnuNivelTraza);
            pkg_traza.trace(csbSubMet, cnuNivelTraza, csbFin_Erc);
            raise pkg_error.CONTROLLED_ERROR;
        when others then
            pkg_error.setError;
            pkg_error.GetError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, cnuNivelTraza);
            pkg_traza.trace(csbSubMet, cnuNivelTraza, csbFin_Err);
            raise pkg_error.CONTROLLED_ERROR;
    end prBorraNegoCargos;
    
    --Borra temporales
    procedure prBorraTemporales is
    begin
        prBorraNegoCargos;
        prBorraNegoProducto;
    end prBorraTemporales;

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
---------------------------------------------------------------------------------
BEGIN
    pkg_traza.trace(csbMetodo, cnuNivelTraza, csbInicio);
    -- Obtiene producto de pantalla
    sbSesunuse := ge_boInstanceControl.fsbGetFieldValue ('SERVSUSC', 'SESUNUSE');
    nuProducto := TO_NUMBER(sbSesunuse);
    pkg_traza.trace('Identificador del producto: '||nuProducto, cnuNivelTraza);
    
    dtFecha := SYSDATE;

    -- Inserta Actualiza Log PB
    ProcessLog
    (
        'Producto:'||nvl(to_char(sbSesunuse),'NULL')
    );

    ------------------------------------------------
    -- Required Attributes
    ------------------------------------------------
    if (sbSesunuse is null) then
        pkg_error.setErrorMessage(
            cnuNULL_ATTR,
            'Producto'
        );
    
    end if;

    -- Valida si esta castigado
    IF pkg_bcproducto.fsbEstadoFinanciero(nuProducto) != 'C' then
        pkg_error.setErrorMessage(
            -20100,
            'El Producto '||sbSesunuse||' no se encuentra Castigado'
        );
    END IF;

    -- Valida si tiene saldo a favor
    IF nvl(pkg_bcproducto.fnuSaldoAfavor(nuProducto),0) <= 0 then
        pkg_error.setErrorMessage(
            -20100,
            'El Producto '||sbSesunuse||' no tiene Saldo a Favor'
        );
    END IF;
    
    -- Establece nombre del programa
    pkg_error.setapplication('SQL');
    
    rcRegNegProd := NULL;
    
    rcRegNegProd.DEBT_NEGOT_PROD_ID      := null;
    rcRegNegProd.DEBT_NEGOTIATION_ID     := 1;
    rcRegNegProd.SESUNUSE                := -1;            
    rcRegNegProd.LATE_CHARGE_LIQ_DATE    := sysdate;
    rcRegNegProd.LATE_CHARGE_DAYS        := 0;   
    rcRegNegProd.BILLED_LATE_CHARGE      := 0;  
    rcRegNegProd.NOT_BILLED_LATE_CHA     := 0;
    rcRegNegProd.NOT_BILLED_VALUE        := 0;    
    rcRegNegProd.PENDING_BALANCE         := 0;     
    rcRegNegProd.VALUE_TO_PAY            := 0;       
    rcRegNegProd.EXONER_RECONN_CHARGE    := 'N';
    
    -- Inserta gc_debt_negot_prod dummy servsusc
    pkg_gc_debt_negot_prod.prInsRegistro(rcRegNegProd,nuDumNegProd);
    pkg_traza.trace('Registra producto por negociación dummy: '||nuDumNegProd, cnuNivelTraza);

    -- Inicializa plantilla gc_debt_negot_charge
    rcDebtNegoCharg := pkg_gc_debt_negot_charge.frcObtRegistro(1);
    pkg_traza.trace('Obtiene regisro de cargos de negociación dummy', cnuNivelTraza);
    
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
        
        pkg_traza.trace('Saldo a favor producto y movimientos: ['||nuSaldo||']['||nuMovivalo||']', cnuNivelTraza);

        -- Unicamente reactiva si los movimientos de saldo a favor y el sesusafa
        -- son congruentes
        if (nuMovivalo =  nuSaldo) then

            -- Obtiene proyecto de castigo
            nuProyCast := fnuGetProcastbyProd(nuProd.sesunuse);
            
            pkg_traza.trace('Proyecto de castigo para el producto: '||nuProyCast, cnuNivelTraza);

            -- Actualiza documento de soporte
            rcDebtNegoCharg.support_document := 'PUN-'||to_char(nuProyCast);

            -- Obtener cuentas de cobro castigadas para distribuir
            open cuCuentas(nuProd.sesunuse);
            fetch cuCuentas bulk collect INTO tbCuentas;
            close cuCuentas;
            
            pkg_traza.trace('Obtiene las cuentas gestionadas por el castigo: '||tbCuentas.count, cnuNivelTraza);

            -- Distribuir saldo a reactivar por cuenta de cobro e Insertar cargos de reactivación
            DistribPunDebt(tbCuentas,nuSaldo,tbNegoCharg);

            -- Reactivar cartera
            -- Invoca al Servicio de reactivación de cartera por negociación de deuda
            gc_bocastigocartera.reactnegociateddebt(tbNegoCharg,nuProd.sesunuse);

            -- Si
            if(tbNegoCharg.count > 0) then

                -- Actualiza saldos de cuentas de cobro afectadas
                for i in tbNegoCharg.first..tbNegoCharg.last loop
                    UpdCuencobr(tbNegoCharg(i).cucocodi);
                end loop;

                -- Aplica saldo a favor en las cuentas reactivadas
                BEGIN
                    pkg_traza.trace('Aplica Saldo a Favor producto', cnuNivelTraza);
                    pkAccountMgr.ApplyPositiveBalServ(nuProd.sesunuse);

                EXCEPTION
                    when OTHERS then
                        pkg_error.setError;
                        pkg_error.GetError(nuError, sbError);
                        sbError := 'Error aplicando saldo a favor al producto '||nuProd.sesunuse||', proyecto de castigo '||nuProyCast||' y saldo a favor '||nuMovivalo||'. Error: '||sbError;
                        pkg_error.setErrorMessage( isbMsgErrr => sbError);
                END;

            end if;

            -- Elimina datos temporales
            prBorraNegoCargos;

        end if;

    end loop;

    -- Borra registro Dummy
    prBorraNegoProducto;
		
    OPEN cuSuspensionCartera(nuProducto);
    FETCH cuSuspensionCartera INTO nuSuspensionCartera;
    CLOSE cuSuspensionCartera;
    
    IF (nuSuspensionCartera > 0) THEN
        DBMS_LOCK.SLEEP(5);
        
        IF (pkg_bcproducto.fnuEstadoCorte(nuProducto) = 6) THEN
            pkg_producto.prActualizaEstadoCorte(nuProducto, 1);
            
            if cuSuspcone%isopen then close cuSuspcone; end if;
            
            rcSuspcone := null;
            open cuSuspcone(nuProducto);
            fetch cuSuspcone into rcSuspcone;
            close cuSuspcone;
            
            if rcSuspcone.suconuse is not null then
            
                pkg_suspcone.prc_ActFechaAtencionRowId(rcSuspcone.row_id,SYSDATE,nuError,sbError);
                
                if nuError != constants_per.OK then
                    pkg_error.setErrorMessage( isbMsgErrr => sbError);
                end if;
            
            end if;
            
			commit;
			
        END IF;
    END IF;
    
    ProcessLog
    (
        'Ok'
    );
    
    pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin);

EXCEPTION
    when pkg_error.CONTROLLED_ERROR then
        rollback;
        pkg_error.GetError(nuError, sbError);
        pkg_traza.trace('sbError: ' || sbError, cnuNivelTraza);
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_Erc);

        ProcessLog
        (
            'Error:'||nvl(to_char(nuError),'NULL')||' Error_Desc:'||nvl(to_char(sbError),'NULL')
        );
        prBorraTemporales;
        raise pkg_error.CONTROLLED_ERROR;
    when OTHERS then
        rollback;
        pkg_error.setError;
        pkg_error.GetError(nuError, sbError);
        pkg_traza.trace('sbError: ' || sbError, cnuNivelTraza);
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_Err);
        
        ProcessLog
        (
            'Error:'||nvl(to_char(nuError),'NULL')||' Error_Desc:'||nvl(to_char(sbError),'NULL')
        );
        prBorraTemporales;
        raise pkg_error.CONTROLLED_ERROR;
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

