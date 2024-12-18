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
    Autor       Fecha       Caso    Descripcion
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
    csbVERSION      CONSTANT VARCHAR2(10) := 'OSF-3668';


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

		return(sbUser);

		pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

	EXCEPTION
		  when OTHERS then
				pkg_error.SetError;
				pkg_error.getError(nuCodError,sbMensErro);
				pkg_traza.trace('Error:'||nuCodError||'-'||sbMensErro,pkg_traza.cnuNivelTrzDef);
				pkg_traza.trace(csbMT_NAME,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);
				RETURN sbUser;
	end fsbObtNombrePorUsuario;    

END pkg_bcpersonal;
/

BEGIN
  pkg_utilidades.prAplicarPermisos('PKG_BCPERSONAL', 'ADM_PERSON');
END;
/