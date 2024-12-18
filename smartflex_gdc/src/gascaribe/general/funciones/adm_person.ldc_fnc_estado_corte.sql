CREATE OR REPLACE FUNCTION ADM_PERSON.LDC_FNC_ESTADO_CORTE (inunuse  pr_product.product_id%TYPE,
                                                            idtfecha DATE)
RETURN NUMBER IS
/**************************************************************************
  Autor       : Francisco Castro
  Fecha       : 2015-05-19
  Descripcion : Funcion que determina el estado de corte de un producto a una fecha especificada

  Parametros Entrada
    inunuse Producto
    idtfecha Fecha en la que se desea saber el estado de corte

  Valor de salida
    est_corte


 HISTORIA DE MODIFICACIONES
   FECHA        AUTOR       DESCRIPCION
   15/02/2023   Adrianavg   OSF-2181: Migrar del esquema OPEN al esquema ADM_PERSON
                            Se retira el esquema OPEN antepuesto a pr_product,hicaesco,servsusc 
                            Se declaran variables para la gestión de trazas, se hace uso del pkg_traza.trace
                            Se ajusta el bloque de exceptiones según pautas técnicas
***************************************************************************/
    --Se declaran variables para la gestión de trazas
    csbMetodo            CONSTANT VARCHAR2(32)       := $$PLSQL_UNIT;
    csbNivelTraza        CONSTANT NUMBER(2)          := pkg_traza.cnuNivelTrzDef; 
    csbInicio   	     CONSTANT VARCHAR2(35) 	     := pkg_traza.csbINICIO;   
    Onuerrorcode         NUMBER:= pkg_error.CNUGENERIC_MESSAGE;	
    Osberrormessage      VARCHAR2(2000);

    est_corte NUMBER;
    
    CURSOR Cuhicaesco IS
     SELECT hcececac
       FROM (SELECT hcececac
               FROM hicaesco
              WHERE hcecnuse = inunuse
                AND hcecfech < idtfecha
              ORDER BY hcecfech DESC)
       WHERE ROWNUM=1;
    
    CURSOR Cuservsusc IS
     SELECT sesuesco
       FROM servsusc
      WHERE sesunuse = inunuse;

BEGIN

    pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
    pkg_error.prInicializaError(onuerrorcode, osberrormessage);
    pkg_traza.trace(csbMetodo ||' inunuse: ' || inunuse, csbNivelTraza);    
    pkg_traza.trace(csbMetodo ||' idtfecha: ' || idtfecha, csbNivelTraza);
    
    OPEN cuhicaesco;
    FETCH cuhicaesco INTO est_corte;
    IF cuhicaesco%notfound THEN
        OPEN cuservsusc;
        FETCH cuservsusc INTO est_corte;
        IF cuservsusc%notfound THEN
           est_corte := -1;
        END IF;
        CLOSE cuservsusc;
    END IF;
    CLOSE cuhicaesco;
    
    pkg_traza.trace(csbMetodo ||' est_corte: ' || est_corte, csbNivelTraza);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
      
    RETURN ( est_corte );
EXCEPTION
    WHEN OTHERS THEN
         pkg_Error.setError;
         pkg_Error.getError(onuerrorcode, osberrormessage);
         pkg_traza.trace(csbMetodo ||' osberrormessage: ' || osberrormessage, csbNivelTraza);
         pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
         RETURN -1;
END LDC_FNC_ESTADO_CORTE;
/
PROMPT "                                                            "
PROMPT OTORGA PERMISOS ESQUEMA sobre funcion LDC_FNC_ESTADO_CORTE
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_FNC_ESTADO_CORTE', 'ADM_PERSON'); 
END;
/