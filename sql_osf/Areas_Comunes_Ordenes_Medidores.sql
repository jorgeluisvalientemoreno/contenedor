select *
  From open.LDC_DETAMED m,
       OPEN.PR_PRODUCT  P,
       OPEN.AB_aDDRESS  DI,
       OPEN.AB_SEGMENTS SE
 where m.order_id = 273006434
   AND P.PRODUCT_TYPE_ID = 7014
   AND P.SUBSCRIPTION_ID = M.COD_CONTRATO
   AND DI.ADDRESS_ID = P.ADDRESs_ID
   AND SE.SEGMENTS_ID = DI.SEGMENT_ID; --1159948

SELECT * FROM open.LDC_DETAMED WHERE ORDER_ID = 273006434;