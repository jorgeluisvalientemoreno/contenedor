CREATE OR REPLACE FUNCTION ADM_PERSON.FSBGETOBSNOLECT (inuOrderId IN NUMBER) RETURN VARCHAR2
IS
  /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : fsbGetObsNoLect
    Descripcion    : Función que retorna la observación de no lectura
    Fecha          : 02/02/2013

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============  ===================
    
    Fecha             Autor             Modificacion
    =========       =========           ====================
    07/02/2023     Adrianavg            OSF-2097: Migrar del esquema OPEN al esquema ADM_PERSON
                                        Se reemplaza DAOR_ORDER.FDTGETCREATED_DATE por PKG_BCORDENES.FDTOBTIENEFECHACREACION
                                        Se declaran variables para la gestión de trazas
                                        Se reemplaza el dbms_output.put_line por pkg_traza.trace
                                        Se ajusta el bloque de exceptiones según pautas técnicas    
    ****************************************************/
    --Se declaran variables para la gestión de trazas
    csbMetodo            CONSTANT VARCHAR2(32)       := $$PLSQL_UNIT;
    csbNivelTraza        CONSTANT NUMBER(2)          := pkg_traza.cnuNivelTrzApi; 
    csbInicio   	       CONSTANT VARCHAR2(35) 	     := pkg_traza.csbINICIO;   
    Onuerrorcode         NUMBER:= pkg_error.CNUGENERIC_MESSAGE;		
    Osberrormessage      VARCHAR2(2000);

    sbObsNoLect    VARCHAR2(100);
    dtCreateDate   DATE;
    dtEndDate      DATE;
    nuProductId    pr_product.product_id%TYPE;
    nuPericose     conssesu.cosspecs%TYPE;
    
    --Cursor para obtener el ultimo periodo de consumo relacionado al producto
    CURSOR cuConsumo(inuProductId pr_product.product_id%TYPE,
                     idtEndDate   DATE)
    IS
    SELECT cosspecs
      FROM conssesu
     WHERE cosssesu = inuProductId
       AND COSSFERE =  (SELECT max(COSSFERE)
                          FROM conssesu
                         WHERE cosssesu = inuProductId
                           AND COSSFERE <=idtEndDate)
    AND ROWNUM = 1
    ORDER BY COSSFERE DESC;
            
    CURSOR cudesc (inuproductid pr_product.product_id%TYPE,
                  inupericose  conssesu.cosspecs%TYPE) 
    IS
    SELECT obledesc
      FROM lectelme LEFT JOIN obselect ON leemoble = oblecodi
     WHERE leemsesu = inuproductid
       AND leempecs = inupericose;
BEGIN

    pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
    pkg_error.prInicializaError(onuerrorcode, osberrormessage);
    pkg_traza.trace(csbMetodo ||' inuOrderId: ' || inuOrderId, csbNivelTraza);
    
    sbObsNoLect := '';
    
    --1.Obtener fecha de generación de la orden
    dtCreateDate := PKG_BCORDENES.FDTOBTIENEFECHACREACION(inuOrderId);
    pkg_traza.trace(csbMetodo ||' dtCreateDate => '||dtCreateDate, csbNivelTraza); 
    
    --2.Adicionar n días a la fecha de finalización del periodo
    IF dtCreateDate IS NOT NULL THEN
       dtEndDate := dtCreateDate + dald_parameter.fnuGetNumeric_Value('LDC_NUM_DIAS_PERIODO');
       pkg_traza.trace(csbMetodo ||' dtEndDate => '||dtEndDate, csbNivelTraza); 
    
       nuProductId := ldc_boutilities.fsbGetValorCampoTabla('OR_ORDER_ACTIVITY','ORDER_ID','PRODUCT_ID',inuOrderId);
       pkg_traza.trace(csbMetodo ||' nuProductId => '||nuProductId, csbNivelTraza); 
    
     --3.Obtener ultimo periodo de consumo
     OPEN cuconsumo(nuproductid, dtenddate);    
     FETCH cuconsumo INTO nupericose;    
     CLOSE cuconsumo;
     pkg_traza.trace(csbMetodo ||' nuPericose => '||nuPericose, csbNivelTraza); 
    
     IF nuPericose IS NULL THEN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN '';
     END IF;

     --4. Obtener ultima observación de no lectura
     OPEN cuDesc(nuProductId,nuPericose);
     FETCH cuDesc into sbObsNoLect;
     IF cuDesc%notfound OR sbObsNoLect IS NULL THEN
        sbObsNoLect := '';
        pkg_traza.trace(csbMetodo ||' NO SE ENCONTRARON DATOS', csbNivelTraza); 
     ELSE
         sbObsNoLect := 'TERCERA OBSERVACIÓN DE NO LECTURA: '||sbObsNoLect;
     END IF;
     CLOSE cuDesc; 
    ELSE
     pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
     RETURN '';
    END IF; 
    
    pkg_traza.trace(csbMetodo ||' sbObsNoLect => '||sbObsNoLect, csbNivelTraza); 
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    
    RETURN sbObsNoLect;

EXCEPTION
     WHEN OTHERS THEN
       IF cuConsumo%isopen THEN
          CLOSE cuConsumo;
       END IF;
       IF cuDesc%isopen THEN
          CLOSE cuDesc;
       END IF;
       pkg_error.seterror; 
       pkg_Error.getError(onuerrorcode, osberrormessage);
       pkg_traza.trace(csbMetodo ||' osberrormessage: ' || osberrormessage, csbNivelTraza);
       pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
       RETURN '';
END fsbGetObsNoLect;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre funcion FSBGETOBSNOLECT
BEGIN
    pkg_utilidades.prAplicarPermisos('FSBGETOBSNOLECT', 'ADM_PERSON'); 
END;
/
PROMPT OTORGA PERMISOS a REPORTES sobre funcion FSBGETOBSNOLECT
GRANT EXECUTE ON ADM_PERSON.FSBGETOBSNOLECT TO REPORTES;
/
