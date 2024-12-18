CREATE OR REPLACE FUNCTION ADM_PERSON.LDC_FNCRECUPERADEUDASVAL (nupano  NUMBER,
                                                                nupmes  NUMBER,
                                                                nuptipr NUMBER,
                                                                nupdepa NUMBER,
                                                                nuploca NUMBER,
                                                                nupcate NUMBER,
                                                                nupar   NUMBER
) RETURN NUMBER IS
/**************************************************************************
  Autor       : John Jairo Jimenez Marimon
  Fecha       : 2015-03-23
  Descripcion : Obtenemos datos para el acumulado total de cartera

  Parametros Entrada
    nuano Año
    numes Mes

  Valor de salida
    sbmen  mensaje
    error  codigo del error

 HISTORIA DE MODIFICACIONES
   FECHA            AUTOR           DESCRIPCION
   20/02/2024       Adrianavg       OSF-2183: Se migra del esquema OPEN al esquema ADM_PERSON
                                    Se declaran variables para la gestión de trazas, se hace uso del pkg_traza.trace	
                                    Se adiciona el bloque de excepciones WHEN OTHERS según las pautas técnicas	
                                    Se retira el esquema OPEN antepuesto a TABLA: ldc_osf_sesucier, total_cart_mes
                                    Se retira el esquema OPEN antepuesto a FUNCIÓN ldc_fncretornaedadconsul                                    
                                    Se retira código comentariado
                                    Se reemplaza SELECT-INTO por cursor cuTotalvencidaCateg, cuTotalvencidaTipProd , cuCartmas90 , cuTotalmas90, cuCliemas90, cuCieactivos
***************************************************************************/
    --Se declaran variables para la gestión de trazas
    csbMetodo            CONSTANT VARCHAR2(32)       := $$PLSQL_UNIT;
    csbNivelTraza        CONSTANT NUMBER(2)          := pkg_traza.cnuNivelTrzDef;
	csbInicio   	     CONSTANT VARCHAR2(35) 	     := pkg_traza.csbINICIO; 
    Onuerrorcode         NUMBER:= pkg_error.CNUGENERIC_MESSAGE;
    Osberrormessage      VARCHAR2(2000);

    nutotalvencida total_cart_mes.vencida%TYPE DEFAULT 0;
    nutotalmas90   total_cart_mes.vencida%TYPE DEFAULT 0;
    nucartmas90    total_cart_mes.vencida%TYPE DEFAULT 0;
    nucliemas90    total_cart_mes.cantidad_clientes%TYPE DEFAULT 0;
    nucieactivos   total_cart_mes.cantidad_clientes%TYPE DEFAULT 0;
    
    CURSOR cuTotalvencidaCateg
    IS
    SELECT NVL(SUM(z.deuda_corriente_vencida),0)
      FROM ldc_osf_sesucier z
     WHERE z.nuano         = nupano
       AND z.numes         = nupmes
       AND z.edad          >= ldc_fncretornaedadconsul(upper(trim(sys_context('userenv','db_name'))),z.tipo_producto,1)
       AND z.departamento  = nupdepa
       AND z.localidad     = nuploca
       AND z.tipo_producto = nuptipr
       AND z.categoria     = nupcate
       AND area_servicio   = area_servicio;

    CURSOR cuTotalvencidaTipProd
    IS
    SELECT NVL(SUM(s.vencida),0)
      FROM total_cart_mes s
     WHERE s.nuano         = nupano
       AND s.numes         = nupmes
       AND s.edad         >= ldc_fncretornaedadconsul(upper(trim(sys_context('userenv','db_name'))),s.tipo_producto,1)
       AND s.departamento  = nupdepa
       AND s.localidad     = nuploca
       AND s.tipo_producto = nuptipr
       AND s.categoria     = nupcate;
       
    CURSOR cuCartmas90
    IS
    SELECT NVL(SUM(s.vencida+s.no_vencida),0)
      FROM total_cart_mes s
     WHERE s.nuano         = nupano
       AND s.numes         = nupmes
       AND s.edad         >= ldc_fncretornaedadconsul(upper(trim(sys_context('userenv','db_name'))),s.tipo_producto,2)
       AND s.departamento  = nupdepa
       AND s.localidad     = nuploca
       AND s.tipo_producto = nuptipr
       AND s.categoria     = nupcate;    

    CURSOR cuTotalmas90
    IS
    SELECT NVL(SUM(sesusape+deuda_no_corriente),0)
      FROM ldc_osf_sesucier s
     WHERE s.nuano         = nupano
       AND s.numes         = nupmes
       AND s.edad         >= ldc_fncretornaedadconsul(upper(trim(sys_context('userenv','db_name'))),s.tipo_producto,2)
       AND s.departamento  = nupdepa
       AND s.localidad     = nuploca
       AND s.tipo_producto = nuptipr
       AND s.categoria     = nupcate
       AND area_servicio   = area_servicio;    
    
    CURSOR cuCliemas90
    IS
    SELECT NVL(SUM(s.cantidad_clientes),0)
      FROM total_cart_mes s
     WHERE s.nuano         = nupano
       AND s.numes         = nupmes
       AND s.edad          >= ldc_fncretornaedadconsul(upper(trim(sys_context('userenv','db_name'))),s.tipo_producto,2)
       AND s.departamento  = nupdepa
       AND s.localidad     = nuploca
       AND s.tipo_producto = nuptipr
       AND s.categoria     = nupcate;    

    CURSOR cuCieactivos
    IS
    SELECT NVL(SUM(s.cantidad_clientes),0)
      FROM total_cart_mes s
     WHERE s.nuano         = nupano
       AND s.numes         = nupmes
       AND s.estado_corte NOT IN (95,110)
       AND s.departamento  = nupdepa
       AND s.localidad     = nuploca
       AND s.tipo_producto = nuptipr
       AND s.categoria     = nupcate;    
     
