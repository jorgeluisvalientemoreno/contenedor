--Validar solicitud que fue anulada
select *
  from open.MO_PACK_ANNUL_DETAIL a
 WHERE A.PACKAGE_ID = 153965764
 order by a.annul_package_id desc;
--Validar solicitudes que fueron anuladas
select *
  from open.MO_PACK_ANNUL_DETAIL a
 WHERE A.PACKAGE_ID in (select mp.package_id
                          from open.mo_packages mp
                         where mp.motive_status_id = 13
                         and mp.package_type_id not in (9, 268))
 order by a.annul_package_id desc;
--where a.annul_package_id in (195078408);
--select mp.*,rowid from open.mo_packages mp where mp.package_id in (194845907,195078408);
--select * from open.ps_package_type ps where ps.package_type_id in (9,279)

--Tramites configurados como anulables
select mp.*, rowid
  from open.mo_packages mp
 where mp.Package_Type_Id IN
       (select M.PACKAGE_TYPE_ID
          from open.ps_package_type m
         where m.Is_Annulable = 'Y')
   AND MP.MOTIVE_STATUS_ID = 13;