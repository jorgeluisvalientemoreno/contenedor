select g.OWNER||'.'||g.OBJECT_NAME, g.*
  from dba_objects g
 where g.OWNER = 'OPEN'
 and g.OBJECT_TYPE = 'TABLE' 
 and g.OBJECT_NAME like upper('%fm_possible_ntl%')
--g.OWNER = 'PERSONALIZACIONES'
