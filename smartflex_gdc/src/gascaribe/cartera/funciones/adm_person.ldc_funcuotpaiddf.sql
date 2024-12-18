CREATE OR REPLACE FUNCTION "ADM_PERSON"."LDC_FUNCUOTPAIDDF" (inuDife in diferido.difecodi%type)
  return number is

  /**************************************************************************

      Autor       : Ronald Colpas Cantillo
      Fecha       : 09-03-2019
      Nombre      : Ldc_FunCuotPaidDF
      Ticket      : 200-2403
      Descripcion : Obtiene el numero de cuotas pagadas de un diferido

      Parametros Entrada
        inuDife   codigo del diferido

      Valor de retorno
       Retorna el numero de cuotas pagadas

      HISTORIA DE MODIFICACIONES

      FECHA        AUTOR       DESCRIPCION

    ***************************************************************************/

  SBTOKENDF      VARCHAR2(20);
  NUNUMCUOTPAY   NUMBER;
  NUNUMCUOTVENC  NUMBER;
  NUVALUEPAY     DIFERIDO.DIFEVATD%TYPE;
  NUVALUEDEUDA   DIFERIDO.DIFEVATD%TYPE;
  NUNUMCUOTNOPAY NUMBER;
  NUDUEBALANCE   NUMBER;

begin

  SBTOKENDF := PKBILLCONST.CSBTOKEN_DIFERIDO;

  cc_bofinancing.getvaluesdeferr(inudifecode     => inuDife,
                                 isbtokendf      => sbtokendf,
                                 iboonlybalance  => False,
                                 onunumcuotpay   => nunumcuotpay,
                                 onunumcuotvenc  => nunumcuotvenc,
                                 onuvaluepay     => nuvaluepay,
                                 onuvaluedeuda   => nuvaluedeuda,
                                 onunumcuotnopay => nunumcuotnopay,
                                 onuduebalance   => nuduebalance);

  return(nunumcuotpay);
exception when others then
  return(0);
end Ldc_FunCuotPaidDF;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_FUNCUOTPAIDDF', 'ADM_PERSON');
END;
/
