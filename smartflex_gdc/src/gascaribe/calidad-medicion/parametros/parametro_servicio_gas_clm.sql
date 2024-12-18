
REM Fuente =   "Propiedad Intelectual de Gases del Caribe"
REM Script		 :		insert_parametro.sql
REM Autor 		 :		Jhon Soto
REM Fecha 		 :	    26-09-2023
REM Descripcion	 :		Crea o actualiza el parametro SERVICIO_GAS_CLM
REM Caso		 :		OSF-1609

DECLARE
    
    nuCodigoError 		NUMBER;
    sbMensajeError 		VARCHAR2(4000);
    nuParametro varchar2(100) := 'SERVICIO_GAS_CLM';
    nuContador  NUMBER;
    
BEGIN

    SELECT COUNT(1) INTO nuContador
    FROM PERSONALIZACIONES.PROCESO_NEGOCIO
    WHERE CODIGO = 7;

   IF nuContador = 0 THEN
      INSERT INTO PERSONALIZACIONES.PROCESO_NEGOCIO VALUES (7,'CALIDAD MEDICION');
   END IF;

    IF pkg_parametros.fnuGetValorNumerico(nuParametro) IS NULL THEN
       Insert into PERSONALIZACIONES.PARAMETROS (CODIGO,DESCRIPCION,VALOR_NUMERICO,VALOR_CADENA,VALOR_FECHA,PROCESO,FECHA_CREACION,FECHA_ACTUALIZACION,USUARIO,TERMINAL) 
       values ('SERVICIO_GAS_CLM','CODIGO DEL ID DEL SERVICIO DE GAS','7014',null,null,7,to_date('02/09/23','DD/MM/RR'),null,'OPEN',null);
    ELSE
		ut_trace.trace('Parametro SERVICIO_GAS_CLM ya existe',10); 
    END IF;
    
    COMMIT;

    
EXCEPTION
      WHEN OTHERS THEN
	Pkg_error.seterror;
	Pkg_error.geterror(nuCodigoError, sbMensajeError);
	dbms_output.put_line(sbMensajeError);
END;
/

