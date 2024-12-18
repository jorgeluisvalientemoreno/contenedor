CREATE OR REPLACE FUNCTION ADM_PERSON.LDCBI_ASSIGN_IOT_METER_READING (SBIN IN VARCHAR2) 
RETURN VARCHAR2 IS
  /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : LDCBI_ASSIGN_IOT_METER_READING
    Descripcion    : 
    Autor          :
    Fecha          :

    Parametros              Descripcion
    ============         ===================

    Fecha             Autor             Modificacion
    =========       =========           ====================
    07/02/2023     Adrianavg            OSF-2097: Migrar del esquema OPEN al esquema ADM_PERSON
                                        Se reemplaza SELECT-INTO por cursor CuAssignOrder
                                        Se reemplaza OS_ASSIGN_ORDER por API_ASSIGN_ORDER
                                        Se reemplaza ex.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                        Se reemplaza LD_BOCONSTANS.CNUGENERIC_ERROR por PKG_ERROR.CNUGENERIC_MESSAGE
                                        Se declaran variables para la gestión de trazas
                                        Se ajusta bloque de exceptiones según pautas técnicas 
  ******************************************************************/
    --Se declaran variables para la gestión de trazas
    csbMetodo            CONSTANT VARCHAR2(32)       := $$PLSQL_UNIT;
    csbNivelTraza        CONSTANT NUMBER(2)          := pkg_traza.cnuNivelTrzApi; 
    csbInicio   	       CONSTANT VARCHAR2(35) 	     := pkg_traza.csbINICIO; 
    
    SBORDER_ID          VARCHAR2(4000) := NULL;
    SBPACKAGE_ID        VARCHAR2(4000) := NULL;
    SBACTIVITY_ID       VARCHAR2(4000) := NULL;
    SBSUBSCRIPTION_ID   VARCHAR2(4000) := NULL;

    CURSOR CUDATA IS
      SELECT TO_NUMBER(REGEXP_SUBSTR(SBIN, '[^,]+',  1,  LEVEL)) AS COLUMN_VALUE
        FROM dual
     CONNECT BY REGEXP_SUBSTR(SBIN, '[^,]+', 1, LEVEL) IS NOT NULL;
    
    ONUERRORCODE    NUMBER;
    OSBERRORMESSAGE VARCHAR2(4000);
    
    NUOPERATING_UNIT_ID OR_ORDER.OPERATING_UNIT_ID%TYPE ;
    
    ASSIGN_ORDER NUMBER := 0;
    
    CURSOR CuAssignOrder(p_sbsubscription_id VARCHAR2)
    IS
    SELECT COUNT(1)
      FROM LDCBI_IOT_METER
     WHERE SUBSCRIPTION_ID = TO_NUMBER(p_sbsubscription_id)
       AND ACTIVE = 'Y' ;

