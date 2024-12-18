CREATE OR REPLACE PACKAGE adm_person.pkg_bccliente IS
/*******************************************************************************
    Fuente=Propiedad Intelectual de Gases del Caribe
    pkg_bccliente
    Autor       :   Lubin Pineda - MVM
    Fecha       :   25-07-2023
    Descripcion :   Paquete con los métodos CRUD para manejo de información
                    sobre las tablas OPEN.GE_SUBSCRIBER
    Modificaciones  :
    Autor       Fecha       Caso    	Descripcion
    jpinedc     27-07-2023  OSF-1249 	Creacion
    jpinedc     27-07-2023  OSF-1249 	Ajustes por revisión técnica
	jerazomvm	25-10-2023	OSF-1788	1. Se crea el cursor cuRecord
										2. Se crea el tipo tabla tytbClientes y tipo record tyrfRecords
										3. Se crea las funciones:
											- fnuDireccion 
											- fsbTelefono
											- frcgetRecord
											- fblexistCliente
											- fnuClienteId
*******************************************************************************/

    -- Cursor que obtiene los datos del cliente
	CURSOR cuRecord(inuClienteId IN ge_subscriber.subscriber_id%TYPE ) IS
		SELECT ge_subscriber.*,
			   ge_subscriber.rowid
		FROM ge_subscriber
		WHERE subscriber_id = inuClienteId;
		
	SUBTYPE styClientes IS cuRecord%ROWTYPE;
	
	TYPE tytbClientes IS TABLE OF styClientes INDEX BY BINARY_INTEGER;
	TYPE tyrfRecords IS REF CURSOR RETURN styClientes;
	
	-- Retona Identificador del ultimo caso que hizo cambios
    FUNCTION fsbVersion RETURN VARCHAR2;

    -- Retorna Tipo de Identificación
    FUNCTION fnuTipoIdentificacion
    (
        inuCliente                  IN  ge_subscriber.subscriber_id%TYPE 
    )
    RETURN ge_subscriber.ident_type_id%TYPE;

    -- Retorna Identificación    
    FUNCTION fsbIdentificacion
    (
        inuCliente                  IN  ge_subscriber.subscriber_id%TYPE 
    )
    RETURN ge_subscriber.identification%TYPE;
    
    -- Retorna Tipo de Cliente    
    FUNCTION fnuTipoCliente
    (
        inuCliente                  IN  ge_subscriber.subscriber_id%TYPE 
    )
    RETURN ge_subscriber.subscriber_type_id%TYPE;
    
    -- Retorna Nombres    
    FUNCTION fsbNombres
    (
        inuCliente                  IN  ge_subscriber.subscriber_id%TYPE 
    )
    RETURN ge_subscriber.subscriber_name%TYPE;
    
    -- Retorna Apellidos    
    FUNCTION fsbApellidos
    (
        inuCliente                  IN  ge_subscriber.subscriber_id%TYPE 
    )
    RETURN ge_subscriber.subs_last_name%TYPE;
    
    -- Retorna Correo electrónico    
    FUNCTION fsbCorreo
    (
        inuCliente                  IN  ge_subscriber.subscriber_id%TYPE 
    )
    RETURN ge_subscriber.e_mail%TYPE;
    
    -- Retorna Actividad Económica    
    FUNCTION fnuActividadEconomica
    (
        inuCliente                  IN  ge_subscriber.subscriber_id%TYPE 
    )
    RETURN ge_subscriber.economic_activity_id%TYPE;     

	-- Retorna la dirección del cliente
    FUNCTION fnuDireccion
    (
        inuCliente	IN  ge_subscriber.subscriber_id%TYPE 
    )
    RETURN ge_subscriber.address_id%TYPE;
	
	-- Retorna el telefono del cliente   
    FUNCTION fsbTelefono
    (
        inuCliente	IN  ge_subscriber.subscriber_id%TYPE 
    )
    RETURN ge_subscriber.phone%TYPE;
	
	-- Retorna un registro de tipo styClientes 
	FUNCTION frcgetRecord
	(
		inuCliente	IN	ge_subscriber.subscriber_id%TYPE 
	)
	RETURN styClientes;
	
	-- Retorna si existe un cliente
	FUNCTION fblexistCliente
	(
		inuCliente	IN	ge_subscriber.subscriber_id%TYPE 
	)
	RETURN BOOLEAN;
	
	-- Retorna el ID del cliente a partir del tipo y número de identificación del cliente.
	FUNCTION fnuClienteId
    (
		inuTipoIdentificacion	IN  GE_SUBSCRIBER.IDENT_TYPE_ID%TYPE,
		isbIdentificacion   	IN	GE_SUBSCRIBER.IDENTIFICATION%TYPE
    )
    RETURN GE_SUBSCRIBER.SUBSCRIBER_ID%TYPE;

