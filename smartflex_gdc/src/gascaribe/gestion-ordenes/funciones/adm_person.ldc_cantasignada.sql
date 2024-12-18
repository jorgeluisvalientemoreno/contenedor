CREATE OR REPLACE FUNCTION ADM_PERSON.LDC_CANTASIGNADA  (nucuad or_operating_unit.operating_unit_id%TYPE,
                                                         nuorden or_order.order_id%TYPE,
                                                         sbsavedata or_order.saved_data_values%TYPE) 
RETURN NUMBER IS
/*****************************************************************************************************************
    Autor       : HB
    caso        :633
    Fecha       : 2021-07-19
    Descripcion : Se halla cantidad de ordenes asignadas por contratista ofertados de cartera de tal manera que si es una orden que se encuentra
                  en la tabla de lecturas especiales (que pertenece a las unidades op del parametro UNI_OPE_LEC_ESP) cuente las veces que se leyo
                  en esa tabla, pero si no es de esas unidades cuente 1.

    Parametros Entrada  nuCuad unid operativa
                        nuorden orden
    Valor de salida

   HISTORIA DE MODIFICACIONES
     FECHA        AUTOR     DESCRIPCION
     15/02/2023   Adrianavg OSF-2181: Migrar del esquema OPEN al esquema ADM_PERSON
                            Se retira codigo comentado y esquema OPEN antepuesto a or_order_items y ldc_cm_lectesp_crit
                            Se reemplaza SELECT-INTO por Cursor CuNucantidad
                            Se declaran variables para la gestión de trazas, se hace uso del pkg_traza.trace
                            Se ajusta el bloque de exceptiones según pautas técnicas
********************************************************************************************************************/
    --Se declaran variables para la gestión de trazas
    csbMetodo            CONSTANT VARCHAR2(32)       := $$PLSQL_UNIT;
    csbNivelTraza        CONSTANT NUMBER(2)          := pkg_traza.cnuNivelTrzDef; 
    csbInicio   	     CONSTANT VARCHAR2(35) 	     := pkg_traza.csbINICIO;   
    Onuerrorcode         NUMBER:= pkg_error.CNUGENERIC_MESSAGE;	
    Osberrormessage      VARCHAR2(2000);
    
    nucantidad number;

    CURSOR CuNucantidad
    IS
    SELECT nvl(i.legal_item_amount, 0) 
      FROM or_order_items i, ldc_cm_lectesp_crit t
     WHERE i.order_id = nuorden
       AND i.order_id = t.order_id
       AND i.items_id = dald_parameter.fnugetnumeric_value('COD_ACT_LEC');    
       
BEGIN

    pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
    pkg_error.prInicializaError(onuerrorcode, osberrormessage);
    pkg_traza.trace(csbMetodo ||' nucuad: ' || nucuad, csbNivelTraza);
    pkg_traza.trace(csbMetodo ||' nuorden: ' || nuorden, csbNivelTraza);
    pkg_traza.trace(csbMetodo ||' sbsavedata: ' || sbsavedata, csbNivelTraza);

    IF INSTR(','  || dald_parameter.fsbgetvalue_chain('UNI_OPE_LEC_ESP') || ',', ',' || nucuad || ',') > 0 THEN
        IF nvl(sbsavedata, 'X') != 'ORDER_GROUPED' THEN
        
           OPEN CuNucantidad;
           FETCH CuNucantidad INTO nucantidad;
           CLOSE CuNucantidad;
           
           pkg_traza.trace(csbMetodo ||' nucantidad: ' || nucantidad, csbNivelTraza);
           pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
           RETURN nvl(nucantidad, 0);
           
        ELSE
           pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);        
           RETURN 0;
        END IF;

    ELSE        
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN 1;
    END IF;
    
EXCEPTION
    WHEN OTHERS THEN
         pkg_Error.setError;
         pkg_Error.getError(onuerrorcode, osberrormessage);
         pkg_traza.trace(csbMetodo ||' osberrormessage: ' || osberrormessage, csbNivelTraza);
         pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);     
         RETURN 1;
END LDC_CANTASIGNADA;
/
PROMPT "                                                            "
PROMPT OTORGA PERMISOS ESQUEMA sobre funcion LDC_CANTASIGNADA
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_CANTASIGNADA', 'ADM_PERSON'); 
END;
/
PROMPT "                                                            "
PROMPT OTORGA PERMISOS a REPORTES sobre funcion LDC_CANTASIGNADA
GRANT EXECUTE ON ADM_PERSON.LDC_CANTASIGNADA TO REPORTES;
/