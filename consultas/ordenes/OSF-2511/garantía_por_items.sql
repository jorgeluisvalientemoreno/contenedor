--- garantía_por_items
Select t.item_warranty_id, t.item_id, ii.description,   t.product_id, t.order_id, t.final_warranty_date, t.is_active
From ge_item_warranty t, ge_items  ii
Where t.item_id = ii.items_id
And  t.product_id in (52851566)
And   t.final_warranty_date >= sysdate
