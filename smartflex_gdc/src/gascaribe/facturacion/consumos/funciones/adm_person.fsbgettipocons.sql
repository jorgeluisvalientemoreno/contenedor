create or replace FUNCTION ADM_PERSON.FSBGETTIPOCONS  (inuProducto  IN servsusc.sesunuse%TYPE,
                                                       idtFecha     IN DATE,
                                                       inuPeriodo   IN NUMBER) RETURN VARCHAR2 AS

/*******************************************************************************
  Propiedad intelectual de GC

  Descripcion    : Función que devuelve el tipo de Consumo (Real o Estimado)
                   de un producto en la facturacion anterior a una fecha recibida
                   como parametro
                   Si devuelve nulo es porque en el periodo solicitado el producto
                   no tuvo facturacion

  Autor          : F.Castro
  Fecha          : 23-05-2016

  Fecha                IDEntrega           Modificacion
  ============    ================    ============================================
  07/02/2023      Adrianavg           OSF-2097: Migrar del esquema OPEN al esquema ADM_PERSON
                                      Se retira esquema OPEN antepuesto a tabla servsusc, factura, perifact, conssesu
                                      Se declaran variables para la gestión de trazas
                                      Se ajusta el bloque de exceptiones según pautas técnicas                                      
  *******************************************************************************/  
    --Se declaran variables para la gestión de trazas
    csbMetodo            CONSTANT VARCHAR2(32)       := $$PLSQL_UNIT;
    csbNivelTraza        CONSTANT NUMBER(2)          := pkg_traza.cnuNivelTrzDef; 
    csbInicio   	     CONSTANT VARCHAR2(35) 	     := pkg_traza.csbINICIO;   
    Onuerrorcode         NUMBER:= pkg_error.CNUGENERIC_MESSAGE;		
    Osberrormessage      VARCHAR2(2000);
    
    nupefa      NUMBER;
    i           NUMBER;
    sbProm      VARCHAR2(15);    
    
    CURSOR cupefa IS
    SELECT factpefa
      FROM factura, servsusc ss
     WHERE factsusc = ss.sesususc
       AND factprog = 6
       AND factfege < idtfecha
       AND ss.sesunuse = inuproducto
  ORDER BY factpefa DESC;
    
    CURSOR cufactprom ( nupefa perifact.pefacodi%TYPE )
    IS
    SELECT 'x'
    FROM conssesu c
    WHERE cosspefa = nupefa
      AND cosssesu = inuproducto
      AND cossmecc = 3
      AND cosscoca > 0
      AND ( SELECT SUM(c2.cosscoca)
              FROM conssesu c2
             WHERE c2.cosssesu = c.cosssesu
               AND c2.cosspefa = c.cosspefa
               AND cossmecc = 4 ) = c.cosscoca;

BEGIN
    
    pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
    pkg_error.prInicializaError(onuerrorcode, osberrormessage);
    pkg_traza.trace(csbMetodo ||' inuProducto: ' || inuProducto, csbNivelTraza);
    pkg_traza.trace(csbMetodo ||' idtFecha: ' || idtFecha, csbNivelTraza);
    pkg_traza.trace(csbMetodo ||' inuPeriodo: ' || inuPeriodo, csbNivelTraza);    

    i := 1;
    nupefa := NULL;
    FOR rg IN cupefa LOOP
        IF i = inuperiodo THEN
            nupefa := rg.factpefa;
        END IF;
        EXIT WHEN i = inuperiodo;
        i := i + 1;
    END LOOP;
    
    pkg_traza.trace(csbMetodo ||' nupefa: ' || nupefa, csbNivelTraza);    
    
    IF nupefa IS NULL THEN
        sbprom := NULL;
    ELSE
        OPEN cufactprom(nupefa);
        FETCH cufactprom INTO sbprom;
        IF cufactprom%notfound THEN
            sbprom := 'REAL';
        ELSE
            sbprom := 'ESTIMADO';
        END IF;

        CLOSE cufactprom;
    END IF;
    
    pkg_traza.trace(csbMetodo ||' tipo de Consumo: ' || sbprom, csbNivelTraza);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    
    RETURN ( sbprom );

EXCEPTION
    WHEN OTHERS THEN
         PKG_ERROR.setError; 
         PKG_ERROR.getError(onuerrorcode, osberrormessage);
         pkg_traza.trace(csbMetodo ||' osberrormessage: ' || osberrormessage, csbNivelTraza);
         pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR); 
         RETURN ('ERROR EN FUNCION');
END fsbGetTipoCons;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre funcion FSBGETTIPOCONS
BEGIN
    pkg_utilidades.prAplicarPermisos('FSBGETTIPOCONS', 'ADM_PERSON'); 
END;
/
PROMPT OTORGA PERMISOS a REPORTES sobre funcion FSBGETTIPOCONS
GRANT EXECUTE ON ADM_PERSON.FSBGETTIPOCONS TO REPORTES;
/