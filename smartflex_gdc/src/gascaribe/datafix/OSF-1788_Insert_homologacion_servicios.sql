declare
 nuConta  NUMBER;
 
 CURSOR cuExiste(fsbObjeto VARCHAR2) IS
  SELECT COUNT(1)
  FROM HOMOLOGACION_SERVICIOS
  WHERE SERVICIO_ORIGEN = fsbObjeto; 
  
BEGIN

	dbms_output.put_line('---- Inicio Insert HOMOLOGACION_SERVICIOS ----');

	OPEN cuExiste('DAGE_SUBSCRIBER.FNUGETADDRESS_ID');
	FETCH cuExiste INTO nuConta; 
	CLOSE cuExiste; 
	
	IF nuConta = 0 THEN	
		Insert into HOMOLOGACION_SERVICIOS
		   (ESQUEMA_ORIGEN, SERVICIO_ORIGEN, DESCRIPCION_ORIGEN, ESQUEMA_DESTINO, SERVICIO_DESTINO, 
			DESCRIPCION_DESTINO)
		 Values
		   ('OPEN', 'DAGE_SUBSCRIBER.FNUGETADDRESS_ID', 'Retorna la dirección del cliente', 'ADM_PERSON', 'PKG_BCCLIENTE.FNUDIRECCION', 
			'Retorna la dirección del cliente');
		COMMIT;
	END IF;
	
	OPEN cuExiste('DAGE_SUBSCRIBER.FSBGETPHONE');
	FETCH cuExiste INTO nuConta; 
	CLOSE cuExiste; 
	
	IF nuConta = 0 THEN	
		Insert into HOMOLOGACION_SERVICIOS
		   (ESQUEMA_ORIGEN, SERVICIO_ORIGEN, DESCRIPCION_ORIGEN, ESQUEMA_DESTINO, SERVICIO_DESTINO, 
			DESCRIPCION_DESTINO)
		 Values
		   ('OPEN', 'DAGE_SUBSCRIBER.FSBGETPHONE', 'Retorna el telefono del cliente', 'ADM_PERSON', 'PKG_BCCLIENTE.FSBTELEFONO', 
			'Retorna el telefono del cliente');
		COMMIT;
	END IF;
	
	OPEN cuExiste('DAGE_SUBSCRIBER.FRCGETRECORD');
	FETCH cuExiste INTO nuConta; 
	CLOSE cuExiste; 
	
	IF nuConta = 0 THEN	
		Insert into HOMOLOGACION_SERVICIOS
		   (ESQUEMA_ORIGEN, SERVICIO_ORIGEN, DESCRIPCION_ORIGEN, ESQUEMA_DESTINO, SERVICIO_DESTINO, 
			DESCRIPCION_DESTINO)
		 Values
		   ('OPEN', 'DAGE_SUBSCRIBER.FRCGETRECORD', 'Retorna la información del cliente', 'ADM_PERSON', 'PKG_BCCLIENTE.FRCGETRECORD', 
			'Retorna la información del cliente');
		COMMIT;
	END IF;
	
	OPEN cuExiste('DAGE_SUBSCRIBER.FBLEXISTT');
	FETCH cuExiste INTO nuConta; 
	CLOSE cuExiste; 
	
	IF nuConta = 0 THEN	
		Insert into HOMOLOGACION_SERVICIOS
		   (ESQUEMA_ORIGEN, SERVICIO_ORIGEN, DESCRIPCION_ORIGEN, ESQUEMA_DESTINO, SERVICIO_DESTINO, 
			DESCRIPCION_DESTINO)
		 Values
		   ('OPEN', 'DAGE_SUBSCRIBER.FBLEXIST', 'Retorna true o false si el cliente existe', 'ADM_PERSON', 'PKG_BCCLIENTE.FBLEXISTCLIENTE', 
			'Retorna true o false si el cliente existe');
		COMMIT;
	END IF;
	
	OPEN cuExiste('GE_BOSUBSCRIBER.GETSUBSCRIBERID');
	FETCH cuExiste INTO nuConta; 
	CLOSE cuExiste; 
	
	IF nuConta = 0 THEN	
		Insert into HOMOLOGACION_SERVICIOS
		   (ESQUEMA_ORIGEN, SERVICIO_ORIGEN, DESCRIPCION_ORIGEN, ESQUEMA_DESTINO, SERVICIO_DESTINO, 
			DESCRIPCION_DESTINO)
		 Values
		   ('OPEN', 'GE_BOSUBSCRIBER.GETSUBSCRIBERID', 'Retorna el ID del cliente a partir del tipo y numero de identificacion del cliente', 'ADM_PERSON', 'PKG_BCCLIENTE.FNUCLIENTEID', 
			'Retorna el ID del cliente a partir del tipo y numero de identificacion del cliente');
		COMMIT;
	END IF;
	
	OPEN cuExiste('UT_STRING.FSBCONCAT');
	FETCH cuExiste INTO nuConta; 
	CLOSE cuExiste; 
	
	IF nuConta = 0 THEN	
		Insert into HOMOLOGACION_SERVICIOS
		   (ESQUEMA_ORIGEN, SERVICIO_ORIGEN, DESCRIPCION_ORIGEN, ESQUEMA_DESTINO, SERVICIO_DESTINO, 
			DESCRIPCION_DESTINO)
		 Values
		   ('OPEN', 'UT_STRING.FSBCONCAT', 'Retorna dos valores concatenados', 'PERSONALIZACIONES', 'LDC_BCCONSGENERALES.FSBCONCATENAR', 
			'Retorna dos valores concatenados');
		COMMIT;
	END IF;
  
	dbms_output.put_line('---- Fin Insert HOMOLOGACION_SERVICIOS ----');
	
end;
/