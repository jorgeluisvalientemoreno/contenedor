select * from open.tt_damage d where d.package_id in (228691097);
select * from OPEN.PR_TIMEOUT_COMPONENT a where a.package_id = 228691097;
select * from open.mo_packages p where p.package_id in (228691097);
select * from open.mo_motive p where p.package_id in (228691097);
select a.*, rowid
  from OPEN.MO_PACKAGE_CHNG_LOG a
 where a.package_id in (228691097);
