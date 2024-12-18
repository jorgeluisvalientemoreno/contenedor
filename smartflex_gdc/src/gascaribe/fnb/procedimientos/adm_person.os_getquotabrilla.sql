CREATE OR REPLACE PROCEDURE adm_person.OS_GetQuotaBrilla(inuSubscription       Number,
                                              onuBrillaQuota        out Number,
                                              onuQuoteUsed          out Number,
                                              onuQuoteAvailable     out Number,
                                              onuInstallOutstanding out Number,
                                              onuErrorCode          out ge_message.message_id %type,
                                              osbErrorMessage       out ge_message.description%type) IS
  /*****************************************************************
    Unidad      : OS_GetQuotaBrilla
    Descripcion : Retorna informaci�n de cupo brilla
    Autor   : Eduar Ramos Barrag�n
    Fecha   : 05-09-2011

    Parametros            Descripcion
    ============          ===================


    Historia de Modificaciones
    Fecha         Autor                Modificacion
    =========     =========            ====================
    14/05/2024    Paola Acosta         OSF-2674: Cambio de esquema ADM_PERSON    
    23-Oct-2013   LDiuza.SAO221111     Se realiza validacion para cuando el cupo disponible
                                       sea negativo, le asigne valor de cero.
    22-Mayo-2013  Evelio Sanjuanelo    Se inicializa la variable onuErrorCode en 0
                                       por si no ocurre ningun error dentro del API
                                       devuelva este valor
  ********************/
BEGIN
  --se inicializa el codigo de error en cero ya que los API devuelven este codigo y se valida
  --que cuando el codigo de error es diferente de 0 quiere decir que el API tuvo un error dentro
  --del proceso. Cuando el API devuelve 0 quiere decir que proceso fue exitoso.
  --Si no se inicializa en 0, este se va con el valor NULL y se toma como ERROR, EVESAN
  onuErrorCode:= 0;
  osbErrorMessage := 'OK';
  ld_bononbankfinancing.AllocateTotalQuota(inuSubscription, onuBrillaQuota);
  onuQuoteUsed          := ld_bononbankfinancing.fnuGetUsedQuote(inuSubscription);

  IF(onuBrillaQuota >= onuQuoteUsed) THEN
    onuQuoteAvailable     := onuBrillaQuota - onuQuoteUsed;
  ELSE
    onuQuoteAvailable     := 0;
  END IF;

  onuInstallOutstanding := LD_BONonBankFiRules.fnuAcquittedFinan(inuSubscription);

EXCEPTION
  WHEN ex.CONTROLLED_ERROR THEN
    errors.GetError(onuErrorCode, osbErrorMessage);
  WHEN others THEN
    Errors.setError;
    errors.GetError(onuErrorCode, osbErrorMessage);
END OS_GetQuotaBrilla;
/
PROMPT Otorgando permisos de ejecucion a OS_GETQUOTABRILLA
BEGIN
    pkg_utilidades.praplicarpermisos('OS_GETQUOTABRILLA', 'ADM_PERSON');
END;
/

PROMPT Otorgando permisos de ejecucion sobre OS_GETQUOTABRILLA para reportes
GRANT EXECUTE ON adm_person.OS_GETQUOTABRILLA TO rexereportes;
/