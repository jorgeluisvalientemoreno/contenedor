   SELECT /*+ ordered index(or_order IDX_OR_ORDER21)
                        index(ge_causal PK_GE_CAUSAL)*/
                    OR_ORDER.ROWID
             FROM   OR_ORDER,
                    GE_CAUSAL
             WHERE
                
                OR_ORDER.DEFINED_CONTRACT_ID = INUCONTRACTID
                
                AND OR_ORDER.IS_PENDING_LIQ = GE_BOCONSTANTS.CSBYES
                
                AND  OR_ORDER.ORDER_STATUS_ID = OR_BOCONSTANTS.CNUORDER_STAT_CLOSED
                   
                AND OR_ORDER.LEGALIZATION_DATE <= IDTBREAKDATE
                   
                AND GE_CAUSAL.CAUSAL_ID = OR_ORDER.CAUSAL_ID
                AND GE_CAUSAL.CLASS_CAUSAL_ID = CNUSUCCESSFULLCLASSCAUSAL
          UNION
             SELECT /*+ ordered
                        index (or_operating_unit IDX_OR_OPERATING_UNIT10)
                        index(or_order  IDX_OR_ORDER_3)
                        INDEX (ct_tasktype_contype  IDX_CT_TASKTYPE_CONTYPE01)
                        index(ge_causal PK_GE_CAUSAL)*/
                    OR_ORDER.ROWID
             FROM   OR_OPERATING_UNIT,
                    OR_ORDER,
                    CT_TASKTYPE_CONTYPE,
                    GE_CAUSAL
                    /*+ CT_BCContract.SetOrdersByTaskContTypeWBase*/
             WHERE
                    OR_OPERATING_UNIT.CONTRACTOR_ID = INUCONTRACTORID
               AND  OR_OPERATING_UNIT.ES_EXTERNA = GE_BOCONSTANTS.CSBYES
               AND  OR_ORDER.OPERATING_UNIT_ID = OR_OPERATING_UNIT.OPERATING_UNIT_ID
                    
               AND  OR_ORDER.ORDER_STATUS_ID = OR_BOCONSTANTS.CNUORDER_STAT_CLOSED
                    
               AND  GE_CAUSAL.CAUSAL_ID = OR_ORDER.CAUSAL_ID
               AND  GE_CAUSAL.CLASS_CAUSAL_ID = CNUSUCCESSFULLCLASSCAUSAL
               
               AND  OR_ORDER.TASK_TYPE_ID = CT_TASKTYPE_CONTYPE.TASK_TYPE_ID
               AND  CT_TASKTYPE_CONTYPE.CONTRACT_TYPE_ID = INUCONTRACTTYPEID
               AND  CT_TASKTYPE_CONTYPE.FLAG_TYPE = ISBFLAGTYPE
                    
               AND  OR_ORDER.LEGALIZATION_DATE <= IDTBREAKDATE
                    
               AND OR_ORDER.IS_PENDING_LIQ = GE_BOCONSTANTS.CSBYES
                    
               AND  OR_ORDER.DEFINED_CONTRACT_ID IS NULL;
