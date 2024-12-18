CREATE OR REPLACE FUNCTION ADM_PERSON.FSBGETOBSCONSECNOLECT (inuProducto  IN servsusc.sesunuse%TYPE,
                                                             inuMeses     IN NUMBER,
                                                             inuPerIni    IN NUMBER, 
                                                             inuPerFin    IN NUMBER) RETURN VARCHAR2 AS

 /*******************************************************************************
  Propiedad intelectual de GC

  Descripcion    : Función que devuelve las observaciones de No Lectura Consecutivas
                   (Descripcion y Cantidad) en un rango de periodos para un producto
  Autor          : F.Castro
  Fecha          : 23-05-2016

  Fecha                IDEntrega           ModIFicacion
  ============    ================    ============================================
  07/02/2023      Adrianavg           OSF-2097: Migrar del esquema OPEN al esquema ADM_PERSON
                                      Se retira esquema antepuesto OPEN a tabla servsusc, lectelme, obselect y perIFact
                                      Se retira código comentariado
                                      Se declaran variables para la gestión de trazas
                                      Se ajusta el bloque de exceptiones según pautas técnicas                                      
  *******************************************************************************/    
    --Se declaran variables para la gestión de trazas
    csbMetodo            CONSTANT VARCHAR2(32)       := $$PLSQL_UNIT;
    csbNivelTraza        CONSTANT NUMBER(2)          := pkg_traza.cnuNivelTrzApi; 
    csbInicio   	       CONSTANT VARCHAR2(35) 	     := pkg_traza.csbINICIO;   
    Onuerrorcode         NUMBER:= pkg_error.CNUGENERIC_MESSAGE;		
    Osberrormessage      VARCHAR2(2000);
    
    nupefa      NUMBER;
    i           NUMBER;
    sbObse      VARCHAR2(2000);
    nuAnoAnt    NUMBER(4);
    nuAno       NUMBER(4);
    nuMesAnt    NUMBER(2);
    nuMes       NUMBER(2);
    sbPefa      VARCHAR2(2000);
    sbLastPefa  VARCHAR2(6);
    
    CURSOR culect IS
    SELECT L.leempefa, L.leemoble, ol.oblecodi, ol.obledesc, ol.oblecanl
      FROM servsusc S, lectelme L,  obselect ol
     WHERE L.leemsesu = sesunuse
       AND nvl(L.leemoble,-1) = ol.oblecodi
       AND L.leemclec = 'F' 
       AND L.leemsesu = inuproducto
       AND L.leempefa IN (SELECT pf.pefacodi
                            FROM perIFact pf
                           WHERE pf.pefaano||LPAD(pf.pefames,2,'0') >= inuperini
                             AND pf.pefaano||LPAD(pf.pefames,2,'0') <= inuperfin
                             AND pf.pefacicl = S.sesucicl)
  ORDER BY leempefa;
    
    CURSOR cupefa (nupefa perIFact.pefacodi%TYPE) IS
    SELECT pefaano, pefames
      FROM perIFact
     WHERE pefacodi = nupefa;
    
    CURSOR cuobse (sbperiodos VARCHAR2) IS
    SELECT L.leemoble, ol.obledesc, COUNT(1) cant
      FROM lectelme L,  obselect ol
     WHERE nvl(L.leemoble,-1) = ol.oblecodi
       AND L.leemclec = 'F'
       AND nvl(ol.oblecanl,'N') = 'S'
       AND L.leemsesu = inuproducto
       AND ','||sbperiodos||',' LIKE '%,'|| leempefa||',%'
  GROUP BY L.leemoble, ol.obledesc;

------------------------------------------------------------------
    FUNCTION fsbGetNextPefa (inuAno NUMBER, inuMes NUMBER) RETURN VARCHAR2 IS
    osbPefa VARCHAR2(6);
    onuAno  NUMBER(4);
    onuMes  NUMBER(2);
    
    --OSF-2097 Se declaran variables para la gestión de trazas
    csbMetodoInter            CONSTANT VARCHAR2(60)       := $$PLSQL_UNIT||'.'||'fsbGetNextPefa';
    csbNivelTrazaInter        CONSTANT NUMBER(2)          := pkg_traza.cnuNivelTrzDef;
    BEGIN
        pkg_traza.trace(csbMetodoInter, csbNivelTrazaInter, csbInicio); 
        pkg_traza.trace(csbMetodoInter ||' inuano: ' || inuano, csbNivelTrazaInter);
        pkg_traza.trace(csbMetodoInter ||' inumes: ' || inumes, csbNivelTrazaInter);
        
        IF inumes = 12 THEN
            onuano := inuano + 1;
            onumes := 1;
        ELSE
            onuano := inuano;
            onumes := inumes + 1;
        END IF;
        
        pkg_traza.trace(csbMetodoInter ||' onuano: ' || onuano, csbNivelTrazaInter);
        
        osbpefa := onuano || LPAD(onumes, 2, '0');
        
        pkg_traza.trace(csbMetodoInter ||' osbpefa: ' || osbpefa, csbNivelTrazaInter);
        pkg_traza.trace(csbMetodoInter, csbNivelTrazaInter, pkg_traza.csbFIN);
        
        RETURN ( osbpefa );
    END fsbgetnextpefa;
