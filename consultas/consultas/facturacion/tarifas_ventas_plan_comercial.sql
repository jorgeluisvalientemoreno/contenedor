 select * 
 from ta_conftaco t
 left join ta_tariconc ta on cotccons= tacocotc
 left join  open.ta_vigetaco on tacocons = vitctaco
 left join open.concepto c on cotcconc = c.conccodi
 where cotcconc in (19)  
 and cotcserv =7014 and cotcvige = 'S'  and tacocr01=4 and vitcfefi >sysdate  
 
 -- TACOCR01 PLAN COMERCIAL 
 -- TACOCR02 SUBCATEGORIA
 -- TACOCR03 CATEGORIA
--30 interna 19 cxc  674 cert
