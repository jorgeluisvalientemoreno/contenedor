CREATE OR REPLACE FUNCTION ADM_PERSON.LDC_FNUESTADOPERIODO(InuPeriodo NUMBER,
                                                           InuCiclo   NUMBER,
                                                           Inuanno    NUMBER,
                                                           Inumes     NUMBER)
RETURN NUMBER IS
  /*******************************************************************************
   Fecha:        22/09/2020
   HORBAT        HORBATH
   CASO          316
   Metodo:       LDC_FNUESTADOPERIODO
   Descripcion:  Establcer registros de inconsistencias en los conceptos de cosumo y no sobrpasen un tope de cntrol
                 en MT3 y Valor.

   Entrada           Descripcion
   nuPeriodo:        Codigo periodo de Facturacion

   Salida             Descripcion

   Historia de Modificaciones
   FECHA        AUTOR           DESCRIPCION
   19/11/2021   LJLB            CA 696 se coloca filtro para que solo se tenga e cuenta consumos con causal recurrente
   15/02/2023   Adrianavg       OSF-2181: Migrar del esquema OPEN al esquema ADM_PERSON
                                Se retira código comentado, y esquema OPEN antepuesto a las tablas del cursor cucargosconsumo
                                Se declaran variables para la gestión de trazas, se hace uso del pkg_traza.trace
                                Se ajusta el bloque de exceptiones según pautas técnicas
  *******************************************************************************/
    --Se declaran variables para la gestión de trazas
    csbMetodo            CONSTANT VARCHAR2(32)       := $$PLSQL_UNIT;
    csbNivelTraza        CONSTANT NUMBER(2)          := pkg_traza.cnuNivelTrzDef; 
    csbInicio   	     CONSTANT VARCHAR2(35) 	     := pkg_traza.csbINICIO;   
    Onuerrorcode         NUMBER:= pkg_error.CNUGENERIC_MESSAGE;	
    Osberrormessage      VARCHAR2(2000);

    CURSOR cuCatmetcub is
    SELECT T.*, T.ROWID 
      FROM LDC_CATMETCUB t;
    
    rfcuCATMETCUB cuCATMETCUB%rowtype;
    
    CURSOR cuCargosConsumo(InuPeriodo   NUMBER,
                         InuCiclo     NUMBER,
                         Inuanno      NUMBER,
                         Inumes       NUMBER,
                         Inucategoria NUMBER,
                         InuMT3       NUMBER,
                         InuValorMT3  NUMBER) 
     IS
    SELECT pf.pefaano           ano,
           pf.pefames           mes,
           pf.pefacicl          Ciclo,
           ss.sesususc          Contrato,
           ss.sesunuse          Producto,
           c.cargunid           volumen,
           c.CARGVALO           Valor,
           ss.sesucate          Categoria,
           ss.sesusuca          Subcategoria,
           pr.product_status_id EstadoProducto,
           c.cargconc           concepto
      FROM CARGOS            c,
           SERVSUSC          ss,
           SUSCRIPC          su,
           pr_product        pr,
           SERVICIO          se,
           CONCEPTO          CO,
           PERIFACT          pf,
           PS_PRODUCT_STATUS e
     WHERE pr.product_status_id = e.product_status_id
       AND ss.sesunuse = pr.product_id
       AND c.cargnuse = ss.sesunuse
       AND ss.Sesususc = su.susccodi
       AND pr.product_type_id = se.servcodi
       AND c.cargconc = CO.conccodi
       AND c.cargpefa = pf.pefacodi
       AND ss.sesucate = Inucategoria
       AND pf.pefacodi = InuPeriodo
       AND pf.pefacicl = InuCiclo
       AND pf.pefaano = Inuanno
       AND pf.pefames = Inumes
       AND c.cargcuco = -1
       AND c.cargcaca = 15
       AND (c.cargunid > InuMT3 or c.cargvalo > InuValorMT3)
       AND c.cargconc = nvl(dald_parameter.fnuGetNumeric_Value('LDC_CONMETCUB', NULL), 0);
    
    rfcucargosconsumo cucargosconsumo%rowtype;
    
    nuCotrol NUMBER := 0;

  --PROCEDIMIENTO INTERNO
  PROCEDURE proPROMETCUB(v_periodo         NUMBER,
                         v_anno            NUMBER,
                         v_mes             NUMBER,
                         v_ciclo           NUMBER,
                         v_contrato        NUMBER,
                         v_producto        NUMBER,
                         v_concepto        NUMBER,
                         v_volliq          NUMBER,
                         v_valliq          NUMBER,
                         v_categoria       NUMBER,
                         v_subcategoria    NUMBER,
                         v_estado_producto NUMBER) 
    IS
    PRAGMA AUTONOMOUS_TRANSACTION;
    --Se declaran variables para la gestión de trazas al procedimiento interno
    csbMetodoInter            CONSTANT VARCHAR2(40)       := csbMetodo||'.'||'proPROMETCUB'; 
    csbNivelTrazaInter        CONSTANT NUMBER(2)          := pkg_traza.cnuNivelTrzTrg; 
    OnuerrorcodeInter         NUMBER:= pkg_error.CNUGENERIC_MESSAGE;	
    OsberrormessageInter      VARCHAR2(2000);        
  BEGIN

    pkg_traza.trace(csbMetodoInter, csbNivelTrazaInter, csbInicio); 
    pkg_error.prInicializaError(OnuerrorcodeInter, OsberrormessageInter);
    
    INSERT INTO ldc_prometcub
      (periodo,
       anno,
       mes,
       ciclo,
       contrato,
       producto,
       concepto,
       volliq,
       valliq,
       categoria,
       subcategoria,
       estado_producto)
    VALUES
      (v_periodo,
       v_anno,
       v_mes,
       v_ciclo,
       v_contrato,
       v_producto,
       v_concepto,
       v_volliq,
       v_valliq,
       v_categoria,
       v_subcategoria,
       v_estado_producto);

    COMMIT;

    pkg_traza.trace(csbMetodoInter ||' INSERT INTO ldc_prometcub, v_periodo '||v_periodo, csbNivelTrazaInter); 
    pkg_traza.trace(csbMetodoInter, csbNivelTrazaInter, pkg_traza.csbFIN); 
    
  EXCEPTION
    WHEN OTHERS THEN
         pkg_Error.setError;
         pkg_Error.getError(OnuerrorcodeInter, OsberrormessageInter);
         pkg_traza.trace(csbMetodoInter ||' osberrormessage: ' || OsberrormessageInter, csbNivelTrazaInter);
         pkg_traza.trace(csbMetodoInter, csbNivelTrazaInter, pkg_traza.csbFIN_ERR);         
         NULL;
  END;

