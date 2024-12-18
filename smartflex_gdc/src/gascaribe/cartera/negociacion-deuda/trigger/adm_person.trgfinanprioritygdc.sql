create or replace TRIGGER ADM_PERSON.TrgFinanPriorityGDC BEFORE INSERT ON cc_financing_request
/*******************************************************************************
    Propiedad intelectual de CSC

    Trigger 	: TrgFinanPriorityGDC

    Descripcion	: Trigger verificar que el plan de negociación de deuda elegido
                  sea el más prioritario o el correcto para elegir según config.

    Autor	   : Eduardo Cerón
    Fecha	   : 09/12/2018

    Historia de Modificaciones
    Fecha	      ID Entrega     Modificacion
    09Jul2019   Cambio 39      Se modifica para que si el producto ha tenido alguna vez refinanciacion de los planes incluidos en
                               PLAN_FINAN_UNA_VEZ o PLAN_FINAN_MARCA y se escoja un plan diferente, busque el plan de mayor prioridad,
                               ya que actualmente la logica hace que no entre a validar esto.
                               
                               Ademas se incluyen los parametros ACTI_REST_PL_MAY_PRI_NEG_CAT_1 y ACTI_REST_PL_MAY_PRI_NEG_CAT_2
                               para activar o desactivar la validacion del plan con mayor prioridad
                               
                               Adicionalmente, se incluye el cruce con la tabla MO_PACKAGES en los cursores que buscan si el producto
                               ha tenido refinanciaciones de los planes incluidos en los parametros PLAN_FINAN_UNA_VEZ o PLAN_FINAN_MARCA
                               para validar que no se tengan en cuenta solicitudes anuladas
                               
   07/04/2021  Cambio 712      Se modifica cursor cuInfoProduct  para que busque la información de categoría, subcategoria, estado decorte, 
                               financiero y nro de cuentas con saldo a la fecha y no al cierre.  
   08/11/2021   Cambio 874     se valida que las negociaciones de plan prende la llama no se ejecuten despues de cierta hora
   23/02/2022	Cambio 877     Se corrige error del cursor cuDataFecha, el cual se cierra doble.
									
	07-02-2023 	 cgonzalez		OSF-784: Se modifica servicio RAISE_APPLICATION_ERROR por GE_BOERRORS.SETERRORCODEARGUMENT
	14-02-2023 	 cgonzalez		OSF-899: Se modifican consultas para hacer uso de expresion regular al consultar informacion de los parametros
*******************************************************************************/
FOR EACH ROW
DECLARE

    --pragma autonomous_transaction;
    nuSpecialPlans NUMBER;

    sbFinanUnaVez   ld_parameter.value_chain%type := open.dald_parameter.fsbGetValue_Chain('PLAN_FINAN_UNA_VEZ');
    sbFinanMarca    ld_parameter.value_chain%type := open.dald_parameter.fsbGetValue_Chain('PLAN_FINAN_MARCA');
    sbFinanRepesca  ld_parameter.value_chain%type := open.dald_parameter.fsbGetValue_Chain('PLAN_FINAN_REPESCA');
    
    sbActivRestPlCat1  ld_parameter.value_chain%type := open.dald_parameter.fsbGetValue_Chain('ACTI_REST_PL_MAY_PRI_NEG_CAT_1');
    sbActivRestPlCat2  ld_parameter.value_chain%type := open.dald_parameter.fsbGetValue_Chain('ACTI_REST_PL_MAY_PRI_NEG_CAT_2');
    --
    dtfechainicial      DATE;
    dtfechafinal        DATE;
    sbMensaje           varchar2(2000)  := open.dald_parameter.fsbGetValue_Chain('MENSAJE_VALIDACION_GCNED');
    --
    sbEntrega200497     varchar2(21) := 'CRM_SAC_CAR_200497_8';
    --
   nuEntrega200497     varchar2(21) := '200497';
    cantidad_ref_ultimos_12_meses    NUMBER(8);
    --

    cursor cuGetFinanPlan1
    is
        SELECT  count(1)
        FROM    open.cc_financing_request c, open.mo_packages p
        WHERE   c.package_id = p.package_id
        AND     subscription_id = :new.subscription_id
        AND     p.motive_status_id != 32
        AND     financing_plan_id in ((SELECT TO_NUMBER(regexp_substr(sbFinanUnaVez,'[^|,]+', 1, level))
										FROM DUAL A
										CONNECT BY regexp_substr(sbFinanUnaVez, '[^|,]+', 1, level) IS NOT NULL))
        AND     rownum = 1;

    cursor cuGetFinanPlan11
    is
        SELECT  count(1)
        FROM    open.cc_financing_request c, open.mo_packages p
        WHERE   c.package_id = p.package_id
        AND     subscription_id = :new.subscription_id
        AND     p.motive_status_id != 32
        AND     financing_plan_id in ((SELECT TO_NUMBER(regexp_substr(sbFinanMarca,'[^|,]+', 1, level))
										FROM DUAL A
										CONNECT BY regexp_substr(sbFinanMarca, '[^|,]+', 1, level) IS NOT NULL))
        AND     rownum = 1;

    --- cursor para obtener la dirección
    cursor cuGetAddress
    is
        SELECT  susciddi
        FROM    open.suscripc
        WHERE   susccodi = :new.subscription_id;

    cursor cuGetRepesca
    is
        SELECT  count(1)
        FROM    open.plandife
        WHERE   nvl(pldifefi,sysdate)>trunc(sysdate)
        AND     pldicodi in ((SELECT TO_NUMBER(regexp_substr(sbFinanRepesca,'[^|,]+', 1, level))
										FROM DUAL A
										CONNECT BY regexp_substr(sbFinanRepesca, '[^|,]+', 1, level) IS NOT NULL));

    -- consulta fecha habil
    cursor cuDataFecha(inuProduct   number)
    is
        select cicoano, cicomes
        from (select cicoano, cicomes
              from ldc_ciercome
              where cicoesta = 'S'
              and exists (select 1
                          from ldc_osf_sesucier
                          where producto = inuProduct
                          and nuano = cicoano
                          and numes = cicomes)
              order by cicofein desc
              )
        where rownum < 2;


    -- cursor informacion producto
    cursor cuInfoProduct
    (
        inuAno          number,
        inuMes          number,
        inuProducto     number
    )
    IS
        /*SELECT  ldc_osf_sesucier.producto
                ,ldc_osf_sesucier.localidad
                ,ldc_osf_sesucier.segmento_predio
                ,(SELECT d.address_id FROM pr_product d WHERE d.product_id = ldc_osf_sesucier.producto) direccion
                ,ldc_osf_sesucier.categoria
                ,ldc_osf_sesucier.subcategoria
                ,ldc_osf_sesucier.estado_corte
                ,(SELECT d.commercial_plan_id FROM pr_product d WHERE d.product_id = ldc_osf_sesucier.producto) plan_comercial
                ,ldc_osf_sesucier.nro_ctas_con_saldo
                ,ldc_osf_sesucier.estado_financiero
                ,ldc_osf_sesucier.ultimo_plan_fina
        FROM open.ldc_osf_sesucier
        WHERE producto = inuProducto
        AND nuano = inuAno
        AND numes = inuMes;*/
        -- SE CAMBIA QUERY POR CAMBIO 712
        SELECT  ldc_osf_sesucier.producto
                ,ldc_osf_sesucier.localidad
                ,ldc_osf_sesucier.segmento_predio
                ,(SELECT d.address_id FROM pr_product d WHERE d.product_id = ldc_osf_sesucier.producto) direccion
                ,sesucate categoria
                ,sesusuca subcategoria
                ,sesuesco estado_corte
                ,(SELECT d.commercial_plan_id FROM pr_product d WHERE d.product_id = ldc_osf_sesucier.producto) plan_comercial
                ,(select count(1) from cuencobr where cuconuse=producto and cucosacu-cucovare-cucovrap > 0) nro_ctas_con_saldo
                ,sesuesfn estado_financiero
                ,ldc_osf_sesucier.ultimo_plan_fina
        FROM open.ldc_osf_sesucier, servsusc
        WHERE producto=sesunuse
        AND producto = inuProducto
        AND nuano = inuAno
        AND numes = inuMes; 
        
    -- consulta ultima entrega del caso 200497
    cursor cuEntrega is
      Select t.nombre_entrega
        From Ldc_Versionentrega t
       where t.Codigo  = (select max(t.codigo)
        from Ldc_Versionentrega t, Ldc_Versionempresa e, Ldc_Versionaplica a, Sistema s
       Where t.Codigo = a.Codigo_Entrega
         And e.Codigo = a.Codigo_Empresa
         And e.Nit = s.Sistnitc
         And t.Nombre_Entrega like '%'||nuEntrega200497||'%');

    rcProducto      cuInfoProduct%rowtype;
    
    sbPlanExcepcion   VARCHAR2(4000) := open.dald_parameter.fsbGetValue_Chain('SPECIALS_PLAN', NULL);
	
	CURSOR cuPlanExcepcion(inuPlan IN NUMBER) IS
		SELECT	count(1)
		FROM 	(SELECT TO_NUMBER(regexp_substr(sbPlanExcepcion,'[^|,]+', 1, level)) as plan_id
				FROM DUAL A
				CONNECT BY regexp_substr(sbPlanExcepcion, '[^|,]+', 1, level) IS NOT NULL)
		WHERE 	plan_id = inuPlan;
	
	nuExistePlan NUMBER;

    nuQuantity1  number;
    nuQuantity11 number;

    nuAddress_id    number;

    --- información geopolítica
    rcgeopoliticalfeature   cc_bcsegmentconstants.tyrcgeopoliticalfeature;

    --- cursor referenciado
    rfDataCursor constants.tyrefcursor;

    --- registro para guardar los datos
    type tyrcDataRecord is record (
        FINANCING_PLAN_ID       plandife.pldicodi%type,
        FINANCING_PLAN_DESC     plandife.pldidesc%type,
        RANGE_PERCENT_TO_FINAN  plandife.pldidoso%type,
        DEFAULT_INTEREST_PERC   plandife.pldipoin%type,
        INTEREST_RATE           tasainte.taindesc%type,
        FIN_COMPUTE_METH        mecadife.mcdidesc%type,
        GRADIENT_FACTOR         plandife.pldifagr%type,
        RANGE_QUOTAS_NUMBER     plandife.pldidoso%type,
        RANGE_SPREAD            plandife.pldidoso%type,
        WARRANTY_GENERATE       plandife.pldigeco%type,
        MAX_EXTRA_PAYMENTS      plandife.pldicema%type,
        SUPPORT_DOCUMENT        plandife.pldidoso%type,
        DUEDATE_ACC_COUNT_TR    plandife.pldicuve%type,
        DUEDATE_ACC_COUNT_SUSP  plandife.pldincvs%type,
        TIMES_TO_REFINANCE      plandife.pldinvre%type,
        CREATION_DATE           plandife.pldifecr%type,
        INITIAL_DATE_APPLY      plandife.pldifein%type,
        END_DATE_APPLY          plandife.pldifefi%type
    );

    type tytbDataTable is table of tyrcDataRecord index by binary_integer;

    tbDataTable     tytbDataTable;

    nuIndex         number;

    /*cursor cuGetPriority
    (
        inuFinancingPlan in cc_com_seg_finan.financing_plan_id%type
    )
    is
        SELECT  priority
        FROM    open.cc_com_seg_finan
        WHERE   financing_plan_id = inuFinancingPlan
        AND     offer_class = 3
        AND     financing_plan_id <> nuFinanUnaVez; -- negociación */

    nuPriority      number := 99;
    nuPriorityTMP   number := 99;
    nuFinanPlan     number;
    nuFinanPlanTMP  number;
    nuCountRepes    number;
    nuProduct_id    number;
    nuAno           number;
    nuMes           number;
	
	--INICIO CA 874
	
	nuHoraVali NUMBER := DALD_PARAMETER.FNUGETNUMERIC_VALUE('LDC_HORAVAEJE', NULL);
	dtFechaUltDia  DATE;
	sbDatos VARCHAR2(1);
  dtFechaPrimero DATE;
  
  
	CURSOR cuIsPlanEncllama IS
	SELECT 'X'
	FROM LDC_CONFPLCAES
	WHERE COPCORIG = :NEW.FINANCING_PLAN_ID;
	--FIN CA 874

    function fnuValida
    (
        inuValor    number,
        isbCadena   varchar2
    )
    return number
    is
        nuCant  number;

        cursor cuValida
        is
            select count(1)
            from dual
            where inuValor in ((SELECT TO_NUMBER(regexp_substr(isbCadena,'[^|,]+', 1, level)) as plan_id
										FROM DUAL A
										CONNECT BY regexp_substr(isbCadena, '[^|,]+', 1, level) IS NOT NULL));
    begin

        open cuValida;
        fetch cuValida into nuCant;
        close cuValida;

        if (nucant > 0) then
            return 1;
        else
            return 0;
        end if;

    end fnuValida;


