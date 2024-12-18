REM Fuente="Propiedad Intelectual de Gases del Caribe"
REM Script		 :		idx_ldc_log_proceso_vmp_01.sql
REM Autor 		 :		Lubin Pineda - MVM
REM Fecha 		 :		26-05-2023
REM Descripcion	 :		Se crea el índice IDX_LDC_LOG_PROCESO_VMP_01
REM Caso	     :		OSF-1085
DECLARE


    sbUsuario           VARCHAR2(30) := 'OPEN';
    sbTabla             VARCHAR2(30) := 'LDC_LOG_PROCESO_VMP';
        
    sbSentencia         VARCHAR2(32000);
    
    sbIndice            VARCHAR2(100) := 'IDX_LDC_LOG_PROCESO_VMP_01';

    CURSOR cuALL_INDEXES( isbUsuario VARCHAR2, isbIndice VARCHAR2, isbTabla VARCHAR2)
    IS
    SELECT *
    FROM all_indexes
    WHERE owner = isbUsuario
    AND index_name = isbIndice
    AND table_name = isbTabla;
    
    rcALL_INDEXES cuALL_INDEXES%ROWTYPE;    
    
    PROCEDURE pExecImmediate( isbSentencia VARCHAR2)
    IS
    BEGIN
    
        EXECUTE IMMEDIATE isbSentencia;
    
        EXCEPTION WHEN OTHERS THEN
            dbms_output.put_line( 'Error pExecImmediate[' || isbSentencia || '][' || SQLERRM || ']');
            RAISE;
    END pExecImmediate;    

BEGIN

    OPEN cuALL_INDEXES( sbUsuario, sbIndice, sbTabla );
    FETCH cuALL_INDEXES INTO rcALL_INDEXES;
    CLOSE cuALL_INDEXES;

    IF rcALL_INDEXES.index_name IS NULL THEN

        sbSentencia := 'CREATE INDEX ' || sbUsuario || '.' || sbIndice || ' ON ' || sbTabla||
                        '(PRODUCTO, PROCESO, FECHA_REGISTRO)';
                        
        pExecImmediate ( sbSentencia );

        dbms_output.put_line( 'Se creó el índice ' || sbUsuario || '.' || sbIndice || ' sobre la tabla ' || sbTabla );    

        
    ELSE
        dbms_output.put_line( 'Ya existe el Ã­ndice ' || sbUsuario || '.' || sbIndice || ' sobre la tabla ' || sbTabla );    
    END IF;

END;
/
