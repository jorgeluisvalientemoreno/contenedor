alter session set current_schema=open;
select 
    ss.sesususc, 
    ss.sesunuse, 
    ca.cargvalo, 
    ca.cargdoso,
    tc.component_id
from cargos ca,
pericose pc,
servsusc ss,
pr_timeout_component tc
where cargnuse in
(
51577055
)
and cargconc = 25
and pc.pecscons = ca.cargpeco
and ss.sesunuse = ca.cargnuse
and tc.timeout_component_id = substr( cargdoso,7)
