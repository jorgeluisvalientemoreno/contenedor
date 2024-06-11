CREATE OR REPLACE PACKAGE TT_BCDAMAGE IS
   CURSOR CUREPAIRELAPSEDTIME( INUPRODUCTID IN PR_PRODUCT.PRODUCT_ID%TYPE ) IS
SELECT  /*+ ordered
                use_nl(OR_ORDER_ACTIVITY GE_ITEMS OR_ORDER_ITEMS OR_ORDER)
                index(OR_ORDER_ACTIVITY IDX_OR_ORDER_ACTIVITY_010)
                index(GE_ITEMS PK_GE_ITEMS)
                index(OR_ORDER_ITEMS IDX_OR_ORDER_ITEMS_03)
                index(OR_ORDER PK_ORDER)
            */
            max(OR_order.execution_final_date) execution_final_date
    FROM    or_order_activity,
            ge_items,
            or_order_items,
            OR_order
    WHERE   OR_order.execution_final_date IS not null
    AND     OR_order.order_id = or_order_activity.order_id
    AND     or_order_items.legal_item_amount > 0
    AND     or_order_items.order_activity_id = or_order_activity.order_activity_id
    AND     ge_items.use_ = /* 'CF' --*/or_boconstants.csbCLIENT_FIX
    AND     ge_items.items_id = or_order_activity.activity_id
    AND     or_order_activity.product_id = inuProductId;
   CURSOR CUGETDAMAGEASSO( INUPACKAGEID IN MO_PACKAGES.PACKAGE_ID%TYPE ) IS
SELECT  /*+ ordered */
            mo_packages_asso.*
    FROM    mo_packages_asso,
            mo_packages
    WHERE   mo_packages.package_type_id in
            (   tt_boconstants.cnuIndDamage,
                tt_boconstants.cnuMassDamage
            )
    AND     mo_packages_asso.package_id_asso = mo_packages.package_id
    AND     mo_packages_asso.package_id = inuPackageId;
   CURSOR CUALLREGPRODUCTDAMAGE( INUPRODUCTID IN MO_MOTIVE.PRODUCT_ID%TYPE, IDTINITIALDATE IN TT_DAMAGE.INITIAL_DATE%TYPE ) IS
SELECT  /*+ index(mo_packages PK_MO_PACKAGES) index(tt_damage PK_TT_DAMAGE) */
                mo_packages.package_id,
               nvl(tt_damage.final_damage_type_id,
               tt_damage.reg_damage_type_id) damage_type_id,
               mo_packages.request_date
        FROM  mo_packages, tt_damage
        WHERE mo_packages.PACKAGE_type_id = tt_boconstants.cnuIndDamage
        AND   mo_packages.package_id = tt_damage.package_id
        AND   tt_damage.reg_damage_status = tt_boconstants.csbRegisteredDamageStatus
        AND   tt_damage.initial_date >= nvl(idtInitialDate, tt_damage.initial_date)
        AND EXISTS
        (
            SELECT  /*+ index(mo_motive IDX_MO_MOTIVE14) */
                    'x'
            FROM mo_motive
            WHERE mo_motive.product_id = inuProductId
            AND mo_motive.package_id = mo_packages.package_id
        );
   CURSOR CUREGPRODUCTDAMAGE( INUPRODUCTID IN MO_MOTIVE.PRODUCT_ID%TYPE, INUDAMAGETYPEID IN TT_DAMAGE_TYPE.DAMAGE_TYPE_ID%TYPE ) IS
