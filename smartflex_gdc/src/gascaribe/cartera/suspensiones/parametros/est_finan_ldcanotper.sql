REM Fuente="Propiedad Intelectual de Gases del Caribe"
REM Script		 :		EST_FINAN_LDCANOTPER.sql
REM Autor 		 :		German Guevara - GlobalMVM
REM Fecha 		 :	    08-02-2024
REM Descripcion	 :		Crea o actualiza el parametro EST_FINAN_LDCANOTPER
REM Caso		 :		OSF-2310
REM 			 :      08-02-2024 : Se entrega el parámetro en la tabla personalizaciones.parametros

DECLARE

	sbCodigo 		parametros.codigo%TYPE := 'EST_FINAN_LDCANOTPER';
	
	CURSOR cuUsuarioTerminal
	IS
	SELECT 	SYS_CONTEXT('USERENV', 'TERMINAL') 		terminal, 
			SYS_CONTEXT('USERENV', 'CURRENT_USER')	usuario
	FROM DUAL;
	
	rcUsuarioTerminal		cuUsuarioTerminal%ROWTYPE;

	CURSOR cuParametros
	IS
		SELECT *
		FROM parametros
		WHERE codigo = sbCodigo;

    rcParametroBD   parametros%ROWTYPE;
	rcParametroOrig	parametros%ROWTYPE;
	

	PROCEDURE prcParametros IS
	BEGIN
	
		rcParametroOrig.codigo 			:= sbCodigo;
		rcParametroOrig.descripcion 	:= 'ESTADOS FINANCIEROS PERMITIDOS PARA ANULAR ORDENES DE PERSECUCION - LDCANOTPER. OSF-2310';
		rcParametroOrig.valor_numerico 	:= NULL;
		rcParametroOrig.valor_cadena 	:= 'A,D';
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
		
        dbms_output.put_line('Inicia creacion parametro EST_FINAN_LDCANOTPER'); 
        INSERT INTO parametros values rcParametroOrig;
		dbms_output.put_line('Termina creacion parametro EST_FINAN_LDCANOTPER');
		
    ELSE
		dbms_output.put_line('Inicia actualizacion parametro EST_FINAN_LDCANOTPER');    
        UPDATE parametros
		SET
			descripcion 		= rcParametroOrig.descripcion,
			valor_numerico		= rcParametroOrig.valor_numerico,
			valor_cadena		= rcParametroOrig.valor_cadena,
			fecha_actualizacion = sysdate,
			usuario 			= rcUsuarioTerminal.usuario,
			terminal			= rcUsuarioTerminal.terminal			
		WHERE codigo = sbCodigo;
		
		dbms_output.put_line('Termina actualizacion parametro EST_FINAN_LDCANOTPER');
    END IF;
    
    COMMIT;

    
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        dbms_output.put_line('Error creando en personaliacioens.parametros EST_FINAN_LDCANOTPER|'|| SQLERRM );
END;
/