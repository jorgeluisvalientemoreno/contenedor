 --XML
 SELECT *
        FROM PS_REQUEST_CONF
        WHERE TAG_NAME = 'P_GESTION_ADMINISTRATIVA_PNO_288';
 
 
 SELECT *
 FROM GE_DISTRIBUTION_FILE D
 WHERE D.DISTRIBUTION_FILE_ID='P_GESTION_ADMINISTRATIVA_PNO_288';
 SELECT  /*+
                        ORDERED
                        index (WF_ATTRIBUTES_EQUIV IX_WF_ATTRIBUTES_EQUIV02)
                        index (WF_FLOW UX_WF_FLOW01)
                    */
                    *
                    /*WF_FLOW.FLOW_ID,
                    WF_FLOW.TAG_NAME,
                    WF_ATTRIBUTES_EQUIV.ATTRIBUTES_EQUIV_ID*/
            FROM    /*+ PS_BCPlanCreation.fnuGetFlowByPackType.SAO497103 */
                    WF_ATTRIBUTES_EQUIV,
                    WF_FLOW
            WHERE   /*WF_ATTRIBUTES_EQUIV.INTERFACE_CONFIG_ID = INUINTERFACEID
            AND     */WF_ATTRIBUTES_EQUIV.VALUE_1             = '288' --TO_CHAR(INUPACKAGETYPEID)
            AND     WF_FLOW.TAG_NAME                        = WF_ATTRIBUTES_EQUIV.FLOW_TAG_NAME;
            
            
SELECT *
FROM WF_UNIT_TYPE
WHERE PARENT_ID=50
