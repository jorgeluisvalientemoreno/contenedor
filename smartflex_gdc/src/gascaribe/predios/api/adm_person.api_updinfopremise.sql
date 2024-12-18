create or replace procedure   adm_person.api_updinfopremise (   inuPremiseId	IN 	NUMBER,
                                                                isbRing			IN 	VARCHAR2,
                                                                idtDateRing		IN 	DATE,
                                                                isbConnection	IN 	VARCHAR2,
                                                                isbInternal		IN 	VARCHAR2,
                                                                inuInternalType	IN 	VARCHAR2,
                                                                isbMeauserment	IN 	VARCHAR2,
                                                                inuNumPoints	IN 	NUMBER,
                                                                inuLevelRisk	IN 	NUMBER,
                                                                isbDescRisk		IN 	VARCHAR2,
                                                                onuErrorCode        OUT GE_MESSAGE.MESSAGE_ID%TYPE,
                                                                osbErrorMessage     OUT GE_ERROR_LOG.DESCRIPTION%TYPE ) IS
 /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
     Programa        : api_updinfopremise
     Descripcion     : api Permite la modificacion de los datos adicionales de un predio
     Autor           : Luis Javier Lopez
     Fecha           : 23-08-2023

    Parametros de Entrada
        inuProduct	        Producto
        inuGeograLocation	Ubicacion Geografica
        inuAddressId	    Direccion 
        inuProductType	    Tipo de Producto
        isbComment	        Comentario
        inuValue	        Valor de la Posible Perdida
        isbInformer	        Suscriptor Informante
        isbStatus	        Estado
        inuActivityId	    Codigo del Item

     Parametros de Salida       
        onuErrorCode	Codigo de Error
        osbErrorMessage	Mensaje de Error

    Modificaciones  :
    =========================================================
    Autor       Fecha           Descripcion
  ***************************************************************************/

 BEGIN
   UT_TRACE.TRACE('Inicio API_UPDINFOPREMISE ', 10);
   pkg_error.prInicializaError(onuErrorCode, osbErrorMessage);
   
   api_updinfopremise( inuPremiseId,
                       isbRing,
                       idtDateRing,
                       isbConnection,
                       isbInternal,
                       inuInternalType,
                       isbMeauserment,
                       inuNumPoints,
                       inuLevelRisk,
                       isbDescRisk,
                       onuErrorCode,
                       osbErrorMessage);
   UT_TRACE.TRACE('Fin API_UPDINFOPREMISE');
 EXCEPTION
   WHEN pkg_Error.CONTROLLED_ERROR THEN
      pkg_Error.getError( onuErrorCode, osbErrorMessage );
      UT_TRACE.TRACE('Fin CONTROLLED_ERROR API_UPDINFOPREMISE ['||osbErrorMessage||']', 10);
   WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError( onuErrorCode, osbErrorMessage );
      UT_TRACE.TRACE('Fin OTHERS API_UPDINFOPREMISE ['||osbErrorMessage||']', 10);
END api_updinfopremise;
/
BEGIN
     pkg_utilidades.praplicarpermisos('API_UPDINFOPREMISE', 'ADM_PERSON');
END;
/