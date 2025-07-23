CREATE OR REPLACE PACKAGE adm_person.pkg_pr_prod_suspension IS
  /*******************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Paquete           :   pkg_pr_prod_suspension
    Autor            :      Jorge Valiente
    Fecha            :      18/03/2024      
    Descripcion      :      Paquete para realizar CRUD sobre la entidad PR_PROD_SUSPENSION   
    Modificaciones   :      
    Autor       Fecha         Caso          Descripcion
    jpinedc     13/01/2025    OSF-3828      Se agrega el cursor cuPR_PROD_SUSPENSION_PROD
    PAcosta     21-04-2025    OSF-4270      Se crean los procesos prcInactivarSuspensionPorId y prcInsRegistro                                   
                                            Se crean constantes globales para control de traza   
  *******************************************************************************/

    -----------------------------------
    -- Metodos
    -----------------------------------
    -- Retona Identificador del ultimo caso que hizo cambios en este archivo
    FUNCTION fsbVersion 
    RETURN VARCHAR2;
    
    --Actualiza la fecha final indicando hasta donde estuvo suspendido en producto
    PROCEDURE prcActualizaFechaFinal(inuProducto             IN number,
                                     idtFechaFinalSuspension IN  date);
    
    --Inactiva el producto suspendido con la fecha final de ejecucion de la orden legalizada
    PROCEDURE prcInactivaSuspension(inuProducto             IN number,
                                    idtFechaFinalSuspension IN date);
                                  
    --Actualiza campo estado Activo
    PROCEDURE prcInactivarSuspensionPorId(inuProdSuspenId IN pr_prod_suspension.prod_suspension_id%TYPE);
                                
    --Inserta registro
    PROCEDURE prcInsRegistro(ircRegistro IN pr_prod_suspension%ROWTYPE);    

    -----------------------------------
    -- Cursores
    -----------------------------------
    -- Obtiene los registros de suspensiones de un producto
    CURSOR cuPR_PROD_SUSPENSION_PROD( inuProducto NUMBER) IS 
    SELECT * FROM PR_PROD_SUSPENSION WHERE PRODUCT_ID =inuProducto ;
    
END pkg_pr_prod_suspension;
/

