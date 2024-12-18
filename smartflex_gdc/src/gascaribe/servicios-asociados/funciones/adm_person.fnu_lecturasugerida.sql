CREATE OR REPLACE FUNCTION adm_person.fnu_lecturasugerida 
(
    inuProductId          IN pr_product.product_id%TYPE,
    idtEjecDate           IN DATE,
    isbTipoLect           IN VARCHAR2,
    idtFechaUltLect       IN DATE,
    inuperiactual         IN NUMBER,
    inuano                IN NUMBER,
    inumes                IN NUMBER,
    inuUltiLect           IN NUMBER,
    inuPeriConsact        IN NUMBER,
    inuDiasConsActu       IN NUMBER,
    inuCicloCons          IN servsusc.sesucico%TYPE
) 
RETURN NUMBER IS

/*****************************************************************
    Propiedad intelectual de GDC.

    Unidad         : fnu_lecturasugerida
    Descripcion    : funcion que retorna la lectura de retiro sugerida
    Autor          : Luis Felipe Valencia Hurtado
    Ticket         : OSF-625     
    Fecha          : 12/01/2023
    
    Datos de Entrada
      inuProductId          Producto
      idtEjecDate           Fecha de Ejecución
      isbTipoLect           Tipo de Lectura
      idtFechaUltLect       Fecha de Última Lectura
      inuperiactual         Periodo Actual
      inuano                Año
      inumes                Mes
      inuUltiLect           Última Lectura
      inuPeriConsact        Periodo de Consumo Actual
      inuDiasConsActu       Días de Consumo de Periodo Actual
      inuCicloCons          Ciclo de Consumo

    Historia de Modificaciones
    Fecha                Autor              Modificacion
    =========            =========          ====================
    16/08/2023          felipe.valencia     Modificación por error en consumo liquidado
	27/06/2024			jsoto				OSF-2846  Se reemplaza uso de LDC_PKFAAC.fnuGetPericoseAnt por fnuobtperconsante
  ******************************************************************/
    --Constantes
    -- Para el control de traza:
    csbSP_NAME  CONSTANT VARCHAR2(100) := $$PLSQL_UNIT||'.';
    csbPUSH     CONSTANT VARCHAR2(50) := 'Inicia ';
    csbPOP      CONSTANT VARCHAR2(50) := 'Finaliza ';
    csbPOP_ERC  CONSTANT VARCHAR2(50) := '*Finaliza con error controlado ';
    csbPOP_ERR  CONSTANT VARCHAR2(50) := '*Finaliza con error ';
    csbLDC      CONSTANT VARCHAR2(50) := '[LDC]';
    -- Nivel de traza BO.
    cnuLEVELPUSHPOP             CONSTANT NUMBER := 1;
    cnuLEVEL                    CONSTANT NUMBER := 9;
    cnuGenericError             CONSTANT NUMBER := 2741;

    nuAcumCons      NUMBER := 0;

    nuCantDias      NUMBER;
    nuCont          NUMBER := 0;
    dtFechUltLec    DATE;
    nuProrrateo     NUMBER;
    nuDiasCons      NUMBER;
    nuConsumoActual NUMBER;
    nuConsPromedio  NUMBER;
    nuSugerLect     NUMBER;
    nuConsEsti      NUMBER;
    nuNumDias       NUMBER;
    nuExisteConsumo NUMBER;
    nuano           NUMBER;
    numes           NUMBER;

    CURSOR cuGeinfoprodu 
    IS
    SELECT p.category_id,p.subcategory_id,d.geograp_location_id
    FROM pr_product p, ab_address d
    WHERE p.address_id = d.address_id
    AND p.product_id = inuProductId;

    regInfoprodu  cuGeinfoprodu%rowtype;

    CURSOR cuConsumoCate
    ( 
      inuCate NUMBER,
      inusuca NUMBER,
      inuLoca NUMBER,
      inuano  NUMBER,
      inuMes  NUMBER
    ) 
    IS
    SELECT (cpsccoto/cpscprod)
    FROM LDC_COPRSUCA
    WHERE CPSCCATE = inuCate
    AND  CPSCSUCA = inusuca
    AND  CPSCUBGE = inuLoca
    AND  CPSCANCO = inuano
    AND  CPSCMECO =  inuMes;

    CURSOR cuConsumos
    (
      inuPericose     in conssesu.cosspecs%TYPE
    )
    IS
    SELECT SUM(COSSCOCA) COSSCOCA, MIN(COSSDICO) COSSDICO
    FROM (    
        SELECT  conssesu.*,
                MIN (DECODE (cossmecc, 4, cossflli, NULL))
                    OVER (PARTITION BY cosspecs, cosstcon, cosssesu)
                    calcflli
        FROM    conssesu 
        WHERE   cosssesu = inuProductId
        AND     cosspecs = inuPericose
        AND     trunc(cossfere) != trunc(sysdate)
        AND     cossfere between idtFechaUltLect AND idtEjecDate
        AND     idtEjecDate >=  (  SELECT prejfech
                        FROM procejec 
                        WHERE prejcope = cosspefa 
                        AND  prejprog = 'FGCC' )
    )
    WHERE   cossmecc != 4
    AND     calcflli = 'S';
    
    CURSOR cuUltimoConsumoPeriActual
    (
      inuPericose     in conssesu.cosspecs%TYPE
    )
    IS
    SELECT *
    FROM (    
        SELECT  conssesu.*,
                MIN (DECODE (cossmecc, 4, cossflli, NULL))
                    OVER (PARTITION BY cosspecs, cosstcon, cosssesu)
                    calcflli
        FROM    conssesu 
        WHERE   cosssesu = inuProductId
        AND     cosspecs = inuPericose
        AND     trunc(cossfere) != trunc(sysdate)
        AND     idtEjecDate >=  (  SELECT prejfech
                FROM procejec 
                WHERE prejcope = cosspefa 
                AND  prejprog = 'FGCC' )
    )
    WHERE   cossmecc != 4
    AND     cossfere = (
                            SELECT  MAX(c3.cossfere) 
                            FROM    conssesu c3 
                            WHERE   c3.cosssesu=inuProductId 
                            AND     c3.cosspecs = inuPericose
                           );
                           
    rcUltimoConsumo cuUltimoConsumoPeriActual%ROWTYPE;
    
    CURSOR cuDiasConsumos
    (
      inuPericose     in conssesu.cosspecs%TYPE
    )
    IS
    SELECT  COSSDICO
    FROM  conssesu
    WHERE COSSMECC = 4
    AND  cosssesu = inuProductId
    AND  cosspecs = inuPericose;

    CURSOR cuConsumosProm
    (
      inuPericose     in conssesu.cosspecs%TYPE
    )
    IS
    SELECT HCPPCOPR
    FROM  HICOPRPM
    WHERE HCPPSESU = inuProductId
    AND  HCPPPECO = inuPericose
    AND HCPPTICO = 1;

    CURSOR cuUltimLecTom
    IS
    SELECT  leemfele
    FROM    lectelme
    WHERE   leemsesu = inuProductId
    and leemfele is not null
    and leemfele < TRUNC(idtEjecDate)
    ORDER BY leemfele DESC;

    CURSOR cuPeriodosCons
    (
      idtFechaIni     IN DATE,
      idtFechaFin     IN DATE,
      inuCicloCons    IN NUMBER
    )
    IS
    SELECT  pecscons, pefaano, pefames
    FROM    pericose, perifact
    WHERE  pecsfeci < idtFechaIni
    AND  pecsfeci >= idtFechaFin
    AND  pecscico = inuCicloCons
    AND  pecscico = pefacicl
    AND  pefafimo BETWEEN pecsfeci AND pecsfecf
    ORDER BY pecsfeci DESC;
    
    CURSOR cuOrdenCritica
    (
        inuProducto IN pr_product.product_id%TYPE,
        inuPericose     in conssesu.cosspecs%TYPE
    )
    IS
    select  cm_ordecrit.* 
    from    cm_ordecrit, or_order 
    where   order_id = orcrorde
    and     orcrsesu =  inuProducto
    and     orcrpeco = 103803
    and     order_status_id != 8; 

    CURSOR cuObtieneMesAño
    (
        inupericose number
    )
    IS
    SELECT  pefaano, 
            pefames
    FROM    PERICOSE pe, perifact p
    WHERE   pe.pecscico = p.pefacicl
    AND     pe.pecscons = inupericose
    AND     pe.PECSFECF BETWEEN p.pefafimo AND p.pefaffmo;

    rcCritica cuOrdenCritica%ROWTYPE;

    sbMethodName    VARCHAR2(50) := 'ldc_fnuGetLecturaSuger';

    FUNCTION fnugetConsumoPromedio
    (
        inuProducto       in  pr_product.product_id%TYPE,
        inuPeriodoCosnumo           in NUMBER
    )
    RETURN NUMBER
    IS
        PRAGMA AUTONOMOUS_TRANSACTION;
        CURSOR cuConsumosProm
        (
            inuProductId    in HICOPRPM.HCPPSESU%TYPE,
            inuPericose     in conssesu.cosspecs%TYPE
        )
        IS
            SELECT HCPPCOPR
            FROM  HICOPRPM
            WHERE HCPPSESU = inuProductId
            AND  HCPPPECO = inuPericose
            AND HCPPTICO = 1;
            
        nuConsumoPromedio   NUMBER;
        sbMethodName        VARCHAR2(50) := 'ldc_fnuGetLecturaSuger';
    BEGIN
        ut_trace.trace(csbLDC||csbSP_NAME||csbPUSH||sbMethodName,cnuLEVELPUSHPOP);

        IF cuConsumosProm%ISOPEN THEN
            CLOSE cuConsumosProm;
        END IF;

        OPEN cuConsumosProm(inuProducto,inuPeriodoCosnumo);
        FETCH cuConsumosProm INTO nuConsumoPromedio;
        CLOSE cuConsumosProm;
        ut_trace.trace(csbLDC||csbSP_NAME||csbPUSH||sbMethodName,cnuLEVELPUSHPOP);
        RETURN nuConsumoPromedio;
    EXCEPTION
        when Pkg_Error.CONTROLLED_ERROR then
            ut_trace.trace(csbLDC||csbSP_NAME||csbPUSH||sbMethodName,cnuLEVELPUSHPOP);
            raise Pkg_Error.CONTROLLED_ERROR;
        when OTHERS then
            Pkg_Error.SetError;
            ut_trace.trace(csbLDC||csbSP_NAME||csbPUSH||sbMethodName,cnuLEVELPUSHPOP);
            raise Pkg_Error.CONTROLLED_ERROR;
    END fnugetConsumoPromedio;
