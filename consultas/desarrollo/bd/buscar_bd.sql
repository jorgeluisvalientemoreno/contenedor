select * from dba_source db where lower(db.TEXT)like lower('%meditien%');

SELECT  A.name, A.type, A.line, A.TEXT
  FROM ALL_SOURCE A
 where  UPPER(TEXT) LIKE UPPER('%P_SOLICITUD_DE_INFORMACION_GENERAL_100214%')
 ORDER  BY NAME, TYPE;


SELECT  A.name, A.type, A.line, A.TEXT
  FROM DBA_SOURCE A
 where  UPPER(TEXT) LIKE UPPER('%P_SOLICITUD_DE_INFORMACION_GENERAL_100214%')
 ORDER  BY NAME, TYPE;
