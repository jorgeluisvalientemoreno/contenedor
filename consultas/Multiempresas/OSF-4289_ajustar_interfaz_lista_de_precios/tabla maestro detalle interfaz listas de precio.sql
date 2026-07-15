--tabla maestro detalle interfaz listas de precio
select dlp.codigo_interfaz,
       lp.descripcion,
       lp.fecha_ini_vigen,
       lp.fecha_final_vige,
       lp.fecha_registro,
       lp.fecha_procesado,
       lp.usuario,
       lp.estado,
       lp.mensaje,
       lp.empresa,
       dlp.codigo_item,
       dlp.costo_items,
       ROUND(dlp.costo_items * 1.19, 2) AS costo_con_iva
from ldci_intdetlistprec dlp
inner join ldci_intelistpr lp  on lp.codigo = dlp.codigo_interfaz
where dlp.codigo_interfaz in (65)
order by dlp.codigo_interfaz, dlp.codigo_item;


-- and   dlp.codigo_item = 10000126
