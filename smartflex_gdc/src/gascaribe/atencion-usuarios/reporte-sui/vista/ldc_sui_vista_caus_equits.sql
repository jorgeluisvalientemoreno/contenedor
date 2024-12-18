CREATE OR REPLACE VIEW OPEN.ldc_sui_vista_caus_equits AS
SELECT distinct cr.causal_registro
       ,cc.description
       ,tipo_solicitud tsd
  FROM open.ldc_sui_caus_equ cr,open.cc_causal cc
 WHERE cr.causal_registro = cc.causal_id;

 /