CREATE OR REPLACE PACKAGE BODY CT_BCCONDITIONS IS
   CSBVERSION CONSTANT VARCHAR2( 10 ) := 'SAO230779';
   FUNCTION FSBVERSION
    RETURN VARCHAR2
    IS
    BEGIN
      RETURN CSBVERSION;
   END FSBVERSION;
   PROCEDURE GETITEMCONDBYCONPLAN( INUCONDITIONSPLANID IN CT_CONDITIONS_BY_PLAN.CONDITIONS_PLAN_ID%TYPE, INUITEMSID IN CT_CONDITIONS.ITEMS_ID%TYPE, INUCERTIFICATETYPEID IN CT_CONDITIONS_BY_PLAN.CERTIFICATE_TYPE_ID%TYPE, ISBLEVEL IN CT_CONDITIONS.LEVEL_%TYPE, ORCCONDITION OUT CT_BCLIQUIDATIONSUPPORT.TYFORMCONDITION )
    IS
      CURSOR CUCONDITIONS IS
SELECT /*+ index ( CT_CONDITIONS IDX_CT_CONDITIONS01 )
                       index (ct_conditions PK_CT_CONDITIONS)
                       use_nl(ct_conditions ct_conditions_by_plan) */
                    ct_conditions.CONDITIONS_ID,
                    ct_conditions.DESCRIPTION,
                    ct_conditions.CONFIG_EXPRESSION_ID,
                    ct_conditions.ITEMS_ID,
                    ct_conditions.ITEM_CLASSIF_ID,
                    ct_conditions.WEIGHT,
                    ct_conditions.STATUS,
                    ct_conditions.LEVEL_,
                    ct_conditions_by_plan.CERTIFICATE_TYPE_ID,
                    ct_conditions_by_plan.CONDITION_BY_PLAN_ID,
                    ct_conditions_by_plan.FLAG_TYPE,
                    ct_conditions_by_plan.CONDITIONS_PLAN_ID,
                    ct_conditions_by_plan.EXEC_ORDER
             FROM ct_conditions
                , ct_conditions_by_plan
            /*+ CT_BCConditions.GetItemCondByConPlan*/
            WHERE ct_conditions.status = CT_BOConstants.fsbgetEnabledCondStatus
              AND ct_conditions_by_plan.certificate_type_id = nvl(inuCertificateTypeId,ct_conditions_by_plan.certificate_type_id)
              AND ct_conditions.items_id = inuItemsId
              AND ct_conditions.item_classif_id IS null
              AND ct_conditions.level_ = nvl(isbLevel,ct_conditions.level_)
              AND ct_conditions.conditions_id = ct_conditions_by_plan.conditions_id
              AND ct_conditions_by_plan.conditions_plan_id = inuConditionsPlanId;
    BEGIN
      OPEN CUCONDITIONS;
      FETCH CUCONDITIONS
         INTO ORCCONDITION;
      CLOSE CUCONDITIONS;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         IF ( CUCONDITIONS%ISOPEN ) THEN
            CLOSE CUCONDITIONS;
         END IF;
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         IF ( CUCONDITIONS%ISOPEN ) THEN
            CLOSE CUCONDITIONS;
         END IF;
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END GETITEMCONDBYCONPLAN;
   PROCEDURE GETITEMCLASSIFCONDBYCONPLAN( INUCONDITIONSPLANID IN CT_CONDITIONS_BY_PLAN.CONDITIONS_PLAN_ID%TYPE, INUITEMCLASSIFID IN CT_CONDITIONS.ITEM_CLASSIF_ID%TYPE, INUCERTIFICATETYPEID IN CT_CONDITIONS_BY_PLAN.CERTIFICATE_TYPE_ID%TYPE, ISBLEVEL IN CT_CONDITIONS.LEVEL_%TYPE, ORCCONDITION OUT CT_BCLIQUIDATIONSUPPORT.TYFORMCONDITION )
    IS
      CURSOR CUCONDITIONS IS
