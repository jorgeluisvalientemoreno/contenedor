declare
 nuConta  NUMBER;
 
 CURSOR cuExiste(fsbObjeto VARCHAR2) IS
  SELECT COUNT(1)
  FROM HOMOLOGACION_SERVICIOS
  WHERE SERVICIO_ORIGEN = fsbObjeto; 
  
BEGIN

	dbms_output.put_line('---- Inicio Insert HOMOLOGACION_SERVICIOS ----');

	OPEN cuExiste('DAAB_ADDRESS.FRCGETRECORD');
	FETCH cuExiste INTO nuConta; 
	CLOSE cuExiste; 
	
	IF nuConta = 0 THEN	
		Insert into HOMOLOGACION_SERVICIOS
		   (ESQUEMA_ORIGEN, SERVICIO_ORIGEN, DESCRIPCION_ORIGEN, ESQUEMA_DESTINO, SERVICIO_DESTINO, 
			DESCRIPCION_DESTINO)
		 Values
		   ('OPEN', 'DAAB_ADDRESS.FRCGETRECORD', 'Obtiene el record de la dirección', 'ADM_PERSON', 'PKG_BCDIRECCIONES.FRCGETRECORD', 
			'Obtiene el record de la dirección');
		COMMIT;
	END IF;
	
	OPEN cuExiste('DAAB_ADDRESS.FNUGETSEGMENT_ID');
	FETCH cuExiste INTO nuConta; 
	CLOSE cuExiste; 
	
	IF nuConta = 0 THEN	
		Insert into HOMOLOGACION_SERVICIOS
		   (ESQUEMA_ORIGEN, SERVICIO_ORIGEN, DESCRIPCION_ORIGEN, ESQUEMA_DESTINO, SERVICIO_DESTINO, 
			DESCRIPCION_DESTINO)
		 Values
		   ('OPEN', 'DAAB_ADDRESS.FNUGETSEGMENT_ID', 'Obtiene el segmento de la dirección', 'ADM_PERSON', 'PKG_BCDIRECCIONES.FNUGETSEGMENTO_ID', 
			'Obtiene el segmento de la dirección');
		COMMIT;
	END IF;
	
	OPEN cuExiste('DAAB_ADDRESS.FSBGETIS_MAIN');
	FETCH cuExiste INTO nuConta; 
	CLOSE cuExiste; 
	
	IF nuConta = 0 THEN	
		Insert into HOMOLOGACION_SERVICIOS
		   (ESQUEMA_ORIGEN, SERVICIO_ORIGEN, DESCRIPCION_ORIGEN, ESQUEMA_DESTINO, SERVICIO_DESTINO, 
			DESCRIPCION_DESTINO)
		 Values
		   ('OPEN', 'DAAB_ADDRESS.FSBGETIS_MAIN', 'Obtiene si la dirección es principal', 'ADM_PERSON', 'PKG_BCDIRECCIONES.FSBGETISMAIN ', 
			'Obtiene si la dirección es principal');
		COMMIT;
	END IF;
  
	dbms_output.put_line('---- Fin Insert HOMOLOGACION_SERVICIOS ----');
	
end;
/