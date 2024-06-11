select * from ldc_inv_ouib a, or_ope_uni_item_bala b
where (a.items_id, a.operating_unit_id) in (select items_id, operating_unit_id  from OR_UNI_ITEM_BALA_MOV
                                            where item_moveme_caus_id = 16
                                            and   move_date >= to_date('10/02/2015','dd/mm/yyyy')
                                            group by items_id, operating_unit_id)
and    a.balance = 0  
and    a.items_id = b.items_id
and    a.operating_unit_id = b.operating_unit_id
and    b.balance > 0
--and    items_id = 10004070
