CREATE OR REPLACE FUNCTION ADM_PERSON.LDC_VALIDASOLIVENTAFNBMERE( nupacontrato suscripc.susccodi%TYPE
) RETURN NUMBER IS
/*********************************************************************************************
  Propiedad intelectual de Horbart S.A
  Funcion     : ldc_validasoliventafnbmere
  Descripcion : Valida tipos de solicitudes para asignar medio de recepción

  Autor  :
  Fecha  : 20-07-2016

  Historia de Modificaciones

  DD-MM-YYYY    <Autor>.SAONNNNN        Modificacion
  -----------  -------------------    -------------------------------------
  20/02/2024       Adrianavg            OSF-2183: Se migra del esquema OPEN al esquema ADM_PERSON
                                        Se declaran variables para la gestión de trazas, se hace uso del pkg_traza.trace	
                                        Se ajusta el bloque de excepciones según las pautas técnicas 
  **********************************************************************************************/
    --Se declaran variables para la gestión de trazas
    csbMetodo            CONSTANT VARCHAR2(32)       := $$PLSQL_UNIT;
    csbNivelTraza        CONSTANT NUMBER(2)          := pkg_traza.cnuNivelTrzDef;
	csbInicio   	     CONSTANT VARCHAR2(35) 	     := pkg_traza.csbINICIO; 
    Onuerrorcode         NUMBER:= pkg_error.CNUGENERIC_MESSAGE;
    Osberrormessage      VARCHAR2(2000);
    
    CURSOR cusolicitudes(nucurcontrato suscripc.susccodi%TYPE) IS
    SELECT fecha_recibido, tipo_solicitud
     FROM(
         SELECT p.request_date  fecha_recibido, p.package_type_id tipo_solicitud
           FROM mo_packages p, mo_motive m
          WHERE p.package_type_id IN( dald_parameter.fnugetnumeric_value('LDC_TIPO_SOL_VISITA')
                                     ,dald_parameter.fnugetnumeric_value('LDC_TIPO_SOL_VISITA_XML')
                                    )
            AND p.motive_status_id in (13,14)
            AND m.subscription_id = nucurcontrato
            AND p.package_id      = m.package_id
          ORDER BY 1
          )
    WHERE ROWNUM = 1;
    
    nudiasvalidacion ld_parameter.numeric_value%TYPE;
    dtfechaval       DATE;
    numere           ge_reception_type.reception_type_id%TYPE;
    dtfecharegistro  DATE;
    
BEGIN
    
    pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
    pkg_error.prInicializaError(onuerrorcode, osberrormessage);
    pkg_traza.trace(csbMetodo ||' nupacontrato: '  || nupacontrato, csbNivelTraza);
   
    dtfecharegistro := SYSDATE;
    pkg_traza.trace(csbMetodo ||' dtfecharegistro: '  || dtfecharegistro, csbNivelTraza);    
    
    nudiasvalidacion := dald_parameter.fnugetnumeric_value('LDC_DIAS_VALIDACION_FECHA');
    pkg_traza.trace(csbMetodo ||' nudiasvalidacion: '  || nudiasvalidacion, csbNivelTraza);    
    
    numere := -1;
    FOR i IN cusolicitudes(nupacontrato) LOOP
        dtfechaval := i.fecha_recibido + nudiasvalidacion;
        pkg_traza.trace(csbMetodo ||' fecha_recibido: '  || i.fecha_recibido , csbNivelTraza);
        pkg_traza.trace(csbMetodo ||' fechaval: '  || dtfechaval, csbNivelTraza);
        IF trunc(dtfecharegistro) BETWEEN trunc(i.fecha_recibido) AND trunc(dtfechaval) THEN
            IF i.tipo_solicitud = dald_parameter.fnugetnumeric_value('LDC_TIPO_SOL_VISITA') THEN
                numere := dald_parameter.fnugetnumeric_value('MEDIO_RECEPCION_CALL_CENTER');
            ELSE
                numere := dald_parameter.fnugetnumeric_value('MEDIO_RECEPCION_PORTAL_WEB');
            END IF;
        END IF;
    END LOOP;
    
    pkg_traza.trace(csbMetodo ||' numere: '  || numere, csbNivelTraza);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);    
    
    RETURN numere;
EXCEPTION
    WHEN OTHERS THEN
         pkg_Error.setError;
         pkg_Error.getError(onuerrorcode, osberrormessage);
         pkg_traza.trace(csbMetodo ||' osberrormessage: ' || osberrormessage, csbNivelTraza);
         pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR); 
         numere := -2;
         RETURN numere;
END LDC_VALIDASOLIVENTAFNBMERE;
/
PROMPT "                                                            "
PROMPT OTORGA PERMISOS ESQUEMA sobre funcion LDC_VALIDASOLIVENTAFNBMERE
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_VALIDASOLIVENTAFNBMERE', 'ADM_PERSON'); 
END;
/
PROMPT "                                                            "
PROMPT OTORGA PERMISOS a REXEREPORTES sobre funcion LDC_VALIDASOLIVENTAFNBMERE
GRANT EXECUTE ON ADM_PERSON.LDC_VALIDASOLIVENTAFNBMERE TO REXEREPORTES;
/