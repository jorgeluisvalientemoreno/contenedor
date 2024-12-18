CREATE OR REPLACE FUNCTION ADM_PERSON.FBOESTADOTIPOSUSPEN(inuContratoId in suscripc.susccodi%type)
RETURN BOOLEAN
IS

  /*****************************************************************
  Unidad         : FBOESTADOTIPOSUSPEN
  Descripcion    : Valida el estado del producto y el tipo de suspension.
				   
  Autor          : Jhon Erazo
  Fecha          : 28/07/2023

  Parametros            Descripcion
  ============        	===================
  inuContratoId			Codigo del contrato

  Historia de Modificaciones

  DD-MM-YYYY    <Autor>               Modificacion
  -----------  -------------------    -------------------------------------
  28/07/2023   jerazomvm        	  OSF-1376: Creación.
  ******************************************************************/
  
  --<<
  -- Variables del proceso
  nuProduct_id					pr_product.product_id%type;
  sbLDC_ESTPROD_SAC				VARCHAR2(4000);
  sbLDC_ESTAPROTIPOSUSP_SAC		VARCHAR2(4000);
  sbLDC_TIPOSUSPENSION_SAC		VARCHAR2(4000);
  -->>

  --<<
  -- Cursor que obtienesi el contrato tiene un producto en estado 15 o estado 2 y con tipo de suspension 15
  -->>
  CURSOR cuValEstadoTipoSusp(inuContract_id 				in suscripc.susccodi%type,
							 isbLdc_Estprod_Sac				in VARCHAR2,
							 isbLdc_EstaProTipoSusp_Sac		in VARCHAR2,
							 isbLdc_TipoSuspension_Sac		in VARCHAR2
							 ) IS	
    select product_id
	from pr_product
	where subscription_id = inuContract_id
	and product_status_id in (select to_number(regexp_substr(isbLdc_Estprod_Sac,
                                               '[^|]+',
                                               1,
                                               LEVEL)) AS LDC_ESTPROD_SAC
							  FROM dual
							  CONNECT BY regexp_substr(isbLdc_Estprod_Sac, '[^|]+', 1, LEVEL) IS NOT NULL)
	union all
	select pp.product_id
	from pr_product pp, pr_prod_suspension pps
	where subscription_id 	= inuContract_id
	and product_status_id 	in (select to_number(regexp_substr(isbLdc_EstaProTipoSusp_Sac,
                                                 '[^|]+',
                                                 1,
                                                 LEVEL)) AS LDC_ESTPROD_SAC
							    FROM dual
							    CONNECT BY regexp_substr(isbLdc_EstaProTipoSusp_Sac, '[^|]+', 1, LEVEL) IS NOT NULL)
	and  pp.product_id 		= pps.product_id
	and suspension_type_id 	in (select to_number(regexp_substr(isbLdc_TipoSuspension_Sac,
                                                 '[^|]+',
                                                 1,
                                                 LEVEL)) AS LDC_ESTPROD_SAC
							    FROM dual
							    CONNECT BY regexp_substr(isbLdc_TipoSuspension_Sac, '[^|]+', 1, LEVEL) IS NOT NULL)
	and active 				= 'Y';

BEGIN

	ut_trace.trace('Inicio FBOESTADOTIPOSUSPEN inuContratoId: ' || inuContratoId, 3);
	
	-- Obtiene el estado del producto para la solicitud SAC servicios nuevos
	sbLDC_ESTPROD_SAC := pkg_parametros.fsbGetValorCadena('LDC_ESTPROD_SAC');
	ut_trace.trace('FBOESTADOTIPOSUSPEN sbLDC_ESTPROD_SAC: ' || sbLDC_ESTPROD_SAC, 3);
	
	-- Obtiene el estado del producto con tipo de suspension para la solicitud SAC servicios nuevos
	sbLDC_ESTAPROTIPOSUSP_SAC := pkg_parametros.fsbGetValorCadena('LDC_ESTAPROTIPOSUSP_SAC');
	ut_trace.trace('FBOESTADOTIPOSUSPEN sbLDC_ESTAPROTIPOSUSP_SAC: ' || sbLDC_ESTAPROTIPOSUSP_SAC, 3);
	
	-- Obtiene el tipo de suspension para la solicitud SAC servicios nuevos
	sbLDC_TIPOSUSPENSION_SAC := pkg_parametros.fsbGetValorCadena('LDC_TIPOSUSPENSION_SAC');
	ut_trace.trace('FBOESTADOTIPOSUSPEN sbLDC_TIPOSUSPENSION_SAC: ' || sbLDC_TIPOSUSPENSION_SAC, 3);

	if(cuValEstadoTipoSusp%isopen) then
		close cuValEstadoTipoSusp;
	end if;

    OPEN cuValEstadoTipoSusp(inuContratoId, 
							 sbLDC_ESTPROD_SAC,
							 sbLDC_ESTAPROTIPOSUSP_SAC,
							 sbLDC_TIPOSUSPENSION_SAC
							 );
    FETCH cuValEstadoTipoSusp INTO nuProduct_id;
    CLOSE cuValEstadoTipoSusp;
	
	if (nuProduct_id is not null) then
		ut_trace.trace('FBOESTADOTIPOSUSPEN la validación obtuvo el producto: ' || nuProduct_id, 4);
		RETURN TRUE;
	ELSE
		ut_trace.trace('FBOESTADOTIPOSUSPEN la validación no obtuvo productos', 4);
		RETURN FALSE;
	end if;

EXCEPTION
  WHEN others THEN
	ut_trace.trace('others => '||sqlerrm, 6);
	ut_trace.trace('return => False', 6);
	Pkg_Error.setError;
	RETURN FALSE;
END FBOESTADOTIPOSUSPEN;
/
PROMPT Otorgando permisos de ejecución a FBOESTADOTIPOSUSPEN
BEGIN
	pkg_utilidades.prAplicarPermisos('FBOESTADOTIPOSUSPEN', 'ADM_PERSON'); 
END;
/