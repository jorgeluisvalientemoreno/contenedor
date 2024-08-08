select a.package_type_id || ' - ' || a.description
  from open.ps_package_type a
 where
--a.package_type_id in (100335, 100337, 100338)
 upper(a.description) like '%SUSPENS%';

select *
  from open.sa_tab st
 where st.process_name in
       (select a.tag_name
          from open.ps_package_type a
         where
        --a.package_type_id in (100335, 100337, 100338)
         upper(a.description) like '%SUSPENS%');
