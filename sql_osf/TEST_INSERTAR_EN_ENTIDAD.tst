PL/SQL Developer Test script 3.0
27
-- Created on 12/12/2024 by JORGE VALIENTE 
declare
  -- Local variables here
  --rcCC_SALES_FINANC_COND CC_SALES_FINANC_COND%ROWTYPE;
  rcCC_SALES_FINANC_COND pkg_CC_SALES_FINANC_COND.tytbRegistros;
begin
  -- Test statements here
  rcCC_SALES_FINANC_COND(0).Package_Id          := 97171240; -- Código Solicitud
  rcCC_SALES_FINANC_COND(0).financing_plan_id   := 120; -- Código Plan de Financiación definido en la venta a constructora
  rcCC_SALES_FINANC_COND(0).compute_method_id   := pkg_plandife.fnuobtpldimccd(rcCC_SALES_FINANC_COND(0).financing_plan_id); -- método de calculo Plan de financiación
  rcCC_SALES_FINANC_COND(0).interest_rate_id    := pkg_plandife.fnuobtPLDITAIN(rcCC_SALES_FINANC_COND(0).financing_plan_id); -- código de la tasa de interés Plan de financiación
  rcCC_SALES_FINANC_COND(0).first_pay_date      := sysdate; -- fecha de cobro de la primera cuota (Sysdate)
  rcCC_SALES_FINANC_COND(0).percent_to_finance  := 100; -- porcentaje a financiar (100)
  rcCC_SALES_FINANC_COND(0).interest_percent    := nvl(pkg_plandife.fnuobtPLDIPOIN(rcCC_SALES_FINANC_COND(0).financing_plan_id),0); -- porcentaje de interés Plan de financiación obtenida del servicio fnuGetInterestRate
  rcCC_SALES_FINANC_COND(0).spread              := 0; -- puntos adicionales (0)
  rcCC_SALES_FINANC_COND(0).quotas_number       := 12; -- numero de cuotas definido en la venta a constructora
  rcCC_SALES_FINANC_COND(0).tax_financing_one   := 'N'; -- financiar IVA a una cuota (N)
  rcCC_SALES_FINANC_COND(0).value_to_finance    := 0; -- valor a financiar (0)
  rcCC_SALES_FINANC_COND(0).document_support    := 'PP-97171240'; -- documento de soporte (PP-Código Solicitud)
  rcCC_SALES_FINANC_COND(0).initial_payment     := 0; -- valor a pagar (0)
  rcCC_SALES_FINANC_COND(0).average_quote_value := 0; -- valor promedio de la cuota (0)

  pkg_CC_SALES_FINANC_COND.prinsRegistro(rcCC_SALES_FINANC_COND(0));

  --select * from CC_SALES_FINANC_COND 

end;
0
0
