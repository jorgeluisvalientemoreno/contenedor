CREATE OR REPLACE FUNCTION ADM_PERSON.LDC_FNUGETINIQUOTA(inuFinanPlan IN  plandIFe.pldicodi%TYPE,
                                                         isbLevel     IN  VARCHAR2,
                                                         inuSuscripc  IN  suscripc.susccodi%TYPE,
                                                         inuProductId IN  servsusc.sesunuse%TYPE )
RETURN NUMBER IS
  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : LDC_FnuGetIniQuota
  Descripcion    : Trae el valor de la cuota inicial de la configuracion establecida por las LDCs

  Autor          : Emiro Leyva
  Fecha          : 20/11/2013

  Parametros                      Descripcion
  ============                 ===================

  Fecha             Autor             ModIFicacion
  =========       =========           ====================
  20-11-2013      Emiro Leyva         Creacion.
  20-10-2014      acardenas.NC3218    Se modIFica para incluir como criterio de la politica
                                      el nivel de suspension del producto.
                                      Esto solo aplica para la suspension por mora y voluntaria cuando
                                      la negociacion se hace a nivel de "Producto".
                                      Se modIFica para aplicar la politica de redondeo por
                                      contrato al valor de la cuota inicial calculada.
  10-12-2014      acardenas.NC4265    Se modIFica para consultar correctamente los rangos de deuda
                                      dependiendo del tipo de cartera.
  01-12-2014      ncarrasquilla       CA200764. Se modIFica para consultar correctamente los rangos de deuda
                                      dependiendo del tipo de cartera.
  25-02-2019      F.Castro            Se modIFica para la cuota inicial de los usuarios categoria 3 en adelante
                                      sea el total del consumo (CA-200-2430)
  15/02/2023      Adrianavg           OSF-2181: Migrar del esquema OPEN al esquema ADM_PERSON
                                      Se retira esquema OPEN antepuesto a ldc_osf_sesucier
                                      Se reemplaza SELECT-INTO por Cursor cuCateEdoFinancXProd,cuCateEdoFinancXSuscripc, cuPorcencuoXProd,cuPorcencuoXSuscripc,cuCiAnoMes,cuValorCastigado
                                      Se retira fblaplicaentrega(sbEntrega) y variable sbEntrega varchar2(30):='OSS_OL_0000308_1' y queda
                                      la invocacion al FINANPRIORITYGDC. 
                                      Se retiran la variables csbEntrega200764   CONSTANT VARCHAR2(100) := 'BSS_CAR_NCZ_200764_1'; csbEntrega2002430
                                      Se retira código comentariado
                                      Se reemplaza dapr_product.fnugetsuspen_ord_act_id por pkg_bcproducto.fnuidactivordensusp
                                      Se reemplaza daor_order_activity.fnugetactivity_id por pkg_bcordenes.fnuobtieneitemactividad
                                      Se declaran variables para la gestión de trazas, se hace uso del pkg_traza.trace
                                      Se ajusta el bloque de exceptiones según pautas técnicas
   27/02/2024     jcatuchemvm         OSF-2395: Se eliminan lógica que no aplican de acuerdo a los Aplicaentrega eliminados [OSS_OL_0000308_1 y BSS_CAR_NCZ_200764_1]
  ******************************************************************/
    --Se declaran variables para la gestión de trazas
    csbMetodo            CONSTANT VARCHAR2(32)       := $$PLSQL_UNIT;
    csbNivelTraza        CONSTANT NUMBER(2)          := pkg_traza.cnuNivelTrzDef; 
    csbInicio   	     CONSTANT VARCHAR2(35) 	     := pkg_traza.csbINICIO;   
    Onuerrorcode         NUMBER:= pkg_error.CNUGENERIC_MESSAGE;	
    Osberrormessage      VARCHAR2(2000);
    
    rcLDC_PLANDIFE       LDC_PLANDIFE%ROWTYPE;

    -- CURSOR de parametrizacion con nivel de suspension
    CURSOR  cuLDC_PLANDIFE1 (   inuPLDICODI    LDC_PLANDIFE.PLDICODI%TYPE,
                                inuNivelSusp   LDC_PLANDIFE.nivel_susp%TYPE,
                                inuValorTotal  NUMBER,
                                inuCorrTotal   NUMBER,
                                inuCorrVencido NUMBER
                            )
    IS
    SELECT *
      FROM LDC_PLANDIFE
     WHERE LDC_PLANDIFE.PLDICODI = inuPLDICODI
       AND CASE WHEN tipo_cartera = 'TO' THEN  inuValorTotal
           ELSE (CASE WHEN tipo_cartera = 'CT' THEN  inuCorrTotal
                 ELSE inuCorrVencido
                 END
                )
           END BETWEEN RANG_SALDO_INI AND RANG_SALDO_FIN
       AND inuNivelSusp = NIVEL_SUSP;

    -- CURSOR de parametrizacion por rango de deuda
    CURSOR  cuLDC_PLANDIFE2 (   inuPLDICODI    LDC_PLANDIFE.PLDICODI%TYPE,
                                inuValorTotal  NUMBER,
                                inuCorrTotal   NUMBER,
                                inuCorrVencido NUMBER
                            )
    IS
    SELECT *
      FROM LDC_PLANDIFE
     WHERE LDC_PLANDIFE.PLDICODI = inuPLDICODI
       AND CASE WHEN tipo_cartera = 'TO' THEN  inuValorTotal
           ELSE (CASE WHEN tipo_cartera = 'CT' THEN  inuCorrTotal
                 ELSE inuCorrVencido
                 END
                 )
            END BETWEEN RANG_SALDO_INI AND RANG_SALDO_FIN
       AND NIVEL_SUSP IS NULL;

    nuTotCartera    dIFerido.DIFEVATD%TYPE;
    nuCorrTotal     dIFerido.DIFEVATD%TYPE;
    nuCorrVencida   dIFerido.DIFEVATD%TYPE;
    nuDIFerida      dIFerido.DIFEVATD%TYPE;
    nuLastSuspen    pr_product.suspen_ord_act_id%TYPE;
    nuReturn        NUMBER;
    sbActivityId    VARCHAR2(2000);
    SbActividadesCM ld_parameter.value_chain%TYPE;
    SbActividadesAC ld_parameter.value_chain%TYPE;
    nuNivelSusp     NUMBER;
    nuRoundFactor   NUMBER;

    /*Variables CA 200-764*/
    nuCategoria        servsusc.sesucate%TYPE;
    nuprocprod         ldc_usucuoinind.porc_cuotaini%TYPE;
    nuporcent          ldc_plandIFe.porc_cuota%TYPE;
    sbestafina         servsusc.sesuesfn%TYPE;
    nuvaano            NUMBER(4);
    nuvames            NUMBER(2);
    nuvalorcastigado   ldc_osf_sesucier.valor_castigado%TYPE;
    
    CURSOR cuCateEdoFinancXProd
    IS
    SELECT sesucate,sesuesfn 
      FROM servsusc s
     WHERE s.sesunuse = inuProductId;
     
    CURSOR cuCateEdoFinancXSuscripc
    IS
    SELECT sesucate,sesuesfn
      FROM servsusc s
     WHERE s.sesususc = inuSuscripc
       AND ROWNUM = 1;    
     
    CURSOR cuPorcencuoXProd
    IS
    SELECT porcencuo 
      FROM( SELECT z.porc_cuotaini porcencuo
            FROM ldc_usucuoinind z
            WHERE z.producto = inuProductId
              AND z.fecha_vencimiento >= SYSDATE
         ORDER BY z.fecha_vencimiento DESC
        )
    WHERE ROWNUM = 1;

    CURSOR cuPorcencuoXSuscripc
    IS
    SELECT porcencuo
    FROM(
         SELECT z.porc_cuotaini porcencuo
           FROM ldc_usucuoinind z
          WHERE z.contrato = inuSuscripc
            AND z.fecha_vencimiento >= SYSDATE
       ORDER BY z.fecha_vencimiento DESC
        )
    WHERE ROWNUM = 1;
    
    CURSOR cuCiAnoMes
    IS
    SELECT cicoano,cicomes
      FROM( SELECT cv.cicoano,cv.cicomes
              FROM ldc_ciercome cv
             WHERE cv.cicoesta = 'S'
          ORDER BY cv.cicofech DESC
          )
    WHERE ROWNUM = 1;
    
    CURSOR cuValorCastigado(p_nuvaano ldc_osf_sesucier.nuano%TYPE,
                            p_nuvames ldc_osf_sesucier.numes%TYPE)
    IS
    SELECT df.valor_castigado
      FROM ldc_osf_sesucier df
     WHERE df.nuano    = nuvaano
       AND df.numes    = nuvames
       AND df.producto = inuproductid;    
 
