select a.*, rowid
  from OPEN.GE_ENTITY a
 where upper(a.name_) like upper('WF_%');
