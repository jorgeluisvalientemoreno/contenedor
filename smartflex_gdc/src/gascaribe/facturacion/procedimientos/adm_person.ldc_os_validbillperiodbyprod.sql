CREATE OR REPLACE PROCEDURE  ADM_PERSON.LDC_OS_ValidBillPeriodByProd
(
    inuProductId        in       servsusc.sesunuse%type,
    onuErrorCode        out      number,
    osbErrorMessage     out      varchar2
)
IS
  /**************************************************************************
  Propiedad Intelectual de PETI

  Funcion     :  LDC_OS_ValidBillPeriodByProd
  Descripcion :  

  Autor       : 
  Fecha       : 

  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================
  09/05/2024          Paola Acosta       OSF-2672: Cambio de esquema ADM_PERSON                                         
  **************************************************************************/
  
    /* Identificador del ciclo de facturación asociado a la suscripción */
    nuBillCycleId           ciclo.ciclcodi%type;

    /* Identificador del período de facturación actual para el ciclo */
    nuCurrBillPeriodId      perifact.pefacodi%type;

    /* Registro para almacenar la información del período de facturación
       actual para el ciclo de la suscripción */
    rcBillPeriod            perifact%rowtype;

    /* Número mínimo de dias antes de fin de periodo de facturación para
       aplicar financiación */
    nuMinDaysBeforeEndPer   number;

    /* Fecha límite de atención para aplicar financiaciones */
    dtAttLimitDate          date;

    /* Fecha actual del sistema */
    dtSystemDate            date;

BEGIN
--{
    UT_Trace.Trace( 'Inicio: [LDC_OS_ValidBillPeriodByProd]', 8);

    /* Se obtiene el número mínimo de dias antes de fin de periodo de facturación
       para aplicar financiación */

    nuMinDaysBeforeEndPer := GE_BOParameter.fnuGet
    (
        'FI_COM_FIN_MIN_DAYS',
        GE_BOConstants.csbYES
    );


    /* Se obtiene el ciclo de facturación asociado al producto*/
    nuBillCycleId := pktblservsusc.fnugetsesucicl(inuProductId);

    /* Se obtiene el período de facturación actual para el ciclo */
    pkBillingPeriodMgr.AccCurrentPeriod
    (
        nuBillCycleId,
        nuCurrBillPeriodId
    );

    UT_Trace.Trace( 'Ciclo: '||nuBillCycleId, 9 );
    UT_Trace.Trace( 'Periodo de Facturación: '||nuCurrBillPeriodId, 9 );

    /* Se calcula la fecha límite de atención para aplicar financiaciones */
    dtAttLimitDate := trunc( pktblperifact.fdtgetenddate(nuCurrBillPeriodId,0) ) - nuMinDaysBeforeEndPer;

    /* Se obtiene la fecha de registro de la solicitud */
    dtSystemDate := trunc( UT_Date.fdtSysdate );

    UT_Trace.Trace( 'Fecha Limite: '||dtAttLimitDate, 9 );
    UT_Trace.Trace( 'Fecha Registro: '||dtSystemDate, 9 );

    /* Se asignan valores por defecto */

    onuErrorCode    := 0;
    osbErrorMessage := '-';

    /* Se valida si la fecha de vencimiento de la solicitud es menor o igual a la
       fecha actual del sistema */

    if ( dtSystemDate >= dtAttLimitDate ) then

        onuErrorCode    := 1;
        osbErrorMessage := 'La fecha de vencimiento de la solicitud es menor o igual a la fecha final de facturación '||
                           ' del periodo asociado al producto ['||inuProductId||']. '||
                           ' No se permite registrar la Financiación.';
        return;
    end if;

    /* Se valida si el producto tiene cargos generados sin facturar */

    if ldc_bosuspensions.fblValProductBilling(inuProductId) then
       onuErrorCode    := 2;
       osbErrorMessage := 'El producto ['||inuProductId||'] tiene cargos generados sin facturar.';
       return;
    END if;

    UT_Trace.Trace( 'Fin: [LDC_OS_ValidBillPeriodByProd]', 8 );

EXCEPTION
    when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 or ex.CONTROLLED_ERROR then
        raise;
    when OTHERS then
        Errors.SetError;
        raise ex.CONTROLLED_ERROR;
END LDC_OS_ValidBillPeriodByProd;
/
PROMPT Otorgando permisos de ejecucion a LDC_OS_VALIDBILLPERIODBYPROD
BEGIN
    pkg_utilidades.praplicarpermisos('LDC_OS_VALIDBILLPERIODBYPROD', 'ADM_PERSON');
END;
/

PROMPT Otorgando permisos de ejecucion sobre LDC_OS_VALIDBILLPERIODBYPROD para reportes
GRANT EXECUTE ON adm_person.LDC_OS_VALIDBILLPERIODBYPROD TO rexereportes;
/