with input_reporte as(
select c.object_name, y.NAME_OBJ, '|'||y.ALIAS_OBJ||'|' ALIAS_OBJ 
from ge_object_process_conf c, 
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
from ge_report_statement rs
inner join open.ge_statement s on s.statement_id=rs.statement_id
inner join ge_statement_columns sc on sc.statement_id =  s.statement_id,
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








