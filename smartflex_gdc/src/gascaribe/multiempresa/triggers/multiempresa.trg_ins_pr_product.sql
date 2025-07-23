CREATE OR REPLACE TRIGGER MULTIEMPRESA.TRG_INS_PR_PRODUCT
BEFORE INSERT OR UPDATE ON PR_PRODUCT
REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW
WHEN (( NEW.ADDRESS_ID IS NOT NULL AND NVL(OLD.ADDRESS_ID,-1) <> NVL(NEW.ADDRESS_ID,-1) ) or (NVL(OLD.SUBSCRIPTION_ID,-1) <> NVL(NEW.SUBSCRIPTION_ID,-1)))
DECLARE

/*******************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Trigger     :   trg_ins_pr_product
    Autor       :   Lubin Pineda - GlobalMVM
    Fecha       :   17/02/2025
    Descripcion :   Trigger para insertar en multiempresa.contrato
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    jpinedc     17/02/2025  OSF-3956    Creacion
    jpinedc     20/05/2025  OSF-4479    * Se modifica la condicion WHEN
    jpinedc     23/05/2025  OSF-4479    * Se ajusta lógica para el manejo de
                                        productos creados con direccion nula
*******************************************************************************/

    csbMetodo       CONSTANT VARCHAR2(70) :=  'trg_ins_pr_product';
    nuError         NUMBER;
    sbError         VARCHAR2(4000);
    csbNivelTraza   CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;

    -- Inserta un registro en multiempresa.contrato
    PROCEDURE prinsActContrato
    (
        inuProducto     IN  pr_product.product_id%TYPE,
        inuTipoProducto IN  pr_product.product_type_id%TYPE,
        inuContrato     IN  contrato.contrato%TYPE,
        inuDireccion    IN  pr_product.address_id%TYPE,
        inuDireccionAnterior    IN  pr_product.address_id%TYPE
    )
    IS
        -- Nombre de este mtodo
        csbMetodo1        CONSTANT VARCHAR2(70) := csbMetodo || '.prinsActContrato';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);

        sbEmpresa       contrato.empresa%TYPE;

        nuDepartamento     ab_address.geograp_location_id%TYPE;

        sbEmpresaAnterior       contrato.empresa%TYPE;

        nuDepartamentoAnterior     ab_address.geograp_location_id%TYPE;

    BEGIN

        pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbINICIO);

        IF  pkg_parametros.fnuValidaSiExisteCadena('TIPO_PRODUCTO_NO_MARCA_EMPRESA', ',', inuTipoProducto  ) = 0 THEN

            IF inuDireccion > 0 THEN
            
                nuDepartamento  := pkg_bcDirecciones.fnuGetDepartamento(inuDireccion);

                sbEmpresa :=     pkg_empresa.fsbObtEmpresaDepartamento( nuDepartamento );

                IF NOT pkg_contrato.fblExiste( inuContrato ) THEN

                    pkg_Contrato.prinsRegistro
                    (
                        inuContrato =>  inuContrato ,
                        isbEmpresa  =>  sbEmpresa
                    );

                ELSE

                    IF inuDireccion <> inuDireccionAnterior AND inuDireccion > 0
                    THEN

                        nuDepartamentoAnterior  := pkg_bcDirecciones.fnuGetDepartamento(inuDireccionAnterior);

                        sbEmpresaAnterior :=     pkg_empresa.fsbObtEmpresaDepartamento( nuDepartamentoAnterior );

                        IF sbEmpresa <> sbEmpresaAnterior THEN

                            pkg_Contrato.prcActualizaEmpresa( inuContrato, sbEmpresa);

                        END IF;

                    END IF;

                END IF;
                
            ELSE
                pkg_traza.trace('La dirección del producto[' || inuProducto || '] es nula', csbNivelTraza );
            END IF;

        ELSE
            pkg_traza.trace('El tipo de producto[' || inuTipoProducto || '] está en el parámetro TIPO_PRODUCTO_NO_MARCA_EMPRESA', csbNivelTraza );
        END IF;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
    END prinsActContrato;

BEGIN

    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);

    prinsActContrato
    (
        inuProducto     =>  :NEW.PRODUCT_ID,
        inuTipoProducto =>  :NEW.PRODUCT_TYPE_ID,
        inuContrato     =>  :NEW.SUBSCRIPTION_ID,
        inuDireccion    =>  NVL(:NEW.ADDRESS_ID,-1),
        inuDireccionAnterior => NVL(:OLD.ADDRESS_ID,-1)
    );

    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

EXCEPTION
    WHEN pkg_error.Controlled_Error THEN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
        pkg_Error.getError(nuError,sbError);
        pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
        RAISE pkg_error.Controlled_Error;
    WHEN OTHERS THEN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
        pkg_error.setError;
        pkg_Error.getError(nuError,sbError);
        pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
        RAISE pkg_error.Controlled_Error;
END;
/