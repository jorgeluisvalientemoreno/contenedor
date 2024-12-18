CREATE OR REPLACE PACKAGE adm_person.pkg_bcproducto IS
/*******************************************************************************
    Fuente=Propiedad Intelectual de Gases del Caribe
    pkg_bcproducto
    Autor       :   Lubin Pineda - MVM
    Fecha       :   25-07-2023
    Descripcion :   Paquete con los métodos CRUD para manejo de información
                    sobre las tablas OPEN.PR_PRODUCT y OPEN.SERVSUSC
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     25-07-2023  OSF-1249 Creacion
    jpinedc     31-07-2023  OSF-1249 Ajustes por revisión técnica
    Adrianavg   29-09-2023  OSF-1666 Crear fnuObtenerLocalidad
    Adrianavg   02-10-2023  OSF-1666 Ajuste por validación ténica: a la fnuObtenerLocalidad
                                     añadirle en la excception la captura del sms de error y que quede en la traza
    Adrianavg   02-10-2023  OSF-1689 Creacion de cursores, tipos y subtipos, procedimientos y funciones
    jpinedc     14-12-2023  OSF-1938 Se ajusta fnuEstadoCorte
    Adrianavg   21-12-2023  OSF-1805 Creacion de fnuTraerCommercialPlanId   
    jsoto       17-06-2024  OSF-2838 Se cambia el nombre de la función fsbExisteProducto por fblExisteProducto  
    jpinedc     26-09-2024  OSF-3368 Se crea fnuObtieneMarcaProducto
*******************************************************************************/
   --CURSORES
   CURSOR cuRecord( inuproduct_id IN Pr_Product.product_id%TYPE) IS
   SELECT PR.*,PR.rowid
	 FROM PR_product PR
	WHERE PR.Product_Id = inuProduct_Id;

    --TIPOS/SUBTIPOS
   SUBTYPE sbtProducto IS CURECORD%ROWTYPE;
   TYPE tytbsbtProducto IS TABLE OF sbtProducto INDEX BY BINARY_INTEGER;
   TYPE tytbproduct_id IS TABLE OF pr_product.product_id%TYPE INDEX BY BINARY_INTEGER;
   TYPE tytbsubscription_id IS TABLE OF pr_product.subscription_id%TYPE INDEX BY BINARY_INTEGER;

    -- Retona Identificador del ultimo caso que hizo cambios en este archivo
    FUNCTION fsbVersion RETURN VARCHAR2;

    -- Retorna Categoría del producto
    FUNCTION fnuCategoria
    (
        inuProducto                  IN  servsusc.sesunuse%TYPE
    )
    RETURN servsusc.sesucate%TYPE;

    -- Retorna SubCategoría del producto
    FUNCTION fnuSubCategoria
    (
        inuProducto                  IN  servsusc.sesunuse%TYPE
    )
    RETURN servsusc.sesusuca%TYPE;

    -- Retorna Estado de Corte del producto
    FUNCTION fnuEstadoCorte
    (
        inuProducto                  IN  servsusc.sesunuse%TYPE
    )
    RETURN servsusc.sesuesco%TYPE;

    -- Retorna Valor Saldo a Favor del producto
    FUNCTION fnuSaldoAfavor
    (
        inuProducto                  IN  servsusc.sesunuse%TYPE
    )
    RETURN servsusc.sesusafa%TYPE;

    -- Retorna la lista estados separada por pipe de estado excluidos
    FUNCTION fsbEstadosExclSuspension
    (
        inuProducto                  IN  servsusc.sesunuse%TYPE
    )
    RETURN servsusc.sesuexcl%TYPE;

    -- Retorna la lista estados separada por pipe de estado incluidos
    FUNCTION fsbEstadosInclSuspension
    (
        inuProducto                  IN  servsusc.sesunuse%TYPE
    )
    RETURN servsusc.sesuincl%TYPE;

    -- Retorna estado financiero del producto
    FUNCTION fsbEstadoFinanciero
    (
        inuProducto                  IN  servsusc.sesunuse%TYPE
    )
    RETURN servsusc.sesuesfn%TYPE;

    -- Retorna fecha suspensión por pago
    FUNCTION fdtFechaSuspPago
    (
        inuProducto                  IN  servsusc.sesunuse%TYPE
    )
    RETURN servsusc.sesufeco%TYPE;

    -- Retorna plan de facturación
    FUNCTION fnuPlanFacturacion
    (
        inuProducto                  IN  servsusc.sesunuse%TYPE
    )
    RETURN servsusc.sesuplfa%TYPE;

    -- Retorna ciclo de consumo
    FUNCTION fnuCicloConsumo
    (
        inuProducto                  IN  servsusc.sesunuse%TYPE
    )
    RETURN servsusc.sesucico%TYPE;

    -- Retorna ciclo de facturación
    FUNCTION fnuCicloFacturacion
    (
        inuProducto                  IN  servsusc.sesunuse%TYPE
    )
    RETURN servsusc.sesucicl%TYPE;

    -- Retorna el tipo de producto
    FUNCTION fnuTipoProducto
    (
        inuProducto                  IN  servsusc.sesunuse%TYPE
    )
    RETURN servsusc.sesuserv%TYPE;

    -- Retorna el contrato
    FUNCTION fnuContrato
    (
        inuProducto                  IN  servsusc.sesunuse%TYPE
    )
    RETURN servsusc.sesususc%TYPE;

    -- Retorna fecha de instalación
    FUNCTION fdtFechaInstalacion
    (
        inuProducto                  IN  servsusc.sesunuse%TYPE
    )
    RETURN servsusc.sesufein%TYPE;

    -- Retorna método variación del consumo
    FUNCTION fnuMetodoVariacion
    (
        inuProducto                  IN  servsusc.sesunuse%TYPE
    )
    RETURN servsusc.sesumecv%TYPE;

    -- Retorna el estado del producto
    FUNCTION fnuEstadoProducto
    (
        inuProducto                  IN  pr_product.product_id%TYPE
    )
    RETURN pr_product.product_status_id%TYPE;

    -- Retorna el id de la dirección de instalación
    FUNCTION fnuIdDireccInstalacion
    (
        inuProducto                  IN  pr_product.product_id%TYPE
    )
    RETURN pr_product.address_id%TYPE;

    -- Retorna el id de la actividad de orden de suspensión
    FUNCTION fnuIdActivOrdenSusp
    (
        inuProducto                  IN  pr_product.product_id%TYPE
    )
    RETURN pr_product.suspen_ord_act_id%TYPE;

    -- Retorna el id de la localidad de la dirección del producto
    FUNCTION fnuObtenerLocalidad
    (
        inuProducto                  IN  pr_product.product_id%TYPE
    )
    RETURN ab_address.geograp_location_id%TYPE;

    --recibe el producto y devuelva si es o no provisional
    PROCEDURE PRC_EsProvisional
    (
        inuproduct_id        IN  pr_product.product_id%TYPE,
        isbEsProvisional      OUT pr_product.is_provisional%TYPE
    );

    --recibe el producto y devuelva la clase de producto.
    PROCEDURE PRC_ClaseProducto
    (
        inuproduct_id        IN  pr_product.product_id%TYPE,
        isbclass_product      OUT pr_product.class_product%TYPE
    );

    --devuelva un registro (rcProduct ) con la información relacionada al subtype sbtProducto
    PROCEDURE PRC_TraeRegistroProduct
    (
        inuproduct_id         IN  pr_product.product_id%TYPE,
        isbrcProduct        OUT NOCOPY sbtProducto
    );

    -- Retorna falso o verdadero si un producto existe o no.
    FUNCTION fblExisteProducto
    (
        inuproduct_id         IN  pr_product.product_id%TYPE
    )
    RETURN BOOLEAN;

    --Validar que el cursor cuRecord esté cerrado
    PROCEDURE PRC_CierreCursorRecord;

    -- Retorna el id del pan comercial segun el producto id
    FUNCTION fnuTraerCommercialPlanId
    (
        inuproduct_id         IN  pr_product.product_id%TYPE
    )
    RETURN pr_product.commercial_plan_id%TYPE; 
 
    -- Retorna la fecha de retiro del prodcuo
    FUNCTION fdtFechaRetiro
    (
        inuproduct_id    IN pr_product.product_id%TYPE
    )
    RETURN servsusc.sesufere%TYPE;
    
    -- Retorna la marca del producto en ldc_marca_producto
    FUNCTION fnuObtieneMarcaProducto
    (
        inuProducto    IN pr_product.product_id%TYPE
    )
    RETURN ldc_marca_producto.suspension_type_id%TYPE;    						   