SELECT  /*+ index(mo_packages PK_MO_PACKAGES) index(tt_damage PK_TT_DAMAGE) */
                mo_packages.package_id,
                nvl(tt_damage.final_damage_type_id, tt_damage.reg_damage_type_id) damage_type_id,
                mo_packages.request_date
        FROM    mo_packages,
                tt_damage,
                (
                    SELECT  tt_damag_type_relat.annul_damage_type_id
                    FROM    tt_damag_type_relat
                    WHERE   tt_damag_type_relat.damage_type_id = inuDamageTypeId
                ) DamageTypeAbsorb
        WHERE   DamageTypeAbsorb.annul_damage_type_id = nvl(tt_damage.final_damage_type_id, tt_damage.reg_damage_type_id)
        AND     mo_packages.package_type_id = tt_boconstants.cnuIndDamage
        AND     mo_packages.package_id = tt_damage.package_id
        AND     tt_damage.reg_damage_status = tt_boconstants.csbRegisteredDamageStatus
        AND EXISTS
        (
            SELECT /*+ index(mo_motive IDX_MO_MOTIVE14) */
                    'x'
            FROM mo_motive
            WHERE mo_motive.product_id = inuProductId
            AND mo_motive.package_id = mo_packages.package_id
        );
   CURSOR CUGETDAMAGESBYORDER( INUORDERID IN OR_ORDER_ACTIVITY.ORDER_ID%TYPE ) IS
SELECT distinct or_order_activity.package_id,
             mo_packages.package_type_id,
             tt_damage.initial_date,
             tt_damage.final_damage_type_id
        FROM mo_packages ,
             or_order_activity,
             ps_motive_status,
             tt_damage
       WHERE ps_motive_status.is_final_status = ge_boconstants.csbNO
         AND ps_motive_status.motive_status_id = mo_packages.motive_status_id
         AND mo_packages.package_type_id in (tt_boconstants.cnuIndDamage, tt_boconstants.cnuMassDamage)
         AND tt_damage.package_id = or_order_activity.package_id
         AND mo_packages.package_id = or_order_activity.package_id
         AND or_order_activity.status <> or_boconstants.csbFinishStatus
         AND or_order_activity.order_id = inuOrderId;
   FUNCTION FSBVERSION
    RETURN VARCHAR2;
   FUNCTION FNUGETDAMAGETYPE( NUPACKAGEID IN TT_DAMAGE.PACKAGE_ID%TYPE )
    RETURN TT_DAMAGE_TYPE.DAMAGE_TYPE_ID%TYPE;
   FUNCTION FTBGETASSOCELEMDAM( INUPACKAGEID IN TT_DAMAGE_ELEMENT.PACKAGE_ID%TYPE, ISBDAMAGESTAT IN TT_DAMAGE.REG_DAMAGE_STATUS%TYPE )
    RETURN DAMO_PACKAGES_ASSO.TYTBMO_PACKAGES_ASSO;
   PROCEDURE LASTDAMAGEDATE( INUPACKAGEID IN MO_PACKAGES.PACKAGE_ID%TYPE, ODTLASTDATE OUT TT_DAMAGE_PRODUCT.ATENTION_DATE%TYPE );
   PROCEDURE FIRSTDAMAGEDATE( INUPACKAGEID IN MO_PACKAGES.PACKAGE_ID%TYPE, ODTFIRSTDATE OUT TT_DAMAGE.INITIAL_DATE%TYPE );
END TT_BCDAMAGE;
/



CREATE OR REPLACE PACKAGE BODY TT_BCDAMAGE IS
   CSBVERSION CONSTANT VARCHAR2( 20 ) := 'SAO190573';
   CURSOR CUREPAIRDAMAGES( INUPACKAGEID IN MO_PACKAGES.PACKAGE_ID%TYPE ) IS
