create or replace procedure   adm_person.api_setcommercialsegment ( iclCommercialSegment IN  CLOB,
                                                                    onuErrorCode         OUT GE_MESSAGE.MESSAGE_ID%TYPE,
                                                                    osbErrorMessage      OUT GE_ERROR_LOG.DESCRIPTION%TYPE ) IS
 /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
     Programa        : api_setcommercialsegment
     Descripcion     : api Almacena (inserta, actualiza y elimina) información de un segmento comercial
     Autor           : Luis Javier Lopez
     Fecha           : 23-08-2023

    Parametros de Entrada
        iclCommercialSegment	CLOB con toda la composición de segmento comercial 
                                (Nombre, Características y Oferta).
    
    Parametros de Salida       
        onuErrorCode	Codigo de Error
        osbErrorMessage	Mensaje de Error

    Modificaciones  :
    =========================================================
    Autor       Fecha           Descripcion
  ***************************************************************************/

 BEGIN
   UT_TRACE.TRACE('Inicio API_SETCOMMERCIALSEGMENT ', 10);
   pkg_error.prInicializaError(onuErrorCode, osbErrorMessage);
   
   os_setcommercialsegment( iclCommercialSegment,
                            onuErrorCode,
                            osbErrorMessage);
   UT_TRACE.TRACE('Fin API_SETCOMMERCIALSEGMENT');
 EXCEPTION
   WHEN pkg_Error.CONTROLLED_ERROR THEN
      pkg_Error.getError( onuErrorCode, osbErrorMessage );
      UT_TRACE.TRACE('Fin CONTROLLED_ERROR API_SETCOMMERCIALSEGMENT ['||osbErrorMessage||']', 10);
   WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError( onuErrorCode, osbErrorMessage );
      UT_TRACE.TRACE('Fin OTHERS API_SETCOMMERCIALSEGMENT ['||osbErrorMessage||']', 10);
END api_setcommercialsegment;
/
BEGIN
     pkg_utilidades.praplicarpermisos('API_SETCOMMERCIALSEGMENT', 'ADM_PERSON');
END;
/