select *
from migragg.servsusc 
where sesususc  = 53691693 ;

select *
from open.factura  
where factsusc = 53691693 
order by factfege desc ;
--12 130733 

select *
from homologacion.suscripc_homologado 
where susccodiosf = 53691693;

select *
from gasgg.factura f
where factsusc = 50191693 
order by factfege desc ; 

select *
from gasgg.perifact p 
where p.pefacicl= 201 
and pefaano = 2025  
order by pefafimo desc ;

select *
from open.perifact p 
where p.pefacicl= 6002 
and pefaano = 2025  
order by pefafimo desc ;

select *
from migragg.lectelme l 
where l.leemsesu= 53643269 
order by leemfele desc ;


select *
from gasgg.lectura l 
where l.lectnuse= 50343269 
order by l.lectfech  desc ; 


