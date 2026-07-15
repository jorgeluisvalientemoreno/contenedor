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
       notas.notatino  "Tipo de nota",
       sum(decode(cargos.cargsign,'DB',cargos.cargvalo,'CR',-cargos.cargvalo,'SA',cargos.cargsign,'R',cargos.cargvalo))  "Valor total de las notas"      
from open.notas
inner join open.ge_document_type on ge_document_type.document_type_id = notas.notacons
inner join open.servsusc on servsusc.sesususc = notas.notasusc
inner join open.cargos on cargos.cargcodo = notas.notanume and cargnuse = sesunuse
inner join open.causcarg on causcarg.cacacodi = cargos.cargcaca
where servsusc.sesususc in (1000895)
and notas.notafecr  >= '02/05/2025'
group by notas.notasusc,notanume,notas.notaprog, servsusc.sesunuse, notas.notafecr, notas.notaobse,
notas.notacons || '-  ' || ge_document_type.description, cargos.cargcuco, 
cargos.cargcaca ||'- '|| initcap(cacadesc)  ,cargos.cargsign,notas.notatino,cargcodo
order by notas.notasusc;

--notas_por_producto
/*select *
from open.notas  n
where n.notasusc in (48080062)
and n.notafecr  >= '30/04/2025'
order by  n.notafecr  desc*/


--and cargos.cargsign = 'CR'
-- and   cargos.cargcuco in (3048808068)


--and notas.notafecr <= '28/04/2025'
