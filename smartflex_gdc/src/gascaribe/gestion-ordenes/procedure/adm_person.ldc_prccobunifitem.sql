CREATE OR REPLACE PROCEDURE adm_person.ldc_prccobunifitem 
IS
    /*********************************************************************************************************************
    Propiedad Intelectual de Gases del caribe S.A E.S.P
    
    Procedimiento : ldc_prccobunifitem
    Descripcion   : Procedimiento que se encarga de validar si los items a legalizar, estan configurados en la
                    tabla : LDC_ITEMCOUS, si es asi, reecalcula los valores a legalizar, posterior a eso,
                    eliminando el cargo anterior, crea un nuevo cargo con los valores actualizados, actualiza
                    el valor de la orden con el nuevo valor reecalculado y registra la auditoria.
    Autor         : John Jairo Jimenez Marimon
    Fecha         : 23-02-2022
    
    Historia de Modificaciones
    Fecha               Autor                Modificacion
    =========           =========          ====================
    17/04/2024          PAcosta             OSF-2532: Se crea el objeto en el esquema adm_person  
    ***************************************************************************************************************************/
    nuOrderId          or_order.order_id%type;
    nuCausalId         ge_causal.causal_id%type;
    nuClassCausalId    ge_causal.class_causal_id%type;
    nuTaskTypeId       or_task_type.task_type_id%type;
    nuOrderActivityId  or_order_activity.order_activity_id%type;
    nuPackageId        mo_packages.package_id%type;
    nuClassCausalRef   ge_causal.class_causal_id%type := 1;
    nmconta            NUMBER(4);
    nmvavalanot        cargos.cargvalo%TYPE;
    nmvavalorot        cargos.cargvalo%TYPE;
    nuProductId        pr_product.product_id%type;
    nuContractId       pr_product.subscription_id%type;
    nuConcepto         or_task_type.concept%type;
    onuErrorCode       number;
    osbErrorMessage    varchar2(2000);
    onuIdListaCosto    ge_unit_cost_ite_lis.list_unitary_cost_id%type;
    onuCostoItem       ge_unit_cost_ite_lis.price%type;
    onuPrecioVentaItem ge_unit_cost_ite_lis.sales_value%type;
    nmvavalotencon     NUMBER(16,2) DEFAULT 0;
    nuItem_id          ge_items.items_id%type;
    dtFechaFinEjec     date;
    nuLocalidad        ge_geogra_location.geograp_location_id%type;
    nuOperatingUnitId  or_operating_unit.operating_unit_id%type;
    nuContract         or_order.defined_contract_id%type;
    nuContractor       or_operating_unit.contractor_id%type;
    nuCaso841          VARCHAR2(30):=	'0000841'; ---- caso 841

    --Cursor para obtener el valor neto de la orden
    CURSOR cuOrderValue(inuOrderId or_order.order_id%type) is
    SELECT oi.order_items_id,
           oi.legal_item_amount cantidad,
           oi.items_id,
           nvl(oi.total_price,0) VALUE
    FROM or_order_items oi
    WHERE oi.order_id = inuOrderId
      AND nvl(oi.out_,'Y') = 'Y';
      
