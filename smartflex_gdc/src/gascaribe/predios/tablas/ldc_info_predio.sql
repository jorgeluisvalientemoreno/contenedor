DECLARE

	sbTabla		USER_TAB_COLUMNS.table_name%TYPE := 'LDC_INFO_PREDIO';
    sbColumna	USER_TAB_COLUMNS.column_name%TYPE:= 'PREDIO_CASTIGADO';

	CURSOR cuALL_TAB_COLUMNS IS
	SELECT *
	FROM ALL_TAB_COLUMNS
	WHERE table_name = sbTabla
	AND column_name = sbColumna;
	
	rcALL_TAB_COLUMNS	cuALL_TAB_COLUMNS%ROWTYPE;
	
BEGIN

	OPEN cuALL_TAB_COLUMNS;
	FETCH cuALL_TAB_COLUMNS INTO rcALL_TAB_COLUMNS;
	CLOSE cuALL_TAB_COLUMNS;
	
	IF rcALL_TAB_COLUMNS.COLUMN_NAME IS NULL THEN

		EXECUTE IMMEDIATE 'ALTER TABLE ' || sbTabla || ' ADD ' || sbColumna || ' ' || 'VARCHAR2(1) DEFAULT '||''''||'N'||'''';
	
		dbms_output.put_line( 'Se agrego la columna ' || user || '.' || sbTabla || '.' || sbColumna );
	
		EXECUTE IMMEDIATE 'COMMENT ON COLUMN ' || sbTabla || '.' || sbColumna || ' IS ' || '''' ||  'S: Indica que el predio esta castigado' || '''' ;
		
		dbms_output.put_line( 'Se creo el comentario para la columna ' || user || '.'  || sbTabla || '.' || sbColumna );
		
	ELSE
		
		dbms_output.put_line( 'Ya existe la columna ' || user || '.' || sbTabla || '.' || sbColumna );
		
	END IF;
END;
/

 
