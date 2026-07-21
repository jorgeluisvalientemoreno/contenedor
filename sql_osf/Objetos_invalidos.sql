select count(1)
  from dba_objects
 where status != 'VALID'
   and owner in ('OPEN',
                 'PERSONALIZACIONES',
                 'ADM_PERSON',
                 'MULTIEMPRESA',
                 'HOMOLOGACION',
                 'MIGRAGG');

select owner || '|' || object_name || '|' || object_type
  from dba_objects
 where status != 'VALID'
   and owner in ('OPEN',
                 'PERSONALIZACIONES',
                 'ADM_PERSON',
                 'MULTIEMPRESA',
                 'HOMOLOGACION',
                 'MIGRAGG');
