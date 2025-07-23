create or replace package adm_person.pkg_session is
/*
  -- Author  : Luis Felipe Valencia
  -- Created : 13/07/2023 3:29:26 p.?m.
  -- Purpose : Manejo de sessión

    Autor       Fecha       Casi     Descripción
    ---------   ----------- -------- ------------------------------
	jsoto		15/11/2024	OSF-3576 Creación de funcion fsbGetPersonByUserId
    epenao      26/01/2024  OSF-1835 +Creación del método fnugetuseridbymask
                                      que enmascara al método:
                                      SA_BOUser.fnuGetUserId
                                      que recibe la máscara del usuario y 
                                      retorna el id del usuario en SA_USER 
    epenao      11/10/2023  OSF-1734 +Creación del método fnuGetSesion
                                     +Ajuste de los métodos para que hagan 
                                      uso de la traza personalizada. 
    jpinedc     14/03/2025  OSF-4042 +Creación del método prcEstableceValorModulo
    lfvalencia  04/04/2025  OSF-3846 +Creación frcObtFunciona
*/
    /*****************************************************************
        Procedimiento   :   getUser
        Descripcion     :   Devuelve la mascara de usuario conectado a la
                            sesión

        Parametros de entrada


        Parametros de salida
        Mascara de usuario en sessión

        Historia de Modificaciones
        Fecha       Autor              Modificacion
        =========   =========         ====================
        13-07-2023  felipe.valencia    OSF-937 Creación
    ******************************************************************/
    FUNCTION getUser RETURN VARCHAR2;

    /*****************************************************************
      Procedimiento   :   getUserId
      Descripcion     :   Devuelve el código del usuario conectado a la
                          sessión

      Parametros de entrada


      Parametros de salida
      Id usuario en sessión

      Historia de Modificaciones
      Fecha       Autor              Modificacion
      =========   =========         ====================
      13-07-2023  felipe.valencia    OSF-937 Creación
    ******************************************************************/
    FUNCTION getUserId RETURN NUMBER;

        /*****************************************************************
      Procedimiento   :   getIP
      Descripcion     :   Devuelve la Ip de la sessión

      Parametros de entrada


      Parametros de salida
      Id usuario en sessión

      Historia de Modificaciones
      Fecha       Autor              Modificacion
      =========   =========         ====================
      13-07-2023  felipe.valencia    OSF-937 Creación
    ******************************************************************/
    FUNCTION getIP RETURN VARCHAR2;

    /*****************************************************************
      Procedimiento   :   getProgram
      Descripcion     :   Devuelve la Ip de la sessión

      Parametros de entrada


      Parametros de salida
      Id usuario en sessión

      Historia de Modificaciones
      Fecha       Autor              Modificacion
      =========   =========         ====================
      13-07-2023  felipe.valencia    OSF-937 Creación
    ******************************************************************/
    FUNCTION getProgram RETURN VARCHAR2;

/*******************************************************************************
    Fuente=Propiedad Intelectual de Gases del Caribe
    programa    :   fsbObtenerModulo
    Autor       :   Jhon Soto - Horbath
    Fecha       :   21-09-2023
    Descripcion :   Obtener Módulo donde se encuentra conectado el usuario
    Parametros de entrada:  N/A
    Retorna: El nombre del módulo al cual está conectada la sesión del usuario

    Modificaciones  :
    Autor       Fecha        Caso     Descripcion
    jsoto       21-09-2023   OSF-1608 Creacion
*******************************************************************************/

    FUNCTION fsbObtenerModulo 
    RETURN varchar2;

    --Retorna el id de la sesión actual. 
    FUNCTION fnuGetSesion
    RETURN NUMBER;
    
/*******************************************************************************
    Fuente=Propiedad Intelectual de Gases del Caribe
    programa    :   fnugetEmpresaDeUsuario
    Autor       :   Jhon Soto - Horbath
    Fecha       :   20-10-2023
    Descripcion :   Obtener Compañia del usuario 
    Parametros de entrada:  N/A
    Retorna: La empresa del usuario que está conectada la sesión del usuario conectado

    Modificaciones  :
    Autor       Fecha        Caso     Descripcion
    jsoto       20-10-2023   OSF-1782 Creacion
*******************************************************************************/

	FUNCTION fnugetEmpresaDeUsuario
	RETURN NUMBER;


