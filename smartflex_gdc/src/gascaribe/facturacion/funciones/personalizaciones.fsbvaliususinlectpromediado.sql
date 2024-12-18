CREATE OR REPLACE FUNCTION personalizaciones.fsbValiUsuSinLectPromediado(inuContrato IN NUMBER) RETURN  VARCHAR2 IS
/*****************************************************************
    Propiedad intelectual de Gases del Caribe

    Unidad         : fsbValiUsuSinLectPromediado
    Descripcion    : Funcion encargada de validar si productos de contrato tuvieron consumo promedio a raíz de ajustes a reglas 
                     de lectura y relectura realizados bajo el caso OSF-2190 
    Autor          :
    Fecha          :

    Parámetros              Descripcion
    ============            ===================
    inuContrato             Número del contrato a validar
    
    Fecha           Autor               Modificación
    =========       =========           ====================
	23-01-2024      jcatuchemvm         OSF-2231: Creación
******************************************************************/
    -- Constantes para el control de la traza
    csbMetodo           CONSTANT VARCHAR2(32)       := $$PLSQL_UNIT;                -- Constante para nombre de función    
    csbNivelTraza       CONSTANT NUMBER(2)          := pkg_traza.cnuNivelTrzDef;    -- Nivel de traza para esta función. 
    csbInicio           CONSTANT VARCHAR2(4)        := pkg_traza.fsbINICIO;         -- Indica inicio de método
    csbFin              CONSTANT VARCHAR2(4)        := pkg_traza.fsbFIN;            -- Indica Fin de método ok
    csbFin_Erc          CONSTANT VARCHAR2(4)        := pkg_traza.fsbFIN_ERC;        -- Indica fin de método con error controlado
    csbFin_Err          CONSTANT VARCHAR2(4)        := pkg_traza.fsbFIN_ERR;        -- Indica fin de método con error no controlado
    
    cnuFechaRelease     CONSTANT DATE := TO_DATE('24/01/2024 21:27','DD/MM/YYYY HH24:MI');
    cnuPeriodos         CONSTANT NUMBER             := 6; --limite de búsqueda de periodos
    
    --Variables generales
    sberror             VARCHAR2(4000);
    nuerror             NUMBER;
    sbValida            VARCHAR2(1);
    nuparam_perid_cero  NUMBER := dald_parameter.fnugetnumeric_value('PER_CERO_VAL_SUSP_CAST');
    
    cursor cuValida(inucont in number) IS
    select unique contrato,
    nvl((select 'S' from servsusc where sesususc = contrato and sesunuse = producto and sesuesfn = 'C'),'N') sesuesfn,
    first_value(producto) over (order by pericons) producto,
    first_value(periodo) over (order by pericons) periodo,
    first_value(pericons) over (order by pericons) pericons,
    first_value(regla) over (order by pericons) regla,
    first_value(observacion) over (order by pericons) observacion,
    first_value(usuario) over (order by pericons) usuario,
    first_value(fecha) over (order by pericons) fecha
    from COSLPROM
    where contrato =  inucont;
    
    
    rcValida        cuValida%rowtype;
    
    CURSOR cuObtieneConsumos(inuProducto in number, inuPeriCons in number) IS
    select d.*,pecscons,pecsfeci,pecsfecf,
    nvl(
    (
        select 'S' from pr_prod_suspension
        where product_id = cosssesu
        and 
        (
            (pecsfeci <= aplication_date and nvl(inactive_date,sysdate) <= pecsfecf) or
            (aplication_date <= pecsfeci  and pecsfecf <= nvl(inactive_date,sysdate)) or
            (pecsfeci <= nvl(inactive_date,sysdate) and nvl(inactive_date,sysdate) <= pecsfecf) or
            (pecsfeci <= aplication_date  and aplication_date <= pecsfecf)
        )
        and rownum = 1
    ),'N') suspendido 
    from
    (
        SELECT cosssesu,cosspecs,SUM(NVL(cosscoca,0)) cosssuma
        FROM conssesu,pericose
        WHERE cosspecs = pecscons
        AND cosssesu = inuProducto
        AND cossflli = 'S'
        AND pecsfeci <=
        NVL
        (
            (
                SELECT /*+ PUSH_SUBQ */
                pecsfeci-1
                FROM pericose
                WHERE pecscons = inuPeriCons
            ), 
            pecsfeci
        )
        GROUP BY cosssesu,cosspecs
        ORDER BY cosspecs DESC
    ) d,pericose 
    where pecscons = cosspecs
    and rownum <= cnuPeriodos;
    
    nupecocerocons      number := 0;
    sbSuspendido        varchar2(1);
    
BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_traza.trace('inuContrato <= '||inuContrato, csbNivelTraza);

        if inuContrato is null then
            sbValida := 'N';
        else
            if cuValida%isopen then
                close cuValida;
            end if;
            
            rcValida := null;
            open cuValida(inuContrato);
            fetch cuValida into rcValida;
            close cuValida;
            
            if inuContrato is null then
                pkg_traza.trace('Contrato nulo', csbNivelTraza);
                sbValida := 'N';
            elsif rcValida.contrato is null then
                pkg_traza.trace('Contrato no facturado con las nuevas reglas', csbNivelTraza);
                sbValida := 'N';
            elsif rcValida.sesuesfn = 'S' then
                pkg_traza.trace('Producto '||rcValida.producto||' castigado', csbNivelTraza);
                sbValida := 'N';
            else
                --Valida consumos cero anteriores
                if cuObtieneConsumos%ISOPEN then
                    close cuObtieneConsumos;
                end if;
                
                sbSuspendido := 'N';
                pkg_traza.trace('Producto: '||rcValida.producto||', periodo de consumo: '||rcValida.pericons,csbNivelTraza);
                for rc in cuObtieneConsumos(rcValida.producto,rcValida.pericons) loop
                    if rc.cosssuma <= 0 then
                        nupecocerocons := nupecocerocons + 1;
                        pkg_traza.trace('Periodo['||nupecocerocons||']: ' || rc.cosspecs || ' sin consumo: ' ||rc.cosssuma||'. Suspendido: '||rc.suspendido, csbNivelTraza);
                        if nupecocerocons = 1 and rc.suspendido = 'S' then
                            sbSuspendido := 'S';
                            exit;
                        end if;
                    else
                        pkg_traza.trace('Periodo['||nupecocerocons||']: ' || rc.cosspecs || ' con consumo: ' ||rc.cosssuma, csbNivelTraza);
                        exit;
                    end if;
                end loop;
                
                pkg_traza.trace('Consecutivo de periodos con consumo cero: '||nupecocerocons, csbNivelTraza);
                
                if (nupecocerocons >= nuparam_perid_cero) or (sbSuspendido = 'S') then
                    sbValida := 'S';
                else
                    sbValida := 'N';
                end if;
            end if;
            
        end if;
        
            
        pkg_traza.trace('return => '||sbValida, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
        return sbValida;
        
    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            sbValida := 'N';
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pkg_traza.trace('return => '||sbValida, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
            return sbValida;
        WHEN OTHERS THEN
            sbValida := 'N';
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pkg_traza.trace('return => '||sbValida, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
            return sbValida;
END fsbValiUsuSinLectPromediado;
/
begin
    pkg_utilidades.prAplicarPermisos('FSBVALIUSUSINLECTPROMEDIADO','PERSONALIZACIONES');
end;
/