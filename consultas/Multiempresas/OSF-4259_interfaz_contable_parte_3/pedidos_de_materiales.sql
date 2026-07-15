--pedidos_de_materiales
select ts.trsmcodi,
       ts.trsmcont,
       ts.trsmprov,
       ts.trsmunop,
       ts.trsmfecr,
       ts.trsmesta,
       te.descripcion,
       ts.trsmofve,
       trsmprov  centro_logistico,
       trsmofve  oficina_venta,
       o.ofvedesc,
       trsmmpdi  motivo_venta,
        mv.mopedesc,
       trsmmdpe motivo_devoluciones,
       md.mdpedesc,
       ts.trsmvtot,
       ts.trsmdore,
       ts.trsmdsre,
       ts.trsmmdpe,
       ts.trsmusmo,
       ts.trsmacti,
       ts.trsmsol,
       ts.trsmtipo,
       ts.trsmprog,
       ts.order_id,
       ts.trsmobse,
       ts.trsmcome
from ldci_transoma  ts
left join ldci_tranesta  te  on te.codigo = ts.trsmesta
left join ldci_oficvent o  on o.ofvecodi = trsmofve
left join ldci_motipedi mv  on mv.mopecodi = ts.trsmmpdi
left join ldci_motidepe md  on md.mdpecodi = trsmmdpe
where 1 = 1
and   ts.trsmcodi =   255235
--and ts.trsmesta = 3
order by ts.trsmfecr desc


--and   ts.trsmesta = 5
