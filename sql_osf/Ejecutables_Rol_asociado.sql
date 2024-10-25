select se.executable_id || ' - ' || se.name || ' [' || se.description || ']' Ejecutable,
       sr.role_id || ' - ' || sr.name Rol,
       su.user_id || ' - ' || su.mask Funcional_Mask,
       gp.person_id || ' - ' || gp.name_ Funcional_OSF,
       gp.name_ Funcional,
       se.executable_type_id || ' - ' ||
       (select set_.name || ' [' || set_.description || ']'
          from OPEN.SA_EXECUTABLE_TYPE set_
         where set_.executable_type_id = se.executable_type_id) Tipo_Ejecutale,
       se.module_id || ' - ' ||
       (select gm.description
          from OPEN.GE_MODULE gm
         where gm.module_id = se.module_id) Modulo,
       se.parent_executable_id || ' - ' ||
       (select se_.name
          from open.sa_executable se_
         where se_.executable_id = se.parent_executable_id) Ejecutable_Padre,
       decode(se.direct_execution, 'Y', 'Si', 'No') Ejecucion_Directa,
       se.times_executed Nuemero_Ejecuciones,
       se.exec_owner Propietario,
       se.last_date_executed ultima_Ejecucion,
       se.class_id || ' - ' ||
       (select gc.namespace || ' [' || gc.type_name || ']'
          from OPEN.GI_CLASS gc
         where gc.class_id = se.class_id) Clase
  from open.sa_executable       se,
       open.sa_role_executables sre,
       open.sa_role             sr,
       open.sa_user_roles       sur,
       open.sa_user             su,
       open.ge_person           gp
 where sre.executable_id = se.executable_id
   and sr.role_id = sre.role_id
   and sur.role_id = sre.role_id
   and sur.user_id = su.user_id
   and su.user_id = gp.user_id
      --and se.executable_id = 500000000000001
   and se.executable_type_id not in (10)
   --and gp.name_ like '%HULBER%'
   and se.name = 'CCQUO'
 order by se.last_date_executed desc;
select EX.EXECUTABLE_ID,
       EX.NAME,
       EX.DESCRIPTION,
       EX.LAST_DATE_EXECUTED,
       EX.TIMES_EXECUTED,
       x.role_id,
       X.DESCRIPTION DESC_ROL
  from open.sa_executable ex
  left join open.sa_role_executables rex
    on rex.executable_id = ex.executable_id
  left join open.sa_role x
    on rex.role_id = x.role_id
--where ex.name in ('RPSUI')
 order by EX.NAME, X.DESCRIPTION;
select s.*, r.name
  from OPEN.SA_ENT_ROLE_EXEC s, open.sa_role r
 where s.enabled = 'Y'
      --and s.executable_id = 500000000000001
   and s.role_id = r.role_id;
