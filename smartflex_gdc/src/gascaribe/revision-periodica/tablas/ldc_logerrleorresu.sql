REM Fuente="Propiedad Intelectual de Gases del Caribe"
REM Script		 :		crldc_logerrleorresa.sql
REM Autor 		 :		Diana Saltarín - GdC, Luis Javier López - Horbath, Lubin Pineda - MVM
REM Fecha 		 :		08-02-2023
REM Descripcion	 :		Se crea la tabla personalizaciones.LDC_LOGERRLEORRESU
REM Caso	     :		OSF-858
REM Historia Modificaciones
REM AUTOR			FECHA		DESCRIPCION
REM jpinedc - MVM 	28/02/2023	Se crea OSF-858 - la tabla con los registros creados desde hace 2 dias sin 
REM								importar el proceso
DECLARE
    
    sbUsuarioOrigen     VARCHAR2(30) := 'OPEN';
    sbUsuarioDestino    VARCHAR2(30) := 'PERSONALIZACIONES';
    sbTabla             VARCHAR2(30) := 'LDC_LOGERRLEORRESU';
    sbTablaOrigen       VARCHAR2(100) := sbUsuarioOrigen || '.' || sbTabla;
    sbTablaDestino      VARCHAR2(100) := sbUsuarioDestino|| '.' || sbTabla;

    CURSOR cuTabla ( isbUsuario VARCHAR2, isbTabla VARCHAR2 )
    IS
    SELECT table_name, num_rows
    FROM ALL_TABLES 
    WHERE owner = isbUsuario
    AND table_name = isbTabla;

    rcTablaOrigen   cuTabla%ROWTYPE;
        
    rcTablaDestino cuTabla%ROWTYPE;
    
    sbSentencia     VARCHAR2(32000);
    
    PROCEDURE pExecImmediate( isbSentencia VARCHAR2)
    IS
    BEGIN
    
        EXECUTE IMMEDIATE isbSentencia;
    
        EXCEPTION WHEN OTHERS THEN
            dbms_output.put_line( 'Error pExecImmediate[' || isbSentencia || '][' || SQLERRM || ']');
            RAISE;
    END pExecImmediate;

BEGIN

    OPEN cuTabla( sbUsuarioOrigen, sbTabla );
    FETCH cuTabla INTO rcTablaOrigen;
    CLOSE cuTabla;
    
    dbms_output.put_line( 'Antes: ' || sbUsuarioOrigen|| '.' || sbTabla || '|' || rcTablaOrigen.num_rows );

    OPEN cuTabla( sbUsuarioDestino, sbTabla );
    FETCH cuTabla INTO rcTablaDestino;
    CLOSE cuTabla;

    dbms_output.put_line( 'Antes: ' || sbUsuarioDestino|| '.' || sbTabla || '|' || rcTablaDestino.num_rows );
            
    IF rcTablaDestino.table_name IS NULL THEN
    
        sbSentencia := 'CREATE TABLE ' || sbTablaDestino || ' AS ' ||
        'SELECT * FROM ' || sbTablaOrigen || ' ' ||
        'WHERE fechgene >= TRUNC(SYSDATE)-2';

        pExecImmediate(sbSentencia);

        dbms_output.put_line('Se creó la tabla ' || sbUsuarioDestino || '.' || sbTabla );

        sbSentencia := 'COMMENT ON TABLE ' || sbTablaDestino || ' IS ' || '''' || 'LOG DE ERROR DE LEGALIZACION DE ORDENES DE RECO Y SUSP ADMIN' || '''';

        pExecImmediate(sbSentencia);
        
        sbSentencia := 'COMMENT ON COLUMN ' || sbTablaDestino || '.ORDER_ID IS ' || '''' || 'NUMERO DE ORDEN' || '''';

        pExecImmediate(sbSentencia);
        
        sbSentencia := 'COMMENT ON COLUMN ' || sbTablaDestino || '.ORDEPADRE IS ' || '''' || 'NUMERO DE ORDEN PADRE' || '''';

        pExecImmediate(sbSentencia);
        
        sbSentencia := 'COMMENT ON COLUMN ' || sbTablaDestino || '.PROCESO IS ' || '''' ||'PROCESO'|| '''';
        
        pExecImmediate(sbSentencia);
        
        sbSentencia := 'COMMENT ON COLUMN ' || sbTablaDestino || '.MENSERROR IS ' || '''' || 'ERROR GENERADO' || '''';

        pExecImmediate(sbSentencia);
        
        sbSentencia := 'COMMENT ON COLUMN ' || sbTablaDestino || '.FECHGENE IS ' || '''' ||'FECHA DE GENERACION' || '''';

        pExecImmediate(sbSentencia);
        
        sbSentencia := 'COMMENT ON COLUMN ' || sbTablaDestino || '.USUARIO IS ' || '''' || 'USUARIO' || '''';

        pExecImmediate(sbSentencia);
        
        sbSentencia := 'COMMENT ON COLUMN ' || sbTablaDestino || '.ID IS '|| '''' || 'ID' || '''';
        
        pExecImmediate(sbSentencia);
        
        dbms_output.put_line('Se crearon comentarios la tabla ' || sbUsuarioDestino || '.' || sbTabla );
        
    END IF;
    
    rcTablaDestino := NULL;
    
    OPEN cuTabla( sbUsuarioDestino, sbTabla );
    FETCH cuTabla INTO rcTablaDestino;
    CLOSE cuTabla;    
    
    IF rcTablaDestino.table_name IS NOT NULL THEN
    
        IF rcTablaOrigen.table_name IS NOT NULL THEN
        
            sbSentencia := 'DROP TABLE ' || sbUsuarioOrigen || '.' || sbTabla;

            pExecImmediate(sbSentencia);
            
            dbms_output.put_line('Se hizo drop a la tabla ' || sbUsuarioOrigen || '.' || sbTabla );        

        ELSE

            dbms_output.put_line('NO Se hizo drop a la tabla ' || sbUsuarioOrigen || '.' || sbTabla || ' porque no existe' );            
            
        END IF;
    
    ELSE

        dbms_output.put_line('NO Se hizo drop a la tabla ' || sbUsuarioOrigen || '.' || sbTabla || ' porque no existe la tabla destino' );            

    END IF;
    
END;
/

