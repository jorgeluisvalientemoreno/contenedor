--pedidos_de_materiales
select ts.trsmcodi,
       ts.trsmcont,
       ts.trsmprov,
       ts.trsmunop,
       ts.trsmfecr,
       ts.trsmesta,
       te.descripcion,
       ts.trsmofve,
       ts.trsmvtot,
       ts.trsmdore,
       ts.trsmdsre,
       ts.trsmmdpe,
       ts.trsmusmo,
       ts.trsmmpdi,
       ts.trsmacti,
       ts.trsmsol,
       ts.trsmtipo,
       ts.trsmprog,
       ts.order_id,
       ts.trsmobse,
       ts.trsmcome
from ldci_transoma  ts
inner join ldci_tranesta  te  on te.codigo = ts.trsmesta
where ts.trsmcodi = 255179