SELECT /*+  index (ct_conditions PK_CT_CONDITIONS)
                        use_nl(ct_conditions ct_conditions_by_plan)  */
                    ct_conditions.CONDITIONS_ID,
                    ct_conditions.DESCRIPTION,
                    ct_conditions.CONFIG_EXPRESSION_ID,
                    ct_conditions.ITEMS_ID,
                    ct_conditions.ITEM_CLASSIF_ID,
                    ct_conditions.WEIGHT,
                    ct_conditions.STATUS,
                    ct_conditions.LEVEL_,
                    ct_conditions_by_plan.CERTIFICATE_TYPE_ID,
                    ct_conditions_by_plan.CONDITION_BY_PLAN_ID,
                    ct_conditions_by_plan.FLAG_TYPE,
                    ct_conditions_by_plan.CONDITIONS_PLAN_ID,
                    ct_conditions_by_plan.EXEC_ORDER
              FROM ct_conditions
                 , ct_conditions_by_plan
             /*+ CT_BCConditions.GetItemClassifCondByConPlan*/
             WHERE ct_conditions.status = CT_BOConstants.fsbgetEnabledCondStatus
               AND ct_conditions_by_plan.certificate_type_id = nvl(inuCertificateTypeId,
                                                           ct_conditions_by_plan.certificate_type_id)
               AND ct_conditions.item_classif_id = inuItemClassifId
               AND ct_conditions.items_id IS null
               AND ct_conditions.level_ = nvl(isbLevel,
                                              ct_conditions.level_)
               AND ct_conditions.conditions_id = ct_conditions_by_plan.conditions_id
               AND ct_conditions_by_plan.conditions_plan_id = inuConditionsPlanId;
    BEGIN
      OPEN CUCONDITIONS;
      FETCH CUCONDITIONS
         INTO ORCCONDITION;
      CLOSE CUCONDITIONS;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         IF ( CUCONDITIONS%ISOPEN ) THEN
            CLOSE CUCONDITIONS;
         END IF;
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         IF ( CUCONDITIONS%ISOPEN ) THEN
            CLOSE CUCONDITIONS;
         END IF;
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END GETITEMCLASSIFCONDBYCONPLAN;
   PROCEDURE GETCONDITIONSBYCONPLAN( INUCONDITIONSPLANID IN CT_CONDITIONS_BY_PLAN.CONDITIONS_PLAN_ID%TYPE, INUCERTIFICATETYPEID IN CT_CONDITIONS_BY_PLAN.CERTIFICATE_TYPE_ID%TYPE, ISBLEVEL IN CT_CONDITIONS.LEVEL_%TYPE, OTBCONDITIONS OUT CT_BCLIQUIDATIONSUPPORT.TYTBFORMCONDITIONS )
    IS
      CURSOR CUCONDITIONS IS
SELECT /*+ index (ct_conditions PK_CT_CONDITIONS)
                       use_nl(ct_conditions ct_conditions_by_plan)*/
                   ct_conditions.CONDITIONS_ID,
                    ct_conditions.DESCRIPTION,
                    ct_conditions.CONFIG_EXPRESSION_ID,
                    ct_conditions.ITEMS_ID,
                    ct_conditions.ITEM_CLASSIF_ID,
                    ct_conditions.WEIGHT,
                    ct_conditions.STATUS,
                    ct_conditions.LEVEL_,
                    ct_conditions_by_plan.CERTIFICATE_TYPE_ID,
                    ct_conditions_by_plan.CONDITION_BY_PLAN_ID,
                    ct_conditions_by_plan.FLAG_TYPE,
                    ct_conditions_by_plan.CONDITIONS_PLAN_ID,
                    ct_conditions_by_plan.EXEC_ORDER
            FROM   ct_conditions,
                   ct_conditions_by_plan
            /*+ CT_BCConditions.GetConditionsByConPlan*/
            WHERE  ct_conditions.status = CT_BOConstants.fsbgetEnabledCondStatus
              AND  ct_conditions_by_plan.certificate_type_id = nvl(inuCertificateTypeId,
                                                           ct_conditions_by_plan.certificate_type_id)
              AND  ct_conditions.items_id IS not null
              AND  ct_conditions.item_classif_id IS null
              AND  ct_conditions.level_ = nvl(isbLevel,
                                              ct_conditions.level_)
              AND ct_conditions.conditions_id = ct_conditions_by_plan.conditions_id
              AND ct_conditions_by_plan.conditions_plan_id = inuConditionsPlanId
              ORDER BY ct_conditions_by_plan.exec_order;
    BEGIN
      OPEN CUCONDITIONS;
      FETCH CUCONDITIONS
         BULK COLLECT INTO OTBCONDITIONS;
      CLOSE CUCONDITIONS;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         IF ( CUCONDITIONS%ISOPEN ) THEN
            CLOSE CUCONDITIONS;
         END IF;
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         IF ( CUCONDITIONS%ISOPEN ) THEN
            CLOSE CUCONDITIONS;
         END IF;
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END GETCONDITIONSBYCONPLAN;
   FUNCTION FBLPLANHASORITLEVELCON( INUCONDITIONSPLANID IN CT_CONDITIONS_PLAN.CONDITIONS_PLAN_ID%TYPE )
    RETURN BOOLEAN
    IS
      SBVARIA VARCHAR2( 1 );
      CURSOR CUCONDITIONS IS
