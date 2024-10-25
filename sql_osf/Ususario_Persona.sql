select *
  from open.ge_person a, open.sa_user b
 where a.user_id = b.user_id
 --and b.user_id = 5916
 and a.name_ like '%ORLANDO%CARRILLO%'
 --and upper(b.mask) = upper('BLERAA')