END pkg_bccliente;
/

CREATE OR REPLACE PACKAGE BODY adm_person.pkg_bccliente IS

    -- Identificador del ultimo caso que hizo cambios
    csbVersion                 VARCHAR2(15) := 'OSF-1788';

    -- Constantes para el control de la traza
    csbSP_NAME		CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT||'.';
    cnuNVLTRC       CONSTANT NUMBER(2)  	:= pkg_traza.fnuNivelTrzDef;
	csbPUSH         CONSTANT VARCHAR2(4)  	:= pkg_traza.fsbINICIO; 
	
	-- Cursor
	rcdata 			cuRecord%ROWTYPE;

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
    Programa        : fnuTipoIdentificacion 
    Descripcion     : Retorna TipoIdentificacion de cliente
    Autor           : Lubin Pineda - MVM 
    Fecha           : 25-07-2023 
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    jpinedc     27-07-2023  OSF-1249    Creacion
    ***************************************************************************/                     
    FUNCTION fnuTipoIdentificacion
    (
        inuCliente                  IN  ge_subscriber.subscriber_id%TYPE 
    )
    RETURN ge_subscriber.ident_type_id%TYPE
    IS

        -- Nombre de ste mÉtodo
        csbMT_NAME  VARCHAR2(70) := csbSP_NAME || 'fnuTipoIdentificacion';
        
        CURSOR cuTipoIdentificacion
        IS
        SELECT  ident_type_id
        FROM ge_subscriber sr
        WHERE sr.subscriber_id = inuCliente;
        
        nuTipoIdentificacion    ge_subscriber.ident_type_id%TYPE;
        
        PROCEDURE pCierracuTipoIdentificacion
        IS
            -- Nombre de este método
            csbMT_NAME1  VARCHAR2(105) := csbMT_NAME || '.pCierracuTipoIdentificacion';        
        BEGIN
        
			pkg_traza.trace(csbMT_NAME1, cnuNVLTRC, csbPUSH);       
        
            IF cuTipoIdentificacion%ISOPEN THEN  
                CLOSE cuTipoIdentificacion;
            END IF;        

            pkg_traza.trace(csbMT_NAME1, cnuNVLTRC, pkg_traza.csbFIN);

        END pCierracuTipoIdentificacion;             
        
    BEGIN
    
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbPUSH);
		
		pkg_traza.trace('inuCliente: ' || inuCliente, cnuNVLTRC);
        
        pCierracuTipoIdentificacion;
    
        OPEN cuTipoIdentificacion;
        FETCH cuTipoIdentificacion INTO nuTipoIdentificacion;
        CLOSE cuTipoIdentificacion;
		
		pkg_traza.trace('nuTipoIdentificacion: ' || nuTipoIdentificacion, cnuNVLTRC);
            
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
        
        RETURN nuTipoIdentificacion;
        
    EXCEPTION
        WHEN OTHERS THEN
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
            pkg_error.SetError;
            pCierracuTipoIdentificacion;
            RETURN nuTipoIdentificacion;                 
    END fnuTipoIdentificacion;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbIdentificacion 
    Descripcion     : Retorna Identificacion de cliente
    Autor           : Lubin Pineda - MVM 
    Fecha           : 25-07-2023 
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    jpinedc     27-07-2023  OSF-1249    Creacion
    ***************************************************************************/                     
    FUNCTION fsbIdentificacion
    (
        inuCliente                  IN  ge_subscriber.subscriber_id%TYPE 
    )
    RETURN ge_subscriber.identification%TYPE
    IS

        -- Nombre de ste mÉtodo
        csbMT_NAME  VARCHAR2(70) := csbSP_NAME || 'fsbIdentificacion';
        
        CURSOR cuIdentificacion
        IS
        SELECT  identification
        FROM ge_subscriber sr
        WHERE sr.subscriber_id = inuCliente;
        
        sbIdentificacion    ge_subscriber.identification%TYPE;
        
        PROCEDURE pCierraCuIdentificacion
        IS
            -- Nombre de este método
            csbMT_NAME1  VARCHAR2(105) := csbMT_NAME || '.pCierraCuIdentificacion';        
        BEGIN
        
            pkg_traza.trace(csbMT_NAME1, cnuNVLTRC, csbPUSH);      
        
            IF cuIdentificacion%ISOPEN THEN  
                CLOSE cuIdentificacion;
            END IF;        

            pkg_traza.trace(csbMT_NAME1, cnuNVLTRC, pkg_traza.csbFIN);

        END pCierraCuIdentificacion;             
        
    BEGIN
    
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbPUSH);
		
		pkg_traza.trace('inuCliente: ' || inuCliente, cnuNVLTRC);
        
        pCierraCuIdentificacion;
    
        OPEN cuIdentificacion;
        FETCH cuIdentificacion INTO sbIdentificacion;
        CLOSE cuIdentificacion;
		
		pkg_traza.trace('sbIdentificacion: ' || sbIdentificacion, cnuNVLTRC);
            
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
        
        RETURN sbIdentificacion;
        
    EXCEPTION
        WHEN OTHERS THEN
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
            pkg_error.SetError;
            pCierracuIdentificacion;
            RETURN sbIdentificacion;              
    END fsbIdentificacion;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuTipoCliente 
    Descripcion     : Retorna Tipo de cliente
    Autor           : Lubin Pineda - MVM 
    Fecha           : 25-07-2023 
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    jpinedc     27-07-2023  OSF-1249    Creacion
    ***************************************************************************/                     
    FUNCTION fnuTipoCliente
    (
        inuCliente                  IN  ge_subscriber.subscriber_id%TYPE 
    )
    RETURN ge_subscriber.subscriber_type_id%TYPE
    IS

        -- Nombre de ste mÉtodo
        csbMT_NAME  VARCHAR2(70) := csbSP_NAME || 'fnuTipoCliente';
        
        CURSOR cuTipoCliente
        IS
        SELECT  subscriber_type_id
        FROM ge_subscriber sr
        WHERE sr.subscriber_id = inuCliente;
        
        nuTipoCliente    ge_subscriber.subscriber_type_id%TYPE;
        
        PROCEDURE pCierracuTipoCliente
        IS
            -- Nombre de este método
            csbMT_NAME1  VARCHAR2(105) := csbMT_NAME || '.pCierraCuTipoCliente';        
        BEGIN
        
			pkg_traza.trace(csbMT_NAME1, cnuNVLTRC, csbPUSH); 			
        
            IF cuTipoCliente%ISOPEN THEN  
                CLOSE cuTipoCliente;
            END IF;        

            pkg_traza.trace(csbMT_NAME1, cnuNVLTRC, pkg_traza.csbFIN);

        END pCierraCuTipoCliente;             
        
    BEGIN
    
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbPUSH);
		
		pkg_traza.trace('inuCliente: ' || inuCliente, cnuNVLTRC);
        
        pCierraCuTipoCliente;
    
        OPEN cuTipoCliente;
        FETCH cuTipoCliente INTO nuTipoCliente;
        CLOSE cuTipoCliente;
		
		pkg_traza.trace('nuTipoCliente: ' || nuTipoCliente, cnuNVLTRC);
            
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
        
        RETURN nuTipoCliente;
        
    EXCEPTION
        WHEN OTHERS THEN
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
            pkg_error.SetError;
            pCierraCuTipoCliente;
            RETURN nuTipoCliente;                 
    END fnuTipoCliente;
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbNombres 
    Descripcion     : Retorna Nombres de cliente
    Autor           : Lubin Pineda - MVM 
    Fecha           : 25-07-2023 
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    jpinedc     27-07-2023  OSF-1249    Creacion
    ***************************************************************************/                     
    FUNCTION fsbNombres
    (
        inuCliente                  IN  ge_subscriber.subscriber_id%TYPE 
    )
    RETURN ge_subscriber.subscriber_name%TYPE
    IS

        -- Nombre de ste mÉtodo
        csbMT_NAME  VARCHAR2(70) := csbSP_NAME || 'fsbNombres';
        
        CURSOR cuNombres
        IS
        SELECT  subscriber_name
        FROM ge_subscriber sr
        WHERE sr.subscriber_id = inuCliente;
        
        sbNombres    ge_subscriber.subscriber_name%TYPE;
        
        PROCEDURE pCierracuNombres
        IS
            -- Nombre de este método
            csbMT_NAME1  VARCHAR2(105) := csbMT_NAME || '.pCierracuNombres';        
        BEGIN
        
            pkg_traza.trace(csbMT_NAME1, cnuNVLTRC, csbPUSH);        
        
            IF cuNombres%ISOPEN THEN  
                CLOSE cuNombres;
            END IF;        

            pkg_traza.trace(csbMT_NAME1, cnuNVLTRC, pkg_traza.csbFIN);

        END pCierracuNombres;             
        
    BEGIN
    
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbPUSH);
		
		pkg_traza.trace('inuCliente: ' || inuCliente, cnuNVLTRC);
        
        pCierracuNombres;
    
        OPEN cuNombres;
        FETCH cuNombres INTO sbNombres;
        CLOSE cuNombres;
		
		pkg_traza.trace('sbNombres: ' || sbNombres, cnuNVLTRC);
            
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
        
        RETURN sbNombres;
        
    EXCEPTION
        WHEN OTHERS THEN
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
            pkg_error.SetError;
            pCierracuNombres;
            RETURN sbNombres;                 
    END fsbNombres;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbApellidos 
    Descripcion     : Retorna Apellidos de cliente
    Autor           : Lubin Pineda - MVM 
    Fecha           : 25-07-2023 
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    jpinedc     27-07-2023  OSF-1249    Creacion
    ***************************************************************************/                     
    FUNCTION fsbApellidos
    (
        inuCliente                  IN  ge_subscriber.subscriber_id%TYPE 
    )
    RETURN ge_subscriber.subs_last_name%TYPE
    IS

        -- Nombre de ste mÉtodo
        csbMT_NAME  VARCHAR2(70) := csbSP_NAME || 'fsbApellidos';
        
        CURSOR cuApellidos
        IS
        SELECT  subs_last_name
        FROM ge_subscriber sr
        WHERE sr.subscriber_id = inuCliente;
        
        sbApellidos    ge_subscriber.subs_last_name%TYPE;
        
        PROCEDURE pCierraCuApellidos
        IS
            -- Nombre de este método
            csbMT_NAME1  VARCHAR2(105) := csbMT_NAME || '.pCierraCuApellidos';        
        BEGIN
        
            pkg_traza.trace(csbMT_NAME1, cnuNVLTRC, csbPUSH);         
        
            IF cuApellidos%ISOPEN THEN  
                CLOSE cuApellidos;
            END IF;        

            pkg_traza.trace(csbMT_NAME1, cnuNVLTRC, pkg_traza.csbFIN);

        END pCierracuApellidos;             
        
    BEGIN
    
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbPUSH);
		
		pkg_traza.trace('inuCliente: ' || inuCliente, cnuNVLTRC);
        
        pCierracuApellidos;
    
        OPEN cuApellidos;
        FETCH cuApellidos INTO sbApellidos;
        CLOSE cuApellidos;
		
		pkg_traza.trace('sbApellidos: ' || sbApellidos, cnuNVLTRC);
            
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
        
        RETURN sbApellidos;
        
    EXCEPTION
        WHEN OTHERS THEN
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
            pkg_error.SetError;
            pCierracuApellidos;
            RETURN sbApellidos;                 
    END fsbApellidos;      

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbCorreo 
    Descripcion     : Retorna Correo electrónico del cliente
    Autor           : Lubin Pineda - MVM 
    Fecha           : 25-07-2023 
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    jpinedc     27-07-2023  OSF-1249    Creacion
    ***************************************************************************/                     
    FUNCTION fsbCorreo
    (
        inuCliente                  IN  ge_subscriber.subscriber_id%TYPE 
    )
    RETURN ge_subscriber.e_mail%TYPE
    IS

        -- Nombre de ste mÉtodo
        csbMT_NAME  VARCHAR2(70) := csbSP_NAME || 'fsbCorreo';
        
        CURSOR cuCorreo
        IS
        SELECT  e_mail
        FROM ge_subscriber sr
        WHERE sr.subscriber_id = inuCliente;
        
        sbCorreo    ge_subscriber.e_mail%TYPE;
        
        PROCEDURE pCierraCuCorreo
        IS
            -- Nombre de este método
            csbMT_NAME1  VARCHAR2(105) := csbMT_NAME || '.pCierracuCorreo';        
        BEGIN
        
            pkg_traza.trace(csbMT_NAME1, cnuNVLTRC, csbPUSH);        
        
            IF cuCorreo%ISOPEN THEN  
                CLOSE cuCorreo;
            END IF;        

            pkg_traza.trace(csbMT_NAME1, cnuNVLTRC, pkg_traza.csbFIN);

        END pCierracuCorreo;             
        
    BEGIN
    
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbPUSH);
		
		pkg_traza.trace('inuCliente: ' || inuCliente, cnuNVLTRC);
        
        pCierracuCorreo;
    
        OPEN cuCorreo;
        FETCH cuCorreo INTO sbCorreo;
        CLOSE cuCorreo;
		
		pkg_traza.trace('sbCorreo: ' || sbCorreo, cnuNVLTRC);
            
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
        
        RETURN sbCorreo;
        
    EXCEPTION
        WHEN OTHERS THEN
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
            pkg_error.SetError;
            pCierracuCorreo;
            RETURN sbCorreo;                 
    END fsbCorreo;      

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuActividadEconomica 
    Descripcion     : Retorna Actividad Económica de cliente
    Autor           : Lubin Pineda - MVM 
    Fecha           : 25-07-2023 
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    jpinedc     27-07-2023  OSF-1249    Creacion
    ***************************************************************************/                     
    FUNCTION fnuActividadEconomica
    (
        inuCliente                  IN  ge_subscriber.subscriber_id%TYPE 
    )
    RETURN ge_subscriber.economic_activity_id%TYPE
    IS

        -- Nombre de ste mÉtodo
        csbMT_NAME  VARCHAR2(70) := csbSP_NAME || 'fnuActividadEconomica';
        
        CURSOR cuActividadEconomica
        IS
        SELECT  economic_activity_id
        FROM ge_subscriber sr
        WHERE sr.subscriber_id = inuCliente;
        
        nuActividadEconomica    ge_subscriber.economic_activity_id%TYPE;
        
        PROCEDURE pCierracuActividadEconomica
        IS
            -- Nombre de este método
            csbMT_NAME1  VARCHAR2(105) := csbMT_NAME || '.pCierracuActividadEconomica';        
        BEGIN
        
            pkg_traza.trace(csbMT_NAME1, cnuNVLTRC, csbPUSH);        
        
            IF cuActividadEconomica%ISOPEN THEN  
                CLOSE cuActividadEconomica;
            END IF;        

            pkg_traza.trace(csbMT_NAME1, cnuNVLTRC, pkg_traza.csbFIN);

        END pCierracuActividadEconomica;             
        
    BEGIN
    
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbPUSH);
		
		pkg_traza.trace('inuCliente: ' || inuCliente, cnuNVLTRC);
        
        pCierracuActividadEconomica;
    
        OPEN cuActividadEconomica;
        FETCH cuActividadEconomica INTO nuActividadEconomica;
        CLOSE cuActividadEconomica;
		
		pkg_traza.trace('nuActividadEconomica: ' || nuActividadEconomica, cnuNVLTRC);
            
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
        
        RETURN nuActividadEconomica;
        
    EXCEPTION
        WHEN OTHERS THEN
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
            pkg_error.SetError;
            pCierracuActividadEconomica;
            RETURN nuActividadEconomica;                 
    END fnuActividadEconomica;
	
	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuDireccion 
    Descripcion     : Retorna la dirección del cliente
	
    Autor           : Jhon Erazo - MVM 
    Fecha           : 25-10-2023 
	
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    jerazomvm   25-07-2023  OSF-1788    Creacion
    ***************************************************************************/                     
    FUNCTION fnuDireccion
    (
        inuCliente	IN	ge_subscriber.subscriber_id%TYPE 
    )
    RETURN ge_subscriber.address_id%TYPE
    IS

        -- Nombre de ste mÉtodo
        csbMT_NAME  VARCHAR2(70) := csbSP_NAME || 'fnuDireccion';
        
        CURSOR cuDireccion
        IS
        SELECT  address_id
        FROM ge_subscriber sr
        WHERE sr.subscriber_id = inuCliente;
        
        nuDireccion    ge_subscriber.address_id%TYPE;
        
        PROCEDURE pCierraCuDireccion
        IS
            -- Nombre de este método
            csbMT_NAME1  VARCHAR2(105) := csbMT_NAME || '.pCierraCuDireccion';        
        BEGIN
        
            pkg_traza.trace(csbMT_NAME1, cnuNVLTRC, csbPUSH);        
        
            IF cuDireccion%ISOPEN THEN  
                CLOSE cuDireccion;
            END IF;        

            pkg_traza.trace(csbMT_NAME1, cnuNVLTRC, pkg_traza.csbFIN);

        END pCierraCuDireccion;             
        
    BEGIN
    
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbPUSH);
		
		pkg_traza.trace('inuCliente: ' || inuCliente, cnuNVLTRC);
        
        pCierraCuDireccion;
    
        OPEN cuDireccion;
        FETCH cuDireccion INTO nuDireccion;
        CLOSE cuDireccion;
		
		pkg_traza.trace('nuDireccion: ' || nuDireccion, cnuNVLTRC);
            
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
        
        RETURN nuDireccion;
        
    EXCEPTION
        WHEN OTHERS THEN
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
            pkg_error.SetError;
            pCierraCuDireccion;
            RETURN nuDireccion;                 
    END fnuDireccion; 
	
	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbTelefono 
    Descripcion     : Retorna el telefono del cliente
	
    Autor           : Jhon Erazo - MVM 
    Fecha           : 25-10-2023 
	
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    jerazomvm   25-07-2023  OSF-1788    Creacion
    ***************************************************************************/                     
    FUNCTION fsbTelefono
    (
        inuCliente	IN	ge_subscriber.subscriber_id%TYPE 
    )
    RETURN ge_subscriber.phone%TYPE
    IS

        -- Nombre del metodo
        csbMT_NAME  VARCHAR2(70) := csbSP_NAME || 'fsbTelefono';
        
        CURSOR cuTelefono
        IS
        SELECT  phone
        FROM ge_subscriber sr
        WHERE sr.subscriber_id = inuCliente;
        
        sbTelefono    ge_subscriber.phone%TYPE;
        
        PROCEDURE pCierraCuTelefono
        IS
            -- Nombre de este método
            csbMT_NAME1  VARCHAR2(105) := csbMT_NAME || '.pCierraCuTelefono';        
        BEGIN
        
            pkg_traza.trace(csbMT_NAME1, cnuNVLTRC, csbPUSH);        
        
            IF cuTelefono%ISOPEN THEN  
                CLOSE cuTelefono;
            END IF;        

            pkg_traza.trace(csbMT_NAME1, cnuNVLTRC, pkg_traza.csbFIN);

        END pCierraCuTelefono;             
        
    BEGIN
    
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbPUSH);
		
		pkg_traza.trace('inuCliente: ' || inuCliente, cnuNVLTRC);
        
        pCierraCuTelefono;
    
        OPEN cuTelefono;
        FETCH cuTelefono INTO sbTelefono;
        CLOSE cuTelefono;
		
		pkg_traza.trace('sbTelefono: ' || sbTelefono, cnuNVLTRC);
            
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
        
        RETURN sbTelefono;
        
    EXCEPTION
        WHEN OTHERS THEN
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
            pkg_error.SetError;
            pCierraCuTelefono;
            RETURN sbTelefono;                 
    END fsbTelefono; 
	
	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : frcgetRecord 
    Descripcion     : Retorna un registro de tipo styClientes
	
    Autor           : Jhon Erazo - MVM 
    Fecha           : 25-10-2023 
	
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    jerazomvm   25-07-2023  OSF-1788    Creacion
    ***************************************************************************/  
	FUNCTION frcgetRecord
	(
		inuCliente	IN	ge_subscriber.subscriber_id%TYPE 
	)
	RETURN styClientes
	IS
        csbMT_NAME		VARCHAR2(70) := csbSP_NAME || 'frcgetRecord';
		rcerror 		styClientes;
		rcrecordnull	cuRecord%ROWTYPE;
		
		PROCEDURE pCierracuRecord
        IS
            -- Nombre de este método
            csbMT_NAME1  VARCHAR2(105) := csbMT_NAME || '.pCierracuRecord';        
        BEGIN
        
            pkg_traza.trace(csbMT_NAME1, cnuNVLTRC, csbPUSH);        
        
            IF cuRecord%ISOPEN THEN  
                CLOSE cuRecord;
            END IF;        

            pkg_traza.trace(csbMT_NAME1, cnuNVLTRC, pkg_traza.csbFIN);

        END pCierracuRecord; 
		
	BEGIN	

		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbPUSH);
		
		pkg_traza.trace('inuCliente: ' || inuCliente, cnuNVLTRC);
		
		rcerror.SUBSCRIBER_ID := inuCliente;
		
		pCierracuRecord;
		
		OPEN cuRecord(inuCliente);
        FETCH cuRecord INTO rcdata;
		
		IF cuRecord%NOTFOUND  THEN
			CLOSE cuRecord;
			rcdata := rcrecordnull;
			RAISE NO_DATA_FOUND;
		END IF;
		
		CLOSE cuRecord;
		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
		
		RETURN rcdata;
		
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);
			pkg_error.SetErrorMessage(1,
									  'Cliente: [' || inuCliente || ']'
									  );
	END frcgetRecord;
	
	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fblexistCliente 
    Descripcion     : Retorna si existe un cliente
	
    Autor           : Jhon Erazo - MVM 
    Fecha           : 25-10-2023 
	
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    jerazomvm   25-07-2023  OSF-1788    Creacion
    ***************************************************************************/ 
	FUNCTION fblexistCliente
	(
		inuCliente	IN	ge_subscriber.subscriber_id%TYPE 
	)
	RETURN BOOLEAN
	IS
		csbMT_NAME		VARCHAR2(70) := csbSP_NAME || 'fblexistCliente';
		rcrecordnull	cuRecord%ROWTYPE;
		
		PROCEDURE pCierracuRecord
        IS
            -- Nombre de este método
            csbMT_NAME1  VARCHAR2(105) := csbMT_NAME || '.pCierracuRecord';        
        BEGIN
        
            pkg_traza.trace(csbMT_NAME1, cnuNVLTRC, csbPUSH);        
        
            IF cuRecord%ISOPEN THEN  
                CLOSE cuRecord;
            END IF;        

            pkg_traza.trace(csbMT_NAME1, cnuNVLTRC, pkg_traza.csbFIN);

        END pCierracuRecord; 
	
	BEGIN
	
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbPUSH);
		
		pkg_traza.trace('inuCliente: ' || inuCliente, cnuNVLTRC);
		
		pCierracuRecord;
		
		OPEN cuRecord(inuCliente);
		FETCH cuRecord INTO RCDATA;
		
		IF cuRecord%NOTFOUND  THEN
			CLOSE cuRecord;
			RCDATA := RCRECORDNULL;
			RAISE NO_DATA_FOUND;
		END IF;
		
		CLOSE cuRecord;
		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
		
		RETURN(TRUE);
		
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);
			RETURN(FALSE);
	END fblexistCliente;
	
	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuClienteId 
    Descripcion     : Retorna el ID del cliente a partir del tipo y número de 
					  identificación del cliente.
	
    Autor           : Jhon Erazo - MVM 
    Fecha           : 25-10-2023 
	
	Parametros entrada:
		inuTipoIdentificacion	Tipo de identificación
		isbIdentificacion		Numero de identificación
	
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    jerazomvm   25-07-2023  OSF-1788    Creacion
    ***************************************************************************/
	FUNCTION fnuClienteId
    (
		inuTipoIdentificacion	IN  GE_SUBSCRIBER.IDENT_TYPE_ID%TYPE,
		isbIdentificacion   	IN	GE_SUBSCRIBER.IDENTIFICATION%TYPE
    )
    RETURN GE_SUBSCRIBER.SUBSCRIBER_ID%TYPE
    IS
		csbMT_NAME		VARCHAR2(70) := csbSP_NAME || 'fnuClienteId';
		nuClienteId		GE_SUBSCRIBER.SUBSCRIBER_ID%TYPE;
        
		CURSOR CuClienteID
        IS
			SELECT SUBSCRIBER_ID
			FROM GE_SUBSCRIBER
			WHERE IDENT_TYPE_ID  = inuTipoIdentificacion
			AND   IDENTIFICATION = isbIdentificacion;
		
		PROCEDURE pCierraCuClienteID
        IS
            -- Nombre de este método
            csbMT_NAME1  VARCHAR2(105) := csbMT_NAME || '.pCierraCuClienteID';        
        BEGIN
        
            pkg_traza.trace(csbMT_NAME1, cnuNVLTRC, csbPUSH);        
        
            IF CuClienteID%ISOPEN THEN  
                CLOSE CuClienteID;
            END IF;        

            pkg_traza.trace(csbMT_NAME1, cnuNVLTRC, pkg_traza.csbFIN);

        END pCierraCuClienteID; 
		
    BEGIN
		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbPUSH);
		
		pkg_traza.trace('inuTipoIdentificacion: ' || inuTipoIdentificacion || chr(10) ||
						'isbIdentificacion: ' 	  || isbIdentificacion, cnuNVLTRC);
						
		IF (inuTipoIdentificacion = -1 AND isbIdentificacion IS NULL) THEN
			pkg_error.SetErrorMessage(1844, inuTipoIdentificacion||'|'||isbIdentificacion);
        END IF;
		
		pCierraCuClienteID;
		
		OPEN CuClienteID;
        FETCH CuClienteID INTO nuClienteId;
		CLOSE CuClienteID;
		
		pkg_traza.trace('nuClienteId: ' || nuClienteId, cnuNVLTRC);

        IF (nuClienteId IS NULL) THEN
			pkg_error.SetErrorMessage(1844, inuTipoIdentificacion||'|'||isbIdentificacion);
        END IF;
		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
		
        RETURN nuClienteId;		
		
    EXCEPTION
        WHEN  pkg_error.CONTROLLED_ERROR THEN
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
            pkg_error.SETERROR;
            RAISE pkg_error.CONTROLLED_ERROR;
    END fnuClienteId;
       
END pkg_bccliente;
/

PROMPT Otorgando permisos de ejecución para adm_person.pkg_bcproducto
BEGIN
    pkg_utilidades.prAplicarPermisos('PKG_BCCLIENTE', 'ADM_PERSON');
END;
/
PROMPT OTORGA PERMISOS a REXEREPORTES sobre el paquete PKG_BCCLIENTE
GRANT EXECUTE ON ADM_PERSON.PKG_BCCLIENTE TO REXEREPORTES;
/

