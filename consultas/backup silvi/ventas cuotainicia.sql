select contrato, 
       p.package_id,
       commercial_plan_id,
       p.motive_status_id,
       s.initial_payment, p.motive_status_id
from multiempresa.contrato
join mo_motive m on m.subscription_id=contrato
join mo_packages p on p.package_id=m.package_id and p.package_type_id=271 and p.motive_status_id=13
join MO_GAS_SALE_DATA s on p.package_id=s.package_id 
where empresa='GDGU' ;

select contrato,
       p.package_id,
       commercial_plan_id,
       p.motive_status_id,
       s.initial_payment
from multiempresa.contrato
join mo_motive m on m.subscription_id=contrato
join mo_packages p on p.package_id=m.package_id and p.package_type_id=271 and p.motive_status_id=14
join MO_GAS_SALE_DATA s on p.package_id=s.package_id
where empresa='GDGU'