BEGIN
    ut_trace.trace('Inicio ldc_prccobunifitem', 10);
    
    IF fblaplicaentregaxcaso(nuCaso841) THEN
        --Obtener orden de la instancia
        nuOrderId := or_bolegalizeorder.fnuGetCurrentOrder;
        ut_trace.trace('Ejecucion ldc_prccobunifitem  => nuOrderId => ' ||nuOrderId,10);
        
        nuCausalId := daor_order.fnugetcausal_id(nuOrderId);
        ut_trace.trace('Ejecucion ldc_prccobunifitem  => nuCausalId => ' ||nuCausalId,10);
        
        nuClassCausalId := dage_causal.fnugetclass_causal_id(nuCausalId);
        ut_trace.trace('Ejecucion ldc_prccobunifitem  => nuClassCausalId => ' ||nuClassCausalId,10);
        
        nuTaskTypeId := daor_order.fnugettask_type_id(nuOrderId);
        ut_trace.trace('Ejecucion ldc_prccobunifitem  => nuTaskTypeId => ' ||nuTaskTypeId,10);
        
        nuOperatingUnitId := daor_order.fnugetoperating_unit_id(nuOrderId);
        ut_trace.trace('Ejecucion ldc_prccobunifitem  => nuOperatingUnitId => ' ||nuOperatingUnitId,10);
        
        nuContract := daor_order.fnugetdefined_contract_id(nuOrderId);
        ut_trace.trace('Ejecucion ldc_prccobunifitem  => nuContract => ' ||nuContract,10);
        
        nuContractor := daor_operating_unit.fnugetcontractor_id(nuOperatingUnitId);
        ut_trace.trace('Ejecucion ldc_prccobunifitem  => nuContractor => ' ||nuContractor,10);
        
        nuOrderActivityId := ldc_bcfinanceot.fnuGetActivityId(nuOrderId);
        ut_trace.trace('Ejecucion ldc_prccobunifitem  => nuOrderActivityId => ' ||nuOrderActivityId,10);
        
        nuPackageId := daor_order_activity.fnugetpackage_id(nuOrderActivityId);
        ut_trace.trace('Ejecucion ldc_prccobunifitem  => nuPackageId => ' ||nuPackageId,10);
        
        nuProductId := daor_order_activity.fnugetproduct_id(nuOrderActivityId);
        ut_trace.trace('Ejecucion ldc_prccobunifitem  => nuProductId => ' ||nuProductId,10);
        
        nuContractId := dapr_product.fnugetsubscription_id(nuProductId);
        ut_trace.trace('Ejecucion ldc_prccobunifitem  => nuContractId => ' ||nuContractId,10);
        
        dtFechaFinEjec  := daor_order.fdtgetexecution_final_date(nuOrderId);
        ut_trace.trace('Ejecucion ldc_prccobunifitem dtFechaFinEjec => ' ||dtFechaFinEjec,10);
        
        nuLocalidad := ldc_boordenes.fnugetidlocalidad(nuorderid);
        ut_trace.trace('Ejecucion ldc_prccobunifitem nuLocalidad => ' ||nuLocalidad,10);
    
        --Validamos si la causal es de exito
        IF nuClassCausalId = nuClassCausalRef THEN
            -- Validamos si el tipo de trabajo tiene concepto asociado
            nuConcepto := daor_task_type.fnugetconcept(nuTaskTypeId);
            ut_trace.trace('Ejecucion ldc_prccobunifitem nuConcepto => ' ||nuConcepto,10);
    
            -- Validamos si el tipo de trabajo tiene concepto asociado
            IF nuConcepto IS NOT NULL THEN
                nmvavalotencon := 0;
                ut_trace.trace('Ejecucion ldc_prccobunifitem nmvavalotencon => ' ||nmvavalotencon,10);
    
                FOR i IN cuOrderValue(nuOrderId) LOOP
                    nuItem_id := i.items_id;
                    ut_trace.trace('Ejecucion ldc_prccobunifitem nuItem_id => ' ||nuItem_id,10);
    
                    SELECT COUNT(1) INTO nmconta
                    FROM ldc_itemcous cu
                    WHERE cu.id_items = nuItem_id;
                    ut_trace.trace('Ejecucion ldc_prccobunifitem nmconta => ' ||nmconta,10);
    
                    IF nmconta >= 1 THEN
    
                        -- Obtenemos el valor del item en la lista de precios
                        ge_bccertcontratista.obtenercostoitemlista(
                                                                 nuItem_id
                                                                ,dtFechaFinEjec
                                                                ,nuLocalidad
                                                                ,nuContractor
                                                                ,nuOperatingUnitId
                                                                ,nuContract
                                                                ,onuIdListaCosto
                                                                ,onuCostoItem
                                                                ,onuPrecioVentaItem
                                                                );
                        onuPrecioVentaItem := nvl(onuPrecioVentaItem,0);
                        ut_trace.trace('Ejecucion ldc_prccobunifitem onuPrecioVentaItem => ' ||onuPrecioVentaItem,10);
                        
                        onuPrecioVentaItem := onuPrecioVentaItem * i.cantidad ;
                        ut_trace.trace('Ejecucion ldc_prccobunifitem onuPrecioVentaItem * i.cantidad => ' ||onuPrecioVentaItem||' * '||i.cantidad,10);
                        
                        nmvavalotencon := nmvavalotencon + onuPrecioVentaItem;
                        ut_trace.trace('Ejecucion ldc_prccobunifitem nmvavalotencon => ' ||nmvavalotencon,10);
    
                        -- Actualizamos valor del items en or_order_items
                        UPDATE or_order_items oi
                        SET oi.total_price    = round(abs(onuPrecioVentaItem))
                        WHERE oi.order_items_id = i.order_items_id;
    
                    END IF;
                END LOOP;
                
                ------
                IF nmvavalotencon >= 1 THEN
                    -- Consultamos el valor de los items
                    BEGIN
                        SELECT nvl(SUM(oi.total_price),0) INTO nmvavalorot
                        FROM or_order_items oi
                        WHERE oi.order_id = nuOrderId
                        AND nvl(oi.out_,'Y') = 'Y';
                    EXCEPTION
                        WHEN no_data_found THEN
                            nmvavalorot := 0;
                    END;
                    
                    nmvavalorot := nvl(nmvavalorot,0);
                    nmvavalorot := round(abs(nmvavalorot));
                    ut_trace.trace('Ejecucion ldc_prccobunifitem nmvavalorot => ' ||nmvavalorot,10);
                    --
                    IF nmvavalorot <> 0 THEN
                        -- Eliminar cargo
                        DELETE cargos
                        WHERE cargos.cargnuse = nuProductId
                        AND cargos.cargconc = nuConcepto
                        AND cargdoso        = 'PP-' || nuPackageId
                        AND cargcodo        = nuOrderId
                        RETURNING cargvalo INTO nmvavalanot;
                        nmvavalanot := nvl(nmvavalanot,0);
                        ut_trace.trace('Ejecucion ldc_prccobunifitem nmvavalanot => ' ||nmvavalanot,10);
                    
                        -- Creamos el nuevo cargo
                        onuErrorCode := 0;
                        os_chargetobill(
                                   inusubscriberservice => nuProductId
                                  ,inuconcept           => nuConcepto
                                  ,inuunits             => 1
                                  ,inuchargecause       => 41
                                  ,inuvalue             => nmvavalorot
                                  ,isbsupportdocument   => 'PP-' || nuPackageId
                                  ,inuconsperiod        => NULL
                                  ,onuerrorcode         => onuErrorCode
                                  ,osberrormsg          => osbErrorMessage
                                  );
                        ut_trace.trace('Ejecucion ldc_prccobunifitem nmvavalanot => ' ||nmvavalanot,10);
                        
                        IF onuErrorCode <> 0 then
                            ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,osbErrorMessage);
                            RAISE ex.controlled_error;
                        END IF;
    
                        -- Actualizamos cargcodo en el cargo
                        UPDATE cargos ca
                        SET cargcodo = nuOrderId
                        WHERE ca.cargnuse = nuProductId
                        AND ca.cargconc = nuConcepto
                        AND ca.cargdoso = 'PP-' || nuPackageId
                        AND ca.cargvalo = nmvavalorot
                        AND ca.cargcaca = 41
                        AND ca.cargunid = 1;
                        
                        -- Creamos registro de auditoria
                        UPDATE ldc_aud_act_val_order lo
                        SET valor_ant = nmvavalanot
                            ,valor_act = nmvavalorot
                        WHERE lo.order_id = nuOrderId;
                        
                        IF SQL%NOTFOUND THEN
                            INSERT INTO ldc_aud_act_val_order(order_id
                                                              ,concepto
                                                              ,valor_ant
                                                              ,valor_act
                                                              ,usuario
                                                              ,fecha)
                            VALUES(nuOrderId
                                   ,nuConcepto
                                   ,nmvavalanot
                                   ,nmvavalorot
                                   ,USER
                                   ,SYSDATE);
                        END IF;
                    END IF;
                END IF;
            END IF;
        END IF;
    END IF;
    ut_trace.trace('Fin ldc_prccobunifitem', 10);
EXCEPTION
    WHEN ex.controlled_error then
        RAISE;
    WHEN OTHERS THEN
        errors.seterror;
        RAISE ex.controlled_error;
END ldc_prccobunifitem;
/
PROMPT Otorgando permisos de ejecucion a ldc_prccobunifitem
BEGIN
  pkg_utilidades.prAplicarPermisos('LDC_PRCCOBUNIFITEM','ADM_PERSON');
END;
/
