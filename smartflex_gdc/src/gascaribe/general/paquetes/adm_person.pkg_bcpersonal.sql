create or replace package adm_person.pkg_bcpersonal IS
   /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : PKG_BCPERSONAL
    Descripcion     : Paquete para implemlogica de negocio con la entidad GE_PERSONAL
    Autor           : Jhon Soto
    Fecha           : 25-11-2024

    Parametros de Entrada     
    Parametros de Salida

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso        Descripcion
    jpinedc     26/03/2025  OSF-4010    Se crea fnuObtAreaOrganizacional
    jpinedc     08/04/2025  OSF-4205    Se crea fnuObtFuncionarioUsuario
  ***************************************************************************/

    --------------------------------------------
    -- Funciones y Procedimientos
    --------------------------------------------

    -- Versión del paquete
    FUNCTION fsbVersion
		RETURN VARCHAR2;


  --Retorna el id de la primera persona configurada para el id del usuario
     FUNCTION fnuObtieneUsuario
      (
        inuPersonaId    in    ge_person.person_id%type
      )
      RETURN  ge_person.user_id%type;


  --Retorna el nombre de la persona configurada para el id del usuario

    FUNCTION fsbObtNombrePorUsuario 
	  (
		 inuUserId in sa_user.user_id%type
	   )
		return varchar2;
		
    -- Obtiene el área organizacional a la que pertenece el funcionario
	FUNCTION fnuObtAreaOrganizacional
	(
        inuFuncionario  IN  ge_person.person_id%TYPE
    )
    RETURN NUMBER;
    
    -- Obtiene el funcionario asociado al usuario
    FUNCTION fnuObtFuncionarioUsuario
    (
        inuUsuario      IN  notas.notausua%TYPE
    )
    RETURN NUMBER;
    
end pkg_bcpersonal;
/

