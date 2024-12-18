CREATE OR REPLACE PACKAGE adm_person.LDC_BOGESTIONTARIFAS IS
    /***************************************************************
    Propiedad intelectual de Sincecomp Ltda.
    
    Unidad	     : 
    Descripcion	 : 
    
    Parametro	    Descripcion
    ============	==============================
    
    Historia de Modificaciones
    Fecha   	           Autor            Modificacion
    ====================   =========        ====================
    25/06/2024              PAcosta         OSF-2878: Cambio de esquema ADM_PERSON                              
    ****************************************************************/ 
    
   PROCEDURE prCreaProyectoTarifa( isbDescTari   IN  ta_proytari.PRTADESC%type,
                                   inuTipoServ   IN  ta_proytari.PRTASERV%type,
                                   inuEstado     IN  ta_proytari.PRTAESTA%type,
                                   isbObservacion IN ta_proytari.PRTAOBSE%type,
                                   isbDocumento   IN ta_proytari.PRTADOCU%type,
                                   idtFecha      IN  DATE,
                                   onuProyTarifa OUT NUMBER,
                                   onuError      OUT NUMBER,
                                   osberror  OUT VARCHAR2);
  /**************************************************************************
    Autor       : olsoftware
    Fecha       : 19/04/2021
    Ticket      : 583
    Proceso     : prCreaProyectoTarifa
    Descripci��n: crear proyecto de tarifa

    Par��metros Entrada
     isbDescTari  Descripciond el proyecto
     inuTipoServ  tipo de producto
     inuEstado    estado
     isbObservacion  observacion
     isbDocumento  documento
     idtFecha  fecha
    Valor de salida
     onuerror   codigo de erorr 0 - correcto, otro valor incorrecto
     osberror   mensaje de error
     onuProyTarifa  codigo del proyecto de tarifa
    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/

   PROCEDURE prActualizaProyectoTari( inuProyTarifa IN NUMBER,
                                     isbDescTari   IN  ta_proytari.PRTADESC%type,
                                     inuTipoServ   IN  ta_proytari.PRTASERV%type,
                                     inuEstado     IN  ta_proytari.PRTAESTA%type,
                                     isbObservacion IN ta_proytari.PRTAOBSE%type,
                                     isbDocumento   IN ta_proytari.PRTADOCU%type,
                                     onuError      OUT NUMBER,
                                     osberror  OUT VARCHAR2);
   /**************************************************************************
    Autor       : olsoftware
    Fecha       : 19/04/2021
    Ticket      : 583
    Proceso     : prActualizaProyectoTari
    Descripci��n: actualiza proyecto de tarifa

    Par��metros Entrada
     isbDescTari  Descripciond el proyecto
     inuTipoServ  tipo de producto
     inuEstado    estado
     isbObservacion  observacion
     isbDocumento  documento
     inuProyTarifa  codigo del proyecto de tarifa

    Valor de salida
     onuerror   codigo de erorr 0 - correcto, otro valor incorrecto
     osberror   mensaje de error

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/

  PROCEDURE prActivaTarifa( inuproyTari  IN NUMBER,
                                onuError     OUT  NUMBER,
                                osbError     OUT VARCHAR2);
  /**************************************************************************
    Autor       : olsoftware
    Fecha       : 19/04/2021
    Ticket      : 583
    Proceso     : prActivaTarifa
    Descripci��n: activar tarifas

    Par��metros Entrada
     inuproyTari  codigo del proyecto de tarifa

    Valor de salida
     onuerror   codigo de erorr 0 - correcto, otro valor incorrecto
     osberror   mensaje de error

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/

  PROCEDURE prGestionTarifaProyecto ( inuproyTari  IN NUMBER,
                                     idtfechaIni  IN DATE,
                                     idtFechaFin  IN DATE,
                                     onuError     OUT  NUMBER,
                                     osbError     OUT VARCHAR2);
  /**************************************************************************
    Autor       : olsoftware
    Fecha       : 19/04/2021
    Ticket      : 583
    Proceso     : prGestionTarifaProyecto
    Descripci��n: gestiona tarifas de trabajo

    Par��metros Entrada
     inuproyTari  codigo del proyecto de tarifa
     idtfechaIni  fecha inicial
     idtFechaFin  fecha final

    Valor de salida
     onuerror   codigo de erorr 0 - correcto, otro valor incorrecto
     osberror   mensaje de error

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/
END LDC_BOGESTIONTARIFAS;
/
CREATE OR REPLACE PACKAGE BODY adm_person.LDC_BOGESTIONTARIFAS IS
  PROCEDURE prCreaProyectoTarifa( isbDescTari   IN  ta_proytari.PRTADESC%type,
                                   inuTipoServ   IN  ta_proytari.PRTASERV%type,
                                   inuEstado     IN  ta_proytari.PRTAESTA%type,
                                   isbObservacion IN ta_proytari.PRTAOBSE%type,
                                   isbDocumento   IN ta_proytari.PRTADOCU%type,
                                   idtFecha      IN  DATE,
                                   onuProyTarifa OUT NUMBER,
                                   onuError      OUT NUMBER,
                                   osberror  OUT VARCHAR2) IS
  /**************************************************************************
    Autor       : olsoftware
    Fecha       : 19/04/2021
    Ticket      : 583
    Proceso     : prCreaProyectoTarifa
    Descripci��n: crear proyecto de tarifa

    Par��metros Entrada
     isbDescTari  Descripciond el proyecto
     inuTipoServ  tipo de producto
     inuEstado    estado
     isbObservacion  observacion
     isbDocumento  documento
     idtFecha  fecha
    Valor de salida
     onuerror   codigo de erorr 0 - correcto, otro valor incorrecto
     osberror   mensaje de error
     onuProyTarifa  codigo del proyecto de tarifa
    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/
  BEGIN
    UT_TRACE.TRACE('INICIO LDC_BOGESTIONTARIFAS.prCreaProyectoTarifa ', 10);
    LDC_BCGESTIONTARIFAS.prInicializaError(onuerror, osberror);
    LDC_BCGESTIONTARIFAS.prInsertaProyecto( isbDescTari ,
                                           inuTipoServ,
                                           inuEstado,
                                           isbObservacion ,
                                           isbDocumento,
                                           idtFecha ,
                                           onuProyTarifa,
                                           onuError,
                                           osberror);

    UT_TRACE.TRACE('FIN LDC_BOGESTIONTARIFAS.prCreaProyectoTarifa ', 10);
  EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
       ERRORS.GETERROR(onuerror, osberror);
    WHEN OTHERS THEN
      ERRORS.SETERROR;
      ERRORS.GETERROR(onuerror, osberror);
  END prCreaProyectoTarifa;

   PROCEDURE prActualizaProyectoTari( inuProyTarifa IN NUMBER,
                                     isbDescTari   IN  ta_proytari.PRTADESC%type,
                                     inuTipoServ   IN  ta_proytari.PRTASERV%type,
                                     inuEstado     IN  ta_proytari.PRTAESTA%type,
                                     isbObservacion IN ta_proytari.PRTAOBSE%type,
                                     isbDocumento   IN ta_proytari.PRTADOCU%type,
                                     onuError      OUT NUMBER,
                                     osberror  OUT VARCHAR2) IS
   /**************************************************************************
    Autor       : olsoftware
    Fecha       : 19/04/2021
    Ticket      : 583
    Proceso     : prActualizaProyectoTari
    Descripci��n: actualiza proyecto de tarifa

    Par��metros Entrada
     isbDescTari  Descripciond el proyecto
     inuTipoServ  tipo de producto
     inuEstado    estado
     isbObservacion  observacion
     isbDocumento  documento
     inuProyTarifa  codigo del proyecto de tarifa

    Valor de salida
     onuerror   codigo de erorr 0 - correcto, otro valor incorrecto
     osberror   mensaje de error

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/
  BEGIN
    UT_TRACE.TRACE('INICIO LDC_BOGESTIONTARIFAS.prActualizaProyectoTari ', 10);
    LDC_BCGESTIONTARIFAS.prInicializaError(onuerror, osberror);
    LDC_BCGESTIONTARIFAS.prActualizaProyecto( inuProyTarifa,
                                             isbDescTari,
                                             inuTipoServ,
                                             inuEstado,
                                             isbObservacion,
                                             isbDocumento,
                                             onuError,
                                             osberror);
    UT_TRACE.TRACE('FIN LDC_BOGESTIONTARIFAS.prActualizaProyectoTari ', 10);
  EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
       ERRORS.GETERROR(onuerror, osberror);
    WHEN OTHERS THEN
      ERRORS.SETERROR;
      ERRORS.GETERROR(onuerror, osberror);
  END prActualizaProyectoTari;
  PROCEDURE prActivaTarifa( inuproyTari  IN NUMBER,
                            onuError     OUT  NUMBER,
                            osbError     OUT VARCHAR2) IS
  /**************************************************************************
    Autor       : olsoftware
    Fecha       : 19/04/2021
    Ticket      : 583
    Proceso     : prActivaTarifa
    Descripci��n: activar tarifas

    Par��metros Entrada
     inuproyTari  codigo del proyecto de tarifa

    Valor de salida
     onuerror   codigo de erorr 0 - correcto, otro valor incorrecto
     osberror   mensaje de error

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/
  BEGIN
    UT_TRACE.TRACE('INICIO LDC_BOGESTIONTARIFAS.prActivaTarifa ', 10);
    LDC_BCGESTIONTARIFAS.prInicializaError(onuerror, osberror);
    LDC_BCGESTIONTARIFAS.prInsertarTariActi( inuproyTari,
                                              onuError,
                                              osbError);

    UT_TRACE.TRACE('FIN LDC_BOGESTIONTARIFAS.prActivaTarifa ', 10);
  EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
       ERRORS.GETERROR(onuerror, osberror);
    WHEN OTHERS THEN
      ERRORS.SETERROR;
      ERRORS.GETERROR(onuerror, osberror);
  END prActivaTarifa;
  PROCEDURE prGestionTarifaProyecto ( inuproyTari  IN NUMBER,
                                     idtfechaIni  IN DATE,
                                     idtFechaFin  IN DATE,
                                     onuError     OUT  NUMBER,
                                     osbError     OUT VARCHAR2) IS
  /**************************************************************************
    Autor       : olsoftware
    Fecha       : 19/04/2021
    Ticket      : 583
    Proceso     : prGestionTarifaProyecto
    Descripci��n: gestiona tarifas de trabajo

    Par��metros Entrada
     inuproyTari  codigo del proyecto de tarifa
     idtfechaIni  fecha inicial
     idtFechaFin  fecha final

    Valor de salida
     onuerror   codigo de erorr 0 - correcto, otro valor incorrecto
     osberror   mensaje de error

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/
   BEGIN
    UT_TRACE.TRACE('INICIO LDC_BOGESTIONTARIFAS.prGestionTarifaProyecto ', 10);
    LDC_BCGESTIONTARIFAS.prInicializaError(onuerror, osberror);
    LDC_BCGESTIONTARIFAS.prInsertarTarifas( inuproyTarI,
                                            idtfechaIni,
                                            idtFechaFin,
                                            onuError,
                                            osbError);
    UT_TRACE.TRACE('FIN LDC_BOGESTIONTARIFAS.prGestionTarifaProyecto ', 10);
  EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
       ERRORS.GETERROR(onuerror, osberror);
    WHEN OTHERS THEN
      ERRORS.SETERROR;
      ERRORS.GETERROR(onuerror, osberror);
  END prGestionTarifaProyecto;

END LDC_BOGESTIONTARIFAS;
/
PROMPT Otorgando permisos de ejecucion a LDC_BOGESTIONTARIFAS
BEGIN
    pkg_utilidades.praplicarpermisos('LDC_BOGESTIONTARIFAS', 'ADM_PERSON');
END;
/
