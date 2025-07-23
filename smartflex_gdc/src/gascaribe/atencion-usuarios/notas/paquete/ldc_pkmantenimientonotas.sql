CREATE OR REPLACE PACKAGE LDC_PKMANTENIMIENTONOTAS IS
    /***********************************************************
    -- Author  : Sandra Muñoz
    -- Created : 15/04/2016 9:32:52
    -- Purpose : Administra las acciones a realizar en FAJU-MANOT
    Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificación
        -----------  -------------------    ------------------------------------
        25-09-2024      jcatuche            OSF-3332: Se ajustan los métodos
                                                [proInsMantenimientoNotaDet]
                                                [proDetAcreditarConcepto]
                                                [proDetAcreditarConceptoYCC]
                                                [proDetDebitarConceptoYCC]
                                                [proGrabarDebitarConcepto]
                                                [proDetAcreditarCuentaCobro]
                                                [proDetDebitarCuentaCobro]
                                                [proDetAcreditarDeuda]
                                                [fcrConceptosCtaCobro]
                                                [fcrConceptosProducto]
                                                [proGrabar]
                                                [validamonto]
                                                [proDetDebitarConcepto]
                                                                            
                                            A nivel general se estandariza la traza y el manejo de errores, se crean cursores para llamados Select INTO, se se cambian los llamados
                                            PKCONSTANTE.TYREFCURSOR por CONSTANTS_PER.TYREFCURSOR, GE_BOPERSONAL.FNUGETPERSONID por PKG_BOPERSONAL.FNUGETPERSONAID,
                                            OS_QUERYPRODDEBTBYCONC por API_QUERYPRODDEBTBYCONC, DAPR_PRODUCT.FNUGETSUBSCRIPTION_ID por PKG_BCPRODUCTO.FNUCONTRATO [adecuación
                                            para control de error], DALD_PARAMETER.FNUGETNUMERIC_VALUE por PKG_BCLD_PARAMETER.FNUOBTIENEVALORNUMERICO, DALD_PARAMETER.FSBGETVALUE_CHAIN por
                                            PKG_BCLD_PARAMETER.FSBOBTIENEVALORCADENA, SA_BOUSER.FNUGETUSERID por PKG_SESSION.GETUSERID, USER por PKG_SESSION.GETUSER, DAPR_PRODUCT.FNUGETPRODUCT_STATUS_ID por 
                                            PKG_BCPRODUCTO.FNUESTADOPRODUCTO [adecuación para control de error], PKCONSTANTE.SI por CONSTANTS_PER.CSBSI, PKTBLSERVSUSC.FNUGETSERVICE por PKG_BCPRODUCTO.FNUTIPOPRODUCTO
                                            
                                            Se crea nueva constante csbNotaProg para almacenar el programa de las notas
                                            Se crea nuevo procedimiento interno para registro de auditoria
                                                [prRegistraAuditoria]
                                                
                                            Se elimina el procedimiento interno
                                                [proPlantilla]
        29-04-2024      jcatuche            OSF-3206 Se ajustan los métodos
                                                [proDetDebitarConcepto]
                                                [proGrabarDebitarConcepto]
        09-08-2023   diana.montes           OSF-1343: Se ajusta procedimientos
                                            [proProyAcreditarDeuda]
                                            [proDetAcreditarDeuda]
                                            [proDetAcreditarCuentaCobro]
                                            [proProyAcreditarCuentaCobro]
                                            [proDetAcreditarConceptoYCC]
                                            [proDetDebitarConceptoYCC]
                                            [proProyAcreditarConceptoYCC]
                                            se ajustan las excepciones de WHEN OTHERS
                                            y Dbms_Output.Put_Line
        13-06-2023   diana.montes           OSF-1117: Se ajusta procedimientos
                                            [proGrabarDebitarConcepto]
        28-10-2022   jcatuchemvm            OSF-637: Se ajusta procedimientos
                                                [proGrabar]
                                                [proGrabarDebitarConcepto]
        15-04-2016   Sandra Muñoz           Creación
    ***********************************************************/
    ------------------------------------------------------------------------------------------------
    -- Listas de valores
    ------------------------------------------------------------------------------------------------
    FUNCTION fcnconcepnoacredit RETURN CONSTANTS_PER.TYREFCURSOR;
    FUNCTION fcrCtasCobroProducto(inuProducto LDC_MANTENIMIENTO_NOTAS_PROY.producto%TYPE)
        RETURN CONSTANTS_PER.TYREFCURSOR;

    FUNCTION fcrConceptosCtaCobro(inuCuentaCobro ldc_mantenimiento_notas_enc.cuenta_cobro%TYPE)
        RETURN CONSTANTS_PER.TYREFCURSOR;

    FUNCTION fcrConceptosProducto
    (
        inuProducto ldc_mantenimiento_notas_enc.producto%TYPE,
        isbnovedad  VARCHAR2
    )
    --FUNCTION fcrConceptosProducto(inuProducto ldc_mantenimiento_notas_enc.producto%TYPE)
     RETURN CONSTANTS_PER.TYREFCURSOR;

    FUNCTION fcrPlanesFinanciacion
    (
        inuNroCuotas ldc_mantenimiento_notas_enc.cuotas%TYPE,
        inuservicio  servicio.servcodi%TYPE
    ) RETURN CONSTANTS_PER.TYREFCURSOR;

    FUNCTION fnutraePIva
    (
        inuconcepto concepto.conccodi%TYPE, -- Solicitud
        inuserv     servsusc.sesuserv%TYPE -- Usuario que registra
    ) RETURN NUMBER;

    ------------------------------------------------------------------------------------------------
    -- Calculos
    ------------------------------------------------------------------------------------------------
    PROCEDURE proDeudaProducto
    (
        inuProducto pr_product.product_id%TYPE, -- Producto
        onuDeuda    OUT NUMBER, -- Deuda del producto
        osbError    OUT VARCHAR2
    );

    PROCEDURE proDeudaConceptoReal
    (
        inuProducto pr_product.product_id%TYPE, -- Producto
        inuConcepto concepto.conccodi%TYPE, -- Concepto
        onuDeuda    OUT NUMBER,
        osbError    OUT VARCHAR2
    );

    PROCEDURE proDeudaConceptoCC
    (
        inuCuenCobr      cuencobr.cucocodi%TYPE, -- Codigo de la cuenta de cobro
        inuConcepto      concepto.conccodi%TYPE, -- Concepto
        onuSaldoConcepto OUT cargos.cargvalo%TYPE, -- Saldo del concepto
        osbError         OUT VARCHAR2 -- Error
    );

    PROCEDURE proDeudaCuentaCobro
    (
        inuProducto      IN pr_product.product_id%TYPE,
        inuCuenCobr      IN cuencobr.cucocodi%TYPE,
        onuSaldoCuenCobr OUT cuencobr.cucosacu%TYPE,
        osbError         OUT VARCHAR2
    );

    ------------------------------------------------------------------------------------------------
    -- Proyeccion
    ------------------------------------------------------------------------------------------------

    PROCEDURE proMostrarProyectado
    (
        inuProducto                   ldc_mantenimiento_notas_proy.producto%TYPE,
        ocrLDC_MANTENIMIENTO_NOTAS_PR OUT CONSTANTS_PER.TYREFCURSOR,
        osbError                      OUT VARCHAR2
    );

    PROCEDURE proMostrarDeudaActual
    (
        inuProducto                   LDC_MANTENIMIENTO_NOTAS_PROY.producto%TYPE,
        ocrLDC_MANTENIMIENTO_NOTAS_PR OUT CONSTANTS_PER.TYREFCURSOR,
        onucreditbalance              OUT NUMBER,
        onuclaimvalue                 OUT NUMBER,
        onudefclaimvalue              OUT NUMBER,
        osbError                      OUT VARCHAR2
    );

    ------------------------------------------------------------------------------------------------
    -- Insertar datos
    ------------------------------------------------------------------------------------------------

    PROCEDURE proBorraDatosTemporales(osbError OUT VARCHAR2);

    PROCEDURE proInsMantenimientoNotaEnc
    (
        inuProducto      ldc_mantenimiento_notas_enc.producto%TYPE, -- producto
        isbNovedad       ldc_mantenimiento_notas_enc.novedad%TYPE, -- operacion a realizar: ad (acreditar deuda), ac(acreditar concepto), acc (acreditar cuenta de cobro), accc (acreditar cuenta de cobro y concepto), d (debitar concepto)
        inuConcepto      ldc_mantenimiento_notas_enc.concepto%TYPE DEFAULT NULL, -- concepto
        inuCuenta_cobro  ldc_mantenimiento_notas_enc.cuenta_cobro%TYPE DEFAULT NULL, -- cuenta de cobro
        inuValor         ldc_mantenimiento_notas_enc.valor%TYPE DEFAULT NULL, -- valor de la nota
        inuCausa_cargo   ldc_mantenimiento_notas_enc.causa_cargo%TYPE, -- causa cargo
        inuCuotas        ldc_mantenimiento_notas_enc.cuotas%TYPE DEFAULT NULL, -- numero de cuotas para el diferido
        inuPlan_diferido ldc_mantenimiento_notas_enc.plan_diferido%TYPE DEFAULT NULL, -- plan diferido
        osbError         OUT VARCHAR2 -- Mensaje de error
    );

    PROCEDURE proBorMantenimientoNotaEnc(osbError OUT VARCHAR2 -- Mensaje de error
                                         );

    ------------------------------------------------------------------------------------------------
    -- Procesar
    ------------------------------------------------------------------------------------------------
    PROCEDURE proGrabar
    (
        inuProducto    pr_product.product_id%TYPE, -- Producto
        isbObservacion fa_notaapro.noapobse%TYPE, -- Observacion
        onuSolicitud   OUT mo_packages.package_id%TYPE, -- Solicitud
        osbError       OUT VARCHAR2
    );

    PROCEDURE proGrabarDebitarConcepto(inuPackage in mo_packages.package_id%type);

    PROCEDURE proCalcularProyectado
    (
        inuProducto LDC_MANTENIMIENTO_NOTAS_PROY.producto%TYPE,
        osbError    OUT VARCHAR2
    );

    ------------------------------------------------------------------------------------------------
    -- Validaciones
    ------------------------------------------------------------------------------------------------
    FUNCTION fnuGeneraNota
    (
        inuSolicitud       mo_packages.package_id%TYPE, -- Solicitud
        isbUsuarioRegistra FA_APROMOFA.APMOUSRE%TYPE -- Usuario que registra
    ) RETURN NUMBER;

    PROCEDURE validamonto
    (
        inuproducto pr_product.product_id%TYPE,
        osbError    OUT VARCHAR2 -- producto

    );

