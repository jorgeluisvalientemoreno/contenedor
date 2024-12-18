CREATE OR REPLACE PACKAGE adm_person.ldc_pkldccfa IS
/***************************************************************************
   Historia de Modificaciones
   Autor       Fecha        Descripcion.
   Adrianavg   26/06/2024   OSF-2883: Migrar del esquema OPEN al esquema ADM_PERSON
   ***************************************************************************/
    PROCEDURE proCorrijeInfoActa(inuActa    ge_acta.id_acta%TYPE, -- Código del acta
                                 isbFactura ge_acta.extern_invoice_num%TYPE -- Factura
                                 );

    PROCEDURE Process;

END ldc_pkLDCCFA;
/
CREATE OR REPLACE PACKAGE BODY adm_person.ldc_pkLDCCFA IS
    csbEntrega200405 VARCHAR2(100) := 'BSS_CON_SMS_200405_1';
    cnuError         NUMBER := 2741; -- Código del mensaje de error

    PROCEDURE proCorrijeInfoActa(inuActa    ge_acta.id_acta%TYPE, -- Código del acta
                                 isbFactura ge_acta.extern_invoice_num%TYPE -- Factura
                                 )

     IS

        /***********************************************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proCorrijeInfoActa
        Descripción:        Elimina caracteres especiales en el número de una factura y exige el
                            número de una factura

        Autor    : Sandra Muñoz
        Fecha    : 28-07-2016 CA-200-405

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificación
        -----------  -------------------    ------------------------------------------------------------
        28-07-2016   Sandra Muñoz           Creación
        ***********************************************************************************************/

    BEGIN

        IF fblaplicaentrega(csbEntrega200405) THEN

            -- Evalúa que el número de la factura no venga vacío
            IF isbFactura IS NULL THEN
                Errors.SetError(cnuError, 'Se requiere el número de la factura');
                RAISE ex.CONTROLLED_ERROR;
            END IF;

            -- Actualiza el número de la factura
            BEGIN
                dage_acta.updextern_invoice_num(inuid_acta             => inuActa,
                                                isbextern_invoice_num$ => TRIM(isbFactura));
            EXCEPTION
                WHEN OTHERS THEN
                    Errors.SetError(cnuError,
                                    'Se presentó un error al intentar actualizar el número de la factura ' ||
                                    isbFactura || ' en el acta ' || inuActa || '. sqlerrm');
                    RAISE ex.CONTROLLED_ERROR;
            END;

        END IF;

    EXCEPTION
        WHEN ex.CONTROLLED_ERROR THEN
            RAISE;

        WHEN OTHERS THEN
            Errors.setError;
            RAISE ex.CONTROLLED_ERROR;
    END;

    PROCEDURE Process IS
        /***********************************************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: Process
        Descripción:        Procesa la forma LDCCFA

        Autor    : Sandra Muñoz
        Fecha    : 28-07-2016 CA-200-405

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificación
        -----------  -------------------    ------------------------------------------------------------
        28-07-2016   Sandra Muñoz           Creación
        ***********************************************************************************************/

        sbID_CONSECUTIVO     ge_boInstanceControl.stysbValue;
        sbEXTERN_INVOICE_NUM ge_boInstanceControl.stysbValue;
        dtFechaPago          ge_acta.extern_pay_date%TYPE; -- Fecha de pago
        sbFacturaAntes       ge_acta.extern_invoice_num%TYPE; -- Fecha de pago

    BEGIN

        -- No permite el procesamiento si la entrega no está aplicada
        IF NOT fblaplicaentrega(csbEntrega200405) THEN
            Errors.SetError(cnuError,
                            'La entrega ' || csbEntrega200405 ||
                            ' no se encuentra aplicada, por tanto no se puede procesar la información');
            RAISE ex.CONTROLLED_ERROR;
        END IF;

        -- Leer la información de la forma
        sbID_CONSECUTIVO     := ge_boInstanceControl.fsbGetFieldValue('GE_ACTA', 'ID_CONSECUTIVO');
        sbEXTERN_INVOICE_NUM := ge_boInstanceControl.fsbGetFieldValue('GE_ACTA',
                                                                      'EXTERN_INVOICE_NUM');

        -- Verificar que el acta ya esté pagada
        BEGIN
            SELECT ga.extern_pay_date,
                   ga.extern_invoice_num
            INTO   dtFechaPago,
                   sbFacturaAntes
            FROM   ge_acta ga
            WHERE  ga.id_acta = to_number(sbID_CONSECUTIVO);
        EXCEPTION
            WHEN OTHERS THEN
                Errors.SetError(cnuError,
                                'No se puede determinar si el acta ' || sbID_CONSECUTIVO ||
                                ' está pagada. ' || SQLERRM);
                RAISE ex.CONTROLLED_ERROR;
        END;

        -- Verificar que el acta esté paga
        IF dtFechaPago IS NULL THEN
            Errors.SetError(cnuError, 'El acta ' || sbEXTERN_INVOICE_NUM || ' aún no está pagada');
            RAISE ex.CONTROLLED_ERROR;
        END IF;

        -- Almacena el dato de la factura sin espacios
        proCorrijeInfoActa(inuActa    => to_number(sbID_CONSECUTIVO),
                           isbFactura => sbEXTERN_INVOICE_NUM);

        -- Inserta en la tabla de auditoría el cambio realizado
        BEGIN
            INSERT INTO ldc_audit_cambio_fact_actas
                (usuario_modif,
                 fecha_hora_modif,
                 acta,
                 nro_factura_antes,
                 nro_factura_despues)
            VALUES
                (USER, --usuario_modif,
                 SYSDATE, --fecha_hora_modif,
                 to_number(sbID_CONSECUTIVO), --acta,
                 sbFacturaAntes, --nro_factura_antes,
                 TRIM(sbEXTERN_INVOICE_NUM) --nro_factura_despues
                 );
        EXCEPTION
            WHEN OTHERS THEN
                Errors.SetError(cnuError,
                                'No fue posible registrar el cambio en la tabla de auditoría: Usuario ' || USER ||
                                ', fecha_hora_modif ' ||
                                to_char(SYSDATE,
                                        'dd-mm-yyyy hh24:mi:ss' || ', acta ' || sbID_CONSECUTIVO ||
                                        ', anterior factura ' || sbFacturaAntes || ', nueva factura ' ||
                                        sbEXTERN_INVOICE_NUM || '. ' || SQLERRM));
                RAISE ex.CONTROLLED_ERROR;
        END;

        COMMIT;

    EXCEPTION
        WHEN ex.CONTROLLED_ERROR THEN
            RAISE;

        WHEN OTHERS THEN
            Errors.setError;
            RAISE ex.CONTROLLED_ERROR;
    END;

END LDC_PKLDCCFA;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre LDC_PKLDCCFA
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_PKLDCCFA', 'ADM_PERSON'); 
END;
/
