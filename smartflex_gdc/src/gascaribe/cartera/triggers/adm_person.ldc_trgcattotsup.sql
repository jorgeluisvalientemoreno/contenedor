CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRGCATTOTSUP
--Inicio caso:279
AFTER UPDATE OF SUCONUOR ON SUSPCONE
REFERENCING
    NEW AS NEW
    OLD AS OLD
FOR EACH ROW
when (new.SUCONUOR <> OLD.SUCONUOR )
--Fin caso:279
/**************************************************************************
        Autor       : Ernesto Santiago / Horbath
        Fecha       : 2019-08-22
        Ticket      : 166
        Descripcion : trigger que asignar a la unidad operativa configurada en la tabla LDC_UOSUP
					  y cambia el tipo de trabajo de de 12526 a 12528 si cumple con las condiciones.

        Valor de salida

        HISTORIA DE MODIFICACIONES
        FECHA           AUTOR                   DESCRIPCION
        24/10/2020      Horbath                 ca279: Se modifica el momento de ejecucion del trigger, para que sea al momento que se actualizara
                                                    y el campo  new.SUCONUOR sea diferente del campo OLD.SUCONUOR.
        25/11/2020      Miguel Ballesteros      ca279: se realiza la modificacion en la consulta del cursor cur_uo para que tenga en cuenta si la localidad
                                                guardado en el MD (LDCUOSUP) sea nula tome todas las categorias asociadas a la orden y categoria, ademas que
												se modifica el proceso de cambio de tipo de trabajo para que cambie ls actividades de forma correcta
   ***************************************************************************/
DECLARE

    -- Mensaje de error
    OSBERRORMESSAGE GE_ERROR_LOG.DESCRIPTION%TYPE;
    -- Codigo de error
    ONUERRORCODE    GE_ERROR_LOG.ERROR_LOG_ID%TYPE;

    sbRequestXML    VARCHAR2(32767);
    VALTT           NUMBER := 0;
    VALCAT          NUMBER := 0;
    NUORDER         number;
	NUPRODUCT       number;
    NUACTV          number;
	nuTiptra	    or_order.task_type_id%type;
	nuUnitop	    LDC_UOSUP.OPERATING_UNIT_ID%type;
    nuCat	        LDC_UOSUP.categoria%type;

	nuTTAnt			or_order.task_type_id%type;
	nuActAnt		or_task_types_items.items_id%type;

	cursor cur_valcat( PRODUCT NUMBER) is
		SELECT 1 FROM
		pr_product where PRODUCT_ID=PRODUCT
		AND CATEGORY_ID in(select nvl((column_value), 0)
		from table(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('TT_CATPPER',NULL),',')));

   cursor cur_valtt(NUORDEN NUMBER) is
	   SELECT 1 FROM
	   OR_ORDER WHERE ORDER_ID=NUORDEN  --138539790
	   AND  TASK_TYPE_ID IN (select nvl((column_value), 0)
					from table(ldc_boutilities.splitstrings(dald_parameter.FNUGETNUMERIC_VALUE('TT_OTSUPPER',NULL),',')));

   cursor cur_uo(NUORDEN NUMBER, NUCAT NUMBER) IS
		Select uo.operating_unit_id
			from ldc_uosup uo,
				 or_order_activity oa
			where uo.departamento = dage_geogra_location.fnugetgeo_loca_father_id(daab_address.fnugetgeograp_location_id(ADDRESS_ID))
			AND   NVL(uo.localidad,0) = DECODE(uo.localidad, NULL, 0, daab_address.fnugetgeograp_location_id(ADDRESS_ID))
			and   oa.order_id = NUORDEN
			AND   uo.categoria = NUCAT;

	-- cursor para obtener la actividad del TT new
    cursor cuGetActTT(nuTT  or_task_types_items.task_type_id%type)is
        select items_id Actividad
            from open.or_task_types_items
            where task_type_id = nuTT
            and is_legalize_visible = 'Y';

