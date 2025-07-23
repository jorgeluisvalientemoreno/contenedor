--- consulta si existe flujo
select *
  from open.wf_data_external
 where package_id in
       (208897353, 210779468, 210901367, 211155546, 211792883);
-- consulto instancias del flujo
select wde.package_id, w.*
  from open.wf_instance w, open.wf_data_external wde
 where w.plan_id = wde.plan_id
   and wde.package_id in
       (208897353, 210779468, 210901367, 211155546, 211792883)
       and w.status_id = 4 
       
       --and w.unit_id = 1056;