SELECT /*+ index ( CT_CONDITIONS PK_CT_CONDITIONS )
                       index (CT_CONDITIONS IDX_CT_CONDITIONS02)
                       index (CT_CONDITIONS_BY_PLAN IDX_CT_CONDITIONS_BY_PLAN01)*/
                   'x'
            FROM   ct_conditions,
                   ct_conditions_by_plan
            /*+ CT_BCConditions.fblPlanHasOrItLevelCon*/
            WHERE  ct_conditions.status = CT_BOConstants.fsbgetEnabledCondStatus
              AND  ct_conditions.level_ IN (CT_BOConstants.fsbgetItemCondLevel,
                                            CT_BOConstants.fsbgetOrderCondLevel)
              AND ct_conditions.conditions_id = ct_conditions_by_plan.conditions_id
              AND  ct_conditions_by_plan.conditions_plan_id = inuConditionsPlanId
              AND rownum < 2;
    BEGIN
      OPEN CUCONDITIONS;
      FETCH CUCONDITIONS
         INTO SBVARIA;
      CLOSE CUCONDITIONS;
      IF SBVARIA IS NULL THEN
         RETURN FALSE;
       ELSE
         RETURN TRUE;
      END IF;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         IF ( CUCONDITIONS%ISOPEN ) THEN
            CLOSE CUCONDITIONS;
         END IF;
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         IF ( CUCONDITIONS%ISOPEN ) THEN
            CLOSE CUCONDITIONS;
         END IF;
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END FBLPLANHASORITLEVELCON;
   PROCEDURE ADDMODIFIEDCONDITION( RCCONDITIONS IN DACT_CONDITIONS.STYCT_CONDITIONS )
    IS
      NUINDEX NUMBER;
    BEGIN
      NUINDEX := NVL( TBCONDITIONSINPLAN.LAST, 0 ) + 1;
      TBCONDITIONSINPLAN( NUINDEX ) := RCCONDITIONS;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END ADDMODIFIEDCONDITION;
   PROCEDURE ADDMODICONDPLABYCONTTY( RCCONDPLANBYCONTRTY IN DACT_CONPLA_CON_TYPE.STYCT_CONPLA_CON_TYPE )
    IS
      NUINDEX NUMBER;
    BEGIN
      NUINDEX := NVL( TBCONDITBYCONTRACTTYPE.LAST, 0 ) + 1;
      TBCONDITBYCONTRACTTYPE( NUINDEX ) := RCCONDPLANBYCONTRTY;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END ADDMODICONDPLABYCONTTY;
   PROCEDURE ADDMODICONDPLABYCONTRA( RCCONDPLANBYCONTRA IN DACT_CONPLA_CON_TYPE.STYCT_CONPLA_CON_TYPE )
    IS
      NUINDEX NUMBER;
    BEGIN
      NUINDEX := NVL( TBCONDITBYCONTRACT.LAST, 0 ) + 1;
      TBCONDITBYCONTRACT( NUINDEX ) := RCCONDPLANBYCONTRA;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END ADDMODICONDPLABYCONTRA;
   FUNCTION FNUISITMORCLASSINPLAN( INUCONDITIONSID IN CT_CONDITIONS.CONDITIONS_ID%TYPE, INUITEMSID IN CT_CONDITIONS.ITEMS_ID%TYPE, INUITEMCLASSIFID IN CT_CONDITIONS.ITEM_CLASSIF_ID%TYPE, INUCONDITIONSPLANID IN CT_CONDITIONS_BY_PLAN.CONDITIONS_PLAN_ID%TYPE, ISBCONDITIONSSTATUS IN CT_CONDITIONS.STATUS%TYPE )
    RETURN NUMBER
    IS
      NUEXISTSITEM CT_CONDITIONS.CONDITIONS_ID%TYPE;
      CUEXISTS CONSTANTS.TYREFCURSOR;
    BEGIN
      UT_TRACE.TRACE( '[BEGIN] fnuIsItmOrClassInPlan', 15 );
      UT_TRACE.TRACE( ' inuItemsId -> ' || INUITEMSID || ' inuItemClassifId-> ' || INUITEMCLASSIFID || ' inuConditionsPlanId -> ' || INUCONDITIONSPLANID || ' inuConditionsId -> ' || INUCONDITIONSID || ' isbConditionsStatus -> ' || ISBCONDITIONSSTATUS, 20 );
      IF ( ISBCONDITIONSSTATUS = CT_BOCONSTANTS.FSBGETDISABLEDCONDSTATUS ) THEN
         UT_TRACE.TRACE( 'Condición deshabilitada', 20 );
         RETURN 0;
      END IF;
      OPEN CUEXISTS FOR SELECT conditions_id
           FROM
                (
                SELECT /*+ index ( CT_CONDITIONS PK_CT_CONDITIONS )
                           index (ct_conditions_by_plan IDX_CT_CONDITIONS_BY_PLAN05)
                           use_nl(ct_conditions ct_conditions_by_plan) */
                       ct_conditions.conditions_id
                  FROM ct_conditions,
                       ct_conditions_by_plan
                 WHERE ct_conditions.items_id = inuItemsId
                   AND ct_conditions.conditions_id <> inuConditionsId
                   AND ct_conditions.status =ct_boconstants.fsbgetEnabledCondStatus
                   AND ct_conditions.conditions_id = ct_conditions_by_plan.conditions_id
                   AND ct_conditions_by_plan.conditions_plan_id = inuConditionsPlanId
                 UNION all
                SELECT /*+ index ( CT_CONDITIONS PK_CT_CONDITIONS )
                           index (ct_conditions_by_plan IDX_CT_CONDITIONS_BY_PLAN05)
                           use_nl(ct_conditions ct_conditions_by_plan) */
                       ct_conditions.conditions_id
                  FROM ct_conditions,
                       ct_conditions_by_plan
                 WHERE ct_conditions.item_classif_id = inuItemClassifId
                   AND ct_conditions.conditions_id <> inuConditionsId
                   AND ct_conditions.status = ct_boconstants.fsbgetEnabledCondStatus
                   AND ct_conditions.conditions_id = ct_conditions_by_plan.conditions_id
                   AND ct_conditions_by_plan.conditions_plan_id = inuConditionsPlanId
                ) items_in_plan
        /*+ CT_BCConditions.fnuIsItmOrClassInPlan*/
        WHERE ROWNUM = 1;
      FETCH CUEXISTS
         INTO NUEXISTSITEM;
      CLOSE CUEXISTS;
      IF NUEXISTSITEM IS NULL THEN
         NUEXISTSITEM := 0;
      END IF;
      UT_TRACE.TRACE( 'nuexistsitem -> ' || NUEXISTSITEM, 20 );
      UT_TRACE.TRACE( '[END] fnuIsItmOrClassInPlan', 15 );
      RETURN NUEXISTSITEM;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         IF ( CUEXISTS%ISOPEN ) THEN
            CLOSE CUEXISTS;
         END IF;
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         IF ( CUEXISTS%ISOPEN ) THEN
            CLOSE CUEXISTS;
         END IF;
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END FNUISITMORCLASSINPLAN;
   FUNCTION FNUISPLANBYCONTRAUSED( INUCONTRACTID IN CT_CONPLA_CON_TYPE.CONTRACT_ID%TYPE, INUCONDITIONSPLANID IN CT_CONPLA_CON_TYPE.CONDITIONS_PLAN_ID%TYPE )
    RETURN NUMBER
    IS
      CUEXISTS CONSTANTS.TYREFCURSOR;
      CONDITIOSNID CT_CONDITIONS.CONDITIONS_ID%TYPE;
    BEGIN
      OPEN CUEXISTS FOR SELECT conditions_id
         FROM
         (
        SELECT /*+
               ORDERED
               INDEX(CT_CONDITIONS   IDX_CT_CONDITIONS01)
               INDEX(GE_DETALLE_ACTA IDX_GE_DETALLE_ACTA04)
               INDEX(GE_ACTA         PK_GE_ACTA)
               */
               ct_conditions_by_plan.conditions_id
          FROM ct_conditions_by_plan,
               ge_detalle_acta,
               ge_acta
         WHERE ct_conditions_by_plan.conditions_plan_id = inuConditionsPlanId
           AND ct_conditions_by_plan.flag_type = ct_boconstants.csbTypeFormCondition
           AND ge_detalle_acta.condition_by_plan_id = ct_conditions_by_plan.condition_by_plan_id
           AND ge_acta.id_acta = ge_detalle_acta.id_acta
           AND ge_acta.id_contrato = inuContractId
           Union all
        SELECT ct_conditions_by_plan.items_id conditions_id
          FROM ct_conditions_by_plan
             , ct_simple_condition
             , ge_detalle_acta
             , ge_acta
         WHERE ct_conditions_by_plan.conditions_plan_id = inuConditionsPlanId
           AND ct_simple_condition.items_id= ct_conditions_by_plan.items_id
           AND ct_simple_condition.condition_level <> ct_boconstants.csbCertificateType
           AND ge_detalle_acta.condition_by_plan_id = ct_conditions_by_plan.condition_by_plan_id
           AND ge_acta.id_acta = ge_detalle_acta.id_acta
           AND ge_acta.id_contrato = inuContractId
          )
          /*+ CT_BCConditions.fnuIsPlanByContraUsed*/
          WHERE  ROWNUM < 2
         ;
      FETCH CUEXISTS
         INTO CONDITIOSNID;
      CLOSE CUEXISTS;
      RETURN CONDITIOSNID;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         IF ( CUEXISTS%ISOPEN ) THEN
            CLOSE CUEXISTS;
         END IF;
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         IF ( CUEXISTS%ISOPEN ) THEN
            CLOSE CUEXISTS;
         END IF;
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END FNUISPLANBYCONTRAUSED;
   FUNCTION FNUISPLANBYCONTYPEUSED( INUCONTRACTTYPEID IN CT_CONPLA_CON_TYPE.CONTRACT_TYPE_ID%TYPE, INUCONDITIONSPLANID IN CT_CONPLA_CON_TYPE.CONDITIONS_PLAN_ID%TYPE )
    RETURN NUMBER
    IS
      CUEXISTS CONSTANTS.TYREFCURSOR;
      CONDITIOSNID CT_CONDITIONS.CONDITIONS_ID%TYPE;
    BEGIN
      OPEN CUEXISTS FOR SELECT /*+
               ORDERED
               INDEX(GE_CONTRATO      IDX_GE_CONTRATO_02)
               INDEX(GE_ACTA          IDX_GE_ACTA_01)
               INDEX(GE_DETALLE_ACTA  IDX_GE_DETALLE_ACTA04)
               INDEX(CT_CONDITIONS    PK_CT_CONDITIONS)
               */
               ct_conditions_by_plan.conditions_id
          FROM ge_contrato,
               ge_acta,
               ge_detalle_acta,
               ct_conditions_by_plan
               /*+ CT_BCConditions.fnuIsPlanByConTypeUsed*/
         WHERE ge_contrato.id_tipo_contrato = inuContractTypeId
           AND ge_acta.id_contrato = ge_contrato.id_contrato
           AND ge_detalle_acta.id_acta = ge_acta.id_acta
           AND ct_conditions_by_plan.condition_by_plan_id  = ge_detalle_acta.condition_by_plan_id
           AND ct_conditions_by_plan.conditions_plan_id = inuConditionsPlanId
           AND ct_conditions_by_plan.flag_type = ct_boconstants.csbTypeFormCondition
           AND ROWNUM = 1
         ;
      FETCH CUEXISTS
         INTO CONDITIOSNID;
      CLOSE CUEXISTS;
      RETURN CONDITIOSNID;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         IF ( CUEXISTS%ISOPEN ) THEN
            CLOSE CUEXISTS;
         END IF;
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         IF ( CUEXISTS%ISOPEN ) THEN
            CLOSE CUEXISTS;
         END IF;
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END FNUISPLANBYCONTYPEUSED;
   FUNCTION FNUISCONDPLANINCONTTYP( INUCONDITIONSPLANID IN CT_CONPLA_CON_TYPE.CONDITIONS_PLAN_ID%TYPE )
    RETURN VARCHAR2
    IS
      CUEXISTSTYPE CONSTANTS.TYREFCURSOR;
      SBFLAGTYPE CT_CONPLA_CON_TYPE.FLAG_TYPE%TYPE;
    BEGIN
      OPEN CUEXISTSTYPE FOR SELECT /*+ index (CT_CONPLA_CON_TYPE IDX_CT_CONPLA_CON_TYPE01)
                   index (CT_CONPLA_CON_TYPE IDX_CT_CONPLA_CON_TYPE02)*/
               ct_conpla_con_type.flag_type
          FROM ct_conpla_con_type,ct_conditions_plan
                /*+ CT_BCConditions.fnuIsCondPlanInContTyp*/
         WHERE ct_conpla_con_type.conditions_plan_id = inuConditionsPlanId
           AND ct_conpla_con_type.conditions_plan_id = ct_conditions_plan.conditions_plan_id;
      FETCH CUEXISTSTYPE
         INTO SBFLAGTYPE;
      CLOSE CUEXISTSTYPE;
      RETURN SBFLAGTYPE;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         IF ( CUEXISTSTYPE%ISOPEN ) THEN
            CLOSE CUEXISTSTYPE;
         END IF;
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         IF ( CUEXISTSTYPE%ISOPEN ) THEN
            CLOSE CUEXISTSTYPE;
         END IF;
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END FNUISCONDPLANINCONTTYP;
   PROCEDURE GETNOLIQCONDBYPLAN( INUCONDITIONSPLANID IN CT_CONDITIONS_BY_PLAN.CONDITIONS_PLAN_ID%TYPE, ISBLEVEL IN CT_CONDITIONS.LEVEL_%TYPE, OTBCONDITIONS IN OUT NOCOPY CT_BCLIQUIDATIONSUPPORT.TYTBFORMCONDITIONS )
    IS
      SBSTATUS CT_CONDITIONS.STATUS%TYPE := CT_BOCONSTANTS.FSBGETENABLEDCONDSTATUS;
      CURSOR CUCONDITIONS IS
