--documentos_spool
select *
from ed_document  d
where d.docupefa = 116020
order by d.docufere desc
