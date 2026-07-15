SELECT l.tipo_producto, l.nuano, l.numes , l.producto, l.contrato, l.categoria, l.estado_financiero
FROM LDC_OSF_SESUCIER l
WHERE l.nuano = 2022
and l.sesusape > 0
AND EXISTS (select null from open.ciclo
left join open.pericose pc on pc.pecscico=ciclcodi and sysdate between pc.pecsfeci and pc.pecsfecf
left join open.perifact pf on pf.pefacicl=ciclcodi and sysdate between pf.pefafimo and pf.pefaffmo
where ciclcico = l.ciclo
and pefaactu = 'S')
and l.tipo_producto in (7055,7014)
and numes = 4
AND NOT EXISTS (SELECT NULL FROM or_order o
INNER JOIN or_order_activity t on o.order_id = t.order_id
WHERE t.product_id = L.PRODUCTO
AND o.task_type_id = 50005 AND 
 o.order_status_id IN (0,5))
AND l.categoria in (2)
AND l.producto in (17096195,50741430)
-- AND l.estado_financiero = 'C'
 
select *
FROM LDC_OSF_SESUCIER l
WHERE l.nuano = 2022
/*and l.sesusape > 0*/
and l.producto = 51564222
