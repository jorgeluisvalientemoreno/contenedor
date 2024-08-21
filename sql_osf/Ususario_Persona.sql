select *
  from open.ge_person a, open.sa_user b
 where a.user_id = b.user_id
 and b.user_id = 5916
 --a.name_ like '%HERNAN%ROMERO%'
 --and upper(b.mask) = upper('BLERAA')
