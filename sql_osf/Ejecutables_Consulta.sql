select a1.* from open.SA_EXECUTABLE a1 where upper(a1.description) like upper('%Anulaci%n de Solicitudes%');
select /*a.executable_id,
       a.name,
       a.description,
       a.executable_type_id,
       a.module_id,
       a.parent_executable_id*/
 *
  from open.SA_EXECUTABLE a
 inner join open.SA_EXECUTABLE_TYPE b
    on a.executable_type_id = b.executable_type_id
   and upper(a.description) like upper('%CCGPA%');
select a1.*
  from open.SA_EXECUTABLE a1
 where a1.executable_id in
       (select *--a.parent_executable_id
          from open.SA_EXECUTABLE a
         inner join open.SA_EXECUTABLE_TYPE b
            on a.executable_type_id = b.executable_type_id
           and a.name = upper('CCGPA'));
