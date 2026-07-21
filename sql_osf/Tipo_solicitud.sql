select a.package_type_id || ' - ' || a.description Tramite, a.tag_name TAG, a.is_annulable Anulable 
  from open.ps_package_type a
 where 1=1
and a.package_type_id in (100341)
 --and upper(a.description) like upper('%CAMBIO%ESTADO%PRODUCTO%')
;

select *
  from open.sa_tab st
 where st.process_name in
       (select a.tag_name
          from open.ps_package_type a
         where
 a.package_type_id in (100341)
    --     upper(a.description) like '%SUSPENS%'
    )
    
    ;
