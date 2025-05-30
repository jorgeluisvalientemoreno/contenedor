select a.package_type_id || ' - ' || a.description
  from open.ps_package_type a
 where 1=1
--and a.package_type_id in (288)
-- and upper(a.description) like upper('%reconexi%')
;

select *
  from open.sa_tab st
 where st.process_name in
       (select a.tag_name
          from open.ps_package_type a
         where
and a.package_type_id in (100343)
    --     upper(a.description) like '%SUSPENS%')
    ;
