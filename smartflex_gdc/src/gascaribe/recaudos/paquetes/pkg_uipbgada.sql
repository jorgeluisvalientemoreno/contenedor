CREATE OR REPLACE PACKAGE pkg_uipbgada
IS
    /******************************************************************
    <Package Fuente="Propiedad Intelectual de GDC">
    <Unidad>pkg_uipbgada</Unidad>
    <Autor>Paola Acosta</Autor>
    <Fecha>26-02-2025</Fecha>
    <Descripcion> 
        Paquete con los servicios bo necesarios para la ejecución
        de la funcionalidad PBGADO - Generación de archivo de debito auotmatico.
    </Descripcion>
    <Historial>
           <Modificacion Autor="Paola.Acosta" Fecha="26-02-2025" Inc="OSF-4041" Empresa="GDC">
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
    Unidad      : prcObjeto
    Descripcion : Servcio de procesamiento de PBGADO 
    ******************************************************************/
    PROCEDURE prcObjeto;
    
END pkg_uipbgada;
/
CREATE OR REPLACE PACKAGE BODY pkg_uipbgada
IS
    /******************************************************************
    <Package Fuente="Propiedad Intelectual de GDC">
    <Unidad> pkg_uipbgada </Unidad>
    <Autor> Paola Acosta</Autor>
    <Fecha> 26-02-2025 </Fecha>
    <Descripcion> 
        Paquete de gestión del pb PBGADO
    </Descripcion>
    <Historial>
           <Modificacion Autor="Paola.Acosta" Fecha="26-02-2025" Inc="OSF-4041" Empresa="GDC">
               Creación
           </Modificacion>       
     </Historial>
     </Package>
    ******************************************************************/

    --------------------------------------------
    -- Constantes 
    --------------------------------------------
    csbVersion          CONSTANT VARCHAR2(10) := 'OSF-4041';
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
    <Fecha> 26-02-2025 </Fecha>
    <Descripcion> 
        Obtiene la version del paquete.
    </Descripcion>
    <Retorno Nombre="Versión del paquete" Tipo="VARCHAR2">
        Versión del paquete
    </Retorno>
    <Historial>
           <Modificacion Autor="Paola.Acosta" Fecha="26-02-2025" Inc="OSF-4041" Empresa="GDC"> 
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
    <Unidad> prcObjeto </Unidad>
    <Autor>Paola Acosta</Autor>
    <Fecha> 24-01-2025 </Fecha>
    <Descripcion> 
        Servicio de procesamiento de la funcionalidad PBGADO
    </Descripcion>
    <Historial>
           <Modificacion Autor="Paola.Acosta" Fecha="24-01-2025" Inc="OSF-4041" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </Procedure>
    **************************************************************************/
    PROCEDURE prcObjeto
    IS
        --Constantes
        csbMtd_nombre       VARCHAR2(70) := csbPqt_nombre || 'prcObjeto';     
        
        --Variables
        nuPFmes       ge_boInstanceControl.stysbValue;
        nuPFAno       ge_boInstanceControl.stysbValue;        
        nuPFCiclo     ge_boInstanceControl.stysbValue;              
      
    BEGIN
        pkg_traza.trace(csbMtd_nombre, cnuNvlTrc, csbInicio);
        
        --Obtener los valores ingresados en la aplicacion PB PBGADA
        nuPFAno := TO_NUMBER(ge_boInstanceControl.fsbGetFieldValue('PERIFACT', 'PEFAANO'));
        
        nuPFMes := TO_NUMBER(ge_boInstanceControl.fsbGetFieldValue('PERIFACT', 'PEFAMES'));            
        
        nuPFCiclo := TO_NUMBER(ge_boInstanceControl.fsbGetFieldValue('PERIFACT', 'PEFACICL'));    
        
        IF ( nuPFAno IS NULL ) THEN
            pkg_error.setErrorMessage(isbMsgErrr => 'El atributo Año Periodo no puede ser nulo, por favor seleccione un valor de la lista desplegable.');
        END IF;
        
        IF ( nuPFMes IS NULL ) THEN
            pkg_error.setErrorMessage(isbMsgErrr => 'El atributo Mes Periodo no puede ser nulo, por favor seleccione un valor de la lista desplegable.');
        END IF;
        
        IF ( nuPFCiclo IS NULL ) THEN
            pkg_error.setErrorMessage(isbMsgErrr => 'El atributo Ciclo de Facturación no puede ser nulo, por favor seleccione un valor de la lista desplegable.');
        END IF;   
        
        pkg_traza.trace('nuPFAno: '||nuPFAno, cnuNvlTrc);
        pkg_traza.trace('nuPFMes: '||nuPFMes, cnuNvlTrc);
        pkg_traza.trace('nuPFCiclo: '||nuPFCiclo, cnuNvlTrc);
                    
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
    END prcObjeto;     

END pkg_uipbgada;
/
BEGIN
    pkg_utilidades.praplicarpermisos(UPPER('pkg_uipbgada'),'OPEN'); 
END;
/