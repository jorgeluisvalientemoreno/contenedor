CREATE OR REPLACE PACKAGE adm_person.pkg_pr_comp_suspension IS
  /*******************************************************************************
      Fuente=Propiedad Intelectual de Gases del Caribe
      pkg_pr_comp_suspension
      Autor            :      Jorge Valiente
      Fecha            :      18/03/2024      
      Descripcion      :      Paquete para realizar CRUD sobre la entidad pr_comp_suspension   
      Modificaciones   :      
      Autor       Fecha       Caso          Descripcion
      PAcosta     21/04/2025  OSF-4270      Creacion metodos: prcActFechaInactivaActivo y prcInsRegistro  
                                            Creación variables globales para el control de la traza  
  *******************************************************************************/

    -- Retona Identificador del ultimo caso que hizo cambios en este archivo
    FUNCTION fsbVersion RETURN VARCHAR2;
    
    --Actualiza la fecha final indicando hasta donde estuvo suspendido el componente del producto
    PROCEDURE prcActualizaFechaFinal(inuCodigoComponente     IN number,
                                     idtFechaFinalSuspension IN date);
    
    --Inactiva el componente suspendido del producto con la fecha final de ejecucion de la orden legalizada
    PROCEDURE prcInactivaSuspension(inuCodigoComponente     IN number,
                                    idtFechaFinalSuspension IN date);
    
    --Actualiza los campos fecha inactiva y activo                               
    PROCEDURE prcActFechaInactivaActivo(inuIdComponente IN pr_comp_suspension.component_id%TYPE,
                                        inuIdTipoSuspen IN pr_comp_suspension.suspension_type_id%TYPE,
                                        inuActivoAnt    IN pr_comp_suspension.active%TYPE,
                                        inuActivoNue    IN pr_comp_suspension.active%TYPE,
                                        idtFechaInctiva IN pr_comp_suspension.inactive_date%TYPE);    

    --Inserta registro
    PROCEDURE prcInsRegistro(ircRegistro IN pr_comp_suspension%ROWTYPE);    

END pkg_pr_comp_suspension;
/
CREATE OR REPLACE PACKAGE BODY adm_person.pkg_pr_comp_suspension IS

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
  Descripcion     : Actualiza la fecha final indicando hasta donde estuvo suspendido el componente del producto
  Autor           : Jorge Valiente
  Fecha           : 18/03/2024 
  
  Parametros de Entrada
  inuSesunuse Codido del servicio 
  inuSesuesco Codigo del estado de corte
  
  Parametros de Salida
  
  Modificaciones  :
  Autor       Fecha       Caso     Descripcion
  ***************************************************************************/
  PROCEDURE prcActualizaFechaFinal(inuCodigoComponente     IN NUMBER,
                                   idtFechaFinalSuspension IN DATE) 
    IS
        -- Nombre de este metodo
        csbMetodo   VARCHAR2(70) := csbPqt_nombre || 'prcActualizaFechaFinal';       
        
    BEGIN    
        pkg_traza.trace(csbMetodo, cnuNvlTrc, csbInicio);
        
        UPDATE pr_comp_suspension
        SET inactive_date = idtFechaFinalSuspension
        WHERE comp_suspension_id = inuCodigoComponente
        AND active = 'Y';
        
        pkg_traza.trace('El componente de suspension ' || inuCodigoComponente ||' se actualiza a la fecha final de suspension ' ||idtFechaFinalSuspension, cnuNvlTrc);
        
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
  Descripcion     : Inactiva el componente suspendido del producto con la fecha final de ejecucion de la orden legalizada
  Autor           : Jorge Valiente
  Fecha           : 18/03/2024 
  
  Parametros de Entrada
  inuProducto   Codido del producto 
  sbActivo      La suspension esta o no activa YES[Y], NO[N]
  
  Parametros de Salida
  
  Modificaciones  :
  Autor       Fecha       Caso     Descripcion
  ***************************************************************************/
  PROCEDURE prcInactivaSuspension(inuCodigoComponente     IN number,
                                    idtFechaFinalSuspension IN date) 
    IS
        -- Nombre de este metodo
        csbMetodo   VARCHAR2(70) := csbPqt_nombre || 'prcInactivaSuspension';    
   
    BEGIN    
        pkg_traza.trace(csbMetodo, cnuNvlTrc, csbInicio);
    
        UPDATE pr_comp_suspension
        SET active = 'N', 
            inactive_date = idtFechaFinalSuspension
        WHERE comp_suspension_id = inuCodigoComponente;
    
        pkg_traza.trace('El componente ' ||inuCodigoComponente||' dejo de estar suspendido el '||idtFechaFinalSuspension, cnuNvlTrc);
    
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
        <Unidad> prcActFechaInactivaActivo </Unidad>
        <Autor> Paola.Acosta </Autor>
        <Fecha> 21-04-2025 </Fecha>
        <Descripcion> 
            Actualizacion campo ACTIVE
        </Descripcion>    
        <Historial>
            <Modificacion Autor="Paola.Acosta" Fecha="21-04-2025" Inc="OSF-4270" Empresa="GDC"> 
                Creación
            </Modificacion>
        </Historial>
    </Procedure>
    **************************************************************************/
    PROCEDURE prcActFechaInactivaActivo(inuIdComponente IN pr_comp_suspension.component_id%TYPE,
                                        inuIdTipoSuspen IN pr_comp_suspension.suspension_type_id%TYPE,
                                        inuActivoAnt    IN pr_comp_suspension.active%TYPE,
                                        inuActivoNue    IN pr_comp_suspension.active%TYPE,
                                        idtFechaInctiva IN pr_comp_suspension.inactive_date%TYPE)
    IS
        csbMtd_nombre       VARCHAR2(70) := csbPqt_nombre || 'prcActFechaInactivaActivo';
    
    BEGIN
        pkg_traza.trace(csbMtd_nombre, cnuNvlTrc, csbInicio); 
        
        UPDATE pr_comp_suspension 
        SET inactive_date = idtFechaInctiva,
            active = inuActivoNue        
        WHERE component_id = inuIdComponente
        AND suspension_type_id = inuIdTipoSuspen
        AND active = inuActivoAnt;   
        
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
    END prcActFechaInactivaActivo;
    
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
    PROCEDURE prcInsRegistro(ircRegistro IN pr_comp_suspension%ROWTYPE)
    IS
        csbMtd_nombre       VARCHAR2(70) := csbPqt_nombre || 'prcInsRegistro';
        rcRegistro          pr_comp_suspension%ROWTYPE;
    
    BEGIN
        pkg_traza.trace(csbMtd_nombre, cnuNvlTrc, csbInicio); 
        
        rcRegistro := ircRegistro;
        rcRegistro.comp_suspension_id := SEQ_PR_COMP_SUSPENSION.NEXTVAL;
        
        INSERT INTO pr_comp_suspension (
            comp_suspension_id, 
            component_id, 
            suspension_type_id, 
            register_date, 
            aplication_date, 
            inactive_date, 
            active
        ) VALUES (
            rcRegistro.comp_suspension_id, 
            rcRegistro.component_id, 
            rcRegistro.suspension_type_id, 
            rcRegistro.register_date, 
            rcRegistro.aplication_date, 
            rcRegistro.inactive_date, 
            rcRegistro.active
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

END pkg_pr_comp_suspension;
/
BEGIN
  pkg_utilidades.prAplicarPermisos('PKG_PR_COMP_SUSPENSION', 'ADM_PERSON');
END;
/
