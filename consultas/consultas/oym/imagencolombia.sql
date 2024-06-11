select *
from open.LDC_IMCORETE
where icrtorde=12879587;

 SELECT  /*+ INDEX(PR_timeout_component IX_PR_TIMEOUT_COMPONENT05)
                    INDEX(mo_packages IDX_MO_PACKAGES_026)
                    INDEX(ps_motive_status PK_PS_MOTIVE_STATUS)
                */
                PR_TIMEOUT_COMPONENT.*,PR_TIMEOUT_COMPONENT.ROWID, 
                MO_PACKAGES.PACKAGE_TYPE_ID
        FROM    open.PR_TIMEOUT_COMPONENT,
                open.MO_PACKAGES,
                open.PS_MOTIVE_STATUS
                /*+  CC_BCProductDamage.frcTimeOutByPackageId */
        WHERE   PR_TIMEOUT_COMPONENT.PACKAGE_ID = 10743217
        AND     PR_TIMEOUT_COMPONENT.COMPONENT_ID IS NULL
        AND     PR_TIMEOUT_COMPONENT.COMPENSATED_TIME IS NULL
        AND     PR_TIMEOUT_COMPONENT.PACKAGE_ID = MO_PACKAGES.PACKAGE_ID
        --AND     MO_PACKAGES.PACKAGE_TYPE_ID = TT_BOCONSTANTS.CNUINDDAMAGE
        AND     MO_PACKAGES.MOTIVE_STATUS_ID = PS_MOTIVE_STATUS.MOTIVE_STATUS_ID
       -- AND     PS_MOTIVE_STATUS.IS_FINAL_STATUS = 'N';
       
 SELECT * 
                    FROM open.cc_legal_causal_answer a,open.cc_answer b
                    WHERE a.answer_id = b.answer_id
                    AND request_type_id = 59
                    AND task_type_id = 10127
--                    AND causal_id = 8931
                    AND rownum = 1;
                    
select *
from open.ge_causal
where UPPER(description) like '%AUSENCIA%';


select *
from open.ge_items
where items_id=100000390;

SELECT *
FROM OPEN.GE_UNIT_COST_ITE_LIS
WHERE SALES_VALUE<2000
AND SALES_VALUE>0;

SELECT *



WHERE ITEMS_ID=100000390;
GE_LIST_UNITARY_COST
