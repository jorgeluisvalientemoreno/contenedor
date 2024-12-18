CREATE OR REPLACE PROCEDURE adm_person.api_setcustworkdata (  inuCustomerID			    IN  NUMBER,
                                                              inuIdentificationTypeID	IN  NUMBER,
                                                              isbIdentification		    IN  VARCHAR2,
                                                              isbOccupation			    IN  VARCHAR2,
                                                              isbTitle				    IN  VARCHAR2,
                                                              inuActivityID			    IN  NUMBER,
                                                              isbWorkArea				IN  VARCHAR2,
                                                              isbCompany				IN  VARCHAR2,
                                                              inuExperience			    IN  NUMBER,
                                                              idtHireDate				IN  DATE,
                                                              inuOfficeAddressID		IN  NUMBER,
                                                              isbOfficePhone			IN  VARCHAR2,
                                                              isbOfficePhoneExtension	IN  NUMBER,
                                                              inuWorkedTime			    IN  NUMBER,
                                                              inuPreviousActivityID	    IN  NUMBER,
                                                              isbPreviousCompany		IN  VARCHAR2,
                                                              isbPreviousOccupation	    IN  VARCHAR2,
                                                              inuPreviousWorkTime		IN  NUMBER,
                                                              onuErrorCode        	    OUT GE_MESSAGE.MESSAGE_ID%TYPE, 
                                                              osbErrorMessage     	    OUT GE_ERROR_LOG.DESCRIPTION%TYPE) IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : API_SETCUSTWORKDATA
    Descripcion     : api registrar informacion laboral de cliente
    Autor           : Luis Javier Lopez
    Fecha           : 01-09-2023

    Parametros de Entrada
     inuCustomerID	            Codigo Cliente
     inuIdentificationTypeID	Codigo Tipo de Identificacion
     isbIdentification	        Numero de Identificacion
     isbOccupation	            Ocupacion
     isbTitle	                Cargo
     inuActivityID	            Codigo Actividad
     isbWorkArea	            Area de Trabajo
     isbCompany	                Empresa
     inuExperience	            Experiencia
     idtHireDate	            Fecha Contratacion
     inuOfficeAddressID	        Codigo Direccion Oficina
     isbOfficePhone	            Telefono Oficina
     isbOfficePhoneExtension	Extension Telefono Oficina
     inuWorkedTime	            Tiempo En Cargo
     inuPreviousActivityID	    Codigo Actividad Anterior
     isbPreviousCompany	        Empresa Anterior
     isbPreviousOccupation	    Ocupacion Anterior
     inuPreviousWorkTime	    Tiempo En Cargo Anterior
      
    Parametros de Salida
     onuErrorCode          codigo de error
     osbErrorMessage       mensaje de error
    Modificaciones  :
    =========================================================
    Autor       Fecha           Descripcion
  ***************************************************************************/

BEGIN
   UT_TRACE.TRACE('Inicio API_SETCUSTWORKDATA ', 10);
   OS_SETCUSTWORKDATA( inuCustomerID,
                        inuIdentificationTypeID,
                        isbIdentification,
                        isbOccupation,
                        isbTitle,
                        inuActivityID,
                        isbWorkArea,
                        isbCompany,
                        inuExperience,
                        idtHireDate,
                        inuOfficeAddressID,
                        isbOfficePhone,
                        isbOfficePhoneExtension,
                        inuWorkedTime,
                        inuPreviousActivityID,
                        isbPreviousCompany,
                        isbPreviousOccupation,
                        inuPreviousWorkTime,
                        onuErrorCode,
                        osbErrorMessage );
  UT_TRACE.TRACE('Fin API_SETCUSTWORKDATA ', 10);
EXCEPTION
   WHEN pkg_Error.CONTROLLED_ERROR THEN
      pkg_Error.getError( onuErrorCode, osbErrorMessage );
      UT_TRACE.TRACE('Fin CONTROLLED_ERROR API_SETCUSTWORKDATA ['||osbErrorMessage||']', 10);
   WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError( onuErrorCode, osbErrorMessage );
      UT_TRACE.TRACE('Fin OTHERS API_SETCUSTWORKDATA ['||osbErrorMessage||']', 10);
END API_SETCUSTWORKDATA;
/
BEGIN
 pkg_utilidades.praplicarpermisos('API_SETCUSTWORKDATA', 'ADM_PERSON');
END;
/