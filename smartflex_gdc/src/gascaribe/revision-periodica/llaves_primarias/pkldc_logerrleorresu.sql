REM Fuente="Propiedad Intelectual de Gases del Caribe"
REM Script		 :		crpkldc_logerrleorresu.sql
REM Autor 		 :		Diana Saltarín - GdC, Luis Javier López - Horbath, Lubin Pineda - MVM
REM Fecha 		 :		08-02-2023
REM Descripcion	 :		Se crea la llave primaria de la tabla personalizaciones.LDC_LOGERRLEORRESU
REM Caso	     :		OSF-858
DECLARE

    sbUsuarioDestino    VARCHAR2(30) := 'PERSONALIZACIONES';
    sbTabla             VARCHAR2(30) := 'LDC_LOGERRLEORRESU';
    sbTablaDestino      VARCHAR2(100) := sbUsuarioDestino|| '.' || sbTabla;

    sbSentencia         VARCHAR2(32000);
    
    sbIndicePK          VARCHAR2(100) := 'PK_'||sbTabla || '_';
    
    CURSOR cuALL_INDEXES( isbUsuario VARCHAR2, isbIndice VARCHAR2, isbTabla VARCHAR2)
    IS
    SELECT *
    FROM all_indexes
    WHERE owner = isbUsuario
    AND index_name = isbIndice
    AND table_name = isbTabla;
    
    rcALL_INDEXES cuALL_INDEXES%ROWTYPE;

    CURSOR cuALL_CONSTRAINTS( isbUsuario VARCHAR2, isbConstraint VARCHAR2, isbTabla VARCHAR2)
    IS
    SELECT *
    FROM all_constraints
    WHERE owner = isbUsuario
    AND constraint_name = isbConstraint
    AND table_name = isbTabla;
    
    rcALL_CONSTRAINTS cuALL_CONSTRAINTS%ROWTYPE;
    
    PROCEDURE pExecImmediate( isbSentencia VARCHAR2)
    IS
    BEGIN
    
        EXECUTE IMMEDIATE isbSentencia;
    
        EXCEPTION WHEN OTHERS THEN
            dbms_output.put_line( 'Error pExecImmediate[' || isbSentencia || '][' || SQLERRM || ']');
            RAISE;
    END pExecImmediate;    

BEGIN

    OPEN cuALL_INDEXES( sbUsuarioDestino, sbIndicePK, sbTabla );
    FETCH cuALL_INDEXES INTO rcALL_INDEXES;
    CLOSE cuALL_INDEXES;

    IF rcALL_INDEXES.index_name IS NULL THEN
    
        sbSentencia := 'CREATE UNIQUE INDEX ' || sbUsuarioDestino || '.' || sbIndicePK || ' ON ' || sbTablaDestino ||
        '(ID)';

        pExecImmediate( sbSentencia );
        
    ELSE
        dbms_output.put_line( 'Ya existe el indice ' || sbUsuarioDestino || '.' || sbIndicePK || ' sobre la tabla ' || sbTablaDestino );
    END IF;


    OPEN cuALL_CONSTRAINTS( sbUsuarioDestino, sbIndicePK, sbTabla );
    FETCH cuALL_CONSTRAINTS INTO rcALL_CONSTRAINTS;
    CLOSE cuALL_CONSTRAINTS;

    IF rcALL_CONSTRAINTS.constraint_name IS NULL THEN
    
        sbSentencia := 'ALTER TABLE ' || sbTablaDestino || ' ADD ('||
          'CONSTRAINT ' || sbIndicePK || ' '||
          'PRIMARY KEY ' ||
          '(ID) ' ||
          'USING INDEX ' || sbUsuarioDestino || '.' || sbIndicePK || ' ' ||
          'ENABLE VALIDATE)';
      
        pExecImmediate( sbSentencia );
        
    ELSE
        dbms_output.put_line( 'Ya existe el constraint ' || sbUsuarioDestino || '.' || sbIndicePK || ' sobre la tabla ' || sbTablaDestino );    
    END IF;

END;
/
