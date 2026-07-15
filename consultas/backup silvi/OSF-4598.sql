select g.*, ce.id_contratista, empresa , c.id_contrato , c.id_tipo_contrato  , ct.conditions_plan_id  
from ge_acta g 
inner join ge_contrato c on g.id_contrato = c.id_contrato
inner join ge_contratista ce on c.id_contratista = ce.id_contratista 
inner join ct_conpla_con_type ct on ct.contract_type_id=c.id_tipo_contrato
inner join contratista co on contratista= ce.id_contratista 
where estado ='A' and  conditions_plan_id in (324, 36 , 181,22)  
ORDER BY fecha_creacion desc ;

