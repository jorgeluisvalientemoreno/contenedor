create or replace trigger ADM_PERSON.LDC_TRG_BLOQASIGNACION
after UPDATE OF order_status_id ON or_order
REFERENCING
    NEW AS NEW
    OLD AS OLD
FOR EACH ROW
when (new.order_status_id = 5 and old.order_status_id!=5)
DECLARE
/************************************************************
 Modificaciones
 
 Fecha             Autor          Observacion
 23/12/2019        HORBATH        CA 147  se valida si la orden esta marca en LDC_ORDER para bloquear
                                  asignacion manual
**************************************************************/
      --Ca200-1871
	  nuOrderActivityId    or_order_activity.order_activity_id%type;
      nuPackageId          mo_packages.package_id%type;
	  nuStatusId           number;
      nuBloqueo            number;
      --Ca200-1871
      
  --INICIO CA 147
  nuExisteBloq NUMBER; 
  --FIN CA 147
BEGIN



   ut_trace.trace('Inicio ldc_trg_BloqAsignacion', 10);
   nuStatusId := dald_parameter.fnuGetNumeric_Value('COD_ESTADO_ASIGNADA_OT',null);

   if nuStatusId is null then
		 ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,'NO SE HA ONFIGURADO EL PARAMETRO COD_ESTADO_ASIGNADA_OT');
         raise ex.CONTROLLED_ERROR;
   end if;
	  ut_trace.trace('ldc_trg_BloqAsignacion :new.order_status_id => '||:new.order_status_id, 10);
	 --La validacion debe ejecutarse solo para caso de asignacion
   if :new.order_status_id = nuStatusId  then
	 --Obtener actividad principal de la orden
	   nuOrderActivityId := ldc_bcfinanceot.fnuGetActivityId(:new.order_id);
		 ut_trace.trace('ldc_trg_BloqAsignacion nuOrderActivityId => '||nuOrderActivityId, 10);


   if OPEN.fblAplicaEntrega('OSS_RPS_JGBA_2001871_6') then
     nuPackageId := daor_order_activity.fnugetpackage_id(nuOrderActivityId,null);
		 ut_trace.trace('ldc_trg_BloqAsignacion nuPackageId => '||nuPackageId, 10);
     if nuPackageId is not null then
      begin
         select count(1)
         into nuBloqueo
       from open.ldc_bloq_lega_solicitud
       where package_id_gene = nuPackageId;
      exception
        when others then
          nuBloqueo:=0;
      end;
      if nuBloqueo>0 then
       ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,'Error al asignar la orden '||:new.order_id|| '. Esta orden se debe asignar y legalizar por el Job de Legalización de RP' );
       raise ex.CONTROLLED_ERROR;
      end if;
     end if;
   end if;
   --INICIO CA 147
   IF FBLAPLICAENTREGAXCASO('0000147') THEN
      --Se valida si la orden boqueada
      SELECT COUNT(1) INTO nuExisteBloq
      FROM ldc_order
      WHERE order_id = :NEW.ORDER_ID
       AND ASIGNADO ='N'
       AND ORDEBLOQ = 'S';
       
      IF nuExisteBloq > 0 THEN
        ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,'Error al asignar la orden '||:new.order_id|| '. Esta orden no se puede asignar manualmente' );
       raise ex.CONTROLLED_ERROR;
      END IF;
   END IF;
   --FIN CA 147
  end if;

   ut_trace.trace('Fin ldc_trg_BloqAsignacion', 10);
end ldc_trg_BloqAsignacion;
/