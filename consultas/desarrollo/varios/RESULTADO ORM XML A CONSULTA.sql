with base as(
select v.id_cons_ejec,id_consulta, xmltype.createxml(esquema) esquema,-- xmltype.createxml(RESULTADO) resultado, 
replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(REPLACE(ESQUEMA,'xs:',''),'xmlns="" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:msdata="urn:schemas-microsoft-com:xml-msdata" xmlns:msprop="urn:schemas-microsoft-com:xml-msprop"', ''),'="NewDataSet" msdata:IsDataSet="true" msdata:UseCurrentLocale="true"',''),'id="NewDataSet"',''),'element name','element_name'),'minOccurs="0" maxOccurs="unbounded"',''),'="Table"',''),'/element','/element_name'),'element_name=','valor>'),
'OraDbType="126"',''),
'OraDbType="106"',''),
'OraDbType="107"',''),
'OraDbType="104"',''),
'OraDbType="112"',''),
'OraDbType="113"',''),
'OraDbType="111"',''),
'minOccurs="0"',''),'/>','</valor>'),'<valor>','<valor><campo>'),'msprop:','</campo><tipo>')
,'type="string"','varchar2(4000)</tipo>')
,'type="int"','number</tipo>')
,'type="long"','number</tipo>')
,'type="decimal"','number</tipo>')
,'type="short"','number</tipo>')
,'type="dateTime"','date</tipo>')
,'"',''),
'<?xml version=1.0?>',''),' ','') xml_estructura
from orm.OPT_CONSULTA_EJECS v
where id_consulta=1660
 and id_cons_ejec=19712
--id_consulta=60
 --and id_cons_ejec=19488
 and v.error_msg is null
),
base2 as(
select *
from base, xmltable('schema/element_name/complexType/choice/element_name/complexType/sequence/valor' passing  xmltype.createxml(xml_estructura)
                     COLUMNS campo varchar2(1000) path '//campo',
                     tipo varchar2(1000) path '//tipo')
),
base3 as(
select 0 ids , 'select * from xmltable(''NewDataSet/Table'' passing ((select xmltype.createxml(RESULTADO) from orm.OPT_CONSULTA_EJECS v where v.id_consulta='||base.id_consulta||'  and v.id_cons_ejec='||base.id_cons_ejec||')) columns' dat
from base
union 
select rownum ids, campo||' '||tipo||'  path ''//'||campo||''''||',' dat 
from base2
)
, maximo as (select max(b.ids) maxi from base3 b)
,base4 as(
select base3.ids, base3.dat
from base3
union 
select 9000, ');'
from dual
order by 1)
select base4.*
from base4
;
 
SELECT *
FROM ORM.OPT_CONSULTA_PROGS C
WHERE C.ID_CONSULTA=60;
SELECT *
FROM ORM.OPT_LAYOUT L
WHERE L.ID_CONSULTA=60;
 
/* 
 
<?xml version="1.0"?>
<xs:schema id="NewDataSet" xmlns="" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:msdata="urn:schemas-microsoft-com:xml-msdata" xmlns:msprop="urn:schemas-microsoft-com:xml-msprop">
  <xs:element name="NewDataSet" msdata:IsDataSet="true" msdata:UseCurrentLocale="true">
    <xs:complexType>
      <xs:choice minOccurs="0" maxOccurs="unbounded">
        <xs:element name="Table">
          <xs:complexType>
            <xs:sequence>
              <xs:element name="CONTRATISTA" msprop:OraDbType="126" type="xs:string" minOccurs="0"/>
              <xs:element name="MES" msprop:OraDbType="106" type="xs:dateTime" minOccurs="0"/>
              <xs:element name="TIPO" msprop:OraDbType="126" type="xs:string" minOccurs="0"/>
              <xs:element name="ASIGNACION" msprop:OraDbType="107" type="xs:decimal" minOccurs="0"/>
              <xs:element name="EJECUCION" msprop:OraDbType="107" type="xs:decimal" minOccurs="0"/>
              <xs:element name="LEGALIZACION" msprop:OraDbType="107" type="xs:decimal" minOccurs="0"/>
              <xs:element name="ORDENES" msprop:OraDbType="107" type="xs:decimal" minOccurs="0"/>
            </xs:sequence>
          </xs:complexType>
        </xs:element>
      </xs:choice>
    </xs:complexType>
  </xs:element>
</xs:schema>
*/

Select *
from xmltable('NewDataSet/Table'
                       passing ((select xmltype.createxml(RESULTADO) from orm.OPT_CONSULTA_EJECS v where id_consulta=60  and id_cons_ejec=19488) )
                       COLUMNS diana varchar2(1000) path '//CONTRATISTA',
                       MES varchar2(1000) path '//MES',
                       TIPO varchar2(1000) path '//TIPO',
                       ASIGNACION varchar2(1000) path '//ASIGNACION',
                       EJECUCION varchar2(1000) path '//EJECUCION',
                       LEGALIZACION varchar2(1000) path '//LEGALIZACION',
                       ORDENES NUMBER path '//ORDENES') nice_xml_table;
                       
 select xmltype.createxml(RESULTADO) from orm.OPT_CONSULTA_EJECS v where id_consulta=60  and id_cons_ejec=19488;                      
Select *
from xmltable('schema'
                       passing ((select xmltype.createxml(REPLACE(ESQUEMA,'xs','')) from orm.OPT_CONSULTA_EJECS v where id_consulta=60  and id_cons_ejec=19488) )
                       COLUMNS diana varchar2(1000) path '//element//complexType//choice//element//complexType//sequence//element',
                       MES varchar2(1000) path '//MES',
                       TIPO varchar2(1000) path '//TIPO',
                       ASIGNACION varchar2(1000) path '//ASIGNACION',
                       EJECUCION varchar2(1000) path '//EJECUCION',
                       LEGALIZACION varchar2(1000) path '//LEGALIZACION',
                       ORDENES NUMBER path '//ORDENES') nice_xml_table;                       
