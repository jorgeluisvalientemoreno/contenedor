

select rs.executable_id, s.statement_id, sc.select_columns, y.*
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
where rs.executable_id=500000000000779
;