select * from dba_source db where lower(db.TEXT)like lower('%meditien%');

SELECT  A.name, A.type, A.line, A.TEXT
  FROM ALL_SOURCE A
 where  UPPER(TEXT) LIKE UPPER('%LDC_VAL_TIPOSUSP767%')
 ORDER  BY NAME, TYPE;


