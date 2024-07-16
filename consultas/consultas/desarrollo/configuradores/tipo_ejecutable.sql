with 
configuracion as(
 select distinct co.tag_name , e2.name
   from open.gi_composition co
   inner join open.gi_config gi on gi.config_id=co.config_id
   inner join open.sa_executable e2 on e2.executable_id= gi.external_root_id
   )
,listavalores as(
select distinct lov.name name_ejec, enti.name_  
from open.ge_entity enti
inner join open.gi_attrib_disp_data gat on gat.list_of_value_from is not null and  upper(gat.list_of_value_from) like '%'||enti.name_||'|%'
inner join open.sa_executable lov  on lov.executable_id=gat.executable_id )
,input_reporte as(
select c.object_name, y.NAME_OBJ, '|'||y.ALIAS_OBJ||'|' ALIAS_OBJ 
from open.ge_object_process_conf c, 
     xmltable(
         
         '/*:OBJECT_PROCESS/*:PARAMETERS/*:PARAMETER' passing c.config_xml 
            COLUMNS 
           NAME_OBJ     VARCHAR2(4000)  PATH '*:NAME',
           IS_REQUIRED_OBJ     VARCHAR2(4000)  PATH '*:IS_REQUIRED',
           ACCEPT_CONS_VALUE_OBJ     VARCHAR2(4000)  PATH '*:ACCEPT_CONS_VALUE',
           ALIAS_OBJ     VARCHAR2(4000)  PATH '*:ALIAS',
           DEFAULT_VALUE_OBJ     VARCHAR2(4000)  PATH '*:DEFAULT_VALUE'
           
                       
               ) y
--where c.object_name='LD_BOREASSIGNORDERS.REASSIGN'
),
columnas_reporte as
(
select rs.executable_id, s.statement_id,s.description stat_desc,  '|'||y.Name||'|' Name
from open.ge_report_statement rs
inner join open.ge_statement s on s.statement_id=rs.statement_id
inner join open.ge_statement_columns sc on sc.statement_id =  s.statement_id,
xmltable('/*:ArrayOfBaseStatementColumn/*:BaseStatementColumn' passing XMLTYPE.createXML(sc.select_columns)
           COLUMNS 
           Name     VARCHAR2(4000)  PATH '*:Name',
           Description     VARCHAR2(4000)  PATH '*:Description',
           DisplayType     VARCHAR2(4000)  PATH '*:DisplayType',
           InternalType     VARCHAR2(4000)  PATH '*:InternalType',
           Length     VARCHAR2(4000)  PATH '*:Length',
           Scale     VARCHAR2(4000)  PATH '*:Scale'
           
                       
               ) y
--where rs.executable_id=500000000006459
)
,total as(
select ir.object_name,
       re.executable_id,
       re.statement_id,
       count(1) cantidad
from input_reporte ir
inner join columnas_reporte re on  ir.alias_obj like '%'||re.name||'%'
group by ir.object_name,
       re.executable_id,
       re.statement_id
)
,fwcgr as (
select input_reporte.object_name,
        total.executable_id, 
        (select e.name from open.sa_executable e where e.executable_id=total.executable_id) name,
        total.statement_id, 
        total.cantidad, 
        count(1)
from input_reporte
inner join total on total.object_name=input_reporte.object_name

group by input_reporte.object_name, total.executable_id,total.statement_id, total.cantidad

having count(1)=total.cantidad
)
,base as(
select s.executable_id,
       s.name nombre_ejec,
       s.description desc_eje,
       s.version,
       s.executable_type_id,
       t.name nombre_tipo,
       t.description desc_tipo,
       case 
         when s.executable_type_id =8 then nvl((select substr(name,-2,2) from open.sa_executable b where b.executable_id = s.parent_executable_id) ,(select 'Motivo Tramite' from open.ps_motive_type mot where mot.tag_name=s.name))
         when s.executable_type_id = 17 then upper('.NET')
         when s.executable_type_id = 10 and s.name like upper('MENU_%') then 'Menu'
         when s.executable_type_id= 18 and (select count(1) from open.ge_object_process_conf conf where conf.executable_name=s.name)>=1 then 'Objeto Proceso' 
         when s.executable_type_id in (1,7,11, 15, 19, 18, 3) then null
         when s.executable_type_id=10 and (select distinct config_type_id from open.gi_composition g where tag_name=s.name) =6 then 'Pestana PI'
         when s.executable_type_id=10 and (select count(1) from open.ge_entity enti, open.gi_attrib_disp_data gat where enti.name_=s.name and upper(gat.list_of_value_from) like '%'||enti.name_||'|%')>0 then 'Entidad Lista Valores MD'
         
         end info_adicional,
       --t.path,
       s.exec_oper_type_id,
       op.name oper_nombre,
       op.description desc_op_tipo,
       s.module_id,
       (select m.description from open.ge_module m where m.module_id=s.module_id) desc_mod,
       s.subsystem_id,
       sb.name,
       sb.description desc_sub,
       c.class_id,
       c.assembly_id,
       c.type_name,
       c.namespace,
       --s.entity_id,
       --(select et.name_ from open.ge_entity et where et.entity_id=e.entity_id) desc_ent,
       --re.role_id,
       --re.entity_id role_enti_name,
       --re.exception_type,
       obj.description||'-'||obj.name_ objeto,
       direct_execution ejecucion_directa,
        (select listagg(aplica_executable||'|'||estab.description, ',') within  group (order by aplica_executable)
               from open.sa_tab ta
               inner join open.sa_executable estab on estab.name=ta.tab_name
               where process_name=s.name) ejecutar_desde, 
       (select conf.object_name from open.ge_object_process_conf conf where conf.executable_name=s.name and s.executable_type_id= 18 ) object_name,
       s.exec_owner,
       s.last_date_executed
from open.sa_executable s
left join open.gi_class c on c.class_id=s.class_id
left join open.sa_executable_type t on t.executable_type_id=s.executable_type_id
left join open.sa_subsystem sb on s.subsystem_id=sb.subsystem_id
--left join open.sa_exec_entities e on e.executable_id=s.executable_id
--left join open.sa_ent_role_exec re on re.executable_id=s.executable_id
left join open.sa_exec_oper_type op on op.exec_oper_type_id=s.exec_oper_type_id 
left join open.sa_tab_object sot on sot.executable_name=s.name and s.executable_type_id =1
left join open.ge_object obj on obj.object_id=sot.object_id and s.executable_type_id =1
where s.executable_id!=-1
 and s.name='LDC_CARGINFO'
)

select s.*,
       case 
            when upper(s.info_adicional) in (upper('Menu'), upper('Pestana PI')) then
                ( select listagg(e2.name, ',') within  group (order by e2.name)
                   from configuracion e2
                 where e2.tag_name=s.nombre_ejec) 
            when upper(s.info_adicional) =upper('Entidad Lista Valores MD') then
                (select listagg(name_ejec, ',') within  group (order by name_ejec)  
                from listavalores lov
                where lov.name_=s.nombre_ejec)
            when upper(s.info_adicional) =upper('Objeto Proceso') then
               (select listagg(fwcgr.name, ',') within  group (order by fwcgr.name)
               from fwcgr
               where fwcgr.object_name=s.object_name)
        end ejecutable_donde_se_usa
from base s


