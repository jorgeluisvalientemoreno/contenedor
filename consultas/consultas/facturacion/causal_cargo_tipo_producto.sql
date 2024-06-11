901356	No Existen Causales Configuradas para el Tipo de Producto [ %s1 ].


select *
from open.FA_CACACLTP t
where t.cctpclcc=7;
--where cctpserv=7057;
select *
from open.FA_CLASCACA c
where c.clccdesc like '%FGCO%'