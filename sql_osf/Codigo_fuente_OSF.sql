select s.name
  from dba_source s
 where upper(s.TEXT) like upper('%rfSUSPENSION_ACTIVA%')
 group by s.name
