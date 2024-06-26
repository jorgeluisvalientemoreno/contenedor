            SELECT LPTOU.OPERATING_UNIT_ID,
                   LPTOU.PROCESOPRE,
                   LPTOU.PROCESOPOST,
                   LPTOU.CATECODI,
                   LPTOU.ITEMS_ID,
                   OOA.PRODUCT_ID,
                   OOA.ADDRESS_ID,
                   OOA.ACTIVITY_ID,
                   OOA.SUBSCRIPTION_ID,
                   ooa.product_id,
                   (SELECT NVL(OOU.OPERATING_ZONE_ID, 0)
                      FROM OR_OPERATING_UNIT OOU
                     WHERE OOU.OPERATING_UNIT_ID = LPTOU.OPERATING_UNIT_ID) ZONA_UNIDAD_OPERATIVA,

                  decode(&sbBLBSS_FACT_LJLB_0000158,'S',
                         LDC_BOASIGAUTO.FNUGETCATE(ooa.subscription_id, ooa.product_id, ooa.task_type_id, ooa.address_id),
                   (SELECT PP.CATEGORY_ID
                      FROM   PR_PRODUCT PP
                      WHERE  PP.PRODUCT_ID = DECODE(OOA.PRODUCT_ID,
                                                    NULL,
                                                    (SELECT PP.PRODUCT_ID
                                                     FROM   PR_PRODUCT PP
                                                     WHERE  PP.ADDRESS_ID = OOA.ADDRESS_ID
                                                     AND    ROWNUM = 1),
                                                    OOA.PRODUCT_ID)
                      AND    PP.PRODUCT_TYPE_ID IN
                             (SELECT TO_NUMBER(column_value)
                               FROM   TABLE(ldc_boutilities.splitstrings(&SBCOD_TIPO_SOL_ASIG,
                                                                         ',')))
                      AND    ROWNUM = 1)) CATEGORY_ID


            FROM   LDC_PACKAGE_TYPE_OPER_UNIT LPTOU,
                   LDC_PACKAGE_TYPE_ASSIGN    LPTA,
                   OR_ORDER_ACTIVITY          OOA
            WHERE  OOA.ORDER_ID = &NUORDER_ID
            AND    NVL(OOA.PACKAGE_ID, 0) = NVL(&NUPACKAGE_ID, 0)
            AND    LPTOU.ITEMS_ID = OOA.ACTIVITY_ID
            AND    LPTA.PACKAGE_TYPE_ASSIGN_ID = LPTOU.PACKAGE_TYPE_ASSIGN_ID
            AND    LPTA.PACKAGE_TYPE_ID =
                   DECODE(DAMO_PACKAGES.FNUGETPACKAGE_TYPE_ID(OOA.PACKAGE_ID, NULL),
                           NULL,
                           -1,
                           DAMO_PACKAGES.FNUGETPACKAGE_TYPE_ID(OOA.PACKAGE_ID, NULL))
            AND    LPTOU.OPERATING_UNIT_ID NOT IN
                   (SELECT LC.OPERATING_UNIT_ID FROM LDC_CARUNIOPE LC WHERE LC.ACTIVO = 'N')
            ORDER  BY dbms_random.value
            ;
