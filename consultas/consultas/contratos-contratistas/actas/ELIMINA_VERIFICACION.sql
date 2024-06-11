delete or_related_order
where rela_order_type_id=9
  and related_order_id in (18338859,17186547,18337504,17191372);


delete CT_ORDER_CERTIFICA
where order_id in (18338859,17186547,18337504,17191372);
