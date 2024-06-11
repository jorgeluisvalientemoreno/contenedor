select inccsusc "Contrato",
       inccsesu "Producto",
       inccserv "Tipo_prod",
       inccfere "Fecha_registro",
       inccfeca "Fecha cancelacion",
       inccobse "Observacion"
from open.inclcoco
where inccsusc=14208893
and inccfeca is null
