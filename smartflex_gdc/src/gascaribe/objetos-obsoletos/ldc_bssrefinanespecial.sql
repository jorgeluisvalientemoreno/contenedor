CREATE OR REPLACE PACKAGE OPEN.LDC_BSSREFINANESPECIAL IS

     /**************************************************************************
    Propiedad Intelectual de PETI

    Funcion     :   fsbVersion
    Descripcion :   Obtiene la version del paquete
    Autor       :   Gabriel Gamarra - Horbath Technologies

    Historia de Modificaciones
      Fecha               Autor                Modificacion
    =========           =========          ====================
    18-12-2014           ggamarra            Creacion
    **************************************************************************/

    FUNCTION fsbVersion RETURN VARCHAR2;

 /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : RefinanCuota
    Descripcion    : Procedimiento para procesar las refinanciaciones especiales
                     dividiendo el 50% en 2 financiaciones - Surtigas

    Parametros           Descripcion
    ============         ===================
    orfcursor            Retorna los datos generales de la factura.

    Fecha             Autor             Modificacion
    =========       =========           ====================
    18-12-2014      ggamarra           Creacion.
    ******************************************************************/

    PROCEDURE RefinanCuota;

 /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : RefinanMultiCuota
    Descripcion    : Procedimiento para procesar las refinanciaciones especiales
                     dividiendo en 2 diferidos - Gascaribe

    Parametros           Descripcion
    ============         ===================
    orfcursor            Retorna los datos generales de la factura.

    Fecha             Autor             Modificacion
    =========       =========           ====================
    18-12-2014      ggamarra           Creacion.
    ******************************************************************/

    PROCEDURE RefinanMultiCuota;

END LDC_BSSREFINANESPECIAL;
/