/*******************************************************************************
    Fuente=Propiedad Intelectual de Gases del Caribe
    programa    :   fsbgetTerminal
    Autor       :   Jhon Soto - Horbath
    Fecha       :   09-11-2023
    Descripcion :   Obtener Terminal del usuario 
    Parametros de entrada:  N/A
    Retorna: El nombre de la terminal donde está conectada la sesión del usuario

    Modificaciones  :
    Autor       Fecha        Caso     Descripcion
    jsoto       20-10-2023   OSF-1911 Creacion
*******************************************************************************/

	FUNCTION fsbgetTerminal
	RETURN VARCHAR2;

/*******************************************************************************
    Fuente=Propiedad Intelectual de Gases del Caribe
    programa    :   fnugetuseridbymask
    Autor       :   Jhon Soto - Horbath
    Fecha       :   30-01-2024
    Descripcion :   Obtener Id  del usuario con la mascara de usuario
    Parametros de entrada:  N/A
    Retorna: El nombre de la terminal donde está conectada la sesión del usuario

    Modificaciones  :
    Autor       Fecha        Caso     Descripcion
*******************************************************************************/
    --Función que retorna el id de sa_user para la máscara de  usuario enviada. 
    function fnugetuseridbymask ( isbusermask in sa_user.mask%type default null)
    return sa_user.user_id%type;

/*******************************************************************************
    Función para obtener el programa desde el que se ejecuta el script.
*******************************************************************************/
    FUNCTION fsbObtieneProgramaActual
    RETURN VARCHAR2;

/*******************************************************************************
    Función para obtener tipo de solicitud de la instancia actual.
*******************************************************************************/
    FUNCTION fnuTipoSolicitudInstancia
    RETURN NUMBER;

/*******************************************************************************
    Fuente=Propiedad Intelectual de Gases del Caribe
    programa    :   fsbGetPersonByUserId
    Autor       :   Jhon Soto - Horbath
    Fecha       :   15-11-2024
    Descripcion :   Función que retorna el id de sa_user con el nombre en GE_PERSON asociada. 
    Parametros de entrada:  N/A

    Modificaciones  :
    Autor       Fecha        Caso     Descripcion
*******************************************************************************/

    function fsbGetPersonByUserId ( inuUserId in sa_user.user_id%type)
    return varchar2;

    -- Establece el Valor para el Módulo
    PROCEDURE prcEstableceValorModulo
    (
        isbModule               IN  VARCHAR2,
        isbAcccion              IN  VARCHAR2,
        isbRegistraSoloSiEsNulo IN  VARCHAR2     
    );

    --Obtiene el registro de la tabla funciona
    FUNCTION frcObtFunciona
    (
        inuUsuarioBd  IN  funciona.funcusba%TYPE
    )
    RETURN Funciona%ROWTYPE; 

