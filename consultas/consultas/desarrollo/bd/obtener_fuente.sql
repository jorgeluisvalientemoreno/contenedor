ALTER SESSION SET CURRENT_SCHEMA= "OPEN";
select dbms_metadata.get_ddl('PACKAGE_BODY',upper('MO_BCRestriction')) FROM DUAL  ;

SELECT text FROM all_source WHERE name = 'GE_BOACEPTARITEMS';
SELECT line,  text FROM all_source WHERE name = upper('ge_bocalendar') AND type='PACKAGE BODY' order by 1;



select lower(OBJECT_NAME),OBJECT_TYPE, dbms_metadata.get_ddl(OBJECT_TYPE,OBJECT_NAME)  FUENTE
FROM dba_objects  
where object_name in upper(('LD_BONONBANKFINANCING2'))
AND OBJECT_TYPE IN ('PACKAGE','PROCEDURE','FUNCTION','TRIGER');
