CREATE OR REPLACE FUNCTION ADM_PERSON.FSBESTADOFINANCIERO (nuEstafina NUMBER, nuSuscripcion NUMBER)
RETURN VARCHAR2 AS
  /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : FSBESTADOFINANCIERO
    Descripcion    : Función para obtener el estado financiero
    Autor          :
    Fecha          :

    Parametros              Descripcion
    ============         ===================

    Fecha             Autor             Modificacion
    =========       =========           ====================
    07/02/2023     Adrianavg            OSF-2097: Migrar del esquema OPEN al esquema ADM_PERSON
                                        Se crea cursor CuCorriente en reemplazo del SELECT-INTO
                                        Se declaran variables para la gestión de trazas, se hace uso del pkg_traza.trace
                                        Se adiciona bloque de exceptions when others segun pautas técnicas
  ******************************************************************/
    --Se declaran variables para la gestión de trazas
    csbMetodo            CONSTANT VARCHAR2(32)       := $$PLSQL_UNIT;
    csbNivelTraza        CONSTANT NUMBER(2)          := pkg_traza.cnuNivelTrzDef; 
    csbInicio   	       CONSTANT VARCHAR2(35) 	     := pkg_traza.csbINICIO; 
    Onuerrorcode         NUMBER:= pkg_error.CNUGENERIC_MESSAGE;	
    Osberrormessage      VARCHAR2(2000);
    
    nuRetorno VARCHAR2(2) := NULL;
    
    CURSOR Cuentas
    IS
    SELECT count(1)
      FROM CUENCOBR
     WHERE CUCONUSE =  nuSuscripcion
       AND NVL(CUCOSACU,0) >= 0;
    
    nuCorriente NUMBER := 0;
    nuCantidad  number := 0;
    
    CURSOR cuCorriente 
    IS
    SELECT COUNT(1)
      FROM cuencobr
     WHERE cuconuse = nususcripcion
       AND nvl(cucosacu, 0) > 0
       AND SYSDATE > cucofeve;
 
BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio); 
    pkg_error.prInicializaError(onuerrorcode, osberrormessage);
    pkg_traza.trace(csbMetodo ||' nuEstafina: ' || nuEstafina, csbNivelTraza);
    
    IF nuEstafina = 4 THEN
      nuRetorno := 'C';
    ELSE
       OPEN Cuentas;
      FETCH Cuentas INTO nuCorriente;
      CLOSE Cuentas;
      pkg_traza.trace(csbMetodo ||' nuCorriente1: ' || nuCorriente, csbNivelTraza);

      IF nuCorriente = 0 THEN
        nuRetorno := 'A';
      ELSE
        IF nuCorriente >= 2 THEN
           nuRetorno:='M';
        ELSE
            OPEN cuCorriente;
           FETCH cuCorriente INTO nuCorriente;
           CLOSE cuCorriente;
           pkg_traza.trace(csbMetodo ||' nuCorriente2: ' || nuCorriente, csbNivelTraza);
           IF nuCorriente = 1 THEN
              nuRetorno:='M';
           ELSE
              nuRetorno:='D';
           END IF;
        END IF;
      END IF;
    END IF;
    
    pkg_traza.trace(csbMetodo ||' nuRetorno: ' || nuRetorno, csbNivelTraza);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    
    RETURN(NURETORNO);
EXCEPTION 
    WHEN OTHERS THEN 
         pkg_error.seterror;
         pkg_Error.getError(onuerrorcode, osberrormessage);
         pkg_traza.trace(csbMetodo ||' osberrormessage: ' || osberrormessage, csbNivelTraza);
         pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
END fsbEstadoFinanciero;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre funcion FSBESTADOFINANCIERO
BEGIN
    pkg_utilidades.prAplicarPermisos('FSBESTADOFINANCIERO', 'ADM_PERSON'); 
END;
/
PROMPT OTORGA PERMISOS a REPORTES sobre funcion FSBESTADOFINANCIERO
GRANT EXECUTE ON ADM_PERSON.FSBESTADOFINANCIERO TO REPORTES;
/