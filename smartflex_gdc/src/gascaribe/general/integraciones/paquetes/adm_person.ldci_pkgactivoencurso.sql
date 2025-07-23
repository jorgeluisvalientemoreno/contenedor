CREATE OR REPLACE PACKAGE ADM_PERSON.LDCI_PKGACTIVOENCURSO IS
  /********************************************************************************
  PROPIEDAD INTELECTUAL DE SURTIGAS.
  PAQUETE:    ldci_pkgActivoEnCurso
  DESCRIPCION: Paquete de primer nivel para manejar el CRUD de la tabla
               ldci_activoencurso.

  AUTOR:      Jorge Mario Galindo - ArquitecSoft
  FECHA:      05/03/2014

  HISTORIA DE MODIFICACIONES
  FECHA         AUTOR       MODIFICACION
  10/06/2025    jpinedc     OSF-4558: * Se borran  fvaGetSociedad y ActSociedad
                            * Se agrega el argumento  de entrada isbSociedad a
                            ** curecord
                            ** fblCargaPrevia
                            ** fvaGetTexto_Breve
                            ** acttexto_breve
                            ** fboExiste
                            ** validaLlave
                            ** validaLlaveDuplicada
                            ** consultarRegistro
                            ** frcConsultaRregistro
                            ** borraregistro
  ********************************************************************************/
  --<<
  -- cursor de la ldci_activoencurso
  -->>
  CURSOR curecord(ivacodigo_activo IN ldci_activoencurso.codigo_activo%TYPE,
                  ivasubnumero     IN ldci_activoencurso.subnumero%TYPE,
                  isbSociedad      IN ldci_activoencurso.sociedad%TYPE) IS
    SELECT ldci_activoencurso.*, ldci_activoencurso.rowid
      FROM ldci_activoencurso
     WHERE codigo_activo = ivacodigo_activo
       AND subnumero = ivasubnumero
       AND sociedad = isbSociedad;

  tyldc_activoencurso ldci_activoencurso%ROWTYPE;

  SUBTYPE stbldc_activoencurso IS ldci_activoencurso%ROWTYPE;

  --<<
  -- tipo usado para manipular ref cursors
  -->>
  TYPE tyrefcursor IS REF CURSOR;
  --<<
  -- subtipos
  -->>
  SUBTYPE styldc_activoencurso IS curecord%ROWTYPE;
  --<<
  -- tipos
  -->>
  TYPE tytbldc_activoencurso IS TABLE OF styldc_activoencurso INDEX BY BINARY_INTEGER;
  TYPE tyrfrecords IS REF CURSOR RETURN styldc_activoencurso;
  --<<
  -- constantes para los mensajes de error y desplegar la existencia o no de un registro
  -->>
  cnurecord_not_exist     CONSTANT NUMBER := 2;
  cnurecord_already_exist CONSTANT NUMBER := 1;
  cnutableparameter       CONSTANT NUMBER := 1000;


  --<<
  -- Funcion para obtener el texto breve
  -->>
  FUNCTION fvaGetTexto_Breve(ivacodigo_activo IN ldci_activoencurso.codigo_activo%TYPE,
                             ivasubnumero     IN ldci_activoencurso.subnumero%TYPE,
                             isbSociedad      IN ldci_activoencurso.sociedad%TYPE,
                             inuusecache      IN NUMBER DEFAULT 0)
    RETURN VARCHAR2;

  --<<
  --  Fucnion para Actualizar el Texto Breve
  -->>
  PROCEDURE acttexto_breve(ivacodigo_activo IN ldci_activoencurso.codigo_activo%TYPE,
                           ivasubnumero     IN ldci_activoencurso.subnumero%TYPE,
                           isbSociedad      IN ldci_activoencurso.sociedad%TYPE,
                           ivatexto_breve   IN ldci_activoencurso.texto_breve%TYPE);

  --<<
  -- Funcion para Validar si existe un activo fijo en curso
  -->>
  FUNCTION fboExiste(ivacodigo_activo IN ldci_activoencurso.codigo_activo%TYPE,
                     ivasubnumero     IN ldci_activoencurso.subnumero%TYPE,
                     isbSociedad      IN ldci_activoencurso.sociedad%TYPE,
                     inuusecache      IN NUMBER DEFAULT 0) RETURN BOOLEAN;

  --<<
  -- Funcion para validar si un Activo en curso existe
  -->>
  PROCEDURE validaLlave(ivacodigo_activo IN ldci_activoencurso.codigo_activo%TYPE,
                        ivasubnumero     IN ldci_activoencurso.subnumero%TYPE,
                        isbSociedad      IN ldci_activoencurso.sociedad%TYPE,
                        inuusecache      IN NUMBER DEFAULT 0);

  --<<
  -- Funcion para validar  llave duplicada
  -->>
  PROCEDURE validaLlaveDuplicada(ivacodigo_activo IN ldci_activoencurso.codigo_activo%TYPE,
                                 ivasubnumero     IN ldci_activoencurso.subnumero%TYPE,
                                 isbSociedad      IN ldci_activoencurso.sociedad%TYPE,
                                 inuusecache      IN NUMBER DEFAULT 0);

  --<<
  -- Funcion para Consultar un Activo en Curso
  -->>
  PROCEDURE consultarRegistro(ivacodigo_activo IN ldci_activoencurso.codigo_activo%TYPE,
                              ivasubnumero     IN ldci_activoencurso.subnumero%TYPE,
                              isbSociedad      IN ldci_activoencurso.sociedad%TYPE,
                              orcrecord        OUT NOCOPY styldc_activoencurso,
                              inuusecache      IN NUMBER DEFAULT 0);

  --<<
  -- Funcion para consultar un Activo Fijo en Curso
  -->>
  FUNCTION frcConsultaRregistro(ivacodigo_activo IN ldci_activoencurso.codigo_activo%TYPE,
                                ivasubnumero     IN ldci_activoencurso.subnumero%TYPE,
                                isbSociedad      IN ldci_activoencurso.sociedad%TYPE,
                                inuusecache      IN NUMBER DEFAULT 0)
    RETURN styldc_activoencurso;

  --<<
  -- Funcion para Insertar un activo fijo en curso
  -->>
  PROCEDURE insertaregistro(ircldc_activoencurso IN ldci_activoencurso%ROWTYPE);

  --<<
  -- Funcion para Borrar un Activo Fijo en Curso
  -->>
  PROCEDURE borraregistro(ivacodigo_activo IN ldci_activoencurso.codigo_activo%TYPE,
                          ivasubnumero     IN ldci_activoencurso.subnumero%TYPE,
                          isbSociedad      IN ldci_activoencurso.sociedad%TYPE);

  --<<
  -- Funcion para Borrar un Activo Fijo en Curso por Rowid
  -->>
  PROCEDURE borrarowid(irirowid ROWID);

  --<<
  -- Procedimiento que sera consumido por el WS para el dato maestro de activos fijos
	-->>
  PROCEDURE proConsuWSActivoFijo(codActivo ldci_activoencurso.codigo_activo%TYPE,
                                 codSubnum ldci_activoencurso.subnumero%TYPE,
                                 sociedad  ldci_activoencurso.sociedad%TYPE,
                                 descripci ldci_activoencurso.texto_breve%TYPE);

