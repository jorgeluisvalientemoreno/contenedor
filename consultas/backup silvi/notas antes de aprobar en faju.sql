select *
from open.fa_cargapro
where fa_cargapro.caapnuse = 17036688
and trunc(fa_cargapro.caapfecr) = '31/01/2024'
and caapcuco = 3053925703;

select * from fa_apromofa f 
order by apmofere desc ;
