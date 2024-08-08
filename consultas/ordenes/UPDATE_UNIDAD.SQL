declare
cursor cuorden is
select o.order_id, o.order_status_id, o.operating_unit_id
from open.or_order o
where order_id in (13942176	,
13942175	,
13933915	,
13933916	,
13933914	,
13933917	,
13856977	,
13856978	,
13943317	,
15596834	,
15596835	,
15596836	,
13848234	,
13848237	,
13848235	,
13848233	,
15588472	,
15588471	,
15588474	,
15588473	,
13939708	,
13939706	   )
and o.order_status_id=7;
begin
  for reg in cuorden loop
    --Se actualiza unidad operativa de la orden en or_order
    update or_order
       set operating_unit_id= 3368
    where order_id=reg.order_id;
    --Se actualiza unidad operativa de la orden en or_order_activity
    update or_order_activity
       set operating_unit_id= 3368
     where order_id=reg.order_id;
    --Se actualiza la unidad operativa y el tecnico
    update ldc_asig_ot_tecn t
       set t.unidad_operativa=3368
           --t.tecnico_unidad=15592
     where t.orden=reg.order_id;
  end loop;
end;
/
