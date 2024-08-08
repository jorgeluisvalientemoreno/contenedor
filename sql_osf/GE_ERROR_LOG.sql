select mp.*, rowid
  from open.mo_packages mp
 where mp.package_id = 183643356;
select gel.*, rowid
  from open.ge_error_log gel
 where to_date(gel.time_stamp, 'DD/MM/YYYY HH24:MI:SS') >= to_date('23/02/2022 12:05:48', 'DD/MM/YYYY HH24:MI:SS')
 and to_date(gel.time_stamp, 'DD/MM/YYYY HH24:MI:SS') < to_date('23/02/2022 12:07:48', 'DD/MM/YYYY HH24:MI:SS')
-- and upper(gel.description) like upper('%Tarea 100645%') ;
