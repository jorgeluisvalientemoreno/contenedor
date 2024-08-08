
CREATE OR REPLACE PACKAGE BODY TT_BCFAULT IS
   CSBVERSION CONSTANT VARCHAR2( 10 ) := 'SAO190508';
   FUNCTION FSBVERSION
    RETURN VARCHAR2
    IS
    BEGIN
      RETURN CSBVERSION;
   END;
   PROCEDURE GETFAULTORDERS( INUFAULTID IN TT_DAMAGE.PACKAGE_ID%TYPE, ORFORDERS OUT CONSTANTS.TYREFCURSOR )
    IS
    BEGIN
      OPEN ORFORDERS FOR SELECT
                /*+ leading(or_order_activity)
                    use_nl(or_order_activity or_order)
                    use_nl(or_order or_task_type)
                    use_nl(or_order or_order_status) */
                DISTINCT
                or_order.order_id nuOrderId,
                or_task_type.task_type_id ||' - '|| or_task_type.description sbTaskType,
                (SELECT or_operating_unit.operating_unit_id ||' - '|| or_operating_unit.name
                 FROM  OR_operating_unit
                 WHERE OR_operating_unit.operating_unit_id = or_order.operating_unit_id) sbWorkUnit,
                or_order_status.order_status_id ||' - '|| or_order_status.description sbOrderStatus,
                or_order.priority nuPriority,
                or_order.created_date dtRegisterdate,
                or_order.legalization_date dtLegalizationDate
            FROM or_order_activity,
                 or_order,
                 or_task_type,
                 or_order_status
                 /*+ TT_BCFault.GetFaultOrders SAO183883 */
            WHERE or_order_activity.package_id = inuFaultId
              AND or_order_activity.order_id = or_order.order_id
              AND or_order.task_type_id = or_task_type.task_type_id
              AND or_order.order_status_id = or_order_status.order_status_id
            UNION ALL
            SELECT
                /*+ leading(tt_damage)
                    index(tt_damage PK_TT_DAMAGE)
                    use_nl(tt_damage or_order_activity)
                    use_nl(or_order_activity or_order)
                    use_nl(or_order or_task_type)
                    use_nl(or_order or_order_status) */
                or_order.order_id nuOrderId,
                or_task_type.task_type_id ||' - '|| or_task_type.description sbTaskType,
                (SELECT or_operating_unit.operating_unit_id ||' - '|| or_operating_unit.name
                 FROM  OR_operating_unit
                 WHERE OR_operating_unit.operating_unit_id = or_order.operating_unit_id) sbWorkUnit,
                or_order_status.order_status_id ||' - '|| or_order_status.description sbOrderStatus,
                or_order.priority nuPriority,
                or_order.created_date dtRegisterdate,
                or_order.legalization_date dtLegalizationDate
            FROM tt_damage,
                 or_order_activity,
                 or_order,
                 or_task_type,
                 or_order_status
                 /*+ TT_BCFault.GetFaultOrders SAO183883 */
            WHERE tt_damage.package_id = inuFaultId
              AND tt_damage.order_activity_id = or_order_activity.order_activity_id
              AND or_order_activity.order_id = or_order.order_id
              AND or_order.task_type_id = or_task_type.task_type_id
              AND or_order.order_status_id = or_order_status.order_status_id;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END GETFAULTORDERS;
   PROCEDURE GETCONTROLFAULTS( INUPRODUCTID IN PR_PRODUCT.PRODUCT_ID%TYPE, IDTINITIALDATE IN MO_PACKAGES.REQUEST_DATE%TYPE, OTBFAULTS OUT NOCOPY DATT_DAMAGE.TYTBPACKAGE_ID )
    IS
      CURSOR CUOPENOUTAGE IS
SELECT /*+ leading(tt_damage_product)
                       use_nl(tt_damage_product mo_packages)
                       use_nl(mo_packages tt_damage) */
                   tt_damage.package_id
            FROM   tt_damage,
                   mo_packages
                   /*+ TT_BCFault.GetControlFaults SAO186582 */
            WHERE  tt_damage.package_id = mo_packages.package_id
              -- Sea una interrupcion controlada
              AND  tt_damage.reg_damage_type_id = TT_BCConstants.cnuCONTROL_FAULT_TYPE
              -- La fecha de registro sea mayor o igual a la fecha de la falla
              AND  idtInitialDate >= nvl(tt_damage.initial_date,
                                         idtInitialDate)
              -- La falla este activa
              AND  mo_packages.motive_status_id NOT IN (tt_bcconstants.cnuTTAttenStatus,
                                                        tt_bcconstants.cnuTTUnfoundedStatus)
              AND  EXISTS (-- El producto este en la falla
                           SELECT /*+ INDEX(tt_damage_product IDX_TT_DAMAGE_PRODUCT_02) */
                                  'X'
                           FROM   tt_damage_product
                           WHERE tt_damage_product.product_id = inuProductId
                             AND tt_damage_product.package_id = mo_packages.package_id
                             AND tt_damage_product.damage_produ_status = tt_bcconstants.csbOpenDamageStatus);
    BEGIN
      OPEN CUOPENOUTAGE;
      FETCH CUOPENOUTAGE
         BULK COLLECT INTO OTBFAULTS;
      CLOSE CUOPENOUTAGE;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         IF ( CUOPENOUTAGE%ISOPEN ) THEN
            CLOSE CUOPENOUTAGE;
         END IF;
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         IF ( CUOPENOUTAGE%ISOPEN ) THEN
            CLOSE CUOPENOUTAGE;
         END IF;
         RAISE EX.CONTROLLED_ERROR;
   END GETCONTROLFAULTS;
   PROCEDURE GETFAULTS( INUPRODUCTID IN PR_PRODUCT.PRODUCT_ID%TYPE, IDTINITIALDATE IN MO_PACKAGES.REQUEST_DATE%TYPE, INUCAUSALID IN CC_CAUSAL.CAUSAL_ID%TYPE, OTBFAULTS OUT NOCOPY DATT_DAMAGE.TYTBPACKAGE_ID )
    IS
      CURSOR CUOPENFAULTS IS