BEGIN
    ut_trace.trace(csbLDC||csbSP_NAME||csbPUSH||sbMethodName,cnuLEVELPUSHPOP);
    ut_trace.trace('--inuProductId: '||inuProductId,cnuLEVEL);
    ut_trace.trace('--idtEjecDate: '||idtEjecDate,cnuLEVEL);
    ut_trace.trace('--isbTipoLect: '||isbTipoLect,cnuLEVEL);

    IF cuGeinfoprodu%ISOPEN THEN
        CLOSE cuGeinfoprodu;
    END IF;

    OPEN cuGeinfoprodu;
    FETCH cuGeinfoprodu INTO regInfoprodu;
    CLOSE cuGeinfoprodu;

    IF isbTipoLect = 'P' THEN
        FOR rcPeriodo IN cuPeriodosCons(idtEjecDate, idtFechaUltLect, inuCicloCons) LOOP               
            IF inuPeriConsact = rcPeriodo.pecscons THEN
                nuConsumoActual := 	NVL(nuConsEsti, 0);
            ELSE

                IF cuConsumosProm%ISOPEN THEN
                    CLOSE cuConsumosProm;
                END IF;

                OPEN cuConsumosProm(rcPeriodo.pecscons);
                FETCH cuConsumosProm INTO nuConsEsti;
                CLOSE cuConsumosProm;
                
                ut_trace.trace('nuConsEsti  - periodo '||nuConsEsti||' - '||rcPeriodo.pecscons,cnuLEVEL);
                
                IF nuConsEsti IS NULL THEN

                    IF cuConsumoCate%ISOPEN THEN
                        CLOSE cuConsumoCate;
                    END IF;

                    OPEN cuConsumoCate
                    ( 
                      regInfoprodu.category_id,
                      regInfoprodu.subcategory_id,
                      regInfoprodu.geograp_location_id,
                      rcPeriodo.pefaano,
                      rcPeriodo.pefames
                    );
                    FETCH cuConsumoCate INTO nuConsEsti;
                    CLOSE cuConsumoCate;
            
                    ut_trace.trace('--ingreso por categoria nuConsEsti  -  '||nuConsEsti,cnuLEVEL);
            
                    IF NVL(nuConsEsti,0) > 0 THEN

                        IF cuDiasConsumos%ISOPEN THEN
                            CLOSE cuDiasConsumos;
                        END IF;

                        OPEN cuDiasConsumos(rcPeriodo.pecscons);
                        FETCH cuDiasConsumos INTO nuDiasCons;
                        CLOSE cuDiasConsumos;

                        nuConsEsti := NVL(nuConsEsti,0) * nuDiasCons;
                    ELSE
                        nuConsEsti := NVL(nuConsEsti,0);
                    END IF;
                END IF;   
                ut_trace.trace('--ingreso  - nuConsumoActual '||nuConsumoActual,10);
    
                nuAcumCons := nuAcumCons + NVL(nuConsEsti, 0);
            END IF;
        END LOOP;
    ELSE
        FOR rcPeriodo IN cuPeriodosCons(idtEjecDate, idtFechaUltLect, inuCicloCons) LOOP
            ut_trace.trace('--rcPeriodo.pecscons '||rcPeriodo.pecscons,cnuLEVEL);
            ut_trace.trace('idtEjecDate '||idtEjecDate,cnuLEVEL);
            ut_trace.trace('idtFechaUltLect '||idtFechaUltLect,cnuLEVEL);
            ut_trace.trace('inuCicloCons '||inuCicloCons,cnuLEVEL);
            
            IF inuPeriConsact = rcPeriodo.pecscons THEN
                ut_trace.trace('--Entro a periodo de actual '||rcPeriodo.pecscons,cnuLEVEL);
                --Obtiene el último consumo del periodo actual

                IF cuUltimoConsumoPeriActual%ISOPEN THEN
                    CLOSE cuUltimoConsumoPeriActual;
                END IF;

                OPEN cuUltimoConsumoPeriActual(rcPeriodo.pecscons);
                FETCH cuUltimoConsumoPeriActual INTO rcUltimoConsumo;
                CLOSE cuUltimoConsumoPeriActual; 
                
                IF (rcUltimoConsumo.cossmecc = 1) THEN
                    ut_trace.trace('--rcUltimoConsumo.cossmecc 1 ',cnuLEVEL);

                    IF cuOrdenCritica%ISOPEN THEN
                        CLOSE cuOrdenCritica;
                    END IF;

                    OPEN cuOrdenCritica(inuProductId, rcPeriodo.pecscons);
                    FETCH cuOrdenCritica INTO rcCritica;
                    CLOSE cuOrdenCritica;
                    
                    IF (rcUltimoConsumo.calcflli = 'S' AND rcCritica.orcrorde IS NULL) THEN
                        nuConsumoActual := rcUltimoConsumo.COSSCOCA;
                    ELSE
                        nuConsumoActual := NULL;
                    END IF;

                    nuAcumCons := nuAcumCons + NVL(nuConsumoActual, 0);

                ELSE
                    ut_trace.trace('--rcUltimoConsumo.cossmecc 4 ',cnuLEVEL);

                    IF cuConsumos%ISOPEN THEN
                        CLOSE cuConsumos;
                    END IF;

                    OPEN cuConsumos(rcPeriodo.pecscons);
                    FETCH cuConsumos INTO nuConsEsti, nuDiasCons;
                    CLOSE cuConsumos; 

                    ut_trace.trace('-- nuConsEsti aca '||nuConsEsti,cnuLEVEL);
                    nuAcumCons := nuAcumCons + NVL(nuConsEsti, 0);
                END IF;
            ELSE

                IF cuConsumos%ISOPEN THEN
                    CLOSE cuConsumos;
                END IF;

                OPEN cuConsumos(rcPeriodo.pecscons);
                FETCH cuConsumos INTO nuConsEsti, nuDiasCons;
                CLOSE cuConsumos; 

                ut_trace.trace('-- nuConsEsti aca '||nuConsEsti,cnuLEVEL);
                nuAcumCons := nuAcumCons + NVL(nuConsEsti, 0);
            END IF;
            ut_trace.trace('--nuConsumoActual '||nuConsumoActual,cnuLEVEL);     
        END LOOP;
    
        ut_trace.trace('--nuAcumCons '||nuAcumCons,cnuLEVEL);

        --IF nuConsumoActual IS NULL THEN
            ut_trace.trace('--nuConsumoActual nulo',cnuLEVEL);
			
			nuConsPromedio := fnugetConsumoPromedio(inuProductId,fnuobtperconsante(inuProductId,inuPeriConsact));
            
            ut_trace.trace('--nuConsPromedio : '||nuConsPromedio,cnuLEVEL);
            ut_trace.trace('--fnuobtperconsante(inuProductId,inuPeriConsact) : '||fnuobtperconsante(inuProductId,inuPeriConsact),cnuLEVEL);
                
            IF  NVL(nuConsPromedio,0)  <= 0 THEN

                IF cuObtieneMesAño%ISOPEN THEN
                    CLOSE cuObtieneMesAño;
                END IF;

                OPEN cuObtieneMesAño (fnuobtperconsante(inuProductId,inuPeriConsact));
                FETCH cuObtieneMesAño INTO nuano, numes;
                CLOSE cuObtieneMesAño;

                nuConsEsti := null;

                IF cuConsumoCate%ISOPEN THEN
                    CLOSE cuConsumoCate;
                END IF;

                OPEN cuConsumoCate
                (
                  regInfoprodu.category_id,
                  regInfoprodu.subcategory_id,
                  regInfoprodu.geograp_location_id,
                  nuano,
                  numes
                );
                FETCH cuConsumoCate INTO nuConsEsti;
                CLOSE cuConsumoCate;
                
                ut_trace.trace('--regInfoprodu.category_id : '||regInfoprodu.category_id,cnuLEVEL);
                ut_trace.trace('--regInfoprodu.subcategory_id : '||regInfoprodu.subcategory_id,cnuLEVEL);
                ut_trace.trace('--regInfoprodu.geograp_location_id : '||regInfoprodu.geograp_location_id,cnuLEVEL);
                ut_trace.trace('--inuano : '||inuano,cnuLEVEL);
                ut_trace.trace('--iumes : '||inumes,cnuLEVEL);
                ut_trace.trace('--nuano : '||nuano,cnuLEVEL);
                ut_trace.trace('--numes : '||numes,cnuLEVEL);
                ut_trace.trace('--nuConsEsti : '||nuConsEsti,cnuLEVEL);
                
                
                nuConsPromedio := NVL(nuConsEsti,0); --* inuDiasConsActu;

                IF NVL(nuConsEsti,0) > 0 THEN

                    IF cuDiasConsumos%ISOPEN THEN
                        CLOSE cuDiasConsumos;
                    END IF;
                
                    OPEN cuDiasConsumos(inuPeriConsact);
                    FETCH cuDiasConsumos INTO nuDiasCons;
                    CLOSE cuDiasConsumos;

                    --nuConsPromedio := NVL(nuConsEsti,0) * nuDiasCons;
                ELSE
                    nuConsEsti := null;

                    IF cuConsumos%ISOPEN THEN
                        CLOSE cuConsumos;
                    END IF;

                    OPEN cuConsumos(fnuobtperconsante(inuProductId,inuPeriConsact));
                    FETCH cuConsumos INTO nuConsEsti, nuDiasCons;
                    CLOSE cuConsumos; 
                    nuConsPromedio := NVL(nuConsEsti,0);
                END IF;
            END IF;

            --nuConsumoActual := NVL(nuConsEsti, 0);
        --END IF;
    END IF;
    
    ut_trace.trace('--nuAcumCons '||nuAcumCons,cnuLEVEL);

    IF cuUltimLecTom%ISOPEN THEN
        CLOSE cuUltimLecTom;
    END IF;
    -- Se obtiene la ultima lectura tomada
    OPEN cuUltimLecTom;
    FETCH cuUltimLecTom INTO dtFechUltLec;
    CLOSE cuUltimLecTom;

    nuNumDias := idtEjecDate - dtFechUltLec;
    ut_trace.trace('--nuConsPromedio '||nuConsPromedio,cnuLEVEL);

    nuProrrateo := ROUND( (nuConsPromedio / inuDiasConsActu)  * nuNumDias, 0 );
    ut_trace.trace('--nuProrrateo  - nuNumDias - dtFechUltLec - inuDiasConsActu '||nuProrrateo||' - '||nuNumDias||' - '||dtFechUltLec||' - '||inuDiasConsActu,cnuLEVEL);

    nuSugerLect := ROUND(NVL(inuUltiLect,0) + NVL(nuAcumCons,0) + NVL(nuProrrateo,0) , 0);

    ut_trace.trace(csbLDC||csbSP_NAME||csbPUSH||sbMethodName,cnuLEVELPUSHPOP);
    RETURN nuSugerLect;
EXCEPTION
    WHEN Pkg_Error.CONTROLLED_ERROR THEN
        ut_trace.trace(csbLDC||csbSP_NAME||csbPUSH||sbMethodName,cnuLEVELPUSHPOP);
        RAISE Pkg_Error.CONTROLLED_ERROR;
    WHEN OTHERS THEN
        ut_trace.trace(csbLDC||csbSP_NAME||csbPUSH||sbMethodName,cnuLEVELPUSHPOP);
        Pkg_Error.SetError;
        RAISE Pkg_Error.CONTROLLED_ERROR;
END fnu_lecturasugerida;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('FNU_LECTURASUGERIDA', 'ADM_PERSON'); 
END;
/