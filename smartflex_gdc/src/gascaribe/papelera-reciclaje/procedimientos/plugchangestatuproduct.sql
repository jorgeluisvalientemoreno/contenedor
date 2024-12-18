/**************************************************************
Unidad      :  PLUGCHANGESTATUPRODUCT
Descripcion :  Proyecto organización
                Se borra el objeto PLUGCHANGESTATUPRODUCT ya que no está usado.
Caso: OSF-1842

Autor       :  Edilay Peña Osorio
Fecha       :  05/12/2023

***************************************************************/


DECLARE
   
    sbUsuarioOrigen     VARCHAR2(30) := 'OPEN';
    sbPaquete           VARCHAR2(30) := upper( 'PLUGCHANGESTATUPRODUCT' );
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
        dbms_output.put_line('Se hizo drop al procedimiento ' || sbPaqueteOrigen );       
    ELSE
        dbms_output.put_line('NO Se hizo drop a la procedimiento ' || sbPaqueteOrigen || ' porque no existe' );                   
    END IF;
   
END;
/
