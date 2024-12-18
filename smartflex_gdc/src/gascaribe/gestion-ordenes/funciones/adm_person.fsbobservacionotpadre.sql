CREATE OR REPLACE FUNCTION ADM_PERSON.FSBOBSERVACIONOTPADRE (nuSolicitud MO_PACKAGES.PACKAGE_ID%TYPE )
    RETURN VARCHAR2 IS
    /**************************************************************************

      Autor       : Luis Javier Lopez Barrios / Horbath
      Fecha       : 2018-22-08
      Ticket      : 200-1994
      Descripcion : funcion que muestra obervacion de tipos de trabajo cargo por coenxion e interna

      Parametros Entrada
       nuSolicitud numero de solicitud de venta

      Valor de salida
      HISTORIA DE MODIFICACIONES

      FECHA        AUTOR       DESCRIPCION
      07/02/2023   Adrianavg   OSF-2097: Migrar del esquema OPEN al esquema ADM_PERSON
                               Se retira esquema OPEN antepuesto a tabla or_order_comment, or_order_activity, or_order 
                               Se reemplaza ldc_boutilities.splitstrings por regexp_substr
                               Se declaran variables para la gestión de trazas
                               Se ajusta el bloque de exceptiones según pautas técnicas                                
    ***************************************************************************/
    --Se declaran variables para la gestión de trazas
    csbMetodo            CONSTANT VARCHAR2(32)       := $$PLSQL_UNIT;
    csbNivelTraza        CONSTANT NUMBER(2)          := pkg_traza.cnuNivelTrzDef; 
    csbInicio   	     CONSTANT VARCHAR2(35) 	     := pkg_traza.csbINICIO;   
    Onuerrorcode         NUMBER:= pkg_error.CNUGENERIC_MESSAGE;		
    Osberrormessage      VARCHAR2(2000);
    
    CURSOR cuComments is
    SELECT co.order_comment coment
      FROM or_order_comment co
     WHERE co.order_id IN (  SELECT o.order_id
                               FROM or_order_activity oa, or_order o
                              WHERE oa.package_id = nuSolicitud
                                AND o.task_type_id IN ( SELECT to_number(regexp_substr(dald_parameter.fsbgetvalue_chain('LDC_TITRINSTCERT', NULL), '[^,]+', 1,  LEVEL)) AS COLUMN_VALUE
                                                          FROM dual
                                                       CONNECT BY regexp_substr(dald_parameter.fsbgetvalue_chain('LDC_TITRINSTCERT', NULL), '[^,]+', 1, LEVEL) IS NOT NULL  
                                                          )
                                AND o.order_id = oa.order_id
                                AND o.order_status_id = DALD_PARAMETER.FNUGETNUMERIC_VALUE('COD_ORDER_STATUS',NULL)
                                AND o.causal_id IN ( SELECT to_number(regexp_substr(dald_parameter.fsbgetvalue_chain('LDC_CAUSFALLO', NULL), '[^,]+', 1, LEVEL)) AS COLUMN_VALUE
                                                       FROM dual
                                                    CONNECT BY regexp_substr(dald_parameter.fsbgetvalue_chain('LDC_CAUSFALLO', NULL), '[^,]+', 1, LEVEL) IS NOT NULL)
                                                   )
      AND UPPER(co.order_comment) not like '%LDC_CLOSEORDER%'
 ORDER BY ORDER_COMMENT_ID DESC;

    sbOb  VARCHAR2(32767);
BEGIN
    
    pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
    pkg_error.prInicializaError(onuerrorcode, osberrormessage);
    pkg_traza.trace(csbMetodo ||' nuSolicitud: ' || nuSolicitud, csbNivelTraza); 

    FOR regcomments IN cucomments LOOP
        IF sbob IS NULL THEN
            sbob := regcomments.coment;
        ELSE
            sbob := sbob || '-'|| regcomments.coment;
        END IF;
    END LOOP;

    pkg_traza.trace(csbMetodo ||' sbob: ' || sbob, csbNivelTraza); 
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    
    RETURN sbob;
EXCEPTION
    WHEN OTHERS THEN
         PKG_ERROR.setError; 
         PKG_ERROR.getError(onuerrorcode, osberrormessage);
         pkg_traza.trace(csbMetodo ||' osberrormessage: ' || osberrormessage, csbNivelTraza);
         pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR); 
         RETURN '-';
END fsbObservacionOTPadre;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre funcion FSBOBSERVACIONOTPADRE
BEGIN
    pkg_utilidades.prAplicarPermisos('FSBOBSERVACIONOTPADRE', 'ADM_PERSON'); 
END;
/
PROMPT OTORGA PERMISOS a REPORTES sobre funcion FSBOBSERVACIONOTPADRE
GRANT EXECUTE ON ADM_PERSON.FSBOBSERVACIONOTPADRE TO REPORTES;
/

