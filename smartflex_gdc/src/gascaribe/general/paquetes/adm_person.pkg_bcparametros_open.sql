CREATE OR REPLACE PACKAGE  adm_person.pkg_bcparametros_open 
IS
    /******************************************************************
    <Package Fuente="Propiedad Intelectual de GDC">
    <Unidad> PKG_BCPARAMETROS_OPEN </Unidad>
    <Autor> </Autor>
    <Fecha> </Fecha>
    <Descripcion> 
       --
    </Descripcion>
    <Historial>
           <Modificacion Autor="" Fecha="" Inc="" Empresa="GDC">
               Creación
           </Modificacion>
           <Modificacion Autor="Paola Acosta" Fecha="12-02-2025" Inc="OSF-4043" Empresa="GDC">
               Se implementan los siguientes metodos creados por JSOTO en EFG con el caso OSF-3794:
                fnuObtNumericoParametr
                fsbObtCadenaParametr                
           </Modificacion>
     </Historial>
     </Package>
    ******************************************************************/
    
    --------------------------------------------
    -- Funciones y Procedimientos
    --------------------------------------------

    /*****************************************************************
    Unidad      : fsbVersion
    Descripcion : Obtiene la version del paquete
    ******************************************************************/
    FUNCTION fsbVersion 
    RETURN VARCHAR2;
    
    /*****************************************************************
    Unidad      : fsbGetValorCadena
    Descripcion : funcion que devuelve valor cadena del codigo del parametro ingresado
    ******************************************************************/
    FUNCTION fsbGetValorCadena
    (
        isbNombreParametro     IN    ge_parameter.parameter_id%TYPE 
    ) 
    RETURN VARCHAR2;
    
    /*****************************************************************
    Unidad      : fnuObtNumericoParametr
    Descripcion : funcion que devuelve valor numerico del codigo del parametro ingresado
    ******************************************************************/
    FUNCTION fnuObtNumericoParametr
    (
        isbNombreParametro     IN    parametr.pamecodi%TYPE 
    )
    RETURN NUMBER;
    
    /*****************************************************************
    Unidad      : fsbObtCadenaParametr
    Descripcion : funcion que devuelve valor cadena del codigo del parametro ingresado
    ******************************************************************/
    FUNCTION fsbObtCadenaParametr
    (
        isbNombreParametro     IN    parametr.pamecodi%TYPE 
    )
    RETURN VARCHAR2;

