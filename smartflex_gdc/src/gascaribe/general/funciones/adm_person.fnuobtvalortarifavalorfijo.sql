CREATE OR REPLACE FUNCTION ADM_PERSON.FNUOBTVALORTARIFAVALORFIJO(inutipocomp 		IN NUMBER, 
																 inuclasserv 		IN NUMBER, 
																 inuConcepto 		IN NUMBER, 
																 idtFechaIni 		IN DATE, 
																 idtFechaFin 		IN DATE, 
																 inuFOT      		IN NUMBER, 
																 isbTarifaPerson	IN VARCHAR2
																 ) 
RETURN NUMBER IS
/**************************************************************************
  Autor       : Jhon Eduar Erazo Guachavez
  Fecha       : 18/10/2024
  Descripcion : Obtiene el valor de tarifa valor fijo

  Parametros Entrada
		inuProductId Identificador del producto

  Valor de salida
		nuValorFijo valor tarifa valor fijo

 HISTORIA DE MODIFICACIONES
   FECHA        AUTOR     	DESCRIPCION
   04/12/2024   PAcosta     OSF-3612: Migración de la bd de EFG a GDC por ajustes de información de 
                                      la entidad HOMOLOGACION_SERVICIOS - GDC 
   18/10/2024  	jerazomvm 	OSF-3321: creación
***************************************************************************/

    --Se declaran variables para la gestión de trazas
    csbMetodo            CONSTANT VARCHAR2(32)  := $$PLSQL_UNIT;
    csbNivelTraza        CONSTANT NUMBER(2)     := pkg_traza.cnuNivelTrzDef; 
    csbInicio   	     CONSTANT VARCHAR2(35) 	:= pkg_traza.csbINICIO;   
	
    nuerrorcode         NUMBER			:= pkg_error.CNUGENERIC_MESSAGE;
	nuValorFijo			NUMBER			:= 0;
    sberrormessage		VARCHAR2(2000)	:= NULL;
    
BEGIN

	pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
	
    pkg_error.prInicializaError(nuerrorcode, sberrormessage);
	
    pkg_traza.trace('inutipocomp: ' 	|| inutipocomp  || chr(10) ||
					'inuclasserv: ' 	|| inuclasserv  || chr(10) ||
					'inuConcepto: ' 	|| inuConcepto  || chr(10) ||
					'idtFechaIni: ' 	|| idtFechaIni  || chr(10) ||
					'idtFechaFin: ' 	|| idtFechaFin  || chr(10) ||
					'inuFOT: ' 			|| inuFOT 		|| chr(10) ||
					'isbTarifaPerson: ' || isbTarifaPerson, csbNivelTraza);      

	-- Obtiene el valor de tarifa valor fijo
	nuValorFijo := OBTVALORTARIFAVALORFIJO(inutipocomp, 
										  inuclasserv, 
										  inuConcepto, 
										  idtFechaIni, 
										  idtFechaFin, 
										  inuFOT, 
										  isbTarifaPerson
										  );
	
	pkg_traza.trace('nuValorFijo: ' || nuValorFijo, csbNivelTraza);  
    
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
		
	RETURN nuValorFijo;
	
EXCEPTION
 WHEN OTHERS THEN 
      pkg_Error.setError;
      pkg_Error.getError(nuerrorcode, sberrormessage);
      pkg_traza.trace(csbMetodo ||' sberrormessage: ' || sberrormessage, csbNivelTraza);
      pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);      
      RETURN nuValorFijo; 
	  
END FNUOBTVALORTARIFAVALORFIJO;
/
PROMPT "                                                            "
PROMPT OTORGA PERMISOS ESQUEMA sobre funcion FNUOBTVALORTARIFAVALORFIJO
BEGIN
    pkg_utilidades.prAplicarPermisos('FNUOBTVALORTARIFAVALORFIJO', 'ADM_PERSON'); 
END;
/