/*
select oourt.*, rowid
  from open.or_ope_uni_rece_type oourt
 where oourt.operating_unit_id = (PKG_BOPERSONAL.fnuGetPuntoAtencionId(1));
delete open.or_ope_uni_rece_type oourt
 where oourt.operating_unit_id = (PKG_BOPERSONAL.fnuGetPuntoAtencionId(1));
commit;
--*/
select oourt.*, rowid
  from open.or_ope_uni_rece_type oourt
 where oourt.operating_unit_id = (PKG_BOPERSONAL.fnuGetPuntoAtencionId(1));
--1 34710 2470  20  AACI6UAAyAAABmxACI
