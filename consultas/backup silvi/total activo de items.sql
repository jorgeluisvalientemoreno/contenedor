select a.operating_unit_id, open.daor_operating_unit.fsbgetname(a.operating_unit_id, null) desc_uni,
                    open.daor_operating_unit.fsbgetes_externa(a.operating_unit_id,null) externa, a.items_id,
                    open.dage_items.fsbgetdescription(a.items_id) desc_item,
                    open.dage_items.fnugetitem_classif_id(a.items_id,null) clas,a.quota, a.balance, 
                    (select balance from open.ldc_act_ouib b where a.items_id=b.items_id and a.operating_unit_id=b.operating_unit_id) cant_act, (select balance from open.ldc_inv_ouib b where a.items_id=b.items_id and a.operating_unit_id=b.operating_unit_id) cant_inv,
                   a.total_costs, (select total_costs from open.ldc_act_ouib b where a.items_id=b.items_id and a.operating_unit_id=b.operating_unit_id)cost_act, (select total_costs from open.ldc_inv_ouib b where a.items_id=b.items_id and a.operating_unit_id=b.operating_unit_id) cost_inv,
                   A.TRANSIT_IN,A.TRANSIT_OUT
from OPEN.OR_OPE_UNI_ITEM_BALA a
where a.operating_unit_id=4490
