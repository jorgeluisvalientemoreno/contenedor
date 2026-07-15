
create table contratos_correos as 
select  susccodi , suscmail   
from suscripc  

update suscripc
set suscmail = null
where suscmail is not null ;

commit;
