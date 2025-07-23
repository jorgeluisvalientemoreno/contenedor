declare
 nuConta  NUMBER;
 
 CURSOR cuExiste(fsbObjeto VARCHAR2) IS
  SELECT COUNT(1)
  FROM HOMOLOGACION_SERVICIOS
  WHERE SERVICIO_ORIGEN = fsbObjeto; 
  
BEGIN

	dbms_output.put_line('---- Inicio Insert HOMOLOGACION_SERVICIOS OSF-2926 ----');

	OPEN cuExiste('GC_BODEBTMANAGEMENT.FNUGETPUNIDEBTBYPROD'); 
	FETCH cuExiste INTO nuConta; 
	CLOSE cuExiste; 
	
	IF nuConta = 0 THEN	
		Insert into HOMOLOGACION_SERVICIOS
		   (ESQUEMA_ORIGEN, SERVICIO_ORIGEN, DESCRIPCION_ORIGEN, ESQUEMA_DESTINO, SERVICIO_DESTINO, 
			DESCRIPCION_DESTINO)
		 Values
		   ('OPEN', 'GC_BODEBTMANAGEMENT.FNUGETPUNIDEBTBYPROD', 'Obtiene el valor del saldo castigado del producto', 
		    'ADM_PERSON', 'PKG_BOGESTION_FINANCIACION.FNUOBTVALORSALDOCASTIGADO', 'Obtiene el valor del saldo castigado del producto');
		COMMIT;
	END IF;
																   
	OPEN cuExiste('PKHOLIDAYMGR.FNUGETNUMOFDAYNONHOLIDAY'); 
	FETCH cuExiste INTO nuConta; 
	CLOSE cuExiste; 
	
	IF nuConta = 0 THEN	
		Insert into HOMOLOGACION_SERVICIOS
		   (ESQUEMA_ORIGEN, SERVICIO_ORIGEN, DESCRIPCION_ORIGEN, ESQUEMA_DESTINO, SERVICIO_DESTINO, 
			DESCRIPCION_DESTINO)
		 Values
		   ('OPEN', 'PKHOLIDAYMGR.FNUGETNUMOFDAYNONHOLIDAY', 'Obtiene los días habiles en un rango de fechas', 
		    'ADM_PERSON', 'PKG_BOCALENDARIO.FNUOBTDIASNOFESTIVOS', 'Obtiene los días habiles en un rango de fechas');
		COMMIT;
	END IF;
	
	OPEN cuExiste('PKTBLPARAMETR.FNUGETVALUENUMBER'); 
	FETCH cuExiste INTO nuConta; 
	CLOSE cuExiste; 
  
	dbms_output.put_line('---- Fin Insert HOMOLOGACION_SERVICIOS OSF-2926 ----');
	
end;
/