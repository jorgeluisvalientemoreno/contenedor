select *
  from dba_objects a
 where a.status <> 'VALID'
   and a.OWNER in ('OPEN', 'PERSONALIZACIONES', 'ADM_PERSON')