------------------------------------------------------------------
    FUNCTION fsbGetPrevPefa (inuAno NUMBER, inuMes NUMBER) RETURN VARCHAR2 IS
    osbPefa VARCHAR2(6);
    onuAno  NUMBER(4);
    onuMes  NUMBER(2);
    
    --OSF-2097 Se declaran variables para la gestión de trazas
    csbMetodoInter            CONSTANT VARCHAR2(60)       := $$PLSQL_UNIT||'.'||'fsbGetPrevPefa';
    csbNivelTrazaInter        CONSTANT NUMBER(2)          := pkg_traza.cnuNivelTrzDef;
    BEGIN
        pkg_traza.trace(csbMetodoInter, csbNivelTrazaInter, csbInicio); 
        pkg_traza.trace(csbMetodoInter ||' inuano: ' || inuano, csbNivelTrazaInter);
        pkg_traza.trace(csbMetodoInter ||' inumes: ' || inumes, csbNivelTrazaInter);
        
        IF inumes = 1 THEN
            onuano := inuano - 1;
            onumes := 12;
        ELSE
            onuano := inuano;
            onumes := inumes - 1;
        END IF;
        
        pkg_traza.trace(csbMetodoInter ||' onuano: ' || onuano, csbNivelTrazaInter);
        
        osbpefa := onuano || LPAD(onumes, 2, '0');
        
        pkg_traza.trace(csbMetodoInter ||' osbpefa: ' || osbpefa, csbNivelTrazaInter);
        pkg_traza.trace(csbMetodoInter, csbNivelTrazaInter, pkg_traza.csbFIN);
                
        RETURN ( osbpefa );
    END fsbgetprevpefa;
------------------------------------------------------------------ 
BEGIN

    pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
    pkg_error.prInicializaError(onuerrorcode, osberrormessage);
    pkg_traza.trace(csbMetodo ||' inuProducto: ' || inuProducto, csbNivelTraza);
    pkg_traza.trace(csbMetodo ||' inuMeses: ' || inuMeses, csbNivelTraza);
    pkg_traza.trace(csbMetodo ||' inuPerIni: ' || inuPerIni, csbNivelTraza);
    pkg_traza.trace(csbMetodo ||' inuPerFin: ' || inuPerFin, csbNivelTraza); 
    
    i := 0;
    sbLastPefa := fsbGetPrevPefa(SUBSTR(inuperini,1,4), SUBSTR(inuperini,5,2));
    pkg_traza.trace(csbMetodo ||' sbLastPefa: ' || sbLastPefa, csbNivelTraza); 
    
    nuAnoAnt := SUBSTR(sbLastPefa,1,4);
    pkg_traza.trace(csbMetodo ||' nuAnoAnt: ' || nuAnoAnt, csbNivelTraza);
    
    nuMesAnt := SUBSTR(sbLastPefa,5,2);
    pkg_traza.trace(csbMetodo ||' nuMesAnt: ' || nuMesAnt, csbNivelTraza);
    
    FOR rg in culect LOOP
     OPEN cupefa(rg.leempefa);
    FETCH cupefa INTO nuano, numes;
    CLOSE cupefa;
    
    pkg_traza.trace(csbMetodo ||' nuano: ' || nuano, csbNivelTraza);
    pkg_traza.trace(csbMetodo ||' numes: ' || numes, csbNivelTraza);
    
    IF nuAno || LPAD(nuMes,2,'0') = fsbGetNextPefa(nuAnoAnt, nuMesAnt) AND
       nvl(rg.oblecanl,'N') = 'S' THEN -- es consecutivo y la obs es de no lectura
       i := i + 1;
       sbPefa := sbPefa || rg.leempefa || ',';
    ELSE
       IF i < inuMeses THEN
         i := 0;
         sbPefa := NULL;
       ELSE
         EXIT;
       END IF;
    END IF;
    nuAnoAnt := nuAno;
    nuMesAnt := nuMes;
    END LOOP;
    
    pkg_traza.trace(csbMetodo ||' sbPefa: ' || sbPefa, csbNivelTraza);
    
    sbObse := NULL;
    IF i >= inuMeses THEN
    FOR rg2 in cuObse(sbPefa) LOOP
      sbObse := sbObse || rg2.obledesc || ':  ' || rg2.cant || '      ' ;
    END LOOP;
    END IF;
    
    pkg_traza.trace(csbMetodo ||' sbObse: ' || sbObse, csbNivelTraza);
    
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    
    RETURN sbObse;

EXCEPTION
    WHEN OTHERS THEN
         pkg_error.seterror; 
         pkg_Error.getError(onuerrorcode, osberrormessage);
         pkg_traza.trace(csbMetodo ||' osberrormessage: ' || osberrormessage, csbNivelTraza);
         pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
         RETURN ('ERROR EN FUNCION');
END fsbGetObsConsecNoLect;
/ 
PROMPT OTORGA PERMISOS ESQUEMA sobre funcion FSBGETOBSCONSECNOLECT
BEGIN
    pkg_utilidades.prAplicarPermisos('FSBGETOBSCONSECNOLECT', 'ADM_PERSON'); 
END;
/
PROMPT OTORGA PERMISOS a REPORTES sobre funcion FSBGETOBSCONSECNOLECT
GRANT EXECUTE ON ADM_PERSON.FSBGETOBSCONSECNOLECT TO REPORTES;
/