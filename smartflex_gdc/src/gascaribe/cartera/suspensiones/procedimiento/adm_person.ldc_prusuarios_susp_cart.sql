create or replace procedure adm_person.ldc_prusuarios_susp_cart
/*****************************************************************
  Propiedad intelectual de PETI.

  Unidad         : LDC_PRUSUARIOS_SUSP_CART
  Descripcion    : Proceso que solo permite legalizar ordenes relacionada a usuarios
                   en el parametro LDC_USUARIOS_SUSP_CART que pueden manejar causales
                   del parametro LDC_CAUSAL_SUSP_CART.

  Autor          : Jorge Valiente
  Fecha          : 30/09/2022

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  19-04-2024	  Adrianavg		  	  OSF-2569: Se migra del esquema OPEN al esquema ADM_PERSON  
  ******************************************************************/
 IS

  nuOrderId             open.or_order.order_id%type;
  nuCausalId            open.OR_ORDER.CAUSAL_ID%type;
  sbLDCCAUSALSUSPCART   open.ld_parameter.value_chain%type := open.dald_parameter.fsbGetValue_Chain('LDC_CAUSAL_SUSP_CART',
                                                                                                    null);
  sbLDCUSUARIOSSUSPCART open.ld_parameter.value_chain%type := open.dald_parameter.fsbGetValue_Chain('LDC_USUARIOS_SUSP_CART',
                                                                                                    null);
  sbLDCMENSSUSPCART     open.ld_parameter.value_chain%type := open.dald_parameter.fsbGetValue_Chain('LDC_MENS_SUSP_CART',
                                                                                                    null);

  sbuser sa_user.mask%type := user;

BEGIN

  ut_trace.trace('Inicio LDC_PRUSUARIOS_SUSP_CART', 10);

  nuOrderId  := or_bolegalizeorder.fnuGetCurrentOrder; -- Obtenemos la orden que se esta legalizando
  nuCausalId := daor_order.fnugetcausal_id(nuOrderId); -- Obtenemos la causal con la cual se esta legalizando

  --Validar que la causal de legalizacion este definido en el parametro
  if instr(',' || sbLDCCAUSALSUSPCART || ',', ',' || nuCausalId || ',') > 0 then
    --Validar que el usuario que legaliza este definido en el parametro
    if instr(',' || sbLDCUSUARIOSSUSPCART || ',', ',' || sbuser || ',') = 0 then
      ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,
                                       sbLDCMENSSUSPCART);
      RAISE ex.controlled_error;
    end if;
  end if;

  ut_trace.trace('Fin LDC_PRUSUARIOS_SUSP_CART', 10);

EXCEPTION
  WHEN ex.controlled_error THEN
    ut_trace.trace('Error LDC_PRUSUARIOS_SUSP_CART', 10);
    RAISE;
  WHEN OTHERS THEN
    errors.seterror;
    RAISE ex.controlled_error;
END LDC_PRUSUARIOS_SUSP_CART;
/
PROMPT OTORGA PERMISOS ESQUEMA SOBRE PROCEDIMIENTO LDC_PRUSUARIOS_SUSP_CART
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_PRUSUARIOS_SUSP_CART', 'ADM_PERSON'); 
END;
/