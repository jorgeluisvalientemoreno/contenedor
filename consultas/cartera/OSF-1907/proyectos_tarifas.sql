SELECT * FROM ta_tariconc WHERE tacocons = 1942;
 SELECT * FROM open.ta_vigetaco WHERE vitctaco = 1951 ORDER BY vitcfein desc 
 
 for update ;
select *  from ta_conftaco t; 


--TARIFAS VENTAS
 select * 
 from ta_conftaco t
 left join ta_tariconc ta on cotccons= tacocotc
 left join  open.ta_vigetaco on tacocons = vitctaco
 left join open.concepto c on cotcconc = c.conccodi
 where vitctaco = 1951
 
 --cotcconc in (31)  
 and cotcserv =7055 --and cotcvige = 'S'
/* and TACOCR01 = 4
 and TACOCR03 = 1
 and TACOCR02 = 1*/
 and  vitcfefi >='01/10/2023'
 --order by vitcfefi desc
 --and cotcdect= 122 and vitcfefi >='01/10/2023' and tacocr01=4-- and  TACOCR02= 2 and TACOCR03= 1
 ;
 SELECT * FROM TA_RANGVITC WHERE RAVTVITC IN (40092,15579) FOR UPDATE 
  -- TACOCR01 PLAN COMERCIAL 
 -- TACOCR02 SUBCATEGORIA
 -- TACOCR03 CATEGORIA  
  
--30 interna 19 cxc  674 cert
select * from ta_vigetaco where  vitctaco in (4050,4051);
  -- for update 

select * from TA_RANGVITP where RAVPVITP in ( 391979, 391978)  --for update /*order by 1 desc*/  ;--unir con VITPCONS
select  * from ta_conftaco where  cotcconc in (193);   ---for update 
select * from TA_VIGETACP order by 1 desc ; 
select * from TA_TARICOPR order by 1 desc ;

select v.*
from open.TA_TARICOPR 
left join open.ta_vigetaco on vitctaco = tacptacc 
left join open.TA_VIGETACP v on TACPCONS=VITPTACP
where vitctaco in (4130,4131); 
