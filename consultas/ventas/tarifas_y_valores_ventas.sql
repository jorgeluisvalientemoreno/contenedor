 select * 
 from ta_conftaco t
 left join ta_tariconc ta on cotccons= tacocotc
 left join  open.ta_vigetaco on tacocons = vitctaco
 left join open.concepto c on cotcconc = c.conccodi
 where cotcconc in (674)  
 and cotcserv = 7014 and cotcvige = 'S' and cotcdect= 122 and vitcfefi >=sysdate 
 ;
 --consulta de tarifas activas para los conceptos de interna, cargo por conexion y certificacion por plan comercial 
-- TACOCR01 PLAN COMERCIAL 
-- TACOCR02 SUBCATEGORIA
-- TACOCR03 CATEGORIA  
--30 interna 19 cxc  674 cert
