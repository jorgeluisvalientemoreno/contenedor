REM Fuente="Propiedad Intelectual de Gases del Caribe"
REM Script		 :		pbmafa_total_hilos.sql
REM Autor 		 :		Lubin Pineda - MVM
REM Fecha 		 :	    15-06-2023
REM Descripcion	 :		Crea o actualiza el parametro PBMAFA_TOTAL_HILOS
REM Caso		 :		OSF-1194
REM 			 :      05-07-2023 : Se entrega el parámetro en la tabla personalizaciones.parametros

DECLARE

	sbCodigo 		personalizaciones.parametros.codigo%TYPE := 'PBMAFA_TOTAL_HILOS';
	
	CURSOR cuUsuarioTerminal
	IS
	SELECT 	SYS_CONTEXT('USERENV', 'TERMINAL') 		terminal, 
			SYS_CONTEXT('USERENV', 'CURRENT_USER')	usuario
	FROM DUAL;
	
	rcUsuarioTerminal		cuUsuarioTerminal%ROWTYPE;

	CURSOR cuParametros
	IS
		SELECT *
		FROM personalizaciones.parametros
		WHERE codigo = sbCodigo;

    rcParametroBD   personalizaciones.parametros%ROWTYPE;
	rcParametroOrig	personalizaciones.parametros%ROWTYPE;
	

	PROCEDURE prcParametros IS
	BEGIN
	
		rcParametroOrig.codigo 			:= sbCodigo;
		rcParametroOrig.descripcion 	:= 'CANTIDAD HILOS PROCESO PBMAFA';
		rcParametroOrig.valor_numerico 	:= 10;
		rcParametroOrig.valor_cadena 	:= NULL;
		rcParametroOrig.fecha_creacion 	:= sysdate;
		rcParametroOrig.usuario 		:= rcUsuarioTerminal.usuario;		
		rcParametroOrig.terminal		:= rcUsuarioTerminal.terminal;		
		
	END prcParametros;
		
BEGIN

	OPEN cuParametros;
	FETCH cuParametros INTO rcParametroBD;
	CLOSE cuParametros;
	
	OPEN cuUsuarioTerminal;
	FETCH cuUsuarioTerminal INTO rcUsuarioTerminal;
	CLOSE cuUsuarioTerminal;
	
	prcParametros;
   
    IF rcParametroBD.codigo IS NULL THEN
		
        dbms_output.put_line('Inicia creacion parametro PBMAFA_TOTAL_HILOS'); 
        INSERT INTO personalizaciones.parametros values rcParametroOrig;
		dbms_output.put_line('Termina creacion parametro PBMAFA_TOTAL_HILOS');
		
    ELSE
		dbms_output.put_line('Inicia actualizacion parametro PBMAFA_TOTAL_HILOS');    
        UPDATE personalizaciones.parametros
		SET
			descripcion 		= rcParametroOrig.descripcion,
			valor_numerico		= rcParametroOrig.valor_numerico,
			valor_cadena		= rcParametroOrig.valor_cadena,
			fecha_actualizacion = sysdate,
			usuario 			= rcUsuarioTerminal.usuario,
			terminal			= rcUsuarioTerminal.terminal			
		WHERE codigo = sbCodigo;
		
		dbms_output.put_line('Termina actualizacion parametro PBMAFA_TOTAL_HILOS');
    END IF;
    
    COMMIT;

    
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        dbms_output.put_line('Error creando en personaliacioens.parametros PBMAFA_TOTAL_HILOS|'|| SQLERRM );
END;
/
