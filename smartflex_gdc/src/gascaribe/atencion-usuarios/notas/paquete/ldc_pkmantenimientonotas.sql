CREATE OR REPLACE PACKAGE OPEN.LDC_PKMANTENIMIENTONOTAS IS
    /***********************************************************
    -- Author  : Sandra Mu?o
    -- Created : 15/04/2016 9:32:52
    -- Purpose : Administra las acciones a realizar en FAJU-MANOT
    Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    ------------------------------------
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
        15-04-2016   Sandra Mu?oz           Creacion
    ***********************************************************/
    ------------------------------------------------------------------------------------------------
    -- Listas de valores
    ------------------------------------------------------------------------------------------------
    FUNCTION fcnconcepnoacredit RETURN PKCONSTANTE.TYREFCURSOR;
    FUNCTION fcrCtasCobroProducto(inuProducto LDC_MANTENIMIENTO_NOTAS_PROY.producto%TYPE)
        RETURN PKCONSTANTE.TYREFCURSOR;

    FUNCTION fcrConceptosCtaCobro(inuCuentaCobro ldc_mantenimiento_notas_enc.cuenta_cobro%TYPE)
        RETURN PKCONSTANTE.TYREFCURSOR;

    FUNCTION fcrConceptosProducto
    (
        inuProducto ldc_mantenimiento_notas_enc.producto%TYPE,
        isbnovedad  VARCHAR2
    )
    --FUNCTION fcrConceptosProducto(inuProducto ldc_mantenimiento_notas_enc.producto%TYPE)
     RETURN PKCONSTANTE.TYREFCURSOR;

    FUNCTION fcrPlanesFinanciacion
    (
        inuNroCuotas ldc_mantenimiento_notas_enc.cuotas%TYPE,
        inuservicio  servicio.servcodi%TYPE
    ) RETURN PKCONSTANTE.TYREFCURSOR;

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
        ocrLDC_MANTENIMIENTO_NOTAS_PR OUT PKCONSTANTE.TYREFCURSOR,
        osbError                      OUT VARCHAR2
    );

    PROCEDURE proMostrarDeudaActual
    (
        inuProducto                   LDC_MANTENIMIENTO_NOTAS_PROY.producto%TYPE,
        ocrLDC_MANTENIMIENTO_NOTAS_PR OUT PKCONSTANTE.TYREFCURSOR,
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
CREATE OR REPLACE PACKAGE BODY OPEN.LDC_PKMANTENIMIENTONOTAS IS

    ------------------------------------------------------------------------------------------------
    -- Datos de paquete
    ------------------------------------------------------------------------------------------------
    gsbPaquete            VARCHAR2(30) := 'LDC_PKMANTENIMIENTONOTAS';
    gnuSesion             NUMBER := userenv('sessionid');
    gsbCRM_SAC_LMF_200818 VARCHAR2(20) := 'CRM_SAC_LMF_200818_3';

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
    
    nuError                 NUMBER;
    sbError                 VARCHAR2(4000);
    
    csbCredito      CONSTANT CHAR(2) := 'CR'; -- Cargo credito
    csbNotaCredito  CONSTANT CHAR(2) := 'NC'; -- Nota credito
    cnuNotaCredito  CONSTANT NUMBER(2) := 71; -- Nota debito
    csbDebito       CONSTANT CHAR(2) := 'DB'; -- Cargo debito
    csbNotaDebito   CONSTANT CHAR(2) := 'ND'; -- Nota Debito
    cnuNotaDebito   CONSTANT NUMBER(2) := 70; -- Nota Debito
    cnuConcConsumo  CONSTANT NUMBER(3) := 31; -- concepto de Consumo
    cnuConcSubsidio CONSTANT NUMBER(3) := 196; -- concepto de Subsidio
    cnuConcSubCovid CONSTANT NUMBER(3) := 167; -- concepto de Subsidio
    cnuConcCovid CONSTANT NUMBER(3) := 130; -- concepto de Subsidio
    cnuTipoconcliq  CONSTANT NUMBER(3) := 4; -- Tipo concepto liquidacion impuesto
    cnuConcContribu CONSTANT NUMBER(3) := 37; -- concepto de Subsidio
    csbTinoDebito   CONSTANT CHAR(1) := 'D'; -- Tipo Nota debito

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

        Nombre del Paquete: proInsertarMantenimientoNota
        Descripcion:        Inserta un registro en la tabla LDC_MANTENIMIENTO_NOTAS_PROY

        Autor    : Sandra Mu?oz
        Fecha    : 15-04-2016  CA 200-201

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        15-04-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

        sbProceso VARCHAR2(4000) := 'proInsertarMantenimientoNota';
        nuPaso    NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        rgDatos   LDC_MANTENIMIENTO_NOTAS_PROY%ROWTYPE; -- Datos a insertar en la tabla
        onuError             NUMBER;  
        exError EXCEPTION; -- Error controlado

    BEGIN
        ut_trace.trace('INICIO ' || gsbPaquete || '.' || sbProceso);

        -- Construccion del registro
        rgDatos.Producto        := inuProducto;
        rgDatos.sesion          := gnuSesion;
        rgDatos.usuario         := ge_bopersonal.fnuGetPersonId;
        rgDatos.fecha           := SYSDATE;
        rgDatos.signo_corriente := isbSignoCorriente;
        rgDatos.valor_corriente := inuValorCorriente;
        rgDatos.valor_vencido   := inuValorVencido;
        rgDatos.concepto        := inuConcepto;
        rgDatos.Origen          := isbOrigen;
        rgDatos.Valor_Diferido  := inuValorDiferido;
        rgDatos.Signo_Diferido  := isbSignoDiferido;
        ut_trace.trace('gnuSesion ' || gnuSesion );
        INSERT INTO LDC_MANTENIMIENTO_NOTAS_PROY VALUES rgDatos;
        ut_trace.trace('FIN ' || gsbPaquete || '.' || sbProceso);
    EXCEPTION
        WHEN exError THEN
            ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' ||
                           sbProceso || '(' || nuPaso || '):' || osbError);
        WHEN OTHERS THEN
            Pkg_Error.setError;
            pkg_error.geterror(onuError, osberror);
            osbError := 'TERMINO CON ERROR NO CONTROLADO  ' || gsbPaquete || '.' ||
                        sbProceso || '(' || nuPaso || '): ' || osberror;
            ut_trace.trace(osbError);
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

        Autor    : Sandra Mu?oz
        Fecha    : 15-04-2016  CA 200-201

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        15-04-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

        sbProceso VARCHAR2(4000) := 'proInsMantenimientoNotaEnc';
        nuPaso    NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        rgDatos   LDC_MANTENIMIENTO_NOTAS_ENC%ROWTYPE; -- Datos a insertar en la tabla

        exError EXCEPTION; -- Error controlado
        onuError             NUMBER;  

    BEGIN

        ut_trace.trace('INICIO ' || gsbPaquete || '.' || sbProceso);
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
        ut_trace.trace('FIN ' || gsbPaquete || '.' || sbProceso);
    EXCEPTION
        WHEN exError THEN
            ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' ||
                           sbProceso || '(' || nuPaso || '):' || osbError);
        WHEN OTHERS THEN
            Pkg_Error.setError;
            pkg_error.geterror(onuError, osberror);
            osbError := 'TERMINO CON ERROR NO CONTROLADO  ' || gsbPaquete || '.' ||
                        sbProceso || '(' || nuPaso || '): ' || osberror;
            ut_trace.trace(osbError);
    END;

    PROCEDURE proInsMantenimientoNotaDet
    (
        inuCuenta_cobro ldc_mantenimiento_notas_det.cuenta_cobro%TYPE, -- producto
        inuProducto     ldc_mantenimiento_notas_det.producto%TYPE, -- operacion a realizar: ad (acreditar deuda), ac(acreditar concepto), acc (acreditar cuenta de cobro), accc (acreditar cuenta de cobro y concepto), d (debitar concepto)
        inuConcepto     ldc_mantenimiento_notas_det.concepto%TYPE, -- concepto
        inuSigno        ldc_mantenimiento_notas_det.signo%TYPE, -- cuenta de cobro
        inuValor        ldc_mantenimiento_notas_det.valor%TYPE, -- valor de la nota
        inuCausa_cargo  ldc_mantenimiento_notas_det.causa_cargo%TYPE, -- Causa cargo
        osbError        OUT VARCHAR2 -- Mensaje de error
    ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proInsMantenimientoNotaDet
        Descripcion:        Inserta un registro en la tabla LDC_MANTENIMIENTO_NOTAS_DET

        Autor    : Sandra Mu?oz
        Fecha    : 15-04-2016  CA 200-201

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        15-04-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

        sbProceso VARCHAR2(4000) := 'proInsMantenimientoNotaDet';
        nuPaso    NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        rgDatos   LDC_MANTENIMIENTO_NOTAS_DET%ROWTYPE; -- Datos a insertar en la tabla

        exError EXCEPTION; -- Error controlado
        onuError             NUMBER;  
    BEGIN

        -- Construccion del registro
        rgDatos.cuenta_cobro := inuCuenta_cobro;
        rgDatos.producto     := inuProducto;
        rgDatos.Concepto     := inuConcepto;
        rgDatos.signo        := inuSigno;
        rgDatos.Valor        := inuValor;
        rgDatos.Sesion       := gnuSesion;
        rgDatos.Causa_Cargo  := inuCausa_cargo;

        INSERT INTO ldc_mantenimiento_notas_det VALUES rgDatos;
        ut_trace.trace('FIN ' || gsbPaquete || '.' || sbProceso);
    EXCEPTION
        WHEN exError THEN
            ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' ||
                           sbProceso || '(' || nuPaso || '):' || osbError);
        WHEN OTHERS THEN
            Pkg_Error.setError;
            pkg_error.geterror(onuError, osberror);
            osbError := 'TERMINO CON ERROR NO CONTROLADO  ' || gsbPaquete || '.' ||
                        sbProceso || '(' || nuPaso || '): ' || osberror;
            ut_trace.trace(osbError);    
    END;

    PROCEDURE proBorMantenimientoNotaEnc(osbError OUT VARCHAR2 -- Mensaje de error
                                         ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proBorMantenimientoNotaEnc
        Descripcion:        Borra los datos de LDC_MANTENIMIENTO_NOTAS_ENC para la sesion

        Autor    : Sandra Mu?oz
        Fecha    : 15-04-2016  CA 200-201

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        15-04-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

        sbProceso VARCHAR2(4000) := 'proBorMantenimientoNotaEnc';
        nuPaso    NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error

        exError EXCEPTION; -- Error controlado
        onuError             NUMBER;  
    BEGIN
        ut_trace.trace('INICIO ' || gsbPaquete || '.' || sbProceso);
        DELETE LDC_MANTENIMIENTO_NOTAS_ENC lmn WHERE lmn.sesion = gnuSesion;
        ut_trace.trace('FIN ' || gsbPaquete || '.' || sbProceso);
    EXCEPTION
        WHEN exError THEN
            osbError := 'No fue posible borrar el contenido de la tabla LDC_MANTENIMIENTO_NOTAS_ENC para la sesion ' ||
                        gnuSesion;
            ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' ||
                           sbProceso || '(' || nuPaso || '):' || osbError);
        WHEN OTHERS THEN
            Pkg_Error.setError;
            pkg_error.geterror(onuError, osberror);
            osbError := 'TERMINO CON ERROR NO CONTROLADO  ' || gsbPaquete || '.' ||
                        sbProceso || '(' || nuPaso || '): ' || osberror;
            ut_trace.trace(osbError);
    END;

    PROCEDURE proBorMantenimientoNotaProy(osbError OUT VARCHAR2 -- Mensaje de error
                                          ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proBorMantenimientoNotaProy
        Descripcion:        Borra un registro en la tabla LDC_MANTENIMIENTO_NOTAS_PROY

        Autor    : Sandra Mu?oz
        Fecha    : 15-04-2016  CA 200-201

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        15-04-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

        sbProceso VARCHAR2(4000) := 'proBorraMantenimientoNota';
        nuPaso    NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error

        exError EXCEPTION; -- Error controlado
        onuError             NUMBER;  
    BEGIN
        ut_trace.trace('INICIO ' || gsbPaquete || '.' || sbProceso);
      ut_trace.trace('gnuSesion ' || gnuSesion );  
       DELETE LDC_MANTENIMIENTO_NOTAS_PROY lmn WHERE lmn.sesion = gnuSesion;
        ut_trace.trace('FIN ' || gsbPaquete || '.' || sbProceso);
    EXCEPTION
        WHEN exError THEN
            osbError := 'No fue posible borrar el contenido de la tabla LDC_MANTENIMIENTO_NOTAS_PROY para la sesion ' ||
                        gnuSesion;
            ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' ||
                           sbProceso || '(' || nuPaso || '):' || osbError);
        WHEN OTHERS THEN
            Pkg_Error.setError;
            pkg_error.geterror(onuError, osberror);
            osbError := 'TERMINO CON ERROR NO CONTROLADO  ' || gsbPaquete || '.' ||
                        sbProceso || '(' || nuPaso || '): ' || osberror;
            ut_trace.trace(osbError);
    END;

    PROCEDURE proBorMantenimientoNotaDet(osbError OUT VARCHAR2 -- Mensaje de error
                                         ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proBorMantenimientoNotaEnc
        Descripcion:        Borra los datos de LDC_MANTENIMIENTO_NOTAS_DETpara la sesion

        Autor    : Sandra Mu?oz
        Fecha    : 15-04-2016  CA 200-201

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        15-04-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

        sbProceso VARCHAR2(4000) := 'proBorMantenimientoNotaDet';
        nuPaso    NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error

        exError EXCEPTION; -- Error controlado
        onuError             NUMBER;  
    BEGIN
        ut_trace.trace('INICIO ' || gsbPaquete || '.' || sbProceso);
        DELETE LDC_MANTENIMIENTO_NOTAS_DET lmn WHERE lmn.sesion = gnuSesion;
        ut_trace.trace('FIN ' || gsbPaquete || '.' || sbProceso);
    EXCEPTION
        WHEN exError THEN
            osbError := 'No fue posible borrar el contenido de la tabla LDC_MANTENIMIENTO_NOTAS_DET para la sesion ' ||
                        gnuSesion;
            ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' ||
                           sbProceso || '(' || nuPaso || '):' || osbError);
        WHEN OTHERS THEN
            Pkg_Error.setError;
            pkg_error.geterror(onuError, osberror);
            osbError := 'TERMINO CON ERROR NO CONTROLADO  ' || gsbPaquete || '.' ||
                        sbProceso || '(' || nuPaso || '): ' || osberror;
            ut_trace.trace(osbError);
    END;

    PROCEDURE proBorraDatosTemporales(osbError OUT VARCHAR2) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proBorraDatosTemporales
        Descripcion:        Borra todos los datos usados para la operacion

        Autor    : Sandra Mu?oz
        Fecha    : 15-04-2016  CA 200-201

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        15-04-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

        sbProceso VARCHAR2(4000) := 'proInsertarMantenimientoNota';
        nuPaso    NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error

        exError EXCEPTION; -- Error controlado
        onuError             NUMBER;  
    BEGIN
        ut_trace.trace('INICIO ' || gsbPaquete || '.' || sbProceso);

        proBorMantenimientoNotaEnc(osbError => osbError);
        IF osbError IS NOT NULL THEN
            RAISE exError;
        END IF;

        proBorMantenimientoNotaProy(osbError => osbError);
        IF osbError IS NOT NULL THEN
            RAISE exError;
        END IF;

        proBorMantenimientoNotaDet(osbError => osbError);
        IF osbError IS NOT NULL THEN
            RAISE exError;
        END IF;

        ut_trace.trace('FIN ' || gsbPaquete || '.' || sbProceso);
    EXCEPTION
        WHEN exError THEN
            ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' ||
                           sbProceso || '(' || nuPaso || '):' || osbError);
        WHEN OTHERS THEN
            
            Pkg_Error.setError;
            pkg_error.geterror(onuError, osberror);
            osbError := 'TERMINO CON ERROR NO CONTROLADO  ' || gsbPaquete || '.' ||
                        sbProceso || '(' || nuPaso || '): ' || osberror;
            ut_trace.trace(osbError);
    END;

    PROCEDURE proDeudaConceptoProy
    (
        inuProducto        IN pr_product.product_id%TYPE,
        inuConcepto        IN concepto.conccodi%TYPE,
        onuValorAAcreditar OUT NUMBER,
        osbError           OUT VARCHAR2
    ) IS
        sbProceso VARCHAR2(4000) := 'proDeudaConcepto';
        nuPaso    NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        exError EXCEPTION; -- Error controlado
        onuError             NUMBER;  
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proDeudaConcepto
        Descripcion:       Obtiene la deuda actual por concepto

        Autor    : Sandra Mu?oz
        Fecha    : 15-04-2016  CA 200-201

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        15-04-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

    BEGIN
        SELECT nvl(SUM(nvl(valor_corriente, 0)) + SUM(nvl(valor_diferido, 0)), 0) deuda_total
        INTO onuValorAAcreditar
        FROM LDC_MANTENIMIENTO_NOTAS_PROY lmn
        WHERE lmn.sesion = gnuSesion
              AND lmn.producto = inuProducto
              AND lmn.origen = 'D'
              AND lmn.signo_corriente = csbDebito
              AND lmn.concepto = inuConcepto; -- Deuda real del concepto
    EXCEPTION
        WHEN exError THEN
            ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' ||
                           sbProceso || '(' || nuPaso || '):' || osbError);
        WHEN OTHERS THEN
            Pkg_Error.setError;
            pkg_error.geterror(onuError, osberror);
            osbError := 'TERMINO CON ERROR NO CONTROLADO  ' || gsbPaquete || '.' ||
                        sbProceso || '(' || nuPaso || '): ' || osberror;
            ut_trace.trace(osbError);
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

        Nombre del Paquete: fnuDeudaConcepto
        Descripcion:       Obtiene la deuda actual por concepto

        Autor    : Sandra Mu?oz
        Fecha    : 15-04-2016  CA 200-201

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        15-04-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

        sbProceso   VARCHAR2(4000) := 'fnuDeudaConcepto';
        nuPaso      NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        cuDeudaConc PKCONSTANTE.TYREFCURSOR;
        nuError     NUMBER := 0;
        rgDeudaConc tDeudaConc;

        exError EXCEPTION; -- Error controlado
        onuError             NUMBER;  
    BEGIN
        ut_trace.trace('INICIO ' || gsbPaquete || '.' || sbProceso);

        -- Obtener los conceptos con deuda del producto
        os_queryproddebtbyconc(inusesunuse => inuProducto, isbpunished => 'S', ocuqueryproddebtbyconc => cuDeudaConc, onuerrorcode => nuError, osberrormessage => osbError);

        IF nuError > 0 THEN
            osbError := nuError || ' - ' || osbError;
            RAISE exError;
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

        IF osbError = '-' THEN
            osbError := NULL;
        END IF;

        ut_trace.trace('FIN ' || gsbPaquete || '.' || sbProceso);
    EXCEPTION
        WHEN exError THEN
            ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' ||
                           sbProceso || '(' || nuPaso || '):' || osbError);
        WHEN OTHERS THEN
            Pkg_Error.setError;
            pkg_error.geterror(onuError, osberror);
            osbError := 'TERMINO CON ERROR NO CONTROLADO  ' || gsbPaquete || '.' ||
                        sbProceso || '(' || nuPaso || '): ' || osberror;
            ut_trace.trace(osbError);
    END;

    -- Refactored procedure proDeudaCuentaCobro
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


        Autor    : Sandra Mu?oz
        Fecha    : 15-04-2016  CA 200-201

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        15-04-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

        sbProceso         VARCHAR2(4000) := 'proDeudaCuentaCobro';
        nuPaso            NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        nuValorAAcreditar NUMBER; -- Valor a acreditar al concepto

        exError EXCEPTION; -- Error controlado
        onuError             NUMBER;  
    BEGIN

        ut_trace.trace('INICIO ' || gsbPaquete || '.' || sbProceso);
        BEGIN
            SELECT nvl(cc.cucosacu, 0)
            INTO onuSaldoCuenCobr
            FROM cuencobr cc
            WHERE cc.cucocodi = inuCuenCobr;
        EXCEPTION
            WHEN no_data_found THEN
                osbError := 'La cuenta de cobro ' || inuCuenCobr ||
                            ' no esta asociada al producto ' || inuProducto;
                RAISE exError;
            WHEN OTHERS THEN
                Pkg_Error.setError;
                pkg_error.geterror(onuError, osberror);
                osbError := 'No fue posible obtener el saldo de la cuenta de cobro ' ||
                            inuCuenCobr || ' - ' || osberror;
                RAISE exError;
                
                
        END;
        ut_trace.trace('FIN ' || gsbPaquete || '.' || sbProceso);
    EXCEPTION
        WHEN exError THEN
            ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' ||
                           sbProceso || '(' || nuPaso || '):' || osbError);
        WHEN OTHERS THEN
            Pkg_Error.setError;
            pkg_error.geterror(onuError, osberror);
            osbError := 'TERMINO CON ERROR NO CONTROLADO  ' || gsbPaquete || '.' ||
                        sbProceso || '(' || nuPaso || '): ' || osberror;
            ut_trace.trace(osbError);
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

        Autor    : Sandra Mu?oz
        Fecha    : 15-04-2016  CA 200-201

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        10-12-2018   Ronald Colpas          caso-200-1650Se modifica para que se muestre la deuda
                                            detallada valor actual, valor vencido.
        15-04-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

        sbProceso   VARCHAR2(4000) := 'proCargaDeudaActual';
        nuPaso      NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        cuDeudaConc PKCONSTANTE.TYREFCURSOR;
        nuError     NUMBER := 0;
        rgDeudaConc tDeudaConc;
        nuConteo    NUMBER;

        --Declaracion de variables para el detalle de la deuda
        nuDeudcorr  NUMBER;
        nuDeudifer  NUMBER;
        nuValorecl  NUMBER;
        nuSaldoafa  NUMBER;
        nuDifrecla  NUMBER;
        cuDeudetre  PKCONSTANTE.TYREFCURSOR;
        cuDeudetai  PKCONSTANTE.TYREFCURSOR;
        rgDeudadet  tDeudetre;

        exError EXCEPTION; -- Error controlado
        onuError             NUMBER;  
    BEGIN
        ut_trace.trace('INICIO ' || gsbPaquete || '.' || sbProceso);

        -- Borrar los resultados de la consulta anterior
        proBorMantenimientoNotaProy(osbError => osbError);
        IF osbError IS NOT NULL THEN
            RAISE exError;
        END IF;

        -- Obtener los conceptos con deuda del producto
        os_queryproddebtbyconc(inusesunuse => inuProducto, isbpunished => 'S', ocuqueryproddebtbyconc => cuDeudaConc, onuerrorcode => nuError, osberrormessage => osbError);

        LOOP
            -- Obtener registro
            FETCH cuDeudaConc
                INTO rgDeudaConc;
            EXIT WHEN cuDeudaConc%NOTFOUND;

            proInsMantenimientoNotaProy(inuProducto => rgDeudaConc.producto, isbSignoCorriente => rgDeudaConc.signo_corriente, inuValorCorriente => rgDeudaConc.valor_corriente, inuValorVencido => 0, inuConcepto => rgDeudaConc.concepto_id, isbOrigen => 'D', inuValorDiferido => rgDeudaConc.valor_diferido, isbSignoDiferido => rgDeudaConc.signo_diferido, osbError => osbError);

            IF osbError IS NOT NULL THEN
                RAISE exError;
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
                RAISE exError;
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

        ut_trace.trace('FIN ' || gsbPaquete || '.' || sbProceso);
    EXCEPTION
        WHEN exError THEN
            ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' ||
                           sbProceso || '(' || nuPaso || '):' || osbError);
        WHEN OTHERS THEN
            Pkg_Error.setError;
            pkg_error.geterror(onuError, osberror);
            osbError := 'TERMINO CON ERROR NO CONTROLADO  ' || gsbPaquete || '.' ||
                        sbProceso || '(' || nuPaso || '): ' || osberror;
            ut_trace.trace(osbError);
    END;

    -- Refactored procedure proSaldoConcepto
    PROCEDURE proDeudaConceptoCC
    (
        inuCuenCobr      cuencobr.cucocodi%TYPE, -- Codigo de la cuenta de cobro
        inuConcepto      concepto.conccodi%TYPE, -- Concepto
        onuSaldoConcepto OUT cargos.cargvalo%TYPE, -- Saldo del concepto
        osbError         OUT VARCHAR2 -- Error
    ) IS

        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proSaldoConcepto
        Descripcion:        Retorna el saldo de un concepto dentro de una cuenta de cobro

        Autor    : Sandra Mu?oz
        Fecha    : 15-04-2016  CA 200-201

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        15-04-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

        sbProceso VARCHAR2(4000) := 'proDeudaConceptoCC';
        nuPaso    NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error

        exError EXCEPTION; -- Error controlado
        tbsaldoconc pkbalanceconceptmgr.tytbsaldoconc;
        onuError             NUMBER;  
    BEGIN
        ut_trace.trace('INICIO ' || gsbPaquete || '.' || sbProceso);
        -- Call the procedure
        pkbalanceconceptmgr.getbalancebyconc(inuaccount => inuCuenCobr, otbsaldoconc => tbsaldoconc);
        BEGIN
            onuSaldoConcepto := tbSaldoConc(inuConcepto).nusaldo;
        EXCEPTION
            WHEN no_data_found THEN
                onuSaldoConcepto := 0;
        END;
        ut_trace.trace('FIN ' || gsbPaquete || '.' || sbProceso);
    EXCEPTION
        WHEN exError THEN
            ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' ||
                           sbProceso || '(' || nuPaso || '):' || osbError);
        WHEN OTHERS THEN
            Pkg_Error.setError;
            pkg_error.geterror(onuError, osberror);
            osbError := 'TERMINO CON ERROR NO CONTROLADO  ' || gsbPaquete || '.' ||
                        sbProceso || '(' || nuPaso || '): ' || osberror;
            ut_trace.trace(osbError);

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

        Autor    : Sandra Mu?oz
        Fecha    : 15-04-2016  CA 200-201

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        15-04-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

        sbProceso VARCHAR2(4000) := 'proInsertarMantenimientoNota';
        nuPaso    NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error

        exError EXCEPTION; -- Error controlado
        onuError             NUMBER;  
    BEGIN
        ut_trace.trace('INICIO ' || gsbPaquete || '.' || sbProceso);

        onuDeuda := pkBCCuencobr.fnuGetOutStandBal(inuproduct => inuProducto);

        ut_trace.trace('FIN ' || gsbPaquete || '.' || sbProceso);
    EXCEPTION
        WHEN exError THEN
            ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' ||
                           sbProceso || '(' || nuPaso || '):' || osbError);
        WHEN OTHERS THEN
            Pkg_Error.setError;
            pkg_error.geterror(onuError, osberror);
            osbError := 'TERMINO CON ERROR NO CONTROLADO  ' || gsbPaquete || '.' ||
                        sbProceso || '(' || nuPaso || '): ' || osberror;
            ut_trace.trace(osbError);
    END;

    -- Refactored procedure proValidaConceptoYaFacurado
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

        Autor    : Sandra Mu?oz
        Fecha    : 15-04-2016  CA 200-201

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        15-04-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

        sbProceso VARCHAR2(4000) := 'proValidaConceptoYaFacurado';
        nuPaso    NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        nuExiste  NUMBER;
        exError EXCEPTION;
        onuError             NUMBER;  
    BEGIN
        BEGIN
            SELECT COUNT(1)
            INTO nuExiste
            FROM cargos c
            WHERE c.cargnuse = inuProducto
                  AND c.cargconc = inuConcepto;
        EXCEPTION
            WHEN OTHERS THEN
                osbError := 'No fue posible identificar si el concepto ' ||
                            inuConcepto || ' ya ha sido facturado al producto ' ||
                            inuProducto;
                RAISE exError;
        END;

        IF nuExiste = 0 THEN
            osbError := 'No se puede acreditar el concepto ' || inuConcepto ||
                        ' ya que no se encuentra en ninguna de ' ||
                        'las cuentas de cobro asociadas al producto ' ||
                        inuProducto;
            RAISE exError;
        END IF;

    EXCEPTION
        WHEN exError THEN
            ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' ||
                           sbProceso || '(' || nuPaso || '):' || osbError);
        WHEN OTHERS THEN
            Pkg_Error.setError;
            pkg_error.geterror(onuError, osberror);
            osbError := 'TERMINO CON ERROR NO CONTROLADO  ' || gsbPaquete || '.' ||
                        sbProceso || '(' || nuPaso || '): ' || osberror;
            ut_trace.trace(osbError);
    END proValidaConceptoYaFacurado;

    FUNCTION fcrCtasCobroProducto(inuProducto LDC_MANTENIMIENTO_NOTAS_PROY.producto%TYPE)
        RETURN PKCONSTANTE.TYREFCURSOR IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete:
        Descripcion:

        Autor    : Sandra Mu?oz

        Fecha    : 15-04-2016  CA 200-201

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        15-04-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

        sbProceso     VARCHAR2(4000) := 'proInsertarMantenimientoNota';
        nuPaso        NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        crCuentaCobro PKCONSTANTE.TYREFCURSOR;
        sbError       VARCHAR2(4000); -- Error

        exError EXCEPTION; -- Error controlado
        onuError             NUMBER;  
    BEGIN
        ut_trace.trace('INICIO ' || gsbPaquete || '.' || sbProceso);

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

        RETURN crCuentaCobro;

        ut_trace.trace('FIN ' || gsbPaquete || '.' || sbProceso);
    EXCEPTION
        WHEN exError THEN
            ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' ||
                           sbProceso || '(' || nuPaso || '):' || sbError);
        WHEN OTHERS THEN
            Pkg_Error.setError;
            pkg_error.geterror(onuError, sberror);
            sbError := 'TERMINO CON ERROR NO CONTROLADO  ' || gsbPaquete || '.' ||
                        sbProceso || '(' || nuPaso || '): ' || sberror;
            ut_trace.trace(sbError);
    END;

    FUNCTION fcrConceptosCtaCobro(inuCuentaCobro ldc_mantenimiento_notas_enc.cuenta_cobro%TYPE)
        RETURN PKCONSTANTE.TYREFCURSOR IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete:
        Descripcion:

        Autor    : Sandra Mu?oz

        Fecha    : 15-04-2016  CA 200-201

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        15-04-2016   Sandra Mu?oz           Creacion
        17-04-2017   Luis Fren G            Se modifica consulta para que no aparezcan los conceptos
                                            que se definen en la tabla que contiene los conceptos que no
                                            se pueden acreditar LDC_CONC_NO_ACRED
        ******************************************************************/

        sbProceso   VARCHAR2(4000) := 'fcrConceptosCtaCobro';
        nuPaso      NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        crConceptos PKCONSTANTE.TYREFCURSOR;
        sbError     VARCHAR2(4000); -- Error

        exError EXCEPTION; -- Error controlado
        onuError             NUMBER;  
    BEGIN
        ut_trace.trace('INICIO ' || gsbPaquete || '.' || sbProceso);

        -- Consulta cursor referenciado
        OPEN crConceptos FOR
            SELECT DISTINCT cargconc concepto, concdesc descripcion
            FROM cargos, concepto
            WHERE cargcuco = inuCuentaCobro
                  AND conccodi = cargconc
                  AND
                  cargconc NOT IN (SELECT l.CONCCODI FROM LDC_CONC_NO_ACRED l)
            ORDER BY cargconc;

        RETURN crConceptos;

        ut_trace.trace('FIN ' || gsbPaquete || '.' || sbProceso);
    EXCEPTION
        WHEN exError THEN
            ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' ||
                           sbProceso || '(' || nuPaso || '):' || sbError);
        WHEN OTHERS THEN
            Pkg_Error.setError;
            pkg_error.geterror(onuError, sberror);
            sbError := 'TERMINO CON ERROR NO CONTROLADO  ' || gsbPaquete || '.' ||
                        sbProceso || '(' || nuPaso || '): ' || sberror;
            ut_trace.trace(sbError);
    END;

    FUNCTION fcrConceptosProducto
    (
        inuProducto ldc_mantenimiento_notas_enc.producto%TYPE,
        isbnovedad  VARCHAR2
    ) RETURN PKCONSTANTE.TYREFCURSOR IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete:
        Descripcion:

        Autor    : Sandra Mu?oz

        Fecha    : 15-04-2016  CA 200-201

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        15-04-2016   Sandra Mu?oz           Creacion
        17-04-2017   Luis Fren G            Se modifica consulta para que no aparezcan los conceptos
                                            que se definen en la tabla que contiene los conceptos que no
                                            se pueden acreditar LDC_CONC_NO_ACRED
        ******************************************************************/

        sbProceso   VARCHAR2(4000) := 'fcrConceptosProducto';
        nuPaso      NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        crConceptos PKCONSTANTE.TYREFCURSOR;
        sbError     VARCHAR2(4000); -- Error

        exError EXCEPTION; -- Error controlado
        onuError             NUMBER;  
    BEGIN
        ut_trace.trace('INICIO ' || gsbPaquete || '.' || sbProceso);

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
                ORDER BY cargconc;
        ELSE
            OPEN crConceptos FOR
                SELECT DISTINCT cargconc concepto, concdesc descripcion
                FROM cargos, concepto
                WHERE cargnuse = inuProducto
                      AND cargconc = conccodi
                      AND cargconc NOT IN
                      (SELECT l.CONCCODI FROM LDC_CONC_NO_ACRED l)
                UNION
                SELECT t.conccodi concepto, t.concdesc descripcion
                FROM concepto t
                WHERE t.conccodi <> -1
                ORDER BY 1;
        END IF;

        RETURN crConceptos;

        ut_trace.trace('FIN ' || gsbPaquete || '.' || sbProceso);
    EXCEPTION
        WHEN exError THEN
            ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' ||
                           sbProceso || '(' || nuPaso || '):' || sbError);
        WHEN OTHERS THEN
            Pkg_Error.setError;
            pkg_error.geterror(onuError, sberror);
            sbError := 'TERMINO CON ERROR NO CONTROLADO  ' || gsbPaquete || '.' ||
                        sbProceso || '(' || nuPaso || '): ' || sberror;
            ut_trace.trace(sbError);
    END;

    FUNCTION fcrPlanesFinanciacion
    (
        inuNroCuotas ldc_mantenimiento_notas_enc.cuotas%TYPE,
        inuservicio  servicio.servcodi%TYPE
    ) RETURN PKCONSTANTE.TYREFCURSOR IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete:
        Descripcion:

        Autor    : Sandra Mu?oz

        Fecha    : 15-04-2016  CA 200-201

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        15-04-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

        sbProceso VARCHAR2(4000) := 'fcrPlanesFinanciacion';
        nuPaso    NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        crPlanes  PKCONSTANTE.TYREFCURSOR;
        sbError   VARCHAR2(4000); -- Error

        exError EXCEPTION; -- Error controlado
        onuError             NUMBER;  
    BEGIN
        ut_trace.trace('INICIO ' || gsbPaquete || '.' || sbProceso);

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

        RETURN crPlanes;

        ut_trace.trace('FIN ' || gsbPaquete || '.' || sbProceso);
    EXCEPTION
        WHEN exError THEN
            ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' ||
                           sbProceso || '(' || nuPaso || '):' || sbError);
        WHEN OTHERS THEN
            Pkg_Error.setError;
            pkg_error.geterror(onuError, sberror);
            sbError := 'TERMINO CON ERROR NO CONTROLADO  ' || gsbPaquete || '.' ||
                        sbProceso || '(' || nuPaso || '): ' || sberror;
            ut_trace.trace(sbError);
    END;
    /*****************************************************************
    Propiedad intelectual de Gases del Caribe.

    Nombre del Paquete:
    Descripcion:

    Autor    : Sandra Mu?oz

    Fecha    : 14-08-2017

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.              Modificacion
    -----------  -------------------    -------------------------------------
    14-08-2017   Luis Fren G.           Creacion
    ******************************************************************/
    FUNCTION fnutraePIva
    (
        inuconcepto concepto.conccodi%TYPE, -- concepto
        inuserv     servsusc.sesuserv%TYPE -- porcentaje
    ) RETURN NUMBER IS
        nuporcentaje NUMBER := 0;
    BEGIN
        SELECT /*VITCCONS cons_tarifa, */
         nvl(ravtporc, 0) /*, cotcserv  servicio */
        INTO nuporcentaje
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
        RETURN nuporcentaje;
    EXCEPTION
        WHEN no_data_found THEN
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

        Autor    : Sandra Mu?oz
        Fecha    : 15-04-2016  CA 200-201

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        09-08-2023   diana.montes           OSF-1343:se modifica cursor cuDeudaConcepto
                                            para incluir cnuConcSubCovid cnuConcCovid y colocar distinct
        11-12-2018   Ronald Colpas          200-1650 Se modifica cursor cuDeudaConcepto para que tenga encuenta
                                            en la proyeccion el concepto subsidio
        15-04-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

        sbProceso VARCHAR2(4000) := 'proProyAcreditarDeuda';
        nuPaso    NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
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

        exError EXCEPTION; -- Error controlado
        onuError             NUMBER;  
        
    BEGIN
        ut_trace.trace('INICIO ' || gsbPaquete || '.' || sbProceso);
        ut_trace.trace('gnuSesion ' || gnuSesion );
        -- Validar datos obligatorios
        IF inuProducto IS NULL THEN
            osbError := 'Falta indicar el producto al que se le acreditara la deuda';
            RAISE exError;
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
                RAISE exError;
            END IF;

        END LOOP;

        ut_trace.trace('FIN ' || gsbPaquete || '.' || sbProceso);
    EXCEPTION
        WHEN exError THEN
            ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' ||
                           sbProceso || '(' || nuPaso || '):' || osbError);
        WHEN OTHERS THEN
            Pkg_Error.setError;
            pkg_error.geterror(onuError, osberror);
            osbError := 'TERMINO CON ERROR NO CONTROLADO  ' || gsbPaquete || '.' ||
                        sbProceso || '(' || nuPaso || '): ' || osberror;
            ut_trace.trace(osbError);
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

        Autor    : Sandra Mu?oz
        Fecha    : 15-04-2016  CA 200-201

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
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


        15-04-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

        sbProceso         VARCHAR2(4000) := 'proProyAcreditarConcepto';
        nuPaso            NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
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
        exError EXCEPTION; -- Error controlado
        onuError             NUMBER;  
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

    BEGIN
        ut_trace.trace('INICIO ' || gsbPaquete || '.' || sbProceso);

        -- Validar datos obligatorios
        IF inuProducto IS NULL THEN
            osbError := 'Falta indicar el producto al que se le acreditara la deuda';
            RAISE exError;
        END IF;

        IF inuConcepto IS NULL THEN
            osbError := 'Falta indicar el concepto al que se va a acreditar';
            RAISE exError;
        ELSE
            proValidaConceptoYaFacurado(inuProducto => inuProducto, inuConcepto => inuConcepto, osbError => osbError);
            IF osbError IS NOT NULL THEN
                RAISE exError;
            END IF;
        END IF;
        nuValorAAcreditar := 0;
        -- Identificar la deuda total del concepto
        SELECT nvl(SUM(nvl(valor_corriente, 0)) /*+ SUM(nvl(valor_diferido, 0))*/, 0) deuda_total,
               NVL(SUM(nvl(valor_vencido, 0)), 0)  --caso-200-1650
        INTO nuValorActconc, nuValorVenconc
        FROM LDC_MANTENIMIENTO_NOTAS_PROY lmn
        WHERE lmn.sesion = gnuSesion
              AND lmn.producto = inuProducto
              AND lmn.origen = 'D'
              AND lmn.signo_corriente = csbDebito
              AND lmn.concepto = inuConcepto -- Deuda real del concepto
        ;
        --si el valor es cero entonces se saca del valor digitado

        --caso200-1650 Mod.13.12.2018 Valor acreditar actual + vencido
        nuValorAAcreditar := nuValorActconc + nuValorVenconc;

        SELECT e.valor
        INTO nuValorDigitado
        FROM ldc_mantenimiento_notas_enc e
        WHERE e.producto = inuProducto
              AND e.concepto = inuConcepto
              AND e.sesion = gnuSesion;

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
                RAISE exError;
            END IF;

            --mod.24.04.2019 validamos si el concepto base tiene Iva para calcularlo
            OPEN cuConcIva;
            FETCH cuConcIva INTO nuConcIva;
            IF cuConcIva%FOUND THEN
              --Se proyecta el valor calculado del IVA
              --Realiza calculo para el valor del IVA
              nuPorIva   := fnutraePIva(inuconcepto => nuConcIva, inuserv => pktblservsusc.fnugetservice(inuProducto));
              nuValorIva := round(nuValorDigitado * (nuPorIva / 100), 0);

              ut_trace.trace('Acredita concepto IVA: '||nuConcIva||' va a insertar valor de: ' ||
                              nuValorIva ||' porcentaje IVA: '|| nuPorIva);
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
                   RAISE exError;
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
                RAISE exError;
            END IF;

            OPEN cuConcIva;
            FETCH cuConcIva INTO nuConcIva;
            IF cuConcIva%FOUND THEN
              --Se proyecta el valor calculado del IVA
              --Realiza calculo para el valor del IVA
              nuPorIva   := fnutraePIva(inuconcepto => nuConcIva, inuserv => pktblservsusc.fnugetservice(inuProducto));
              nuValorIva := round(nuValorDigitado * (nuPorIva / 100), 0);

              ut_trace.trace('Acredita concepto IVA: '||nuConcIva||' va a insertar valor de: ' ||
                              nuValorIva ||' porcentaje IVA: '|| nuPorIva);
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
                   RAISE exError;
                END IF;
              END IF;
            END IF;
            CLOSE cuConcIva;

        END IF;

        ut_trace.trace('FIN ' || gsbPaquete || '.' || sbProceso);
    EXCEPTION
        WHEN exError THEN
            ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' ||
                           sbProceso || '(' || nuPaso || '):' || osbError);
        WHEN OTHERS THEN
            Pkg_Error.setError;
            pkg_error.geterror(onuError, osberror);
            osbError := 'TERMINO CON ERROR NO CONTROLADO  ' || gsbPaquete || '.' ||
                        sbProceso || '(' || nuPaso || '): ' || osberror;
            ut_trace.trace(osbError);
    END;



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

        Autor    : Sandra Mu?oz
        Fecha    : 15-04-2016  CA 200-201

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
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

        15-04-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

        sbProceso       VARCHAR2(4000) := 'proProyAcreditarConceptoYCC';
        nuPaso          NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
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
        exError EXCEPTION; -- Error controlado
        onuError             NUMBER;  
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
        ut_trace.trace('INICIO ' || gsbPaquete || '.' || sbProceso);

        -- Validar datos obligatorios
        IF inuProducto IS NULL THEN
            osbError := 'Falta indicar el producto al que se le acreditara la deuda';
            RAISE exError;
        END IF;

        IF inuConcepto IS NULL THEN
            osbError := 'Falta indicar el concepto al que se va a acreditar';
            RAISE exError;
        ELSE

            proValidaConceptoYaFacurado(inuProducto => inuProducto, --
                                        inuConcepto => inuConcepto, --
                                        osbError => osbError);
            IF osbError IS NOT NULL THEN
                RAISE exError;
            END IF;
        END IF;

        IF inuValor IS NULL THEN
            osbError := 'Falta ingresar el valor a acreditar';
            RAISE exError;
        END IF;

        IF inuCuenCobr IS NULL THEN
            osbError := 'Falta la cuenta de cobro en la que se acreditara el concepto';
            RAISE exError;
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
            RAISE exError;
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
            RAISE exError;
        END IF;

        --mod.24.04.2019 validamos si el concepto base tiene Iva para calcularlo
        OPEN cuConcIva;
        FETCH cuConcIva INTO nuConcIva;
        IF cuConcIva%FOUND THEN
          --Se proyecta el valor calculado del IVA
          --Realiza calculo para el valor del IVA
          nuPorIva   := fnutraePIva(inuconcepto => nuConcIva, inuserv => pktblservsusc.fnugetservice(inuProducto));
          nuValorIva := round(inuValor * (nuPorIva / 100), 0);

          ut_trace.trace('Acredita concepto IVA: '||nuConcIva||' va a insertar valor de: ' ||
                          nuValorIva ||' porcentaje IVA: '|| nuPorIva);
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
               RAISE exError;
            END IF;
          END IF;
        END IF;
        CLOSE cuConcIva;

        
        ut_trace.trace('FIN ' || gsbPaquete || '.' || sbProceso);
    EXCEPTION
        WHEN exError THEN
            ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' ||
                           sbProceso || '(' || nuPaso || '):' || osbError);
        WHEN OTHERS THEN
            Pkg_Error.setError;
            pkg_error.geterror(onuError, osberror);
            osbError := 'TERMINO CON ERROR NO CONTROLADO  ' || gsbPaquete || '.' ||
                        sbProceso || '(' || nuPaso || '): ' || osberror;
            ut_trace.trace(osbError);
    END;

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


        Autor    : Sandra Mu?oz
        Fecha    : 15-04-2016  CA 200-201

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        09-08-2023   diana.montes           OSF-1343: se ajusta para  tener en cuenta el subsidio covid  
                                            y consumo de covid
        15-12-2018   Ronald Colpas          Se modifica para prorretear la deuda de la cuenta de cobro
                                            cuando el valor digitado sea mayor al de la cuenta

        15-04-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

        sbProceso        VARCHAR2(4000) := 'proProyAcreditarCuentaCobro';
        nuPaso           NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
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
        exError EXCEPTION; -- Error controlado
        onuError             NUMBER;  
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

    BEGIN
        ut_trace.trace('INICIO ' || gsbPaquete || '.' || sbProceso);
        ut_trace.trace('gnuSesion ' || gnuSesion );
        -- Validar datos obligatorios
        IF inuProducto IS NULL THEN
            osbError := 'Falta indicar el producto al que se le acreditara la deuda';
            RAISE exError;
        END IF;

        IF inuCuenCobr IS NULL THEN
            osbError := 'Falta indicar el numero de cuenta de cobro a acreditar';
            RAISE exError;
        END IF;
        --se guarda el valor que se digito
        SELECT e.valor
        INTO nuValorDigitado
        FROM ldc_mantenimiento_notas_enc e
        WHERE e.producto = inuProducto
              AND e.cuenta_cobro = inuCuenCobr
              AND e.sesion = gnuSesion;

        -- Obtener el saldo total de la cuenta de cobro
        BEGIN
            SELECT nvl(cc.cucosacu, 0)
            INTO nuSaldoCuenCobr
            FROM cuencobr cc
            WHERE cc.cucocodi = inuCuenCobr;
        EXCEPTION
            WHEN no_data_found THEN
                osbError := 'La cuenta de cobro ' || inuCuenCobr ||
                            ' no esta asociada al producto ' || inuProducto;
                RAISE exError;
            WHEN OTHERS THEN
                Pkg_Error.setError;
                pkg_error.geterror(onuError, osberror);
                osbError := 'No fue posible obtener el saldo de la cuenta de cobro ' ||
                            inuCuenCobr || ' - ' || osberror;
                RAISE exError;  
           
        END;

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
                    RAISE exError;
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
                            RAISE exError;
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
                            RAISE exError;
                        END IF;
                    END IF;
                END IF;    
                nuValorSubsidio := 0;
                nuValorsubsidioCovid := 0;
                nuValorCovid :=0;
                IF rgConceptosCC.Cargconc = cnuConcConsumo THEN
                    ut_trace.trace('acredita concepto entro por concepto 31 ');
                    --- subsidio cnuConcSubsidio
                    proDeudaConceptoCC(inuCuenCobr => inuCuenCobr,
                                       inuConcepto => cnuConcSubsidio,
                                       onuSaldoConcepto => nuValorsubsidio,
                                       osbError => osbError);
                    IF osbError IS NOT NULL THEN
                        RAISE exError;
                    END IF;
                    ---  subsidio cnuConcSubCovid
                    proDeudaConceptoCC(inuCuenCobr => inuCuenCobr,
                                       inuConcepto => cnuConcSubCovid,
                                       onuSaldoConcepto => nuValorsubsidioCovid,
                                       osbError => osbError);
                    IF osbError IS NOT NULL THEN
                        RAISE exError;
                    END IF;
                    ---  consumo cnuConcCovid
                    proDeudaConceptoCC(inuCuenCobr => inuCuenCobr,
                                       inuConcepto => cnuConcCovid,
                                       onuSaldoConcepto => nuValorCovid,
                                       osbError => osbError);
                    IF osbError IS NOT NULL THEN
                        RAISE exError;
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
                    ut_trace.trace('acredita concepto va a insertar valor del subsidio ' ||
                                   nuValorSubsidio);
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
                    ut_trace.trace('acredita concepto va a insertar valor del subsidio  covid' ||
                                   nuValorsubsidioCovid);
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
                    ut_trace.trace('acredita concepto va a insertar valor del consumo  covid' ||
                                   nuValorCovid);
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
            ut_trace.trace('La cuenta de cobro ' || inuCuenCobr ||
                           ' no se puede acreditar ya que no tiene saldo');
        END IF;

        ut_trace.trace('FIN ' || gsbPaquete || '.' || sbProceso);
    EXCEPTION
        WHEN exError THEN
            ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' ||
                           sbProceso || '(' || nuPaso || '):' || osbError);
        WHEN OTHERS THEN
            Pkg_Error.setError;
            pkg_error.geterror(onuError, osberror);
            osbError := 'TERMINO CON ERROR NO CONTROLADO  ' || gsbPaquete || '.' ||
                        sbProceso || '(' || nuPaso || '): ' || osberror;
            ut_trace.trace(osbError);
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

        Autor    : Sandra Mu?oz
        Fecha    : 15-04-2016  CA 200-201

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        19-12-2018   Ronald Colpas          Se modifica para que se proyecte el concepto IVA

        15-04-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

        sbProceso VARCHAR2(4000) := 'proProyDebitarConcepto';
        nuPaso    NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        exError EXCEPTION; -- Error controlado
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
        onuError             NUMBER;  
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
        ut_trace.trace('INICIO ' || gsbPaquete || '.' || sbProceso);
        -- Validar datos obligatorios
        IF inuProducto IS NULL THEN
            osbError := 'Falta indicar el producto al que se le debitara el valor';
            RAISE exError;
        END IF;

        IF inuConcepto IS NULL THEN
            osbError := 'Falta indicar el concepto al que se le debitara el valor';
            RAISE exError;
        ELSE
            proValidaConceptoYaFacurado(inuProducto => inuProducto, inuConcepto => inuConcepto, osbError => osbError);
            IF osbError IS NOT NULL THEN
                NULL;
            END IF;
        END IF;

        IF inuValor IS NULL THEN
            osbError := 'Falta indicar el valor a debitar';
            RAISE exError;
        END IF;

        --Validamos si el concepto se carga a diferido para validar vigencia del plan de financiacion
        IF nvl(inuPlan, -1) != -1 THEN

          OPEN cuPlandife;
          FETCH cuPlandife INTO nuMetodo;
          IF cuPlandife%NOTFOUND THEN
            CLOSE cuPlandife;
            osbError := 'Plan definanciacion seleccionado no esta vigente.';
            RAISE exError;
          ELSE
            CLOSE cuPlandife;
          END IF;

          IF nuMetodo is null THEN
            osbError := 'Plan de financiacion: '||inuPlan||', no tiene metodo de calculo configurado';
            RAISE exError;
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

            RAISE exError;
        END IF;

        --Se valida si el IVA del concepto base
        OPEN cuConcIva;
        FETCH cuConcIva INTO nuConcIva;
        IF cuConcIva%FOUND THEN
          CLOSE cuConcIva;
          nuPorIva   := fnutraePIva(inuconcepto => nuConcIva, inuserv => pktblservsusc.fnugetservice(inuProducto));
          nuValorIva := round(inuValor * (nuPorIva / 100), 0);

          ut_trace.trace('Proyectar concepto IVA: ' || nuConcIva || ', valor: ' || nuValorIva);

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

        ut_trace.trace('FIN ' || gsbPaquete || '.' || sbProceso);
    EXCEPTION
        WHEN exError THEN
            ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' ||
                           sbProceso || '(' || nuPaso || '):' || osbError);
        WHEN OTHERS THEN
            Pkg_Error.setError;
            pkg_error.geterror(onuError, osberror);
            osbError := 'TERMINO CON ERROR NO CONTROLADO  ' || gsbPaquete || '.' ||
                        sbProceso || '(' || nuPaso || '): ' || osberror;
            ut_trace.trace(osbError);
    END;

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

        Nombre del Paquete: proProyDebitarConcepto para traer a presente mes
        Descripcion:        Esta opcion se utilizara cuando se requiera aumentar la deuda de un
                            concepto para el producto seleccionado y no diferirla.

        Autor    : Luis Fren G
        Fecha    : 15-09-2017  CA 200-818

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        19-12-2018   Ronald Colpas          Se modifica para que proyecte la deuda a cargar a PM.
                                            para que consulte el concepto IVA que tenga asociado.

        15-09-2017   Luis Fren G           Creacion
        ******************************************************************/

        sbProceso VARCHAR2(4000) := 'proProyDebitarConceptoPM';
        nuPaso    NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        exError EXCEPTION; -- Error controlado
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
        onuError             NUMBER;  
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
        ut_trace.trace('INICIO ' || gsbPaquete || '.' || sbProceso);

        -- Validar datos obligatorios
        IF inuProducto IS NULL THEN
            osbError := 'Falta indicar el producto al que se le debitara el valor';
            RAISE exError;
        END IF;

        IF inuConcepto IS NULL THEN
            osbError := 'Falta indicar el concepto al que se le debitara el valor';
            RAISE exError;
        ELSE
            proValidaConceptoYaFacurado(inuProducto => inuProducto, inuConcepto => inuConcepto, osbError => osbError);
            IF osbError IS NOT NULL THEN
                NULL;
            END IF;
        END IF;

        IF inuValor IS NULL THEN
            osbError := 'Falta indicar el valor a debitar';
            RAISE exError;
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
            RAISE exError;
        END IF;

        --Se valida si el IVA del concepto base
        OPEN cuConcIva;
        FETCH cuConcIva INTO nuConcIva;
        IF cuConcIva%FOUND THEN
          CLOSE cuConcIva;
          nuPorIva   := fnutraePIva(inuconcepto => nuConcIva, inuserv => pktblservsusc.fnugetservice(inuProducto));
          nuValorIva := round(inuValor * (nuPorIva / 100), 0);

          ut_trace.trace('Proyectar concepto IVA: ' || nuConcIva || ', valor: ' || nuValorIva);

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
        ut_trace.trace('FIN ' || gsbPaquete || '.' || sbProceso);
    EXCEPTION
        WHEN exError THEN
            ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' ||
                           sbProceso || '(' || nuPaso || '):' || osbError);
        WHEN OTHERS THEN
            Pkg_Error.setError;
            pkg_error.geterror(onuError, osberror);
            osbError := 'TERMINO CON ERROR NO CONTROLADO  ' || gsbPaquete || '.' ||
                        sbProceso || '(' || nuPaso || '): ' || osberror;
            ut_trace.trace(osbError);
    END;

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

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        21-05-2019   Ronald Colpas C.       Creacion
        ******************************************************************/

        sbProceso        VARCHAR2(4000) := 'proProyDebitarCuentaCobro';
        nuPaso           NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        nuSaldoConcepto  cargos.cargvalo%TYPE; -- Saldo del concepto
        nuSaldoCuenCobr  cuencobr.cucosacu%TYPE; -- Saldo de la cuenta de cobro
        nuValorDigitado  NUMBER; --valor digitado en la pantalla
        swExist          NUMBER := 0; --sw para saber si hay cargos generados por FGCA

        nuVenc           NUMBER; --vencimiento de la cta 0 vencida, 1 actual
        nuValorActual    NUMBER; --valor actual
        nuValorVencid    NUMBER; --valor vencido

        exError EXCEPTION; -- Error controlado
        onuError             NUMBER;  
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


    BEGIN
        ut_trace.trace('INICIO ' || gsbPaquete || '.' || sbProceso);

        -- Validar datos obligatorios
        IF inuProducto IS NULL THEN
            osbError := 'Falta indicar el producto al que se le acreditara la deuda';
            RAISE exError;
        END IF;

        IF inuCuenCobr IS NULL THEN
            osbError := 'Falta indicar el numero de cuenta de cobro a acreditar';
            RAISE exError;
        END IF;
        --se guarda el valor que se digito
        SELECT e.valor
        INTO nuValorDigitado
        FROM ldc_mantenimiento_notas_enc e
        WHERE e.producto = inuProducto
              AND e.cuenta_cobro = inuCuenCobr
              AND e.sesion = gnuSesion;

        -- Obtener el saldo total de la cuenta de cobro
        BEGIN
            SELECT nvl(cc.cucosacu, 0)
            INTO nuSaldoCuenCobr
            FROM cuencobr cc
            WHERE cc.cucocodi = inuCuenCobr;
        EXCEPTION
            WHEN no_data_found THEN
                osbError := 'La cuenta de cobro ' || inuCuenCobr ||
                            ' no esta asociada al producto ' || inuProducto;
                RAISE exError;
            WHEN OTHERS THEN
                Pkg_Error.setError;
                pkg_error.geterror(onuError, osberror);
                osbError := 'No fue posible obtener el saldo de la cuenta de cobro ' ||
                            inuCuenCobr || ' - ' || osberror;
                RAISE exError;
        END;

        IF nuSaldoCuenCobr > 0 THEN
          osbError := 'La cuenta de cobro ' || inuCuenCobr ||
                      ' a la que se quiere aplicar novedad debitar por cuenta de cobro esta con saldo pendiente ';
          RAISE exError;
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
              RAISE exError;
          END IF;
          ut_trace.trace('Nota Debito concepto ' || rgConceptosCC.Cargconc);
        END LOOP;
        IF swExist = 0 THEN
            osbError := 'La cuenta de cobro ' || inuCuenCobr ||
                           ' a la que se quiere aplicar novedad '||
                           'debitar por cuenta de cobro no tiene cargos generados por FGCA';
            ut_trace.trace(osbError);
            RAISE exError;
        END IF;

        ut_trace.trace('FIN ' || gsbPaquete || '.' || sbProceso);
    EXCEPTION
        WHEN exError THEN
            ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' ||
                           sbProceso || '(' || nuPaso || '):' || osbError);
        WHEN OTHERS THEN
            Pkg_Error.setError;
            pkg_error.geterror(onuError, osberror);
            osbError := 'TERMINO CON ERROR NO CONTROLADO  ' || gsbPaquete || '.' ||
                        sbProceso || '(' || nuPaso || '): ' || osberror;
            ut_trace.trace(osbError);
            
            
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

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        20-05-2019   Ronald colpas          Creacion
        ******************************************************************/

        sbProceso       VARCHAR2(4000) := 'proProyDebitarConceptoYCC';
        nuPaso          NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        nuValorIva      NUMBER; --valor de Iva
        nuConcIva       NUMBER := 0; --concept Iva

        nuVenc           NUMBER; --vencimiento de la cta 0 vencida, 1 actual
        nuValorActual    NUMBER; --valor actual
        nuValorVencid    NUMBER; --valor vencido
        nuValor          NUMBER:= 0; --Valor del concepto digitado
        nuPorIva         NUMBER; --porcentaje IVA

        nuValorActIVA     NUMBER; -- Deuda actual del concepto IVA
        nuValorVenIVA     NUMBER; -- Deuda actual del concepto IVA

        exError EXCEPTION; -- Error controlado
        onuError             NUMBER;  

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
        ut_trace.trace('INICIO ' || gsbPaquete || '.' || sbProceso);

        -- Validar datos obligatorios
        IF inuProducto IS NULL THEN
            osbError := 'Falta indicar el producto al que se le debitar la deuda';
            RAISE exError;
        END IF;

        IF inuConcepto IS NULL THEN
            osbError := 'Falta indicar el concepto al que se va a debitar';
            RAISE exError;
        END IF;

        IF inuValor IS NULL THEN
            osbError := 'Falta ingresar el valor a debitar';
            RAISE exError;
        END IF;

        IF inuCuenCobr IS NULL THEN
            osbError := 'Falta la cuenta de cobro en la que se debitara el concepto';
            RAISE exError;
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
            RAISE exError;
        END IF;

        --validamos si el concepto base tiene Iva para calcularlo
        OPEN cuConcIva;
        FETCH cuConcIva INTO nuConcIva;
        IF cuConcIva%FOUND THEN
          --Se proyecta el valor calculado del IVA
          --Realiza calculo para el valor del IVA
          nuPorIva   := fnutraePIva(inuconcepto => nuConcIva, inuserv => pktblservsusc.fnugetservice(inuProducto));
          nuValorIva := round(inuValor * (nuPorIva / 100), 0);

          ut_trace.trace('Acredita concepto IVA: '||nuConcIva||' va a insertar valor de: ' ||
                          nuValorIva ||' porcentaje IVA: '|| nuPorIva);
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
               RAISE exError;
            END IF;
          END IF;
        END IF;
        CLOSE cuConcIva;

        ut_trace.trace('FIN ' || gsbPaquete || '.' || sbProceso);
    EXCEPTION
        WHEN exError THEN
            ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' ||
                           sbProceso || '(' || nuPaso || '):' || osbError);
        WHEN OTHERS THEN
            Pkg_Error.setError;
            pkg_error.geterror(onuError, osberror);
            osbError := 'TERMINO CON ERROR NO CONTROLADO  ' || gsbPaquete || '.' ||
                        sbProceso || '(' || nuPaso || '): ' || osberror;
            ut_trace.trace(osbError);
    END;

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

        Autor    : Sandra Mu?oz
        Fecha    : 15-04-2016  CA 200-201

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        10-08-2023   diana.montes           OSF-1343: Se incluye el manejo de subsidio 167 y 
                                            130 consumo
        15-04-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

        sbProceso        VARCHAR2(4000) := 'proDetAcreditarDeuda';
        nuPaso           NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        nuSaldoConcepto  cargos.cargvalo%TYPE; -- Saldo del concepto
        nuValorsubsidio  NUMBER(8);
        nuValorsubsidioC NUMBER(8);
        nuValorsubsidioCovid NUMBER(8);
        nuValorCovid     NUMBER(8);
        nuValorsubsidioCv NUMBER(8);
        exError EXCEPTION; -- Error controlado
        onuError             NUMBER;  
        
        CURSOR cuConceptosCC(inuCuenCobr cuencobr.cucocodi%TYPE) IS
            SELECT DISTINCT c.cargconc concepto
            FROM cargos c
            WHERE c.cargcuco = inuCuenCobr;

    BEGIN
        ut_trace.trace('INICIO ' || gsbPaquete || '.' || sbProceso);

        -- Validar datos obligatorios
        IF inuProducto IS NULL THEN
            osbError := 'Falta indicar el producto al que se le acreditara la deuda';
            RAISE exError;
        END IF;

        IF inuCausaCargo IS NULL THEN
            osbError := 'Falta indicar la causa cargo';
            RAISE exError;
        END IF;

        -- Recorrer las cuentas de cuentas de cobro con saldo del producto

        FOR rgCuentasConSaldo IN cuCuentasConSaldo(inuProducto => inuProducto)
        LOOP

            -- Recorrer los conceptos de la cuenta de cobro
            FOR rgConceptosCC IN cuConceptosCC(rgCuentasConSaldo.cuenta_cobro)
            LOOP

                -- Calcular saldo del concepto en la cuenta de cobro
                proDeudaConceptoCC(inuCuenCobr => rgCuentasConSaldo.cuenta_cobro, inuConcepto => rgConceptosCC.concepto, onuSaldoConcepto => nuSaldoConcepto, osbError => osbError);

                IF osbError IS NOT NULL THEN
                    RAISE exError;
                END IF;
                --  SE ADICIONA IF 
                IF rgConceptosCC.CONCEPTO not in (cnuConcSubsidio,cnuConcSubCovid,cnuConcCovid)
                THEN
                    -- Si el concepto tiene deuda, se crea el registro CR por ese valor
                    IF nvl(nuSaldoConcepto, 0) > 0 THEN

                        -- Crear registro CR
                        proInsMantenimientoNotaDet(inuCuenta_cobro => rgCuentasConSaldo.cuenta_cobro, inuProducto => inuProducto, inuConcepto => rgConceptosCC.concepto, inuSigno => csbCredito, inuValor => nuSaldoConcepto, inuCausa_cargo => inuCausaCargo, osbError => osbError);

                        IF osbError IS NOT NULL THEN
                            RAISE exError;
                        END IF;
                    END IF;
                END IF;    
                ---------------------------------------------------------------------------------------------------
                --lmfg
                IF rgConceptosCC.concepto = cnuConcConsumo THEN
                    proDeudaConceptoCC(inuCuenCobr => rgCuentasConSaldo.Cuenta_Cobro, inuConcepto => cnuConcSubsidio, onuSaldoConcepto => nuValorsubsidio, osbError => osbError);
                    IF nuValorsubsidio <> 0 THEN
                        ut_trace.trace('Va a insertar el subsidio acreditar deuda ' ||
                                       nuValorsubsidio);
                        proInsMantenimientoNotaDet(inuCuenta_cobro => rgCuentasConSaldo.cuenta_cobro, inuProducto => inuProducto, inuConcepto => cnuConcSubsidio, inuSigno => csbDebito, inuValor => -1 *
                                                                nuValorsubsidio, inuCausa_cargo => inuCausaCargo, osbError => osbError);
                    END IF;
                    
                    proDeudaConceptoCC(inuCuenCobr => rgCuentasConSaldo.Cuenta_Cobro, inuConcepto => cnuConcSubCovid, onuSaldoConcepto => nuValorsubsidioCovid, osbError => osbError);
                    IF nuValorsubsidioCovid <> 0 THEN
                        ut_trace.trace('Va a insertar el subsidio COVID acreditar deuda ' ||
                                       nuValorsubsidioCovid);
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
                        ut_trace.trace('Va a insertar el 130 COVID acreditar deuda ' ||
                                       nuValorCovid);
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

        ut_trace.trace('FIN ' || gsbPaquete || '.' || sbProceso);
    EXCEPTION
        WHEN exError THEN
            ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' ||
                           sbProceso || '(' || nuPaso || '):' || osbError);
        WHEN OTHERS THEN
            Pkg_Error.setError;
            pkg_error.geterror(onuError, osberror);
            osbError := 'TERMINO CON ERROR NO CONTROLADO  ' || gsbPaquete || '.' ||
                        sbProceso || '(' || nuPaso || '): ' || osberror;
            ut_trace.trace(osbError);
    END;

    -- Refactored procedure proDeudaConcepto

    PROCEDURE proDetAcreditarConcepto
    (
        inuProducto   pr_product.product_id%TYPE, -- Producto
        inuConcepto   concepto.conccodi%TYPE, -- Concepto
        inuCausaCargo causcarg.cacacodi%TYPE, -- Causa cargo
        osbError      OUT VARCHAR2
    ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proDetAcreditarConcepto
        Descripcion:        Crea la aprobacion de conceptos para la acreditacion de conceptos

        Autor    : Sandra Mu?oz
        Fecha    : 15-04-2016  CA 200-201

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        25-04-2019   Ronald Colpas          Caso-200-1650 Se modifica para excluir de la proyeccion los
                                            conceptos subsidio y contribucion, el iva se calcula
                                            con respecto al valor ingresado en el concepto.
                                            Se modifico para que tenga encuenta cuando el valor deuda concepto
                                            sea menor que el digitado

        13-12-2018   Ronald Colpas          Caso-200-1650 se modifica el servicio para que detalle
                                            correctamente la novedad de acreditar por concepto.
                                            se tiene encuenta cuando el concepto tenga IVA para que se detalle.
                                            Si se acredita por concepto consumo se le detalle el subsidio
                                            si el valor acreditar del concepto base es difernte
                                            a la deuda real del concepto base se calcula el IVA que
                                            tenga este de acuerdo al procenteje calculado por la
                                            funcion fnutraePIva

        15-04-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

        sbProceso         VARCHAR2(4000) := 'proDetAcreditarConcepto';
        nuPaso            NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
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
        exError EXCEPTION; -- Error controlado
        onuError             NUMBER;  
        
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

    BEGIN
        ut_trace.trace('INICIO ' || gsbPaquete || '.' || sbProceso);

        -- Validar datos obligatorios
        IF inuProducto IS NULL THEN
            osbError := 'Falta indicar el producto al que se le acreditara la deuda';
            RAISE exError;
        END IF;

        IF inuConcepto IS NULL THEN
            osbError := 'Falta indicar el concepto al que se va a acreditar';
            RAISE exError;
        ELSE
            proValidaConceptoYaFacurado(inuProducto => inuProducto, inuConcepto => inuConcepto, osbError => osbError);
            IF osbError IS NOT NULL THEN
                RAISE exError;
            END IF;
        END IF;

        IF inuCausaCargo IS NULL THEN
            osbError := 'Falta indicar la causa cargo';
            RAISE exError;
        END IF;

        -- Obtener los parametros de sistemas
        --MET_CALC_MANTENIMIENTO_NOTAS
        --si el valor es cero entonces se saca del valor digitado
        SELECT e.valor
        INTO nuvalorDigitado
        FROM ldc_mantenimiento_notas_enc e
        WHERE e.producto = inuProducto
              AND e.concepto = inuConcepto
              AND e.sesion = gnuSesion;

        -- Recorrer todas las cuentas de cobro con saldo y donde este presente el concepto a acreditar
        FOR rgCuentasConSaldo IN cuCuentasConSaldo LOOP
          nucantcc := 1;
          -- Identificar la deuda del concepto en la cuenta de cobro
          proDeudaConceptoCC(inuCuenCobr => rgCuentasConSaldo.Cuenta_Cobro, --
                             inuConcepto => inuConcepto, --
                             onuSaldoConcepto => nuValorAAcreditar, --
                             osbError => osbError);

          IF osbError IS NOT NULL THEN
            RAISE exError;
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
            RAISE exError;
          END IF;

          --mod.25.04.2019 validamos si el concepto base tiene Iva para calcularlo
          OPEN cuConcIva;
          FETCH cuConcIva INTO nuConcIva;
          IF cuConcIva%FOUND THEN
            --Se proyecta el valor calculado del IVA
            --Realiza calculo para el valor del IVA
            nuPorIva   := fnutraePIva(inuconcepto => nuConcIva, inuserv => pktblservsusc.fnugetservice(inuProducto));
            nuValorIva := round(nuValorAAcreditar * (nuPorIva / 100), 0);

            ut_trace.trace('Acredita concepto IVA: '||nuConcIva||' va a insertar valor de: ' ||
                            nuValorIva ||' porcentaje IVA: '|| nuPorIva);

            IF nuValorIva != 0 THEN
              proInsMantenimientoNotaDet(inuCuenta_cobro => rgCuentasConSaldo.cuenta_cobro, --
                                         inuProducto => inuProducto, --
                                         inuConcepto => nuConcIva, --
                                         inuSigno => csbCredito, --
                                         inuValor => nuValorIva, --
                                         inuCausa_cargo => inuCausaCargo, --
                                         osbError => osbError);
              IF osbError IS NOT NULL THEN
                RAISE exError;
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
            SELECT MAX(cucocodi)
              INTO nucuencobr
              FROM cuencobr, cargos
             WHERE cuconuse = inuProducto
               AND cargcuco = cucocodi;
          ELSE
            --se halla la maxima cuenta de cobro pendiente del concepto
            SELECT MAX(cucocodi)
              INTO nucuencobr
              FROM cuencobr, cargos
             WHERE cuconuse = inuProducto
               AND cargcuco = cucocodi
               AND cargconc = inuConcepto
               AND cucosacu > 0;
          END IF;

          proInsMantenimientoNotaDet(inuCuenta_cobro => nucuencobr, --
                                     inuProducto => inuProducto, --
                                     inuConcepto => inuConcepto, --
                                     inuSigno => csbCredito, --
                                     inuValor => nuValorRestante, --
                                     inuCausa_cargo => inuCausaCargo, --
                                     osbError => osbError);

          IF osbError IS NOT NULL THEN
            RAISE exError;
          END IF;

          --IF nucantcc = 0 THEN
            OPEN cuConcIva;
            FETCH cuConcIva INTO nuConcIva;
            IF cuConcIva%FOUND THEN
              --Se proyecta el valor calculado del IVA
              --Realiza calculo para el valor del IVA
              nuPorIva   := fnutraePIva(inuconcepto => nuConcIva, inuserv => pktblservsusc.fnugetservice(inuProducto));
              nuValorIva := round(nuValorRestante * (nuPorIva / 100), 0);

              ut_trace.trace('Acredita concepto IVA: '||nuConcIva||' va a insertar valor de: ' ||
                              nuValorIva ||' porcentaje IVA: '|| nuPorIva);

              IF nuValorIva != 0 THEN
                proInsMantenimientoNotaDet(inuCuenta_cobro => nucuencobr, --
                                           inuProducto => inuProducto, --
                                           inuConcepto => nuConcIva, --
                                           inuSigno => csbCredito, --
                                           inuValor => nuValorIva, --
                                           inuCausa_cargo => inuCausaCargo, --
                                           osbError => osbError);
               IF osbError IS NOT NULL THEN
                 RAISE exError;
               END IF;

             END IF;

            END IF;
            close cuConcIva;
          
        END IF;

        

        ut_trace.trace('FIN ' || gsbPaquete || '.' || sbProceso);
    EXCEPTION
        WHEN exError THEN
            ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' ||
                           sbProceso || '(' || nuPaso || '):' || osbError);
        WHEN OTHERS THEN
            Pkg_Error.setError;
            pkg_error.geterror(onuError, osberror);
            osbError := 'TERMINO CON ERROR NO CONTROLADO  ' || gsbPaquete || '.' ||
                        sbProceso || '(' || nuPaso || '): ' || osberror;
            ut_trace.trace(osbError);
    END;

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

        Autor    : Sandra Mu?oz
        Fecha    : 15-04-2016  CA 200-201

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        22-08-2023   Diana.Montes           OSF-1343: Se coloca la validacion inuValor < 0 para que 
                                            no permita registrar valores negativos
        25-04-2019   Ronald Colpas          Caso-200-1650 Se modifica para excluir de la proyeccion los
                                            conceptos subsidio y contribucion, el iva se calcula
                                            con respecto al valor ingresado en el concepto.
                                            Se modifico para que tenga encuenta cuando el valor deuda concepto
                                            sea menor que el digitado

        16-12-2018   Ronald Colpas          Se modifica para que calcule correctamente
                                            el cargo a crear por concepto subsidio e IVA.
                                            si el valor acreditar del concepto base es difernte
                                            a la deuda real del concepto base se calcula el IVA que
                                            tenga este de acuerdo al procenteje calculado por la
                                            funcion fnutraePIva

        15-04-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

        sbProceso       VARCHAR2(4000) := 'proDetAcreditarConceptoYCC';
        nuPaso          NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
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
        exError EXCEPTION; -- Error controlado
        onuError             NUMBER;  
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
        ut_trace.trace('INICIO ' || gsbPaquete || '.' || sbProceso);

        -- Validar datos obligatorios
        IF inuProducto IS NULL THEN
            osbError := 'Falta indicar el producto al que se le acreditara la deuda';
            RAISE exError;
        END IF;

        IF inuConcepto IS NULL THEN
            osbError := 'Falta indicar el concepto al que se va a acreditar';
            RAISE exError;
        ELSE
            proValidaConceptoYaFacurado(inuProducto => inuProducto, inuConcepto => inuConcepto, osbError => osbError);
            IF osbError IS NOT NULL THEN
                RAISE exError;
            END IF;
        END IF;

        IF inuValor IS NULL THEN
            osbError := 'Falta ingresar el valor a acreditar';
            RAISE exError;
        END IF;
        
        IF inuValor < 0 THEN
            osbError := 'El valor a acreditar debe ser mayor a cero';
            RAISE exError;
        END IF;

        IF inuCuenCobr IS NULL THEN
            osbError := 'Falta la cuenta de cobro en la que se acreditara la cuenta de cobro';
            RAISE exError;
        END IF;

        IF inuCausaCargo IS NULL THEN
            osbError := 'Falta indicar la causa cargo';
            RAISE exError;
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
            RAISE exError;
        END IF;

        --mod.25.04.2019 validamos si el concepto base tiene Iva para calcularlo
        OPEN cuConcIva;
        FETCH cuConcIva INTO nuConcIva;
        IF cuConcIva%FOUND THEN
          --Se proyecta el valor calculado del IVA
          --Realiza calculo para el valor del IVA
          nuPorIva   := fnutraePIva(inuconcepto => nuConcIva, inuserv => pktblservsusc.fnugetservice(inuProducto));
          nuValorIva := round(inuValor * (nuPorIva / 100), 0);

          ut_trace.trace('Acredita concepto IVA: '||nuConcIva||' va a insertar valor de: ' ||
                          nuValorIva ||' porcentaje IVA: '|| nuPorIva);

          IF nuValorIva != 0 THEN
            proInsMantenimientoNotaDet(inuCuenta_cobro => inuCuenCobr, --
                                       inuProducto => inuProducto, --
                                       inuConcepto => nuConcIva, --
                                       inuSigno => csbCredito, --
                                       inuValor => nuValorIva, --
                                       inuCausa_cargo => inuCausaCargo, --
                                       osbError => osbError);
            IF osbError IS NOT NULL THEN
              RAISE exError;
            END IF;

          END IF;
        END IF;

        

        ut_trace.trace('FIN ' || gsbPaquete || '.' || sbProceso);
    EXCEPTION
        WHEN exError THEN
            ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' ||
                           sbProceso || '(' || nuPaso || '):' || osbError);
        WHEN OTHERS THEN
            Pkg_Error.setError;
            pkg_error.geterror(onuError, osberror);
            osbError := 'TERMINO CON ERROR NO CONTROLADO  ' || gsbPaquete || '.' ||
                        sbProceso || '(' || nuPaso || '): ' || osberror;
            ut_trace.trace(osbError);
    END;

    PROCEDURE proDetAcreditarCuentaCobro
    (
        inuProducto   pr_product.product_id%TYPE, -- Producto
        inuCuenCobr   cuencobr.cucocodi%TYPE, -- CuentaCobro
        inuCausaCargo causcarg.cacacodi%TYPE, -- Causa cargo
        osbError      OUT VARCHAR2
    ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proDetAcreditarCuentaCobro
        Descripcion:        Permite preparar la informacion

        El sistema debe permitir seleccionar cualquier cuenta de cobro asociada al producto seleccionado
        sin importar si tiene saldo o no.


        Autor    : Sandra Mu?oz
        Fecha    : 15-04-2016  CA 200-201

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        10-08-2023   diana.montes           OSF-1343: se modifica para tener en cuenta el subsidio 
                                            del concepto 167
        15-12-2018   Ronald Colpas          Se modifica para prorretear la deuda de la cuenta de cobro
                                            cuando el valor digitado sea mayor al de la cuenta

        15-04-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

        sbProceso         VARCHAR2(4000) := 'proProyAcreditarCuentaCobro';
        nuPaso            NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
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
        nuValorCovid     NUMBER(8);
        onuError             NUMBER;  
        exError EXCEPTION; -- Error controlado

        CURSOR cuConceptosCC IS
            SELECT DISTINCT cargconc
            FROM cargos c
            WHERE c.cargcuco = inuCuenCobr

            ;

    BEGIN
        ut_trace.trace('INICIO ' || gsbPaquete || '.' || sbProceso);

        -- Validar datos obligatorios
        IF inuProducto IS NULL THEN
            osbError := 'Falta indicar el producto al que se le acreditara la deuda';
            RAISE exError;
        END IF;

        IF inuCuenCobr IS NULL THEN
            osbError := 'Falta indicar el numero de cuenta de cobro a acreditar';
            RAISE exError;
        END IF;

        IF inuCausaCargo IS NULL THEN
            osbError := 'Falta indicar la causa cargo';
            RAISE exError;
        END IF;

        -- Obtener el saldo total de la cuenta de cobro
        proDeudaCuentaCobro(inuProducto => inuProducto, --
                            inuCuenCobr => inuCuenCobr, --
                            onuSaldoCuenCobr => nuSaldoCuenCobr, --
                            osbError => osbError);

        IF osbError IS NOT NULL THEN
            RAISE exError;
        END IF;
        --se guarda el valor que se digito
        SELECT e.valor
        INTO nuValorDigitado
        FROM ldc_mantenimiento_notas_enc e
        WHERE e.producto = inuProducto
              AND e.cuenta_cobro = inuCuenCobr
              AND e.sesion = gnuSesion;

        IF nuValorDigitado > nuSaldoCuenCobr THEN
           
            swMayor := 1;
        END IF;

        -- No procesar si la cuenta de cobro no tiene saldo
        IF nuSaldoCuenCobr > 0 THEN

            -- Recorrer todos los conceptos de la cuenta de cobro seleccionada
            FOR rgConceptosCC IN cuConceptosCC
            LOOP

                -- Identificar la deuda total del concepto
                proDeudaConceptoCC(inuCuenCobr => inuCuenCobr, --
                                   inuConcepto => rgConceptosCC.Cargconc, --
                                   onuSaldoConcepto => nuValorAAcreditar, --
                                   osbError => osbError);

                IF osbError IS NOT NULL THEN
                    RAISE exError;
                END IF;

                -- Si el concepto tiene deuda, se crea el cargo CR
                --si el valor digitado no es mayor que la deuda de la cc(swmayor=0)
                --se hace el proceso normal
                
                -- se adiciona if
                IF rgConceptosCC.Cargconc not in (cnuConcSubsidio,cnuConcSubCovid,cnuConcCovid) THEN
                    IF nuValorAAcreditar > 0
                       AND swMayor = 0 THEN
                        proInsMantenimientoNotaDet(inuCuenta_cobro => inuCuenCobr, --
                                                   inuProducto => inuProducto, --
                                                   inuConcepto => rgConceptosCC.Cargconc, --
                                                   inuSigno => csbCredito, --
                                                   inuValor => nuValorAAcreditar, --
                                                   inuCausa_cargo => inuCausaCargo, --
                                                   osbError => osbError);

                        IF osbError IS NOT NULL THEN
                            RAISE exError;
                        END IF;
                    ELSIF nuValorAAcreditar > 0 THEN --mod.15.12.2018 Isempre y cuando el concepto tenga deuda
                        --mod.15.12.2018 realizamos el prorrateo para el concepto
                        --para indicar el valor que le corresponde
                        nuPorcentage := nuValorAAcreditar / nuSaldoCuenCobr;
                        nuValorAAcreditar := round(nuValorDigitado * nuPorcentage);

                        --valor digitado mayor al valor de la cc(swmayor<>0) se toma el
                        --valor porcionado
                        proInsMantenimientoNotaDet(inuCuenta_cobro => inuCuenCobr, --
                                                   inuProducto => inuProducto, --
                                                   inuConcepto => rgConceptosCC.Cargconc, --
                                                   inuSigno => csbCredito, --
                                                   inuValor => nuValorAAcreditar, --nuvalor, --
                                                   inuCausa_cargo => inuCausaCargo, --
                                                   osbError => osbError);

                        IF osbError IS NOT NULL THEN
                            RAISE exError;
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
                        RAISE exError;
                    END IF;
                    -- subsidio covid
                    proDeudaConceptoCC(inuCuenCobr => inuCuenCobr,
                                       inuConcepto => cnuConcSubCovid,
                                       onuSaldoConcepto => nuValorsubsidioCovid,
                                       osbError => osbError);

                    IF osbError IS NOT NULL THEN
                        RAISE exError;
                    END IF;
                    -- consumo covid
                    proDeudaConceptoCC(inuCuenCobr => inuCuenCobr,
                                       inuConcepto => cnuConcCovid,
                                       onuSaldoConcepto => nuValorCovid,
                                       osbError => osbError);

                    IF osbError IS NOT NULL THEN
                        RAISE exError;
                    END IF;
                    IF nuValorsubsidio <> 0 THEN
                        ut_trace.trace('Va a insertar el subsidio acreditar deuda ' ||
                                       nuValorsubsidio);
                        proInsMantenimientoNotaDet(inuCuenta_cobro => inuCuenCobr,
                                                   inuProducto => inuProducto,
                                                   inuConcepto => cnuConcSubsidio,
                                                   inuSigno => csbDebito,
                                                   inuValor => -1 * nuValorsubsidio,
                                                   inuCausa_cargo => inuCausaCargo,
                                                   osbError => osbError);
                        IF osbError IS NOT NULL THEN
                          RAISE exError;
                        END IF;
                    END IF;
                    --  valor subsidio covid
                    IF nuValorsubsidioCovid <> 0 THEN
                        ut_trace.trace('Va a insertar el subsidio covid acreditar deuda ' ||
                                       nuValorsubsidioCovid);
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
                          RAISE exError;
                        END IF;
                    END IF;
                    --  valor consumo covid
                    IF nuValorCovid <> 0 THEN
                        ut_trace.trace('Va a insertar el consumo covid acreditar deuda ' ||
                                       nuValorCovid);
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
                          RAISE exError;
                        END IF;
                    END IF;
                    
                END IF;

            --lmfg
            ------------------------------------------------------------------------------------------------

            END LOOP;

        ELSE
            ut_trace.trace('La cuenta de cobro ' || inuCuenCobr ||
                           ' no se puede acreditar ya que no tiene saldo');
        END IF;

        ut_trace.trace('FIN ' || gsbPaquete || '.' || sbProceso);
    EXCEPTION
        WHEN exError THEN
            ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' ||
                           sbProceso || '(' || nuPaso || '):' || osbError);
        WHEN OTHERS THEN
            Pkg_Error.setError;
            pkg_error.geterror(onuError, osberror);
            osbError := 'TERMINO CON ERROR NO CONTROLADO  ' || gsbPaquete || '.' ||
                        sbProceso || '(' || nuPaso || '): ' || osberror;
            ut_trace.trace(osbError);
    END;

    PROCEDURE proDetDebitarConcepto
    (
        inuProducto   pr_product.product_id%TYPE, -- Producto
        inuConcepto   concepto.conccodi%TYPE, -- Concepto
        inuValor      cargos.cargvalo%TYPE, -- Valor a acreditar
        inuCausaCargo causcarg.cacacodi%TYPE, -- Causa cargo
        inuPlanId     plandife.pldicodi%TYPE, -- Plan de diferido
        inuNroCuotas  plandife.pldicumi%TYPE, -- Numero de cuotas
        osbError      OUT VARCHAR2
    ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proDetDebitarConcepto
        Descripcion:        Almacena la informacion a debitar

        Autor    : Sandra Mu?oz
        Fecha    : 15-04-2016  CA 200-201

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        29-04-2024   jcatuche               OSF-3206: Se agrega llamado a pkg_gestiondiferidos.pSimProyCuotas
                                                para simulación de financiación
        15-04-2016   Sandra Mu?oz           Creacion
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
        sbDifeProg             CHAR(4) := 'FRNF';
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
        onuError             NUMBER;  
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

        exError EXCEPTION; -- Error controlado

    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_traza.trace('inuProducto    <= '||inuProducto, csbNivelTraza);
        pkg_traza.trace('inuConcepto    <= '||inuConcepto, csbNivelTraza);
        pkg_traza.trace('inuValor       <= '||inuValor, csbNivelTraza);
        pkg_traza.trace('inuCausaCargo  <= '||inuCausaCargo, csbNivelTraza);
        pkg_traza.trace('inuPlanId      <= '||inuPlanId, csbNivelTraza);
        pkg_traza.trace('inuNroCuotas   <= '||inuNroCuotas, csbNivelTraza);

        Pkg_Error.SetApplication(sbDifeProg);

        -- Validar datos obligatorios
        IF inuProducto IS NULL THEN
            osbError := 'Falta indicar el producto al que se le acreditara la deuda';
            RAISE exError;
        END IF;

        IF inuConcepto IS NULL THEN
            osbError := 'Falta indicar el concepto al que se va a acreditar';
            RAISE exError;
        END IF;

        IF inuValor IS NULL THEN
            osbError := 'Falta ingresar el valor a acreditar';
            RAISE exError;
        END IF;

        IF inuCausaCargo IS NULL THEN
            osbError := 'Falta indicar la causa cargo';
            RAISE exError;
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
                    RAISE exError;
            end;
        End If;

        proInsMantenimientoNotaDet(inuCuenta_cobro => -1, --
                                   inuProducto => inuProducto, --
                                   inuConcepto => inuConcepto, --
                                   inuSigno => 'DB', --
                                   inuValor => inuValor, --
                                   inuCausa_cargo => inuCausaCargo, --
                                   osbError => osbError);


        --Registramos en LDC_MANTENIMIENTO_NOTAS_DIF la informaci?n para ser usada en proceso
        --de aprobacion de moviemntos finacieros
        insert into LDC_MANTENIMIENTO_NOTAS_DIF(PACKAGE_ID, PRODUCT_ID, CUCOCODI, CONCEPTO_ID,  CUOTAS, PLAN_DIFE, SESION)
          values(-1, inuProducto, -1, inuConcepto, inuNroCuotas, inuPlanId, gnuSesion);

        pkg_traza.trace('osbError => '||osbError, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
        
    EXCEPTION
        WHEN exError THEN
            sbError := osbError;
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
        WHEN OTHERS THEN
            Pkg_Error.setError;
            pkg_error.geterror(nuError, sbError);
            osbError := sbError;
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
    END;
    
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

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        21-05-2019   Ronald Colpas C.       Creacion
        ******************************************************************/

        sbProceso         VARCHAR2(4000) := 'proDetDebitarCuentaCobro';
        nuPaso            NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        nuSaldoCuenCobr   cuencobr.cucosacu%TYPE; -- Saldo de la cuenta de cobro
        nucantconc        NUMBER; --cantidad de conceptos en la cuenta de cobro
        swExist           NUMBER := 0; --sw para saber si hay cargos del programa FGCA
        nuValorDigitado   NUMBER; --valor digitado en la pantalla
        nuvalor           NUMBER; --valor porcionado de la deuda por concepto

        nuVenc           NUMBER; --vencimiento de la cta 0 vencida, 1 actual
        onuError             NUMBER;  
        exError EXCEPTION; -- Error controlado

        CURSOR cuCargFGCA is
          SELECT *
            FROM cargos
           WHERE cargcuco = inuCuenCobr
             AND cargprog = 5;


    BEGIN
        ut_trace.trace('INICIO ' || gsbPaquete || '.' || sbProceso);

        -- Validar datos obligatorios
        IF inuProducto IS NULL THEN
            osbError := 'Falta indicar el producto al que se le acreditara la deuda';
            RAISE exError;
        END IF;

        IF inuCuenCobr IS NULL THEN
            osbError := 'Falta indicar el numero de cuenta de cobro a acreditar';
            RAISE exError;
        END IF;

        IF inuCausaCargo IS NULL THEN
            osbError := 'Falta indicar la causa cargo';
            RAISE exError;
        END IF;

        -- Obtener el saldo total de la cuenta de cobro
        proDeudaCuentaCobro(inuProducto => inuProducto, --
                            inuCuenCobr => inuCuenCobr, --
                            onuSaldoCuenCobr => nuSaldoCuenCobr, --
                            osbError => osbError);

        IF osbError IS NOT NULL THEN
            RAISE exError;
        END IF;

        IF nuSaldoCuenCobr > 0 THEN
          osbError := 'La cuenta de cobro ' || inuCuenCobr ||
                      ' a la que se quiere aplicar novedad debitar por cuenta de cobro esta con saldo pendiente ';
          RAISE exError;
        END IF;

        swExist := 0;
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
             RAISE exError;
           END IF;
           ut_trace.trace('Novedad Debitar CC concepto: ' || rgConceptosCC.Cargconc);

        END LOOP;

        IF swExist = 0 THEN
            osbError := 'La cuenta de cobro ' || inuCuenCobr ||
                           ' a la que se quiere aplicar novedad '||
                           'debitar por cuenta de cobro no tiene cargos generados por FGCA';
            ut_trace.trace(osbError);
            RAISE exError;
        END IF;

        ut_trace.trace('FIN ' || gsbPaquete || '.' || sbProceso);
    EXCEPTION
        WHEN exError THEN
            ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' ||
                           sbProceso || '(' || nuPaso || '):' || osbError);
        WHEN OTHERS THEN
            Pkg_Error.setError;
            pkg_error.geterror(onuError, osberror);
            osbError := 'TERMINO CON ERROR NO CONTROLADO  ' || gsbPaquete || '.' ||
                        sbProceso || '(' || nuPaso || '): ' || osberror;
            ut_trace.trace(osbError);
    END;

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

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        22-08-2023   Diana.Montes           OSF-1343: Se coloca la validacion inuValor < 0 para que 
                                            no permita registrar valores negativos
        20-05-2019   Ronad Colpas C.        Creacion
        ******************************************************************/

        sbProceso       VARCHAR2(4000) := 'proDetDebitarConceptoYCC';
        nuPaso          NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
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
        exError EXCEPTION; -- Error controlado
        onuError             NUMBER;  
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
        ut_trace.trace('INICIO ' || gsbPaquete || '.' || sbProceso);

        -- Validar datos obligatorios
        IF inuProducto IS NULL THEN
            osbError := 'Falta indicar el producto al que se le acreditara la deuda';
            RAISE exError;
        END IF;

        IF inuConcepto IS NULL THEN
            osbError := 'Falta indicar el concepto al que se va a acreditar';
            RAISE exError;
        END IF;

        IF inuValor IS NULL THEN
            osbError := 'Falta ingresar el valor a acreditar';
            RAISE exError;
        END IF;
        
        IF inuValor < 0 THEN
            osbError := 'El valor a debitar debe ser mayor a cero';
            RAISE exError;
        END IF;
        
        IF inuCuenCobr IS NULL THEN
            osbError := 'Falta la cuenta de cobro en la que se acreditara la cuenta de cobro';
            RAISE exError;
        END IF;

        IF inuCausaCargo IS NULL THEN
            osbError := 'Falta indicar la causa cargo';
            RAISE exError;
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
            RAISE exError;
        END IF;

        --Validamos si el concepto base tiene Iva para calcularlo
        OPEN cuConcIva;
        FETCH cuConcIva INTO nuConcIva;
        IF cuConcIva%FOUND THEN
          --Realiza calculo para el valor del IVA
          nuPorIva   := fnutraePIva(inuconcepto => nuConcIva, inuserv => pktblservsusc.fnugetservice(inuProducto));
          nuValorIva := round(inuValor * (nuPorIva / 100), 0);

          ut_trace.trace('Acredita concepto IVA: '||nuConcIva||' va a insertar valor de: ' ||
                          nuValorIva ||' porcentaje IVA: '|| nuPorIva);

          IF nuValorIva != 0 THEN
            proInsMantenimientoNotaDet(inuCuenta_cobro => inuCuenCobr, --
                                       inuProducto => inuProducto, --
                                       inuConcepto => nuConcIva, --
                                       inuSigno => csbDebito, --
                                       inuValor => nuValorIva, --
                                       inuCausa_cargo => inuCausaCargo, --
                                       osbError => osbError);
            IF osbError IS NOT NULL THEN
              RAISE exError;
            END IF;

          END IF;
        END IF;

        ut_trace.trace('FIN ' || gsbPaquete || '.' || sbProceso);
    EXCEPTION
        WHEN exError THEN
            ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' ||
                           sbProceso || '(' || nuPaso || '):' || osbError);
        WHEN OTHERS THEN
            Pkg_Error.setError;
            pkg_error.geterror(onuError, osberror);
            osbError := 'TERMINO CON ERROR NO CONTROLADO  ' || gsbPaquete || '.' ||
                        sbProceso || '(' || nuPaso || '): ' || osberror;
            ut_trace.trace(osbError);
    END;

    PROCEDURE proCalcularProyectado
    (
        inuProducto LDC_MANTENIMIENTO_NOTAS_PROY.producto%TYPE,
        osbError    OUT VARCHAR2
    ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proCalcularProyectado
        Descripcion:        Carga toda la informacion para poder calcular la deuda proyectada

        Autor    : Sandra Mu?oz

        Fecha    : 15-04-2016  CA 200-201

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        12-04-2018   Ronald Colpas          caso 2001650 se omite validacion de aplicacion de entrega fblaplicaentrega

        15-04-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

        sbProceso VARCHAR2(4000) := 'proInsertarMantenimientoNota';
        nuPaso    NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error

        exError EXCEPTION; -- Error controlado
        onuError             NUMBER;  
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
        ut_trace.trace('INICIO ' || gsbPaquete || '.' || sbProceso);

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
                RAISE exError;
            END IF;
        END LOOP;

        COMMIT;

        ut_trace.trace('FIN ' || gsbPaquete || '.' || sbProceso);
    EXCEPTION
        WHEN exError THEN
            ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' ||
                           sbProceso || '(' || nuPaso || '):' || osbError);
        WHEN OTHERS THEN
            Pkg_Error.setError;
            pkg_error.geterror(onuError, osberror);
            osbError := 'TERMINO CON ERROR NO CONTROLADO  ' || gsbPaquete || '.' ||
                        sbProceso || '(' || nuPaso || '): ' || osberror;
            ut_trace.trace(osbError);
    END;

    PROCEDURE proMostrarDeudaActual
    (
        inuProducto                   LDC_MANTENIMIENTO_NOTAS_PROY.producto%TYPE,
        ocrLDC_MANTENIMIENTO_NOTAS_PR OUT PKCONSTANTE.TYREFCURSOR,
        onucreditbalance              OUT NUMBER,
        onuclaimvalue                 OUT NUMBER,
        onudefclaimvalue              OUT NUMBER,
        osbError                      OUT VARCHAR2
    ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proMostrarDeudaActual
        Descripcion:        Muestra la deuda actual por concepto

        Autor    : Sandra Mu?oz

        Fecha    : 15-04-2016  CA 200-201

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        11-12-2018   Ronald colpas          caso2001650 se modifica cursor ocrLDC_MANTENIMIENTO_NOTAS_PR
                                            para incluir el valor vencido
        15-04-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

        sbProceso VARCHAR2(4000) := 'proMostrarDeudaActual';
        nuPaso    NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error

        nucurrentaccounttotal  NUMBER;
        nudeferredaccounttotal NUMBER;
        nuContrato  pr_product.subscription_id%type;
        otbbalanceaccounts PKCONSTANTE.TYREFCURSOR; --fa_boaccountstatustodate.tytbbalanceaccounts;
        otbdeferredbalance PKCONSTANTE.TYREFCURSOR; --fa_boaccountstatustodate.tytbdeferredbalance;


        exError EXCEPTION; -- Error controlado
        onuError             NUMBER;  
    BEGIN
        ut_trace.trace('INICIO ' || gsbPaquete || '.' || sbProceso);

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
        nuContrato := dapr_product.fnugetsubscription_id(inuProducto);

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

        ut_trace.trace('FIN ' || gsbPaquete || '.' || sbProceso);
    EXCEPTION
        WHEN exError THEN
            ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' ||
                           sbProceso || '(' || nuPaso || '):' || osbError);
        WHEN OTHERS THEN
            Pkg_Error.setError;
            pkg_error.geterror(onuError, osberror);
            osbError := 'TERMINO CON ERROR NO CONTROLADO  ' || gsbPaquete || '.' ||
                        sbProceso || '(' || nuPaso || '): ' || osberror;
            ut_trace.trace(osbError);
    END;

    PROCEDURE proMostrarProyectado
    (
        inuProducto                   LDC_MANTENIMIENTO_NOTAS_PROY.producto%TYPE,
        ocrLDC_MANTENIMIENTO_NOTAS_PR OUT PKCONSTANTE.TYREFCURSOR,
        osbError                      OUT VARCHAR2
    ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete:
        Descripcion:

        Autor    : Sandra Mu?oz

        Fecha    : 15-04-2016  CA 200-201

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        11-12-2018   Ronald colpas          caso2001650 se modifica cursor ocrLDC_MANTENIMIENTO_NOTAS_PR
                                            para incluir el valor vencido
        15-04-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

        sbProceso VARCHAR2(4000) := 'proInsertarMantenimientoNota';
        nuPaso    NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error

        exError EXCEPTION; -- Error controlado
        onuError             NUMBER;  
    BEGIN
        ut_trace.trace('INICIO ' || gsbPaquete || '.' || sbProceso);

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

        ut_trace.trace('FIN ' || gsbPaquete || '.' || sbProceso);
    EXCEPTION
        WHEN exError THEN
            ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' ||
                           sbProceso || '(' || nuPaso || '):' || osbError);
        WHEN OTHERS THEN
            Pkg_Error.setError;
            pkg_error.geterror(onuError, osberror);
            osbError := 'TERMINO CON ERROR NO CONTROLADO  ' || gsbPaquete || '.' ||
                        sbProceso || '(' || nuPaso || '): ' || osberror;
            ut_trace.trace(osbError);
    END;

    PROCEDURE proDesglosaAcreditarDeuda
    (
        inuProducto pr_product.product_id%TYPE, -- Producto
        osbError    OUT VARCHAR2
    ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proGenAcreditarDeuda
        Descripcion:        Genera las solicitudes de aprobacion de notas

        Autor    : Sandra Mu?oz
        Fecha    : 15-04-2016  CA 200-201

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        15-04-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

        sbProceso    VARCHAR2(4000) := 'proGenAcreditarDeuda';
        nuPaso       NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        nuDeudaTotal NUMBER; -- Deuda total del producto

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
        exError EXCEPTION; -- Error controlado
        onuError             NUMBER;  
    BEGIN
        ut_trace.trace('INICIO ' || gsbPaquete || '.' || sbProceso);

        -- Validar datos obligatorios
        IF inuProducto IS NULL THEN
            osbError := 'Falta indicar el producto al que se le acreditara la deuda';
            RAISE exError;
        END IF;

        -- Obtiene la deuda del producto
        BEGIN
            SELECT nvl(SUM(nvl(valor_corriente, 0)) +
                       SUM(nvl(valor_diferido, 0)), 0) deuda_total
            INTO nuDeudaTotal
            FROM LDC_MANTENIMIENTO_NOTAS_PROY lmn
            WHERE lmn.sesion = gnuSesion
                  AND lmn.producto = inuProducto
                  AND lmn.origen = 'D'
                  AND lmn.signo_corriente = csbDebito -- Deuda real de los productos

            ;
        EXCEPTION
            WHEN OTHERS THEN
                Pkg_Error.setError;
            pkg_error.geterror(onuError, osberror);
                osbError := 'No fue posible determinar la deuda total del producto ' ||
                            inuProducto || '. ' || osberror;
                RAISE exError;
        END;

        -- Obtener los conceptos con deuda del producto
        FOR rgDeudaConcepto IN cuDeudaConcepto
        LOOP

            -- Crear registro CR
            proInsMantenimientoNotaProy(inuProducto => inuProducto, isbSignoCorriente => csbCredito, inuValorCorriente => rgDeudaConcepto.Valor_Corriente, inuValorVencido => rgDeudaConcepto.valor_vencido, inuConcepto => rgDeudaConcepto.concepto, isbOrigen => 'P', inuValorDiferido => 0, isbSignoDiferido => 0, osbError => osbError);

            IF osbError IS NOT NULL THEN
                RAISE exError;
            END IF;

        END LOOP;

        ut_trace.trace('FIN ' || gsbPaquete || '.' || sbProceso);
    EXCEPTION
        WHEN exError THEN
            ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' ||
                           sbProceso || '(' || nuPaso || '):' || osbError);
        WHEN OTHERS THEN
            Pkg_Error.setError;
            pkg_error.geterror(onuError, osberror);
            osbError := 'TERMINO CON ERROR NO CONTROLADO  ' || gsbPaquete || '.' ||
                        sbProceso || '(' || nuPaso || '): ' || osberror;
            ut_trace.trace(osbError);
    END;

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

        Autor    : Sandra Mu?oz
        Fecha    : 15-04-2016  CA 200-201

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        12-04-2018   Ronald Colpas          caso 2001650 se omite validacion de aplicacion de entrega fblaplicaentrega

        15-04-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

        sbProceso                    VARCHAR2(4000) := 'fnuGeneraNota';
        nuPaso                       NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        nuMaxMontoPerfilFinanciero   NUMBER; -- Maximo monto autorizado para el perfil financiero del usuario
        nuGeneraNota                 NUMBER := 1; -- Indica si se genera la nota o se envia a visado
        sbError                      VARCHAR2(4000); -- Error
        nuProducto                   pr_product.product_id%TYPE; -- Producto
        nuNumeroDias                 ld_parameter.numeric_value%TYPE; -- Numero de dias en las que se evaluara si un producto ya se le crearon notas
        nuAcumuladoNotas             NUMBER; -- Valor de las notas generadas en un periodo de tiempo para un cliente a un mismo producto
        sbEstadoPendienteInstalacion ld_parameter.value_chain%TYPE; -- Estados de producto que indican que esta pendiente de instalacion
        sbSolicitudVenta             ld_parameter.value_chain%TYPE; -- Tipos de solicitud de venta
        nuSolicitudRegistrado        ld_parameter.numeric_value%TYPE; -- Estado registrado de una solicitud
        nuTieneVentaRegistrada       ld_parameter.numeric_value%TYPE; -- Indica si un producto tiene venta registrada
        exError EXCEPTION; -- Error controlado
        onuError             NUMBER;  
    BEGIN
        
        ut_trace.trace('INICIO ' || gsbPaquete || '.' || sbProceso);

        -- Obtener los valores de los parametros
        nuNumeroDias := DALD_PARAMETER.fnuGetNumeric_Value('DIAS_MONTO_NOTAS');
        IF nuNumeroDias IS NULL THEN
            sbError := 'No se ha definido el parametro DIAS_MONTO_NOTAS';
            RAISE exError;
        END IF;

        sbEstadoPendienteInstalacion := DALD_PARAMETER.fsbGetValue_Chain('PRODUCTO_PENDIENTE_INSTALACION');
        IF sbEstadoPendienteInstalacion IS NULL THEN
            sbError := 'No se ha definido el parametro PRODUCTO_PENDIENTE_INSTALACION';
            RAISE exError;
        END IF;

        sbSolicitudVenta := DALD_PARAMETER.fsbGetValue_Chain('SOLICITUDES_VENTA');
        IF sbSolicitudVenta IS NULL THEN
            sbError := 'No se ha definido el parametro SOLICITUDES_VENTA';
            RAISE exError;
        END IF;

        nuSolicitudRegistrado := DALD_PARAMETER.fnuGetNumeric_Value('FNB_ESTADOSOL_REG');
        IF nuSolicitudRegistrado IS NULL THEN
            sbError := 'No se ha definido el parametro FNB_ESTADOSOL_REG';
            RAISE exError;
        END IF;
        ut_trace.trace('va a obtener el perfil financiero');
        -- Obtener el monto maximo autorizado para el perfil financiero del usuario
        nuMaxMontoPerfilFinanciero := GE_BOFinancialProfile.fnuMaxAmountByUser(4, sa_bouser.fnuGetUserId(isbUsuarioRegistra));
        ut_trace.trace('usuario ' || isbUsuarioRegistra || ' valor ' ||
                             nuMaxMontoPerfilFinanciero);

        -- Valida si la entrega aplica para la gasera
        --caso-2001650 Se omite validacion de aplicacion de entrega

            -- Tener en cuenta que si el total de notas aplicadas a un mismo concepto en un producto
            -- en el dia por el usuario final es superior a lo que indica su perfil financiero se
            -- debe solicitar visado
            BEGIN
                SELECT product_id
                INTO nuProducto
                FROM mo_motive mm
                WHERE mm.package_id = inuSolicitud;
            EXCEPTION
                WHEN OTHERS THEN
                    sbError := 'Error al intentar obtener el producto asociado a la solicitud ' ||
                               inuSolicitud;
                    ut_trace.trace('    SELECT product_id
                                        FROM   mo_motive mm
                                        WHERE  mm.package_id = ' ||
                                   inuSolicitud);
                    RAISE exError;
            END;

            ut_trace.trace(' producto ' || nuProducto);
            BEGIN
                SELECT SUM(nvl(fca.caapvalo, 0))
                INTO nuAcumuladoNotas
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
            EXCEPTION
                WHEN OTHERS THEN
                    sbError := 'No fue posible obtener el valor de las notas realizadas';
                    RAISE exError;
            END;
            ut_trace.trace(' valor acumulado de notas ' ||
                                 nuAcumuladoNotas);
            -- Requiere aprobacion
            IF nuAcumuladoNotas > nuMaxMontoPerfilFinanciero THEN
                nuGeneraNota := 0;
                ut_trace.trace(' =0 ' || nuGeneraNota);
            ELSE
                nuGeneraNota := 1;
                ut_trace.trace(' =1 ' || nuGeneraNota);
                --RETURN 0;
            END IF;
            ut_trace.trace(' nugenera ' || nuGeneraNota);
            -- Si el producto tiene una solicitud de venta (587 - Venta, 100277 - Venta de Gas Cotizada IFRS,
            -- 100275 - Venta de Gas por Formulario IFRS, 100271 - Venta de Gas por Formulario
            -- Migraci?n, 100288 - Venta de Gas por Formulario Migracion 2, 100101 - Venta de
            -- Servicios de Ingenier?a, 323 - Venta a Constructoras, 271 - Venta de Gas por
            -- Formulario, 100229 - Venta de Gas Cotizada, 100025 - Venta de Accesorios, 100236 -
            -- Venta de Seguros, 100264 - VENTA FNB, 100261 - Venta Seguros XML, 141 - Venta,
            -- 100218 - Venta promigas XML, 100233 - Venta de Gas por Formulario XML,
            -- 100219 - Venta Servicios Financieros) registrada (estado 13) y el parametro de
            -- solicitar visado de aprobacion debe iniciarse el tramite 289.
            IF instr(sbEstadoPendienteInstalacion, dapr_product.fnugetproduct_status_id(inuproduct_id => nuProducto) || '|') > 0 THEN

                SELECT COUNT(1)
                INTO nuTieneVentaRegistrada
                FROM mo_packages mp, mo_motive mm
                WHERE mp.package_id = mm.package_id
                      AND mm.product_id = nuProducto
                      AND
                      instr(sbSolicitudVenta, mp.package_type_id || '|') > 0
                      AND mp.motive_status_id = nuSolicitudRegistrado;

                IF nuTieneVentaRegistrada > 0 THEN
                    nuGeneraNota := 0;
                    ut_trace.trace(' venta registrada >0 ');
                ELSE
                    nuGeneraNota := 1;
                    ut_trace.trace(' venta registrada =0 ');

                END IF;
            END IF;

        --caso 201650 se omite If de fblaplicaentrega


        ut_trace.trace(' va a devolver valor  ' || nuGeneraNota);
        RETURN nuGeneraNota;
        -- No requiere aprobacion

        ut_trace.trace('FIN ' || gsbPaquete || '.' || sbProceso);
    EXCEPTION
        WHEN exError THEN
            ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' ||
                           sbProceso || '(' || nuPaso || '):' || sbError);
        WHEN OTHERS THEN
            Pkg_Error.setError;
            pkg_error.geterror(onuError, sberror);
            sbError := 'TERMINO CON ERROR NO CONTROLADO  ' || gsbPaquete || '.' ||
                       sbProceso || '(' || nuPaso || '): ' || sbError;
            ut_trace.trace(sbError);
    END;

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

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        12-04-2018   Ronald Colpas          caso 2001650 se omite validacion de aplicacion de entrega fblaplicaentrega

        15-04-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

        sbProceso                    VARCHAR2(4000) := 'fnuGeneraNota';
        nuPaso                       NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        nuMaxMontoPerfilFinanciero   NUMBER; -- Maximo monto autorizado para el perfil financiero del usuario
        nuGeneraNota                 NUMBER := 1; -- Indica si se genera la nota o se envia a visado
        sbError                      VARCHAR2(4000); -- Error
        nuProducto                   pr_product.product_id%TYPE; -- Producto
        nuNumeroDias                 ld_parameter.numeric_value%TYPE; -- Numero de dias en las que se evaluara si un producto ya se le crearon notas
        nuAcumuladoNotas             NUMBER := 0; -- Valor de las notas generadas en un periodo de tiempo para un cliente a un mismo producto
        sbEstadoPendienteInstalacion ld_parameter.value_chain%TYPE; -- Estados de producto que indican que esta pendiente de instalacion
        sbSolicitudVenta             ld_parameter.value_chain%TYPE; -- Tipos de solicitud de venta
        nuSolicitudRegistrado        ld_parameter.numeric_value%TYPE; -- Estado registrado de una solicitud
        nuTieneVentaRegistrada       ld_parameter.numeric_value%TYPE; -- Indica si un producto tiene venta registrada
        exError EXCEPTION; -- Error controlado
        nuvaloraprobacion ldc_mantenimiento_notas_enc.valor%TYPE;
        sbUsuarioRegistra FA_APROMOFA.APMOUSRE%TYPE;
        onuError             NUMBER;  
    BEGIN
        
        ut_trace.trace('INICIO ' || gsbPaquete || '.' || sbProceso);

        SELECT USER INTO sbUsuarioRegistra FROM dual;

        -- Obtener los valores de los parametros
        nuNumeroDias := DALD_PARAMETER.fnuGetNumeric_Value('DIAS_MONTO_NOTAS');
        IF nuNumeroDias IS NULL THEN
            sbError := 'No se ha definido el parametro DIAS_MONTO_NOTAS';
            RAISE exError;
        END IF;

        sbEstadoPendienteInstalacion := DALD_PARAMETER.fsbGetValue_Chain('PRODUCTO_PENDIENTE_INSTALACION');
        IF sbEstadoPendienteInstalacion IS NULL THEN
            sbError := 'No se ha definido el parametro PRODUCTO_PENDIENTE_INSTALACION';
            RAISE exError;
        END IF;

        sbSolicitudVenta := DALD_PARAMETER.fsbGetValue_Chain('SOLICITUDES_VENTA');
        IF sbSolicitudVenta IS NULL THEN
            sbError := 'No se ha definido el parametro SOLICITUDES_VENTA';
            RAISE exError;
        END IF;

        nuSolicitudRegistrado := DALD_PARAMETER.fnuGetNumeric_Value('FNB_ESTADOSOL_REG');
        IF nuSolicitudRegistrado IS NULL THEN
            sbError := 'No se ha definido el parametro FNB_ESTADOSOL_REG';
            RAISE exError;
        END IF;
        ut_trace.trace('va a obtener el perfil financiero');
        -- Obtener el monto maximo autorizado para el perfil financiero del usuario
        nuMaxMontoPerfilFinanciero := GE_BOFinancialProfile.fnuMaxAmountByUser(4, sa_bouser.fnuGetUserId(sbUsuarioRegistra));
        ut_trace.trace('usuario ' || sbUsuarioRegistra || ' valor ' ||
                             nuMaxMontoPerfilFinanciero);



        -- Valida si la entrega aplica para la gasera
        --caso-2001650 Se omite validacion de aplicacione de entrega


            SELECT lmne.valor
            INTO nuValorAprobacion
            FROM ldc_mantenimiento_notas_enc lmne
            WHERE lmne.producto = inuProducto
                  AND lmne.sesion = gnuSesion;

            ut_trace.trace(' producto ' || inuproducto);
            BEGIN
                SELECT SUM(nvl(fca.caapvalo, 0))
                INTO nuAcumuladoNotas
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
            EXCEPTION
                WHEN OTHERS THEN
                    sbError := 'No fue posible obtener el valor de las notas realizadas';
                    RAISE exError;
            END;

            ut_trace.trace(' valor acumulado de notas ' ||
                                 nuAcumuladoNotas);
            -- Requiere aprobacion
            IF (nvl(nuvaloraprobacion, 0) + NVL(nuAcumuladoNotas, 0)) >
               NVL(nuMaxMontoPerfilFinanciero, 0) THEN
                nuGeneraNota := 0;
                ut_trace.trace(' =0 ' || nuGeneraNota);
            ELSE
                nuGeneraNota := 1;
                ut_trace.trace(' =1 ' || nuGeneraNota);
                --RETURN 0;
            END IF;
            ut_trace.trace(' nugenera ' || nuGeneraNota);
            -- Si el producto tiene una solicitud de venta (587 - Venta, 100277 - Venta de Gas Cotizada IFRS,
            -- 100275 - Venta de Gas por Formulario IFRS, 100271 - Venta de Gas por Formulario
            -- Migraci?n, 100288 - Venta de Gas por Formulario Migracion 2, 100101 - Venta de
            -- Servicios de Ingenier?a, 323 - Venta a Constructoras, 271 - Venta de Gas por
            -- Formulario, 100229 - Venta de Gas Cotizada, 100025 - Venta de Accesorios, 100236 -
            -- Venta de Seguros, 100264 - VENTA FNB, 100261 - Venta Seguros XML, 141 - Venta,
            -- 100218 - Venta promigas XML, 100233 - Venta de Gas por Formulario XML,
            -- 100219 - Venta Servicios Financieros) registrada (estado 13) y el parametro de
            -- solicitar visado de aprobacion debe iniciarse el tramite 289.
            IF instr(sbEstadoPendienteInstalacion, dapr_product.fnugetproduct_status_id(inuproduct_id => InuProducto) || '|') > 0 THEN

                SELECT COUNT(1)
                INTO nuTieneVentaRegistrada
                FROM mo_packages mp, mo_motive mm
                WHERE mp.package_id = mm.package_id
                      AND mm.product_id = InuProducto
                      AND
                      instr(sbSolicitudVenta, mp.package_type_id || '|') > 0
                      AND mp.motive_status_id = nuSolicitudRegistrado;

                IF nuTieneVentaRegistrada > 0 THEN
                    nuGeneraNota := 0;
                    ut_trace.trace(' venta registrada >0 ');
                ELSE
                    nuGeneraNota := 1;
                    ut_trace.trace(' venta registrada =0 ');

                END IF;
            ELSE
                NULL;
            END IF;


        ut_trace.trace(' va a devolver valor  ' || nuGeneraNota);
        osbError := nuGeneraNota;
        -- No requiere aprobacion

        ut_trace.trace('FIN ' || gsbPaquete || '.' || sbProceso);
    EXCEPTION
        WHEN exError THEN
            ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' ||
                           sbProceso || '(' || nuPaso || '):' || sbError);
        WHEN OTHERS THEN
            Pkg_Error.setError;
            pkg_error.geterror(onuError, sbError);
            sbError := 'TERMINO CON ERROR NO CONTROLADO  ' || gsbPaquete || '.' ||
                       sbProceso || '(' || nuPaso || '): ' || sbError;
            ut_trace.trace(sbError);
    END;

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

        Autor    : Sandra Mu?oz
        Fecha    : 15-04-2016  CA 200-201

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------

        28-10-2022   jcatuchemvm            OSF-637: Se ajusta cursor cuCargos eliminando DISTINCT, el cual evita que 
                                            se registre mas de un cargo para el mismo concepto, cuenta, signo, valor, causa.
                                            En MANOT se presenta el escenario para el mismo concepto, valor, causa. 
        12-04-2018   Ronald Colpas          caso 2001650 se omite validacion de aplicacion de entrega fblaplicaentrega

        15-04-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

        sbProceso                     VARCHAR2(4000) := 'proGrabar';
        nuPaso                        NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
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

        exError EXCEPTION; -- Error controlado
        onuError             NUMBER;  
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
                  AND producto = inuProducto

            ;

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
                            lmnd.cuenta_cobro
            FROM ldc_mantenimiento_notas_det lmnd, cuencobr cc
            WHERE lmnd.producto = inuProducto
                  AND lmnd.sesion = gnuSesion
                  AND lmnd.cuenta_cobro = cc.cucocodi
                  AND cc.cucofact = inuFactura

            ;

    BEGIN

        ut_trace.trace('INICIO ' || gsbPaquete || '.' || sbProceso);

        SELECT USER INTO usuario FROM dual;

        proBorMantenimientoNotaDet(osbError => osbError);
        IF osbError IS NOT NULL THEN
            RAISE exError;
        END IF;
        /*        INSERT INTO ltrace VALUES ('esta en prograbar...'); -- Recorrer las novedades ingresadas
        --commit;*/
        FOR rgNovedades IN cuNovedades
        LOOP

            IF rgNovedades.Novedad = 'AD' THEN
                -- Acreditar deuda
                proDetAcreditarDeuda(inuProducto => rgNovedades.Producto, inuCausaCargo => rgNovedades.Causa_Cargo, osbError => osbError);
            ELSIF rgNovedades.Novedad = 'AC' THEN
                -- Acreditar concepto
                proDetAcreditarConcepto(inuProducto => rgNovedades.Producto, inuConcepto => rgNovedades.Concepto, inuCausaCargo => rgNovedades.Causa_Cargo, osbError => osbError);
            ELSIF rgNovedades.Novedad = 'ACC' THEN
                -- Acreditar cuenta de cobro
                proDetAcreditarCuentaCobro(inuProducto => rgNovedades.Producto, inuCuenCobr => rgNovedades.Cuenta_Cobro, inuCausaCargo => rgNovedades.Causa_Cargo, osbError => osbError);
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
                RAISE exError;
            END IF;

        END LOOP;

        -- Obtener el contrato asociado al producto
        nuContrato := dapr_product.fnugetsubscription_id(inuProducto);

        --se revisa el monto que lleva

        -- Calcular el valor a aprobar
        SELECT SUM(DECODE(lmnd.signo, csbCredito, -NVL(lmnd.valor, 0), NVL(lmnd.valor, 0))),
               COUNT(1)
        INTO nuValorAprobacion, nuExistenRegistrosParaAprobar
        FROM ldc_mantenimiento_notas_det lmnd
        WHERE lmnd.producto = inuProducto
              AND lmnd.sesion = gnuSesion;

        IF nuExistenRegistrosParaAprobar > 0
        /*  AND aprueba = 0 */
         THEN

            -- Crear la solicitud
            BEGIN
                fa_boapprobilladjustmov.regapproverequest(inusubscriptionid => nuContrato, --
                                                          inuproductid => inuProducto, --
                                                          onupackageid => nuSolicitud);

            EXCEPTION
                WHEN OTHERS THEN
                    osbError := 'No fue posible crear la solicitud de aprobacion';
                    ut_trace.trace('fa_boapprobilladjustmov.regapproverequest(inusubscriptionid => ' ||
                                   nuContrato || ',
                                                  inuproductid      => ' ||
                                   inuProducto || ',
                                                  onupackageid      => ' ||
                                   nuSolicitud || ');');
                    RAISE exError;
            END;

            IF nvl(nuSolicitud, -1) = -1 THEN
                osbError := 'No fue posible crear la solicitud de aprobacion';
                RAISE exError;
            END IF;

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
                    pkg_error.geterror(onuError, osberror);
                    osbError := 'Error al crear la aprobacion de los movimientos';
                    ut_trace.trace('fa_boapprobilladjustmov.regapprobilladjust(inusumapprove  => ' ||
                                   pkbillconst.CERO || ',
                                                   isbprocces     => ' ||
                                   FA_BCApromofa.csbPRGA_AMOUNT || ',
                                                   ionuapromofaid => ' ||
                                   nuAprobacion || ',
                                                   inupackageid   => ' ||
                                   nuSolicitud || ') ;' || ' - ' || osberror);
                    ut_trace.trace('fa_boapprobilladjustmov.regapprobilladjust(inusumapprove  => ' ||
                                         pkbillconst.CERO || ',
                                                   isbprocces     => ' ||
                                         FA_BCApromofa.csbPRGA_AMOUNT || ',
                                                   ionuapromofaid => ' ||
                                         nuAprobacion || ',
                                                   inupackageid   => ' ||
                                         nuSolicitud || ') ;' || ' - ' ||
                                         SQLERRM);
                    RAISE exError;
            END;

            -- Obtener las facturas
            FOR rgFacturas IN cuFacturas
            LOOP

                sbDocumentoSoporteAprob := NULL;

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
                        pkg_error.geterror(onuError, osberror);
                        osbError := 'Error al registrar la nota para aprobacion de la factura ' ||
                                    rgFacturas.factura;
                        ut_trace.trace(' fa_boapprobilladjustmov.RegNoteToApprove(inuapprovdoc  => ' ||
                                       nuAprobacion || ',
                                                         inucontract   => ' ||
                                       nuContrato || ',
                                                         inubill       => ' ||
                                       rgFacturas.Factura || ',
                                                         isbobserv     => ' ||
                                       isbObservacion || ',
                                                         inudoctype    => ' ||
                                       rgFacturas.tipo_documento || ',
                                                         iosbsopdoc    => ' ||
                                       sbDocumentoSoporteAprob || ',
                                                         onunotenumber => ' ||
                                       nuNotaAprobacion || ');');

                        ut_trace.trace(' fa_boapprobilladjustmov.RegNoteToApprove(inuapprovdoc  => ' ||
                                             nuAprobacion || ',
                                                         inucontract   => ' ||
                                             nuContrato || ',
                                                         inubill       => ' ||
                                             rgFacturas.Factura || ',
                                                         isbobserv     => ' ||
                                             isbObservacion || ',
                                                         inudoctype    => ' ||
                                             rgFacturas.tipo_documento || ',
                                                         iosbsopdoc    => ' ||
                                             sbDocumentoSoporteAprob || ',
                                                         onunotenumber => ' ||
                                             nuNotaAprobacion || ');' ||
                                             osberror);

                        RAISE exError;
                END;

                ut_trace.trace('nuFacturaAnt ' || nuFacturaAnt);
                ut_trace.trace('rgfacturas ' || rgFacturas.Factura);

                IF nuFacturaAnt <> rgFacturas.Factura THEN
                    --lmf*/
                    ut_trace.trace('entro por diferencia de facturas');

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
                                                                   inubasevalue => rgCargos.Valor, --
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
            RAISE exError;
        END IF;

        COMMIT;

        ut_trace.trace('FIN ' || gsbPaquete || '.' || sbProceso);
    EXCEPTION
        WHEN exError THEN
            ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' ||
                           sbProceso || '(' || nuPaso || '):' || osbError);
        WHEN OTHERS THEN
            Pkg_Error.setError;
            pkg_error.geterror(onuError, osberror);
            osbError := 'TERMINO CON ERROR NO CONTROLADO  ' || gsbPaquete || '.' ||
                        sbProceso || '(' || nuPaso || '): ' || osberror;
            ut_trace.trace(osbError);
    END;

    PROCEDURE proGrabarDebitarConcepto(inuPackage in mo_packages.package_id%type) IS

	    /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del procedimiento: proGrabarDebitarConcepto
        Descripcion:

        Autor    :
        Fecha    :

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        29-04-2024      jcatuchemvm         OSF-3206: Se elimina en el llamado al procedimiento para ajustar la cuenta el valor del impuesto [nuvaloriva]
                                            el procedimiento de registro del cargo de iva ya realiza el ajuste de la cuenta para el valor del impuesto.
                                            Evita que la cuenta quede desajustada
        19-06-2023   Diana Montes           OSF-1347: Se modifica para que ejecute el proceso solamente cuando tenga registro 
                                            en la entidad ldc_mantenimiento_notas_dif (cuando se registra por MANOT), se 
                                            encuentra en la accion 8342 en el flujo. 
        13-06-2023   Diana Montes           OSF-1117: Se modifica para que todos los cargos queden 
                                            asociados a una sola cuenta de cobro y factura

        28-10-2022   jcatuchemvm            OSF-637: Se ajusta cursor cuDebConc el cual duplicaba los cargos
                                            que en MANOT se registran para el mismo concepto y valor, ya que en
                                            ldc_mantenimiento_notas_dif no se hace distincion por el valor, ahora 
                                            solo se difieren los cargos solicitados. Se agrega rowid para la actualizacion
                                            Se actualiza la variable nuvaloriva en cada iteracion de concepto, para evitar
                                            que las cuentas de cobro queden con un saldo errado correspondiente al valor del
                                            IVA de la cuenta/concepto anterior
        30-11-2020   Miguel Ballesteros     caso 271: se modificar el cierre del cursor cuConcIva

        ******************************************************************/
        csbMetodo                     VARCHAR2(4000) := csbPaquete||'proGrabarDebitarConcepto';
      nuFactura              factura.factcodi%TYPE; -- Numero de factura
      nuContrato             NUMBER;
      grcSubscription        suscripc%ROWTYPE;
      nuCuentaCobro          cuencobr.cucocodi%TYPE;
      rcProduct              servsusc%ROWTYPE;
      nuNote                 notas.notanume%TYPE;
      sbDifeProg             CHAR(4) := 'FRNF';
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
      sbError                VARCHAR2(4000) := NULL;
      onuError             NUMBER;  
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
        
            Pkg_Error.SetApplication(sbDifeProg);     
            -- crear factura
            pkAccountStatusMgr.GetNewAccoStatusNum(nuFactura);
            -- Obtener el codigo del contrato
            nuContrato := pkg_bcproducto.fnuContrato(nuProduct);
            if nuContrato is null then
                pkg_error.setErrorMessage(isbMsgErrr => 'El producto '||nuProduct||' no existe en la BD');
            end if;
            nuContrato := dapr_product.fnugetsubscription_id(nuProduct);
            
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
            FETCH cuConcIva
              INTO nuConcIva;
            IF cuConcIva%FOUND THEN
              --CLOSE cuConcIva;  --- modificacion caso 271
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
                                               nuValorIva, --
                                               pkBillConst.csbTOKEN_NOTA_DEBITO ||
                                               nuNote, --
                                               pkBillConst.DEBITO, --
                                                Constants_Per.Csbsi, --
                                               NULL, --
                                                Constants_Per.Csbsi);
            END IF;

            CLOSE cuConcIva; --- modificacion caso 271

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
                                                                isbdifeprog          => sbDifeProg, --
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

    PROCEDURE proPlantilla
    (
        nuDato   NUMBER,
        osbError OUT VARCHAR2
    ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete:
        Descripcion:

        Autor    : Sandra Mu?oz
        Fecha    : 15-04-2016  CA 200-201

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        15-04-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

        sbProceso VARCHAR2(4000) := 'proInsertarMantenimientoNota';
        nuPaso    NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error

        exError EXCEPTION; -- Error controlado
        onuError             NUMBER;  
    BEGIN
        ut_trace.trace('INICIO ' || gsbPaquete || '.' || sbProceso);

        ut_trace.trace('FIN ' || gsbPaquete || '.' || sbProceso);
    EXCEPTION
        WHEN exError THEN
            ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' ||
                           sbProceso || '(' || nuPaso || '):' || osbError);
        WHEN OTHERS THEN
            Pkg_Error.setError;
            pkg_error.geterror(onuError, osberror);
            osbError := 'TERMINO CON ERROR NO CONTROLADO  ' || gsbPaquete || '.' ||
                        sbProceso || '(' || nuPaso || '): ' || osberror;
            ut_trace.trace(osbError);
    END;

    FUNCTION fcnconcepnoacredit RETURN PKCONSTANTE.TYREFCURSOR IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete:
        Descripcion:

        Autor    : Luis Fren G

        Fecha    : 10/04/2017  CA 200-818

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        10-04-2017   Luis Fren G           Creacion
        ******************************************************************/

        sbProceso     VARCHAR2(4000) := 'fcnconcepnoacredit';
        nuPaso        NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        crConcepNoAcr PKCONSTANTE.TYREFCURSOR;
        sbError       VARCHAR2(4000); -- Error
        exError EXCEPTION; -- Error controlado
        onuError             NUMBER;  
    BEGIN
        ut_trace.trace('INICIO ' || gsbPaquete || '.' || sbProceso);

        -- Consulta cursor referenciado
        OPEN crConcepNoAcr FOR
            SELECT l.conccodi FROM ldc_conc_no_acred l ORDER BY 1;

        RETURN crConcepNoAcr;

        ut_trace.trace('FIN ' || gsbPaquete || '.' || sbProceso);
    EXCEPTION
        WHEN exError THEN
            ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' ||
                           sbProceso || '(' || nuPaso || '):' || sbError);
        WHEN OTHERS THEN
            Pkg_Error.setError;
            pkg_error.geterror(onuError, sberror);
            sbError := 'TERMINO CON ERROR NO CONTROLADO  ' || gsbPaquete || '.' ||
                       sbProceso || '(' || nuPaso || '): ' || sberror;
            ut_trace.trace(sbError);
    END;

END LDC_PKMANTENIMIENTONOTAS;
/