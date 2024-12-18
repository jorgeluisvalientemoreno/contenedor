declare
 nuConta  NUMBER;
 
 CURSOR cuExiste(fsbObjeto VARCHAR2) IS
  SELECT COUNT(1)
  FROM HOMOLOGACION_SERVICIOS
  WHERE SERVICIO_ORIGEN = upper(fsbObjeto); 
  
BEGIN

	dbms_output.put_line('---- Inicio Insert HOMOLOGACION_SERVICIOS ----');

	OPEN cuExiste('ps_bopacktypeparam.fsbgetpacktypeparam');
	FETCH cuExiste INTO nuConta; 
	CLOSE cuExiste; 
	
	IF nuConta = 0 THEN	
		Insert into HOMOLOGACION_SERVICIOS
		   (ESQUEMA_ORIGEN, SERVICIO_ORIGEN, DESCRIPCION_ORIGEN, ESQUEMA_DESTINO, SERVICIO_DESTINO, 
			DESCRIPCION_DESTINO)
		 Values
		   ('OPEN', upper('ps_bopacktypeparam.fsbgetpacktypeparam'), 'Obtiene el parametro por tipo de solicitud', 
           'ADM_PERSON', upper('pkg_botiposolicitud.fsbObtParametroTipoSolicitud'), 
			'Obtiene el parametro por tipo de solicitud');
		COMMIT;
	END IF;
  
	dbms_output.put_line('---- Fin Insert HOMOLOGACION_SERVICIOS ----');
	
end;
/