SELECT /*+ index (ct_conditions PK_CT_CONDITIONS)
                       use_nl(ct_conditions ct_conditions_by_plan)*/
                   ct_conditions.CONDITIONS_ID,
                    ct_conditions.DESCRIPTION,
                    ct_conditions.CONFIG_EXPRESSION_ID,
                    ct_conditions.ITEMS_ID,
                    ct_conditions.ITEM_CLASSIF_ID,
                    ct_conditions.WEIGHT,
                    ct_conditions.STATUS,
                    ct_conditions.LEVEL_,
                    ct_conditions_by_plan.CERTIFICATE_TYPE_ID,
                    ct_conditions_by_plan.CONDITION_BY_PLAN_ID,
                    ct_conditions_by_plan.FLAG_TYPE,
                    ct_conditions_by_plan.CONDITIONS_PLAN_ID,
                    ct_conditions_by_plan.EXEC_ORDER
            FROM   ct_conditions,
                   ct_conditions_by_plan
                   /*+ CT_BCConditions.GetNoLiqCondByPlan*/
            WHERE  ct_conditions.status = sbStatus
              AND  ct_conditions_by_plan.certificate_type_id IS null
              AND  ct_conditions.items_id IS null
              AND  ct_conditions.item_classif_id IS null
              AND  ct_conditions.level_ = isbLevel
              AND ct_conditions.conditions_id = ct_conditions_by_plan.conditions_id
              AND ct_conditions_by_plan.conditions_plan_id = inuConditionsPlanId
              ORDER BY ct_conditions_by_plan.exec_order;
    BEGIN
      OPEN CUCONDITIONS;
      FETCH CUCONDITIONS
         BULK COLLECT INTO OTBCONDITIONS;
      CLOSE CUCONDITIONS;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         IF ( CUCONDITIONS%ISOPEN ) THEN
            CLOSE CUCONDITIONS;
         END IF;
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         IF ( CUCONDITIONS%ISOPEN ) THEN
            CLOSE CUCONDITIONS;
         END IF;
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END GETNOLIQCONDBYPLAN;
END CT_BCCONDITIONS;
/


