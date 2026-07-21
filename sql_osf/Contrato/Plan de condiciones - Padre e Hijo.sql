--La entdad ct_conditions_by_plan agrupa en un plan de condiciones en una serie de registros de la condiguracion las pestañas 
--Plan de condiciones
select * from CT_CONDITIONS_PLAN ccp order by ccp.conditions_plan_id;

--Condiciones de Exclusion
SELECT /*+ index (ct_conditions_by_plan IDX_CT_CONDITIONS_BY_PLAN01)*/
 *
  FROM CT_CONDITIONS cc, ct_conditions_by_plan ccpb
 WHERE 1 = 1
   and cc.conditions_id = ccpb.conditions_id
   and ccpb.conditions_plan_id = 36
   AND cc.level_ = 'E'
 ORDER BY ccpb.exec_order;

--Condiciones de Novedad
SELECT /*+ index (ct_conditions_by_plan IDX_CT_CONDITIONS_BY_PLAN01)*/
 *
  FROM CT_CONDITIONS cc, ct_conditions_by_plan ccpb
 WHERE 1 = 1
   and cc.conditions_id = ccpb.conditions_id
   and ccpb.conditions_plan_id = 36
   AND cc.level_ = 'N'
 ORDER BY ccpb.exec_order;

--Plan de condiciones X Condiciones Simples
SELECT /*+ index (ct_conditions_by_plan IDX_CT_CONDITIONS_BY_PLAN01)*/
 *
  FROM ct_conditions_by_plan
 WHERE ct_conditions_by_plan.conditions_plan_id = 36
   AND ct_conditions_by_plan.flag_type = 'S' --ct_boconstants.csbTypeSimpleCondition
 ORDER BY ct_conditions_by_plan.exec_order;

--Condiciones Simples X Items
SELECT /*+ index (ct_conditions_by_plan IDX_CT_CONDITIONS_BY_PLAN01)*/
 csci.*
  FROM CT_SIMPLE_CONDITION csc, ct_simple_cond_items csci
 WHERE 1 = 1
   and csc.simple_condition_id = csci.simple_condition_id
   and csc.items_id in (SELECT /*+ index (ct_conditions_by_plan IDX_CT_CONDITIONS_BY_PLAN01)*/
                         ct_conditions_by_plan.items_id
                          FROM ct_conditions_by_plan
                         WHERE ct_conditions_by_plan.conditions_plan_id = 36
                           AND ct_conditions_by_plan.flag_type = 'S' --ct_boconstants.csbTypeSimpleCondition
                        )
 ORDER BY csci.simple_cond_items_id;

--Plan de condiciones x Condiciones formuladas
SELECT /*+INDEX(CT_CONDITIONS PK_CT_CONDITIONS)
INDEX(CT_CONDITIONS_BY_PLAN PK_CT_CONDITIONS_BY_PLAN )
USE_NL(ct_conditions ct_conditions_by_plan )*/
 CT_CONDITIONS.CONDITIONS_ID,
 CT_CONDITIONS_BY_PLAN.CONDITIONS_PLAN_ID,
 CT_CONDITIONS.DESCRIPTION,
 CT_CONDITIONS.CONFIG_EXPRESSION_ID,
 dagr_config_expression.fsbgetdescription(CT_CONDITIONS.CONFIG_EXPRESSION_ID) CONFIG_EXPRESSION_DESCRIPTION,
 CT_CONDITIONS_BY_PLAN.EXEC_ORDER,
 CT_CONDITIONS.ITEMS_ID,
 CT_CONDITIONS.ITEM_CLASSIF_ID,
 CT_CONDITIONS_BY_PLAN.CERTIFICATE_TYPE_ID,
 CT_CONDITIONS.WEIGHT,
 CT_CONDITIONS.STATUS,
 decode(ct_conditions.items_id,
        null,
        null,
        dage_items.fsbgetdescription(ct_conditions.items_id)) ITEMS_DESCRIPTION,
 decode(ct_conditions.ITEM_CLASSIF_ID,
        null,
        null,
        dage_item_classif.fsbgetdescription(ct_conditions.ITEM_CLASSIF_ID)) ITEM_CLASSIF_DESCRIPTION,
 CT_CONDITIONS.LEVEL_
  FROM CT_CONDITIONS, CT_CONDITIONS_BY_PLAN
 WHERE CT_CONDITIONS_BY_PLAN.conditions_plan_id = 36
   AND CT_CONDITIONS.CONDITIONS_ID = CT_CONDITIONS_BY_PLAN.CONDITIONS_ID
   AND CT_CONDITIONS.level_ in
       (ct_boconstants.fsbgetItemCondLevel,
        ct_boconstants.fsbgetOrderCondLevel,
        ct_boconstants.fsbgetCertificateCondLevel)
