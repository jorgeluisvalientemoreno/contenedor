CREATE OR REPLACE FUNCTION "ADM_PERSON"."LDCPRBLOPORVAL" (inuOrder or_order.order_id%type ) RETURN number is

  /**************************************************************************
      Proceso     : LDCPRBLOPORVAL
      Autor       :  Horbath
      Fecha       : 03-06-2020
      Ticket      : 146
      Descripcion : funcion para permitir la modificacion de la orden en lego,
					dependiendo la cusal de legalizacion de la orden validacion de garantia.

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/

sberror       varchar2(3000);
nuStatus      number;
nuCausal      number;
codeval      number;

nuGarInc	  or_order.causal_id%type:= dald_parameter.fnuGetNumeric_Value('CAUSAL_GARANTIA_INCORRECTA');
nuGarCor	  or_order.causal_id%type:= dald_parameter.fnuGetNumeric_Value('CAUSAL_GARANTIA_CORRECTA');
nuTtrabajo    or_order.task_type_id%type:= dald_parameter.fnuGetNumeric_Value('TITRVALIDAGARANTIA');

cursor CURVALG(ORDEN NUMBER) is
		select order_status_id, causal_id
		from or_related_order r, or_order o
		where r.RELATED_ORDER_ID = o.order_id
		and r.order_id=ORDEN
		and o.TASK_TYPE_ID=nuTtrabajo
        and  CREATED_DATE = (select max(CREATED_DATE)
                                from or_related_order r, or_order o
                                where r.RELATED_ORDER_ID = o.order_id
                                and r.order_id=ORDEN
                                and o.TASK_TYPE_ID=nuTtrabajo);

begin
	ut_trace.trace('Empieza LDCPRBLOPORVAL', 10);
	ut_trace.trace('LDCPRBLOPORVAL-inuOrder -->'||inuOrder, 10);
  if (fblAplicaEntregaxCaso('0000146')) then
      OPEN CURVALG(inuOrder);
      FETCH CURVALG INTO nuStatus,nuCausal;
      CLOSE CURVALG;
      ut_trace.trace('LDCPRBLOPORVAL-nuStatus -->'||nuStatus, 10);
      ut_trace.trace('LDCPRBLOPORVAL-nuCausal -->'||nuCausal, 10);
      if nuStatus is null and nuCausal is null then

        codeval:=0;

      else

        if nuStatus = 8 then

          if nuCausal = nuGarInc then

            codeval:=0;

          ELSIF nuCausal = nuGarCor then

            codeval:=2;

          end if;

        else

          codeval:=1;

        end if;

      end if ;
      ut_trace.trace('Termina LDCPRBLOPORVAL', 10);
        return(codeval);
   else
        return 0;
   end if ;
exception
     when others then
          return(0); --codeval:=0;
end LDCPRBLOPORVAL;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDCPRBLOPORVAL', 'ADM_PERSON');
END;
/
