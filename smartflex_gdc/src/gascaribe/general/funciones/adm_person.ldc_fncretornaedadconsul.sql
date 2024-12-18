CREATE OR REPLACE FUNCTION ADM_PERSON.LDC_FNCRETORNAEDADCONSUL(sbpbasedatos VARCHAR2,
                                                               nuptipr NUMBER,
                                                               nupara NUMBER) 
RETURN NUMBER IS
/**************************************************************************
  Autor       : John Jairo Jimenez Marimon
  Fecha       : 2015-03-23
  Descripcion : Obtenemos edades por gasera

  Parametros Entrada
    sbpbasedatos basedatos
    nuptipr tipo_producto
    nupara  ?

  Valor de salida
    nuparedad  edad gasera 

 HISTORIA DE MODIFICACIONES
   FECHA        AUTOR     DESCRIPCION
   15/02/2023   Adrianavg OSF-2181: Migrar del esquema OPEN al esquema ADM_PERSON
                          Se retira el esquema OPEN antepuesto a bases_datos_osf 
                          Se reemplaza SELECT-INTO por Cursor CuEdadGasera
                          Se declaran variables para la gestión de trazas, se hace uso del pkg_traza.trace
                          Se añade bloque de exceptiones when others según pautas técnicas
***************************************************************************/
    --Se declaran variables para la gestión de trazas
    csbMetodo            CONSTANT VARCHAR2(32)       := $$PLSQL_UNIT;
    csbNivelTraza        CONSTANT NUMBER(2)          := pkg_traza.cnuNivelTrzDef; 
    csbInicio   	     CONSTANT VARCHAR2(35) 	     := pkg_traza.csbINICIO;   
    Onuerrorcode         NUMBER:= pkg_error.CNUGENERIC_MESSAGE;	
    Osberrormessage      VARCHAR2(2000);
    
    nuparedad bases_datos_osf.cartera_vencida%TYPE;
    
    CURSOR CuEdadGasera
    IS
    SELECT decode(nupara,1,k.cartera_vencida,k.cartera_mas_90)
      FROM bases_datos_osf k
     WHERE TRIM(k.basedatos) = TRIM(sbpbasedatos)
       AND k.tipo_producto   = nuptipr;    
    
BEGIN

    pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
    pkg_error.prInicializaError(onuerrorcode, osberrormessage);
    pkg_traza.trace(csbMetodo ||' basedatos: ' || sbpbasedatos, csbNivelTraza);    
    pkg_traza.trace(csbMetodo ||' tipo_producto: ' || nuptipr, csbNivelTraza);  
    pkg_traza.trace(csbMetodo ||' nupara: ' || nupara, csbNivelTraza);      
    
    BEGIN
        OPEN CuEdadGasera;
        FETCH CuEdadGasera INTO nuparedad;
        CLOSE CuEdadGasera;
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
        nuparedad := 0;
        pkg_traza.trace(csbMetodo ||' edad gasera: ' || nuparedad, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);        
        RETURN nuparedad;
    END;

    pkg_traza.trace(csbMetodo ||' edad gasera: ' || nuparedad, csbNivelTraza);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 
      
    RETURN nuparedad;
EXCEPTION
 WHEN OTHERS THEN 
      pkg_Error.setError;
      pkg_Error.getError(onuerrorcode, osberrormessage);
      pkg_traza.trace(csbMetodo ||' osberrormessage: ' || osberrormessage, csbNivelTraza);
      pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);      
      RETURN nuparedad; 
END LDC_FNCRETORNAEDADCONSUL;
/
PROMPT "                                                            "
PROMPT OTORGA PERMISOS ESQUEMA sobre funcion LDC_FNCRETORNAEDADCONSUL
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_FNCRETORNAEDADCONSUL', 'ADM_PERSON'); 
END;
/