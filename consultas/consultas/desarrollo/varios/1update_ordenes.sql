DECLARE

    sbError   VARCHAR2(4000); -- Error al modificar una OT
    nuCerrada NUMBER := 8;

    -- Cursor con las OT a modificar
    CURSOR cuOrden IS
        select order_id,
       order_status_id,
       o.causal_id,
       o.legalization_date,
       task_type_id
  from open.or_order o
 where order_status_id in (5, 7,6)
   and causal_id is not null
   and order_id in (61107282)
   and exists
 (select null
          from open.or_order_stat_change s
         where s.order_id = o.order_id
           and s.final_status_id = 8)
   ;

    -- Procedimiento que realiza la actualización sobre una solicitud
    PROCEDURE proActualizaOT(inuOrderId or_order.order_id%TYPE, -- Datos de la orden
                             osbError   OUT VARCHAR2 -- Error del proceso
                             ) IS
    
        rcStatChange      daor_order_stat_change.styOr_order_stat_change; -- Tabla de cambios de estado
        dtFechaAsignacion or_order_stat_change.stat_chg_date%TYPE; -- Fecha en que se realiza el cambio de estado
		dtFechaLegalizacion or_order_stat_change.stat_chg_date%TYPE; -- Fecha en que se realiza el cambio de estado
        rgOrden           daor_order.styOr_order;
    
    BEGIN
        daor_order.getRecord(inuOrderId, rgOrden);
    
        -- Si la OT está en estado 8 - CERRADA no se realiza acción alguna
        IF rgOrden.order_status_id = nuCerrada THEN
            osbError := 'La OT está cerrada';
        END IF;
    
	
		        -- Obtener la fecha de legalizacion
        BEGIN
            SELECT oosc.stat_chg_date
            INTO   dtFechaLegalizacion
            FROM   or_order_stat_change oosc
            WHERE  oosc.order_id = rgOrden.order_id
            AND    oosc.final_status_id = 8;
        EXCEPTION
            WHEN no_data_found THEN
                osbError := 'No se encontró el cambio de estado GENERADA - ASIGNADA para determinar la fecha de asignación';
            WHEN too_many_rows THEN
                osbError := 'Se encontró más de un cambio de estado GENERADA - ASIGNADA y no se puede determinar la fecha de asignación real';
        END;
    
        -- Si se realizó el cambio de estado se registra el cambio de estado en la tabla OR_ORDER_STAT_CHANGE
        IF SQL%ROWCOUNT = 1 THEN
        
            rcStatChange.order_stat_change_id := or_bosequences.fnuNextOr_Order_Stat_Change;
            rcStatChange.initial_status_id    := rgOrden.order_status_id;
            rcStatChange.final_status_id      := nuCerrada;
            rcStatChange.order_id             := rgOrden.order_id;
            rcStatChange.stat_chg_date        := SYSDATE;
            rcStatChange.user_id              := ut_session.getUSER;
            rcStatChange.terminal             := ut_session.getTERMINAL;
            rcStatChange.comment_type_id      := NULL;
            rcStatChange.execution_date       := rgOrden.Exec_estimate_date;
            rcStatChange.initial_oper_unit_id := rgOrden.Operating_unit_id;
            rcStatChange.programing_class_id  := rgOrden.Programing_class_id;
            rcStatChange.action_id            := 103;
            rcStatChange.range_description    := NULL;
        
            -- Actualiza el estado de la orden
            rgOrden.order_status_id := nuCerrada;
            
			if rgOrden.LEGALIZATION_DATE is null then	
			    rgOrden.LEGALIZATION_DATE := dtFechaLegalizacion;
			end if;
            daor_order.updRecord(rgOrden);
        
            -- Registra el cambio de estado
            daor_order_stat_change.insrecord(rcStatChange);
        
        ELSE
            osbError := 'No se pudo realizar el cambio de estado de la OT';
        END IF;
    
    END proActualizaOT;

BEGIN

    -- Recorrer el cursor con las OT a modificar
    FOR rgOrden IN cuOrden LOOP
    
        -- Realizar la modificación en la solicitud procesada       
        proActualizaOT(inuOrderId => rgOrden.Order_id, osbError => sbError);
    
        -- Validar si tuvo error
        IF sbError IS NOT NULL THEN
            DBMS_OUTPUT.PUT_LINE('OT ' || rgOrden.order_id || ': No se pudo modificar - ' ||
                                 sbError);
            ROLLBACK;
        ELSE
            DBMS_OUTPUT.PUT_LINE('OT ' || rgOrden.order_id || ': Modificada con éxito');
            COMMIT;
        END IF;
		sbError := null;    
    END LOOP;
END;
/