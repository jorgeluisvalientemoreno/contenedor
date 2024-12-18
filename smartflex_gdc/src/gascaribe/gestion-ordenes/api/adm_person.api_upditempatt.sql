create or replace procedure adm_person.api_upditempatt( iclXmlin          IN  CLOB, 
                                                        onuErrorCode     OUT GE_MESSAGE.MESSAGE_ID%TYPE, 
                                                        osbErrorMessage  OUT GE_ERROR_LOG.DESCRIPTION%TYPE )
 /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
     Programa        : API_UPDITEMPATT
     Descripcion     : API para certificación de ítems seriados
     Autor           : Luis Javier Lopez
     Fecha           : 28-08-2023

    Parametros de Entrada
     iclXmlin    XML con Serie del Equipo, Fecha hasta la cual se Certificará 
                 y Mensaje de Trazabilidad

    Parametros de Salida
     onuErrorCode          codigo de error
     osbErrorMessage       mensaje de error
    Modificaciones  :
    =========================================================
    Autor       Fecha           Descripción
  ***************************************************************************/

 IS
 BEGIN
   UT_TRACE.TRACE('Inicio API_UPDITEMPATT ', 10);
   OS_UPDITEMPATT( iclXmlin, onuErrorCode, osbErrorMessage );
   UT_TRACE.TRACE('Fin API_UPDITEMPATT ', 10);
 EXCEPTION
   WHEN pkg_Error.CONTROLLED_ERROR THEN
      pkg_Error.GETERROR( onuErrorCode, osbErrorMessage );
      UT_TRACE.TRACE('Fin CONTROLLED_ERROR API_UPDITEMPATT ['||osbErrorMessage||']', 10);
   WHEN OTHERS THEN
      pkg_Error.SETERROR;
      pkg_Error.GETERROR( onuErrorCode, osbErrorMessage );
      UT_TRACE.TRACE('Fin OTHERS API_UPDITEMPATT ['||osbErrorMessage||']', 10);
END api_upditempatt;
/
BEGIN
 pkg_utilidades.praplicarpermisos('API_UPDITEMPATT', 'ADM_PERSON');
END;
/