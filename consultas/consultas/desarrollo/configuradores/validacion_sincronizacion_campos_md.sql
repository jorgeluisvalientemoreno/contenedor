﻿ SELECT A.*, B.*, C.*
        FROM GE_ENTITY_ATTRIBUTES A, GI_ATTRIB_DISP_DATA B, GE_ATTR_VAL_EXPRESS C
        WHERE B.EXECUTABLE_ID = 500000000015771
          AND A.ENTITY_ID = 6163
          AND A.ENTITY_ID = B.ENTITY_ID
          AND A.STATUS <> 'B'
          AND A.ENTITY_ATTRIBUTE_ID = B.ENTITY_ATTRIBUTE_ID
          AND B.ENTITY_ATTRIBUTE_ID = C.ENTITY_ATTRIBUTE_ID(+)
        ORDER BY B.POSITION;
        
          SELECT COUNT(*)
        FROM GI_ATTRIB_DISP_DATA
        WHERE EXECUTABLE_ID = 500000000015771
          AND ENTITY_ID = 6163;
          
           SELECT COUNT(*)
        FROM GE_ENTITY_ATTRIBUTES
        WHERE ENTITY_ID = 6163
          AND STATUS <> 'B';
          
              SELECT   * --COUNT (1) COLUMNSCOUNTED
    FROM    GE_ENTITY,
            ALL_TAB_COLUMNS
    WHERE   /*+ Ubicaci�n: GI_BCFrameWorkMasterDetail.cuCountSchemeColumns SAO204673 */
            /*OWNER = GE_BOPARAMETER.FSBGET('DEFAULT_SCHEMA')
    AND     */TABLE_NAME = GE_ENTITY.NAME_
    AND     GE_ENTITY.ENTITY_ID = 6163;