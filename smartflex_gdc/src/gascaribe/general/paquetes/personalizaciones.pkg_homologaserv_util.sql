create or replace package personalizaciones.pkg_homologaserv_util is
/*
Autor: Edilay Peña Osorio  - Global MVM. 
Fecha: 21/11/2023
Descripción: 
  Métodos para validar dependencias de un objeto. 
  
  Modo de uso:
  Los procedimientos escriben la información en la tabla:
  ge_log_trace, por lo tanto se debe activar la traza
  para ver la información, con las siguientes líneas en un tester
  antes de llamar alguno de los métodos el resultado del procedimiento 
  se escribirá en el dbms_output:
      pkg_traza.setlevel(99);----establece el nivel de traza a mostrar    
      pkg_traza.Init;--Borra las trazas generadas anteriormente para session current
      pkg_traza.traza_dbms_output;--genera la traza en dbms_output

  Autor           Fecha     Descripicón
-------------   ----------  -------------------------------------------------------------------
    epenao      15/01/2024  OSF-2186 Modificación de las sentencias para que ordenen por nombre de objeto
                                     y se valide el nombre de cambio en el objeto y así imprimir el 
                                     encabezado, esto para identificar casos en los que se 
                                     comparten gra parte del nombre, ejemplo:
                                       LDC_PKCM_LECTESP
                                       LDC_PKCM_LECTESP8
                                       LDC_PKCM_LECTESP9
                                    Se ajusta la consulta de objetos a homologar para que en lugar 
                                    de partir de la tabla public_dependency tome de 
                                    HOMOLOGACION_SERVICIOS el servicio a homologar y lo busque en el fuente 
                                    dba_source del objeto.
*/    
   
    --Escribe cuántos objetos están usando el objeto enviado    
    procedure prValidaDependen (isbObjeto in VARCHAR2);

    --Escribe el detalle de los objetos que usan el objeto enviado
    procedure prdetalleDependen (isbObjeto in VARCHAR2);
    
    --Escribe los objetos a homologar que está usando el objeto enviado
    procedure prValidaHomologa (isbObjeto in VARCHAR2);

    --Escribe la líne en que los objetos a homologar que está usando el objeto enviado
    procedure prValidaHomologaLinea (isbObjeto in VARCHAR2);
    
    --Escribe todos los objetos que está usando el objeto enviado
    procedure prValidaUsados   (isbObjeto in VARCHAR2);

    --Escribe todos los objetos que está usando el objeto enviado
    procedure prValidaUsadosLinea   (isbObjeto in VARCHAR2);
    
    --Escribe los objetos no homologados que usa el objeto enviado
    procedure prValidaUsadoNoHomologa (isbObjeto in VARCHAR2);

    --Retorna los objetos propios de producto que está usando 
    procedure prValidaProducto (isbobjeto in varchar2);


end pkg_homologaserv_util;

/
create or replace package body personalizaciones.pkg_homologaserv_util is
csbNOMPKG    	CONSTANT VARCHAR2(35):= $$PLSQL_UNIT||'.'; -- Constantes para el control de la traza
csbTagErr     CONSTANT VARCHAR2(30):= 'ERROR: ';
sbseparador   varchar2(1) := '|';
nuCodError    NUMBER;
sbMensErro    VARCHAR2(4000);


function fsbObjeto(isbObjeto in VARCHAR2) return VARCHAR2 is
/******************************************************************************************
Función: fsbObjeto
Autor: Edilay Peña Osorio  - Global MVM. 
Fecha: 21/11/2023
Descripción:
Retorna la cadena en mayúscula y en medio del comodín de búsqueda '%'

*******************************************************************************************/
  csbMetodo  CONSTANT VARCHAR2(100) := csbNOMPKG||'fsbObjeto'; --Nombre del método en la traza
  sbobjeto VARCHAR2(150);
  
begin
   pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbINICIO);
    sbobjeto := '%'||UPPER(isbObjeto)||'%';
   pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN);
   RETURN sbobjeto;  
  
