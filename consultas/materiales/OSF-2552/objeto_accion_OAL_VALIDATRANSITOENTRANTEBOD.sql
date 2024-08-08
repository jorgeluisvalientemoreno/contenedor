Select o.idaccion,
       o.tipoaccion,
       o.nombreobjeto,
       o.tipotrabajo,
       o.idactividad,
       o.idcausal,
       o.unidadoperativa,
       o.descripcion,
       o.procesonegocio,
       p.descripcion,
       o.ordenejecucion,
       o.activo,
       o.fechacreacion
from personalizaciones.objetos_accion  o
left join personalizaciones.proceso_negocio p  on p.codigo = o.procesonegocio
where o.nombreobjeto = 'OAL_VALIDATRANSITOENTRANTEBOD'
