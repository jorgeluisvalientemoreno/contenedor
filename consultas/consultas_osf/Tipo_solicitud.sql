select a.package_type_id || ' - ' || a.description
  from ps_package_type a
 where
--a.package_type_id in (100335, 100337, 100338)
 upper(a.description) like '%SUSPENS%';

select *
  from sa_tab st
 where st.process_name in
       (select a.tag_name
          from ps_package_type a
         where
        --a.package_type_id in (100335, 100337, 100338)
         upper(a.description) like '%SUSPENS%');
