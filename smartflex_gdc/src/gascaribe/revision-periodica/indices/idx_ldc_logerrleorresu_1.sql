REM Fuente="Propiedad Intelectual de Gases del Caribe"
REM Script		 :		crpkldc_logerrleorresu.sql
REM Autor 		 :		Diana Saltarín - GdC, Luis Javier López - Horbath, Lubin Pineda - MVM
REM Fecha 		 :		08-02-2023
REM Descripcion	 :		Se crea la tabla personalizaciones.LDC_LOGERRLEORRESU
REM Caso	     :		OSF-858
DECLARE

    sbUsuarioDestino    VARCHAR2(30) := 'PERSONALIZACIONES';
    sbTabla             VARCHAR2(30) := 'LDC_LOGERRLEORRESU';
    sbTablaDestino      VARCHAR2(100) := sbUsuarioDestino|| '.' || sbTabla;

    sbSentencia         VARCHAR2(32000);
    
    sbIndice         VARCHAR2(100) := 'IDX_'||sbTabla || '_1';

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

    OPEN cuALL_INDEXES( sbUsuarioDestino, sbIndice, sbTabla );
    FETCH cuALL_INDEXES INTO rcALL_INDEXES;
    CLOSE cuALL_INDEXES;

    IF rcALL_INDEXES.index_name IS NULL THEN

        sbSentencia := 'CREATE INDEX ' || sbUsuarioDestino || '.' || sbIndice || ' ON ' || sbTablaDestino||
                        '(PROCESO, FECHGENE, ORDER_ID)';
                        
        pExecImmediate ( sbSentencia );
        
    ELSE
        dbms_output.put_line( 'Ya existe el indice ' || sbUsuarioDestino || '.' || sbIndice || ' sobre la tabla ' || sbTablaDestino );    
    END IF;

END;
/
