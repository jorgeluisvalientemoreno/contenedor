CREATE OR REPLACE PACKAGE personalizaciones.pkg_bcPagos IS
    /******************************************************************
    <Package Fuente="Propiedad Intelectual de GDC">
    <Unidad>pkg_bcPagos</Unidad>
    <Autor>Paola Acosta</Autor>
    <Fecha>23-04-2025</Fecha>
    <Descripcion> 
        Paquete con los servicios de consulta para las tablas: CUPON, PAGOS,
        RESURECA y RC_PAGOPEND
    </Descripcion>
    <Historial>
           <Modificacion Autor="Jhon.Soto" Fecha="09-06-2025" Inc="OSF-4574" Empresa="GDC">
               Modificacion: creacion metodo fnuObtCuponSolicitud            
           </Modificacion>  
           <Modificacion Autor="Paola.Acosta" Fecha="23-04-2025" Inc="OSF-4514" Empresa="GDC">
               Modificacion cursor cuCantPagosXFechaPago, cambio campo pagofepa por pagofegr
           </Modificacion>  
           <Modificacion Autor="Paola.Acosta" Fecha="23-04-2025" Inc="OSF-4293" Empresa="GDC">
               Creacion
           </Modificacion>          
     </Historial>
     </Package>
    ******************************************************************/
 
    --------------------------------------------
    -- Cursores
    --------------------------------------------    
    --Consulta los pagos asociados a un contrato 
    CURSOR cuCantPagosXFechaPago(inuSusc  IN servsusc.sesususc%TYPE,
                                 idtFecha IN pagos.pagofepa%TYPE) 
    IS
    SELECT COUNT(1)
    FROM pagos
    WHERE pagosusc = inuSusc
    AND pagofegr >= idtFecha;
        
    -----------------------------------
    -- Tipos/Subtipos
    -----------------------------------
        
    -----------------------------------
    -- Metodos
    -----------------------------------    
    /*****************************************************************
    Unidad      : fsbVersion
    Descripcion : Obtiene la version del paquete
    ******************************************************************/
    FUNCTION fsbVersion 
    RETURN VARCHAR2;                                  
    
    /*****************************************************************
    Unidad      : fnuObtCantPagosXFechaPago
    Descripcion : Retorna informacion de los pagos asociados a una suscripcion
    ******************************************************************/    
    FUNCTION fnuObtCantPagosXFechaPago(inuSusc  IN servsusc.sesususc%TYPE,
                                       idtFecha IN pagos.pagofepa%TYPE)
    RETURN NUMBER;  
    
    /*****************************************************************
    Unidad      : fnuObtCuponSolicitud
    Descripcion : Obtiene el Numero de cupon de pago asociado a la solicitud de cotizacion
    ******************************************************************/  
    FUNCTION fnuObtCuponSolicitud(inuSolicitud IN cupon.cupodocu%TYPE)
    RETURN NUMBER;
 
END pkg_bcPagos;
/

