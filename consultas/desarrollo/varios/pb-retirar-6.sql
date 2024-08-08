WITH BASE AS(
            select executable_id,
            nvl((select substr(name,-2,2) from OPEN.sa_executable b where b.executable_id = s.parent_executable_id), (select 'TRAMITE' from open.ps_package_type where tag_name=name)) tipo,
            name,description,
            (select case when module_id < 0 then abs(module_id) else module_id end||'-'||description from OPEN.ge_module g where module_id = s.module_id) module_id,
            '' ultimamod, '' estado,'' entrega, '' nota,
            s.last_date_executed
            from OPEN.sa_executable s

            )
      , base2 as(
            SELECT base.executable_id,
                   base.tipo,
                   base.name nombre,
                   base.description descripcion,
                   base.module_id modulo,
                   CASE 
                     WHEN TIPO='TRAMITE' THEN (SELECT MAX(REQUEST_DATE) FROM MO_PACKAGES P WHERE P.TAG_NAME=NAME) 
                    ELSE base.last_date_executed END "Fecha Ultima Ejecución",
                   (select max(start_date_) from open.ge_process_schedule s where s.executable_id=base.executable_id),
                   (select count(1) from open.ge_process_schedule s where s.executable_id=base.executable_id and job!=-1) "Programaciones Activas",
                   extractvalue(app_xml, 'PB/APPLICATION/ALLOW_SCHEDULE') es_programable ,distribution_file_id, extractvalue(app_xml, 'PB/APPLICATION/OBJECT_NAME') proceso
            FROM BASE
            left join ge_distribution_file f on f.distribution_file_id=base.name
            WHERE    name in ('LDRPQRSUIB','DLROTTT','DLRIGCV','DLRMTUS','LDRITAN','NOTICAL','LDCPAMM','AOPCA','PBAIS','LDRPATE','ELEX','LDCDBS','LDCIGINT','LDCIGINTMES','LDCINTACTAS','LDCINTCONSUMO','LDCINTPROCOS','LDCINTREPROV','LDCIREPINTCONTL','LDCIREPLICACECO','LDCIREVCLACART')
             
              )
 select base2.*,
        case when "Fecha Ultima Ejecución" is not null then 'Se ejecuto por ultima vez '||"Fecha Ultima Ejecución" else 'No tiene fecha de ultimo acceso, lo cual indica que nunca se ha usado.' end ultima_ejecucion
 from base2;
 
 select EX.EXECUTABLE_ID,
       EX.NAME,
       EX.DESCRIPTION,
       EX.LAST_DATE_EXECUTED,
       EX.TIMES_EXECUTED,
       x.role_id,
       X.DESCRIPTION DESC_ROL
from open.sa_executable ex
left join open.sa_role_executables rex on rex.executable_id=ex.executable_id
left join open.sa_role x on rex.role_id = x.role_id
where ex.name in ('LDRPQRSUIB','DLROTTT','DLRIGCV','DLRMTUS','LDRITAN','NOTICAL','LDCPAMM','AOPCA','PBAIS','LDRPATE','ELEX','LDCDBS','LDCIGINT','LDCIGINTMES','LDCINTACTAS','LDCINTCONSUMO','LDCINTPROCOS','LDCINTREPROV','LDCIREPINTCONTL','LDCIREPLICACECO','LDCIREVCLACART')

  order by EX.NAME, X.DESCRIPTION;
