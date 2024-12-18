create or replace PROCEDURE  adm_person.api_registerRequestByXml ( isbRequestXML      IN   CONSTANTS_PER.TIPO_XML_SOL%TYPE,
                                                                    onuPackageId      OUT  NUMBER,
                                                                    onuMotiveId       OUT  NUMBER,
                                                                    onuErrorCode      OUT  NUMBER,
                                                                    osbErrorMessage   OUT  VARCHAR2) is
/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : api_registerRequestByXml
    Descripcion     : api para realizar registro de solicitud mediante xml
    Autor           : Luis Javier Lopez Barrios
    Fecha           : 14-06-2023
    Parametros de Entrada
       isbRequestXML         XML de la solicitud a generar


    Parametros de Salida
       onuPackageId          solicitud
	   onuMotiveId           motivo
	   onuErrorCode     	 codigo de error
       osbErrorMessage   	 mensaje de error
    Modificaciones  :
    =========================================================
    Autor       Fecha           Descripción
    Jsoto       14/09/2023      Se cambia tipo de dato isbRequestXML por CONSTANTS_PER.TIPO_XML_SOL
  ***************************************************************************/
    nuLevel     NUMBER(2);
    nuTraceOut  NUMBER(1);
BEGIN
    nuLevel     := ut_trace.GETLEVEL;
    nuTraceOut  := ut_trace.GETOUTPUT;
    os_registerrequestwithxml(isbRequestXML,
                              onuPackageId,
                              onuMotiveId ,
                              onuErrorCode  ,
                              osbErrorMessage);
    ut_trace.SETOUTPUT(nuTraceOut);
    ut_trace.SETLEVEL(nuLevel);
EXCEPTION
    WHEN PKG_ERROR.CONTROLLED_ERROR THEN
        pkg_Error.GETERROR(onuErrorCode, osbErrorMessage);
    WHEN OTHERS THEN
        PKG_ERROR.SETERROR;
        PKG_ERROR.GETERROR(onuErrorCode, osbErrorMessage);
END api_registerrequestbyxml;
/
begin
  pkg_utilidades.prAplicarPermisos('API_REGISTERREQUESTBYXML', 'ADM_PERSON');
end;
/