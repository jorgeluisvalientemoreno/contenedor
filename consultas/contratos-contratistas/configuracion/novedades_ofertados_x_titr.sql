select tc.tipo_trabajo,
       open.daor_task_type.fsbgetdescription(tc.tipo_trabajo, null) desc_titr,
       tc.actividad_novedad_ofertados,
       open.dage_items.fsbgetdescription(tc.actividad_novedad_ofertados, null) desc_act_negativa,
       tc.actividad_positiva,
       open.dage_items.fsbgetdescription(tc.actividad_positiva, null) desc_act_positiva
  from open.ldc_tipo_trab_x_nov_ofertados tc