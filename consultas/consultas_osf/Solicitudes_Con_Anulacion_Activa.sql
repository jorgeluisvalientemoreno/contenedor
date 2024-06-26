select * from open.ps_package_type m where m.package_type_id = 100284;
select *
  from open.ps_package_type m
 where upper(m.description) like '%ANULACI%';
select mm.package_id, mm.subscription_id, mm.product_id
  from open.mo_packages mp, open.mo_motive mm
 where mp.Package_Type_Id = 100284
   and mp.package_id = mm.package_id
   AND MP.MOTIVE_STATUS_ID = 13
   and (select count(1)
          from open.Or_Order_Activity ooa
         where ooa.package_id = mm.package_id
           and ooa.operating_unit_id is not null) > 0;
select mm.subscription_id, count(1)
  from open.mo_packages mp, open.mo_motive mm
 where mp.Package_Type_Id = 100284
   and mp.package_id = mm.package_id
   AND MP.MOTIVE_STATUS_ID = 13
 group by mm.subscription_id;
select mp.*, rowid
  from open.mo_packages mp
 where mp.Package_Type_Id IN
       (select M.PACKAGE_TYPE_ID
          from open.ps_package_type m
         where m.Is_Annulable = 'Y')
   AND MP.MOTIVE_STATUS_ID = 13;
