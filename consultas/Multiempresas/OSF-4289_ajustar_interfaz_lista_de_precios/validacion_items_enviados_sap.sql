--validacion_items_enviados_sap
select mm.material,
       i.description,
       i.item_classif_id,
       mm.empresa,
       mm.habilitado
from multiempresa.materiales  mm
 inner join ge_items i  on i.items_id = mm.material
 where mm.habilitado = 'S'
  and  mm.empresa = 'GDGU'
  and not exists (select 1
   from ldci_intdetlistprec dlp
    where dlp.codigo_item = mm.material and dlp.codigo_interfaz = 72)
order by mm.material
