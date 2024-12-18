declare
	nuConta  NUMBER;
 
	CURSOR cuExiste(sbObjeto VARCHAR2,
					sbesquema VARCHAR2) 
	IS
		SELECT COUNT(1)
		FROM dba_objects
		WHERE object_name 	= sbObjeto
		AND OWNER 			= sbesquema;
  
BEGIN

	dbms_output.put_line('---- Inicio Eliminacion procedimiento ----');
	
	OPEN cuExiste('REVERSEEXECUTEORDER',
				  'OPEN');
	FETCH cuExiste INTO nuConta; 
	CLOSE cuExiste; 
	
	IF nuConta = 1 THEN	
		dbms_output.put_line('---- Eliminando el procedimiento REVERSEEXECUTEORDER ----');
		EXECUTE IMMEDIATE 'DROP PROCEDURE OPEN.REVERSEEXECUTEORDER';
	END IF;
  
	dbms_output.put_line('---- Fin Eliminacion procedimiento ----');
	
end;
/