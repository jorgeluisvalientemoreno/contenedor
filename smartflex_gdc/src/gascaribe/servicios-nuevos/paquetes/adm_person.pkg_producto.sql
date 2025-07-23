CREATE OR REPLACE PACKAGE adm_person.pkg_producto IS
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : pkg_producto
    Descripcion     : Paquete para contener servicio realcioandos a la entidad PR_PRODUCT y sus componentes
    Autor           : Jorge Valiente
    Fecha           : 22-06-2023
    
    Parametros de Entrada
      isbProceso    nombre del proceso
      inuTotalRegi  total de registros a procesar
    Parametros de Salida
    
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso      Descripcion
    dsaltarin   11/07/2024  OSF-3266  Se aegrega el mÃ©todo prActualizaMetodoAnVarCon
    jcatuche    04/07/2024  OSF-3266  Se agrega el mÃ©todo  prActualizaCiclos
    jerazomvm   07/09/2023  OSF-1530  Se crea el procedimiento prActualizaEstadoCorte
    fvalencia   13/12/2024  OSF-3746  Se crea la funciÃ³n frcObtieneRegistro
    pacosta     20/01/2025  OSF-3868  Se crea el proceso prActualizaSoloEstadoCorte y se aplican pautas tÃ©cnicas.
    jpinedc     27/01/2025  OSF-3893    Se crea prActualizaFechaRetiro    
    pacosta     21/04/2025  OSF-4270    Se crea proceso prActualizaSoloFechaCorte
    ***************************************************************************/
    
    --Cursores globales 
  	CURSOR cuObtieneRegistro
    (
        inuProductoId IN pr_product.product_id%TYPE 
    )
    IS
    SELECT  pr_product.*,
            pr_product.ROWID
    FROM    pr_product
    WHERE   product_id = inuProductoId;

    -- Tipos Globales
    SUBTYPE styProductos IS cuObtieneRegistro%ROWTYPE;

    TYPE tytbProductos IS TABLE OF styProductos INDEX BY BINARY_INTEGER;
    TYPE tyrfProductos IS REF CURSOR RETURN styProductos;

    -- Metodos
    /***************************************************************************
    Programa        : prActualizaEstadoProducto
    Descripcion     : proceso que actualiza estado del producto    
    ***************************************************************************/
    PROCEDURE prActualizaEstadoProducto(inuProduct_id        IN pr_product.product_id%TYPE,
                                        inuProduct_status_id IN pr_product.product_status_id%TYPE);

    /***************************************************************************    
    Programa        : prActualizaFechaInstalacion
    Descripcion     : proceso que actualiza fecha de instalacion del servicio   
    ***************************************************************************/
    PROCEDURE prActualizaFechaInstalacion(inuSesunuse IN servsusc.sesunuse%TYPE,
                                          idtSesufein IN servsusc.sesufein%TYPE);

    /***************************************************************************   
    Programa        : prActualizaEstadoCorte
    Descripcion     : proceso que actualiza el estado y fecha de corte del servicio    
    ***************************************************************************/
    PROCEDURE prActualizaEstadoCorte(inuSesunuse   IN servsusc.sesunuse%TYPE,
                                     inuSesuesco   IN servsusc.sesuesco%TYPE,
                                     idtFechaCorte IN DATE DEFAULT NULL);

    /***************************************************************************   
    Programa        : prcActualizaUltActSuspension
    Descripcion     : Actualiza Utilma Actividad Suspension   
    ***************************************************************************/
    PROCEDURE prcActualizaUltActSuspension(inuProducto            IN NUMBER,
                                           inuActividadSuspension IN NUMBER);

    /***************************************************************************   
    Programa        : prcActualizaInclusion
    Descripcion     : proceso que actualiza inclucion del servicio del producto   
    ***************************************************************************/
    PROCEDURE prcActualizaInclusion (inuProducto  IN  NUMBER,
                                     isbInclusion IN  VARCHAR2);

    /***************************************************************************   
    Programa        : prActualizaCiclos
    Descripcion     : Actualiza ciclos   
    ***************************************************************************/
    PROCEDURE prActualizaCiclos 
    (
        inuProducto     IN servsusc.sesunuse%TYPE,
        inuCiclo        IN servsusc.sesucicl%TYPE,
        inuCicloConsumo IN servsusc.sesucico%TYPE
    );
    
    /***************************************************************************   
    Programa        : prActualizaMetodoAnVarCon
    Descripcion     : Actualiza mÃ©todo de Ã¡nalisis de variaciÃ³n de consumo  
    ***************************************************************************/
    PROCEDURE prActualizaMetodoAnVarCon 
    (
        inuProducto   IN servsusc.sesunuse%TYPE,
        inuMetodo     IN servsusc.sesumecv%TYPE
    );

    /***************************************************************************   
    Programa        : prcActuCategoriaySubcategoria
    Descripcion     : Actualiza categorÃ­a y subcategorÃ­a por contrato 
    ***************************************************************************/
    PROCEDURE prcActuCategoriaySubcategoria 
    (
        inucontrato       IN servsusc.sesususc%TYPE,
        inuCategoria      IN servsusc.sesucate%TYPE,
        inuSubCategoria   IN servsusc.sesusuca%TYPE
    );

    /***************************************************************************   
    Programa        : frcObtieneRegistro
    Descripcion     : Retorna un registro de tipo styProductos  
    ***************************************************************************/
    FUNCTION frcObtieneRegistro
    (
      inuProductoId	IN	pr_product.product_id%TYPE
    )
    RETURN styProductos;
    
    /***************************************************************************   
    Programa        : prActualizaSoloEstadoCorte
    Descripcion     : proceso que actualiza el estado de corte del servicio   
    ***************************************************************************/
    PROCEDURE prActualizaSoloEstadoCorte(inuSesunuse IN servsusc.sesunuse%TYPE,
									     inuSesuesco IN servsusc.sesuesco%TYPE);
                                         

    -- Actualiza la fecha de retiro del producto
    PROCEDURE prActualizaFechaRetiro
    (
      inuProducto	    IN	pr_product.product_id%TYPE,
      inuEstadoCorte    IN  servsusc.sesuesco%TYPE,
      idtFechaRetiro    IN  pr_product.retire_date%TYPE DEFAULT SYSDATE
    );
    
    /***************************************************************************   
    Programa        : prActualizaSoloFechaCorte
    Descripcion     : Actualiza solo la fecha de corte del servicio   
    ***************************************************************************/
    PROCEDURE prActualizaSoloFechaCorte(inuSesunuse IN servsusc.sesunuse%TYPE,
									    inuSesufeco IN servsusc.sesufeco%TYPE); 

