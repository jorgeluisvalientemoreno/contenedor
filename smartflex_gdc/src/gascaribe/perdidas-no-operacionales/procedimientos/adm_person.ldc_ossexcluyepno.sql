CREATE OR REPLACE procedure      ADM_PERSON.LDC_OSSEXCLUYEPNO
  /*****************************************************************
  Propiedad intelectual de PETI.

  Unidad         : LDC_OSSEXCLUYEPNO
  Descripcion    : Proceso que se configura en los tipos de trabajo de analisis de consumo
                   con el cual se evalua la causal de legalizacion, si se encuentra dentro del
                   parametro se debe cambiar el estado del registro de la tabla FM_POSSIBLE_NTL
                   status 'E'.

  Autor          :  Jhon Jairo Soto
  Fecha          : 29/08/2013

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
   02/05/2024      PACOSTA            OSF-2638: Se crea el objeto en el esquema adm_person  
   14/11/2013      JSOTO              Se adecua para que el proceso de excluir PNO segun la causal
                                      tambien tenga en cuenta cuando la orden principal ha sido revocada
                                      NC-1467
  ******************************************************************/
IS

nuOrderId          or_order.order_id%type;
nuOrderId1         or_order.order_id%type;
nuCausalId         OR_ORDER.CAUSAL_ID%type;
sbCausaExcluye     varchar2(2);
nuPossibleNTL      FM_POSSIBLE_NTL.POSSIBLE_NTL_ID%TYPE;
nuNumintentos      number;
nuOTBloqueada      number;
nuClaseCausal      number;
nuOrderActivityId  OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID%TYPE;
nuOrderActivityId2  OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID%TYPE;
nuOriginActivityId  OR_ORDER_ACTIVITY.ORIGIN_ACTIVITY_ID%TYPE;


