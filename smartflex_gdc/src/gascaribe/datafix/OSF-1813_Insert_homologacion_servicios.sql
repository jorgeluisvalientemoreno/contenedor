declare
 nuConta  NUMBER;
 
 CURSOR cuExiste(fsbObjeto VARCHAR2) IS
  SELECT COUNT(1)
  FROM HOMOLOGACION_SERVICIOS
  WHERE SERVICIO_ORIGEN = fsbObjeto; 
  
BEGIN

	dbms_output.put_line('---- Inicio Insert HOMOLOGACION_SERVICIOS ----');

	OPEN cuExiste('FA_BOACCOUNTSTATUSTODATE.PRODUCTBALANCEACCOUNTSTODATE');
	FETCH cuExiste INTO nuConta; 
	CLOSE cuExiste; 
	
	IF nuConta = 0 THEN	
		Insert into HOMOLOGACION_SERVICIOS
		   (ESQUEMA_ORIGEN, SERVICIO_ORIGEN, DESCRIPCION_ORIGEN, ESQUEMA_DESTINO, SERVICIO_DESTINO, 
			DESCRIPCION_DESTINO)
		 Values
		   ('OPEN', 'FA_BOACCOUNTSTATUSTODATE.PRODUCTBALANCEACCOUNTSTODATE', 'Genera estados de cuenta de un producto por fecha.', 'ADM_PERSON', 'API_GENERAESTADOCUENTAXFECHA', 
			'Api para generar estados de cuenta de un producto por fecha');
		COMMIT;
	END IF;
	
	OPEN cuExiste('OBTENERVALORINSTANCIA');
	FETCH cuExiste INTO nuConta; 
	CLOSE cuExiste; 
	
	IF nuConta = 0 THEN	
		Insert into HOMOLOGACION_SERVICIOS
		   (ESQUEMA_ORIGEN, SERVICIO_ORIGEN, DESCRIPCION_ORIGEN, ESQUEMA_DESTINO, SERVICIO_DESTINO, 
			DESCRIPCION_DESTINO)
		 Values
		   ('OPEN', 'OBTENERVALORINSTANCIA', 'Obtiene el valor de la instancia', 'ADM_PERSON', 'API_OBTENERVALORINSTANCIA', 
			'Api para obtener el valor de la instancia');
		COMMIT;
	END IF;
  
	dbms_output.put_line('---- Fin Insert HOMOLOGACION_SERVICIOS ----');
	
end;
/