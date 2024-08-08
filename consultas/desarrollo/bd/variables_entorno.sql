select DECODE(parameter, 'NLS_CHARACTERSET', 'CHARACTER SET',
'NLS_LANGUAGE', 'LANGUAGE',
'NLS_TERRITORY', 'TERRITORY') name,
 value from v$nls_parameters
 WHERE parameter IN ( 'NLS_CHARACTERSET', 'NLS_LANGUAGE', 'NLS_TERRITORY')
 
 execute dbms_application_info.SET_MODULE( module_name => 'PRUEBA_D', action_name => 'APLICA');
 ALTER SESSION SET NLS_LANG='AMERICAN_AMERICA.AL32UTF8'

SELECT * FROM v$version;
