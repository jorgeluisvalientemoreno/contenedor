create or replace procedure   adm_person.api_pegencontractobligat ( inuPeriodId		  IN  NUMBER,
                                                                    idbCutOffDate	  IN  DATE,
                                                                    inuContractTypeId IN  NUMBER,
                                                                    inuContractorId	  IN  NUMBER,
                                                                    inuAdminBaseId	  IN  NUMBER,
                                                                    onuErrorCode      OUT GE_MESSAGE.MESSAGE_ID%TYPE,
                                                                    osbErrorMessage   OUT GE_ERROR_LOG.DESCRIPTION%TYPE ) IS
 /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
     Programa        : api_pegencontractobligat
     Descripcion     : api para la Generacion de Obligaciones a contratistas
     Autor           : Luis Javier Lopez
     Fecha           : 23-08-2023

    Parametros de Entrada
        inuPeriodId             Codigo del periodo (Obligatorio)
        idbCutOffDate           Fecha de corte (Obligatorio)
        inuContractTypeId       Codigo de Tipo de contrato (Opcional)
        inuContractorId         Codigo de contratista (Opcional)
        inuAdminBaseId          Codigo de la Base administrativa (Opcional)

    Parametros de Salida       
        onuErrorCode          codigo de error
        osbErrorMessage       mensaje de error
    Modificaciones  :
    =========================================================
    Autor       Fecha           Descripcion
  ***************************************************************************/

 BEGIN
   UT_TRACE.TRACE('Inicio API_PEGENCONTRACTOBLIGAT ', 10);
   pkg_error.prInicializaError(onuErrorCode, osbErrorMessage);
   
   OS_PEGenContractObligat( inuPeriodId,
                            idbCutOffDate,
                            inuContractTypeId,
                            inuContractorId,
                            inuAdminBaseId,
                            onuErrorCode,
                            osbErrorMessage );
  UT_TRACE.TRACE('Fin API_PEGENCONTRACTOBLIGAT');
 EXCEPTION
   WHEN pkg_Error.CONTROLLED_ERROR THEN
      pkg_Error.getError( onuErrorCode, osbErrorMessage );
      UT_TRACE.TRACE('Fin CONTROLLED_ERROR API_PEGENCONTRACTOBLIGAT ['||osbErrorMessage||']', 10);
   WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError( onuErrorCode, osbErrorMessage );
      UT_TRACE.TRACE('Fin OTHERS API_PEGENCONTRACTOBLIGAT ['||osbErrorMessage||']', 10);
END api_pegencontractobligat;
/
BEGIN
     pkg_utilidades.praplicarpermisos('API_PEGENCONTRACTOBLIGAT', 'ADM_PERSON');
END;
/