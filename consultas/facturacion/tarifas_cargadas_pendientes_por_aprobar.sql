SELECT tacpprta proyecto,
        tacpcotc conf_tarifa_concepto, 
        tacpreso resolucion, 
        tacpdesc descripcion, 
        tacpcr01 mercado, 
        cotcconc concepto,
        vitpfein fecha_inicio_vigencia,
        vitpfefi fecha_fin_vigencia,
        vitpvalo valor
FROM OPEN.ta_taricopr
    JOIN OPEN.ta_conftaco ON ta_conftaco.cotccons = ta_taricopr.tacpcotc
    JOIN open.ta_vigetacp ON ta_vigetacp.vitptacp= ta_taricopr.tacpcons
WHERE ta_taricopr.tacpprta =12291
and vitptipo='B';