BEGIN

    pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
    pkg_error.prInicializaError(onuerrorcode, osberrormessage);
    pkg_traza.trace(csbMetodo ||' nupano: '  || nupano|| ' , nupmes:  ' || nupmes, csbNivelTraza);
    pkg_traza.trace(csbMetodo ||' nuptipr: ' || nuptipr||' , nupdepa: ' || nupdepa, csbNivelTraza);
    pkg_traza.trace(csbMetodo ||' nuploca: ' || nuploca||' , nupcate: ' || nupcate, csbNivelTraza);
    pkg_traza.trace(csbMetodo ||' nupar: ' || nupar, csbNivelTraza);
                                                                
    nutotalvencida := 0;
    nutotalmas90   := 0;
    nucartmas90    := 0;
    nucliemas90    := 0;
    
    IF nupar = 1 THEN
        IF nuptipr IN ( 7055,7056 ) THEN
        
           OPEN cuTotalvencidaCateg;
           FETCH cuTotalvencidaCateg INTO nutotalvencida;
           CLOSE cuTotalvencidaCateg;
           
        ELSE
        
            OPEN cuTotalvencidaTipProd;
            FETCH cuTotalvencidaTipProd INTO nutotalvencida;
            CLOSE cuTotalvencidaTipProd;
            
        END IF;
        
        pkg_traza.trace(csbMetodo ||' totalvencida: ' || nutotalvencida, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        
        RETURN nutotalvencida;
        
    ELSIF nupar = 2 THEN
               
        OPEN cuCartmas90;
        FETCH cuCartmas90 INTO nucartmas90;
        CLOSE cuCartmas90;

        pkg_traza.trace(csbMetodo ||' cartmas90: ' || nucartmas90, csbNivelTraza);        
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        
        RETURN nucartmas90;
        
    ELSIF nupar = 3 THEN
    
        OPEN cuTotalmas90;
        FETCH cuTotalmas90 INTO nutotalmas90;
        CLOSE cuTotalmas90;
        
        pkg_traza.trace(csbMetodo ||' totalmas90: ' || nutotalmas90, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
         
        RETURN  nutotalmas90;
        
    ELSIF nupar = 4 THEN
    
        OPEN cuCliemas90;
        FETCH cuCliemas90 INTO nucliemas90;
        CLOSE cuCliemas90;

        pkg_traza.trace(csbMetodo ||' Cliemas90: ' || nucliemas90, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
                  
        RETURN nucliemas90;
        
    ELSE
        
        OPEN cuCieactivos;
        FETCH cuCieactivos INTO nucieactivos;
        CLOSE cuCieactivos;         

        pkg_traza.trace(csbMetodo ||' Cieactivos: ' || nucieactivos, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
                        
        RETURN nucieactivos;
    END IF;
    
EXCEPTION 
    WHEN OTHERS THEN
         pkg_Error.setError;
         pkg_Error.getError(onuerrorcode, osberrormessage);
         pkg_traza.trace(csbMetodo ||' osberrormessage: ' || osberrormessage, csbNivelTraza);
         pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
         RAISE pkg_Error.Controlled_Error;
END LDC_FNCRECUPERADEUDASVAL;
/
PROMPT "                                                            "
PROMPT OTORGA PERMISOS ESQUEMA sobre funcion LDC_FNCRECUPERADEUDASVAL
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_FNCRECUPERADEUDASVAL', 'ADM_PERSON'); 
END;
/
PROMPT "                                                            "
PROMPT OTORGA PERMISOS a REXEREPORTES sobre funcion LDC_FNCRECUPERADEUDASVAL
GRANT EXECUTE ON ADM_PERSON.LDC_FNCRECUPERADEUDASVAL TO REXEREPORTES;
/ 