 --GDC_BCSuspension_XNO_Cert
 
 SELECT id_producto
    FROM  (
            (
                (
                    SELECT /*+ index (a IDX_LDC_PLAZOS_CERT03) */
                            a.ID_PRODUCTO
                    FROM   ldc_plazos_cert a
                    WHERE  plazo_min_suspension <= SYSDATE + nvl(Dald_parameter.fnuGetNumeric_Value('NUM_DIAS_ANTICIPAR_NOTIFI_RP',NULL),0)
                    AND    (is_notif NOT IN ('YV', 'YR') OR is_notif IS NULL)
                    UNION
                    SELECT /*+ index (a IDX_LDC_MARCA_PRODUCTO02) */
                            a.ID_PRODUCTO
                    FROM   ldc_marca_producto a, ldc_plazos_cert    B
                    WHERE  fecha_ultima_actu <= SYSDATE - Dald_parameter.fnuGetNumeric_Value('DIAS_SUSP_X_DEFECTO',NULL)
                    AND    REGISTER_POR_DEFECTO = 'Y'
                    AND    (is_notif NOT IN ('YV', 'YR') OR is_notif IS NULL)
                    AND    a.id_producto = b.id_producto
                )
                MINUS
                (
                    /* caso: 767
          SELECT PRODUCT_ID
                    FROM   pr_prod_suspension
                    WHERE  suspension_type_id IN (101, 102, 103, 104)
                    AND    active = 'Y'
                    UNION*/
                    SELECT PRODUCT_ID
                    FROM   mo_packages m, ps_motive_status c, mo_motive x
                    WHERE  m.PACKAGE_TYPE_ID IN
                           (SELECT to_number(column_value)
                            FROM   TABLE(ldc_boutilities.SPLITstrings(dald_parameter.fsbGetValue_Chain('COD_PKG_TYPE_ID_FILTRO'),
                                                                      ',')))
                    --InStr(isbCOD_PKG_TYPE_ID_FILTRO_SUSP, ','||m.package_type_id||',') > 0   -- 265,266,100270,100156,100246,100153,100014,100237,100013,100294,100295,100321,100293
                    AND    c.MOTIVE_STATUS_ID = m.MOTIVE_STATUS_ID
                    AND    c.MOTI_STATUS_TYPE_ID = 2
                    AND    c.MOTIVE_STATUS_ID NOT IN (14, 32, 51)
                    AND    x.PACKAGE_ID = m.PACKAGE_ID
                )
            )
            UNION
            (
                (
                    SELECT /*+ index (a IDX_LDC_PLAZOS_CERT03) */
                            a.ID_PRODUCTO
                    FROM   ldc_plazos_cert a
                    WHERE  plazo_min_suspension <= sysdate + nvl(Dald_parameter.fnuGetNumeric_Value('NUM_DIAS_ANTICIPAR_NOTIFI_RP',NULL),0)
                    AND    is_notif in ('YV', 'YR')
                    INTERSECT
                    SELECT PRODUCT_ID
                       FROM or_order_activity oa, or_order o
                      WHERE oa.order_id = o.order_id
                        AND o.task_type_id = 10445
                        AND o.order_status_id = 11
                )
                /* caso: 767
        MINUS
                    SELECT PRODUCT_ID
                    FROM  pr_prod_suspension
                    WHERE suspension_type_id in (101, 102, 103, 104)
                    AND   active = 'Y'*/
            )
        --Inicio CASO 383
        --Inicio ca 472 se quita tabla PLAZOS_CERT_PREV_COVID19
        /*MINUS
            (
                SELECT ID_PRODUCTO
                FROM PLAZOS_CERT_PREV_COVID19
                WHERE trunc(sysdate) < trunc(FECHA_EXCLUSI)
            )*/
        --Inicio CASO 383
        --Inicio  OSF-582
        MINUS(
                SELECT ab.PRODUCT_ID
                FROM pr_product ab
                WHERE ab.PRODUCT_STATUS_ID in (3,16)
             )
        --Fin OSF-582
        )
        where id_producto in (14521693)
        
        --mod (id_producto, inuThreadsQuantity) + 1 = inuThreadNumber;
