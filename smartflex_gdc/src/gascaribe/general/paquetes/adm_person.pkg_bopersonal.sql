create or replace package adm_person.pkg_bopersonal IS
   /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : PKG_BOPERSONAL
    Descripcion     : Paquete para hacer el llamado a objetos de OPEN instanciados
    Autor           : Jhon Soto
    Fecha           : 15-09-2023

    Parametros de Entrada     
    Parametros de Salida

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso    Descripcion
    epenao      12/10/2023  OSF-1702 + Creación de la función fnuGetUsuario
                                       la cual recibe el id de la persona y retorna
                                       el id del usario. 
	jsoto		15/01/2024	OSF-2175 Se eliminan las constantes para estado del producto
	cgonzalez	26/11/2024	OSF-3668 Se adiciona servicio fnuObtPersonaPorUsuario
    jpinedc     08/04/2025  OSF-4205 Se modifica fnuObtPersonaPorUsuario	
  ***************************************************************************/
    
  
  FUNCTION fnuGetPersonaId
    RETURN NUMBER;
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuGetPersonaId
    Descripcion     : Función para retornar el ID de la persona conectada en el sistema
    Autor           : Jhon Soto
    Fecha           : 15-09-2023

    Parametros de Entrada N/A
    Parametros de Salida  Retorna el ID de la persona conectada en el sistema

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso    Descripcion
  ***************************************************************************/
  
  FUNCTION fnuGetPuntoAtencionId (inuPersonaId IN ge_person.person_id%type)
    RETURN NUMBER;
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuGetPuntoAtencionId
    Descripcion     : Función para Obtener el ID del punto de atención actual de la persona conectada al sistema
    Autor           : Jhon Soto
    Fecha           : 15-09-2023

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso    Descripcion
  ***************************************************************************/


   FUNCTION fnuGetPersonIdPorIdentif (inuIdentificacion     IN ge_person.number_id%TYPE,
                                      inuTipoIdentificacion IN ge_person.ident_type_id%TYPE,
                                      onuPersonaID          OUT ge_person.person_id%TYPE)
   RETURN BOOLEAN ;
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuGetPersonIdPorIdentif
    Descripcion     : Función para validar si existe el numero y tipo de identificación y devuelve el id de la persona
    Autor           : Jhon Soto
    Fecha           : 28-09-2023

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso    Descripcion
  ***************************************************************************/

PROCEDURE prRegistraPersona 
       (
           isbNombre                     IN ge_person.name_%TYPE,
           isbidentificacion             IN ge_person.number_id%TYPE,
           inuTipoIdentificcion          IN ge_person.ident_type_id%TYPE,
           inuDireccionId                IN ge_person.address_id%TYPE,
           isbTelefono                   IN ge_person.phone_number%TYPE,
           isbCorreo                     IN ge_person.e_mail%TYPE,
           isbbeeper                     IN ge_person.beeper%TYPE,
           inuTipoPersona                IN ge_person.personal_type%TYPE,
           inuAreaOrg                    IN ge_person.organizat_area_id%TYPE,
           inuUbicacionGeogra            IN ge_person.geograp_location_id%TYPE,
           inuUsuarioID                  IN ge_person.user_id%TYPE,
           ionuPersonaId                 IN out ge_person.person_id%TYPE
     );
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prRegistraPersona
    Descripcion     : proceso para crear personas
    Autor           : Jhon Soto (Horbath) 
    Fecha           : 28-09-2023

    Parametros de Entrada     
           isbNombre                     Nombre
           isbidentificacion             Identificacion
           inuTipoIdentificcion          Tipo Identificacion
           inuDireccionId                Direccion
           isbTelefono                   Telefono
           isbCorreo                     Correo
           isbbeeper                     Beeper
           inuTipoPersona                Tipo de persona
           inuAreaOrg                    Area Organizacional
           inuUbicacionGeogra            Ubicacion geográfica
           inuUsuarioID                  Id de Usuario
      Parametro de entrada y/o salida
            ionuPersonaId                 Id de Persona
 
 
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso    Descripcion
    jsoto       28/09/2023  OSF-1664    Creacion
  ***************************************************************************/

  --Retorna el id del usuario para el id de persona enviado
  FUNCTION fnuObtPersonaPorUsuario
  (
    inuUsuarioID    in    sa_user.user_id%type
  )
  RETURN  ge_person.person_id%type;

