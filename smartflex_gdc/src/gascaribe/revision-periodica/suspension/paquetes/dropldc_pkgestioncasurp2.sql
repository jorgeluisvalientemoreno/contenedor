REM Fuente="Propiedad Intelectual de Gases del Caribe"
REM Script		 :		crldc_logerrleorresa.sql
REM Autor 		 :		Diana Saltarín - GdC, Luis Javier López - Horbath, Lubin Pineda - MVM
REM Fecha 		 :		23-02-2023
REM Descripcion	 :		Se borrar el paquete OPEN.ldc_pkgestioncasurp2 por obsoleto
REM Caso	     :		OSF-858
DECLARE
    
    sbUsuarioOrigen     VARCHAR2(30) := 'OPEN';
    sbPaquete           VARCHAR2(30) := upper( 'ldc_pkgestioncasurp2' );
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
    
        sbSentencia := 'DROP PACKAGE ' || sbPaqueteOrigen;

        pExecImmediate(sbSentencia);
        
        dbms_output.put_line('Se hizo drop a la paquete ' || sbPaqueteOrigen );        

    ELSE

        dbms_output.put_line('NO Se hizo drop a la paquete ' || sbPaqueteOrigen || ' porque no existe' );            
        
    END IF;
    
END;
/

