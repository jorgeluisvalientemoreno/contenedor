select pagosusc,
       pagofepa,
       pagovapa  
from open.pagos 
where pagosusc = 17148269
order by pagofepa desc