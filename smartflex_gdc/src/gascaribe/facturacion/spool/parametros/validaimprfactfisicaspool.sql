DECLARE
 nuTab1 NUMBER := 0;
BEGIN
 SELECT COUNT(1) INTO nuTab1
   FROM ld_parameter p
  WHERE p.parameter_id = 'VALIDAIMPRFACTFISICASPOOL';
  IF (nuTab1 = 0) THEN
   dbms_output.put_line('Insert del Parametro VALIDAIMPRFACTFISICASPOOL');
   INSERT INTO ld_parameter(
                            parameter_id
						   ,numeric_value
						   ,value_chain
						   ,description                            
                           ) 
                     VALUES(
                            'VALIDAIMPRFACTFISICASPOOL'
                           ,NULL
                           ,'S'
                           ,'Determina si se hace el envió de impresión física en el SPOOL (S/N)'
                           );
     COMMIT;                           
  END IF;
END;
/