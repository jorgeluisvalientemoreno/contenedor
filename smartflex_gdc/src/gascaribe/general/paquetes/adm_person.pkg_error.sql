
create or replace package  adm_person.pkg_error is

  -- Author  : ELIANA BERDEJO
  -- Created : 1/06/2023 3:29:26 p.?m.
  -- Purpose : Manejo de Errores esquema Personalizaciones
  CONTROLLED_ERROR EXCEPTION;
  PRAGMA EXCEPTION_INIT(CONTROLLED_ERROR, -20002);

  CNUGENERIC_MESSAGE   CONSTANT NUMBER(6) := 2741;

  -- Public function and procedure declarations
  PROCEDURE setError;
  /*****************************************************************
      Procedimiento   :   setError
      Descripcion     :   Proceso que setea error

      Parametros de entrada

      Parametros de salida

      Historia de Modificaciones
      Fecha       Autor              Modificacion
      =========   =========       ====================
  ******************************************************************/
  PROCEDURE getError (onuCodeError OUT NUMBER,
                      osbMsgErrr   OUT VARCHAR2);
   /*****************************************************************
      Procedimiento   :   getError
      Descripcion     :   Proceso que devuelve codigo y mensaje de error

      Parametros de entrada

      Parametros de salida
        onuCodeError    codigo del error
        osbMsgErrr      mensaje de error

      Historia de Modificaciones
      Fecha       Autor              Modificacion
      =========   =========       ====================
  ******************************************************************/
  PROCEDURE setErrorMessage (inuCodeError IN NUMBER default CNUGENERIC_MESSAGE,
                             isbMsgErrr   IN VARCHAR2);
  /*****************************************************************
      Procedimiento   :   setErrorMessage
      Descripcion     :   Proceso que setea mensaje de error

      Parametros de entrada
        inuCodeError    codigo del error
        isbMsgErrr      mensaje de error

      Parametros de salida

      Historia de Modificaciones
      Fecha       Autor              Modificacion
      =========   =========       ====================
  ******************************************************************/
  PROCEDURE setApplication (isbPrograma IN VARCHAR2);
  /*****************************************************************
      Procedimiento   :   setApplication
      Descripcion     :   Proceso que setea aplicacion en ejecucion

      Parametros de entrada
        isbPrograma    nombre del programa

      Parametros de salida

      Historia de Modificaciones
      Fecha       Autor              Modificacion
      =========   =========       ====================
      06-06-2023  ljlb             OSF-1215 Creación
  ******************************************************************/

  FUNCTION getApplication RETURN VARCHAR2;
  /*****************************************************************
      Procedimiento   :   getApplication
      Descripcion     :   Proceso que devuelve aplicacion en ejecucion

      Parametros de entrada


      Parametros de salida

      Historia de Modificaciones
      Fecha       Autor              Modificacion
      =========   =========       ====================
      06-06-2023  ljlb             OSF-1215 Creación
  ******************************************************************/
  PROCEDURE prInicializaError( onuCodeError  OUT  NUMBER,
                               osbMsgErrr    OUT  VARCHAR2 );
  /*****************************************************************
      Procedimiento   :   prInicializaError
      Descripcion     :   Proceso que inicializa variables de error

      Parametros de entrada


      Parametros de salida
        onuCodeError    codigo de error
        osbMsgErrr      mensaje de error
      Historia de Modificaciones
      Fecha       Autor              Modificacion
      =========   =========       ====================
      06-06-2023  ljlb             OSF-1215 Creación
  ******************************************************************/
  
  PROCEDURE initialize;
  /*****************************************************************
      Procedimiento   :   initialize
      Descripcion     :   Proceso que inicializa variables de error

      Parametros de entrada

      Parametros de salida
      
      Historia de Modificaciones
      Fecha       Autor              Modificacion
      =========   =========       ====================
      06-06-2023  ljlb             OSF-1215 Creación
  ******************************************************************/
