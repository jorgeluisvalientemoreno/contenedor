CREATE OR REPLACE PROCEDURE ADM_PERSON.LDC_PRLEGORDENSACRP  IS

    /**************************************************************************
        Autor       : Ernesto Santiago / Horbath
        Fecha       : 2019-08-22
        Ticket      : 44
        Descripcion : Plugin que  permite legalizacion de ordenes de trabajo similares asignados a la misma unidad de trabajo

        Valor de salida

        HISTORIA DE MODIFICACIONES
        FECHA        AUTOR       DESCRIPCION
        12/05/2021   HORBATH     CASO 602: Obtener el comentario legalizado de la orden instanciada y legalizada
                                           Modificar el cursor CUVALOR cambiando la l�gica de la sentencia y agregando el
                                           estado de la orden y obtener las ordenes en eatso 0 y 5
        09/07/2021   DSALTARIN   CASO 825: Se corrige forma de obtener cometnario de legalizaci�n, para que en caso que no encuentre no arroje error.
										   Se corrige forma de obtener orden a legalizar ya que se busca en estado 0 o 5 pero siempre con unidad,
										   las ot en estado 0 no tiene cero
                       se corrige para que no legalice en este proceso ya que esta generando bloqueo
   ***************************************************************************/

    nuOrden                 or_order.order_id%type;
    nuOrle                 or_order.order_id%type;
    nuOrder_id              or_order.order_id%type;

   -- nucontrato             or_order_activity.PRODUCT_ID%type;

    nucontrato              or_order_activity.SUBSCRIPTION_ID%type;
    osbErrorMessage         GE_ERROR_LOG.DESCRIPTION%TYPE;
    onuErrorCode          ge_error_log.error_log_id%type;
    nuUnitop              or_operating_unit.OPERATING_UNIT_ID%type;
    NUTIPTR               or_order.task_type_id%TYPE := dald_parameter.fnugetnumeric_value('LDC_TTRALEGSACRP',null);
    sbComment            or_order_comment.ORDER_COMMENT%TYPE;
    nuPersonId number;
    nuactivity number;
    nuCausalId number;
    nuTipoComentario number;
    sbComentario varchar(200);
    message    VARCHAR2(500);

    --- en este cursor se obtiene el tipo de trabajo, la actividad y el estado de la orden que se esta legalizando
    cursor CUORDATO is
    select oa.SUBSCRIPTION_ID, o.OPERATING_UNIT_ID
    from or_order_activity  oa, or_order o
    WHERE oa.order_id=NUORDEN
	 and oa.order_id = o.order_id;

    CURSOR cuPerson IS
    SELECT person_id
    FROM or_order_person
    WHERE order_id = NUORDEN;


    cursor CUVALOR(  inucontrato NUMBER, UNIT NUMBER ) is
    select o.order_id ,o.EXEC_INITIAL_DATE, o.EXECUTION_FINAL_DATE,  o.order_status_id
    from or_order_activity a, or_order o, mo_packages m
    where a.order_id = o.order_id
	  and m.package_id = a.package_id
	  and m.package_type_id = 100306
     -- and o.task_type_id= NUTIPTR --12161--
      --and o.ORDER_STATUS_ID = 5 --CASO 602
      and o.ORDER_STATUS_ID in (5,0)
      and a.SUBSCRIPTION_ID= inucontrato --847711--
      AND ((o.OPERATING_UNIT_ID= UNIT and o.order_status_id=5) or (o.order_status_id=0)) --1891--
      ;  --30221959

BEGIN

    -- con estas funciones se obtienen los datos de la orden que se intentan legalizar --
    ut_trace.trace('Inicio PLUGIN LDC_PRLEGORDENSACRP',10);
    nuOrden := or_bolegalizeorder.fnuGetCurrentOrder; -- se obtiene el id de la orden que se intenta legalizar
    nuCausalId :=  open.dald_parameter.fnuGetNumeric_Value('LDC_CAULEGSACRP');

    OPEN cuPerson;
    FETCH cuPerson INTO nuPersonId;
    IF cuPerson%NOTFOUND THEN
      nuPersonId := GE_BOPersonal.fnuGetPersonId;
    END IF;
    CLOSE cuPerson;

    OPEN CUORDATO;
    FETCH CUORDATO INTO nucontrato,  nuUnitop ;
    CLOSE CUORDATO;

  --CASO 602 se cambiara rownum=1 por legalize_comment = 'Y'
  --825
    begin
	select ORDER_COMMENT into sbComment
	from or_order_comment where order_id = nuOrden and legalize_comment = 'Y';
	EXCEPTION
	 when others then
	   sbComment :='Orden legalizada por proceso LDC_PRLEGORDENSACRP';
	end;
  --825
  --and rownum=1;


    FOR reg IN CUVALOR(nucontrato,nuUnitop) LOOP
      if fblaplicaentregaxcaso('0000825') then
        insert into ldc_ordeasigproc(ORAPORPA, ORAPSOGE, ORAOPELE, ORAOUNID, ORAOCALE, ORAOPROC) values(nuOrden,reg.order_id, nuPersonId, nuUnitop, nuCausalId,'LEGALIZASAC');
      else
        onuErrorCode := NULL;
	      osbErrorMessage := NULL;

       --Inicio CASO 602
         if reg.order_status_id = 0 then
            os_assign_order(reg.order_id,
                            nuUnitop,
                            SYSDATE,
                            SYSDATE,
                            onuErrorCode,
                            osberrormessage);
            IF onuErrorCode <> 0 THEN
                gw_boerrors.checkerror(onuErrorCode, osbErrorMessage);
                raise ex.CONTROLLED_ERROR;
            end if;

         end if;
         --Fin CASO 602

          OS_LEGALIZEORDERALLACTIVITIES(reg.order_id, nuCausalId, nuPersonId, reg.EXEC_INITIAL_DATE, reg.EXECUTION_FINAL_DATE,
                                          sbComment,sysdate, onuErrorCode, osbErrorMessage);
            if (onuErrorCode <> 0) then
            --XLOGPNO('LDC_PRLEGORDENSACRP error '||osbErrorMessage);
              gw_boerrors.checkerror(onuErrorCode, osbErrorMessage);
              raise ex.CONTROLLED_ERROR;
            end if;
          --XLOGPNO('LDC_PRLEGORDENSACRP fin correcto');
       end if;
    END LOOP;


    --dbms_output.put_line(' 6');
    ut_trace.trace('fin PLUGIN LDC_PRLEGORDENSACRP',10);
EXCEPTION
    when ex.CONTROLLED_ERROR then
       Errors.getError(ONUERRORCODE, OSBERRORMESSAGE);
       RAISE Ex.CONTROLLED_ERROR;
    when others then
        Errors.setError;
        RAISE ex.controlled_error;
END LDC_PRLEGORDENSACRP;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_PRLEGORDENSACRP', 'ADM_PERSON');
END;
/
