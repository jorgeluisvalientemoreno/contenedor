select mp.*, rowid
  from open.mo_packages mp
 where mp.Package_Type_Id IN
       (select M.PACKAGE_TYPE_ID
          from open.ps_package_type m
         where m.Is_Annulable = 'Y')
   AND MP.MOTIVE_STATUS_ID = 13
   --and LDC_BOORDENES.FNUCONTROLVISUALANULSOLI(mp.package_id) IN (1, 2, 3);