BEGIN

    ut_trace.Trace('Inicio: TrgFinanPriorityGDC', 15);
    --- busca la ultima entrega del caso 200497 y valida si aplica
    open cuEntrega;
    fetch cuEntrega into sbEntrega200497;
    if cuEntrega%notfound then
      sbEntrega200497 := nuEntrega200497;
    end if;
    close cuEntrega;
    
    --- valida si aplica
    if fblaplicaentrega(sbEntrega200497) then
        begin
            GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE ('WORK_INSTANCE',null,'PR_PRODUCT','PRODUCT_ID',nuProduct_id);

        exception
            when others then
                --nuProduct_id    := null;
                return;
        end;

        if(:new.record_program = 'GCNED') then

            
			--INICIO CA 874
			IF FBLAPLICAENTREGAXCASO('0000874') THEN			  
			  dtFechaUltDia :=  to_date(to_char(LAST_DAY(sysdate),'dd/mm/yyyy')||' '||nuHoraVali,'dd/mm/yyyy hh24');
			  dtFechaPrimero := TO_DATE('01/'||TO_CHAR(SYSDATE, 'MM/YYYY')||' '||nuHoraVali,'DD/MM/YYYY HH24' );
			  
			  IF dtFechaUltDia <  SYSDATE   OR  SYSDATE < dtFechaPrimero THEN
				 
            OPEN cuIsPlanEncllama;
            FETCH cuIsPlanEncllama INTO sbDatos;			  
            CLOSE cuIsPlanEncllama;
            
            IF sbDatos IS NOT NULL THEN
               GE_BOERRORS.SETERRORCODEARGUMENT(-20101, 'No se puede registrar la negociacion de deuda con un plan prende la llama porque se esta ejecutando el cierre financiero');
            END IF;			  
         END IF;
			END IF;
      --FIN CA 874
			
			open  cuGetFinanPlan1;
            fetch cuGetFinanPlan1 into nuQuantity1;
            close cuGetFinanPlan1;

            -- si ha tenido el plan 1 y se seleccionó uno diferente a 11 entonces no deja avanzar
            if (nuQuantity1 = 1 and fnuValida(:new.financing_plan_id,sbFinanMarca) = 0) then -- parametrizar
                GE_BOERRORS.SETERRORCODEARGUMENT(-20101, 'El contrato ['||:new.subscription_id||'] ya ha tenido una financiación con el plan(es) ['||sbFinanUnaVez||'], solo puede usar el plan(es) ['||sbFinanMarca||']');
                ROLLBACK;
            end if;

            open  cuGetFinanPlan11;
            fetch cuGetFinanPlan11 into nuQuantity11;
            close cuGetFinanPlan11;

            -- si es el plan 11 y se seleccionó uno diferente a 11 entonces no deja avanzar
            if (nuQuantity11 = 1 and fnuValida(:new.financing_plan_id,sbFinanMarca) = 0) then -- parametrizar
                GE_BOERRORS.SETERRORCODEARGUMENT(-20101, 'El contrato ['||:new.subscription_id||'] ya tiene una financiación con el plan(es) ['||sbFinanMarca||'], solo puede usar el plan(es) ['||sbFinanMarca||']');
                ROLLBACK;
            end if;

            -------------------------------------------Cambio del trigger EFIGAS(2257)--------------------------

            ut_trace.Trace('Cursor para verificar que el contrato con el plan se encuentren en la tabla LDC_SPECIALS_PLAN');
           
			OPEN cuPlanExcepcion(:new.FINANCING_PLAN_ID);
			FETCH cuPlanExcepcion INTO nuExistePlan;
			CLOSE cuPlanExcepcion;

			IF (nuExistePlan > 0) THEN
              select count(1)
              into nuSpecialPlans
              from LDC_SPECIALS_PLAN
              where SUBSCRIPTION_ID = :new.subscription_id
              AND PLAN_ID = :NEW.FINANCING_PLAN_ID
              AND SYSDATE BETWEEN INIT_DATE AND END_DATE;
  
  
              IF nuSpecialPlans = 0 THEN
  
                  ut_trace.Trace('El contrato '||:new.subscription_id||' no se cuentra registrado con el plan '||:NEW.FINANCING_PLAN_ID||' como plan excepcional en la tabla LDC_SPECIALS_PLAN o fecha actual no se encuentra dentro de las fechas de inicio y fin', 10);
                  dbms_output.put_line('El contrato '||:new.subscription_id||' no se cuentra registrado con el plan '||:NEW.FINANCING_PLAN_ID||' como plan excepcional en la tabla LDC_SPECIALS_PLAN o fecha actual no se encuentra dentro de las fechas de inicio y fin');
                  GE_BOERRORS.SETERRORCODEARGUMENT(-20101, 'El contrato '||:new.subscription_id||' no se cuentra registrado con el plan '||:NEW.FINANCING_PLAN_ID||' como plan excepcional en la tabla LDC_SPECIALS_PLAN o fecha actual no se encuentra dentro de las fechas de inicio y fin');
  
              END IF;
            
            END IF;

            ----------------------------------------------------------------------------
            -- se hace la lógica para obtener el plan de financiación prioritario
            -- sólo se hace si no tiene ni 1 ni 11 y a nivel de producto
            ----------------------------------------------------------------------------
            /*if (nuQuantity11 = 1 or nuQuantity1 = 1) then
                null;
            else*/ -- se comentaria por Cambio 39

                dtfechainicial  := to_date(to_char(add_months(SYSDATE,-12),'dd/mm/yyyy')||' 00:00:00','dd/mm/yyyy hh24:mi:ss');
                dtfechafinal    := to_date(to_char(SYSDATE,'dd/mm/yyyy')||' 23:59:59','dd/mm/yyyy hh24:mi:ss');

                -- consultar año y mes
                open cuDataFecha(nuProduct_id);
                fetch cuDataFecha into nuAno, nuMes;
                if (cuDataFecha%notfound) then
                    nuAno   := null;
                    nuMes   := null;
                    ---close cuDataFecha; --cambio 877
                end if;
                close cuDataFecha;

                ut_trace.Trace('TrgFinanPriorityGDC => nuAno: '||nuAno||' - nuMes: '||nuMes, 15);

                -- consultar informacion del producto
                open cuInfoProduct(nuAno,nuMes,nuProduct_id);
                fetch cuInfoProduct into rcProducto;
                close cuInfoProduct;


                -- consultar la financiaion
                SELECT COUNT(DISTINCT(d.difecodi))
                INTO cantidad_ref_ultimos_12_meses
                FROM open.diferido d
                WHERE d.difenuse = nuProduct_id
                  AND d.difefein BETWEEN  dtfechainicial AND dtfechafinal
                  AND d.difeprog = 'GCNED';

                ut_trace.Trace('TrgFinanPriorityGDC => cantidad_ref_ultimos_12_meses: '||cantidad_ref_ultimos_12_meses, 15);


                if (rcProducto.producto is null) then
                    return;
                end if;

                --- consultar el plan con mayor prioridad
                nuFinanPlan := ldc_planfinmayprior(rcProducto.producto
                                                          ,rcProducto.localidad
                                                          ,rcProducto.segmento_predio
                                                          ,rcProducto.direccion
                                                          ,rcProducto.categoria
                                                          ,rcProducto.subcategoria
                                                          ,rcProducto.estado_corte
                                                          ,rcProducto.plan_comercial
                                                          ,cantidad_ref_ultimos_12_meses
                                                          ,rcProducto.nro_ctas_con_saldo
                                                          ,rcProducto.estado_financiero
                                                          ,rcProducto.ultimo_plan_fina
                                                         );

                ut_trace.Trace('TrgFinanPriorityGDC => FinanPlan_Ingresado: '||:new.financing_plan_id, 15);
                ut_trace.Trace('TrgFinanPriorityGDC => nuFinanPlan: '||nuFinanPlan, 15);

                if (:new.financing_plan_id = nvl(nuFinanPlan,:new.financing_plan_id) or fnuValida(:new.financing_plan_id,sbFinanUnaVez) = 1 or fnuValida(:new.financing_plan_id,sbFinanRepesca) = 1 ) then
                    null;
                else
                  --- MODIFICACION PARA QUE RESTRINJA POR CATEGORIAS DEPENDIENDO DE LOS PARAMETROS CONFIGURADOS ---
                  if (rcProducto.Categoria  = 1 and sbActivRestPlCat1 = 'N') OR
                     (rcProducto.Categoria != 1 and sbActivRestPlCat2 = 'N') THEN
                    NULL;
                  else
                  --- FIN MODIFICACION PARA QUE RESTRINJA POR CATEGORIAS DEPENDIENDO DE LOS PARAMETROS CONFIGURADOS ---
                    open  cuGetRepesca;
                    fetch cuGetRepesca into nuCountRepes;
                    close cuGetRepesca;

                    ut_trace.Trace('TrgFinanPriorityGDC => nuCountRepes: '||nuCountRepes, 15);

                    if(nuCountRepes = 1) then -- si está activo el plan repesca

                        if (nuFinanPlan is not null) then

                            sbMensaje   := sbMensaje||' ['||nuFinanPlan||'- '||
                                           pktblplandife.fsbgetdescription(nuFinanPlan)||']. ';
                        end if;

                        GE_BOERRORS.SETERRORCODEARGUMENT(-20101,sbMensaje);
                        ROLLBACK;
                    end if;

                    if (nuFinanPlan is not null) then

                        sbMensaje   := sbMensaje||' ['||nuFinanPlan||'- '||
                                       pktblplandife.fsbgetdescription(nuFinanPlan)||']. ';
                    end if;

                    GE_BOERRORS.SETERRORCODEARGUMENT(-20101,sbMensaje);
                    ROLLBACK;
                end if;
              end if;

          --  end if;

        end if;
    end if;
    ut_trace.Trace('Fin: TrgFinanPriorityGDC', 15);

EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
          RAISE EX.CONTROLLED_ERROR;
    WHEN others THEN
          errors.seterror;
          RAISE EX.CONTROLLED_ERROR;
END TrgFinanPriorityGDC;
/