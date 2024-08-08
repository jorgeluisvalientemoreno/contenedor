----LDC_BOASIGAUTO.PRASIGNACION
select a.package_type_id,
       s.description,
       t.package_type_oper_unit_id,
       t.operating_unit_id,
       u.name,
       t.task_type_id,
       t.items_id,
       i.description,
       t.procesopre,
       t.procesopost,
       t.catecodi
  from open.ldc_package_type_assign a
 inner join open.ps_package_type  s on a.package_type_id = s.package_type_id
 inner join open.ldc_package_type_oper_unit  t on a.package_type_assign_id = t.package_type_assign_id
 inner join open.ge_items  i on t.items_id = i.items_id
 inner join open.or_operating_unit  u  on t.operating_unit_id = u.operating_unit_id
;

--LDC_BOASIGAUTO.PRASIGNACION
SELECT LPTOU.OPERATING_UNIT_ID,
             LPTOU.PROCESOPRE,
             LPTOU.PROCESOPOST,
             LPTOU.CATECODI,
             LPTOU.ITEMS_ID,
             OOA.PRODUCT_ID,
             OOA.ADDRESS_ID,
             OOA.ACTIVITY_ID,
             OOA.SUBSCRIPTION_ID
        FROM LDC_PACKAGE_TYPE_OPER_UNIT LPTOU,
             LDC_PACKAGE_TYPE_ASSIGN    LPTA,
             OR_ORDER_ACTIVITY          OOA,
             PR_PRODUCT P
       WHERE OOA.ORDER_ID = &NUORDER_ID
         AND OOA.PRODUCT_ID = P.PRODUCT_ID
         AND LPTOU.CATECODI IN (p.CATEGORY_ID,-1)
         AND NVL(OOA.PACKAGE_ID, 0) = NVL(&NUPACKAGE_ID, 0)
         AND LPTOU.ITEMS_ID = OOA.ACTIVITY_ID
         AND LPTA.PACKAGE_TYPE_ASSIGN_ID = LPTOU.PACKAGE_TYPE_ASSIGN_ID
         AND LPTA.PACKAGE_TYPE_ID =
             DECODE(DAMO_PACKAGES.FNUGETPACKAGE_TYPE_ID(OOA.PACKAGE_ID,
                                                        NULL),
                    NULL,
                    -1,
                    DAMO_PACKAGES.FNUGETPACKAGE_TYPE_ID(OOA.PACKAGE_ID, NULL))
         AND LPTOU.OPERATING_UNIT_ID NOT IN
             (SELECT LC.OPERATING_UNIT_ID
                FROM LDC_CARUNIOPE LC
               WHERE LC.ACTIVO = 'N')
       ORDER BY dbms_random.value;
       
  alter session set current_schema="OPEN";
select *
from LDC_PACKAGE_TYPE_OPER_UNIT TITR, LDC_PACKAGE_TYPE_ASSIGN TISO, open.or_task_types_items ti
WHERE TITR.PACKAGE_TYPE_ASSIGN_ID=TISO.PACKAGE_TYPE_ASSIGN_ID
  AND package_type_id in (100156)
  and ti.items_id=titr.items_id
  and ti.task_type_id=12457;
  
  

SELECT LPTOU.OPERATING_UNIT_ID,
                   LPTOU.PROCESOPRE,
                   LPTOU.PROCESOPOST,
                   LPTOU.CATECODI,
                   LPTOU.ITEMS_ID,
                   OOA.PRODUCT_ID,
                   OOA.ADDRESS_ID,
                   OOA.ACTIVITY_ID,
                   OOA.SUBSCRIPTION_ID
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
            ORDER  BY dbms_random.value;
