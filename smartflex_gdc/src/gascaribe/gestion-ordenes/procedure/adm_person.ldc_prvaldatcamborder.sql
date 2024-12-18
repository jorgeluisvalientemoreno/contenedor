CREATE OR REPLACE PROCEDURE adm_person.LDC_PRVALDATCAMBORDER IS

      /*******************************************************************************
     Metodo:       LDC_PRVALDATCAMBORDER
     Descripcion:  Procedimiento usado como regla de validacion para verificar que los campos
				   estan llenos en el PB y de la logica del PB

     Autor:        Olsoftware/Miguel Ballesteros
     Fecha:        01/08/2021


     Historia de Modificaciones
     FECHA          AUTOR                       DESCRIPCION
     12/03/2024     felipe.valencia             OSF-2416: Se realiza ajuste para actualizar
                                                dirección en la tabla OR_EXTERN_SYSTEMS_ID
                                                y se realizan modificación de estandares
    *******************************************************************************/
    sbError             VARCHAR2(4000);
    nuError             NUMBER;
    csbMT_NAME          VARCHAR2(100) := $$PLSQL_UNIT;

	sbOrden 			ge_boInstanceControl.stysbValue;
	sbDireccion 		ge_boInstanceControl.stysbValue;
    nuDireccion         NUMBER;

	sbmensa         	VARCHAR2(10000);

    CURSOR cuGetOrden IS
    SELECT TO_NUMBER(regexp_substr(sbOrden,'[^,]+', 1, level)) as orden
    FROM dual connect by regexp_substr(sbOrden, '[^,]+', 1, level) is not null;

 BEGIN

	sbOrden 			:= ge_boInstanceControl.fsbGetFieldValue ('OR_ORDER_CLASSIF', 'DESCRIPTION');
	sbDireccion 		:= ge_boInstanceControl.fsbGetFieldValue ('AB_ADDRESS', 'ADDRESS');

	------------------------------------------------
	-- Required Attributes
	------------------------------------------------
	-- se valida que los campos no sean nulos
	IF (sbOrden is null) then
		sbmensa := 'Debe ingresar la orden u ordenes a actualizar';
		Pkg_Error.SetErrorMessage( isbMsgErrr => sbmensa); 
	END IF;

	IF (sbDireccion is null) then
		sbmensa := 'Debe ingresar la nueva direccion a actualizar';
		Pkg_Error.SetErrorMessage( isbMsgErrr => sbmensa); 
	END IF;

    nuDireccion :=  TO_NUMBER(sbDireccion);

	-- se valida que la direccion exista en la base de datos
	IF (pkg_bccambio_direccion_ordenes.fblExisteDireccion(nuDireccion) = FALSE) THEN
		sbmensa := 'La direccion ingresada no esta regitrada en la base de datos';
		Pkg_Error.SetErrorMessage( isbMsgErrr => sbmensa); 
	END IF;

	FOR i IN CuGetOrden LOOP
        pkg_bocambio_direccion_ordenes.prcprocesaCambioDireccion(i.orden,nuDireccion);
    END LOOP;

EXCEPTION
    WHEN pkg_Error.Controlled_Error  THEN
        pkg_Error.getError(nuError, sbError);
        pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
        RAISE pkg_Error.Controlled_Error;
    WHEN OTHERS THEN
        pkg_Error.setError;
        pkg_Error.getError(nuError, sbError);
        pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
        RAISE pkg_Error.Controlled_Error;  
END LDC_PRVALDATCAMBORDER;
/
PROMPT Otorgando permisos de ejecucion a LDC_PRVALDATCAMBORDER
BEGIN
    pkg_utilidades.praplicarpermisos('LDC_PRVALDATCAMBORDER', 'ADM_PERSON');
END;
/