CREATE OR REPLACE PACKAGE personalizaciones.pkg_bcsolicitud_interaccion
IS
    /******************************************************************
    <Package Fuente="Propiedad Intelectual de GDC">
    <Unidad> pkg_bcsolicitud_interaccion </Unidad>
    <Autor> Paola Acosta</Autor>
    <Fecha> 24-12-2024 </Fecha>
    <Descripcion> 
        Paquete de gestión de flujos
    </Descripcion>
    <Historial>
           <Modificacion Autor="Paola.Acosta" Fecha="24-12-2024" Inc="OSF-3755" Empresa="GDC">
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
    Unidad      : fnuValTipoRecepcionEscrito
    Descripcion : Valida medio de recepcion escrito
    ******************************************************************/
    FUNCTION fnuValTipoRecepcionEscrito
    (
        inuIdSolicitud IN mo_packages.package_id%type
    )
    RETURN NUMBER;
    
    /*****************************************************************
    Unidad      : fnuValTipoSolUniOpeCau
    Descripcion : Valida tipo solicitud, unidad operativa y causal
    ******************************************************************/
    FUNCTION fnuValTipoSolUniOpeCau
    (        
       isbIdSolicitudPadre IN mo_packages.cust_care_reques_num%TYPE   
    )
    RETURN NUMBER;
	
    
    /*****************************************************************
    Unidad      : fnuTipSolPerInteraccion
    Descripcion : Valida tipo solicitud para permitir interaccion
    ******************************************************************/
    FUNCTION fnuTipSolPerInteraccion
    (
        inuIdSolicitud IN mo_packages.package_id%type
    ) 
    RETURN NUMBER;
	

    
