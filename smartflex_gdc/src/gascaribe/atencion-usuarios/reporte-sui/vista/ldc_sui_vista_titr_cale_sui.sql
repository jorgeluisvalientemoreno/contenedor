 CREATE OR REPLACE VIEW OPEN.ldc_sui_vista_titr_cale_sui AS
SELECT distinct tc.tipo_trabajo tipo_trabajo_causal
      ,tc.causal_legalizacion causal
      ,tt.description
  FROM ldc_sui_titrcale tc,ge_causal tt
 WHERE tc.causal_legalizacion = tt.causal_id;

 /