SELECT  /*+ ordered
                    index(OR_ORDER_ACTIVITY IDX_OR_ORDER_ACTIVITY_06)
                    index(OR_ORDER PK_OR_ORDER)
                    index(OR_TASK_TYPE PK_OR_TASK_TYPE)
                    index(OR_TASK_TYPES_ITEMS PK_OR_TASK_TYPES_ITEMS)
                    index(GE_ITEMS PK_GE_ITEMS)
                */
                or_order.order_id
        FROM    or_order_activity,
                or_order,
                or_task_type,
                or_task_types_items,
                ge_items
        WHERE   or_order_activity.package_id = inuPackageId
          AND   or_order.order_id = or_order_activity.order_id
          AND   or_task_type.task_type_id = or_order.task_type_id
          AND   or_task_types_items.task_type_id = or_task_type.task_type_id
          AND   ge_items.items_id = or_task_types_items.items_id
          AND   nvl(ge_items.use_, '-') NOT IN
          (
                OR_BOConstants.csbDiagnosticUse,
                OR_BOConstants.csbCLIENT_MAINTENA_USE
          )
          AND ROWNUM = 1;
   FUNCTION FSBVERSION
    RETURN VARCHAR2
    IS
    BEGIN
      RETURN CSBVERSION;
   END;
   FUNCTION FNUGETDAMAGETYPE( NUPACKAGEID IN TT_DAMAGE.PACKAGE_ID%TYPE )
    RETURN TT_DAMAGE_TYPE.DAMAGE_TYPE_ID%TYPE
    IS
      NUDAMAGETYPE TT_DAMAGE_TYPE.DAMAGE_TYPE_ID%TYPE;
      CURSOR CUDAMAGETYPE IS
SELECT nvl(tt_damage.final_damage_type_id,tt_damage.reg_damage_type_id) damage_type_id
              FROM tt_damage
             WHERE tt_damage.package_id = nuPackageId;
    BEGIN
      UT_TRACE.TRACE( '--[INICIO] TT_BCDamage.fnuGetDamageType(nuPackageId=' || NUPACKAGEID || ')', 15 );
      OPEN CUDAMAGETYPE;
      FETCH CUDAMAGETYPE
         INTO NUDAMAGETYPE;
      CLOSE CUDAMAGETYPE;
      UT_TRACE.TRACE( '--[FIN] TT_BCDamage.fnuGetDamageType -> ' || NUDAMAGETYPE, 15 );
      RETURN NUDAMAGETYPE;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END FNUGETDAMAGETYPE;
   FUNCTION FTBGETASSOCELEMDAM( INUPACKAGEID IN TT_DAMAGE_ELEMENT.PACKAGE_ID%TYPE, ISBDAMAGESTAT IN TT_DAMAGE.REG_DAMAGE_STATUS%TYPE )
    RETURN DAMO_PACKAGES_ASSO.TYTBMO_PACKAGES_ASSO
    IS
      TBDAMAGES DAMO_PACKAGES_ASSO.TYTBMO_PACKAGES_ASSO;
      CURSOR CUASSOCDAMAGES IS
SELECT mo_packages_asso.*, mo_packages_asso.rowid
        FROM   tt_damage, mo_packages_asso
        WHERE  mo_packages_asso.package_id_asso = inuPackageId
        AND    tt_damage.package_id = mo_packages_asso.package_id
        AND    tt_damage.reg_damage_status = isbDamageStat;
      PROCEDURE CLOSECURSORS
       IS
       BEGIN
         IF ( CUASSOCDAMAGES%ISOPEN ) THEN
            CLOSE CUASSOCDAMAGES;
         END IF;
      END CLOSECURSORS;
    BEGIN
      UT_TRACE.TRACE( 'BEGIN FUNCTION TT_BCDamage.ftbGetAssocElemDam [' || INUPACKAGEID || ']', 16 );
      CLOSECURSORS;
      OPEN CUASSOCDAMAGES;
      FETCH CUASSOCDAMAGES
         BULK COLLECT INTO TBDAMAGES;
      CLOSE CUASSOCDAMAGES;
      UT_TRACE.TRACE( 'END FUNCTION TT_BCDamage.ftbGetAssocElemDam [' || TBDAMAGES.COUNT || ']', 16 );
      RETURN TBDAMAGES;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         UT_TRACE.TRACE( 'EXCEPTION CONTROLLED_ERROR TT_BCDamage.ftbGetAssocElemDam', 1 );
         CLOSECURSORS;
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         UT_TRACE.TRACE( 'EXCEPTION OTHERS TT_BCDamage.ftbGetAssocElemDam', 1 );
         CLOSECURSORS;
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END FTBGETASSOCELEMDAM;
   PROCEDURE LASTDAMAGEDATE( INUPACKAGEID IN MO_PACKAGES.PACKAGE_ID%TYPE, ODTLASTDATE OUT TT_DAMAGE_PRODUCT.ATENTION_DATE%TYPE )
    IS
      CURSOR CULASTDAMAGEDATE IS
