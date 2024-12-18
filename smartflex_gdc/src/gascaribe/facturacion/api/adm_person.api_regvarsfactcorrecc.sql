CREATE OR REPLACE PROCEDURE ADM_PERSON.API_REGVARSFACTCORRECC (inuRefType	      IN	NUMBER,
                                                               iclXMLReference	IN	CLOB,
                                                               iclXmlInfoVar	  IN	CLOB,
                                                               oclXmlOutput	    OUT	CLOB,
                                                               onuErrorCode     OUT GE_MESSAGE.MESSAGE_ID%TYPE,
                                                               osbErrorMessage  OUT GE_ERROR_LOG.DESCRIPTION%TYPE) IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : API_REGVARSFACTCORRECC
    Descripcion     : api registrar los valores de las variables usadas para el cálculo los factores de corrección
    Autor           : Diana Saltarin
    Fecha           : 01-09-2023

    Parametros de Entrada
    inuRefType	         "Tipo de Referencia:
                          1 Localidad
                          2 Elemento de Medición
                          3 Producto"
    iclXMLReference	      Referencia de la Variable 
    iclXmlInfoVar	        Información de la Variable


    Parametros de Salida
     oclXmlOutput	         XML de Salida
     onuErrorCode          codigo de error
     osbErrorMessage       mensaje de error
    Modificaciones  :
    =========================================================
    Autor       Fecha           Descripcion
  ***************************************************************************/

BEGIN
   UT_TRACE.TRACE('Inicio API_REGVARSFACTCORRECC ', 10);
   onuErrorCode    := 0;
   osbErrorMessage := NULL;
   OS_REGVARSFACTCORRECC( inuRefType,
                          iclXMLReference,
                          iclXmlInfoVar,
                          oclXmlOutput,
                          onuErrorCode,
                          osbErrorMessage);
  UT_TRACE.TRACE('Fin API_REGVARSFACTCORRECC ', 10);
EXCEPTION
   WHEN pkg_Error.CONTROLLED_ERROR THEN
      pkg_Error.getError( onuErrorCode, osbErrorMessage );
      UT_TRACE.TRACE('Fin CONTROLLED_ERROR API_REGVARSFACTCORRECC ['||osbErrorMessage||']', 10);
   WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError( onuErrorCode, osbErrorMessage );
      UT_TRACE.TRACE('Fin OTHERS API_REGVARSFACTCORRECC ['||osbErrorMessage||']', 10);
END API_REGVARSFACTCORRECC;
/
BEGIN

	pkg_utilidades.prAplicarPermisos('API_REGVARSFACTCORRECC', 'ADM_PERSON'); 

END;
/

