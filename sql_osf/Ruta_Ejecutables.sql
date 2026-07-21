select s2.module_id modulo_forma,
       (select decode(s2.module_id,
                      4,
                      'Órdenes',
                      5,
                      'GESTIÓN DE MOTIVOS',
                      description)
          from open.ge_module
         where module_id = s2.module_id) descripcion_modulo,
       st.aplica_executable forma_padre,
       (select description
          from open.sa_executable
         where name = st.aplica_executable) descripcion_forma_padre,
       s2.name forma_hijo,
       s2.description descripcion_forma_hijo,
       case
         when (s1.name is not null) then
          s1.name
         else
          to_char(s2.executable_type_id)
       end tipo_forma,
       case
         when (s1.name is not null) then
          s1.description
         when (s2.class_id is not null) then
          'Forma .NET'
         else
          (select description
             from open.sa_executable_type
            where executable_type_id = s2.executable_type_id)
       end descripcion_tipo_forma,
       decode(s2.direct_execution, 'Y', 'SI', 'NO') ejecucion_directa,
       --s2.path ruta,
       (SELECT DISTINCT (T.aplica_executable || '/' || ex2.description)
        --ex1.last_date_executed ULTIMA_FECHA, ex1.times_executed
          FROM open.sa_tab T, open.sa_executable ex1, open.sa_executable ex2
         WHERE T.process_name = ex1.name
           AND T.tab_name = ex2.name
           AND T.PROCESS_NAME = s2.name
           AND T.aplica_executable = st.aplica_executable
           AND EX2.NAME = ST.tab_name) ruta,
       S2.last_date_executed ULTIMA_FECHA
  from open.sa_executable s1, -- tipo_forma
       open.sa_executable s2, -- hijo
       open.sa_tab        st -- padre
--    open.ldc_sa_executable_log a
 where s2.parent_executable_id = s1.executable_id(+)
   and s2.name = st.process_name(+)
      --and s2.executable_id = a.executable_id (+)
   AND (&Objeto = '-1' OR s2.name LIKE '%' || &Objeto || '%')