EXCEPTION
    WHEN OTHERS THEN
        pkg_error.SetError; 
        pkg_error.geterror (nuCodError, sbMensErro);
        pkg_traza.trace(csbTagErr||nuCodError||'-'||sbMensErro,pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(csbMETODO, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
end fsbObjeto;

procedure prdetalleDependen  (isbObjeto in VARCHAR2) is 
/******************************************************************************************
Método: prdetalleDependen
Autor: Edilay Peña Osorio  - Global MVM. 
Fecha: 21/11/2023
Descripción:
Busca el objeto enviado en las tablas: 
    +public_dependency
    +dba_source
    +ge_object
    +gr_config_expression
    +ldc_procedimiento_obj
    +homologacion_servicios
    +ge_statement
    +ge_distribution_file
Imprime por cada tabla la información que encuentra con el fin de que se evalúe su uso
*******************************************************************************************/
    csbMetodo  CONSTANT VARCHAR2(100) := csbNOMPKG||'prdetalleDependen'; --Nombre del método en la traza
    sbObjQry  VARCHAR2(150) :=  fsbObjeto(isbObjeto);
    cursor cuhijos is 
    --buscando los hijos en public_dependency
    with objeto as
    (
       select o.object_id, o.object_name, o.owner, o.object_type
         from dba_objects o
        where o.object_name like sbObjQry
    )
    select p.object_id ID_PADRE, p.object_name NOMBRE_PADRE, p.owner DUENO_PADRE, p.object_type TIPO_PADRE,
           pd.object_id ID_HIJO, oh.object_name NOMBRE_HIJO, oh.owner DUENO_HIJO, oh.object_type TIPO_HIJO
      from public_dependency pd, 
           objeto p, 
           dba_objects oh
     where pd.referenced_object_id = p.object_id
       and pd.object_id = oh.object_id
     order by p.object_type, --Tipo Padre
              oh.owner, --Dueño hijo
              oh.object_type --Tipo hijo
    ;
 
    cursor cusource is    
    --busca dependencias en dba_source
    with source_obj as
    (
        select distinct owner, name, type 
         from dba_source
        where upper(text) like sbObjQry
    )
    select oh.object_id ID_HIJO, oh.object_name NOMBRE_HIJO, oh.owner DUENO_HIJO, oh.object_type TIPO_HIJO
      from dba_objects oh, 
           source_obj so
     where so.owner = oh.owner
       and so.name  = oh.object_name
       and so.type  = oh.object_type
    ;   


    cursor cuObject is
    --Busca dependencias en ge_object por si es usado en el framework o reglas
    select o.module_id id_modulo, 
           (select mnemonic||'-'||description from ge_module m where m.module_id = o.module_id) modulo_desc,
            o.name_ nombre, 
           o.object_type_id id_tipo,
           (select ot.description from ge_object_type  ot where ot.object_type_id = o.object_type_id) nombre_tipo
     from ge_object o
    where upper(name_) like sbObjQry
    order by o.module_id, o.name_;

    cursor cuConfExp is
    --Busca si es usado en una regla
    select ce.config_expression_id, ce.object_name,ce.object_type,
           ce.configura_type_id,
           (select 'Mód.'||module_id||'-'||description from gr_configura_type ct where ct.configura_type_id = ce.configura_type_id)  tipo_configura        
      from gr_config_expression ce
     where upper(code) like sbObjQry
        or upper(expression) like sbObjQry
        or upper(object_name) like sbObjQry
     order by ce.object_name
    ;

    cursor cuLdcProcObj is
    --Busca si es usado en ldc_procedimiento_obj
    select task_type_id,causal_id, procedimiento,activo
      from ldc_procedimiento_obj
     where upper(procedimiento) like sbObjQry
     order by procedimiento asc
     ;

    cursor cuHomoServi is 
    --Busca si está en la lista de servicios homologados
    select esquema_origen,servicio_origen, 
           esquema_destino, servicio_destino
      from homologacion_servicios
     where upper(servicio_origen) like sbObjQry
        or upper(servicio_destino) like sbObjQry;

    cursor cuStatement is
    --Busca si está siendo usado en una lista de valores 
     select s.statement_id, 
          s.module_id, 
          (select mnemonic||'-'||description from ge_module m where m.module_id = s.module_id) modulo_desc,
          s.description,
          s.statement          
    from ge_statement s
   where upper(statement) like sbObjQry;     
   
    cursor cuDistributionFile is
    --Busca en pantallas del framework
     select df.distribution_file_id, 
         df.file_name,
         df.distri_group_id,
         df.description
    from ge_distribution_file df
    where upper(extract(df.app_xml, '/').getclobval()) like sbObjQry;     

    cursor cuScheduleJob is
    select sj.owner, sj.job_name, sj.job_creator, sj.job_type, sj.start_date,
           sj.enabled, sj.last_start_date
      from dba_scheduler_jobs sj
     where upper(job_Action) like sbObjQry;

     cursor cuJobs is 
     select j.job id_job, j.log_user,j.priv_user,j.schema_user,
            j.last_date, j.last_sec, j.next_date, j.what
       from dba_jobs j
      where upper(what) like sbObjQry;   
    
begin 
   pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbINICIO);
   pkg_traza.trace('**********************************************************************');
   pkg_traza.trace('DETALLE dependencias para objeto: '||sbObjQry);
   pkg_traza.trace(
          'public_dependency|id_padre|nombre_padre|dueno_padre|tipo_padre|'||
          'id_hijo|nombre_hijo|dueno_hijo|tipo_hijo');    
          
    for rchijos in cuhijos  loop--Escribe quienes usan el objeto según public_dependency
       pkg_traza.trace( sbseparador||
           rchijos.ID_PADRE||'|'||rchijos.NOMBRE_PADRE||'|'||rchijos.DUENO_PADRE||'|'||rchijos.TIPO_PADRE||'|'||
           rchijos.ID_HIJO||'|'||rchijos.NOMBRE_HIJO||'|'||rchijos.DUENO_HIJO||'|'||rchijos.TIPO_HIJO      
       );
    end loop;

        pkg_traza.trace( 
             'dba_source|id_hijo|nombre_hijo|dueno_hijo|tipo_hijo'
        );

    for rcsource in cusource loop --Escribe quiénes lo tienen en el código fuente
        pkg_traza.trace(
             sbseparador||rcsource.ID_HIJO||'|'||rcsource.NOMBRE_HIJO||'|'||rcsource.DUENO_HIJO||'|'||rcsource.TIPO_HIJO
        );
    end loop;


        pkg_traza.trace(
           'ge_object|id_modulo|modulo_desc|nombre|id_tipo|nombre_tipo'
        );

    for rcObject in cuObject loop --Escribe si está registrado en ge_object
        pkg_traza.trace(
            sbseparador||rcObject.id_modulo||'|'||rcObject.modulo_desc||'|'||rcObject.nombre||'|'||rcObject.id_tipo
           ||'|'||rcObject.nombre_tipo
        );
    end loop;

        pkg_traza.trace( 
           'gr_config_expression|config_expression_id|object_name|object_type|configura_type_id|tipo_configura' 
        );

   for rcConfExp in cuConfExp loop --Escribe si está registrado en gr_config_expression
        pkg_traza.trace(
            sbseparador||rcConfExp.config_expression_id||'|'||rcConfExp.object_name||'|'||rcConfExp.object_type||'|'||
           rcConfExp.configura_type_id||'|'||rcConfExp.tipo_configura 
        );
   end loop;

       pkg_traza.trace( 
              'ge_statement|statement_id|module_id|modulo_desc|description|statement');   
   for rcStatement in cuStatement loop --Escribe si está siendo utilizado en ge_statement
       pkg_traza.trace( sbseparador||rcStatement.statement_id||'|'||
                       rcStatement.module_id||'|'||rcStatement.modulo_desc||'|'||
                       rcStatement.description||'|'||rcStatement.statement);
   end loop;
   
   pkg_traza.trace( 'ge_distribution_file|distribution_file_id|file_name|distri_group_id|description');    
   for rcDistributionFile in cuDistributionFile loop --Escribe si está siendo usado por pantallas del framework
       pkg_traza.trace( sbseparador||rcDistributionFile.distribution_file_id||'|'||
                       rcDistributionFile.file_name||'|'||
                       rcDistributionFile.distri_group_id||'|'||
                       rcDistributionFile.description
                       );       
   end loop;   

    pkg_traza.trace( 'ldc_procedimiento_obj|task_type_id|causal_id|procedimiento|activo');
   for rcLdcProcObj in cuLdcProcObj loop --Escribe si está registrado en ldc_procedimiento_obj
       pkg_traza.trace( sbseparador||rcLdcProcObj.task_type_id||'|'||rcLdcProcObj.causal_id||'|'||
                        rcLdcProcObj.procedimiento||'|'||rcLdcProcObj.activo
                      );
   end loop;

    pkg_traza.trace( 'homologacion_servicios|esquema_origen|servicio_origen|esquema_destino|servicio_destino');
   for rcHomoServi in cuHomoServi loop --Escribe si está registrado en homologacion_servicios
       pkg_traza.trace( sbseparador||rcHomoServi.esquema_origen||'|'||rcHomoServi.servicio_origen||'|'|| 
                        rcHomoServi.esquema_destino||'|'||rcHomoServi.servicio_destino);                             
   end loop;
   

    pkg_traza.trace( 'dba_scheduler_jobs|owner|job_name|job_creator|job_type|start_date|enabledlast_start_date');
   for rcScheduleJob in cuScheduleJob loop --Escribe si existen schedulers que usen el objeto
       pkg_traza.trace( sbseparador||
                        rcScheduleJob.owner||'|'||rcScheduleJob.job_name||'|'||rcScheduleJob.job_creator||'|'||
                        rcScheduleJob.job_type||'|'||rcScheduleJob.start_date||'|'||rcScheduleJob.enabled||'|'||
                        rcScheduleJob.last_start_date);                             
   end loop;

    pkg_traza.trace( 'db_jobs|id_job|log_user|priv_user|schema_user|last_date|last_sec|next_date');
   for rcJobs in cuJobs loop --Escribe si existen jobs que usen el objeto
       pkg_traza.trace( sbseparador||
                        rcJobs.id_job||'|'||rcJobs.log_user||'|'||rcJobs.priv_user||'|'||
                        rcJobs.schema_user||'|'||rcJobs.last_date||'|'||rcJobs.next_date);                             
   end loop;



   pkg_traza.trace('FIN DETALLE DEPENDENCIAS**********************************************');

   pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN);
 EXCEPTION
     WHEN OTHERS THEN
         pkg_error.SetError; 
         pkg_error.geterror (nuCodError, sbMensErro);
         pkg_traza.trace(csbTagErr||nuCodError||'-'||sbMensErro,pkg_traza.cnuNivelTrzDef);         
         pkg_traza.trace(csbMETODO, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
end prdetalleDependen;



procedure prValidaDependen  (isbObjeto in VARCHAR2) is
/******************************************************************************************
Método: prdetalleDependen
Autor: Edilay Peña Osorio  - Global MVM. 
Fecha: 21/11/2023
Descripción:
Busca el objeto enviado cuántas veces está en las tablas: 
    +public_dependency
    +dba_source
    +ge_object
    +gr_config_expression
    +ldc_procedimiento_obj
    +homologacion_servicios
    +ge_statement
    +ge_distribution_file
Imprime este conteo con el fin de validar si está siendo usado o no, el detalle de esta información 
se puede consultar con el método prdetalleDependen.
*******************************************************************************************/
    csbMetodo  CONSTANT VARCHAR2(100) := csbNOMPKG||'prValidaDependen'; --Nombre del método en la traza
    sbObjQry  VARCHAR2(150) :=  fsbObjeto(isbObjeto);
    cursor cucnthijos is 
    --contando los hijos
    with objeto as
    (
       select o.object_id, o.object_name, o.owner, o.object_type
         from dba_objects o
        where o.object_name like sbObjQry
    )
    select count (*) total
      from public_dependency pd, 
           objeto p, 
           dba_objects oh
     where pd.referenced_object_id = p.object_id
       and pd.object_id = oh.object_id
    ;
    rccnthijos  cucnthijos%rowtype;

    cursor cucntsource is    
    --busca dependencias en dba_source
    with source_obj as
    (
        select distinct owner, name, type 
         from dba_source
        where text like sbObjQry
    )
    select count(*) total
      from dba_objects oh, 
           source_obj so
     where so.owner = oh.owner
       and so.name  = oh.object_name
       and so.type  = oh.object_type
     ;  
    rccntsource  cucntsource%rowtype;

    cursor cucntObject is
    select count(*) total
    from ge_object
    where upper(name_) like sbObjQry;
    rccntObject  cucntObject%rowtype;

    cursor cucntConfExp is
    select count(*) total
      from gr_config_expression
     where upper(code) like sbObjQry
        or upper(expression) like sbObjQry
        or upper(object_name) like sbObjQry
    ;
    rccntConfExp  cucntConfExp%rowtype;

    cursor cucntLdcProcObj is
    select count(*) total
     from ldc_procedimiento_obj
     where upper(procedimiento) like  sbObjQry
     ;
     rccntLdcProcObj  cucntLdcProcObj%rowtype;

    cursor cucntHomoServi is 
    select count(*) total
      from homologacion_servicios
     where upper(servicio_origen) like sbObjQry
        or (servicio_destino) like sbObjQry;   
    rccntHomoServi    cucntHomoServi%rowtype;
    
    cursor cucntstatement is
    select count(*) total
      from ge_statement
     where upper(statement) like sbObjQry ;
    rccntstatement  cucntstatement%rowtype;
    
    cursor cucntDistributionFile is
     select count(*) total
    from ge_distribution_file df
    where upper(extract(df.app_xml, '/').getclobval()) like sbObjQry;    
    rccntDistributionFile   cucntDistributionFile%rowtype;

    cursor cuScheduleJob is 
     select count(*) total
       from dba_scheduler_jobs
      where upper(job_Action) like sbObjQry;
    rcScheduleJob cuScheduleJob%rowtype; 

    cursor cuJobs is
    select count(*) total
      from dba_jobs
     where upper(what) like sbObjQry;
    rcJobs cuJobs%rowtype;

begin
    pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbINICIO);
    open cucnthijos;--cuenta quienes usan el objeto según public_dependency
      fetch cucnthijos into rccnthijos;
    close cucnthijos;
      

    open cucntsource;--cuenta quiénes lo tienen en el código fuente
      fetch cucntsource into rccntsource;
    close cucntsource;


    open cucntObject; --cuenta si está registrado en ge_object
      fetch cucntObject into rccntObject;
    close cucntObject;    

    open cucntConfExp;--cuenta si está registrado en gr_config_expression
      fetch cucntConfExp into rccntConfExp;
    close cucntConfExp;        

    open cucntLdcProcObj; --Cuenta si está registrado en ldc_procedimiento_obj
      fetch cucntLdcProcObj into rccntLdcProcObj;
    close cucntLdcProcObj;      

    open cucntHomoServi;--Cuenta si está registrado en homologacion_servicios
      fetch cucntHomoServi into rccntHomoServi;
    close cucntHomoServi;   
    
   open cucntstatement;--cuenta si está siendo utilizado en ge_statement
      fetch cucntstatement into rccntstatement;
   close cucntstatement;   
    
   open cucntDistributionFile; --cuenta si está siendo usado por pantallas del framework
      fetch cucntDistributionFile into rccntDistributionFile;
   close cucntDistributionFile;      

  open cuScheduleJob;
      fetch cuScheduleJob into rcScheduleJob;
  close cuScheduleJob;
    
  open cuJobs;
       fetch cuJobs into rcJobs;
  close cuJobs;  

    pkg_traza.trace('**********************************************************************');
    pkg_traza.trace('CONSULTA DEPENDENCIAS*************************************************');
    pkg_traza.trace( sbseparador||'Resultado dependencia para objeto:'||sbseparador||sbObjQry);
    pkg_traza.trace( sbseparador||'hijos en PUBLIC_DEPENDENCY         :'||sbseparador||rccnthijos.total);
  --  pkg_traza.trace('hijos en DBA_DEPENDENCIES          :'||rccntDbDepen.total);
    pkg_traza.trace( sbseparador||'Llamados en DBA_SOURCES            :'||sbseparador||rccntsource.total);
    pkg_traza.trace( sbseparador||'Registros en GE_OBJECT             :'||sbseparador||rccntObject.total);
    pkg_traza.trace( sbseparador||'Llamados en GR_CONFIG_EXPRESSION   :'||sbseparador||rccntConfExp.total);
    pkg_traza.trace( sbseparador||'Llamados en GE_STATEMEN            :'||sbseparador||rccntstatement.total);
    pkg_traza.trace( sbseparador||'Llamados en GE_DISTRIBUTION_FILE   :'||sbseparador||rccntDistributionFile.total);
    pkg_traza.trace( sbseparador||'Regsitros en LDC_PROCEDIMIENTO_OBJ :'||sbseparador||rccntLdcProcObj.total);
    pkg_traza.trace( sbseparador||'Regsitros en HOMOLOGACION_SERVICIOS:'||sbseparador||rccntHomoServi.total);
    pkg_traza.trace( sbseparador||'Regsitros en DBA_SCHEDULER_JOBS    :'||sbseparador||rcScheduleJob.total);
    pkg_traza.trace( sbseparador||'Regsitros en DBA_JOBS              :'||sbseparador||rcJobs.total);
    pkg_traza.trace('FIN CONSULTA DEPENDENCIAS*********************************************');
    pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN);
 EXCEPTION
     WHEN OTHERS THEN
         pkg_error.SetError; 
         pkg_error.geterror (nuCodError, sbMensErro);
         pkg_traza.trace(csbTagErr||nuCodError||'-'||sbMensErro,pkg_traza.cnuNivelTrzDef);         
         pkg_traza.trace(csbMETODO, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
end prValidaDependen;

procedure prValidaHomologa (isbObjeto in VARCHAR2) is
/******************************************************************************************
Método: prValidaHomologa
Autor: Edilay Peña Osorio  - Global MVM. 
Fecha: 21/11/2023
Descripción:
     Escribe si el objeto enviado está usando algún objeto
     que se debe homologar según la tabla: HOMOLOGA_SERVICIOS
  Autor        Fecha      Descripción
---------------------------------------------------------------------------------------------------- 
  epenao      12/01/2024  OSF-2186 Se adiciona ordenamiento del la consulta por el nombre del objeto 
                                   Se valida si el nombre del objeto es diferente el anterior
                                   para decidir la impresión del encabezado, esto con el fin de 
                                   separar los objetos que comparten gran parte del nombre, ejemplo:
                                       LDC_PKCM_LECTESP
                                       LDC_PKCM_LECTESP8
                                       LDC_PKCM_LECTESP9
                                  Se adiciona consulta de los objetos a homologar en HOMOLOGACION_SERVICIOS
                                  y luego se cruza con dba_sources del objeto a validar, esto con 
                                  el fin de encontrar coincidencias.    

*******************************************************************************************/

  csbMetodo  CONSTANT VARCHAR2(100) := csbNOMPKG||'prValidaHomologa'; --Nombre del método en la traza
  sbObjQry   VARCHAR2(150) :=  fsbObjeto(isbObjeto);

  cursor cuObjetosHomologa is 
      select 
            distinct  hs.servicio_origen, hs.servicio_destino,
             hs.esquema_origen, hs.esquema_destino,
             ds.owner dueno_objeto, ds.name nombre_objeto,
             hs.descripcion_destino, hs.observacion
       from homologacion_servicios hs, dba_source ds
      where ds.name like sbObjQry
        and upper(ds.text) like '%'||upper(hs.servicio_origen)||'%'        
      order by nombre_objeto asc
      ;

    
    nutotalreg NUMBER := 0;
    sbObjAnt   varchar2(100);
begin
    pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbINICIO);   
    pkg_traza.trace('**********************************************************************');
    pkg_traza.trace('CONSULTA USO DE OBJETOS HOMOLOGADOS');
    sbObjAnt:= '-';
    for rc_datos in cuObjetosHomologa loop
       nutotalreg := nutotalreg +1;
       if nutotalreg = 1 or 
          (sbObjAnt != rc_datos.nombre_objeto) then
           pkg_traza.trace('------------------------------------------------');
           pkg_traza.trace(sbseparador||
                          'Objeto evaluado:'||rc_datos.dueno_objeto||'.'|| rc_datos.nombre_objeto);

           pkg_traza.trace(sbseparador||
                           'Servicios homologados que usa:'); 
           pkg_traza.trace(sbseparador||
                          'esquema_origen|servicio_origen|'||
                          'esquema_destino|servicio_destino|'||
                          'observación|descripción');
       end if; 
       pkg_traza.trace( sbseparador||                      
                      rc_datos.esquema_origen   ||sbseparador||
                      rc_datos.servicio_origen  ||sbseparador||
                      rc_datos.esquema_destino  ||sbseparador||
                      rc_datos.servicio_destino ||sbseparador||
                      '"'||rc_datos.descripcion_destino||'"'||sbseparador||
                      '"'||rc_datos.observacion||'"'                      
                    ); 
      sbObjAnt :=   rc_datos.nombre_objeto;            
  end loop;
  if nutotalreg = 0 then
     pkg_traza.trace('*****************NO SE ENCONTRÓ USO DE OBJETOS HOMOLOGADOS********************');
  end if; 
  pkg_traza.trace('FIN CONSULTA OBJETOS HOMOLOGADOS**************************************');
  pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN);
 EXCEPTION
     WHEN OTHERS THEN
         pkg_error.SetError; 
         pkg_error.geterror (nuCodError, sbMensErro);
         pkg_traza.trace(csbTagErr||nuCodError||'-'||sbMensErro,pkg_traza.cnuNivelTrzDef);
         pkg_traza.trace(csbMETODO, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
end prValidaHomologa;

  procedure prValidaHomologaLinea (isbObjeto in VARCHAR2) is
/******************************************************************************************
Método: prValidaHomologaLinea
Autor: Edilay Peña Osorio  - Global MVM. 
Fecha: 21/11/2023
Descripción:
     Escribe la línea en la que el objeto enviado está usando algún objeto
     que se debe homologar según la tabla: HOMOLOGA_SERVICIOS

  Autor        Fecha      Descripción
---------------------------------------------------------------------------------------------------- 
  epenao      12/01/2024  OSF-2186 Se adiciona ordenamiento del la consulta por el nombre del objeto 
                                    Se valida si el nombre del objeto es diferente el anterior
                                    para decidir la impresión del encabezado, esto con el fin de 
                                    separar los objetos que comparten gran parte del nombre, ejemplo:
                                        LDC_PKCM_LECTESP
                                        LDC_PKCM_LECTESP8
                                        LDC_PKCM_LECTESP9
                                  Se adiciona consulta de los objetos a homologar en HOMOLOGACION_SERVICIOS
                                  y luego se cruza con dba_sources del objeto a validar, esto con 
                                  el fin de encontrar coincidencias.     


*******************************************************************************************/
  csbMetodo  CONSTANT VARCHAR2(100) := csbNOMPKG||'prValidaHomologaLinea'; --Nombre del método en la traza
  sbObjQry   VARCHAR2(150) :=  fsbObjeto(isbObjeto);
  cursor cuObjetosHomologa is 
      select distinct  hs.servicio_origen, hs.servicio_destino,
             hs.esquema_origen, hs.esquema_destino,
             ds.owner dueno_objeto, ds.name nombre_objeto, 
             ds.line num_linea, 
             hs.descripcion_destino, hs.observacion,
             REPLACE(ds.text,chr(10), '')  linea
        from homologacion_servicios hs, dba_source ds
       where ds.name like sbObjQry
         and upper(ds.text) like '%'||upper(hs.servicio_origen)||'%'        
       order by nombre_objeto asc, num_linea asc;         
    
    nutotalreg NUMBER := 0;
    sbObjAnt   varchar2(100);
begin
    pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbINICIO);
    pkg_traza.trace('**********************************************************************');
    pkg_traza.trace('CONSULTA USO DE OBJETOS HOMOLOGADOS');
    sbObjAnt:= '-';
    for rc_datos in cuObjetosHomologa loop
       nutotalreg := nutotalreg +1;
       if nutotalreg = 1 or 
          (sbObjAnt != rc_datos.nombre_objeto) then
           pkg_traza.trace('------------------------------------------------');
           pkg_traza.trace(sbseparador||
                          'Objeto evaluado:'||rc_datos.dueno_objeto||'.'|| rc_datos.nombre_objeto);

           pkg_traza.trace(sbseparador||
                           'Servicios homologados que usa:'); 
           pkg_traza.trace(sbseparador||
                          'esquema_origen|servicio_origen|'||
                          'esquema_destino|servicio_destino|num_línea|línea|'||
                          'Descripcion|Observación');
       end if; 
       pkg_traza.trace( sbseparador||                      
                      rc_datos.esquema_origen   ||sbseparador||
                      rc_datos.servicio_origen  ||sbseparador||
                      rc_datos.esquema_destino  ||sbseparador||
                      rc_datos.servicio_destino ||sbseparador||
                      rc_datos.num_linea        ||sbseparador||
                      rc_datos.linea            ||sbseparador||
                      '"'||rc_datos.descripcion_destino||'"'||sbseparador||
                      '"'||rc_datos.observacion||'"'         
                    ); 
      sbObjAnt :=   rc_datos.nombre_objeto;              
  end loop;
  if nutotalreg = 0 then
     pkg_traza.trace('*****************NO SE ENCONTRÓ USO DE OBJETOS HOMOLOGADOS********************');
  end if; 
  pkg_traza.trace('FIN CONSULTA OBJETOS HOMOLOGADOS**************************************');
     
  pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN);
 EXCEPTION
     WHEN OTHERS THEN
         pkg_error.geterror (nuCodError, sbMensErro);
         pkg_traza.trace(csbTagErr||nuCodError||'-'||sbMensErro,pkg_traza.cnuNivelTrzDef);     
         pkg_error.SetError; 
         pkg_traza.trace(csbMETODO, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
end prValidaHomologaLinea;

procedure prValidaUsadoNoHomologa (isbObjeto in VARCHAR2) is
/******************************************************************************************
Método: prValidaHomologaLinea
Autor: Edilay Peña Osorio  - Global MVM. 
Fecha: 21/11/2023
Descripción:
     Escribe la línea en la que el objeto enviado está usando objetos que no se encuentran en la 
     tabla HOMOLOGACION_SERVICIOS

  Autor        Fecha      Descripción
---------------------------------------------------------------------------------------------------- 
  epenao      12/01/2024  OSF-2186 Se adiciona ordenamiento del la consulta por el nombre del objeto 
                                    Se valida si el nombre del objeto es diferente el anterior
                                    para decidir la impresión del encabezado, esto con el fin de 
                                    separar los objetos que comparten gran parte del nombre, ejemplo:
                                        LDC_PKCM_LECTESP
                                        LDC_PKCM_LECTESP8
                                        LDC_PKCM_LECTESP9 

*******************************************************************************************/

  csbMetodo  CONSTANT VARCHAR2(100) := csbNOMPKG||'prValidaUsadoNoHomologa'; --Nombre del método en la traza
  sbObjQry  VARCHAR2(150) :=  fsbObjeto(isbObjeto);
  cursor cuObjetosHomologa is 
   with objeto as
      (--Obtiene Id del objeto a validar
      select o.object_id, o.object_name, o.owner, o.object_type
      from dba_objects o
      where o.object_name like sbObjQry
      ),
      depen as
      (--Obtiene las dependencias(a quién usa) del objeto a validar
      select p.object_id ID_PADRE, p.object_name NOMBRE_PADRE, p.owner DUENO_PADRE, p.object_type TIPO_PADRE,
        pd.object_id ID_HIJO, oh.object_name NOMBRE_HIJO, oh.owner DUENO_HIJO, oh.object_type TIPO_HIJO
      from public_dependency pd, 
          objeto oh, 
          dba_objects p
      where pd.referenced_object_id = p.object_id
      and pd.object_id = oh.object_id
      and p.object_type != 'TABLE'
      and p.object_name != oh.object_name
      ),
      usados as
      (--Obtiene la línea del código donde utiliza cada objeto
      select ds.*, de.*
        from dba_source ds, depen de
      where ds.name = de.nombre_hijo
        and upper(ds.text) like '%'||upper(de.nombre_padre)||'%'
      ),
      todosusados as
      (
      --Cruza la tabla de homologación con el fuente de las dependencias
      select u.owner dueno_objeto, u.name nombre_objeto,
             u.nombre_padre, u.DUENO_PADRE,u.TIPO_PADRE,
             hs.esquema_origen, hs.servicio_origen, hs.esquema_destino, hs.servicio_destino,
             u.line num_linea, 
             REPLACE(u.text,chr(10), '')  linea
        from usados u left OUTER JOIN homologacion_servicios hs
                   on upper(u.text) like upper('%'||hs.servicio_origen||'%')
      )
      select distinct tu.dueno_padre, tu.nombre_padre, tu.tipo_padre, 
             tu.dueno_objeto, tu.nombre_objeto,
             tu.servicio_destino
        from todosusados tu
      where tu.esquema_origen is  null    
      order by  tu.nombre_objeto asc
      ;  

    cursor cuDestinoHomologado (isbobjeto in varchar2) is 
    select COUNT(servicio_destino ) TOT 
      from homologacion_servicios
     where servicio_destino like isbobjeto||'%'
    ;   
    rccuDestinoHomologado cuDestinoHomologado%rowtype;
       
    nutotalreg NUMBER := 0;
    sbObjAnt   varchar2(100);
begin
    pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbINICIO);
    pkg_traza.trace('**********************************************************************');
    pkg_traza.trace('CONSULTA USO DE OBJETOS  NO  HOMOLOGADOS');
    sbObjAnt:= '-';
    for rc_datos in cuObjetosHomologa loop
       nutotalreg := nutotalreg +1;
       if nutotalreg = 1 or 
          (sbObjAnt != rc_datos.nombre_objeto) then
           pkg_traza.trace('------------------------------------------------');          
           pkg_traza.trace(sbseparador||
                          'Objeto evaluado:'||rc_datos.dueno_objeto||'.'|| rc_datos.nombre_objeto);
           pkg_traza.trace(sbseparador||
                           'Servicios NO homologados que usa:'); 
           pkg_traza.trace(sbseparador||
                          'dueno_padre|nombre_padre|tipo_padre');
       end if; 
       open cuDestinoHomologado(rc_datos.nombre_padre);
           fetch cuDestinoHomologado into rccuDestinoHomologado;
       close cuDestinoHomologado;
       if rccuDestinoHomologado.TOT = 0then
          pkg_traza.trace( sbseparador||                      
                          rc_datos.dueno_padre   ||sbseparador||
                          rc_datos.nombre_padre  ||sbseparador||
                          rc_datos.tipo_padre  
                        ); 
      end if;   
      sbObjAnt :=   rc_datos.nombre_objeto;           
  end loop;
  if nutotalreg = 0 then
     pkg_traza.trace('*****************NO SE ENCONTRÓ USO DE OBJETOS HOMOLOGADOS********************');
  end if; 
  pkg_traza.trace('FIN CONSULTA OBJETOS NO HOMOLOGADOS**************************************');

  pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN);
 EXCEPTION
     WHEN OTHERS THEN
         pkg_error.SetError; 
         pkg_error.geterror (nuCodError, sbMensErro);
         pkg_traza.trace(csbTagErr||nuCodError||'-'||sbMensErro,pkg_traza.cnuNivelTrzDef);         
         pkg_traza.trace(csbMETODO, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);     
