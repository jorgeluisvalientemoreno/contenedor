CREATE OR REPLACE PACKAGE adm_person.pkg_bccontrato IS
/*******************************************************************************
    Fuente=Propiedad Intelectual de Gases del Caribe
    pkg_bccontrato
    Autor       :   Lubin Pineda - MVM
    Fecha       :   25-07-2023
    Descripcion :   Paquete con los métodos CRUD para manejo de información
                    sobre la tabla OPEN.SUSCRIPC
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     25-07-2023  OSF-1249 Creacion
    jpinedc     31-07-2023  OSF-1249 Ajustes por revisión técnica
    diana.montes05-09-2023  OSF-1478 Se crean los procedimientos
                            [UPDSUSCCEMD][UPDSUSCCEMF]
                            [UPDSUSCCOEM]
    jsoto       17/06/2024  OSF-2838    Se cambia en la función fnuCodigoProcFacturacion 
                                        suscsafa por suscnupr como dato retornado
    jcatuche    06/09/2024  OSF-3266    Se crea la función fblExiste
	jerazomvm	30/12/2024	OSF-3816	Se crea la función fnuObtProdPorTipoYEstado    
    jpinedc     21/02/2025  OSF-4037    Se crea fblTieneProdDiferACobrServ
    jherazo     21/02/2025  OSF-4037    Se crea prcObtProductosXTipoYContrato	
    jherazo     21/02/2025  OSF-4037    Se modifica fnuObtProdPorTipoYEstado
    PAcosta     28/03/2025  OSF-4140    Se crea la funcion fblExisActPorContratoTipoSol
                                        Se aplica uso de constantes globales para el manejo de 
                                         constantes de traza.
*******************************************************************************/
    SUBTYPE sbtContrato IS suscripc%ROWTYPE;
    -- Retona Identificador del ultimo caso que hizo cambios
    FUNCTION fsbVersion RETURN VARCHAR2;

    -- Retorna Ciclo de Facturación del contrato
    FUNCTION fnuCicloFacturacion
    (
        inuContrato                  IN  suscripc.susccodi%TYPE   
    )
    RETURN suscripc.susccicl%TYPE;

    -- Retorna tipo de contrato    
    FUNCTION fnuTipoContrato
    (
        inuContrato                  IN  suscripc.susccodi%TYPE   
    )
    RETURN suscripc.susctisu%TYPE;

    -- Retorna id dirección reparto    
    FUNCTION fnuIdDireccReparto
    (
        inuContrato                  IN  suscripc.susccodi%TYPE   
    )
    RETURN suscripc.susciddi%TYPE;

    -- Retorna id de cliente
    FUNCTION fnuIdCliente
    (
        inuContrato                  IN  suscripc.susccodi%TYPE   
    )
    RETURN suscripc.suscclie%TYPE;

    -- Retorna Valor Saldo a Favor
    FUNCTION fnuSaldoAfavor
    (
        inuContrato                  IN  suscripc.susccodi%TYPE   
    )
    RETURN suscripc.suscsafa%TYPE;

    -- Retorna Código Proceso Facturación
    FUNCTION fnuCodigoProcFacturacion
    (
        inuContrato                  IN  suscripc.susccodi%TYPE   
    )
    RETURN suscripc.suscnupr%TYPE;                         
    PROCEDURE UPDSUSCCEMD
	(
		INUSUSCCODI IN SUSCRIPC.SUSCCODI%TYPE,
		INUSUSCCEMD IN SUSCRIPC.SUSCCEMD%TYPE
	);
	PROCEDURE UPDSUSCCEMF
	(
		INUSUSCCODI IN SUSCRIPC.SUSCCODI%TYPE,
		INUSUSCCEMF IN SUSCRIPC.SUSCCEMF%TYPE
	);
	PROCEDURE UPDSUSCCOEM
	(
		INUSUSCCODI IN SUSCRIPC.SUSCCODI%TYPE,
		INUSUSCCOEM IN SUSCRIPC.SUSCCOEM%TYPE
	);

	--Valida que exista el contrato
    FUNCTION fblExiste
    (
       inuContrato             IN  suscripc.susccodi%TYPE
    ) RETURN BOOLEAN;

	-- Retorna el producto de gas activo                   
    FUNCTION fnuObtProdPorTipoYEstado(inuContrato		IN suscripc.susccodi%TYPE,
									  inuTipoProducto	IN pr_product.product_type_id%TYPE,
									  inuEstado			IN pr_product.product_status_id%TYPE
									  )
    RETURN pr_product.product_id%TYPE;    
    FUNCTION frcObtInfoContrato(inuContrato IN suscripc.susccodi%type) RETURN sbtContrato;
    /**************************************************************************
     Proceso     : frcObtInfoContrato
     Autor       : Luis Javier Lopez Barrios 
     Fecha       : 2025-01-15
     Ticket      : OSF-3855
     Descripcion : devuelve registro de un contrato

    Parametros Entrada
     inuContrato   codigo del contrato
   
    Parametros de salida
   
    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/
	
    -- Retorna verdadero si el contrato tiene productos diferentes a cobros de servicios
    FUNCTION fblTieneProdDiferACobrServ( inuContrato servsusc.sesususc%TYPE )
    RETURN BOOLEAN;

	-- Obtiene en una tabla PL el producto del contrato y tipo de producto
    PROCEDURE prcObtProductosXTipoYContrato(inuContrato 	IN suscripc.susccodi%TYPE,
											inuTipoProducto	IN servicio.servcodi%TYPE,
										    otbProducto 	OUT pkg_bcproducto.tytbsbtServsusc
											);
                                            
    --Valida si esxiste actividad para el contrato y tipo de solicitud ingresados                                        
    FUNCTION fblExisActPorContratoTipoSol(inuContrato     IN  suscripc.susccodi%TYPE,
                                          inuItem         IN  mo_data_for_order.item_id%TYPE,
                                          inuTipoTramite  IN  NUMBER)
    RETURN BOOLEAN;   

    -- Retorna la actividad economica del contrato
    FUNCTION fnuActividadEconomicaContrato
    (
        inuContrato                  IN  suscripc.susccodi%TYPE   
    )
    RETURN pe_eco_act_contract.economic_activity_id%TYPE;                                         

END pkg_bccontrato;
/

create or replace PACKAGE BODY  adm_person.pkg_bccontrato IS

    -- Identificador del ultimo caso que hizo cambios
    csbVersion                 VARCHAR2(15) := 'OSF-4451';
    
    -- Constantes para el control de la traza
    csbSP_NAME          CONSTANT VARCHAR2(35) := 'pkg_bccontrato.';
    cnuNVLTRC           CONSTANT NUMBER       := 5;
    csbInicio   		CONSTANT VARCHAR2(35) := pkg_traza.csbInicio;
    csbFin              CONSTANT VARCHAR2(35) := pkg_traza.csbFin;
    csbFin_err          CONSTANT VARCHAR2(35) := pkg_traza.csbFin_err;
    csbFin_erc          CONSTANT VARCHAR2(35) := pkg_traza.csbfin_erc; 
 
    CNURECORD_NO_EXISTE CONSTANT NUMBER(1) := 1; 
    nuError                     NUMBER;
    sbError                     VARCHAR2(4000);
    
    -- Tipo de producto Cobro de servicios
    cnuCobrServ                 CONSTANT NUMBER(2) := pkg_parametros.fnuGetValorNumerico('TIPO_PRODUCTO_COBRO_SERVICIOS');

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbVersion 
    Descripcion     : Retona la ultima WO que hizo cambios en el paquete 
    Autor           : Lubin Pineda - MVM 
    Fecha           : 27-07-2023 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     27-07-2023  OSF-1249 Creacion
    ***************************************************************************/    
    FUNCTION fsbVersion RETURN VARCHAR2 IS
    BEGIN
        RETURN csbVersion;
    END fsbVersion;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuCicloFacturacion 
    Descripcion     : Retorna Ciclo de Facturación del contrato
    Autor           : Lubin Pineda - MVM 
    Fecha           : 27-07-2023 
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    jpinedc     27-07-2023  OSF-1249    Creacion
    ***************************************************************************/                     
    FUNCTION fnuCicloFacturacion
    (
        inuContrato                  IN  suscripc.susccodi%TYPE   
    )
    RETURN suscripc.susccicl%TYPE
    IS

        -- Nombre de ste mÉtodo
        csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.fnuCicloFacturacion';
        nuerrorcode NUMBER;         -- se almacena codigo de error
        sbmenserror VARCHAR2(2000);  -- se almacena descripcion del error 


        CURSOR cuCicloFacturacion
        IS
        SELECT  sc.susccicl
        FROM suscripc sc
        WHERE sc.susccodi = inuContrato;

        nuCicloFacturacion    suscripc.susccicl%TYPE;

        PROCEDURE pCierracuCicloFacturacion
        IS
            -- Nombre de este método
            csbMT_NAME1  VARCHAR2(105) := csbMT_NAME || '.pCierracuCicloFacturacion';        
        BEGIN

            pkg_traza.trace(csbMT_NAME1, cnuNVLTRC, csbInicio);        

            IF cuCicloFacturacion%ISOPEN THEN  
                CLOSE cuCicloFacturacion;
            END IF;        

            pkg_traza.trace(csbMT_NAME1, cnuNVLTRC, csbFin);

        END pCierracuCicloFacturacion;             

    BEGIN

        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbInicio);

        pCierracuCicloFacturacion;

        OPEN cuCicloFacturacion;
        FETCH cuCicloFacturacion INTO nuCicloFacturacion;
        CLOSE cuCicloFacturacion;

        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbFin);

        RETURN nuCicloFacturacion;

    EXCEPTION
        WHEN OTHERS THEN
            pkg_error.SetError;
			pkg_error.getError(nuErrorCode,sbMensError);
			pkg_traza.trace(csbMT_NAME||' '||sbMensError, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbFin_err);	
            pCierracuCicloFacturacion;
            RETURN nuCicloFacturacion;                 
    END fnuCicloFacturacion;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuTipoContrato 
    Descripcion     : Retorna tipo de contrato
    Autor           : Lubin Pineda - MVM 
    Fecha           : 27-07-2023 
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    jpinedc     27-07-2023  OSF-1249    Creacion
    ***************************************************************************/                     
    FUNCTION fnuTipoContrato
    (
        inuContrato                  IN  suscripc.susccodi%TYPE   
    )
    RETURN suscripc.susctisu%TYPE
    IS

        -- Nombre de ste mÉtodo
        csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.fnuTipoContrato';
        nuerrorcode NUMBER;         -- se almacena codigo de error
        sbmenserror VARCHAR2(2000);  -- se almacena descripcion del error 


        CURSOR cuTipoContrato
        IS
        SELECT  sc.susctisu
        FROM suscripc sc
        WHERE sc.susccodi = inuContrato;

        nuTipoContrato    suscripc.susctisu%TYPE;

        PROCEDURE pCierracuTipoContrato
        IS
            -- Nombre de este método
            csbMT_NAME1  VARCHAR2(105) := csbMT_NAME || '.pCierracuTipoContrato';        
        BEGIN

            pkg_traza.trace(csbMT_NAME1, cnuNVLTRC, csbInicio);        

            IF cuTipoContrato%ISOPEN THEN  
                CLOSE cuTipoContrato;
            END IF;        

            pkg_traza.trace(csbMT_NAME1, cnuNVLTRC, csbFin);

        END pCierracuTipoContrato;             

    BEGIN

        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbInicio);

        pCierracuTipoContrato;

        OPEN cuTipoContrato;
        FETCH cuTipoContrato INTO nuTipoContrato;
        CLOSE cuTipoContrato;

        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbFin);

        RETURN nuTipoContrato;

    EXCEPTION
        WHEN OTHERS THEN
            pkg_error.SetError;
			pkg_error.getError(nuErrorCode,sbMensError);
			pkg_traza.trace(csbMT_NAME||' '||sbMensError, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbFin_err);	
            pCierracuTipoContrato;
            RETURN nuTipoContrato;                 
    END fnuTipoContrato;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuIdDireccReparto 
    Descripcion     : Retorna id dirección reparto 
    Autor           : Lubin Pineda - MVM 
    Fecha           : 27-07-2023 
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    jpinedc     27-07-2023  OSF-1249    Creacion
    ***************************************************************************/                    
    FUNCTION fnuIdDireccReparto
    (
        inuContrato                  IN  suscripc.susccodi%TYPE   
    )
    RETURN suscripc.susciddi%TYPE
    IS

        -- Nombre de ste mÉtodo
        csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.fnuIdDireccReparto';
        nuerrorcode NUMBER;         -- se almacena codigo de error
        sbmenserror VARCHAR2(2000);  -- se almacena descripcion del error 


        CURSOR cuIdDireccReparto
        IS
        SELECT  sc.susciddi
        FROM suscripc sc
        WHERE sc.susccodi = inuContrato;

        nuIdDireccReparto    suscripc.susciddi%TYPE;

        PROCEDURE pCierracuIdDireccReparto
        IS
            -- Nombre de este método
            csbMT_NAME1  VARCHAR2(105) := csbMT_NAME || '.pCierracuIdDireccReparto';        
        BEGIN

            pkg_traza.trace(csbMT_NAME1, cnuNVLTRC, csbInicio);        

            IF cuIdDireccReparto%ISOPEN THEN  
                CLOSE cuIdDireccReparto;
            END IF;        

            pkg_traza.trace(csbMT_NAME1, cnuNVLTRC, csbFin);

        END pCierracuIdDireccReparto;             

    BEGIN

        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbInicio);

        pCierracuIdDireccReparto;

        OPEN cuIdDireccReparto;
        FETCH cuIdDireccReparto INTO nuIdDireccReparto;
        CLOSE cuIdDireccReparto;

        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbFin);

        RETURN nuIdDireccReparto;

    EXCEPTION
        WHEN OTHERS THEN
            pkg_error.SetError;
			pkg_error.getError(nuErrorCode,sbMensError);
			pkg_traza.trace(csbMT_NAME||' '||sbMensError, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbFin_err);	
            pCierracuIdDireccReparto;
            RETURN nuIdDireccReparto;                 
    END fnuIdDireccReparto;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuIdCliente 
    Descripcion     : Retorna id de cliente
    Autor           : Lubin Pineda - MVM 
    Fecha           : 27-07-2023 
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    jpinedc     27-07-2023  OSF-1249    Creacion
    ***************************************************************************/                     
    FUNCTION fnuIdCliente
    (
        inuContrato                  IN  suscripc.susccodi%TYPE   
    )
    RETURN suscripc.suscclie%TYPE
    IS

        -- Nombre de ste mÉtodo
        csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.fnuIdCliente';
        nuerrorcode NUMBER;         -- se almacena codigo de error
        sbmenserror VARCHAR2(2000);  -- se almacena descripcion del error 

        CURSOR cuIdCliente
        IS
        SELECT  sc.suscclie
        FROM suscripc sc
        WHERE sc.susccodi = inuContrato;

        nuIdCliente    suscripc.suscclie%TYPE;

        PROCEDURE pCierracuIdCliente
        IS
            -- Nombre de este método
            csbMT_NAME1  VARCHAR2(105) := csbMT_NAME || '.pCierracuIdCliente';        
        BEGIN

            pkg_traza.trace(csbMT_NAME1, cnuNVLTRC, csbInicio);        

            IF cuIdCliente%ISOPEN THEN  
                CLOSE cuIdCliente;
            END IF;        

            pkg_traza.trace(csbMT_NAME1, cnuNVLTRC, csbFin);

        END pCierracuIdCliente;             

    BEGIN

        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbInicio);

        pCierracuIdCliente;

        OPEN cuIdCliente;
        FETCH cuIdCliente INTO nuIdCliente;
        CLOSE cuIdCliente;

        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbFin);

        RETURN nuIdCliente;

    EXCEPTION
        WHEN OTHERS THEN
            pkg_error.SetError;
			pkg_error.getError(nuErrorCode,sbMensError);
			pkg_traza.trace(csbMT_NAME||' '||sbMensError, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbFin_err);	
            pCierracuIdCliente;
            RETURN nuIdCliente;                 
    END fnuIdCliente;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuSaldoAfavor 
    Descripcion     : Retorna Valor Saldo a Favor
    Autor           : Lubin Pineda - MVM 
    Fecha           : 27-07-2023 
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    jpinedc     27-07-2023  OSF-1249    Creacion
    ***************************************************************************/                     
    FUNCTION fnuSaldoAfavor
    (
        inuContrato                  IN  suscripc.susccodi%TYPE   
    )
    RETURN suscripc.suscsafa%TYPE
    IS

        -- Nombre de ste mÉtodo
        csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.fnuSaldoAfavor';
        nuerrorcode NUMBER;         -- se almacena codigo de error
        sbmenserror VARCHAR2(2000);  -- se almacena descripcion del error 

        CURSOR cuSaldoAfavor
        IS
        SELECT  sc.suscsafa
        FROM suscripc sc
        WHERE sc.susccodi = inuContrato;

        nuSaldoAfavor    suscripc.suscsafa%TYPE;

        PROCEDURE pCierracuSaldoAfavor
        IS
            -- Nombre de este método
            csbMT_NAME1  VARCHAR2(105) := csbMT_NAME || '.pCierracuSaldoAfavor';        
        BEGIN

            pkg_traza.trace(csbMT_NAME1, cnuNVLTRC, csbInicio);        

            IF cuSaldoAfavor%ISOPEN THEN  
                CLOSE cuSaldoAfavor;
            END IF;        

            pkg_traza.trace(csbMT_NAME1, cnuNVLTRC, csbFin);

        END pCierracuSaldoAfavor;             

    BEGIN

        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbInicio);

        pCierracuSaldoAfavor;

        OPEN cuSaldoAfavor;
        FETCH cuSaldoAfavor INTO nuSaldoAfavor;
        CLOSE cuSaldoAfavor;

        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbFin);

        RETURN nuSaldoAfavor;

    EXCEPTION
        WHEN OTHERS THEN
            pkg_error.SetError;
			pkg_error.getError(nuErrorCode,sbMensError);
			pkg_traza.trace(csbMT_NAME||' '||sbMensError, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbFin_err);	
            pCierracuSaldoAfavor;
            RETURN nuSaldoAfavor;                 
    END fnuSaldoAfavor;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuCodigoProcFacturacion 
    Descripcion     : Retorna Código Proceso Facturación
    Autor           : Lubin Pineda - MVM 
    Fecha           : 27-07-2023 
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    jpinedc     27-07-2023  OSF-1249    Creacion
    jsoto       17/06/2024  OSF-2838    Se cambia suscsafa por suscnupr como dato retornado
    ***************************************************************************/                     
    FUNCTION fnuCodigoProcFacturacion
    (
        inuContrato                  IN  suscripc.susccodi%TYPE   
    )
    RETURN suscripc.suscnupr%TYPE
    IS

        -- Nombre de ste mÉtodo
        csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.fnuCodigoProcFacturacion';
        nuerrorcode NUMBER;         -- se almacena codigo de error
        sbmenserror VARCHAR2(2000);  -- se almacena descripcion del error 

        CURSOR cuCodigoProcFacturacion
        IS
        SELECT  sc.suscnupr
        FROM suscripc sc
        WHERE sc.susccodi = inuContrato;

        nuCodigoProcFacturacion    suscripc.suscnupr%TYPE;

        PROCEDURE pCierracuCodigoProcFacturacion
        IS
            -- Nombre de este método
            csbMT_NAME1  VARCHAR2(105) := csbMT_NAME || '.pCierracuCodigoProcFacturacion';        
        BEGIN

            pkg_traza.trace(csbMT_NAME1, cnuNVLTRC, csbInicio);        

            IF cuCodigoProcFacturacion%ISOPEN THEN  
                CLOSE cuCodigoProcFacturacion;
            END IF;        

            pkg_traza.trace(csbMT_NAME1, cnuNVLTRC, csbFin);

        END pCierracuCodigoProcFacturacion;             

    BEGIN

        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbInicio);

        pCierracuCodigoProcFacturacion;

        OPEN cuCodigoProcFacturacion;
        FETCH cuCodigoProcFacturacion INTO nuCodigoProcFacturacion;
        CLOSE cuCodigoProcFacturacion;

        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbFin);

        RETURN nuCodigoProcFacturacion;

    EXCEPTION
        WHEN OTHERS THEN
            pkg_error.SetError;
			pkg_error.getError(nuErrorCode,sbMensError);
			pkg_traza.trace(csbMT_NAME||' '||sbMensError, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbFin_err);	
            pCierracuCodigoProcFacturacion;
            RETURN nuCodigoProcFacturacion;                 
    END fnuCodigoProcFacturacion;    



     /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : UPDSUSCCEMF 
    Descripcion     : Actualiza el cambo susccemf dado el contrato
    Autor           : Diana Montes - MVM 
    Fecha           : 05-09-2023 
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    diana.montes05-09-2023  OSF-1478    Creacion
    ***************************************************************************/  
    PROCEDURE UPDSUSCCEMF( INUSUSCCODI IN SUSCRIPC.SUSCCODI%TYPE,
                           INUSUSCCEMF IN SUSCRIPC.SUSCCEMF%TYPE
	) IS
	-- Nombre de este método
    csbMT_NAME  VARCHAR2(70) := csbSP_NAME ||  '.UpdSusccemf';      
    nuerrorcode NUMBER;         -- se almacena codigo de error
    sbmenserror VARCHAR2(2000);  -- se almacena descripcion del error 

   BEGIN

        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbInicio);        

        UPDATE SUSCRIPC
        SET
            SUSCCEMF = INUSUSCCEMF
        WHERE  SUSCCODI = INUSUSCCODI;

        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbFin);

        IF ( SQL%NOTFOUND ) THEN
            RAISE NO_DATA_FOUND;
        END IF;

        EXCEPTION
            WHEN NO_DATA_FOUND THEN
			pkg_error.getError(nuErrorCode,sbMensError);
			pkg_traza.trace(csbMT_NAME||' '||sbMensError, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbFin_erc);	
			WHEN OTHERS THEN
            pkg_error.SetError;
			pkg_error.getError(nuErrorCode,sbMensError);
			pkg_traza.trace(csbMT_NAME||' '||sbMensError, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbFin_err);	

    END UPDSUSCCEMF;

     /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : UPDSUSCCEMD 
    Descripcion     : Actualiza el cambo susccemd dado el contrato
    Autor           : Diana Montes - MVM 
    Fecha           : 05-09-2023 
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    diana.montes05-09-2023  OSF-1478    Creacion
    ***************************************************************************/      
	PROCEDURE UPDSUSCCEMD
	(
		INUSUSCCODI IN SUSCRIPC.SUSCCODI%TYPE,
		INUSUSCCEMD IN SUSCRIPC.SUSCCEMD%TYPE
	)
	IS

	-- Nombre de este método
            csbMT_NAME  VARCHAR2(70) := csbSP_NAME ||  '.UpdSusccemd';   
			nuerrorcode NUMBER;         -- se almacena codigo de error
			sbmenserror VARCHAR2(2000);  -- se almacena descripcion del error 

        BEGIN

            pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbInicio);  

		UPDATE SUSCRIPC
		SET
			SUSCCEMD = INUSUSCCEMD
		WHERE  SUSCCODI = INUSUSCCODI;

		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbFin);

		IF ( SQL%NOTFOUND ) THEN
                RAISE NO_DATA_FOUND;
        END IF;

		EXCEPTION
		WHEN NO_DATA_FOUND THEN
			pkg_error.getError(nuErrorCode,sbMensError);
			pkg_traza.trace(csbMT_NAME||' '||sbMensError, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbFin_erc);	
		WHEN OTHERS THEN
			pkg_error.SetError;
			pkg_error.getError(nuErrorCode,sbMensError);
			pkg_traza.trace(csbMT_NAME||' '||sbMensError, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbFin_err);	


	END UPDSUSCCEMD;
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : UPDSUSCCOEM 
    Descripcion     : Actualiza el cambo susccoem dado el contrato
    Autor           : Diana Montes - MVM 
    Fecha           : 05-09-2023 
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    diana.montes05-09-2023  OSF-1478    Creacion
    ***************************************************************************/ 
	PROCEDURE UPDSUSCCOEM
	(
		INUSUSCCODI IN SUSCRIPC.SUSCCODI%TYPE,
		INUSUSCCOEM IN SUSCRIPC.SUSCCOEM%TYPE
	)
	IS
	 -- Nombre de ste mÉtodo
        csbMT_NAME  VARCHAR2(70) := csbSP_NAME ||  '.UpdSusccoem';
        nuerrorcode NUMBER;         -- se almacena codigo de error
        sbmenserror VARCHAR2(2000);  -- se almacena descripcion del error 


        BEGIN

            pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbInicio);     

		UPDATE SUSCRIPC
		SET
			SUSCCOEM = INUSUSCCOEM
		WHERE  SUSCCODI = INUSUSCCODI;

		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbFin);

		IF ( SQL%NOTFOUND ) THEN
                RAISE NO_DATA_FOUND;
        END IF;

		EXCEPTION
		WHEN NO_DATA_FOUND THEN
			pkg_error.getError(nuErrorCode,sbMensError);
			pkg_traza.trace(csbMT_NAME||' '||sbMensError, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbFin_erc);	
		WHEN OTHERS THEN
			pkg_error.SetError;
			pkg_error.getError(nuErrorCode,sbMensError);
			pkg_traza.trace(csbMT_NAME||' '||sbMensError, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbFin_err);	

	END UPDSUSCCOEM;         

	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fblExiste 
    Descripcion     : Valida si el contrato existe
    Autor           : jcatuche
    Fecha           : 04-0172024 
    Modificaciones  :
    Autor       Fecha       Caso        Descripción
    jcatuche    06-09-2024  OSF-3266    Creación
    ***************************************************************************/   
    FUNCTION fblExiste
    (
       inuContrato             IN  suscripc.susccodi%TYPE
    ) RETURN BOOLEAN
    IS
        csbMT_NAME   VARCHAR2(70) := csbSP_NAME||'fblExiste';

        blExiste    boolean;
        nuRegistros number;

        cursor cuExiste is
        select count(susccodi)
        from suscripc
        where susccodi = inuContrato;
    BEGIN
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbInicio);

        if cuExiste%isopen then
            close cuExiste;
        end if;

        open cuExiste;
        fetch cuExiste into nuRegistros;
        close cuExiste;

        blExiste := nuRegistros != 0;

        pkg_traza.trace('blExiste => '||case when blExiste then 'True' else 'Falso' end, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbFin);
        return blExiste;
    EXCEPTION
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' ||sbError, cnuNVLTRC);
            blExiste := false;
            pkg_traza.trace('blExiste => '||case when blExiste then 'True' else 'Falso' end, cnuNVLTRC);
            pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbFin_err);  
            return blExiste;  
    END fblExiste;      

	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuObtProdPorTipoYEstado 
    Descripcion     : Retorna el producto de gas activo

    Autor           : Jhon Erazo - MVM 
    Fecha           : 30/12/2024

	Parametros
		Entrada:
			inuContrato		Identificador del contrato
			inuTipoProducto	Identificador del estado del producto
			inuEstado		Estado del producto

		Salida:
			nuProductoGas	Identificador del producto gas

    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    jerazomvm	30/12/2024	OSF-3816    Creacion
    ***************************************************************************/                     
    FUNCTION fnuObtProdPorTipoYEstado(inuContrato		IN suscripc.susccodi%TYPE,
									  inuTipoProducto	IN pr_product.product_type_id%TYPE,
									  inuEstado			IN pr_product.product_status_id%TYPE
									  )
    RETURN pr_product.product_id%TYPE
    IS

        -- Nombre de ste mÉtodo
        csbMT_NAME  	VARCHAR2(70) := csbSP_NAME || '.fnuObtProdPorTipoYEstado';
        nuerrorcode 	NUMBER;         -- se almacena codigo de error		
        sbmenserror 	VARCHAR2(2000);  -- se almacena descripcion del error 
        nuProducto   pr_product.product_id%TYPE;

        CURSOR cuProducto
        IS
			SELECT product_id
			FROM pr_product 
			WHERE subscription_id	= inuContrato
			AND product_type_id 	= inuTipoProducto
			AND product_status_id 	= inuEstado;

        PROCEDURE pCierracuProducto
        IS
            -- Nombre de este método
            csbMT_NAME1  VARCHAR2(105) := csbMT_NAME || '.pCierracuProducto';        
        BEGIN

            pkg_traza.trace(csbMT_NAME1, cnuNVLTRC, csbInicio);        

            IF cuProducto%ISOPEN THEN  
                CLOSE cuProducto;
            END IF;        

            pkg_traza.trace(csbMT_NAME1, cnuNVLTRC, csbFin);

        END pCierracuProducto;             

    BEGIN

        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbInicio);

		pkg_traza.trace('inuContrato: ' 	|| inuContrato 		|| CHR(10) ||
						'inuTipoProducto: ' || inuTipoProducto 	|| CHR(10) ||
						'inuEstado: ' 		|| inuEstado, cnuNVLTRC);

        pCierracuProducto;

        OPEN cuProducto;
        FETCH cuProducto INTO nuProducto;
        CLOSE cuProducto;

		pkg_traza.trace('nuProducto: ' || nuProducto, cnuNVLTRC);

        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbFin);

        RETURN nuProducto;

    EXCEPTION
        WHEN OTHERS THEN
            pkg_error.SetError;
			pkg_error.getError(nuErrorCode,sbMensError);
			pkg_traza.trace(csbMT_NAME||' '||sbMensError, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbFin_err);	
            pCierracuProducto;
            RETURN nuProducto;                 
    END fnuObtProdPorTipoYEstado;
    
    FUNCTION frcObtInfoContrato(inuContrato IN suscripc.susccodi%type) RETURN sbtContrato IS
    /**************************************************************************
     Proceso     : frcObtInfoContrato
     Autor       : Luis Javier Lopez Barrios 
     Fecha       : 2025-01-15
     Ticket      : OSF-3855
     Descripcion : devuelve registro de un contrato

    Parametros Entrada
     inuContrato   codigo del contrato
   
    Parametros de salida
   
    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/
    csbMetodo       VARCHAR2(100) := csbSP_NAME || '.frcObtInfoContrato';
    
    CURSOR cuObtInfoContrato IS
    SELECT *
    FROM suscripc
    WHERE suscripc.susccodi = inuContrato;
    
    rgContrato  sbtContrato;
    PROCEDURE prCierraCursor  IS
      csbMetodo1       VARCHAR2(100) := csbMetodo || '.prCierraCursor';
    BEGIN
       pkg_traza.trace(csbMetodo1, pkg_traza.cnuNivelTrzDef, csbInicio);
       IF cuObtInfoContrato%ISOPEN THEN   CLOSE cuObtInfoContrato;    END IF;
       pkg_traza.trace(csbMetodo1, pkg_traza.cnuNivelTrzDef, csbFin); 
    END prCierraCursor;
  BEGIN
     pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, csbInicio);
     pkg_traza.trace('inuContrato => ' || inuContrato, pkg_traza.cnuNivelTrzDef);
     prCierraCursor;
     OPEN cuObtInfoContrato;
     FETCH cuObtInfoContrato INTO rgContrato;
     CLOSE cuObtInfoContrato;
     
     pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, csbFin);
     RETURN rgContrato;
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
      pkg_Error.getError(nuError, sbError);
      pkg_traza.trace('sberror: ' || sbError, pkg_traza.cnuNivelTrzDef);
      prCierraCursor;
      pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, csbFin_erc);
      RAISE pkg_error.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(nuError, sbError);
      pkg_traza.trace('sberror: ' || sbError, pkg_traza.cnuNivelTrzDef);
      prCierraCursor;
      pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, csbFin_err);
      RAISE pkg_error.CONTROLLED_ERROR;
  END frcObtInfoContrato;

    -- Retorna verdadero si el contrato tiene productos diferentes a cobros de servicios
    FUNCTION fblTieneProdDiferACobrServ( inuContrato servsusc.sesususc%TYPE )
    RETURN BOOLEAN
    IS

        csbMetodo       CONSTANT VARCHAR2(105) :=  csbSP_NAME || '.fblTieneProdDiferACobrServ';
            
        blTieneProdDiferACobrServ  BOOLEAN;
        
        CURSOR cuServSusc
        IS
        SELECT sesunuse
        FROM servsusc ss
        WHERE ss.sesususc = inuContrato
        AND ss.sesuserv <> cnuCobrServ;
        
        nuSeSuNuSe  servsusc.sesunuse%TYPE;

        PROCEDURE prCierraCursor  IS
          csbMetodo1       VARCHAR2(100) := csbMetodo || '.prCierraCursor';
        BEGIN
           pkg_traza.trace(csbMetodo1, pkg_traza.cnuNivelTrzDef, csbInicio);
           IF cuServSusc%ISOPEN THEN   CLOSE cuServSusc;    END IF;
           pkg_traza.trace(csbMetodo1, pkg_traza.cnuNivelTrzDef, csbFin); 
        END prCierraCursor;
            
    BEGIN

        pkg_traza.trace(csbMetodo, cnuNVLTRC, csbInicio);
            
        OPEN cuServSusc;
        FETCH cuServSusc INTO nuSeSuNuSe;   
        CLOSE cuServSusc;
        
        blTieneProdDiferACobrServ := nuSeSuNuSe IS NOT NULL;

        pkg_traza.trace(csbMetodo, cnuNVLTRC, csbFin);
                
        RETURN blTieneProdDiferACobrServ;

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sberror: ' || sbError, pkg_traza.cnuNivelTrzDef);
            prCierraCursor;
            pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, csbFin_erc);
            RETURN blTieneProdDiferACobrServ;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sberror: ' || sbError, pkg_traza.cnuNivelTrzDef);
            prCierraCursor;
            pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, csbFin_err);
            RETURN blTieneProdDiferACobrServ;
    END fblTieneProdDiferACobrServ;

/**************************************************************************
    <PROCEDURE Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> prcObtProductosXTipoYContrato </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 25-02-2025 </Fecha>
    <Descripcion> 
        Obtiene en una tabla PL el producto del contrato y tipo de producto
    </Descripcion>
	<Parametros> 
        Entrada:
			inuContrato		Identificador del contrato
			inuTipoProducto	Identificador del tipo de producto
		
		Salida:
			otbProducto	Tabla con los productos
			
    </Parametros>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="25-02-2025" Inc="OSF-4046" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </PROCEDURE>
    **************************************************************************/
    PROCEDURE prcObtProductosXTipoYContrato(inuContrato 	IN suscripc.susccodi%TYPE,
											inuTipoProducto	IN servicio.servcodi%TYPE,
										    otbProducto 	OUT pkg_bcproducto.tytbsbtServsusc
											)
    IS
	
		csbMT_NAME  VARCHAR2(200) := csbSP_NAME || 'prcObtProductosXTipoYContrato';
		
		nuError		NUMBER;  
		sbmensaje	VARCHAR2(1000);  
		
		CURSOR cuProducto
		IS
			SELECT *
			FROM SERVSUSC
			WHERE SESUSUSC 	= inuContrato
			AND sesuserv 	= inuTipoProducto;
        
    BEGIN
		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbInicio);
		
		pkg_traza.trace('inuContrato: '   	|| inuContrato || CHR(10) || 
						'inuTipoProducto: '	|| inuTipoProducto, cnuNVLTRC);
		
		IF (cuProducto%ISOPEN) THEN
			CLOSE cuProducto;
		END IF;
		
		OPEN cuProducto;
		FETCH cuProducto BULK COLLECT INTO otbProducto;
		CLOSE cuProducto;

		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbFin);

    EXCEPTION
		WHEN pkg_error.CONTROLLED_ERROR THEN
			pkg_error.setError;
			pkg_Error.getError(nuError, sbmensaje);
			pkg_traza.trace('nuError: ' || nuError || ' sbmensaje: ' || sbmensaje, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbFin_erc); 
			RAISE pkg_error.CONTROLLED_ERROR;
		WHEN others THEN
			pkg_Error.setError;
			pkg_Error.getError(nuError, sbmensaje);
			pkg_traza.trace('nuError: ' || nuError || ' sbmensaje: ' || sbmensaje, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbFin_err); 
			RAISE pkg_Error.Controlled_Error;
    END prcObtProductosXTipoYContrato;
    
    /**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> fblExisActPorContratoTipoSol </Unidad>
    <Autor>Paola Acosta</Autor>
    <Fecha> 28-03-2025 </Fecha>
    <Descripcion> 
        Valida si esxiste actividad para el contrato y tipo de solicitud ingresados
    </Descripcion>
    <Historial>
           <Modificacion Autor="Paola.Acosta" Fecha="28-03-2025" Inc="OSF-4151" Empresa="EFG">
               Creación
           </Modificacion>
    </Historial>
    </Procedure>
    **************************************************************************/
    FUNCTION fblExisActPorContratoTipoSol(inuContrato    IN  suscripc.susccodi%TYPE,
                                          inuItem        IN  mo_data_for_order.item_id%TYPE,
                                          inuTipoTramite IN  NUMBER)
    RETURN BOOLEAN
    IS
        --Constantes
        csbMtd_nombre   CONSTANT VARCHAR2(70)  := csbSP_NAME || 'fblExisActPorContratoTipoSol';             
        
        --Variables
        nuError		NUMBER;  
		sbmensaje	VARCHAR2(1000); 
        nuExiste    NUMBER;       
        
        --Cursores
        CURSOR cuActPorContratoTipoSol IS
        SELECT COUNT(oa.order_activity_id)
        FROM or_order_activity oa, mo_packages mo
        WHERE subscription_id = inuContrato
        AND oa.package_id = mo.package_id
        AND mo.package_type_id = inuTipoTramite
        AND oa.activity_id = inuItem
        AND oa.status IN (pkg_gestionordenes.csbEstadoActRegistrado, pkg_gestionordenes.csbEstadoActAsignado)
        AND mo.motive_status_id = pkg_bogestionsolicitudes.cnuSolicitudRegistrada;
        
    BEGIN
        pkg_traza.trace(csbMtd_nombre, cnuNvlTrc, csbInicio);
               
        OPEN cuActPorContratoTipoSol;
        FETCH cuActPorContratoTipoSol INTO nuExiste;
        CLOSE cuActPorContratoTipoSol;

        IF (nuExiste > 0) THEN
            pkg_traza.trace('blRespuesta: TRUE', cnuNvlTrc); 
            RETURN TRUE;
        END IF;          
        
        pkg_traza.trace(csbMtd_nombre, cnuNvlTrc, csbFin);
        pkg_traza.trace('blRespuesta: FALSO', cnuNvlTrc); 
        
        RETURN FALSE;
        
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_error.setError;
            pkg_error.getError(nuError, sbMensaje);
            pkg_traza.trace('nuError: ' || nuError || ' sbMensaje: ' || sbMensaje, cnuNvlTrc);
            pkg_traza.trace(csbMtd_nombre, cnuNvlTrc, csbFin_erc); 
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_error.setError;
            pkg_error.getError(nuError, sbMensaje);
            pkg_traza.trace('nuError: ' || nuError || ' sbMensaje: ' || sbMensaje, cnuNvlTrc);
            pkg_traza.trace(csbMtd_nombre, cnuNvlTrc, csbFin_err); 
            RAISE pkg_error.controlled_error;
    END fblExisActPorContratoTipoSol; 
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuActividadEconomicaContrato 
    Descripcion     : Retorna la actividad economica del contrato
    Autor           : Luis Felipe Valencia Hurtado
    Fecha           : 13-05-2025
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    fvalencia     13-05-2025  OSF-4451    Creacion
    ***************************************************************************/                     
    FUNCTION fnuActividadEconomicaContrato
    (
        inuContrato                  IN  suscripc.susccodi%TYPE   
    )
    RETURN pe_eco_act_contract.economic_activity_id%TYPE
    IS

        -- Nombre de ste mÉtodo
        csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.fnuActividadEconomicaContrato';
        nuerrorcode NUMBER;         -- se almacena codigo de error
        sbmenserror VARCHAR2(2000);  -- se almacena descripcion del error 

        CURSOR cuActividadEconomica
        IS
        SELECT  a.economic_activity_id 
        FROM    pe_eco_act_contract a
        WHERE   a.subscription_id = inuContrato;

        nuActividadEconomica    ge_economic_activity.economic_activity_id%TYPE;

        PROCEDURE pCierraCursor
        IS
            -- Nombre de este método
            csbMT_NAME1  VARCHAR2(105) := csbMT_NAME || '.pCierraCursor';        
        BEGIN

            pkg_traza.trace(csbMT_NAME1, cnuNVLTRC, csbInicio);        

            IF cuActividadEconomica%ISOPEN THEN  
                CLOSE cuActividadEconomica;
            END IF;        

            pkg_traza.trace(csbMT_NAME1, cnuNVLTRC, csbFin);

        END pCierraCursor;             

    BEGIN

        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbInicio);

        pCierraCursor;

        OPEN cuActividadEconomica;
        FETCH cuActividadEconomica INTO nuActividadEconomica;
        CLOSE cuActividadEconomica;

        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbFin);

        RETURN nuActividadEconomica;

    EXCEPTION
        WHEN OTHERS THEN
            pkg_error.SetError;
			pkg_error.getError(nuErrorCode,sbMensError);
			pkg_traza.trace(csbMT_NAME||' '||sbMensError, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbFin_err);	
            pCierraCursor;
            RETURN nuActividadEconomica;                 
    END fnuActividadEconomicaContrato;
END pkg_bccontrato;
/

PROMPT Otorgando permisos de ejecución para adm_person.PKG_BCCONTRATO
BEGIN
    pkg_utilidades.prAplicarPermisos('PKG_BCCONTRATO', 'ADM_PERSON');
END;
/

