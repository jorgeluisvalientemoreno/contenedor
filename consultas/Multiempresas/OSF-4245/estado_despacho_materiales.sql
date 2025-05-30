--estado_despacho_materiales
select *
from ldci_intemmit  dm
where dm.mmitfesa >= '23/05/2025'
for update


--dm.mmitnupe like '%255179%'
--for update
