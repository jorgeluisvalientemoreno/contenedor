select notas.notasusc  "Contrato", 
       servsusc.sesunuse  "Producto",      
       notas.notafecr  "Fecha de creacion", 
       notas.notaobse  "Observacion", 
       notas.notacons || '-  ' || ge_document_type.description  "Tipo de documento",
       cargos.cargcuco  "Cuenta de cobro", 
       cargos.cargcaca ||'- '|| initcap(causcarg.cacadesc)  "Causa del cargo",
       sum(decode(cargos.cargsign,'DB',cargos.cargvalo,'CR',-cargos.cargvalo))  "Valor total de las notas"      
from open.notas
inner join open.ge_document_type on ge_document_type.document_type_id = notas.notacons
inner join open.servsusc on servsusc.sesususc = notas.notasusc
inner join open.cargos on cargos.cargcodo = notas.notanume
inner join open.causcarg on causcarg.cacacodi = cargos.cargcaca
where servsusc.sesunuse = 6550677
and notas.notafecr >= '15/11/2022'
group by notas.notasusc, servsusc.sesunuse, notas.notafecr, notas.notaobse,
notas.notacons || '-  ' || ge_document_type.description, cargos.cargcuco, 
cargos.cargcaca ||'- '|| initcap(cacadesc)  