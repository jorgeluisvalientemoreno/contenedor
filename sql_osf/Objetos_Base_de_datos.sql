select g.OWNER||'.'||g.OBJECT_NAME, g.*
  from dba_objects g
 where g.OWNER in ('OPEN','PERSONALIZACIONES','ADM_PERSON')
 and g.OBJECT_TYPE = 'PACKAGE' 
 and g.OBJECT_NAME like upper('%CONSTANT%');
--g.OWNER = 'PERSONALIZACIONES'
--LDC_BO_GESTIONSUSPSEG
