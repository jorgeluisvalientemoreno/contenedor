 --validar_tarifas
 select  cotcconc, cotcserv,cotcvige,tacocr01 PLAN_COME ,tacocr02 SUBCATEGORIA ,tacocr03 CATEGORIA,vitctaco,vitccons, vitcfein,vitcfefi , vitcvalo, vitcporc
 from ta_conftaco t
 left join ta_tariconc ta on cotccons= tacocotc
 left join  open.ta_vigetaco on tacocons = vitctaco
 left join open.concepto c on cotcconc = c.conccodi
 where cotcconc in (19,30,674)  and 
 cotcserv =7014 and cotcvige = 'S' and vitcfefi >='01/12/2024' and tacocr01=4 and tacocr02 in (1,-1);

--actualizar_tarifas 
select *
from ta_vigetaco v
where v.vitctaco = 1937
order by v.vitcfein desc
--for update
