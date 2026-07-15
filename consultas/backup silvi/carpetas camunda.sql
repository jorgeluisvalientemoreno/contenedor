--carpetas camunda 
select *
from LDCI_SERVNUEV_EVIDENCI_GESTION
where subscription_id = 67257674
--for update ;

select * from ldci_package_camunda_log where package_id in (185852906,
183228496);


--numero formulario disponible
select *
from (select a.*
      from open.fa_histcodi a
      where a.hicdunop is not null
      and a.hicdcore is null
      and a.hicdfebl is null
      and upper(a.hicdobse) = upper('asignar')) a1
where a1.hicdunop = 4021 ; 

--validar ordenes generadas
select *
from or_order o 
inner join or_order_activity a on o.order_id = a.order_id 
where  subscription_id = 67257716;

select *
from pr_product 
where subscription_id = 67257716
