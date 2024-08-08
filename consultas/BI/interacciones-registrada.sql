with base as(
select f.IdSolicitud as Interaccion,
	   f.FechaSolicitud as FechaInteraccion,
	   f.IdTipoSolicitud as TipoInteraccion,
	   f.IdEstado as EstadoInteraccion,
	   f.IdMedioRecepcion MediRecepInter,
	   f2.IdSolicitud Solicitud,
	   f2.IdTipoSolicitud TipoSol,
	   f2.IdEstado EstadoSol,
	   f.IdPeticionAtencionCliente
from Comun.FactSolicitud f
left join Comun.FactSolicitud f2 on f2.IdPeticionAtencionCliente= f.IdPeticionAtencionCliente and f2.IdSolicitud!=f.IdSolicitud
where f.IdTipoSolicitud=268
 and f.idEstado=13
 --and f.IdSolicitud=11538366
 and f.FechaSolicitud > '01/01/2015'
 and f.FechaSolicitud < '01/01/2016'
 and f.IdMedioRecepcion in (10, 20 , 44)
 and not exists(select null from Comun.FactOrden o where o.IdSolicitud=f.IdSolicitud and o.IdEstadoOrden in (8,12))
 and not exists(select null from Comun.FactSolicitud f3 where f3.IdPeticionAtencionCliente = f.IdSolicitud and f3.IdEstado=13 and f.IdSolicitud!=f3.IdSolicitud)
 )

 select  base.Interaccion, base.FechaInteraccion, base.MediRecepInter,r.MedioRecepcion,base.EstadoSol, count(1)
 from base
 inner join AtencionUsuarios.DimMedioRecepcion r on r.IdMedioRecepcion=base.MediRecepInter
 group by base.Interaccion, base.FechaInteraccion, base.MediRecepInter,r.MedioRecepcion,base.EstadoSol