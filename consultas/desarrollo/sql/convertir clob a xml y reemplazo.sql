with base as(
SELECT l.codigo,l.fecha_registro,l.estado,  tabla_ante.*
 FROM  open.ldci_inbox  l, xmltable('estadosDocOrdenes' passing XMLTYPE.createXML(l.xml) 
                                    columns idOrden varchar2(4000) path '//estadoDocOrden//idOrden') tabla_ante                    
   where sistema='ONBASE'
  and operacion='DOCUMENTOSORDEN'
 -- and fecha_registro>='08/01/2019'
  and tabla_ante.idOrden like '%-%' --!=REGEXP_REPLACE(tabla_ante.idOrden,' [A-Za-z]*')
)
select *
from base
where base.idorden!=REGEXP_REPLACE(base.idOrden,' [A-Za-z]*')  
     ;
