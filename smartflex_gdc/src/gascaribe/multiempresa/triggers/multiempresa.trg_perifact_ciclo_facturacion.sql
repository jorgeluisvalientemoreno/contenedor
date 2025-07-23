create or replace trigger MULTIEMPRESA.TRG_PERIFACT_CICLO_FACTURACION
BEFORE INSERT ON OPEN.PERIFACT
REFERENCING OLD AS OLD NEW AS NEW FOR EACH ROW

DECLARE
	nuError			NUMBER;
	sbError			VARCHAR2(4000);
	csbMT_NAME  	VARCHAR2(200) :=  'TRG_PERIFACT_CICLO_FACTURACION';
	sbEmpresa		VARCHAR2(200);
	nuCiclo	NUMBER;

BEGIN

	pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);
	
    IF INSERTING THEN
	
		nuCiclo := :new.pefacicl;
		
		sbEmpresa := pkg_ciclo_facturacion.fsbObtEmpresa(nuCiclo);

		IF sbEmpresa IS NULL THEN
			pkg_error.setErrorMessage(isbMsgErrr => 'El ciclo '||nuCiclo ||' no esta actualmente configurado para ninguna empresa ');
		END IF;
		
    END IF;
	
	pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

EXCEPTION
    WHEN pkg_Error.Controlled_Error THEN
      pkg_Error.getError(nuError, sbError);
      pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
      RAISE pkg_Error.controlled_error;
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(nuError, sbError);
      pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
      RAISE pkg_Error.controlled_error;
END TRG_PERIFACT_CICLO_FACTURACION;
/