SELECT /*+ leading(tt_damage_product)
                       use_nl(tt_damage_product mo_packages)
                       use_nl(mo_packages tt_damage) */
                   tt_damage.package_id
            FROM   tt_damage,
                   mo_packages
                   /*+ TT_BCFault.GetFaults SAO190508 */
            WHERE  tt_damage.package_id = mo_packages.package_id
              -- La fecha de registro sea mayor o igual a la fecha de la falla
              AND  idtInitialDate >= nvl(tt_damage.initial_date,
                                         idtInitialDate)
              -- Sea una interrupcion de servicio
              AND tt_damage.element_id IS NULL
              -- La falla este activa
              AND  mo_packages.motive_status_id NOT IN (tt_bcconstants.cnuTTAttenStatus,
                                                        tt_bcconstants.cnuTTUnfoundedStatus)
              AND  EXISTS (-- El tipo de falla absorbe la causal de la queja
                           SELECT /*+ INDEX(cc_caus_dama_type_rela IDX_CC_CAUS_DAMA_TYPE_RELA01) */
                                 'X'
                           FROM  cc_caus_dama_type_rela
                           WHERE cc_caus_dama_type_rela.damage_type_id = nvl(tt_damage.final_damage_type_id,
                                                                            tt_damage.reg_damage_type_id)
                            AND cc_caus_dama_type_rela.causal_id = inuCausalId)
              AND  EXISTS (-- El producto este en la falla
                           SELECT /*+ INDEX(tt_damage_product IDX_TT_DAMAGE_PRODUCT_02) */
                                  'X'
                           FROM   tt_damage_product
                           WHERE tt_damage_product.product_id = inuProductId
                             AND tt_damage_product.package_id = mo_packages.package_id
                             AND tt_damage_product.damage_produ_status = tt_bcconstants.csbOpenDamageStatus);
    BEGIN
      OPEN CUOPENFAULTS;
      FETCH CUOPENFAULTS
         BULK COLLECT INTO OTBFAULTS;
      CLOSE CUOPENFAULTS;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         IF ( CUOPENFAULTS%ISOPEN ) THEN
            CLOSE CUOPENFAULTS;
         END IF;
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         IF ( CUOPENFAULTS%ISOPEN ) THEN
            CLOSE CUOPENFAULTS;
         END IF;
         RAISE EX.CONTROLLED_ERROR;
   END GETFAULTS;
   FUNCTION FBLISABSORBED( INUFAULTID IN TT_DAMAGE.PACKAGE_ID%TYPE )
    RETURN BOOLEAN
    IS
      CURSOR CUISABSORBED IS
SELECT  /*+ ordered use_nl(MO_PACKAGES_ASSO MO_PACKAGES)
                    index(MO_PACKAGES_ASSO IDX_MO_PACKAGES_ASSO_04)
                    index(MO_PACKAGES PK_MO_PACKAGES)*/
                mo_packages_asso.*
        FROM    mo_packages_asso,
                mo_packages
                /*+ Ubicacion: TT_BCFault.cuIsAbsorbed SAO183880 */
        WHERE   mo_packages.package_type_id = /* 59 --*/tt_bcconstants.cnuMassDamage
        AND     mo_packages.package_id = mo_packages_asso.package_id_asso
        AND     mo_packages_asso.package_id = inuFaultId;
    BEGIN
      UT_TRACE.TRACE( 'Inicia TT_BCFault.fblIsAbsorbed [' || INUFAULTID || ']', 15 );
      FOR RCROW IN CUISABSORBED
       LOOP
         UT_TRACE.TRACE( 'Finaliza TT_BCFault.fblIsAbsorbed [TRUE]', 15 );
         RETURN TRUE;
      END LOOP;
      UT_TRACE.TRACE( 'Finaliza TT_BCFault.fblIsAbsorbed [FALSE]', 15 );
      RETURN FALSE;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         UT_TRACE.TRACE( 'Error : ex.CONTROLLED_ERROR', 15 );
         RAISE;
      WHEN OTHERS THEN
         UT_TRACE.TRACE( 'Error : others', 15 );
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END;
END TT_BCFAULT;
/


