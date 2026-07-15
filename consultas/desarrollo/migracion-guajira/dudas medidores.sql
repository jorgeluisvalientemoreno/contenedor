select cuadcodi,
       cuadnomb,
       sum(eixbdisu),
       sum(eixbvlor)
from exitebod
left join cuadcont on cuadcodi=eixbbcua
left join item on itemcodi=eixbitem
where eixbbcua in (531, 702,  703, 122, 800, 312, -1,100,200,256,258,305,318,319,511,512,533,534,700,805,1000,1105,1206,1305)
group by cuadcodi,
       cuadnomb;
select medicuad,
       cuadnomb,
       medibode,
       mediesme,
       (select esmedesc from estamedi where esmecodi=mediesme) desc_estado,
       mediitem,
       (select itemdesc from item where itemcodi=mediitem) desc_item,
       count(1)
from medidor
left join cuadcont on cuadcodi=medicuad

where medicuad in (531, 702,  703, 122, 800, 312, 100,200,256,258,305,318,319,511,512,533,534,700,805,1000,1105,1206,1305)
  and mediesme in (1, 6)
group by medicuad,
       cuadnomb,
       medibode,
       mediesme,
       mediitem
order by medicuad, mediesme, mediitem       
;


select cuadcodi,
       cuadnomb,
       sum(eixbdisu),
       sum(eixbvlor)
from exitebod
left join cuadcont on cuadcodi=eixbbcua
left join item on itemcodi=eixbitem
where eixbbcua in (119,314)
group by cuadcodi,
       cuadnomb;
select medicuad,
       cuadnomb,
       medibode,
       mediesme,
       (select esmedesc from estamedi where esmecodi=mediesme) desc_estado,
       mediitem,
       (select itemdesc from item where itemcodi=mediitem) desc_item,
       count(1)
from medidor
left join cuadcont on cuadcodi=medicuad

where medicuad in (119, 314)
  and mediesme in (1, 6)
group by medicuad,
       cuadnomb,
       medibode,
       mediesme,
       mediitem
order by medicuad, mediesme, mediitem       
;

with seriales_bodega as (select cuadcodi,
       cuadnomb,
       itemcodi,
       itemdesc,
       itemseri,
       sum(eixbdisu) cant_sumi,
       sum(eixbvlor) valor_sumi,
       sum(EIXBDIVE) cant_vend
from exitebod
left join cuadcont on cuadcodi=eixbbcua
inner join item on itemcodi=eixbitem and nvl(itemseri,'N')='S'
where eixbbcua not in (531, 702,  703, 122, 800, 312, -1,100,200,256,258,305,318,319,511,512,533,534,700,805,1000,1105,1206,1305)
group by cuadcodi,
       cuadnomb,itemcodi,
       itemdesc,
       itemseri)
, seriales_medidor as(
select medicuad,
       cuadnomb,
       mediitem,
       itemdesc,
       count(1) cant_seri
from medidor
left join cuadcont on cuadcodi=medicuad
left join item on itemcodi=mediitem
where mediesme in (1, 6)
  and medicuad not in (531, 702,  703, 122, 800, 312, -1,100,200,256,258,305,318,319,511,512,533,534,700,805,1000,1105,1206,1305)
group by medicuad,
       cuadnomb,
       mediitem,
       itemdesc
)
select *
from seriales_bodega  
full outer join seriales_medidor on medicuad=cuadcodi and mediitem= itemcodi
where cant_sumi+cant_vend!=0 or cant_seri!=0
;
select *
from medidor
where mediesme in (1,6)
  and mediitem is null