SELECT  max(initial_Date) Fecha
        FROM    mo_packages_asso, tt_damage
        WHERE   mo_packages_asso.package_id_asso = inuPackageId
        AND     tt_damage.package_id = mo_packages_asso.package_id;
    BEGIN
      UT_TRACE.TRACE( 'Inicia TT_BCDamage.LastDamageDate ...', 20 );
      IF ( CULASTDAMAGEDATE%ISOPEN ) THEN
         CLOSE CULASTDAMAGEDATE;
      END IF;
      OPEN CULASTDAMAGEDATE;
      FETCH CULASTDAMAGEDATE
         INTO ODTLASTDATE;
      CLOSE CULASTDAMAGEDATE;
      UT_TRACE.TRACE( 'Finaliza TT_BCDamage.LastDamageDate', 20 );
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         UT_TRACE.TRACE( 'EXCEPTION CONTROLLED_ERROR TT_BCDamage.LastDamageDate', 15 );
         IF ( CULASTDAMAGEDATE%ISOPEN ) THEN
            CLOSE CULASTDAMAGEDATE;
         END IF;
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         UT_TRACE.TRACE( 'EXCEPTION OTHERS TT_BCDamage.LastDamageDate', 15 );
         IF ( CULASTDAMAGEDATE%ISOPEN ) THEN
            CLOSE CULASTDAMAGEDATE;
         END IF;
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END LASTDAMAGEDATE;
   PROCEDURE FIRSTDAMAGEDATE( INUPACKAGEID IN MO_PACKAGES.PACKAGE_ID%TYPE, ODTFIRSTDATE OUT TT_DAMAGE.INITIAL_DATE%TYPE )
    IS
      CURSOR CUFIRSTDAMAGEDATE IS
SELECT  min(initial_Date) initial_date
        FROM    mo_packages_asso, tt_damage
        WHERE   mo_packages_asso.package_id_asso = inuPackageId
        AND     tt_damage.package_id = mo_packages_asso.package_id;
    BEGIN
      UT_TRACE.TRACE( 'Inicia TT_BCDamage.FirstDamageDate ...', 20 );
      IF ( CUFIRSTDAMAGEDATE%ISOPEN ) THEN
         CLOSE CUFIRSTDAMAGEDATE;
      END IF;
      OPEN CUFIRSTDAMAGEDATE;
      FETCH CUFIRSTDAMAGEDATE
         INTO ODTFIRSTDATE;
      CLOSE CUFIRSTDAMAGEDATE;
      UT_TRACE.TRACE( 'Finaliza TT_BCDamage.LastDamageDate', 20 );
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         UT_TRACE.TRACE( 'EXCEPTION CONTROLLED_ERROR TT_BCDamage.LastDamageDate', 15 );
         IF ( CUFIRSTDAMAGEDATE%ISOPEN ) THEN
            CLOSE CUFIRSTDAMAGEDATE;
         END IF;
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         UT_TRACE.TRACE( 'EXCEPTION OTHERS TT_BCDamage.FirstDamageDate', 15 );
         IF ( CUFIRSTDAMAGEDATE%ISOPEN ) THEN
            CLOSE CUFIRSTDAMAGEDATE;
         END IF;
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END FIRSTDAMAGEDATE;
END TT_BCDAMAGE;
/


