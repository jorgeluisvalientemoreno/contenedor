select *
from open.ge_subscriber s
where s.identification='8040178877'
  and subscriber_id=1468688;

select * from open.GE_SUBS_PHONE g where g.subscriber_id in (1468688);

select *
from open.pr_product p
where p.subs_phone_id in (select g.subs_phone_id from open.GE_SUBS_PHONE g where g.subscriber_id in (79175,1213068,1468688))
