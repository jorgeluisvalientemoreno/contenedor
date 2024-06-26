select * from open.ge_causal g where g.causal_id = 3734;
select *
  from open.ge_class_causal g1
 where g1.class_causal_id in
       (select g.class_causal_id
          from open.ge_causal g
         where g.causal_id = 3734);
select *
  from open.ge_causal_type g2
 where g2.causal_type_id in
       (select g.causal_type_id
          from open.ge_causal g
         where g.causal_id = 3734);

select c.causal_id, c.description, c.class_causal_id --, count(1)
  from open.or_order o, open.ge_causal c
 where task_type_id = 12669
   and order_status_id = 8
   and o.legalization_date >= '01/10/2022'
   and c.causal_id = o.causal_id
   and c.class_causal_id = 1
 group by c.causal_id, c.description, c.class_causal_id
--causal de clase exito
