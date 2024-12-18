CREATE OR REPLACE FUNCTION ADM_PERSON.LDC_CALCULAEDADMORAPROD(Nuproductid NUMBER) 
RETURN DATE IS
/**************************************************************************
  Autor       : John Jairo Jimenez Marimon
  Fecha       : 2013-07-10
  Descripcion : Obtiene edad de la mora del producto

  Parametros Entrada
     NUSESUNUSE Codigo del servicio suscrito

  Valor de Retorno
    nudias  dias de mora

 HISTORIA DE MODIFICACIONES
   FECHA        AUTOR     DESCRIPCION
   15/02/2023   Adrianavg OSF-2181: Migrar del esquema OPEN al esquema ADM_PERSON
                          Se reemplaza SELECT-INTO por Cursor CuCuenCobro
                          Se declaran variables para la gestión de trazas, se hace uso del pkg_traza.trace
                          Se ajusta el bloque de exceptiones según pautas técnicas
***************************************************************************/
    --Se declaran variables para la gestión de trazas
    csbMetodo            CONSTANT VARCHAR2(32)       := $$PLSQL_UNIT;
    csbNivelTraza        CONSTANT NUMBER(2)          := pkg_traza.cnuNivelTrzDef; 
    csbInicio   	     CONSTANT VARCHAR2(35) 	     := pkg_traza.csbINICIO;   
    Onuerrorcode         NUMBER:= pkg_error.CNUGENERIC_MESSAGE;	
    Osberrormessage      VARCHAR2(2000);
    
    dtfeve cuencobr.cucofeve%TYPE;
    
    CURSOR CuCuenCobro
    IS
    SELECT trunc(cucofeve) 
      FROM cuencobr b
     WHERE b.cucocodi =(SELECT MIN(cucocodi)
                          FROM cuencobr c
                         WHERE c.cuconuse = nuproductid
                           AND c.cucosacu > 0);    
BEGIN

    pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
    pkg_error.prInicializaError(onuerrorcode, osberrormessage);
    pkg_traza.trace(csbMetodo ||' nuproductid: ' || nuproductid, csbNivelTraza);    
    
    BEGIN
        OPEN CuCuenCobro;
        FETCH CuCuenCobro INTO dtfeve;
        CLOSE CuCuenCobro; 
    
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
        dtfeve := TO_DATE('01/01/1900','DD/MM/YYYY');
    END;
    
    pkg_traza.trace(csbMetodo ||' dtfeve: ' || dtfeve, csbNivelTraza);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 
    
    RETURN dtfeve;
EXCEPTION
 WHEN OTHERS THEN
      dtfeve := TO_DATE('01/01/1800','DD/MM/YYYY');
      pkg_Error.setError;
      pkg_Error.getError(onuerrorcode, osberrormessage);
      pkg_traza.trace(csbMetodo ||' osberrormessage: ' || osberrormessage, csbNivelTraza);
      pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);      
      RETURN dtfeve;
END LDC_CALCULAEDADMORAPROD;
/
PROMPT "                                                            "
PROMPT OTORGA PERMISOS ESQUEMA sobre funcion LDC_CALCULAEDADMORAPROD
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_CALCULAEDADMORAPROD', 'ADM_PERSON'); 
END;
/
PROMPT "                                                            "
PROMPT OTORGA PERMISOS a REPORTES sobre funcion LDC_CALCULAEDADMORAPROD
GRANT EXECUTE ON ADM_PERSON.LDC_CALCULAEDADMORAPROD TO REPORTES;
/