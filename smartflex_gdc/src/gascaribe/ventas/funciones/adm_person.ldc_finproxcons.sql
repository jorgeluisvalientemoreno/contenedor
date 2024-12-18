CREATE OR REPLACE FUNCTION ADM_PERSON.LDC_FINPROXCONS(nuDocumento consecut.conscodi%TYPE)
RETURN NUMBER IS
PRAGMA AUTONOMOUS_TRANSACTION;
  /************************************************************************
   PROPIEDAD INTELECTUAL DE GASES DEL CARIBE E.S.P. SA

   FUNCION        : LDC_finProxCons
   AUTOR          : Ronald Colpas Cantillo
   FECHA          : Junio 14 del 2017
   DESCRIPCION    : Consulta el proximo consecutivo de la tabla consecut.

  Parametros de Entrada
  Parametros de Salida
  osbMes:  Mensaje de Error.

  Historia de Modificaciones
  Autor     Fecha        Descripcion
  Adrianavg 15/02/2023   OSF-2181: Migrar del esquema OPEN al esquema ADM_PERSON 
                         Se declaran variables para la gestión de trazas, se hace uso del pkg_traza.trace
                         Se ajusta el bloque de exceptiones según pautas técnicas
************************************************************************/
    --Se declaran variables para la gestión de trazas
    csbMetodo            CONSTANT VARCHAR2(32)       := $$PLSQL_UNIT;
    csbNivelTraza        CONSTANT NUMBER(2)          := pkg_traza.cnuNivelTrzDef; 
    csbInicio   	     CONSTANT VARCHAR2(35) 	     := pkg_traza.csbINICIO;   
    Onuerrorcode         NUMBER:= pkg_error.CNUGENERIC_MESSAGE;	
    Osberrormessage      VARCHAR2(2000);
    
    nuConsecut consecut.consnume%TYPE;
    fallo CONSTANT NUMBER := -1;
BEGIN

    pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
    pkg_error.prInicializaError(onuerrorcode, osberrormessage);
    pkg_traza.trace(csbMetodo ||' nuDocumento: ' || nuDocumento, csbNivelTraza);    
    
       UPDATE consecut
          SET consnume = consnume + 1
        WHERE conscodi = nudocumento
    RETURNING consnume INTO nuconsecut;
    COMMIT;
    pkg_traza.trace(csbMetodo ||' nuconsecut: ' || nuconsecut, csbNivelTraza); 
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
      
    RETURN ( nuconsecut - 1 );
  EXCEPTION
    WHEN OTHERS THEN
         pkg_Error.setError;
         pkg_Error.getError(onuerrorcode, osberrormessage);
         pkg_traza.trace(csbMetodo ||' osberrormessage: ' || osberrormessage, csbNivelTraza);
         pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
         RETURN(fallo);
END LDC_FINPROXCONS;
/
PROMPT "                                                            "
PROMPT OTORGA PERMISOS ESQUEMA sobre funcion LDC_FINPROXCONS
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_FINPROXCONS', 'ADM_PERSON'); 
END;
/
PROMPT "                                                            "
PROMPT OTORGA PERMISOS a REPORTES sobre funcion LDC_FINPROXCONS
GRANT EXECUTE ON ADM_PERSON.LDC_FINPROXCONS TO REPORTES;
/