--lo primero es configurar la clase de tipo de trabajo
select t.task_type_id, t.description, t.task_type_classif, open.dage_task_class.fsbgetdescription(t.task_type_classif, null) desc_clas,
       t.concept
from open.or_task_type t 
where t.task_type_id in (11226, 12617)

--las rutas dedicadas deben exister corresponden al ciclo
select *
from open.OR_ROUTE r
where r.dedicated_route='Y'

--el tipo de traajo debe tener las rutas dedicadas asociadas
select *
from open.OR_ROUTE_TASK_TYPE
where task_type_id in (11226);

--la ruta debe estar asociada a una zona
select *
  from open.OR_ROUTE_ZONE t
  where t.operating_zone_id in (174,175,176)
  and t.route_id in (55500000,18500000,19010000,90500000,20500000,18010000,27010000,55020000,90140000,89140000,24010000);


SELECT /*+ use_nl(OR_route_premise)*/
               OR_ROUTE_PREMISE.ROUTE_ID, CONSECUTIVE
          FROM OR_ROUTE_PREMISE, OR_ROUTE, OR_ROUTE_TASK_TYPE
         WHERE OR_ROUTE_PREMISE.PREMISE_ID = INUPREMISEID
           AND OR_ROUTE_PREMISE.ROUTE_ID = OR_ROUTE.ROUTE_ID
           AND OR_ROUTE.DEDICATED_ROUTE = GE_BOCONSTANTS.CSBYES
           AND OR_ROUTE_TASK_TYPE.ROUTE_ID = OR_ROUTE.ROUTE_ID
           AND OR_ROUTE_TASK_TYPE.TASK_TYPE_ID = INUTASKTYPEID;

--el predio del cliente debe estar configurado en OR_ROUTE_PREMISE
--al parecer cuando estan todas las configuraciones anteiores la orden del tipo de trabajo se genera con la ruta dedicada en lugar de la ruta del predio
select o.order_id, o.route_id, re.route_id dedicada,o.order_status_id
from open.or_order o, open.or_order_activity a, open.ab_address di, open.ab_segments se, open.OR_ROUTE_PREMISE re
where o.task_type_id = 11226
 and o.created_date>='01/02/2022'
 and a.order_id=o.order_id
 and se.segments_id=di.segment_id
 and o.external_address_id=di.address_id
 and re.premise_id=di.estate_number
-- and o.order_Status_id=0






