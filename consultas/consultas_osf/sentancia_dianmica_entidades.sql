select '*'||a.OBJECT_NAME || ' = select a.*, rowid from '|| a.OWNER || '.'|| a.OBJECT_NAME ||' where a. =;' from dba_objects a where a.OBJECT_TYPE = 'TABLE' and a.OWNER in ('OPEN','PERSONALIZACIONES','ADM_PERSON');

