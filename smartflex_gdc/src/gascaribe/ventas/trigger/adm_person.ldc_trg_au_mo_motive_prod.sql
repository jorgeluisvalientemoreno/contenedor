CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRG_AU_MO_MOTIVE_PROD
    FOR UPDATE OF PRODUCT_ID ON MO_MOTIVE
    COMPOUND TRIGGER
    /*****************************************************************
    Propiedad intelectual de Gascaribe-Efigas.

    Unidad         : LDC_TRG_AU_MO_MOTIVE_PROD
    Descripcion    : Trigger para actualizar el código del producto en la orden
                     de verificación de cliente especial, para los trámites de
                     venta de gas cotizada.
    Autor          : KCienfuegos
    Fecha          : 28-12-2016
    Caso           : CA200-535

    Parametros           Descripcion
    ============         ===================

    Historia de Modificaciones
    Fecha         Autor                         Modificacion
    ===============================================================
    28-12-2016    KCienfuegos.CA200-535         Creacion.
    ******************************************************************/
      nuTipoSolVtaCot          ps_package_type.package_type_id%TYPE := dald_parameter.fnuGetNumeric_Value('COD_VENTA_COTIZADA',0);
      nuActividadClient        or_order_activity.activity_id%TYPE := dald_parameter.fnuGetNumeric_Value('ACT_VERIF_CLIENTE_ESP',0);

    AFTER EACH ROW IS
      nuSolicitud              mo_packages.package_id%TYPE;
      nuMotivo                 mo_motive.motive_id%TYPE;
      nuProducto               pr_product.product_id%TYPE;
      nuTipoSol                ps_package_type.package_type_id%TYPE;

    BEGIN
        dbms_output.put_line('Inicia AFTER EACH ROW LDC_TRG_AU_MO_MOTIVE_PROD');

        IF(fblaplicaentrega(ldc_bccotizacioncomercial.csbentrega))THEN

          nuMotivo := :old.motive_id;

          dbms_output.put_line('motive_id: '||nuMotivo);

          nuSolicitud := :old.package_id;

          dbms_output.put_line('nuSolicitud: '||nuSolicitud);

          nuTipoSol := damo_packages.fnugetpackage_type_id(nuSolicitud, 0);

          IF(nvl(nuTipoSol,-1) = nuTipoSolVtaCot)THEN

            dbms_output.put_line('nuTipoSol: '||nuTipoSol);

            IF (:new.product_id IS NOT NULL)THEN

              dbms_output.put_line('product_id: '||:new.product_id);

              BEGIN
                UPDATE or_order_activity oa
                   SET oa.product_id = :new.product_id
                 WHERE oa.package_id = nuSolicitud
                   AND oa.subscription_id = :old.subscription_id
                   AND oa.activity_id = nuActividadClient
                   AND oa.product_id IS NULL;
              EXCEPTION
                WHEN OTHERS THEN
                  NULL;
              END;

            END IF;

          END IF;
        END IF;

        UT_Trace.Trace('Finaliza AFTER EACH ROW LDC_TRG_AU_MO_MOTIVE_PROD',10);
    EXCEPTION
        WHEN ex.CONTROLLED_ERROR THEN
              RAISE;
          WHEN OTHERS THEN
              Errors.setError;
              RAISE ex.CONTROLLED_ERROR;
    END AFTER EACH ROW;

END LDC_TRG_AU_MO_MOTIVE_PROD;
/