END pkg_bcparametros_open;
/
CREATE OR REPLACE PACKAGE BODY adm_person.pkg_bcparametros_open 
IS
    /******************************************************************
    <Package Fuente="Propiedad Intelectual de GDC">
    <Unidad> PKG_BCPARAMETROS_OPEN </Unidad>
    <Autor> </Autor>
    <Fecha> </Fecha>
    <Descripcion> 
       --
    </Descripcion>
    <Historial>
           <Modificacion Autor="" Fecha="" Inc="" Empresa="GDC">
               Creación
           </Modificacion>
           <Modificacion Autor="Paola Acosta" Fecha="12-02-2025" Inc="OSF-4043" Empresa="GDC">
               Se implementan los siguientes metodos creados por JSOTO en EFG con el caso OSF-3794:
                fnuObtNumericoParametr
                fsbObtCadenaParametr 
               Se crean las constantes globales cnuNvlTrz, csbinicio, csbFin, csbFin_ERC y csbFin_Err.
           </Modificacion>
     </Historial>
     </Package>
    ******************************************************************/
    
    -- Identificador del ultimo caso que hizo cambios
    csbVersion     VARCHAR2(15) := 'OSF-4043';
   
    -- Constantes para el control de la traza
    csbSp_Name     CONSTANT VARCHAR2(35) := $$PLSQL_UNIT;    
	cnuNvlTrz      CONSTANT NUMBER       := pkg_traza.cnuNivelTrzDef;
    csbinicio      CONSTANT VARCHAR2(35) := pkg_traza.csbInicio;
    csbFin         CONSTANT VARCHAR2(35) := pkg_traza.csbFin;
    csbFin_ERC     CONSTANT VARCHAR2(35) := pkg_traza.csbFin_ERC;
    csbFin_Err     CONSTANT VARCHAR2(35) := pkg_traza.csbFin_Err;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbVersion 
    Descripcion     : Retona el identificador del ultimo caso que hizo cambios
    Autor           : Carlos Gonzalez - Horbath
    Fecha           : 02-08-2023
    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    cgonzalez   02-08-2023  OSF-1236 Creacion
    ***************************************************************************/
    FUNCTION fsbVersion RETURN VARCHAR2 IS
    BEGIN
        RETURN csbVersion;
    END fsbVersion;
     
    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : fsbGetValorCadena
        Descripcion     : funcion que devuelve valor cadena del codigo del parametro ingresado 
        Autor           : Luis Felipe Valencia
        Fecha           : 02-02-2024

        Parametros de Entrada
          isbNombreParametro    nombre del parametro

        Parametros de Salida         
        Modificaciones  :
        =========================================================
        Autor             Fecha         Caso        Descripción
        felipe.valencia   02-02-2024    OSF-1909    Creación
    ***************************************************************************/
    FUNCTION fsbGetValorCadena
    (
        isbNombreParametro     IN    ge_parameter.parameter_id%TYPE 
    ) 
    RETURN VARCHAR2 IS

        sbValor   ge_parameter.value%TYPE;
        csbMetodo  CONSTANT VARCHAR2(100) := csbSp_Name||'fsbGetValorCadena';

        sbError             VARCHAR2(4000);
        nuError             NUMBER;   

        CURSOR cuGetValorParametro IS
        SELECT  value
        FROM ge_parameter
        WHERE parameter_id  = isbNombreParametro;
   
    BEGIN
      pkg_traza.trace(csbMetodo, cnuNvlTrz, csbinicio);

      IF cuGetValorParametro%ISOPEN THEN
        CLOSE cuGetValorParametro;
      END IF;
      
      OPEN cuGetValorParametro;
      FETCH cuGetValorParametro INTO sbValor;
      CLOSE cuGetValorParametro;

      pkg_traza.trace(csbMetodo, cnuNvlTrz, csbFin);
      
      RETURN sbValor;

    EXCEPTION
    WHEN pkg_Error.Controlled_Error  THEN
        pkg_Error.getError(nuError, sbError);
        pkg_traza.trace('sbError: ' || sbError, cnuNvlTrz);
        pkg_traza.trace(csbMetodo, cnuNvlTrz, csbFin_ERC);
        RETURN sbValor;
    --Validación de error no controlado
    WHEN OTHERS THEN
        pkg_Error.setError;
        pkg_Error.getError(nuError, sbError);
        pkg_traza.trace('sbError: ' || sbError, cnuNvlTrz);
        pkg_traza.trace(csbMetodo, cnuNvlTrz, csbFin_Err);
        RETURN sbValor;
    END fsbGetValorCadena;
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuObtNumericoParametr
    Descripcion     : funcion que devuelve valor numerico del codigo del parametro ingresado 
    Autor           : Jhon Eduar Erazo
    Fecha           : 12-02-2025
    
    Parametros de Entrada
        isbNombreParametro    nombre del parametro
    
    Parametros de Salida         
    Modificaciones  :
    =========================================================
    Autor           Fecha         Caso        Descripción
    PaolaAcosta		12-02-2025    OSF-4043    Creación
    ***************************************************************************/
    FUNCTION fnuObtNumericoParametr
    (
        isbNombreParametro     IN    parametr.pamecodi%TYPE 
    ) 
    RETURN NUMBER IS

        csbMetodo  CONSTANT VARCHAR2(100) := csbSp_Name||'fnuObtNumericoParametr';

        nuError     NUMBER; 
		nuValor   	parametr.pamenume%TYPE;
		sbError     VARCHAR2(4000);
	
        CURSOR cuGetValorParametro 
		IS
			SELECT pamenume
			FROM parametr
			WHERE pamecodi  = isbNombreParametro;
   
    BEGIN
	
		pkg_traza.trace(csbMetodo, cnuNvlTrz, csbinicio);
	  
		pkg_traza.trace('isbNombreParametro: '  || isbNombreParametro, cnuNvlTrz); 

		IF cuGetValorParametro%ISOPEN THEN
			CLOSE cuGetValorParametro;
		END IF;
      
		OPEN cuGetValorParametro;
		FETCH cuGetValorParametro INTO nuValor;
		CLOSE cuGetValorParametro;
	  
		pkg_traza.trace('nuValor: ' || nuValor, cnuNvlTrz);

		pkg_traza.trace(csbMetodo, cnuNvlTrz, csbFin);
      
		RETURN nuValor;

    EXCEPTION
		WHEN pkg_Error.Controlled_Error  THEN
			pkg_Error.getError(nuError, sbError);
			pkg_traza.trace('sbError: ' || sbError, cnuNvlTrz);
			pkg_traza.trace(csbMetodo, cnuNvlTrz, csbFin_ERC);
			RETURN nuValor;
		WHEN OTHERS THEN
			pkg_Error.setError;
			pkg_Error.getError(nuError, sbError);
			pkg_traza.trace('sbError: ' || sbError, cnuNvlTrz);
			pkg_traza.trace(csbMetodo, cnuNvlTrz, csbFin_Err);
			RETURN nuValor;
    END fnuObtNumericoParametr;
	
	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbObtCadenaParametr
    Descripcion     : funcion que devuelve valor cadena del codigo del parametro ingresado 
    Autor           : Jhon Eduar Erazo
    Fecha           : 12-02-2025

    Parametros de Entrada
        isbNombreParametro    nombre del parametro

    Parametros de Salida         
    Modificaciones  :
    =========================================================
    Autor           Fecha         Caso        Descripción
    PaolaAcosta		12-02-2025    OSF-4043    Creación
    ***************************************************************************/
    FUNCTION fsbObtCadenaParametr
    (
        isbNombreParametro     IN    parametr.pamecodi%TYPE 
    ) 
    RETURN VARCHAR2 IS

        csbMetodo  CONSTANT VARCHAR2(100) := csbSp_Name||'fsbObtCadenaParametr';

        nuError     NUMBER; 
		sbValor   	parametr.pamechar%TYPE;
		sbError     VARCHAR2(4000);
	
        CURSOR cuGetValorParametro 
		IS
			SELECT pamechar
			FROM parametr
			WHERE pamecodi  = isbNombreParametro;
   
    BEGIN
	
		pkg_traza.trace(csbMetodo, cnuNvlTrz, csbinicio);
	  
		pkg_traza.trace('isbNombreParametro: '  || isbNombreParametro, cnuNvlTrz); 

		IF cuGetValorParametro%ISOPEN THEN
			CLOSE cuGetValorParametro;
		END IF;
      
		OPEN cuGetValorParametro;
		FETCH cuGetValorParametro INTO sbValor;
		CLOSE cuGetValorParametro;
	  
		pkg_traza.trace('sbValor: ' || sbValor, cnuNvlTrz);

		pkg_traza.trace(csbMetodo, cnuNvlTrz, csbFin);
      
		RETURN sbValor;

    EXCEPTION
		WHEN pkg_Error.Controlled_Error  THEN
			pkg_Error.getError(nuError, sbError);
			pkg_traza.trace('sbError: ' || sbError, cnuNvlTrz);
			pkg_traza.trace(csbMetodo, cnuNvlTrz, csbFin_ERC);
			RETURN sbValor;
		WHEN OTHERS THEN
			pkg_Error.setError;
			pkg_Error.getError(nuError, sbError);
			pkg_traza.trace('sbError: ' || sbError, cnuNvlTrz);
			pkg_traza.trace(csbMetodo, cnuNvlTrz, csbFin_Err);
			RETURN sbValor;
    END fsbObtCadenaParametr;

END pkg_bcparametros_open;
/
PROMPT Otorgando permisos de ejecución para personalizaciones.pkg_bcordenes_industriales
BEGIN
    pkg_utilidades.prAplicarPermisos(upper('pkg_bcparametros_open'), 'ADM_PERSON');
END;
/