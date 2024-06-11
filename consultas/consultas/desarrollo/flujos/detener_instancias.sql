declare
 cursor cuDatos is
 select p.package_id solicitud, p.package_type_id, e.*
from open.mo_packages p, wf_data_external e
where package_type_id=100312
  and p.motive_status_id=13
  and e.package_id=p.package_id 
  --  and p.package_id=150784599
  and not exists(select null from  wf_instance i, wf_instance_attrib ia where e.plan_id=i.plan_id and i.instance_id=ia.instance_id);
 
 nuresult number;
 nuInstancia	number;
 ionuinstanceattribid	number;
 sbVAlor	varchar2(4000);
 nuattriblayer number;
 sbisduplicable	varchar2(1);
begin
	for reg in cuDatos loop
		begin
			wf_boeifinstance.suspendinstance(reg.plan_id,nuresult);
			if nuresult != 1 then
				commit;
				ionuinstanceattribid := null;
				nuInstancia	:= null;
				sbVAlor := null;
				nuattriblayer := null;
				sbisduplicable :='N';
				
				select instance_id
				into nuInstancia
				from open.wf_instance
				where plan_id=reg.plan_id
				  and unit_id=103095
				  and unit_type_id=100699;
				WF_BODataAttrib.SaveInstanceAttrib(ionuinstanceattribid => ionuinstanceattribid,
													inuinstanceid => nuInstancia,
													inuattributeid => 5001480,
													isbvalue => sbValor,
													inuattriblayer => nuattriblayer,
													isbisduplicable => sbisduplicable,
													inuinout => null,
													inustatementid => null,
													isbmandatory => 'N');
				if ionuinstanceattribid is not null then
					commit;
					
					wf_boeifinstance.reactivateinstance(reg.plan_id,nuresult);
					if nuresult != -1 then 
						commit;
					else
						rollback;
					end if;
				end if;
			else 
				rollback;
			end if;
		exception
			when others then
			rollback;
		end;
	end loop;
end;
/  
  