BEGIN

    pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
    pkg_error.prInicializaError(onuerrorcode, osberrormessage);
    pkg_traza.trace(csbMetodo ||' inuFinanPlan: ' || inuFinanPlan, csbNivelTraza);
    pkg_traza.trace(csbMetodo ||' isbLevel:     ' || isbLevel, csbNivelTraza);
    pkg_traza.trace(csbMetodo ||' inuSuscripc:  ' || inuSuscripc, csbNivelTraza);
    pkg_traza.trace(csbMetodo ||' inuProductId: ' || inuProductId, csbNivelTraza);     
                                                         
    
    --Inicio CA 200-764
    IF isbLevel = 'P' THEN
        pkg_traza.trace(csbMetodo ||' --> Busca Categoria y EdoFinanciero xProducto: ', csbNivelTraza);
        
        BEGIN
            OPEN cuCateEdoFinancXProd;
            FETCH cuCateEdoFinancXProd INTO nuCategoria,sbestafina;
            CLOSE cuCateEdoFinancXProd;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                nuCategoria := NULL;
                sbestafina := NULL;
        END;              
        nuprocprod := NULL;
        
        BEGIN
            OPEN cuPorcencuoXProd;
            FETCH cuPorcencuoXProd INTO nuprocprod;
            CLOSE cuPorcencuoXProd;        
        EXCEPTION
        WHEN NO_DATA_FOUND THEN
             nuprocprod := NULL;
        END;
        pkg_traza.trace(csbMetodo ||' --> FIN Busca Categoria y EdoFinanciero xProducto: ', csbNivelTraza);
    ELSE
        pkg_traza.trace(csbMetodo ||' --> Busca Categoria y EdoFinanciero xSuscripc: ', csbNivelTraza);
        
        BEGIN    
            OPEN cuCateEdoFinancXSuscripc;
            FETCH cuCateEdoFinancXSuscripc INTO nuCategoria,sbestafina;
            CLOSE cuCateEdoFinancXSuscripc;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                nuCategoria := NULL;
                sbestafina := NULL;
        END;
        
        nuprocprod := NULL;
      
        BEGIN
            OPEN cuPorcencuoXSuscripc;
            FETCH cuPorcencuoXSuscripc INTO nuprocprod;
            CLOSE cuPorcencuoXSuscripc;        
        EXCEPTION
        WHEN NO_DATA_FOUND THEN
           nuprocprod := NULL;
        END;
        pkg_traza.trace(csbMetodo ||' --> FIN Busca Categoria y EdoFinanciero xSuscripc: ', csbNivelTraza);
    END IF;
    
    pkg_traza.trace(csbMetodo ||' nuCategoria: ' || nuCategoria, csbNivelTraza);    
    pkg_traza.trace(csbMetodo ||' sbestafina: ' || sbestafina, csbNivelTraza);
    pkg_traza.trace(csbMetodo ||' nuprocprod: ' || nuprocprod, csbNivelTraza);
    
    IF nuCategoria >= 3  THEN
       nuReturn := fnuCuotaInicialCom ( inuFinanPlan, inuSuscripc, inuProductId );
       pkg_traza.trace(csbMetodo ||' nuReturn: ' || nuReturn, csbNivelTraza);
       
    ELSE
        pkg_traza.trace(csbMetodo ||' toma el camino de nuCategoria <3 ', csbNivelTraza);  
        IF isbLevel = 'P' THEN
            IF sbestafina = 'C' THEN
                BEGIN
                    OPEN cuCiAnoMes;
                    FETCH cuCiAnoMes INTO nuvaano, nuvames;
                    CLOSE cuCiAnoMes;
                EXCEPTION
                    WHEN NO_DATA_FOUND THEN
                         nuvaano := NULL;
                         nuvames := NULL;
                END;
                pkg_traza.trace(csbMetodo ||' nuvaano: ' || nuvaano, csbNivelTraza);
                pkg_traza.trace(csbMetodo ||' nuvames: ' || nuvames, csbNivelTraza);
                
                BEGIN
                    OPEN cuValorCastigado(nuvaano,nuvames);
                    FETCH cuValorCastigado INTO nuvalorcastigado;
                    CLOSE cuValorCastigado;            
                EXCEPTION
                WHEN NO_DATA_FOUND THEN
                     nuvalorcastigado := 0;
                END;
                
                pkg_traza.trace(csbMetodo ||' nuvalorcastigado: ' || nuvalorcastigado, csbNivelTraza);
                
                nuTotCartera := nuvalorcastigado;
                pkg_traza.trace(csbMetodo ||' nuTotCartera: ' || nuTotCartera, csbNivelTraza);
                
           ELSE
                -- Realiza busqueda por producto
                pkg_traza.trace(csbMetodo ||' Nivel Producto ['||inuProductId||']', csbNivelTraza); 
                -- Deuda Corriente Vencida
                nuCorrVencida   := gc_bodebtmanagement.fnuGetExpirDebtByProd(inuProductId); 
                
                -- Deuda Corriente Total
                nuCorrTotal     := gc_bodebtmanagement.fnuGetDebtByProd(inuProductId); 
                
                -- Deuda DIFerida
                nuDIFerida      := gc_bodebtmanagement.fnuGetDefDebtByProd(inuProductId); 
                
                -- Cartera Total
                nuTotCartera    := nuCorrTotal + nuDIFerida; 
            
           END IF;
    
            -- Ultima Actividad de suspension
            nuLastSuspen  := pkg_bcproducto.fnuidactivordensusp(inuProductID);
            
            IF nuLastSuspen IS NOT NULL THEN
              -- Obtiene el tipo de actividad asociada a la actividad de orden
              sbActivityId  := to_char(pkg_bcordenes.fnuobtieneitemactividad(nuLastSuspen));
            ELSE
              sbActivityId  := '-';
            END IF;
            
            pkg_traza.trace(csbMetodo ||' tipo de actividad asociada a la actividad de orden ['||sbActivityId||']', csbNivelTraza);
            
            -- Establece el nivel de suspension
            SbActividadesCM := dald_parameter.fsbGetValue_Chain('LDC_ACT_SUSP_CM_FDPCI');
            pkg_traza.trace(csbMetodo ||' SbActividadesCM ['||SbActividadesCM||']', csbNivelTraza);
            
            SbActividadesAC := dald_parameter.fsbGetValue_Chain('LDC_ACT_SUSP_ACO_FDPCI');
            pkg_traza.trace(csbMetodo ||' SbActividadesAC ['||SbActividadesAC||']', csbNivelTraza);
    
            IF instr(SbActividadesCM, sbActivityId) > 0 THEN
                nuNivelSusp := 1; -- Centro de Medicion
            ELSIF instr(SbActividadesAC, sbActivityId) > 0 THEN
                nuNivelSusp := 2; -- Acometida
            ELSE
                nuNivelSusp := 0; -- No Aplica
            END IF;
    
            pkg_traza.trace(csbMetodo ||' Nivel de Suspension ['||nuNivelSusp||']', csbNivelTraza); 

        ELSE
            -- busco por el contrato
            pkg_traza.trace(csbMetodo ||' Nivel contrato ['||inuSuscripc||']', csbNivelTraza);         
            -- Deuda Corriente Vencida
            nuCorrVencida := gc_bodebtmanagement.fnuGetExpirDebtBySusc(inuSuscripc);
            
            -- Deuda Corriente Total
            nuCorrTotal := gc_bodebtmanagement.fnuGetDebtBySusc(inuSuscripc);        
            
            -- Deuda DIFerida
            nuDIFerida := gc_bodebtmanagement.fnuGetDefDebtBySusc(inuSuscripc);
            
            -- Cartera Total
            nuTotCartera := nuCorrTotal + nuDIFerida;
            
            -- Nivel de Suspension
            nuNivelSusp := 0;       --No aplica  
            
         END IF;--isbLevel = 'P'

      pkg_traza.trace(csbMetodo ||' Cartera Corriente Vencida   ['||nuCorrVencida||']', csbNivelTraza);
      pkg_traza.trace(csbMetodo ||' Cartera Corriente Total     ['||nuCorrTotal||']', csbNivelTraza);
      pkg_traza.trace(csbMetodo ||' Cartera DIFerida            ['||nuDIFerida||']', csbNivelTraza);
      pkg_traza.trace(csbMetodo ||' Cartera Total               ['||nuTotCartera||']', csbNivelTraza);
      pkg_traza.trace(csbMetodo ||' Ultima Actividad de suspension ['||nuLastSuspen||']', csbNivelTraza);      

      nuReturn := NULL;

      IF cuLDC_PLANDIFE2%ISOPEN THEN
         CLOSE cuLDC_PLANDIFE2;
      END IF;

      -- VerIFica si debe realizar consulta por nivel de suspension

      IF nuNivelSusp <> 0 THEN

        IF cuLDC_PLANDIFE1%ISOPEN THEN
            CLOSE cuLDC_PLANDIFE1;
        END IF;
 
        OPEN  cuLDC_PLANDIFE1(inuFinanPlan, nuNivelSusp, nuTotCartera, nuCorrTotal, nuCorrVencida);
        FETCH cuLDC_PLANDIFE1 INTO rcLDC_PLANDIFE;
        
        pkg_traza.trace(csbMetodo ||' --> Consulta por nivel de suspension...', csbNivelTraza);
        pkg_traza.trace(csbMetodo ||' VALOR_CUOTA_FIJA ['||rcldc_plandife.valor_cuota_fija||']', csbNivelTraza); 
        pkg_traza.trace(csbMetodo ||' PORC_CUOTA ['||rcldc_plandife.porc_cuota||']', csbNivelTraza);
        pkg_traza.trace(csbMetodo ||' TIPO_CARTERA ['||rcldc_plandife.tipo_cartera||']', csbNivelTraza); 
        
          IF cuLDC_PLANDIFE1%FOUND THEN
              IF nvl(rcldc_plandife.valor_cuota_fija,0) > 0 THEN
                 nuReturn:=Rcldc_Plandife.valor_cuota_fija;
              ELSE
              
                IF nuprocprod IS NOT NULL THEN
                  nuporcent := nuprocprod/100;
                ELSE
                  nuporcent := rcldc_plandIFe.porc_cuota/100;
                END IF;
                pkg_traza.trace(csbMetodo ||' nuporcent ['||nuporcent||']', csbNivelTraza); 
                
                IF rcLDC_PLANDIFE.TIPO_CARTERA = 'CV' THEN
                   nuReturn := nuCorrVencida * nuporcent ;
                ELSIF  rcLDC_PLANDIFE.TIPO_CARTERA = 'CT' THEN
                   nuReturn := nuCorrTotal * nuporcent ;
                ELSIF rcLDC_PLANDIFE.TIPO_CARTERA = 'TO' THEN
                   nuReturn := nuTotCartera * nuporcent ;
                END IF;
                
              END IF;
          END IF;
        
        pkg_traza.trace(csbMetodo ||' nuReturn ['||nuReturn||']', csbNivelTraza); 
        
        CLOSE cuLDC_PLANDIFE1;
        
        pkg_traza.trace(csbMetodo ||' --> FIN Consulta por nivel de suspension...', csbNivelTraza);
      END IF;

      -- Si no existe parametrizacion por nivel de suspension, consulta por rango
      IF nuReturn IS NULL THEN

        OPEN  cuLDC_PLANDIFE2(inuFinanPlan, nuTotCartera, nuCorrTotal, nuCorrVencida);
        FETCH cuLDC_PLANDIFE2 INTO rcLDC_PLANDIFE;

        pkg_traza.trace(csbMetodo ||' --> Consulta por rango de deuda...', csbNivelTraza);
        pkg_traza.trace(csbMetodo ||' VALOR_CUOTA_FIJA ['||rcldc_plandife.valor_cuota_fija||']', csbNivelTraza); 
        pkg_traza.trace(csbMetodo ||' PORC_CUOTA ['||rcldc_plandife.porc_cuota||']', csbNivelTraza);
        pkg_traza.trace(csbMetodo ||' TIPO_CARTERA ['||rcldc_plandife.tipo_cartera||']', csbNivelTraza);        

          IF cuLDC_PLANDIFE2%found THEN
             IF nvl(rcLDC_PLANDIFE.VALOR_CUOTA_FIJA,0) > 0 THEN
                nuReturn:=rcLDC_PLANDIFE.VALOR_CUOTA_FIJA;
             ELSE
             
               IF nuprocprod IS NOT NULL THEN
                  nuporcent := nuprocprod/100;
                ELSE
                  nuporcent := rcldc_plandIFe.porc_cuota/100;
                END IF;
                pkg_traza.trace(csbMetodo ||' nuporcent ['||nuporcent||']', csbNivelTraza); 
                
                IF rcLDC_PLANDIFE.TIPO_CARTERA = 'CV' THEN
                   nuReturn := nuCorrVencida * nuporcent ;
                ELSIF  rcLDC_PLANDIFE.TIPO_CARTERA = 'CT' THEN
                   nuReturn := nuCorrTotal * nuporcent ;
                ELSIF rcLDC_PLANDIFE.TIPO_CARTERA = 'TO' THEN
                   nuReturn := nuTotCartera * nuporcent ;
                END IF;
                
             END IF;
          END IF;
        
        pkg_traza.trace(csbMetodo ||' nuReturn ['||nuReturn||']', csbNivelTraza); 
        
        CLOSE cuLDC_PLANDIFE2;
        
        pkg_traza.trace(csbMetodo ||' --> FIN Consulta por rango de deuda...', csbNivelTraza);
      END IF;

    END IF;--nuCategoria = 2
    
    --  Obtiene el factor de redondeo para la suscripcion
    FA_BOPoliticaRedondeo.ObtFactorRedondeo(inuSuscripc, nuRoundFactor, 99);
    pkg_traza.trace(csbMetodo ||' factor de redondeo ['||nuRoundFactor||']', csbNivelTraza);
    
    --  Aplica politica de redondeo al valor de la cuota
    nuReturn := round( nuReturn, nuRoundFactor );

    pkg_traza.trace(csbMetodo ||' Cuota inicial calculada ['||nuReturn||']', csbNivelTraza);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 

    RETURN(nuReturn);

 EXCEPTION
     WHEN OTHERS THEN
          pkg_Error.setError;
          pkg_Error.getError(onuerrorcode, osberrormessage);
          pkg_traza.trace(csbMetodo ||' osberrormessage: ' || osberrormessage, csbNivelTraza);
          pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
          RETURN (NULL);
END LDC_FNUGETINIQUOTA;
/
PROMPT "                                                            "
PROMPT OTORGA PERMISOS ESQUEMA sobre funcion LDC_FNUGETINIQUOTA
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_FNUGETINIQUOTA', 'ADM_PERSON'); 
END;
/
PROMPT "                                                            "
PROMPT OTORGA PERMISOS a REPORTES sobre funcion LDC_FNUGETINIQUOTA
GRANT EXECUTE ON ADM_PERSON.LDC_FNUGETINIQUOTA TO REPORTES;
/