CREATE OR REPLACE PACKAGE BODY OPEN.LDC_BSSREFINANESPECIAL IS

    csbVersion CONSTANT VARCHAR2(50) := 'TEAM RQ669_3';


    csbPlandifeEsp   CONSTANT ld_parameter.parameter_id%type := 'ESP_REFINA_PLAN';
    csbPlandifeNew   CONSTANT ld_parameter.parameter_id%type := 'ESP_REFINA_PLAN_NUEVO';
    csbGracePeriod   CONSTANT ld_parameter.parameter_id%type := 'ESP_REFINA_PER_GRACIA';
    csbProcDate      CONSTANT ld_parameter.parameter_id%type := 'ESP_REFINA_PROC_DATE';
    csbCuotaInicial  CONSTANT ld_parameter.parameter_id%type := 'ESP_REFINA_INI_SALDO';


    nuPlanSingle  NUMBER  := dald_parameter.fnuGetNumeric_Value(csbPlandifeEsp);
    nuPlanNew     NUMBER  := dald_parameter.fnuGetNumeric_Value(csbPlandifeNew);
    nuPerGracia   NUMBER  := dald_parameter.fnuGetNumeric_Value(csbGracePeriod);
    gnuSaldo      NUMBER  := dald_parameter.fnuGetNumeric_Value(csbCuotaInicial);


    sbPath        varchar2(500) := pktblparametr.fsbgetstringvalue('RUTA_TRAZA');

    cursor cuRefinanciaciones (nuPlan number, dtUltFinan date ) is
        SELECT --+ index(mo_packages,IDX_MO_PACKAGES_025)
            cc_financing_request.*,  mo_packages.attention_date
        FROM mo_packages, cc_financing_request
        WHERE mo_packages.attention_date > dtUltFinan
        AND   mo_packages.package_id =  cc_financing_request.package_id
        AND   cc_financing_request.financing_plan_id = nuPlan
        AND   mo_packages.motive_status_id = 14
        ORDER BY  mo_packages.attention_date ;

    cursor cuDiferidos ( nuDiferido number ) is
        SELECT   *
        FROM    diferido
        WHERE   difecofi = nuDiferido
        ORDER BY difecodi;

	----------------------------------------------------------------------
	-- Metodos
	----------------------------------------------------------------------

    FUNCTION fsbVersion
    RETURN VARCHAR2
    IS
    BEGIN
	    pkErrors.push('LDC_BSSREFINANESPECIAL.fsbVersion');
		pkErrors.pop;
		RETURN csbVersion;
    END fsbVersion;
  /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : release_lock
    Descripcion    : Procedimiento para liberar el proceso una vez termine

    Parametros           Descripcion
    ============         ===================


    Fecha             Autor             Modificacion
    =========       =========           ====================
    18-12-2014      ggamarra           Creacion.
    ******************************************************************/
    PROCEDURE release_lock(sbLockHandle in VARCHAR2 )
        IS

        nuRequestResult number;

        BEGIN
            if (sbLockHandle IS not null) then
                nuRequestResult := dbms_lock.release( lockhandle=>sbLockHandle);
            END if;
        EXCEPTION
            when others then
            ut_trace.Trace('Error inesperado'||sqlerrm, 2);
    END;

 /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : RefinanCuota
    Descripcion    : Procedimiento para procesar las refinanciaciones especiales
                     dividiendo el 50% en 2 financiaciones - Surtigas

    Parametros           Descripcion
    ============         ===================


    Fecha             Autor             Modificacion
    =========       =========           ====================
    18-12-2014      ggamarra           Creacion.
    ******************************************************************/

    PROCEDURE RefinanCuota IS

    sbLockHandle        varchar2(2000);
    nuRequestResult     number;
    sbTimeProc          varchar2(20);
    sbLog               varchar2(2000);
    sbFileManagement    utl_file.file_type;
    sbLineLog           varchar2(1000);
    dtLastFinan         date;

    nuSaldo1            number;
    nuSaldo2            number;
    rcDiferido          diferido%rowtype;
    rcPeriGracia        dacc_grace_peri_defe.stycc_grace_peri_defe;
    rcMovidife1         movidife%rowtype;
    rcMovidife2         movidife%rowtype;
    rcMovidifenull      movidife%rowtype;
    nuNumDiferido       number;
    sbUser              varchar2(2000);
    sbTerminal          varchar2(2000);

    nuQuotaValue        number;
    nuNominalPerc       number;
    nuRoundFactor       number;
    nuSaldo             number;
    nuRound             number;

    BEGIN

        sbTimeProc := TO_CHAR(SYSDATE, 'yyyymmdd_hh24miss');
          /* Arma nombre del archivo LOG */
        sbLog := 'REFESP_' || sbTimeProc || '.LOG';

          /* Crea archivo Log */
        sbFileManagement := pkUtlFileMgr.Fopen(sbPath, sbLog, 'w');
        sbLineLog := ' Inicio del proceso';
        pkUtlFileMgr.Put_Line(sbFileManagement, sbLineLog);


    -- Verifica que se encuentren configurados los parametros

        if nuPlanSingle IS null  then

            sbLineLog := '  El parametro '||csbPlandifeEsp||' no tiene un valor definido';
            pkUtlFileMgr.Put_Line(sbFileManagement, sbLineLog);
            raise ex.CONTROLLED_ERROR;
        END if;

        if nuPerGracia IS null then

            sbLineLog := '  El parametro '||csbGracePeriod||' no tiene un valor definido';
            pkUtlFileMgr.Put_Line(sbFileManagement, sbLineLog);
            raise ex.CONTROLLED_ERROR;
        END if;

        dtLastFinan := dald_parameter.fsbGetValue_Chain(csbProcDate);

        if  dtLastFinan IS null then

            dtLastFinan := sysdate - 1;

        END if;

        for i in  cuRefinanciaciones(nuPlanSingle,dtLastFinan) loop

        SELECT sum(difesape) INTO nuSaldo
        FROM diferido
        WHERE difecofi = i.financing_id;


            for j in cuDiferidos(i.financing_id) loop

                rcMovidife2 := rcMovidifenull;
                rcMovidife1 := rcMovidifenull;
                 -- Asigna a cada diferido el porcentaje para que sume el valor requerido inicial
                nuSaldo1 := round(gnuSaldo*j.difesape/nuSaldo) ;
                nuSaldo2 := j.difesape - nuSaldo1 ;

                 --Calcula el interes nominal
                pkDeferredMgr.ValInterestSpread(  j.difemeca,      -- Metodo de Calculo
                                                  j.difeinte,      -- Porcentaje de Interes (Efectivo Anual)
                                                  j.difespre,      -- Spread
                                                  nuNominalPerc             -- Interes Nominal (Salida)
                                                  );
                -- Recalcular cuota mensual
                pkDeferredMgr.CalculatePayment(  nuSaldo1,                       -- Saldo a Diferir (difesape)
                                                 j.difenucu,                       -- Numero de Cuotas  diferido
                                                 nuNominalPerc,                             -- Interes Nominal
                                                 j.difemeca,                       -- Metodo de Calculo
                                                 j.difespre,                       -- Spread
                                                 j.difeinte + j.difespre, -- Interes Efectivo mas Spread
                                                 nuQuotaValue                     -- Valor de la Cuota (Salida)
                                                 );

                --  Obtiene el factor de redondeo para la suscripcion
                FA_BOPoliticaRedondeo.ObtFactorRedondeo(j.difesusc, nuRoundFactor, 99);

                --  Aplica politica de redondeo al valor de la cuota
                nuQuotaValue := round( nuQuotaValue, nuRoundFactor );

                   -- Actualiza el diferido original
                UPDATE diferido SET difesape = nuSaldo1, difevacu = nuQuotaValue ,difevatd = nuSaldo1
                WHERE difecodi = j.difecodi;

                -- Crea el movimiento
                pkmovementdeferredmgr.fillmovementdefrecord(j.difecodi,nuSaldo2,-1,0,0,0,sysdate,'REFESPEC',rcMovidife1);
                rcMovidife1.modicuap := 0;
                pktblmovidife.insrecord(rcMovidife1);

                -- Crea el diferido nuevo

                rcDiferido := pktbldiferido.frcgetrecord(j.difecodi);

                    -- Obtiene usuario
    	        sbUser := pkGeneralServices.fsbGetUserName;
    	           -- Obtiene Terminal
    	        sbTerminal := pkGeneralServices.fsbGetTerminal;
    	           -- Obtiene numero de diferido
    	        pkDeferredMgr.GetNewDefNumber( nuNumDiferido );

                rcDiferido.difesape := nuSaldo2 ;
                rcDiferido.difevatd := nuSaldo2 ;
                rcDiferido.difevacu := nuSaldo2 ;
                rcDiferido.difenucu := 1 ;
                rcDiferido.difecodi := nuNumDiferido;
                rcDiferido.difefumo := sysdate;

                pktbldiferido.insrecord(rcDiferido);

                -- Inserta periodo de gracia
                rcPeriGracia.grace_peri_defe_id := pkgeneralservices.fnugetnextsequenceval('SEQ_CC_GRACE_PERI_D_185489');
                rcPeriGracia.grace_period_id  := nuPerGracia;
                rcPeriGracia.deferred_id      := nuNumDiferido;
                rcPeriGracia.initial_date     := rcDiferido.difefein;
                rcPeriGracia.end_date         := rcDiferido.difefein + j.difenucu*30 ;
                rcPeriGracia.program          := 700;
                rcPeriGracia.person_id        := -1 ;

                dacc_grace_peri_defe.insrecord(rcPeriGracia);

                -- Inserta movimiento en Movidife
                pkmovementdeferredmgr.fillmovementdefrecord(nuNumDiferido,rcDiferido.difesape,-1,0,0,0,sysdate,'REFESPEC',rcMovidife2);

                rcMovidife2.modicuap := 0;

                if  rcMovidife2.modisign = 'CR' then

                    rcMovidife2.modisign := 'DB';
                else
                    rcMovidife2.modisign := 'CR';
                END if;

                pktblmovidife.insrecord(rcMovidife2);


            END loop;

            sbLineLog := '  Contrato: '||i.subscription_id||' Financiacion: '||i.financing_id||' procesado con exito';
            pkUtlFileMgr.Put_Line(sbFileManagement, sbLineLog);

            -- Actualiza fecha de ultimo procesado
            UPDATE ld_parameter  SET ld_parameter.value_chain = to_char(i.attention_date,'dd/mm/yyyy hh24:mi:ss')
            WHERE  ld_parameter.parameter_id = csbProcDate ;

            -- Actualiza plan de diferido para evitar reproceso
            UPDATE cc_financing_request SET financing_plan_id = nuPlanNew WHERE financing_id = i.financing_id ;

            commit;

        END loop;

        sbLineLog := 'Proceso Terminado';
        pkUtlFileMgr.Put_Line(sbFileManagement, sbLineLog);

        pkUtlFileMgr.fClose(sbFileManagement);

        release_lock(sbLockHandle);

        EXCEPTION
            when ex.CONTROLLED_ERROR then
                rollback;
                pkUtlFileMgr.fClose(sbFileManagement);
                release_lock(sbLockHandle);
                raise ex.CONTROLLED_ERROR;
            when others then
                rollback;
                pkUtlFileMgr.fClose(sbFileManagement);
                release_lock(sbLockHandle);
                Errors.setError;
                raise ex.CONTROLLED_ERROR;

    END RefinanCuota;

 /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : RefinanMultiCuota
    Descripcion    : Procedimiento para procesar las refinanciaciones especiales
                     dividiendo en 2 diferidos - Gascaribe

    Parametros           Descripcion
    ============         ===================


    Fecha             Autor             Modificacion
    =========       =========           ====================
    18-12-2014      ggamarra           Creacion.
    ******************************************************************/

    PROCEDURE RefinanMultiCuota IS

     sbLockHandle        varchar2(2000);
    nuRequestResult     number;
    sbTimeProc          varchar2(20);
    sbLog               varchar2(2000);
    sbFileManagement    utl_file.file_type;
    sbLineLog           varchar2(1000);
    dtLastFinan         date;

    nuSaldo1            number;
    nuSaldo2            number;
    rcDiferido          diferido%rowtype;
    rcPeriGracia        dacc_grace_peri_defe.stycc_grace_peri_defe;
    rcMovidife1         movidife%rowtype;
    rcMovidife2         movidife%rowtype;
    rcMovidifenull      movidife%rowtype;
    nuNumDiferido       number;
    sbUser              varchar2(2000);
    sbTerminal          varchar2(2000);

    nuQuotaValue        number;
    nuNominalPerc       number;
    nuRoundFactor       number;

    BEGIN

        sbTimeProc := TO_CHAR(SYSDATE, 'yyyymmdd_hh24miss');
          /* Arma nombre del archivo LOG */
        sbLog := 'REFESP_' || sbTimeProc || '.LOG';

          /* Crea archivo Log */
        sbFileManagement := pkUtlFileMgr.Fopen(sbPath, sbLog, 'w');
        sbLineLog := ' Inicio del proceso';
        pkUtlFileMgr.Put_Line(sbFileManagement, sbLineLog);

    -- Verifica que se encuentren configurados los parametros

        if nuPlanSingle IS null  then

            sbLineLog := '  El parametro '||csbPlandifeEsp||' no tiene un valor definido';
            pkUtlFileMgr.Put_Line(sbFileManagement, sbLineLog);
            raise ex.CONTROLLED_ERROR;
        END if;

        if nuPerGracia IS null then

            sbLineLog := '  El parametro '||csbGracePeriod||' no tiene un valor definido';
            pkUtlFileMgr.Put_Line(sbFileManagement, sbLineLog);
            raise ex.CONTROLLED_ERROR;
        END if;

        dtLastFinan := dald_parameter.fsbGetValue_Chain(csbProcDate);

        if  dtLastFinan IS null then

            dtLastFinan := sysdate - 1;

        END if;

        for i in  cuRefinanciaciones(nuPlanSingle,dtLastFinan) loop

            for j in cuDiferidos(i.financing_id) loop

                rcMovidife2 := rcMovidifenull;
                rcMovidife1 := rcMovidifenull;

                nuSaldo1 := j.difesape/2 ;
                nuSaldo2 := nuSaldo1 ;

                if mod(nuSaldo1,1) <> 0 then

                    nuSaldo1 := nuSaldo1 + 0.5;
                    nuSaldo2 := nuSaldo2 - 0.5;

                END if;

                 --Calcula el interes nominal
                pkDeferredMgr.ValInterestSpread(  j.difemeca,      -- Metodo de Calculo
                                                  j.difeinte,      -- Porcentaje de Interes (Efectivo Anual)
                                                  j.difespre,      -- Spread
                                                  nuNominalPerc             -- Interes Nominal (Salida)
                                                  );
                -- Recalcular cuota mensual
                pkDeferredMgr.CalculatePayment(  nuSaldo1,                       -- Saldo a Diferir (difesape)
                                                 j.difenucu,                       -- Numero de Cuotas  diferido
                                                 nuNominalPerc,                             -- Interes Nominal
                                                 j.difemeca,                       -- Metodo de Calculo
                                                 j.difespre,                       -- Spread
                                                 j.difeinte + j.difespre, -- Interes Efectivo mas Spread
                                                 nuQuotaValue                     -- Valor de la Cuota (Salida)
                                                 );

                --  Obtiene el factor de redondeo para la suscripcion
                FA_BOPoliticaRedondeo.ObtFactorRedondeo(j.difesusc, nuRoundFactor, 99);

                --  Aplica politica de redondeo al valor de la cuota
                nuQuotaValue := round( nuQuotaValue, nuRoundFactor );

                   -- Actualiza el diferido original
                UPDATE diferido SET difesape = nuSaldo1, difevacu = nuQuotaValue ,difevatd = nuSaldo1
                WHERE difecodi = j.difecodi;

                -- Crea el movimiento
                pkmovementdeferredmgr.fillmovementdefrecord(j.difecodi,nuSaldo2,-1,0,0,0,sysdate,'REFESPEC',rcMovidife1);
                rcMovidife1.modicuap := 0;
                pktblmovidife.insrecord(rcMovidife1);

                -- Crea el diferido nuevo

                rcDiferido := pktbldiferido.frcgetrecord(j.difecodi);

                --Calcula el interes nominal
                pkDeferredMgr.ValInterestSpread(  rcDiferido.difemeca,      -- Metodo de Calculo
                                                  rcDiferido.difeinte,      -- Porcentaje de Interes (Efectivo Anual)
                                                  rcDiferido.difespre,      -- Spread
                                                  nuNominalPerc             -- Interes Nominal (Salida)
                                                  );
                -- Recalcular cuota mensual
                pkDeferredMgr.CalculatePayment(  nuSaldo2,                                  -- Saldo a Diferir (difesape)
                                                 rcDiferido.difenucu,                       -- Numero de Cuotas  diferido
                                                 nuNominalPerc,                             -- Interes Nominal
                                                 rcDiferido.difemeca,                       -- Metodo de Calculo
                                                 rcDiferido.difespre,                       -- Spread
                                                 rcDiferido.difeinte + rcDiferido.difespre, -- Interes Efectivo mas Spread
                                                 nuQuotaValue                               -- Valor de la Cuota (Salida)
                                                 );

                --  Obtiene el factor de redondeo para la suscripcion
                FA_BOPoliticaRedondeo.ObtFactorRedondeo(rcDiferido.difesusc, nuRoundFactor, 99);

                --  Aplica politica de redondeo al valor de la cuota
                nuQuotaValue := round( nuQuotaValue, nuRoundFactor );

                -- Asigna el valor de la cuota
                rcDiferido.difevacu := nuQuotaValue;

                    -- Obtiene usuario
    	        sbUser := pkGeneralServices.fsbGetUserName;
    	           -- Obtiene Terminal
    	        sbTerminal := pkGeneralServices.fsbGetTerminal;
    	           -- Obtiene numero de diferido
    	        pkDeferredMgr.GetNewDefNumber( nuNumDiferido );

                rcDiferido.difesape := nuSaldo2 ;
                rcDiferido.difevatd := nuSaldo2 ;
                rcDiferido.difecodi := nuNumDiferido;
                rcDiferido.difefumo := sysdate;

                pktbldiferido.insrecord(rcDiferido);

                -- Inserta periodo de gracia
                rcPeriGracia.grace_peri_defe_id := pkgeneralservices.fnugetnextsequenceval('SEQ_CC_GRACE_PERI_D_185489');
                rcPeriGracia.grace_period_id  := nuPerGracia;
                rcPeriGracia.deferred_id      := nuNumDiferido;
                rcPeriGracia.initial_date     := rcDiferido.difefein;
                rcPeriGracia.end_date         := rcDiferido.difefein + j.difenucu*30  ;
                rcPeriGracia.program          := 700;
                rcPeriGracia.person_id        := -1 ;

                dacc_grace_peri_defe.insrecord(rcPeriGracia);

                -- Inserta movimiento en Movidife
                pkmovementdeferredmgr.fillmovementdefrecord(nuNumDiferido,rcDiferido.difesape,-1,0,0,0,sysdate,'REFESPEC',rcMovidife2);

                rcMovidife2.modicuap := 0;

                if  rcMovidife2.modisign = 'CR' then

                    rcMovidife2.modisign := 'DB';
                else
                    rcMovidife2.modisign := 'CR';
                END if;

                pktblmovidife.insrecord(rcMovidife2);


            END loop;                      -- cc_financing_request.subscription_id

            sbLineLog := '  Contrato: '||i.subscription_id||' Financiacion: '||i.financing_id||' procesado con exito';
            pkUtlFileMgr.Put_Line(sbFileManagement, sbLineLog);

            -- Actualiza fecha de ultimo reproceso
            UPDATE ld_parameter  SET ld_parameter.value_chain = to_char(i.attention_date,'dd/mm/yyyy hh24:mi:ss')
            WHERE  ld_parameter.parameter_id = csbProcDate ;

            -- Actualiza plan de diferido para evitar reproceso
            UPDATE cc_financing_request SET financing_plan_id = nuPlanNew WHERE financing_id = i.financing_id ;

            commit;

        END loop;

        sbLineLog := 'Proceso Terminado';
        pkUtlFileMgr.Put_Line(sbFileManagement, sbLineLog);

        pkUtlFileMgr.fClose(sbFileManagement);

        release_lock(sbLockHandle);

        EXCEPTION
            when ex.CONTROLLED_ERROR then
                rollback;
                pkUtlFileMgr.fClose(sbFileManagement);
                release_lock(sbLockHandle);
                raise ex.CONTROLLED_ERROR;
            when others then
                rollback;
                pkUtlFileMgr.fClose(sbFileManagement);
                release_lock(sbLockHandle);
                Errors.setError;
                raise ex.CONTROLLED_ERROR;

    END RefinanMultiCuota ;

END LDC_BSSREFINANESPECIAL;
/

