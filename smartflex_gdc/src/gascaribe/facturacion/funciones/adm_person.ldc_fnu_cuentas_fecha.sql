CREATE OR REPLACE FUNCTION ADM_PERSON.LDC_FNU_CUENTAS_FECHA(PRODUCTO NUMBER, 
                                                            FECHA DATE)
RETURN NUMBER IS
/**************************************************************************
  Autor       :  
  Fecha       :  
  Descripcion :  

  Parametros Entrada
     PRODUCTO Codigo del servicio suscrito
     FECHA    Fecha de creacion
  Valor de Retorno
     

 HISTORIA DE MODIFICACIONES
   FECHA        AUTOR     DESCRIPCION
   15/02/2023   Adrianavg OSF-2181: Migrar del esquema OPEN al esquema ADM_PERSON
                          Se retira el esquema OPEN antepuesto a cargos, cuencobr
                          Se declaran variables para la gestión de trazas, se hace uso del pkg_traza.trace
                          Se adiciona bloque de exceptiones when others según pautas técnicas
***************************************************************************/
    --Se declaran variables para la gestión de trazas
    csbMetodo            CONSTANT VARCHAR2(32)       := $$PLSQL_UNIT;
    csbNivelTraza        CONSTANT NUMBER(2)          := pkg_traza.cnuNivelTrzDef; 
    csbInicio   	     CONSTANT VARCHAR2(35) 	     := pkg_traza.csbINICIO;   
    Onuerrorcode         NUMBER:= pkg_error.CNUGENERIC_MESSAGE;	
    Osberrormessage      VARCHAR2(2000);
    
    CURSOR cuPrincipal Is
    SELECT count(*)
      FROM (SELECT cargnuse,cargcuco,cucovato,cucovaab, NVL(sum(decode(cargsign,'DB',cargvalo,'CR',-cargvalo)),0) Vato, 
                    NVL(sum(decode(cargsign,'PA',cargvalo,'AS',cargvalo,'SA',-cargvalo,'AP',-cargvalo, 'NS',cargvalo)),0) Vaab
              FROM cargos, cuencobr
             WHERE cargcuco = cucocodi
               AND cargcuco > 0
               AND cargfecr <= FECHA 
          GROUP BY cargnuse, cargcuco, cucovato, cucovaab
          )
     WHERE cargnuse = PRODUCTO
       AND (VATO - VAAB) > 0;
    
    Cuentas number default 0;

BEGIN

    pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
    pkg_error.prInicializaError(onuerrorcode, osberrormessage);
    pkg_traza.trace(csbMetodo ||' PRODUCTO: ' || PRODUCTO, csbNivelTraza);    
    pkg_traza.trace(csbMetodo ||' FECHA: ' || FECHA, csbNivelTraza);
    
    OPEN cuPrincipal;
    FETCH cuPrincipal INTO cuentas;
    CLOSE cuPrincipal;
    
    pkg_traza.trace(csbMetodo ||' cuentas: ' || cuentas, csbNivelTraza);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);     
    
    RETURN cuentas;
EXCEPTION
 WHEN OTHERS THEN 
      pkg_Error.setError;
      pkg_Error.getError(onuerrorcode, osberrormessage);
      pkg_traza.trace(csbMetodo ||' osberrormessage: ' || osberrormessage, csbNivelTraza);
      pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
      RETURN cuentas;
END LDC_FNU_CUENTAS_FECHA;
/
PROMPT "                                                            "
PROMPT OTORGA PERMISOS ESQUEMA sobre funcion LDC_FNU_CUENTAS_FECHA
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_FNU_CUENTAS_FECHA', 'ADM_PERSON'); 
END;
/
PROMPT "                                                            "
PROMPT OTORGA PERMISOS a REPORTES sobre funcion LDC_FNU_CUENTAS_FECHA
GRANT EXECUTE ON ADM_PERSON.LDC_FNU_CUENTAS_FECHA TO REPORTES;
/