DECLARE
 nuTab1 NUMBER := 0;
BEGIN
 SELECT COUNT(1) INTO nuTab1
   FROM ld_parameter p
  WHERE p.parameter_id = 'INTFINANPRODSPOOL';
  IF (nuTab1 = 0) THEN
   dbms_output.put_line('Insert del Parametro INTFINANPRODSPOOL');
   INSERT INTO ld_parameter(
                            parameter_id
						   ,numeric_value
						   ,value_chain
						   ,description                            
                           ) 
                     VALUES(
                            'INTFINANPRODSPOOL'
                           ,NULL
                           ,'7014'
                           ,'Determina los tipos de productos para los cuales aplicara en la descripción de los conceptos el interés en el SPOOL.'
                           );
     COMMIT;                           
  END IF;
END;
/