END pkg_bcsolicitud_interaccion;
/
CREATE OR REPLACE PACKAGE BODY personalizaciones.pkg_bcsolicitud_interaccion
IS
    /******************************************************************
    <Package Fuente="Propiedad Intelectual de GDC">
    <Unidad> pkg_bcsolicitud_interaccion </Unidad>
    <Autor> Paola Acosta</Autor>
    <Fecha> 24-12-2024 </Fecha>
    <Descripcion> 
        Paquete de gestión de flujos
    </Descripcion>
    <Historial>
           <Modificacion Autor="Paola.Acosta" Fecha="24-12-2024" Inc="OSF-3755" Empresa="GDC">
               Creación
           </Modificacion>       
     </Historial>
     </Package>
    ******************************************************************/

    --------------------------------------------
    -- Constantes 
    --------------------------------------------
    csbVersion          CONSTANT VARCHAR2(10) := 'OSF-3755';
    csbPqtNombre        CONSTANT VARCHAR2(100):= $$PLSQL_UNIT||'.';
    cnuNvlTraza         CONSTANT NUMBER       := pkg_traza.cnuNivelTrzDef;
	csbInicio   		CONSTANT VARCHAR2(35) := pkg_traza.fsbInicio;
    
    -----------------------------------
    -- Variables privadas del package
    -----------------------------------
    
    --------------------------------------------
    -- Funciones y Procedimientos
    --------------------------------------------

    /**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de GDC">
    <Unidad> fsbVersion </Unidad>
    <Autor> Paola.Acosta </Autor>
    <Fecha> 24-12-2024 </Fecha>
    <Descripcion> 
        Obtiene la version del paquete.
    </Descripcion>    
    <Historial>
           <Modificacion Autor="Paola.Acosta" Fecha="24-12-2024" Inc="OSF-3755" Empresa="GDC"> 
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
    <Unidad> fnuValTipoRecepcionEscrito </Unidad>
    <Autor> Paola Acosta</Autor>
    <Fecha> 24-12-2024 </Fecha>
    <Descripcion> 
        Funcion que validar si el medio de recpcion de las solicitudes
        asociadas a la interaccion son de medio de recepcion escrito
        Retorna 1 Si es escrito
        Retorna 0 Si no es escrito
    </Descripcion>
    <Historial>
           <Modificacion Autor="Paola.Acosta" Fecha="24-12-2024" Inc="OSF-3755" Empresa="GDC">
               Creacion: Migracion del obejto ld_bortainteraccion.fnureceptypeinteraccioniswrite
           </Modificacion>
    </Historial>
    </Procedure>
    **************************************************************************/
    FUNCTION fnuValTipoRecepcionEscrito
    (        
       inuIdSolicitud       in mo_packages.package_id%type    
    )
    RETURN NUMBER
    IS
		csbMtdName  VARCHAR2(70) := csbPqtNombre || 'fnuValTipoRecepcionEscrito';
             
        nuError				NUMBER;  	
		sbMensaje   		VARCHAR2(1000);
        
        --Variables
        nuEsEscrito         NUMBER(1);
        
        --Cursores
        CURSOR cuValTipoRecep IS
        SELECT nvl(MAX(decode(b.is_write, 'Y', 1, 0)), 0) flag_validate
        FROM  mo_packages       a,
              ge_reception_type b
        WHERE a.package_id IN (
                                SELECT package_id
                                FROM   mo_packages_asso
                                WHERE  package_id_asso = inuIdSolicitud
                              )
        AND  a.reception_type_id = b.reception_type_id;
        
    BEGIN
		
		pkg_traza.trace(csbMtdName, cnuNvlTraza, csbInicio);
		
        OPEN  cuValTipoRecep;
        FETCH cuValTipoRecep INTO nuEsEscrito;
        CLOSE cuValTipoRecep;
		
        pkg_traza.trace(csbPqtNombre, cnuNvlTraza, pkg_traza.csbFIN);      
        
		RETURN nuEsEscrito; 		

    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_error.setError;
            pkg_error.getError(nuError, sbMensaje);
            pkg_traza.trace('nuError: ' || nuError || ' sbMensaje: ' || sbMensaje, cnuNvlTraza);
            pkg_traza.trace(csbPqtNombre, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFin_erc); 
            RAISE pkg_error.controlled_error;
        WHEN others THEN
            pkg_error.setError;
            pkg_error.getError(nuError, sbMensaje);
            pkg_traza.trace('nuError: ' || nuError || ' sbMensaje: ' || sbMensaje, cnuNvlTraza);
            pkg_traza.trace(csbPqtNombre, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFin_err); 
            RAISE pkg_error.controlled_error;
    END fnuValTipoRecepcionEscrito;    
    
    /**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> fnuValTipoSolUniOpeCau </Unidad>
    <Autor> Paola Acosta</Autor>
    <Fecha> 24-12-2024 </Fecha>
    <Descripcion> 
        Valida el tipo de solicitud, unidad operativa y causal
    </Descripcion>
    <Historial>
           <Modificacion Autor="Paola.Acosta" Fecha="24-12-2024" Inc="OSF-3755" Empresa="GDC">
               Creacion
           </Modificacion>
    </Historial>
    </Procedure>
    **************************************************************************/
    FUNCTION fnuValTipoSolUniOpeCau
    (        
       isbIdSolicitudPadre IN mo_packages.cust_care_reques_num%TYPE   
    )
    RETURN NUMBER
    IS
		csbMtdName  VARCHAR2(70) := csbPqtNombre || 'fnuValTipoSolUniOpeCau';
             
        nuError				NUMBER;  	
		sbMensaje   		VARCHAR2(1000);
        
        --Constantes       
        csbCausales      CONSTANT parametros.valor_cadena%TYPE := pkg_parametros.fsbGetValorCadena('CAUSALES_FLAG_VALIDATE');
        csbTipoSolicitud CONSTANT parametros.valor_cadena%TYPE := pkg_parametros.fsbGetValorCadena('TIPO_SOLICITUD_FLAG_VALIDATE');
        csbTipoUnidad    CONSTANT parametros.valor_cadena%TYPE := pkg_parametros.fsbGetValorCadena('TIPO_UNIDAD_FLAG_VALIDATE');
            
        --Variables
        onuRespuesta        NUMBER;
        
        --Cursores
        CURSOR cuValidaSol 
        IS
        SELECT
            DECODE(COUNT(1),0,0,1) flag_validate
        FROM
            mo_packages p
            INNER JOIN mo_motive m ON m.package_id = p.package_id 
            AND m.causal_id IN (
                                SELECT to_number(regexp_substr(csbCausales,
                                        '[^,]+',
                                        1,
                                        LEVEL)) AS tipoitem
                                FROM dual
                                CONNECT BY regexp_substr(csbCausales, '[^,]+', 1, LEVEL) IS NOT NULL
                                )
            INNER JOIN or_operating_unit u ON u.operating_unit_id = p.management_area_id 
            AND u.unit_type_id IN (
                                    SELECT to_number(regexp_substr(csbTipoUnidad,
                                            '[^,]+',
                                            1,
                                            LEVEL)) AS tipoitem
                                    FROM dual
                                    CONNECT BY regexp_substr(csbTipoUnidad, '[^,]+', 1, LEVEL) IS NOT NULL
                                    )
        WHERE
            p.cust_care_reques_num LIKE '%'||isbIdSolicitudPadre||'%'
            AND p.package_type_id IN (
                                        SELECT to_number(regexp_substr(csbTipoSolicitud,
                                            '[^,]+',
                                            1,
                                            LEVEL)) AS tipoitem
                                        FROM dual
                                        CONNECT BY regexp_substr(csbTipoSolicitud, '[^,]+', 1, LEVEL) IS NOT NULL
                                        );  
        
    BEGIN
		
		pkg_traza.trace(csbMtdName, cnuNvlTraza, csbInicio);
		
        OPEN cuValidaSol;
        FETCH cuValidaSol INTO onuRespuesta;
        CLOSE cuValidaSol; 
		
        pkg_traza.trace(csbPqtNombre, cnuNvlTraza, pkg_traza.csbFIN);
        
		RETURN onuRespuesta; 
        
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_error.setError;
            pkg_error.getError(nuError, sbMensaje);
            pkg_traza.trace('nuError: ' || nuError || ' sbMensaje: ' || sbMensaje, cnuNvlTraza);
            pkg_traza.trace(csbPqtNombre, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFin_erc); 
            RAISE pkg_error.controlled_error;
        WHEN others THEN
            pkg_error.setError;
            pkg_error.getError(nuError, sbMensaje);
            pkg_traza.trace('nuError: ' || nuError || ' sbMensaje: ' || sbMensaje, cnuNvlTraza);
            pkg_traza.trace(csbPqtNombre, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFin_err); 
            RAISE pkg_error.controlled_error;
        END fnuValTipoSolUniOpeCau;    
    
    /**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> fnuTipSolPerInteraccion </Unidad>
    <Autor> Paola Acosta</Autor>
    <Fecha> 23-12-2024 </Fecha>
    <Descripcion> 
        Funcion que valida si la solicitud asociada a la Solicitud Interaccion esta configurado 
        en el parametro TIPO_SOL_PERMITIDA_INTERACCION para permitirle generar o no el flujo de la interaccion.
        Retorna 1 Si genera interaccion 
        Retorna 0 No genera interaccion 
    </Descripcion>
    <Historial>
           <Modificacion Autor="Paola Acosta" Fecha="23-12-2024" Inc="OSF-3755" Empresa="GDC">
               Creacion: Migración del objeto ld_bortainteraccion.fnuTipSolPerInteraccion 
           </Modificacion>
    </Historial>
    </Procedure>
    **************************************************************************/
    FUNCTION fnuTipSolPerInteraccion
    (
        inuIdSolicitud IN mo_packages.package_id%type
    )    
    RETURN NUMBER
    IS
		csbMtdName  VARCHAR2(70) := csbPqtNombre || 'fnuTipSolPerInteraccion';   

        nuError				NUMBER;  		
		sbMensaje   		VARCHAR2(1000);
        
        nuExiste    NUMBER(1);
        sbTipoSol   CONSTANT parametros.valor_cadena%TYPE := pkg_parametros.fsbGetValorCadena('TIPO_SOL_PERMITIDA_INTERACCION'); 
        
        CURSOR cucod_tip_sol IS
        SELECT COUNT(1)
        FROM   mo_packages a,
               ge_reception_type b
        WHERE  a.package_id IN (
                                    SELECT package_id
                                    FROM   mo_packages_asso
                                    WHERE  package_id_asso = inuIdSolicitud
                               )
            AND a.reception_type_id = b.reception_type_id
            AND a.package_type_id IN (
                                        SELECT to_number(regexp_substr(sbTipoSol, '[^,]+', 1, level))
                                        FROM   dual
                                        CONNECT BY
                                            regexp_substr(sbTipoSol, '[^,]+', 1, level) IS NOT NULL
                                     );
                
    BEGIN		
		pkg_traza.trace(csbMtdName, cnuNvlTraza, csbInicio);
		
		OPEN cucod_tip_sol;
        FETCH cucod_tip_sol INTO nuExiste;        
        CLOSE cucod_tip_sol;        
        
        pkg_traza.trace(csbPqtNombre, cnuNvlTraza, pkg_traza.csbFIN);
        
        RETURN nuExiste;       
		
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_error.setError;
            pkg_error.getError(nuError, sbMensaje);
            pkg_traza.trace('nuError: ' || nuError || ' sbMensaje: ' || sbMensaje, cnuNvlTraza);
            pkg_traza.trace(csbPqtNombre, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFin_erc); 
            RAISE pkg_error.controlled_error;
        WHEN others THEN
            pkg_error.setError;
            pkg_error.getError(nuError, sbMensaje);
            pkg_traza.trace('nuError: ' || nuError || ' sbMensaje: ' || sbMensaje, cnuNvlTraza);
            pkg_traza.trace(csbPqtNombre, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFin_err); 
            RAISE pkg_error.controlled_error;
    END fnuTipSolPerInteraccion;    
        
    
END pkg_bcsolicitud_interaccion;
/
BEGIN
    pkg_utilidades.prAplicarPermisos(upper('PKG_BCSOLICITUD_INTERACCION'),'PERSONALIZACIONES'); 
END;
/