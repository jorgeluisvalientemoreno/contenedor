REM Fuente="Propiedad Intelectual de Gases del Caribe"
REM Script		 :		idx_ldc_comi_tarifa_nel_1.sql
REM Autor 		 :		Lubin Pineda - MVM
REM Fecha 		 :		13-02-2023
REM Descripcion	 :		Se crea el índice IDX_LDC_COMI_TARIFA_NEL_1
REM Caso	     :		OSF-858
DECLARE


    sbUsuario           VARCHAR2(30) := 'OPEN';
    sbTabla             VARCHAR2(30) := 'LDC_COMI_TARIFA_NEL';
        
    sbSentencia         VARCHAR2(32000);
    
    sbIndice            VARCHAR2(100) := 'IDX_LDC_COMI_TARIFA_NEL_1';

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
                        '(COMISION_PLAN_ID, FECHA_VIG_INICIAL, FECHA_VIG_FINAL)';
                        
        pExecImmediate ( sbSentencia );

        dbms_output.put_line( 'Se creó el índice ' || sbUsuario || '.' || sbIndice || ' sobre la tabla ' || sbTabla );    

        
    ELSE
        dbms_output.put_line( 'Ya existe el índice ' || sbUsuario || '.' || sbIndice || ' sobre la tabla ' || sbTabla );    
    END IF;

END;
/