END Pkg_Error;
/
create or replace PACKAGE BODY adm_person.pkg_error IS


  -- Function and procedure implementations
  PROCEDURE setError is
  /*****************************************************************
      Procedimiento   :   setError
      Descripcion     :   Proceso que setea error

      Parametros de entrada

      Parametros de salida

      Historia de Modificaciones
      Fecha       Autor              Modificacion
      =========   =========       ====================
  ******************************************************************/
  BEGIN
     Errors.setError;
  END;

  PROCEDURE getError (onuCodeError OUT NUMBER,
                      osbMsgErrr   OUT VARCHAR2) IS
  /*****************************************************************
      Procedimiento   :   getError
      Descripcion     :   Proceso que devuelve codigo y mensaje de error

      Parametros de entrada

      Parametros de salida
        onuCodeError    codigo del error
        osbMsgErrr      mensaje de error

      Historia de Modificaciones
      Fecha       Autor              Modificacion
      =========   =========       ====================
  ******************************************************************/
  BEGIN
     Errors.getError(onuCodeError,
                     osbMsgErrr);
  END;

  PROCEDURE setErrorMessage (inuCodeError IN NUMBER default CNUGENERIC_MESSAGE,
                             isbMsgErrr   IN VARCHAR2)IS
  /*****************************************************************
      Procedimiento   :   setErrorMessage
      Descripcion     :   Proceso que setea mensaje de error

      Parametros de entrada
        inuCodeError    codigo del error
        isbMsgErrr      mensaje de error

      Parametros de salida

      Historia de Modificaciones
      Fecha       Autor              Modificacion
      =========   =========       ====================
  ******************************************************************/
  BEGIN

    ge_boerrors.seterrorcodeargument(inuCodeError,
                                     isbMsgErrr);	
  END;

   PROCEDURE setApplication (isbPrograma IN VARCHAR2) IS
  /*****************************************************************
      Procedimiento   :   setApplication
      Descripcion     :   Proceso que setea aplicacion en ejecucion

      Parametros de entrada
        isbPrograma    nombre del programa

      Parametros de salida

      Historia de Modificaciones
      Fecha       Autor              Modificacion
      =========   =========       ====================
      06-06-2023  ljlb             OSF-1215 Creación
  ******************************************************************/
  BEGIN

     pkErrors.setApplication(isbPrograma);
  EXCEPTION
    WHEN OTHERS THEN
       setError;
       RAISE CONTROLLED_ERROR;
  END setApplication;
  FUNCTION getApplication RETURN VARCHAR2 IS
  /*****************************************************************
      Procedimiento   :   getApplication
      Descripcion     :   Proceso que devuelve aplicacion en ejecucion

      Parametros de entrada


      Parametros de salida

      Historia de Modificaciones
      Fecha       Autor              Modificacion
      =========   =========       ====================
      06-06-2023  ljlb             OSF-1215 Creación
  ******************************************************************/
  BEGIN

     return pkErrors.fsbgetApplication;
  EXCEPTION
    WHEN OTHERS THEN
       setError;
       return pkErrors.fsbgetApplication;
  END getApplication;
  PROCEDURE prInicializaError( onuCodeError  OUT  NUMBER,
                               osbMsgErrr    OUT  VARCHAR2 ) IS
  /*****************************************************************
      Procedimiento   :   prInicializaError
      Descripcion     :   Proceso que inicializa variables de error

      Parametros de entrada


      Parametros de salida
        onuCodeError    codigo de error
        osbMsgErrr      mensaje de error
      Historia de Modificaciones
      Fecha       Autor              Modificacion
      =========   =========       ====================
      06-06-2023  ljlb             OSF-1215 Creación
  ******************************************************************/
  BEGIN
     onuCodeError := 0;
     osbMsgErrr   := NULL;
  EXCEPTION
    WHEN OTHERS THEN
       setError;
  END prInicializaError;
  
  PROCEDURE initialize IS
  /*****************************************************************
      Procedimiento   :   initialize
      Descripcion     :   Proceso que inicializa variables de error

      Parametros de entrada

      Parametros de salida
      
      Historia de Modificaciones
      Fecha       Autor              Modificacion
      =========   =========       ====================
      06-06-2023  ljlb             OSF-1215 Creación
  ******************************************************************/
  BEGIN
      Errors.initialize;
  END initialize;
END Pkg_Error;
/
GRANT EXECUTE ON adm_person.Pkg_Error TO SYSTEM_OBJ_PRIVS_ROLE
/
GRANT EXECUTE ON adm_person.Pkg_Error TO REXEINNOVA
/
GRANT EXECUTE ON adm_person.Pkg_Error TO PERSONALIZACIONES
/
