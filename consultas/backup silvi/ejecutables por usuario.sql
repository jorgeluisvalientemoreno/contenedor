SELECT * FROM OPEN.sa_user_roles, OPEN.sa_user, open.sa_role r WHERE r.role_id in ( SELECT role_id FROM OPEN.sa_role_executables WHERE executable_id= 
(select s.executable_id from open.sa_executable s where name='LDC_CCGEJE'))
 AND sa_user_roles.user_id = sa_user.user_id
 and sa_user_roles.role_id=r.role_id
 ;
 

select  sa_executable.name, sa_role_executables.role_id  "Rol", sa_user_roles.user_id, ge_person.person_id, ge_person.name_, sa_user.mask     --Busqueda con nombre para id ejecutable
from open.sa_executable
inner join open.sa_role_executables on sa_role_executables.executable_id = sa_executable.executable_id
inner join open.sa_user_roles on sa_user_roles.role_id = sa_role_executables.role_id
inner join open.ge_person on ge_person.user_id = sa_user_roles.user_id
inner join open.sa_user on sa_user.user_id = ge_person.user_id
where sa_executable.name = 'LDC_CCGEJE';


select * from sa_executable sa where sa.name ='MDCCFE'
select * from sa_role_executables e
where e.executable_id =  500000000015769 for update 

;


select * 
from  open.sa_user_roles 
inner join open.ge_person on ge_person.user_id = sa_user_roles.user_id
inner join open.sa_user on sa_user.user_id = ge_person.user_id
where  MASK LIKE '%DIASAL%'
