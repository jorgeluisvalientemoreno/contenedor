REM Fuente="Propiedad Intelectual de Gases del Caribe"
REM Script		 :		crpkldc_logerrleorresu.sql
REM Autor 		 :		Diana Saltarín - GdC, Luis Javier López - Horbath, Lubin Pineda - MVM
REM Fecha 		 :		08-02-2023
REM Descripcion	 :		Se crea la tabla personalizaciones.LDC_LOGERRLEORRESU
REM Caso	     :		OSF-858
DECLARE

    sbUsuarioOrigen     VARCHAR2(30) := 'OPEN';
    sbUsuarioDestino    VARCHAR2(30) := 'PERSONALIZACIONES';
    sbTabla             VARCHAR2(30) := 'LDC_LOGERRLEORRESU';

    sbSentencia         VARCHAR2(32000);

    sbSecuencia         VARCHAR2(100) := 'SEQ_'||sbTabla;    
    sbSecuenciaOrigen   VARCHAR2(100) := sbUsuarioOrigen || '.' || sbSecuencia;
    sbSecuenciaDestino  VARCHAR2(100) := sbUsuarioDestino|| '.' || sbSecuencia;

    CURSOR cuSECUENCIA( isbUsuario VARCHAR2, isbSecuencia VARCHAR2)
    IS
    SELECT *
    FROM all_sequences
    WHERE sequence_owner = isbUsuario
    AND sequence_name = isbSecuencia;

    rcSecuenciaOrigen cuSECUENCIA%ROWTYPE;    
        
    rcSecuenciaDestino cuSECUENCIA%ROWTYPE;    
    
    PROCEDURE pExecImmediate( isbSentencia VARCHAR2)
    IS
    BEGIN
    
        EXECUTE IMMEDIATE isbSentencia;
    
        EXCEPTION WHEN OTHERS THEN
            dbms_output.put_line( 'Error pExecImmediate[' || isbSentencia || '][' || SQLERRM || ']');
            RAISE;
    END pExecImmediate;    

BEGIN

    OPEN cuSECUENCIA( sbUsuarioOrigen, sbSecuencia );
    FETCH cuSECUENCIA INTO rcSecuenciaOrigen;
    CLOSE cuSECUENCIA;

    OPEN cuSECUENCIA( sbUsuarioDestino, sbSecuencia );
    FETCH cuSECUENCIA INTO rcSecuenciaDestino;
    CLOSE cuSECUENCIA;

    IF rcSecuenciaDestino.sequence_name IS NULL THEN

        sbSentencia := 'CREATE SEQUENCE ' || sbSecuenciaDestino || chr(13) ||
        'START WITH ' || (rcSecuenciaOrigen.last_number + 1) ||chr(13) ||
        'MAXVALUE 9999999999999999999999999999 '|| chr(13) ||
        'MINVALUE 1'|| chr(13) ||
        'NOCYCLE'|| chr(13) ||
        'NOCACHE'|| chr(13) ||
        'NOORDER';
        
        pExecImmediate(sbSentencia);

        dbms_output.put_line( 'Se creó la secuencia ' || sbUsuarioDestino || '.' || sbSecuencia );                
  
    ELSE
        dbms_output.put_line( 'Ya existe la secuencia ' || sbUsuarioDestino || '.' || sbSecuencia );        
    END IF;
    
    IF rcSecuenciaOrigen.sequence_name IS NOT NULL THEN
    
        sbSentencia := 'DROP SEQUENCE ' || sbSecuenciaOrigen;
        
        pExecImmediate(sbSentencia);
        
        dbms_output.put_line( 'Se hizo drop a la secuencia ' || sbSecuenciaOrigen );            
                    
    ELSE
    
        dbms_output.put_line( 'NO se hace drop a la secuencia ' || sbSecuenciaOrigen || ' porque no existe' );            
    
    END IF;
    
END;
/