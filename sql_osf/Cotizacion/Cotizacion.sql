select a.*, rowid from OPEN.CC_QUOT_ITEM_VALUES a where a.quotation_item_id in (select a1.quotation_item_id from OPEN.CC_QUOTATION_ITEM a1 where a1.quotation_id = 28096);
select a.*, rowid from OPEN.CC_QUOTATION_ITEM a where a.quotation_id = 28096;
select a.*, rowid from OPEN.CC_QUOTATION a where a.package_id =228969034;
select a.*, rowid from OPEN.CC_QUOT_FINANC_COND a where a.quotation_id =28096;
select a.*, rowid from OPEN.CC_QUOTED_WORK a where a.quotation_id =28096;
select a.*, rowid from OPEN.CC_QUOT_FINANC_COND a where a.quotation_id =28096;
select a.*, rowid from OPEN.MO_PACKAGES_ASSO a where a.package_id = 228969034;
select a.*, rowid from OPEN.LDC_COTIZACION_COMERCIAL a where a.sol_cotizacion in (228791231,228969035);
select a.*, rowid from OPEN.LDC_ITEMS_COTIZACION_COM a where a.id_cot_comercial = 9655;  

