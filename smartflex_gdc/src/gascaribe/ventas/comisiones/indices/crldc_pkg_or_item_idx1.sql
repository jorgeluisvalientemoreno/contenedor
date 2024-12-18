REM Fuente="Propiedad Intelectual de Gases del Caribe"
REM Script		 :		crldc_pkg_or_item_idx1.sql
REM Autor 		 :		Lubin Pineda - MVM
REM Fecha 		 :		25-01-2023
REM Descripcion	 :		Crea el indice LDC_PKG_OR_ITEM_IDX1
REM Caso		 :		OSF-839
DECLARE

	sbTabla		VARCHAR2(30) := 'LDC_PKG_OR_ITEM';
	sbIndice	VARCHAR2(30) := 'LDC_PKG_OR_ITEM_IDX1';

	CURSOR cuUSER_INDEX
	IS
	SELECT index_name
	FROM user_indexes
	WHERE index_name = sbIndice
	AND table_name = sbTabla;
	
	rcIndice cuUSER_INDEX%ROWTYPE;
BEGIN

	OPEN cuUSER_INDEX;
	FETCH cuUSER_INDEX INTO rcIndice;
	CLOSE cuUSER_INDEX;

	IF rcIndice.index_name IS NULL THEN
		EXECUTE IMMEDIATE 'CREATE INDEX ' || sbIndice || ' ON ' || sbTabla || '( PACKAGE_ID, order_item_id)';
		dbms_output.put_line( 'Creado el indice [' || sbIndice || '] en la tabla [' || sbTabla || ']' );
	ELSE
		dbms_output.put_line( 'Ya existe el indice [' || sbIndice || '] en la tabla [' || sbTabla || ']' );
	END IF;
END;
/
