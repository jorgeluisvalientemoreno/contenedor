CREATE OR REPLACE FUNCTION ADM_PERSON.LDC_FNUGETCATHIST (inuprod NUMBER,
                                                         inuano  NUMBER,
                                                         inumes  NUMBER) 
RETURN NUMBER IS
 /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : ldc_FnuGetCatHist
    Descripcion    : Funcion que devuelve la categoria que tenia un producto en un periodo (año-mes)
                     especificado (utiliza la tabla ldc_snapchotcreg)
                     Devulve -1 si no existe el producto en la tabla ldc_snapchotcreg en el periodo
                     especificado, o si hay un error.
    Autor          : F.Castro
    Fecha          : 07/02/2016

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============  ===================
    inuprod       Producto
    inuano        Año
    inumes        Mes

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
   15/02/2023         Adrianavg         OSF-2181: Migrar del esquema OPEN al esquema ADM_PERSON
                                        Se retira el esquema OPEN antepuesto a ldc_snapshotcreg_b
                                        Se declaran variables para la gestión de trazas, se hace uso del pkg_traza.trace
                                        Se ajusta el bloque de exceptiones según pautas técnicas
  ******************************************************************/
    --Se declaran variables para la gestión de trazas
    csbMetodo            CONSTANT VARCHAR2(32)       := $$PLSQL_UNIT;
    csbNivelTraza        CONSTANT NUMBER(2)          := pkg_traza.cnuNivelTrzDef; 
    csbInicio   	     CONSTANT VARCHAR2(35) 	     := pkg_traza.csbINICIO;   
    Onuerrorcode         NUMBER:= pkg_error.CNUGENERIC_MESSAGE;	
    Osberrormessage      VARCHAR2(2000);
    
    nucate NUMBER;
    
    CURSOR cuCate 
    IS
     SELECT idcategoria
       FROM ldc_snapshotcreg_b
      WHERE idproducto = inuprod
        AND anioperifac  = inuano
        AND mesperifac =   inumes
        AND idfactura IS NOT NULL
   ORDER BY IDCUENCOBR DESC;

BEGIN

    pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
    pkg_error.prInicializaError(onuerrorcode, osberrormessage);
    pkg_traza.trace(csbMetodo ||' inuprod: ' || inuprod, csbNivelTraza);    
    pkg_traza.trace(csbMetodo ||' inuano: ' || inuano, csbNivelTraza); 
    pkg_traza.trace(csbMetodo ||' inumes: ' || inumes, csbNivelTraza); 
   
    OPEN cucate;
    FETCH cucate INTO nucate;
    IF nucate IS NULL THEN
        nucate := -1;
    END IF;
    CLOSE cucate;
    
    pkg_traza.trace(csbMetodo ||' nucate: ' || nucate, csbNivelTraza);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);       
    
    RETURN ( nucate );
EXCEPTION
    WHEN OTHERS THEN
         pkg_Error.setError;
         pkg_Error.getError(onuerrorcode, osberrormessage);
         pkg_traza.trace(csbMetodo ||' osberrormessage: ' || osberrormessage, csbNivelTraza);
         pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);            
         nucate := -1;
         RETURN ( nucate );
END LDC_FNUGETCATHIST;
/
PROMPT "                                                            "
PROMPT OTORGA PERMISOS ESQUEMA sobre funcion LDC_FNUGETCATHIST
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_FNUGETCATHIST', 'ADM_PERSON'); 
END;
/