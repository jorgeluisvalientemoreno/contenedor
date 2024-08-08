select * from open.LDC_ORDEASIGPROC a where a.oraporpa = 304410747;
select * from open.LDC_GEN_VSIXJOB b where b.coclorde = 304410747;
SELECT O.TASK_TYPE_ID,
       O.OPERATING_UNIT_ID,
       O.CAUSAL_ID,
       OA.ACTIVITY_ID,
       s.package_id,
       P.CATEGORY_ID,
       P.SUBCATEGORY_ID,
       nvl(S.PACKAGE_TYPE_ID, -1) PACKAGE_TYPE_ID,
       OA.PRODUCT_ID,
       oa.SUBSCRIPTION_ID,
       OA.SUBSCRIBER_ID,
       NVL(OA.ADDRESS_ID, O.EXTERNAL_ADDRESS_ID) ADDRESS_ID,
       (select c.order_comment
          from open.or_ordeR_comment c
         where c.order_id = o.order_id
           and c.legalize_comment = 'Y'
           and rownum = 1) comentario
  From open.or_order o, open.or_order_activity oa
  left join open.mo_packages s
    on s.package_id = oa.package_id
  left join open.pr_product p
    on p.product_id = oa.product_id
 WHERE o.order_id = oa.order_id
   AND o.order_id = 304410747;
SELECT --*--
 c.coclacpa, C.COCLACTI, C.COCLMERE, c.COCLASAU, c.COCLDIAS, c.COCLCAME
  FROM open.LDC_COTTCLAC c
 WHERE (c.COCLTISO = /*regDatOrden.PACKAGE_TYPE_ID*/
       100101 or c.COCLTISO = -1)
   AND c.COCLTITR = /*regDatOrden.TASK_TYPE_ID*/
       12155
   AND (c.COCLACPA in /*regDatOrden.ACTIVITY_ID*/
       (100009788, 4000056) or c.COCLACPA is null)
   AND (c.COCLCAUS = /*regDatOrden.CAUSAL_ID*/
       3633 or c.COCLCAUS = -1)
   AND (c.COCLCATE = /*regDatOrden.CATEGORY_ID*/
       1 or c.COCLCATE = -1)
   AND (c.COCLSUCA = /*regDatOrden.SUBCATEGORY_ID*/
       2 or c.COCLSUCA is null);
