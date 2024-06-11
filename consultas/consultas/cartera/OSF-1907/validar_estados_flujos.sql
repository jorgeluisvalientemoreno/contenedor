-- validar_estados_flujos
select p.cust_care_reques_num,
       p2.package_id, 
       p2.package_type_id,
       ts.description,
       d.plan_id,
       i.status_id,
       s.description
from mo_packages p
inner join mo_packages p2 on p2.cust_care_reques_num=p.cust_care_reques_num
left join wf_data_external d on d.package_id=p2.package_id
left join open.wf_instance i on i.plan_id=d.plan_id and i.instance_id=i.plan_id
left join open.wf_instance_status s on s.instance_status_id = i.status_id
left join open.ps_package_type ts on ts.package_type_id = p2.package_type_id
where p.package_id= 206933987;
