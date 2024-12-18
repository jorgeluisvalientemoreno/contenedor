/**********************************************************************
    Propiedad intelectual de Centro de servicios Compartidos
    Nombre          LDC_PKVALIDAINCIDENTESIC
    Autor           Oscar Adrian Parra
    Fecha           28/10/2016

    Descripción     Paquete validaciones Incidnete Imagen Colombia

    Historia de Modificaciones
    Fecha              Autor             Modificación
   =========         ==========        ===============
   30/10/2023         epenao           OSF-1758:
                                       Se borra el objeto ya que no está siendo 
                                       utilizando por las funcionalidades existentes 
                                       o las integraciones.   
   28/10/2016         oparra           200-500: Creacion
***********************************************************************/

DECLARE
    
    sbUsuarioOrigen     VARCHAR2(30) := 'OPEN';
    sbPaquete           VARCHAR2(30) := upper( 'LDC_PKVALIDAINCIDENTESIC' );
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
        
        dbms_output.put_line('Se hizo drop al paquete ' || sbPaqueteOrigen );        

    ELSE

        dbms_output.put_line('NO Se hizo drop a la paquete ' || sbPaqueteOrigen || ' porque no existe' );            
        
    END IF;
    
END;
/

