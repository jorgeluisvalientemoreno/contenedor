CREATE OR REPLACE PACKAGE adm_person.LDC_PKTARIFATRANSITORIA IS
  /**************************************************************************
   HISTORIA DE MODIFICACIONES
  FECHA         AUTOR       DESCRIPCION
  07-11-2023	ADRIANAVG	OSF-1709: se reemplaza constants_per.tyrefcursor por constants_per.tyrefcursor
  ***************************************************************************/  
  FUNCTION GetDatosLDC_DEPRTATT(inservsusc in servsusc.sesunuse%type)
    return constants_per.tyrefcursor;

  FUNCTION GetInformacionCliente(inservsusc in servsusc.sesunuse%type)
    return constants_per.tyrefcursor;

  FUNCTION GetReceptiontype return constants_per.tyrefcursor;

  FUNCTION GetResumenConcepto(inservsusc in servsusc.sesunuse%type)
    return constants_per.tyrefcursor;

  FUNCTION GetIdentificatype return constants_per.tyrefcursor;

  FUNCTION GetValidaDocumento(Inutipodoc number, Inudoc varchar2)
    return number;

END LDC_PKTARIFATRANSITORIA;
/


CREATE OR REPLACE PACKAGE BODY adm_person.LDC_PKTARIFATRANSITORIA IS

  /**************************************************************************
   HISTORIA DE MODIFICACIONES
     FECHA        AUTOR   	DESCRIPCION
   04-01-2021    Horbath    CA559. Se ajusta para que tenga en cuenta el concepto 130
   07-03-2023	   CGONZALEZ	OSF-943: Se pasa la logica al paquete PERSONALIZACIONES.LDC_PKTARIFATRANSITORIA
   25-10-2023	   ADRIANAVG	OSF-1709: Se reemplaza PERSONALIZACIONES.LDC_PKTARIFATRANSITORIA por PERSONALIZACIONES.PKG_TARIFATRANSITORIA   
                            se retira el esquema PERSONALIZACIONES antepuesto al objeto PKG_TARIFATRANSITORIA   
   07-11-2023	   ADRIANAVG	OSF-1709: se reemplaza pkConstante.tyRefCursor por constants_per.tyrefcursor
  ***************************************************************************/
  FUNCTION GetDatosLDC_DEPRTATT(inservsusc in servsusc.sesunuse%type)
    return constants_per.tyrefcursor is

    rfcursor constants_per.tyrefcursor;

  BEGIN

    rfcursor := PKG_TARIFATRANSITORIA.GetDatosLDC_DEPRTATT(inservsusc);

    return rfcursor;

  EXCEPTION
    When ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    When others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END GetDatosLDC_DEPRTATT;

  /**************************************************************************
   HISTORIA DE MODIFICACIONES
     FECHA 		AUTOR   	DESCRIPCION
	 07-03-2023	CGONZALEZ	OSF-943: Se pasa la logica al paquete PERSONALIZACIONES.LDC_PKTARIFATRANSITORIA
     07-11-2023	ADRIANAVG	OSF-1709: se reemplaza pkConstante.tyRefCursor por constants_per.tyrefcursor     
  ***************************************************************************/
  FUNCTION GetInformacionCliente(inservsusc in servsusc.sesunuse%type)
    return constants_per.tyrefcursor is

    rfcursor constants_per.tyrefcursor;

  BEGIN

    rfcursor := PKG_TARIFATRANSITORIA.GetInformacionCliente(inservsusc);

    return rfcursor;

  EXCEPTION
    When ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    When others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END GetInformacionCliente;

  /**************************************************************************************
  Historia de Modificaciones

    Fecha       Autor       Modificacion
  =========     =========   ====================
  07-03-2023	CGONZALEZ	OSF-943: Se pasa la logica al paquete PERSONALIZACIONES.LDC_PKTARIFATRANSITORIA
  07-11-2023	ADRIANAVG	OSF-1709: se reemplaza pkConstante.tyRefCursor por constants_per.tyrefcursor  
  ***************************************************************************************/
  FUNCTION GetReceptiontype return constants_per.tyrefcursor is

    rfcursor constants_per.tyrefcursor;

  BEGIN

	rfcursor := PKG_TARIFATRANSITORIA.GetReceptiontype;

    return rfcursor;

  EXCEPTION
    When ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    When others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END GetReceptiontype;

  /**************************************************************************
   HISTORIA DE MODIFICACIONES
     FECHA        AUTOR   DESCRIPCION
  04-01-2021    Horbath           CA559. Se ajusta para que tenga en cuenta el concepto 130
  07-03-2023	CGONZALEZ	OSF-943: Se pasa la logica al paquete PERSONALIZACIONES.LDC_PKTARIFATRANSITORIA
  07-11-2023	ADRIANAVG	OSF-1709: se reemplaza pkConstante.tyRefCursor por constants_per.tyrefcursor  
  ***************************************************************************/
  FUNCTION GetResumenConcepto(inservsusc in servsusc.sesunuse%type)
    return constants_per.tyrefcursor  is

    rfcursor constants_per.tyrefcursor ;

  BEGIN

    rfcursor := PKG_TARIFATRANSITORIA.GetResumenConcepto(inservsusc);

    return rfcursor;

  EXCEPTION
    When ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    When others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END GetResumenConcepto;

  /**************************************************************************************
  Historia de Modificaciones

    Fecha       Autor       Modificacion
  =========     =========   ====================
  07-03-2023	CGONZALEZ	OSF-943: Se pasa la logica al paquete PERSONALIZACIONES.LDC_PKTARIFATRANSITORIA
  07-11-2023	ADRIANAVG	OSF-1709: se reemplaza pkConstante.tyRefCursor por constants_per.tyrefcursor  
  ***************************************************************************************/
  FUNCTION GetIdentificatype return constants_per.tyrefcursor is

    rfcursor constants_per.tyrefcursor;

  BEGIN

	rfcursor := PKG_TARIFATRANSITORIA.GetIdentificatype;

    return rfcursor;

  EXCEPTION
    When ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    When others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END GetIdentificatype;

  /**************************************************************************************
  Historia de Modificaciones

    Fecha       Autor       Modificacion
  =========     =========   ====================
  07-03-2023	CGONZALEZ	OSF-943: Se pasa la logica al paquete PERSONALIZACIONES.LDC_PKTARIFATRANSITORIA
  ***************************************************************************************/
  FUNCTION GetValidaDocumento(Inutipodoc number, Inudoc varchar2)
    return number is

    nusubscriberid ge_subscriber.subscriber_id%type := 0;

  BEGIN

    nusubscriberid := PKG_TARIFATRANSITORIA.GetValidaDocumento(Inutipodoc, Inudoc);

    return nvl(nusubscriberid, 0);

  EXCEPTION
    When others then
      return nvl(nusubscriberid, 0);
  END GetValidaDocumento;

END LDC_PKTARIFATRANSITORIA;
/
PROMPT Otorgando permisos de ejecucion a LDC_PKTARIFATRANSITORIA
BEGIN
    pkg_utilidades.praplicarpermisos('LDC_PKTARIFATRANSITORIA', 'ADM_PERSON');
END;
/