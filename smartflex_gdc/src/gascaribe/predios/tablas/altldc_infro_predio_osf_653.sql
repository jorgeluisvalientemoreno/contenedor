REM Fuente="Propiedad Intelectual de Gases del Caribe"
REM Script		 :		altldc_infro_predio_osf_653.sql
REM Autor 		 :		Lubin Pineda - MVM
REM Fecha 		 :		01-11-2022
REM Descripcion	 :		Agrega la columna ldc_info_predio.PNO
REM Jira		 :		OSF-653
DECLARE

	sbTabla		USER_TAB_COLUMNS.table_name%TYPE := 'LDC_INFO_PREDIO';
    sbColumna	USER_TAB_COLUMNS.column_name%TYPE:= 'PNO';

	CURSOR cuUSER_TAB_COLUMNS IS
	SELECT *
	FROM USER_TAB_COLUMNS
	WHERE table_name = sbTabla
	AND column_name = sbColumna;
	
	rcUSER_TAB_COLUMNS	cuUSER_TAB_COLUMNS%ROWTYPE;
	
BEGIN

	OPEN cuUSER_TAB_COLUMNS;
	FETCH cuUSER_TAB_COLUMNS INTO rcUSER_TAB_COLUMNS;
	CLOSE cuUSER_TAB_COLUMNS;
	
	IF rcUSER_TAB_COLUMNS.COLUMN_NAME IS NULL THEN

		EXECUTE IMMEDIATE 'ALTER TABLE ' || sbTabla || ' ADD ' || sbColumna || ' ' || 'VARCHAR2(1)';
	
		dbms_output.put_line( 'Se agrego la columna ' || user || '.' || sbTabla || '.' || sbColumna );
	
		EXECUTE IMMEDIATE 'COMMENT ON COLUMN ' || sbTabla || '.' || sbColumna || ' IS ' || '''' ||  'S: Indica que el predio esta marcado como PNO' || '''' ;
		
		dbms_output.put_line( 'Se creo el comentario para la columna ' || user || '.'  || sbTabla || '.' || sbColumna );
		
	ELSE
		
		dbms_output.put_line( 'Ya existe la columna ' || user || '.' || sbTabla || '.' || sbColumna );
		
	END IF;
END;
/

 
