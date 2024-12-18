create or replace procedure   adm_person.api_register_ntl ( inuProduct			IN  NUMBER,
                                                            inuGeograLocation	IN  NUMBER,
                                                            inuAddressId		IN  NUMBER,
                                                            inuProductType		IN  NUMBER,
                                                            isbComment			IN  VARCHAR2,
                                                            inuValue			IN  NUMBER,
                                                            isbInformer			IN  NUMBER,
                                                            isbStatus			IN  VARCHAR2,
                                                            inuActivityId		IN NUMBER,
                                                            onuId				OUT NUMBER,
                                                            onuOrderId			OUT NUMBER,
                                                            onuPackageId		OUT NUMBER,
                                                            onuErrorCode        OUT GE_MESSAGE.MESSAGE_ID%TYPE,
                                                            osbErrorMessage     OUT GE_ERROR_LOG.DESCRIPTION%TYPE,
                                                            inuPersonId			IN   NUMBER
                                                            ) IS
 /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
     Programa        : api_register_ntl
     Descripcion     : api Permite registrar una posible pérdida
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
        onuId	        Codigo Generado
        onuOrderId	    Codigo de la Orden de Trabajo
        onuPackageId	Identificador del Paquete
        onuErrorCode	Codigo de Error
        osbErrorMessage	Mensaje de Error

    Modificaciones  :
    =========================================================
    Autor       Fecha           Descripcion
  ***************************************************************************/

 BEGIN
   UT_TRACE.TRACE('Inicio API_REGISTER_NTL ', 10);
   pkg_error.prInicializaError(onuErrorCode, osbErrorMessage);
   
   OS_REGISTER_NTL( inuProduct,
                    inuGeograLocation,
                    inuAddressId,
                    inuProductType,
                    isbComment,
                    inuValue,
                    isbInformer,
                    isbStatus,
                    inuActivityId,
                    onuId,
                    onuOrderId,
                    onuPackageId,
                    onuErrorCode,
                    osbErrorMessage,
                    inuPersonId );
   UT_TRACE.TRACE('Fin API_REGISTER_NTL');
 EXCEPTION
   WHEN pkg_Error.CONTROLLED_ERROR THEN
      pkg_Error.getError( onuErrorCode, osbErrorMessage );
      UT_TRACE.TRACE('Fin CONTROLLED_ERROR API_REGISTER_NTL ['||osbErrorMessage||']', 10);
   WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError( onuErrorCode, osbErrorMessage );
      UT_TRACE.TRACE('Fin OTHERS API_REGISTER_NTL ['||osbErrorMessage||']', 10);
END api_register_ntl;
/
BEGIN
     pkg_utilidades.praplicarpermisos('API_REGISTER_NTL', 'ADM_PERSON');
END;
/