CREATE OR REPLACE FUNCTION ADM_PERSON.LDC_FNCRETORNAUNIDSOLICITUD(nupasolicitud mo_packages.package_id%TYPE)
RETURN NUMBER IS
/***************************************************************************
  Funcion: ldc_fncretornaunidsolicitud

  Descripcion:    OBTIENE UNIDAD PARA ASIGNAR ORDEN POR UOBYSOL

  Autor: Elkin Alvarez

  Historia de Modificaciones

  Fecha          Autor           Modificacion
  ===========    ==========      =============================================
  25-04-2019     dsaltarin       200-2588. Se modifica para que tome la unidad de la orden
  07-09-2020     dsaltarin       213. Se cambia para que primero se busque la unidad de la tabla ldc_asigna_unidad_rev_per,
                                 sino la encuentra y el cambio 200-2588 aplica para la gasera obtendra la unidad de la orden origen.
  15/02/2023     Adrianavg       OSF-2181: Migrar del esquema OPEN al esquema ADM_PERSON
                                 Se retira el esquema OPEN antepuesto a or_order 
                                 Se reemplaza SELECT-INTO por Cursor CuUnidadOperativa y CuUnidadOperativaOrdenTrab
                                 Se retira fblaplicaentrega(csbEntrega2588) y variable csbEntrega2588
                                 Se declaran variables para la gestión de trazas, se hace uso del pkg_traza.trace
                                 Se ajusta el bloque de exceptiones según pautas técnicas                                 
  ***************************************************************************/
    --Se declaran variables para la gestión de trazas
    csbMetodo            CONSTANT VARCHAR2(32)       := $$PLSQL_UNIT;
    csbNivelTraza        CONSTANT NUMBER(2)          := pkg_traza.cnuNivelTrzDef; 
    csbInicio   	     CONSTANT VARCHAR2(35) 	     := pkg_traza.csbINICIO;   
    Onuerrorcode         NUMBER:= pkg_error.CNUGENERIC_MESSAGE;	
    Osberrormessage      VARCHAR2(2000);
    
    nuunidadoperativa or_operating_unit.operating_unit_id%TYPE;
    
    CURSOR CuUnidadOperativa
    IS
    SELECT x.unidad_operativa 
      FROM ldc_asigna_unidad_rev_per x
     WHERE x.solicitud_generada = nupasolicitud
       AND ROWNUM = 1;    
       
    CURSOR CuUnidadOperativaOrdenTrab
    IS
    SELECT lk.operating_unit_id
      FROM ldc_asigna_unidad_rev_per x, or_order lk
     WHERE x.solicitud_generada = nupasolicitud
       AND x.orden_trabajo      = lk.order_id
       AND ROWNUM = 1;    
 
BEGIN

    pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
    pkg_error.prInicializaError(onuerrorcode, osberrormessage);
    pkg_traza.trace(csbMetodo ||' nupasolicitud: ' || nupasolicitud, csbNivelTraza);    
    
  BEGIN
    OPEN CuUnidadOperativa;
    FETCH CuUnidadOperativa INTO nuunidadoperativa;
    CLOSE CuUnidadOperativa;
    
  EXCEPTION
    WHEN OTHERS THEN
         nuunidadoperativa := NULL;
  END;
  
	IF nuunidadoperativa IS NULL THEN
        OPEN CuUnidadOperativaOrdenTrab;
        FETCH CuUnidadOperativaOrdenTrab INTO nuunidadoperativa;
        CLOSE CuUnidadOperativaOrdenTrab;
	END IF;

    pkg_traza.trace(csbMetodo ||' nuunidadoperativa: ' || nuunidadoperativa, csbNivelTraza);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 
      
    RETURN nuunidadoperativa;
EXCEPTION
WHEN OTHERS THEN
     pkg_Error.setError;
     pkg_Error.getError(onuerrorcode, osberrormessage);
     pkg_traza.trace(csbMetodo ||' osberrormessage: ' || osberrormessage, csbNivelTraza);
     pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);   
     nuunidadoperativa := NULL;
     RETURN nuunidadoperativa;
END LDC_FNCRETORNAUNIDSOLICITUD;
/
PROMPT "                                                            "
PROMPT OTORGA PERMISOS ESQUEMA sobre funcion LDC_FNCRETORNAUNIDSOLICITUD
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_FNCRETORNAUNIDSOLICITUD', 'ADM_PERSON'); 
END;
/ 