-- Consulta agrupadoras

SELECT  oo.order_id,
            oo.operating_unit_id,
            oo.defined_contract_id,
            oo.legalization_date,
            oo.task_type_id,
            aa.geograp_location_id
    FROM    or_order oo,
            ab_address aa
    WHERE   aa.address_id = oo.external_address_id
    AND     oo.task_type_id IN (12626,12627,12626,10043)
    AND TRUNC(oo.legalization_date) = '13/02/2024'
    AND     oo.order_status_id   = 8
    AND     oo.IS_PENDING_LIQ = 'Y'
    AND oo.saved_data_values = 'ORDER_GROUPED'
    AND NOT EXISTS (SELECT orden_agrupadora FROM detalle_ot_agrupada WHERE orden_agrupadora = oo.order_id);
    
 --   individuales

SELECT  305897727 orden_agrupadora,--inuOrdenAgrupadora orden_agrupadora,
                oo.order_id orden,
                NULL fecha_procesada,
                'R' estado
        FROM    or_order oo,
                ab_address aa
        WHERE  aa.address_id = oo.external_address_id
        AND TRUNC(oo.legalization_date) = '13/02/2024'--TRUNC(idtFechaLegal)
        AND oo.operating_unit_id    = 4007--inuUnidadOperativa
        AND oo.defined_contract_id    = 8521--inuContratoId
        AND aa.geograp_location_id    = 201--inLocalidad
        AND oo.task_type_id       = 12626--inuTipoTrabajo
        AND oo.order_status_id      = 8
        AND NVL(oo.IS_PENDING_LIQ,'N') = 'N'
        AND oo.saved_data_values IS NULL
        AND NOT EXISTS (select orden_agrupadora from detalle_ot_agrupada where orden = oo.order_id);

select * from detalle_ot_agrupada where orden =  300489911; --305897727 305897675
        select count(distinct orden) from detalle_ot_agrupada  where estado = 'N'; --3 550 610
        select * from ab_address where address_id in (4471254,5026299);
        select * from or_order where order_id  in (305897727, 305897675)
