-- Tipos de ciclos

select *
from ldc_cm_lectesp_tpcl;

-- Funcionarios por tipos de ciclos

select l2.tipocicl_id, 
       l3.description,
       l2.person_id,
       p.name_
from ldc_cm_lectesp_petc l2
inner join ge_person p on p.person_id = l2.person_id
inner join ldc_cm_lectesp_tpcl l3 on l3.tipocicl_id = l2.tipocicl_id
where l2.person_id = 38963;

-- Ciclos por tipos de ciclos

select c.pecscico, 
       c.pecstpci,
       l4.description
from ldc_cm_lectesp_cicl  c
inner join ldc_cm_lectesp_tpcl l4 on l4.tipocicl_id = c.pecstpci;
