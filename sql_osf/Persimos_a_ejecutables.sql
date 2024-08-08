select se.*, rowid from sa_executable se where se.name like '%JLVPEV%';
select sr.*, rowid
  from sa_role_executables sr
 where sr.executable_id =
       (select se.executable_id
          from sa_executable se
         where se.name like '%JLVPEV%');
 
