create or replace PACKAGE adm_person.LDC_UISOLXML
IS
    /**********************************************************************************
        Propiedad intelectual de CSC. (C).

        Package     : LDC_UISOLXML
        Descripci?n : Paquete con la logica de generacion de tramites por XML
                      utilizando un archivo plano.

        Autor     : Manuel Mejia
        Fecha     : 15-03-2017

        Historia de Modificaciones
        DD-MM-YYYY      <Autor>                 Modificaci?n
        -----------     -------------------     -------------------------------------
        15-03-2017      Mmejia                  Creaci?n.
        22-09-2020      ESANTIAGO(HORBATH)      CA:502 se modifica procedimiento PROCESS
        02/01/2024      JSOTO                   OSF-2005:
                                               -Ajustes cambio en llamado a algunos de los objetos de producto por personalizados
                                               -Ajuste  cambio en manejo de trazas y errores por personalizados (pkg_error y pkg_traza).
                                               -Ajuste llamado a api_registerRequestByXml
                                               -Se suprimen llamado a AplicaEntrega que no se encuentren activos
        10/04/2024      jpinedc                 OSF-2379:       Cambio de utl_file por
                                                pkg_gestionArchivos y ajustes por últimos
                                                estandares de programación
        26/06/2024      PAcosta                 OSF-2878: Cambio de esquema ADM_PERSON                                                
    **********************************************************************************/
    -----------------------------------
    -- Variables privadas del package
    -----------------------------------
    FUNCTION fsbVersion
        RETURN VARCHAR2;

    PROCEDURE BeforeFrame;

    PROCEDURE Process;
