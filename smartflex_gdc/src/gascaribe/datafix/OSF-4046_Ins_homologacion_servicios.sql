declare
 nuConta  NUMBER;
 
 CURSOR cuExiste(fsbObjeto VARCHAR2) IS
  SELECT COUNT(1)
  FROM HOMOLOGACION_SERVICIOS
  WHERE SERVICIO_ORIGEN = fsbObjeto; 
  
BEGIN

	dbms_output.put_line('---- Inicio Insert HOMOLOGACION_SERVICIOS OSF-4046 ----');

	OPEN cuExiste('PR_BOCNFCOMPONENT.FNUGETCOMPONENTIDBYPRODUCT');  
	FETCH cuExiste INTO nuConta; 
	CLOSE cuExiste; 
	
	IF nuConta = 0 THEN	
		Insert into HOMOLOGACION_SERVICIOS
		   (ESQUEMA_ORIGEN, SERVICIO_ORIGEN, DESCRIPCION_ORIGEN, ESQUEMA_DESTINO, SERVICIO_DESTINO, 
			DESCRIPCION_DESTINO)
		 Values
		   ('OPEN', 'PR_BOCNFCOMPONENT.FNUGETCOMPONENTIDBYPRODUCT', 'Obtiene el componente del producto', 
		    'ADM_PERSON', 'PKG_BOGESTION_COMPONENTE.FNUOBTCOMPONENTEXTIPOYPROD', 'Obtiene el componente del producto');
		COMMIT;
	END IF;
	
	OPEN cuExiste('PR_BCPRODUCT.FNUGETMAINCOMPONENTID');  
	FETCH cuExiste INTO nuConta; 
	CLOSE cuExiste; 
	
	IF nuConta = 0 THEN	
		Insert into HOMOLOGACION_SERVICIOS
		   (ESQUEMA_ORIGEN, SERVICIO_ORIGEN, DESCRIPCION_ORIGEN, ESQUEMA_DESTINO, SERVICIO_DESTINO, 
			DESCRIPCION_DESTINO)
		 Values
		   ('OPEN', 'PR_BCPRODUCT.FNUGETMAINCOMPONENTID', 'Obtiene el componente principal del producto', 
		    'ADM_PERSON', 'PKG_BCGESTION_PRODUCTO.FNUOBTCOMPONENTEPRINCIPAL', 'Obtiene el componente principal del producto');
		COMMIT;
	END IF;
	
	OPEN cuExiste('PR_BOCOMPONENT.GETCOMPONENTTYPE');  
	FETCH cuExiste INTO nuConta; 
	CLOSE cuExiste; 
	
	IF nuConta = 0 THEN	
		Insert into HOMOLOGACION_SERVICIOS
		   (ESQUEMA_ORIGEN, SERVICIO_ORIGEN, DESCRIPCION_ORIGEN, ESQUEMA_DESTINO, SERVICIO_DESTINO, 
			DESCRIPCION_DESTINO)
		 Values
		   ('OPEN', 'PR_BOCOMPONENT.GETCOMPONENTTYPE', 'Obtiene el tipo de componente', 
		    'ADM_PERSON', 'PKG_BOGESTION_COMPONENTE.FNUOBTTIPOCOMPONENTE', 'Obtiene el tipo de componente'); 
		COMMIT; 
	END IF;
  
	dbms_output.put_line('---- Fin Insert HOMOLOGACION_SERVICIOS OSF-4046 ----');
	
end;
/