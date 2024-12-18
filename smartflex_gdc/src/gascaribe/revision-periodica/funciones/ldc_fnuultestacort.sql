CREATE OR REPLACE FUNCTION Ldc_fnuUltEstaCort
( 
    inuProducto hicaesco.hcecnuse%TYPE,
    idtFecha    hicaesco.hcecfech%TYPE,
    inuEsCoAct  hicaesco.hcececac%TYPE
)
/*****************************************************************
  Propiedad intelectual de Gases del caribe
  
  Unidad         :  Ldc_fnuUltEstaCort
  Descripcion    :  Retorna el estado de corte del producto 
                    (inuProducto) antes de la fecha idtFecha
  
  Autor          :  Lubin Pineda - MVM
  Fecha          :  28/02/2023
  
  Parametros              Descripcion
  ============         ===================
  
  Fecha             Autor             Modificacion
  =========       =========           ====================
  
  ******************************************************************/
RETURN hicaesco.hcececac%TYPE
IS
    rcLastState     HICAESCO%ROWTYPE;
    
    nuUltEstaCort   hicaesco.hcececac%TYPE;

BEGIN

    ut_trace.trace ( 'Inicia Ldc_fnuUltEstaCort', 10 );

    IF idtFecha IS NOT NULL THEN
    
        rcLastState := PKBCHICAESCO.frcGetLastState ( inuProducto, idtFecha );
        
        nuUltEstaCort := rcLastState.HCECECAC;
        
        IF nuUltEstaCort IS NULL THEN
            nuUltEstaCort :=  inuEsCoAct;        
        END IF;

    ELSE
    
        nuUltEstaCort :=  inuEsCoAct; 
    
    END IF;

    ut_trace.trace ( 'Termina Ldc_fnuUltEstaCort', 10 );
    
    RETURN nuUltEstaCort;

EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
        RAISE ex.CONTROLLED_ERROR;
    WHEN others THEN
        Errors.setError;
        RAISE ex.CONTROLLED_ERROR;        
END Ldc_fnuUltEstaCort;
/

prompt "Grant execute sobre open.UT_TRACE a ORM"
grant execute on open.ldc_fnuultestacort to ORM;

prompt "Grant execute sobre open.UT_TRACE a rselopen "
grant execute on open.ldc_fnuultestacort to rselopen;
