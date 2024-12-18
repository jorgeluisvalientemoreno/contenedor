CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRG_CONDBLOQASIG


BEFORE insert or update ON  LDC_CONDBLOQASIG
 FOR EACH ROW

DECLARE

      cursor cuOperatinUnit (inuTaskTypeId number,
			                       inuOperUniId  number)
			is
			select count(*)
      from or_ope_uni_task_type
      where ((task_type_id = inuTaskTypeId
      and OPERATING_UNIT_ID = inuOperUniId and (inuTaskTypeId <> 0 or inuOperUniId <> 1 )) or (inuTaskTypeId = 0 or  inuOperUniId = 1 ));

			cursor cuActivity (inuTaskTypeId number,
			                   inuItemId     number)
			is
			select count(*)
			from or_task_types_items
				where ((task_type_id = inuTaskTypeId
				and  ITEMS_ID = inuItemId and (inuTaskTypeId <> 0 or inuItemId <> -1 ))or (inuTaskTypeId = 0 or inuItemId = -1));


      nuOperUnitCount      number := 0;
			nuActivCount      number := 0;

BEGIN

/*****************************************************************
    Propiedad intelectual de GASCARIBE Y EFIGAS (c).

    Unidad         : ldc_trg_BloqueoAsignacion
    Descripcion    : Trigger para bloquear la inserción/actualización de configuraciones erroneas
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

   ut_trace.trace('Inicio ldc_trg_CONDBLOQASIG', 10);
	 --1. Valida si el tipo de trabajo pertene a la uo
   open cuOperatinUnit (:new.task_type_id,:new.operating_unit_id);
	 fetch cuOperatinUnit into nuOperUnitCount;
	 close cuOperatinUnit;

   if nuOperUnitCount = 0 then
		       ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,'El tipo de trabajo '||to_char(:new.task_type_id)||' - '||daor_task_type.fsbgetdescription(:new.task_type_id,null)||' NO está configurado para la unidad operativa '||to_char(:new.operating_unit_id)||daor_operating_unit.fsbgetname
					 (:new.operating_unit_id,null));
         raise ex.CONTROLLED_ERROR;
   end if;
    --2. Validar si la actividad configurada pertenece al tipo de trabajo
		open cuActivity (:new.task_type_id,:new.activity_id);
    fetch cuActivity into  nuActivCount;
		close cuActivity;

		if nuActivCount = 0 then
		      ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,'La actividad de orden '||to_char(:new.activity_id)||dage_items.fsbgetdescription(:new.activity_id,null)||' NO está asociada al tipo de trabajo '||to_char(:new.task_type_id)||' - '||daor_task_type.fsbgetdescription(:new.task_type_id,null) );

         raise ex.CONTROLLED_ERROR;
   end if;


   ut_trace.trace('Fin ldc_trg_CONDBLOQASIG', 10);
END LDC_TRG_CONDBLOQASIG;
/
