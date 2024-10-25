--usuario
select * from open.sa_user a where a.mask = 'ANGZEQ';

--Relacion ROL - usuario
select * from open.sa_user_roles b where b.user_id = 1951;

--Relacion ROL - usuario
select *
  from open.sa_user_roles b
  left join open.sa_user a
    on b.user_id = a.user_id
   and a.mask = 'ANGZEQ';

--ROL de usuario
select distinct sr.*
  from open.sa_role sr
 inner join open.sa_user_roles b
    on sr.role_id = sr.role_id
 inner join open.sa_user a
    on b.user_id = a.user_id
   and a.mask = 'MAUCHA';

--Relacion ROL
select sr.*, rowid
  from open.sa_role sr
 where sr.role_id in (2, 3814, 3815, 3816);

--Relacion ROL - Ejecutable
select distinct sr.*
  from open.sa_role sr
 inner join open.sa_role_executables c
    on c.role_id = sr.role_id
 inner join open.sa_executable se
    on se.executable_id = c.executable_id
   and se.name like '%LDIPA%';

--Ejecutable
select * from open.sa_executable d where d.name = 'PBIFSE';

--Relacion Usuario - ROL - Ejecutable
with rol_usuario as
 (select distinct sr.role_id, a.mask
    from open.sa_role sr
   inner join open.sa_user_roles b
      on sr.role_id = sr.role_id
   inner join open.sa_user a
      on b.user_id = a.user_id
     and a.mask = 'MAUCHA')
--Relacion ROL - Ejecutable
select distinct sr.*, se.name, ru.mask
  from open.sa_role sr
 inner join open.sa_role_executables c
    on c.role_id = sr.role_id
 inner join open.sa_executable se
    on se.executable_id = c.executable_id
   and se.name = 'LDIPA'
 inner join rol_usuario ru
    on ru.role_id = sr.role_id;
