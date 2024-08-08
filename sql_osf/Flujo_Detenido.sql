Select h.request_number_origi,
       h.interface_history_id,
       h.last_mess_code_error || ' - ' || h.last_mess_desc_error ultimo_error,
       h.status_id || ' - ' ||
       open.dain_status.fsbgetdescription(h.status_id) estado,
       inserting_date,
       p.package_id
  From open.in_interface_history h, open.wf_instance w, open.mo_packages p
 Where h.status_id = '9'
   And h.request_number_origi = w.instance_id
   And w.parent_external_id = p.package_id
   And p.package_type_id In (100237)
 Order By h.inserting_date Desc;
