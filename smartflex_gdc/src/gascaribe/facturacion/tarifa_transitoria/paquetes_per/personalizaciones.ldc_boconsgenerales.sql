CREATE OR REPLACE PACKAGE personalizaciones.ldc_boConsGenerales IS
/*******************************************************************************
    Fuente=Propiedad Intelectual de Gases del Caribe
    personalizaciones.ldc_boConsGenerales
    Autor       :   Carlos Andres Gonzalez - HORBATH
    Fecha       :   07-03-2023
    Descripcion :   Paquete con las consultas/servicios generales
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jcatuchemvm 12-05-2023  OSF-1299 Se agregan los siguientes métodos
                                        [fnuGetNumberYear]
                                        [fnuGetNumberMonth]
                                        [fdtGetMaxDate]
                                        [fdtGetSysDate]
                                        [fnuSecond]
                                        [fdtGetDatePlusOneDay]
                                        [isDateBetween]
                                        [GetNextMonth]
                                        [GetPreviousMonth]
    cgonzalez   07-03-2023  OSF-943 Creacion
    adrianavg   06-10-2023  OSF-1709 Se eliminan los métodos fnuGetPersonId y fnuGetLegaliceOrder
                            el primero reemplazado por pkg_bopersonal.fnuGetPersonaId y el segundo
                            reemplazado por pkg_bcordenes.fnuObtenerOTInstanciaLegal en donde eran invocados
    adrianavg   25-10-2023  OSF-1709 Se reemplazan algunos metodos, variables por su homologo existente en 
                            personalizaciones.homologacion_servicios.                            
*******************************************************************************/

    -- Retorna Identificador del ultimo caso que hizo cambios en este archivo
    FUNCTION fsbVersion RETURN VARCHAR2;

    -- Retorna Identificador de la base de datos
    FUNCTION fsbGetDatabaseDesc RETURN VARCHAR2;

    -- Retorna Número del año de una fecha
    FUNCTION fnuGetNumberYear (idtDate IN DATE) RETURN NUMBER;

    -- Retorna Número del mes de una fecha
    FUNCTION fnuGetNumberMonth (idtDate IN DATE) RETURN NUMBER;

    -- Retorna la máxima fecha oracle
    FUNCTION fdtGetMaxDate RETURN DATE;

    -- Retorna la fecha actual del sistema
    FUNCTION fdtGetSysDate RETURN DATE;

    -- Retorna el valor de un segundo
    FUNCTION fnuSecond RETURN NUMBER;

    -- Retorna la fecha mas un día
    FUNCTION fdtGetDatePlusOneDay (idtDate IN DATE,isbTrunc IN VARCHAR DEFAULT 'T' ) RETURN DATE;

    -- Valida fecha entre fechas
    FUNCTION  isDateBetween (idtDateInit IN DATE, idtDateFin IN DATE, idtDateCheck IN DATE) RETURN BOOLEAN;

    -- Retorna año y mes siguientes
    PROCEDURE GetNextMonth (inuYear IN NUMBER, inuMonth IN NUMBER, onuYear OUT NUMBER, onuMonth OUT NUMBER);

    -- Retorna año y mes anteriores
    PROCEDURE GetPreviousMonth (inuYear IN NUMBER, inuMonth IN NUMBER, onuYear OUT NUMBER, onuMonth OUT NUMBER);


     /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbGetFormatoFecha
    Descripcion     : Retorna formato de fecha
    Autor           : Jhon Soto / horbath
    Fecha           : 28-09-2023
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion

    ***************************************************************************/
    FUNCTION fsbGetFormatoFecha RETURN VARCHAR2;


END ldc_boConsGenerales;
/


