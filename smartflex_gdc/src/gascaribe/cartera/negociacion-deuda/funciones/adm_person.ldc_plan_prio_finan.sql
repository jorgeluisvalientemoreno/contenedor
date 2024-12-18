CREATE OR REPLACE FUNCTION ADM_PERSON.LDC_PLAN_PRIO_FINAN (inuProductId NUMBER) RETURN NUMBER AS
/*****************************************************************
    Propiedad intelectual de Gases del Caribe

    Unidad         : LDC_PLAN_PRIO_FINAN
    Descripcion    : Obtiene el plan de financiación prioritario para negociaciónes de deuda desde movilidad
    Autor          :
    Fecha          :

    Parámetros              Descripcion
    ============            ===================
    inuProducto             Número del producto 
    financingPlanId         Plan de financiación prioritario
    
    Fecha           Autor               Modificación
    =========       =========           ====================
	18-06-2024      jcatuche            OSF-2851: Se agrega ordenamiento al cursor cuSpecialPlan para que se retorna la configuración más reciente
	xx-xx-xxxx      xxxxxx              Creación
******************************************************************/
    -- Constantes para el control de la traza
    csbMetodo           CONSTANT VARCHAR2(32)       := $$PLSQL_UNIT;                -- Constante para nombre de función    
    csbNivelTraza       CONSTANT NUMBER(2)          := pkg_traza.cnuNivelTrzDef;    -- Nivel de traza para esta función. 
    csbInicio           CONSTANT VARCHAR2(4)        := pkg_traza.fsbINICIO;         -- Indica inicio de método
    csbFin              CONSTANT VARCHAR2(4)        := pkg_traza.fsbFIN;            -- Indica Fin de método ok
    csbFin_Erc          CONSTANT VARCHAR2(4)        := pkg_traza.fsbFIN_ERC;        -- Indica fin de método con error controlado
    csbFin_Err          CONSTANT VARCHAR2(4)        := pkg_traza.fsbFIN_ERR;        -- Indica fin de método con error no controlado
    
    financingPlanId                 NUMBER;
    dtfechainicial                  DATE;
    dtfechafinal                    DATE;
    cantidad_ref_ultimos_12_meses   NUMBER(8);
    nuAno                           number;
    nuMes                           number;
    exerror                         Exception; -- Error controlado

    sberror                         VARCHAR2(4000);
    nuerror                         NUMBER;

    cursor cuSpecialPlan(inuProduct number)
      is
      select plan_id
      from LDC_SPECIALS_PLAN
      where product_id = inuProduct
      and trunc(sysdate) between init_date and end_date
      order by specials_plan_id desc
    ;

    cursor cuDataFecha(inuProduct number)
        is
        select cicoano, cicomes
        from (select cicoano, cicomes
              from ldc_ciercome
              where cicoesta = 'S'
                and exists(select 1
                           from ldc_osf_sesucier
                           where producto = inuProduct
                             and nuano = cicoano
                             and numes = cicomes)
              order by cicofein desc
             )
        where rownum < 2;

    cursor cuInfoProduct
                      (
        inuAno number,
        inuMes number,
        inuProducto number
        )
        IS
        SELECT ldc_osf_sesucier.producto
             , ldc_osf_sesucier.localidad
             , ldc_osf_sesucier.segmento_predio
             , (SELECT d.address_id FROM pr_product d WHERE d.product_id = ldc_osf_sesucier.producto) direccion
             , sesucate                                                                                    categoria
             , sesusuca                                                                                    subcategoria
             , sesuesco                                                                                    estado_corte
             , (SELECT d.commercial_plan_id
                FROM pr_product d
                WHERE d.product_id = ldc_osf_sesucier.producto)                                            plan_comercial
             , (select count(1)
                from cuencobr
                where cuconuse = producto and cucosacu - cucovare - cucovrap > 0)                          nro_ctas_con_saldo
             , sesuesfn                                                                                    estado_financiero
             , ldc_osf_sesucier.ultimo_plan_fina
        FROM ldc_osf_sesucier,
             servsusc
        WHERE producto = sesunuse
          AND producto = inuProducto
          AND nuano = inuAno
          AND numes = inuMes;

    rcProducto                    cuInfoProduct%rowtype;
    
    cursor cudiferidos is
    SELECT COUNT(DISTINCT(d.difecofi))
    FROM diferido d
    WHERE d.difenuse = inuProductId
    AND d.difefein BETWEEN dtfechainicial AND dtfechafinal
    AND d.difeprog = 'GCNED';
    
BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
    pkg_traza.trace('inuProductId <= '||inuProductId, csbNivelTraza);
    
    --Cierre de cursores
    if cuSpecialPlan%isopen then
        close cuSpecialPlan;
    end if;
    
    if cuDataFecha%isopen then
        close cuDataFecha;
    end if;
    
    if cuInfoProduct%isopen then
        close cuInfoProduct;
    end if;
    
    if cudiferidos%isopen then
        close cudiferidos;
    end if;
        
    dtfechainicial := to_date(to_char(add_months(SYSDATE, -12), 'dd/mm/yyyy') || ' 00:00:00', 'dd/mm/yyyy hh24:mi:ss');
    dtfechafinal := to_date(to_char(SYSDATE, 'dd/mm/yyyy') || ' 23:59:59', 'dd/mm/yyyy hh24:mi:ss');

    financingPlanId :=  null;
    open cuSpecialPlan(inuProductId);
    fetch cuSpecialPlan into financingPlanId;
    close cuSpecialPlan;
    
    -- Si el usuario está configurado para un plan especial vigente, ese será el de mayor prioridad
    if financingPlanId is null then

        -- consultar año y mes
        open cuDataFecha(inuProductId);
        fetch cuDataFecha into nuAno, nuMes;

        if (cuDataFecha%notfound) then
            nuAno := null;
            nuMes := null;
            close cuDataFecha;
        end if;

        close cuDataFecha;

        -- consultar informacion del producto
        open cuInfoProduct(nuAno, nuMes, inuProductId);
        fetch cuInfoProduct into rcProducto;
        close cuInfoProduct;

        -- consultar la financiacion
        cantidad_ref_ultimos_12_meses := null;
        open cudiferidos;
        fetch cudiferidos into cantidad_ref_ultimos_12_meses;
        close cudiferidos;
        
        financingPlanId := LDC_PLANFINMAYPRIOR
        (
            rcProducto.producto, 
            rcProducto.localidad, 
            rcProducto.segmento_predio, 
            rcProducto.direccion, 
            rcProducto.categoria, 
            rcProducto.subcategoria, 
            rcProducto.estado_corte, 
            rcProducto.plan_comercial, 
            cantidad_ref_ultimos_12_meses, 
            rcProducto.nro_ctas_con_saldo, 
            rcProducto.estado_financiero, 
            rcProducto.ultimo_plan_fina
        );

        if NVL(financingPlanId, -2) = -2 then
          nuError := -2;
          sbError := 'No se encontró un plan para este producto';
          RAISE exerror;
        end if;

        if financingPlanId = -1 then
          nuError := -3;
          sbError := 'Ocurrió un error en la búsqueda del plan';
          RAISE exerror;
        end if;
    end if;
    
    pkg_traza.trace('return => '||financingPlanId, csbNivelTraza);
    pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);        
    RETURN financingPlanId;
    
EXCEPTION
    WHEN pkg_Error.Controlled_Error  THEN
        financingPlanId  := NULL;
        pkg_Error.getError(nuError, sbError);
        pkg_traza.trace('nuError: ' || nuError, csbNivelTraza);
        pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
        pkg_traza.trace('return => '||financingPlanId, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
        RETURN financingPlanId;
    WHEN exerror THEN
        financingPlanId  := NULL;
        pkg_traza.trace('nuError: ' || nuError, csbNivelTraza);
        pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
        pkg_traza.trace('return => '||financingPlanId, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
        RETURN financingPlanId;
    WHEN OTHERS THEN
        financingPlanId  := NULL;
        pkg_Error.setError;
        pkg_Error.getError(nuError, sbError);
        pkg_traza.trace('nuError: ' || nuError, csbNivelTraza);
        pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
        pkg_traza.trace('return => '||financingPlanId, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
        RETURN financingPlanId;
END;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_PLAN_PRIO_FINAN', 'ADM_PERSON');
END;
/