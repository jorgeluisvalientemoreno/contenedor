--GDC_BCSuspension_XNO_Cert

SELECT id_producto
    FROM
        (
            (
                (
                    (
                        SELECT /*+ index (a IDX_LDC_PLAZOS_CERT03) */
                                a.ID_PRODUCTO
                        FROM   ldc_plazos_cert a
                        WHERE  plazo_min_suspension <= SYSDATE + nvl(open.Dald_parameter.fnuGetNumeric_Value('NUM_DIAS_ANTICIPAR_NOTIFI_RP',NULL),0)
                        AND    is_notif IN ('YV', 'YR')
                        UNION
                        SELECT /*+ index (a IDX_LDC_MARCA_PRODUCTO02) */ a.id_producto
                        FROM   ldc_marca_producto a, ldc_plazos_cert    B
                        WHERE  fecha_ultima_actu <= (CASE WHEN a.medio_recepcion = 'E' THEN
                                                        SYSDATE - (open.Dald_parameter.fnuGetNumeric_Value('DIAS_SUSP_X_DEFECTO_OIA', NULL))  --open.Dald_parameter.fnuGetNumeric_Value('DIAS_SUSP_X_DEFECTO_OIA', NULL)
                                                     ELSE
                                                        SYSDATE - (open.Dald_parameter.fnuGetNumeric_Value('DIAS_SUSP_X_DEFECTO',NULL) +         -- open.Dald_parameter.fnuGetNumeric_Value('DIAS_SUSP_X_DEFECTO',NULL)
                                                                   open.Dald_parameter.fnuGetNumeric_Value('NUM_DIAS_NOTIFICAR_RP_REPA',NULL)
                                                                   )
                                       END)
                        AND    register_por_defecto = 'Y'
                        AND    is_notif IN ('YV', 'YR')
                        AND    a.id_producto = b.id_producto
                    )
                    INTERSECT
                        SELECT mo.PRODUCT_ID
                        FROM   mo_packages m, mo_motive mo, or_order_activity oa, or_order o
                        WHERE  m.package_id = oa.package_id
                        AND    m.PACKAGE_ID = mo.package_id
                        AND    oa.order_id = o.order_id
                        AND    m.PACKAGE_TYPE_ID = 100246   -- Notificacion Suspension x Ausencia de Certificado
                        AND    o.task_type_id = 10450       -- Suspension desde cm revisiones periodicas
                        AND    o.order_status_id = 20       -- Planeada
                )
                UNION
                (
                    (
                        SELECT /*+ index (a IDX_LDC_PLAZOS_CERT03) */
                                a.id_producto
                        FROM   ldc_plazos_cert a
                        WHERE  plazo_min_suspension <= SYSDATE +  nvl(Dald_parameter.fnuGetNumeric_Value('NUM_DIAS_ANTICIPAR_NOTIFI_RP',NULL),0)
                        AND    is_notif IN ('YV', 'YR')
                        UNION
                        SELECT /*+ index (a IDX_LDC_MARCA_PRODUCTO02) */
                                a.id_producto
                        FROM   ldc_marca_producto a, ldc_plazos_cert    B
                        WHERE  fecha_ultima_actu <= (CASE WHEN a.medio_recepcion = 'E' THEN
                                                            SYSDATE - (Dald_parameter.fnuGetNumeric_Value('DIAS_SUSP_X_DEFECTO_OIA', NULL)) -- Dald_parameter.fnuGetNumeric_Value('DIAS_SUSP_X_DEFECTO_OIA', NULL)
                                                        ELSE
                                                            SYSDATE - (Dald_parameter.fnuGetNumeric_Value('DIAS_SUSP_X_DEFECTO',NULL)
                                                                            +
                                                                      Dald_parameter.fnuGetNumeric_Value('NUM_DIAS_NOTIFICAR_RP_REPA',NULL)) -- Dald_parameter.fnuGetNumeric_Value('NUM_DIAS_NOTIFICAR_RP_REPA',NULL)
                                                     END)
                        AND    REGISTER_POR_DEFECTO = 'Y'
                        AND    is_notif IN ('YV', 'YR')
                        AND    a.id_producto = b.id_producto
            )
            MINUS
                        SELECT PRODUCT_ID
                        FROM   mo_packages m, ps_motive_status c, mo_motive x
                        WHERE  m.PACKAGE_TYPE_ID IN
                           (SELECT to_number(column_value)
                            FROM   TABLE(ldc_boutilities.SPLITstrings(dald_parameter.fsbGetValue_Chain('COD_PKG_TYPE_ID_FILTRO'),
                                                                      ',')))
                        --InStr(isbCOD_PKG_TYPE_ID_FILTRO_SUSP, ','||m.package_type_id||',') > 0   -- 265,266,100270,100156,100246,100153,100014,100237,100013,100294,100295,100321,100293
                        AND    c.MOTIVE_STATUS_ID = m.MOTIVE_STATUS_ID
                        AND    c.MOTI_STATUS_TYPE_ID = 2                -- Estado paquete
                        AND    c.MOTIVE_STATUS_ID NOT IN (14, 32, 51)   -- 14-Atendido 32-Anulado 51-Cancelada
                        AND    x.PACKAGE_ID = m.PACKAGE_ID
          )
                UNION
                (
                    SELECT /*+ index (a IDX_LDC_PLAZOS_CERT01) */
                           a.ID_PRODUCTO
                    FROM   ldc_plazos_cert a
                    WHERE  plazo_min_suspension <= sysdate + nvl(open.Dald_parameter.fnuGetNumeric_Value('NUM_DIAS_ANTICIPAR_NOTIFI_RP',NULL),0)
                    AND    is_notif in ('YV', 'YR')
                    INTERSECT
                    SELECT product_id
                    FROM  or_order_activity oa, or_order o
                    WHERE oa.order_id = o.order_id
                    AND   o.task_type_id = 10445    -- Visita validacion de trabajos reparacion
                    AND   o.order_status_id = 11    -- Bloqueada
                )
            )
            MINUS
                (
                    SELECT PRODUCT_ID
                    FROM   pr_prod_suspension
                    WHERE  suspension_type_id IN (101, 102, 103, 104)
                    AND   active = 'Y'
                )
            --Inicio CASO 383
            MINUS
                (
                    SELECT ID_PRODUCTO
                    FROM PLAZOS_CERT_PREV_COVID19
                    WHERE trunc(sysdate) < trunc(FECHA_EXCLUSI)
                )
            --Fin CASO 383
            --Inicio  OSF-582
            MINUS(
                    SELECT ab.PRODUCT_ID
                    FROM pr_product ab
                    WHERE ab.PRODUCT_STATUS_ID in (3,16)
                 )
            --Fin OSF-582
        )
    WHERE --mod (id_producto, inuThreadsQuantity) + 1 = inuThreadNumber
      --inicio ca 337
    /*and*/ LDC_PKGESTPREXCLURP.FUNVALEXCLURP(id_producto) = 0
    and     id_producto in (1022572);
