CREATE OR REPLACE FUNCTION ADM_PERSON.LDC_FNCRETORDENPADRE(nuordenhija or_order.order_id%TYPE)
RETURN NUMBER IS
/**************************************************************************
  Autor       : John Jairo Jimenez Marimon
  Fecha       : 2016-07-28
  Descripcion : Obtenemos orden padre

  Parametros Entrada
    nuano Año
    numes Mes

  Valor de salida
    sbmen  mensaje
    error  codigo del error

 HISTORIA DE MODIFICACIONES
   FECHA        AUTOR   DESCRIPCION
   15/02/2023   Adrianavg OSF-2181: Migrar del esquema OPEN al esquema ADM_PERSON
                          Se retira el esquema OPEN antepuesto a or_related_order,or_order 
                          Se reemplaza SELECT-INTO por Cursor CuOrdenPadre
                          Se declaran variables para la gestión de trazas, se hace uso del pkg_traza.trace
                          Se ajusta el bloque de exceptiones según pautas técnicas
***************************************************************************/
    --Se declaran variables para la gestión de trazas
    csbMetodo            CONSTANT VARCHAR2(32)       := $$PLSQL_UNIT;
    csbNivelTraza        CONSTANT NUMBER(2)          := pkg_traza.cnuNivelTrzDef; 
    csbInicio   	     CONSTANT VARCHAR2(35) 	     := pkg_traza.csbINICIO;   
    Onuerrorcode         NUMBER:= pkg_error.CNUGENERIC_MESSAGE;	
    Osberrormessage      VARCHAR2(2000);
    
    nuotordpadre or_order.order_id%TYPE;
    
    CURSOR CuOrdenPadre
    IS
    SELECT orden_padre
      FROM(
        SELECT ot.created_date, oy.order_id orden_padre
          FROM or_related_order oy, or_order ot
         WHERE oy.related_order_id = nuordenhija
           AND oy.order_id         = ot.order_id
      ORDER BY ot.created_date DESC
        )
    WHERE ROWNUM = 1;      
    
BEGIN

    pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
    pkg_error.prInicializaError(onuerrorcode, osberrormessage);
    pkg_traza.trace(csbMetodo ||' nuordenhija: ' || nuordenhija, csbNivelTraza);    
    
    nuotordpadre := NULL;
    OPEN CuOrdenPadre;
    FETCH CuOrdenPadre INTO nuotordpadre;
    CLOSE CuOrdenPadre;

    pkg_traza.trace(csbMetodo ||' nuotordpadre: ' || nuotordpadre, csbNivelTraza); 
    
    RETURN nuotordpadre;
EXCEPTION
 WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(onuerrorcode, osberrormessage);
      pkg_traza.trace(csbMetodo ||' osberrormessage: ' || osberrormessage, csbNivelTraza);
      pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);       
      RETURN NULL;
END LDC_FNCRETORDENPADRE;
/
PROMPT "                                                            "
PROMPT OTORGA PERMISOS ESQUEMA sobre funcion LDC_FNCRETORDENPADRE
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_FNCRETORDENPADRE', 'ADM_PERSON'); 
END;
/