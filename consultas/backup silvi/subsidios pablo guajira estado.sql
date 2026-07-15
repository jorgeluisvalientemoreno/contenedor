SELECT ASIG_SUBSIDY_ID|| '-S' codigo,
 asu.order_id,
 s.package_id
 FROM ld_asig_subsidy asu, mo_packages s, ld_subsidy su, multiemprEsa.contrato
 WHERE
    asu.delivery_doc = 'N' AND
    asu.state_subsidy <> 5 AND
    Asu.subsidy_id  = su.subsidy_id AND
    S.package_id   = asu.package_id
    and contrato=asu.susccodi
    and empresa='GDGU';
    
    
select *
from LDC_LOGERCODAVE
where trunc(fecherror) >='11/02/2026';


select *
from ld_asig_subsidy  
where susccodi = 67791849;

select * 
from 