END LDC_UISOLXML;
/
create or replace PACKAGE BODY adm_person.LDC_UISOLXML
IS
    /**********************************************************************************
        Propiedad intelectual de CSC. (C).

        Package     : LDC_UISOLXML
        Descripci?n : Paquete con la logica de generacion de tramites por XML
                      utilizando un archivo plano.

        Autor     : Manuel Mejia
        Fecha     : 15-03-2017

        Historia de Modificaciones
        DD-MM-YYYY    <Autor>               Modificaci?n
        -----------  -------------------    -------------------------------------
        15-03-2017     Mmejia              Creaci?n.
     02/01/2024  JSOTO    OSF-2005:
              -Ajustes cambio en llamado a algunos de los objetos de producto por personalizados
              -Ajuste  cambio en manejo de trazas y errores por personalizados (pkg_error y pkg_traza).
              -Ajuste llamado a api_registerRequestByXml
              -Se suprimen llamado a AplicaEntrega que no se encuentren activos
    **********************************************************************************/
    -----------------------------------
    -- Variables privadas del package
    -----------------------------------
    CSBVERSION   CONSTANT VARCHAR2 (10) := 'OSF-2379';
    GSBERRMSG             GE_ERROR_LOG.DESCRIPTION%TYPE;

    -- Constantes para el control de la traza
    csbSP_NAME   CONSTANT VARCHAR2 (35) := $$PLSQL_UNIT || '.';
    cnuNVLTRC    CONSTANT NUMBER (2) := pkg_traza.fnuNivelTrzDef;

    nuCodError            NUMBER;
    sbErrMsg              VARCHAR2 (2000);

    TYPE rcPackage IS RECORD
    (
        sbXMLPackage    constants_per.tipo_xml_sol%TYPE
    );

    SUBTYPE styrcPackage IS rcPackage;

    TYPE tyrcPackage IS TABLE OF styrcPackage
        INDEX BY BINARY_INTEGER;

    vtyrcPackage          tyrcPackage;

    /*****************************************************************
    Propiedad intelectual de CSC. (C).

    Procedure : fsbVersion
    Descripci?n :

    Par?metros : Descripci?n

    Retorno     :

    Autor : Manuel Mejia
    Fecha : 15-03-2017

    Historia de Modificaciones
    Fecha       Autor
    ----------  --------------------
    15-03-2017  Mmejia  Creaci?n.
    *****************************************************************/
    FUNCTION fsbVersion
        RETURN VARCHAR2
    IS
        csbMT_NAME   VARCHAR2 (70) := csbSP_NAME || 'fsbVersion';
    BEGIN
        pkg_traza.trace (csbMT_NAME, cnuNVLTRC, pkg_traza.fsbINICIO);
        pkg_traza.trace (csbMT_NAME, cnuNVLTRC, pkg_traza.fsbFIN);
        RETURN (CSBVERSION);
    EXCEPTION
        WHEN pkg_error.controlled_error
        THEN
            pkg_error.geterror (nuCodError, sbErrMsg);
            pkg_traza.trace (
                'nuCodError: ' || nuCodError || ', sbErrMsg: ' || sbErrMsg,
                cnuNVLTRC);
            pkg_traza.trace (csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);
            RAISE pkg_error.controlled_error;
        WHEN OTHERS
        THEN
            pkg_error.setError;
            pkg_error.geterror (nuCodError, sbErrMsg);
            pkg_traza.trace (
                'nuCodError: ' || nuCodError || ', sbErrMsg: ' || sbErrMsg,
                cnuNVLTRC);
            pkg_traza.trace (csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
            RAISE pkg_error.controlled_error;
    END fsbVersion;

    /*****************************************************************
    Propiedad intelectual de CSC. (C).

    Procedure : BeforeFrame
    Descripci?n :

    Par?metros : Descripci?n

    Retorno     :

    Autor : Manuel Mejia
    Fecha : 15-03-2017

    Historia de Modificaciones
    Fecha       Autor
    ----------  --------------------
    15-03-2017  Mmejia  Creaci?n.
    *****************************************************************/
    PROCEDURE BeforeFrame
    IS
        csbMT_NAME   VARCHAR2 (70) := csbSP_NAME || 'BeforeFrame';
    BEGIN
        pkg_traza.trace (csbMT_NAME, cnuNVLTRC, pkg_traza.fsbINICIO);
        pkg_traza.trace (csbMT_NAME, cnuNVLTRC, pkg_traza.fsbFIN);
    EXCEPTION
        WHEN pkg_error.controlled_error
        THEN
            pkg_error.geterror (nuCodError, sbErrMsg);
            pkg_traza.trace (
                'nuCodError: ' || nuCodError || ', sbErrMsg: ' || sbErrMsg,
                cnuNVLTRC);
            pkg_traza.trace (csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);
            RAISE pkg_error.controlled_error;
        WHEN OTHERS
        THEN
            pkg_error.setError;
            pkg_error.geterror (nuCodError, sbErrMsg);
            pkg_traza.trace (
                'nuCodError: ' || nuCodError || ', sbErrMsg: ' || sbErrMsg,
                cnuNVLTRC);
            pkg_traza.trace (csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
            RAISE pkg_error.controlled_error;
    END BeforeFrame;

    /*****************************************************************
    Propiedad intelectual de CSC. (C).

    Nombre del Paquete: pReadFile
    Descripcion:

    Autor  : Mmejia
    Fecha  : 20-04-2017

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.              Modificacion
    -----------  -------------------    -------------------------------------
    ******************************************************************/
    PROCEDURE pReadFile (vaRuta VARCHAR2, vaNombreArch VARCHAR2)
    IS
        --<<
        -- Variables del proceso
        -->>
        sbDirectory   VARCHAR2 (4000);
        ufarchivo     pkg_gestionArchivos.styArchivo;
        sbLinea       constants_per.tipo_xml_sol%TYPE;
        nuIndex       NUMBER := 1;
        csbMT_NAME    VARCHAR2 (70) := csbSP_NAME || 'pReadFile';
    BEGIN
        pkg_traza.trace (csbMT_NAME, cnuNVLTRC, pkg_traza.fsbINICIO);
        --<<
        -- Inicializacion de variables
        -->>
        sbDirectory := vaRuta;
        pkg_traza.trace ('LDC_UISOLXML.pReadFile directorio OK', cnuNVLTRC);
        ufarchivo :=
            pkg_gestionArchivos.ftAbrirArchivo_SMF (sbDirectory,
                                                    vaNombreArch,
                                                    'r');
        pkg_traza.trace ('LDC_UISOLXML.pReadFile Arhivo abierto OK',
                         cnuNVLTRC);

        vtyrcPackage.DELETE ();

        LOOP
            BEGIN
                sbLinea :=
                    pkg_gestionArchivos.fsbObtenerLinea_SMF (ufarchivo);
            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    EXIT;
            END;

            vtyrcPackage (nuIndex).sbXMLPackage := sbLinea;
            nuIndex := nuIndex + 1;
        END LOOP;

        pkg_gestionArchivos.prcCerrarArchivo_SMF (ufarchivo);
        pkg_traza.trace (csbMT_NAME, cnuNVLTRC, pkg_traza.fsbFIN);
    EXCEPTION
        WHEN pkg_error.controlled_error
        THEN
            pkg_error.geterror (nuCodError, sbErrMsg);
            pkg_traza.trace (
                'nuCodError: ' || nuCodError || ', sbErrMsg: ' || sbErrMsg,
                cnuNVLTRC);
            pkg_traza.trace (csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);
            RAISE pkg_error.controlled_error;
        WHEN OTHERS
        THEN
            pkg_error.setError;
            pkg_error.geterror (nuCodError, sbErrMsg);
            pkg_traza.trace (
                'nuCodError: ' || nuCodError || ', sbErrMsg: ' || sbErrMsg,
                cnuNVLTRC);
            pkg_traza.trace (csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
            RAISE pkg_error.controlled_error;
    END pReadFile;

    /*****************************************************************
    Propiedad intelectual de CSC. (C).

    Procedure : Process
    Descripci?n :

    Par?metros : Descripci?n

    Retorno     :

    Autor : Manuel Mejia
    Fecha : 15-03-2017

    Historia de Modificaciones
    Fecha       Autor
    ----------  --------------------
    15-03-2017  Mmejia  Creaci?n.
 22-09-2020  ESANTIAGO(HORBATH) CA:502 Se agreggo validacion de error generado por el api OS_RegisterRequestWithXML
    *****************************************************************/
    PROCEDURE Process
    IS
        cnuNULL_ATTRIBUTE   CONSTANT NUMBER := 2126;

        sbCOMENTARIO                 ge_boInstanceControl.stysbValue;
        sbDOCUMENTO_EXTERNO          ge_boInstanceControl.stysbValue;
        sbRuta                       LD_PARAMETER.value_chain%TYPE := '';
        nuPackageId                  mo_packages.package_id%TYPE;
        nuErrorCode                  NUMBER;
        sbErrorMessage               VARCHAR2 (4000);
        nuMotiveId                   mo_motive.motive_id%TYPE;
        csbMT_NAME                   VARCHAR2 (70) := csbSP_NAME || 'Process';

        --File
        archiLog                     pkg_gestionArchivos.styArchivo;
        sbNomarcLog                  VARCHAR2 (200);
    BEGIN
        pkg_traza.trace (csbMT_NAME, cnuNVLTRC, pkg_traza.fsbINICIO);

        sbCOMENTARIO :=
            ge_boInstanceControl.fsbGetFieldValue ('GE_ITEMS_DOCUMENTO',
                                                   'COMENTARIO');
        sbDOCUMENTO_EXTERNO :=
            ge_boInstanceControl.fsbGetFieldValue ('GE_ITEMS_DOCUMENTO',
                                                   'DOCUMENTO_EXTERNO');

        ------------------------------------------------
        -- Required Attributes
        ------------------------------------------------

        IF (sbCOMENTARIO IS NULL)
        THEN
            pkg_error.setErrorMessage (cnuNULL_ATTRIBUTE,
                                       'Ruta Archivos (Servidor)');
        END IF;

        IF (sbDOCUMENTO_EXTERNO IS NULL)
        THEN
            pkg_error.setErrorMessage (cnuNULL_ATTRIBUTE,
                                       'Nombre Archivo (con extensi?n)');
        END IF;

        sbRuta := pkg_BCLD_Parameter.fsbObtieneValorCadena ('LDC_RUTA_FILE_EVAC');

        ------------------------------------------------
        -- User code
        ------------------------------------------------
        --Lee el archivo y carga los datos a la tabla PL
        LDC_UISOLXML.pReadFile (sbRuta, sbDOCUMENTO_EXTERNO);

        pkg_traza.trace (
               '  LDC_UISOLXML.Process vtyrcPackage.Count() '
            || vtyrcPackage.COUNT (),
            cnuNVLTRC);

        --Recorre la Tabla Pl de producto leidos
        IF (vtyrcPackage.COUNT > 0)
        THEN
            -->>
            --Se setea el nombre del archivo log
            -->>
            sbNomarcLog :=
                   sbDOCUMENTO_EXTERNO
                || '_'
                || TO_CHAR (SYSDATE, 'DDMMYYYYHH24MISS')
                || '.log';

            --Apertura de archivo de log
            archiLog := pkg_gestionArchivos.ftAbrirArchivo_SMF (sbRuta, sbNomarcLog, 'w');

            --<<
            --recorre las lineas del archivo leidas
            -->>
            FOR nuIndex IN vtyrcPackage.FIRST .. vtyrcPackage.LAST
            LOOP
                --<<
                -- llamado al proceso que ejecuta la generacion de tramite
                -- por archivo plano
                -->>
                api_registerrequestbyxml (
                    vtyrcPackage (nuIndex).sbXMLPackage,
                    nuPackageId,
                    nuMotiveId,
                    nuErrorCode,
                    sbErrorMessage);
                pkg_traza.trace (
                    '  LDC_UISOLXML.Process nuPackageId ' || nuPackageId,
                    cnuNVLTRC);
                pkg_traza.trace (
                       '  LDC_UISOLXML.Process sbErrorMessage '
                    || sbErrorMessage,
                    cnuNVLTRC);

                -- INICIO CASO: 502
                IF sbErrorMessage IS NOT NULL
                THEN
                    ROLLBACK;
                ELSE
                    COMMIT;
                END IF;

                -- FIN CASO: 502


                -->>
                --Registro del mensaje de error en la ruta de log
                -->>
                pkg_gestionArchivos.prcEscribirLinea_SMF (
                    archiLog,
                       'Linea:['
                    || nuIndex
                    || '] nuPackageId:['
                    || nuPackageId
                    || '] nuMotiveId: ['
                    || nuMotiveId
                    || '] ERROR_CODE: ['
                    || nuErrorCode
                    || '] ERROR:['
                    || sbErrorMessage
                    || ']');
            END LOOP;

            --Cierre de archivo
            pkg_gestionArchivos.prcCerrarArchivo_SMF (archiLog);
        END IF;


        pkg_traza.trace (csbMT_NAME, cnuNVLTRC, pkg_traza.fsbFIN);
    EXCEPTION
        WHEN pkg_error.controlled_error
        THEN
            pkg_error.geterror (nuCodError, sbErrMsg);
            pkg_traza.trace (
                'nuCodError: ' || nuCodError || ', sbErrMsg: ' || sbErrMsg,
                cnuNVLTRC);
            pkg_traza.trace (csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);
            RAISE pkg_error.controlled_error;
        WHEN OTHERS
        THEN
            pkg_error.setError;
            pkg_error.geterror (nuCodError, sbErrMsg);
            pkg_traza.trace (
                'nuCodError: ' || nuCodError || ', sbErrMsg: ' || sbErrMsg,
                cnuNVLTRC);
            pkg_traza.trace (csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
            RAISE pkg_error.controlled_error;
    END Process;
END LDC_UISOLXML;
/
PROMPT Otorgando permisos de ejecucion a LDC_UISOLXML
BEGIN
    pkg_utilidades.praplicarpermisos('LDC_UISOLXML', 'ADM_PERSON');
END;
/