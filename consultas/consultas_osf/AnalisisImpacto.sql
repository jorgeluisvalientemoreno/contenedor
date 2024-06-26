DECLARE
  csbPrueba CONSTANT VARCHAR2(50) := 'TESTER_XXXX';
  ISBOBJETO      VARCHAR2(200) := UPPER('ldc_suspporrpusuvenc');
  nuErrorCode    NUMBER;
  sbErrorMessage VARCHAR2(4000);
  sbseparador    VARCHAR2(1) := '|';

  sbsesion VARCHAR2(100);

  CURSOR cuTraza is
    SELECT message
      FROM open.ge_log_trace
     WHERE id_session = sbsesion
     ORDER BY log_trace_id;

  PROCEDURE loop_traza is
  begin
    dbms_output.put_line('Resultado de la traza');
    for rctraza in cuTraza loop
      dbms_output.put_line(rctraza.message);
    end loop;
  
  end loop_traza;

  procedure prValidaDependen(isbObjeto in VARCHAR2) is
    sbObjQry VARCHAR2(150) := isbObjeto;
    cursor cucnthijos is
    --contando los hijos
      with objeto as
       (select o.object_id, o.object_name, o.owner, o.object_type
          from dba_objects o
         where o.object_name like ('%' || sbObjQry || '%'))
      select count(*) total
        from public_dependency pd, objeto p, dba_objects oh
       where pd.referenced_object_id = p.object_id
         and pd.object_id = oh.object_id;
    rccnthijos cucnthijos%rowtype;
  
    /*   
      cursor cucntDbDepen is
      select count(*) total
        from dba_dependencies
       where referenced_name like sbObjQry
       ;
       rccntDbDepen cucntDbDepen%rowtype;     
    */
    cursor cucntsource is
    --busca dependencias en dba_source
      with source_obj as
       (select distinct owner, name, type
          from dba_source
         where upper(text) like ('%' || sbObjQry || '%')
           and name <> sbObjQry)
      select count(*) total
        from dba_objects oh, source_obj so
       where so.owner = oh.owner
         and so.name = oh.object_name
         and so.type = oh.object_type;
    rccntsource cucntsource%rowtype;
  
    cursor cucntObject is
      select count(*) total
        from ge_object
       where upper(name_) like ('%' || sbObjQry || '%');
    rccntObject cucntObject%rowtype;
  
    cursor cucntSchedule is
      select count(*) total
        from dba_scheduler_jobs
       where upper(job_Action) like ('%' || sbObjQry || '%');
    rccntSchedule cucntSchedule%rowtype;
  
    cursor cucntConfExp is
      select count(*) total
        from gr_config_expression
       where upper(code) like ('%' || sbObjQry || '%')
          or upper(expression) like ('%' || sbObjQry || '%')
          or upper(object_name) like ('%' || sbObjQry || '%');
    rccntConfExp cucntConfExp%rowtype;
  
    cursor cucntLdcProcObj is
      select count(*) total
        from ldc_procedimiento_obj
       where upper(procedimiento) like ('%' || sbObjQry || '%');
  
    rccntLdcProcObj cucntLdcProcObj%rowtype;
  
    cursor cucntHomoServi is
      select count(*) total
        from homologacion_servicios
       where upper(servicio_origen) like ('%' || sbObjQry || '%')
          or upper(servicio_destino) like ('%' || sbObjQry || '%');
    rccntHomoServi cucntHomoServi%rowtype;
  
    cursor cucntstatement is
      select count(*) total
        from ge_statement
       where upper(statement) like ('%' || sbObjQry || '%');
    rccntstatement cucntstatement%rowtype;
  
    cursor cucntDistributionFile is
      select count(*) total
        from ge_distribution_file df
       where upper(extract(df.app_xml, '/').getclobval()) like
             ('%' || sbObjQry || '%');
    rccntDistributionFile cucntDistributionFile%rowtype;
  
  begin
  
    open cucnthijos;
    fetch cucnthijos
      into rccnthijos;
    close cucnthijos;
  
    /*   
     open cucntDbDepen;
       fetch cucntDbDepen into rccntDbDepen;
     close cucntDbDepen;
    */
  
    open cucntsource;
    fetch cucntsource
      into rccntsource;
    close cucntsource;
  
    open cucntObject;
    fetch cucntObject
      into rccntObject;
    close cucntObject;
  
    open cucntSchedule;
    fetch cucntSchedule
      into rccntSchedule;
    close cucntSchedule;
  
    open cucntConfExp;
    fetch cucntConfExp
      into rccntConfExp;
    close cucntConfExp;
  
    open cucntLdcProcObj;
    fetch cucntLdcProcObj
      into rccntLdcProcObj;
    close cucntLdcProcObj;
  
    open cucntHomoServi;
    fetch cucntHomoServi
      into rccntHomoServi;
    close cucntHomoServi;
  
    open cucntstatement;
    fetch cucntstatement
      into rccntstatement;
    close cucntstatement;
  
    open cucntDistributionFile;
    fetch cucntDistributionFile
      into rccntDistributionFile;
    close cucntDistributionFile;
  
    /*   pkg_traza.setlevel(99);----establece el nivel de traza a mostrar    
    pkg_traza.Init;--Borra las trazas generadas anteriormente para session current
    
    pkg_traza.traza_dbms_output;--genera la traza en dbms_output   
    */
    pkg_traza.trace(sbseparador || 'Resultado dependencia para objeto:' ||
                    sbObjQry);
    pkg_traza.trace(sbseparador || 'hijos en PUBLIC_DEPENDENCY         :' ||
                    rccnthijos.total);
    --  pkg_traza.trace('hijos en DBA_DEPENDENCIES          :'||rccntDbDepen.total);
    pkg_traza.trace(sbseparador || 'Llamados en DBA_SOURCES            :' ||
                    rccntsource.total);
    pkg_traza.trace(sbseparador || 'Registros en GE_OBJECT             :' ||
                    rccntObject.total);
    pkg_traza.trace(sbseparador || 'Registros en DBA_SCHEDULER_JOBS    :' ||
                    rccntSchedule.total);
    pkg_traza.trace(sbseparador || 'Llamados en GR_CONFIG_EXPRESSION   :' ||
                    rccntConfExp.total);
    pkg_traza.trace(sbseparador || 'Llamados en GE_STATEMEN            :' ||
                    rccntstatement.total);
    pkg_traza.trace(sbseparador || 'Llamados en GE_DISTRIBUTION_FILE   :' ||
                    rccntDistributionFile.total);
    pkg_traza.trace(sbseparador || 'Registros en LDC_PROCEDIMIENTO_OBJ :' ||
                    rccntLdcProcObj.total);
    pkg_traza.trace(sbseparador || 'Registros en HOMOLOGACION_SERVICIOS:' ||
                    rccntHomoServi.total);
  
  end prValidaDependen;