END pkg_bopersonal;
/
create or replace package body     adm_person.pkg_bopersonal IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : PKG_BOPERSONAL
    Descripcion     : Paquete para hacer el llamado a objetos de OPEN instanciados
    Autor           : Jhon Soto
    Fecha           : 15-09-2023

    Parametros de Entrada
    Parametros de Salida

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso    Descripcion
  ***************************************************************************/
  
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuGetPersonaId
    Descripcion     : Función para retornar el ID de la persona conectada en el sistema
    Autor           : Jhon Soto
    Fecha           : 15-09-2023

    Parametros de Entrada N/A
    Parametros de Salida  Retorna el ID de la persona conectada en el sistema

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso    Descripcion
  ***************************************************************************/
    -- Constantes para el control de la traza
    csbNOMPKG 	CONSTANT VARCHAR2(35):= $$PLSQL_UNIT||'.';



    FUNCTION fnuGetPersonaId
    RETURN NUMBER IS
         csbMetodo  CONSTANT VARCHAR2(100) := csbNOMPKG||'fnuGetPersonaId'; 
    BEGIN
        pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbINICIO);
        pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN); 
     return(ge_bopersonal.fnugetpersonid);

    END fnuGetPersonaId;
   
   
     /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuGetPuntoAtencionId
    Descripcion     : Función para Obtener el ID del punto de atención actual de la persona conectada al sistema
    Autor           : Jhon Soto
    Fecha           : 15-09-2023

    Parametros de Entrada
        inuPersonaId Id de la persona para buscar su punto de atención actual.
    
    Parametros de Salida
        Retorna el punto de atención actual para la persona que viene en el parametro

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso    Descripcion
  ***************************************************************************/

   FUNCTION fnuGetPuntoAtencionId (inuPersonaId     IN ge_person.person_id%type)
   RETURN NUMBER IS
       csbMetodo  CONSTANT VARCHAR2(100) := csbNOMPKG||'fnuGetPuntoAtencionId';
    BEGIN
        pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbINICIO);
        pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN);
     return(ge_bopersonal.fnugetcurrentchannel(inuPersonaID,constants_per.GetTrue()));
    
    END fnuGetPuntoAtencionId;  

  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuGetPersonIdPorIdentif
    Descripcion     : Función para validar si existe el numero y tipo de identificación y devuelve el id de la persona
    Autor           : Jhon Soto
    Fecha           : 28-09-2023

    Parametros de entrada:
    inuIdentificacion     Numero de identificacion
    inuTipoIdentificacion Tipo de identificacion

    Parametros de salida :
    onuPersonaID          Id de la persona asociada a la identificacion y tipo ingresadas    

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso    Descripcion
    jsoto       28/09/2023  1664    Creacion
  ***************************************************************************/

   FUNCTION fnuGetPersonIdPorIdentif (inuIdentificacion     IN ge_person.number_id%TYPE,
                                      inuTipoIdentificacion IN ge_person.ident_type_id%TYPE,
                                      onuPersonaID          OUT ge_person.person_id%TYPE)
   RETURN BOOLEAN IS
      csbMetodo     CONSTANT VARCHAR2(50) := 'FNUGETPERSONIDPORIDENTIF'; 
    BEGIN
        pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbINICIO);
        pkg_traza.trace('inuIdentificacion: '||inuIdentificacion||
                        '  inuTipoIdentificacion: '|| inuTipoIdentificacion, pkg_traza.cnuNivelTrzDef);
                                      
        pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN);                     
     return(ge_bopersonal.valididentification(inuIdentificacion,inuTipoIdentificacion,onuPersonaID));

    END fnuGetPersonIdPorIdentif;  
  
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prRegistraPersona
    Descripcion     : proceso para crear personas
    Autor           : Jhon Soto (Horbath) 
    Fecha           : 28-09-2023

    Parametros de Entrada     
           isbNombre                     Nombre
           isbidentificacion             Identificacion
           inuTipoIdentificcion          Tipo Identificacion
           inuDireccionId                Direccion
           isbTelefono                   Telefono
           isbCorreo                     Correo
           isbbeeper                     Beeper
           inuTipoPersona                Tipo de persona
           inuAreaOrg                    Area Organizacional
           inuUbicacionGeogra            Ubicacion geográfica
           inuUsuarioID                  Id de Usuario
      Parametro de entrada y/o salida
            ionuPersonaId                 Id de Persona
 
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso    Descripcion
    jsoto       28/09/2023  1664    Creacion
  ***************************************************************************/

