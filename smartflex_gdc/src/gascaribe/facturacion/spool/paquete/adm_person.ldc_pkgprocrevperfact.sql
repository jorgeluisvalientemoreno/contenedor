CREATE OR REPLACE PACKAGE adm_person.ldc_pkgprocrevperfact
IS
    /*****************************************************************

    Unidad         : ldc_pkgprocrevperfact
    Descripcion    : Paquete con la lógica de negocio de RP el Spool de Gas Caribe
    Autor          :
    Fecha          : 16/03/2022

    Historia de Modificaciones
    Fecha         Autor               Modificacion
    -------------------------------------------------
    16/03/2022    Horbath           OSF-144. Creación
    24/10/2023    jpinedc-MVM       OSF-1701:
                                    * fnuEdadCertificadoSpoolSpool: Creación
                                    * frcConfMensRP: Creación
                                    * pInsUpdRegNotiRP: Creación
                                    * RfDatosRevision: Modificación
    26/06/2024     Adrianavg        OSF-2883: Migrar del esquema OPEN al esquema ADM_PERSON
    ******************************************************************/

    FUNCTION fsbversion
        RETURN VARCHAR2;

    FUNCTION LDC_GETFECHMAXIMARP (inuProducto IN servsusc.sesunuse%TYPE)
        RETURN DATE;

    FUNCTION LDC_GETFECHSUSPRP (inuProducto IN servsusc.sesunuse%TYPE)
        RETURN DATE;

    PROCEDURE rfdatosrevision (orfcursor OUT CONSTANTS_PER.TYREFCURSOR);

    FUNCTION fnuEdadCertificadoSpool( inuProducto number)
    RETURN NUMBER;

    FUNCTION frcConfMensRP ( inuEdadCertificado NUMBER )
    RETURN LDC_CONFIMENSRP%ROWTYPE;

    PROCEDURE pInsUpdRegNotiRP
    (
        inuproducto NUMBER,
        inuContrato NUMBER,
        inuperiodo  NUMBER,
        inuEdadProd NUMBER
    );