end prValidaUsadoNoHomologa;


procedure prValidaUsados   (isbObjeto in VARCHAR2)is

/******************************************************************************************
Método: prValidaUsados
Autor: Edilay Peña Osorio  - Global MVM. 
Fecha: 21/11/2023
Descripción:
   Escribe los objetos que están siendo usados por el objeto enviado, se excluyen tablas.

  Autor        Fecha      Descripción
---------------------------------------------------------------------------------------------------- 
  epenao      12/01/2024  OSF-2186 Se adiciona ordenamiento del la consulta por el nombre del objeto 
                                    Se valida si el nombre del objeto es diferente el anterior
                                    para decidir la impresión del encabezado, esto con el fin de 
                                    separar los objetos que comparten gran parte del nombre, ejemplo:
                                        LDC_PKCM_LECTESP
                                        LDC_PKCM_LECTESP8
                                        LDC_PKCM_LECTESP9    
*******************************************************************************************/

  csbMetodo  CONSTANT VARCHAR2(100) := csbNOMPKG||'prValidaUsados'; --Nombre del método en la traza
  sbObjQry   VARCHAR2(150) :=  fsbObjeto(isbObjeto);
  cursor cuObjetosUsados is 
   with objeto as
      (--Obtiene Id del objeto a validar
      select o.object_id, o.object_name, o.owner, o.object_type
      from dba_objects o
      where o.object_name like sbObjQry
      )
      --Obtiene las dependencias(a quién usa) del objeto a validar
      select p.object_id ID_PADRE, p.object_name NOMBRE_PADRE, p.owner DUENO_PADRE, p.object_type TIPO_PADRE,
             pd.object_id ID_HIJO, oh.object_name NOMBRE_HIJO, oh.owner DUENO_HIJO, oh.object_type TIPO_HIJO
        from public_dependency pd, 
             objeto oh, 
             dba_objects p
       where pd.referenced_object_id = p.object_id
         and pd.object_id = oh.object_id
         and p.object_type != 'TABLE'
         and p.object_name != oh.object_name 
       order by nombre_hijo asc
      ;  
    
    nutotalreg NUMBER := 0;
    sbObjAnt   varchar2(100);
