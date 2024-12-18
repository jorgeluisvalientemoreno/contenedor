REM Fuente="Propiedad Intelectual de Gases del Caribe"
REM Script		 :		crldc_aud_bloq_lega_sol.sql
REM Autor 		 :		Diana Saltar�n - GdC, Luis Javier L�pez - Horbath, Lubin Pineda - MVM
REM Fecha 		 :		08-02-2023
REM Descripcion	 :		Se crea la tabla personalizaciones.ldc_aud_bloq_lega_sol
REM Caso	     :		OSF-858
DECLARE
    
    sbUsuarioOrigen     VARCHAR2(30) := 'OPEN';
    sbUsuarioDestino    VARCHAR2(30) := 'PERSONALIZACIONES';
    sbTabla             VARCHAR2(30) := UPPER('ldc_aud_bloq_lega_sol');

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

        sbSentencia := 'CREATE TABLE ' || sbUsuarioDestino || '.' || sbTabla || ' AS ' ||     
        'SELECT * FROM ' || sbUsuarioOrigen || '.' || sbTabla;
        
        pExecImmediate( sbSentencia );

        dbms_output.put_line('Se cre� la tabla ' || sbUsuarioDestino || '.' || sbTabla );
      
        sbSentencia := 'COMMENT ON TABLE ' || sbUsuarioDestino || '.' || sbTabla || ' IS ' || '''' || 'AUDITORIA DE BLOQUEO PARA ASIGNACION ASIGNACION DE ORDENES' || '''';

        pExecImmediate( sbSentencia );

        sbSentencia := 'COMMENT ON COLUMN ' || sbUsuarioDestino || '.' || sbTabla ||'.PACKAGE_ID IS '|| '''' || 'SOLICITUD' || '''';

        pExecImmediate( sbSentencia );
        
        sbSentencia := 'COMMENT ON COLUMN ' || sbUsuarioDestino || '.' || sbTabla ||'.ORDER_ID IS '|| '''' || 'ORDEN' || '''';

        pExecImmediate( sbSentencia );
        
        sbSentencia := 'COMMENT ON COLUMN ' || sbUsuarioDestino || '.' || sbTabla ||'.USUARIO IS '|| ''''|| 'USUARIO'|| '''';

        pExecImmediate( sbSentencia );
        
        sbSentencia := 'COMMENT ON COLUMN ' || sbUsuarioDestino || '.' || sbTabla ||'.FECHA IS '|| '''' || 'FECHA'|| '''';
        
        pExecImmediate( sbSentencia );
                
        sbSentencia := 'COMMENT ON COLUMN ' || sbUsuarioDestino || '.' || sbTabla ||'.MAQUINA IS ' || '''' || 'MAQUINA' || '''';
        
        pExecImmediate( sbSentencia );        

        dbms_output.put_line('Se crearon comentarios la tabla ' || sbUsuarioDestino || '.' || sbTabla );
                       
    ELSE
            
        dbms_output.put_line('Ya existe la tabla ' || sbUsuarioDestino || '.' || sbTabla );
               
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