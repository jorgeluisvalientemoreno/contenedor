select n.notafact  Factura, 
       n.notasusc  Contrato, 
       n.notafeco  Fecha_Facturacion, 
       n.notafecr  Fecha_Creacion, 
       n.notaobse  Observacion,
       n.notacons || '-  ' || d.description  Tipo_Documento 
from open.notas  n
inner join open.ge_document_type  d on d.document_type_id = n.notacons
where n.notasusc = 1288148
and n.notafeco >= '26/09/2022'