CREATE OR REPLACE PACKAGE BODY personalizaciones.ldc_boConsGenerales IS

    -- Identificador del ultimo caso que hizo cambios en este archivo
    csbVersion                 VARCHAR2(15) := 'OSF-1709';

    -- Constantes para el control de la traza
    /***************************************************************************
        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso     Descripción
        adrianavg   25-10-2023  OSF-1709 Se reemplazan algunos metodos, variables por su homologo existente en 
                                         personalizaciones.homologacion_servicios. Se reemplaza csbSP_NAME y cnuNVLTRC
                                         por csbNOMPKG y csbNivelTraza
    ***************************************************************************/     
    csbNOMPKG      CONSTANT VARCHAR2(32) := $$PLSQL_UNIT||'.';
    csbNivelTraza  CONSTANT NUMBER(2)    := pkg_traza.cnuNivelTrzDef;    

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa    	: fsbVersion
    Autor       	: Carlos Andres Gonzalez - HORBATH
    Fecha       	: 07-03-2023
    Descripcion     : Retorna el identificador del ultimo caso que hizo cambios en el paquete
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    cgonzalez   07-03-2023  OSF-943 Creacion
    ***************************************************************************/
    FUNCTION fsbVersion RETURN VARCHAR2 IS
    BEGIN
        RETURN csbVersion;
    END fsbVersion;


    -- Retorna Identificador de la base de datos
    FUNCTION fsbGetDatabaseDesc RETURN VARCHAR2 IS
      sbInstanceName varchar2(100);
      sbInstanceDesc varchar2(100);
    BEGIN
      sbInstanceName := sys_context('USERENV','DB_NAME');
      if sbInstanceName in ('SFPL0707','SFPX0707') then
         sbInstanceDesc:= null;
      elsif sbInstanceName in ('SFQH0707','SFQT0707') then
         sbInstanceDesc:= 'Calidad';
      elsif sbInstanceName in ('SFBZ0707','SFBD0707') then
         sbInstanceDesc:= 'Desarrollo';
      else
        sbInstanceDesc:= 'Desconocida';
      end if;
      return sbInstanceDesc;
    EXCEPTION
      WHEN OTHERS THEN
        sbInstanceDesc:= '--';
        return sbInstanceDesc;
    END;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa    	: fnuGetNumberYear
    Autor       	: Juan Gabriel Catuche Girón - MVM
    Fecha       	: 12-05-2023
    Descripcion     : Retorna el número del año dada una fecha
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jcatuchemvm 12-05-2023  OSF-889 Creacion
    ***************************************************************************/
    FUNCTION fnuGetNumberYear (idtDate IN DATE) RETURN NUMBER IS
    BEGIN
        RETURN TO_CHAR(idtDate,'YYYY');
    END fnuGetNumberYear;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa    	: fnuGetNumberMonth
    Autor       	: Juan Gabriel Catuche Girón - MVM
    Fecha       	: 12-05-2023
    Descripcion     : Retorna el número del mes dada una fecha
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jcatuchemvm 12-05-2023  OSF-889 Creacion
    ***************************************************************************/
    FUNCTION fnuGetNumberMonth (idtDate IN DATE) RETURN NUMBER IS
    BEGIN
        RETURN TO_CHAR(idtDate,'MM');
    END fnuGetNumberMonth;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa    	: fdtGetMaxDate
    Autor       	: Juan Gabriel Catuche Girón - MVM
    Fecha       	: 12-05-2023
    Descripcion     : Retorna la máxima fecha de oracle
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jcatuchemvm 12-05-2023  OSF-889 Creacion
    ***************************************************************************/
    FUNCTION fdtGetMaxDate RETURN DATE IS
    BEGIN
        RETURN TO_DATE('31/12/4732 23:59:59','DD/MM/YYYY HH24:MI:SS');
    END fdtGetMaxDate;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa    	: fdtGetSysDate
    Autor       	: Juan Gabriel Catuche Girón - MVM
    Fecha       	: 12-05-2023
    Descripcion     : Retorna la fecha del sistema
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jcatuchemvm 12-05-2023  OSF-889 Creacion
    ***************************************************************************/
    FUNCTION fdtGetSysDate RETURN DATE IS
    BEGIN
        RETURN (SYSDATE);
    END fdtGetSysDate;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa    	: fnuSecond
    Autor       	: Juan Gabriel Catuche Girón - MVM
    Fecha       	: 12-05-2023
    Descripcion     : Retorna el valor de un segundo
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jcatuchemvm 12-05-2023  OSF-889 Creacion
    ***************************************************************************/
    FUNCTION fnuSecond RETURN NUMBER IS
    BEGIN
        RETURN (1/86400);
    END fnuSecond;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa    	: fdtGetDatePlusOneDay
    Autor       	: Juan Gabriel Catuche Girón - MVM
    Fecha       	: 12-05-2023
    Descripcion     : Retorna la fecha dada más un día
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jcatuchemvm 12-05-2023  OSF-889 Creacion
    ***************************************************************************/
    FUNCTION fdtGetDatePlusOneDay (idtDate IN DATE,isbTrunc IN VARCHAR DEFAULT 'T' ) RETURN DATE IS
        dtDate DATE;
    BEGIN
        IF isbTrunc = 'T' THEN
            dtDate := TRUNC(idtDate+1);
        ELSE
            dtDate := idtDate+1;
        END IF;

        RETURN dtDate;
    END fdtGetDatePlusOneDay;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa    	: isDateBetween
    Autor       	: Juan Gabriel Catuche Girón - MVM
    Fecha       	: 12-05-2023
    Descripcion     : Verifica la fecha de validación entre las fechas dadas
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jcatuchemvm 12-05-2023  OSF-889 Creacion
    ***************************************************************************/
    FUNCTION isDateBetween (idtDateInit IN DATE, idtDateFin IN DATE, idtDateCheck IN DATE) RETURN BOOLEAN IS
        blCheck BOOLEAN;
    BEGIN
        IF idtDateCheck BETWEEN idtDateInit AND idtDateFin THEN
            blCheck := TRUE;
        ELSE
            blCheck := FALSE;
        END IF;

        RETURN blCheck;
    END isDateBetween;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa    	: GetNextMonth
    Autor       	: Juan Gabriel Catuche Girón - MVM
    Fecha       	: 12-05-2023
    Descripcion     : Retorna mes y año siguientes al mes y año dado
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jcatuchemvm 12-05-2023  OSF-889 Creacion
    ***************************************************************************/
    PROCEDURE GetNextMonth (inuYear IN NUMBER, inuMonth IN NUMBER, onuYear OUT NUMBER, onuMonth OUT NUMBER) IS
    BEGIN
        IF inuMonth = 12 THEN
            onuYear := inuYear + 1;
            onuMonth := 1;
        ELSE
            onuYear := inuYear;
            onuMonth := inuMonth + 1;
        END IF;
    END GetNextMonth;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa    	: GetPreviousMonth
    Autor       	: Juan Gabriel Catuche Girón - MVM
    Fecha       	: 12-05-2023
    Descripcion     : Retorna mes y año previo al mes y año dado
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jcatuchemvm 12-05-2023  OSF-889 Creacion
    ***************************************************************************/
    PROCEDURE GetPreviousMonth (inuYear IN NUMBER, inuMonth IN NUMBER, onuYear OUT NUMBER, onuMonth OUT NUMBER) IS
    BEGIN
        IF inuMonth = 1 THEN
            onuYear := inuYear - 1;
            onuMonth := 12;
        ELSE
            onuYear := inuYear;
            onuMonth := inuMonth - 1;
        END IF;
    END GetPreviousMonth;


     /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbGetFormatoFecha
    Descripcion     : Retorna formato de fecha consultando el parametro de la base de datos
    Autor           : Jhon Soto - Horbath
    Fecha           : 28-09-2023
    Modificaciones  :
    Autor       Fecha       Caso      Descripción
    jsoto       28-09-2023  OSF-1678  Creación
    jsoto       5-10-2023   OSF-1686  Se traslada la funcion del paquete BC al BO
    adrianavg   25-10-2023  OSF-1709  Se reemplazan algunos metodos, variables por su homologo existente en 
                                      personalizaciones.homologacion_servicios. Se reemplaza csbMT_NAME por 
                                      csbMetodo. Se reemplaza ut_trace.trace por pkg_traza.trace
    ***************************************************************************/
    FUNCTION  fsbGetFormatoFecha
    RETURN VARCHAR2 IS

    sbFormatoFecha VARCHAR2(30); 
    csbMetodo       CONSTANT VARCHAR(60) := csbNOMPKG||'fsbGetFormatoFecha';

    CURSOR cuFormatoFecha IS
    SELECT VALUE
    FROM V$PARAMETER
    WHERE UPPER(NAME) = 'NLS_DATE_FORMAT';

    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO); 

        IF cuFormatoFecha%ISOPEN THEN
           CLOSE cuFormatoFecha;
        END IF;

        OPEN cuFormatoFecha;
        FETCH cuFormatoFecha INTO sbFormatoFecha;
        CLOSE cuFormatoFecha;
 
        pkg_traza.trace(csbMetodo||'sbFormatoFecha: '||sbFormatoFecha, csbNivelTraza); 

        /*Si el parametro de la base de datos es nulo se asigna un valor por defecto */
        IF sbFormatoFecha IS NULL THEN
           sbFormatoFecha := 'DD-MM-YYYY HH24:MI:SS';
           pkg_traza.trace(csbMetodo||'sbFormatoFecha: '||sbFormatoFecha, csbNivelTraza);
        END IF;

    RETURN sbFormatoFecha;

    EXCEPTION
      WHEN OTHERS THEN
      RETURN sbFormatoFecha;
    END fsbGetFormatoFecha;


END ldc_boConsGenerales;
/
PROMPT Otorgando permisos de ejecucion a LDC_BOCONSGENERALES
BEGIN
  pkg_utilidades.prAplicarPermisos('LDC_BOCONSGENERALES','PERSONALIZACIONES');
END;
/