CREATE OR REPLACE FUNCTION ADM_PERSON.FNUGETCONSPROMFACT (inuproducto IN servsusc.sesunuse%TYPE,
                                                          idtfege     IN perifact.pefafege%TYPE,
                                                          inupefa     IN perifact.pefacodi%TYPE
) RETURN NUMBER AS

/*******************************************************************************
  Propiedad intelectual de GC

  Descripcion    : Funcion que devuelve el Consumo estimado facturado en un periodo dado
                   Si devuelve nulo es porque en el periodo solicitado el producto
                   no se facturo promedio

  Autor          : F.Castro
  Fecha          : 23-05-2016

  Fecha                IDEntrega           Modificacion
  ============    ================    ============================================
  20/02/2024        Adrianavg         OSF-2183: Se migra del esquema OPEN al esquema ADM_PERSON
                                      Se declaran variables para la gestión de trazas, se hace uso del pkg_traza.trace
                                      Se ajusta el bloque de excepciones según las pautas técnicas
                                      Se retira el esquema OPEN antepuesto a servsusc, perifact, conssesu, mecacons
  *******************************************************************************/
    --Se declaran variables para la gestión de trazas
    csbMetodo            CONSTANT VARCHAR2(32)       := $$PLSQL_UNIT;
    csbNivelTraza        CONSTANT NUMBER(2)          := pkg_traza.cnuNivelTrzDef;
	csbInicio   	     CONSTANT VARCHAR2(35) 	     := pkg_traza.csbINICIO; 
    Onuerrorcode         NUMBER:= pkg_error.CNUGENERIC_MESSAGE;
    Osberrormessage      VARCHAR2(2000);
        
    nuProm      conssesu.cosscoca%TYPE := -1;
    numecc      mecacons.mecccodi%TYPE := 0;
    nucoca      conssesu.cosscoca%TYPE := -1; 
    
    CURSOR cuConsProm 
    IS
    SELECT C.cossmecc, C.cosscoca
      FROM conssesu C
     WHERE C.cosspefa = inupefa
       AND C.cosssesu = inuproducto
       AND C.cossmecc NOT IN (2,4,5)
       AND C.cossfere < idtfege + 1
  ORDER BY C.cossfere DESC ;

BEGIN

    pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
    pkg_error.prInicializaError(onuerrorcode, osberrormessage);
    pkg_traza.trace(csbMetodo ||' inuproducto: ' || inuproducto, csbNivelTraza);
    pkg_traza.trace(csbMetodo ||' idtfege: ' || idtfege, csbNivelTraza);
    pkg_traza.trace(csbMetodo ||' inupefa: ' || inupefa, csbNivelTraza);
    
    OPEN cuconsprom;    
    FETCH cuconsprom INTO numecc, nucoca;
    
    IF cuconsprom%notfound THEN
       nuprom := NULL;
    END IF;    
    CLOSE cuconsprom;
    
    pkg_traza.trace(csbMetodo ||' numecc: ' || numecc, csbNivelTraza);
    pkg_traza.trace(csbMetodo ||' nucoca: ' || nucoca, csbNivelTraza);
    
    IF numecc = 3 THEN
        nuprom := nucoca;
    ELSE
        nuprom := NULL;
    END IF;

    pkg_traza.trace(csbMetodo ||' nuprom: ' || nuprom, csbNivelTraza);    
    pkg_traza.trace(csbmetodo, csbniveltraza, pkg_traza.csbfin);
    
    RETURN ( nuprom );

EXCEPTION
    WHEN OTHERS THEN
         pkg_Error.setError;
         pkg_Error.getError(onuerrorcode, osberrormessage);
         pkg_traza.trace(csbMetodo ||' osberrormessage: ' || osberrormessage, csbNivelTraza);
         pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
         RETURN (NULL);
END fnuGetConsPromFact;
/
PROMPT "                                                            "
PROMPT OTORGA PERMISOS ESQUEMA sobre funcion FNUGETCONSPROMFACT
BEGIN
    pkg_utilidades.prAplicarPermisos('FNUGETCONSPROMFACT', 'ADM_PERSON'); 
END;
/
PROMPT "                                                            "
PROMPT OTORGA PERMISOS a REXEREPORTES sobre funcion FNUGETCONSPROMFACT
GRANT EXECUTE ON ADM_PERSON.FNUGETCONSPROMFACT TO REXEREPORTES;
/
