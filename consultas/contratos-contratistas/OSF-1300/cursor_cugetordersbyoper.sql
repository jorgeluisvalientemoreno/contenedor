--cursor_cugetordersbyoper(inuYear IN NUMBER,
--                         inuMonth IN NUMBER,
--                         inuOperatingUnit IN or_operating_unit.operating_unit_id%type) is
    SELECT oo.order_id,
    oo.legalization_date,
    ooa.activity_id,
        oo.operating_unit_id,
        oo.order_status_id,
        saved_data_values,
        oo.is_pending_liq,
        ooi.items_id,
        ooi.legal_item_amount,
        ooi.value,
        oo.order_value/*,
        count (oo.order_id)*/
    FROM or_order oo,
     or_order_activity ooa,
     or_order_items ooi,
     ab_address aa
    where oo.order_id = ooa.order_id
    and oo.order_id = ooi.order_id
    and oo.EXTERNAL_ADDRESS_ID = aa.ADDRESS_ID
    and EXTRACT(YEAR FROM oo.legalization_date) = 2023 
   and EXTRACT(MONTH FROM oo.legalization_date) = 7 
   and oo.task_type_id = 12617
   AND oo.operating_unit_id IN (1888,1889,1890,4439,4440,4441)
    AND oo.order_status_id = 8
    and ooi.items_id in (SELECT to_number(regexp_substr('100004427,100004429,100004431,100010088'  , --100007128,
                        '[^,]+',
                      1,
                      LEVEL)) AS COD_ITEMS_LECTURA_INDUS
             FROM dual
             CONNECT BY regexp_substr('100004427,100004429,100004431,100010088' , '[^,]+', 1, LEVEL) IS NOT NULL) --100007128,
   and nvl(oo.IS_PENDING_LIQ,'N') = 'N'
    and oo.saved_data_values is null
   /* group by ooa.activity_id,
        oo.operating_unit_id,
        oo.order_status_id,
        saved_data_values,
        oo.is_pending_liq,
        ooi.items_id,
        ooi.legal_item_amount,
        ooi.value,
        oo.order_value*/
