select t.cotitain || '-  ' || i.taindesc  Tasa_Interes, 
       t.cotifein  Fecha_Inicio, 
       t.cotifefi  Fecha_Fin, 
       t.cotiporc  Porcentaje 
from open.ldc_conftain  t
inner join open.tasainte  i on i.taincodi = t.cotitain
where t.cotitain = 2
order by cotifefi desc

select *
from conftain
where cotitain = 2
order by cotifefi desc --for update 
;  
  
Insert into conftain 
values ( 2, '23/10/2024' , '31/10/2024' , 44.0)

select *
from ldc_conftain
where cotitain = 2
order by cotifefi desc
for update 
  
 SELECT * FROM ta_tariconc WHERE tacocons = 1951;
 SELECT * FROM ta_vigetaco WHERE vitctaco = 1951 ORDER BY vitcfein desc for update ;
 
 
