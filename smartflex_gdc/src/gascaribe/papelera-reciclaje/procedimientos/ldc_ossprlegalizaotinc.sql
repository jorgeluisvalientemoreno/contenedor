CREATE OR REPLACE procedure LDC_OSSPRLEGALIZAOTINC
AS

  /*****************************************************************
  Propiedad intelectual de PETI.

  Unidad         : LDC_OSSPRLEGALIZAOTINC
  Descripcion    : Proceso que busca ordenes bloqueadas con causales (9585,9580), las legaliza
                        como incumplidas con causal 3005 (Proceso automatico del sistema)
                        y envia correo al funcionario de servicios adicionales

  Autor          :  Jhon Jairo Soto
  Fecha          : 18/02/2013

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================

  ******************************************************************/

inuOrderId           open.or_order.order_id%type;
inuCausalId          open.or_order.causal_id%type;
inuPersonId          open.ge_person.person_id%type;
idtExeInitialDate    date;
idtExeFinalDate     date;
isbComment         open.or_order_comment.order_comment%type;
idtChangeDate       date;
onuErrorCode        number;
osbErrorMessage   varchar2(2000);
nucontador number;
sbMessage varchar2(8000);
sbIssue varchar2(2000);

cursor cuLegalizaOrdenes is
SELECT c.order_id --c.* --datos  de la OT que voy a incumplir
FROM OR_order_activity  a, OR_order_activity b, or_order c, or_order d
WHERE a.origin_activity_id= b.order_activity_id
and a.order_id = c.order_id
and b.order_id = d.order_id
--and a.order_id = 44
and c.order_status_id = 11--estado bloqueado
and D.CAUSAL_ID in (9585,9580)
and sysdate-d.legalization_date > 5;


begin

        inuCausalId := 3005; -- causal por proceso automatico del sistema
        inuPersonId := -1;
        idtExeInitialDate := sysdate;
        idtExeFinalDate := sysdate;
        idtChangeDate := sysdate;
        isbComment := 'ORDEN LEGALIZADA POR PROCESO AUTOMATICO, CUMPLE TIEMPO MAXIMO PARA ESTAR BLOQUEADA SIN GESTION';
        nucontador := 0;


    for RCordenes in cuLegalizaOrdenes loop
        inuOrderId := RCordenes.order_id;
        OS_LEGALIZEORDERALLACTIVITIES(inuOrderId, inuCausalId, inuPersonId, idtExeInitialDate ,idtExeFinalDate, isbComment,idtChangeDate, onuErrorCode, osbErrorMessage);

        if onuErrorCode = 0 then
            nucontador := nucontador +1;
            if nucontador = 1 then
                sbMessage := inuOrderId;
            else
                sbMessage := sbMessage || ';' ||inuOrderId;
            end if;
        end if;

    end loop;

  if nucontador > 0 then
        sbIssue := 'Legalizacion de ordenes incumplidas ' ||'Cantidad: ' ||nucontador||'- fecha: '||
                           sysdate || '-' || ' con causales 9580 y 9585 luego de N dias';

        LDC_SENDEMAIL(dald_parameter.fsbGetValue_Chain('PAR_EMAIL_SERV_ADIC'),
                                sbIssue,
                                sbMessage);
  end if;

EXCEPTION
  WHEN ex.CONTROLLED_ERROR THEN
    raise;
   when others then
    ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                     'Error al ejecutar proceso LDC_OSSPRLEGALIZAOTINC con OT '||inuOrderId);
    raise;
end;
/
