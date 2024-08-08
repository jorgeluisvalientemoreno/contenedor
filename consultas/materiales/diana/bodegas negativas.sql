select reinval1 cod_item,i.description,  reincod1 cod_unidad, u.name, reinval4
from open.reportes r, open.repoinco  rd, open.or_operating_unit u, open.ge_items i
where repofech>='02/01/2019'
 and reinrepo=reponume
 and repoapli='100-85492'
 and reinval4<0
 and u.operating_unit_id=reincod1
 and i.items_id=reinval1;
