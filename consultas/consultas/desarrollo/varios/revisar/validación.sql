select ti.instance_attrib_id, i.instance_id, p.package_id, p.package_type_id, p.tag_name, p.motive_status_id
from open.tsd_wf_inst_attrib_121021_1 ti, open.wf_instance i, open.wf_data_external d, open.mo_packages p
where ti.instance_id=i.instance_id
  and d.plan_id=i.instance_id
  and p.package_id=d.package_id
  and p.motive_status_id=13