create or replace package body     adm_person.pkg_bcpersonal IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : PKG_BCPERSONAL
    Descripcion     : Paquete para implemlogica de negocio con la entidad GE_PERSONAL 
    Autor           : Jhon Soto
    Fecha           : 25-11-2024

    Parametros de Entrada
    Parametros de Salida

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso    Descripcion
  ***************************************************************************/

    -- Constantes para el control de la traza
    csbNOMPKG 		CONSTANT VARCHAR2(35):= $$PLSQL_UNIT||'.';
    csbVERSION      CONSTANT VARCHAR2(10) := 'OSF-4205';


    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        
    Programa        : fsbVersion
    Descripcion     : Retona el identificador del ultimo caso que hizo cambios
        Autor         : Jhon Soto
        Fecha         : 25-11-2024
    
        Modificaciones  :
        Autor           Fecha       Caso      Descripcion
    ***************************************************************************/
    FUNCTION fsbVersion RETURN VARCHAR2 IS
    BEGIN
        RETURN csbVersion;
    END fsbVersion;


  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuObtieneUsuario
    Descripcion     : Obtener usuario de la persona conectada
    Autor           : Jhon Soto (Horbath) 
    Fecha           : 25-11-2024

    Parametros de Entrada     
      Parametro de entrada y/o salida
            ionuPersonaId                 Id de Persona
 
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso    Descripcion
  ***************************************************************************/
 FUNCTION fnuObtieneUsuario
  (
    inuPersonaId    in    ge_person.person_id%type
  )
  RETURN  ge_person.user_id%type
  IS             
      csbMETODO     CONSTANT VARCHAR2(100) := csbNOMPKG||'fnuObtieneUsuario';
      nuCodError    ge_error_log.message_id%TYPE;--Código mensaje de error
      sbMenError    ge_error_log.description%TYPE;--Descripción mensaje de error
      nuUsuario     ge_person.user_id%type;

      cursor cuUsuarioId is
      SELECT user_id
        FROM ge_person
       WHERE person_id = inuPersonaId;
      
  BEGIN
      pkg_traza.trace(csbMETODO,pkg_traza.cnuNivelTrzDef,pkg_traza.csbINICIO);   
      
      open cuUsuarioId;
         fetch cuUsuarioId into nuUsuario;
      close cuUsuarioId;   
      pkg_traza.trace('Persona: '||inuPersonaID||
                      ' - Usuario obtenido:'||nuUsuario,pkg_traza.cnuNivelTrzDef);
      
      pkg_traza.trace(csbMETODO,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN);
      return nuUsuario;   
  EXCEPTION
      WHEN OTHERS THEN
          pkg_error.SetError;  
          pkg_error.GetError(nuCodError,sbMenError);          
          pkg_traza.trace(csbMetodo||' '|| 'Error:'||nuCodError||'-'||sbMenError);
          pkg_traza.trace(csbMETODO, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
          RETURN nuUsuario;       
  END fnuObtieneUsuario;

/*******************************************************************************
    Fuente=Propiedad Intelectual de Gases del Caribe
    programa    :   fsbObtNombrePorUsuario
    Autor       :   Jhon Soto - Horbath
    Fecha       :   15-11-2024
    Descripcion :   Función que retorna el nombre de sa_user con el nombre en GE_PERSON asociada. 
    Parametros de entrada:  N/A

    Modificaciones  :
    Autor       Fecha        Caso     Descripcion
	jsoto		15/11/2024	OSF-3576  Creación de función 
*******************************************************************************/
    
    function fsbObtNombrePorUsuario ( inuUserId in sa_user.user_id%type)
    return varchar2
    IS 

        csbMT_NAME  CONSTANT VARCHAR2(100) := csbNOMPKG||'.fsbObtNombrePorUsuario'; --Nombre del método en la traza
		sbUser		VARCHAR2(200);
        sbMensErro  VARCHAR2(4000);
        nuCodError  NUMBER;

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

		pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
		
		return(sbUser);

	EXCEPTION
		  when OTHERS then
				pkg_error.SetError;
				pkg_error.getError(nuCodError,sbMensErro);
				pkg_traza.trace('Error:'||nuCodError||'-'||sbMensErro,pkg_traza.cnuNivelTrzDef);
				pkg_traza.trace(csbMT_NAME,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);
				RETURN sbUser;
	end fsbObtNombrePorUsuario;
	
    -- Obtiene el área organizacional a la que pertenece el funcionario
	FUNCTION fnuObtAreaOrganizacional
	(
        inuFuncionario  IN  ge_person.person_id%TYPE
    )
    RETURN NUMBER
    IS 

        csbMT_NAME  CONSTANT VARCHAR2(100) := csbNOMPKG||'.fnuObtAreaOrganizacional';
        sbMensErro  VARCHAR2(4000);
        nuCodError  NUMBER;

		nuAreaOrganizacional    NUMBER;

        CURSOR cuObtAreaOrganizacional
        IS
        SELECT organizat_area_id
        FROM ge_person pe
        WHERE pe.person_id = inuFuncionario;
        
        PROCEDURE prcCierraCursor
        IS
            csbMT_NAME1  CONSTANT VARCHAR2(100) := csbMT_NAME||'.prcCierraCursor';
            sbMensErro1  VARCHAR2(4000);
            nuCodError1  NUMBER;
            
        BEGIN
        
            pkg_traza.trace(csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);    

            IF cuObtAreaOrganizacional%ISOPEN THEN
                CLOSE cuObtAreaOrganizacional;
            END IF;

            pkg_traza.trace(csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);        

        EXCEPTION
              when OTHERS then
                    pkg_error.SetError;
                    pkg_error.getError(nuCodError,sbMensErro);
                    pkg_traza.trace('Error:'||nuCodError||'-'||sbMensErro,pkg_traza.cnuNivelTrzDef);
                    pkg_traza.trace(csbMT_NAME,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);
                    RAISE pkg_Error.CONTROLLED_ERROR;
        END prcCierraCursor;              

	BEGIN

		pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);    
        
		OPEN cuObtAreaOrganizacional;		
        FETCH cuObtAreaOrganizacional INTO nuAreaOrganizacional;
        CLOSE cuObtAreaOrganizacional;

		pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

		RETURN nuAreaOrganizacional;

    EXCEPTION
		  when OTHERS then
				pkg_error.SetError;
				pkg_error.getError(nuCodError,sbMensErro);
				pkg_traza.trace('Error:'||nuCodError||'-'||sbMensErro,pkg_traza.cnuNivelTrzDef);
				pkg_traza.trace(csbMT_NAME,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);
				prcCierraCursor;
				RETURN nuAreaOrganizacional;
	end fnuObtAreaOrganizacional;
	
    -- Obtiene el funcionario asociado al usuario
    FUNCTION fnuObtFuncionarioUsuario
    (
        inuUsuario      IN  notas.notausua%TYPE
    )
    RETURN NUMBER
    IS 

        csbMT_NAME  CONSTANT VARCHAR2(100) := csbNOMPKG||'.fnuObtFuncionarioUsuario';
        sbMensErro  VARCHAR2(4000);
        nuCodError  NUMBER;

		nuFuncionarioUsuario    NUMBER;

        CURSOR cuObtFuncionarioUsuario
        IS
        SELECT person_id
        FROM ge_person pe
        WHERE pe.user_id = inuUsuario;
        
        PROCEDURE prcCierraCursor
        IS
            csbMT_NAME1  CONSTANT VARCHAR2(100) := csbMT_NAME||'.prcCierraCursor';
            sbMensErro1  VARCHAR2(4000);
            nuCodError1  NUMBER;
            
        BEGIN
        
            pkg_traza.trace(csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);    

            IF cuObtFuncionarioUsuario%ISOPEN THEN
                CLOSE cuObtFuncionarioUsuario;
            END IF;

            pkg_traza.trace(csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);        

        EXCEPTION
              when OTHERS then
                    pkg_error.SetError;
                    pkg_error.getError(nuCodError,sbMensErro);
                    pkg_traza.trace('Error:'||nuCodError||'-'||sbMensErro,pkg_traza.cnuNivelTrzDef);
                    pkg_traza.trace(csbMT_NAME,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);
                    RAISE pkg_Error.CONTROLLED_ERROR;
        END prcCierraCursor;              

	BEGIN

		pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);    
        
		OPEN cuObtFuncionarioUsuario;		
        FETCH cuObtFuncionarioUsuario INTO nuFuncionarioUsuario;
        CLOSE cuObtFuncionarioUsuario;

		pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

		RETURN nuFuncionarioUsuario;

    EXCEPTION
		  when OTHERS then
				pkg_error.SetError;
				pkg_error.getError(nuCodError,sbMensErro);
				pkg_traza.trace('Error:'||nuCodError||'-'||sbMensErro,pkg_traza.cnuNivelTrzDef);
				pkg_traza.trace(csbMT_NAME,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);
				prcCierraCursor;
				RETURN nuFuncionarioUsuario;
	end fnuObtFuncionarioUsuario;    	 

END pkg_bcpersonal;
/

BEGIN
  pkg_utilidades.prAplicarPermisos('PKG_BCPERSONAL', 'ADM_PERSON');
END;
/

