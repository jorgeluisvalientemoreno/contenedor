select ROL.ROLE_ID,
       X.DESCRIPTION DESC_ROL,
       MASK,
       U.LAST_SUCC_LOGON_DATE,
       EX.EXECUTABLE_ID,
       EX.NAME,
       EX.DESCRIPTION,
       EX.LAST_DATE_EXECUTED,
       EX.TIMES_EXECUTED,
       P.PERSON_ID,
       P.NAME_,
       A.ORGANIZAT_AREA_ID,
       A.NAME_,
       S.account_status,
       padre.name
from open.sa_user_roles rol, open.sa_user u, open.sa_role_executables rex, open.sa_executable ex
left join open.sa_executable padre on padre.executable_id=ex.parent_executable_id
, open.sa_role x, open.ge_person p, open.ge_organizat_area a, dba_users s
where rol.user_id=u.user_id
  and rol.role_id=rex.role_id
  and rex.executable_id=ex.executable_id
  and ex.name=upper(&forma)
  and x.role_id=rol.role_id
  and p.user_id=u.user_id
  and a.organizat_area_id=p.organizat_area_id
  and p.person_id not in (1)
  and s.username=u.mask
  --and p.organizat_area_id!=200
  order by EX.NAME, X.DESCRIPTION;
  
select *
from open.sa_executable
where name=upper(&forma);

select *
from open.ge_process_schedule s, open.sa_executable e
where e.executable_id=s.executable_id
 and e.name=upper(&forma)
