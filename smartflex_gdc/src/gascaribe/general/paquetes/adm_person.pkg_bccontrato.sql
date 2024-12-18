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
    jcatuche    06/09/2024  OSF-3266: Se crea la función fblExiste
*******************************************************************************/

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
    
    
END pkg_bccontrato;
/

CREATE OR REPLACE PACKAGE BODY adm_person.pkg_bccontrato IS

    -- Identificador del ultimo caso que hizo cambios
    csbVersion                 VARCHAR2(15) := 'OSF-3266';

    -- Constantes para el control de la traza
    csbSP_NAME                 CONSTANT VARCHAR2(35)         := 'pkg_bccontrato.';
    cnuNVLTRC                  CONSTANT NUMBER                := 5;
    
    CNURECORD_NO_EXISTE CONSTANT NUMBER(1) := 1; 
    nuError                     NUMBER;
    sbError                     VARCHAR2(4000);

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
        
            pkg_traza.trace(csbMT_NAME1, cnuNVLTRC, pkg_traza.csbINICIO);        
        
            IF cuTipoContrato%ISOPEN THEN  
                CLOSE cuTipoContrato;
            END IF;        

            pkg_traza.trace(csbMT_NAME1, cnuNVLTRC, pkg_traza.csbFIN);

        END pCierracuTipoContrato;             
        
    BEGIN
    
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);
        
        pCierracuTipoContrato;
    
        OPEN cuTipoContrato;
        FETCH cuTipoContrato INTO nuTipoContrato;
        CLOSE cuTipoContrato;
            
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
        
        RETURN nuTipoContrato;
        
    EXCEPTION
        WHEN OTHERS THEN
            pkg_error.SetError;
			pkg_error.getError(nuErrorCode,sbMensError);
			pkg_traza.trace(csbMT_NAME||' '||sbMensError, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME,cnuNVLTRC,pkg_traza.fsbFIN_ERR);	
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
        
            pkg_traza.trace(csbMT_NAME1, cnuNVLTRC, pkg_traza.csbINICIO);        
        
            IF cuIdDireccReparto%ISOPEN THEN  
                CLOSE cuIdDireccReparto;
            END IF;        

            pkg_traza.trace(csbMT_NAME1, cnuNVLTRC, pkg_traza.csbFIN);

        END pCierracuIdDireccReparto;             
        
    BEGIN
    
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);
        
        pCierracuIdDireccReparto;
    
        OPEN cuIdDireccReparto;
        FETCH cuIdDireccReparto INTO nuIdDireccReparto;
        CLOSE cuIdDireccReparto;
            
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
        
        RETURN nuIdDireccReparto;
        
    EXCEPTION
        WHEN OTHERS THEN
            pkg_error.SetError;
			pkg_error.getError(nuErrorCode,sbMensError);
			pkg_traza.trace(csbMT_NAME||' '||sbMensError, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME,cnuNVLTRC,pkg_traza.fsbFIN_ERR);	
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
        
            pkg_traza.trace(csbMT_NAME1, cnuNVLTRC, pkg_traza.csbINICIO);        
        
            IF cuIdCliente%ISOPEN THEN  
                CLOSE cuIdCliente;
            END IF;        

            pkg_traza.trace(csbMT_NAME1, cnuNVLTRC, pkg_traza.csbFIN);

        END pCierracuIdCliente;             
        
    BEGIN
    
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);
        
        pCierracuIdCliente;
    
        OPEN cuIdCliente;
        FETCH cuIdCliente INTO nuIdCliente;
        CLOSE cuIdCliente;
            
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
        
        RETURN nuIdCliente;
        
    EXCEPTION
        WHEN OTHERS THEN
            pkg_error.SetError;
			pkg_error.getError(nuErrorCode,sbMensError);
			pkg_traza.trace(csbMT_NAME||' '||sbMensError, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME,cnuNVLTRC,pkg_traza.fsbFIN_ERR);	
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
			pkg_error.getError(nuErrorCode,sbMensError);
			pkg_traza.trace(csbMT_NAME||' '||sbMensError, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME,cnuNVLTRC,pkg_traza.fsbFIN_ERR);	
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
        
            pkg_traza.trace(csbMT_NAME1, cnuNVLTRC, pkg_traza.csbINICIO);        
        
            IF cuCodigoProcFacturacion%ISOPEN THEN  
                CLOSE cuCodigoProcFacturacion;
            END IF;        

            pkg_traza.trace(csbMT_NAME1, cnuNVLTRC, pkg_traza.csbFIN);

        END pCierracuCodigoProcFacturacion;             
        
    BEGIN
    
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);
        
        pCierracuCodigoProcFacturacion;
    
        OPEN cuCodigoProcFacturacion;
        FETCH cuCodigoProcFacturacion INTO nuCodigoProcFacturacion;
        CLOSE cuCodigoProcFacturacion;
            
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
        
        RETURN nuCodigoProcFacturacion;
        
    EXCEPTION
        WHEN OTHERS THEN
            pkg_error.SetError;
			pkg_error.getError(nuErrorCode,sbMensError);
			pkg_traza.trace(csbMT_NAME||' '||sbMensError, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME,cnuNVLTRC,pkg_traza.fsbFIN_ERR);	
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
        
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);        

        UPDATE SUSCRIPC
        SET
            SUSCCEMF = INUSUSCCEMF
        WHERE  SUSCCODI = INUSUSCCODI;
        
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
        
        IF ( SQL%NOTFOUND ) THEN
            RAISE NO_DATA_FOUND;
        END IF;

        EXCEPTION
            WHEN NO_DATA_FOUND THEN
			pkg_error.getError(nuErrorCode,sbMensError);
			pkg_traza.trace(csbMT_NAME||' '||sbMensError, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME,cnuNVLTRC,pkg_traza.fsbFIN_ERC);	
			WHEN OTHERS THEN
            pkg_error.SetError;
			pkg_error.getError(nuErrorCode,sbMensError);
			pkg_traza.trace(csbMT_NAME||' '||sbMensError, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME,cnuNVLTRC,pkg_traza.fsbFIN_ERR);	

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
        
            pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);  

		UPDATE SUSCRIPC
		SET
			SUSCCEMD = INUSUSCCEMD
		WHERE  SUSCCODI = INUSUSCCODI;
		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
		
		IF ( SQL%NOTFOUND ) THEN
                RAISE NO_DATA_FOUND;
        END IF;

		EXCEPTION
		WHEN NO_DATA_FOUND THEN
			pkg_error.getError(nuErrorCode,sbMensError);
			pkg_traza.trace(csbMT_NAME||' '||sbMensError, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME,cnuNVLTRC,pkg_traza.fsbFIN_ERC);	
		WHEN OTHERS THEN
			pkg_error.SetError;
			pkg_error.getError(nuErrorCode,sbMensError);
			pkg_traza.trace(csbMT_NAME||' '||sbMensError, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME,cnuNVLTRC,pkg_traza.fsbFIN_ERR);	

                
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
        
            pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);     
	
		UPDATE SUSCRIPC
		SET
			SUSCCOEM = INUSUSCCOEM
		WHERE  SUSCCODI = INUSUSCCODI;
		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
		
		IF ( SQL%NOTFOUND ) THEN
                RAISE NO_DATA_FOUND;
        END IF;

		EXCEPTION
		WHEN NO_DATA_FOUND THEN
			pkg_error.getError(nuErrorCode,sbMensError);
			pkg_traza.trace(csbMT_NAME||' '||sbMensError, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME,cnuNVLTRC,pkg_traza.fsbFIN_ERC);	
		WHEN OTHERS THEN
			pkg_error.SetError;
			pkg_error.getError(nuErrorCode,sbMensError);
			pkg_traza.trace(csbMT_NAME||' '||sbMensError, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME,cnuNVLTRC,pkg_traza.fsbFIN_ERR);	
                
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
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);
        
        if cuExiste%isopen then
            close cuExiste;
        end if;
        
        open cuExiste;
        fetch cuExiste into nuRegistros;
        close cuExiste;
        
        blExiste := nuRegistros != 0;
        
        pkg_traza.trace('blExiste => '||case when blExiste then 'True' else 'Falso' end, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.fsbFIN);
        return blExiste;
    EXCEPTION
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' ||sbError, cnuNVLTRC);
            blExiste := false;
            pkg_traza.trace('blExiste => '||case when blExiste then 'True' else 'Falso' end, cnuNVLTRC);
            pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);  
            return blExiste;  
    END fblExiste;      
END pkg_bccontrato;
/
PROMPT Otorgando permisos de ejecución para adm_person.PKG_BCCONTRATO
BEGIN
    pkg_utilidades.prAplicarPermisos('PKG_BCCONTRATO', 'ADM_PERSON');
END;
/