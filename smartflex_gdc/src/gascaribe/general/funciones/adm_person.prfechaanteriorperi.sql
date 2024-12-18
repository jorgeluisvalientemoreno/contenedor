CREATE OR REPLACE FUNCTION ADM_PERSON.PRFECHAANTERIORPERI(inucicl  IN NUMBER,
                                                          inuAnio  IN NUMBER,
                                                          inuMes   IN NUMBER)
RETURN DATE AS
  /**************************************************************************************
    Copyright (c) 2014 ROLLOUT SURTIGAS.

    NOMBRE       : prlecturaanterior_sge.prc
    AUTOR        : Arquitecsoft S.A.S - Diego Fernando Oviedo
    FECHA        : 13-05-2014
    DESCRIPCION  : Procedimiento mediante el cual se obtiene la lectura
                   anterior y su correspondiente fecha

    Parametros de Entrada
    inusesunuse   Numero de servicio
    inuAnio       Anio de lectura actual
    inuMes        Mes de la lectura actual

    Parametros de Salida
    onuLectAnte   Valor lectura anterior
    onuLectFeAn   Fecha lectura anterior

    Historia de Modificaciones
    Autor       Fecha           Descripcion
    Adrianavg   20/02/2024      OSF-2183: Se migra del esquema OPEN al esquema ADM_PERSON
                                Se declaran variables para la gestión de trazas, se hace uso del pkg_traza.trace
                                Se ajusta el bloque de excepciones según las pautas técnicas
                                Se reemplaza SELECT-INTO por cursor cufectAnte
                                Se retira esquema MIGRA antepuesto a ldc_temp_planfaca_sge
    *****************************************************************************************/
    --Se declaran variables para la gestión de trazas
    csbMetodo            CONSTANT VARCHAR2(32)       := $$PLSQL_UNIT;
    csbNivelTraza        CONSTANT NUMBER(2)          := pkg_traza.cnuNivelTrzDef;
	csbInicio   	     CONSTANT VARCHAR2(35) 	     := pkg_traza.csbINICIO; 
    Onuerrorcode         NUMBER:= pkg_error.CNUGENERIC_MESSAGE;
    Osberrormessage      VARCHAR2(2000);
    
    -- Variables
    nuAnioAnterior  NUMBER; -- Anio anterior cuando el mes es 1
    nuMesAnterior   NUMBER; -- Mes anterior al actual    nuLeAnteDefault NUMBER := NULL; -- Valor de la lectura anterior por default
    nuLeFeAnDefault DATE := NULL; -- Fecha de lectura anterior por default
    onufectAnte     DATE;
    
    CURSOR cufectAnte(p_MesAnterior ldc_temp_planfaca_sge.pafcmes%TYPE,
                      p_AnioAnterior ldc_temp_planfaca_sge.pafcano%TYPE )
    IS
    SELECT pafcfein
      FROM (SELECT /*+ INDEX(lectura IDXLECTURA02) */ pafcfein
              FROM ldc_temp_planfaca_sge
             WHERE pafccicl = inucicl
               AND pafcmes = p_MesAnterior
               AND pafcano = p_AnioAnterior
              ORDER BY pafcfein DESC)
     WHERE ROWNUM = 1;
     
BEGIN

    pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
    pkg_error.prInicializaError(onuerrorcode, osberrormessage);
    pkg_traza.trace(csbMetodo ||' inucicl: ' || inucicl, csbNivelTraza);
    pkg_traza.trace(csbMetodo ||' inuAnio: ' || inuAnio, csbNivelTraza);
    pkg_traza.trace(csbMetodo ||' inuMes: ' || inuMes, csbNivelTraza);
    
    -- Se valida el mes que llega es 1 para el manejo del anio anterior
    IF inuMes = 1 THEN
    
      nuAnioAnterior := inuAnio - 1;
      nuMesAnterior  := 12;
    
    ELSE
    
      nuAnioAnterior := inuAnio;
      nuMesAnterior  := inuMes - 1;
    
    END IF;

    pkg_traza.trace(csbMetodo ||' nuAnioAnterior: ' || nuAnioAnterior, csbNivelTraza);
    pkg_traza.trace(csbMetodo ||' nuMesAnterior: ' || nuMesAnterior, csbNivelTraza);    
    
        
    OPEN cufectAnte(nuMesAnterior, nuAnioAnterior );
    FETCH cufectAnte INTO onufectAnte;
    CLOSE cufectAnte;
    
   
    pkg_traza.trace(csbMetodo ||' onufectAnte: ' || onufectAnte, csbNivelTraza);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    
    RETURN onufectAnte+1;
     
EXCEPTION
    WHEN OTHERS THEN
         pkg_Error.setError;
         pkg_Error.getError(onuerrorcode, osberrormessage);
         pkg_traza.trace(csbMetodo ||' osberrormessage: ' || osberrormessage, csbNivelTraza);
         pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
         onufectAnte := NULL;
         RETURN NULL;
END PRFECHAANTERIORPERI; 
/
PROMPT "                                                            "
PROMPT OTORGA PERMISOS ESQUEMA sobre funcion PRFECHAANTERIORPERI
BEGIN
    pkg_utilidades.prAplicarPermisos('PRFECHAANTERIORPERI', 'ADM_PERSON'); 
END;
/
PROMPT "                                                            "
PROMPT OTORGA PERMISOS a REXEREPORTES sobre funcion PRFECHAANTERIORPERI
GRANT EXECUTE ON ADM_PERSON.PRFECHAANTERIORPERI TO REXEREPORTES;
/
