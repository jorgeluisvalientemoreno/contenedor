set serveroutput on;
REM Fuente="Propiedad Intelectual de Gases del Caribe" 
REM Autor 		 :		Adriana Vargas MVM
REM Fecha 		 :		18-12-2023
REM Descripcion	 :		Se borra el procedimiento open.LDC_PROCLIQUIDAPORCFIJO
REM Caso	     :		OSF-1893
DECLARE
    
    sbUsuarioOrigen     VARCHAR2(30) := 'OPEN';
    sbPaquete           VARCHAR2(30) := upper( 'LDC_PROCLIQUIDAPORCFIJO' );
    sbPaqueteOrigen     VARCHAR2(100) := sbUsuarioOrigen || '.' || sbPaquete;
    CURSOR cuObjeto ( isbUsuario VARCHAR2, isbPaquete VARCHAR2 )
    IS
    SELECT object_name
    FROM ALL_OBJECTS 
    WHERE owner = isbUsuario
    AND object_name = isbPaquete;
    rcObjetoOrigen   cuObjeto%ROWTYPE;
            
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
    OPEN cuObjeto( sbUsuarioOrigen, sbPaquete );
    FETCH cuObjeto INTO rcObjetoOrigen;
    CLOSE cuObjeto;
                   
    IF rcObjetoOrigen.object_name IS NOT NULL THEN    
        sbSentencia := 'DROP PROCEDURE ' || sbPaqueteOrigen;
        pExecImmediate(sbSentencia);        
        dbms_output.put_line('Se hizo drop al procedure ' || sbPaqueteOrigen );        
    ELSE
        dbms_output.put_line('NO Se hizo drop al procedure ' || sbPaqueteOrigen || ' porque no existe' );        
    END IF;    
END;
/