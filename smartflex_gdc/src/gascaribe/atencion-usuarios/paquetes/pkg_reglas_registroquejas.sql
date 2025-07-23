CREATE OR REPLACE PACKAGE pkg_reglas_registroquejas
IS
    /******************************************************************
    <Package Fuente="Propiedad Intelectual de GDC">
    <Unidad>pkg_reglas_registroQuejas</Unidad>
    <Autor>Paola Acosta</Autor>
    <Fecha>03-02-2025</Fecha>
    <Descripcion> 
        Paquete para gestion de reglas del tramite Registro de Quejas
        ps_package_type_100030
    </Descripcion>
    <Historial>
           <Modificacion Autor="Paola.Acosta" Fecha="03-02-2025" Inc="OSF-3930" Empresa="GDC">
               Creación
           </Modificacion>          
     </Historial>
     </Package>
    ******************************************************************/

    --------------------------------------------
    -- Funciones y Procedimientos
    --------------------------------------------

    /*****************************************************************
    Unidad      : fsbVersion
    Descripcion : Obtiene la version del paquete
    ******************************************************************/
    FUNCTION fsbVersion
    RETURN VARCHAR2;
	
    /*****************************************************************
    Unidad      : prcReglaAsigDireccionRespuesta
    Descripcion : Asignacion valor Direccion de Respuesta
    ******************************************************************/
    PROCEDURE prcReglaAsigDireccionRespuesta;
    
END pkg_reglas_registroquejas;
/
CREATE OR REPLACE PACKAGE BODY pkg_reglas_registroquejas
IS
    /******************************************************************
    <Package Fuente="Propiedad Intelectual de GDC">
    <Unidad> pkg_reglas_registroQuejas </Unidad>
    <Autor> Paola Acosta</Autor>
    <Fecha> 03-02-2025 </Fecha>
    <Descripcion> 
        Paquete para gestion de reglas del tramite Registro de Quejas
        ps_package_type_100030
    </Descripcion>
    <Historial>
           <Modificacion Autor="Paola.Acosta" Fecha="03-02-2025" Inc="OSF-3930" Empresa="GDC">
               Creación
           </Modificacion>       
     </Historial>
     </Package>
    ******************************************************************/

    --------------------------------------------
    -- Constantes 
    --------------------------------------------
    csbVersion          CONSTANT VARCHAR2(10) := 'OSF-3930';
    csbPqt_nombre       CONSTANT VARCHAR2(100):= $$plsql_unit||'.';
    cnuNvlTrc           CONSTANT NUMBER       := pkg_traza.cnuniveltrzdef;
	csbInicio   		CONSTANT VARCHAR2(35) := pkg_traza.csbInicio;
    csbFin              CONSTANT VARCHAR2(35) := pkg_traza.csbFin;
    csbFin_err          CONSTANT VARCHAR2(35) := pkg_traza.csbFin_err;
    csbFin_erc          CONSTANT VARCHAR2(35) := pkg_traza.csbfin_erc;  
    
    -----------------------------------
    -- Variables privadas del package
    -----------------------------------
    nuError		NUMBER;  		
	sbMensaje   VARCHAR2(1000);
    
    --------------------------------------------
    -- Funciones y Procedimientos
    --------------------------------------------

    /**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de GDC">
    <Unidad> fsbVersion </Unidad>
    <Autor> Paola.Acosta </Autor>
    <Fecha> 03-02-2025 </Fecha>
    <Descripcion> 
        Obtiene la version del paquete.
    </Descripcion>
    <Retorno Nombre="Versión del paquete" Tipo="VARCHAR2">
        Versión del paquete
    </Retorno>
    <Historial>
           <Modificacion Autor="Paola.Acosta" Fecha="03-02-2025" Inc="OSF-3930" Empresa="GDC"> 
               Creación
           </Modificacion>
    </Historial>
    </Procedure>
    **************************************************************************/
    FUNCTION fsbVersion
    RETURN VARCHAR2
    IS
    BEGIN
        RETURN csbVersion;
    END fsbVersion;
  
    /**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> prcReglaAsigDireccionRespuesta </Unidad>
    <Autor>Paola Acosta</Autor>
    <Fecha> 24-01-2025 </Fecha>
    <Descripcion> 
        Servicio para la inicializacion del campo Dirección de Respuesta
    </Descripcion>
    <Historial>
           <Modificacion Autor="Paola.Acosta" Fecha="24-01-2025" Inc="OSF-3930" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </Procedure>
    **************************************************************************/
    PROCEDURE prcReglaAsigDireccionRespuesta
    IS
        --Constantes
        csbMtd_nombre       VARCHAR2(70) := csbPqt_nombre || 'prcReglaAsigDireccionRespuesta';     
        
        --Variables     
        boAtributoInstanciado   BOOLEAN;       
        nuAtributo              NUMBER;
        nuContrato              suscripc.susccodi%TYPE;
        nuDireccion             suscripc.susciddi%TYPE;          
        nuDireccionDefecto      suscripc.susciddi%TYPE := pkg_parametros.fnuGetValorNumerico('DIREC_RESPUESTA_REGIS_QUEJAS');
        
    BEGIN
        pkg_traza.trace(csbMtd_nombre, cnuNvlTrc, csbInicio);
                     
        --Retorna si un atributo se encuentra instanciado o no
        boAtributoInstanciado := ge_boInstanceControl.fblAcckeyAttributesTack('WORK_INSTANCE', NULL, 'SUSCRIPC', 'SUSCCODI', nuAtributo);        
        
        --Si el atributo esta instanciado
        IF boAtributoInstanciado = TRUE THEN      
                 
            --Obtener contrato
            ge_boInstanceControl.getAttributeNewValue('WORK_INSTANCE', NULL, 'SUSCRIPC', 'SUSCCODI', nuContrato);
            pkg_traza.trace('nuContrato: '||nuContrato, cnuNvlTrc);             
            
            --Obtener direccion
            nuDireccion := pkg_bcContrato.fnuIdDireccReparto(nuContrato);                  
          
        ELSE                        
            nuDireccion := nuDireccionDefecto;
                        
        END IF;
        
        pkg_traza.trace('Direccion: '|| nuDireccion, cnuNvlTrc); 
        
        --Establecer direccion
        ge_boInstanceControl.setEntityAttribute(nuDireccion);                 
    
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
    END prcReglaAsigDireccionRespuesta; 
        
    
END pkg_reglas_registroquejas;
/
BEGIN
    pkg_utilidades.praplicarpermisos(UPPER('pkg_reglas_registroQuejas'),'OPEN'); 
END;
/