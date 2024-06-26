select * from open.or_act_by_ele_type a;
select *
  from open.or_act_by_req_data b
 where b.item_id in (4295444, 4295445, 4295446, 4295486);
select * from open.or_act_by_req_elem c;
select *
  from open.or_act_by_task_mod d
 where d.items_id in (4295444, 4295445, 4295446, 4295486);
select * from open.or_act_insp_por_act e;
select * from ge_equivalenc_values a where a.origin_value like '%3196%'
