CREATE OR REPLACE trigger ADM_PERSON.LDC_TRG_BLOQUEOASIGNACION
after UPDATE OF order_status_id ON or_order
REFERENCING
    NEW AS NEW
    OLD AS OLD
FOR EACH ROW
when (new.order_status_id = 5 )
DECLARE
      pragma autonomous_transaction;
			cursor cuCondiciones (inuTaskTypeId     number,
			                      inuActivityId     number,
														inuOperatinUnitId number)
			 is
				SELECT LDC_CONDBLOQASIG.BLOQUEOM_ID, LDC_CONDBLOQASIG.OPERATING_UNIT_ID,LDC_CONDBLOQASIG.task_type_id, LDC_CONDBLOQASIG.activity_id,numdias,cant_ot
						FROM LDC_CONDBLOQASIG
						 JOIN LDC_ACTBLOQ ON idmaestro = bloqueom_id
						 WHERE (operating_unit_id = 1 OR operating_unit_id = inuOperatinUnitId)
						 AND (LDC_ACTBLOQ.TASK_TYPE_ID = 0 OR LDC_ACTBLOQ.TASK_TYPE_ID = inuTaskTypeId)
						 AND (LDC_ACTBLOQ.ACTIVITY_ID is null OR LDC_ACTBLOQ.ACTIVITY_ID = inuActivityId)
             and ESACTIVA = 'A';

			cursor cuOrdenes (inuTaskTypeId     number,
			                  inuOperatinUnitId number,
												inuActivityId     number,
												inuStatusId       number,
												nuDays            number)
			is
			select count(*)
				from or_order oo
					join or_order_activity ooa on oo.order_id = ooa.order_id
						where order_status_id = inuStatusId
							and ((oo.task_type_id = inuTaskTypeId and inuTaskTypeId <> 0) or inuTaskTypeId = 0)
							AND ((ooa.activity_id = inuActivityId and inuActivityId is not null) or inuActivityId is null)
              and oo.operating_unit_id = inuOperatinUnitId
							and sysdate-oo.assigned_date >= nuDays;

			nuTaskTypeId         or_task_type.task_type_id%type;
			nuOrderActivityId    or_order_activity.order_activity_id%type;
			nuActivityId         ge_items.items_id%type;
			nuOperatingUnitid    or_operating_unit.operating_unit_id%type;
			nuStatusId           number;
			nuCountOts           number := 0;
BEGIN

/*****************************************************************
    Propiedad intelectual de GASCARIBE Y EFIGAS (c).

    Unidad         : ldc_trg_BloqueoAsignacion
    Descripcion    : Trigger para bloquear la asignación de ordenes según configuración
    Autor          : socoro@horbath.com
    Fecha          : 18/04/2016

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============  ===================


    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
******************************************************************/

   ut_trace.trace('Inicio ldc_trg_BloqueoAsignacion', 10);
	 nuStatusId := dald_parameter.fnuGetNumeric_Value('COD_ESTADO_ASIGNADA_OT',null);

	 if nuStatusId is null then
		 ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,'NO SE HA ONFIGURADO EL PARÁMETRO COD_ESTADO_ASIGNADA_OT');
         raise ex.CONTROLLED_ERROR;
	 end if;
	  ut_trace.trace('ldc_trg_BloqueoAsignacion :new.order_status_id => '||:new.order_status_id, 10);
	 --La validación debe ejecutarse solo para caso de asignación
   if :new.order_status_id = nuStatusId  then


	 --Obtener tipo de trabajo
	   nuTaskTypeId := :new.task_type_id;
		 ut_trace.trace('ldc_trg_BloqueoAsignacion nuTaskTypeId => '||nuTaskTypeId, 10);
	 --Obtener actividad principal de la orden
	   nuOrderActivityId := ldc_bcfinanceot.fnuGetActivityId(:new.order_id);
		 ut_trace.trace('ldc_trg_BloqueoAsignacion nuOrderActivityId => '||nuOrderActivityId, 10);

		 nuActivityId := daor_order_activity.fnugetactivity_id(nuOrderActivityId, null);
		 ut_trace.trace('ldc_trg_BloqueoAsignacion nuActivityId => '||nuActivityId, 10);
	 --Obtener unidad operativa
	   nuOperatingUnitid := :new.operating_unit_id;
		 ut_trace.trace('ldc_trg_BloqueoAsignacion nuOperatingUnitid => '||nuOperatingUnitid, 10);

	 --VALIDAR SI EXISTE CONFIGURACIÿN ESPECÍFICA POR ACTIVIDAD
	 for rcCondicion in cuCondiciones (nuTaskTypeId,nuActivityId,nuOperatingUnitid) loop
		 ut_trace.trace('ldc_trg_BloqueoAsignacion nuTaskTypeId => '||nuTaskTypeId, 10);
		 --Obtener ordenes registradas
		 open cuOrdenes (rcCondicion.Task_Type_Id,nuOperatingUnitid,rcCondicion.Activity_Id,nuStatusId,rcCondicion.Numdias);
		 fetch cuOrdenes into nuCountOts;
		 close cuOrdenes;
		 ut_trace.trace('ldc_trg_BloqueoAsignacion nuCountOts => '||nuCountOts, 10);
		 if nuCountOts >= rcCondicion.Cant_Ot then
		   ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,'Error al asignar la orden '||:new.order_id|| '. La unidad operativa tiene' ||nuCountOts ||' ordenes asignadas. Validar condición de bloqueo: '||rcCondicion.Bloqueom_Id);
         raise ex.CONTROLLED_ERROR;
     end if;
	 end loop;





   end if;

   ut_trace.trace('Fin ldc_trg_BloqueoAsignacion', 10);
END LDC_TRG_BLOQUEOASIGNACION;
/