PROCEDURE prRegistraPersona 
       (
           isbNombre                     IN ge_person.name_%TYPE,
           isbidentificacion             IN ge_person.number_id%TYPE,
           inuTipoIdentificcion          IN ge_person.ident_type_id%TYPE,
           inuDireccionId                IN ge_person.address_id%TYPE,
           isbTelefono                   IN ge_person.phone_number%TYPE,
           isbCorreo                     IN ge_person.e_mail%TYPE,
           isbbeeper                     IN ge_person.beeper%TYPE,
           inuTipoPersona                IN ge_person.personal_type%TYPE,
           inuAreaOrg                    IN ge_person.organizat_area_id%TYPE,
           inuUbicacionGeogra            IN ge_person.geograp_location_id%TYPE,
           inuUsuarioID                  IN ge_person.user_id%TYPE,
           ionuPersonaId                 IN out ge_person.person_id%TYPE
     )
IS

     csbMetodo     CONSTANT VARCHAR2(50) := 'PRREGISTRAPERSONA'; 
	 nuCodError	   NUMBER;
	 sbMenError	   VARCHAR2(4000);
 
BEGIN

     
    pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbINICIO);

	ge_bopersonal.register(isbNombre,
						   isbidentificacion,
						   inuTipoIdentificcion,
						   inuDireccionId,
						   isbTelefono,
						   isbCorreo,
						   isbbeeper,
						   inuTipoPersona,
						   inuAreaOrg,
						   inuUbicacionGeogra,
						   inuUsuarioID,
						   ionuPersonaId);

    pkg_traza.trace(' Persona creada: '||ionuPersonaId, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN);

    EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
		pkg_Error.getError(nuCodError,sbMenError);
		pkg_traza.trace(csbMetodo||' '||sbMenError, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERC);
        RAISE pkg_error.CONTROLLED_ERROR;
    WHEN others THEN
        pkg_Error.setError;
		pkg_Error.getError(nuCodError,sbMenError);
		pkg_traza.trace(csbMetodo||' '||sbMenError, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);
        RAISE pkg_error.CONTROLLED_ERROR;
END prRegistraPersona;

  
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuObtPersonaPorUsuario
    Descripcion     : Proceso para consultar persona mediante id de usuario
    Autor           : Jhon Soto (Horbath) 
    Fecha           : 26-11-2024

    Parametros de Entrada     
           inuUsuarioID                  Id de Usuario
      Parametro de entrada y/o salida
            ionuPersonaId                 Id de Persona

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso    Descripcion
    jsoto       26/11/2024  3668    Creacion
    jpinedc     08/04/2025  4205    Se usa pkg_bcPersonal.fnuObtFuncionarioUsuario
    ***************************************************************************/
    FUNCTION fnuObtPersonaPorUsuario
    (
        inuUsuarioID    in    sa_user.user_id%type
    )
    RETURN  ge_person.person_id%type
    IS             
        csbMETODO     CONSTANT VARCHAR2(100) := csbNOMPKG||'fnuObtPersonaPorUsuario';
        nuCodError    ge_error_log.message_id%TYPE;--Código mensaje de error
        sbMenError    ge_error_log.description%TYPE;--Descripción mensaje de error
        nuPerson      ge_person.person_id%type;
      
    BEGIN
        pkg_traza.trace(csbMETODO,pkg_traza.cnuNivelTrzDef,pkg_traza.csbINICIO);   

        pkg_traza.trace('Id Usuario|'||inuUsuarioID,pkg_traza.cnuNivelTrzDef);
        
        nuPerson    :=  pkg_bcPersonal.fnuObtFuncionarioUsuario(inuUsuarioID);
  
        pkg_traza.trace('Id Funcionario|'||nuPerson,pkg_traza.cnuNivelTrzDef);
      
        pkg_traza.trace(csbMETODO,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN);
        
        RETURN nuPerson;
        
    EXCEPTION
        WHEN OTHERS THEN
            pkg_error.SetError;  
            pkg_error.GetError(nuCodError,sbMenError);          
            pkg_traza.trace(csbMetodo||' '|| 'Error:'||nuCodError||'-'||sbMenError);
            pkg_traza.trace(csbMETODO, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RETURN nuPerson;       
    END fnuObtPersonaPorUsuario;
  
END pkg_bopersonal;
/
PROMPT Otorgando permisos de ejecución a pkg_bopersonal
BEGIN
  pkg_utilidades.prAplicarPermisos('PKG_BOPERSONAL','ADM_PERSON');
END;
/