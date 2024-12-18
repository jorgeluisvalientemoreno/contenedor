REM Fuente="Propiedad Intelectual de Gases del Caribe"
REM Script		 :		idx_ldc_descapli_02.sql
REM Autor 		 :		Diana Patricia Montes - MVM.
REM Fecha 		 :		28-06-2023
REM Descripcion	 :		Se crea el índice idx_ldc_descapli_02
REM Caso	     :		OSF-1117

DECLARE

    sbTabla             VARCHAR2(30) := 'LDC_DESCAPLI';
        
    sbSentencia         VARCHAR2(32000);
    
    sbIndice            VARCHAR2(100) := 'idx_ldc_descapli_02';

    CURSOR cuALL_INDEXES( isbIndice VARCHAR2, isbTabla VARCHAR2)
    IS
    SELECT *
    FROM user_indexes
    WHERE 
     index_name = isbIndice
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

    OPEN cuALL_INDEXES( sbIndice, sbTabla );
    FETCH cuALL_INDEXES INTO rcALL_INDEXES;
    CLOSE cuALL_INDEXES;

    IF rcALL_INDEXES.index_name IS NULL THEN

        sbSentencia := 'CREATE INDEX ' || sbIndice || ' ON ' || sbTabla||
                        '(DIFERIDO)';
                        
        pExecImmediate ( sbSentencia );

        dbms_output.put_line( 'Se creó el índice ' || sbIndice || ' sobre la tabla ' || sbTabla );    

        
    ELSE
        dbms_output.put_line( 'Ya existe el índice ' || sbIndice || ' sobre la tabla ' || sbTabla );    
    END IF;

END;
/