select a1.executable_id,
       a1.name || ' - ' ||
       a1.description Ejecutable,
       a1.path,
       a1.version,
       a1.executable_type_id,
       a1.exec_oper_type_id,
       a1.module_id || ' - ' || gm.description Modulo,
       a1.subsystem_id,
       a1.parent_executable_id,
       a1.last_record_allowed,
       a1.path_file_help,
       a1.without_restr_policy,
       a1.direct_execution,
       a1.times_executed,
       a1.exec_owner,
       a1.last_date_executed,
       a1.class_id
  from open.SA_EXECUTABLE a1
 inner join open.ge_module gm
    on gm.module_id = a1.module_id
 where 
 --a1.name = 'LDCAPSOMA'
 upper(a1.description) like upper('%Solicitud%Material%')
 ;

select a1.*
  from open.SA_EXECUTABLE a1
 where upper(a1.description) like upper('%cambio%direcci%');
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
       (select * --a.parent_executable_id
          from open.SA_EXECUTABLE a
         inner join open.SA_EXECUTABLE_TYPE b
            on a.executable_type_id = b.executable_type_id
           and a.name = upper('CCGPA'));
