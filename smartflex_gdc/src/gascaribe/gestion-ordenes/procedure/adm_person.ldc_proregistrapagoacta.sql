CREATE OR REPLACE PROCEDURE ADM_PERSON.LDC_PROREGISTRAPAGOACTA IS
    /*****************************************************************
    Propiedad intelectual de Gases de occidente.

    Nombre del Paquete: ldc_proRegistraPagoActa
    Descripción:        Al momento de ingresar un número de factura se valida
                        que no exista el mismo número de factura en otra acta
                        del mismo contratista

    Autor : Sandra Muñoz
    Fecha : 05-11-2015 Aranda 8658
    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.              Modificación
    -----------  -------------------    -------------------------------------
    28-07-2016   Sandra Muñoz           Exigir el ingreso del número de la factura y eliminar espacios
                                        antes y después del número de la factura CA200-405
    05-11-2015   Sandra Muñoz           Creación
    ******************************************************************/

    sbRegistrarPago        CHAR(1); -- Indica si se cumplen las condiciones para aceptar la venta
    nuActaConFactIngresada ge_acta.id_acta%TYPE; -- Indica el número del acta donde ya se registró la factura
    SBID_ACTA              GE_BOINSTANCECONTROL.STYSBVALUE; -- Id del acta seleccionada en la forma
    NUCERTIFICATEID        GE_ACTA.ID_ACTA%TYPE; -- Número del acta ingresada por la forma convertida en variable
    SBEXTERN_INVOICE_NUM   GE_BOINSTANCECONTROL.STYSBVALUE; -- Número de factura ingresada por la forma
    --    SBEXTERNINVOICENUM     GE_ACTA.EXTERN_INVOICE_NUM%TYPE; -- número de factura convertida a variable
    sbPrograma          VARCHAR2(4000) := 'ldc_proRegistraPagoActa'; -- Nombre del programa que se está ejecutando
    nuContratista       ge_Acta.Contractor_Id%TYPE; -- Contratista asociada al acta que se va pagar
    sbError             VARCHAR2(4000);
    sbNombreContratista ge_contratista.nombre_contratista%TYPE; -- Nombre del contratista
    nuPaso              NUMBER; -- Paso ejecutado en el programa

    exError EXCEPTION; -- Exception controlada
    csbEntrega200405 VARCHAR2(100) := 'BSS_CON_SMS_200405_1';

    FUNCTION fsbAplicaEntrega(isbEntrega VARCHAR2) RETURN VARCHAR2 IS
        blGDO      BOOLEAN := LDC_CONFIGURACIONRQ.aplicaParaGDO(isbEntrega);
        blEFIGAS   BOOLEAN := LDC_CONFIGURACIONRQ.aplicaParaEfigas(isbEntrega);
        blSURTIGAS BOOLEAN := LDC_CONFIGURACIONRQ.aplicaParaSurtigas(isbEntrega);
        blGDC      BOOLEAN := LDC_CONFIGURACIONRQ.aplicaParaGDC(isbEntrega);
    BEGIN
        IF blGDO = TRUE OR blEFIGAS = TRUE OR blSURTIGAS = TRUE OR blGDC = TRUE THEN
            RETURN 'S';
        END IF;
        RETURN 'N';
    END;

BEGIN

    nuPaso := 10;

    ut_trace.trace('Inicio ' || sbPrograma, 10);

    -- Lee la información de la forma
    nuPaso := 30;
    ut_trace.trace('Lee la información de la forma', 10);
    SBID_ACTA       := GE_BOINSTANCECONTROL.FSBGETFIELDVALUE('GE_ACTA', 'ID_ACTA');
    NUCERTIFICATEID := UT_CONVERT.FNUCHARTONUMBER(SBID_ACTA);

    SBEXTERN_INVOICE_NUM := GE_BOINSTANCECONTROL.FSBGETFIELDVALUE('GE_ACTA', 'EXTERN_INVOICE_NUM');

    IF fsbAplicaEntrega('FNB_SMS_ARA_8658') = 'S' THEN
        nuPaso := 40;
        ut_trace.trace('Se busca el número del contratista', 10);
        BEGIN
            -- Se busca el número del contratista
            SELECT gc.id_contratista,
                   gco.nombre_contratista
            INTO   nuContratista,
                   sbNombreContratista
            FROM   ge_acta        ga,
                   ge_contrato    gc,
                   ge_contratista gco
            WHERE  ga.id_acta = nuCertificateId
            AND    ga.id_contrato = gc.id_contrato
            AND    gc.id_contratista = gco.id_contratista;
        EXCEPTION
            WHEN OTHERS THEN
                sbError := 'No fué posible identificar el contratista asociado al acta ' ||
                           NUCERTIFICATEID;
                ut_trace.trace('Error ejecutando
                            SELECT gc.id_contratista,
                                   gco.nombre_contratista
                            FROM   ge_acta        ga,
                                   ge_contrato    gc,
                                   ge_contratista gco
                            WHERE  ga.id_acta = ' || nuCertificateId || '
                            AND    ga.id_contrato = gc.id_contrato
                            AND    gc.id_contratista = gco.id_contratista;',
                               10);
                RAISE exError;
        END;

        -- Si la factura ya se le aplicó al mismo contratista
        nuPaso := 50;
        ut_trace.trace('Si la factura ya se le aplicó al mismo contratista', 10);
        BEGIN
            SELECT ga.id_acta
            INTO   nuActaConFactIngresada
            FROM   ge_acta     ga,
                   ge_contrato gc
            WHERE  gc.id_contratista = nuContratista
            AND    ga.extern_invoice_num = SBEXTERN_INVOICE_NUM
            AND    ga.id_contrato = gc.id_contrato;
        EXCEPTION
            WHEN too_many_rows THEN
                sbError := 'El contratista ' || nuContratista || ' - ' || sbNombreContratista ||
                           ' ya tiene varias actas pagadas con el número de factura ' ||
                           SBEXTERN_INVOICE_NUM;
                ut_trace.trace('  SELECT ga.id_acta
            FROM   ge_acta     ga,
                   ge_contrato gc
            WHERE  gc.id_contratista = ' || nuContratista || '
            AND    ga.extern_invoice_num = ' || SBEXTERN_INVOICE_NUM || '
            AND    ga.id_contrato = gc.id_contrato;',
                               10);

                RAISE exError;
            WHEN OTHERS THEN
                nuActaConFactIngresada := NULL;
        END;

        -- Si ya está registrada la factura en otro lugar, sacar error
        nuPaso := 60;
        ut_trace.trace('Marcar como que no se debe pagar la factura', 10);
        IF nuActaConFactIngresada IS NOT NULL THEN
            sbError := 'El contratista ' || nuContratista || ' - ' || sbNombreContratista ||
                       ' tiene el acta ' || nuActaConFactIngresada ||
                       ' pagada con el número de factura ' || SBEXTERN_INVOICE_NUM;
            RAISE exError;
        END IF;

    END IF;


    -- Si no aplica a la gasera
    CT_BOExternalServices.UpdFwCertificateToPaid;

    ldc_pkldccfa.procorrijeinfoacta(inuacta => nuCertificateId, isbfactura => SBEXTERN_INVOICE_NUM);

    COMMIT;

    ut_trace.trace('Fin ' || sbPrograma, 10);

EXCEPTION
    WHEN exError THEN
        ut_trace.trace('Error en - ' || sbPrograma || ' ejecutando el paso ' || nuPaso, 10);
        ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, sbError);

END ldc_proRegistraPagoActa;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_PROREGISTRAPAGOACTA', 'ADM_PERSON');
END;
/