END LDC_PKMANTENIMIENTONOTAS;
/
CREATE OR REPLACE PACKAGE BODY LDC_PKMANTENIMIENTONOTAS IS

    ------------------------------------------------------------------------------------------------
    -- Datos de paquete
    ------------------------------------------------------------------------------------------------
    gnuSesion             NUMBER := userenv('sessionid');
    
    ------------------------------------------------------------------------------------------------
    -- Tipos de datos
    ------------------------------------------------------------------------------------------------
    TYPE tDeudaConc IS RECORD(
        producto        pr_product.product_id%TYPE,
        concepto_id     concepto.conccodi%TYPE,
        signo_corriente cargos.cargsign%TYPE,
        valor_corriente cargos.cargvalo%TYPE,
        signo_diferido  diferido.difesign%TYPE,
        valor_diferido  diferido.difesape%TYPE);

    --Mod.11.12.2018
    TYPE tDeudetre IS RECORD(
        concepto_id     concepto.conccodi%TYPE,
        concepto_desc   concepto.concdesc%TYPE,
        valor_actaul    cargos.cargvalo%TYPE,
        valor_vencido   cargos.cargvalo%TYPE,
        valor_diferido  diferido.difesape%TYPE);

    ------------------------------------------------------------------------------------------------
    -- Constantes
    ------------------------------------------------------------------------------------------------
    csbPaquete              CONSTANT VARCHAR2(32)       := $$PLSQL_UNIT||'.';           -- Constante para nombre del paquete    
    csbNivelTraza           CONSTANT NUMBER(2)          := pkg_traza.cnuNivelTrzDef;    -- Nivel de traza para este paquete. 
    csbInicio               CONSTANT VARCHAR2(4)        := pkg_traza.fsbINICIO;         -- Indica inicio de método
    csbFin                  CONSTANT VARCHAR2(4)        := pkg_traza.fsbFIN;            -- Indica Fin de método ok
    csbFin_Erc              CONSTANT VARCHAR2(4)        := pkg_traza.fsbFIN_ERC;        -- Indica fin de método con error controlado
    csbFin_Err              CONSTANT VARCHAR2(4)        := pkg_traza.fsbFIN_ERR;        -- Indica fin de método con error no controlado
    
    csbCredito      CONSTANT VARCHAR2(2) := 'CR'; -- Cargo credito
    csbNotaCredito  CONSTANT VARCHAR2(2) := 'NC'; -- Nota credito
    cnuNotaCredito  CONSTANT NUMBER(2) := 71; -- Nota debito
    csbDebito       CONSTANT VARCHAR2(2) := 'DB'; -- Cargo debito
    csbNotaDebito   CONSTANT VARCHAR2(2) := 'ND'; -- Nota Debito
    cnuNotaDebito   CONSTANT NUMBER(2) := 70; -- Nota Debito
    cnuConcConsumo  CONSTANT NUMBER(3) := 31; -- concepto de Consumo
    cnuConcSubsidio CONSTANT NUMBER(3) := 196; -- concepto de Subsidio
    cnuConcSubCovid CONSTANT NUMBER(3) := 167; -- concepto de Subsidio
    cnuConcCovid    CONSTANT NUMBER(3) := 130; -- concepto de Subsidio
    cnuTipoconcliq  CONSTANT NUMBER(3) := 4; -- Tipo concepto liquidacion impuesto
    cnuConcContribu CONSTANT NUMBER(3) := 37; -- concepto de Subsidio
    csbTinoDebito   CONSTANT VARCHAR2(1) := 'D'; -- Tipo Nota debito
    csbNotaProg     CONSTANT VARCHAR2(4) := 'FRNF';  --Programa para registrar las notas MANOT
    
    nuError                 NUMBER;
    sbError                 VARCHAR2(4000);
    
    ------------------------------------------------------------------------------------------------
    -- Cursores
    ------------------------------------------------------------------------------------------------
    -- Cuentas de cobro son saldo para un producto
    CURSOR cuCuentasConSaldo(inuProducto pr_product.product_id%TYPE) IS
        SELECT cucocodi cuenta_cobro
        FROM cuencobr
        WHERE cuconuse = inuProducto
          AND cucosacu > 0
       ORDER BY cucocodi; --Agregado 11.12.2018

    ------------------------------------------------------------------------------------------------
    -- Procedimientos
    ------------------------------------------------------------------------------------------------
    PROCEDURE prRegistraAuditoria
    ( 
        isbNovedad      IN VARCHAR2,
        inuSolicitud    IN NUMBER,
        isbObservacion  IN VARCHAR2,
        isbNovedad2     IN VARCHAR2,
        isbError        IN VARCHAR2
    );
    
    PROCEDURE proInsMantenimientoNotaProy
    (
        inuProducto       LDC_MANTENIMIENTO_NOTAS_PROY.producto%TYPE,
        isbSignoCorriente LDC_MANTENIMIENTO_NOTAS_PROY.signo_corriente%TYPE,
        inuValorCorriente LDC_MANTENIMIENTO_NOTAS_PROY.valor_corriente%TYPE,
        inuValorVencido   LDC_MANTENIMIENTO_NOTAS_PROY.valor_vencido%TYPE,
        inuConcepto       LDC_MANTENIMIENTO_NOTAS_PROY.concepto%TYPE,
        isbOrigen         LDC_MANTENIMIENTO_NOTAS_PROY.origen%TYPE,
        inuValorDiferido  LDC_MANTENIMIENTO_NOTAS_PROY.valor_diferido%TYPE,
        isbSignoDiferido  LDC_MANTENIMIENTO_NOTAS_PROY.signo_diferido%TYPE,
        osbError          OUT VARCHAR2 -- Mensaje de error
    ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proInsMantenimientoNotaProy
        Descripcion:        Inserta un registro en la tabla LDC_MANTENIMIENTO_NOTAS_PROY

        Autor    : Sandra Muñoz
        Fecha    : 15-04-2016  CA 200-201

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificación
        -----------  -------------------    -------------------------------------
        15-04-2016   Sandra Muñoz           Creación
        ******************************************************************/

        csbMetodo   CONSTANT VARCHAR2(100) := csbPaquete||'proInsMantenimientoNotaProy';
        rgDatos   LDC_MANTENIMIENTO_NOTAS_PROY%ROWTYPE; -- Datos a insertar en la tabla
        

    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_traza.trace('inuProducto        <= '||inuProducto, csbNivelTraza);
        pkg_traza.trace('isbSignoCorriente  <= '||isbSignoCorriente, csbNivelTraza);
        pkg_traza.trace('inuValorCorriente  <= '||inuValorCorriente, csbNivelTraza);
        pkg_traza.trace('inuValorVencido    <= '||inuValorVencido, csbNivelTraza);
        pkg_traza.trace('inuConcepto        <= '||inuConcepto, csbNivelTraza);
        pkg_traza.trace('isbOrigen          <= '||isbOrigen, csbNivelTraza);
        pkg_traza.trace('inuValorDiferido   <= '||inuValorDiferido, csbNivelTraza);
        pkg_traza.trace('isbSignoDiferido   <= '||isbSignoDiferido, csbNivelTraza);
        
        pkg_traza.trace('gnuSesion ' || gnuSesion ,csbNivelTraza );

        -- Construccion del registro
        rgDatos.Producto        := inuProducto;
        rgDatos.sesion          := gnuSesion;
        rgDatos.usuario         := PKG_BOPERSONAL.FNUGETPERSONAID;
        rgDatos.fecha           := SYSDATE;
        rgDatos.signo_corriente := isbSignoCorriente;
        rgDatos.valor_corriente := inuValorCorriente;
        rgDatos.valor_vencido   := inuValorVencido;
        rgDatos.concepto        := inuConcepto;
        rgDatos.Origen          := isbOrigen;
        rgDatos.Valor_Diferido  := inuValorDiferido;
        rgDatos.Signo_Diferido  := isbSignoDiferido;
        
        INSERT INTO LDC_MANTENIMIENTO_NOTAS_PROY VALUES rgDatos;
        
        pkg_traza.trace('osbError => '||osbError, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
        
    EXCEPTION
        WHEN OTHERS THEN
            Pkg_Error.setError;
            pkg_error.geterror(nuError, sbError);
            osbError := sbError;
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);            
    END;

    PROCEDURE proInsMantenimientoNotaEnc
    (
        inuProducto      ldc_mantenimiento_notas_enc.producto%TYPE, -- producto
        isbNovedad       ldc_mantenimiento_notas_enc.novedad%TYPE, -- operacion a realizar: ad (acreditar deuda), ac(acreditar concepto), acc (acreditar cuenta de cobro), accc (acreditar cuenta de cobro y concepto), d (debitar concepto)
        inuConcepto      ldc_mantenimiento_notas_enc.concepto%TYPE DEFAULT NULL, -- concepto
        inuCuenta_cobro  ldc_mantenimiento_notas_enc.cuenta_cobro%TYPE DEFAULT NULL, -- cuenta de cobro
        inuValor         ldc_mantenimiento_notas_enc.valor%TYPE DEFAULT NULL, -- valor de la nota
        inuCausa_cargo   ldc_mantenimiento_notas_enc.causa_cargo%TYPE, -- causa cargo
        inuCuotas        ldc_mantenimiento_notas_enc.cuotas%TYPE DEFAULT NULL, -- numero de cuotas para el diferido
        inuPlan_diferido ldc_mantenimiento_notas_enc.plan_diferido%TYPE DEFAULT NULL, -- plan diferido
        osbError         OUT VARCHAR2 -- Mensaje de error
    ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proInsMantenimientoNotaEnc
        Descripcion:        Inserta un registro en la tabla LDC_MANTENIMIENTO_NOTAS_ENC

        Autor    : Sandra Muñoz
        Fecha    : 15-04-2016  CA 200-201

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificación
        -----------  -------------------    -------------------------------------
        15-04-2016   Sandra Muñoz           Creación
        ******************************************************************/

        csbMetodo   CONSTANT VARCHAR2(100) := csbPaquete||'proInsMantenimientoNotaEnc';
        nuPaso    NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        rgDatos   LDC_MANTENIMIENTO_NOTAS_ENC%ROWTYPE; -- Datos a insertar en la tabla


    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_traza.trace('inuProducto        <= '||inuProducto, csbNivelTraza);
        pkg_traza.trace('isbNovedad         <= '||isbNovedad, csbNivelTraza);
        pkg_traza.trace('inuConcepto        <= '||inuConcepto, csbNivelTraza);
        pkg_traza.trace('inuCuenta_cobro    <= '||inuCuenta_cobro, csbNivelTraza);
        pkg_traza.trace('inuValor           <= '||inuValor, csbNivelTraza);
        pkg_traza.trace('inuCausa_cargo     <= '||inuCausa_cargo, csbNivelTraza);
        pkg_traza.trace('inuCuotas          <= '||inuCuotas, csbNivelTraza);
        pkg_traza.trace('inuPlan_diferido   <= '||inuPlan_diferido, csbNivelTraza);

        -- Construccion del registro

        nuPaso           := 10;
        rgDatos.Producto := inuProducto;
        nuPaso           := 20;
        rgDatos.Novedad  := isbNovedad;
        nuPaso           := 30;

        rgDatos.Concepto      := inuConcepto;
        nuPaso                := 40;
        rgDatos.Cuenta_Cobro  := inuCuenta_cobro;
        nuPaso                := 50;
        rgDatos.Valor         := inuValor;
        nuPaso                := 60;
        rgDatos.Causa_Cargo   := inuCausa_cargo;
        nuPaso                := 70;
        rgDatos.Cuotas        := inuCuotas;
        nuPaso                := 80;
        rgDatos.Plan_Diferido := inuPlan_diferido;
        nuPaso                := 90;
        rgDatos.Sesion        := gnuSesion;

        nuPaso := 100;

        INSERT INTO ldc_mantenimiento_notas_enc VALUES rgDatos;

        COMMIT;
        
        pkg_traza.trace('osbError => '||osbError, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
        
    EXCEPTION
        WHEN OTHERS THEN
            Pkg_Error.setError;
            pkg_error.geterror(nuError, sbError);
            osbError := sbError;
            pkg_traza.trace('sbError: '||sbError||'('||nuPaso||')',csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err); 
    END;

    PROCEDURE proInsMantenimientoNotaDet
    (
        inuCuenta_cobro ldc_mantenimiento_notas_det.cuenta_cobro%TYPE, -- producto
        inuProducto     ldc_mantenimiento_notas_det.producto%TYPE, -- operacion a realizar: ad (acreditar deuda), ac(acreditar concepto), acc (acreditar cuenta de cobro), accc (acreditar cuenta de cobro y concepto), d (debitar concepto)
        inuConcepto     ldc_mantenimiento_notas_det.concepto%TYPE, -- concepto
        inuSigno        ldc_mantenimiento_notas_det.signo%TYPE, -- cuenta de cobro
        inuValor        ldc_mantenimiento_notas_det.valor%TYPE, -- valor de la nota
        inuCausa_cargo  ldc_mantenimiento_notas_det.causa_cargo%TYPE, -- Causa cargo
        inuValor_Base   ldc_mantenimiento_notas_det.valor_base%TYPE DEFAULT NULL, -- valor base de la nota
        osbError        OUT VARCHAR2 -- Mensaje de error
    ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proInsMantenimientoNotaDet
        Descripcion:        Inserta un registro en la tabla LDC_MANTENIMIENTO_NOTAS_DET

        Autor    : Sandra Muñoz
        Fecha    : 15-04-2016  CA 200-201

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificación
        -----------  -------------------    -------------------------------------
        15-04-2016   Sandra Muñoz           Creación
        25-09/2024      jcatuche            OSF-3332: Se agrega nueva columna al registro. Valor_base
        ******************************************************************/

        csbMetodo   CONSTANT VARCHAR2(100) := csbPaquete||'proInsMantenimientoNotaDet';
        rgDatos   LDC_MANTENIMIENTO_NOTAS_DET%ROWTYPE; -- Datos a insertar en la tabla

        
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_traza.trace('inuCuenta_cobro    <= '||inuCuenta_cobro, csbNivelTraza);
        pkg_traza.trace('inuProducto        <= '||inuProducto, csbNivelTraza);
        pkg_traza.trace('inuConcepto        <= '||inuConcepto, csbNivelTraza);
        pkg_traza.trace('inuSigno           <= '||inuSigno, csbNivelTraza);
        pkg_traza.trace('inuValor           <= '||inuValor, csbNivelTraza);
        pkg_traza.trace('inuCausa_cargo     <= '||inuCausa_cargo, csbNivelTraza);
        pkg_traza.trace('inuValor_Base      <= '||inuValor_Base, csbNivelTraza);
        
        -- Construccion del registro
        rgDatos.cuenta_cobro := inuCuenta_cobro;
        rgDatos.producto     := inuProducto;
        rgDatos.Concepto     := inuConcepto;
        rgDatos.signo        := inuSigno;
        rgDatos.Valor        := inuValor;
        rgDatos.Sesion       := gnuSesion;
        rgDatos.Causa_Cargo  := inuCausa_cargo;
        rgDatos.Valor_Base   := nvl(inuValor_Base,inuValor);

        INSERT INTO ldc_mantenimiento_notas_det VALUES rgDatos;
        
        pkg_traza.trace('osbError => '||osbError, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
        
    EXCEPTION
        WHEN OTHERS THEN
            Pkg_Error.setError;
            pkg_error.geterror(nuError, sbError);
            osbError := sbError;
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err); 
    END proInsMantenimientoNotaDet;

    PROCEDURE proBorMantenimientoNotaEnc(osbError OUT VARCHAR2 -- Mensaje de error
                                         ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proBorMantenimientoNotaEnc
        Descripcion:        Borra los datos de LDC_MANTENIMIENTO_NOTAS_ENC para la sesion

        Autor    : Sandra Muñoz
        Fecha    : 15-04-2016  CA 200-201

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificación
        -----------  -------------------    -------------------------------------
        15-04-2016   Sandra Muñoz           Creación
        ******************************************************************/

        csbMetodo   CONSTANT VARCHAR2(100) := csbPaquete||'proBorMantenimientoNotaEnc';
        
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        
        DELETE LDC_MANTENIMIENTO_NOTAS_ENC lmn WHERE lmn.sesion = gnuSesion;
        
        pkg_traza.trace('osbError => '||osbError, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
        
    EXCEPTION
        WHEN OTHERS THEN
            osbError := 'No fue posible borrar el contenido de la tabla LDC_MANTENIMIENTO_NOTAS_ENC para la sesion ' ||gnuSesion;
            Pkg_Error.setError;
            pkg_error.geterror(nuError, sbError);
            sbError := osbError||'-'||sbError;
            osbError := sbError;
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err); 
    END;

    PROCEDURE proBorMantenimientoNotaProy(osbError OUT VARCHAR2 -- Mensaje de error
                                          ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proBorMantenimientoNotaProy
        Descripcion:        Borra un registro en la tabla LDC_MANTENIMIENTO_NOTAS_PROY

        Autor    : Sandra Muñoz
        Fecha    : 15-04-2016  CA 200-201

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificación
        -----------  -------------------    -------------------------------------
        15-04-2016   Sandra Muñoz           Creación
        ******************************************************************/

        csbMetodo   CONSTANT VARCHAR2(100) := csbPaquete||'proBorMantenimientoNotaProy';
        

    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_traza.trace('gnuSesion ' || gnuSesion, csbNivelTraza); 
         
       DELETE LDC_MANTENIMIENTO_NOTAS_PROY lmn WHERE lmn.sesion = gnuSesion;
        
        pkg_traza.trace('osbError => '||osbError, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
    
    EXCEPTION
        WHEN OTHERS THEN
            osbError := 'No fue posible borrar el contenido de la tabla LDC_MANTENIMIENTO_NOTAS_PROY para la sesion ' ||gnuSesion;
            Pkg_Error.setError;
            pkg_error.geterror(nuError, sbError);
            sbError := osbError||'-'||sbError; 
            osbError := sbError;
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err); 
    END;

    PROCEDURE proBorMantenimientoNotaDet(osbError OUT VARCHAR2 -- Mensaje de error
                                         ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proBorMantenimientoNotaDet
        Descripcion:        Borra los datos de LDC_MANTENIMIENTO_NOTAS_DETpara la sesion

        Autor    : Sandra Muñoz
        Fecha    : 15-04-2016  CA 200-201

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificación
        -----------  -------------------    -------------------------------------
        15-04-2016   Sandra Muñoz           Creación
        ******************************************************************/

        csbMetodo   CONSTANT VARCHAR2(100) := csbPaquete||'proBorMantenimientoNotaDet';
       

    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        
        DELETE LDC_MANTENIMIENTO_NOTAS_DET lmn WHERE lmn.sesion = gnuSesion;
        
        pkg_traza.trace('osbError => '||osbError, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
        
    EXCEPTION
        WHEN OTHERS THEN
            osbError := 'No fue posible borrar el contenido de la tabla LDC_MANTENIMIENTO_NOTAS_DET para la sesion ' ||gnuSesion;
            Pkg_Error.setError;
            pkg_error.geterror(nuError, sbError);
            sbError := osbError||'-'||sbError;
            osbError := sbError;
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err); 
    END;

    PROCEDURE proBorraDatosTemporales(osbError OUT VARCHAR2) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proBorraDatosTemporales
        Descripcion:        Borra todos los datos usados para la operacion

        Autor    : Sandra Muñoz
        Fecha    : 15-04-2016  CA 200-201

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificación
        -----------  -------------------    -------------------------------------
        15-04-2016   Sandra Muñoz           Creación
        ******************************************************************/

        csbMetodo   CONSTANT VARCHAR2(100) := csbPaquete||'proBorraDatosTemporales';
        
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);

        proBorMantenimientoNotaEnc(osbError => osbError);
        IF osbError IS NOT NULL THEN
            pkg_error.setErrorMessage( isbMsgErrr => osbError);
        END IF;

        proBorMantenimientoNotaProy(osbError => osbError);
        IF osbError IS NOT NULL THEN
            pkg_error.setErrorMessage( isbMsgErrr => osbError);
        END IF;

        proBorMantenimientoNotaDet(osbError => osbError);
        IF osbError IS NOT NULL THEN
            pkg_error.setErrorMessage( isbMsgErrr => osbError);
        END IF;

        pkg_traza.trace('osbError => '||osbError, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
        
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_error.geterror(nuError, sbError);
            osbError := sbError;
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);     
        WHEN OTHERS THEN            
            Pkg_Error.setError;
            pkg_error.geterror(nuError, sbError);
            osbError := sbError;
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err); 
    END;

    PROCEDURE proDeudaConceptoProy
    (
        inuProducto        IN pr_product.product_id%TYPE,
        inuConcepto        IN concepto.conccodi%TYPE,
        onuValorAAcreditar OUT NUMBER,
        osbError           OUT VARCHAR2
    ) IS
        csbMetodo   CONSTANT VARCHAR2(100) := csbPaquete||'proDeudaConceptoProy';
        
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proDeudaConceptoProy
        Descripcion:       Obtiene la deuda actual por concepto

        Autor    : Sandra Muñoz
        Fecha    : 15-04-2016  CA 200-201

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificación
        -----------  -------------------    -------------------------------------
        15-04-2016   Sandra Muñoz           Creación
        ******************************************************************/

        cursor cuValorAAcreditar IS
        SELECT nvl(SUM(nvl(valor_corriente, 0)) + SUM(nvl(valor_diferido, 0)), 0) deuda_total
        FROM LDC_MANTENIMIENTO_NOTAS_PROY lmn
        WHERE lmn.sesion = gnuSesion
              AND lmn.producto = inuProducto
              AND lmn.origen = 'D'
              AND lmn.signo_corriente = csbDebito
              AND lmn.concepto = inuConcepto; -- Deuda real del concepto

    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_traza.trace('inuProducto    <= '||inuProducto, csbNivelTraza);
        pkg_traza.trace('inuConcepto    <= '||inuConcepto, csbNivelTraza);
        
        if cuValorAAcreditar%isopen then
            close cuValorAAcreditar;
        end if;
        
        open cuValorAAcreditar;
        fetch cuValorAAcreditar into onuValorAAcreditar;
        close cuValorAAcreditar;
              
        pkg_traza.trace('onuValorAAcreditar => '||onuValorAAcreditar, csbNivelTraza);
        pkg_traza.trace('osbError           => '||osbError, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
        
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_error.geterror(nuError, sbError);
            osbError := sbError;
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc); 
        WHEN OTHERS THEN
            Pkg_Error.setError;
            pkg_error.geterror(nuError, sbError);
            osbError := sbError;
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err); 
    END proDeudaConceptoProy;

    PROCEDURE proDeudaConceptoReal
    (
        inuProducto pr_product.product_id%TYPE, -- Producto
        inuConcepto concepto.conccodi%TYPE, -- Concepto
        onuDeuda    OUT NUMBER,
        osbError    OUT VARCHAR2
    ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proDeudaConceptoReal
        Descripcion:       Obtiene la deuda actual por concepto

        Autor    : Sandra Muñoz
        Fecha    : 15-04-2016  CA 200-201

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificación
        -----------  -------------------    -------------------------------------
        15-04-2016   Sandra Muñoz           Creación
        ******************************************************************/

        csbMetodo   CONSTANT VARCHAR2(100) := csbPaquete||'proDeudaConceptoReal';
        cuDeudaConc CONSTANTS_PER.TYREFCURSOR;
        rgDeudaConc tDeudaConc;


    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_traza.trace('inuProducto    <= '||inuProducto, csbNivelTraza);
        pkg_traza.trace('inuConcepto    <= '||inuConcepto, csbNivelTraza);

        nuError     := 0;
        -- Obtener los conceptos con deuda del producto
        api_queryproddebtbyconc(inusesunuse => inuProducto, isbpunished => 'S', ocuqueryproddebtbyconc => cuDeudaConc, onuerrorcode => nuError, osberrormessage => sbError);

        IF nuError > 0 THEN
            osbError := nuError ||' - '||sbError;
            pkg_error.setErrorMessage( isbMsgErrr => osbError);
        END IF;

        LOOP
            -- Obtener registro
            FETCH cuDeudaConc
                INTO rgDeudaConc;
            EXIT WHEN cuDeudaConc%NOTFOUND;

            IF rgDeudaConc.concepto_id = inuConcepto THEN
                onuDeuda := rgDeudaConc.valor_corriente;

                IF onuDeuda IS NULL THEN
                    onuDeuda := 0;
                END IF;

            END IF;

        END LOOP;

        IF onuDeuda IS NULL THEN
            onuDeuda := 0;
        END IF;

        IF nuError = 0 or sbError = '-' THEN
            osbError := NULL;
        END IF;

        pkg_traza.trace('onuDeuda   => '||onuDeuda, csbNivelTraza);
        pkg_traza.trace('osbError   => '||osbError, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
        
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_error.geterror(nuError, sbError);
            osbError := sbError;
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc); 
        WHEN OTHERS THEN
            Pkg_Error.setError;
            pkg_error.geterror(nuError, sbError);
            osbError := sbError;
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err); 
    END;

    PROCEDURE proDeudaCuentaCobro
    (
        inuProducto      IN pr_product.product_id%TYPE,
        inuCuenCobr      IN cuencobr.cucocodi%TYPE,
        onuSaldoCuenCobr OUT cuencobr.cucosacu%TYPE,
        osbError         OUT VARCHAR2
    ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proDeudaCuentaCobro
        Descripcion:        Devuelve el saldo de una cuenta de cobro


        Autor    : Sandra Muñoz
        Fecha    : 15-04-2016  CA 200-201

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificación
        -----------  -------------------    -------------------------------------
        15-04-2016   Sandra Muñoz           Creación
        ******************************************************************/

        csbMetodo           CONSTANT VARCHAR2(100) := csbPaquete||'proDeudaCuentaCobro';
        nuValorAAcreditar NUMBER; -- Valor a acreditar al concepto

        cursor cuSaldoCuenCobr is
            SELECT nvl(cc.cucosacu, 0)
            FROM cuencobr cc
            WHERE cc.cucocodi = inuCuenCobr;
        
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_traza.trace('inuProducto    <= '||inuProducto, csbNivelTraza);
        pkg_traza.trace('inuCuenCobr    <= '||inuCuenCobr, csbNivelTraza);
        
        if cuSaldoCuenCobr%isopen then
            close cuSaldoCuenCobr;
        end if;
        
        open cuSaldoCuenCobr;
        fetch cuSaldoCuenCobr into onuSaldoCuenCobr;
        if cuSaldoCuenCobr%notfound then
            close cuSaldoCuenCobr;
            osbError := 'No fue posible obtener el saldo de la cuenta de cobro '||inuCuenCobr;
            pkg_error.setErrorMessage( isbMsgErrr => osbError);
        end if;
        close cuSaldoCuenCobr;
            
        pkg_traza.trace('onuSaldoCuenCobr   => '||onuSaldoCuenCobr, csbNivelTraza);
        pkg_traza.trace('osbError           => '||osbError, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
        
    EXCEPTION
        WHEN Pkg_Error.controlled_error THEN
            pkg_error.geterror(nuError, sbError);
            osbError := sbError;
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc); 
        WHEN OTHERS THEN
            Pkg_Error.setError;
            pkg_error.geterror(nuError, sbError);
            osbError := sbError;
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err); 
    END proDeudaCuentaCobro;

    PROCEDURE proCargaDeudaActual
    (
        inuProducto pr_product.product_id%TYPE, -- Producto
        osbError    OUT VARCHAR2
    ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proCargaDeudaActual
        Descripcion:       Obtiene la deuda actual por concepto

        Autor    : Sandra Muñoz
        Fecha    : 15-04-2016  CA 200-201

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificación
        -----------  -------------------    -------------------------------------
        10-12-2018   Ronald Colpas          caso-200-1650Se modifica para que se muestre la deuda
                                            detallada valor actual, valor vencido.
        15-04-2016   Sandra Muñoz           Creación
        ******************************************************************/

        csbMetodo   CONSTANT VARCHAR2(100) := csbPaquete||'proCargaDeudaActual';
        cuDeudaConc CONSTANTS_PER.TYREFCURSOR;
        nuError     NUMBER := 0;
        rgDeudaConc tDeudaConc;
        nuConteo    NUMBER;

        --Declaracion de variables para el detalle de la deuda
        nuDeudcorr  NUMBER;
        nuDeudifer  NUMBER;
        nuValorecl  NUMBER;
        nuSaldoafa  NUMBER;
        nuDifrecla  NUMBER;
        cuDeudetre  CONSTANTS_PER.TYREFCURSOR;
        cuDeudetai  CONSTANTS_PER.TYREFCURSOR;
        rgDeudadet  tDeudetre;

      
        
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_traza.trace('inuProducto <= '||inuProducto, csbNivelTraza);

        -- Borrar los resultados de la consulta anterior
        proBorMantenimientoNotaProy(osbError => osbError);
        IF osbError IS NOT NULL THEN
            pkg_error.setErrorMessage( isbMsgErrr => osbError);
        END IF;

        -- Obtener los conceptos con deuda del producto
        api_queryproddebtbyconc(inusesunuse => inuProducto, isbpunished => 'S', ocuqueryproddebtbyconc => cuDeudaConc, onuerrorcode => nuError, osberrormessage => osbError);

        LOOP
            -- Obtener registro
            FETCH cuDeudaConc
                INTO rgDeudaConc;
            EXIT WHEN cuDeudaConc%NOTFOUND;

            proInsMantenimientoNotaProy(inuProducto => rgDeudaConc.producto, isbSignoCorriente => rgDeudaConc.signo_corriente, inuValorCorriente => rgDeudaConc.valor_corriente, inuValorVencido => 0, inuConcepto => rgDeudaConc.concepto_id, isbOrigen => 'D', inuValorDiferido => rgDeudaConc.valor_diferido, isbSignoDiferido => rgDeudaConc.signo_diferido, osbError => osbError);

            IF osbError IS NOT NULL THEN
                pkg_error.setErrorMessage( isbMsgErrr => osbError);
            END IF;

        END LOOP;

        --Inicio Mod. 10/12/2018 Obtiene deuda actual y vencida
        fa_boaccountstatustodate.productaccountstatustodate(inuproductid => inuProducto,
                                                      idtdate => sysdate,
                                                      onucurrentaccounttotal => nuDeudcorr,
                                                      onudeferredaccounttotal => nuDeudifer,
                                                      onucreditbalance => nuSaldoafa,
                                                      onuclaimvalue => nuValorecl,
                                                      onudefclaimvalue => nuDifrecla,
                                                      orfresumeaccountdetail => cuDeudetre,
                                                      orfaccountdetail => cuDeudetai);
        LOOP
            -- Obtener registro
            FETCH cuDeudetre
                INTO rgDeudadet;
            EXIT WHEN cuDeudetre%NOTFOUND;

            --Actualizamos los valores actual y vencido
            update LDC_MANTENIMIENTO_NOTAS_PROY t
               set t.valor_corriente = rgDeudadet.valor_actaul,
                   t.valor_vencido   = rgDeudadet.valor_vencido
             where t.sesion = gnuSesion
               and t.concepto = rgDeudadet.concepto_id;
            IF osbError IS NOT NULL THEN
                pkg_error.setErrorMessage( isbMsgErrr => osbError);
            END IF;

        END LOOP;

        update LDC_MANTENIMIENTO_NOTAS_PROY t
           set t.valor_corriente = decode(t.signo_corriente,
                                          'DB',
                                          t.valor_corriente,
                                          -t.valor_corriente),
               t.valor_vencido   = decode(t.signo_corriente,
                                          'DB',
                                          t.valor_vencido,
                                          -t.valor_vencido)
         where t.sesion = gnuSesion;
        --Fin Mod. 10/12/2018

        pkg_traza.trace('osbError => '||osbError, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
        
    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            pkg_error.geterror(nuError, sbError);
            osbError := sbError;
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
        WHEN OTHERS THEN
            Pkg_Error.setError;
            pkg_error.geterror(nuError, sbError);
            osbError := sbError;
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
    END;

    PROCEDURE proDeudaConceptoCC
    (
        inuCuenCobr      cuencobr.cucocodi%TYPE, -- Codigo de la cuenta de cobro
        inuConcepto      concepto.conccodi%TYPE, -- Concepto
        onuSaldoConcepto OUT cargos.cargvalo%TYPE, -- Saldo del concepto
        osbError         OUT VARCHAR2 -- Error
    ) IS

        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proDeudaConceptoCC
        Descripcion:        Retorna el saldo de un concepto dentro de una cuenta de cobro

        Autor    : Sandra Muñoz
        Fecha    : 15-04-2016  CA 200-201

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificación
        -----------  -------------------    -------------------------------------
        15-04-2016   Sandra Muñoz           Creación
        ******************************************************************/

        csbMetodo   CONSTANT VARCHAR2(100) := csbPaquete||'proDeudaConceptoCC';
        tbsaldoconc pkbalanceconceptmgr.tytbsaldoconc;
        
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_traza.trace('inuCuenCobr    <= '||inuCuenCobr, csbNivelTraza);
        pkg_traza.trace('inuConcepto    <= '||inuConcepto, csbNivelTraza);
        
        -- Call the procedure
        pkbalanceconceptmgr.getbalancebyconc(inuaccount => inuCuenCobr, otbsaldoconc => tbsaldoconc);
        BEGIN
            onuSaldoConcepto := tbSaldoConc(inuConcepto).nusaldo;
        EXCEPTION
            WHEN no_data_found THEN
                onuSaldoConcepto := 0;
        END;
        
        pkg_traza.trace('onuSaldoConcepto   => '||onuSaldoConcepto, csbNivelTraza);
        pkg_traza.trace('osbError           => '||osbError, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
        
    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            pkg_error.geterror(nuError, sbError);
            osbError := sbError;
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
        WHEN OTHERS THEN
            Pkg_Error.setError;
            pkg_error.geterror(nuError, sbError);
            osbError := sbError;
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
    END proDeudaConceptoCC;

    PROCEDURE proDeudaProducto
    (
        inuProducto pr_product.product_id%TYPE, -- Producto
        onuDeuda    OUT NUMBER, -- Deuda del producto
        osbError    OUT VARCHAR2
    ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proDeudaProducto
        Descripcion:        Devuelve la deuda del producto

        Autor    : Sandra Muñoz
        Fecha    : 15-04-2016  CA 200-201

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificación
        -----------  -------------------    -------------------------------------
        15-04-2016   Sandra Muñoz           Creación
        ******************************************************************/

        csbMetodo   CONSTANT VARCHAR2(100) := csbPaquete||'proDeudaProducto';
     

    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_traza.trace('inuProducto <= '||inuProducto, csbNivelTraza);

        onuDeuda := pkBCCuencobr.fnuGetOutStandBal(inuproduct => inuProducto);

        pkg_traza.trace('onuDeuda => '||onuDeuda, csbNivelTraza);
        pkg_traza.trace('osbError => '||osbError, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
        
    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            pkg_error.geterror(nuError, sbError);
            osbError := sbError;
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
        WHEN OTHERS THEN
            Pkg_Error.setError;
            pkg_error.geterror(nuError, sbError);
            osbError := sbError;
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
    END;

    PROCEDURE proValidaConceptoYaFacurado
    (
        inuProducto IN pr_product.product_id%TYPE,
        inuConcepto IN concepto.conccodi%TYPE,
        osbError    OUT VARCHAR2
    ) IS

        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proValidaConceptoYaFacurado
        Descripcion:       Indica si un concepto ya ha sido facturado para el producto ingresado por
                           parametro

        Autor    : Sandra Muñoz
        Fecha    : 15-04-2016  CA 200-201

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificación
        -----------  -------------------    -------------------------------------
        15-04-2016   Sandra Muñoz           Creación
        ******************************************************************/

        csbMetodo   CONSTANT VARCHAR2(100) := csbPaquete||'proValidaConceptoYaFacurado';
        nuExiste  NUMBER;
        
        cursor cuExiste is
            SELECT COUNT(1)
            FROM cargos c
            WHERE c.cargnuse = inuProducto
                  AND c.cargconc = inuConcepto;
       
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_traza.trace('inuProducto    <= '||inuProducto, csbNivelTraza);
        pkg_traza.trace('inuConcepto    <= '||inuConcepto, csbNivelTraza);
        
        if cuExiste%isopen then
            close cuExiste;
        end if;

        open cuExiste;
        fetch cuExiste into nuExiste;
        close cuExiste;
            
       
        IF nuExiste = 0 THEN
            osbError := 'No se puede acreditar el concepto ' || inuConcepto ||' ya que no se encuentra en ninguna de las cuentas de cobro asociadas al producto ' ||inuProducto;
            pkg_error.setErrorMessage( isbMsgErrr => osbError);
        END IF;

        pkg_traza.trace('osbError => '||osbError, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
        
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_error.geterror(nuError, sbError);
            osbError := sbError;
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
        WHEN OTHERS THEN
            Pkg_Error.setError;
            pkg_error.geterror(nuError, sbError);
            osbError := sbError;
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
    END proValidaConceptoYaFacurado;

    FUNCTION fcrCtasCobroProducto(inuProducto LDC_MANTENIMIENTO_NOTAS_PROY.producto%TYPE)
        RETURN CONSTANTS_PER.TYREFCURSOR IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: fcrCtasCobroProducto
        Descripcion:

        Autor    : Sandra Muñoz

        Fecha    : 15-04-2016  CA 200-201

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificación
        -----------  -------------------    -------------------------------------
        15-04-2016   Sandra Muñoz           Creación
        ******************************************************************/

        csbMetodo       CONSTANT VARCHAR2(100) := csbPaquete||'fcrCtasCobroProducto';
        crCuentaCobro   CONSTANTS_PER.TYREFCURSOR;

    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_traza.trace('inuProducto    <= '||inuProducto, csbNivelTraza);

        -- Consulta cursor referenciado
        OPEN crCuentaCobro FOR
          SELECT cucocodi cuenta,
                 pefaano  ano,
                 pefames  mes,
                 nvl(cucosacu, 0) saldo
            from factura f, cuencobr cc, perifact pf
           where cuconuse = inuProducto
             and factpefa = pefacodi
             and cucofact = factcodi
           order by pefafege desc;

        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
        RETURN crCuentaCobro;

    EXCEPTION
        WHEN OTHERS THEN
            Pkg_Error.setError;
            pkg_error.geterror(nuError, sbError);
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
    END;

    FUNCTION fcrConceptosCtaCobro(inuCuentaCobro ldc_mantenimiento_notas_enc.cuenta_cobro%TYPE)
        RETURN CONSTANTS_PER.TYREFCURSOR IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete:fcrConceptosCtaCobro
        Descripcion:

        Autor    : Sandra Muñoz

        Fecha    : 15-04-2016  CA 200-201

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificación
        -----------  -------------------    -------------------------------------
        15-04-2016  Sandra Muñoz            Creación
        17-04-2017  Luis Fren G             Se modifica consulta para que no aparezcan los conceptos
                                            que se definen en la tabla que contiene los conceptos que no
                                            se pueden acreditar LDC_CONC_NO_ACRED
        25-09-2024   jcatuche               OSF-3332: Se añade exclusión de conceptos de impuesto concticl = cnuTipoconcliq y de pago
        ******************************************************************/

        csbMetodo   VARCHAR2(4000) := csbPaquete||'fcrConceptosCtaCobro';
        crConceptos CONSTANTS_PER.TYREFCURSOR;

    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_traza.trace('inuCuentaCobro <= '||inuCuentaCobro, csbNivelTraza);

        -- Consulta cursor referenciado
        OPEN crConceptos FOR
        SELECT DISTINCT cargconc concepto, concdesc descripcion
        FROM cargos, concepto
        WHERE cargcuco = inuCuentaCobro
        AND conccodi = cargconc
        AND cargconc NOT IN (SELECT l.CONCCODI FROM LDC_CONC_NO_ACRED l)
        AND concticl != cnuTipoconcliq
        AND cargsign != 'PA'
        ORDER BY cargconc;

        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
        RETURN crConceptos;

    EXCEPTION
        WHEN OTHERS THEN
            Pkg_Error.setError;
            pkg_error.geterror(nuError, sbError);
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
    END fcrConceptosCtaCobro;

    FUNCTION fcrConceptosProducto
    (
        inuProducto ldc_mantenimiento_notas_enc.producto%TYPE,
        isbnovedad  VARCHAR2
    ) RETURN CONSTANTS_PER.TYREFCURSOR IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete:fcrConceptosProducto
        Descripcion:

        Autor    : Sandra Muñoz

        Fecha    : 15-04-2016  CA 200-201

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificación
        -----------  -------------------    -------------------------------------
        15-04-2016   Sandra Muñoz           Creación
        17-04-2017   Luis Fren G            Se modifica consulta para que no aparezcan los conceptos
                                            que se definen en la tabla que contiene los conceptos que no
                                            se pueden acreditar LDC_CONC_NO_ACRED
        25-09-2024      jcatuche            OSF-3332: Se añade exclusión de conceptos de impuesto concticl = cnuTipoconcliq y de pago
        ******************************************************************/

        csbMetodo   VARCHAR2(4000) := csbPaquete||'fcrConceptosProducto';
        crConceptos CONSTANTS_PER.TYREFCURSOR;
    
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_traza.trace('inuProducto    <= '||inuProducto, csbNivelTraza);
        pkg_traza.trace('isbnovedad     <= '||isbnovedad, csbNivelTraza);

        -- Consulta cursor referenciado lmfg para que aparezcan todos los conceptos
        IF isbNovedad <> 'DC' THEN
            --descomentariar para el desarrollo
            --lmfg
            OPEN crConceptos FOR
                SELECT DISTINCT cargconc concepto, concdesc descripcion
                FROM cargos, concepto
                WHERE cargnuse = inuProducto
                      AND cargconc = conccodi
                      AND cargconc NOT IN
                      (SELECT l.CONCCODI FROM LDC_CONC_NO_ACRED l)
                AND concticl != cnuTipoconcliq
                AND cargsign != 'PA'
                ORDER BY cargconc;
        ELSE
            OPEN crConceptos FOR
                SELECT DISTINCT cargconc concepto, concdesc descripcion
                FROM cargos, concepto
                WHERE cargnuse = inuProducto
                      AND cargconc = conccodi
                      AND cargconc NOT IN
                      (SELECT l.CONCCODI FROM LDC_CONC_NO_ACRED l)
                AND concticl != cnuTipoconcliq
                AND cargsign != 'PA'
                UNION
                SELECT t.conccodi concepto, t.concdesc descripcion
                FROM concepto t
                WHERE t.conccodi <> -1
                AND concticl != cnuTipoconcliq
                AND conccodi != 145
                ORDER BY 1;
        END IF;

        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
        RETURN crConceptos;

    EXCEPTION
        WHEN OTHERS THEN
            Pkg_Error.setError;
            pkg_error.geterror(nuError, sbError);
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
    END fcrConceptosProducto;

    FUNCTION fcrPlanesFinanciacion
    (
        inuNroCuotas ldc_mantenimiento_notas_enc.cuotas%TYPE,
        inuservicio  servicio.servcodi%TYPE
    ) RETURN CONSTANTS_PER.TYREFCURSOR IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete:fcrPlanesFinanciacion
        Descripcion:

        Autor    : Sandra Muñoz

        Fecha    : 15-04-2016  CA 200-201

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificación
        -----------  -------------------    -------------------------------------
        15-04-2016   Sandra Muñoz           Creación
        ******************************************************************/

        csbMetodo   CONSTANT VARCHAR2(100) := csbPaquete||'fcrPlanesFinanciacion';
        crPlanes  CONSTANTS_PER.TYREFCURSOR;

    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_traza.trace('inuNroCuotas   <= '||inuNroCuotas, csbNivelTraza);
        pkg_traza.trace('inuservicio    <= '||inuservicio, csbNivelTraza);

        -- Consulta cursor referenciado
        OPEN crPlanes FOR
            SELECT pldicodi, pldidesc
            FROM plandife pd
            WHERE TRUNC(SYSDATE) BETWEEN pd.pldifein AND pd.pldifefi
                  AND (inuNroCuotas) BETWEEN pd.pldicumi AND pd.pldicuma
                  AND ((pldidesc NOT LIKE
                       decode(inuservicio, 7014, '%BRILLA%', 7056, '%BRILLA%', 7054, '%BRILLA%', 7052, '%BRILLA%') AND
                       pldidesc NOT LIKE
                       decode(inuservicio, 7014, '%FNB%', 7056, '%FNB%', 7054, '%FNB%', 7052, '%FNB%')) OR
                       (pldidesc LIKE
                       decode(inuservicio, 7055, '%BRILLA%', 7053, '%BRILLA%') OR
                       pldidesc LIKE
                       decode(inuservicio, 7055, '%FNB%', 7053, '%FNB%')))
            ORDER BY pldicodi DESC;

        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
        RETURN crPlanes;

    EXCEPTION
        WHEN OTHERS THEN
            Pkg_Error.setError;
            pkg_error.geterror(nuError, sbError);
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
    END;
    /*****************************************************************
    Propiedad intelectual de Gases del Caribe.

    Nombre del Paquete:fnutraePIva
    Descripcion:

    Autor    : Sandra Muñoz

    Fecha    : 14-08-2017

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.              Modificación
    -----------  -------------------    -------------------------------------
    14-08-2017   Luis Fren G.           Creación
    ******************************************************************/
    FUNCTION fnutraePIva
    (
        inuconcepto concepto.conccodi%TYPE, -- concepto
        inuserv     servsusc.sesuserv%TYPE -- porcentaje
    ) RETURN NUMBER IS
        nuporcentaje NUMBER := 0;
        
        cursor cuporcentaje is
        SELECT /*VITCCONS cons_tarifa, */
         nvl(ravtporc, 0) /*, cotcserv  servicio */
        FROM ta_tariconc a,
             ta_conftaco b,
             ta_vigetaco d,
             ta_rangvitc e
        WHERE b.cotcconc = inuconcepto -- inuConcepto
              AND a.tacocotc = b.cotccons
              AND d.vitctaco = a.tacocons
              AND D.VITCCONS = e.ravtvitc
              AND SYSDATE BETWEEN vitcfein AND vitcfefi
              AND ravtporc > 0
              AND cotcserv = inuserv;
        
    BEGIN
        if cuporcentaje%isopen then
            close cuporcentaje;
        end if;

        open cuporcentaje;
        fetch cuporcentaje into nuporcentaje;
        if cuporcentaje%notfound then
            close cuporcentaje;
            nuporcentaje := 0;
        else
            close cuporcentaje;
        end if;
        
        RETURN nuporcentaje;
    EXCEPTION
        WHEN others THEN
            nuporcentaje := 0;
            RETURN nuporcentaje;
    END;

    PROCEDURE proProyAcreditarDeuda
    (
        inuProducto pr_product.product_id%TYPE, -- Producto
        osbError    OUT VARCHAR2
    ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proProyAcreditarDeuda
        Descripcion:        Esta opcion se utilizara cuando se requiera dejar en cero la deuda de un
                            producto.
                            Se requiere que el sistema solicite como obligatorio el valor a acreditar,
                            la causa cargo.  Al procesar, el sistema debe aplicar una nota credito
                            en cada cuenta de cobro con saldo por el valor pendiente de pago de cada
                            una.
                            Por defecto el sistema debe cargar el valor a acreditar y lo debe obtener
                            de la deuda corriente para ese producto. Se debe permitir modificar el
                            valor y que sea igual o mayor a la deuda corriente, si es mayor, el valor
                            que sobra debe crearse como saldo a favor del producto.
                            La causa cargo sera la que se asigne a cada cargo CR creado.

        Autor    : Sandra Muñoz
        Fecha    : 15-04-2016  CA 200-201

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificación
        -----------  -------------------    -------------------------------------
        09-08-2023   diana.montes           OSF-1343:se modifica cursor cuDeudaConcepto
                                            para incluir cnuConcSubCovid cnuConcCovid y colocar distinct
        11-12-2018   Ronald Colpas          200-1650 Se modifica cursor cuDeudaConcepto para que tenga encuenta
                                            en la proyeccion el concepto subsidio
        15-04-2016   Sandra Muñoz           Creación
        ******************************************************************/

        csbMetodo   CONSTANT VARCHAR2(100) := csbPaquete||'proProyAcreditarDeuda';
        --nuDeudaTotal NUMBER; -- Deuda total del producto
        nuValorDigitado NUMBER; --valor digitado en la pantalla

        CURSOR cuDeudaConcepto IS
            SELECT distinct decode(signo_corriente, csbDebito, csbCredito, csbDebito) signo_corriente,
                   valor_corriente,
                   valor_vencido,
                   concepto,
                   valor_diferido,
                   signo_diferido
            FROM LDC_MANTENIMIENTO_NOTAS_PROY lmn
            WHERE lmn.sesion = gnuSesion
                  AND lmn.producto = inuProducto
                  AND lmn.origen = 'D'
                  AND (lmn.signo_corriente = csbDebito -- Deuda real de los productos
                  OR lmn.concepto  in (cnuConcSubsidio,cnuConcSubCovid,cnuConcCovid)); 

      
        
        
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_traza.trace('inuProducto    <= '||inuProducto, csbNivelTraza);
        
        pkg_traza.trace('gnuSesion ' || gnuSesion, csbNivelTraza);
        
        -- Validar datos obligatorios
        IF inuProducto IS NULL THEN
            osbError := 'Falta indicar el producto al que se le acreditara la deuda';
            pkg_error.setErrorMessage( isbMsgErrr => osbError);
        END IF;

       

        -- Obtener los conceptos con deuda del producto
        FOR rgDeudaConcepto IN cuDeudaConcepto
        LOOP

            -- Crear registro CR
            proInsMantenimientoNotaProy(inuProducto => inuProducto, --
                                        isbSignoCorriente => rgDeudaConcepto.Signo_Corriente, --csbCredito, --
                                        inuValorCorriente => rgDeudaConcepto.Valor_Corriente, --
                                        inuValorVencido => rgDeudaConcepto.Valor_Vencido, --
                                        inuConcepto => rgDeudaConcepto.Concepto, --
                                        isbOrigen => 'P', --
                                        inuValorDiferido => 0, --
                                        isbSignoDiferido => 0, --
                                        osbError => osbError);

            IF osbError IS NOT NULL THEN
                pkg_error.setErrorMessage( isbMsgErrr => osbError);
            END IF;

        END LOOP;

        pkg_traza.trace('osbError => '||osbError, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
        
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_error.geterror(nuError, sbError);
            osbError := sbError;
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
        WHEN OTHERS THEN
            Pkg_Error.setError;
            pkg_error.geterror(nuError, sbError);
            osbError := sbError;
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
    END;

    PROCEDURE proProyAcreditarConcepto
    (
        inuProducto pr_product.product_id%TYPE, -- Producto
        inuConcepto concepto.conccodi%TYPE, -- Concepto
        osbError    OUT VARCHAR2
    ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proProyAcreditarConcepto
        Descripcion:        Esta opcion se utilizara cuando se requiera dejar en cero la deuda de un
                            concepto para el producto que se esta procesando.
                            El sistema solo debe permitir ingresar conceptos que alguna vez hayan
                            sido facturados al producto, es decir, que esten asociados a las cuentas
                            de cobro del producto sin importar si tienen saldo o no.

        Autor    : Sandra Muñoz
        Fecha    : 15-04-2016  CA 200-201

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificación
        -----------  -------------------    -------------------------------------
        24-04-2019   Ronald Colpas          Caso-200-1650 Se modifica para excluir de la proyeccion los
                                            conceptos subsidio y contribucion, el iva se calcula
                                            con respecto al valor ingresado en el concepto.
                                            Se modifico para que tenga encuenta cuando el valor deuda concepto
                                            sea menor que el digitado

        13-12-2018   Ronald Colpas          Caso-200-1650 se modifica el servicio para que proyecte
                                            correctamente la novedad de acreditar por concepto.
                                            se tiene encuenta cuendo el concepto tenga IVA para que lo proyecte.
                                            Si se acredita por concepto consumo se proyecta subsidio o contribucion
                                            si el valor acreditar del concepto base es difernte
                                            a la deuda real del concepto base se calcula el IVA que
                                            tenga este de acuerdo al procenteje calculado por la
                                            funcion fnutraePIva


        15-04-2016   Sandra Muñoz           Creación
        ******************************************************************/

        csbMetodo         VARCHAR2(4000) := csbPaquete||'proProyAcreditarConcepto';
        nuValorAAcreditar NUMBER; -- Deuda total del concepto
        nuValorSubsidio   NUMBER; --valor del subsidio
        nuValorIva        NUMBER; --valor de Iva
        nuConcIva         NUMBER := 0; --concept Iva
        nuConcMora        NUMBER; --concepto de mora
        nuValorMora       NUMBER; --valor de la mora
        nuValorDigitado   NUMBER; --valor digitado en la pantalla

        nuConcregistra    NUMBER := 0;
        nuValorActconc    NUMBER; -- Deuda actual del concepto
        nuValorVenconc    NUMBER; -- Deuda actual del concepto
        nuPorIva          NUMBER; -- Porcentage IVA
        nuValorActIVA     NUMBER; -- Deuda actual del concepto IVA
        nuValorVenIVA     NUMBER; -- Deuda actual del concepto IVA
        nuValorsubsidioCovid NUMBER; --valor del subsidio
        nuValorCovid      NUMBER; --valor del subsidio
        
       
        --caso 200-1650 Cursor que consulta la deuda proyectada para el concepto seleccionado
        CURSOR cuDeudaConcepto IS
          SELECT decode(signo_corriente, csbDebito, csbCredito, csbDebito) signo_corriente,
                 valor_corriente,
                 valor_vencido,
                 concepto,
                 valor_diferido,
                 signo_diferido
            FROM LDC_MANTENIMIENTO_NOTAS_PROY lmn
           WHERE lmn.sesion = gnuSesion
             AND lmn.producto = inuProducto
             AND lmn.origen = 'D'
             AND lmn.signo_corriente = csbDebito
             AND lmn.concepto = inuConcepto;



      --caso 200-1650 Consulta el concepto IVA del base
       CURSOR cuConcIva is
          SELECT c.coblconc
            FROM concbali c
           WHERE c.coblcoba = inuConcepto
             AND c.coblcoba <> 137
             AND EXISTS (SELECT 1
                    FROM concepto t
                   WHERE t.conccodi = c.coblconc
                     AND t.concticl = cnuTipoconcliq);

        cursor cuValor is
        SELECT nvl(SUM(nvl(valor_corriente, 0)) /*+ SUM(nvl(valor_diferido, 0))*/, 0) deuda_corr,
               NVL(SUM(nvl(valor_vencido, 0)), 0)  deuda_vencida 
        FROM LDC_MANTENIMIENTO_NOTAS_PROY lmn
        WHERE lmn.sesion = gnuSesion
              AND lmn.producto = inuProducto
              AND lmn.origen = 'D'
              AND lmn.signo_corriente = csbDebito
              AND lmn.concepto = inuConcepto -- Deuda real del concepto
        ;
        
        cursor cuDigitado is
        SELECT e.valor
        FROM ldc_mantenimiento_notas_enc e
        WHERE e.producto = inuProducto
              AND e.concepto = inuConcepto
              AND e.sesion = gnuSesion;

    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_traza.trace('inuProducto    <= '||inuProducto, csbNivelTraza);
        pkg_traza.trace('inuConcepto    <= '||inuConcepto, csbNivelTraza);
        
        if cuValor%isopen then
            close cuValor;
        end if;
        
        if cuDigitado%isopen then
            close cuDigitado;
        end if;

        -- Validar datos obligatorios
        IF inuProducto IS NULL THEN
            osbError := 'Falta indicar el producto al que se le acreditara la deuda';
            pkg_error.setErrorMessage( isbMsgErrr => osbError);
        END IF;

        IF inuConcepto IS NULL THEN
            osbError := 'Falta indicar el concepto al que se va a acreditar';
            pkg_error.setErrorMessage( isbMsgErrr => osbError);
        ELSE
            proValidaConceptoYaFacurado(inuProducto => inuProducto, inuConcepto => inuConcepto, osbError => osbError);
            IF osbError IS NOT NULL THEN
                pkg_error.setErrorMessage( isbMsgErrr => osbError);
            END IF;
        END IF;
        nuValorAAcreditar := 0;
        -- Identificar la deuda total del concepto
        open cuValor;
        fetch cuValor into nuValorActconc, nuValorVenconc;
        close cuValor;
        
        --si el valor es cero entonces se saca del valor digitado

        --caso200-1650 Mod.13.12.2018 Valor acreditar actual + vencido
        nuValorAAcreditar := nuValorActconc + nuValorVenconc;

        open cuDigitado;
        fetch cuDigitado into nuValorDigitado;
        if cuDigitado%notfound then
            close cuDigitado;
            osbError := 'No fue posible determinar el valor digitado para el ajuste';
            pkg_error.setErrorMessage( isbMsgErrr => osbError);
        end if;
        close cuDigitado;

        IF nuValordigitado > nuValorAAcreditar THEN

            --caso200-1650 Mod.13.12.2018 el valor restante es cargado en actual o vencido
            IF nuValorActconc = 0 THEN
              nuValorVenconc := nuValorDigitado;
            ELSE
              nuValorActconc := nuValorActconc + (nuValorDigitado - nuValorAAcreditar);
            END IF;

        --mod.24.04.2019 si el valor digitado es menor al acreditar
        ELSIF nuValordigitado < nuValorAAcreditar THEN
            IF nuValorActconc = 0 THEN
              nuValorVenconc := nuValorDigitado;
            ELSIF nuValorVenconc = 0 THEN
              nuValorActconc := nuValorDigitado;
            ELSE
              --Si tiene deuda en el actual y vencido
              if (nuValorDigitado - nuValorVenconc) <= 0 then
                nuValorVenconc := nuValorDigitado;
              else
                nuValorActconc := nuValorDigitado - nuValorVenconc;
              end if;

            END IF;
        END IF;

        --caso 200-1650 Obtener los conceptos con deuda del producto
        FOR rgDeudaConcepto IN cuDeudaConcepto
        LOOP
            nuConcregistra := 1;
            IF rgDeudaConcepto.Concepto = inuConcepto THEN
               rgDeudaConcepto.Valor_Corriente := nuValorActconc;
               rgDeudaConcepto.Valor_Vencido := nuValorVenconc;
            END IF;

            -- Crear registro CR
            proInsMantenimientoNotaProy(inuProducto => inuProducto, --
                                        isbSignoCorriente => rgDeudaConcepto.Signo_Corriente, --csbCredito, --
                                        inuValorCorriente => rgDeudaConcepto.Valor_Corriente, --
                                        inuValorVencido => rgDeudaConcepto.Valor_Vencido, --
                                        inuConcepto => rgDeudaConcepto.Concepto, --
                                        isbOrigen => 'P', --
                                        inuValorDiferido => 0, --
                                        isbSignoDiferido => 0, --
                                        osbError => osbError);

            IF osbError IS NOT NULL THEN
                pkg_error.setErrorMessage( isbMsgErrr => osbError);
            END IF;

            --mod.24.04.2019 validamos si el concepto base tiene Iva para calcularlo
            OPEN cuConcIva;
            FETCH cuConcIva INTO nuConcIva;
            IF cuConcIva%FOUND THEN
              --Se proyecta el valor calculado del IVA
              --Realiza calculo para el valor del IVA
                nuPorIva   := fnutraePIva(inuconcepto => nuConcIva, inuserv => PKG_BCPRODUCTO.FNUTIPOPRODUCTO(inuProducto));
                nuValorIva := round(nuValorDigitado * (nuPorIva / 100), 0);

                pkg_traza.trace('Acredita concepto IVA: '||nuConcIva||' va a insertar valor de: '||nuValorIva||' porcentaje IVA: '|| nuPorIva,csbNivelTraza);
                
                IF nuValorIva != 0 THEN
                    IF rgDeudaConcepto.Valor_Corriente <> 0 then
                        nuValorActIVA := nuValorIva;
                        nuValorVenIVA := 0;
                    ELSE
                        nuValorActIVA := 0;
                        nuValorVenIVA := nuValorIva;
                    END IF;
                    proInsMantenimientoNotaProy(inuProducto => inuProducto, --
                                            isbSignoCorriente => csbCredito, --
                                            inuValorCorriente => nuValorActIVA, --
                                            inuValorVencido => nuValorVenIVA, --
                                            inuConcepto => nuConcIva, --
                                            isbOrigen => 'P', --
                                            inuValorDiferido => 0, --
                                            isbSignoDiferido => 0, --
                                            osbError => osbError);

                    IF osbError IS NOT NULL THEN
                        pkg_error.setErrorMessage( isbMsgErrr => osbError);
                    END IF;
                END IF;
            END IF;
            CLOSE cuConcIva;
        END LOOP;

        --Si el valor no fue proyectado por deuda pendiente se proyecta en actual
        IF nuConcregistra = 0 THEN
            proInsMantenimientoNotaProy(inuProducto => inuProducto, --
                                      isbSignoCorriente => csbCredito, --
                                      inuValorCorriente => nuValorDigitado, --
                                      inuValorVencido => 0, --
                                      inuConcepto => inuConcepto, --
                                      isbOrigen => 'P', --
                                      inuValorDiferido => 0, --
                                      isbSignoDiferido => 0, --
                                      osbError => osbError);

            IF osbError IS NOT NULL THEN
                pkg_error.setErrorMessage( isbMsgErrr => osbError);
            END IF;

            OPEN cuConcIva;
            FETCH cuConcIva INTO nuConcIva;
            IF cuConcIva%FOUND THEN
              --Se proyecta el valor calculado del IVA
              --Realiza calculo para el valor del IVA
                nuPorIva   := fnutraePIva(inuconcepto => nuConcIva, inuserv => PKG_BCPRODUCTO.FNUTIPOPRODUCTO(inuProducto));
                nuValorIva := round(nuValorDigitado * (nuPorIva / 100), 0);

                pkg_traza.trace('Acredita concepto IVA: '||nuConcIva||' va a insertar valor de: '||nuValorIva||' porcentaje IVA: '|| nuPorIva,csbNivelTraza);
                IF nuValorIva != 0 THEN
                    proInsMantenimientoNotaProy(inuProducto => inuProducto, --
                                            isbSignoCorriente => csbCredito, --
                                            inuValorCorriente => nuValorIva, --
                                            inuValorVencido => 0, --
                                            inuConcepto => nuConcIva, --
                                            isbOrigen => 'P', --
                                            inuValorDiferido => 0, --
                                            isbSignoDiferido => 0, --
                                            osbError => osbError);

                    IF osbError IS NOT NULL THEN
                        pkg_error.setErrorMessage( isbMsgErrr => osbError);
                    END IF;
                END IF;
            END IF;
            CLOSE cuConcIva;

        END IF;

        pkg_traza.trace('osbError => '||osbError, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
        
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_error.geterror(nuError, sbError);
            osbError := sbError;
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
        WHEN OTHERS THEN
            Pkg_Error.setError;
            pkg_error.geterror(nuError, sbError);
            osbError := sbError;
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
    END proProyAcreditarConcepto;



    PROCEDURE proProyAcreditarConceptoYCC
    (
        inuProducto pr_product.product_id%TYPE, -- Producto
        inuConcepto concepto.conccodi%TYPE, -- Concepto
        inuValor    cargos.cargvalo%TYPE, -- Valor a acreditar
        inuCuenCobr cuencobr.cucocodi%TYPE, -- Cuenta de cobro
        osbError    OUT VARCHAR2
    ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proProyAcreditarConceptoYCC
        Descripcion:        Esta opcion se utilizara cuando se desee acreditar por un valor mayor al
                            de la deuda del concepto.
                            El sistema solo debe permitir ingresar conceptos que alguna vez hayan
                            sido facturados al producto, es decir, que esten asociados a las cuentas
                            de cobro del producto sin importar si tienen saldo o no.

        Autor    : Sandra Muñoz
        Fecha    : 15-04-2016  CA 200-201

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificación
        -----------  -------------------    -------------------------------------
        09/08/2023   Diana.Montes           OSF-1343: Se modifica cursor cuConceptos para que tenga 
                                            en cuenta el concepto de subsido por covid 167. 130
        24-04-2019   Ronald Colpas          Caso-200-1650 Se modifica para excluir de la proyeccion los
                                            conceptos subsidio y contribucion, el iva se calcula
                                            con respecto al valor ingresado en el concepto.
                                            Se modifico para que tenga encuenta cuando el valor deuda concepto
                                            sea menor que el digitado

        16-12-2018   Ronald Colpas          Se modifica para que proyecte la deuda acreditar
                                            por concepto y cuenta de cobro correcta.
                                            si el concepto tiene IVA este se proyecta.

        15-04-2016   Sandra Muñoz           Creación
        ******************************************************************/

        csbMetodo       VARCHAR2(4000) := csbPaquete||'proProyAcreditarConceptoYCC';
        nuValorSubsidio NUMBER; --valor del subsidio
        nuValorIva      NUMBER; --valor de Iva
        nuConcIva       NUMBER := 0; --concept Iva
        nuConcMora      NUMBER; --concepto de mora
        nuValorMora     NUMBER; --valor de la mora

        nuVenc           NUMBER; --vencimiento de la cta 0 vencida, 1 actual
        nuValorActual    NUMBER; --valor actual
        nuValorVencid    NUMBER; --valor vencido
        nuValorConc      NUMBER; --valor del concepto
        nuValor          NUMBER:= 0; --Valor del concepto digitado
        nuPorIva         NUMBER; --porcentaje IVA

        nuValorActIVA     NUMBER; -- Deuda actual del concepto IVA
        nuValorVenIVA     NUMBER; -- Deuda actual del concepto IVA
        nuValorsubsidioCovid NUMBER; --valor del subsidio
        nuValorCovid        NUMBER; --valor del subsidio
        
        
 --caso 200-1650 Valida si la cuenta de cobro es a la fecha o vencida
        CURSOR cuVencta is
          SELECT COUNT(1)
            FROM cuencobr
           WHERE cucocodi = inuCuenCobr
             AND cucofeve > sysdate;

       --caso 200-1650 Consulta el concepto IVA del base
       CURSOR cuConcIva is
          SELECT c.coblconc
            FROM concbali c
           WHERE c.coblcoba = inuConcepto
             AND c.coblcoba <> 137
             AND EXISTS (SELECT 1
                    FROM concepto t
                   WHERE t.conccodi = c.coblconc
                     AND t.concticl = cnuTipoconcliq);

    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_traza.trace('inuProducto    <= '||inuProducto, csbNivelTraza);
        pkg_traza.trace('inuConcepto    <= '||inuConcepto, csbNivelTraza);
        pkg_traza.trace('inuValor       <= '||inuValor, csbNivelTraza);
        pkg_traza.trace('inuCuenCobr    <= '||inuCuenCobr, csbNivelTraza);

        -- Validar datos obligatorios
        IF inuProducto IS NULL THEN
            osbError := 'Falta indicar el producto al que se le acreditara la deuda';
            pkg_error.setErrorMessage( isbMsgErrr => osbError);
        END IF;

        IF inuConcepto IS NULL THEN
            osbError := 'Falta indicar el concepto al que se va a acreditar';
            pkg_error.setErrorMessage( isbMsgErrr => osbError);
        ELSE

            proValidaConceptoYaFacurado(inuProducto => inuProducto, --
                                        inuConcepto => inuConcepto, --
                                        osbError => osbError);
            IF osbError IS NOT NULL THEN
                pkg_error.setErrorMessage( isbMsgErrr => osbError);
            END IF;
        END IF;

        IF inuValor IS NULL THEN
            osbError := 'Falta ingresar el valor a acreditar';
            pkg_error.setErrorMessage( isbMsgErrr => osbError);
        END IF;

        IF inuCuenCobr IS NULL THEN
            osbError := 'Falta la cuenta de cobro en la que se acreditara el concepto';
            pkg_error.setErrorMessage( isbMsgErrr => osbError);
        END IF;

        --Mod.15.12.2018 Validamos el vencimiento de la cuenta de cobro para indicar si es
        --actual o vencida
        OPEN cuVencta;
        FETCH cuVencta INTO nuVenc;
        CLOSE cuVencta;

        IF nuVenc = 0 THEN
          nuValorActual := 0;
          nuValorVencid := inuValor;
        ELSE
          nuValorActual := inuValor;
          nuValorVencid := 0;
        END IF;

        --Hallamos el valor del concepto
        proDeudaConceptoCC(inuCuenCobr => inuCuenCobr,
                           inuConcepto => inuConcepto,
                           onuSaldoConcepto => nuValor,
                           osbError => osbError);

        IF osbError IS NOT NULL THEN
            pkg_error.setErrorMessage( isbMsgErrr => osbError);
        END IF;

        proInsMantenimientoNotaProy(inuProducto => inuProducto, --
                                    isbSignoCorriente => csbCredito, --
                                    inuValorCorriente => nuValorActual,
                                    inuValorVencido => nuValorVencid, --
                                    inuConcepto => inuConcepto, --
                                    isbOrigen => 'P', --
                                    inuValorDiferido => 0, --
                                    isbSignoDiferido => 0, --
                                    osbError => osbError);
        IF osbError IS NOT NULL THEN
            pkg_error.setErrorMessage( isbMsgErrr => osbError);
        END IF;

        --mod.24.04.2019 validamos si el concepto base tiene Iva para calcularlo
        OPEN cuConcIva;
        FETCH cuConcIva INTO nuConcIva;
        IF cuConcIva%FOUND THEN
          --Se proyecta el valor calculado del IVA
          --Realiza calculo para el valor del IVA
            nuPorIva   := fnutraePIva(inuconcepto => nuConcIva, inuserv => PKG_BCPRODUCTO.FNUTIPOPRODUCTO(inuProducto));
            nuValorIva := round(inuValor * (nuPorIva / 100), 0);

            pkg_traza.trace('Acredita concepto IVA: '||nuConcIva||' va a insertar valor de: '||nuValorIva||' porcentaje IVA: '||nuPorIva,csbNivelTraza);
            
            IF nuValorIva != 0 THEN
                IF nuValorActual <> 0 then
                    nuValorActIVA := nuValorIva;
                    nuValorVenIVA := 0;
                ELSE
                    nuValorActIVA := 0;
                    nuValorVenIVA := nuValorIva;
                END IF;
                proInsMantenimientoNotaProy(inuProducto => inuProducto, --
                                        isbSignoCorriente => csbCredito, --
                                        inuValorCorriente => nuValorActIVA, --
                                        inuValorVencido => nuValorVenIVA, --
                                        inuConcepto => nuConcIva, --
                                        isbOrigen => 'P', --
                                        inuValorDiferido => 0, --
                                        isbSignoDiferido => 0, --
                                        osbError => osbError);

                IF osbError IS NOT NULL THEN
                    pkg_error.setErrorMessage( isbMsgErrr => osbError);
                END IF;
            END IF;
        END IF;
        CLOSE cuConcIva;

        pkg_traza.trace('osbError => '||osbError, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
        
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_error.geterror(nuError, sbError);
            osbError := sbError;
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
        WHEN OTHERS THEN
            Pkg_Error.setError;
            pkg_error.geterror(nuError, sbError);
            osbError := sbError;
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
    END proProyAcreditarConceptoYCC;

    PROCEDURE proProyAcreditarCuentaCobro
    (
        inuProducto pr_product.product_id%TYPE, -- Producto
        inuCuenCobr cuencobr.cucocodi%TYPE, -- CuentaCobro
        osbError    OUT VARCHAR2
    ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proProyAcreditarCuentaCobro
        Descripcion:        Esta opcion se utilizara cuando se requiere disminuir el saldo de una cuenta
                            de cobro o para un concepto especifico en la cuenta de cobro seleccionada.

        Se requiere que el sistema solicite como obligatorios la cuenta de cobro, la causa cargo.
        Al procesar, el sistema debe crear un cargo CR en la cuenta de cobro seleccionada para el
        concepto seleccionado por el valor ingresado y con la causa cargo indicado. Si no se
        selecciono concepto, se debe crear un cargo CR a cada concepto con saldo de la cuenta de
        cobro.

        El sistema debe permitir seleccionar cualquier cuenta de cobro asociada al producto seleccionado
        sin importar si tiene saldo o no.


        Autor    : Sandra Muñoz
        Fecha    : 15-04-2016  CA 200-201

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificación
        -----------  -------------------    -------------------------------------
        09-08-2023   diana.montes           OSF-1343: se ajusta para  tener en cuenta el subsidio covid  
                                            y consumo de covid
        15-12-2018   Ronald Colpas          Se modifica para prorretear la deuda de la cuenta de cobro
                                            cuando el valor digitado sea mayor al de la cuenta

        15-04-2016   Sandra Muñoz           Creación
        ******************************************************************/

        csbMetodo        VARCHAR2(4000) := csbPaquete||'proProyAcreditarCuentaCobro';
        nuSaldoConcepto  cargos.cargvalo%TYPE; -- Saldo del concepto
        nuSaldoCuenCobr  cuencobr.cucosacu%TYPE; -- Saldo de la cuenta de cobro
        nuValorDigitado  NUMBER; --valor digitado en la pantalla
        nuValorCc        cargos.cargvalo%TYPE; --valor de la cuenta de cobro
        nuvaloracreditar cargos.cargvalo%TYPE; --valor a acreditar
        nucantconc       NUMBER; --cantidad de conceptos en la cuenta de cobro
        swMayor          NUMBER := 0; --sw para saber si el valor es mayor
        nuValorSubsidio  NUMBER := 0;
        nuConcIva        NUMBER;
        nuValorIva       NUMBER := 0;
        nuConcMora       NUMBER;
        nuValorMora      NUMBER := 0;

        nuVenc           NUMBER; --vencimiento de la cta 0 vencida, 1 actual
        nuValorActual    NUMBER; --valor actual
        nuValorVencid    NUMBER; --valor vencido
        nuPorcentage     NUMBER; --Porcentaje para prorratear la deuda
        nuValorsubsidioCovid NUMBER := 0;
        nuValorCovid      NUMBER := 0;
        nuValorActualC    NUMBER := 0; --valor actualC
        nuValorVencidC    NUMBER:= 0; --valor vencidoC
        nuValorActualCv    NUMBER := 0; --valor actualC
        nuValorVencidCv    NUMBER:= 0; --valor vencidoC
        
        
        CURSOR cuConceptosCC IS
            SELECT DISTINCT cargconc
            FROM cargos c
            WHERE c.cargcuco = inuCuenCobr

            ;

        CURSOR cuVencta is
          SELECT COUNT(1)
            FROM cuencobr
           WHERE cucocodi = inuCuenCobr
             AND cucofeve > sysdate;

        cursor cuValorDigitado is
        SELECT e.valor
        FROM ldc_mantenimiento_notas_enc e
        WHERE e.producto = inuProducto
        AND e.cuenta_cobro = inuCuenCobr
        AND e.sesion = gnuSesion;
        
        cursor cuSaldoCuenCobr is
        SELECT nvl(cc.cucosacu, 0)
        FROM cuencobr cc
        WHERE cc.cucocodi = inuCuenCobr;

    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_traza.trace('inuProducto    <= '||inuProducto, csbNivelTraza);
        pkg_traza.trace('inuCuenCobr    <= '||inuCuenCobr, csbNivelTraza);
        
        pkg_traza.trace('gnuSesion ' || gnuSesion, csbNivelTraza);
        
        if cuValorDigitado%isopen then
            close cuValorDigitado;
        end if;
        
        if cuSaldoCuenCobr%isopen then
            close cuSaldoCuenCobr;
        end if;
        
        -- Validar datos obligatorios
        IF inuProducto IS NULL THEN
            osbError := 'Falta indicar el producto al que se le acreditara la deuda';
            pkg_error.setErrorMessage( isbMsgErrr => osbError);
        END IF;

        IF inuCuenCobr IS NULL THEN
            osbError := 'Falta indicar el numero de cuenta de cobro a acreditar';
            pkg_error.setErrorMessage( isbMsgErrr => osbError);
        END IF;
        --se guarda el valor que se digito
        open cuValorDigitado;
        fetch cuValorDigitado into nuValorDigitado;
        if cuValorDigitado%notfound then
            close cuValorDigitado;
            osbError := 'No fue posible determinar el valor digitado para el ajuste';
            pkg_error.setErrorMessage( isbMsgErrr => osbError);
        end if;
        close cuValorDigitado;

        -- Obtener el saldo total de la cuenta de cobro
        open cuSaldoCuenCobr;
        fetch cuSaldoCuenCobr into nuSaldoCuenCobr;
        if cuSaldoCuenCobr%notfound then
            close cuSaldoCuenCobr;
            osbError := 'No fue posible obtener el saldo de la cuenta de cobro ' || inuCuenCobr;
            pkg_error.setErrorMessage( isbMsgErrr => osbError);
        end if;
        close cuSaldoCuenCobr;
            
        IF nuValorDigitado > nuSaldoCuenCobr THEN            
            swMayor          := 1;
        END IF;

        --Mod.15.12.2018 Validamos el vencimiento de la cuenta de cobro para indicar si es
        --actual o vencida
        OPEN cuVencta;
        FETCH cuVencta INTO nuVenc;
        CLOSE cuVencta;

        -- No procesar si la cuenta de cobro no tiene saldo
        IF nuSaldoCuenCobr > 0 THEN

            -- Crear un cargo CR por el saldo de cada concepto de la cuenta de cobro
            FOR rgConceptosCC IN cuConceptosCC
            LOOP

                proDeudaConceptoCC(inuCuenCobr => inuCuenCobr, --
                                   inuConcepto => rgConceptosCC.Cargconc, --
                                   onuSaldoConcepto => nuSaldoConcepto, --
                                   osbError => osbError);

                IF osbError IS NOT NULL THEN
                    pkg_error.setErrorMessage( isbMsgErrr => osbError);
                END IF;

                --Mod.15.12.2018 Se verifica el vencimiento de la cuenta de cobro para indicar actual y vencido
                IF nuVenc = 0 THEN
                  nuValorActual := 0;
                  nuValorVencid := nuSaldoConcepto;
                ELSE
                  nuValorActual := nuSaldoConcepto;
                  nuValorVencid := 0;
                END IF;
                --  se crea if
                IF rgConceptosCC.Cargconc not in (cnuConcSubsidio,cnuConcSubCovid,cnuConcCovid)
                THEN
                    IF nuSaldoConcepto > 0 --si el valor digitado es menor hace el calculo normal
                       AND swMayor = 0 THEN
                        proInsMantenimientoNotaProy(inuProducto => inuProducto, --
                                                    isbSignoCorriente => csbCredito, --
                                                    inuValorCorriente => nuValorActual, --nuSaldoConcepto
                                                    inuValorVencido => nuValorVencid, --
                                                    inuConcepto => rgConceptosCC.Cargconc, --
                                                    isbOrigen => 'P', --
                                                    inuValorDiferido => 0, --
                                                    isbSignoDiferido => 0, --
                                                    osbError => osbError);

                        IF osbError IS NOT NULL THEN
                            pkg_error.setErrorMessage( isbMsgErrr => osbError);
                        END IF;
                    ELSIF nuSaldoConcepto > 0 THEN --mod.15.12.2018 Isempre y cuando el concepto tenga deuda
                        --mod.15.12.2018 realizamos el prorrateo para el concepto
                        --para indicar el valor que le corresponde
                        nuPorcentage := nuSaldoConcepto / nuSaldoCuenCobr;

                        nuValorActual := round(nuValorActual * nuPorcentage);
                        nuValorVencid := round(nuValorVencid * nuPorcentage);

                        --el valor digitado mayor se utiliza la proporcion del descuento
                        proInsMantenimientoNotaProy(inuProducto => inuProducto, --
                                                    isbSignoCorriente => csbCredito, --
                                                    inuValorCorriente => nuValorActual, --nuSaldoConcepto
                                                    inuValorVencido => nuValorVencid, --
                                                    inuConcepto => rgConceptosCC.Cargconc, --
                                                    isbOrigen => 'P', --
                                                    inuValorDiferido => 0, --
                                                    isbSignoDiferido => 0, --
                                                    osbError => osbError);

                        IF osbError IS NOT NULL THEN
                            pkg_error.setErrorMessage( isbMsgErrr => osbError);
                        END IF;
                    END IF;
                END IF;    
                nuValorSubsidio := 0;
                nuValorsubsidioCovid := 0;
                nuValorCovid :=0;
                IF rgConceptosCC.Cargconc = cnuConcConsumo THEN
                    pkg_traza.trace('acredita concepto entro por concepto 31',csbNivelTraza);
                    --- subsidio cnuConcSubsidio
                    proDeudaConceptoCC(inuCuenCobr => inuCuenCobr,
                                       inuConcepto => cnuConcSubsidio,
                                       onuSaldoConcepto => nuValorsubsidio,
                                       osbError => osbError);
                    IF osbError IS NOT NULL THEN
                        pkg_error.setErrorMessage( isbMsgErrr => osbError);
                    END IF;
                    ---  subsidio cnuConcSubCovid
                    proDeudaConceptoCC(inuCuenCobr => inuCuenCobr,
                                       inuConcepto => cnuConcSubCovid,
                                       onuSaldoConcepto => nuValorsubsidioCovid,
                                       osbError => osbError);
                    IF osbError IS NOT NULL THEN
                        pkg_error.setErrorMessage( isbMsgErrr => osbError);
                    END IF;
                    ---  consumo cnuConcCovid
                    proDeudaConceptoCC(inuCuenCobr => inuCuenCobr,
                                       inuConcepto => cnuConcCovid,
                                       onuSaldoConcepto => nuValorCovid,
                                       osbError => osbError);
                    IF osbError IS NOT NULL THEN
                        pkg_error.setErrorMessage( isbMsgErrr => osbError);
                    END IF;
                    --Mod.15.12.2018 Se verifica el vencimiento de la cuenta de cobro para indicar actual y vencido
                    --  se modifica el valor para el subsidio de covid y consumo covid
                    --  concepto 130
                    IF nuVenc = 0 THEN
                      nuValorActual := 0;
                      nuValorVencid := nuValorSubsidio;
                      nuValorActualC := 0;
                      nuValorVencidC := nuValorsubsidioCovid;
                      nuValorActualCv := 0;
                      nuValorVencidCv := nuValorCovid;
                    ELSE
                      nuValorActual := nuValorSubsidio;
                      nuValorVencid := 0;
                      nuValorActualC := nuValorsubsidioCovid;
                      nuValorVencidC := 0;
                      nuValorActualCv := nuValorCovid;
                      nuValorVencidCv := 0;
                    END IF;

                END IF;

                IF nuValorSubsidio <> 0 THEN
                    pkg_traza.trace('acredita concepto va a insertar valor del subsidio '||nuValorSubsidio,csbNivelTraza);
                    proInsMantenimientoNotaProy(inuProducto => inuProducto, --
                                                isbSignoCorriente => csbDebito, --
                                                inuValorCorriente => nuValorActual * -1, --
                                                inuValorVencido => nuValorVencid * -1, --
                                                inuConcepto => cnuConcSubsidio, --
                                                isbOrigen => 'P', --
                                                inuValorDiferido => 0, --
                                                isbSignoDiferido => 0, --
                                                osbError => osbError);
                END IF;
                
                 
                IF nuValorsubsidioCovid <> 0 THEN
                    pkg_traza.trace('acredita concepto va a insertar valor del subsidio  covid '||nuValorsubsidioCovid,csbNivelTraza);
                    IF nvl(nuValorsubsidioCovid,0) < 0 THEN
                    
                        proInsMantenimientoNotaProy(inuProducto => inuProducto, --
                                                isbSignoCorriente => csbDebito, --
                                                inuValorCorriente => nuValorActualC * -1, --
                                                inuValorVencido => nuValorVencidC * -1, --
                                                inuConcepto => cnuConcSubCovid, --
                                                isbOrigen => 'P', --
                                                inuValorDiferido => 0, --
                                                isbSignoDiferido => 0, --
                                                osbError => osbError);
                    ELSE
                        proInsMantenimientoNotaProy(inuProducto => inuProducto, --
                                                isbSignoCorriente => csbCredito, --
                                                inuValorCorriente => nuValorActualC , --
                                                inuValorVencido => nuValorVencidC, --
                                                inuConcepto => cnuConcSubCovid, --
                                                isbOrigen => 'P', --
                                                inuValorDiferido => 0, --
                                                isbSignoDiferido => 0, --
                                                osbError => osbError);    
                    END IF;                                                    
                END IF;
                
                IF nuValorCovid <> 0 THEN
                
                    pkg_traza.trace('acredita concepto va a insertar valor del consumo  covid' ||nuValorCovid,csbNivelTraza);
                    
                    IF nvl(nuValorCovid,0) < 0 THEN                
                        proInsMantenimientoNotaProy(inuProducto => inuProducto, --
                                                isbSignoCorriente => csbDebito, --
                                                inuValorCorriente => nuValorActualCv * -1, --
                                                inuValorVencido => nuValorVencidCv * -1, --
                                                inuConcepto => cnuConcCovid, --
                                                isbOrigen => 'P', --
                                                inuValorDiferido => 0, --
                                                isbSignoDiferido => 0, --
                                                osbError => osbError);
                    ELSE
                        proInsMantenimientoNotaProy(inuProducto => inuProducto, --
                                                isbSignoCorriente => csbCredito, --
                                                inuValorCorriente => nuValorActualCv, --
                                                inuValorVencido => nuValorVencidCv, --
                                                inuConcepto => cnuConcCovid, --
                                                isbOrigen => 'P', --
                                                inuValorDiferido => 0, --
                                                isbSignoDiferido => 0, --
                                                osbError => osbError);
                    END IF;                            
                END IF;
                --se busca si el concepto tiene iva
                
            END LOOP;
        ELSE
            pkg_traza.trace('La cuenta de cobro '||inuCuenCobr||' no se puede acreditar ya que no tiene saldo',csbNivelTraza);
        END IF;

        pkg_traza.trace('osbError => '||osbError, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
        
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_error.geterror(nuError, sbError);
            osbError := sbError;
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
        WHEN OTHERS THEN
            Pkg_Error.setError;
            pkg_error.geterror(nuError, sbError);
            osbError := sbError;
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
    END;

    PROCEDURE proProyDebitarConcepto
    (
        inuProducto pr_product.product_id%TYPE, -- Producto
        inuConcepto concepto.conccodi%TYPE, -- Concepto
        inuValor    cargos.cargvalo%TYPE, -- Valor a debitar
        inuPlan     plandife.pldicodi%type,
        osbError    OUT VARCHAR2
    ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proProyDebitarConcepto
        Descripcion:        Esta opcion se utilizara cuando se requiera aumentar la deuda de un
                            concepto para el producto seleccionado.

        Autor    : Sandra Muñoz
        Fecha    : 15-04-2016  CA 200-201

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificación
        -----------  -------------------    -------------------------------------
        19-12-2018   Ronald Colpas          Se modifica para que se proyecte el concepto IVA

        15-04-2016   Sandra Muñoz           Creación
        ******************************************************************/

        csbMetodo   CONSTANT VARCHAR2(100) := csbPaquete||'proProyDebitarConcepto';
        nuValorSubsidio NUMBER; --valor del subsidio
        nuValorIva      NUMBER; --valor de Iva
        nuConcIva       NUMBER := 0; --concept Iva
        nuConcMora      NUMBER; --concepto de mora
        nuValorMora     NUMBER; --valor de la mora
        nuPorIva        NUMBER; --porcentaje de iva del concepto
        nuserv          NUMBER; --codigo del tipo de servicio
        nuMetodo        NUMBER; --Metodo de calculo
        nuValorsubsidioCovid NUMBER;
        nuValorCovid    NUMBER;
        
        --caso 200-1650 Consulta el concepto IVA del base
        CURSOR cuConcIva is
          SELECT c.coblconc
            FROM concbali c
           WHERE c.coblcoba = inuConcepto
             AND c.coblcoba <> 137
             AND EXISTS (SELECT 1
                    FROM concepto t
                   WHERE t.conccodi = c.coblconc
                     AND t.concticl = cnuTipoconcliq);

        CURSOR cuPlandife is
          SELECT p.pldimccd from plandife p
           where p.pldicodi = inuPlan
             and p.pldifein <= sysdate
             and p.pldifefi >= sysdate;

    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_traza.trace('inuProducto    <= '||inuProducto, csbNivelTraza);
        pkg_traza.trace('inuConcepto    <= '||inuConcepto, csbNivelTraza);
        pkg_traza.trace('inuValor       <= '||inuValor, csbNivelTraza);
        pkg_traza.trace('inuPlan        <= '||inuPlan, csbNivelTraza);
        
        -- Validar datos obligatorios
        IF inuProducto IS NULL THEN
            osbError := 'Falta indicar el producto al que se le debitara el valor';
            pkg_error.setErrorMessage( isbMsgErrr => osbError);
        END IF;

        IF inuConcepto IS NULL THEN
            osbError := 'Falta indicar el concepto al que se le debitara el valor';
            pkg_error.setErrorMessage( isbMsgErrr => osbError);
        ELSE
            proValidaConceptoYaFacurado(inuProducto => inuProducto, inuConcepto => inuConcepto, osbError => osbError);
            IF osbError IS NOT NULL THEN
                NULL;
            END IF;
        END IF;

        IF inuValor IS NULL THEN
            osbError := 'Falta indicar el valor a debitar';
            pkg_error.setErrorMessage( isbMsgErrr => osbError);
        END IF;

        --Validamos si el concepto se carga a diferido para validar vigencia del plan de financiacion
        IF nvl(inuPlan, -1) != -1 THEN

            OPEN cuPlandife;
            FETCH cuPlandife INTO nuMetodo;
            IF cuPlandife%notfound THEN
                CLOSE cuPlandife;
                osbError := 'Plan definanciacion seleccionado no esta vigente.';
                pkg_error.setErrorMessage( isbMsgErrr => osbError);
            ELSE
                CLOSE cuPlandife;
            END IF;

            IF nuMetodo is null THEN
                osbError := 'Plan de financiacion: '||inuPlan||', no tiene metodo de calculo configurado';
                pkg_error.setErrorMessage( isbMsgErrr => osbError);
            END IF;

        END IF;
        -- Debitar el concepto
        proInsMantenimientoNotaProy(inuProducto => inuProducto, --
                                    isbSignoCorriente => NULL, --
                                    inuValorCorriente => 0, --
                                    inuValorVencido => 0, --
                                    inuConcepto => inuConcepto, --
                                    isbOrigen => 'P', --
                                    inuValorDiferido => inuValor, --
                                    isbSignoDiferido => NULL, --csbDebito
                                    osbError => osbError);

        IF osbError IS NOT NULL THEN
            pkg_error.setErrorMessage( isbMsgErrr => osbError);
        END IF;

        --Se valida si el IVA del concepto base
        OPEN cuConcIva;
        FETCH cuConcIva INTO nuConcIva;
        IF cuConcIva%FOUND THEN
          CLOSE cuConcIva;
          nuPorIva   := fnutraePIva(inuconcepto => nuConcIva, inuserv => PKG_BCPRODUCTO.FNUTIPOPRODUCTO(inuProducto));
          nuValorIva := round(inuValor * (nuPorIva / 100), 0);

          pkg_traza.trace('Proyectar concepto IVA: '||nuConcIva||', valor: '||nuValorIva,csbNivelTraza);

          proInsMantenimientoNotaProy(inuProducto => inuProducto, --
                                    isbSignoCorriente => NULL, --
                                    inuValorCorriente => 0, --
                                    inuValorVencido => 0, --
                                    inuConcepto => nuConcIva, --
                                    isbOrigen => 'P', --
                                    inuValorDiferido => nuValorIva, --
                                    isbSignoDiferido => NULL, 
                                    osbError => osbError);
        ELSE
          CLOSE cuConcIva;
        END IF;

        pkg_traza.trace('osbError => '||osbError, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
        
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_error.geterror(nuError, sbError);
            osbError := sbError;
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
        WHEN OTHERS THEN
            Pkg_Error.setError;
            pkg_error.geterror(nuError, sbError);
            osbError := sbError;
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
    END proProyDebitarConcepto;

    PROCEDURE proProyDebitarConceptoPM
    (
        inuProducto pr_product.product_id%TYPE, -- Producto
        inuConcepto concepto.conccodi%TYPE, -- Concepto
        inuValor    cargos.cargvalo%TYPE, -- Valor a acreditar
        isbpresente VARCHAR2, --indica si se va a traer a presente mes
        osbError    OUT VARCHAR2
    ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proProyDebitarConceptoPM para traer a presente mes
        Descripcion:        Esta opcion se utilizara cuando se requiera aumentar la deuda de un
                            concepto para el producto seleccionado y no diferirla.

        Autor    : Luis Fren G
        Fecha    : 15-09-2017  CA 200-818

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificación
        -----------  -------------------    -------------------------------------
        19-12-2018   Ronald Colpas          Se modifica para que proyecte la deuda a cargar a PM.
                                            para que consulte el concepto IVA que tenga asociado.

        15-09-2017   Luis Fren G           Creación
        ******************************************************************/

        csbMetodo   CONSTANT VARCHAR2(100) := csbPaquete||'proProyDebitarConceptoPM';
        nuValorSubsidio NUMBER; --valor del subsidio
        nuValorIva      NUMBER; --valor de Iva
        nuConcIva       NUMBER := 0; --concept Iva
        nuConcMora      NUMBER; --concepto de mora
        nuValorMora     NUMBER; --valor de la mora
        nuPorIva        NUMBER; --porcentaje de iva del concepto
        nuserv          NUMBER; --codigo del tipo de servicio
        RCSERVSUSC      SERVSUSC%ROWTYPE;
        RCPERIFACT      PERIFACT%ROWTYPE;
        nuValorsubsidioCovid NUMBER;
        nuValorCovid     NUMBER;
        --caso 200-1650 Consulta el concepto IVA del base
        CURSOR cuConcIva is
          SELECT c.coblconc
            FROM concbali c
           WHERE c.coblcoba = inuConcepto
             AND c.coblcoba <> 137
             AND EXISTS (SELECT 1
                    FROM concepto t
                   WHERE t.conccodi = c.coblconc
                     AND t.concticl = cnuTipoconcliq);

    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_traza.trace('inuProducto    <= '||inuProducto, csbNivelTraza);
        pkg_traza.trace('inuConcepto    <= '||inuConcepto, csbNivelTraza);
        pkg_traza.trace('inuValor       <= '||inuValor, csbNivelTraza);
        pkg_traza.trace('isbpresente    <= '||isbpresente, csbNivelTraza);

        -- Validar datos obligatorios
        IF inuProducto IS NULL THEN
            osbError := 'Falta indicar el producto al que se le debitara el valor';
            pkg_error.setErrorMessage( isbMsgErrr => osbError);
        END IF;

        IF inuConcepto IS NULL THEN
            osbError := 'Falta indicar el concepto al que se le debitara el valor';
            pkg_error.setErrorMessage( isbMsgErrr => osbError);
        ELSE
            proValidaConceptoYaFacurado(inuProducto => inuProducto, inuConcepto => inuConcepto, osbError => osbError);
            IF osbError IS NOT NULL THEN
                NULL;
            END IF;
        END IF;

        IF inuValor IS NULL THEN
            osbError := 'Falta indicar el valor a debitar';
            pkg_error.setErrorMessage( isbMsgErrr => osbError);
        END IF;

        -- Debitar el concepto
        proInsMantenimientoNotaProy(inuProducto => inuProducto, --
                                    isbSignoCorriente => NULL, --
                                    inuValorCorriente => inuvalor, --
                                    inuValorVencido => 0, --
                                    inuConcepto => inuConcepto, --
                                    isbOrigen => 'P', --
                                    inuValorDiferido => 0, --
                                    isbSignoDiferido => NULL, 
                                    osbError => osbError);

        IF osbError IS NOT NULL THEN
            pkg_error.setErrorMessage( isbMsgErrr => osbError);
        END IF;

        --Se valida si el IVA del concepto base
        OPEN cuConcIva;
        FETCH cuConcIva INTO nuConcIva;
        IF cuConcIva%FOUND THEN
          CLOSE cuConcIva;
          nuPorIva   := fnutraePIva(inuconcepto => nuConcIva, inuserv => PKG_BCPRODUCTO.FNUTIPOPRODUCTO(inuProducto));
          nuValorIva := round(inuValor * (nuPorIva / 100), 0);

          pkg_traza.trace('Proyectar concepto IVA: '||nuConcIva||', valor: '||nuValorIva,csbNivelTraza);

          proInsMantenimientoNotaProy(inuProducto => inuProducto, --
                                    isbSignoCorriente => NULL, --
                                    inuValorCorriente => nuValorIva, --
                                    inuValorVencido => 0, --
                                    inuConcepto => nuConcIva, --
                                    isbOrigen => 'P', --
                                    inuValorDiferido => 0, --
                                    isbSignoDiferido => 0, 
                                    osbError => osbError);

        ELSE
          CLOSE cuConcIva;
        END IF;
        
        pkg_traza.trace('osbError => '||osbError, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
        
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_error.geterror(nuError, sbError);
            osbError := sbError;
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
        WHEN OTHERS THEN
            Pkg_Error.setError;
            pkg_error.geterror(nuError, sbError);
            osbError := sbError;
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
    END proProyDebitarConceptoPM;

    PROCEDURE proProyDebitarCuentaCobro
    (
        inuProducto pr_product.product_id%TYPE, -- Producto
        inuCuenCobr cuencobr.cucocodi%TYPE, -- CuentaCobro
        osbError    OUT VARCHAR2
    ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proProyDebitarCuentaCobro
        Descripcion:        Esta opcion se utilizara cuando se requiere restructurar la deuda una cuenta
                            de cobro.

        El sistema debe permitir seleccionar cualquier cuenta de cobro asociada al producto seleccionado
        sin saldo, esta novedad solo es para cargos generados por el programa FGCA.


        Autor    : Ronald Colpas C.
        Fecha    : 21-05-2019  CA 200-1650

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificación
        -----------  -------------------    -------------------------------------
        21-05-2019   Ronald Colpas C.       Creación
        ******************************************************************/

        csbMetodo        VARCHAR2(4000) := csbPaquete||'proProyDebitarCuentaCobro';
        nuSaldoConcepto  cargos.cargvalo%TYPE; -- Saldo del concepto
        nuSaldoCuenCobr  cuencobr.cucosacu%TYPE; -- Saldo de la cuenta de cobro
        nuValorDigitado  NUMBER; --valor digitado en la pantalla
        swExist          NUMBER := 0; --sw para saber si hay cargos generados por FGCA

        nuVenc           NUMBER; --vencimiento de la cta 0 vencida, 1 actual
        nuValorActual    NUMBER; --valor actual
        nuValorVencid    NUMBER; --valor vencido

        
        
        CURSOR cuConceptosCC IS
            SELECT DISTINCT cargconc
            FROM cargos c
            WHERE c.cargcuco = inuCuenCobr

            ;

        CURSOR cuVencta is
          SELECT COUNT(1)
            FROM cuencobr
           WHERE cucocodi = inuCuenCobr
             AND cucofeve > sysdate;

        CURSOR cuCargFGCA is
          SELECT *
            FROM cargos
           WHERE cargcuco = inuCuenCobr
             AND cargprog = 5;

        cursor cuValorDigitado is
        SELECT e.valor
        FROM ldc_mantenimiento_notas_enc e
        WHERE e.producto = inuProducto
        AND e.cuenta_cobro = inuCuenCobr
        AND e.sesion = gnuSesion;
        
        cursor cuSaldoCuenCobr is
        SELECT nvl(cc.cucosacu, 0)
        FROM cuencobr cc
        WHERE cc.cucocodi = inuCuenCobr;

    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_traza.trace('inuProducto    <= '||inuProducto, csbNivelTraza);
        pkg_traza.trace('inuCuenCobr    <= '||inuCuenCobr, csbNivelTraza);
        
        if cuValorDigitado%isopen then
            close cuValorDigitado;
        end if;
        
        if cuSaldoCuenCobr%isopen then
            close cuSaldoCuenCobr;
        end if;

        -- Validar datos obligatorios
        IF inuProducto IS NULL THEN
            osbError := 'Falta indicar el producto al que se le acreditara la deuda';
            pkg_error.setErrorMessage( isbMsgErrr => osbError);
        END IF;

        IF inuCuenCobr IS NULL THEN
            osbError := 'Falta indicar el numero de cuenta de cobro a acreditar';
            pkg_error.setErrorMessage( isbMsgErrr => osbError);
        END IF;
        --se guarda el valor que se digito
        open cuValorDigitado;
        fetch cuValorDigitado into nuValorDigitado;
        if cuValorDigitado%notfound then
            close cuValorDigitado;
            osbError := 'No fue posible determinar el valor digitado para el ajuste';
            pkg_error.setErrorMessage( isbMsgErrr => osbError);
        end if;
        close cuValorDigitado;
        

        -- Obtener el saldo total de la cuenta de cobro
        open cuSaldoCuenCobr;
        fetch cuSaldoCuenCobr into nuSaldoCuenCobr;
        if cuSaldoCuenCobr%notfound then
            close cuSaldoCuenCobr;
            osbError := 'No fue posible obtener el saldo de la cuenta de cobro '||inuCuenCobr;
            pkg_error.setErrorMessage( isbMsgErrr => osbError);
        end if;
        close cuSaldoCuenCobr;


        IF nuSaldoCuenCobr > 0 THEN
            osbError := 'La cuenta de cobro ' || inuCuenCobr ||' a la que se quiere aplicar novedad debitar por cuenta de cobro esta con saldo pendiente';
            pkg_error.setErrorMessage( isbMsgErrr => osbError);
        END IF;

        --actual o vencida
        OPEN cuVencta;
        FETCH cuVencta INTO nuVenc;
        CLOSE cuVencta;

        swExist := 0;
        -- Crear un cargo CR por el saldo de cada concepto de la cuenta de cobro
        FOR rgConceptosCC IN cuCargFGCA LOOP
            swExist := 1;
            --Se verifica el vencimiento de la cuenta de cobro para indicar actual y vencido
            IF nuVenc = 0 THEN
                nuValorActual := 0;
                nuValorVencid := rgConceptosCC.Cargvalo;
            ELSE
                nuValorActual := rgConceptosCC.Cargvalo;
                nuValorVencid := 0;
            END IF;
    
            proInsMantenimientoNotaProy(inuProducto => inuProducto, --
                                        isbSignoCorriente => rgConceptosCC.Cargsign, --
                                        inuValorCorriente => nuValorActual, --nuSaldoConcepto
                                        inuValorVencido => nuValorVencid, --
                                        inuConcepto => rgConceptosCC.Cargconc, --
                                        isbOrigen => 'P', --
                                        inuValorDiferido => 0, --
                                        isbSignoDiferido => 0, --
                                        osbError => osbError);
    
            IF osbError IS NOT NULL THEN
                pkg_error.setErrorMessage( isbMsgErrr => osbError);
            END IF;
            
            pkg_traza.trace('Nota Debito concepto ' || rgConceptosCC.Cargconc,csbNivelTraza);
          
        END LOOP;
        IF swExist = 0 THEN
            osbError := 'La cuenta de cobro ' || inuCuenCobr ||' a la que se quiere aplicar novedad debitar por cuenta de cobro no tiene cargos generados por FGCA';
            pkg_error.setErrorMessage( isbMsgErrr => osbError);
        END IF;

        pkg_traza.trace('osbError => '||osbError, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
        
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_error.geterror(nuError, sbError);
            osbError := sbError;
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
        WHEN OTHERS THEN
            Pkg_Error.setError;
            pkg_error.geterror(nuError, sbError);
            osbError := sbError;
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
    END;

    PROCEDURE proProyDebitarConceptoYCC
    (
        inuProducto pr_product.product_id%TYPE, -- Producto
        inuConcepto concepto.conccodi%TYPE, -- Concepto
        inuValor    cargos.cargvalo%TYPE, -- Valor a acreditar
        inuCuenCobr cuencobr.cucocodi%TYPE, -- Cuenta de cobro
        osbError    OUT VARCHAR2
    ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proProyDebitarConceptoYCC
        Descripcion:        Esta opcion se utilizara cuando se desee debitar por cuenta de cobro y concepto
                            Si el concepto base tiene IVA, el Iva se calcula sobre el valor digitado
                            de cuerdo con el procentaje vigente

        Autor    : Ronald Colpas
        Fecha    : 20-05-2019  CA 200-1650

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificación
        -----------  -------------------    -------------------------------------
        20-05-2019   Ronald colpas          Creación
        ******************************************************************/

        csbMetodo       VARCHAR2(4000) := csbPaquete||'proProyDebitarConceptoYCC';
        nuValorIva      NUMBER; --valor de Iva
        nuConcIva       NUMBER := 0; --concept Iva

        nuVenc           NUMBER; --vencimiento de la cta 0 vencida, 1 actual
        nuValorActual    NUMBER; --valor actual
        nuValorVencid    NUMBER; --valor vencido
        nuValor          NUMBER:= 0; --Valor del concepto digitado
        nuPorIva         NUMBER; --porcentaje IVA

        nuValorActIVA     NUMBER; -- Deuda actual del concepto IVA
        nuValorVenIVA     NUMBER; -- Deuda actual del concepto IVA

       

        --caso 200-1650 Valida si la cuenta de cobro es a la fecha o vencida
        CURSOR cuVencta is
          SELECT COUNT(1)
            FROM cuencobr
           WHERE cucocodi = inuCuenCobr
             AND cucofeve > sysdate;

       --caso 200-1650 Consulta el concepto IVA del base
       CURSOR cuConcIva is
          SELECT c.coblconc
            FROM concbali c
           WHERE c.coblcoba = inuConcepto
             AND c.coblcoba <> 137
             AND EXISTS (SELECT 1
                    FROM concepto t
                   WHERE t.conccodi = c.coblconc
                     AND t.concticl = cnuTipoconcliq);

    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_traza.trace('inuProducto    <= '||inuProducto, csbNivelTraza);
        pkg_traza.trace('inuConcepto    <= '||inuConcepto, csbNivelTraza);
        pkg_traza.trace('inuValor       <= '||inuValor, csbNivelTraza);
        pkg_traza.trace('inuCuenCobr    <= '||inuCuenCobr, csbNivelTraza);

        -- Validar datos obligatorios
        IF inuProducto IS NULL THEN
            osbError := 'Falta indicar el producto al que se le debitar la deuda';
            pkg_error.setErrorMessage( isbMsgErrr => osbError);
        END IF;

        IF inuConcepto IS NULL THEN
            osbError := 'Falta indicar el concepto al que se va a debitar';
            pkg_error.setErrorMessage( isbMsgErrr => osbError);
        END IF;

        IF inuValor IS NULL THEN
            osbError := 'Falta ingresar el valor a debitar';
            pkg_error.setErrorMessage( isbMsgErrr => osbError);
        END IF;

        IF inuCuenCobr IS NULL THEN
            osbError := 'Falta la cuenta de cobro en la que se debitara el concepto';
            pkg_error.setErrorMessage( isbMsgErrr => osbError);
        END IF;

        --Validamos el vencimiento de la cuenta de cobro para indicar si es
        --actual o vencida
        OPEN cuVencta;
        FETCH cuVencta INTO nuVenc;
        CLOSE cuVencta;

        IF nuVenc = 0 THEN
          nuValorActual := 0;
          nuValorVencid := inuValor;
        ELSE
          nuValorActual := inuValor;
          nuValorVencid := 0;
        END IF;

        proInsMantenimientoNotaProy(inuProducto => inuProducto, --
                                    isbSignoCorriente => csbDebito, --
                                    inuValorCorriente => nuValorActual,--inuValor, --
                                    inuValorVencido => nuValorVencid, --
                                    inuConcepto => inuConcepto, --
                                    isbOrigen => 'P', --
                                    inuValorDiferido => 0, --
                                    isbSignoDiferido => 0, --
                                    osbError => osbError);
        IF osbError IS NOT NULL THEN
            pkg_error.setErrorMessage( isbMsgErrr => osbError);
        END IF;

        --validamos si el concepto base tiene Iva para calcularlo
        OPEN cuConcIva;
        FETCH cuConcIva INTO nuConcIva;
        IF cuConcIva%FOUND THEN
          --Se proyecta el valor calculado del IVA
          --Realiza calculo para el valor del IVA
            nuPorIva   := fnutraePIva(inuconcepto => nuConcIva, inuserv => PKG_BCPRODUCTO.FNUTIPOPRODUCTO(inuProducto));
            nuValorIva := round(inuValor * (nuPorIva / 100), 0);

            pkg_traza.trace('Acredita concepto IVA: '||nuConcIva||' va a insertar valor de: '||nuValorIva||' porcentaje IVA: '||nuPorIva,csbNivelTraza);
          
            IF nuValorIva != 0 THEN
                IF nuValorActual <> 0 then
                    nuValorActIVA := nuValorIva;
                    nuValorVenIVA := 0;
                ELSE
                    nuValorActIVA := 0;
                    nuValorVenIVA := nuValorIva;
                END IF;
                proInsMantenimientoNotaProy(inuProducto => inuProducto, --
                                        isbSignoCorriente => csbDebito, --
                                        inuValorCorriente => nuValorActIVA, --
                                        inuValorVencido => nuValorVenIVA, --
                                        inuConcepto => nuConcIva, --
                                        isbOrigen => 'P', --
                                        inuValorDiferido => 0, --
                                        isbSignoDiferido => 0, --
                                        osbError => osbError);

                IF osbError IS NOT NULL THEN
                    pkg_error.setErrorMessage( isbMsgErrr => osbError);
                END IF;
            END IF;
        END IF;
        CLOSE cuConcIva;

        pkg_traza.trace('osbError => '||osbError, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
        
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_error.geterror(nuError, sbError);
            osbError := sbError;
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
        WHEN OTHERS THEN
            Pkg_Error.setError;
            pkg_error.geterror(nuError, sbError);
            osbError := sbError;
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
    END proProyDebitarConceptoYCC;

    PROCEDURE proDetAcreditarDeuda
    (
        inuProducto   pr_product.product_id%TYPE, -- Producto
        inuCausaCargo causcarg.cacacodi%TYPE, -- Causa cargo
        osbError      OUT VARCHAR2
    ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proDetAcreditarDeuda
        Descripcion:        Prepara el registro para crear el cargo para la aprobacio'n

        Autor    : Sandra Muñoz
        Fecha    : 15-04-2016  CA 200-201

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificación
        -----------  -------------------    -------------------------------------
        15-04-2016   Sandra Muñoz           Creación
        10-08-2023   diana.montes           OSF-1343: Se incluye el manejo de subsidio 167 y 
                                            130 consumo
        25-09-2024   jcatuche               OSF-3332: Se ajusta cursor cuConceptosCC, añadiendo validación para conceptos base e impuesto,
                                            ahora solo se gestionan conceptos base y a aquellos con configuración de impuesto se les calcula el impuesto
                                            Se agrega parámetro de entrada valor_base al llamado proInsMantenimientoNotaDet del impuesto
        ******************************************************************/

        csbMetodo               VARCHAR2(4000) := csbPaquete||'proDetAcreditarDeuda';
        nuSaldoConcepto         cargos.cargvalo%TYPE; -- Saldo del concepto
        nuValorsubsidio         NUMBER(8);
        nuValorsubsidioCovid    NUMBER(8);
        nuValorCovid            NUMBER(8);
        nuPorIva                NUMBER;
        nuValorBase             NUMBER;
        nuServ                  NUMBER;
        nuValorIva              NUMBER;
        
        CURSOR cuConceptosCC(inuCuenCobr cuencobr.cucocodi%TYPE) IS
        with base as
        (
            SELECT DISTINCT cargconc,
            (
                select case when concticl = cnuTipoconcliq then 'N' else 'S' end
                from concepto 
                where conccodi = cargconc
            ) esbase,
            (
                select coblconc from concbali,concepto a
                where coblcoba = cargconc
                and a.conccodi = coblconc
                and a.concticl = cnuTipoconcliq
            ) impuesto
            FROM cargos c
            WHERE c.cargcuco = inuCuenCobr
        )
        select * from base
        where esbase = 'S';

    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_traza.trace('inuProducto    <= '||inuProducto, csbNivelTraza);
        pkg_traza.trace('inuCausaCargo  <= '||inuCausaCargo, csbNivelTraza);

        -- Validar datos obligatorios
        IF inuProducto IS NULL THEN
            osbError := 'Falta indicar el producto al que se le acreditara la deuda';
            pkg_error.setErrorMessage( isbMsgErrr => osbError);
        END IF;

        IF inuCausaCargo IS NULL THEN
            osbError := 'Falta indicar la causa cargo';
            pkg_error.setErrorMessage( isbMsgErrr => osbError);
        END IF;

        nuServ := pkg_bcproducto.fnuTipoProducto(inuProducto);
        
        -- Recorrer las cuentas de cuentas de cobro con saldo del producto
        FOR rgCuentasConSaldo IN cuCuentasConSaldo(inuProducto => inuProducto)
        LOOP

            -- Recorrer los conceptos de la cuenta de cobro
            FOR rgConceptosCC IN cuConceptosCC(rgCuentasConSaldo.cuenta_cobro)
            LOOP

                -- Calcular saldo del concepto en la cuenta de cobro
                proDeudaConceptoCC(inuCuenCobr => rgCuentasConSaldo.cuenta_cobro, inuConcepto => rgConceptosCC.cargconc, onuSaldoConcepto => nuSaldoConcepto, osbError => osbError);

                IF osbError IS NOT NULL THEN
                    pkg_error.setErrorMessage( isbMsgErrr => osbError);
                END IF;
                --  SE ADICIONA IF 
                IF rgConceptosCC.cargconc not in (cnuConcSubsidio,cnuConcSubCovid,cnuConcCovid)
                THEN
                    -- Si el concepto tiene deuda, se crea el registro CR por ese valor
                    IF nvl(nuSaldoConcepto, 0) > 0 THEN
                        
                        -- Crear registro CR
                        proInsMantenimientoNotaDet(inuCuenta_cobro => rgCuentasConSaldo.cuenta_cobro, inuProducto => inuProducto, inuConcepto => rgConceptosCC.cargconc, inuSigno => csbCredito, inuValor => nuSaldoConcepto, inuCausa_cargo => inuCausaCargo, osbError => osbError);

                        IF osbError IS NOT NULL THEN
                            pkg_error.setErrorMessage( isbMsgErrr => osbError);
                        END IF;
                        
                        --Gestión de impuestos
                        IF rgConceptosCC.impuesto is not null then
                        
                            nuPorIva := 0;
                            nuPorIva   := fnutraePIva(inuconcepto => rgConceptosCC.impuesto, inuserv => nuServ);
                    
                            IF nuPorIva <= 0 then
                                osbError := 'El concepto de impuesto '||rgConceptosCC.impuesto||' en la cuenta '||rgCuentasConSaldo.cuenta_cobro||' no tiene % válido ['||nuPorIva||']';
                                pkg_error.setErrorMessage( isbMsgErrr => osbError);
                            END IF;
                            
                            nuValorBase := nuSaldoConcepto;
                            nuValorIva := round(nuValorBase * (nuPorIva / 100), 0);
                            
                            proInsMantenimientoNotaDet(inuCuenta_cobro => rgCuentasConSaldo.cuenta_cobro, --
                                             inuProducto => inuProducto, --
                                             inuConcepto => rgConceptosCC.impuesto, --
                                             inuSigno => csbCredito, --
                                             inuValor => nuValorIva, --
                                             inuCausa_cargo => inuCausaCargo, --
                                             inuValor_Base => nuValorBase,
                                             osbError => osbError);
                                             
                            IF osbError IS NOT NULL THEN
                                pkg_error.setErrorMessage( isbMsgErrr => osbError);
                            END IF;
                        END IF;
                    END IF;
                END IF;    
                ---------------------------------------------------------------------------------------------------
                --lmfg
                IF rgConceptosCC.cargconc = cnuConcConsumo THEN
                    proDeudaConceptoCC(inuCuenCobr => rgCuentasConSaldo.Cuenta_Cobro, inuConcepto => cnuConcSubsidio, onuSaldoConcepto => nuValorsubsidio, osbError => osbError);
                    IF nuValorsubsidio <> 0 THEN
                        pkg_traza.trace('Va a insertar el subsidio acreditar deuda '||nuValorsubsidio,csbNivelTraza);
                        proInsMantenimientoNotaDet(inuCuenta_cobro => rgCuentasConSaldo.cuenta_cobro, inuProducto => inuProducto, inuConcepto => cnuConcSubsidio, inuSigno => csbDebito, inuValor => -1 *
                                                                nuValorsubsidio, inuCausa_cargo => inuCausaCargo, osbError => osbError);
                    END IF;
                    
                    proDeudaConceptoCC(inuCuenCobr => rgCuentasConSaldo.Cuenta_Cobro, inuConcepto => cnuConcSubCovid, onuSaldoConcepto => nuValorsubsidioCovid, osbError => osbError);
                    IF nuValorsubsidioCovid <> 0 THEN
                        pkg_traza.trace('Va a insertar el subsidio COVID acreditar deuda '||nuValorsubsidioCovid,csbNivelTraza);
                        --  NUEVA CONDICION
                        
                        IF  nvl(nuValorsubsidioCovid, 0) < 0 THEN             
                            proInsMantenimientoNotaDet(inuCuenta_cobro => rgCuentasConSaldo.cuenta_cobro, inuProducto => inuProducto, inuConcepto => cnuConcSubCovid, inuSigno => csbDebito, inuValor => -1 *
                                                                nuValorsubsidioCovid, inuCausa_cargo => inuCausaCargo, osbError => osbError);
                        ELSE
                            proInsMantenimientoNotaDet(inuCuenta_cobro => rgCuentasConSaldo.cuenta_cobro, inuProducto => inuProducto, inuConcepto => cnuConcSubCovid, inuSigno => csbCredito, inuValor => 
                                                                nuValorsubsidioCovid, inuCausa_cargo => inuCausaCargo, osbError => osbError);
                        END IF;                                        
                    END IF;
                    --  concepto 130
                    proDeudaConceptoCC(inuCuenCobr => rgCuentasConSaldo.Cuenta_Cobro, inuConcepto => cnuConcCovid, onuSaldoConcepto => nuValorCovid, osbError => osbError);
                    IF nuValorCovid <> 0 THEN
                        pkg_traza.trace('Va a insertar el 130 COVID acreditar deuda '||nuValorCovid,csbNivelTraza);
                        IF  nvl(nuValorCovid,0) < 0 THEN                 
                            proInsMantenimientoNotaDet(inuCuenta_cobro => rgCuentasConSaldo.cuenta_cobro, inuProducto => inuProducto, inuConcepto => cnuConcCovid, inuSigno => csbDebito, inuValor => -1 *
                                                                nuValorCovid, inuCausa_cargo => inuCausaCargo, osbError => osbError);
                        ELSE
                            proInsMantenimientoNotaDet(inuCuenta_cobro => rgCuentasConSaldo.cuenta_cobro, inuProducto => inuProducto, inuConcepto => cnuConcCovid, inuSigno => csbCredito, inuValor => 
                                                                nuValorCovid, inuCausa_cargo => inuCausaCargo, osbError => osbError);
                        END IF;                                         
                    END IF;
                END IF;

            --lmfg
            ------------------------------------------------------------------------------------------------
            END LOOP;

        END LOOP;

        pkg_traza.trace('osbError => '||osbError, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
        
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_error.geterror(nuError, sbError);
            osbError := sbError;
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
        WHEN OTHERS THEN
            Pkg_Error.setError;
            pkg_error.geterror(nuError, sbError);
            osbError := sbError;
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
    END proDetAcreditarDeuda;

    -- Refactored procedure proDeudaConcepto

    PROCEDURE proDetAcreditarConcepto
    (
        inuProducto   pr_product.product_id%TYPE, -- Producto
        inuConcepto   concepto.conccodi%TYPE, -- Concepto
        inuValor      cargos.cargvalo%TYPE, -- Valor a acreditar
        inuCausaCargo causcarg.cacacodi%TYPE, -- Causa cargo
        osbError      OUT VARCHAR2
    ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proDetAcreditarConcepto
        Descripcion:        Crea la aprobacion de conceptos para la acreditacion de conceptos

        Autor    : Sandra Muñoz
        Fecha    : 15-04-2016  CA 200-201

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificación
        -----------  -------------------    -------------------------------------
        15-04-2016   Sandra Muñoz           Creación
        13-12-2018   Ronald Colpas          Caso-200-1650 se modifica el servicio para que detalle
                                            correctamente la novedad de acreditar por concepto.
                                            se tiene encuenta cuando el concepto tenga IVA para que se detalle.
                                            Si se acredita por concepto consumo se le detalle el subsidio
                                            si el valor acreditar del concepto base es difernte
                                            a la deuda real del concepto base se calcula el IVA que
                                            tenga este de acuerdo al procenteje calculado por la
                                            funcion fnutraePIva
        25-04-2019   Ronald Colpas          Caso-200-1650 Se modifica para excluir de la proyeccion los
                                            conceptos subsidio y contribucion, el iva se calcula
                                            con respecto al valor ingresado en el concepto.
                                            Se modifico para que tenga encuenta cuando el valor deuda concepto
                                            sea menor que el digitado
        25-09-2024   jcatuche               OSF-3332: Se agrega parámetro de entrada valor_base al llamado proInsMantenimientoNotaDet
                                            Se añade parámetro de entrada inuValor para evitar hacer la busqueda directamente en el procedimiento
        ******************************************************************/

        csbMetodo         VARCHAR2(4000) := csbPaquete||'proDetAcreditarConcepto';
        nuValorAAcreditar NUMBER; -- Deuda total del concepto
        nuValorsubsidio   NUMBER(8); --valor del subsidio
        sw                NUMBER := 0; --swtch para controlar el subsidio
        nuValorIva        NUMBER; --valor de Iva
        nuConcIva         NUMBER := 0; --concept Iva
        nuValorMora       NUMBER; --valor de mora
        nuConcMora        NUMBER; --concept mora
        nuCCAnt           cuencobr.cucocodi%TYPE := 1;
        nucantcc          NUMBER := 0;
        nucuencobr        cuencobr.cucocodi%TYPE;
        nuvalorDigitado   NUMBER;
        nuTotalAcreditar  NUMBER := 0; --Total a acredidato por el concepto
        nuValorRestante   NUMBER; --Total restante para saldo a favor
        nuValorContribu   NUMBER; --Valor contribucion
        nuPorIva          NUMBER; -- Porcentage IVA
        nuValorsubsidioCovid NUMBER(8);
        nuValorCovid      NUMBER(8);
        
        --mod.15.12.2018 Se modifica para agrupar por cuenta de cobro
        CURSOR cuCuentasConSaldo IS
            SELECT distinct cucocodi cuenta_cobro
            FROM cuencobr, cargos
            WHERE cuconuse = inuProducto
              AND cucosacu > 0
              AND cargcuco = cucocodi
              AND cargconc = inuConcepto
            order by cucocodi;

        CURSOR cuConcIva is
          SELECT c.coblconc
            FROM concbali c
           WHERE c.coblcoba = inuConcepto
             AND c.coblcoba <> 137
             AND EXISTS (SELECT 1
                    FROM concepto t
                   WHERE t.conccodi = c.coblconc
                     AND t.concticl = cnuTipoconcliq);

        
        cursor cucuencobr is
        SELECT MAX(cucocodi)
        FROM cuencobr, cargos
        WHERE cuconuse = inuProducto
        AND cargcuco = cucocodi;
        
        cursor cucuencobrSal is
        SELECT MAX(cucocodi)
        FROM cuencobr, cargos
        WHERE cuconuse = inuProducto
        AND cargcuco = cucocodi
        AND cargconc = inuConcepto
        AND cucosacu > 0;

    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_traza.trace('inuProducto    <= '||inuProducto, csbNivelTraza);
        pkg_traza.trace('inuConcepto    <= '||inuConcepto, csbNivelTraza);
        pkg_traza.trace('inuValor       <= '||inuConcepto, csbNivelTraza);
        pkg_traza.trace('inuCausaCargo  <= '||inuCausaCargo, csbNivelTraza);
        
        
        if cucuencobr%isopen then
            close cucuencobr;
        end if;
        
        if cucuencobrSal%isopen then
            close cucuencobrSal;
        end if;

        -- Validar datos obligatorios
        IF inuProducto IS NULL THEN
            osbError := 'Falta indicar el producto al que se le acreditara la deuda';
            pkg_error.setErrorMessage( isbMsgErrr => osbError);
        END IF;

        IF inuConcepto IS NULL THEN
            osbError := 'Falta indicar el concepto al que se va a acreditar';
            pkg_error.setErrorMessage( isbMsgErrr => osbError);
        ELSE
            proValidaConceptoYaFacurado(inuProducto => inuProducto, inuConcepto => inuConcepto, osbError => osbError);
            IF osbError IS NOT NULL THEN
                pkg_error.setErrorMessage( isbMsgErrr => osbError);
            END IF;
        END IF;

        IF inuCausaCargo IS NULL THEN
            osbError := 'Falta indicar la causa cargo';
            pkg_error.setErrorMessage( isbMsgErrr => osbError);
        END IF;

        if nvl(inuValor,0) <= 0 then
            osbError := 'El valor a acreditar debe ser mayor a cero';
            pkg_error.setErrorMessage( isbMsgErrr => osbError);
        end if;
        
        nuValorDigitado := inuValor;

        -- Recorrer todas las cuentas de cobro con saldo y donde este presente el concepto a acreditar
        FOR rgCuentasConSaldo IN cuCuentasConSaldo LOOP
            nucantcc := 1;
            -- Identificar la deuda del concepto en la cuenta de cobro
            proDeudaConceptoCC(inuCuenCobr => rgCuentasConSaldo.Cuenta_Cobro, --
                                inuConcepto => inuConcepto, --
                                onuSaldoConcepto => nuValorAAcreditar, --
                                osbError => osbError);
    
            IF osbError IS NOT NULL THEN
                pkg_error.setErrorMessage( isbMsgErrr => osbError);
            END IF;
            --Acumulamos el valor acreditado
            nuTotalAcreditar := nuTotalAcreditar + nuValorAAcreditar;
    
            --mod.25.04 valida si el valor digitado es menor que el que se este acreditando
            --y se salga del recorrido de las cuentas
            IF nuTotalAcreditar > nuvalorDigitado THEN
                nuValorAAcreditar :=nuValorAAcreditar-( nuTotalAcreditar - nuvalorDigitado);
            END IF;
    
            proInsMantenimientoNotaDet(inuCuenta_cobro => rgCuentasConSaldo.cuenta_cobro, --
                                        inuProducto => inuProducto, --
                                        inuConcepto => inuConcepto, --
                                        inuSigno => csbCredito, --
                                        inuValor => nuValorAAcreditar, --
                                        inuCausa_cargo => inuCausaCargo, --
                                        osbError => osbError);
    
            IF osbError IS NOT NULL THEN
                pkg_error.setErrorMessage( isbMsgErrr => osbError);
            END IF;
    
            --mod.25.04.2019 validamos si el concepto base tiene Iva para calcularlo
            OPEN cuConcIva;
            FETCH cuConcIva INTO nuConcIva;
            IF cuConcIva%FOUND THEN
                --Se proyecta el valor calculado del IVA
                --Realiza calculo para el valor del IVA
                nuPorIva   := fnutraePIva(inuconcepto => nuConcIva, inuserv => PKG_BCPRODUCTO.FNUTIPOPRODUCTO(inuProducto));
                nuValorIva := round(nuValorAAcreditar * (nuPorIva / 100), 0);
    
                pkg_traza.trace('Acredita concepto IVA: '||nuConcIva||' va a insertar valor de: '||nuValorIva||' porcentaje IVA: '||nuPorIva,csbNivelTraza);
    
                IF nuValorIva != 0 THEN
                    proInsMantenimientoNotaDet(inuCuenta_cobro => rgCuentasConSaldo.cuenta_cobro, --
                                            inuProducto => inuProducto, --
                                            inuConcepto => nuConcIva, --
                                            inuSigno => csbCredito, --
                                            inuValor => nuValorIva, --
                                            inuCausa_cargo => inuCausaCargo, --
                                            inuValor_Base => nuValorAAcreditar,
                                            osbError => osbError);
                    IF osbError IS NOT NULL THEN
                        pkg_error.setErrorMessage( isbMsgErrr => osbError);
                    END IF;
    
                END IF;
            END IF;
            close cuConcIva;

            --mod.25.04.2019 termina de acreditar las cuentas por conceptos
            IF nuTotalAcreditar >= nuvalorDigitado THEN
                EXIT;
            END IF;

            --Validamos si el concepto es consumo y si la cuenta de cobro tiene subsidio
        
        END LOOP;

        nuValorRestante := nuvalorDigitado - nuTotalAcreditar;
        --Si el usuario tiene valor restante se carga como saldo afavor en la cuenta de cobro mas reciente
        IF nuValorRestante > 0 THEN

            --Si el usuario no tiene cuenta de cobro pendiente se busca la mas reciente
            --de lo contrario busca la pendiente mas reciente
            IF nucantcc = 0 THEN
                --se halla la maxima cuenta de cobro del producto
                open cucuencobr;
                fetch cucuencobr into nucuencobr;
                close cucuencobr;
            ELSE
                --se halla la maxima cuenta de cobro pendiente del concepto
                open cucuencobrSal;
                fetch cucuencobrSal into nucuencobr;
                close cucuencobrSal;
            END IF;

            proInsMantenimientoNotaDet(inuCuenta_cobro => nucuencobr, --
                                     inuProducto => inuProducto, --
                                     inuConcepto => inuConcepto, --
                                     inuSigno => csbCredito, --
                                     inuValor => nuValorRestante, --
                                     inuCausa_cargo => inuCausaCargo, --
                                     osbError => osbError);

            IF osbError IS NOT NULL THEN
                pkg_error.setErrorMessage( isbMsgErrr => osbError);
            END IF;

            --IF nucantcc = 0 THEN
            OPEN cuConcIva;
            FETCH cuConcIva INTO nuConcIva;
            IF cuConcIva%FOUND THEN
                --Se proyecta el valor calculado del IVA
                --Realiza calculo para el valor del IVA
                nuPorIva   := fnutraePIva(inuconcepto => nuConcIva, inuserv => PKG_BCPRODUCTO.FNUTIPOPRODUCTO(inuProducto));
                nuValorIva := round(nuValorRestante * (nuPorIva / 100), 0);
    
                pkg_traza.trace('Acredita concepto IVA: '||nuConcIva||' va a insertar valor de: ' ||nuValorIva||' porcentaje IVA: '|| nuPorIva,csbNivelTraza);
    
                IF nuValorIva != 0 THEN
                    proInsMantenimientoNotaDet(inuCuenta_cobro => nucuencobr, --
                                           inuProducto => inuProducto, --
                                           inuConcepto => nuConcIva, --
                                           inuSigno => csbCredito, --
                                           inuValor => nuValorIva, --
                                           inuCausa_cargo => inuCausaCargo, --
                                           inuValor_Base => nuValorRestante,
                                           osbError => osbError);
                    IF osbError IS NOT NULL THEN
                        pkg_error.setErrorMessage( isbMsgErrr => osbError);
                    END IF;

                END IF;

            END IF;
            close cuConcIva;
          
        END IF;

        pkg_traza.trace('osbError => '||osbError, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
        
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_error.geterror(nuError, sbError);
            osbError := sbError;
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
        WHEN OTHERS THEN
            Pkg_Error.setError;
            pkg_error.geterror(nuError, sbError);
            osbError := sbError;
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
    END proDetAcreditarConcepto;

    PROCEDURE proDetAcreditarConceptoYCC
    (
        inuProducto   pr_product.product_id%TYPE, -- Producto
        inuConcepto   concepto.conccodi%TYPE, -- Concepto
        inuValor      cargos.cargvalo%TYPE, -- Valor a acreditar
        inuCuenCobr   cuencobr.cucocodi%TYPE, -- Cuenta de cobro
        inuCausaCargo causcarg.cacacodi%TYPE, -- Causa cargo
        osbError      OUT VARCHAR2
    ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proDetAcreditarConceptoYCC
        Descripcion:        Almacena la informacion a acreditar

        Autor    : Sandra Muñoz
        Fecha    : 15-04-2016  CA 200-201

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificación
        -----------  -------------------    -------------------------------------
        15-04-2016   Sandra Muñoz           Creación
        16-12-2018   Ronald Colpas          Se modifica para que calcule correctamente
                                            el cargo a crear por concepto subsidio e IVA.
                                            si el valor acreditar del concepto base es difernte
                                            a la deuda real del concepto base se calcula el IVA que
                                            tenga este de acuerdo al procenteje calculado por la
                                            funcion fnutraePIva
        25-04-2019   Ronald Colpas          Caso-200-1650 Se modifica para excluir de la proyeccion los
                                            conceptos subsidio y contribucion, el iva se calcula
                                            con respecto al valor ingresado en el concepto.
                                            Se modifico para que tenga encuenta cuando el valor deuda concepto
                                            sea menor que el digitado
        22-08-2023   Diana.Montes           OSF-1343: Se coloca la validacion inuValor < 0 para que 
                                            no permita registrar valores negativos
        25-09-2024   jcatuche               OSF-3332: Se agrega parámetro de entrada valor_base al llamado proInsMantenimientoNotaDet
        ******************************************************************/

        csbMetodo       VARCHAR2(4000) := csbPaquete||'proDetAcreditarConceptoYCC';
        nuValorsubsidio NUMBER(8); --valor del subsidio en caso de que el concepto tenga
        nuValorIva      NUMBER; --valor de Iva
        nuConcIva       NUMBER := 0; --concept Iva
        nuValorMora     NUMBER; --valor de mora
        nuConcMora      NUMBER; --concept mora

        nuPorIva        NUMBER; --porcentaje IVA
        nuValor         NUMBER := 0; --valor del concepto base
        nuValorConc     NUMBER; --valor conpeto asociados de base
        nuValorsubsidioCovid NUMBER(8);
        nuValorCovid   NUMBER(8);
        
        --caso 200-1650 Consulta el concepto IVA del base
       CURSOR cuConcIva is
          SELECT c.coblconc
            FROM concbali c
           WHERE c.coblcoba = inuConcepto
             AND c.coblcoba <> 137
             AND EXISTS (SELECT 1
                    FROM concepto t
                   WHERE t.conccodi = c.coblconc
                     AND t.concticl = cnuTipoconcliq);

    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_traza.trace('inuProducto    <= '||inuProducto, csbNivelTraza);
        pkg_traza.trace('inuConcepto    <= '||inuConcepto, csbNivelTraza);
        pkg_traza.trace('inuValor       <= '||inuValor, csbNivelTraza);
        pkg_traza.trace('inuCuenCobr    <= '||inuCuenCobr, csbNivelTraza);
        pkg_traza.trace('inuCausaCargo  <= '||inuCausaCargo, csbNivelTraza);

        -- Validar datos obligatorios
        IF inuProducto IS NULL THEN
            osbError := 'Falta indicar el producto al que se le acreditara la deuda';
            pkg_error.setErrorMessage( isbMsgErrr => osbError);
        END IF;

        IF inuConcepto IS NULL THEN
            osbError := 'Falta indicar el concepto al que se va a acreditar';
            pkg_error.setErrorMessage( isbMsgErrr => osbError);
        ELSE
            proValidaConceptoYaFacurado(inuProducto => inuProducto, inuConcepto => inuConcepto, osbError => osbError);
            IF osbError IS NOT NULL THEN
                pkg_error.setErrorMessage( isbMsgErrr => osbError);
            END IF;
        END IF;

        IF nvl(inuValor,0) <= 0 THEN
            osbError := 'El valor a acreditar debe ser mayor a cero';
            pkg_error.setErrorMessage( isbMsgErrr => osbError);
        END IF;

        IF inuCuenCobr IS NULL THEN
            osbError := 'Falta la cuenta de cobro en la que se acreditara la cuenta de cobro';
            pkg_error.setErrorMessage( isbMsgErrr => osbError);
        END IF;

        IF inuCausaCargo IS NULL THEN
            osbError := 'Falta indicar la causa cargo';
            pkg_error.setErrorMessage( isbMsgErrr => osbError);
        END IF;


        -- Acreditar el concepto
        proInsMantenimientoNotaDet(inuCuenta_cobro => inuCuenCobr, --
                               inuProducto => inuProducto, --
                               inuConcepto => inuConcepto, --
                               inuSigno => csbCredito, --
                               inuValor => inuValor, --
                               inuCausa_cargo => inuCausaCargo, --
                               osbError => osbError);

        IF osbError IS NOT NULL THEN
            pkg_error.setErrorMessage( isbMsgErrr => osbError);
        END IF;

        --mod.25.04.2019 validamos si el concepto base tiene Iva para calcularlo
        OPEN cuConcIva;
        FETCH cuConcIva INTO nuConcIva;
        IF cuConcIva%FOUND THEN
          --Se proyecta el valor calculado del IVA
          --Realiza calculo para el valor del IVA
            nuPorIva   := fnutraePIva(inuconcepto => nuConcIva, inuserv => PKG_BCPRODUCTO.FNUTIPOPRODUCTO(inuProducto));
            nuValorIva := round(inuValor * (nuPorIva / 100), 0);

            pkg_traza.trace('Acredita concepto IVA: '||nuConcIva||' va a insertar valor de: '||nuValorIva||' porcentaje IVA: '|| nuPorIva,csbNivelTraza);

            IF nuValorIva != 0 THEN
                proInsMantenimientoNotaDet(inuCuenta_cobro => inuCuenCobr, --
                                       inuProducto => inuProducto, --
                                       inuConcepto => nuConcIva, --
                                       inuSigno => csbCredito, --
                                       inuValor => nuValorIva, --
                                       inuCausa_cargo => inuCausaCargo, --
                                       inuValor_Base => inuValor,
                                       osbError => osbError);
                IF osbError IS NOT NULL THEN
                    pkg_error.setErrorMessage( isbMsgErrr => osbError);
                END IF;

            END IF;
        END IF;

        pkg_traza.trace('osbError => '||osbError, csbNivelTraza);  
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
        
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_error.geterror(nuError, sbError);
            osbError := sbError;
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
        WHEN OTHERS THEN
            Pkg_Error.setError;
            pkg_error.geterror(nuError, sbError);
            osbError := sbError;
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
    END proDetAcreditarConceptoYCC;

    PROCEDURE proDetAcreditarCuentaCobro
    (
        inuProducto   pr_product.product_id%TYPE, -- Producto
        inuCuenCobr   cuencobr.cucocodi%TYPE, -- CuentaCobro
        inuValor      cargos.cargvalo%TYPE, -- Valor a acreditar
        inuCausaCargo causcarg.cacacodi%TYPE, -- Causa cargo
        osbError      OUT VARCHAR2
    ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proDetAcreditarCuentaCobro
        Descripcion:        Permite preparar la informacion

        El sistema debe permitir seleccionar cualquier cuenta de cobro asociada al producto seleccionado
        sin importar si tiene saldo o no.


        Autor    : Sandra Muñoz
        Fecha    : 15-04-2016  CA 200-201

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificación
        -----------  -------------------    -------------------------------------
        15-04-2016   Sandra Muñoz           Creación
        15-12-2018   Ronald Colpas          Se modifica para prorretear la deuda de la cuenta de cobro
                                            cuando el valor digitado sea mayor al de la cuenta
        10-08-2023   diana.montes           OSF-1343: se modifica para tener en cuenta el subsidio 
                                            del concepto 167
        25-09-2024   jcatuche               OSF-3332: Se ajusta cursor cuConceptosCC, añadiendo validación para conceptos base e impuesto,
                                            ahora solo se gestionan conceptos base y a aquellos con configuración de impuesto se les calcula el impuesto
                                            Se agrega parámetro de entrada valor_base al llamado proInsMantenimientoNotaDet del impuesto
                                            Se añade parámetro de entrada inuValor para evitar hacer la busqueda directamente en el procedimiento
        ******************************************************************/

        csbMetodo         VARCHAR2(4000) := csbPaquete||'proDetAcreditarCuentaCobro';
        nuSaldoCuenCobr   cuencobr.cucosacu%TYPE; -- Saldo de la cuenta de cobro
        nuValorAAcreditar NUMBER; -- Valor a acreditar al concepto
        nuValorsubsidio   NUMBER(8); --valor subsidio
        nucantconc        NUMBER; --cantidad de conceptos en la cuenta de cobro
        swMayor           NUMBER := 0; --sw para saber si el valor es mayor
        nuValorDigitado   NUMBER; --valor digitado en la pantalla
        nuvalor           NUMBER; --valor porcionado de la deuda por concepto

        nuVenc           NUMBER; --vencimiento de la cta 0 vencida, 1 actual
        nuPorcentage     NUMBER; --Porcentaje para prorratear la deuda
        nuValorsubsidioCovid NUMBER(8);
        nuValorCovid      NUMBER(8);
        nuPorIva          NUMBER;
        nuValorBase       NUMBER;
        nuServ            NUMBER;
        nuValorIva        NUMBER;

        CURSOR cuConceptosCC IS
        with base as
        (
            SELECT DISTINCT cargconc,
            (
                select case when concticl = cnuTipoconcliq then 'N' else 'S' end
                from concepto 
                where conccodi = cargconc
            ) esbase,
            (
                select coblconc from concbali,concepto a
                where coblcoba = cargconc
                and a.conccodi = coblconc
                and a.concticl = cnuTipoconcliq
            ) impuesto
            FROM cargos c
            WHERE c.cargcuco = inuCuenCobr
        )
        select * from base
        where esbase = 'S';
            
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_traza.trace('inuProducto    <= '||inuProducto, csbNivelTraza);
        pkg_traza.trace('inuCuenCobr    <= '||inuCuenCobr, csbNivelTraza);
        pkg_traza.trace('inuValor       <= '||inuValor, csbNivelTraza);
        pkg_traza.trace('inuCausaCargo  <= '||inuCausaCargo, csbNivelTraza);
        
        -- Validar datos obligatorios
        IF inuProducto IS NULL THEN
            osbError := 'Falta indicar el producto al que se le acreditara la deuda';
            pkg_error.setErrorMessage( isbMsgErrr => osbError);
        END IF;

        IF inuCuenCobr IS NULL THEN
            osbError := 'Falta indicar el numero de cuenta de cobro a acreditar';
            pkg_error.setErrorMessage( isbMsgErrr => osbError);
        END IF;

        IF inuCausaCargo IS NULL THEN
            osbError := 'Falta indicar la causa cargo';
            pkg_error.setErrorMessage( isbMsgErrr => osbError);
        END IF;
        
        IF nvl(inuValor,0) <= 0 THEN
            osbError := 'El valor a acreditar debe ser mayor a cero';
            pkg_error.setErrorMessage( isbMsgErrr => osbError);
        END IF;
        
        --se guarda el valor que se digito
        nuValorDigitado := inuValor;
        
        -- Obtener el saldo total de la cuenta de cobro
        proDeudaCuentaCobro(inuProducto => inuProducto, --
                            inuCuenCobr => inuCuenCobr, --
                            onuSaldoCuenCobr => nuSaldoCuenCobr, --
                            osbError => osbError);

        IF osbError IS NOT NULL THEN
            pkg_error.setErrorMessage( isbMsgErrr => osbError);
        END IF;
        
        
        IF nuValorDigitado > nuSaldoCuenCobr THEN
           
            swMayor := 1;
        END IF;

        -- No procesar si la cuenta de cobro no tiene saldo
        IF nuSaldoCuenCobr > 0 THEN
        
            nuServ := pkg_bcproducto.fnuTipoProducto(inuProducto);

            -- Recorrer todos los conceptos de la cuenta de cobro seleccionada
            FOR rgConceptosCC IN cuConceptosCC
            LOOP

                -- Identificar la deuda total del concepto
                proDeudaConceptoCC(inuCuenCobr => inuCuenCobr, --
                                   inuConcepto => rgConceptosCC.Cargconc, --
                                   onuSaldoConcepto => nuValorAAcreditar, --
                                   osbError => osbError);

                IF osbError IS NOT NULL THEN
                    pkg_error.setErrorMessage( isbMsgErrr => osbError);
                END IF;

                -- Si el concepto tiene deuda, se crea el cargo CR
                --si el valor digitado no es mayor que la deuda de la cc(swmayor=0)
                --se hace el proceso normal
                
                -- se adiciona if
                IF rgConceptosCC.Cargconc not in (cnuConcSubsidio,cnuConcSubCovid,cnuConcCovid) THEN
                    
                    IF nuValorAAcreditar > 0 THEN
                    
                        IF swMayor = 1 THEN
                            --mod.15.12.2018 Isempre y cuando el concepto tenga deuda
                            --mod.15.12.2018 realizamos el prorrateo para el concepto
                            --para indicar el valor que le corresponde
                            nuPorcentage := nuValorAAcreditar / nuSaldoCuenCobr;
                            nuValorAAcreditar := round(nuValorDigitado * nuPorcentage);
                            
                            --valor digitado mayor al valor de la cc(swmayor<>0) se toma el
                            --valor porcionado
                        END IF;
                        
                        proInsMantenimientoNotaDet(inuCuenta_cobro => inuCuenCobr, --
                                                       inuProducto => inuProducto, --
                                                       inuConcepto => rgConceptosCC.Cargconc, --
                                                       inuSigno => csbCredito, --
                                                       inuValor => nuValorAAcreditar, --
                                                       inuCausa_cargo => inuCausaCargo, 
                                                       osbError => osbError);

                        IF osbError IS NOT NULL THEN
                            pkg_error.setErrorMessage( isbMsgErrr => osbError);
                        END IF;
                    
                        --Gestión de impuestos
                        IF rgConceptosCC.impuesto is not null then
                        
                            nuPorIva := 0;
                            nuPorIva   := fnutraePIva(inuconcepto => rgConceptosCC.impuesto, inuserv => nuServ);
                    
                            IF nuPorIva <= 0 then
                                osbError := 'El concepto de impuesto '||rgConceptosCC.impuesto||' en la cuenta '||inuCuenCobr||' no tiene % válido ['||nuPorIva||']';
                                pkg_error.setErrorMessage( isbMsgErrr => osbError);
                            END IF;
                            
                            nuValorBase := nuValorAAcreditar;
                            nuValorIva := round(nuValorBase * (nuPorIva / 100), 0);
                            
                            proInsMantenimientoNotaDet(inuCuenta_cobro => inuCuenCobr, --
                                             inuProducto => inuProducto, --
                                             inuConcepto => rgConceptosCC.impuesto, --
                                             inuSigno => csbCredito, --
                                             inuValor => nuValorIva, --
                                             inuCausa_cargo => inuCausaCargo, --
                                             inuValor_Base => nuValorBase,
                                             osbError => osbError);
                                             
                            IF osbError IS NOT NULL THEN
                                pkg_error.setErrorMessage( isbMsgErrr => osbError);
                            END IF;
                        END IF;
                    END IF;
                END IF;
                ---------------------------------------------------------------------------------------------------
                --lmfg
                IF rgConceptosCC.Cargconc = cnuConcConsumo THEN
                    proDeudaConceptoCC(inuCuenCobr => inuCuenCobr,
                                       inuConcepto => cnuConcSubsidio,
                                       onuSaldoConcepto => nuValorsubsidio,
                                       osbError => osbError);

                    IF osbError IS NOT NULL THEN
                        pkg_error.setErrorMessage( isbMsgErrr => osbError);
                    END IF;
                    -- subsidio covid
                    proDeudaConceptoCC(inuCuenCobr => inuCuenCobr,
                                       inuConcepto => cnuConcSubCovid,
                                       onuSaldoConcepto => nuValorsubsidioCovid,
                                       osbError => osbError);

                    IF osbError IS NOT NULL THEN
                        pkg_error.setErrorMessage( isbMsgErrr => osbError);
                    END IF;
                    -- consumo covid
                    proDeudaConceptoCC(inuCuenCobr => inuCuenCobr,
                                       inuConcepto => cnuConcCovid,
                                       onuSaldoConcepto => nuValorCovid,
                                       osbError => osbError);

                    IF osbError IS NOT NULL THEN
                        pkg_error.setErrorMessage( isbMsgErrr => osbError);
                    END IF;
                    IF nuValorsubsidio <> 0 THEN
                    
                        pkg_traza.trace('Va a insertar el subsidio acreditar deuda ' ||nuValorsubsidio,csbNivelTraza);
                        
                        proInsMantenimientoNotaDet(inuCuenta_cobro => inuCuenCobr,
                                                   inuProducto => inuProducto,
                                                   inuConcepto => cnuConcSubsidio,
                                                   inuSigno => csbDebito,
                                                   inuValor => -1 * nuValorsubsidio,
                                                   inuCausa_cargo => inuCausaCargo,
                                                   osbError => osbError);
                        IF osbError IS NOT NULL THEN
                            pkg_error.setErrorMessage( isbMsgErrr => osbError);
                        END IF;
                    END IF;
                    --  valor subsidio covid
                    IF nuValorsubsidioCovid <> 0 THEN
                        pkg_traza.trace('Va a insertar el subsidio covid acreditar deuda ' ||nuValorsubsidioCovid,csbNivelTraza);
                        
                        IF nvl(nuValorsubsidioCovid,0) < 0 THEN
                            proInsMantenimientoNotaDet(inuCuenta_cobro => inuCuenCobr,
                                                   inuProducto => inuProducto,
                                                   inuConcepto => cnuConcSubCovid,
                                                   inuSigno => csbDebito,
                                                   inuValor => -1 * nuValorsubsidioCovid,
                                                   inuCausa_cargo => inuCausaCargo,
                                                   osbError => osbError);
                        ELSE
                            proInsMantenimientoNotaDet(inuCuenta_cobro => inuCuenCobr,
                                                   inuProducto => inuProducto,
                                                   inuConcepto => cnuConcSubCovid,
                                                   inuSigno => csbCredito,
                                                   inuValor => nuValorsubsidioCovid,
                                                   inuCausa_cargo => inuCausaCargo,
                                                   osbError => osbError);
                        END IF;                           
                        IF osbError IS NOT NULL THEN
                            pkg_error.setErrorMessage( isbMsgErrr => osbError);
                        END IF;
                    END IF;
                    --  valor consumo covid
                    IF nuValorCovid <> 0 THEN
                        pkg_traza.trace('Va a insertar el consumo covid acreditar deuda ' ||nuValorCovid,csbNivelTraza);
                        IF nvl(nuValorCovid,0) < 0 THEN
                            proInsMantenimientoNotaDet(inuCuenta_cobro => inuCuenCobr,
                                                   inuProducto => inuProducto,
                                                   inuConcepto => cnuConcCovid,
                                                   inuSigno => csbDebito,
                                                   inuValor => -1 * nuValorCovid,
                                                   inuCausa_cargo => inuCausaCargo,
                                                   osbError => osbError);
                         ELSE
                            proInsMantenimientoNotaDet(inuCuenta_cobro => inuCuenCobr,
                                                   inuProducto => inuProducto,
                                                   inuConcepto => cnuConcCovid,
                                                   inuSigno => csbCredito,
                                                   inuValor => nuValorCovid,
                                                   inuCausa_cargo => inuCausaCargo,
                                                   osbError => osbError);
                        END IF;   
                        IF osbError IS NOT NULL THEN
                            pkg_error.setErrorMessage( isbMsgErrr => osbError);
                        END IF;
                    END IF;
                    
                END IF;

            --lmfg
            ------------------------------------------------------------------------------------------------

            END LOOP;

        ELSE
            pkg_traza.trace('La cuenta de cobro ' ||inuCuenCobr||' no se puede acreditar ya que no tiene saldo',csbNivelTraza);
        END IF;

        pkg_traza.trace('osbError => '||osbError, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
        
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_error.geterror(nuError, sbError);
            osbError := sbError;
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
        WHEN OTHERS THEN
            Pkg_Error.setError;
            pkg_error.geterror(nuError, sbError);
            osbError := sbError;
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
    END proDetAcreditarCuentaCobro;

    PROCEDURE proDetDebitarConcepto
    (
        inuProducto   pr_product.product_id%TYPE, -- Producto
        inuConcepto   concepto.conccodi%TYPE, -- Concepto
        inuValor      cargos.cargvalo%TYPE, -- Valor a debitar
        inuCausaCargo causcarg.cacacodi%TYPE, -- Causa cargo
        inuPlanId     plandife.pldicodi%TYPE, -- Plan de diferido
        inuNroCuotas  plandife.pldicumi%TYPE, -- Numero de cuotas
        osbError      OUT VARCHAR2
    ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proDetDebitarConcepto
        Descripcion:        Almacena la informacion a debitar

        Autor    : Sandra Muñoz
        Fecha    : 15-04-2016  CA 200-201

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificación
        -----------  --------------     -------------------------------------
        15-04-2016   Sandra Muñoz           Creación
        29-04-2024   jcatuche               OSF-3206: Se agrega llamado a pkg_gestiondiferidos.pSimProyCuotas
                                                para simulación de financiación
        25-11-2024   jcatuche               OSF-3332: Se elimina variable sbDifeProg para dar paso a la constante csbNotaProg
        ******************************************************************/

        csbMetodo              VARCHAR2(4000) := csbPaquete||'proDetDebitarConcepto';
        nuFactura              factura.factcodi%TYPE; -- Numero de factura
        nuContrato             NUMBER;
        grcSubscription        suscripc%ROWTYPE;
        nuCuentaCobro          cuencobr.cucocodi%TYPE;
        rcProduct              servsusc%ROWTYPE;
        nuBillValue            NUMBER;
        nuTaxValue             NUMBER;
        sbDescription          VARCHAR2(4000) := NULL;
        nuSubsc                servsusc.sesususc%TYPE;
        nuNote                 notas.notanume%TYPE;
        nuNroCuotas            NUMBER;
        nuSaldo                NUMBER;
        nuTotalAcumCapital     NUMBER;
        nuTotalAcumCuotExtr    NUMBER;
        nuTotalAcumInteres     NUMBER;
        sbRequiereVisado       VARCHAR2(10);
        nuDifeCofi             NUMBER;
        nuTieneVentaRegistrada ld_parameter.numeric_value%TYPE; -- Indica si un producto tiene venta registrada
        nuMetodoCalculo        ld_parameter.numeric_value%TYPE; -- Metodo de calculo
        nuConcIva              NUMBER := 0; --concepto de iva
        nuvaloriva             NUMBER := 0; --valor de iva proyectado
        nuPorIva               NUMBER := 0; --porcentaje IVA
        
        --lmfg
        CURSOR cuivaProy IS
            SELECT nvl(valor_corriente, 0)
            FROM LDC_MANTENIMIENTO_NOTAS_PROY
            WHERE sesion = gnuSesion
                  AND concepto = nuConcIva
                  AND origen = 'P'
                  AND producto = inuproducto
                  AND rownum = 1;

        --caso 200-1650 Consulta el concepto IVA del base
        CURSOR cuConcIva is
          SELECT c.coblconc
            FROM concbali c
           WHERE c.coblcoba = inuConcepto
             AND c.coblcoba <> 137
             AND EXISTS (SELECT 1
                    FROM concepto t
                   WHERE t.conccodi = c.coblconc
                     AND t.concticl = cnuTipoconcliq);

        

    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_traza.trace('inuProducto    <= '||inuProducto, csbNivelTraza);
        pkg_traza.trace('inuConcepto    <= '||inuConcepto, csbNivelTraza);
        pkg_traza.trace('inuValor       <= '||inuValor, csbNivelTraza);
        pkg_traza.trace('inuCausaCargo  <= '||inuCausaCargo, csbNivelTraza);
        pkg_traza.trace('inuPlanId      <= '||inuPlanId, csbNivelTraza);
        pkg_traza.trace('inuNroCuotas   <= '||inuNroCuotas, csbNivelTraza);

        Pkg_Error.SetApplication(csbNotaProg);

        -- Validar datos obligatorios
        IF inuProducto IS NULL THEN
            osbError := 'Falta indicar el producto al que se le acreditara la deuda';
            pkg_error.setErrorMessage( isbMsgErrr => osbError);
        END IF;

        IF inuConcepto IS NULL THEN
            osbError := 'Falta indicar el concepto al que se va a acreditar';
            pkg_error.setErrorMessage( isbMsgErrr => osbError);
        END IF;

        IF nvl(inuValor,0) <= 0 THEN
            osbError := 'El valor a debitar debe ser mayor a cero';
            pkg_error.setErrorMessage( isbMsgErrr => osbError);
        END IF;

        IF inuCausaCargo IS NULL THEN
            osbError := 'Falta indicar la causa cargo';
            pkg_error.setErrorMessage( isbMsgErrr => osbError);
        END IF;
        
        IF inuPlanId is not null and inuNroCuotas is not null  then
            begin
                --Simula financiación
                pkg_gestiondiferidos.pSimProyCuotas
                (
                    inuProducto,
                    inuPlanId,
                    inuNroCuotas,
                    inuConcepto, 
                    inuValor
                );
            exception
                when pkg_error.CONTROLLED_ERROR then
                    pkg_error.geterror(nuError, osbError);
                    osbError := osbError||' Concepto ['||inuConcepto||'].';
                    osbError := osbError||' Valor ['||inuValor||']';
                    osbError := osbError||' Plan ['||inuPlanId||']';
                    osbError := osbError||' Cuotas ['||inuNroCuotas||']';
                    RAISE pkg_error.CONTROLLED_ERROR;
            end;
        End If;

        proInsMantenimientoNotaDet(inuCuenta_cobro => -1, --
                                   inuProducto => inuProducto, --
                                   inuConcepto => inuConcepto, --
                                   inuSigno => csbDebito, --
                                   inuValor => inuValor, --
                                   inuCausa_cargo => inuCausaCargo, --
                                   osbError => osbError);


        --Registramos en LDC_MANTENIMIENTO_NOTAS_DIF la información para ser usada en proceso
        --de aprobacion de moviemntos finacieros
        insert into LDC_MANTENIMIENTO_NOTAS_DIF(PACKAGE_ID, PRODUCT_ID, CUCOCODI, CONCEPTO_ID,  CUOTAS, PLAN_DIFE, SESION)
          values(-1, inuProducto, -1, inuConcepto, inuNroCuotas, inuPlanId, gnuSesion);

        pkg_traza.trace('osbError => '||osbError, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
        
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_error.geterror(nuError, sbError);
            osbError := sbError;
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
        WHEN OTHERS THEN
            Pkg_Error.setError;
            pkg_error.geterror(nuError, sbError);
            osbError := sbError;
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
    END proDetDebitarConcepto;
    
    PROCEDURE proDetDebitarCuentaCobro
    (
        inuProducto   pr_product.product_id%TYPE, -- Producto
        inuCuenCobr   cuencobr.cucocodi%TYPE, -- CuentaCobro
        inuCausaCargo causcarg.cacacodi%TYPE, -- Causa cargo
        osbError      OUT VARCHAR2
    ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proDetDebitarCuentaCobro
        Descripcion:        Permite preparar la informacion

        El sistema debe permitir seleccionar cualquier cuenta de cobro asociada al producto seleccionado
        sin saldo, esta cuenta debe tener saldo generados por el programa FGCA


        Autor    : Ronald Colpas C.
        Fecha    : 21-05-2019  CA 200-1650

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificación
        -----------  -------------------    -------------------------------------
        21-05-2019   Ronald Colpas C.       Creación
        25-09-2024   jcatuche               OSF-3332: Se ajusta cursor cuCargFGCA, añadiendo validación para conceptos base, impuesto y liquidación de impuesto,
                                            ahora solo se gestionan conceptos base y a aquellos con configuración de impuesto se les calcula el impuesto
                                            Se agrega parámetro de entrada valor_base al llamado proInsMantenimientoNotaDet
        ******************************************************************/

        csbMetodo         VARCHAR2(4000) := 'proDetDebitarCuentaCobro';
        nuSaldoCuenCobr   cuencobr.cucosacu%TYPE; -- Saldo de la cuenta de cobro
        nucantconc        NUMBER; --cantidad de conceptos en la cuenta de cobro
        swExist           NUMBER := 0; --sw para saber si hay cargos del programa FGCA
        nuValorDigitado   NUMBER; --valor digitado en la pantalla
        nuvalor           NUMBER; --valor porcionado de la deuda por concepto

        nuVenc            NUMBER; --vencimiento de la cta 0 vencida, 1 actual
        nuPorIva          NUMBER;
        nuValorIva        NUMBER; --valor de Iva
        nuValorBase       NUMBER;
        nuServ            NUMBER;

        CURSOR cuCargFGCA is
        with base as 
        (
            SELECT 
            (
                select case when concticl = cnuTipoconcliq then 'N' else 'S' end
                from concepto 
                where conccodi = cargconc
            ) esbase, 
            case when cargcaca = 51 and (cargdoso like 'DF%' or cargdoso like 'FD%' or cargdoso like 'CX%') then 'N' else 'S' end liqimp,
            (
                select coblconc from concbali,concepto a
                where coblcoba = cargconc
                and a.conccodi = coblconc
                and a.concticl = cnuTipoconcliq
            ) impuesto,c.*
            FROM cargos c
            WHERE cargcuco = inuCuenCobr
            AND cargprog = 5
        )
        select * from base 
        where esbase = 'S';


    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_traza.trace('inuProducto    <= '||inuProducto, csbNivelTraza);
        pkg_traza.trace('inuCuenCobr    <= '||inuCuenCobr, csbNivelTraza);
        pkg_traza.trace('inuCausaCargo  <= '||inuCausaCargo, csbNivelTraza);

        -- Validar datos obligatorios
        IF inuProducto IS NULL THEN
            osbError := 'Falta indicar el producto al que se le acreditara la deuda';
            pkg_error.setErrorMessage( isbMsgErrr => osbError);
        END IF;

        IF inuCuenCobr IS NULL THEN
            osbError := 'Falta indicar el numero de cuenta de cobro a acreditar';
            pkg_error.setErrorMessage( isbMsgErrr => osbError);
        END IF;

        IF inuCausaCargo IS NULL THEN
            osbError := 'Falta indicar la causa cargo';
            pkg_error.setErrorMessage( isbMsgErrr => osbError);
        END IF;

        -- Obtener el saldo total de la cuenta de cobro
        proDeudaCuentaCobro(inuProducto => inuProducto, --
                            inuCuenCobr => inuCuenCobr, --
                            onuSaldoCuenCobr => nuSaldoCuenCobr, --
                            osbError => osbError);

        IF osbError IS NOT NULL THEN
            pkg_error.setErrorMessage( isbMsgErrr => osbError);
        END IF;

        IF nuSaldoCuenCobr > 0 THEN
            osbError := 'La cuenta de cobro ' || inuCuenCobr ||
                      ' a la que se quiere aplicar novedad debitar por cuenta de cobro esta con saldo pendiente ';
            pkg_error.setErrorMessage( isbMsgErrr => osbError);
        END IF;

        swExist := 0;
        nuServ := pkg_bcproducto.fnuTipoProducto(inuProducto);
        -- Recorrer todos los conceptos de la cuenta de cobro seleccionada generados por FGCA
        FOR rgConceptosCC IN cuCargFGCA LOOP
            
            swExist := 1;
            
            proInsMantenimientoNotaDet(inuCuenta_cobro => inuCuenCobr, --
                                 inuProducto => inuProducto, --
                                 inuConcepto => rgConceptosCC.Cargconc, --
                                 inuSigno => rgConceptosCC.Cargsign, --
                                 inuValor => rgConceptosCC.Cargvalo, --
                                 inuCausa_cargo => inuCausaCargo, --
                                 osbError => osbError);
            
            IF osbError IS NOT NULL THEN
                pkg_error.setErrorMessage( isbMsgErrr => osbError);
            END IF;
                                 
            IF rgConceptosCC.liqimp = 'S' and rgConceptosCC.impuesto is not null then
            
                nuPorIva := 0;
                nuPorIva   := fnutraePIva(inuconcepto => rgConceptosCC.impuesto, inuserv => nuServ);
                
                IF nuPorIva <= 0 then
                    osbError := 'El concepto de impuesto '||rgConceptosCC.impuesto||' en la cuenta '||inuCuenCobr||' no tiene % válido ['||nuPorIva||']';
                    pkg_error.setErrorMessage( isbMsgErrr => osbError);
                END IF;
                
                nuValorBase := rgConceptosCC.Cargvalo;
                nuValorIva := round(nuValorBase * (nuPorIva / 100), 0);
                
                proInsMantenimientoNotaDet(inuCuenta_cobro => inuCuenCobr, --
                                 inuProducto => inuProducto, --
                                 inuConcepto => rgConceptosCC.impuesto, --
                                 inuSigno => rgConceptosCC.Cargsign, --
                                 inuValor => nuValorIva, --
                                 inuCausa_cargo => inuCausaCargo, --
                                 inuValor_Base => nuValorBase,
                                 osbError => osbError);
                                 
                IF osbError IS NOT NULL THEN
                    pkg_error.setErrorMessage( isbMsgErrr => osbError);
                END IF;
                
            END IF;
            
            pkg_traza.trace('Novedad Debitar CC concepto: ' || rgConceptosCC.Cargconc,csbNivelTraza);

        END LOOP;

        IF swExist = 0 THEN
            osbError := 'La cuenta de cobro ' || inuCuenCobr ||
                           ' a la que se quiere aplicar novedad '||
                           'debitar por cuenta de cobro no tiene cargos generados por FGCA';
            pkg_error.setErrorMessage( isbMsgErrr => osbError);
        END IF;

        pkg_traza.trace('osbError => '||osbError, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
        
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_error.geterror(nuError, sbError);
            osbError := sbError;
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
        WHEN OTHERS THEN
            Pkg_Error.setError;
            pkg_error.geterror(nuError, sbError);
            osbError := sbError;
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
    END proDetDebitarCuentaCobro;

    PROCEDURE proDetDebitarConceptoYCC
    (
        inuProducto   pr_product.product_id%TYPE, -- Producto
        inuConcepto   concepto.conccodi%TYPE, -- Concepto
        inuValor      cargos.cargvalo%TYPE, -- Valor a acreditar
        inuCuenCobr   cuencobr.cucocodi%TYPE, -- Cuenta de cobro
        inuCausaCargo causcarg.cacacodi%TYPE, -- Causa cargo
        osbError      OUT VARCHAR2
    ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proDetDebitarConceptoYCC
        Descripcion:        Almacena la informacion a debitar

        Autor    : Ronald Colpas C.
        Fecha    : 20-05-2019  CA 200-1650

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificación
        -----------  -------------------    -------------------------------------
        20-05-2019   Ronad Colpas C.        Creación
        22-08-2023   Diana.Montes           OSF-1343: Se coloca la validacion inuValor < 0 para que 
                                            no permita registrar valores negativos
        25-09-2024   jcatuche               OSF-3332: Se agrega parámetro de entrada valor_base al llamado proInsMantenimientoNotaDet
        ******************************************************************/

        csbMetodo       VARCHAR2(4000) := csbPaquete||'proDetDebitarConceptoYCC';
        nuValorsubsidio NUMBER(8); --valor del subsidio en caso de que el concepto tenga
        nuValorIva      NUMBER; --valor de Iva
        nuConcIva       NUMBER := 0; --concept Iva
        nuValorMora     NUMBER; --valor de mora
        nuConcMora      NUMBER; --concept mora

        nuPorIva        NUMBER; --porcentaje IVA
        nuValor         NUMBER := 0; --valor del concepto base
        nuValorConc     NUMBER; --valor conpeto asociados de base
        nuValorsubsidioCovid NUMBER(8);
        nuValorCovid    NUMBER(8);
        
        
       --Consulta el concepto IVA del base
       CURSOR cuConcIva is
          SELECT c.coblconc
            FROM concbali c
           WHERE c.coblcoba = inuConcepto
             AND c.coblcoba <> 137
             AND EXISTS (SELECT 1
                    FROM concepto t
                   WHERE t.conccodi = c.coblconc
                     AND t.concticl = cnuTipoconcliq);

    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_traza.trace('inuProducto    <= '||inuProducto, csbNivelTraza);
        pkg_traza.trace('inuConcepto    <= '||inuConcepto, csbNivelTraza);
        pkg_traza.trace('inuValor       <= '||inuValor, csbNivelTraza);
        pkg_traza.trace('inuCuenCobr    <= '||inuCuenCobr, csbNivelTraza);
        pkg_traza.trace('inuCausaCargo  <= '||inuCausaCargo, csbNivelTraza);

        -- Validar datos obligatorios
        IF inuProducto IS NULL THEN
            osbError := 'Falta indicar el producto al que se le acreditara la deuda';
            pkg_error.setErrorMessage( isbMsgErrr => osbError);
        END IF;

        IF inuConcepto IS NULL THEN
            osbError := 'Falta indicar el concepto al que se va a acreditar';
            pkg_error.setErrorMessage( isbMsgErrr => osbError);
        END IF;

        IF inuValor IS NULL THEN
            osbError := 'Falta ingresar el valor a acreditar';
            pkg_error.setErrorMessage( isbMsgErrr => osbError);
        END IF;
        
        IF nvl(inuValor,0) <= 0 THEN
            osbError := 'El valor a debitar debe ser mayor a cero';
            pkg_error.setErrorMessage( isbMsgErrr => osbError);
        END IF;
        
        IF inuCuenCobr IS NULL THEN
            osbError := 'Falta la cuenta de cobro en la que se acreditara la cuenta de cobro';
            pkg_error.setErrorMessage( isbMsgErrr => osbError);
        END IF;

        IF inuCausaCargo IS NULL THEN
            osbError := 'Falta indicar la causa cargo';
            pkg_error.setErrorMessage( isbMsgErrr => osbError);
        END IF;

        -- Acreditar el concepto
        proInsMantenimientoNotaDet(inuCuenta_cobro => inuCuenCobr, --
                                   inuProducto => inuProducto, --
                                   inuConcepto => inuConcepto, --
                                   inuSigno => csbDebito, --
                                   inuValor => inuValor, --
                                   inuCausa_cargo => inuCausaCargo, --
                                   osbError => osbError);

        IF osbError IS NOT NULL THEN
            pkg_error.setErrorMessage( isbMsgErrr => osbError);
        END IF;

        --Validamos si el concepto base tiene Iva para calcularlo
        OPEN cuConcIva;
        FETCH cuConcIva INTO nuConcIva;
        IF cuConcIva%FOUND THEN
            --Realiza calculo para el valor del IVA
            nuPorIva   := fnutraePIva(inuconcepto => nuConcIva, inuserv => PKG_BCPRODUCTO.FNUTIPOPRODUCTO(inuProducto));
            nuValorIva := round(inuValor * (nuPorIva / 100), 0);

            pkg_traza.trace('Acredita concepto IVA: '||nuConcIva||' va a insertar valor de: '||nuValorIva ||' porcentaje IVA: '||nuPorIva,csbNivelTraza);

            IF nuValorIva != 0 THEN
                proInsMantenimientoNotaDet(inuCuenta_cobro => inuCuenCobr, --
                                       inuProducto => inuProducto, --
                                       inuConcepto => nuConcIva, --
                                       inuSigno => csbDebito, --
                                       inuValor => nuValorIva, --
                                       inuCausa_cargo => inuCausaCargo, --
                                       inuValor_Base => inuValor,
                                       osbError => osbError);
                IF osbError IS NOT NULL THEN
                    pkg_error.setErrorMessage( isbMsgErrr => osbError);
                END IF;

            END IF;
        END IF;

        pkg_traza.trace('osbError => '||osbError, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
        
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_error.geterror(nuError, sbError);
            osbError := sbError;
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
        WHEN OTHERS THEN
            Pkg_Error.setError;
            pkg_error.geterror(nuError, sbError);
            osbError := sbError;
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
    END proDetDebitarConceptoYCC;

    PROCEDURE proCalcularProyectado
    (
        inuProducto LDC_MANTENIMIENTO_NOTAS_PROY.producto%TYPE,
        osbError    OUT VARCHAR2
    ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proCalcularProyectado
        Descripcion:        Carga toda la informacion para poder calcular la deuda proyectada

        Autor    : Sandra Muñoz

        Fecha    : 15-04-2016  CA 200-201

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificación
        -----------  -------------------    -------------------------------------
        12-04-2018   Ronald Colpas          caso 2001650 se omite validacion de aplicacion de entrega fblaplicaentrega

        15-04-2016   Sandra Muñoz           Creación
        ******************************************************************/

        csbMetodo   CONSTANT VARCHAR2(100) := csbPaquete||'proCalcularProyectado';

        
        CURSOR cuNovedades IS
            SELECT producto,
                   novedad,
                   concepto,
                   cuenta_cobro,
                   valor,
                   causa_cargo,
                   cuotas,
                   plan_diferido,
                   sesion
            FROM ldc_mantenimiento_notas_enc
            WHERE sesion = gnuSesion
                  AND producto = inuProducto

            ;

    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_traza.trace('inuProducto <= '||inuProducto, csbNivelTraza);

        -- Calcular los saldos por concepto actuales

        proCargaDeudaActual(inuProducto => inuProducto, osbError => osbError);

        -- Recorrer las novedades ingresadas

        FOR rgNovedades IN cuNovedades
        LOOP

            IF rgNovedades.Novedad = 'AD' THEN
                proProyAcreditarDeuda(inuProducto => rgNovedades.Producto, --
                                      osbError => osbError);
            ELSIF rgNovedades.Novedad = 'AC' THEN
                proProyAcreditarConcepto(inuProducto => rgNovedades.Producto, --
                                         inuConcepto => rgNovedades.Concepto, --
                                         osbError => osbError);
            ELSIF rgNovedades.Novedad = 'ACC' THEN
                proProyAcreditarCuentaCobro(inuProducto => rgNovedades.Producto, --
                                            inuCuenCobr => rgNovedades.Cuenta_Cobro, --
                                            osbError => osbError);
            ELSIF rgNovedades.Novedad = 'ACCC' THEN

                proProyAcreditarConceptoYCC(inuProducto => rgNovedades.Producto, --
                                            inuConcepto => rgNovedades.Concepto, --
                                            inuValor => rgNovedades.Valor, --
                                            inuCuenCobr => rgNovedades.Cuenta_Cobro, --
                                            osbError => osbError);

            ELSIF rgNovedades.Novedad = 'DC'
                  AND rgNovedades.Cuotas IS NOT NULL
                  AND rgNovedades.Plan_Diferido IS NOT NULL THEN
                --se proyecta debito con la formacion de un diferido
                proProyDebitarConcepto(inuProducto => rgNovedades.Producto, --
                                       inuConcepto => rgNovedades.Concepto, --
                                       inuValor => rgNovedades.Valor, --
                                       inuPlan => rgNovedades.Plan_Diferido,
                                       osbError => osbError);
            ELSIF rgNovedades.Novedad = 'DC'
                  AND rgNovedades.Cuotas IS NULL
                  AND rgNovedades.Plan_Diferido IS NULL THEN
                --se proyecta debito a presente mes
                proProyDebitarConceptoPM(inuProducto => rgNovedades.Producto, --
                                         inuConcepto => rgNovedades.Concepto, --
                                         inuValor => rgNovedades.Valor, isbpresente => 'S', osbError => osbError);

            ELSIF rgNovedades.Novedad = 'DCC' THEN
                --Nueva novedad proyectar debitar por cuenta de cobro
                proProyDebitarCuentaCobro(inuProducto => rgNovedades.Producto, --
                                            inuCuenCobr => rgNovedades.Cuenta_Cobro, --
                                            osbError => osbError);

            ELSIF rgNovedades.Novedad = 'DCCC' THEN
              --Nueva novedad proyectar debitar por concepto y cuenta de cobro
              proProyDebitarConceptoYCC(inuProducto => rgNovedades.Producto, --
                                        inuConcepto => rgNovedades.Concepto, --
                                        inuValor => rgNovedades.Valor, --
                                        inuCuenCobr => rgNovedades.Cuenta_Cobro, --
                                        osbError => osbError);
            END IF;

            IF osbError IS NOT NULL THEN
                pkg_error.setErrorMessage( isbMsgErrr => osbError);
            END IF;
        END LOOP;

        COMMIT;

        pkg_traza.trace('osbError => '||osbError, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
        
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_error.geterror(nuError, sbError);
            osbError := sbError;
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
        WHEN OTHERS THEN
            Pkg_Error.setError;
            pkg_error.geterror(nuError, sbError);
            osbError := sbError;
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
    END proCalcularProyectado;

    PROCEDURE proMostrarDeudaActual
    (
        inuProducto                   LDC_MANTENIMIENTO_NOTAS_PROY.producto%TYPE,
        ocrLDC_MANTENIMIENTO_NOTAS_PR OUT CONSTANTS_PER.TYREFCURSOR,
        onucreditbalance              OUT NUMBER,
        onuclaimvalue                 OUT NUMBER,
        onudefclaimvalue              OUT NUMBER,
        osbError                      OUT VARCHAR2
    ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proMostrarDeudaActual
        Descripcion:        Muestra la deuda actual por concepto

        Autor    : Sandra Muñoz

        Fecha    : 15-04-2016  CA 200-201

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificación
        -----------  -------------------    -------------------------------------
        11-12-2018   Ronald colpas          caso2001650 se modifica cursor ocrLDC_MANTENIMIENTO_NOTAS_PR
                                            para incluir el valor vencido
        15-04-2016   Sandra Muñoz           Creación
        ******************************************************************/

        csbMetodo   CONSTANT VARCHAR2(100) := csbPaquete||'proMostrarDeudaActual';

        nucurrentaccounttotal  NUMBER;
        nudeferredaccounttotal NUMBER;
        nuContrato  pr_product.subscription_id%type;
        otbbalanceaccounts CONSTANTS_PER.TYREFCURSOR; --fa_boaccountstatustodate.tytbbalanceaccounts;
        otbdeferredbalance CONSTANTS_PER.TYREFCURSOR; --fa_boaccountstatustodate.tytbdeferredbalance;


    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_traza.trace('inuProducto <= '||inuProducto, csbNivelTraza);

        -- Consulta cursor referenciado
        OPEN ocrLDC_MANTENIMIENTO_NOTAS_PR FOR
            SELECT lmn.producto,
                   lmn.concepto,
                   c.concdesc,
                   SUM(DECODE(nvl(lmn.signo_corriente, 'DB'), 'DB', lmn.valor_corriente, 'SA', lmn.valor_corriente, -NVL(lmn.valor_corriente, 0))) valor_corriente,
                   SUM(DECODE(nvl(lmn.signo_corriente, 'DB'), 'DB', lmn.valor_vencido, 'SA', lmn.valor_vencido, -NVL(lmn.valor_vencido, 0))) valor_vencido,
                   SUM(DECODE(NVL(lmn.signo_diferido, 'DB'), 'DB', nvl(lmn.valor_diferido, 0), -nvl(valor_diferido, 0))) valor_diferido,
                   SUM(DECODE(nvl(lmn.signo_corriente, 'DB'), 'DB', lmn.valor_corriente, 'SA', lmn.valor_corriente, -NVL(lmn.valor_corriente, 0))) +
                   SUM(DECODE(nvl(lmn.signo_corriente, 'DB'), 'DB', lmn.valor_vencido, 'SA', lmn.valor_vencido, -NVL(lmn.valor_vencido, 0))) +
                   SUM(DECODE(NVL(lmn.signo_diferido, 'DB'), 'DB', nvl(lmn.valor_diferido, 0), -nvl(valor_diferido, 0))) valor_total
            FROM LDC_MANTENIMIENTO_NOTAS_PROY lmn, concepto c
            WHERE lmn.SESION = gnuSesion
                  AND lmn.producto = inuProducto
                  AND c.conccodi = lmn.concepto
                  AND lmn.origen = 'D'

            GROUP BY lmn.producto, lmn.concepto, c.concdesc
            ORDER BY lmn.producto, lmn.concepto;

        --obtengo el contrato del producto
        nuContrato := pkg_bcproducto.fnuContrato(inuProducto);
        if nuContrato is null then
            osbError:= 'El producto '||inuProducto||' no existe en la BD';
            pkg_error.setErrorMessage( isbMsgErrr => osbError);
        end if;

        --Mod. 10-12-2018 Saldo a Favor, Valor Reclamo, Valor reclamo diferido.
         fa_boaccountstatustodate.subscriptaccountstatustodate(inusubscriptionid => nuContrato,
                                                               idtdate => sysdate,
                                                               onucurrentaccounttotal => nucurrentaccounttotal,
                                                               onudeferredaccounttotal => nudeferredaccounttotal,
                                                               onucreditbalance => onucreditbalance,
                                                               onuclaimvalue => onuclaimvalue,
                                                               onudefclaimvalue => onudefclaimvalue,
                                                               orfresumeaccountdetail => otbbalanceaccounts,
                                                               orfaccountdetail => otbdeferredbalance);

        pkg_traza.trace('onucreditbalance   => '||onucreditbalance, csbNivelTraza);
        pkg_traza.trace('onuclaimvalue      => '||onuclaimvalue, csbNivelTraza);
        pkg_traza.trace('onudefclaimvalue   => '||onudefclaimvalue, csbNivelTraza);
        pkg_traza.trace('osbError           => '||osbError, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
        
    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            pkg_error.geterror(nuError, sbError);
            osbError := sbError;
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
        WHEN OTHERS THEN
            Pkg_Error.setError;
            pkg_error.geterror(nuError, sbError);
            osbError := sbError;
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
    END;

    PROCEDURE proMostrarProyectado
    (
        inuProducto                   LDC_MANTENIMIENTO_NOTAS_PROY.producto%TYPE,
        ocrLDC_MANTENIMIENTO_NOTAS_PR OUT CONSTANTS_PER.TYREFCURSOR,
        osbError                      OUT VARCHAR2
    ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete:proMostrarProyectado
        Descripcion:

        Autor    : Sandra Muñoz

        Fecha    : 15-04-2016  CA 200-201

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificación
        -----------  -------------------    -------------------------------------
        11-12-2018   Ronald colpas          caso2001650 se modifica cursor ocrLDC_MANTENIMIENTO_NOTAS_PR
                                            para incluir el valor vencido
        15-04-2016   Sandra Muñoz           Creación
        ******************************************************************/

        csbMetodo   CONSTANT VARCHAR2(100) := csbPaquete||'proMostrarProyectado';

    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_traza.trace('inuProducto <= '||inuProducto, csbNivelTraza);

        -- Consulta cursor referenciado
        OPEN ocrLDC_MANTENIMIENTO_NOTAS_PR FOR
            SELECT lmn.producto,
                   lmn.concepto,
                   c.concdesc,
                   SUM(DECODE(nvl(lmn.signo_corriente, 'DB'), 'DB', lmn.valor_corriente, 'SA', lmn.valor_corriente, -NVL(lmn.valor_corriente, 0))) valor_corriente,
                   SUM(DECODE(nvl(lmn.signo_corriente, 'DB'), 'DB', lmn.valor_vencido, 'SA', lmn.valor_vencido, -NVL(lmn.valor_vencido, 0))) valor_vencido,
                   SUM(DECODE(NVL(lmn.signo_diferido, 'DB'), 'DB', nvl(lmn.valor_diferido, 0), -nvl(valor_diferido, 0))) valor_diferido,
                   SUM(DECODE(nvl(lmn.signo_corriente, 'DB'), 'DB', lmn.valor_corriente, 'SA', lmn.valor_corriente, -NVL(lmn.valor_corriente, 0))) +
                   SUM(DECODE(nvl(lmn.signo_corriente, 'DB'), 'DB', lmn.valor_vencido, 'SA', lmn.valor_vencido, -NVL(lmn.valor_vencido, 0))) +
                   SUM(DECODE(NVL(lmn.signo_diferido, 'DB'), 'DB', nvl(lmn.valor_diferido, 0), -nvl(valor_diferido, 0))) valor_total
            FROM LDC_MANTENIMIENTO_NOTAS_PROY lmn, concepto c
            WHERE lmn.SESION = gnuSesion
                  AND lmn.producto = inuProducto
                  AND c.conccodi = lmn.concepto

            GROUP BY lmn.producto, lmn.concepto, c.concdesc
            ORDER BY lmn.producto, lmn.concepto;

        pkg_traza.trace('osbError => '||osbError, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
        
    EXCEPTION
        WHEN OTHERS THEN
            Pkg_Error.setError;
            pkg_error.geterror(nuError, sbError);
            osbError := sbError;
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
    END;

    PROCEDURE proDesglosaAcreditarDeuda
    (
        inuProducto pr_product.product_id%TYPE, -- Producto
        osbError    OUT VARCHAR2
    ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proDesglosaAcreditarDeuda
        Descripcion:        Genera las solicitudes de aprobacion de notas

        Autor    : Sandra Muñoz
        Fecha    : 15-04-2016  CA 200-201

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificación
        -----------  -------------------    -------------------------------------
        15-04-2016   Sandra Muñoz           Creación
        ******************************************************************/

        csbMetodo    VARCHAR2(4000) := csbPaquete||'proDesglosaAcreditarDeuda';
        

        CURSOR cuDeudaConcepto IS
            SELECT signo_corriente,
                   valor_corriente,
                   valor_vencido,
                   concepto,
                   valor_diferido,
                   signo_diferido
            FROM ldc_mantenimiento_notas_proy lmn
            WHERE lmn.sesion = gnuSesion
                  AND lmn.producto = inuProducto
                  AND lmn.origen = 'D'
                  AND lmn.signo_corriente = csbDebito -- Deuda real de los productos
            ;

        
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_traza.trace('inuProducto <= '||inuProducto, csbNivelTraza);
        
        -- Validar datos obligatorios
        IF inuProducto IS NULL THEN
            osbError := 'Falta indicar el producto al que se le acreditara la deuda';
            pkg_error.setErrorMessage( isbMsgErrr => osbError);
        END IF;

        -- Obtener los conceptos con deuda del producto
        FOR rgDeudaConcepto IN cuDeudaConcepto
        LOOP

            -- Crear registro CR
            proInsMantenimientoNotaProy(inuProducto => inuProducto, isbSignoCorriente => csbCredito, inuValorCorriente => rgDeudaConcepto.Valor_Corriente, inuValorVencido => rgDeudaConcepto.valor_vencido, inuConcepto => rgDeudaConcepto.concepto, isbOrigen => 'P', inuValorDiferido => 0, isbSignoDiferido => 0, osbError => osbError);

            IF osbError IS NOT NULL THEN
                pkg_error.setErrorMessage( isbMsgErrr => osbError);
            END IF;

        END LOOP;

        pkg_traza.trace('osbError => '||osbError, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
        
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_error.geterror(nuError, sbError);
            osbError := sbError;
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
        WHEN OTHERS THEN
            Pkg_Error.setError;
            pkg_error.geterror(nuError, sbError);
            osbError := sbError;
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
    END proDesglosaAcreditarDeuda;

    FUNCTION fnuGeneraNota
    (
        inuSolicitud       mo_packages.package_id%TYPE, -- Solicitud
        isbUsuarioRegistra FA_APROMOFA.APMOUSRE%TYPE -- Usuario que registra
    ) RETURN NUMBER IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: fnuGeneraNota
        Descripcion:        El sistema debe controlar que un usuario de aplicacion no pueda realizar
                            notas por un valor mayor de lo permitido en su perfil financiero a un
                            mismo contrato en un periodo de tiempo.
                            Si se llega a pasar de este limite se debe enviar a visado para autorizar
                            la realizacion de las notas.
                            Para los casos en que el producto este pendiente de instalacion y tenga
                            una venta registrada, siempre deben enviar a visado es posible
                            independientemente del monto.

                            Indica si se debe puede generar la nota sin aprobacion:
                            1 = Si
                            0 = No

        Autor    : Sandra Muñoz
        Fecha    : 15-04-2016  CA 200-201

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificación
        -----------  -------------------    -------------------------------------
        12-04-2018   Ronald Colpas          caso 2001650 se omite validacion de aplicacion de entrega fblaplicaentrega

        15-04-2016   Sandra Muñoz           Creación
        ******************************************************************/

        csbMetodo                    VARCHAR2(4000) := csbPaquete||'fnuGeneraNota';
        nuMaxMontoPerfilFinanciero   NUMBER; -- Maximo monto autorizado para el perfil financiero del usuario
        nuGeneraNota                 NUMBER := 1; -- Indica si se genera la nota o se envia a visado
        nuProducto                   pr_product.product_id%TYPE; -- Producto
        nuProductStatus              pr_product.product_status_id%TYPE;
        nuNumeroDias                 ld_parameter.numeric_value%TYPE; -- Numero de dias en las que se evaluara si un producto ya se le crearon notas
        nuAcumuladoNotas             NUMBER; -- Valor de las notas generadas en un periodo de tiempo para un cliente a un mismo producto
        sbEstadoPendienteInstalacion ld_parameter.value_chain%TYPE; -- Estados de producto que indican que esta pendiente de instalacion
        sbSolicitudVenta             ld_parameter.value_chain%TYPE; -- Tipos de solicitud de venta
        nuSolicitudRegistrado        ld_parameter.numeric_value%TYPE; -- Estado registrado de una solicitud
        nuTieneVentaRegistrada       ld_parameter.numeric_value%TYPE; -- Indica si un producto tiene venta registrada
        
        
        cursor cuProducto is
        SELECT product_id
        FROM mo_motive mm
        WHERE mm.package_id = inuSolicitud;
        
        cursor cuAcumuladoNotas is
        SELECT SUM(nvl(fca.caapvalo, 0))
        FROM fa_apromofa famf,
             mo_motive   mm,
             fa_notaapro fna,
             fa_cargapro fca
        WHERE famf.apmousre = isbUsuarioRegistra
              AND famf.apmosoli = mm.package_id
              AND trunc(famf.apmofere) >=
              trunc(SYSDATE) - nvl(nuNumeroDias, 0)
              AND mm.product_id = nuProducto
              AND famf.apmocons = fna.noapapmo
              AND fna.noapnume = fca.caapnoap
              AND fca.caapsign = csbCredito;
        
        cursor cuTieneVentaRegistrada is 
        SELECT COUNT(1)
        FROM mo_packages mp, mo_motive mm
        WHERE mp.package_id = mm.package_id
              AND mm.product_id = nuProducto
              AND
              instr(sbSolicitudVenta, mp.package_type_id || '|') > 0
              AND mp.motive_status_id = nuSolicitudRegistrado;
        
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_traza.trace('inuSolicitud       <= '||inuSolicitud, csbNivelTraza);
        pkg_traza.trace('isbUsuarioRegistra <= '||isbUsuarioRegistra, csbNivelTraza);
        
        if cuProducto%isopen then
            close cuProducto;
        end if;
        
        if cuAcumuladoNotas%isopen then
            close cuAcumuladoNotas;
        end if;
        
        if cuTieneVentaRegistrada%isopen then
            close cuTieneVentaRegistrada;
        end if;

        -- Obtener los valores de los parametros
        nuNumeroDias := pkg_bcld_parameter.fnuObtieneValorNumerico('DIAS_MONTO_NOTAS');
        IF nuNumeroDias IS NULL THEN
            sbError := 'No se ha definido el parametro DIAS_MONTO_NOTAS';
            pkg_error.setErrorMessage( isbMsgErrr => sbError);
        END IF;

        sbEstadoPendienteInstalacion := pkg_bcld_parameter.fsbObtieneValorCadena('PRODUCTO_PENDIENTE_INSTALACION');
        IF sbEstadoPendienteInstalacion IS NULL THEN
            sbError := 'No se ha definido el parametro PRODUCTO_PENDIENTE_INSTALACION';
            pkg_error.setErrorMessage( isbMsgErrr => sbError);
        END IF;

        sbSolicitudVenta := pkg_bcld_parameter.fsbObtieneValorCadena('SOLICITUDES_VENTA');
        IF sbSolicitudVenta IS NULL THEN
            sbError := 'No se ha definido el parametro SOLICITUDES_VENTA';
            pkg_error.setErrorMessage( isbMsgErrr => sbError);
        END IF;

        nuSolicitudRegistrado := pkg_bcld_parameter.fnuObtieneValorNumerico('FNB_ESTADOSOL_REG');
        IF nuSolicitudRegistrado IS NULL THEN
            sbError := 'No se ha definido el parametro FNB_ESTADOSOL_REG';
            pkg_error.setErrorMessage( isbMsgErrr => sbError);
        END IF;
        
        pkg_traza.trace('va a obtener el perfil financiero',csbNivelTraza);
        -- Obtener el monto maximo autorizado para el perfil financiero del usuario
        nuMaxMontoPerfilFinanciero := GE_BOFinancialProfile.fnuMaxAmountByUser(4, pkg_session.fnugetuseridbymask(isbUsuarioRegistra));
        
        pkg_traza.trace('usuario ' || isbUsuarioRegistra || ' valor ' ||nuMaxMontoPerfilFinanciero,csbNivelTraza);

        -- Valida si la entrega aplica para la gasera
        --caso-2001650 Se omite validacion de aplicacion de entrega

        -- Tener en cuenta que si el total de notas aplicadas a un mismo concepto en un producto
        -- en el dia por el usuario final es superior a lo que indica su perfil financiero se
        -- debe solicitar visado
        open cuProducto;
        fetch cuProducto into nuProducto;
        if cuProducto%notfound then
            close cuProducto;
            sbError := 'Error al intentar obtener el producto asociado a la solicitud '||inuSolicitud;
            pkg_error.setErrorMessage( isbMsgErrr => sbError);
        end if;
        close cuProducto;
                
        pkg_traza.trace(' producto ' || nuProducto,csbNivelTraza);            
         
        nuAcumuladoNotas := null;   
        open cuAcumuladoNotas;
        fetch cuAcumuladoNotas into nuAcumuladoNotas;
        close cuAcumuladoNotas;
        
        if nuAcumuladoNotas is null then 
            sbError := 'No fue posible obtener el valor de las notas realizadas';
            pkg_error.setErrorMessage( isbMsgErrr => sbError);
        end if;
        
        pkg_traza.trace(' valor acumulado de notas '||nuAcumuladoNotas,csbNivelTraza);
            
        -- Requiere aprobacion
        IF nuAcumuladoNotas > nuMaxMontoPerfilFinanciero THEN
            nuGeneraNota := 0;
            pkg_traza.trace(' =0 ' || nuGeneraNota,csbNivelTraza);
        ELSE
            nuGeneraNota := 1;
            pkg_traza.trace(' =1 ' || nuGeneraNota,csbNivelTraza);
            --RETURN 0;
        END IF;
        
        pkg_traza.trace(' nugenera ' || nuGeneraNota,csbNivelTraza);
        -- Si el producto tiene una solicitud de venta (587 - Venta, 100277 - Venta de Gas Cotizada IFRS,
        -- 100275 - Venta de Gas por Formulario IFRS, 100271 - Venta de Gas por Formulario
        -- Migración, 100288 - Venta de Gas por Formulario Migracion 2, 100101 - Venta de
        -- Servicios de Ingeniería, 323 - Venta a Constructoras, 271 - Venta de Gas por
        -- Formulario, 100229 - Venta de Gas Cotizada, 100025 - Venta de Accesorios, 100236 -
        -- Venta de Seguros, 100264 - VENTA FNB, 100261 - Venta Seguros XML, 141 - Venta,
        -- 100218 - Venta promigas XML, 100233 - Venta de Gas por Formulario XML,
        -- 100219 - Venta Servicios Financieros) registrada (estado 13) y el parametro de
        -- solicitar visado de aprobacion debe iniciarse el tramite 289.

        nuProductStatus := pkg_bcproducto.fnuEstadoProducto(inuProducto => nuProducto);
        if nuProductStatus is null then
            sbError :='El producto '||nuProducto||' no existe en la BD';
            pkg_error.setErrorMessage( isbMsgErrr => sbError);
        end if;
        
        IF instr(sbEstadoPendienteInstalacion, nuProductStatus || '|') > 0 THEN

            open cuTieneVentaRegistrada;
            fetch cuTieneVentaRegistrada into nuTieneVentaRegistrada;
            close cuTieneVentaRegistrada;

            IF nuTieneVentaRegistrada > 0 THEN
                nuGeneraNota := 0;
                pkg_traza.trace(' venta registrada >0 ',csbNivelTraza);
            ELSE
                nuGeneraNota := 1;
                pkg_traza.trace(' venta registrada =0 ',csbNivelTraza);

            END IF;
        END IF;

        --caso 201650 se omite If de fblaplicaentrega
        pkg_traza.trace('return => '||nuGeneraNota, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
        RETURN nuGeneraNota;
        -- No requiere aprobacion
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_error.geterror(nuError, sbError);
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
        WHEN OTHERS THEN
            Pkg_Error.setError;
            pkg_error.geterror(nuError, sbError);
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
    END fnuGeneraNota;

    PROCEDURE validamonto
    (
        inuproducto pr_product.product_id%TYPE,
        osbError    OUT VARCHAR2
    ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: validamonto
        Descripcion:        Esta procedimiento es para la forma manots, para que saque el mensaje de avertencia antes de grabar, la nota.

                            Indica si se debe puede generar la nota sin aprobacion:
                            1 = Si
                            0 = No

        Autor    : Luis Fren G.
        Fecha    : 04-12-2017

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificación
        -----------  -------------------    -------------------------------------
        15-04-2016   Sandra Muñoz           Creación
        12-04-2018   Ronald Colpas          caso 2001650 se omite validacion de aplicacion de entrega fblaplicaentrega
        25-09-2024   jcatuche               OSF-3332: Se ajusta cursor cuValorAprobacion encargado de obtener el valor del total de cargos
                                            a gestionar [nuValorAprobacion]. Evita error cuando se registra más de un cargo en MANOT
        ******************************************************************/

        csbMetodo                    VARCHAR2(4000) := csbPaquete||'validamonto';
        nuMaxMontoPerfilFinanciero   NUMBER; -- Maximo monto autorizado para el perfil financiero del usuario
        nuGeneraNota                 NUMBER := 1; -- Indica si se genera la nota o se envia a visado
        nuProductStatus              pr_product.product_status_id%TYPE;
        nuNumeroDias                 ld_parameter.numeric_value%TYPE; -- Numero de dias en las que se evaluara si un producto ya se le crearon notas
        nuAcumuladoNotas             NUMBER := 0; -- Valor de las notas generadas en un periodo de tiempo para un cliente a un mismo producto
        sbEstadoPendienteInstalacion ld_parameter.value_chain%TYPE; -- Estados de producto que indican que esta pendiente de instalacion
        sbSolicitudVenta             ld_parameter.value_chain%TYPE; -- Tipos de solicitud de venta
        nuSolicitudRegistrado        ld_parameter.numeric_value%TYPE; -- Estado registrado de una solicitud
        nuTieneVentaRegistrada       ld_parameter.numeric_value%TYPE; -- Indica si un producto tiene venta registrada
        nuvaloraprobacion ldc_mantenimiento_notas_enc.valor%TYPE;
        sbUsuarioRegistra FA_APROMOFA.APMOUSRE%TYPE;
        
        cursor cuValorAprobacion is
        SELECT sum(lmne.valor)
        FROM ldc_mantenimiento_notas_enc lmne
        WHERE lmne.producto = inuProducto
        AND lmne.sesion = gnuSesion;
        
        cursor cuAcumuladoNotas is
        SELECT nvl(SUM(fca.caapvalo),0)
        FROM fa_apromofa famf,
             mo_motive   mm,
             fa_notaapro fna,
             fa_cargapro fca
        WHERE famf.apmousre = sbUsuarioRegistra
              AND famf.apmosoli = mm.package_id
              AND trunc(famf.apmofere) >=
              trunc(SYSDATE) - nvl(nuNumeroDias, 0)
              AND mm.product_id = inuproducto
              AND famf.apmocons = fna.noapapmo
              AND fna.noapnume = fca.caapnoap
              AND fca.caapsign = csbCredito;
        
        cursor cuTieneVentaRegistrada is 
        SELECT COUNT(1)
        FROM mo_packages mp, mo_motive mm
        WHERE mp.package_id = mm.package_id
              AND mm.product_id = InuProducto
              AND
              instr(sbSolicitudVenta, mp.package_type_id || '|') > 0
              AND mp.motive_status_id = nuSolicitudRegistrado;
    
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_traza.trace('inuProducto <= '||inuProducto, csbNivelTraza);
        
        if cuValorAprobacion%isopen then
            close cuValorAprobacion;
        end if;
        
        if cuAcumuladoNotas%isopen then
            close cuAcumuladoNotas;
        end if;
        
        if cuTieneVentaRegistrada%isopen then
            close cuTieneVentaRegistrada;
        end if;

        sbUsuarioRegistra := pkg_session.getUser;

        -- Obtener los valores de los parametros
        nuNumeroDias := pkg_bcld_parameter.fnuObtieneValorNumerico('DIAS_MONTO_NOTAS');
        IF nuNumeroDias IS NULL THEN
            sbError := 'No se ha definido el parametro DIAS_MONTO_NOTAS';
            pkg_error.setErrorMessage( isbMsgErrr => sbError);
        END IF;

        sbEstadoPendienteInstalacion := pkg_bcld_parameter.fsbObtieneValorCadena('PRODUCTO_PENDIENTE_INSTALACION');
        IF sbEstadoPendienteInstalacion IS NULL THEN
            sbError := 'No se ha definido el parametro PRODUCTO_PENDIENTE_INSTALACION';
            pkg_error.setErrorMessage( isbMsgErrr => sbError);
        END IF;

        sbSolicitudVenta := pkg_bcld_parameter.fsbObtieneValorCadena('SOLICITUDES_VENTA');
        IF sbSolicitudVenta IS NULL THEN
            sbError := 'No se ha definido el parametro SOLICITUDES_VENTA';
            pkg_error.setErrorMessage( isbMsgErrr => sbError);
        END IF;

        nuSolicitudRegistrado := pkg_bcld_parameter.fnuObtieneValorNumerico('FNB_ESTADOSOL_REG');
        IF nuSolicitudRegistrado IS NULL THEN
            sbError := 'No se ha definido el parametro FNB_ESTADOSOL_REG';
            pkg_error.setErrorMessage( isbMsgErrr => sbError);
        END IF;
        
        pkg_traza.trace('va a obtener el perfil financiero',csbNivelTraza);
        
        -- Obtener el monto maximo autorizado para el perfil financiero del usuario
        nuMaxMontoPerfilFinanciero := GE_BOFinancialProfile.fnuMaxAmountByUser(4, pkg_session.getUserId);
        
        pkg_traza.trace('usuario ' || sbUsuarioRegistra || ' valor ' ||nuMaxMontoPerfilFinanciero,csbNivelTraza);

        -- Valida si la entrega aplica para la gasera
        --caso-2001650 Se omite validacion de aplicacione de entrega
        
        nuValorAprobacion := null;
        open cuValorAprobacion;
        fetch cuValorAprobacion into nuValorAprobacion;
        close cuValorAprobacion;
        
        nuAcumuladoNotas := null;
        open cuAcumuladoNotas;
        fetch cuAcumuladoNotas into nuAcumuladoNotas;
        close cuAcumuladoNotas;
        
        if nuAcumuladoNotas is null then
            sbError := 'No fue posible obtener el valor de las notas realizadas';
            pkg_error.setErrorMessage( isbMsgErrr => sbError);
        end if;
        
        pkg_traza.trace(' valor acumulado de notas ' ||nuAcumuladoNotas,csbNivelTraza);
        pkg_traza.trace(' valor aprobacción de notas ' ||nuValorAprobacion,csbNivelTraza);
        
            -- Requiere aprobacion
            IF (nvl(nuvaloraprobacion, 0) + NVL(nuAcumuladoNotas, 0)) >
               NVL(nuMaxMontoPerfilFinanciero, 0) THEN
                nuGeneraNota := 0;
            pkg_traza.trace(' =0 ' || nuGeneraNota,csbNivelTraza);
            ELSE
                nuGeneraNota := 1;
            pkg_traza.trace(' =1 ' || nuGeneraNota,csbNivelTraza);
                --RETURN 0;
            END IF;
        
        pkg_traza.trace('nugenera ' ||nuGeneraNota,csbNivelTraza);
            -- Si el producto tiene una solicitud de venta (587 - Venta, 100277 - Venta de Gas Cotizada IFRS,
            -- 100275 - Venta de Gas por Formulario IFRS, 100271 - Venta de Gas por Formulario
        -- Migración, 100288 - Venta de Gas por Formulario Migracion 2, 100101 - Venta de
        -- Servicios de Ingeniería, 323 - Venta a Constructoras, 271 - Venta de Gas por
            -- Formulario, 100229 - Venta de Gas Cotizada, 100025 - Venta de Accesorios, 100236 -
            -- Venta de Seguros, 100264 - VENTA FNB, 100261 - Venta Seguros XML, 141 - Venta,
            -- 100218 - Venta promigas XML, 100233 - Venta de Gas por Formulario XML,
            -- 100219 - Venta Servicios Financieros) registrada (estado 13) y el parametro de
            -- solicitar visado de aprobacion debe iniciarse el tramite 289.

        nuProductStatus := pkg_bcproducto.fnuEstadoProducto(inuProducto => InuProducto);
        
        if nuProductStatus is null then
            sbError := 'El producto '||InuProducto||' no existe en la BD';
            pkg_error.setErrorMessage( isbMsgErrr => sbError);
        end if;
        
        IF instr(sbEstadoPendienteInstalacion, nuProductStatus || '|') > 0 THEN

            open cuTieneVentaRegistrada;
            fetch cuTieneVentaRegistrada into nuTieneVentaRegistrada;
            close cuTieneVentaRegistrada;

            IF nuTieneVentaRegistrada > 0 THEN
                nuGeneraNota := 0;
                pkg_traza.trace(' venta registrada >0 ',csbNivelTraza);
            ELSE
                nuGeneraNota := 1;
                pkg_traza.trace(' venta registrada =0 ',csbNivelTraza);

            END IF;
        ELSE
            NULL;
        END IF;


        pkg_traza.trace(' va a devolver valor  ' || nuGeneraNota,csbNivelTraza);
        osbError := nuGeneraNota;
        -- No requiere aprobacion

        pkg_traza.trace('osbError => '||osbError, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
        
    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            pkg_error.geterror(nuError, sbError);
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
        WHEN OTHERS THEN
            Pkg_Error.setError;
            pkg_error.geterror(nuError, sbError);
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
    END validamonto;

    PROCEDURE proGrabar
    (
        inuProducto    pr_product.product_id%TYPE, -- Producto
        isbObservacion fa_notaapro.noapobse%TYPE, -- Observacion
        onuSolicitud   OUT mo_packages.package_id%TYPE, -- Solicitud
        osbError       OUT VARCHAR2
    ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proGrabar
        Descripcion:        Almacena la informacion de las notas

        Autor    : Sandra Muñoz
        Fecha    : 15-04-2016  CA 200-201

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificación
        -----------  -------------------    -------------------------------------
        15-04-2016   Sandra Muñoz           Creación
        12-04-2018   Ronald Colpas          caso 2001650 se omite validacion de aplicacion de entrega fblaplicaentrega
        28-10-2022   jcatuchemvm            OSF-637: Se ajusta cursor cuCargos eliminando DISTINCT, el cual evita que 
                                            se registre mas de un cargo para el mismo concepto, cuenta, signo, valor, causa.
                                            En MANOT se presenta el escenario para el mismo concepto, valor, causa. 
        25-09-2024      jcatuche            OSF-3332: Se añade ajuste en llamado a regchargetoapprove enviando el valor base explicito del cursor cuCargos
                                            Se añade llamado setApplication para asignar programa después de crear la aprobación de movimientos de facturación
                                            Se añade parámetro inuValor al llamar a proDetAcreditarConcepto
                                            Se añade restricción para novedades masivas por cuenta de cobro por inconsistencias en FAEL
                                            Se añade validación de unicidad de novedad por solicitud, no se permiten combinaciónes de novedeades en una misma solicitud.
                                            Se añade registro de auditoría a las solicitudes MANOT
        ******************************************************************/

        csbMetodo                     VARCHAR2(4000) := csbPaquete||'proGrabar';
        nuSolicitud                   mo_packages.package_id%TYPE; -- Solicitud
        nuAprobacion                  fa_apromofa.apmocons%TYPE; -- Numero de aprobacion
        nuContrato                    suscripc.susccodi%TYPE; -- Contrato asociado al producto
        nuNotaAprobacion              NUMBER; -- Nota de aprobacion
        sbDocumentoSoporteAprob       fa_notaapro.noapdoso%TYPE; -- Documento de soporte para aprobacion
        sbDocumentoSoporteCargo       fa_cargapro.caapdoso%TYPE; -- Documento de soporte para nota
        nuValorAprobacion             NUMBER; -- Valor de la aprobacion
        nuExistenRegistrosParaAprobar NUMBER; -- Indica si hay que crear notas de aprobacion
        nuFacturaAnt                  cuencobr.cucofact%TYPE := 1;
        NuvalorIva                    NUMBER;
        NuConcIva                     NUMBER;
        NuServ                        NUMBER;
        aprueba                       NUMBER;
        usuario                       VARCHAR2(10);
        sbNovedad                     VARCHAR2(4);
        sbNovedadT                    VARCHAR2(4);
        
        CURSOR cuNovedades IS
            SELECT producto,
                   novedad,
                   concepto,
                   cuenta_cobro,
                   valor,
                   causa_cargo,
                   cuotas,
                   plan_diferido,
                   sesion
            FROM ldc_mantenimiento_notas_enc lmne
            WHERE sesion = gnuSesion
                  AND producto = inuProducto;
            
        CURSOR cuValidaNovedad IS
            SELECT novedad,min(rowid) row_id
            FROM ldc_mantenimiento_notas_enc lmne
            WHERE sesion = gnuSesion
            AND producto = inuProducto
            group by novedad
            order by row_id;
        
        --Para que solo aplique una nota por cuenta de cobro
        CURSOR cuFacturas IS
          SELECT cucofact factura,
                 SUM(lmnd.valor) valor,
                 (case
                   when sum(decode(lmnd.signo, csbCredito, -lmnd.valor, lmnd.valor)) < 0 then
                    cnuNotaCredito
                   else
                    cnuNotaDebito
                 end) tipo_documento
            FROM ldc_mantenimiento_notas_det lmnd, cuencobr cc
           WHERE lmnd.producto = inuProducto
             AND lmnd.sesion = gnuSesion
             AND cc.cucocodi = lmnd.cuenta_cobro
           GROUP BY cucofact
           ORDER BY cucofact;


        CURSOR cuCargos(inuFactura cuencobr.cucofact%TYPE) IS
            SELECT          lmnd.concepto,
                            lmnd.causa_cargo,
                            lmnd.signo,
                            lmnd.valor,
                            lmnd.valor_base,
                            lmnd.cuenta_cobro
            FROM ldc_mantenimiento_notas_det lmnd, cuencobr cc
            WHERE lmnd.producto = inuProducto
                  AND lmnd.sesion = gnuSesion
                  AND lmnd.cuenta_cobro = cc.cucocodi
                  AND cc.cucofact = inuFactura;

        cursor cuValorAprobacion is 
        SELECT SUM(DECODE(lmnd.signo, csbCredito, -NVL(lmnd.valor, 0), NVL(lmnd.valor, 0))),
               COUNT(1)
        FROM ldc_mantenimiento_notas_det lmnd
        WHERE lmnd.producto = inuProducto
              AND lmnd.sesion = gnuSesion;

    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_traza.trace('inuProducto    <= '||inuProducto, csbNivelTraza);
        pkg_traza.trace('isbObservacion <= '||isbObservacion, csbNivelTraza);

        if cuValorAprobacion%isopen then
            close cuValorAprobacion;
        end if;

        usuario :=  PKG_SESSION.GETUSER;

        proBorMantenimientoNotaDet(osbError => osbError);
        IF osbError IS NOT NULL THEN
            pkg_error.setErrorMessage( isbMsgErrr => osbError);
        END IF;
       
        --Valida unicidad de novedades
        sbNovedad := null;
        FOR rgNovedades in cuValidaNovedad LOOP
            IF sbNovedad IS NULL THEN
                sbNovedad := rgNovedades.Novedad;
            END IF;
            
            sbNovedadT := rgNovedades.Novedad;
            
            --Validación de combinación de novedades por gestión
            IF sbNovedadT != sbNovedad THEN
                sbError := 'No está permitido combinar diferentes tipos novedades por solicitud [';
                sbError := sbError||
                case sbNovedad 
                    when 'AD' then 'Acreditar Deuda'
                    when 'AC' then 'Acreditar por Concepto'
                    when 'ACC' then 'Acreditar por Cuenta de Cobro'
                    when 'ACCC' then 'Acreditar por Cuenta de Cobro y Concepto'
                    when 'DC' then 'Debitar por Concepto'
                    when 'DCC' then 'Debitar por Cuenta de Cobro'
                    when 'DCCC' then 'Debitar por Cuenta de Cobro y Concepto'
                    else sbNovedad
                end;
                sbError := sbError||' - ';
                sbError := sbError||
                case sbNovedadT 
                    when 'AD' then 'Acreditar Deuda]'
                    when 'AC' then 'Acreditar por Concepto]'
                    when 'ACC' then 'Acreditar por Cuenta de Cobro]'
                    when 'ACCC' then 'Acreditar por Cuenta de Cobro y Concepto]'
                    when 'DC' then 'Debitar por Concepto]'
                    when 'DCC' then 'Debitar por Cuenta de Cobro]'
                    when 'DCCC' then 'Debitar por Cuenta de Cobro y Concepto]'
                    else sbNovedadT
                end;
                sbError := sbError||'. Por favor registre un solo tipo de novedad por solicitud';
                pkg_error.setErrorMessage( isbMsgErrr => sbError);
            END IF;
        END LOOP;
        
        --Restricción de novedades crédito por cuenta de cobro
        IF sbNovedad in ('AD','ACC') THEN
            sbError := 'Por inconsistencias en Facturación Electrónica, se restringe la gestión automática de notas crédito por cuenta de cobro [';
            sbError := sbError||
            case sbNovedad
                when 'AD' then 'Acreditar Deuda]'
                when 'ACC' then 'Acreditar por Cuenta de Cobro]'
            end;
            sbError := sbError||'. Por favor considerar las novedades Acreditar por Concepto o Acreditar por Cuenta de Cobro y Concepto';
            pkg_error.setErrorMessage( isbMsgErrr => sbError);
        END IF;
        
        FOR rgNovedades IN cuNovedades
        LOOP

            IF rgNovedades.Novedad = 'AD' THEN
                -- Acreditar deuda
                proDetAcreditarDeuda(inuProducto => rgNovedades.Producto, inuCausaCargo => rgNovedades.Causa_Cargo, osbError => osbError);
            ELSIF rgNovedades.Novedad = 'AC' THEN
                -- Acreditar concepto
                proDetAcreditarConcepto(inuProducto => rgNovedades.Producto, inuConcepto => rgNovedades.Concepto, inuValor => rgNovedades.Valor, inuCausaCargo => rgNovedades.Causa_Cargo, osbError => osbError);
            ELSIF rgNovedades.Novedad = 'ACC' THEN
                -- Acreditar cuenta de cobro
                proDetAcreditarCuentaCobro(inuProducto => rgNovedades.Producto, inuCuenCobr => rgNovedades.Cuenta_Cobro, inuValor => rgNovedades.Valor, inuCausaCargo => rgNovedades.Causa_Cargo, osbError => osbError);
            ELSIF rgNovedades.Novedad = 'ACCC' THEN
                -- Acreditar cuenta de cobro y concepto
                proDetAcreditarConceptoYCC(inuProducto => rgNovedades.Producto, inuConcepto => rgNovedades.Concepto, inuValor => rgNovedades.Valor, inuCuenCobr => rgNovedades.Cuenta_Cobro, inuCausaCargo => rgNovedades.Causa_Cargo, osbError => osbError);
            ELSIF rgNovedades.Novedad = 'DC' THEN
                -- Debitar concepto
                proDetDebitarConcepto(inuProducto => rgNovedades.Producto, inuConcepto => rgNovedades.Concepto, inuValor => rgNovedades.Valor, inuCausaCargo => rgNovedades.Causa_Cargo, inuPlanId => rgNovedades.Plan_Diferido, inuNroCuotas => rgNovedades.Cuotas, osbError => osbError);
            ELSIF rgNovedades.Novedad = 'DCC' THEN
                -- Debitar cuenta de cobro
                proDetDebitarCuentaCobro(inuProducto => rgNovedades.Producto, inuCuenCobr => rgNovedades.Cuenta_Cobro, inuCausaCargo => rgNovedades.Causa_Cargo, osbError => osbError);
            ELSIF rgNovedades.Novedad = 'DCCC' THEN
                -- Debitar cuenta de cobro y concepto
                proDetDebitarConceptoYCC(inuProducto => rgNovedades.Producto, inuConcepto => rgNovedades.Concepto, inuValor => rgNovedades.Valor, inuCuenCobr => rgNovedades.Cuenta_Cobro, inuCausaCargo => rgNovedades.Causa_Cargo, osbError => osbError);
            END IF;
            
            IF osbError IS NOT NULL THEN
                pkg_error.setErrorMessage( isbMsgErrr => osbError);
            END IF;
            
        END LOOP;

        -- Obtener el contrato asociado al producto
        nuContrato := pkg_bcproducto.fnuContrato(inuProducto);
        if nuContrato is null then
            osbError := 'El producto '||inuProducto||' no existe en la BD';
            pkg_error.setErrorMessage( isbMsgErrr => osbError);
        end if;
        
        pkg_traza.trace('Contrato :'||nuContrato,csbNivelTraza);

        --se revisa el monto que lleva

        -- Calcular el valor a aprobar
        open cuValorAprobacion;
        fetch cuValorAprobacion into nuValorAprobacion, nuExistenRegistrosParaAprobar;
        close cuValorAprobacion;
        
        pkg_traza.trace('Valor a aprobar :'||nuValorAprobacion,csbNivelTraza);

        IF nuExistenRegistrosParaAprobar > 0
        THEN

            -- Crear la solicitud
            BEGIN
                fa_boapprobilladjustmov.regapproverequest(inusubscriptionid => nuContrato, --
                                                          inuproductid => inuProducto, --
                                                          onupackageid => nuSolicitud);

            EXCEPTION
                WHEN OTHERS THEN
                    Pkg_Error.setError;
                    pkg_error.geterror(nuError, sbError);
                    osbError := 'No fue posible crear la solicitud de aprobacion. Error :'||sberror;
                    pkg_error.setErrorMessage( isbMsgErrr => osbError);
            END;

            IF nvl(nuSolicitud, -1) = -1 THEN
                osbError := 'No fue posible crear la solicitud de aprobacion';
                pkg_error.setErrorMessage( isbMsgErrr => osbError);
            END IF;
            
            pkg_traza.trace('Solicitud :'||nuSolicitud,csbNivelTraza);

            --Se actualiza comment_ en mo_packages
            update mo_packages
               set comment_ = isbObservacion
             where package_id = nuSolicitud;

            -- Crear la aprobacion de movimientos
            BEGIN

                fa_boApproBillAdjustMov.regApproBillAdjust(inusumapprove => nuValorAprobacion, --
                                                           isbprocces => FA_BCApromofa.csbPRGA_AMOUNT, --
                                                           ionuapromofaid => nuAprobacion, --
                                                           inupackageid => nuSolicitud);
            EXCEPTION
                WHEN OTHERS THEN
                    Pkg_Error.setError;
                    pkg_error.geterror(nuError, sberror);
                    osbError := 'Error al crear la aprobacion de los movimientos: '||sberror;
                    pkg_error.setErrorMessage( isbMsgErrr => osbError);
            END;
            
            pkg_traza.trace('Número de aprobación :'||nuAprobacion,csbNivelTraza);
            
            Pkg_Error.SetApplication(csbNotaProg);
            
            -- Obtener las facturas
            FOR rgFacturas IN cuFacturas
            LOOP

                sbDocumentoSoporteAprob := NULL;
                pkg_traza.trace('Factura :'||rgFacturas.Factura,csbNivelTraza);
                pkg_traza.trace('Tipo Documento :'||rgFacturas.tipo_documento,csbNivelTraza);

                -- Registrar la nota para aprobacion
                BEGIN
                    fa_boapprobilladjustmov.RegNoteToApprove(inuapprovdoc => nuAprobacion, --
                                                             inucontract => nuContrato, --
                                                             inubill => rgFacturas.Factura, --
                                                             isbobserv => isbObservacion, --
                                                             inudoctype => rgFacturas.tipo_documento, --
                                                             iosbsopdoc => sbDocumentoSoporteAprob, --
                                                             onunotenumber => nuNotaAprobacion);

                EXCEPTION
                    WHEN OTHERS THEN
                        Pkg_Error.setError;
                        pkg_error.geterror(nuError, sberror);
                        osbError := 'Error al registrar la nota para aprobacion de la factura '||rgFacturas.factura||': '||sberror;
                        pkg_error.setErrorMessage( isbMsgErrr => osbError);
                END;
                
                pkg_traza.trace('Documento soporte :'||sbDocumentoSoporteAprob,csbNivelTraza);
                pkg_traza.trace('Nota creada :'||nuNotaAprobacion,csbNivelTraza);

                pkg_traza.trace('nuFacturaAnt ' || nuFacturaAnt,csbNivelTraza);
                pkg_traza.trace('rgfacturas ' || rgFacturas.Factura,csbNivelTraza);

                IF nuFacturaAnt <> rgFacturas.Factura THEN
                    --lmf*/
                    pkg_traza.trace('entro por diferencia de facturas',csbNivelTraza);

                    -- Crear los cargos para aprobacion
                    FOR rgCargos IN cuCargos(inuFactura => rgFacturas.factura)
                    LOOP
                        -- Construir el documento de soporte
                        IF rgCargos.Signo = csbCredito THEN
                            sbDocumentoSoporteCargo := csbNotaCredito || '-' ||
                                                       nuNotaAprobacion;
                        ELSE
                            sbDocumentoSoporteCargo := csbNotaDebito || '-' ||
                                                       nuNotaAprobacion;
                        END IF;

                        --Actualizo informacion de novedad debitar por concepto
                        update ldc_mantenimiento_notas_dif d
                         set d.package_id = nuSolicitud,
                             d.docsoporte = sbDocumentoSoporteCargo
                          where d.sesion = gnuSesion
                            and d.concepto_id = rgCargos.Concepto
                            and d.docsoporte is null;

                        fa_boapprobilladjustmov.regchargetoapprove(inuaccount => rgCargos.Cuenta_Cobro, --
                                                                   inuproduct => inuProducto, --
                                                                   inuconcept => rgCargos.Concepto, ---
                                                                   inuchrcause => rgCargos.Causa_Cargo, --
                                                                   isbsign => rgCargos.Signo, --
                                                                   inuvalue => rgCargos.Valor, --
                                                                   isbsopdocuc => sbDocumentoSoporteCargo, --
                                                                   inunoteid => nuNotaAprobacion, --
                                                                   inubasevalue => rgCargos.Valor_Base, --
                                                                   iboapplypolicy => TRUE);
                    END LOOP;
                    nuFacturaAnt := rgFacturas.Factura;
                END IF; --lmf

            END LOOP;

            mo_boGenerateRequest.ProcessRequest(nuSolicitud);

            onuSolicitud := nuSolicitud;
            

        END IF;

        --Se borran las tablas temporales
        ldc_pkMantenimientoNotas.proBorraDatosTemporales(osbError => osbError);

        IF osbError IS NOT NULL THEN
            pkg_error.setErrorMessage( isbMsgErrr => osbError);
        END IF;

        COMMIT;
        
        --Registra auditoría MANOT Exito
        prRegistraAuditoria(sbNovedad,nuSolicitud,isbObservacion,sbNovedadT,null);
        
        pkg_traza.trace('onuSolicitud   => '||onuSolicitud, csbNivelTraza);
        pkg_traza.trace('osbError       => '||osbError, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
        
    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            pkg_error.geterror(nuError, sbError);
            osbError := sbError; 
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            --Registra auditoría MANOT fallo
            prRegistraAuditoria(sbNovedad,nuSolicitud,isbObservacion,sbNovedadT,sbError);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
        WHEN OTHERS THEN
            Pkg_Error.setError;
            pkg_error.geterror(nuError, sbError);
            osbError := sbError;
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            --Registra auditoría MANOT fallo
            prRegistraAuditoria(sbNovedad,nuSolicitud,isbObservacion,sbNovedadT,sbError);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
    END proGrabar;

    PROCEDURE proGrabarDebitarConcepto(inuPackage in mo_packages.package_id%type) IS

	    /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del procedimiento: proGrabarDebitarConcepto
        Descripcion:

        Autor    :
        Fecha    :

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificación
        -----------  -------------------    -------------------------------------
        30-11-2020   Miguel Ballesteros     caso 271: se modificar el cierre del cursor cuConcIva
        28-10-2022   jcatuchemvm            OSF-637: Se ajusta cursor cuDebConc el cual duplicaba los cargos
                                            que en MANOT se registran para el mismo concepto y valor, ya que en
                                            ldc_mantenimiento_notas_dif no se hace distincion por el valor, ahora 
                                            solo se difieren los cargos solicitados. Se agrega rowid para la actualizacion
                                            Se actualiza la variable nuvaloriva en cada iteracion de concepto, para evitar
                                            que las cuentas de cobro queden con un saldo errado correspondiente al valor del
                                            IVA de la cuenta/concepto anterior
        13-06-2023   Diana Montes           OSF-1117: Se modifica para que todos los cargos queden 
                                            asociados a una sola cuenta de cobro y factura
        19-06-2023   Diana Montes           OSF-1347: Se modifica para que ejecute el proceso solamente cuando tenga registro 
                                            en la entidad ldc_mantenimiento_notas_dif (cuando se registra por MANOT), se 
                                            encuentra en la accion 8342 en el flujo. 
        29-04-2024   jcatuche               OSF-3206: Se elimina en el llamado al procedimiento para ajustar la cuenta el valor del impuesto [nuvaloriva]
                                            el procedimiento de registro del cargo de iva ya realiza el ajuste de la cuenta para el valor del impuesto.
                                            Evita que la cuenta quede desajustada
        25-09-2024   jcatuche               OSF-3332: Se especifica valor base del iva al llamar al procedimiento DetailRegister
                                            Se elimina variable sbDifeProg para dar paso a la constante csbNotaProg
        ******************************************************************/
        csbMetodo                     VARCHAR2(4000) := csbPaquete||'proGrabarDebitarConcepto';
        nuFactura              factura.factcodi%TYPE; -- Numero de factura
        nuContrato             NUMBER;
        grcSubscription        suscripc%ROWTYPE;
        nuCuentaCobro          cuencobr.cucocodi%TYPE;
        rcProduct              servsusc%ROWTYPE;
        nuNote                 notas.notanume%TYPE;
        nuNroCuotas            NUMBER;
        nuSaldo                NUMBER;
        nuTotalAcumCapital     NUMBER;
        nuTotalAcumCuotExtr    NUMBER;
        nuTotalAcumInteres     NUMBER;
        sbRequiereVisado       VARCHAR2(10);
        nuDifeCofi             NUMBER;
        nuMetodoCalculo        ld_parameter.numeric_value%TYPE; -- Metodo de calculo
        nuConcIva              NUMBER := 0; --concepto de iva
        nuvaloriva             NUMBER := 0; --valor de iva proyectado
        nuPorIva               NUMBER := 0; --porcentaje IVA
        SBSIGNAPPLIED   cargos.cargsign%type;
        NUADJUSTAPPLIED cargos.cargvalo%type;
        cuentaC         cuencobr.cucocodi%TYPE;
        nuProduct       servsusc.sesunuse%TYPE;
        sbDocSoporte    ldc_mantenimiento_notas_dif.docsoporte%TYPE;

        --Consulta la solicitud a procesar
        cursor cuDebConc is
        select c.*,m.*,c.rowid row_id
          from cargos c,  ( select distinct * from ldc_mantenimiento_notas_dif a where a.package_id = inuPackage ) m
         where cargcuco+0 = -1
           and cargnuse = m.product_id
           and cargconc = m.concepto_id
           and cargdoso = m.docsoporte;

        --caso 200-1650 Consulta el concepto IVA del base
        CURSOR cuConcIva (nuConcepto concepto.conccodi%type) is
        SELECT c.coblconc
          FROM concbali c
         WHERE c.coblcoba = nuConcepto
           AND c.coblcoba <> 137
           AND EXISTS (SELECT 1
                  FROM concepto t
                 WHERE t.conccodi = c.coblconc
                   AND t.concticl = cnuTipoconcliq);
                   
        -- obtiene el producto nuevo dmontes
        CURSOR cuProduct IS
        select distinct(product_id) product_id,DOCSOPORTE  from ldc_mantenimiento_notas_dif
        where package_id = inuPackage;              
            
    BEGIN
    
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_traza.trace('inuPackage <= '||inuPackage, csbNivelTraza);
      
        OPEN cuProduct ;
        FETCH cuProduct INTO nuProduct,sbDocSoporte;
        if cuProduct%notfound then
            sbDocSoporte := -1;
            nuProduct := -1;      
        end if;
        close   cuProduct;  
        if nuProduct != -1 then
        
            Pkg_Error.SetApplication(csbNotaProg);     
            -- crear factura
            pkAccountStatusMgr.GetNewAccoStatusNum(nuFactura);
            -- Obtener el codigo del contrato
            nuContrato := pkg_bcproducto.fnuContrato(nuProduct);
            if nuContrato is null then
                sbError := 'El producto '||nuProduct||' no existe en la BD';
                pkg_error.setErrorMessage( isbMsgErrr => sbError);
            end if;
            
            grcSubscription := pktblSuscripc.frcGetRecord(nuContrato);

            
            -- Crea una nueva FACTURA
            pkAccountStatusMgr.AddNewRecord(nuFactura, --
                                            pkGeneralServices.fnuIDProceso, --
                                            grcSubscription, --
                                            GE_BOconstants.fnuGetDocTypeCons);
            -- Obtiene el numero de la cuenta de cobro
            pkAccountMgr.GetNewAccountNum(nuCuentaCobro);
            -- Obtiene los datos del producto
            rcProduct := pktblservsusc.frcgetrecord(nuProduct);

            -- Crea una nueva cuenta de cobro
            pkAccountMgr.AddNewRecord(nuFactura, --
                                      nuCuentaCobro, --
                                      rcProduct);
            --Actualizo el numero de factura en la nota
            nuNote := to_number(substr(sbDocSoporte, 4, length(sbDocSoporte)));
            update notas
               set notafact = nuFactura
             where notafact =-1
             and notanume = nuNote;
             
            for rd in cuDebConc loop

                -- Actualiza la cuenta de cobro de los cargos a la -1
                update cargos c
                set cargcuco = nuCuentaCobro
                where c.rowid    = rd.row_id
                and c.cargcuco = -1
                and c.cargnuse = rd.cargnuse
                and c.cargconc = rd.cargconc
                and c.cargdoso = rd.cargdoso;
                
                 --Actualizamos la cartera del usario
                PKUPDACCORECEIV.UPDACCOREC(PKBILLCONST.CNUSUMA_CARGO,
                                           nuCuentaCobro,
                                           nuContrato,
                                           rd.cargnuse,
                                           rd.cargconc,
                                           rd.cargsign,
                                           rd.cargvalo,
                                           PKBILLCONST.CNUUPDATE_DB);

                PKACCOUNTMGR.ADJUSTACCOUNT(nuCuentaCobro,
                                           rd.cargnuse,
                                           rd.cargcaca,
                                           rd.cargprog,
                                           PKBILLCONST.CNUUPDATE_DB,
                                           SBSIGNAPPLIED,
                                           NUADJUSTAPPLIED,
                                           PKBILLCONST.POST_FACTURACION);

                --Se valida si el IVA del concepto base
                nuvaloriva := 0;
                OPEN cuConcIva (rd.cargconc);
                FETCH cuConcIva INTO nuConcIva;
            
                IF cuConcIva%FOUND THEN
                    
                    nuPorIva   := fnutraePIva(inuconcepto => nuConcIva,
                                        inuserv     => PKG_BCPRODUCTO.FNUTIPOPRODUCTO(rd.cargnuse));
                    nuValorIva := round(rd.cargvalo * (nuPorIva / 100), 0);

                    pkg_traza.trace('debitar concepto IVA: ' ||nuConcIva||', valor: '||nuValorIva,csbNivelTraza);

                    -- Crear Detalle Nota debito del IVA
                    FA_BOBillingNotes.DetailRegister(nuNote, --
                                               rd.product_id, --
                                               nuContrato, --
                                               nuCuentaCobro, --
                                               nuConcIva, --
                                               rd.cargcaca, --
                                               nuValorIva, --
                                               rd.cargvalo, --
                                               pkBillConst.csbTOKEN_NOTA_DEBITO ||
                                               nuNote, --
                                               pkBillConst.DEBITO, --
                                                Constants_Per.Csbsi, --
                                               NULL, --
                                                Constants_Per.Csbsi);
                END IF;

                CLOSE cuConcIva; --- Modificación caso 271

                IF rd.plan_dife IS NOT NULL AND rd.cuotas IS NOT NULL THEN
                    --Obtenemos el metodo de calculo para el plan de financiacion
                    nuMetodoCalculo := pktblplandife.fnugetpldimccd(rd.plan_dife);

                    -- Crea diferido si las cuotas y el plan son no nulos, si son nulos es porque se trae a presente mes
                    ldc_validalegcertnuevas.financiarconceptosfactura(inunumprodsfinanc    => rd.product_id, --
                                                                inufactura           => nuFactura, --
                                                                inuplanid            => rd.plan_dife, --
                                                                inumetodo            => nuMetodoCalculo, --
                                                                inudifenucu          => rd.cuotas, --
                                                                isbdocusopo          => '-', --
                                                                isbdifeprog          => csbNotaProg, --
                                                                onuacumcuota         => nuNroCuotas, --
                                                                onusaldo             => nuSaldo, --
                                                                onutotalacumcapital  => nuTotalAcumCapital, --
                                                                onutotalacumcuotextr => nuTotalAcumCuotExtr, --
                                                                onutotalacuminteres  => nuTotalAcumInteres, --
                                                                osbrequierevisado    => sbRequiereVisado, --
                                                                onudifecofi          => nuDifeCofi);
                END IF;

            end loop; 
            
        end if;      
        
        delete from ldc_mantenimiento_notas_dif where package_id = inuPackage;

        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
        
    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            pkg_error.geterror(nuError, sbError);
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
            raise pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Pkg_Error.setError;
            pkg_error.geterror(nuError, sbError);
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
            raise pkg_error.CONTROLLED_ERROR;
    END proGrabarDebitarConcepto;    

    FUNCTION fcnconcepnoacredit RETURN CONSTANTS_PER.TYREFCURSOR IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete:fcnconcepnoacredit
        Descripcion:

        Autor    : Luis Fren G

        Fecha    : 10/04/2017  CA 200-818

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificación
        -----------  -------------------    -------------------------------------
        10-04-2017   Luis Fren G           Creación
        ******************************************************************/

        csbMetodo     VARCHAR2(4000) := csbPaquete||'fcnconcepnoacredit';
        crConcepNoAcr CONSTANTS_PER.TYREFCURSOR;
        
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);

        -- Consulta cursor referenciado
        OPEN crConcepNoAcr FOR
            SELECT l.conccodi FROM ldc_conc_no_acred l ORDER BY 1;

        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
        RETURN crConcepNoAcr;

    EXCEPTION
        WHEN OTHERS THEN
            Pkg_Error.setError;
            pkg_error.geterror(nuError, sbError);
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
    END;
    
    PROCEDURE prRegistraAuditoria
    ( 
        isbNovedad      IN VARCHAR2,
        inuSolicitud    IN NUMBER,
        isbObservacion  IN VARCHAR2,
        isbNovedad2     IN VARCHAR2,
        isbError        IN VARCHAR2
    )IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del procedimiento: prRegistraAuditoria
        Descripcion:

        Autor    :
        Fecha    :

        Historia de Modificaciones

        DD/MM/YYYY      <Autor>.            Modificación
        -----------     ---------------     -------------------------------------
        02/12/2024      jcatuche            OSF-3332: Creación 
        ******************************************************************/
        PRAGMA AUTONOMOUS_TRANSACTION;
        
        csbMetodo                     VARCHAR2(4000) := csbPaquete||'prRegistraAuditoria';
        
        rcAuditoria                   PKG_AUDITORIA_MANOT.styRegistro;
        dtFecha                       date := SYSDATE;
        
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_traza.trace('isbNovedad     <= '||isbNovedad, csbNivelTraza);
        pkg_traza.trace('inuSolicitud   <= '||inuSolicitud, csbNivelTraza);
        pkg_traza.trace('isbNovedad2    <= '||isbNovedad2, csbNivelTraza);
        pkg_traza.trace('isbError       <= '||isbError, csbNivelTraza);
        
        rcAuditoria.novedad     := nvl(isbNovedad,'ERR');
        rcAuditoria.usuario     := PKG_SESSION.GETUSER;
        rcAuditoria.fecha       := dtFecha;
        rcAuditoria.solicitud   := nvl(inuSolicitud,-1);
        rcAuditoria.observacion := isbObservacion;
        rcAuditoria.error       := isbError;
        
        --Inserta novedad 1
        PKG_AUDITORIA_MANOT.prInsRegistro(rcAuditoria);
        
        if isbNovedad2 is not null and isbNovedad != isbNovedad2 then 
            
            --Inserta novedad 2
            rcAuditoria.novedad     := isbNovedad2;
            PKG_AUDITORIA_MANOT.prInsRegistro(rcAuditoria);
            
        end if;
        
        commit;
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            rollback;
            pkg_error.geterror(nuError, sbError);
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
        WHEN OTHERS THEN
            rollback;
            Pkg_Error.setError;
            pkg_error.geterror(nuError, sbError);
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
    END prRegistraAuditoria;

END LDC_PKMANTENIMIENTONOTAS;
/