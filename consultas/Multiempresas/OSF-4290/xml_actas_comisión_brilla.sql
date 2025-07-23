--xml_actas_comisión_brilla
select f.faceaeid,
       f.faceaeidacta,
       c.id_contratista,
       co.nombre_contratista,
       a.id_contrato,
       c.descripcion,
       a.estado,
       a.id_tipo_acta,
       c.id_tipo_contrato,
       tc.descripcion,
       f.faceaexml,
       f.faceaexmlnc,
       f.faceaefechen,
       f.faceaefeennc
from ldci_facteactasenv f
inner join ge_acta  a  on a.id_acta = f.faceaeidacta
inner join ge_contrato  c  on c.id_contrato = a.id_contrato
inner join ge_contratista  co  on co.id_contratista = c.id_contratista
inner join ge_tipo_contrato  tc  on tc.id_tipo_contrato = c.id_tipo_contrato
where 1 = 1
 and f.faceaefeennc is not null
 and f.faceaeidacta = 242256
 and f.faceaefeennc >= '01/03/2025'
 and exists (select 1
      from multiempresa.contratista  mc
      where mc.contratista = c.id_contratista)
order by f.faceaefeennc desc


/*
delete from ldci_facteactasenv f where f.faceaeidacta = 242256
*/



/*select *
from ldci_facteactasenv f
where 1 = 1
 and f.faceaefeennc is not null
order by f.faceaefeennc desc*/
