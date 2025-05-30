--estado_solicitud_material_a_sap
select r.id_items_documento,
       r.document_type_id,
       d.description,
       r.documento_externo,
       r.fecha,
       r.estado,
       CASE r.estado
         WHEN 'R' THEN 'REGISTRADO'
         WHEN 'A' THEN 'ABIERTO'
         WHEN 'C' THEN 'CERRADO'
         WHEN 'E' THEN 'EXPORTADO'
         ELSE 'DESCONOCIDO'
       END AS descripcion_estado,
       r.operating_unit_id,
       r.destino_oper_uni_id,
       up.name,
       r.terminal_id,
       r.user_id,
       r.comentario,
       r.causal_id,
       r.delivery_date,
       r.package_id
from GE_ITEMS_DOCUMENTO r
inner join GE_DOCUMENT_TYPE  d  on d.document_type_id = r.document_type_id
inner join or_operating_unit  up  on up.operating_unit_id = r.destino_oper_uni_id
where 1 = 1
--and     r.document_type_id = 102
and r.id_items_documento = 1500751

--and     r.estado = 'R'
order by r.fecha desc


--and     r.fecha >= '14/05/2025'
--1500751,1500752,1500753,
--activos_gdca: 1500760
--inventario_gdgu: 1500762, 1500764
--activos_gdgu: 1500766
