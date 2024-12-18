CREATE OR REPLACE PROCEDURE ADM_PERSON.API_REGTELEMEASCONSUMPTION ( isbMeasElemCode	    IN	VARCHAR2,
                                                                    inuConsumptionType	IN	NUMBER,
                                                                    idtConsumptionDate	IN	DATE,
                                                                    inuConsumptionUnits	IN	NUMBER,
                                                                    onuErrorCode        OUT GE_MESSAGE.MESSAGE_ID%TYPE,
                                                                    osbErrorMessage     OUT GE_ERROR_LOG.DESCRIPTION%TYPE) IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : API_REGTELEMEASCONSUMPTION
    Descripcion     : api realizar el registro de los consumos telemedidos
    Autor           : Diana Saltarin
    Fecha           : 01-09-2023

    Parametros de Entrada
    isbMeasElemCode	    Código del Elemento de Medición. 
    inuConsumptionType	Tipo de Consumo. 
    idtConsumptionDate	Fecha de Consumo. 
    inuConsumptionUnits	Unidades de Consumo. 

    Parametros de Salida
     onuErrorCode          codigo de error
     osbErrorMessage       mensaje de error
    Modificaciones  :
    =========================================================
    Autor       Fecha           Descripcion
  ***************************************************************************/

BEGIN
   UT_TRACE.TRACE('Inicio API_REGTELEMEASCONSUMPTION ', 10);
   onuErrorCode    := 0;
   osbErrorMessage := NULL;
   OS_REGTELEMEASCONSUMPTION(  isbMeasElemCode,
                               inuConsumptionType,
                               idtConsumptionDate,
                               inuConsumptionUnits,
                               onuErrorCode,
                               osbErrorMessage);
  UT_TRACE.TRACE('Fin API_REGTELEMEASCONSUMPTION ', 10);
EXCEPTION
   WHEN pkg_Error.CONTROLLED_ERROR THEN
      pkg_Error.getError( onuErrorCode, osbErrorMessage );
      UT_TRACE.TRACE('Fin CONTROLLED_ERROR API_REGTELEMEASCONSUMPTION ['||osbErrorMessage||']', 10);
   WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError( onuErrorCode, osbErrorMessage );
      UT_TRACE.TRACE('Fin OTHERS API_REGTELEMEASCONSUMPTION ['||osbErrorMessage||']', 10);
END API_REGTELEMEASCONSUMPTION;
/
BEGIN

	pkg_utilidades.prAplicarPermisos('API_REGTELEMEASCONSUMPTION', 'ADM_PERSON'); 

END;
/

