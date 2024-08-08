--aqui se configuran la clase de valoración del tipo de trabajo
--si el tipo de bodega es A se descueta de la bodega de activo
--si el tip de bodega es I se descuenta de la bodega de inventario
--tambien se confiura la validación contable en el cierre de actas, si esta el flag active_flag activo
select tt.task_type_id cod_titr,
       tt.description desc_titr,
       t.warehouse_type tipo_bodega,
       t.creation_date,
       t.disable_date,
       t.active_flag 
  from open.ldc_tt_tb t
 inner join open.or_task_type tt
    on tt.task_type_id = t.task_type_id
