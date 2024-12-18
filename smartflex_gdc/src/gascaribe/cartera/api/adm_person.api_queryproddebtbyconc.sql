create or replace procedure   adm_person.api_queryproddebtbyconc ( inuSesunuse            IN NUMBER,
                                                                   isbPunished            IN VARCHAR2,
                                                                   ocuQueryProdDebtByConc OUT CONSTANTS_PER.TYREFCURSOR,
                                                                   onuErrorCode           OUT GE_MESSAGE.MESSAGE_ID%TYPE,
                                                                   osbErrorMessage        OUT GE_ERROR_LOG.DESCRIPTION%TYPE ) IS
 /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
     Programa        : api_queryproddebtbyconc
     Descripcion     : api obtener la deuda por concepto del producto ingresado como parámetro de entrada. 
     Autor           : Luis Javier Lopez
     Fecha           : 23-08-2023

    Parametros de Entrada
        inuSesunuse             Codigo del Producto
        isbPunished           Tipo de Proceso
     Parametros de Salida       
        ocuQueryProdDebtByConc  Detalle de la Deuda
        onuErrorCode          codigo de error
        osbErrorMessage       mensaje de error
    Modificaciones  :
    =========================================================
    Autor       Fecha           Descripcion
  ***************************************************************************/

 BEGIN
   UT_TRACE.TRACE('Inicio API_QUERYPRODDEBTBYCONC ', 10);
   pkg_error.prInicializaError(onuErrorCode, osbErrorMessage);
   
   os_queryproddebtbyconc( inuSesunuse,
                           isbPunished,                           
                           ocuQueryProdDebtByConc,
                           onuErrorCode,
                           osbErrorMessage );
  UT_TRACE.TRACE('Fin API_QUERYPRODDEBTBYCONC');
 EXCEPTION
   WHEN pkg_Error.CONTROLLED_ERROR THEN
      pkg_Error.getError( onuErrorCode, osbErrorMessage );
      UT_TRACE.TRACE('Fin CONTROLLED_ERROR API_QUERYPRODDEBTBYCONC ['||osbErrorMessage||']', 10);
   WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError( onuErrorCode, osbErrorMessage );
      UT_TRACE.TRACE('Fin OTHERS API_PEGENCONTRACTOBLIGAT ['||osbErrorMessage||']', 10);
END api_queryproddebtbyconc;
/
BEGIN
     pkg_utilidades.praplicarpermisos('API_QUERYPRODDEBTBYCONC', 'ADM_PERSON');
END;
/