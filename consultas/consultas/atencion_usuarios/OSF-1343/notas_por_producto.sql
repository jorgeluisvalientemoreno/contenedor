--notas_por_producto
select notas.notasusc  "Contrato",cargcodo "Cons documento",  
       notanume "Numero_nota" ,
       notas.notaprog "Programa_nota" ,
       servsusc.sesunuse  "Producto",      
       notas.notafecr  "Fecha de creacion", 
       initcap(notas.notaobse)  "Observacion", 
       notas.notacons || '-  ' || ge_document_type.description  "Tipo de documento",
       cargos.cargcuco  "Cuenta de cobro", 
       cargos.cargcaca ||'- '|| initcap(causcarg.cacadesc)  "Causa del cargo",
       cargos.cargsign "Signo",
       sum(decode(cargos.cargsign,'DB',cargos.cargvalo,'CR',-cargos.cargvalo,'SA',cargos.cargvalo))  "Valor total de las notas"      
from open.notas
inner join open.ge_document_type on ge_document_type.document_type_id = notas.notacons
inner join open.servsusc on servsusc.sesususc = notas.notasusc
inner join open.cargos on cargos.cargcodo = notas.notanume and cargnuse = sesunuse
inner join open.causcarg on causcarg.cacacodi = cargos.cargcaca
where servsusc.sesususc in (48035401)
and notas.notafecr  >= '20/12/2023'
and notas.notafecr <= '21/12/2023'
group by notas.notasusc,notanume,notas.notaprog, servsusc.sesunuse, notas.notafecr, notas.notaobse,
notas.notacons || '-  ' || ge_document_type.description, cargos.cargcuco, 
cargos.cargcaca ||'- '|| initcap(cacadesc)  ,cargos.cargsign,cargcodo
order by notas.notasusc;


--and cargos.cargsign = 'CR'
-- and   cargos.cargcuco in (3048808068)
