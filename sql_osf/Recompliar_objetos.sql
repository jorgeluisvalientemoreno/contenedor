select 'alter ' || REPLACE(object_type, 'BODY', '') || ' ' || owner || '.' ||
       object_name || ' compile;'
  from dba_objects
 where status = 'INVALID'
   AND OWNER = 'OPEN'
 order by owner, object_name
