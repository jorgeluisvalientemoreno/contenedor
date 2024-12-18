CREATE OR REPLACE procedure adm_person.prTemporalCharges is
    /**************************************************************************
    Autor       : Miguel Angel Ballesteros Gomez / Horbath
    Fecha       : 2019-03-27
    Ticket      : 200-2402
    Descripcion : Procedimiento que envia correos de acuerdo con la causal
                  que se este legalizando
    
    Valor de salida
    
    HISTORIA DE MODIFICACIONES
    FECHA            AUTOR             DESCRIPCION
    24/04/2024       PACOSTA           OSF-2596: Se retita el llamado al esquema OPEN (open.)                                   
                                       Se crea el objeto en el esquema adm_person                               
    ***************************************************************************/
   
    nuOrderId         or_order.order_id%type;
    nuCausalId        ge_causal.causal_id%type;
    nuClassCausalId   ge_causal.class_causal_id%type;
    nuTaskTypeId      or_task_type.task_type_id%type;
    nuOrderActivityId or_order_activity.order_activity_id%type;
    nuPackageId       mo_packages.package_id%type;
    nuClassCausalRef  ge_causal.class_causal_id%type := 1;
    dtLivePR          date := trunc(to_date(dald_parameter.fsbGetValue_Chain('LIVE_DEPARTURE_DATE_PR'),
                                            ut_date.fsbDATE_FORMAT));
    --Cursor para obtener el valor neto de la orden
    /*cursor cuOrderValue(inuOrderId or_order.order_id%type) is
      SELECT sum(nvl(or_order_items.total_price, 0)) value
        FROM or_order_items
       WHERE or_order_items.order_id = inuOrderId
         AND or_order_items.out_ = 'Y';*/

    nuProductId     pr_product.product_id%type;
    nuContractId    pr_product.subscription_id%type;
    --nuOrderValue    or_order.order_value%type;
    nuConcepto      or_task_type.concept%type;
    onuErrorCode    number;
    osbErrorMessage varchar2(2000);

    onuIdListaCosto    ge_unit_cost_ite_lis.list_unitary_cost_id%type;
    onuCostoItem       ge_unit_cost_ite_lis.price%type;
    onuPrecioVentaItem ge_unit_cost_ite_lis.sales_value%type;
    nuItem_id          ge_items.items_id%type;
    dtfechAsigna       date := sysdate;
    dtFechaFinEjec     date;
    nuLocalidad        ge_geogra_location.geograp_location_id%type;
    nuOperatingUnitId  or_operating_unit.operating_unit_id%type;
    nuContract         or_order.defined_contract_id%type;
    nuContractor       or_operating_unit.contractor_id%type;

    nuGenCharge        number := 0;
    --nuOriginActivityId or_order_activity.origin_activity_id%type;
    --Cursor para validar si la orden se regener? a partir de una orden de
    ---arbitraje o correcci?n.
    /*cursor cuIsRegen(inuActivityId or_order_activity.order_activity_id%type) is
      select count(*)
        from or_order_activity, or_order
       where or_order_activity.order_activity_id = inuActivityId
         and or_order.order_id = or_order_activity.order_id
         and ((or_order.task_type_id = 12475 and or_order.causal_id = 9537) or
             (or_order.task_type_id = 10213 and or_order.causal_id = 3162));*/
    --nuIsRegen number := 0;

	 nuCaso750	varchar2(30):=	'0000750'; ---- caso 750
	 sw750		boolean := False;	--- caso 750

  begin

	IF FBLAPLICAENTREGAXCASO(nuCaso750)THEN
		sw750 := true;
	END IF;

    ut_trace.trace('Inicio prTemporalCharges', 10);
    --Obtener orden de la instancia
    nuOrderId := or_bolegalizeorder.fnuGetCurrentOrder;
    ut_trace.trace('Ejecucion prTemporalCharges  => nuOrderId => ' ||
                   nuOrderId,
                   10);
    nuCausalId := daor_order.fnugetcausal_id(nuOrderId);
    ut_trace.trace('Ejecucion prTemporalCharges  => nuCausalId => ' ||
                   nuCausalId,
                   10);
    nuClassCausalId := dage_causal.fnugetclass_causal_id(nuCausalId);
    ut_trace.trace('Ejecucion prTemporalCharges  => nuClassCausalId => ' ||
                   nuClassCausalId,
                   10);
    nuTaskTypeId := daor_order.fnugettask_type_id(nuOrderId);
    ut_trace.trace('Ejecucion prTemporalCharges  => nuTaskTypeId => ' ||
                   nuTaskTypeId,
                   10);
    nuOperatingUnitId := daor_order.fnugetoperating_unit_id(nuOrderId);
    ut_trace.trace('Ejecucion prTemporalCharges  => nuOperatingUnitId => ' ||
                   nuOperatingUnitId,
                   10);
    nuContract := daor_order.fnugetdefined_contract_id(nuOrderId);
    ut_trace.trace('Ejecucion prTemporalCharges  => nuContract => ' ||
                   nuContract,
                   10);
    nuContractor := daor_operating_unit.fnugetcontractor_id(nuOperatingUnitId);
    ut_trace.trace('Ejecucion prTemporalCharges  => nuContractor => ' ||
                   nuContractor,
                   10);
    --Validar clase de causal de legalizaci?n
    if nuClassCausalId = nuClassCausalRef  then

      nuOrderActivityId := ldc_bcfinanceot.fnuGetActivityId(nuOrderId);
      ut_trace.trace('Ejecucion prTemporalCharges  => nuOrderActivityId => ' ||
                     nuOrderActivityId,
                     10);
      nuPackageId := daor_order_activity.fnugetpackage_id(nuOrderActivityId);
      ut_trace.trace('Ejecucion prTemporalCharges  => nuPackageId => ' ||
                     nuPackageId,
                     10);
      --Obtener el valor del item
      nuItem_id := daor_order_activity.fnugetactivity_id(nuOrderActivityId);
      ut_trace.trace('Ejecucion prTemporalCharges nuItem_id => ' ||
                     nuItem_id,
                     10);
      dtFechaFinEjec  := daor_order.fdtgetexecution_final_date(nuOrderId);
      ut_trace.trace('Ejecucion prTemporalCharges dtFechaFinEjec => ' ||
                     dtFechaFinEjec,
                     10);

      nuLocalidad:=LDC_BOORDENES.FNUGETIDLOCALIDAD(nuOrderId);
      ut_trace.trace('Ejecucion prTemporalCharges nuLocalidad => ' ||
                     nuLocalidad,
                     10);


      GE_BCCertContratista.ObtenerCostoItemLista(nuItem_id,
                                                 dtFechaFinEjec,
                                                 nuLocalidad,
                                                 nuContractor,
                                                 nuOperatingUnitId,
                                                 nuContract,
                                                 onuIdListaCosto,
                                                 onuCostoItem,
                                                 onuPrecioVentaItem);
      ut_trace.trace('Ejecucion prTemporalCharges onuPrecioVentaItem => ' ||
                     onuPrecioVentaItem,
                     10);
      nuConcepto := daor_task_type.fnugetconcept(nuTaskTypeId);
      ut_trace.trace('Ejecucion prTemporalCharges nuConcepto => ' ||
                     nuConcepto,
                     10);
      --Obtener servicio
      nuProductId := daor_order_activity.fnugetproduct_id(nuOrderActivityId);
      ut_trace.trace('Ejecucion prTemporalCharges  => nuProductId => ' ||
                     nuProductId,
                     10);
      --Obtener contrato
      nuContractId := dapr_product.fnugetsubscription_id(nuProductId);
      ut_trace.trace('Ejecucion prTemporalCharges  => nuContractId => ' ||
                     nuContractId,
                     10);

      if nuTaskTypeId in (dald_parameter.fnuGetNumeric_Value('LDC_COBROFINAN_RP')) then
        --Eliminar cargo
        delete from cargos
         where cargos.cargnuse = nuProductId
           and cargos.cargconc in (174, 739, 137)
           and cargdoso = 'PP-' || nuPackageId;
        nuGenCharge := 1;
      elsif instr(dald_parameter.fsbGetValue_Chain('RECONEXION_FLUJO_NUEVO'), to_char(nuTaskTypeId)) > 0 then
        delete from cargos
         where cargos.cargnuse = nuProductId
           and cargos.cargconc = nuConcepto
           and cargdoso = 'PP-' || nuPackageId;
        nuGenCharge := 1;
      end if;

      if nuGenCharge > 0 then
        ut_trace.trace('Ejecucion prTemporalCharge10444  Inicio de insertar cargo CR',
                       10);

         GE_BCCertContratista.ObtenerCostoItemLista(nuItem_id,
                                                 dtFechaFinEjec,
                                                 nuLocalidad,
                                                 nuContractor,
                                                 nuOperatingUnitId,
                                                 nuContract,
                                                 onuIdListaCosto,
                                                 onuCostoItem,
                                                 onuPrecioVentaItem);
        ut_trace.trace('Ejecucion prTemporalCharge onuPrecioVentaItem => ' ||
                     onuPrecioVentaItem,
                     10);

      --cambio 7819
      --validar que el valor de la lista de costos sea mayor a 0
      if onuPrecioVentaItem > 0 then
      --Fin cambio 7819
        if onuPrecioVentaItem is not null and nuConcepto is not null then

        OS_CHARGETOBILL(INUSUBSCRIBERSERVICE => nuProductId,
                        INUCONCEPT           => nuConcepto,
                        INUUNITS             => 1,
                        INUCHARGECAUSE       => 53,
                        INUVALUE             => round(abs(onuPrecioVentaItem)),
                        ISBSUPPORTDOCUMENT   => 'PP-' || nuPackageId,
                        INUCONSPERIOD        => NULL,
                        ONUERRORCODE         => onuErrorCode,
                        OSBERRORMSG          => osbErrorMessage);
        ut_trace.trace('CODIGO ERROR --> ' || onuErrorCode);
        ut_trace.trace('DESCRIPCION ERROR --> ' || osbErrorMessage);
        ut_trace.trace('Fin de insertar cargo', 10);
        if onuErrorCode <> 0 then
          ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                           osbErrorMessage);
          raise ex.CONTROLLED_ERROR;
        end if;
        ut_trace.trace('Ejecucion prTemporalCharge10444  FIN de insertar cargo DB ' ||
                       nuConcepto,
                       10);
      end if;
        -- fin validacion concepto
      --cambio 7819
      else
         ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                          'El precio de venta del item '|| nuItem_id || ' es cero en la lista de costo '|| onuIdListaCosto);
          raise ex.CONTROLLED_ERROR;
      end if; --validacion del valor mayor a 0

      end if;
    end if;
    ut_trace.trace('Fin prTemporalCharge10444', 10);


	exception
		when ex.CONTROLLED_ERROR then
			if sw750 then
				raise ex.CONTROLLED_ERROR;
			else
				gw_boerrors.checkerror(SQLCODE, SQLERRM);
				raise;
			end if;

		when others then

			if sw750 then
				ERRORS.SETERROR;
				raise ex.CONTROLLED_ERROR;
			else
				gw_boerrors.checkerror(SQLCODE, SQLERRM);
				raise ex.CONTROLLED_ERROR;
			end if;



  end prTemporalCharges;
/
PROMPT Otorgando permisos de ejecucion a PRTEMPORALCHARGES
BEGIN
    pkg_utilidades.praplicarpermisos('PRTEMPORALCHARGES', 'ADM_PERSON');
END;
/

PROMPT Otorgando permisos de ejecucion sobre PRTEMPORALCHARGES para reportes
GRANT EXECUTE ON adm_person.PRTEMPORALCHARGES TO rexereportes;
/