END pkg_session;
/
create or replace PACKAGE BODY adm_person.pkg_session IS
    -- Constantes para el control de la traza
    csbNOMPKG 	CONSTANT VARCHAR2(35):= $$PLSQL_UNIT;
    nuCodError  number;
    sbMensErro  VARCHAR2(4000);

    FUNCTION getUser RETURN VARCHAR2 IS
        csbMETODO  CONSTANT VARCHAR2(100) := csbNOMPKG||'.getUser';
    BEGIN
        pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbINICIO);
        pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN);
        RETURN ut_session.getUser;
    EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
        pkg_Error.setError;
        pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERC);
        RAISE pkg_error.CONTROLLED_ERROR;
    WHEN others THEN
        pkg_Error.setError;
        pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);
        RAISE pkg_error.CONTROLLED_ERROR;
    END getUser;


    FUNCTION getUserId RETURN NUMBER IS
         csbMETODO  CONSTANT VARCHAR2(100) := csbNOMPKG||'.getUserId';
    BEGIN
        pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbINICIO);
        pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN);
        RETURN sa_bouser.fnuGetUserId(ut_session.getuser);
    EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
        pkg_Error.setError;
        pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERC);
        RAISE pkg_error.CONTROLLED_ERROR;
    WHEN others THEN
        pkg_Error.setError;
        pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);
        RAISE pkg_error.CONTROLLED_ERROR;
    END getUserId;


    FUNCTION getIP RETURN VARCHAR2 IS
        csbMETODO  CONSTANT VARCHAR2(100) := csbNOMPKG||'.getIP';
    BEGIN
        pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbINICIO);
        pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN);
        RETURN ut_session.getIP;
    EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
        pkg_Error.setError;
        pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERC);
        RAISE pkg_error.CONTROLLED_ERROR;
    WHEN others THEN
        pkg_Error.setError;
        pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);
        RAISE pkg_error.CONTROLLED_ERROR;
    END getIP;

    FUNCTION getProgram RETURN VARCHAR2 IS
        csbMETODO  CONSTANT VARCHAR2(100) := csbNOMPKG||'.getProgram';
    BEGIN
        pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbINICIO);
        pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN);
        RETURN ut_session.getProgram;
    EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
        pkg_Error.setError;
        pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERC);
        RAISE pkg_error.CONTROLLED_ERROR;
    WHEN others THEN
        pkg_Error.setError;
        pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);
        RAISE pkg_error.CONTROLLED_ERROR;
    END getProgram;


