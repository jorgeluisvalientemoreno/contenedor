CREATE OR REPLACE FUNCTION ADM_PERSON.LDC_VALIDATITRSECERT(inuOrder_id IN  OR_ORDER.ORDER_ID%TYPE)
RETURN NUMBER IS

    /**************************************************************
      Propiedad intelectual PETI.
    
      procedimiento  :  ldc_validatitrsecert
     Autor  :
     Fecha  :
    
    Historia de Modificaciones
    Fecha       Autor             Modificacion
    =========   =========       ====================
    15-10-2020  HORBATH         CA 34 se coloca restriccion para que el proceso no valida para GDC
    20/02/2024  Adrianavg       OSF-2183: Se migra del esquema OPEN al esquema ADM_PERSON
                                Se declaran variables para la gestión de trazas, se hace uso del pkg_traza.trace	
                                se adiciona bloque de excepciones when others según las pautas técnicas
                                Se reemplaza SELECT-INTO por cursor cuConta    
    **************************************************************/
    --Se declaran variables para la gestión de trazas
    csbMetodo            CONSTANT VARCHAR2(32)       := $$PLSQL_UNIT;
    csbNivelTraza        CONSTANT NUMBER(2)          := pkg_traza.cnuNivelTrzDef;
	csbInicio   	     CONSTANT VARCHAR2(35) 	     := pkg_traza.csbINICIO; 
    Onuerrorcode         NUMBER:= pkg_error.CNUGENERIC_MESSAGE;
    Osberrormessage      VARCHAR2(2000);
    
    nuconta        NUMBER DEFAULT 0;
    sbdescription  or_task_type.description%TYPE;
    
    --INICIA CA 34
    sbNit  VARCHAR2(400) :=  dald_parameter.fsbgetvalue_chain('NIT_GDC', null);
    sbNitEmp VARCHAR2(400);
    
    CURSOR cugetSistema IS
    SELECT SISTNITC
      FROM sistema
     WHERE SISTCODI = 99;
    --FIN CA 34
    
    CURSOR cuConta
    IS
    SELECT COUNT(1) 
      FROM or_order o, ldc_trab_cert l
     WHERE o.order_id     = inuOrder_id
       AND o.task_type_id = l.id_trabcert;    

BEGIN
    
    pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
    pkg_error.prInicializaError(onuerrorcode, osberrormessage);
    pkg_traza.trace(csbMetodo ||' inuOrder_id: '  || inuOrder_id, csbNivelTraza);
    
    --INICIO CA 34
    OPEN cugetSistema;
    FETCH cugetSistema INTO sbNitEmp;
    CLOSE cugetSistema;
    pkg_traza.trace(csbMetodo ||' sbNitEmp: '  || sbNitEmp, csbNivelTraza); 
    pkg_traza.trace(csbMetodo ||' sbNit: '  || sbNit, csbNivelTraza);  
    
    IF sbNitEmp  = sbNit THEN
        pkg_traza.trace(csbMetodo ||' sbNitEmp es igual a sbNit', csbNivelTraza);  
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);        
        RETURN 0;
    END IF;
    --FIN CA 34
    
    OPEN cuConta;
    FETCH cuConta INTO nuconta;
    CLOSE cuConta;
        
    pkg_traza.trace(csbMetodo ||' nuconta: '  || nuconta, csbNivelTraza);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);   
    
    RETURN nuconta;
EXCEPTION
    WHEN OTHERS THEN
         pkg_Error.setError;
         pkg_Error.getError(onuerrorcode, osberrormessage);
         pkg_traza.trace(csbMetodo ||' osberrormessage: ' || osberrormessage, csbNivelTraza);
         pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR); 
         RETURN nuconta;
END LDC_VALIDATITRSECERT;
/
PROMPT "                                                            "
PROMPT OTORGA PERMISOS ESQUEMA sobre funcion LDC_VALIDATITRSECERT
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_VALIDATITRSECERT', 'ADM_PERSON'); 
END;
/
PROMPT "                                                            "
PROMPT OTORGA PERMISOS a REXEREPORTES sobre funcion LDC_VALIDATITRSECERT
GRANT EXECUTE ON ADM_PERSON.LDC_VALIDATITRSECERT TO REXEREPORTES;
/