BEGIN

    ut_trace.trace('Inicio LDC_OSSEXCLUYEPNO', 10);

    nuOrderId := or_bolegalizeorder.fnuGetCurrentOrder; -- Obtenemos la orden que se esta legalizando
    nuOrderId1 := nuOrderId;  -- Conservar el valor inicial para luego obtener la causal de legalizacion

    nuNumIntentos := ldc_boutilities.fsbgetvalorcampotabla('OR_ORDER_ACTIVITY',
                                                               'ORDER_ID',
                                                               'LEGALIZE_TRY_TIMES',
                                                                nuOrderId1); -- Obtenemos el numero de ordenes regeneradas
    nuOTBloqueada := nuNumIntentos;

    nuOrderActivityId := ldc_boutilities.fsbgetvalorcampotabla('OR_ORDER_ACTIVITY',
                                                               'ORDER_ID',
                                                               'ORDER_ACTIVITY_ID',
                                                                nuOrderId); --Buscamos el ID de la Actividad de la orden


    nuOriginActivityId := daor_order_activity.fnugetorigin_activity_id(nuOrderActivityId,null);

   if nuNumIntentos <> 0 and nuOriginActivityId is null then

         loop

            nuOrderActivityId := ldc_boutilities.fsbgetvalorcampotabla('OR_ORDER_ACTIVITY',
                                                               'ORDER_ACTIVITY_ID',
                                                               'ORIGIN_ACTIVITY_ID',
                                                                nuOrderActivityId); -- Ciclo para buscar el ID de la actividad de la OT original inicial

             ut_trace.trace('LDC_OSSEXCLUYEPNO-nuOrderActivityId -->'||nuOrderActivityId, 10);
             ut_trace.trace('LDC_OSSEXCLUYEPNO-nuNumIntentos -->'||nuNumIntentos, 10);

        nuNumIntentos := nuNumIntentos -1;
        exit when nuNumIntentos = 0;
        end loop;

        nuOrderId := ldc_boutilities.fsbgetvalorcampotabla('OR_ORDER_ACTIVITY',
                                                               'ORDER_ACTIVITY_ID',
                                                               'ORDER_ID',
                                                                nuOrderActivityId); --Buscamos la Orden original que dio origen al registro de PNO

        ut_trace.trace('LDC_OSSEXCLUYEPNO-nuOrderId -->'||nuOrderId, 10);

   elsif nuOriginActivityId > 0 then
   -- Inicio NC-1467
        loop

            nuOrderActivityId := ldc_boutilities.fsbgetvalorcampotabla('OR_ORDER_ACTIVITY',
                                                               'ORDER_ACTIVITY_ID',
                                                               'ORIGIN_ACTIVITY_ID',
                                                                nuOrderActivityId); -- Ciclo para buscar el ID de la actividad de la OT original inicial

            if nuOrderActivityId <> '-1' then

               nuOrderActivityId2 := nuOrderActivityId;

            end if;

             ut_trace.trace('LDC_OSSEXCLUYEPNO-nuOrderActivityId -->'||nuOrderActivityId2, 10);

          exit when nuOrderActivityId = '-1';
        end loop;

        nuOrderId := ldc_boutilities.fsbgetvalorcampotabla('OR_ORDER_ACTIVITY',
                                                               'ORDER_ACTIVITY_ID',
                                                               'ORDER_ID',
                                                                nuOrderActivityId2); --Buscamos la Orden original que dio origen al registro de PNO

        ut_trace.trace('LDC_OSSEXCLUYEPNO-nuOrderId -->'||nuOrderId, 10);
   --FIN NC-1467
   end if;


    nuPossibleNTL := ldc_boutilities.fsbgetvalorcampotabla('FM_POSSIBLE_NTL',
                                                           'ORDER_ID',
                                                           'POSSIBLE_NTL_ID',
                                                            nuOrderId);  -- Obtenemos el codigo de PNO asociado a la orden

  if nuPossibleNTL <> '-1'  then

    nuCausalId := daor_order.fnugetcausal_id(nuOrderId1);  -- Obtenemos la causal con la cual se esta legalizando

    nuClaseCausal :=  dage_causal.fnugetclass_causal_id(nuCausalId);

    ut_trace.trace('LDC_OSSEXCLUYEPNO-nuCausalId -->'||nuCausalId, 10);

    sbCausaExcluye := ldc_boutilities.fsbBuscaToken(dald_parameter.fsbgetvalue_chain('COD_CAUSA_EXCLUYE_PNO'),nuCausalId,','); -- Si la causal esta en el parametro
    ut_trace.trace('LDC_OSSEXCLUYEPNO-sbCausaExcluye -->'||sbCausaExcluye, 10);


    if(sbCausaExcluye = 'N') or (nuClaseCausal = 2 and nuOTBloqueada = 2 )then  -- Si la causal no esta dentro del parametro, actualizamos el estado de PNO a excluido

        DAFM_POSSIBLE_NTL.UPDSTATUS(nuPossibleNTL,'E');
        ut_trace.trace('LDC_OSSEXCLUYEPNO- Excluye nuPossibleNTL-->'||nuPossibleNTL, 10);

    end if;
  end if;

  ut_trace.trace('Fin LDC_OSSEXCLUYEPNO', 10);

EXCEPTION
  WHEN ex.CONTROLLED_ERROR THEN
    raise;
   when others then
    ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                     'Error al ejecutar proceso LDC_OSSEXCLUYEPNO con OT '||nuOrderId);
    raise;
END LDC_OSSEXCLUYEPNO;
/
PROMPT Otorgando permisos de ejecucion a LDC_OSSEXCLUYEPNO
BEGIN
    pkg_utilidades.praplicarpermisos('LDC_OSSEXCLUYEPNO', 'ADM_PERSON');
END;
/
PROMPT Otorgando permisos de ejecucion sobre LDC_OSSEXCLUYEPNO para reportes
GRANT EXECUTE ON adm_person.LDC_OSSEXCLUYEPNO TO rexereportes;
/
