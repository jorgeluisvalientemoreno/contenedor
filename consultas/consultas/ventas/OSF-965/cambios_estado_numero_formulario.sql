select hicdtico tipo_formulario,
       hicdfech,
       hicdnume numero_form,hicdesta,
case when hicdesta = 'L' then 'Libre'
     when hicdesta = 'A'  then 'Asignado'
     when hicdesta = 'V' then 'Vendido'
     when hicdesta = 'P' then 'Pendiente'
     when hicdesta = 'N' then 'Anulado' end as estado,
       hicdunop unidad_op
from open.fa_histcodi h
where h.hicdnume = 9094603
and h.hicdtico = 1
AND h.hicdfech >= '11/04/2023';