CREATE OR REPLACE PACKAGE BODY personalizaciones.pkg_bcPagos IS
    /******************************************************************
    <Package Fuente="Propiedad Intelectual de GDC">
    <Unidad>pkg_bcPagos</Unidad>
    <Autor>Paola Acosta</Autor>
    <Fecha>23-04-2025</Fecha>
    <Descripcion> 
        Paquete con los servicios de consulta para las tablas: CUPON, PAGOS,
        RESURECA y RC_PAGOPEND
    </Descripcion>
    <Historial>
           <Modificacion Autor="Paola.Acosta" Fecha="23-04-2025" Inc="OSF-4293" Empresa="GDC">
               Creacion
           </Modificacion>       
     </Historial>
     </Package>
    ******************************************************************/

    --------------------------------------------
    -- Constantes 
    --------------------------------------------
    csbVersion      CONSTANT VARCHAR2(10)  := 'OSF-4514';
    csbPqt_nombre   CONSTANT VARCHAR2(100) := $$plsql_unit || '.';
    cnuNvlTrc       CONSTANT NUMBER        := pkg_traza.cnuNivelTrzDef;
    csbInicio       CONSTANT VARCHAR2(35)  := pkg_traza.csbInicio;
    csbFin          CONSTANT VARCHAR2(35)  := pkg_traza.csbFin;
    csbFin_err      CONSTANT VARCHAR2(35)  := pkg_traza.csbFin_err;
    csbFin_erc      CONSTANT VARCHAR2(35)  := pkg_traza.csbfin_erc;  
    
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
    <Fecha> 23-04-2025 </Fecha>
    <Descripcion> 
        Obtiene la version del paquete.
    </Descripcion>
    <Retorno Nombre="Version del paquete" Tipo="VARCHAR2">
        Version del paquete
    </Retorno>
    <Historial>
           <Modificacion Autor="Paola.Acosta" Fecha="23-04-2025" Inc="OSF-4293" Empresa="GDC"> 
               Creacion
           </Modificacion>
    </Historial>
    </Procedure>
    **************************************************************************/
    FUNCTION fsbVersion RETURN VARCHAR2 IS
    BEGIN
        RETURN csbVersion;
    END fsbVersion;
    
    /**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de GDC">
        <Unidad> fnuObtCantPagosXFechaPago </Unidad>
        <Autor> Paola.Acosta </Autor>
        <Fecha> 23-04-2025 </Fecha>
        <Descripcion> 
            Retorna informacion de los pagos asociados a una suscripcion
        </Descripcion>    
        <Historial>
            <Modificacion Autor="Paola.Acosta" Fecha="23-04-2025" Inc="OSF-4293" Empresa="GDC"> 
                Creacion
            </Modificacion>
        </Historial>
    </Procedure>
    **************************************************************************/  
    FUNCTION fnuObtCantPagosXFechaPago(inuSusc  IN servsusc.sesususc%TYPE,
                     idtFecha IN pagos.pagofepa%TYPE)
    RETURN NUMBER
    IS
        --Constantes
        csbMtd_nombre CONSTANT VARCHAR2(70) := csbPqt_nombre || 'fnuObtCantPagosXFechaPago';
                
        --Variables
        onuPago NUMBER;
    
    BEGIN
        pkg_traza.trace(csbMtd_nombre, cnuNvlTrc, csbInicio); 
        
        IF cuCantPagosXFechaPago%ISOPEN THEN 
            CLOSE cuCantPagosXFechaPago; 
        END IF;
        
        OPEN cuCantPagosXFechaPago(inuSusc, idtFecha);
        FETCH cuCantPagosXFechaPago INTO onuPago;
        CLOSE cuCantPagosXFechaPago;
        
        pkg_traza.trace(csbMtd_nombre, cnuNvlTrc, csbFin);
        
        RETURN onuPago;
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
    END fnuObtCantPagosXFechaPago;
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuObtCuponSolicitud
    Descripcion     : Obtiene el Numero de cupon de pago asociado a la solicitud de cotizacion
    Autor           : Jsoto
    Fecha           : 11-06-2025
    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    jsoto     	09-06-2025  OSF-4574 Creacion
    ***************************************************************************/    
    FUNCTION fnuObtCuponSolicitud(inuSolicitud IN cupon.cupodocu%TYPE)
    RETURN NUMBER
    IS    
        nuError			NUMBER;
        sbError			VARCHAR(4000);
        csbMtd_nombre		VARCHAR2(70) 	:= csbPqt_nombre || 'fnuObtCuponSolicitud';
        nuCupon			NUMBER;
        
        CURSOR cuCuponPorSolicitud
        IS
        SELECT cuponume
        FROM cupon
        WHERE cupodocu = to_char(inuSolicitud)
        ORDER BY 1 DESC;
    
    BEGIN
    
        pkg_traza.trace( csbMtd_nombre, cnuNvlTrc, csbInicio);
        
        pkg_traza.trace('inuSolicitud: '||inuSolicitud);
        IF cuCuponPorSolicitud%ISOPEN THEN
            CLOSE cuCuponPorSolicitud;
        END IF;
        OPEN cuCuponPorSolicitud;
        FETCH cuCuponPorSolicitud INTO nuCupon;
        CLOSE cuCuponPorSolicitud;
        pkg_traza.trace('nuCupon: '||nuCupon);
        pkg_traza.trace( csbMtd_nombre, cnuNvlTrc, csbFin);
    
        RETURN nuCupon;
    EXCEPTION
        WHEN OTHERS THEN
            pkg_error.setError;
            pkg_error.getError(nuError, sbError);
            pkg_traza.trace(nuError||':'||sbError || csbMtd_nombre, cnuNvlTrc);
            pkg_traza.trace(csbMtd_nombre, cnuNvlTrc, csbFin_err);
            RAISE pkg_error.controlled_error;
    END fnuObtCuponSolicitud;
    
END pkg_bcPagos;
/

BEGIN
    pkg_utilidades.praplicarpermisos(upper('pkg_bcPagos'), 'PERSONALIZACIONES');
END;
/