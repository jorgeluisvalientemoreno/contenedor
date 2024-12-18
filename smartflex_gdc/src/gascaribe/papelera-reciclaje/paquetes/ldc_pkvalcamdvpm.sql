    /**************************************************************
    Propiedad intelectual Horbath.
    Unidad      :  LDC_PKVALCAMDVPM
    Descripcion :  Validaci¿n y Calibraci¿n de Medidores por VPM
    Caso: 200-2468

    Autor       :  Josh Brito
    Fecha       :  16/04/2019
    Parametros  :

    Historia de Modificaciones
    Fecha        Autor              Modificacion
    =========    =========          ====================
    10/11/2023    epenao           OSF-1756:
                                   Se borra el objeto ya que no está siendo 
                                   utilizando por las funcionalidades existentes 
                                   o las integraciones.       
    16/04/2019   Josh Brito         Creacion
    07/12/2020   HORBATH            CASO 132:
    ***************************************************************/


DECLARE
    
    sbUsuarioOrigen     VARCHAR2(30) := 'OPEN';
    sbPaquete           VARCHAR2(30) := upper( 'LDC_PKVALCAMDVPM' );
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
