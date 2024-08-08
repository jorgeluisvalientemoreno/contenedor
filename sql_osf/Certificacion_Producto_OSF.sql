SELECT
/*+
ordered
use_nl(cer ora ord pac ora_rev ord_rev ora_inv ord_inv pac_inv)
*/
 cer.product_id,
 cer.certificate_id,
 cer.review_date,
 cer.register_date, --  Fecha de creaci¿n del certificado
 cer.Estimated_end_date, --        Fecha Estimada de fin de vigencia del certificado
 cer.end_date, --        Fecha de fin de vigencia del certificado
 ora.order_id ORD, -- codigo de la orden de revision
 (select items_id || chr(32) || chr(45) || chr(32) || description
    FROM ge_items
   WHERE items_id = ora.activity_id) ACT_REV, --Actividad de Revisi¿n
 (select operating_unit_id || chr(32) || chr(45) || chr(32) || name
    FROM OR_operating_unit
   WHERE operating_unit_id = ord.operating_unit_id) OPE_UNIT, -- Unidad de trabajo que revisa
 (select PACKAGE_type_id || chr(32) || chr(45) || chr(32) || description
    FROM ps_package_type
   WHERE PACKAGE_type_id = pac.package_type_id) PACK_TYPE, --Tipo de solicitud con que se cre¿ el certificado
 cer.package_id PACK, --C¿digo de la solicitud con que se cre¿ el certificado
 (select items_id || chr(32) || chr(45) || chr(32) || description
    FROM ge_items
   WHERE items_id = ora_rev.activity_id) ACT_CER, -- Actividad que cre¿ el certificado
 ora_rev.order_id ORD_REV, --C¿digo de la orden que cre¿ el certificado
 (select operating_unit_id || chr(32) || chr(45) || chr(32) || name
    FROM OR_operating_unit
   WHERE operating_unit_id = ord_rev.operating_unit_id) OPE_UNIT_REV, --Unidad de Trabajo que certifica
 (select PACKAGE_type_id || chr(32) || chr(45) || chr(32) || description
    FROM ps_package_type
   WHERE PACKAGE_type_id = pac_inv.package_type_id) PACK_TYPE_INV, --Tipo de solicitud que invalid¿ el certificado
 ora_inv.package_id PACK_INV, --C¿digo de la solicitud con que se invalid¿ el certificado
 (select items_id || chr(32) || chr(45) || chr(32) || description
    FROM ge_items
   WHERE items_id = ora_inv.activity_id) ACT_INV, --Actividad que invalid¿ el certificado
 ora_inv.order_id ORD_INV, --C¿digo de la orden invalid¿ el certificado
 (select operating_unit_id || chr(32) || chr(45) || chr(32) || name
    FROM OR_operating_unit
   WHERE operating_unit_id = ord_inv.operating_unit_id) OPE_UNIT_INV --Unidad de Trabajo que invalida
  FROM pr_certificate    cer,
       OR_order_activity ora, -- Actividad de revision
       OR_order          ord, -- Orden de revision
       mo_packages       pac,
       OR_order_activity ora_rev, -- Actividad que certifica
       OR_order          ord_rev, -- Orden que certifica
       OR_order_activity ora_inv, -- Actividad de invalida
       OR_order          ord_inv, -- Orden que invalida
       mo_packages       pac_inv
 WHERE ora.ORDER_ACTIVITY_ID = cer.ORDER_ACT_REVIEW_ID
   AND ora_rev.ORDER_ACTIVITY_ID = cer.ORDER_ACT_CERTIF_ID
   AND ora_inv.ORDER_ACTIVITY_ID(+) = cer.ORDER_ACT_CANCEL_ID
   AND cer.package_id = pac.package_id
   AND ora_inv.package_id = pac_inv.package_id(+)
   AND ora.order_id = ord.order_id
   AND ora_rev.order_id = ord_rev.order_id
   AND ora_inv.order_id = ord_inv.order_id(+)
   --AND cer.product_id = :inuProduct
   and ldc_getedadrp(cer.product_id) <= 54
   and rownum= 1
 ORDER BY cer.register_date desc
 
