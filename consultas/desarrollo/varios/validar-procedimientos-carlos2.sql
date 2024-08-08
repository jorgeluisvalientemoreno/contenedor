declare
  cursor cuObjeto is
    select object_type, object_name, decode(object_type, 'PACKAGE', object_name||'.',object_name) nombre
    from dba_objects
    where object_type in ('PACKAGE','PROCEDURE','FUNCTION','TRIGGER')
      and object_name=upper('LDCI_PKREVISIONPERIODICAWEB');
   --------------------------------------------------------------------------------------------------------------   
   procedure schedule(sbNombre in varchar2) is
     cursor cuCursor is
     select *
     from dba_scheduler_jobs
     where upper(job_action) like upper('%'||sbNombre||'%');
   begin
     dbms_output.put_line('INICIA SCHEDULE');
     for reg in cuCursor loop
       dbms_output.put_line(reg.job_name||'|'||reg.job_action||'|'||reg.state||'|'||reg.LAST_START_DATE);
     end loop;
     dbms_output.put_line('FIN SCHEDULE');
   end;
   ----------------------------------------------------------------------------------------------------------------
   procedure ejecutable(sbNombre in varchar2) is
     cursor cuCursor is
     select e.name, e.description, e.exec_owner, e.last_date_executed, s.job, j.LAST_DATE
     from open.sa_executable e
     left join open.ge_process_schedule s on s.EXECUTABLE_ID=e.executable_id and s.job!=-1
     left join dba_jobs j on j.job=s.job 
     where upper(name) like upper('%'||sbNombre||'%');
   begin
     dbms_output.put_line('INICIA EJECUTABLE');
     dbms_output.put_line('nombre|propietario|fecha_ultima_ejec|job|fecha_job');
     for reg in cuCursor loop
       dbms_output.put_line(reg.name||'|'||reg.exec_owner||'|'||reg.last_date_executed||'|'||reg.job||'|'||reg.last_date);
     end loop;
     dbms_output.put_line('FIN EJECUTABLE');
   end;
   -----------------------------------------------------------------------------------------------------------------------------
   procedure ge_object(sbNombre in varchar2) is
     cursor cuCursor is
        select o.name_, o.description, o.object_type_id ||' '||t.description tipo, e.job, j.last_date
          from open.ge_object o
          inner join open.ge_object_type t on t.object_type_id=o.object_type_id
          left join open.ge_process_schedule e on e.parameters_ like 'OBJECT_ID='||o.object_id and e.job!=-1
          left join dba_jobs j on j.job=e.job
          where upper(name_) like upper(sbNombre||'%');
   begin
     dbms_output.put_line('INICIA GE_OBJECT');
     dbms_output.put_line('nombre|descripcion|tipo_objeto|job|fecha_job');
     for reg in cuCursor loop
       dbms_output.put_line(reg.name_||'|'||reg.description||'|'||reg.tipo||'|'||reg.job||'|'||reg.last_date);
     end loop;
     dbms_output.put_line('FIN GE_OBJECT');
   end;
   -----------------------------------------------------------------------------------------------------------------------------   
   procedure jobs(sbNombre in varchar2) is
     cursor cuCursor is
       select *
        from dba_jobs
        where upper(what) like upper('%'||sbNombre||'%');
   begin
     dbms_output.put_line('INICIA DBA_JOBS');
     dbms_output.put_line('job|job_action|fecha_job|broken');
     for reg in cuCursor loop
       dbms_output.put_line(reg.job||'|'||reg.what||'|'||reg.last_date||'|'||reg.broken);
     end loop;
     dbms_output.put_line('FIN DBA_JOBS');
   end;
   -----------------------------------------------------------------------------------------------------------------------------   
   procedure consultaPb(sbNombre in varchar2) is
     cursor cuCursor is
       select df.distribution_file_id ejec, e.description, e.exec_owner, e.last_date_executed, s.job, j.LAST_DATE
        from open.ge_distribution_file df
        left join open.sa_executable e on e.name=df.distribution_file_id
        left join open.ge_process_schedule s on s.EXECUTABLE_ID=e.executable_id and s.job!=-1
        left join dba_jobs j on j.job=s.job 
        where upper(extract(df.app_xml, '/').getclobval()) like  upper('%'||sbNombre||'%');      
   begin
     dbms_output.put_line('INICIA PB');
     dbms_output.put_line('nombre|propietario|fecha_ultima_ejec|job|fecha_job');
     for reg in cuCursor loop
       dbms_output.put_line(reg.ejec||'|'||reg.exec_owner||'|'||reg.last_date_executed||'|'||reg.job||'|'||reg.last_date);
     end loop;
     dbms_output.put_line('FIN PB');
   end;
   -----------------------------------------------------------------------------------------------------------------------------   
   procedure sentencias(sbNombre in varchar2) is
     cursor cuCursor is
       select *
        from open.ge_statement
       where upper(statement) like  upper('%'||sbNombre||'%');      
   begin
     dbms_output.put_line('INICIA SENTENCIAS');
     dbms_output.put_line('statement_id');
     for reg in cuCursor loop
       dbms_output.put_line(reg.statement_id);
     end loop;
     dbms_output.put_line('FIN SENTENCIAS');
   end;
   -----------------------------------------------------------------------------------------------------------------------------   
   procedure sa_tab(sbNombre in varchar2) is
     cursor cuCursor is
       select aplica_executable, process_name,  e.description, e.exec_owner, e.last_date_executed, s.job, j.LAST_DATE
        from open.sa_tab
        left join open.sa_executable e on e.name=process_name
        left join open.ge_process_schedule s on s.EXECUTABLE_ID=e.executable_id and s.job!=-1
        left join dba_jobs j on j.job=s.job 
       where upper(condition) like upper('%'||sbNombre||'%');      
   begin
     dbms_output.put_line('INICIA SA_TAB');
     dbms_output.put_line('APLICA_EXECUTABLE|PROCESS_NAME|DESCRIPCION|EXEC_OWNER|LAST_DATE_EXECUTED|JOB|LAST_DATE');
     for reg in cuCursor loop
       dbms_output.put_line(reg.aplica_executable||'|'||reg.process_name||'|'||reg.description||'|'||reg.exec_owner||'|'||reg.last_date_executed||'|'||reg.job||'|'||reg.last_date);
     end loop;
     dbms_output.put_line('FIN SA_TAB');
   end;
   -----------------------------------------------------------------------------------------------------------------------------   
   procedure plugin(sbNombre in varchar2) is
     cursor cuCursor is
       select upper(procedimiento) procedimiento, activo
        from open.ldc_procedimiento_obj
        where trim(upper(procedimiento)) like upper('%'||sbNombre||'%');
     
   begin
     dbms_output.put_line('INICIA PLUGIN');
     dbms_output.put_line('PROCEDIMIENTO|ACTIVO');
     for reg in cuCursor loop
       dbms_output.put_line(reg.procedimiento ||'|'||reg.activo);
     end loop;
     dbms_output.put_line('FIN PLUGIN');
   end;
   -----------------------------------------------------------------------------------------------------------------------------   
   procedure ofertados(sbNombre in varchar2) is
     cursor cuCursor is
       select *
        from open.ldc_tipos_ofertados
        where upper(procedimiento_ejecutar)  like upper('%'||sbNombre||'%');
     
   begin
     dbms_output.put_line('INICIA OFERTADOS');
     dbms_output.put_line('DESCRIPCION|PROCEDIMIENTO');
     for reg in cuCursor loop
       dbms_output.put_line(reg.descripcion ||'|'||reg.procedimiento_ejecutar);
     end loop;
     dbms_output.put_line('FIN OFERTADOS');
   end;
   -----------------------------------------------------------------------------------------------------------------------------   
   procedure consultasPI(sbNombre in varchar2) is
     cursor cuCursor is
       select e2.name, upper(ad.child_parent_service) child_parent_service, upper(ad.parent_child_service) parent_child_service , NULL SERVICIO3
        from OPEN.GI_COMPOSITION_ADITI AD
        inner join open.gi_composition c on c.composition_id=ad.composition_id
        inner join open.gi_config con on con.config_id=c.config_id
        inner join open.sa_executable e2 on e2.executable_id= con.external_root_id
        where upper(ad.child_parent_service) like upper('%'||sbNombre||'%')
          or upper(ad.parent_child_service) like upper('%'||sbNombre||'%')
        UNION
        select distinct  e2.name, upper(QUERY_SERVICE_NAME) QUERY_SERVICE_NAME, upper(PROCESS_SERVICE_NAME) PROCESS_SERVICE_NAME,upper(SEARCH_SERVICE_NAME) SEARCH_SERVICE_NAME
   from OPEN.GE_ENTITY_ADITIONAL AD
   INNER JOIN OPEN.GE_ENTITY E ON E.ENTITY_ID=AD.ENTITY_ID
   INNER JOIN open.gi_composition co on tag_name=e.name_
   inner join open.gi_config gi on gi.config_id=co.config_id
   inner join open.sa_executable e2 on e2.executable_id= gi.external_root_id
   where upper(QUERY_SERVICE_NAME)  like upper('%'||sbNombre||'%')
   OR upper(PROCESS_SERVICE_NAME) like upper('%'||sbNombre||'%')
   OR upper(SEARCH_SERVICE_NAME) like upper('%'||sbNombre||'%');
   
     
   begin
     dbms_output.put_line('INICIA PI');
     dbms_output.put_line('NOMBRE_EJECUABLE|SERVICIO1|SERVICIO2|SERVICIO3');
     for reg in cuCursor loop
       dbms_output.put_line(reg.name||'|'||reg.child_parent_service||'|'||reg.parent_child_service||reg.servicio3);
     end loop;
     dbms_output.put_line('FIN PI');
   end;
   -----------------------------------------------------------------------------------------------------------------------------   
   procedure consultasFCED(sbNombre in varchar2) is
     cursor cuCursor is
       with base as(
            select ef.formcodi,
                   ef.formdesc,
                   ef.formtido,
                   ef.formiden,
                   ef.formtico,
                   c.coemcodi,
                   c.coemdesc,
                   c.coemtido,
                   c.coempada,
                   fr.francodi,
                   fr.frandesc,
                   f.frfoorde,
                   f.frfomult,
                   b.blfrcodi,
                   bl.bloqcodi,
                   bl.bloqdesc,
                   bl.bloqiden,
                   bl.bloqfuda,
                   fd.fudaserv,
                   fd.fudasent,
                   b.blfrorde,
                   b.blfrmult,
                   b.blfrsait,
                   i.itemcodi,
                   i.itemdesc,
                   i.itematfd, 
                   itbl.itblblfr,
                   itbl.itblorde,
                   itbl.itbliden
            from open.ed_formato ef 
            left join open.ed_confexme c on ef.formiden=c.coempada
            left join open.ed_franform f on f.frfoform=ef.formcodi
            left join open.ed_franja fr on fr.francodi=f.frfofran
            left join open.ed_bloqfran b on f.frfocodi = b.blfrfrfo
            left join open.ed_bloque bl on  b.blfrbloq = bl.bloqcodi
            left join open.ed_fuendato fd on fd.fudacodi=bl.bloqfuda
            left join open.ed_itembloq itbl on itbl.itblblfr=b.blfrcodi
            left join open.ed_item i on i.itemcodi=itbl.itblitem
            order by frfoorde, blfrorde, itblorde)
            select distinct formdesc
            from base
            where upper(fudaserv) like upper('%'||sbNombre||'%');
     
   begin
     dbms_output.put_line('INICIA FCED');
     dbms_output.put_line('NOMBRE_FORMATO|');
     for reg in cuCursor loop
       dbms_output.put_line(reg.formdesc);
     end loop;
     dbms_output.put_line('FIN FCED');
   end;
   -----------------------------------------------------------------------------------------------------------------------------  
   procedure executeInmmediate(sbNombre in varchar2) is
     cursor cuCursor is
      Select  d.name
    from DBA_SOURCE d
    where UPPER(text) like 'EXECUTE'||'%'||sbNombre||'%' 
    and owner = 'OPEN' 
    and type IN ('PACKAGE BODY','FUNCTION','PROCEDURE');
            
     
   begin
     dbms_output.put_line('INICIA EXECUTE');
     dbms_output.put_line('NOMBRE');
     for reg in cuCursor loop
       dbms_output.put_line(reg.name);
     end loop;
     dbms_output.put_line('FIN EXECUTE');
   end;
   -----------------------------------------------------------------------------------------------------------------------------   
   procedure dependencias(sbNombre in varchar2) is
     cursor cuCursor is
     select *
      from dba_dependencies
      where referenced_name = upper(sbNombre)
        and name!=referenced_name;
            
     
   begin
     dbms_output.put_line('INICIA DEPENDENCIAS');
     dbms_output.put_line('NOMBRE');
     for reg in cuCursor loop
       dbms_output.put_line(reg.NAME);
     end loop;
     dbms_output.put_line('FIN DEPENDENCIAS');
   end;
   -----------------------------------------------------------------------------------------------------------------------------                   
                       
                         
                   
                   
                

begin
   for reg in cuObjeto loop
      dbms_output.put_line('Nombre: '||reg.nombre);
      schedule(reg.nombre);
      ejecutable(reg.nombre);
      ge_object(reg.nombre);
      jobs(reg.nombre);
      consultaPb(reg.nombre);
      sentencias(reg.nombre);
      sa_tab(reg.nombre);
      plugin(reg.nombre);
      ofertados(reg.nombre);
      consultasPI(reg.nombre);
      consultasFCED(reg.nombre);
      executeInmmediate(reg.nombre);
      dependencias(reg.object_name);
   end loop;
end;
/