/*******************************************************************************
    Fuente=Propiedad Intelectual de Gases del Caribe
    programa    :   fsbObtenerModulo
    Autor       :   Jhon Soto - Horbath
    Fecha       :   21-09-2023
    Descripcion :   Obtener Módulo donde se encuentra conectado el usuario

    Parametros de entrada:  N/A
    Retorna: El nombre del módulo al cual está conectada la sesión del usuario

    Modificaciones  :
    Autor       Fecha        Caso     Descripcion
    jsoto       21-09-2023   OSF-1608 Creacion
*******************************************************************************/
    FUNCTION fsbObtenerModulo 
    RETURN varchar2 
    IS
        csbMT_NAME  VARCHAR2(70) :=  csbNOMPKG||'.fsbObtenerModulo';
        sbmodulo    VARCHAR2(100);

    BEGIN

        pkg_traza.trace(csbMT_NAME,pkg_traza.cnuNivelTrzDef,pkg_traza.csbINICIO);    
        sbmodulo := ut_session.getModule;
        pkg_traza.trace('Módulo: ' || sbmodulo, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(csbMT_NAME,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN);
        return sbmodulo;

    EXCEPTION
        WHEN OTHERS THEN
            pkg_error.SetError;
            pkg_traza.trace(csbMT_NAME,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);
            RETURN sbmodulo;
    END fsbObtenerModulo;


    FUNCTION fnuGetSesion
    RETURN NUMBER
    IS           
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
     Programa        : fnuGetSesion
     Descripcion     : Retorna el id de la sesión obtenido al llamar al método
                       ut_session.getsessionid.
     Autor           : Edilay Peña Osorio - MVM
     Fecha           : 11/10/2023

     Parametros de Entrada
     N/A

     Parametros de Salida

     Nombre                  Tipo             Descripción
     ===================    =========         =============================
     nuIdSesion              NUMBER           Id de la sesión actual. 

     Modificaciones  :
     =========================================================
     Autor       Fecha           Descripción
     epenao    11/10/2023       OSF-1734: Creación
    ***************************************************************************/      
        csbMETODO  CONSTANT VARCHAR2(100) := csbNOMPKG||'.fnuGetSesion';
        nuIdSesion NUMBER := NULL;        
    BEGIN
        pkg_traza.trace(csbMETODO,pkg_traza.cnuNivelTrzDef,pkg_traza.csbINICIO);   

        nuIdSesion := ut_session.getsessionid;    

        pkg_traza.trace(csbMETODO,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN);
        return nuIdSesion ;   
    EXCEPTION
        WHEN OTHERS THEN
            pkg_error.SetError;         
            pkg_traza.trace(csbMETODO, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RETURN nuIdSesion ;       
    END fnuGetSesion;

/*******************************************************************************
    Fuente=Propiedad Intelectual de Gases del Caribe
    programa    :   fnugetEmpresaDeUsuario
    Autor       :   Jhon Soto - Horbath
    Fecha       :   20-10-2023
    Descripcion :   Obtener la compañia del usuario conectado

    Parametros de entrada:  N/A
    Retorna: El nombre del módulo al cual está conectada la sesión del usuario

    Modificaciones  :
    Autor       Fecha        Caso     Descripcion
    jsoto       20-10-2023   OSF-1782 Creacion
*******************************************************************************/
    FUNCTION fnugetEmpresaDeUsuario 
    RETURN NUMBER 
    IS
        csbMT_NAME  VARCHAR2(70) :=  csbNOMPKG||'.fnugetEmpresaDeUsuario';
        nuCompania  NUMBER;

    BEGIN

        pkg_traza.trace(csbMT_NAME,pkg_traza.cnuNivelTrzDef,pkg_traza.csbINICIO);    
        nuCompania := sa_bosystem.fnugetusercompanyid;
        pkg_traza.trace('Compania: ' || nuCompania, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(csbMT_NAME,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN);
        return nuCompania;

    EXCEPTION
        WHEN OTHERS THEN
            pkg_error.SetError;
            pkg_traza.trace(csbMT_NAME,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);
            RETURN nuCompania;
    END fnugetEmpresaDeUsuario;


/*******************************************************************************
    Fuente=Propiedad Intelectual de Gases del Caribe
    programa    :   fsbgetTerminal
    Autor       :   Jhon Soto - Horbath
    Fecha       :   09-11-2023
    Descripcion :   Obtener Terminal del usuario 
    Parametros de entrada:  N/A
    Retorna: El nombre de la terminal donde está conectada la sesión del usuario

    Modificaciones  :
    Autor       Fecha        Caso     Descripcion
    jsoto       20-10-2023   OSF-1911 Creacion
*******************************************************************************/
    FUNCTION fsbgetTerminal 
    RETURN VARCHAR2 
    IS
        csbMT_NAME  VARCHAR2(70) :=  csbNOMPKG||'.fsbgetTerminal';
        sbTerminal  VARCHAR2(70);

    BEGIN

        pkg_traza.trace(csbMT_NAME,pkg_traza.cnuNivelTrzDef,pkg_traza.csbINICIO);    
        sbTerminal := UT_SESSION.GETTERMINAL();
        pkg_traza.trace('sbTerminal: ' || sbTerminal, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(csbMT_NAME,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN);
        return sbTerminal;

    EXCEPTION
        WHEN OTHERS THEN
            pkg_error.SetError;
            pkg_traza.trace(csbMT_NAME,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);
            RETURN sbTerminal;
    END fsbgetTerminal;

/*******************************************************************************
    Fuente=Propiedad Intelectual de Gases del Caribe
    programa    :   fnugetuseridbymask
    Autor       :   Jhon Soto - Horbath
    Fecha       :   30-01-2024
    Descripcion :   Función que retorna el id de sa_user para la máscara de  usuario enviada. 
    Parametros de entrada:  N/A
    Retorna: El nombre de la terminal donde está conectada la sesión del usuario

    Modificaciones  :
    Autor       Fecha        Caso     Descripcion
*******************************************************************************/
    
    function fnugetuseridbymask ( isbusermask in sa_user.mask%type default null)
    return sa_user.user_id%type
    IS 
        csbMetodo  CONSTANT VARCHAR2(100) := csbNOMPKG||'.fnugetuseridbymask'; --Nombre del método en la traza
        nuUser_id  sa_user.user_id%type;

    begin 
        pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbINICIO);

            nuUser_id := SA_BOUser.fnuGetUserId(isbusermask);

        pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN);
        return nuUser_id;
    exception
      when OTHERS then
            pkg_error.SetError;
            pkg_error.getError(nuCodError,sbMensErro);
            pkg_traza.trace('Error:'||nuCodError||'-'||sbMensErro,pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);
            RETURN nuUser_id;
    end fnugetuseridbymask;    


/*******************************************************************************
  Propiedad intelectual de Gases del Caribe.

  Programa:    fsbObtieneProgramaActual
  Autor:       jpadilla
  Fecha:       26-08-2024
  Descripción: Esta función obtiene el nombre del programa que está ejecutando
               la query actual en mayúsculas.
               Ej: 'SIGGAS.EXE', 'PL/SQL', 'DATAGRIP', 'DBEAVER'.

  Historial de cambios:
  Fecha       Autor          Cambio
  ==========  =============  ===================================================
  26-08-2024  jpadilla       Creación de la función.
  13/09/2024  Jorge Valiente OSF-3296: Actaulizar sentencia de obtener el programa actual
                                       de la sesion ejecuta desde el cursor cuProgramaActual
*******************************************************************************/

FUNCTION fsbObtieneProgramaActual RETURN VARCHAR2 IS
  csbMetodo CONSTANT VARCHAR2(100) := csbNOMPKG ||
                                      '.fsbObtieneProgramaActual';
  sbProgramaActual VARCHAR2(48);

  CURSOR cuProgramaActual IS
    SELECT UPPER(PROGRAM)
      FROM V$SESSION
     WHERE AUDSID = SYS_CONTEXT('USERENV', 'SESSIONID');

BEGIN

  pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

  IF (cuProgramaActual%ISOPEN) THEN
    CLOSE cuProgramaActual;
  END IF;

  OPEN cuProgramaActual;
  FETCH cuProgramaActual
    INTO sbProgramaActual;

  IF (cuProgramaActual%NOTFOUND) THEN
    sbProgramaActual := 'DESCONOCIDO';
  END IF;

  CLOSE cuProgramaActual;

  pkg_traza.trace('Programa Actual: ' || sbProgramaActual, pkg_traza.cnuNivelTrzDef); 
  pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
  RETURN sbProgramaActual;

exception
  when OTHERS then
    pkg_error.SetError;
    pkg_error.getError(nuCodError, sbMensErro);
    pkg_traza.trace('Error:' || nuCodError || '-' || sbMensErro,
                    pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace(csbMetodo,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbFIN_ERR);
    RETURN('DESCONOCIDO');
  
END fsbObtieneProgramaActual;


/*******************************************************************************
  Propiedad intelectual de Gases del Caribe.

  Programa:    fnuTipoSolicitudInstancia
  Autor:       jpadilla
  Fecha:       26-08-2024
  Descripción: Obtiene el identificador del tipo de solicitud si es una solicitud.

  Historial de cambios:
  Fecha       Autor          Cambio
  ==========  =============  ===================================================
  26-08-2024  jpadilla       Creación de la función.
*******************************************************************************/

FUNCTION fnuTipoSolicitudInstancia RETURN NUMBER IS
    blExists   BOOLEAN;
    nuIndex    ge_boinstancecontrol.stynuIndex;
    sbPackType ge_boinstancecontrol.stysbValue := NULL;
BEGIN
    -- Valida si existe la instancia
    blExists := ge_boinstancecontrol.fblAcckeyInstanceStack('WORK_INSTANCE',
                                                            nuIndex);

    IF (blExists) THEN
        -- Valida si es la instancia de una solicitud
        blExists := ge_boinstancecontrol.fblAcckeyAttributeStack('WORK_INSTANCE',
                                                                 NULL,
                                                                 'PS_PACKAGE_TYPE',
                                                                 'PACKAGE_TYPE_ID',
                                                                 nuIndex);

        IF (blExists) THEN
            -- Obtiene el identificador del tipo de solicitud
            prc_obtieneValorInstancia('WORK_INSTANCE',
                                      NULL,
                                      'PS_PACKAGE_TYPE',
                                      'PACKAGE_TYPE_ID',
                                      sbPackType);
        END IF;
    END IF;

    RETURN TO_NUMBER(sbPackType);
EXCEPTION
    WHEN OTHERS THEN
        RETURN NULL;
END fnuTipoSolicitudInstancia;

/*******************************************************************************
    Fuente=Propiedad Intelectual de Gases del Caribe
    programa    :   fsbGetPersonByUserId
    Autor       :   Jhon Soto - Horbath
    Fecha       :   15-11-2024
    Descripcion :   Función que retorna el id de sa_user con el nombre en GE_PERSON asociada. 
    Parametros de entrada:  N/A

    Modificaciones  :
    Autor       Fecha        Caso     Descripcion
	jsoto		15/11/2024	OSF-3576  Creación de función 
*******************************************************************************/
    
    function fsbGetPersonByUserId ( inuUserId in sa_user.user_id%type)
    return varchar2
    IS 

        csbMT_NAME  CONSTANT VARCHAR2(100) := csbNOMPKG||'.fsbGetPersonByUserId'; --Nombre del método en la traza
		sbUser		VARCHAR2(200);

		-- Cursor para consultar el Usuario
		CURSOR cuConsultaUsuario IS
		SELECT name_
		  FROM ge_person
		 WHERE user_id = inuUserId;

	BEGIN

		pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
		
		-- con el id del usuario de la base de datos averiguamos el nombre del usuario
		-- nombre del usuario conectado
		IF inuUserId > 0 THEN
			OPEN cuconsultausuario;
			FETCH cuconsultausuario
			  INTO sbUser;
			CLOSE cuconsultausuario;
		END IF;

		return(sbUser);

		pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

	EXCEPTION
		  when OTHERS then
				pkg_error.SetError;
				pkg_error.getError(nuCodError,sbMensErro);
				pkg_traza.trace('Error:'||nuCodError||'-'||sbMensErro,pkg_traza.cnuNivelTrzDef);
				pkg_traza.trace(csbMT_NAME,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);
				RETURN sbUser;
	end fsbGetPersonByUserId;
	
    -- Establece el Valor para el Módulo
    PROCEDURE prcEstableceValorModulo
    (
        isbModule               IN  VARCHAR2,
        isbAcccion              IN  VARCHAR2,
        isbRegistraSoloSiEsNulo IN  VARCHAR2     
    )
    IS 

        csbMT_NAME  CONSTANT VARCHAR2(100) := csbNOMPKG||'.prcEstableceValorModulo'; --Nombre del método en la traza

	BEGIN

		pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO); 
		
		ut_session.setmodule(isbModule, isbAcccion, isbRegistraSoloSiEsNulo);
		   
		pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

	EXCEPTION
		  when OTHERS then
				pkg_error.SetError;
				pkg_error.getError(nuCodError,sbMensErro);
				pkg_traza.trace('Error:'||nuCodError||'-'||sbMensErro,pkg_traza.cnuNivelTrzDef);
				pkg_traza.trace(csbMT_NAME,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);
    END prcEstableceValorModulo;

    /*******************************************************************************
        Fuente=Propiedad Intelectual de Gases del Caribe
        programa    :   frcObtFunciona
        Autor       :   Luis Felipe Valencia
        Fecha       :   19/02/2024
        Descripcion :   Obtiene el registro de la tabla funciona.
        Parametros de entrada:  Usuario de base de datos
        Retorna: Retorna el registro del tabla funciona

        Modificaciones  :
        Autor       Fecha        Caso     Descripcion
        fvalencia   19/02/2024  OSF-3846  Creacion.
    *******************************************************************************/
    FUNCTION frcObtFunciona
    (
        inuUsuarioBd  IN  funciona.funcusba%TYPE
    )
    RETURN Funciona%ROWTYPE
    IS
        csbMetodo  CONSTANT VARCHAR2(100) := csbNOMPKG||'.frcObtFunciona'; --Nombre del método en la traza
        rcFunciona  Funciona%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbINICIO);

        rcFunciona := pkbcfunciona.frcFunciona(inuUsuarioBd);

        pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN);
        return rcFunciona;
    EXCEPTION
        WHEN OTHERS then
            pkg_error.SetError;
            pkg_error.getError(nuCodError,sbMensErro);
            pkg_traza.trace('Error:'||nuCodError||'-'||sbMensErro,pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);
            RETURN rcFunciona;
    END frcObtFunciona;

END pkg_session;

/
PROMPT Otorgando permisos de ejecución para adm_person.pkg_session
BEGIN
    pkg_utilidades.prAplicarPermisos('PKG_SESSION', 'ADM_PERSON');
END;
/