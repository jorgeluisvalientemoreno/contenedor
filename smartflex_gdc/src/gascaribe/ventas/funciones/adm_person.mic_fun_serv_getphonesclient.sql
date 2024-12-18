CREATE OR REPLACE FUNCTION ADM_PERSON.MIC_FUN_SERV_GETPHONESCLIENT( inusubscriber ge_subscriber.subscriber_id%TYPE )
RETURN VARCHAR2 IS
/*********************************************************************************************
  Propiedad intelectual de Horbart S.A
  Funcion     : MIC_FUN_SERV_GETPHONESCLIENT
  Descripcion : 

  Autor  :
  Fecha  : 

  Historia de Modificaciones
  DD-MM-YYYY    <Autor>.SAONNNNN        Modificacion
  -----------  -------------------    -------------------------------------
  20/02/2024       Adrianavg            OSF-2183: Se migra del esquema OPEN al esquema ADM_PERSON
                                        Se declaran variables para la gestión de trazas, se hace uso del pkg_traza.trace	
                                        Se ajusta el bloque de excepciones según las pautas técnicas
                                        Se reemplaza SELECT-INTO por cursor cuVarParameter
                                        Se retira el esquema OPEN antepuesto a ld_bosubsidy
  **********************************************************************************************/
    --Se declaran variables para la gestión de trazas
    csbMetodo            CONSTANT VARCHAR2(32)       := $$PLSQL_UNIT;
    csbNivelTraza        CONSTANT NUMBER(2)          := pkg_traza.cnuNivelTrzDef;
	csbInicio   	     CONSTANT VARCHAR2(35) 	     := pkg_traza.csbINICIO; 
    Onuerrorcode         NUMBER:= pkg_error.CNUGENERIC_MESSAGE;
    Osberrormessage      VARCHAR2(2000);
    
    Var_Parameter VARCHAR2(1000);
    
    CURSOR cuVarParameter
    IS
    SELECT LD_BOSUBSIDY.Fnugetphonesclient(inusubscriber) 
      FROM dual;    

BEGIN
    
    pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
    pkg_error.prInicializaError(onuerrorcode, osberrormessage);
    pkg_traza.trace(csbMetodo ||' inusubscriber: '  || inusubscriber, csbNivelTraza);
   
    OPEN cuVarParameter;
    FETCH cuVarParameter INTO Var_Parameter;
    CLOSE cuVarParameter;
    
    pkg_traza.trace(csbMetodo ||' Var_Parameter: '  || Var_Parameter, csbNivelTraza);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);    

    RETURN(Var_Parameter);
    
EXCEPTION
    WHEN OTHERS THEN
         pkg_Error.setError;
         pkg_Error.getError(onuerrorcode, osberrormessage);
         pkg_traza.trace(csbMetodo ||' osberrormessage: ' || osberrormessage, csbNivelTraza);
         pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
         RETURN(Var_Parameter);
END MIC_FUN_SERV_GETPHONESCLIENT;
/
PROMPT "                                                            "
PROMPT OTORGA PERMISOS ESQUEMA sobre funcion MIC_FUN_SERV_GETPHONESCLIENT
BEGIN
    pkg_utilidades.prAplicarPermisos('MIC_FUN_SERV_GETPHONESCLIENT', 'ADM_PERSON'); 
END;
/
