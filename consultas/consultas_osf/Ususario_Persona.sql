select *
  from open.ge_person a, open.sa_user b
 where a.user_id = b.user_id
 and a.name_ like '%HERNAN%ROMERO%'
---   and upper(b.mask) = upper('BLERAA')
