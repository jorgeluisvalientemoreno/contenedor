select *
from cc_commercial_plan;

select *
from concepto;
--validar_impuestos_conceptos
select c.coblconc,
       cc.concdesc,
       c.coblcoba,
       c.coblpoim,
       c.coblfivi,
       c.coblffvi,
       cc.concticl
from concbali  c
inner join concepto  cc  on cc.conccodi = c.coblconc
where c.coblcoba = 30
