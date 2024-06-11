select conftain.cotitain || '-  ' || tasainte.taindesc  Tasa_Interes, 
       conftain.cotifein  Fecha_Inicio, 
       conftain.cotifefi  Fecha_Fin, 
       conftain.cotiporc  Porcentaje 
from open.conftain
inner join open.tasainte on tasainte.taincodi = conftain.cotitain
