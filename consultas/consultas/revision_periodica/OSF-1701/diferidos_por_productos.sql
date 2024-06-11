--diferidos_por_productos
select difesusc "Contrato",
      difenuse "Producto" ,
      sesuserv || ' ' || initcap (servdesc) tipo_producto ,
      difecodi "Codigo diferido",
      difeconc ||' ' ||  initcap(concdesc) "concepto",
      difesape "Saldo pendiente" ,
      difenucu - difecupa "cuot_pendientes",
       difecupa "Cuotas pagadas" , difefein "Fecha ingreso diferido" ,  difepldi "plan" , difeprog "Programa"
from diferido
left join  open.servsusc on difesusc = sesususc and difenuse= sesunuse
left join servicio on servcodi = sesuserv
left join LDC_CONCGRVF on cogrcodi = difeconc 
left join concepto on conccodi = difeconc 
where difenuse = 50303431
and  difesape > 0
