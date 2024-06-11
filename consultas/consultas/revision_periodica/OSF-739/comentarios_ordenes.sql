select or_order.order_id,
       or_order_comment.comment_type_id,
       or_order_comment.order_comment,
       or_order_comment.register_date
  from or_order
  left join open.or_order_comment on or_order_comment.order_id = or_order.order_id
 where or_order.order_id in (260907781)
 order by or_order_comment.register_date desc
