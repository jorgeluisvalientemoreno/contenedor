CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRGVALDIR
BEFORE INSERT
ON SUSCRIPC
 REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW
DECLARE
 /**************************************************************************
		Autor       : Horbath
		Fecha       : 2-02-2021
		Ticket      : 649
		Proceso     : LDC_TRGVALDIR
		Descripcion : Trigger para validar la direccion.

		HISTORIA DE MODIFICACIONES
		FECHA        AUTOR       DESCRIPCION
		10-02-2021  Horbath      Se agrega validacion de la forma que se esta ajecutando actualmente.
		30-11-2023	Dsaltarin	 OSF-2000: Se modifican el trigger para que si se esta ejecutando
								 el tramite de venta de energía solar, no valide que ya exista un
								 producto de gas en el predio, esto se valida con el parametro TIPO_SOLI_NO_VAL_DIR_PROD_GAS
		21-10-2024	jpinedc	    OSF-3450: Se migra a ADM_PERSON
   ***************************************************************************/
	csbMetodo			CONSTANT VARCHAR2(100) := 'LDC_TRGVALDIR';
	nuProductId			NUMBER;
	nuValForma			NUMBER;
	nuError				NUMBER;

	sbMensa				VARCHAR2(4000);
	sbPrograOSF			VARCHAR2(200);
	sbPackageTypeId		VARCHAR2(100);

	nuTipoSolExclVal	NUMBER;
	sbFormasNoValida	LD_PARAMETER.VALUE_CHAIN%TYPE := DALD_PARAMETER.fsbGetValue_Chain('FORMAS_NO_LDC_TRGVALDIR',NULL);

	CURSOR cuValForma(sbForma varchar) IS
		SELECT 1
		  FROM ( SELECT regexp_substr(sbFormasNoValida,
									'[^,]+',
									1,
									LEVEL) AS formas
				   FROM dual
				 CONNECT BY regexp_substr(sbFormasNoValida, '[^,]+', 1, LEVEL) IS NOT NULL)
		 WHERE formas = sbForma ;


BEGIN
	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
    --sbPrograOSF := pkErrors.fsbGetApplication;
	-- Inicio caso: 649.2
	sbPrograOSF := PKG_SESSION.FSBOBTENERMODULO;

	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, 'sbPrograOSF: '||sbPrograOSF);

    OPEN cuValforma (sbPrograOSF);
	FETCH cuValforma
	INTO nuValforma;
	CLOSE cuValforma;
    -- Fin caso: 649.2


    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, 'nuValForma: '||nuValForma);
	IF  nuValforma IS NULL /*caso: 649.2*/ THEN

        BEGIN
            GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE('PAQUETE-1',NULL,'PROCESS_ENTITY','OBJECT_ID',sbPackageTypeId);
        EXCEPTION
            WHEN OTHERS THEN
                sbPackageTypeId := '-1';
        END;
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, 'sbPackageTypeId: '||sbPackageTypeId);

		nuTipoSolExclVal := pkg_parametros.fnuValidaSiExisteCadena('TIPO_SOLI_NO_VAL_DIR_PROD_GAS',',',sbPackageTypeId);
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, 'nuTipoSolExclVal: '||nuTipoSolExclVal);
        IF nuTipoSolExclVal = 0 THEN
			nuProductId := PR_BOProduct.fnugetprodbyaddrprodtype(:new.SUSCIDDI, ld_boconstans.cnuGasService);
			pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, 'nuProductId: '||nuProductId);
			IF nuProductId IS not null then
				-- Si el producto no es nulo entonces existen productos de GAS activos
				pkg_error.setErrorMessage(isbMsgErrr => 'Ya existe un producto de GAS instalado en la dirección.');
				raise pkg_error.CONTROLLED_ERROR;
			END IF; --IF nuProductId IS not null then
		END IF; --IF nuTipoSolExclVal = 0 THEN

	END IF;

    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

EXCEPTION
  When pkg_error.CONTROLLED_ERROR Then
	  pkg_Error.getError(nuError, sbMensa);
      pkg_traza.trace('sbError: ' || sbMensa, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
      Raise pkg_error.CONTROLLED_ERROR;
  WHEN OTHERS THEN
      pkg_error.setError;
	  pkg_Error.getError(nuError, sbMensa);
      pkg_traza.trace('sbError: ' || sbMensa, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
      Raise pkg_error.CONTROLLED_ERROR;
END LDC_TRGVALDIR;
/
