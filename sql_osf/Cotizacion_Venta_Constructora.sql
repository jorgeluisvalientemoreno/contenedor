select csf.* from OPEN.CC_QUOTATION csf where csf.Package_Id = 8701753;
select mp.*, rowid from open.mo_packages mp where mp.package_id = 8701753;
select mp.*, rowid from open.mo_motive mp where mp.package_id = 8701753;
select mp.*, rowid from open.diferido mp where mp.difesusc = (select mp1.subscription_id from open.mo_motive mp1 where mp1.package_id = 8701753);
select ca.*, rowid from open.cargos ca where ca.cargnuse = (select mp1.product_id from open.mo_motive mp1 where mp1.package_id = 8701753);
select csf1.* from OPEN.cc_quotation_item csf1 where csf1.quotation_id in (select csf.quotation_id from OPEN.CC_QUOTATION csf where csf.Package_Id = 8701753);
select gi.*,rowid from open.ge_items gi where gi.items_id in (select csf1.items_id from OPEN.cc_quotation_item csf1 where csf1.quotation_id in (select csf.quotation_id from OPEN.CC_QUOTATION csf where csf.Package_Id = 8701753));
select mo_boPackages.fnugetliquidmethod(8701753) from dual;
select csf.* from OPEN.CC_SALES_FINANC_COND csf where csf.package_id = 8701753;
--select a.*, rowid from OPEN.CC_FINANCING_REQUEST a where a.financing_id = 9905640;
select a.*, rowid from OPEN.CUPON a where a.cuposusc = (select mp1.subscription_id from open.mo_motive mp1 where mp1.package_id = 8701753);
--select a.*, rowid  from OPEN.GC_DEBT_NEGOTIATION a where a.coupon_id in (176973417, 177664575, 178519584, 179276040);
SELECT /*+
                    leading(quotation)
                    use_nl(quotation item)
                    use_nl(item task_type)
                    use_nl(item ge_items)
                    use_nl(item activity)
                    index(quotation pk_cc_quotation)
                    index(item IDX_CC_QUOTATION_ITEM01)
                    index(task_type PK_OR_TASK_TYPE)
                    index(ge_items PK_ge_items)
                    index(activity pk_cc_quotation_item)
                */
 ge_items.items_id,
 decode((select mp.liquidation_method from open.mo_packages mp where mp.package_id=8701753),--mo_boPackages.fnugetliquidmethod(8701753)
        3,--or_boconstants.cnuMETODO_DELEGATE_PRICE,
        task_type.concept,
        ge_items.concept) concept,
 (item.items_quantity * item.unit_value * nvl(activity.items_quantity, 1)) AS value,
 item.items_quantity,
 'DB'
 --pkBillConst.DEBITO 
 AS sign_
  FROM /*+ CC_BCQuotationItem.cuConceptsInQuotation */ open.cc_quotation_item item,
       open.cc_quotation_item activity,
       open.ge_items,
       open.or_task_type      task_type,
       open.cc_quotation      quotation
 WHERE item.quotation_id = quotation.quotation_id
   AND quotation.quotation_id = (select csf.quotation_id from OPEN.CC_QUOTATION csf where csf.Package_Id = 8701753)
   AND task_type.task_type_id = item.task_type_id
   AND item.items_id = ge_items.items_id
   AND item.unit_value > 0
   AND item.item_parent = activity.quotation_item_id(+)
union all
SELECT /*+
                    leading(item)
                    use_nl(item ge_items)
                    use_nl(item activity)
                    index(item IDX_CC_QUOTATION_ITEM01)
                    index(ge_items PK_ge_items)
                    index(activity pk_cc_quotation_item)
                */
 ge_items.items_id,
 ge_items.discount_concept,
 (item.items_quantity * item.unit_discount_value *
 nvl(activity.items_quantity, 1)) AS value,
 item.items_quantity,
 'CR'--pkBillConst.CREDITO 
 AS sign_
  FROM /*+ CC_BCQuotationItem.cuConceptsInQuotation */ open.cc_quotation_item item,
       open.cc_quotation_item activity,
       open.ge_items
 WHERE item.quotation_id = (select csf.quotation_id from OPEN.CC_QUOTATION csf where csf.Package_Id = 8701753)
   AND item.items_id = ge_items.items_id
   AND item.unit_discount_value > 0
   AND item.item_parent = activity.quotation_item_id(+);
