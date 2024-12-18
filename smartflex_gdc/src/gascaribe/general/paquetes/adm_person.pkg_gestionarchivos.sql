CREATE OR REPLACE PACKAGE adm_person.pkg_GestionArchivos IS
/*******************************************************************************
    Fuente=Propiedad Intelectual de Gases del Caribe
    pkg_GestionArchivos
    Autor       :   Lubin Pineda - MVM
    Fecha       :   02/02/2024
    Descripcion :   Paquete con los objetos del negocio para el manejo de
                    archivos
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     02/02/2024  OSF-2106 Creacion - GdC
    jpinedc     23/02/2024  OSF-2128 Creacion - Efi
    jpinedc     04/03/2024  OSF-2490 Ajuste prcRenombraArchivo_Ut, 
                                     prcRenombraArchivo_SMF ,
                                     prcCerrarArchivo_SMF - GdC
    jpinedc     11/10/2024  OSF-3466 Se crean fsbExtensionArchivo y
                                     fsbNombreArchivoSinExt
*******************************************************************************/

    SUBTYPE styArchivo IS utl_file.file_type;
    
    csbMODO_LECTURA     CONSTANT VARCHAR2(1) := 'r';
    csbMODO_ESCRITURA   CONSTANT VARCHAR2(1) := 'w';
    csbMODO_ADICION     CONSTANT VARCHAR2(1) := 'a';
    
    cnuFIN_ARCHIVO      CONSTANT NUMBER(1)  := 1;

    -- Retona Identificador del ultimo caso que hizo cambios en este archivo
    FUNCTION fsbVersion RETURN VARCHAR2;
    
    -- Obtiene los atributos de un archivo con utl_file
    PROCEDURE prcAtributosArchivo_Ut
    ( 
        isbDirectorio       IN  VARCHAR2,
        isbArchivo          IN  VARCHAR2 , 
        oblExisteArchivo    OUT BOOLEAN, 
        onuTamanoArchivo    OUT NUMBER, 
        onuTamanoBloque     OUT NUMBER
    );

    -- Retorna verdadero si el archivo existe y falso en caso contrario con utl_file
    FUNCTION fblExisteArchivo_Ut
    ( 
        isbDirectorio   IN VARCHAR2, 
        isbArchivo      IN VARCHAR2 
    ) RETURN BOOLEAN; 
    
    -- Eleva mensaje de error si el archivo no existe
    PROCEDURE prcValidaExisteArchivo_UT
    ( 
        isbDirectorio   IN VARCHAR2, 
        isbArchivo      IN VARCHAR2 
    );    

    -- Retorna verdadero si el archivo esta abierto y falso en caso contrario con utl_file
    FUNCTION fblArchivoAbierto_Ut
    ( 
        istyArchivo      IN  OUT styArchivo 
    ) RETURN BOOLEAN;


    -- Retorna el puntero del archivo si puede abrirlo con las condiciones indicadas con utl_file
    FUNCTION ftAbrirArchivo_Ut
    (  
        isbDirectorio       IN  VARCHAR2, 
        isbArchivo          IN  VARCHAR2, 
        isbModo             IN  VARCHAR2
    ) RETURN styArchivo;


    -- Retorna el puntero del archivo si puede abrirlo con las condiciones indicadas con utl_file
    FUNCTION fsbObtenerLinea_Ut
    ( 
        istyArchivo          IN  OUT styArchivo 
    ) RETURN VARCHAR2;

    -- Escribe lineas en el archivo con utl_file
    PROCEDURE prcEscribirLinea_Ut
    ( 
        istyArchivo          IN  OUT styArchivo , 
        isbLinea            IN  VARCHAR2,
        iblInmediato        IN  BOOLEAN DEFAULT FALSE
    );

    -- Escribe linea sin terminador en el archivo con utl_file
    PROCEDURE prcEscribirLineaSinTerm_Ut
    ( 
        istyArchivo          IN  OUT styArchivo , 
        isbLinea            IN  VARCHAR2
    );

    -- Cierra el archivo si se encuentra abierto con utl_file
    PROCEDURE prcCerrarArchivo_Ut
    (
        istyArchivo          IN  OUT styArchivo 
    );

    -- Borra un archivo con utl_file
    PROCEDURE prcBorrarArchivo_Ut
    ( 
        isbDirectorio VARCHAR2, 
        isbArchivo VARCHAR2 
    );

    -- Copia un archivo con utl_file
    PROCEDURE prcCopiaArchivo_Ut
    ( 
        isbDirectorioOrigen     IN  VARCHAR2, 
        isbArchivoOrigen        IN  VARCHAR2,  
        isbDirectorioDestino    IN  VARCHAR2, 
        isbArchivoDestino       IN  VARCHAR2,
        inuLineaInicial         IN  NUMBER DEFAULT NULL,
        inuLineaFinal           IN  NUMBER DEFAULT NULL
    );

    -- Renombra un archivo con utl_file
    PROCEDURE prcRenombraArchivo_Ut
    ( 
        isbDirectorioOrigen     IN  VARCHAR2,
        isbArchivoOrigen        IN  VARCHAR2,  
        isbDirectorioDestino    IN  VARCHAR2,
        isbArchivoDestino       IN  VARCHAR2,
        iblSobreEscribe         IN  BOOLEAN DEFAULT FALSE
    );

    PROCEDURE prcEscribeTermLinea_Ut
    ( 
        iflArchivo      styArchivo,
        inuLineas       NUMBER DEFAULT 1
    );

    -- Cierra todo los archivos abiertos
    PROCEDURE prcCerrarArchivos_UT;
    
    -- Obtiene un segmento en formato binario
    PROCEDURE prcObtieneSegmentoBinario_UT
    ( 
        iflArchivo  IN  styArchivo, 
        oraSegmento OUT RAW, 
        inuLongituD IN  NUMBER DEFAULT NULL
    ); 
    
    -- Escribe un segmento en formato binario con SMF
    PROCEDURE prcEscribeSegmentoBinario_UT
    ( 
        iflArchivo      IN  styArchivo, 
        iraSegmento     IN RAW, 
        iblInmediato    IN  BOOLEAN DEFAULT FALSE
    );          

    -- Obtiene los atributos de un archivo con SMF
    PROCEDURE prcAtributosArchivo_SMF
    ( 
        isbDirectorio       IN  VARCHAR2,
        isbArchivo          IN  VARCHAR2 , 
        oblExisteArchivo    OUT BOOLEAN, 
        onuTamanoArchivo    OUT NUMBER, 
        onuTamanoBloque     OUT NUMBER
    );
    
    -- Retorna verdadero si el archivo existe y falso en caso contrario
    FUNCTION fblExisteArchivo_SMF
    ( 
        isbDirectorio   IN VARCHAR2, 
        isbArchivo      IN VARCHAR2 
    ) RETURN BOOLEAN;
    
    -- Eleva mensaje de error si el archivo no existe
    PROCEDURE prcValidaExisteArchivo_SMF
    ( 
        isbDirectorio   IN VARCHAR2, 
        isbArchivo      IN VARCHAR2 
    );    

    -- Retorna verdadero si el archivo esta abierto y falso en caso contrario
    FUNCTION fblArchivoAbierto_SMF
    ( 
        istyArchivo      IN  OUT styArchivo 
    ) RETURN BOOLEAN;
                
    -- Retorna el puntero del archivo si puede abrirlo con las condiciones indicadas con SmartFlex
    FUNCTION ftAbrirArchivo_SMF
    (  
        isbDirectorio       IN  VARCHAR2, 
        isbArchivo          IN  VARCHAR2, 
        isbModo             IN  VARCHAR2
    ) RETURN styArchivo;

    -- Retorna el puntero del archivo si puede abrirlo con las condiciones indicadas con SmartFlex
    FUNCTION fsbObtenerLinea_SMF
    ( 
        istyArchivo          IN  OUT styArchivo 
    ) RETURN VARCHAR2;

    -- Escribe lineas en el archivo con SMF
    PROCEDURE prcEscribirLinea_SMF
    ( 
        istyArchivo          IN  OUT styArchivo , 
        isbLinea            IN  VARCHAR2,
        iblInmediato        IN  BOOLEAN DEFAULT FALSE
    );
    
    -- Escribe linea sin terminador en el archivo con SMF
    PROCEDURE prcEscribirLineaSinTerm_SMF
    ( 
        istyArchivo          IN  OUT styArchivo , 
        isbLinea            IN  VARCHAR2
    );    

    -- Renombra un archivo con SMF
    PROCEDURE prcRenombraArchivo_SMF
    ( 
        isbDirectorioOrigen     IN  VARCHAR2,
        isbArchivoOrigen        IN  VARCHAR2,  
        isbDirectorioDestino    IN  VARCHAR2,
        isbArchivoDestino       IN  VARCHAR2,
        iblSobreEscribe         IN  BOOLEAN DEFAULT FALSE
    );
    
    -- Cierra el archivo si se encuentra abierto con SmartFlex
    PROCEDURE prcCerrarArchivo_SMF
    (
        istyArchivo         IN  OUT styArchivo,
        isbDirectorio       IN VARCHAR2 DEFAULT NULL,
        isbArchivo          IN  VARCHAR2 DEFAULT NULL,
        ifblCerrarMasivo    IN BOOLEAN DEFAULT FALSE     
    );
    
    -- Borra un archivo con SmartFlex
    PROCEDURE prcBorrarArchivo_SMF
    ( 
        isbDirectorio VARCHAR2, 
        isbArchivo VARCHAR2 
    );

    -- Copia un archivo con SMF
    PROCEDURE prcCopiaArchivo_SMF
    ( 
        isbDirectorioOrigen     IN  VARCHAR2, 
        isbArchivoOrigen        IN  VARCHAR2,  
        isbDirectorioDestino    IN  VARCHAR2, 
        isbArchivoDestino       IN  VARCHAR2,
        inuLineaInicial         IN  NUMBER DEFAULT NULL,
        inuLineaFinal           IN  NUMBER DEFAULT NULL
    );
    
    -- Escribe finales de linea
    PROCEDURE prcEscribeTermLinea_SMF
    ( 
        iflArchivo      styArchivo,
        inuLineas       NUMBER DEFAULT 1
    );    
    
    -- Cierra todo los archivos abiertos
    PROCEDURE prcCerrarArchivos_SMF;
    
    -- Obtiene un segmento en formato binario con SMF
    PROCEDURE prcObtieneSegmentoBinario_SMF
    ( 
        iflArchivo  IN  styArchivo, 
        oraSegmento OUT RAW, 
        inuLongituD IN  NUMBER DEFAULT NULL
    );
    
    -- Escribe un segmento en formato binario con SMF
    PROCEDURE prcEscribeSegmentoBinario_SMF
    ( 
        iflArchivo      IN  styArchivo, 
        iraSegmento     IN RAW, 
        iblInmediato    IN  BOOLEAN DEFAULT FALSE
    );
    
    -- Retorna la extensión del archivo de entrada
    FUNCTION fsbExtensionArchivo(isbArchivo VARCHAR2) RETURN VARCHAR2;

    -- Retorna el nombre del archivo sin la extensión   
    FUNCTION fsbNombreArchivoSinExt(isbArchivo VARCHAR2) RETURN VARCHAR2;        

