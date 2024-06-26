select mp.document_key
  from open.mo_packages mp
 where mp.document_type_id = 1
   and mp.package_type_id = 271
 order by mp.document_key desc
