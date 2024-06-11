-- Cambio_estado_producto
select h.hcecnuse "Producto",
       h.hcecsusc "Contrato",
       h.hcecserv "Tipo servicio",
       hcececac   "Estado actual",
       hcececan   "Estado ant",
       hcecfech   "Fecha_cambio",
       hcecusua   "Usuario",
       hcecterm   "Terminal",
       hcecprog   "Programa"
  from hicaesco h
 where h.hcecnuse = 50886540
 order by h.hcecfech desc
