select *
  from open.sa_user_roles       rol,
       open.sa_user             u,
       open.sa_role_executables rex,
       open.sa_executable       ex,
       open.sa_role             x
 where rol.user_id = u.user_id
   and rol.role_id = rex.role_id
   and rex.executable_id = ex.executable_id
   and ex.name = 'ORPAI'
   and mask = 'DARFER'
   and x.role_id = rol.role_id
