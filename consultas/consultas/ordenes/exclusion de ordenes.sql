select open.FSBEXCLUIROTCONEXIONNUEVA(16587744) from dual;

 SELECT A.*
      FROM open.OR_ORDER_ACTIVITY A
     WHERE A.ORDER_ID = 16587744
       AND A.TASK_TYPE_ID IN
           (SELECT TO_NUMBER(COLUMN_VALUE)
              FROM TABLE(open.LDC_BOUTILITIES.SPLITSTRINGS(open.DALD_PARAMETER.fsbGetValue_Chain('COD_TAS_TYP_EJECUTORES',
                                                                                       NULL),
                                                      ',')))
       AND open.DAMO_PACKAGES.FNUGETPACKAGE_TYPE_ID(A.PACKAGE_ID, NULL) IN
           (SELECT TO_NUMBER(COLUMN_VALUE)
              FROM TABLE(open.LDC_BOUTILITIES.SPLITSTRINGS(open.DALD_PARAMETER.fsbGetValue_Chain('COD_SOL_VENTAS',
                                                                                       NULL),
                                                      ',')));
select OPEN.DAMO_PACKAGES.FNUGETPACKAGE_TYPE_ID(10661386) from dual ;
select open.DALD_PARAMETER.fnuGetNumeric_Value('COD_TIPO_SOL_VENTAS_CONST',
                                                                         NULL) from dual;
                                                                         
SELECT * --COUNT(A.ORDER_ID) CANTIDAD_ORDENES
      FROM open.OR_ORDER_ACTIVITY A, open.OR_ORDER B
     WHERE A.PACKAGE_ID = 10661386
       AND A.TASK_TYPE_ID IN
           (SELECT TO_NUMBER(COLUMN_VALUE)
              FROM TABLE(open.LDC_BOUTILITIES.SPLITSTRINGS(open.DALD_PARAMETER.fsbGetValue_Chain('COD_TAS_TYP_EJECUTORES',
                                                                                       NULL),
                                                      ',')))
       AND open.DAMO_PACKAGES.FNUGETPACKAGE_TYPE_ID(10661386, NULL) IN
           (SELECT TO_NUMBER(COLUMN_VALUE)
              FROM TABLE(open.LDC_BOUTILITIES.SPLITSTRINGS(open.DALD_PARAMETER.fsbGetValue_Chain('COD_SOL_VENTAS',
                                                                                       NULL),
                                                      ',')))
       AND A.ORDER_ID = B.ORDER_ID;                      
 SELECT  * --COUNT(A.ORDER_ID) CANTIDAD_LEGALIZADAS
      FROM open.OR_ORDER_ACTIVITY A, open.OR_ORDER B
     WHERE A.PACKAGE_ID = 10661386
       AND A.TASK_TYPE_ID IN
           (SELECT TO_NUMBER(COLUMN_VALUE)
              FROM TABLE(open.LDC_BOUTILITIES.SPLITSTRINGS(open.DALD_PARAMETER.fsbGetValue_Chain('COD_TAS_TYP_EJECUTORES',
                                                                                       NULL),
                                                      ',')))
       AND open.DAMO_PACKAGES.FNUGETPACKAGE_TYPE_ID(10661386, NULL) IN
           (SELECT TO_NUMBER(COLUMN_VALUE)
              FROM TABLE(open.LDC_BOUTILITIES.SPLITSTRINGS(open.DALD_PARAMETER.fsbGetValue_Chain('COD_SOL_VENTAS',
                                                                                       NULL),
                                                      ',')))
       AND A.ORDER_ID = B.ORDER_ID
       AND B.ORDER_STATUS_ID =
           open.DALD_PARAMETER.fnuGetNumeric_Value('COD_ORDER_STATUS', NULL);                                                          
