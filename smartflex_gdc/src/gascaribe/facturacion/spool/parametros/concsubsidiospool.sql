DECLARE
 nuTab1 NUMBER := 0;
BEGIN
 SELECT COUNT(1) INTO nuTab1
   FROM ld_parameter p
  WHERE p.parameter_id = 'CONCSUBSIDIOSPOOL';
  IF (nuTab1 = 0) THEN
   dbms_output.put_line('Insert del Parametro CONCSUBSIDIOSPOOL');
   INSERT INTO ld_parameter(
                            parameter_id
						   ,numeric_value
						   ,value_chain
						   ,description                            
                           ) 
                     VALUES(
                            'CONCSUBSIDIOSPOOL'
                           ,NULL
                           ,'196,197'
                           ,'Determina los conceptos de Subsidio a los cuales se les agregara el Porcentaje en la descripción del SPOOL'
                           );
     COMMIT;                           
  END IF;
END;
/