BEGIN

    pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
    pkg_error.prInicializaError(onuerrorcode, osberrormessage);
    pkg_traza.trace(csbMetodo ||' InuPeriodo: ' || InuPeriodo, csbNivelTraza);
    pkg_traza.trace(csbMetodo ||' InuCiclo: ' || InuCiclo, csbNivelTraza);
    pkg_traza.trace(csbMetodo ||' Inuanno: ' || Inuanno, csbNivelTraza);
    pkg_traza.trace(csbMetodo ||' Inumes: ' || Inumes, csbNivelTraza);
    
    FOR rfcuCATMETCUB IN cuCATMETCUB LOOP
    
    pkg_traza.trace(csbMetodo ||' -->INICIA LOOP cuCATMETCUB', csbNivelTraza);
    pkg_traza.trace(csbMetodo ||' Categoria: ' || rfcuCATMETCUB.Categoria, csbNivelTraza);
    pkg_traza.trace(csbMetodo ||' Metroscubicos: ' || rfcuCATMETCUB.Metroscubicos, csbNivelTraza);
    pkg_traza.trace(csbMetodo ||' Valormetrocubico: ' || rfcuCATMETCUB.Valormetrocubico, csbNivelTraza);
    
        FOR rfcucargosconsumo IN cucargosconsumo(InuPeriodo,
                                                 InuCiclo,
                                                 Inuanno,
                                                 Inumes,
                                                 rfcuCATMETCUB.Categoria,
                                                 rfcuCATMETCUB.Metroscubicos,
                                                 rfcuCATMETCUB.Valormetrocubico) LOOP
        
        pkg_traza.trace(csbMetodo ||' -->INICIA LOOP cucargosconsumo', csbNivelTraza);
        pkg_traza.trace(csbMetodo ||' Contrato: ' || rfcucargosconsumo.contrato, csbNivelTraza);
        pkg_traza.trace(csbMetodo ||' Producto: ' || rfcucargosconsumo.producto, csbNivelTraza);
        pkg_traza.trace(csbMetodo ||' Concepto: ' || rfcucargosconsumo.concepto, csbNivelTraza);
        pkg_traza.trace(csbMetodo ||' Volumen:  ' || rfcucargosconsumo.volumen, csbNivelTraza);
        pkg_traza.trace(csbMetodo ||' Valor:    ' || rfcucargosconsumo.valor, csbNivelTraza);
        pkg_traza.trace(csbMetodo ||' Categoria: ' || rfcucargosconsumo.categoria, csbNivelTraza);
        pkg_traza.trace(csbMetodo ||' Subcategoria: ' || rfcucargosconsumo.subcategoria, csbNivelTraza);
        pkg_traza.trace(csbMetodo ||' Estadoproducto: ' || rfcucargosconsumo.estadoproducto, csbNivelTraza);
        
          proPROMETCUB(InuPeriodo,
                       InuAnno,
                       InuMes,
                       InuCiclo,
                       rfcucargosconsumo.contrato,
                       rfcucargosconsumo.producto,
                       rfcucargosconsumo.concepto,
                       rfcucargosconsumo.volumen,
                       rfcucargosconsumo.valor,
                       rfcucargosconsumo.categoria,
                       rfcucargosconsumo.subcategoria,
                       rfcucargosconsumo.estadoproducto);
        
          nuCotrol := 1;
        
        END LOOP;
        pkg_traza.trace(csbMetodo ||' -->FIN LOOP cucargosconsumo', csbNivelTraza);
    END LOOP;
    pkg_traza.trace(csbMetodo ||' -->FIN LOOP cuCATMETCUB', csbNivelTraza);
    
    pkg_traza.trace(csbMetodo ||' nuCotrol: ' || nuCotrol, csbNivelTraza);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 
    
    RETURN nuCotrol;

EXCEPTION
  WHEN OTHERS THEN
       pkg_Error.setError;
       pkg_Error.getError(onuerrorcode, osberrormessage);
       pkg_traza.trace(csbMetodo ||' osberrormessage: ' || osberrormessage, csbNivelTraza);
       pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
       RETURN 0;
end LDC_FNUESTADOPERIODO;
/
PROMPT "                                                            "
PROMPT OTORGA PERMISOS ESQUEMA sobre funcion LDC_FNUESTADOPERIODO
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_FNUESTADOPERIODO', 'ADM_PERSON'); 
END;
/