begin
    pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbINICIO);    
    pkg_traza.trace('**********************************************************************');
    pkg_traza.trace('CONSULTA OBJETOS USADOS');
    sbObjAnt:= '-';
    
    for rc_datos in cuObjetosUsados loop
       nutotalreg := nutotalreg +1;
       if nutotalreg = 1 or
          (sbObjAnt != rc_datos.nombre_hijo) then
           pkg_traza.trace('------------------------------------------------');
           pkg_traza.trace(sbseparador||
                          'Objeto evaluado:'||rc_datos.DUENO_HIJO||'.'|| rc_datos.NOMBRE_HIJO);

           pkg_traza.trace(sbseparador||
                           'Objetos que usa:'); 
           pkg_traza.trace(sbseparador||
                          'Dueno_objeto|nombre_objeto|'||
                          'tipo_objeto');
       end if; 
       pkg_traza.trace( sbseparador||                      
                      rc_datos.DUENO_PADRE   ||sbseparador||
                      rc_datos.NOMBRE_PADRE  ||sbseparador||
                      rc_datos.TIPO_PADRE     
                    ); 
        sbObjAnt := rc_datos.nombre_hijo;                     
    end loop;
    pkg_traza.trace('FIN CONSULTA OBJETOS USADOS******************************************');
     
    pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN);
 EXCEPTION
     WHEN OTHERS THEN
         pkg_error.SetError; 
         pkg_error.geterror (nuCodError, sbMensErro);
         pkg_traza.trace(csbTagErr||nuCodError||'-'||sbMensErro,pkg_traza.cnuNivelTrzDef);         
         pkg_traza.trace(csbMETODO, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
end prValidaUsados;


procedure prValidaUsadosLinea   (isbObjeto in VARCHAR2)is
/******************************************************************************************
Método: prValidaUsadosLinea
Autor: Edilay Peña Osorio  - Global MVM. 
Fecha: 21/11/2023
Descripción:
   Escribe la línea en la que  el objeto enviado está invocando 
   otro objeto de la base de datos, se excluyen tablas.
*******************************************************************************************/

  csbMetodo  CONSTANT VARCHAR2(100) := csbNOMPKG||'prValidaUsadosLinea'; --Nombre del método en la traza
  sbObjQry  VARCHAR2(150) :=  fsbObjeto(isbObjeto);
  cursor cuObjetosUsados is 
   with objeto as
      (--Obtiene Id del objeto a validar
      select o.object_id, o.object_name, o.owner, o.object_type
      from dba_objects o
      where o.object_name like sbObjQry
      ),
      depen as
      (--Obtiene las dependencias(a quién usa) del objeto a validar
      select p.object_id ID_PADRE, p.object_name NOMBRE_PADRE, p.owner DUENO_PADRE, p.object_type TIPO_PADRE,
        pd.object_id ID_HIJO, oh.object_name NOMBRE_HIJO, oh.owner DUENO_HIJO, oh.object_type TIPO_HIJO
      from public_dependency pd, 
          objeto oh, 
          dba_objects p
      where pd.referenced_object_id = p.object_id
      and pd.object_id = oh.object_id
      and p.object_type != 'TABLE'
      and p.object_name != oh.object_name
      )
      --Obtiene la línea del código donde utiliza cada objeto
      select ds.owner dobjeto,ds.name nobjeto,
             de.dueno_padre Dueno_objeto,
             de.nombre_padre nombre_objeto, 
             de.tipo_padre tipo_objeto,
             ds.line num_linea, 
             REPLACE(ds.text,chr(10), '')  linea
        from dba_source ds, depen de
      where  ds.name = de.nombre_hijo
        and upper(ds.text) like '%'||upper(de.nombre_padre)||'%'
      order by nobjeto asc, num_linea asc 
      ;  
    
    nutotalreg NUMBER := 0;
    sbObjAnt   varchar2(100);
begin
    pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbINICIO);
    pkg_traza.trace('**********************************************************************');
    pkg_traza.trace('CONSULTA LINEA DONDE ESTÁN LOS OBJETOS USADOS');    
    sbObjAnt:= '-';

    for rc_datos in cuObjetosUsados loop
       nutotalreg := nutotalreg +1;
       if nutotalreg = 1 or
          (sbObjAnt != rc_datos.nobjeto) then
           pkg_traza.trace('------------------------------------------------');
           pkg_traza.trace(sbseparador||
                          'Objeto evaluado:'||rc_datos.dobjeto||'.'|| rc_datos.nobjeto);

           pkg_traza.trace(sbseparador||
                           'Objetos que usa:'); 
           pkg_traza.trace(sbseparador||
                          'Dueno_objeto|nombre_objeto|'||
                          'tipo_objeto|num_línea|línea');
       end if; 
       pkg_traza.trace( sbseparador||                      
                      rc_datos.Dueno_objeto ||sbseparador||
                      rc_datos.nombre_objeto||sbseparador||
                      rc_datos.tipo_objeto  ||sbseparador||
                      rc_datos.num_linea    ||sbseparador||                      
                      rc_datos.linea       
                    ); 
       sbObjAnt := rc_datos.nobjeto;                                         
     end loop;
     pkg_traza.trace('FIN CONSULTA LÍNEA OBJETOS USADOS******************************************');     
    pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN);
 EXCEPTION
     WHEN OTHERS THEN
         pkg_error.SetError; 
         pkg_error.geterror (nuCodError, sbMensErro);
         pkg_traza.trace(csbTagErr||nuCodError||'-'||sbMensErro,pkg_traza.cnuNivelTrzDef);         
         pkg_traza.trace(csbMETODO, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
end prValidaUsadosLinea;


procedure prValidaProducto (isbobjeto in varchar2) is 
/******************************************************************************************
Método: prValidaProducto
Autor: Edilay Peña Osorio  - Global MVM. 
Fecha: 24/11/2023
Descripción:
   Escribe los objetos de producto que están siendo usados por el objeto enviado. 
   La validación se hace con la tabla master_open donde se encuentran los 
   objetos marcados por Open como de producto. 
*******************************************************************************************/
 csbMetodo  CONSTANT VARCHAR2(100) := csbNOMPKG||'prValidaProducto'; --Nombre del método en la traza
 sbObjQry  VARCHAR2(150) :=  fsbObjeto(isbObjeto);
 cursor cuObjProducto is 
    with objeto as
      (--Obtiene Id del objeto a validar
      select o.object_id, o.object_name, o.owner, o.object_type
      from dba_objects o
      where o.object_name like sbObjQry
      ),
      depen as
      (--Obtiene las dependencias(a quién usa) del objeto a validar
      select p.object_id ID_PADRE, p.object_name NOMBRE_PADRE, p.owner DUENO_PADRE, p.object_type TIPO_PADRE,
        pd.object_id ID_HIJO, oh.object_name NOMBRE_HIJO, oh.owner DUENO_HIJO, oh.object_type TIPO_HIJO
      from public_dependency pd, 
          objeto oh, 
          dba_objects p
      where pd.referenced_object_id = p.object_id
      and pd.object_id = oh.object_id
      and p.object_type != 'TABLE'
      and p.object_name != oh.object_name
      )
    --Cruza con los objetos clasificados por producto como de Open  
    select d.dueno_hijo dueno_objeto,  d.nombre_hijo nombre_objeto,            
           d.dueno_padre, d.nombre_padre,
           mo.object_type, mo.observacion         
     from depen d, master_open mo
    where upper(d.nombre_padre) = upper(mo.nombre)
    ;

    nutotalreg NUMBER := 0;
begin 
    pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbINICIO);
    pkg_traza.trace('**********************************************************************');
    pkg_traza.trace('CONSULTA OBJETOS DE PRODUCTO USADOS');
    
    for rc_datos in cuObjProducto loop
       nutotalreg := nutotalreg +1;
       if nutotalreg = 1 then
           pkg_traza.trace(sbseparador||
                          'Objeto evaluado:'||rc_datos.dueno_objeto||'.'|| rc_datos.nombre_objeto);

           pkg_traza.trace(sbseparador||
                           'Objetos que usa:'); 
           pkg_traza.trace(sbseparador||
                          'Dueno_objeto|nombre_objeto|'||
                          'tipo_objeto');
       end if; 
       pkg_traza.trace( sbseparador||                      
                      rc_datos.dueno_padre ||sbseparador||
                      rc_datos.nombre_padre||sbseparador||
                      rc_datos.object_type ||sbseparador||
                      rc_datos.observacion        
                    ); 
     end loop;
     pkg_traza.trace('FIN CONSULTA OBJETOS DE PRODUCTO USADOS******************************');       
    pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN);
 EXCEPTION
     WHEN OTHERS THEN
         pkg_error.SetError; 
         pkg_error.geterror (nuCodError, sbMensErro);
         pkg_traza.trace(csbTagErr||nuCodError||'-'||sbMensErro,pkg_traza.cnuNivelTrzDef);         
         pkg_traza.trace(csbMETODO, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
end prValidaProducto;

end pkg_homologaserv_util;
/
PROMPT Asignación de permisos para el paquete PKG_HOMOLOGASERV_UTIL
begin
  pkg_utilidades.prAplicarPermisos('PKG_HOMOLOGASERV_UTIL', 'PERSONALIZACIONES');
end;
/ 
PROMPT Asignación de permisos para el Usuario USELOPEN
GRANT EXECUTE ON PKG_HOMOLOGASERV_UTIL TO USELOPEN;
/
