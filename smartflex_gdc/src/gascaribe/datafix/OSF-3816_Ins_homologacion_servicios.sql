declare
 nuConta  NUMBER;
 
 CURSOR cuExiste(fsbObjeto VARCHAR2) IS
  SELECT COUNT(1)
  FROM HOMOLOGACION_SERVICIOS
  WHERE SERVICIO_ORIGEN = fsbObjeto; 
  
BEGIN

	dbms_output.put_line('---- Inicio Insert HOMOLOGACION_SERVICIOS OSF-2926 ----');

	OPEN cuExiste('PR_BOPRODUCT.FNUFIRSTPRODBYCONTRACT');  
	FETCH cuExiste INTO nuConta; 
	CLOSE cuExiste; 
	
	IF nuConta = 0 THEN	
		Insert into HOMOLOGACION_SERVICIOS
		   (ESQUEMA_ORIGEN, SERVICIO_ORIGEN, DESCRIPCION_ORIGEN, ESQUEMA_DESTINO, SERVICIO_DESTINO, 
			DESCRIPCION_DESTINO)
		 Values
		   ('OPEN', 'PR_BOPRODUCT.FNUFIRSTPRODBYCONTRACT', 'Obtiene el primer producto del contrato', 
		    'ADM_PERSON', 'PKG_BOGESTION_PRODUCTO.FNUOBTPRIMERPRODDECONTRATO', 'Obtiene el primer producto del contrato');
		COMMIT;
	END IF;
  
	dbms_output.put_line('---- Fin Insert HOMOLOGACION_SERVICIOS OSF-2926 ----');
	
end;
/