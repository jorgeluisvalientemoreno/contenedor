select cp.tipo_trab, 
       t.description desc_titr,
       cp.actividad,
       i.description desc_acti,
       cp.unidad_operativa,
       u.name,
       cp.costo_prom
from open.ldc_taskactcostprom cp
left join open.or_task_type t on t.task_type_id=cp.tipo_trab
left join open.ge_items i on i.items_id=cp.actividad
left join open.or_operating_unit u on u.operating_unit_id = cp.unidad_operativa