CREATE OR REPLACE PACKAGE BODY adm_person.pkg_pr_prod_suspension IS

    --------------------------------------------
    -- Constantes globales para control de traza
    --------------------------------------------       
    cnuNvlTrc           CONSTANT NUMBER       := pkg_traza.cnuNivelTrzDef;
	csbInicio   		CONSTANT VARCHAR2(35) := pkg_traza.csbInicio;
    csbFin              CONSTANT VARCHAR2(35) := pkg_traza.csbFin;
    csbFin_err          CONSTANT VARCHAR2(35) := pkg_traza.csbFin_err;
    csbFin_erc          CONSTANT VARCHAR2(35) := pkg_traza.csbfin_erc;  
    csbPqt_nombre       CONSTANT VARCHAR2(35) := $$PLSQL_UNIT || '.';
    
    -----------------------------------
    -- Variables privadas del package
    -----------------------------------
    nuError		NUMBER;  		
	sbMensaje   VARCHAR2(5000);  
    
    -- Identificador del ultimo caso que hizo cambios
    csbVersion VARCHAR2(15) := 'OSF-4270';

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbVersion
    Descripcion     : Retona la ultima modificacion que hizo cambios en el paquete
    Autor           : 
    Fecha           : 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    ***************************************************************************/
    FUNCTION fsbVersion RETURN VARCHAR2 IS
    BEGIN
    RETURN csbVersion;
    END fsbVersion;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prcActualizaFechaFinal
    Descripcion     : Actualiza la fecha final indicando hasta donde estuvo suspendido en producto
    Autor           : Jorge Valiente
    Fecha           : 18/03/2024 
    
    Parametros de Entrada
    inuSesunuse Codido del servicio 
    inuSesuesco Codigo del estado de corte
    
    Parametros de Salida
    
    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    ***************************************************************************/
    PROCEDURE prcActualizaFechaFinal(inuProducto             IN number,
                                     idtFechaFinalSuspension IN date) 
    IS
        -- Nombre de este metodo
        csbMetodo   VARCHAR2(70) := csbPqt_nombre || 'prcActualizaFechaFinal';     
    BEGIN    
        pkg_traza.trace(csbMetodo, cnuNvlTrc, csbInicio);
    
        UPDATE PR_PROD_SUSPENSION
        SET INACTIVE_DATE = idtFechaFinalSuspension
        WHERE PRODUCT_ID = inuProducto
          AND ACTIVE = 'Y';
    
        pkg_traza.trace('El producto '||inuProducto||' se actualiza a la fecha final de suspension '||idtFechaFinalSuspension, cnuNvlTrc);
    
        pkg_traza.trace(csbMetodo, cnuNvlTrc, csbFin);    
    EXCEPTION
        WHEN pkg_Error.Controlled_Error THEN
            pkg_Error.getError(nuError, sbMensaje);
            pkg_traza.trace('Error: ' || sbMensaje, cnuNvlTrc);
            pkg_traza.trace(csbMetodo, cnuNvlTrc, csbFin_erc);
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbMensaje);
            pkg_traza.trace('Error: ' || sbMensaje, cnuNvlTrc);
            pkg_traza.trace(csbMetodo, cnuNvlTrc, csbFin_err);    
    END prcActualizaFechaFinal;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prcInactivaSuspension
    Descripcion     : Inactiva el producto suspendido con la fecha final de ejecucion de la orden legalizada
    Autor           : Jorge Valiente
    Fecha           : 18/03/2024 
    
    Parametros de Entrada
    inuProducto                Codido del producto 
    dtFechaFinalSuspension     Fecha final de ejecucion de la orden legalizada
    
    Parametros de Salida
    
    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    ***************************************************************************/
    PROCEDURE prcInactivaSuspension(inuProducto             IN number,
                                    idtFechaFinalSuspension IN date) 
    IS
        -- Nombre de este metodo
        csbMetodo   VARCHAR2(70) := csbPqt_nombre || 'prcInactivaSuspension';   
    BEGIN    
        pkg_traza.trace(csbMetodo, cnuNvlTrc, csbInicio);
    
        UPDATE PR_PROD_SUSPENSION
        SET ACTIVE = 'N', 
            INACTIVE_DATE = idtFechaFinalSuspension
        WHERE PRODUCT_ID = inuProducto
          AND ACTIVE = 'Y';
    
        pkg_traza.trace('El producto '||inuProducto||' dejo de estar suspendido el '||idtFechaFinalSuspension, cnuNvlTrc);
        
        pkg_traza.trace(csbMetodo, cnuNvlTrc, csbFin);    
    EXCEPTION
        WHEN pkg_Error.Controlled_Error THEN
              pkg_Error.getError(nuError, sbMensaje);
              pkg_traza.trace('Error: ' || sbMensaje, cnuNvlTrc);
              pkg_traza.trace(csbMetodo, cnuNvlTrc, csbFin_erc);
        WHEN OTHERS THEN
              pkg_Error.setError;
              pkg_Error.getError(nuError, sbMensaje);
              pkg_traza.trace('Error: ' || sbMensaje, cnuNvlTrc);
              pkg_traza.trace(csbMetodo, cnuNvlTrc, csbFin_err);    
    END prcInactivaSuspension;
    
    /**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de GDC">
        <Unidad> prcInactivarSuspensionPorId </Unidad>
        <Autor> Paola.Acosta </Autor>
        <Fecha> 21-04-2025 </Fecha>
        <Descripcion> 
            Actualiza campo estado Activo
        </Descripcion>    
        <Historial>
            <Modificacion Autor="Paola.Acosta" Fecha="21-04-2025" Inc="OSF-4270" Empresa="GDC"> 
                Creación
            </Modificacion>
        </Historial>
    </Procedure>
    **************************************************************************/
    PROCEDURE prcInactivarSuspensionPorId(inuProdSuspenId IN pr_prod_suspension.prod_suspension_id%TYPE)
    IS
        csbMtd_nombre       VARCHAR2(70) := csbPqt_nombre || 'prcInactivarSuspensionPorId';
    
    BEGIN
        pkg_traza.trace(csbMtd_nombre, cnuNvlTrc, csbInicio); 
        
        UPDATE pr_prod_suspension
        SET inactive_date = sysdate,
            active = 'N'
        WHERE prod_suspension_id = inuProdSuspenId;
        
        pkg_traza.trace(csbMtd_nombre, cnuNvlTrc, csbFin);
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
    END prcInactivarSuspensionPorId;   
    
    /**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de GDC">
        <Unidad> prcInsRegistro </Unidad>
        <Autor> Paola.Acosta </Autor>
        <Fecha> 21-04-2025 </Fecha>
        <Descripcion> 
            Inserta registro
        </Descripcion>    
        <Historial>
            <Modificacion Autor="Paola.Acosta" Fecha="21-04-2025" Inc="OSF-4270" Empresa="GDC"> 
                Creación
            </Modificacion>
        </Historial>
    </Procedure>
    **************************************************************************/
    PROCEDURE prcInsRegistro(ircRegistro IN pr_prod_suspension%ROWTYPE)
    IS
        csbMtd_nombre       VARCHAR2(70) := csbPqt_nombre || 'prcInsRegistro';
        rcRegistro          pr_prod_suspension%ROWTYPE;
    
    BEGIN
        pkg_traza.trace(csbMtd_nombre, cnuNvlTrc, csbInicio); 
        
        rcRegistro := ircRegistro;
        rcRegistro.prod_suspension_id := SEQ_PR_PROD_SUSPENSION.NEXTVAL;
        
        INSERT INTO pr_prod_suspension (
            prod_suspension_id,
            product_id,
            suspension_type_id,
            register_date,
            aplication_date,
            inactive_date,
            active,
            connection_code
        ) VALUES (
            rcRegistro.prod_suspension_id,
            rcRegistro.product_id,
            rcRegistro.suspension_type_id,
            rcRegistro.register_date,
            rcRegistro.aplication_date,
            rcRegistro.inactive_date,
            rcRegistro.active,
            rcRegistro.connection_code
        );
        
        pkg_traza.trace(csbMtd_nombre, cnuNvlTrc, csbFin);
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
    END prcInsRegistro;     

END pkg_pr_prod_suspension;
/

BEGIN
  pkg_utilidades.prAplicarPermisos('PKG_PR_PROD_SUSPENSION', 'ADM_PERSON');
END;
/

