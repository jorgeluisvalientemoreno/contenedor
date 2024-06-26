select mp.*, rowid
  from open.mo_packages mp
 where mp.package_id in (&p);
select mp.*, rowid
  from open.mo_packages mp
 where mp.cust_care_reques_num in
       (select mp1.cust_care_reques_num
          from open.mo_packages mp1
         where mp1.package_id in (&p));
