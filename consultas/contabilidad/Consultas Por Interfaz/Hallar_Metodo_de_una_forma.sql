SELECT 'Consulta', extractvalue(APP_XML, 'PB/APPLICATION/QUERY_NAME') cONSULTA FROM OPEN.GE_DISTRIBUTION_FILE
 WHERE distribution_file_id = 'LDCINTCONSUMORO'
UNION
SELECT 'proceso', extractvalue(APP_XML, 'PB/APPLICATION/OBJECT_NAME') proceso FROM OPEN.GE_DISTRIBUTION_FILE 
 WHERE distribution_file_id = 'LDCINTCONSUMORO'