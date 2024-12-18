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

	dbms_output.put_line('---- Inicio Eliminacion funcion ----');

	OPEN cuExiste('FNUGETORDERFINISHED',
				  'ADM_PERSON');
	FETCH cuExiste INTO nuConta; 
	CLOSE cuExiste; 
	
	IF nuConta = 1 THEN	
		dbms_output.put_line('---- Eliminando la funcion FNUGETORDERFINISHED ----');
		EXECUTE IMMEDIATE 'DROP FUNCTION ADM_PERSON.FNUGETORDERFINISHED';
	END IF;
  
	dbms_output.put_line('---- Fin Eliminacion funcion ----');
	
end;
/