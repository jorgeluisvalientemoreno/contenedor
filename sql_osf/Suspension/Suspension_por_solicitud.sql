select a.*, rowid
  from OPEN.MO_SUSPENSION a
 where a.motive_id in (select mm.motive_id
                         from open.mo_motive mm
                        where mm.package_id = 213716926)
