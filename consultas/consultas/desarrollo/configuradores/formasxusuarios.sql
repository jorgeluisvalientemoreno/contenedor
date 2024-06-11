SELECT * FROM OPEN.sa_user_roles, OPEN.sa_user, open.sa_role r WHERE r.role_id in ( SELECT role_id FROM OPEN.sa_role_executables WHERE executable_id= 
(select s.executable_id from open.sa_executable s where name='P_RECONEXION_VOLUNTARIA_100210'))
 AND sa_user_roles.user_id = sa_user.user_id
 and sa_user_roles.role_id=r.role_id
 ;
 select *
 from sa_executable
 where name='LDCCA'

select *
from open.sa_user_roles rol, open.sa_user u, open.sa_role_executables rex, open.sa_executable ex, open.sa_role x
where rol.user_id=u.user_id
  and rol.role_id=rex.role_id
  and rex.executable_id=ex.executable_id
  --and ex.name='LDCCFLOT'
  and mask='HEIMOL'
  and x.role_id=rol.role_id;
  
  select  e.executable_id,
          e.name,
          e.description,
          o.description,
          c.object_name,
          o.name_
  
from open.ge_object o, open.ge_object_process_conf c, open.sa_executable e
where upper(o.description) like upper('%desbloque%')
  and o.name_=c.object_name
  and c.executable_name=e.name;


select *
from open.ge_object_process_conf;


select c.config_xml, y.*
from ge_object_process_conf c, 
     xmltable('OBJECT_PROCESS' passing c.config_xml 
               columns b_ACCEPT_CONS_VALUE varchar2(4000) path '//PARAMETERS/PARAMETER[1]/ACCEPT_CONS_VALUE'
                       ,b_name1 varchar2(4000)  path '//PARAMETERS/PARAMETER[2]/ACCEPT_CONS_VALUE'
                        ,b_name2 varchar2(4000)  path '//PARAMETERS/PARAMETER[3]/ACCEPT_CONS_VALUE'
                         ,b_name3 varchar2(4000)  path '//PARAMETERS/PARAMETER[4]/ACCEPT_CONS_VALUE'
                         ,b_name4 varchar2(4000)  path '//PARAMETERS/PARAMETER[5]/ACCEPT_CONS_VALUE'
                         ,b_name5 varchar2(4000)  path '//PARAMETERS/PARAMETER[6]/ACCEPT_CONS_VALUE'
                       
               ) y
where c.object_name='PROPROCCESLOCK'
