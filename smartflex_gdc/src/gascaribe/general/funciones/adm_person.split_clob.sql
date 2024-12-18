CREATE OR REPLACE FUNCTION ADM_PERSON.SPLIT_CLOB (P_LIST CLOB, P_DEL VARCHAR2) 
RETURN SPLIT_TBL PIPELINED IS

      /*******************************************************************************
     Metodo:       Split_clob
     Descripcion:  Funcion que retorna la cadena separada de una serie de cadenas concatenadas,
				   la cadena principal es de tipo CLOB, lo cual esta funcion recibirÃ¡ cadenas
				   concatenadas de mas de 4000 caracteres.
     Fecha:        07/10/2019

     Entrada        Descripcion
     p_list:        Cadena concatenada
     P_DEL:         Delimitador

     Salida         Descripcion
     split_tbl      cadena separada

     Historia de Modificaciones
     Adrianavg   20/02/2024      OSF-2183: Se migra del esquema OPEN al esquema ADM_PERSON
                                 Se declaran variables para la gestión de trazas, se hace uso del pkg_traza.trace
                                 Se adiciona el bloque de excepciones WHEN OTHERS según las pautas técnicas                       
    *******************************************************************************/
    --Se declaran variables para la gestión de trazas
    csbMetodo            CONSTANT VARCHAR2(32)       := $$PLSQL_UNIT;
    csbNivelTraza        CONSTANT NUMBER(2)          := pkg_traza.cnuNivelTrzDef;
	csbInicio   	     CONSTANT VARCHAR2(35) 	     := pkg_traza.csbINICIO; 
    Onuerrorcode         NUMBER:= pkg_error.CNUGENERIC_MESSAGE;
    Osberrormessage      VARCHAR2(2000);
    
    L_IDX  PLS_INTEGER;
    L_LIST VARCHAR2(32767) := P_LIST;

BEGIN

    pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
    pkg_error.prInicializaError(onuerrorcode, osberrormessage);
    pkg_traza.trace(csbMetodo ||' P_LIST: ' || P_LIST, csbNivelTraza);
    pkg_traza.trace(csbMetodo ||' P_DEL: ' || P_DEL, csbNivelTraza); 
    
    LOOP
      l_idx := instr(l_list, p_del);
      pkg_traza.trace(csbMetodo ||' L_IDX: ' || l_idx, csbNivelTraza);
      
      IF L_IDX > 0 THEN
        PIPE ROW(SUBSTR(L_LIST, 1, L_IDX - 1));
        l_list := substr(l_list, l_idx + LENGTH(p_del));
        pkg_traza.trace(csbMetodo ||' L_IDX > 0, L_LIST: ' || l_list, csbNivelTraza); 
      ELSE
        PIPE ROW(L_LIST);
        pkg_traza.trace(csbMetodo ||' ELSE, L_LIST: ' || l_list, csbNivelTraza); 
        EXIT;
      END IF;
    END LOOP;
    
    pkg_traza.trace(csbMetodo ||' RETURN, L_LIST: ' || l_list, csbNivelTraza);    
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    
    RETURN;
EXCEPTION
    WHEN OTHERS THEN
         pkg_Error.setError;
         pkg_Error.getError(onuerrorcode, osberrormessage);
         pkg_traza.trace(csbMetodo ||' osberrormessage: ' || osberrormessage, csbNivelTraza);
         pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR); 
END SPLIT_CLOB;
/
PROMPT "                                                            "
PROMPT OTORGA PERMISOS ESQUEMA sobre funcion SPLIT_CLOB
BEGIN
    pkg_utilidades.prAplicarPermisos('SPLIT_CLOB', 'ADM_PERSON'); 
END;
/
