CREATE OR REPLACE FUNCTION LDC_FBSESTADOTIPOSUSPEN(inuContratoId in suscripc.susccodi%type)
RETURN BOOLEAN
IS

  /*****************************************************************
  Unidad         : LDC_FBSESTADOTIPOSUSPEN
  Descripcion    : Valida el estado del producto y el tipo de suspension.
				   
  Autor          : Jhon Erazo
  Fecha          : 01/08/2023

  Parametros            Descripcion
  ============        	===================
  inuContratoId			Codigo del contrato

  Historia de Modificaciones

  DD-MM-YYYY    <Autor>               Modificacion
  -----------  -------------------    -------------------------------------
  01/08/2023   jerazomvm        	  OSF-1376: Creación.
  ******************************************************************/
  
  --<<
  -- Variables del proceso
  -->>

BEGIN

	ut_trace.trace('Inicio LDC_FBSESTADOTIPOSUSPEN inuContratoId: ' || inuContratoId, 3);
	
	-- Valida el estado del producto y el tipo de suspension
	IF (FBOESTADOTIPOSUSPEN(inuContratoId)) THEN
		ut_trace.trace('LDC_FBSESTADOTIPOSUSPEN IS TRUE', 4);
		RETURN TRUE;
	ELSE
		ut_trace.trace('LDC_FBSESTADOTIPOSUSPEN IS FALSE', 3);
		RETURN FALSE;
	END IF;
	

EXCEPTION
  WHEN others THEN
	ut_trace.trace('others => ' ||sqlerrm, 6);
	ut_trace.trace('return => False', 6);
	Pkg_Error.setError;
	RETURN FALSE;
END LDC_FBSESTADOTIPOSUSPEN;
/
PROMPT Otorgando permisos de ejecución a FBOESTADOTIPOSUSPEN
BEGIN
	pkg_utilidades.prAplicarPermisos('LDC_FBSESTADOTIPOSUSPEN', 'OPEN'); 
END;
/