END pkg_GestionArchivos;
/

CREATE OR REPLACE PACKAGE BODY adm_person.pkg_GestionArchivos IS

    -- Identificador del ultimo caso que hizo cambios en este archivo
    csbVersion                 VARCHAR2(15) := 'OSF-2490';

    -- Constantes para el control de la traza
    csbSP_NAME		CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT||'.';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
    
    TYPE tbArchivosAbiertos IS TABLE OF styArchivo INDEX BY VARCHAR2(1000);
    
    gtbArchivosAbiertos tbArchivosAbiertos;
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbVersion 
    Descripcion     : Retona la ultima WO que hizo cambios en el paquete 
    Autor           : Lubin Pineda - MVM 
    Fecha           : 02/02/2024 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     02/02/2024  OSF-2106 Creacion
    ***************************************************************************/    
    FUNCTION fsbVersion RETURN VARCHAR2 IS
    BEGIN
        RETURN csbVersion;
    END fsbVersion;    
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prcAtributosArchivo_Ut 
    Descripcion     : Obtiene atributos de un archivo                      
    Autor           : Lubin Pineda - MVM 
    Fecha           : 02/02/2024 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     02/02/2024  OSF-2106 Creacion
    ***************************************************************************/   
    -- Obtiene los atributos de un archivo
    PROCEDURE prcAtributosArchivo_Ut
    ( 
        isbDirectorio       IN  VARCHAR2,
        isbArchivo          IN  VARCHAR2 , 
        oblExisteArchivo    OUT BOOLEAN, 
        onuTamanoArchivo    OUT NUMBER, 
        onuTamanoBloque     OUT NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prcAtributosArchivo';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO); 
        
        utl_file.fGetAttr(isbDirectorio,isbArchivo,oblExisteArchivo,onuTamanoArchivo,onuTamanoBloque);
         
        pkg_traza.trace('Atributos archivo ' || isbDirectorio || '/' ||isbArchivo ||':',csbNivelTraza); 
        pkg_traza.trace('                  ' || 'onuTamanoArchivo =' ||onuTamanoArchivo ,csbNivelTraza);
        pkg_traza.trace('                  ' || 'onuTamanoBloque =' ||onuTamanoBloque ,csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);  

    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;        
    END prcAtributosArchivo_Ut;

    -- Retorna verdadero si el archivo existe y falso en caso contrario
    FUNCTION fblExisteArchivo_Ut
    ( 
        isbDirectorio   IN VARCHAR2, 
        isbArchivo      IN VARCHAR2 
    ) RETURN BOOLEAN
    IS
        csbMetodo       CONSTANT VARCHAR2(70) := csbSP_NAME || 'fblExisteArchivo_Ut';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        blExisteArchivo BOOLEAN;
        nuTamanoArchivo NUMBER;
        nuTamanoBloque  NUMBER;
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        
        prcAtributosArchivo_Ut(isbDirectorio,isbArchivo,blExisteArchivo,nuTamanoArchivo,nuTamanoBloque);
          
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        
        IF blExisteArchivo THEN
            pkg_traza.trace( 'SI existe el archivo ' || isbDirectorio || '/' || isbArchivo ,csbNivelTraza);
        ELSE
            pkg_traza.trace( 'NO existe El archivo ' || isbDirectorio || '/' || isbArchivo ,csbNivelTraza);        
        END IF;
        
        RETURN blExisteArchivo;

    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;        
    END fblExisteArchivo_Ut;    

    -- Eleva mensaje de error si el archivo no existe
    PROCEDURE prcValidaExisteArchivo_UT
    ( 
        isbDirectorio   IN VARCHAR2, 
        isbArchivo      IN VARCHAR2 
    )
    IS
        csbMetodo       CONSTANT VARCHAR2(70) := csbSP_NAME || 'prcValidaExisteArchivo';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
       
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        
        IF NOT fblExisteArchivo_Ut( isbDirectorio, isbArchivo ) THEN
            pkg_error.setErrorMessage( isbMsgErrr => 'No existe el archivo ' || isbDirectorio || '/' || isbArchivo );  
        END IF;
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);  
        
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;        
    END prcValidaExisteArchivo_UT;    

    -- Retorna verdadero si el archivo esta abierto y falso en caso contrario
    FUNCTION fblArchivoAbierto_Ut
    ( 
        istyArchivo      IN  OUT styArchivo 
    ) RETURN BOOLEAN
    IS
        csbMetodo           CONSTANT VARCHAR2(70) := csbSP_NAME || 'fblArchivoAbierto_Ut';
        nuError             NUMBER;
        sbError             VARCHAR2(4000);
        blArchivoAbierto    BOOLEAN;
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO); 
        
        blArchivoAbierto := utl_file.Is_Open(istyArchivo);

        IF blArchivoAbierto THEN
            pkg_traza.trace( 'SI esta abierto el archivo '  ,csbNivelTraza);
        ELSE
            pkg_traza.trace( 'NO esta abierto el archivo ' ,csbNivelTraza);        
        END IF;
                  
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        
        RETURN blArchivoAbierto;  

    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;        
    END fblArchivoAbierto_Ut;    

    -- Retorna el puntero del archivo si puede abrirlo con las condiciones indicadas
    FUNCTION ftAbrirArchivo_Ut
    (  
        isbDirectorio       IN  VARCHAR2, 
        isbArchivo          IN  VARCHAR2, 
        isbModo             IN  VARCHAR2
    ) RETURN styArchivo
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'ftAbrirArchivo_Ut';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        
        flArchivo       styArchivo;
        
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        
        flArchivo := utl_file.fOpen( isbDirectorio, isbArchivo, isbModo );

        pkg_traza.trace( 'Se abrió el archivo ' || isbDirectorio || '/' || isbArchivo || ' en modo ' || isbModo  ,csbNivelTraza);
                  
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 
        
        RETURN  flArchivo;

    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;        
    END ftAbrirArchivo_Ut;    
    
    -- Retorna el puntero del archivo si puede abrirlo con las condiciones indicadas
    FUNCTION fsbObtenerLinea_Ut
    ( 
        istyArchivo          IN  OUT styArchivo 
    ) RETURN VARCHAR2
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fsbObtenerLinea_Ut';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        
        sbLinea         VARCHAR2(32767);
        
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        
        utl_file.Get_Line( istyArchivo, sbLinea );

        pkg_traza.trace( 'sbLinea|' || sbLinea ,csbNivelTraza);
           
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);  
        
        RETURN sbLinea;

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            pkg_traza.trace('Llegó al final del archivo', csbNivelTraza );
            RAISE;            
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;        
    END fsbObtenerLinea_Ut;      

    -- Escribe lineas en el archivo
    PROCEDURE prcEscribirLinea_Ut
    ( 
        istyArchivo          IN  OUT styArchivo , 
        isbLinea            IN  VARCHAR2,
        iblInmediato        IN  BOOLEAN DEFAULT FALSE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prcEscribirLinea_Ut';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);

        utl_file.Put_Line( istyArchivo, isbLinea, iblInmediato );
                  
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);  

    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;        
    END prcEscribirLinea_Ut;
    
    -- Escribe lineas en el archivo
    PROCEDURE prcEscribirLineaSinTerm_Ut
    ( 
        istyArchivo          IN  OUT styArchivo , 
        isbLinea            IN  VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prcEscribirLineaSinTerm_Ut';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);

        utl_file.Put( istyArchivo, isbLinea );
                  
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);  

    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;        
    END prcEscribirLineaSinTerm_Ut;                 

    -- Cierra el archivo si se encuentra abierto
    PROCEDURE prcCerrarArchivo_Ut
    (
        istyArchivo          IN  OUT styArchivo 
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prcCerrarArchivo_Ut';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        
        IF fblArchivoAbierto_Ut(istyArchivo)  THEN
            utl_file.fClose( istyArchivo );
        ELSE
            pkg_traza.trace( 'El archivo esta cerrado', csbNivelTraza);        
        END IF;
          
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);  

    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;        
    END prcCerrarArchivo_Ut;        
    
    -- Borra un archivo
    PROCEDURE prcBorrarArchivo_Ut
    ( 
        isbDirectorio VARCHAR2, 
        isbArchivo VARCHAR2 
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prcBorrarArchivo_Ut';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO); 
        
        utl_file.fRemove(isbDirectorio, isbArchivo);
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);  

    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;        
    END prcBorrarArchivo_Ut;        
        
    -- Copia un archivo
    PROCEDURE prcCopiaArchivo_Ut
    ( 
        isbDirectorioOrigen     IN  VARCHAR2, 
        isbArchivoOrigen        IN  VARCHAR2,  
        isbDirectorioDestino    IN  VARCHAR2, 
        isbArchivoDestino       IN  VARCHAR2,
        inuLineaInicial         IN  NUMBER DEFAULT NULL,
        inuLineaFinal           IN  NUMBER DEFAULT NULL
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prcCopiaArchivo';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        
        utl_file.fCopy
        (
            isbDirectorioOrigen,
            isbArchivoOrigen,
            isbDirectorioDestino,
            isbArchivoDestino,
            inuLineaInicial,
            inuLineaFinal
        );
                  
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);  

    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;        
    END prcCopiaArchivo_Ut;        

    -- Renombra un archivo
    PROCEDURE prcRenombraArchivo_Ut
    ( 
        isbDirectorioOrigen     IN  VARCHAR2,
        isbArchivoOrigen        IN  VARCHAR2,  
        isbDirectorioDestino    IN  VARCHAR2,
        isbArchivoDestino       IN  VARCHAR2,
        iblSobreEscribe         IN  BOOLEAN DEFAULT FALSE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prcRenombraArchivo_Ut';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        
        utl_file.fRename
        (
            isbDirectorioOrigen,
            isbArchivoOrigen,
            isbDirectorioDestino,
            isbArchivoDestino,
            iblSobreEscribe
        );
          
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);  

    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;        
    END prcRenombraArchivo_Ut;

    -- Escribe terminadores de línea en el archivo por medio de UT
    PROCEDURE prcEscribeTermLinea_Ut
    ( 
        iflArchivo      styArchivo,
        inuLineas       NUMBER DEFAULT 1
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prcEscribeTermLinea_Ut';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        
        utl_file.new_line
        (
            iflArchivo      ,
            inuLineas      
        );
          
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);  

    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;        
    END prcEscribeTermLinea_Ut;

    -- Cierra todo los archivos abiertos
    PROCEDURE prcCerrarArchivos_UT
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prcCerrarArchivos_UT';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        
        utl_file.fClose_All;
          
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);  

    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;        
    END prcCerrarArchivos_UT;
    
    -- Obtiene un segmento en formato binario
    PROCEDURE prcObtieneSegmentoBinario_UT
    ( 
        iflArchivo  IN  styArchivo, 
        oraSegmento OUT RAW, 
        inuLongituD IN  NUMBER DEFAULT NULL
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prcObtieneSegmentoBinario_UT';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        
        utl_file.Get_Raw(iflArchivo, oraSegmento, inuLongituD) ;
          
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);  

    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;        
    END prcObtieneSegmentoBinario_UT;
    
    -- Escribe un segmento en formato binario
    PROCEDURE prcEscribeSegmentoBinario_UT
    ( 
        iflArchivo      IN  styArchivo, 
        iraSegmento     IN RAW, 
        iblInmediato    IN  BOOLEAN DEFAULT FALSE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prcEscribeSegmentoBinario_UT';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        
        utl_file.Put_Raw(iflArchivo, iraSegmento, iblInmediato) ;
          
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);  

    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;        
    END prcEscribeSegmentoBinario_UT;                
    
    PROCEDURE prcAtributosArchivo_SMF
    ( 
        isbDirectorio       IN  VARCHAR2,
        isbArchivo          IN  VARCHAR2 , 
        oblExisteArchivo    OUT BOOLEAN, 
        onuTamanoArchivo    OUT NUMBER, 
        onuTamanoBloque     OUT NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prcAtributosArchivo_SMF';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO); 
        
        prcAtributosArchivo_UT(isbDirectorio,isbArchivo,oblExisteArchivo,onuTamanoArchivo,onuTamanoBloque);
         
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);  

    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;        
    END prcAtributosArchivo_SMF;

    -- Retorna verdadero si el archivo existe y falso en caso contrario
    FUNCTION fblExisteArchivo_SMF
    ( 
        isbDirectorio   IN VARCHAR2, 
        isbArchivo      IN VARCHAR2 
    ) RETURN BOOLEAN
    IS
        csbMetodo       CONSTANT VARCHAR2(70) := csbSP_NAME || 'fblExisteArchivo_SMF';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        blExisteArchivo BOOLEAN;
        nuTamanoArchivo NUMBER;
        nuTamanoBloque  NUMBER;
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        
        prcAtributosArchivo_SMF(isbDirectorio,isbArchivo,blExisteArchivo,nuTamanoArchivo,nuTamanoBloque);
          
        IF blExisteArchivo THEN
            pkg_traza.trace('SI Existe el archivo ' || isbDirectorio || '/' || isbArchivo, csbNivelTraza );
        ELSE
            pkg_traza.trace('NO Existe el archivo ' || isbDirectorio || '/' || isbArchivo, csbNivelTraza );
        END IF;
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);  
        
        RETURN blExisteArchivo;

    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;        
    END fblExisteArchivo_SMF;    

    -- Eleva mensaje de error si el archivo no existe
    PROCEDURE prcValidaExisteArchivo_SMF
    ( 
        isbDirectorio   IN VARCHAR2, 
        isbArchivo      IN VARCHAR2 
    )
    IS
        csbMetodo       CONSTANT VARCHAR2(70) := csbSP_NAME || 'prcValidaExisteArchivo_SMF';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
       
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        
        IF NOT fblExisteArchivo_SMF( isbDirectorio, isbArchivo ) THEN
            pkg_error.setErrorMessage( isbMsgErrr => 'No existe el archivo ' || isbDirectorio || '/' || isbArchivo );  
        END IF;
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);  
        
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;        
    END prcValidaExisteArchivo_SMF;  

    -- Retorna verdadero si el archivo esta abierto y falso en caso contrario
    FUNCTION fblArchivoAbierto_SMF
    ( 
        istyArchivo      IN  OUT styArchivo 
    ) RETURN BOOLEAN
    IS
        csbMetodo           CONSTANT VARCHAR2(70) := csbSP_NAME || 'fblArchivoAbierto_SMF';
        nuError             NUMBER;
        sbError             VARCHAR2(4000);
        blArchivoAbierto    BOOLEAN;
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO); 
        
        blArchivoAbierto := fblArchivoAbierto_UT(istyArchivo);
          
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        
        RETURN blArchivoAbierto;  

    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;        
    END fblArchivoAbierto_SMF;
           
    -- Retorna el puntero del archivo si puede abrirlo con las condiciones indicadas
    FUNCTION ftAbrirArchivo_SMF
    (  
        isbDirectorio       IN  VARCHAR2, 
        isbArchivo          IN  VARCHAR2, 
        isbModo             IN  VARCHAR2
    ) RETURN styArchivo
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'ftAbrirArchivo_SMF';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        
        flArchivo       styArchivo;
        
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        
        flArchivo := pkUtlFileMgr.fOpen( isbDirectorio, isbArchivo, isbModo );
        
        IF NOT gtbArchivosAbiertos.Exists( isbDirectorio || '|' || isbArchivo ) THEN
            gtbArchivosAbiertos( isbDirectorio || '|' || isbArchivo ) := flArchivo;
        END IF;
        
        pkg_traza.trace('Se abrió el archivo ' || isbDirectorio || '/' || isbArchivo || ' en modo ' || isbModo, csbNivelTraza );
          
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 
        
        RETURN  flArchivo;

    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;        
    END ftAbrirArchivo_SMF;    
    
    -- Retorna el puntero del archivo si puede abrirlo con las condiciones indicadas
    FUNCTION fsbObtenerLinea_SMF
    ( 
        istyArchivo          IN  OUT styArchivo 
    ) RETURN VARCHAR2
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fsbObtenerLinea_SMF';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        
        sbLinea         VARCHAR2(32767);
        
        nuLinea         NUMBER;
        
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        
        nuLinea := pkUtlFileMgr.Get_Line( istyArchivo, sbLinea );
          
        -- Si se llegó al final del archivo se eleva excepción
        IF nuLinea = cnuFIN_ARCHIVO THEN            
            RAISE NO_DATA_FOUND;
        END IF;
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);  
        
        RETURN sbLinea;

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            pkg_traza.trace('Se llegó al final del archivo', csbNivelTraza );        
            RAISE;
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;        
    END fsbObtenerLinea_SMF;      

    -- Escribe lineas en el archivo
    PROCEDURE prcEscribirLinea_SMF
    ( 
        istyArchivo          IN  OUT styArchivo , 
        isbLinea            IN  VARCHAR2,
        iblInmediato        IN  BOOLEAN DEFAULT FALSE        
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prcEscribirLinea_SMF';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);

        IF NOT iblInmediato THEN
            pkUtlFileMgr.Put_Line( istyArchivo, isbLinea );
        ELSE
            prcEscribirLinea_UT(istyArchivo,isbLinea,iblInmediato);
        END IF;
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);  

    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;        
    END prcEscribirLinea_SMF; 
    
    -- Escribe linea sin terminador en el archivo con SMF
    PROCEDURE prcEscribirLineaSinTerm_SMF
    ( 
        istyArchivo          IN  OUT styArchivo , 
        isbLinea            IN  VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prcEscribirLineaSinTerm_SMF';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        
        prcEscribirLineaSinTerm_UT( istyArchivo, isbLinea );

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);  

    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;        
    END prcEscribirLineaSinTerm_SMF;      
    
    -- Renombra un archivo con utl_file
    PROCEDURE prcRenombraArchivo_SMF
    ( 
        isbDirectorioOrigen     IN  VARCHAR2,
        isbArchivoOrigen        IN  VARCHAR2,  
        isbDirectorioDestino    IN  VARCHAR2,
        isbArchivoDestino       IN  VARCHAR2,
        iblSobreEscribe         IN  BOOLEAN DEFAULT FALSE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prcRenombraArchivo_SMF';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        
        prcRenombraArchivo_UT
        ( 
            isbDirectorioOrigen,
            isbArchivoOrigen,
            isbDirectorioDestino,  
            isbArchivoDestino,
            iblSobreEscribe
        );
        
        pkg_traza.trace( 'Se renombró el archivo ' ||isbDirectorioOrigen || '/' || isbArchivoOrigen , csbNivelTraza);
        pkg_traza.trace( 'Como ' ||isbDirectorioDestino || '/' || isbArchivoDestino , csbNivelTraza);

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);  

    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;        
    END prcRenombraArchivo_SMF;                       

    -- Cierra el archivo si se encuentra abierto
    PROCEDURE prcCerrarArchivo_SMF
    (
        istyArchivo         IN  OUT styArchivo,
        isbDirectorio       IN VARCHAR2 DEFAULT NULL,
        isbArchivo          IN  VARCHAR2 DEFAULT NULL,
        ifblCerrarMasivo    IN BOOLEAN DEFAULT FALSE     
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prcCerrarArchivo_SMF';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        
        IF fblArchivoAbierto_SMF(istyArchivo)  THEN
            pkUtlFileMgr.fClose( istyArchivo );
            pkg_traza.trace( 'Se cerró el archivo ' ||isbDirectorio || '/' || isbArchivo , csbNivelTraza); 
        ELSE
            pkg_traza.trace( 'El archivo esta cerrado', csbNivelTraza);        
        END IF;
        
        IF gtbArchivosAbiertos.exists( isbDirectorio || '|' || isbArchivo ) THEN
            gtbArchivosAbiertos.delete( isbDirectorio || '|' || isbArchivo );
        END IF;
          
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);  

    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;        
    END prcCerrarArchivo_SMF;        
    
    -- Borra un archivo
    PROCEDURE prcBorrarArchivo_SMF
    ( 
        isbDirectorio VARCHAR2, 
        isbArchivo VARCHAR2 
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prcBorrarArchivo_SMF';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO); 
        
        pkUtlFileMgr.fRemove(isbDirectorio, isbArchivo);
        
        pkg_traza.trace('Se borró el archivo ' || isbDirectorio || '/' || isbArchivo , csbNivelTraza);
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);  

    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;        
    END prcBorrarArchivo_SMF;

    -- Copia un archivo con SMF
    PROCEDURE prcCopiaArchivo_SMF
    ( 
        isbDirectorioOrigen     IN  VARCHAR2, 
        isbArchivoOrigen        IN  VARCHAR2,  
        isbDirectorioDestino    IN  VARCHAR2, 
        isbArchivoDestino       IN  VARCHAR2,
        inuLineaInicial         IN  NUMBER DEFAULT NULL,
        inuLineaFinal           IN  NUMBER DEFAULT NULL
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prcCopiaArchivo_SMF';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);

    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        
        prcCopiaArchivo_UT
        ( 
            isbDirectorioOrigen, 
            isbArchivoOrigen   ,  
            isbDirectorioDestino, 
            isbArchivoDestino   ,
            inuLineaInicial     ,
            inuLineaFinal       
        );       
                
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);  

    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;        
    END prcCopiaArchivo_SMF;    
  
    -- Escribe Terminadores de linea con SMF
    PROCEDURE prcEscribeTermLinea_SMF
    ( 
        iflArchivo      styArchivo,
        inuLineas       NUMBER DEFAULT 1
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prcEscribeTermLinea_SMF';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);

    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        
        prcEscribeTermLinea_UT( iflArchivo, inuLineas);
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);  

    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;        
    END prcEscribeTermLinea_SMF;        
      
    -- Cierra todo los archivos abiertos
    PROCEDURE prcCerrarArchivos_SMF
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prcCerrarArchivos_SMF';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        sbDirectorioyArchivo       VARCHAR2(1000);
        
        CURSOR cuDirectorioyArchivo( isbDirAch VARCHAR2 )
        IS
        SELECT regexp_substr(isbDirAch,'[^|]+', 1,LEVEL)
        FROM dual
        CONNECT BY regexp_substr(isbDirAch, '[^|]+', 1, LEVEL) IS NOT NULL; 
                
        sbDirectorio VARCHAR2(1000);       

        sbArchivo VARCHAR2(1000);
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        
        IF gtbArchivosAbiertos.COUNT >0 THEN
        
            sbDirectorioyArchivo := gtbArchivosAbiertos.First;
            
            LOOP
                EXIT WHEN sbDirectorioyArchivo IS NULL;
                
                OPEN cuDirectorioyArchivo(sbDirectorioyArchivo);
                FETCH cuDirectorioyArchivo INTO sbDirectorio;
                FETCH cuDirectorioyArchivo INTO sbArchivo;
                CLOSE cuDirectorioyArchivo;
                                
                prcCerrarArchivo_SMF(gtbArchivosAbiertos(sbDirectorioyArchivo),sbDirectorio,sbArchivo, TRUE);
                               
                sbDirectorioyArchivo := gtbArchivosAbiertos.Next(sbDirectorioyArchivo);
                
            END LOOP;
            
            gtbArchivosAbiertos.delete;           
        
        END IF;
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);  

    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;        
    END prcCerrarArchivos_SMF;
    
    -- Obtiene un segmento en formato binario con SMF
    PROCEDURE prcObtieneSegmentoBinario_SMF
    ( 
        iflArchivo  IN  styArchivo, 
        oraSegmento OUT RAW, 
        inuLongituD IN  NUMBER DEFAULT NULL
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prcObtieneSegmentoBinario_SMF';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        
        prcObtieneSegmentoBinario_UT
        ( 
            iflArchivo, 
            oraSegmento, 
            inuLongituD
        );
          
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);  

    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;        
    END prcObtieneSegmentoBinario_SMF;

    -- Escribe un segmento en formato binario con SMF
    PROCEDURE prcEscribeSegmentoBinario_SMF
    ( 
        iflArchivo      IN  styArchivo, 
        iraSegmento     IN RAW, 
        iblInmediato    IN  BOOLEAN DEFAULT FALSE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prcEscribeSegmentoBinario_SMF';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        
        prcEscribeSegmentoBinario_UT
        ( 
            iflArchivo, 
            iraSegmento, 
            iblInmediato
        );
          
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);  

    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;        
    END prcEscribeSegmentoBinario_SMF;
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbExtensionArchivo 
    Descripcion     : Retona la extensión del archivo si tiene y null en caso
                      contrario
    Autor           : Lubin Pineda - MVM 
    Fecha           : 08/10/2024 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     08/10/2024  OSF-3162 Creacion
    ***************************************************************************/     
    FUNCTION fsbExtensionArchivo(isbArchivo VARCHAR2) RETURN VARCHAR2
    IS
        csbMetodo           CONSTANT VARCHAR2(70) := csbSP_NAME || 'fsbExtensionArchivo';
        nuError             NUMBER;
        sbError             VARCHAR2(4000);
        sbExtensionArchivo  VARCHAR2(10);
        nuPosUltimoPunto    NUMBER;
        
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);     
        
        nuPosUltimoPunto := INSTR( isbArchivo, '.' , -1);
        
        IF  nuPosUltimoPunto > 0 THEN
            sbExtensionArchivo := SUBSTR( isbArchivo, (nuPosUltimoPunto+1) );        
        END IF; 
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        
        RETURN sbExtensionArchivo;
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RETURN sbExtensionArchivo;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RETURN sbExtensionArchivo;             
    END fsbExtensionArchivo;    

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbNombreArchivoSinExt 
    Descripcion     : Retona el nombre del archivo sin la extensión la tiene
    Autor           : Lubin Pineda - MVM 
    Fecha           : 08/10/2024 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     08/10/2024  OSF-3162 Creacion
    ***************************************************************************/      
    FUNCTION fsbNombreArchivoSinExt(isbArchivo VARCHAR2) RETURN VARCHAR2
    IS
        csbMetodo           CONSTANT VARCHAR2(70) := csbSP_NAME || 'fsbNombreArchivoSinExt';
        nuError             NUMBER;
        sbError             VARCHAR2(4000);
        sbExtensionArchivo  VARCHAR2(50);
        sbNomberArchivo     VARCHAR2(200);
        
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        
        sbExtensionArchivo := fsbExtensionArchivo(isbArchivo);       

        IF sbExtensionArchivo IS NOT NULL THEN
            sbNomberArchivo := REPLACE( isbArchivo, '.' || sbExtensionArchivo, '' );
        ELSE 
            sbNomberArchivo := isbArchivo;
        END IF;
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        
        RETURN sbNomberArchivo;
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RETURN sbNomberArchivo;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RETURN sbNomberArchivo;             
    END fsbNombreArchivoSinExt;                                     
                  
END pkg_GestionArchivos;
/

Prompt Otorgando permisos sobre ADM_PERSON.pkg_GestionArchivos
BEGIN
    pkg_utilidades.prAplicarPermisos( upper('pkg_GestionArchivos'), 'ADM_PERSON');
END;
/