BEGIN

	if  fblaplicaentregaxcaso('0000166') then
		NUORDER:= :new.SUCONUOR; --:new.SUCONUOR; ORD:140504001	 140505311   111690045
		NUPRODUCT:= :new.SUCONUSE; --:new.SUCONUSE; PR:1042180     1999621     50574522


		open cur_valcat( NUPRODUCT);
		fetch cur_valcat into VALCAT ;
		close cur_valcat;

		open cur_valtt( NUORDER);
		fetch cur_valtt into VALTT ;
		close cur_valtt;

		if VALCAT =1 AND VALTT=1 then

         nuCat:= dapr_product.fnugetcategory_id(NUPRODUCT);

		 if(cur_uo%isopen)then
			close cur_uo;
		 end if;

         open cur_uo( NUORDER,nuCat);
         fetch cur_uo into nuUnitop;
         close cur_uo;

         if (nuUnitop is not null and DAOR_ORDER.FNUGETORDER_STATUS_ID(NUORDER, null)=0)then

            os_assign_order( NUORDER, nuUnitop, sysdate, sysdate, ONUERRORCODE, OSBERRORMESSAGE);

            if ONUERRORCODE <> 0 then
                ge_boerrors.seterrorcodeargument(2741,'ERROR os_assign_order, '||OSBERRORMESSAGE);
			END if;

		  end if;

		  -- se obtiene la informacion del tipo de trabajo actual de la orden
		  nuTTAnt	:= open.daor_order.fnugettask_type_id(NUORDER, null);

		  -- se obtiene la actividad del tipo de trabajo actual de la orden
		  if(cuGetActTT%isopen)then
				close cuGetActTT;
		  end if;

		  open cuGetActTT (nuTTAnt);
		  fetch cuGetActTT into nuActAnt;
		  close cuGetActTT;

		  nuTiptra:= DALD_PARAMETER.FNUGETNUMERIC_VALUE ('TT_NUOTSUP',NULL);  --- tipo de trabajo nuevo
		  NUACTV :=DALD_PARAMETER.FNUGETNUMERIC_VALUE ('TT_NUACTSUP',NULL);  -- actividad nuevo

		  UT_XmlUtilities.Freexml;
		  sbRequestXML :=
					 '<ORDER>
					 <ORDER_ID>'||TO_CHAR(NUORDER)||'</ORDER_ID>
					 <NEW_TASK_TYPE>'||to_char(nuTiptra)||'</NEW_TASK_TYPE>
					 <ACTIVITIES>
					 <ACTIVITY>
					 <ACTIVITY_ID>'||NUACTV||'</ACTIVITY_ID>
					 <RELATED_ACTIVITY_ID></RELATED_ACTIVITY_ID>
					 </ACTIVITY></ACTIVITIES>
					 </ORDER>';

			/*Ejecuta el XML creado*/
			OS_CHANGE_TASKTYPE (sbRequestXML, ONUERRORCODE, OSBERRORMESSAGE);

			if ONUERRORCODE <> 0 then
				ge_boerrors.seterrorcodeargument(2741,'ERROR OS_CHANGE_TASKTYPE, '||OSBERRORMESSAGE);
			else
				-- se actualiza la actividad anterior de la orden para que quede inhabilitada para la legalizacion
				update open.or_order_items
					set legal_item_amount = -1
					where order_id = NUORDER
					and  items_id = nuActAnt;

				update open.or_order_activity
					set status='F', final_date=sysdate
					where activity_id = nuActAnt /*actividad anterior*/
					and order_id = NUORDER;

				commit;
			END if;

		end if;

	end if;

EXCEPTION
    when ex.CONTROLLED_ERROR then
        Errors.getError(ONUERRORCODE, OSBERRORMESSAGE);

    when others then
        Errors.setError;
        Errors.getError(ONUERRORCODE, OSBERRORMESSAGE);

END LDC_TRGCATTOTSUP;
/