begin
  sbsesion := SYS_CONTEXT('USERENV', 'SESSIONID');
  dbms_output.put_line('Sesión para la traza:' || sbsesion);
  pkg_traza.setlevel(99); ----establece el nivel de traza a mostrar    
  pkg_traza.Init; --Borra las trazas generadas anteriormente para session current
  pkg_traza.traza_tabla; --Indica que la traza se inserta en la tabla ge_log_trace
  --pkg_traza.traza_dbms_output;--genera la traza en dbms_output

  pkg_traza.trace('Incio de la prueba funcionalidad: ' || csbPrueba, 1);

  PRVALIDADEPENDEN(ISBOBJETO => ISBOBJETO);

  --Llamado a proceso para la prueba 
  -------------------------------------------------------------
  -------------------------------------------------------------
  pkg_traza.trace('Fin OK de la prueba funcionalidad: ' || csbPrueba, 1);
  loop_traza;
exception
  WHEN pkg_Error.CONTROLLED_ERROR THEN
    pkg_traza.trace('Fin con ERROR CONTROLADO de la prueba funcionalidad: ' ||
                    csbPrueba,
                    1);
    pkg_Error.GETERROR(nuErrorCode, sbErrorMessage);
    dbms_output.put_line('---------------error----------------------');
    dbms_output.put_line(nuErrorCode || '-' || sbErrorMessage);
    dbms_output.put_line('------------------------------------------');
    loop_traza;
  when others then
    pkg_traza.trace('Fin con ERRORES de la prueba funcionalidad: ' ||
                    csbPrueba,
                    1);
    loop_traza;
END;
/