BEGIN
    
    pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
    pkg_error.prInicializaError(onuerrorcode, osberrormessage);
    pkg_traza.trace(csbMetodo ||' sbin: ' || sbin, csbNivelTraza);    
    
    NUOPERATING_UNIT_ID := DALD_PARAMETER.FNUGETNUMERIC_VALUE('IOT_METER_READING_UNIT');
    pkg_traza.trace(csbMetodo ||' Unidad Operativa: ' || NUOPERATING_UNIT_ID, csbNivelTraza);

    IF NUOPERATING_UNIT_ID IS NULL OR NUOPERATING_UNIT_ID = 0 THEN
       pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
       RETURN NULL;
    END IF;
    
    FOR TEMPCUDATA IN CUDATA LOOP
        IF SBORDER_ID IS NULL THEN
           SBORDER_ID      := TEMPCUDATA.COLUMN_VALUE;
           OSBERRORMESSAGE := '[ORDEN - ' || SBORDER_ID || ']';
        ELSIF SBPACKAGE_ID IS NULL THEN
           SBPACKAGE_ID    := TEMPCUDATA.COLUMN_VALUE;
           OSBERRORMESSAGE := OSBERRORMESSAGE || ' - [SOLICITUD - ' || SBPACKAGE_ID || ']';
        ELSIF SBACTIVITY_ID IS NULL THEN
           SBACTIVITY_ID   := TEMPCUDATA.COLUMN_VALUE;
           OSBERRORMESSAGE := OSBERRORMESSAGE || ' - [ACTIVIDAD - ' || SBACTIVITY_ID || ']';
        ELSIF SBSUBSCRIPTION_ID IS NULL THEN
           SBSUBSCRIPTION_ID := TEMPCUDATA.COLUMN_VALUE;
           OSBERRORMESSAGE := OSBERRORMESSAGE || ' - [CONTRATO - ' || SBSUBSCRIPTION_ID || ']';
        END IF;
    END LOOP;
    
    pkg_traza.trace(csbMetodo ||' OSBERRORMESSAGE: ' || OSBERRORMESSAGE, csbNivelTraza);
    
     OPEN CuAssignOrder(SBSUBSCRIPTION_ID);
    FETCH CuAssignOrder INTO ASSIGN_ORDER;
    CLOSE CuAssignOrder;
    
    pkg_traza.trace(csbMetodo ||' ASSIGN_ORDER: ' || ASSIGN_ORDER, csbNivelTraza);
    
    IF ASSIGN_ORDER > 0 THEN
       API_ASSIGN_ORDER(TO_NUMBER(SBORDER_ID),  --inuOrder
                        NUOPERATING_UNIT_ID,    --inuOperatingUnit
                        ONUERRORCODE,           --onuErrorCode
                        OSBERRORMESSAGE         --osbErrorMessage
                        );  
    
        pkg_traza.trace(csbMetodo ||' API_ASSIGN_ORDER-->ONUERRORCODE: ' || ONUERRORCODE, csbNivelTraza);
        pkg_traza.trace(csbMetodo ||' API_ASSIGN_ORDER-->OSBERRORMESSAGE: ' || OSBERRORMESSAGE, csbNivelTraza);
        
        IF ONUERRORCODE = 0 THEN
            UPDATE LDC_ORDER
               SET ASIGNADO = 'S'
             WHERE NVL(PACKAGE_ID, 0) = NVL(TO_NUMBER(SBPACKAGE_ID), 0)
               AND ORDER_ID = TO_NUMBER(SBORDER_ID);
            pkg_traza.trace(csbMetodo ||' UPDATE LDC_ORDER, PACKAGE_ID: ' || NVL(TO_NUMBER(SBPACKAGE_ID), 0)
                                      ||' ORDER_ID: ' || TO_NUMBER(SBORDER_ID), csbNivelTraza);   
        ELSE
          LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TO_NUMBER(SBPACKAGE_ID),
                                                TO_NUMBER(SBORDER_ID),
                                                'LA ORDEN NO FUE ASIGNADA A LA UNIDAD OPERATIVA [' ||
                                                NUOPERATING_UNIT_ID ||
                                                '] - MENSAJE DE ERROR PROVENIENTE DE OS_ASSIGN_ORDER --> ' ||
                                                OSBERRORMESSAGE);
        END IF;
    
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN NUOPERATING_UNIT_ID;
    
    ELSE
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN NULL;
    END IF;
    
EXCEPTION
    WHEN PKG_ERROR.CONTROLLED_ERROR THEN
         ONUERRORCODE    := PKG_ERROR.CNUGENERIC_MESSAGE;
         OSBERRORMESSAGE := 'ERROR AL ASIGNAR LA ORDEN DE LECTURA DE MEDIDOR INTELIGENTE: ' ||PKERRORS.FSBGETERRORMESSAGE;
         OSBERRORMESSAGE := OSBERRORMESSAGE || ' - [' || DBMS_UTILITY.FORMAT_ERROR_STACK || ' - [' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE || ']';
         LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TO_NUMBER(SBPACKAGE_ID), TO_NUMBER(SBORDER_ID), OSBERRORMESSAGE);
         COMMIT;
         pkg_Error.setError;
         pkg_Error.getError(onuerrorcode, osberrormessage);
         pkg_traza.trace(csbMetodo ||' osberrormessage: ' || osberrormessage, csbNivelTraza);
         pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
         RETURN -1;
    WHEN OTHERS THEN
         ONUERRORCODE    := PKG_ERROR.CNUGENERIC_MESSAGE;
         OSBERRORMESSAGE := 'ERROR AL ASIGNAR LA ORDEN DE LECTURA DE MEDIDOR INTELIGENTE: ' || PKERRORS.FSBGETERRORMESSAGE;
         OSBERRORMESSAGE := OSBERRORMESSAGE || ' - [' || DBMS_UTILITY.FORMAT_ERROR_STACK || ' - [' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE || ']';
         LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TO_NUMBER(SBPACKAGE_ID), TO_NUMBER(SBORDER_ID), OSBERRORMESSAGE);    
         COMMIT;
         pkg_Error.setError;
         pkg_Error.getError(onuerrorcode, osberrormessage);
         pkg_traza.trace(csbMetodo ||' osberrormessage: ' || osberrormessage, csbNivelTraza);
         pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);         
         RETURN -1;
END LDCBI_ASSIGN_IOT_METER_READING;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre funcion LDCBI_ASSIGN_IOT_METER_READING
BEGIN
    pkg_utilidades.prAplicarPermisos('LDCBI_ASSIGN_IOT_METER_READING', 'ADM_PERSON'); 
END;
/
PROMPT OTORGA PERMISOS a REPORTES sobre funcion LDCBI_ASSIGN_IOT_METER_READING
GRANT EXECUTE ON ADM_PERSON.LDCBI_ASSIGN_IOT_METER_READING TO REPORTES;
/