END pkg_producto;
/

CREATE OR REPLACE PACKAGE BODY adm_person.pkg_producto
IS
    -- Constantes para el control de la traza
    csbPqt_Nombre       CONSTANT VARCHAR2(100)        := $$plsql_unit || '.';
    csbNivelTraza       CONSTANT NUMBER(2)            := pkg_traza.cnuNivelTrzDef;    -- Nivel de traza para esta función.
    csbInicio           CONSTANT VARCHAR2(4)          := pkg_traza.fsbInicio;         -- Indica inicio de método
    csbFin              CONSTANT VARCHAR2(4)          := pkg_traza.fsbFin;            -- Indica Fin de método ok
    csbFin_err          CONSTANT VARCHAR2(4)          := pkg_traza.fsbFin_err;        -- Indica fin de método con error no controlado
    
    --Variables generales
    sbError             VARCHAR2(4000);
    nuError             NUMBER;
    rcdatos 		    cuObtieneRegistro%ROWTYPE;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prActualizaEstadoProducto
    Descripcion     : proceso que actualiza estado del producto
    Autor           : Jorge Valiente
    Fecha           : 22-06-2023
    
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso    Descripcion
    ***************************************************************************/
    PROCEDURE prActualizaEstadoProducto (
        inuProduct_id          IN pr_product.product_id%TYPE,
        inuProduct_status_id   IN pr_product.product_status_id%TYPE)
    IS
        csbMetodo   VARCHAR2(70) := csbPqt_Nombre||'prActualizaEstadoProducto';
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_traza.trace('inuProduct_id          <= '||inuProduct_id, csbNivelTraza);
        pkg_traza.trace('inuProduct_status_id   <= '||inuProduct_status_id, csbNivelTraza);
    
        UPDATE pr_product
        SET product_status_id = inuProduct_status_id
        WHERE product_id = inuProduct_id;
    
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);        
    EXCEPTION
        WHEN OTHERS THEN
            pkg_error.setError;
            pkg_error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' ||sbError, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_err);
            RAISE pkg_error.Controlled_Error;
    END prActualizaEstadoProducto;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prActualizaFechaInstalacion
    Descripcion     : proceso que actualiza fecha de instalacion del servicio
    Autor           : Jorge Valiente
    Fecha           : 22-06-2023 
    
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso    Descripcion
    ***************************************************************************/
    PROCEDURE prActualizaFechaInstalacion (
        inuSesunuse   IN servsusc.sesunuse%TYPE,
        idtsesufein   IN servsusc.sesufein%TYPE)
    IS
        csbMetodo   VARCHAR2(70) := csbPqt_Nombre||'prActualizaFechaInstalacion';
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_traza.trace('inuSesunuse   <= '||inuSesunuse, csbNivelTraza);
        pkg_traza.trace('idtsesufein   <= '||idtsesufein, csbNivelTraza);
    
        UPDATE servsusc
        SET sesufein = idtsesufein
        WHERE sesunuse = inuSesunuse;
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
    EXCEPTION
        WHEN OTHERS THEN
            pkg_error.setError;
            pkg_error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' ||sbError, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_err);
            RAISE pkg_error.Controlled_Error;
    END prActualizaFechaInstalacion;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prActualizaEstadoCorte
    Descripcion     : proceso que actualiza el estado de corte del servicio
    Autor           : Jhon Erazo
    Fecha           : 07/09/2023
    
    Parametros de Entrada
        inuSesunuse Identificador del servicio suscrito
        inuSesuesco Estado de corte
    
    Parametros de Salida
    
    Modificaciones :
    =========================================================
    Autor       Fecha       Caso      Descripcion
    jerazomvm 07/09/2023  OSF-1530  CreaciÃ³n
    ***************************************************************************/
    PROCEDURE prActualizaEstadoCorte (
        inuSesunuse     IN servsusc.sesunuse%TYPE,
        inuSesuesco     IN servsusc.sesuesco%TYPE,
        idtFechaCorte   IN DATE DEFAULT NULL)
    IS
        csbMetodo   VARCHAR2(70) := csbPqt_Nombre||'prActualizaEstadoCorte';
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_traza.trace('inuSesunuse   <= '||inuSesunuse, csbNivelTraza);
        pkg_traza.trace('inuSesuesco   <= '||inuSesuesco, csbNivelTraza);
        pkg_traza.trace('idtFechaCorte <= '||idtFechaCorte, csbNivelTraza);
    
        UPDATE servsusc
        SET sesuesco = inuSesuesco, sesufeco = idtFechaCorte
        WHERE sesunuse = inuSesunuse;
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
    EXCEPTION
        WHEN OTHERS THEN
            pkg_error.setError;
            pkg_error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' ||sbError, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_err);
            RAISE pkg_error.Controlled_Error;
    END prActualizaEstadoCorte;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prcActualizaUltActSuspension
    Descripcion     : Actualiza Utilma Actividad Suspension
    Autor           : Jorge Valiente
    Fecha           : 18/03/2024
    
    Parametros de Entrada
    inuProducto                 Codido del Producto
    inuActividadSuspension      Codigo de ultima actividad de suspension
    
    Parametros de Salida
    
    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    ***************************************************************************/
    PROCEDURE prcActualizaUltActSuspension (inuProducto            IN  NUMBER,
                                            inuActividadSuspension IN  NUMBER)
    IS
        -- Nombre de este metodo
        csbMetodo   VARCHAR2(70) := csbPqt_Nombre||'prcActualizaUltActSuspension';
       
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_traza.trace('inuProducto            <= '||inuProducto, csbNivelTraza);
        pkg_traza.trace('inuActividadSuspension <= '||inuActividadSuspension, csbNivelTraza);
    
        UPDATE PR_PRODUCT
        SET SUSPEN_ORD_ACT_ID = inuActividadSuspension
        WHERE PRODUCT_ID = inuProducto;
    
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);        
    EXCEPTION
        WHEN OTHERS THEN
            pkg_error.setError;
            pkg_error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' ||sbError, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_err);
    END prcActualizaUltActSuspension;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prcActualizaInclusion
    Descripcion     : proceso que actualiza inclucion del servicio del producto
    Autor           : Jorge Valiente
    Fecha           : 24-04-2024
    
    Parametros de Entrada
        inuProducto  Codigo del producto
        isbInclusion inclusion del producto
    
    Parametros de Salida
    
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso      Descripcion
    ***************************************************************************/
    PROCEDURE prcActualizaInclusion (inuProducto  IN NUMBER,
                                     isbInclusion IN VARCHAR2)
    IS
        csbMetodo   VARCHAR2(70) := csbPqt_Nombre||'prcActualizaInclusion';       
    
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_traza.trace('inuProducto    <= '||inuProducto, csbNivelTraza);
        pkg_traza.trace('isbInclusion   <= '||isbInclusion, csbNivelTraza);
        
        UPDATE servsusc
        SET sesuincl = isbInclusion
        WHERE sesunuse = inuProducto;
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);        
    EXCEPTION
        WHEN OTHERS THEN
            pkg_error.setError;
            pkg_error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' ||sbError, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_err);
            RAISE pkg_error.Controlled_Error;
    END prcActualizaInclusion;
  
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prActualizaCiclos 
    Descripcion     : Actualiza ciclos del producto
    Autor           : jcatuche
    Fecha           : 04-0172024 
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    jcatuche    04-07-2024  OSF-3266    Creacion
    ***************************************************************************/   
    PROCEDURE prActualizaCiclos 
    (
        inuProducto     IN servsusc.sesunuse%TYPE,
        inuCiclo        IN servsusc.sesucicl%TYPE,
        inuCicloConsumo IN servsusc.sesucico%TYPE
    )
    IS
        csbMetodo   VARCHAR2(70) := csbPqt_Nombre||'prActualizaCiclos';
    
    BEGIN    
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_traza.trace('inuProducto    <= '||inuProducto, csbNivelTraza); 
        pkg_traza.trace('inuCiclo       <= '||inuCiclo, csbNivelTraza);  
        pkg_traza.trace('inuCicloConsumo        <= '||inuCicloConsumo, csbNivelTraza);        
    
        UPDATE servsusc
        SET sesucicl = inuCiclo,sesucico = inuCicloConsumo
        WHERE sesunuse = inuProducto;
            
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);        
    EXCEPTION
        WHEN OTHERS THEN
            pkg_error.setError;
            pkg_error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' ||sbError, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_err);
            RAISE pkg_error.Controlled_Error;	
    END prActualizaCiclos;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prActualizaMetodoAnVarCon 
    Descripcion     : Actualiza metodo de analisis de variaciÃ³n de consumo del producto
    Autor           : dsaltarin
    Fecha           : 11-09-2024 
    
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    dsaltarin    11-09-2024  OSF-3266    Creacion
    ***************************************************************************/   
    PROCEDURE prActualizaMetodoAnVarCon 
    (
        inuProducto   IN servsusc.sesunuse%TYPE,
        inuMetodo     IN servsusc.sesumecv%TYPE
    )
    IS
        csbMetodo   VARCHAR2(70) := csbPqt_Nombre||'prActualizaMetodoAnVarCon';
        
    BEGIN    
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_traza.trace('inuProducto    <= '||inuProducto, csbNivelTraza); 
        pkg_traza.trace('inuMetodo       <= '||inuMetodo, csbNivelTraza);       
    
        UPDATE servsusc
        SET sesumecv = inuMetodo
        WHERE sesunuse = inuProducto;
            
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);        
    EXCEPTION
        WHEN OTHERS THEN
            pkg_error.setError;
            pkg_error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' ||sbError, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_err);
            RAISE pkg_error.Controlled_Error;	
    END prActualizaMetodoAnVarCon;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prcActuCategoriaySubcategoria 
    Descripcion     : Actualiza categoria y subcategoria por contrato
    Autor           : felipe.valencia
    Fecha           : 25-11-2024 
    
    Modificaciones  :
    Autor               Fecha         Caso        Descripcion
    felipe.valencia     25-11-2024    OSF-3607    Creacion
    ***************************************************************************/   
    PROCEDURE prcActuCategoriaySubcategoria 
    (
        inucontrato       IN servsusc.sesususc%TYPE,
        inuCategoria      IN servsusc.sesucate%TYPE,
        inuSubCategoria   IN servsusc.sesusuca%TYPE
    )
    IS
        csbMetodo   VARCHAR2(70) := csbPqt_Nombre||'prcActuCategoriaySubcategoria';
      
    BEGIN    
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_traza.trace('inucontrato    <= '||inucontrato, csbNivelTraza); 
        pkg_traza.trace('inuCategoria   <= '||inuCategoria, csbNivelTraza);     
        pkg_traza.trace('inuSubCategoria <= '||inuSubCategoria, csbNivelTraza);      
        
        pr_boproduct.updprodcatbycontract(inucontrato, inuCategoria, inuSubCategoria);
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);        
    EXCEPTION
        WHEN pkg_error.Controlled_Error  THEN
            pkg_error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFin_erc);
            RAISE pkg_error.Controlled_Error;  
        WHEN OTHERS THEN
            pkg_error.setError;
                  pkg_error.getError(nuError, sbError);
                  pkg_traza.trace('sbError: ' ||sbError, csbNivelTraza);
                  pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_err);
                  RAISE pkg_error.Controlled_Error;	
    END prcActuCategoriaySubcategoria;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : frcObtieneRegistro
    Descripcion     : Retorna un registro de tipo styProductos
    
    Autor           : Luis Felipe Valencia Hurtado
    Fecha           : 13-12-2024
    
    Parametros de entrada:
    inuProductoId 		Identificador del producto
    
    Modificaciones  :
    Autor             Fecha         Caso          Descripcion
    felipe.valencia   12-12-2024    OSF-3746      Creacion
    ***************************************************************************/
    FUNCTION frcObtieneRegistro
    (
        inuProductoId	IN	pr_product.product_id%TYPE
    )
    RETURN styProductos
    IS        
        csbMT_NAME		VARCHAR2(200) := csbPqt_Nombre || 'frcObtieneRegistro';
        rcerror 		styProductos;
        rcrecordnull	cuObtieneRegistro%ROWTYPE;
    
        PROCEDURE pCierracuRecord
        IS
            -- Nombre de este mÃ©todo
            csbMT_NAME1  VARCHAR2(105) := csbMT_NAME || '.pCierracuRecord';
        BEGIN        
            pkg_traza.trace(csbMT_NAME1, csbNivelTraza, csbInicio);
        
            IF cuObtieneRegistro%ISOPEN THEN
            CLOSE cuObtieneRegistro;
            END IF;
            
            pkg_traza.trace(csbMT_NAME1, csbNivelTraza, pkg_traza.csbFIN);        
        END pCierracuRecord;
    
    BEGIN    
        pkg_traza.trace(csbMT_NAME, csbNivelTraza, csbInicio);    
        pkg_traza.trace('inuProductoId: ' || inuProductoId, csbNivelTraza);
        
        rcerror.product_id := inuProductoId;
        
        pCierracuRecord;
        
        OPEN cuObtieneRegistro(inuProductoId);
        FETCH cuObtieneRegistro INTO rcdatos;
        
        IF cuObtieneRegistro%NOTFOUND  THEN
            CLOSE cuObtieneRegistro;
            
            rcdatos := rcrecordnull;
            RAISE NO_DATA_FOUND;
        END IF;
        
        CLOSE cuObtieneRegistro;
        
        pkg_traza.trace(csbMT_NAME, csbNivelTraza, pkg_traza.csbFIN);
        
        RETURN rcdatos;
    
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            pkg_traza.trace(csbMT_NAME, csbNivelTraza, pkg_traza.csbFin_erc);
            pkg_error.SetErrorMessage(1,'Producto: ['|| inuProductoId||']');
    END frcObtieneRegistro;
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prActualizaSoloEstadoCorte
    Descripcion     : proceso que actualiza el estado de corte del servicio
    Autor           : Paola Acosta
    Fecha           : 20/01/2025
  
    Modificaciones :
    =========================================================
    Autor       Fecha       Caso    	Descripcion
	pacosta 	20/01/2025	OSF-3866	CreaciÃ³n
	***************************************************************************/
	PROCEDURE prActualizaSoloEstadoCorte(inuSesunuse IN servsusc.sesunuse%TYPE,
									     inuSesuesco IN servsusc.sesuesco%TYPE) 
    IS
        csbMtd_nombre   CONSTANT    VARCHAR2(200) := csbPqt_Nombre || 'prActualizaEstadoCorte';
	BEGIN
        
        pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbInicio);
        pkg_traza.trace('inuSesunuse: '	|| inuSesunuse, csbNivelTraza);                                 
        pkg_traza.trace('inuSesuesco: ' || inuSesuesco, csbNivelTraza);  
        		
        UPDATE servsusc
        SET sesuesco = inuSesuesco           
        WHERE sesunuse = inuSesunuse;
		 
        pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin);
    
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace('pkg_error.CONTROLLED_ERROR ' || csbMtd_nombre, csbNivelTraza);
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_traza.trace('OTHERS ' || csbMtd_nombre, csbNivelTraza);
            pkg_error.seterror;
            RAISE pkg_error.controlled_error;
	END prActualizaSoloEstadoCorte;

    -- Actualiza la fecha de retiro del producto
    PROCEDURE prActualizaFechaRetiro
    (
      inuProducto	    IN	pr_product.product_id%TYPE,
      inuEstadoCorte    IN  servsusc.sesuesco%TYPE,
      idtFechaRetiro    IN  pr_product.retire_date%TYPE DEFAULT SYSDATE
    )	
    IS
        csbMT_NAME		VARCHAR2(200) := csbPqt_Nombre || 'prActualizaFechaRetiro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
	BEGIN

		pkg_traza.trace(csbMT_NAME, csbNivelTraza, csbInicio);
		
		UPDATE pr_product
		SET retire_date = idtFechaRetiro
		WHERE product_id = inuProducto;

        UPDATE servsusc 
        SET sesufere = idtFechaRetiro, 
        sesuesco = inuEstadoCorte
        WHERE sesunuse = inuProducto;
        		
		pkg_traza.trace(csbMT_NAME, csbNivelTraza, csbFin);

    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMT_NAME, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMT_NAME, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;		
    END prActualizaFechaRetiro;
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prActualizaSoloFechaCorte
    Descripcion     : Actualiza solo la fecha de corte del servicio
    Autor           : Paola Acosta
    Fecha           : 21/04/2025
  
    Modificaciones :
    =========================================================
    Autor       Fecha       Caso    	Descripcion
	pacosta 	21/04/2025	OSF-4270	Creación
	***************************************************************************/
	PROCEDURE prActualizaSoloFechaCorte(inuSesunuse IN servsusc.sesunuse%TYPE,
									    inuSesufeco IN servsusc.sesufeco%TYPE) 
    IS
        csbMtd_nombre   CONSTANT    VARCHAR2(200) := csbPqt_Nombre || 'prActualizaSoloFechaCorte';
	BEGIN
        
        pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbInicio);
        pkg_traza.trace('inuSesunuse: '	|| inuSesunuse, csbNivelTraza);                                 
        pkg_traza.trace('inuSesufeco: ' || inuSesufeco, csbNivelTraza);  
        		
        UPDATE servsusc
        SET sesufeco = inuSesufeco           
        WHERE sesunuse = inuSesunuse;
		 
        pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin);
    
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace('PKG_ERROR.CONTROLLED_ERROR ' || csbMtd_nombre, csbNivelTraza);
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_traza.trace('OTHERS ' || csbMtd_nombre, csbNivelTraza);
            pkg_error.seterror;
            RAISE pkg_error.controlled_error;
	END prActualizaSoloFechaCorte;    
    
END pkg_producto;
/
BEGIN
  pkg_utilidades.prAplicarPermisos('PKG_PRODUCTO', 'ADM_PERSON');
END;
/