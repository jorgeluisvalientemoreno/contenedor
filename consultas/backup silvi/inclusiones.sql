select inccsusc "Contrato",
       inccsesu "Producto",
       inccserv "Tipo_prod",
       inccfere "Fecha_registro",
       inccfeca "Fecha cancelacion",
       inccobse "Observacion"
from open.inclcoco
where inccsusc=17180109
and inccfeca is null

select *
from ldc_prodrerp 
where /*prreproc = 'N'
 and */prreprod = 17151918 
;
 
 
