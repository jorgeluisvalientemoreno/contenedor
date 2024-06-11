select sa_user_roles.user_id,sa_user.mask
from open.sa_user, open.sa_user_roles, open.sa_role
where sa_user.user_id=sa_user_roles.user_id
and sa_user_roles.role_id= sa_role.role_id
and exists (select 1 from open.sa_user_roles where sa_user_roles.user_id=sa_user.user_id and sa_user_roles.role_id=2)
group by sa_user_roles.user_id,sa_user.mask
having count(*)=1