END pkg_bcproducto;

/

CREATE OR REPLACE PACKAGE BODY adm_person.pkg_bcproducto IS

    -- Identificador del ultimo caso que hizo cambios
    csbVersion                 VARCHAR2(15) := 'OSF-3368';

    -- Constantes para el control de la traza
    csbSP_NAME     CONSTANT VARCHAR2(35) := $$PLSQL_UNIT||'.'; 
    cnuNVLTRC      CONSTANT NUMBER(2)    := pkg_traza.cnuNivelTrzDef; 
    
    cnuMARCA_101  CONSTANT  ldc_marca_producto.suspension_type_id%TYPE := 
                            pkg_bcld_parameter.fnuobtienevalornumerico('MARCA_PRODUCTO_101');  

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbVersion
    Descripcion     : Retona la ultima WO que hizo cambios en el paquete
    Autor           : Lubin Pineda - MVM
    Fecha           : 25-07-2023
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     25-07-2023  OSF-1249 Creacion
    ***************************************************************************/
    FUNCTION fsbVersion RETURN VARCHAR2 IS
    BEGIN
        RETURN csbVersion;
    END fsbVersion;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuCategoria
    Descripcion     : Retorna Categoría del producto
    Autor           : Lubin Pineda - MVM
    Fecha           : 27-07-2023
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    jpinedc     27-07-2023  OSF-1249    Creacion
    ***************************************************************************/
    FUNCTION fnuCategoria
    (
        inuProducto                  IN  servsusc.sesunuse%TYPE
    )
    RETURN servsusc.sesucate%TYPE
    IS

        -- Nombre de ste mÉtodo
        csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.fnuCategoria';
        nuerrorcode NUMBER;         -- se almacena codigo de error
        sbmenserror VARCHAR2(2000);  -- se almacena descripcion del error 


        CURSOR cuCategoria
        IS
        SELECT  ss.sesucate
        FROM servsusc ss
        WHERE ss.sesunuse = inuProducto;

        nuCategoria    servsusc.sesucate%TYPE;

        PROCEDURE pCierracuCategoria
        IS
            -- Nombre de este método
            csbMT_NAME1  VARCHAR2(105) := csbMT_NAME || '.pCierracuCategoria';
        BEGIN

            pkg_traza.trace(csbMT_NAME1, cnuNVLTRC, pkg_traza.csbINICIO);

            IF cuCategoria%ISOPEN THEN
                CLOSE cuCategoria;
            END IF;

            pkg_traza.trace(csbMT_NAME1, cnuNVLTRC, pkg_traza.csbFIN);

        END pCierracuCategoria;

    BEGIN

        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

        pCierracuCategoria;

        OPEN cuCategoria;
        FETCH cuCategoria INTO nuCategoria;
        CLOSE cuCategoria;

        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

        RETURN nuCategoria;

    EXCEPTION
        WHEN OTHERS THEN
            pkg_error.SetError;
			pkg_error.getError(nuErrorCode,sbMensError);
			pkg_traza.trace(csbMT_NAME||' '||sbMensError, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME,cnuNVLTRC,pkg_traza.fsbFIN_ERR);
            pCierracuCategoria;
            RETURN nuCategoria;
    END fnuCategoria;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuSubCategoria
    Descripcion     : Retorna SubCategoría del producto
    Autor           : Lubin Pineda - MVM
    Fecha           : 27-07-2023
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    jpinedc     27-07-2023  OSF-1249    Creacion
    ***************************************************************************/
    FUNCTION fnuSubCategoria
    (
        inuProducto                  IN  servsusc.sesunuse%TYPE
    )
    RETURN servsusc.sesusuca%TYPE
    IS

        -- Nombre de ste mÉtodo
        csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.fnuSubCategoria';
        nuerrorcode NUMBER;         -- se almacena codigo de error
        sbmenserror VARCHAR2(2000);  -- se almacena descripcion del error 


        CURSOR cuCategoria
        IS
        SELECT  ss.sesusuca
        FROM servsusc ss
        WHERE ss.sesunuse = inuProducto;

        nuSubCategoria    servsusc.sesusuca%TYPE;

        PROCEDURE pCierracuCategoria
        IS
            -- Nombre de este método
            csbMT_NAME1  VARCHAR2(105) := csbMT_NAME || '.pCierracuCategoria';
        BEGIN

            pkg_traza.trace(csbMT_NAME1, cnuNVLTRC, pkg_traza.csbINICIO);

            IF cuCategoria%ISOPEN THEN
                CLOSE cuCategoria;
            END IF;

            pkg_traza.trace(csbMT_NAME1, cnuNVLTRC, pkg_traza.csbFIN);

        END pCierracuCategoria;

    BEGIN

        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

        pCierracuCategoria;

        OPEN cuCategoria;
        FETCH cuCategoria INTO nuSubCategoria;
        CLOSE cuCategoria;

        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

        RETURN nuSubCategoria;

    EXCEPTION
        WHEN OTHERS THEN
            pkg_error.SetError;
            pCierracuCategoria;
            RETURN nuSubCategoria;
    END fnuSubCategoria;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuEstadoCorte
    Descripcion     : Retorna Estado de Corte del producto
    Autor           : Lubin Pineda - MVM
    Fecha           : 27-07-2023
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    jpinedc     27-07-2023  OSF-1249    Creacion
    jpinedc     14-12-2023  OSF-1938    Se corrige cursor
    ***************************************************************************/
    FUNCTION fnuEstadoCorte
    (
        inuProducto                  IN  servsusc.sesunuse%TYPE
    )
    RETURN servsusc.sesuesco%TYPE
    IS

        -- Nombre de ste mÉtodo
        csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.fnuEstadoCorte';
        nuerrorcode NUMBER;         -- se almacena codigo de error
        sbmenserror VARCHAR2(2000);  -- se almacena descripcion del error 
		

        CURSOR cuEstadoCorte
        IS
        SELECT  ss.sesuesco
        FROM servsusc ss
        WHERE ss.sesunuse = inuProducto;

        nuEstadoCorte    servsusc.sesuesco%TYPE;

        PROCEDURE pCierracuEstadoCorte
        IS
            -- Nombre de este método
            csbMT_NAME1  VARCHAR2(105) := csbMT_NAME || '.pCierracuEstadoCorte';
        BEGIN

            pkg_traza.trace(csbMT_NAME1, cnuNVLTRC, pkg_traza.csbINICIO);

            IF cuEstadoCorte%ISOPEN THEN
                CLOSE cuEstadoCorte;
            END IF;

            pkg_traza.trace(csbMT_NAME1, cnuNVLTRC, pkg_traza.csbFIN);

        END pCierracuEstadoCorte;

    BEGIN

        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

        pCierracuEstadoCorte;

        OPEN cuEstadoCorte;
        FETCH cuEstadoCorte INTO nuEstadoCorte;
        CLOSE cuEstadoCorte;

        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

        RETURN nuEstadoCorte;

    EXCEPTION
        WHEN OTHERS THEN
            pkg_error.SetError;
            pCierracuEstadoCorte;
            RETURN nuEstadoCorte;
    END fnuEstadoCorte;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuSaldoAfavor
    Descripcion     : Retorna Valor Saldo a Favor del producto
    Autor           : Lubin Pineda - MVM
    Fecha           : 27-07-2023
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    jpinedc     27-07-2023  OSF-1249    Creacion
    ***************************************************************************/
    FUNCTION fnuSaldoAfavor
    (
        inuProducto                  IN  servsusc.sesunuse%TYPE
    )
    RETURN servsusc.sesusafa%TYPE
    IS

        -- Nombre de ste mÉtodo
        csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.fnuSaldoAfavor';
        nuerrorcode NUMBER;         -- se almacena codigo de error
        sbmenserror VARCHAR2(2000);  -- se almacena descripcion del error 
		

        CURSOR cuSaldoAfavor
        IS
        SELECT  ss.sesusafa
        FROM servsusc ss
        WHERE ss.sesunuse = inuProducto;

        nuSaldoAfavor    servsusc.sesusafa%TYPE;

        PROCEDURE pCierracuSaldoAfavor
        IS
            -- Nombre de este método
            csbMT_NAME1  VARCHAR2(105) := csbMT_NAME || '.pCierracuSaldoAfavor';
        BEGIN

            pkg_traza.trace(csbMT_NAME1, cnuNVLTRC, pkg_traza.csbINICIO);

            IF cuSaldoAfavor%ISOPEN THEN
                CLOSE cuSaldoAfavor;
            END IF;

            pkg_traza.trace(csbMT_NAME1, cnuNVLTRC, pkg_traza.csbFIN);

        END pCierracuSaldoAfavor;

    BEGIN

        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

        pCierracuSaldoAfavor;

        OPEN cuSaldoAfavor;
        FETCH cuSaldoAfavor INTO nuSaldoAfavor;
        CLOSE cuSaldoAfavor;

        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

        RETURN nuSaldoAfavor;

    EXCEPTION
        WHEN OTHERS THEN
            pkg_error.SetError;
			pkg_error.getError(nuErrorCode, sbMensError);
			pkg_traza.trace(csbMT_NAME||' '||sbMensError, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME,cnuNVLTRC,pkg_traza.fsbFIN_ERR);
            pCierracuSaldoAfavor;
            RETURN nuSaldoAfavor;
    END fnuSaldoAfavor;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbEstadosExclSuspension
    Descripcion     : Retorna la lista estados separada por pipe para los cuales
                      el producto esta excluido de los procesos de suspensión
    Autor           : Lubin Pineda - MVM
    Fecha           : 27-07-2023
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    jpinedc     27-07-2023  OSF-1249    Creacion
    ***************************************************************************/
    FUNCTION fsbEstadosExclSuspension
    (
        inuProducto                  IN  servsusc.sesunuse%TYPE
    )
    RETURN servsusc.sesuexcl%TYPE
    IS

        -- Nombre de ste mÉtodo
        csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.fsbEstadosExclSuspension';
        nuerrorcode NUMBER;         -- se almacena codigo de error
        sbmenserror VARCHAR2(2000);  -- se almacena descripcion del error 


        CURSOR cuExcluidoCorte
        IS
        SELECT  ss.sesuexcl
        FROM servsusc ss
        WHERE ss.sesunuse = inuProducto;

        sbEstadosExcluidosSuspension    servsusc.sesuexcl%TYPE;

        PROCEDURE pCierracuExcluidoCorte
        IS
            -- Nombre de este método
            csbMT_NAME1  VARCHAR2(105) := csbMT_NAME || '.pCierracuExcluidoCorte';
        BEGIN

            pkg_traza.trace(csbMT_NAME1, cnuNVLTRC, pkg_traza.csbINICIO);

            IF cuExcluidoCorte%ISOPEN THEN
                CLOSE cuExcluidoCorte;
            END IF;

            pkg_traza.trace(csbMT_NAME1, cnuNVLTRC, pkg_traza.csbFIN);

        END pCierracuExcluidoCorte;

    BEGIN

        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

        pCierracuExcluidoCorte;

        OPEN cuExcluidoCorte;
        FETCH cuExcluidoCorte INTO sbEstadosExcluidosSuspension;
        CLOSE cuExcluidoCorte;

        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

        RETURN sbEstadosExcluidosSuspension;

    EXCEPTION
        WHEN OTHERS THEN
            pkg_error.SetError;
			pkg_error.getError(nuErrorCode,sbMensError);
			pkg_traza.trace(csbMT_NAME||' '||sbMensError, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME,cnuNVLTRC,pkg_traza.fsbFIN_ERR);	
            pCierracuExcluidoCorte;
            RETURN sbEstadosExcluidosSuspension;
    END fsbEstadosExclSuspension;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbEstadosInclSuspension
    Descripcion     : Retorna la lista estados separada por pipe para los cuales
                      el producto esta incluido de los procesos de suspensión
    Autor           : Lubin Pineda - MVM
    Fecha           : 27-07-2023
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    jpinedc     27-07-2023  OSF-1249    Creacion
    ***************************************************************************/
    FUNCTION fsbEstadosInclSuspension
    (
        inuProducto                  IN  servsusc.sesunuse%TYPE
    )
    RETURN servsusc.sesuincl%TYPE
    IS

        -- Nombre de ste mÉtodo
        csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.fsbEstadosInclSuspension';
        nuerrorcode NUMBER;         -- se almacena codigo de error
        sbmenserror VARCHAR2(2000);  -- se almacena descripcion del error 
		

        CURSOR cuEstadosIncluidosSuspension
        IS
        SELECT  ss.sesuincl
        FROM servsusc ss
        WHERE ss.sesunuse = inuProducto;

        sbEstadosIncluidosSuspension    servsusc.sesuincl%TYPE;

        PROCEDURE pCierracuEstadosInclSuspension
        IS
            -- Nombre de este método
            csbMT_NAME1  VARCHAR2(105) := csbMT_NAME || '.pCierracuEstadosInclSuspension';
        BEGIN

            pkg_traza.trace(csbMT_NAME1, cnuNVLTRC, pkg_traza.csbINICIO);

            IF cuEstadosIncluidosSuspension%ISOPEN THEN
                CLOSE cuEstadosIncluidosSuspension;
            END IF;

            pkg_traza.trace(csbMT_NAME1, cnuNVLTRC, pkg_traza.csbFIN);

        END pCierracuEstadosInclSuspension;

    BEGIN

        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

        pCierracuEstadosInclSuspension;

        OPEN cuEstadosIncluidosSuspension;
        FETCH cuEstadosIncluidosSuspension INTO sbEstadosIncluidosSuspension;
        CLOSE cuEstadosIncluidosSuspension;

        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

        RETURN sbEstadosIncluidosSuspension;

    EXCEPTION
        WHEN OTHERS THEN
            pkg_error.SetError;
			pkg_error.getError(nuErrorCode,sbMensError);
			pkg_traza.trace(csbMT_NAME||' '||sbMensError, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME,cnuNVLTRC,pkg_traza.fsbFIN_ERR);	
            pCierracuEstadosInclSuspension;
            RETURN sbEstadosIncluidosSuspension;
    END fsbEstadosInclSuspension;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbEstadoFinanciero
    Descripcion     : Retorna estado financiero del producto
    Autor           : Lubin Pineda - MVM
    Fecha           : 27-07-2023
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    jpinedc     27-07-2023  OSF-1249    Creacion
    ***************************************************************************/
    FUNCTION fsbEstadoFinanciero
    (
        inuProducto                  IN  servsusc.sesunuse%TYPE
    )
    RETURN servsusc.sesuesfn%TYPE
    IS

        -- Nombre de ste mÉtodo
        csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.fsbEstadoFinanciero';
        nuerrorcode NUMBER;         -- se almacena codigo de error
        sbmenserror VARCHAR2(2000);  -- se almacena descripcion del error 


        CURSOR cuEstadoFinanciero
        IS
        SELECT  ss.sesuesfn
        FROM servsusc ss
        WHERE ss.sesunuse = inuProducto;

        sbEstadoFinanciero    servsusc.sesuesfn%TYPE;

        PROCEDURE pCierracuEstadoFinanciero
        IS
            -- Nombre de este método
            csbMT_NAME1  VARCHAR2(105) := csbMT_NAME || '.pCierracuEstadoFinanciero';
        BEGIN

            pkg_traza.trace(csbMT_NAME1, cnuNVLTRC, pkg_traza.csbINICIO);

            IF cuEstadoFinanciero%ISOPEN THEN
                CLOSE cuEstadoFinanciero;
            END IF;

            pkg_traza.trace(csbMT_NAME1, cnuNVLTRC, pkg_traza.csbFIN);

        END pCierracuEstadoFinanciero;

    BEGIN

        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

        pCierracuEstadoFinanciero;

        OPEN cuEstadoFinanciero;
        FETCH cuEstadoFinanciero INTO sbEstadoFinanciero;
        CLOSE cuEstadoFinanciero;

        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

        RETURN sbEstadoFinanciero;

    EXCEPTION
        WHEN OTHERS THEN
            pkg_error.SetError;
			pkg_error.getError(nuErrorCode,sbMensError);
			pkg_traza.trace(csbMT_NAME||' '||sbMensError, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME,cnuNVLTRC,pkg_traza.fsbFIN_ERR);	
            pCierracuEstadoFinanciero;
            RETURN sbEstadoFinanciero;
    END fsbEstadoFinanciero;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fdtFechaSuspPago
    Descripcion     : Retorna fecha suspensión por pago
    Autor           : Lubin Pineda - MVM
    Fecha           : 27-07-2023
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    jpinedc     27-07-2023  OSF-1249    Creacion
    ***************************************************************************/
    FUNCTION fdtFechaSuspPago
    (
        inuProducto                  IN  servsusc.sesunuse%TYPE
    )
    RETURN servsusc.sesufeco%TYPE
    IS

        -- Nombre de ste mÉtodo
        csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.fdtFechaSuspPago';
        nuerrorcode NUMBER;         -- se almacena codigo de error
        sbmenserror VARCHAR2(2000);  -- se almacena descripcion del error 
		

        CURSOR cuFechaSuspPago
        IS
        SELECT  ss.sesufeco
        FROM servsusc ss
        WHERE ss.sesunuse = inuProducto;

        dtFechaSuspPago    DATE;

        PROCEDURE pCierracuFechaSuspPago
        IS
            -- Nombre de este método
            csbMT_NAME1  VARCHAR2(105) := csbMT_NAME || '.pCierracuFechaSuspPago';
        BEGIN

            pkg_traza.trace(csbMT_NAME1, cnuNVLTRC, pkg_traza.csbINICIO);

            IF cuFechaSuspPago%ISOPEN THEN
                CLOSE cuFechaSuspPago;
            END IF;

            pkg_traza.trace(csbMT_NAME1, cnuNVLTRC, pkg_traza.csbFIN);

        END pCierracuFechaSuspPago;

    BEGIN

        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

        pCierracuFechaSuspPago;

        OPEN cuFechaSuspPago;
        FETCH cuFechaSuspPago INTO dtFechaSuspPago;
        CLOSE cuFechaSuspPago;

        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

        RETURN dtFechaSuspPago;

    EXCEPTION
        WHEN OTHERS THEN
            pkg_error.SetError;
			pkg_error.getError(nuErrorCode,sbMensError);
			pkg_traza.trace(csbMT_NAME||' '||sbMensError, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME,cnuNVLTRC,pkg_traza.fsbFIN_ERR);	
            pCierracuFechaSuspPago;
            RETURN dtFechaSuspPago;
    END fdtFechaSuspPago;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuPlanFacturacion
    Descripcion     : Retorna plan de facturación
    Autor           : Lubin Pineda - MVM
    Fecha           : 27-07-2023
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    jpinedc     27-07-2023  OSF-1249    Creacion
    ***************************************************************************/
    FUNCTION fnuPlanFacturacion
    (
        inuProducto                  IN  servsusc.sesunuse%TYPE
    )
    RETURN servsusc.sesuplfa%TYPE
    IS

        -- Nombre de ste mÉtodo
        csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.fnuPlanFacturacion';
        nuerrorcode NUMBER;         -- se almacena codigo de error
        sbmenserror VARCHAR2(2000);  -- se almacena descripcion del error 
		

        CURSOR cuPlanFacturacion
        IS
        SELECT  ss.sesuplfa
        FROM servsusc ss
        WHERE ss.sesunuse = inuProducto;

        nuPlanFacturacion    servsusc.sesuplfa%TYPE;

        PROCEDURE pCierracuPlanFacturacion
        IS
            -- Nombre de este método
            csbMT_NAME1  VARCHAR2(105) := csbMT_NAME || '.pCierracuPlanFacturacion';
        BEGIN

            pkg_traza.trace(csbMT_NAME1, cnuNVLTRC, pkg_traza.csbINICIO);

            IF cuPlanFacturacion%ISOPEN THEN
                CLOSE cuPlanFacturacion;
            END IF;

            pkg_traza.trace(csbMT_NAME1, cnuNVLTRC, pkg_traza.csbFIN);

        END pCierracuPlanFacturacion;

    BEGIN

        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

        pCierracuPlanFacturacion;

        OPEN cuPlanFacturacion;
        FETCH cuPlanFacturacion INTO nuPlanFacturacion;
        CLOSE cuPlanFacturacion;

        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

        RETURN nuPlanFacturacion;

    EXCEPTION
        WHEN OTHERS THEN
            pkg_error.SetError;
			pkg_error.getError(nuErrorCode,sbMensError);
			pkg_traza.trace(csbMT_NAME||' '||sbMensError, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME,cnuNVLTRC,pkg_traza.fsbFIN_ERR);	
            pCierracuPlanFacturacion;
            RETURN nuPlanFacturacion;
    END fnuPlanFacturacion;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuCicloConsumo
    Descripcion     : Retorna ciclo de consumo
    Autor           : Lubin Pineda - MVM
    Fecha           : 27-07-2023
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    jpinedc     27-07-2023  OSF-1249    Creacion
    ***************************************************************************/
    FUNCTION fnuCicloConsumo
    (
        inuProducto                  IN  servsusc.sesunuse%TYPE
    )
    RETURN servsusc.sesucico%TYPE
    IS

        -- Nombre de ste mÉtodo
        csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.fnuCicloConsumo';
        nuerrorcode NUMBER;         -- se almacena codigo de error
        sbmenserror VARCHAR2(2000);  -- se almacena descripcion del error 
		

        CURSOR cuCicloConsumo
        IS
        SELECT  ss.sesucico
        FROM servsusc ss
        WHERE ss.sesunuse = inuProducto;

        nuiCicloConsumo    servsusc.sesucico%TYPE;

        PROCEDURE pCierracuCicloConsumo
        IS
            -- Nombre de este método
            csbMT_NAME1  VARCHAR2(105) := csbMT_NAME || '.pCierracuCicloConsumo';
        BEGIN

            pkg_traza.trace(csbMT_NAME1, cnuNVLTRC, pkg_traza.csbINICIO);

            IF cuCicloConsumo%ISOPEN THEN
                CLOSE cuCicloConsumo;
            END IF;

            pkg_traza.trace(csbMT_NAME1, cnuNVLTRC, pkg_traza.csbFIN);

        END pCierracuCicloConsumo;

    BEGIN

        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

        pCierracuCicloConsumo;

        OPEN cuCicloConsumo;
        FETCH cuCicloConsumo INTO nuiCicloConsumo;
        CLOSE cuCicloConsumo;

        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

        RETURN nuiCicloConsumo;

    EXCEPTION
        WHEN OTHERS THEN
            pkg_error.SetError;
			pkg_error.getError(nuErrorCode,sbMensError);
			pkg_traza.trace(csbMT_NAME||' '||sbMensError, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME,cnuNVLTRC,pkg_traza.fsbFIN_ERR);	
            pCierracuCicloConsumo;
            RETURN nuiCicloConsumo;
    END fnuCicloConsumo;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuCicloFacturacion
    Descripcion     : Retorna ciclo de facturación
    Autor           : Lubin Pineda - MVM
    Fecha           : 27-07-2023
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    jpinedc     27-07-2023  OSF-1249    Creacion
    ***************************************************************************/
    FUNCTION fnuCicloFacturacion
    (
        inuProducto                  IN  servsusc.sesunuse%TYPE
    )
    RETURN servsusc.sesucicl%TYPE
    IS

        -- Nombre de ste mÉtodo
        csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.fnuCicloFacturacion';
        nuerrorcode NUMBER;         -- se almacena codigo de error
        sbmenserror VARCHAR2(2000);  -- se almacena descripcion del error 
		

        CURSOR cuCicloFacturacion
        IS
        SELECT  ss.sesucicl
        FROM servsusc ss
        WHERE ss.sesunuse = inuProducto;

        nuCicloFacturacion    servsusc.sesucicl%TYPE;

        PROCEDURE pCierracuCicloFacturacion
        IS
            -- Nombre de este método
            csbMT_NAME1  VARCHAR2(105) := csbMT_NAME || '.pCierracuCicloFacturacion';
        BEGIN

            pkg_traza.trace(csbMT_NAME1, cnuNVLTRC, pkg_traza.csbINICIO);

            IF cuCicloFacturacion%ISOPEN THEN
                CLOSE cuCicloFacturacion;
            END IF;

            pkg_traza.trace(csbMT_NAME1, cnuNVLTRC, pkg_traza.csbFIN);

        END pCierracuCicloFacturacion;

    BEGIN

        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

        pCierracuCicloFacturacion;

        OPEN cuCicloFacturacion;
        FETCH cuCicloFacturacion INTO nuCicloFacturacion;
        CLOSE cuCicloFacturacion;

        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

        RETURN nuCicloFacturacion;

    EXCEPTION
        WHEN OTHERS THEN
            pkg_error.SetError;
			pkg_error.getError(nuErrorCode,sbMensError);
			pkg_traza.trace(csbMT_NAME||' '||sbMensError, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME,cnuNVLTRC,pkg_traza.fsbFIN_ERR);	
            pCierracuCicloFacturacion;
            RETURN nuCicloFacturacion;
    END fnuCicloFacturacion;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuTipoProducto
    Descripcion     : Retorna el tipo de producto
    Autor           : Lubin Pineda - MVM
    Fecha           : 27-07-2023
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    jpinedc     27-07-2023  OSF-1249    Creacion
    ***************************************************************************/
    FUNCTION fnuTipoProducto
    (
        inuProducto                  IN  servsusc.sesunuse%TYPE
    )
    RETURN servsusc.sesuserv%TYPE
    IS

        -- Nombre de ste mÉtodo
        csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.fnuTipoProducto';
        nuerrorcode NUMBER;         -- se almacena codigo de error
        sbmenserror VARCHAR2(2000);  -- se almacena descripcion del error 

        CURSOR cuTipoProducto
        IS
        SELECT  ss.sesuserv
        FROM servsusc ss
        WHERE ss.sesunuse = inuProducto;

        nuTipoProducto    servsusc.sesuserv%TYPE;

        PROCEDURE pCierracuTipoProducto
        IS
            -- Nombre de este método
            csbMT_NAME1  VARCHAR2(105) := csbMT_NAME || '.pCierracuTipoProducto';
        BEGIN

            pkg_traza.trace(csbMT_NAME1, cnuNVLTRC, pkg_traza.csbINICIO);

            IF cuTipoProducto%ISOPEN THEN
                CLOSE cuTipoProducto;
            END IF;

            pkg_traza.trace(csbMT_NAME1, cnuNVLTRC, pkg_traza.csbFIN);

        END pCierracuTipoProducto;

    BEGIN

        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

        pCierracuTipoProducto;

        OPEN cuTipoProducto;
        FETCH cuTipoProducto INTO nuTipoProducto;
        CLOSE cuTipoProducto;

        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

        RETURN nuTipoProducto;

    EXCEPTION
        WHEN OTHERS THEN
            pkg_error.SetError;
			pkg_error.getError(nuErrorCode,sbMensError);
			pkg_traza.trace(csbMT_NAME||' '||sbMensError, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME,cnuNVLTRC,pkg_traza.fsbFIN_ERR);	
            pCierracuTipoProducto;
            RETURN nuTipoProducto;
    END fnuTipoProducto;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuContrato
    Descripcion     : Retorna el contrato
    Autor           : Lubin Pineda - MVM
    Fecha           : 27-07-2023
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    jpinedc     27-07-2023  OSF-1249    Creacion
    ***************************************************************************/
    FUNCTION fnuContrato
    (
        inuProducto                  IN  servsusc.sesunuse%TYPE
    )
    RETURN servsusc.sesususc%TYPE
    IS

        -- Nombre de ste mÉtodo
        csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.fnuContrato';
        nuerrorcode NUMBER;         -- se almacena codigo de error
        sbmenserror VARCHAR2(2000);  -- se almacena descripcion del error 


        CURSOR cuContrato
        IS
        SELECT  ss.sesususc
        FROM servsusc ss
        WHERE ss.sesunuse = inuProducto;

        nuContrato    servsusc.sesususc%TYPE;

        PROCEDURE pCierracuContrato
        IS
            -- Nombre de este método
            csbMT_NAME1  VARCHAR2(105) := csbMT_NAME || '.pCierracuContrato';
        BEGIN

            pkg_traza.trace(csbMT_NAME1, cnuNVLTRC, pkg_traza.csbINICIO);

            IF cuContrato%ISOPEN THEN
                CLOSE cuContrato;
            END IF;

            pkg_traza.trace(csbMT_NAME1, cnuNVLTRC, pkg_traza.csbFIN);

        END pCierracuContrato;

    BEGIN

        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

        pCierracuContrato;

        OPEN cuContrato;
        FETCH cuContrato INTO nuContrato;
        CLOSE cuContrato;

        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

        RETURN nuContrato;

    EXCEPTION
        WHEN OTHERS THEN
            pkg_error.SetError;
			pkg_error.getError(nuErrorCode,sbMensError);
			pkg_traza.trace(csbMT_NAME||' '||sbMensError, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME,cnuNVLTRC,pkg_traza.fsbFIN_ERR);	
            pCierracuContrato;
            RETURN nuContrato;
    END fnuContrato;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fdtFechaInstalacion
    Descripcion     : Retorna fecha de instalación
    Autor           : Lubin Pineda - MVM
    Fecha           : 27-07-2023
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    jpinedc     27-07-2023  OSF-1249    Creacion
    ***************************************************************************/
    FUNCTION fdtFechaInstalacion
    (
        inuProducto                  IN  servsusc.sesunuse%TYPE
    )
    RETURN servsusc.sesufein%TYPE
    IS

        -- Nombre de ste mÉtodo
        csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.fdtFechaInstalacion';
        nuerrorcode NUMBER;         -- se almacena codigo de error
        sbmenserror VARCHAR2(2000);  -- se almacena descripcion del error 

        CURSOR cuFechaInstalacion
        IS
        SELECT  ss.sesufein
        FROM servsusc ss
        WHERE ss.sesunuse = inuProducto;

        dtFechaInstalacion    servsusc.sesufein%TYPE;

        PROCEDURE pCierracuFechaInstalacion
        IS
            -- Nombre de este método
            csbMT_NAME1  VARCHAR2(105) := csbMT_NAME || '.pCierracuFechaInstalacion';
        BEGIN

            pkg_traza.trace(csbMT_NAME1, cnuNVLTRC, pkg_traza.csbINICIO);

            IF cuFechaInstalacion%ISOPEN THEN
                CLOSE cuFechaInstalacion;
            END IF;

            pkg_traza.trace(csbMT_NAME1, cnuNVLTRC, pkg_traza.csbFIN);

        END pCierracuFechaInstalacion;

    BEGIN

        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

        pCierracuFechaInstalacion;

        OPEN cuFechaInstalacion;
        FETCH cuFechaInstalacion INTO dtFechaInstalacion;
        CLOSE cuFechaInstalacion;

        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

        RETURN dtFechaInstalacion;

    EXCEPTION
        WHEN OTHERS THEN
            pkg_error.SetError;
			pkg_error.getError(nuErrorCode,sbMensError);
			pkg_traza.trace(csbMT_NAME||' '||sbMensError, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME,cnuNVLTRC,pkg_traza.fsbFIN_ERR);	
            pCierracuFechaInstalacion;
            RETURN dtFechaInstalacion;
    END fdtFechaInstalacion;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuMetodoVariacion
    Descripcion     : Retorna método variación del consumo
    Autor           : Lubin Pineda - MVM
    Fecha           : 27-07-2023
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    jpinedc     27-07-2023  OSF-1249    Creacion
    ***************************************************************************/
    FUNCTION fnuMetodoVariacion
    (
        inuProducto                  IN  servsusc.sesunuse%TYPE
    )
    RETURN servsusc.sesumecv%TYPE
    IS

        -- Nombre de ste mÉtodo
        csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.fnuMetodoVariacion';
        nuerrorcode NUMBER;         -- se almacena codigo de error
        sbmenserror VARCHAR2(2000);  -- se almacena descripcion del error 

        CURSOR cuMetodoVariacion
        IS
        SELECT  ss.sesumecv
        FROM servsusc ss
        WHERE ss.sesunuse = inuProducto;

        nuMetodoVariacion    servsusc.sesumecv%TYPE;

        PROCEDURE pCierracuMetodoVariacion
        IS
            -- Nombre de este método
            csbMT_NAME1  VARCHAR2(105) := csbMT_NAME || '.pCierracuMetodoVariacion';
        BEGIN

            pkg_traza.trace(csbMT_NAME1, cnuNVLTRC, pkg_traza.csbINICIO);

            IF cuMetodoVariacion%ISOPEN THEN
                CLOSE cuMetodoVariacion;
            END IF;

            pkg_traza.trace(csbMT_NAME1, cnuNVLTRC, pkg_traza.csbFIN);

        END pCierracuMetodoVariacion;

    BEGIN

        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

        pCierracuMetodoVariacion;

        OPEN cuMetodoVariacion;
        FETCH cuMetodoVariacion INTO nuMetodoVariacion;
        CLOSE cuMetodoVariacion;

        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

        RETURN nuMetodoVariacion;

    EXCEPTION
        WHEN OTHERS THEN
            pkg_error.SetError;
			pkg_error.getError(nuErrorCode,sbMensError);
			pkg_traza.trace(csbMT_NAME||' '||sbMensError, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME,cnuNVLTRC,pkg_traza.fsbFIN_ERR);	
            pCierracuMetodoVariacion;
            RETURN nuMetodoVariacion;
    END fnuMetodoVariacion;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuEstadoProducto
    Descripcion     : Retorna el estado del producto
    Autor           : Lubin Pineda - MVM
    Fecha           : 27-07-2023
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    jpinedc     27-07-2023  OSF-1249    Creacion
    ***************************************************************************/
    FUNCTION fnuEstadoProducto
    (
        inuProducto                  IN  pr_product.product_id%TYPE
    )
    RETURN pr_product.product_status_id%TYPE
    IS

        -- Nombre de ste mÉtodo
        csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.fnuEstadoProducto';
        nuerrorcode NUMBER;         -- se almacena codigo de error
        sbmenserror VARCHAR2(2000);  -- se almacena descripcion del error 

        CURSOR cuEstadoProducto
        IS
        SELECT  pr.product_status_id
        FROM pr_product pr
        WHERE pr.product_id = inuProducto;

        nuEstadoProducto    pr_product.product_status_id%TYPE;

        PROCEDURE pCierracuEstadoProducto
        IS
            -- Nombre de este método
            csbMT_NAME1  VARCHAR2(105) := csbMT_NAME || '.pCierracuEstadoProducto';
        BEGIN

            pkg_traza.trace(csbMT_NAME1, cnuNVLTRC, pkg_traza.csbINICIO);

            IF cuEstadoProducto%ISOPEN THEN
                CLOSE cuEstadoProducto;
            END IF;

            pkg_traza.trace(csbMT_NAME1, cnuNVLTRC, pkg_traza.csbFIN);

        END pCierracuEstadoProducto;

    BEGIN

        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

        pCierracuEstadoProducto;

        OPEN cuEstadoProducto;
        FETCH cuEstadoProducto INTO nuEstadoProducto;
        CLOSE cuEstadoProducto;

        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

        RETURN nuEstadoProducto;

    EXCEPTION
        WHEN OTHERS THEN
            pkg_error.SetError;
			pkg_error.getError(nuErrorCode,sbMensError);
			pkg_traza.trace(csbMT_NAME||' '||sbMensError, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME,cnuNVLTRC,pkg_traza.fsbFIN_ERR);	
            pCierracuEstadoProducto;
            RETURN nuEstadoProducto;
    END fnuEstadoProducto;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuIdDireccInstalacion
    Descripcion     : Retorna el id de la dirección de instalación
    Autor           : Lubin Pineda - MVM
    Fecha           : 27-07-2023
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    jpinedc     27-07-2023  OSF-1249    Creacion
    ***************************************************************************/
    FUNCTION fnuIdDireccInstalacion
    (
        inuProducto                  IN  pr_product.product_id%TYPE
    )
    RETURN pr_product.address_id%TYPE
    IS

        -- Nombre de ste mÉtodo
        csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.fnuIdDireccInstalacion';
        nuerrorcode NUMBER;         -- se almacena codigo de error
        sbmenserror VARCHAR2(2000);  -- se almacena descripcion del error 

        CURSOR cuIdDireccInstalacion
        IS
        SELECT pr.address_id
        FROM pr_product pr
        WHERE pr.product_id = inuProducto;

        nuIdDireccInstalacion    pr_product.address_id%TYPE;

        PROCEDURE pCierracuIdDireccInstalacion
        IS
            -- Nombre de este método
            csbMT_NAME1  VARCHAR2(105) := csbMT_NAME || '.pCierracuIdDireccInstalacion';
        BEGIN

            pkg_traza.trace(csbMT_NAME1, cnuNVLTRC, pkg_traza.csbINICIO);

            IF cuIdDireccInstalacion%ISOPEN THEN
                CLOSE cuIdDireccInstalacion;
            END IF;

            pkg_traza.trace(csbMT_NAME1, cnuNVLTRC, pkg_traza.csbFIN);

        END pCierracuIdDireccInstalacion;

    BEGIN

        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

        pCierracuIdDireccInstalacion;

        OPEN cuIdDireccInstalacion;
        FETCH cuIdDireccInstalacion INTO nuIdDireccInstalacion;
        CLOSE cuIdDireccInstalacion;

        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

        RETURN nuIdDireccInstalacion;

    EXCEPTION
        WHEN OTHERS THEN
            pkg_error.SetError;
			pkg_error.getError(nuErrorCode,sbMensError);
			pkg_traza.trace(csbMT_NAME||' '||sbMensError, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME,cnuNVLTRC,pkg_traza.fsbFIN_ERR);	
            pCierracuIdDireccInstalacion;
            RETURN nuIdDireccInstalacion;
    END fnuIdDireccInstalacion;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuIdActivOrdenSusp
    Descripcion     : Retorna el id de la actividad de orden de suspensión
    Autor           : Lubin Pineda - MVM
    Fecha           : 27-07-2023
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    jpinedc     27-07-2023  OSF-1249    Creacion
    ***************************************************************************/
    FUNCTION fnuIdActivOrdenSusp
    (
        inuProducto                  IN  pr_product.product_id%TYPE
    )
    RETURN pr_product.suspen_ord_act_id%TYPE
    IS

        -- Nombre de ste mÉtodo
        csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.fnuIdActivOrdenSusp';
        nuerrorcode NUMBER;         -- se almacena codigo de error
        sbmenserror VARCHAR2(2000);  -- se almacena descripcion del error 

        CURSOR cuIdActivOrdenSusp
        IS
        SELECT  pr.suspen_ord_act_id
        FROM pr_product pr
        WHERE pr.product_id = inuProducto;

         nuIdActivOrdenSusp    pr_product.suspen_ord_act_id%TYPE;

        PROCEDURE pCierracuIdActivOrdenSusp
        IS
            -- Nombre de este método
            csbMT_NAME1  VARCHAR2(105) := csbMT_NAME || '.pCierracuIdActivOrdenSusp';
        BEGIN

            pkg_traza.trace(csbMT_NAME1, cnuNVLTRC, pkg_traza.csbINICIO);

            IF cuIdActivOrdenSusp%ISOPEN THEN
                CLOSE cuIdActivOrdenSusp;
            END IF;

            pkg_traza.trace(csbMT_NAME1, cnuNVLTRC, pkg_traza.csbFIN);

        END pCierracuIdActivOrdenSusp;

    BEGIN

        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

        pCierracuIdActivOrdenSusp;

        OPEN cuIdActivOrdenSusp;
        FETCH cuIdActivOrdenSusp INTO  nuIdActivOrdenSusp;
        CLOSE cuIdActivOrdenSusp;

        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

        RETURN  nuIdActivOrdenSusp;

    EXCEPTION
        WHEN OTHERS THEN
            pkg_error.SetError;
			pkg_error.getError(nuErrorCode,sbMensError);
			pkg_traza.trace(csbMT_NAME||' '||sbMensError, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME,cnuNVLTRC,pkg_traza.fsbFIN_ERR);	
            pCierracuIdActivOrdenSusp;
            RETURN  nuIdActivOrdenSusp;
    END fnuIdActivOrdenSusp;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuObtenerLocalidad
    Descripcion     : Retorna el id de la locaclidad de la dirección del producto
    Autor           : Adriana Vargas - MVM
    Fecha           : 29-09-2023

    Parametros de Entrada
    inuProducto     Código del producto

    Parametros de Salida
    geograp_location_id Id de la localidad de la dirección del producto

    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    Adrianavg   29-09-2023  OSF-1666 Creacion
    Adrianavg   02-10-2023  OSF-1666 Ajuste por validación ténica: a la fnuObtenerLocalidad
                                     añadirle en la excception la captura del sms de error y que quede en la traza
    ***************************************************************************/
    FUNCTION fnuObtenerLocalidad
    (
        inuProducto                  IN  pr_product.product_id%TYPE
    )
    RETURN ab_address.geograp_location_id%TYPE
    IS
        -- Nombre de este método
        csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.fnuObtenerLocalidad';
        nuErrorCode NUMBER;         -- se almacena codigo de error
        sbMensError VARCHAR2(2000);  -- se almacena descripcion del error

        CURSOR cuLocalidad
        IS
        select ab.geograp_location_id
          from pr_product pr,
               ab_address ab
         where pr.address_id = ab.address_id
           and pr.product_id = inuProducto;

        nuLocalidad ab_address.geograp_location_id%TYPE;

        PROCEDURE pCierracuLocalidad
        IS
            -- Nombre de este método
            csbMT_NAME1  VARCHAR2(105) := csbMT_NAME || '.pCierracuLocalidad';
        BEGIN

            pkg_traza.trace(csbMT_NAME1, cnuNVLTRC, pkg_traza.csbINICIO);

            IF cuLocalidad%ISOPEN THEN
                CLOSE cuLocalidad;
            END IF;

            pkg_traza.trace(csbMT_NAME1, cnuNVLTRC, pkg_traza.csbFIN);

        END pCierracuLocalidad;

    BEGIN

        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

        pCierracuLocalidad;

        OPEN cuLocalidad;
        FETCH cuLocalidad INTO nuLocalidad;
        CLOSE cuLocalidad;

        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

        RETURN nuLocalidad;

    EXCEPTION
        WHEN OTHERS THEN
            pkg_error.SetError;
            Pkg_Error.GetError(nuErrorCode, sbMensError);
            pCierracuLocalidad;
			pkg_traza.trace(csbMT_NAME||' '||sbMensError, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME,cnuNVLTRC,pkg_traza.fsbFIN_ERR);
            RETURN nuLocalidad;
    END fnuObtenerLocalidad;


    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : PRC_EsProvisional
    Descripcion     : Recibe el producto y devuelve si es o no provisional
    Autor           : Adriana Vargas - MVM
    Fecha           : 04-10-2023

    Parametros de Entrada
    inuproduct_id     Código del producto

    Parametros de Salida
    isbEsProvisional  Indicador si el producto es provisional o no, en letra S/N

    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    Adrianavg   04-10-2023  OSF-1689 Creacion
    ***************************************************************************/
    PROCEDURE PRC_EsProvisional
    (
        inuproduct_id        IN  pr_product.product_id%TYPE,
        isbEsProvisional     OUT pr_product.is_provisional%TYPE
    )
    IS
        csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.PRC_EsProvisional';
        nuErrorCode NUMBER;         -- se almacena codigo de error
        sbMensError VARCHAR2(2000);  -- se almacena descripcion del error
        sbcuRecord  sbtProducto;
    BEGIN
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

        PRC_CierreCursorRecord; --validar que el cursor este cerrado

        OPEN cuRecord(inuproduct_id);
        FETCH cuRecord INTO sbcuRecord;
        CLOSE cuRecord;

        isbEsProvisional:= sbcuRecord.is_provisional;
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    EXCEPTION
        WHEN OTHERS THEN
            pkg_error.SetError;
            Pkg_Error.GetError(nuErrorCode, sbMensError);
			pkg_traza.trace(csbMT_NAME||' '||sbMensError, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME,cnuNVLTRC,pkg_traza.fsbFIN_ERR);
    END;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : PRC_ClaseProducto
    Descripcion     : Recibe el producto y devuelve la clase de producto
    Autor           : Adriana Vargas - MVM
    Fecha           : 04-10-2023

    Parametros de Entrada
    inuproduct_id     Código del producto

    Parametros de Salida
    isbclass_product  Clase de Producto

    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    Adrianavg   04-10-2023  OSF-1689 Creacion
    ***************************************************************************/
    PROCEDURE PRC_ClaseProducto
    (
        inuproduct_id        IN  pr_product.product_id%TYPE,
        isbclass_product     OUT pr_product.class_product%TYPE
    )
    IS
        csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.PRC_ClaseProducto';
        nuErrorCode NUMBER;         -- se almacena codigo de error
        sbMensError VARCHAR2(2000);  -- se almacena descripcion del error
        sbcuRecord  sbtProducto;
    BEGIN
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

        PRC_CierreCursorRecord; --validar que el cursor este cerrado

        OPEN cuRecord(inuproduct_id);
        FETCH cuRecord INTO sbcuRecord;
        CLOSE cuRecord;

        isbclass_product:= sbcuRecord.class_product;
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    EXCEPTION
        WHEN OTHERS THEN
            pkg_error.SetError;
            Pkg_Error.GetError(nuErrorCode, sbMensError);
			pkg_traza.trace(csbMT_NAME||' '||sbMensError, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME,cnuNVLTRC,pkg_traza.fsbFIN_ERR);
    END;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : PRC_TraeRegistroProduct
    Descripcion     : Devuelva un registro (rcProduct ) con la información relacionada al subtype sbtProducto
    Autor           : Adriana Vargas - MVM
    Fecha           : 04-10-2023

    Parametros de Entrada
    inuproduct_id     Código del producto

    Parametros de Salida
    isbrcProduct      Registro de la tabla Producto

    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    Adrianavg   04-10-2023  OSF-1689 Creacion
    ***************************************************************************/
    PROCEDURE PRC_TraeRegistroProduct
    (
        inuproduct_id       IN  pr_product.product_id%TYPE,
        isbrcProduct        OUT NOCOPY sbtProducto
    )
    IS
        csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.PRC_TraeRegistroProduct';
        nuErrorCode NUMBER;         -- se almacena codigo de error
        sbMensError VARCHAR2(2000);  -- se almacena descripcion del error
        sbcuRecord  sbtProducto;

    BEGIN
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

        PRC_CierreCursorRecord; --validar que el cursor este cerrado

        OPEN cuRecord(inuproduct_id);
        FETCH cuRecord INTO isbrcProduct;
        CLOSE cuRecord;

        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    EXCEPTION
        WHEN OTHERS THEN
            pkg_error.SetError;
            Pkg_Error.GetError(nuErrorCode, sbMensError);
			pkg_traza.trace(csbMT_NAME||' '||sbMensError, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME,cnuNVLTRC,pkg_traza.fsbFIN_ERR);
    END;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fblExisteProducto
    Descripcion     : Retorna falso o verdadero si un producto existe o no
    Autor           : Adriana Vargas - MVM
    Fecha           : 04-10-2023

    Parametros de Entrada
    inuproduct_id     Código del producto

    Parametros de Salida
    sbcuRecord        Existencia del producto, TRUE o FALSE

    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    Adrianavg   04-10-2023  OSF-1689 Creacion
    jsoto       17/06/2024  OSF-2838 Se cambia el nombre de la función fsbExisteProducto por fblExisteProducto
    ***************************************************************************/
    FUNCTION fblExisteProducto
    (
        inuproduct_id         IN  pr_product.product_id%TYPE
    )
    RETURN BOOLEAN
    IS
        csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.fblExisteProducto';
        nuErrorCode NUMBER;         -- se almacena codigo de error
        sbMensError VARCHAR2(2000);  -- se almacena descripcion del error
        sbcuRecord sbtProducto;


    BEGIN
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

        PRC_CierreCursorRecord; --validar que el cursor este cerrado

        OPEN cuRecord(inuproduct_id);
        FETCH cuRecord INTO sbcuRecord;
            IF cuRecord%notfound THEN
                CLOSE cuRecord;
                pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
                RETURN( FALSE );
            ELSE
               pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
               RETURN( TRUE );
            END IF;
        CLOSE cuRecord;

    EXCEPTION
        WHEN OTHERS THEN
            pkg_error.SetError;
            Pkg_Error.GetError(nuErrorCode, sbMensError);
			pkg_traza.trace(csbMT_NAME||' '||sbMensError, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME,cnuNVLTRC,pkg_traza.fsbFIN_ERR);
            RETURN( FALSE );
    END;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : PRC_CierreCursorRecord
    Descripcion     : Validar que el cursor cuRecord se encuentre cerrado
    Autor           : Adriana Vargas - MVM
    Fecha           : 04-10-2023

    Parametros de Entrada

    Parametros de Salida

    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    Adrianavg   04-10-2023  OSF-1689 Creacion
    ***************************************************************************/
    PROCEDURE PRC_CierreCursorRecord
    IS
        -- Nombre de este método
        csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.PRC_CierreCursorRecord';
        nuErrorCode NUMBER;         -- se almacena codigo de error
        sbMensError VARCHAR2(2000);  -- se almacena descripcion del error
    BEGIN
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

        IF cuRecord%ISOPEN THEN
            CLOSE cuRecord;
        END IF;

        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
    EXCEPTION
        WHEN OTHERS THEN
            pkg_error.SetError;
            Pkg_Error.GetError(nuErrorCode, sbMensError);
			pkg_traza.trace(csbMT_NAME||' '||sbMensError, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME,cnuNVLTRC,pkg_traza.fsbFIN_ERR);
    END PRC_CierreCursorRecord;
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuTraerCommercialPlanId
    Descripcion     : Retorna el id del plan comercial segun el id de producto
    Autor           : Adriana Vargas - MVM
    Fecha           : 21-12-2023

    Parametros de Entrada

    Parametros de Salida

    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    Adrianavg   21-12-2023  OSF-1805 Creacion
                                     Se ajusta declaración de las variables de traza en el encabezado
    ***************************************************************************/
    -- Retorna el id del pan comercial segun el producto id
    FUNCTION fnuTraerCommercialPlanId
    (
        inuproduct_id IN pr_product.product_id%TYPE
    ) 
    RETURN pr_product.commercial_plan_id%TYPE IS

        csbmt_name  VARCHAR2(70) := csbsp_name || 'fnuTraerCommercialPlanId';
        nuerrorcode NUMBER;         -- se almacena codigo de error
        sbmenserror VARCHAR2(2000);  -- se almacena descripcion del error 
        sbcuRecord  cuRecord%rowtype; 
    BEGIN
        pkg_traza.trace(csbmt_name, cnuNVLTRC, pkg_traza.csbINICIO);
        pkg_traza.trace(csbmt_name||' inuproduct_id: '||inuproduct_id, cnuNVLTRC);
        prc_cierrecursorrecord; --validar que el cursor este cerrado

        OPEN curecord(inuproduct_id);
        FETCH curecord INTO sbcuRecord;
        CLOSE curecord;
        pkg_traza.trace(csbmt_name||' commercial_plan_id: '||sbcuRecord.commercial_plan_id, cnuNVLTRC); 
        pkg_traza.trace(csbmt_name, cnuNVLTRC, pkg_traza.csbFIN);
        RETURN sbcuRecord.commercial_plan_id;

    EXCEPTION
        WHEN OTHERS THEN
            pkg_error.seterror;
            pkg_error.geterror(nuerrorcode, sbmenserror);
			pkg_traza.trace(csbMT_NAME||' '||sbMensError, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME,cnuNVLTRC,pkg_traza.fsbFIN_ERR);
    END;

  --Retorna la fecha de retiro del producto
    function fdtFechaRetiro
    (
        inuproduct_id    IN pr_product.product_id%type
    )
    return servsusc.sesufere%type
    is
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
     Programa        : fdtFechaRetiro
     Descripcion     : Retorna la fecha de retiro del servicios.
                       este método se hace para reemplazar a pktblServsusc.fdtGetRetireDate
     Autor           : Edilay Peña Osorio - MVM
     Fecha           : 31/01/2024

     Parametros de Entrada

     Nombre                  Tipo                    Descripción
     ===================    =========                =============================
     inuproduct_id          pr_product.product_id    Id del producto.

     Retorno
     Nombre                  Tipo                    Descripción
     ===================    =========                =============================
     dtsesufere             servsusc.sesufere        Fecha retiro del servicio.

     Modificaciones  :
     =========================================================
     Autor       Fecha           Descripción
     epenao    31/01/2024        OSF-1835: Creación
    ***************************************************************************/

        csbMetodo  CONSTANT VARCHAR2(100) := csbsp_name||'fdtFechaRetiro'; --Nombre del método en la traza
        CURSOR cuSesufere
        IS
        SELECT  ss.sesufere
        FROM servsusc ss
        WHERE ss.sesunuse = inuproduct_id;

        dtsesufere    servsusc.sesufere%TYPE := null;
        sbmenserror   VARCHAR2(2000); -- descripcion error
        nuerrorcode   NUMBER;         -- codigo error

    begin
       pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbINICIO);
       open cuSesufere;
            fetch cuSesufere into dtsesufere;
           if cuSesufere%NOTFOUND then
              --Levanta excepción para mantener el comportamiento del
              --método al que está reemplazando.
               RAISE PKG_ERROR.CONTROLLED_ERROR;
           end if;
       close cuSesufere;

       pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN);
       return dtsesufere;
    EXCEPTION
        WHEN OTHERS THEN
            pkg_error.SetError;
            Pkg_Error.GetError(nuErrorCode, sbMensError);
            pkg_traza.trace('Error: '||nuErrorCode||'-'||sbMensError);
            pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN_ERR);
            RAISE PKG_ERROR.CONTROLLED_ERROR;
    end fdtFechaRetiro;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
     Programa        : fnuObtieneMarcaProducto
     Descripcion     : Retorna la marca del producto en ldc_marca_producto.
     Autor           : Jorge Valiente Horbath - Lubin Pineda - GlobalMVM
     Fecha           : 26-09-2024

     Parametros de Entrada

     Nombre                  Tipo                    Descripción
     ===================    =========                =============================
     inuProducto            pr_product.product_id    Id del producto.

     Retorno
     Nombre                  Tipo                                       Descripción
     ===================    =========                                   =============================
     nuMarcaProducto        ldc_marca_producto.suspension_type_id        Marca del producto

     Modificaciones  :
     =========================================================
     Autor       Fecha           Descripción
     jvaliente  26-09-2024        OSF-3368: Creación   
    ***************************************************************************/
    FUNCTION fnuObtieneMarcaProducto
    (
        inuProducto    IN pr_product.product_id%TYPE
    )
    RETURN ldc_marca_producto.suspension_type_id%TYPE
    IS

        csbMetodo       VARCHAR2(70) := csbSP_NAME || 'fnuObtieneMarcaProducto';
        nuErrorCode     NUMBER; 
        sbMensError     VARCHAR2(4000);
        nuMarcaProducto ldc_marca_producto.suspension_type_id%TYPE;

        CURSOR cuMarca IS
        SELECT mp.suspension_type_id
        FROM ldc_marca_producto mp
        WHERE mp.id_producto = inuProducto;

  BEGIN
    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

    pkg_traza.trace('Producto: ' || inuProducto, pkg_traza.cnuNivelTrzDef);

    OPEN cuMarca;
    FETCH cuMarca into nuMarcaProducto;
    CLOSE cuMarca;
    
    IF nuMarcaProducto IS NULL THEN
        pkg_traza.trace('nuMarcaProducto IS NULL', pkg_traza.cnuNivelTrzDef);
        nuMarcaProducto := cnuMARCA_101;
    END IF;
    
    pkg_traza.trace('nuMarcaProducto|' || nuMarcaProducto, pkg_traza.cnuNivelTrzDef);
    
    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

    RETURN nuMarcaProducto;

  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
      pkg_Error.getError(nuErrorCode, sbMensError);
      pkg_traza.trace('sberror: ' || sbMensError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
      RETURN(-1);

    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(nuErrorCode, sbMensError);
      pkg_traza.trace('sberror: ' || sbMensError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
      RETURN(-1);
  END fnuObtieneMarcaProducto; 

END pkg_bcproducto;
/

PROMPT Otorgando permisos de ejecución para adm_person.pkg_bcproducto
BEGIN
    pkg_utilidades.prAplicarPermisos('PKG_BCPRODUCTO', 'ADM_PERSON');
END;
/

PROMPT OTORGA PERMISOS a REXEREPORTES sobre el paquete PKG_BCPRODUCTO
GRANT EXECUTE ON ADM_PERSON.PKG_BCPRODUCTO TO REXEREPORTES;
/
