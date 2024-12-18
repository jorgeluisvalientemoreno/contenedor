CREATE OR REPLACE PROCEDURE ADM_PERSON.API_LOADFILETOREADING (inuActivity	      IN	NUMBER,
                                                              isbFileName	      IN	VARCHAR2,
                                                              isbObservation	  IN	VARCHAR2,
                                                              ibbFileSrc	      IN	BLOB,
                                                              onuErrorCode      OUT GE_MESSAGE.MESSAGE_ID%TYPE,
                                                              osbErrorMessage   OUT GE_ERROR_LOG.DESCRIPTION%TYPE) IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : API_LOADFILETOREADING
    Descripcion     : api permite almacenar un archivo para una lectura. 

    Autor           : Diana Saltarin
    Fecha           : 01-09-2023

    Parametros de Entrada
    inuActivity	    Identificador de la Actividad
    isbFileName	    Nombre del Archivo
    isbObservation	Observación del Archivo
    ibbFileSrc	    Fuente del Archivo

    Parametros de Salida
     onuErrorCode          codigo de error
     osbErrorMessage       mensaje de error
    Modificaciones  :
    =========================================================
    Autor       Fecha           Descripcion
  ***************************************************************************/

BEGIN
   UT_TRACE.TRACE('Inicio API_LOADFILETOREADING ', 10);
   onuErrorCode    := 0;
   osbErrorMessage := NULL;
   OS_LOADFILETOREADING(inuActivity,
                        isbFileName,
                        isbObservation,
                        ibbFileSrc,
                        onuErrorCode,
                        osbErrorMessage
                        );
  UT_TRACE.TRACE('Fin API_LOADFILETOREADING ', 10);
EXCEPTION
   WHEN pkg_Error.CONTROLLED_ERROR THEN
      pkg_Error.getError( onuErrorCode, osbErrorMessage );
      UT_TRACE.TRACE('Fin CONTROLLED_ERROR API_LOADFILETOREADING ['||osbErrorMessage||']', 10);
   WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError( onuErrorCode, osbErrorMessage );
      UT_TRACE.TRACE('Fin OTHERS API_LOADFILETOREADING ['||osbErrorMessage||']', 10);
END API_LOADFILETOREADING;
/
BEGIN

	pkg_utilidades.prAplicarPermisos('API_LOADFILETOREADING', 'ADM_PERSON'); 

END;
/

