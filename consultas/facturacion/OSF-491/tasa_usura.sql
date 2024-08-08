select t.cotitain || '-  ' || i.taindesc  Tasa_Interes, 
       t.cotifein  Fecha_Inicio, 
       t.cotifefi  Fecha_Fin, 
       t.cotiporc  Porcentaje 
from open.conftain  t
inner join open.tasainte  i on i.taincodi = t.cotitain
where t.cotitain = 2
order by cotifefi desc
