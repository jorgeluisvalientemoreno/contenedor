 CREATE OR REPLACE VIEW OPEN.ldc_sui_vista_titr_sui AS
SELECT distinct tc.tipo_trabajo tipo_trabajo
      ,tt.description
  FROM ldc_sui_titrcale tc,or_task_type tt
 WHERE tc.tipo_trabajo = tt.task_type_id
 ;

 /