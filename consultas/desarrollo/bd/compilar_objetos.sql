SELECT OWNER, OBJECT_NAME, OBJECT_TYPE, 'alter '
               || r_obj.object_type
               || ' '
               || r_obj.owner
               || '.'
               || r_obj.object_name
               || ' compile'  FROM ALL_OBJECTS r_obj WHERE STATUS = 'INVALID'
AND owner='OPEN';