END LDCI_PKGACTIVOENCURSO;
/

CREATE OR REPLACE PACKAGE BODY ADM_PERSON.LDCI_PKGACTIVOENCURSO IS
  /********************************************************************************
  PROPIEDAD INTELECTUAL DE SURTIGAS.
  PAQUETE:     ldci_pkgActivoEnCurso
  DESCRIPCION: Paquete de primer nivel para manejar el CRUD de la tabla
               ldci_activoencurso.

  AUTOR:       Jorge Mario Galindo - ArquitecSoft
  FECHA:       05/03/2014

  HISTORIA DE MODIFICACIONES
  FECHA         AUTOR    MODIFICACION

  ********************************************************************************/

    csbSP_NAME		CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT||'.';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;

    --<<
    -- Tipo Cursor
    -->>
    TYPE tyrfldc_activoencurso IS REF CURSOR;

    --<<
    -- Tipos referenciando al registro
    --<<
    TYPE tytbcodigo_activo IS TABLE OF ldci_activoencurso.codigo_activo%TYPE INDEX BY BINARY_INTEGER;
    TYPE tytbsubnumero IS TABLE OF ldci_activoencurso.subnumero%TYPE INDEX BY BINARY_INTEGER;
    TYPE tytbsociedad IS TABLE OF ldci_activoencurso.sociedad%TYPE INDEX BY BINARY_INTEGER;
    TYPE tytbtexto_breve IS TABLE OF ldci_activoencurso.texto_breve%TYPE INDEX BY BINARY_INTEGER;

    --<<
    -- Tipo de Dato
    -->>
    TYPE tyrcldc_activoencurso IS RECORD(
    codigo_activo tytbcodigo_activo,
    subnumero     tytbsubnumero,
    sociedad      tytbsociedad,
    texto_breve   tytbtexto_breve);

    --<<
    --Variables Globales
    -->>
    rcRecOfTab   tyrcLDC_ACTIVOENCURSO;
    rcData       cuRecord%ROWTYPE;
    rcRecordNull cuRecord%ROWTYPE;
    cnuCACHEON   NUMBER := 1;

    FUNCTION fblCargaPrevia(ivacodigo_activo IN ldci_activoencurso.codigo_activo%TYPE,
                          ivasubnumero     IN ldci_activoencurso.subnumero%TYPE,
                          isbSociedad      IN ldci_activoencurso.sociedad%TYPE)
    /********************************************************************************
    PROPIEDAD INTELECTUAL DE SURTIGAS.
    FUNCION:     fblCargaPrevia
    DESCRIPCION: Carga la Carga Previa.

    PARAMETROS DE ENTRADA: ivacodigo_activo => Codigo de Activo
                           ivasubnumero     => Subnumero
    PARAMETROS DE SALIDA:  Ninguno
    RETORNOS:              TRUE             => Existe
                           FALSE            => No Existe

    AUTOR:      Jorge Mario Galindo - ArquitecSoft
    FECHA:      05/03/2014

    HISTORIA DE MODIFICACIONES
    FECHA       AUTOR   CASO        MODIFICACION
    10/06/2025  jpinedc OSF-4558    Se agrega argumento de entrada isbSociedad
    ********************************************************************************/
    RETURN BOOLEAN IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fblCargaPrevia';    
        blCargaPrevia   BOOLEAN := FALSE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO); 
        
        IF 
        (
            iVACODIGO_ACTIVO = rcData.CODIGO_ACTIVO AND
            iVASUBNUMERO = rcData.SUBNUMERO AND 
            isbSociedad = rcData.SOCIEDAD
        ) THEN
            blCargaPrevia := TRUE;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);            
        RETURN blCargaPrevia;
        
    END fblCargaPrevia;

  PROCEDURE reCarga(ivacodigo_activo IN ldci_activoencurso.codigo_activo%TYPE,
                    ivasubnumero     IN ldci_activoencurso.subnumero%TYPE,
                    isbSociedad      IN ldci_activoencurso.sociedad%TYPE) IS
  /********************************************************************************
    PROPIEDAD INTELECTUAL DE SURTIGAS.
    PROCEDIMIENTO:    reCarga
    DESCRIPCION:      Procedimiento para la Recarga de un Activo Fijo en Curso.

    PARAMETROS DE ENTRADA: ivacodigo_activo => Codigo de Activo
                           ivasubnumero     => Subnumero
    PARAMETROS DE SALIDA:  Ninguno
    RETORNOS:              Ninguno

    AUTOR:      Jorge Mario Galindo - ArquitecSoft
    FECHA:      05/03/2014

    HISTORIA DE MODIFICACIONES
    FECHA       AUTOR   CASO        MODIFICACION
    10/06/2025  jpinedc OSF-4558    Se agrega argumento de entrada isbSociedad
    ********************************************************************************/
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fblCargaPrevia';      
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO); 
            
        IF (curecord%ISOPEN) THEN
            CLOSE curecord;
        END IF;
        
        OPEN curecord(ivacodigo_activo, ivasubnumero, isbSociedad);
        FETCH curecord INTO rcdata;
        IF (curecord%NOTFOUND) THEN
          CLOSE curecord;
          rcdata := rcrecordnull;
          RAISE no_data_found;
        END IF;
        CLOSE curecord;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);         
    END reCarga;

    FUNCTION fvaGetTexto_Breve(ivacodigo_activo IN ldci_activoencurso.codigo_activo%TYPE,
                             ivasubnumero     IN ldci_activoencurso.subnumero%TYPE,
                             isbSociedad      IN ldci_activoencurso.sociedad%TYPE,
                             inuusecache      IN NUMBER DEFAULT 0)
  /********************************************************************************
    PROPIEDAD INTELECTUAL DE SURTIGAS.
    FUNCION:     fvaGetTexto_Breve
    DESCRIPCION: Funcion para obtener el texto breve.

    PARAMETROS DE ENTRADA: ivacodigo_activo => Codigo de Activo
                           ivasubnumero     => Subnumero
                           inuusecache      => Control
    PARAMETROS DE SALIDA:  Ninguno
    RETORNOS:              Texto Breve

    AUTOR:       Jorge Mario Galindo - ArquitecSoft
    FECHA:       05/03/2014

    FECHA       AUTOR   CASO        MODIFICACION
    10/06/2025  jpinedc OSF-4558    Se agrega argumento de entrada isbSociedad
    ********************************************************************************/
    RETURN VARCHAR2 IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fvaGetTexto_Breve';     
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO); 
            
        IF (inuusecache = cnucacheon AND
            fblcargaprevia(ivacodigo_activo, ivasubnumero, isbSociedad)) THEN
            RETURN(rcdata.texto_breve);
        END IF;
        
        recarga(ivacodigo_activo, ivasubnumero, isbSociedad);

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 
        
        RETURN(rcdata.texto_breve);

    EXCEPTION
        WHEN OTHERS THEN
            ldci_pkInterfazSAP.vaMensError :=  '[fnuGetTipoTrab] - No se pudo obtener el tipo_trab '||sqlerrm||' '||DBMS_UTILITY.format_error_backtrace;
            RETURN NULL;
    END fvaGetTexto_Breve;

    PROCEDURE acttexto_breve(ivacodigo_activo IN ldci_activoencurso.codigo_activo%TYPE,
                           ivasubnumero     IN ldci_activoencurso.subnumero%TYPE,
                           isbSociedad      IN ldci_activoencurso.sociedad%TYPE,
                           ivatexto_breve   IN ldci_activoencurso.texto_breve%TYPE) IS
    /********************************************************************************
    PROPIEDAD INTELECTUAL DE SURTIGAS.
    PROCEDURE:     actTexto_Breve
    PROCEDIMIENTO: Actualiza el texto breve de un activo fijo en curso.

    PARAMETROS DE ENTRADA: ivacodigo_activo => Codigo de Activo
                           ivasubnumero     => Subnumero
                           ivatexto_breve   => Descripcion
    PARAMETROS DE SALIDA:  Ninguno
    RETORNOS:              Ninguno

    AUTOR:         Jorge Mario Galindo - ArquitecSoft
    FECHA:         05/03/2014

    HISTORIA DE MODIFICACIONES
    FECHA       AUTOR   CASO        MODIFICACION
    10/06/2025  jpinedc OSF-4558    Se agrega argumento de entrada isbSociedad
    ********************************************************************************/
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'acttexto_breve';              
    BEGIN
    
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO); 
            
        UPDATE ldci_activoencurso
        SET texto_breve = ivatexto_breve
        WHERE codigo_activo = ivacodigo_activo
        AND subnumero = ivasubnumero
        AND sociedad = isbSociedad;

        rcdata.texto_breve := ivatexto_breve;
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 
                
    EXCEPTION
        WHEN no_data_found THEN
            ldci_pkInterfazSAP.vaMensError :=  '[fnuGetTipoTrab] - No se pudo obtener el tipo_trab '||sqlerrm||' '||DBMS_UTILITY.format_error_backtrace;
    END acttexto_breve;

    PROCEDURE cargar(ivacodigo_activo IN ldci_activoencurso.codigo_activo%TYPE,
                   ivasubnumero     IN ldci_activoencurso.subnumero%TYPE,
                   isbSociedad      IN ldci_activoencurso.sociedad%TYPE, 
                   inuusecache      IN NUMBER DEFAULT 0) IS
    /********************************************************************************
    PROPIEDAD INTELECTUAL DE SURTIGAS.
    PROCEDURE:   cargar
    DESCRIPCION: Carga la informacion de un activo fijo en curso.

    PARAMETROS DE ENTRADA: ivacodigo_activo => Codigo de Activo
                           ivasubnumero     => Subnumero
                           inuusecache      => Control
    PARAMETROS DE SALIDA:  Ninguno
    RETORNOS:              Ninguno

    AUTOR:      Jorge Mario Galindo - ArquitecSoft
    FECHA:      05/03/2014

    HISTORIA DE MODIFICACIONES
    FECHA       AUTOR   CASO        MODIFICACION
    10/06/2025  jpinedc OSF-4558    Se agrega argumento de entrada isbSociedad
    ********************************************************************************/
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'cargar';      
    BEGIN
    
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO); 
            
        IF (inuusecache = cnucacheon AND
            fblcargaprevia(ivacodigo_activo, ivasubnumero, isbSociedad)) THEN
            pkg_traza.trace('Registro en Cache', csbNivelTraza);
        ELSE
            recarga(ivacodigo_activo, ivasubnumero, isbSociedad);
        END IF;
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
                 
    END cargar;

    FUNCTION fboExiste(ivacodigo_activo IN ldci_activoencurso.codigo_activo%TYPE,
                     ivasubnumero     IN ldci_activoencurso.subnumero%TYPE,
                     isbSociedad      IN ldci_activoencurso.sociedad%TYPE,                      
                     inuusecache      IN NUMBER DEFAULT 0) RETURN BOOLEAN IS
    /********************************************************************************
    PROPIEDAD INTELECTUAL DE SURTIGAS.
    FUNCION:     fboExiste
    DESCRIPCION: Funcion para validar si un activo fijo Existe.

    PARAMETROS DE ENTRADA: ivacodigo_activo => Codigo de Activo
                           ivasubnumero     => Subnumero
                           inuusecache      => Control
    PARAMETROS DE SALIDA:  Ninguno
    RETORNOS:              TRUE             => Existe
                           FALSE            => No Existe

    AUTOR:      Jorge Mario Galindo - ArquitecSoft
    FECHA:      05/03/2014

    HISTORIA DE MODIFICACIONES
    FECHA       AUTOR   CASO        MODIFICACION
    10/06/2025  jpinedc OSF-4558    Se agrega argumento de entrada isbSociedad
    ********************************************************************************/
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fboExiste';      
        boExiste    BOOLEAN;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        cargar(ivacodigo_activo, ivasubnumero, isbSociedad, inuusecache);
        boExiste := TRUE;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN boExiste;
    EXCEPTION
        WHEN no_data_found THEN
            ldci_pkInterfazSAP.vaMensError :=  '[fnuGetTipoTrab] - No se pudo obtener el tipo_trab '||sqlerrm||' '||DBMS_UTILITY.format_error_backtrace;
            boExiste := FALSE;            
            RETURN boExiste;
    END fboExiste;

    PROCEDURE validaLlave(ivacodigo_activo IN ldci_activoencurso.codigo_activo%TYPE,
                        ivasubnumero     IN ldci_activoencurso.subnumero%TYPE,
                        isbSociedad      IN ldci_activoencurso.sociedad%TYPE,  
                        inuusecache      IN NUMBER DEFAULT 0) IS
    /********************************************************************************
    PROPIEDAD INTELECTUAL DE SURTIGAS.
    PROCEDURE:   validaLlave
    DESCRIPCION: Valida la llave de un activo dijo en curso.

    PARAMETROS DE ENTRADA: ivacodigo_activo => Codigo de Activo
                           ivasubnumero     => Subnumero
                           inuusecache      => Control
    PARAMETROS DE SALIDA:  Ninguno
    RETORNOS:              Ninguno

    AUTOR:      Jorge Mario Galindo - ArquitecSoft
    FECHA:      05/03/2014

    HISTORIA DE MODIFICACIONES
    FECHA       AUTOR   CASO        MODIFICACION
    10/06/2025  jpinedc OSF-4558    Se agrega argumento de entrada isbSociedad
    ********************************************************************************/
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'validaLlave';        
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);    
        cargar(ivacodigo_activo, ivasubnumero, isbSociedad, inuusecache);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    EXCEPTION
        WHEN no_data_found THEN
            ldci_pkInterfazSAP.vaMensError :=  '[fnuGetTipoTrab] - No se pudo obtener el tipo_trab '||sqlerrm||' '||DBMS_UTILITY.format_error_backtrace;
    END validaLlave;

    PROCEDURE validaLlaveDuplicada(ivacodigo_activo IN ldci_activoencurso.codigo_activo%TYPE,
                                 ivasubnumero     IN ldci_activoencurso.subnumero%TYPE,
                                isbSociedad      IN ldci_activoencurso.sociedad%TYPE,                                   
                                 inuusecache      IN NUMBER DEFAULT 0) IS
    /********************************************************************************
    PROPIEDAD INTELECTUAL DE SURTIGAS.
    PROCEDURE:   validaLlaveDuplicada
    DESCRIPCION: Valida la llave de un activo dijo en curso.

    PARAMETROS DE ENTRADA: ivacodigo_activo => Codigo de Activo
                           ivasubnumero     => Subnumero
                           inuusecache      => Control
    PARAMETROS DE SALIDA:  Ninguno
    RETORNOS:              Ninguno

    AUTOR:      Jorge Mario Galindo - ArquitecSoft
    FECHA:      05/03/2014

    HISTORIA DE MODIFICACIONES
    FECHA       AUTOR   CASO        MODIFICACION
    10/06/2025  jpinedc OSF-4558    Se agrega argumento de entrada isbSociedad
    ********************************************************************************/
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'validaLlaveDuplicada'; 
    BEGIN
    
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO); 
            
        cargar(ivacodigo_activo, ivasubnumero, isbSociedad, inuusecache);

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 
        
    EXCEPTION
        WHEN no_data_found THEN
            ldci_pkInterfazSAP.vaMensError :=  '[fnuGetTipoTrab] - No se pudo obtener el tipo_trab '||sqlerrm||' '||DBMS_UTILITY.format_error_backtrace;
    END validaLlaveDuplicada;

    PROCEDURE consultarRegistro(ivacodigo_activo IN ldci_activoencurso.codigo_activo%TYPE,
                              ivasubnumero     IN ldci_activoencurso.subnumero%TYPE,
                              isbSociedad      IN ldci_activoencurso.sociedad%TYPE,                                
                              orcrecord        OUT NOCOPY styldc_activoencurso,
                              inuusecache      IN NUMBER DEFAULT 0) IS
    /********************************************************************************
    PROPIEDAD INTELECTUAL DE SURTIGAS.
    PROCEDURE:   consultarRegistro
    DESCRIPCION: Consulta un Activo Fijo En Curso.

    PARAMETROS DE ENTRADA: ivacodigo_activo => Codigo de Activo
                           ivasubnumero     => Subnumero
                           inuusecache      => Control
    PARAMETROS DE SALIDA:  orcrecord        => record
    RETORNOS:              Ninguno

    AUTOR:      Jorge Mario Galindo - ArquitecSoft
    FECHA:      05/03/2014

    HISTORIA DE MODIFICACIONES
    FECHA       AUTOR   CASO        MODIFICACION
    10/06/2025  jpinedc OSF-4558    Se agrega argumento de entrada isbSociedad
    ********************************************************************************/
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'consultarRegistro';     
    BEGIN
    
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO); 
            
        cargar(ivacodigo_activo, ivasubnumero, isbSociedad, inuusecache);
        orcrecord := rcdata;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 
        
    EXCEPTION
        WHEN no_data_found THEN
            ldci_pkInterfazSAP.vaMensError :=  '[fnuGetTipoTrab] - No se pudo obtener el tipo_trab '||sqlerrm||' '||DBMS_UTILITY.format_error_backtrace;
    END consultarRegistro;

    FUNCTION frcConsultaRregistro(ivacodigo_activo IN ldci_activoencurso.codigo_activo%TYPE,
                                ivasubnumero     IN ldci_activoencurso.subnumero%TYPE,
                                isbSociedad      IN ldci_activoencurso.sociedad%TYPE,                                 
                                inuusecache      IN NUMBER DEFAULT 0)
    /********************************************************************************
    PROPIEDAD INTELECTUAL DE SURTIGAS.
    FUNCTION:    frcConsultaRregistro
    DESCRIPCION: consulta y retorna en una referencia de cursor el codigo de activo
                 fijo en curso.

    PARAMETROS DE ENTRADA: ivacodigo_activo => Codigo de Activo
                           ivasubnumero     => Subnumero
                           inuusecache      => Control
    PARAMETROS DE SALIDA:  Ninguno
    RETORNOS:              styldc_activoencurso => cursor referenciado

    AUTOR:      Jorge Mario Galindo - ArquitecSoft
    FECHA:      05/03/2014

    HISTORIA DE MODIFICACIONES
    FECHA       AUTOR   CASO        MODIFICACION
    10/06/2025  jpinedc OSF-4558    Se agrega argumento de entrada isbSociedad
    ********************************************************************************/
    RETURN styldc_activoencurso IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'frcConsultaRregistro';       
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);     
        cargar(ivacodigo_activo, ivasubnumero, isbSociedad, inuusecache);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);         
        RETURN(rcdata);
    EXCEPTION
        WHEN no_data_found THEN
            ldci_pkInterfazSAP.vaMensError :=  '[fnuGetTipoTrab] - No se pudo obtener el tipo_trab '||sqlerrm||' '||DBMS_UTILITY.format_error_backtrace;
    END frcConsultaRregistro;

  PROCEDURE insertaRegistro(ircldc_activoencurso IN ldci_activoencurso%ROWTYPE) IS
    /********************************************************************************
    PROPIEDAD INTELECTUAL DE SURTIGAS.
    PROCEDURE:   insertaRegistro
    DESCRIPCION: Procedimiento para la insercion de  un activo fijo en curso.

    PARAMETROS DE ENTRADA: ircldc_activoencurso => Type de Activo en Curso
    PARAMETROS DE SALIDA:  Ninguno
    RETORNOS:              Ninguno

    AUTOR:      Jorge Mario Galindo - ArquitecSoft
    FECHA:      05/03/2014

    HISTORIA DE MODIFICACIONES
    FECHA         AUTOR    MODIFICACION

    ********************************************************************************/
  BEGIN
    INSERT INTO ldci_activoencurso
      (

       codigo_activo,
       subnumero,
       sociedad,
       texto_breve)
    VALUES
      (

       ircldc_activoencurso.codigo_activo,
       ircldc_activoencurso.subnumero,
       ircldc_activoencurso.sociedad,
       ircldc_activoencurso.texto_breve

       );

  EXCEPTION
    WHEN dup_val_on_index THEN
      ldci_pkInterfazSAP.vaMensError :=  '[fnuGetTipoTrab] - No se pudo obtener el tipo_trab '||sqlerrm||' '||DBMS_UTILITY.format_error_backtrace;
  END insertaRegistro;

  PROCEDURE borraRegistro(ivacodigo_activo IN ldci_activoencurso.codigo_activo%TYPE,
                          ivasubnumero     IN ldci_activoencurso.subnumero%TYPE,
                          isbSociedad      IN ldci_activoencurso.sociedad%TYPE
                          ) IS
    /********************************************************************************
    PROPIEDAD INTELECTUAL DE SURTIGAS.
    PROCEDURE:   borraRegistro
    DESCRIPCION: borra un registro de activo fijo en curso.

    PARAMETROS DE ENTRADA: ivacodigo_activo => Activo fijo
                           ivasubnumero     => Subnumero
    PARAMETROS DE SALIDA:  Ninguno
    RETORNOS:              Ninguno

    AUTOR:      Jorge Mario Galindo - ArquitecSoft
    FECHA:      05/03/2014

    HISTORIA DE MODIFICACIONES
    FECHA       AUTOR   CASO        MODIFICACION
    10/06/2025  jpinedc OSF-4558    Se agrega argumento de entrada isbSociedad
    ********************************************************************************/
  BEGIN
    DELETE FROM ldci_activoencurso
     WHERE codigo_activo = ivacodigo_activo
       AND subnumero = ivasubnumero
       AND sociedad = isbSociedad;

  EXCEPTION
    WHEN no_data_found THEN
      ldci_pkInterfazSAP.vaMensError :=  '[fnuGetTipoTrab] - No se pudo obtener el tipo_trab '||sqlerrm||' '||DBMS_UTILITY.format_error_backtrace;
   END borraRegistro;

  PROCEDURE borraRowid(irirowid ROWID) IS
    /********************************************************************************
    PROPIEDAD INTELECTUAL DE SURTIGAS.
    PROCEDURE:   borraRowid
    DESCRIPCION: borra un registro de activo fijo en curso por rowid.

    PARAMETROS DE ENTRADA: irirowid => Rowid del activo Fijo
    PARAMETROS DE SALIDA:  Ninguno
    RETORNOS:              Ninguno

    AUTOR:      Jorge Mario Galindo - ArquitecSoft
    FECHA:      05/03/2014

    HISTORIA DE MODIFICACIONES
    FECHA         AUTOR    MODIFICACION

    ********************************************************************************/
  BEGIN
    DELETE FROM ldci_activoencurso WHERE ROWID = irirowid;

  EXCEPTION
    WHEN no_data_found THEN
      ldci_pkInterfazSAP.vaMensError :=  '[fnuGetTipoTrab] - No se pudo obtener el tipo_trab '||sqlerrm||' '||DBMS_UTILITY.format_error_backtrace;
  END;

  PROCEDURE proConsuWSActivoFijo(codActivo ldci_activoencurso.codigo_activo%TYPE,
                                 codSubnum ldci_activoencurso.subnumero%TYPE,
                                 sociedad  ldci_activoencurso.sociedad%TYPE,
                                 descripci ldci_activoencurso.texto_breve%TYPE)
    /********************************************************************************
    PROPIEDAD INTELECTUAL DE SURTIGAS.
    PROCEDURE:   proConsuWSActivoFijo
    DESCRIPCION: Logica para la actualizacion de un activo fijo en curso.

    PARAMETROS DE ENTRADA: codActivo => Codigo Activo en Curso
                           codSubnum => Codigo Subnumero
                           sociedad  => Sociedad
                           descripci => Descripcion Breve
    PARAMETROS DE SALIDA:  Ninguno
    RETORNOS:              Ninguno

    AUTOR:      Jorge Mario Galindo - ArquitecSoft
    FECHA:      05/03/2014

    HISTORIA DE MODIFICACIONES
    FECHA         AUTOR    MODIFICACION

    ********************************************************************************/
  IS

    --<<
    -- Parametros
    -->>
    sbError   VARCHAR2(2000);
    nuError   NUMBER := -1;

    --<<
    -- Subtipo
    -->>
    vStbrcLdc_ActivoEnCurso    ldci_pkgActivoEnCurso.stbLdc_ActivoEnCurso;


  BEGIN

    --<<
    -- Se valida si el codigo de activo en curso pasado
    -- por parametro de entrada existe
    -->>
    IF (ldci_pkgActivoEnCurso.fboExiste(ivacodigo_activo => codActivo, ivasubnumero => codSubnum, isbSociedad => sociedad))THEN

       --<<
       -- Se actualiza el texto Breve
       -->>
       ldci_pkgActivoEnCurso.ActTexto_Breve(ivacodigo_activo => codActivo,
                                           ivasubnumero     => codSubnum,
                                           isbSociedad => sociedad,
                                           ivatexto_breve   => descripci);

    ELSE

       --<<
       -- Seteo los datos del activo en curso a insertar
       -->>
       vStbrcLdc_ActivoEnCurso.Codigo_Activo := codActivo;
       vStbrcLdc_ActivoEnCurso.Subnumero     := codSubnum;
       vStbrcLdc_ActivoEnCurso.Sociedad      := sociedad;
       vStbrcLdc_ActivoEnCurso.Texto_Breve   := descripci;

       --<<
       -- Inserto el Activo Fijo en Curso
       -->>
       ldci_pkgActivoEnCurso.insertaregistro(ircldc_activoencurso => vStbrcLdc_ActivoEnCurso);

    END IF;

    --<<
    -- Guardo los cambios
    -->>
    COMMIT;

  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
ldci_pkInterfazSAP.vaMensError :=  '[fnuGetTipoTrab] - No se pudo obtener el tipo_trab '||sqlerrm||' '||DBMS_UTILITY.format_error_backtrace;
  END proConsuWSActivoFijo;

END LDCI_PKGACTIVOENCURSO;
/

PROMPT Otorgando permisos de ejecucion a LDCI_PKGACTIVOENCURSO
BEGIN
  pkg_utilidades.prAplicarPermisos('LDCI_PKGACTIVOENCURSO','ADM_PERSON');
END;
/

GRANT EXECUTE on ADM_PERSON.LDCI_PKGACTIVOENCURSO to INTEGRACIONES;
GRANT EXECUTE on ADM_PERSON.LDCI_PKGACTIVOENCURSO to INTEGRADESA;
/

