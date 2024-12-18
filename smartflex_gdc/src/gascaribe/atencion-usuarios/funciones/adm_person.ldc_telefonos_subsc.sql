CREATE OR REPLACE FUNCTION ADM_PERSON.LDC_TELEFONOS_SUBSC ( vartel         IN NUMBER,
                                                            nusubscriberid IN NUMBER
) RETURN NUMBER IS

/**************************************************************
  Propiedad intelectual PETI.
  Trigger  :  LDC_TELEFONOS_SUBSC
  Descripción  : Debido a que en una consulta donde se necesite mostrar los telefonos del subscritor se visualizan en filas y no columna,
                 se crea esta función para mostrar dichos telefonos separados en columna hasta 5 telefonos.
                 Esta función es para el reporte que será enviado al marcador predictivo
  Autor  : Alvaro E. Zapata
  Fecha  : 16-04-2013

  Historia de Modificaciones
    FECHA            AUTOR           DESCRIPCION
    20/02/2024       Adrianavg       OSF-2183: Se migra del esquema OPEN al esquema ADM_PERSON
                                     Se declaran variables para la gestión de trazas, se hace uso del pkg_traza.trace	
                                     Se ajusta el bloque de excepciones según las pautas técnicas
  **************************************************************/
    --Se declaran variables para la gestión de trazas
    csbMetodo            CONSTANT VARCHAR2(32)       := $$PLSQL_UNIT;
    csbNivelTraza        CONSTANT NUMBER(2)          := pkg_traza.cnuNivelTrzDef;
	csbInicio   	     CONSTANT VARCHAR2(35) 	     := pkg_traza.csbINICIO; 
    Onuerrorcode         NUMBER:= pkg_error.CNUGENERIC_MESSAGE;
    Osberrormessage      VARCHAR2(2000);
    
    Cursor CuTelSubs is
    SELECT DECODE(VarTel,1,tel1,2,tel2,3,tel3,4,tel4,5,Tel)
        FROM
        (
            SELECT  tel1,tel2,tel3, SUBSTR(tel,1,INSTR(tel,',')-1) tel4, SUBSTR(tel,INSTR(tel,',')+1) Tel
              FROM
            (
                SELECT  tel1, tel2, SUBSTR(tel,1,INSTR(tel,',')-1) tel3, SUBSTR(tel,INSTR(tel,',')+1) Tel
                  FROM
                (
                    SELECT  tel1, SUBSTR(tel,1,INSTR(tel,',')-1) tel2, SUBSTR(tel,INSTR(tel,',')+1) Tel
                      FROM
                    (
                        SELECT SUBSTR(tel,1,INSTR(tel,',')-1) tel1, SUBSTR(tel,INSTR(tel,',')+1) Tel
                          FROM
                          (
                              SELECT RTRIM (XMLAGG (XMLELEMENT (e,PHONE || ',')).EXTRACT ('//text()'), ',')||',' Tel
                                     ,RTRIM (XMLAGG (XMLELEMENT (e,PHONE || ',')).EXTRACT ('//text()'), ',')
                                FROM GE_SUBS_PHONE SP
                               WHERE SUBSCRIBER_ID = nuSubscriberId

                        )
                    )
                )
            )
        );

    nuTele NUMBER;

BEGIN
    
    pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
    pkg_error.prInicializaError(onuerrorcode, osberrormessage);
    pkg_traza.trace(csbMetodo ||' vartel: '  || vartel, csbNivelTraza);
    pkg_traza.trace(csbMetodo ||' nusubscriberid: '  || nusubscriberid, csbNivelTraza);
    
    OPEN cutelsubs;    
    FETCH cutelsubs INTO nutele;    
    IF cutelsubs%notfound THEN
        nutele := NULL;
    END IF;
    
    CLOSE cutelsubs;
    
    pkg_traza.trace(csbMetodo ||' nutele: '  || nutele, csbNivelTraza);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    
    RETURN nutele;

EXCEPTION
    WHEN NO_DATA_FOUND THEN ---no existen datos
         pkg_Error.getError(onuerrorcode, osberrormessage);
         pkg_traza.trace(csbMetodo ||' osberrormessage: ' || osberrormessage, csbNivelTraza);
         pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
         RETURN '-1';
    WHEN OTHERS THEN ---se esta generando un error al ejecutar la funcion
         pkg_Error.setError;
         pkg_Error.getError(onuerrorcode, osberrormessage);
         pkg_traza.trace(csbMetodo ||' osberrormessage: ' || osberrormessage, csbNivelTraza);
         pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR); 
         RETURN '-2';
END LDC_TELEFONOS_SUBSC;
/
PROMPT "                                                            "
PROMPT OTORGA PERMISOS ESQUEMA sobre funcion LDC_TELEFONOS_SUBSC
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_TELEFONOS_SUBSC', 'ADM_PERSON'); 
END;
/ 
PROMPT "                                                            "
PROMPT OTORGA PERMISOS a REXEREPORTES sobre funcion LDC_TELEFONOS_SUBSC
GRANT EXECUTE ON ADM_PERSON.LDC_TELEFONOS_SUBSC TO REXEREPORTES;
/