END ldc_pkgprocrevperfact;
/
CREATE OR REPLACE PACKAGE BODY adm_person.ldc_pkgprocrevperfact
IS
    ----------------------------------------------------------------------
    -- Constantes
    ----------------------------------------------------------------------
    csbVersion              CONSTANT VARCHAR2 (50) := 'OSF-1701';

    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;

    nuMesesRevision     NUMBER := dald_parameter.fnuGetNumeric_Value('LDC_MESES_VALIDEZ_CERT');

    /**************************************************************************
    Funcion     :   fsbVersion
    Descripcion :   Retorna la versión del paquete
    Autor       :   IBecerra.horbath

    Historia de Modificaciones
    Fecha               Autor              Modificacion
    =========           =========          ====================
    16/03/2022          IBecerra.horbath   Creacion
    **************************************************************************/
    FUNCTION fsbVersion
        RETURN VARCHAR2
    IS
    BEGIN
        pkErrors.push ('ldc_pkgprocrevperfact.fsbVersion');
        pkErrors.pop;
        RETURN csbVersion;
    END fsbVersion;

    /**************************************************************************
   Unidad         : fnuGetProducto
      Descripcion    : Obtiene el producto asociado a la factura

      Parametros              Descripcion
      ============         ===================
      inuFactura          Id de la factura

      Fecha             Autor             Modificacion
      =========       =========           ====================
      16/03/2022      IBecerra.Horbath    Creacion
 **************************************************************************/
    FUNCTION fnuGetProducto (inuFactura IN factura.factcodi%TYPE)
        RETURN NUMBER
    IS
        csbMetodo        CONSTANT VARCHAR2(100) := ' ldc_pkgprocrevperfact.fnuGetProducto';

        nuSesunuse   servsusc.sesunuse%TYPE;

        CURSOR cuProducto IS
        SELECT sesunuse
        FROM servsusc, cuencobr
        WHERE sesunuse = cuconuse
        AND cucofact = inuFactura
        AND sesuserv = dald_parameter.fnuGetNumeric_Value ('COD_SERV_GAS')
        AND ROWNUM = 1;

        CURSOR cuCuCoNuSE
        IS
        SELECT cuconuse
        FROM cuencobr
        WHERE cucofact = inuFactura
        AND ROWNUM = 1;

        nuError     NUMBER;
        sbError     VARCHAR2(4000);

        PROCEDURE pCierraCursores
        IS
            csbMetodo1        CONSTANT VARCHAR2(100) := ' ldc_pkgprocrevperfact.fnuGetProducto.pCierraCursores';
        BEGIN

            pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbINICIO);

            IF cuProducto%ISOPEN THEN
                CLOSE cuProducto;
            END IF;

           IF cuCuCoNuSE%ISOPEN THEN
                CLOSE cuCuCoNuSE;
            END IF;

            pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbFIN);

        END pCierraCursores;

    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        pkg_Traza.trace ('inuFactura: ' || inuFactura, csbNivelTraza);

        pCierraCursores;

        -- Inicialmente se consulta si tiene producto de GAS
        OPEN cuProducto;
        FETCH cuProducto INTO nuSesunuse;
        CLOSE cuProducto;

        nuSesunuse := NVL( nuSesunuse, -1 );

        -- Si no tiene producto de GAS se selecciona cualquier producto del contrato
        IF (nuSesunuse = -1 )
        THEN

            OPEN cuCuCoNuSE;
            FETCH cuCuCoNuSE INTO nuSesunuse;
            CLOSE cuCuCoNuSE;

            nuSesunuse := NVL( nuSesunuse, 0);

        END IF;

        pkg_Traza.trace ('nuSesunuse: ' || nuSesunuse, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

        RETURN nuSesunuse;

    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pCierraCursores;
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pCierraCursores;
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
            RAISE pkg_error.Controlled_Error;
    END fnuGetProducto;

    /*****************************************************************
      Unidad         : LDC_GETFECHMAXIMARP
      Descripcion    : Retorna la fecha máxima de certificado

      Parametros              Descripcion
      ============         ===================
      inuProducto          Id del producto

      Fecha             Autor             Modificacion
      =========       =========           ====================
      16/03/2022      IBecerra.Horbath    Creacion
      ******************************************************************/
    FUNCTION LDC_GETFECHMAXIMARP (inuProducto IN servsusc.sesunuse%TYPE)
        RETURN DATE
    IS

        csbMetodo        CONSTANT VARCHAR2(100) := ' ldc_pkgprocrevperfact.LDC_GETFECHMAXIMARP';

        dtFechaMax   DATE;

        nuError     NUMBER;
        sbError     VARCHAR2(4000);

        CURSOR cuFechaMax (producto_id LDC_PLAZOS_CERT.id_producto%TYPE)
        IS
            SELECT TRUNC (plazo_maximo)
              FROM LDC_PLAZOS_CERT
             WHERE id_producto = producto_id;

        PROCEDURE pCierraCursores
        IS
            csbMetodo1        CONSTANT VARCHAR2(100) := ' ldc_pkgprocrevperfact.LDC_GETFECHMAXIMARP.pCierraCursores';
        BEGIN

            pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbINICIO);

            IF cuFechaMax%ISOPEN THEN
                CLOSE cuFechaMax;
            END IF;

            pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbFIN);

        END pCierraCursores;

    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);

        pkg_Traza.trace ('inuProducto: ' || inuProducto, csbNivelTraza);

        pCierraCursores;

        IF inuProducto IS NOT NULL
        THEN

            OPEN cuFechaMax (inuProducto);
            FETCH cuFechaMax INTO dtFechaMax;
            CLOSE cuFechaMax;

            pkg_Traza.trace ( 'dtFechaMax: ' || TO_CHAR (dtFechaMax, 'dd/mm/yyyy'), csbNivelTraza);

        END IF;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

        RETURN dtFechaMax;

    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pCierraCursores;
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            RETURN NULL;
        WHEN OTHERS THEN
            pkg_error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pCierraCursores;
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
            RETURN NULL;
    END ldc_getFechMaximaRP;


    /*****************************************************************
      Unidad         : LDC_GETFECHSUSPRP
      Descripcion    : Retorna la fecha máxima de certificado

      Parametros              Descripcion
      ============         ===================
      inuProducto          Id del producto

      Fecha             Autor             Modificacion
      =========       =========           ====================
      16/03/2022      IBecerra.Horbath    Creacion
      ******************************************************************/
    FUNCTION LDC_GETFECHSUSPRP (inuProducto IN servsusc.sesunuse%TYPE)
        RETURN DATE
    IS

        csbMetodo        CONSTANT VARCHAR2(100) := ' ldc_pkgprocrevperfact.LDC_GETFECHSUSPRP';

        dtFechaMax      DATE;
        nuDiasNoti      ld_parameter.numeric_value%TYPE;

        nuError         NUMBER;
        sbError         VARCHAR2(4000);

        CURSOR cuFechaMax (producto_id LDC_PLAZOS_CERT.id_producto%TYPE)
        IS
        SELECT TRUNC (plazo_maximo)
        FROM LDC_PLAZOS_CERT
        WHERE id_producto = producto_id;

        PROCEDURE pCierraCursores
        IS
            csbMetodo1        CONSTANT VARCHAR2(100) := ' ldc_pkgprocrevperfact.LDC_GETFECHSUSPRP.pCierraCursores';
        BEGIN

            pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbINICIO);

            IF cuFechaMax%ISOPEN THEN
                CLOSE cuFechaMax;
            END IF;

            pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbFIN);

        END pCierraCursores;

    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);

        pkg_Traza.trace ('inuProducto: ' || inuProducto, 2);

        nuDiasNoti := dald_parameter.fnuGetNumeric_Value ('NUM_DIAS_NOTIFICAR_RP');
        pkg_Traza.trace ('nuDiasNoti: ' || nuDiasNoti, 2);

        pCierraCursores;

        IF inuProducto IS NOT NULL
        THEN
            OPEN cuFechaMax (inuProducto);
            FETCH cuFechaMax INTO dtFechaMax;
            CLOSE cuFechaMax;

            IF dtFechaMax IS NOT NULL
            THEN
                dtFechaMax := dtFechaMax - nuDiasNoti;
            END IF;
        END IF;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

        RETURN dtFechaMax;

    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pCierraCursores;
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            RETURN NULL;
        WHEN OTHERS THEN
            pkg_error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pCierraCursores;
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
            RETURN NULL;
    END LDC_GETFECHSUSPRP;

    /**************************************************************************
    Procedimiento :   RfDatosRevision
    Descripcion   :   Obtiene los mensajes de RP para spool de facturación
    Autor         :   IBecerra.horbath

    Historia de Modificaciones
    Fecha               Autor              Modificacion
    =========           =========          ====================
    16/03/2022          IBecerra.horbath   Creacion
    24/10/2023          jpinedc-MVM         OSF-1701:
                                            *   Se usan fnuEdadCertificadoSpool,
                                                frcConfMensRP y pInsUpdRegNotiRP
    **************************************************************************/

    PROCEDURE RfDatosRevision (orfcursor OUT CONSTANTS_PER.TYREFCURSOR)
    IS

        csbMetodo        CONSTANT VARCHAR2(100) := ' ldc_pkgprocrevperfact.RfDatosRevision';

        sbFactcodi        ge_boInstanceControl.stysbValue;
        FECH_MAXIMA       VARCHAR2 (50);
        FECH_SUSP         VARCHAR2 (50);
        TIPO_NOTI         NUMBER;
        MENS_NOTI         VARCHAR2 (2000);

        nuEdadProd        NUMBER (4);
        nuProducto        NUMBER;

        nuError           NUMBER;
        sbError           VARCHAR2(4000);

        CURSOR cuObtProductoGas (nuFactura NUMBER)
        IS
            SELECT sesunuse
              FROM factura f, servsusc p
             WHERE     f.factsusc = p.sesususc
                   AND f.factcodi = nuFactura
                   AND p.sesuserv =
                       dald_parameter.fnuGetNumeric_Value ('COD_SERV_GAS');

        --se valida tipo de notifica
        CURSOR cuValidaNoti (sbTipodeNoti VARCHAR2)
        IS
            SELECT 'X'
              FROM (    SELECT TO_NUMBER (REGEXP_SUBSTR (sbTipodeNoti,
                                                         '[^,]+',
                                                         1,
                                                         LEVEL))    tipo_not
                          FROM DUAL
                    CONNECT BY REGEXP_SUBSTR (sbTipodeNoti,
                                              '[^,]+',
                                              1,
                                              LEVEL)
                                   IS NOT NULL)
             WHERE tipo_not = TIPO_NOTI;

        sbNombProga       VARCHAR2 (4000)
            := dald_parameter.fsbGetValue_Chain ('LDC_NOPRSPOOL', NULL); --se almacena los programas a tener en cuenta
        sbProgEjec        VARCHAR2 (100);  --se almacena programa en ejecucion
        sbDatoProg        VARCHAR2 (1); --se almacena resultado de la validacion del programa
        nuContrato        servsusc.sesususc%TYPE;       --se almacena contrato
        sbCumplReq        VARCHAR2 (1) := 'N'; --se almacena si se esta ejecutando el spool y la entrega aplica
        nuperiodo         NUMBER;         --se almacena periodo de facturacion

        --se valida si el programa esta configurado
        CURSOR cuValidaProg IS
            SELECT 'X'
              FROM (    SELECT TRIM (REGEXP_SUBSTR (sbNombProga,
                                                    '[^,]+',
                                                    1,
                                                    LEVEL))    programa
                          FROM DUAL
                    CONNECT BY REGEXP_SUBSTR (sbNombProga,
                                              '[^,]+',
                                              1,
                                              LEVEL)
                                   IS NOT NULL)
             WHERE programa = sbProgEjec;

        --se obtiene informacion de la factura
        CURSOR cuInforFactura IS
            SELECT factpefa, factsusc
              FROM factura f
             WHERE f.factcodi = TO_NUMBER (sbFactcodi);

        rcConfMensRP      LDC_CONFIMENSRP%ROWTYPE;

        PROCEDURE pCierraCursores
        IS
            csbMetodo1        CONSTANT VARCHAR2(100) := ' ldc_pkgprocrevperfact.RfDatosRevision.pCierraCursores';
        BEGIN

            pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbINICIO);

            IF cuObtProductoGas%ISOPEN THEN
                CLOSE cuObtProductoGas;
            END IF;

            IF cuValidaNoti%ISOPEN THEN
                CLOSE cuValidaNoti;
            END IF;

            IF cuValidaProg%ISOPEN THEN
                CLOSE cuValidaProg;
            END IF;

            IF cuInforFactura%ISOPEN THEN
                CLOSE cuInforFactura;
            END IF;

            IF orfcursor%ISOPEN THEN
                CLOSE orfcursor;
            END IF;

            pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbFIN);

        END pCierraCursores;

    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);

        -- Obtiene el identificador de la factura instanciada
        sbFactcodi := API_OBTENERVALORINSTANCIA ('FACTURA', 'FACTCODI');

        pCierraCursores;

        -- Se obtiene el producto gas asociado al contrato de la factura CA200-1081
        OPEN cuObtProductoGas (sbFactcodi);
        FETCH cuObtProductoGas INTO nuProducto;
        CLOSE cuObtProductoGas;

        --Fin CA200-1081

        sbProgEjec := PKG_SESSION.FSBOBTENERMODULO; --se obtiene programa en ejecucion

        --se valida si el programa en ejecucion esta configurado
        OPEN cuValidaProg;
        FETCH cuValidaProg INTO sbDatoProg;

        IF cuValidaProg%FOUND
        THEN
            sbCumplReq := 'S';
        END IF;

        CLOSE cuValidaProg;

        nuEdadProd := fnuEdadCertificadoSpool( nuProducto );

        FECH_MAXIMA := NULL;
        FECH_SUSP := NULL;

        rcConfMensRP := frcConfMensRP(nuEdadProd);

        -- En caso que la configuración indique que se imprime la fecha máxima
        IF (rcConfMensRP.MERPIMFM = 'S')
        THEN
            FECH_MAXIMA :=
                TO_CHAR (LDC_GETFECHMAXIMARP (nuProducto),
                         'DD Month YYYY',
                         'nls_date_language=spanish');
        END IF;

        -- En caso que la configuración indique que se imprime la fecha de suspensión
        IF (rcConfMensRP.MERPIMFS = 'S')
        THEN
            FECH_SUSP :=
                TO_CHAR (LDC_GETFECHSUSPRP (nuProducto),
                         'DD Month YYYY',
                         'nls_date_language=spanish');
        END IF;

        IF TRUNC (
               TO_DATE (FECH_MAXIMA,
                        'DD Month YYYY',
                        'nls_date_language=spanish')) <
           TRUNC (SYSDATE)
        THEN
            FECH_SUSP := 'INMEDIATO';
        END IF;


        -- Si imprime carta y está en ejecución el proceso FIDF
        IF ((rcConfMensRP.MERPIMCN = 'S') AND (sbCumplReq = 'S'))
        THEN

            nuperiodo := NULL;
            nuContrato := NULL;

            --se carga informacion de la factura
            OPEN cuInforFactura;
            FETCH cuInforFactura INTO nuperiodo, nuContrato;
            CLOSE cuInforFactura;

            pInsUpdRegNotiRP
                (
                    nuProducto,
                    nuContrato,
                    nuperiodo,
                    nuEdadProd
                );

        END IF;

        TIPO_NOTI := rcConfMensRP.MERPTINO;
        MENS_NOTI := rcConfMensRP.MERPMENS;

        OPEN orfcursor FOR
            SELECT TIPO_NOTI     TIPO_NOTI,
                   MENS_NOTI     MENS_NOTI,
                   FECH_MAXIMA,
                   FECH_SUSP
              FROM DUAL;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pCierraCursores;
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pCierraCursores;
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
            RAISE pkg_error.Controlled_Error;
    END RfDatosRevision;

    /**************************************************************************
    Procedimiento :   fnuEdadCertificadoSpool
    Descripcion   :   Retorna la edad en meses del certificado de la red interna
    Autor         :   jpinedc.MVM

    Historia de Modificaciones
    Fecha               Autor              Modificacion
    =========           =========          ====================
    24/10/2023          jpinedc-MVM         OSF-1701: Creación
    **************************************************************************/
    FUNCTION fnuEdadCertificadoSpool( inuProducto number)
    RETURN NUMBER
    IS

        csbMetodo        CONSTANT VARCHAR2(100) := ' ldc_pkgprocrevperfact.fnuEdadCertificadoSpool';

        nuEdadCertificado   NUMBER;

        nuError         NUMBER;
        sbError         VARCHAR2(4000);

        CURSOR cuEdad
        IS
        SELECT nuMesesRevision -
               months_between(trunc(to_date(nvl(plazo_maximo,
                                                  sesufein +
                                                  nuMesesRevision * 365 / 12)),
                                      'MONTH'),
                                trunc(SYSDATE, 'MONTH'))
        FROM LDC_PLAZOS_CERT, servsusc
        WHERE id_producto = inuProducto
        AND sesunuse = id_producto;

        PROCEDURE pCierraCursores
        IS
            csbMetodo1        CONSTANT VARCHAR2(100) := ' ldc_pkgprocrevperfact.fnuEdadCertificadoSpool.pCierraCursores';
        BEGIN

            pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbINICIO);

            IF cuEdad%ISOPEN THEN
                CLOSE cuEdad;
            END IF;

            pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbFIN);

        END pCierraCursores;

    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);

        pCierraCursores;

        OPEN cuEdad;
        FETCH cuEdad INTO nuEdadCertificado;
        CLOSE cuEdad;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

        RETURN nuEdadCertificado;

    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pCierraCursores;
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pCierraCursores;
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
            RAISE pkg_error.Controlled_Error;
    END fnuEdadCertificadoSpool;

    /**************************************************************************
    Procedimiento :   frcConfMensRP
    Descripcion   :   Retorna un registro con la configuración de notificaciones
                      según la edad del certificado
    Autor         :   jpinedc.MVM

    Historia de Modificaciones
    Fecha               Autor              Modificacion
    =========           =========          ====================
    24/10/2023          jpinedc-MVM         OSF-1701: Creación
    **************************************************************************/
    FUNCTION frcConfMensRP ( inuEdadCertificado NUMBER )
    RETURN LDC_CONFIMENSRP%ROWTYPE
    IS

        csbMetodo           CONSTANT VARCHAR2(100) := 'ldc_pkgprocrevperfact.frcConfMensRP';

        nuError             NUMBER;
        sbError             VARCHAR2(4000);

        --Se obtiene la información de la configuración por edad de certificación
        CURSOR cuConfMensRP (nuEdad IN NUMBER)
        IS
            SELECT *
              FROM LDC_CONFIMENSRP
             WHERE nuEdad BETWEEN MERPEDIN AND MERPEDFI;

        rcConfMensRP      LDC_CONFIMENSRP%ROWTYPE;

        PROCEDURE pCierraCursores
        IS
            csbMetodo1        CONSTANT VARCHAR2(100) := ' ldc_pkgprocrevperfact.frcConfMensRP.pCierraCursores';
        BEGIN

            pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbINICIO);

            IF cuConfMensRP%ISOPEN THEN
                CLOSE cuConfMensRP;
            END IF;

            pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbFIN);

        END pCierraCursores;

    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);

        pCierraCursores;

        OPEN cuConfMensRP( inuEdadCertificado );
        FETCH cuConfMensRP INTO rcConfMensRP;
        CLOSE cuConfMensRP;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

        RETURN rcConfMensRP;

    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pCierraCursores;
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pCierraCursores;
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
            RAISE pkg_error.Controlled_Error;
    END frcConfMensRP;

    /**************************************************************************
    Procedimiento :   pInsUpdRegNotiRP
    Descripcion   :   Inserta o actualiza un registro en LDC_INFOPRNORP
    Autor         :   jpinedc.MVM

    Historia de Modificaciones
    Fecha               Autor              Modificacion
    =========           =========          ====================
    24/10/2023          jpinedc-MVM         OSF-1701: Creación
    **************************************************************************/
    PROCEDURE pInsUpdRegNotiRP
    (
        inuproducto NUMBER,
        inuContrato NUMBER,
        inuperiodo  NUMBER,
        inuEdadProd NUMBER
    )
    IS

        csbMetodo           CONSTANT VARCHAR2(100) := 'ldc_pkgprocrevperfact.pInsUpdRegNotiRP';

        nuOrdeImpr        LDC_INFOPRNORP.INPNORIM%TYPE; --Se almacena orden de impresion
        nuOrdeEntre       LDC_INFOPRNORP.INPNOREC%TYPE; --Se almacena orden de entrega de carta

        nuError           NUMBER;
        sbError           VARCHAR2(4000);

        --Se valida si ya existe registro de informacion para el mismo periodo
        CURSOR cuExisteReg IS
            SELECT INPNORIM, INPNOREC
              FROM LDC_INFOPRNORP
             WHERE INPNSESU = inuProducto AND INPNPEFA = inuperiodo;

        PROCEDURE pCierraCursores
        IS
            csbMetodo1        CONSTANT VARCHAR2(100) := ' ldc_pkgprocrevperfact.pInsUpdRegNotiRP.pCierraCursores';
        BEGIN

            pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbINICIO);

            IF cuExisteReg%ISOPEN THEN
                CLOSE cuExisteReg;
            END IF;

            pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbFIN);

        END pCierraCursores;

    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);

        pCierraCursores;

        --se valida si existe registro
        OPEN cuExisteReg;
        FETCH cuExisteReg INTO nuOrdeImpr, nuOrdeEntre;
        IF cuExisteReg%NOTFOUND
        THEN
            INSERT INTO LDC_INFOPRNORP (INPNSESU,
                                        INPNSUSC,
                                        INPNPEFA,
                                        INPNMERE,
                                        INPNFERE)
                 VALUES (inuproducto,
                         inuContrato,
                         inuperiodo,
                         inuEdadProd,
                         SYSDATE);
        ELSE
            IF nuOrdeImpr IS NULL AND nuOrdeEntre IS NULL
            THEN
                UPDATE LDC_INFOPRNORP
                   SET INPNMERE = inuEdadProd, INPNFERE = SYSDATE
                 WHERE INPNSESU = inuproducto AND INPNPEFA = inuperiodo;
            END IF;
        END IF;

        CLOSE cuExisteReg;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pCierraCursores;
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pCierraCursores;
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
            RAISE pkg_error.Controlled_Error;
    END pInsUpdRegNotiRP;

END LDC_PKGPROCREVPERFACT;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre LDC_PKGPROCREVPERFACT
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_PKGPROCREVPERFACT', 'ADM_PERSON'); 
END;
/